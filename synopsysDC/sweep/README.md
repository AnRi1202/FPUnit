# Sweep Scripts

スイープ関連の Python / TCL / ランチャーは `sweep/` 以下に集約しています。

## ディレクトリ構成

```
sweep/
  sweep_paths.py          # 共通パスヘルパー
  no_retime/              # 単体調査（retiming なし）
    run_ret_no_retime_dat.py
    run_abs_comparator.tcl
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

## 実行例

`synopsysDC/` から:

```bash
# 単体調査（P1, no retime, DAT 取得）
./sweep/no_retime/launch_tmux.sh

# abs_comparator 単体面積
dc_shell -f sweep/no_retime/run_abs_comparator.tcl

# V2 retiming スイープ
./sweep/retime/launch_sweep_v2.sh
```
