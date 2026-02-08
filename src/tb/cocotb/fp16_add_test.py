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
async def test_fp16_adder_pipeline(dut):
    """Test the 4-stage FP16 adder with addition and subtraction cases"""

    # 1. Start the clock (100MHz / 10ns period)
    cocotb.start_soon(Clock(dut.i_clk, 10, unit="ns").start())

    # 2. Reset the DUT
    dut.i_rst_n.value = 0
    dut.i_operand_a.value = 0
    dut.i_operand_b.value = 0
    await Timer(20, unit="ns")
    dut.i_rst_n.value = 1
    await RisingEdge(dut.i_clk)

    # Warm-up: Feed a simple operation to flush the pipeline after reset
    dut.i_operand_a.value = float16_to_hex(1.0)
    dut.i_operand_b.value = float16_to_hex(1.0)
    for i in range(5):
        await RisingEdge(dut.i_clk)

    # Test Case 1: Addition - 1.5 + 2.5 = 4.0
    val_a = 1.5
    val_b = 2.5
    expected = val_a + val_b

    dut.i_operand_a.value = float16_to_hex(val_a)
    dut.i_operand_b.value = float16_to_hex(val_b)

    dut._log.info(f"Input hex: a=0x{float16_to_hex(val_a):04X}, b=0x{float16_to_hex(val_b):04X}")

    # Account for 4 pipeline stages
    for i in range(5):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_sum.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 1 - Addition: {val_a} + {val_b} = {result_float} (expected {expected}), error={abs(result_float-expected):.2e}, hex=0x{result_hex:04X}")
    assert abs(result_float - expected) < 1e-53, f"Failed: Expected {expected}, got {result_float}"

    # Test Case 2: Subtraction - 5.0 + (-2.0) = 3.0
    val_a = 5.0
    val_b = -2.0
    expected = val_a + val_b

    dut.i_operand_a.value = float16_to_hex(val_a)
    dut.i_operand_b.value = float16_to_hex(val_b)

    for i in range(5):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_sum.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 2 - Subtraction: {val_a} + ({val_b}) = {result_float} (expected {expected}), error={abs(result_float-expected):.2e}")
    assert abs(result_float - expected) < 1e-53, f"Failed: Expected {expected}, got {result_float}"

    # Test Case 3: Subtraction - (-3.5) + 1.5 = -2.0
    val_a = -3.5
    val_b = 1.5
    expected = val_a + val_b

    dut.i_operand_a.value = float16_to_hex(val_a)
    dut.i_operand_b.value = float16_to_hex(val_b)

    for i in range(5):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_sum.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 3 - Subtraction: {val_a} + {val_b} = {result_float} (expected {expected}), error={abs(result_float-expected):.2e}")
    assert abs(result_float - expected) < 1e-53, f"Failed: Expected {expected}, got {result_float}"

    # Test Case 4: Addition of negatives - (-2.0) + (-3.0) = -5.0
    val_a = -2.0
    val_b = -3.0
    expected = val_a + val_b

    dut.i_operand_a.value = float16_to_hex(val_a)
    dut.i_operand_b.value = float16_to_hex(val_b)

    for i in range(5):
        await RisingEdge(dut.i_clk)

    result_hex = dut.o_sum.value.to_unsigned()
    result_float = hex_to_float16(result_hex)

    dut._log.info(f"Test 4 - Addition of negatives: {val_a} + {val_b} = {result_float} (expected {expected}), error={abs(result_float-expected):.2e}")
    assert abs(result_float - expected) < 1e-53, f"Failed: Expected {expected}, got {result_float}"

@cocotb.test()
async def test_fp16_random_floats(dut):
    """Feed random FP16 floats and check results after pipeline latency"""
    import random

    cocotb.start_soon(Clock(dut.i_clk, 10, unit="ns").start())

    # Reset the DUT
    dut.i_rst_n.value = 0
    dut.i_operand_a.value = 0
    dut.i_operand_b.value = 0
    await RisingEdge(dut.i_clk)
    await RisingEdge(dut.i_clk)
    dut.i_rst_n.value = 1
    await RisingEdge(dut.i_clk)

    # Test 240 random cases
    # FP16 range is approximately ±65504 (max) and ±6.1e-5 (min normalized)
    for i in range(240):
        # Use smaller range appropriate for FP16
        a = random.uniform(-1000.0, 1000.0)
        b = random.uniform(-1000.0, 1000.0)

        # Convert to FP16 precision for reference calculation
        a_fp16 = np.float16(a)
        b_fp16 = np.float16(b)
        expected = float(np.float16(a_fp16 + b_fp16))

        dut.i_operand_a.value = float16_to_hex(a_fp16)
        dut.i_operand_b.value = float16_to_hex(b_fp16)

        # Wait for pipeline (4 stages)
        for _ in range(5):
            await RisingEdge(dut.i_clk)

        result_hex = dut.o_sum.value.to_unsigned()
        got = hex_to_float16(result_hex)
        error = abs(got - expected)

        # Detect catastrophic cancellation: large inputs, small output
        input_magnitude = max(abs(float(a_fp16)), abs(float(b_fp16)))
        output_magnitude = abs(expected)
        is_cancellation = (input_magnitude > 10.0) and (output_magnitude < input_magnitude * 0.1)

        # Use adaptive thresholds - FP16 has less precision
        if is_cancellation:
            # For catastrophic cancellation, use absolute error relative to input magnitude
            rel_error = error / input_magnitude if input_magnitude > 0 else error
            threshold = 1e-2  # Relaxed threshold for FP16 cancellation cases
        else:
            # Normal case: relative error
            rel_error = error / max(abs(expected), 1.0) if expected != 0 else error
            threshold = 1e-2  # FP16 has ~3 decimal digits of precision

        # Log the first few for debugging
        if i < 4:
            dut._log.info(f"Test {i}: {float(a_fp16):.4f} + {float(b_fp16):.4f} = {got:.4f} (exp {expected:.4f}), hex=0x{result_hex:04X}, rel_err={rel_error:.2e}")

        if rel_error >= 1e-53:  # Log errors > 1e-3
            cancel_flag = " [CANCELLATION]" if is_cancellation else ""
            dut._log.warning(f"Large error at test {i}: {float(a_fp16):.4f} + {float(b_fp16):.4f} = {got:.4f} (expected {expected:.4f}), rel_error={rel_error:.2e}{cancel_flag}")

        assert rel_error < threshold, f"Test {i} failed: {float(a_fp16)} + {float(b_fp16)} = {got}, expected {expected}, rel_error={rel_error}, threshold={threshold}"
