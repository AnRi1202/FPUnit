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

## 実行スクリプト一覧

### 1. アーキテクチャ別にバックグラウンド実行 (tmux)

`launch_sweep_[arch].sh` を使用して、各アーキテクチャのスイープを `tmux` セッション（バックグラウンド）で開始します。

| 対象アーキテクチャ | 実行コマンド | Tmux Session Name | 生成されるサマリ CSV |
| :--- | :--- | :--- | :--- |
| **FloPoCo Baseline** | `./launch_sweep_flopoco.sh` | `sweep_flopoco` | `sweep_summary_flopoco_all.csv` |
| **V1 (Area Opt All)** | `./launch_sweep_v1.sh` | `sweep_v1` | `sweep_summary_v1_all.csv` |
| **V2 (BF16 Full All)** | `./launch_sweep_v2.sh` | `sweep_v2` | `sweep_summary_v2_all.csv` |
| **V2 Subunits (Add/Mul, Div/Sqrt)** | `./launch_sweep_v2_subunits.sh` | `v2_subunits_sweep` | `sweep_summary_v2_3/4_*.csv` |
| **V3 Subunits (Add/Mul, Div/Sqrt)** | `./launch_sweep_v3_subunits.sh` | `v3_subunits_sweep` | `sweep_summary_v3_*.csv` |

- **監視方法**: `tmux attach -t [Session Name]` で各セッションに接続できます。
- **デバッグ**: 各セッション内で動作ログが表示されるほか、`logs/` ディレクトリに詳細ログが保存されます。

### 2. 進捗モニタリング

すべてのスイープの進捗（ログの更新状況）を一括で監視します。

```bash
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

## ディレクトリ構成

- `logs/`: すべての合成ログ (.log)
- `src/rtl/`: アーキテクチャ別のソースコード
- `run-*/`: 合成実行ごとの中間結果 (area.rpt, timing.rpt等)
- `launch_sweep_*.sh`: tmux 起動用シェルスクリプト
- `run_sweep_*.py`: 合成自動化用 Python スクリプト
- `ret_*.tcl`: Synopsys DC 合成スクリプト
