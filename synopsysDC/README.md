# FPU Synthesis and PPA Evaluation Environment

このディレクトリには、FloPoCoベースのBaselineデザインと、改良版（V1, V2, V3）デザインの PPA (Power, Performance, Area) を評価するためのスクリプト群が含まれています。

## 統一合成制約 (Standardized Constraints)

公平な比較のため、すべての合成スクリプトで以下の制約を統一しています。

- **Clock Period**: 0.5 ns (目標 2.0 GHz)
- **I/O Delay**: 0.1 ns (周期の 20%)
- **Input Transition**: 0.05 ns
- **Output Load**: 0.1
- **Process**: Nangate 45nm Open Cell Library

---

## 実行スクリプト対応表 (Script Mapping)

すべてのスイープスクリプトは `run_sweep_[Architecture]_[Operation].py` の形式で命名され、実行ログは `logs/` ディレクトリに集約されます。

| 対象アーキテクチャ | 実行スクリプト (Python) | 合成スクリプト (TCL) | 結果サマリ (CSV) | 実行ログ (Directory) |
| :--- | :--- | :--- | :--- | :--- |
| **FloPoCo Baseline** | `run_sweep_flopoco_all.py` | (Internal Template) | `sweep_summary_flopoco_all.csv` | `logs/sweep_f*_*.log` |
| **V1 (Area Opt)** | `run_sweep_v1_all.py` | `ret_v1.tcl` | `sweep_summary_v1_all.csv` | `logs/sweep_v1_*.log` |
| **V2 (BF16 Full)** | `run_sweep_v2_all.py` | `ret_v2.tcl` | `sweep_summary_v2_all.csv` | `logs/sweep_v2_*.log` |
| **V2.3 (Add/Mul)** | `run_sweep_v2_3_addmul.py` | `ret_v2_3_addmul.tcl` | `sweep_summary_v2_3_addmul.csv` | `logs/sweep_v2_3_*.log` |
| **V2.4 (Div/Sqrt)** | `run_sweep_v2_4_divsqrt.py` | `ret_v2_4_divsqrt.tcl` | `sweep_summary_v2_4_divsqrt.csv` | `logs/sweep_v2_4_*.log` |
| **V3 (Modular AM)** | `run_sweep_v3_addmul.py` | `ret_v3_addmul.tcl` | `sweep_summary_v3_addmul.csv` | `logs/sweep_v3_addmul_*.log` |
| **V3.1 (Modular DS)** | `run_sweep_v3_1_divsqrt.py` | `ret_v3_1_divsqrt.tcl` | `sweep_summary_v3_1_divsqrt.csv` | `logs/sweep_v3_1_divsqrt_*.log` |

---

## 実行コマンド一覧

### 1. 全スイープの並行実行 (tmux)
複数のアーキテクチャのスイープを `tmux` 上で同時に開始します。

```bash
# V3 / V3.1 の並行実行
./run_sweep_v3_v3_1_parallel.sh

# V2.3 / V2.4 の並行実行
./run_sweep_v2_3_v2_4_parallel.sh

# 以前の統合ランチャー (Legacy)
./launch_sweeps_tmux.sh
```

### 2. モニタリング
ログファイルの進捗をリアルタイムで監視します。

```bash
# logs/ ディレクトリ内の最新ログを確認
watch -n 1 'ls -ltr logs/*.log | tail -n 10'
```

---

## 補助ツール

### 1. 組み合わせ（0段）ベースライン計測
パイプラインを入れない状態での純粋な論理遅延と面積を計測します。

```bash
dc_shell-xg-t -f measure_comb_dat.tcl
# 出力: comb_baseline_dat_area.csv
```

### 2. 全結果サマリ作成
ディレクトリ内のすべての `.csv` または `.log` から最終的な比較表を作成します。

```bash
python3 summarize_results.py
# 出力: final_summary.csv
```

---

## 主要なディレクトリ構成

- `logs/`: すべてのスイープ実行ログ (.log)
- `src/rtl/`: 対象となる各アーキテクチャのソースコード
- `run-*/`: 各合成実行の詳細な中間データ (`area.rpt`, `timing.rpt` 等)
