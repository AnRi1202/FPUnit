# Sweep Scripts

スイープ関連の Python / TCL / ランチャーは `sweep/` 以下に集約しています。

## ディレクトリ構成

```
sweep/
  sweep_paths.py          # 共通パスヘルパー
  no_retime/              # 単体調査（retiming なし）
    run_ret_no_retime_dat.py
    run_flopoco_all.py
    launch_tmux.sh
    launch_flopoco.sh
  retime/                 # パイプライン / retiming スイープ
    ret_*.tcl
    run_sweep_*.py
    run_fpmult_with_bf16_f*.tcl
    run_intmult_f*_ret.tcl
    launch_sweep_*.sh
```

## 出力先

| 種類 | 出力ディレクトリ |
|------|------------------|
| no_retime | `synopsysDC/sweep_run/no_retime/` |
| retime | `synopsysDC/sweep_run/retime/` |

ログと CSV サマリは従来どおり `synopsysDC/logs/` と `synopsysDC/*.csv` です。

単体ユーティリ合成（abs_comparator / barrel_shifter）は `synopsysDC/` 直下の TCL を使います（出力は `synopsysDC/run-<TOP>-*/`）。

## 実行例

`synopsysDC/` から:

```bash
# 単体調査（P1, no retime, DAT 取得）
./sweep/no_retime/launch_tmux.sh

# 単体ユーティリ面積（synopsysDC/ 直下）
dc_shell -f run_abs_comparator.tcl
dc_shell -f run_barrel_shifter.tcl
TOP=barrel_shifter_gpt dc_shell -f run_barrel_shifter.tcl

# V2 retiming スイープ
./sweep/retime/launch_sweep_v2.sh
```
