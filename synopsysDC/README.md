# FPU Synthesis and PPA Evaluation Environment

このディレクトリには、FloPoCoベースのBaselineデザインと、改良版（V1, V2, V1_3）デザインの PPA (Power, Performance, Area) を評価するためのスクリプト群が含まれています。

## 統一合成制約 (Standardized Constraints)

公平な比較のため、すべての合成スクリプトで以下の制約を統一しています。

- **Clock Period**: 0.5 ns (目標 2.0 GHz)
- **I/O Delay**: 0.1 ns (周期の 20%)
- **Input Transition**: 0.05 ns
- **Output Load**: 0.1
- **Process**: Nangate 45nm Open Cell Library

---

## 実行スクリプト一覧

### 1. 演算・アーキテクチャ別にバックグラウンド実行 (tmux)

`sweep/` 以下のランチャーを使用します。詳細は [sweep/README.md](sweep/README.md) を参照。

| 種類 | 例 | Tmux Session | サマリ CSV |
| :--- | :--- | :--- | :--- |
| **no_retime（単体調査）** | `./sweep/no_retime/launch_tmux.sh` | `sweep_no_ret` | `ret_no_retime_dat_summary.csv` |
| **no_retime（F100–F600 comb）** | `./sweep/no_retime/launch_flopoco.sh` | `sweep_flopoco` | `sweep_summary_flopoco_all.csv` |
| **retime（V1 All）** | `./sweep/retime/launch_sweep_v1.sh` | `sweep_v1` | `sweep_summary_v1_all.csv` |
| **retime（V2 All）** | `./sweep/retime/launch_sweep_v2.sh` | `sweep_v2` | `sweep_summary_v2_all.csv` |
| **retime（サブユニット）** | `./sweep/retime/launch_sweep_v2_simd.sh` 等 | 各スクリプト参照 | `sweep_summary_v2_*.csv` |
| **純粋組み合わせ遅延** | `./launch_baseline_comb.sh` | `comb_baseline` | `comb_baseline_dat_area.csv` |

- **監視方法**: `tmux attach -t [Session Name]` で各セッションに接続して進捗を確認できます。

### 2. 進捗モニタリング

すべてのスイープのログ更新状況を一括で監視します。

```bash
watch -n 1 'ls -ltr logs/*.log | tail -n 10'
```

なお、csvが残ってる場合はskipされます。

---

## ディレクトリ構成

- `sweep/no_retime/`: retiming なしの単体調査スクリプト
- `sweep/retime/`: retiming パイプラインスイープスクリプト
- `sweep_run/no_retime/`, `sweep_run/retime/`: 各スイープの合成結果
- `logs/`: すべての合成ログ (.log)
- `src/rtl/`: アーキテクチャ別のソースコード
- `run_ppa.tcl`: comb baseline 用（出力は `run-comb-*`）
- `launch_*.sh`: 実行用シェルスクリプト（sweep 以外）
