"""Shared paths for sweep scripts under synopsysDC/sweep/."""
import os
import re

SWEEP_PKG_DIR = os.path.dirname(os.path.abspath(__file__))
SWEEP_NO_RETIME_DIR = os.path.join(SWEEP_PKG_DIR, "no_retime")
SWEEP_RETIME_DIR = os.path.join(SWEEP_PKG_DIR, "retime")

CATEGORY_NO_RETIME = "no_retime"
CATEGORY_RETIME = "retime"


def synopsys_dc_root():
    """Absolute path to synopsysDC/ (working directory for dc_shell)."""
    return os.path.dirname(SWEEP_PKG_DIR)


# Backward-compatible alias used by existing scripts
syn_dir_from_here = synopsys_dc_root


def sweep_run_root(syn_dir=None, category=CATEGORY_RETIME):
    if syn_dir is None:
        syn_dir = synopsys_dc_root()
    root = os.path.join(syn_dir, "sweep_run", category)
    os.makedirs(root, exist_ok=True)
    return root


def sweep_run_rel(category=CATEGORY_RETIME):
    return f"sweep_run/{category}"


def join_run_dir(syn_dir, run_name, category=CATEGORY_RETIME):
    return os.path.join(sweep_run_root(syn_dir, category), run_name)


def find_latest_run(syn_dir, run_prefix, category=CATEGORY_RETIME):
    root = sweep_run_root(syn_dir, category)
    matches = sorted(d for d in os.listdir(root) if d.startswith(run_prefix))
    if not matches:
        return None
    return os.path.join(root, matches[-1])


def find_latest_run_pattern(syn_dir, pattern, category=CATEGORY_RETIME):
    root = sweep_run_root(syn_dir, category)
    matches = sorted(d for d in os.listdir(root) if re.match(pattern, d))
    if not matches:
        return None
    return os.path.join(root, matches[-1])


def script_dir():
    """Directory containing the calling sweep script (no_retime/ or retime/)."""
    import inspect

    frame = inspect.currentframe()
    if frame and frame.f_back:
        return os.path.dirname(os.path.abspath(frame.f_back.f_code.co_filename))
    return SWEEP_PKG_DIR


def tcl_path(filename, category=CATEGORY_RETIME):
    """Path to a TCL file relative to synopsysDC root."""
    base = SWEEP_NO_RETIME_DIR if category == CATEGORY_NO_RETIME else SWEEP_RETIME_DIR
    return os.path.relpath(os.path.join(base, filename), synopsys_dc_root())
