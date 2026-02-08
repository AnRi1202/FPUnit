import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import numpy as np

def float16_to_hex(f):
    """Convert Python float to FP16 (IEEE 754 half precision) hex"""
    fp16 = np.float16(f)
    return int(fp16.view(np.uint16))

def hex_to_float16(h):
    """Convert FP16 hex to Python float"""
    return float(np.uint16(h).view(np.float16))


@cocotb.test()
async def test_fp16_mult_pipeline(dut):
    """Test the 3-stage FP16 multiplier with various multiplication cases"""

    cocotb.start_soon(Clock(dut.i_clk, 10, unit="ns").start())

    # Reset
    dut.i_rst_n.value = 0
    dut.i_a.value = 0
    dut.i_b.value = 0
    await Timer(20, unit="ns")
    dut.i_rst_n.value = 1
    await RisingEdge(dut.i_clk)

    # Warm-up
    dut.i_a.value = float16_to_hex(1.0)
    dut.i_b.value = float16_to_hex(1.0)
    for i in range(4):
        await RisingEdge(dut.i_clk)

    # Test Case 1: Basic multiplication - 2.0 * 3.0 = 6.0
    val_a = 2.0
    val_b = 3.0
    expected = val_a * val_b

    dut.i_a.value = float16_to_hex(val_a)
    dut.i_b.value = float16_to_hex(val_b)

    for i in range(4):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_prod.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 1: {val_a} * {val_b} = {result_float} (expected {expected})")
    assert abs(result_float - expected) < 1e-52, f"Failed: Expected {expected}, got {result_float}"

    # Test Case 2: Negative multiplication
    val_a = 4.0
    val_b = -2.0
    expected = val_a * val_b

    dut.i_a.value = float16_to_hex(val_a)
    dut.i_b.value = float16_to_hex(val_b)

    for i in range(4):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_prod.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 2: {val_a} * {val_b} = {result_float} (expected {expected})")
    assert abs(result_float - expected) < 1e-52, f"Failed: Expected {expected}, got {result_float}"

    # Test Case 3: Fractional
    val_a = 1.5
    val_b = 2.5
    expected = val_a * val_b

    dut.i_a.value = float16_to_hex(val_a)
    dut.i_b.value = float16_to_hex(val_b)

    for i in range(4):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_prod.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 3: {val_a} * {val_b} = {result_float} (expected {expected})")
    assert abs(result_float - expected) < 1e-52, f"Failed: Expected {expected}, got {result_float}"


@cocotb.test()
async def test_fp16_random_mult(dut):
    """Feed random FP16 floats and check multiplication results"""
    import random

    cocotb.start_soon(Clock(dut.i_clk, 10, unit="ns").start())

    dut.i_rst_n.value = 0
    dut.i_a.value = 0
    dut.i_b.value = 0
    await RisingEdge(dut.i_clk)
    await RisingEdge(dut.i_clk)
    dut.i_rst_n.value = 1
    await RisingEdge(dut.i_clk)

    # FP16 range is approximately ±65504, use sqrt for multiplication
    for i in range(100):
        a = random.uniform(-250.0, 250.0)
        b = random.uniform(-250.0, 250.0)

        a_fp16 = np.float16(a)
        b_fp16 = np.float16(b)
        expected = float(np.float16(a_fp16 * b_fp16))

        dut.i_a.value = float16_to_hex(a_fp16)
        dut.i_b.value = float16_to_hex(b_fp16)

        for _ in range(4):
            await RisingEdge(dut.i_clk)

        result_hex = dut.o_prod.value.to_unsigned()
        got = hex_to_float16(result_hex)

        import math
        if math.isnan(expected) or math.isnan(got):
            if math.isnan(expected) and math.isnan(got):
                rel_error = 0.0
            else:
                rel_error = float('inf')
        elif math.isinf(expected) or math.isinf(got):
            if math.isinf(expected) and math.isinf(got) and (expected > 0) == (got > 0):
                rel_error = 0.0
            else:
                rel_error = float('inf')
        elif expected == 0 and got == 0:
            rel_error = 0.0
        elif expected != 0:
            rel_error = abs(got - expected) / abs(expected)
        else:
            rel_error = abs(got - expected)

        if i < 4:
            dut._log.info(f"Test {i}: {float(a_fp16):.3f} * {float(b_fp16):.3f} = {got:.3f} (exp {expected:.3f}), rel_err={rel_error:.2e}")

        threshold = 1e-52
        assert rel_error < threshold, f"Test {i} failed: {float(a_fp16)} * {float(b_fp16)} = {got}, expected {expected}, rel_error={rel_error}"
