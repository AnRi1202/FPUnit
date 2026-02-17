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

### 1. 演算・アーキテクチャ別にバックグラウンド実行 (tmux)

`launch_sweep_[arch].sh` を使用して、各アーキテクチャのスイープを `tmux` 上で開始します。
実行後、各アーキテクチャごとの **サマリ CSV** が直下に生成されます。

| 対象 | 実行コマンド | Tmux Session | 生成されるサマリ CSV |
| :--- | :--- | :--- | :--- |
| **FloPoCo Baseline** | `./launch_sweep_flopoco.sh` | `sweep_flopoco` | `sweep_summary_flopoco_all.csv` |
| **V1 (Area Opt All)** | `./launch_sweep_v1.sh` | `sweep_v1` | `sweep_summary_v1_all.csv` |
| **V2 (BF16 Full All)** | `./launch_sweep_v2.sh` | `sweep_v2` | `sweep_summary_v2_all.csv` |
| **V2 Subunits** | `./launch_sweep_v2_subunits.sh` | `v2_subunits_sweep` | `sweep_summary_v2_*.csv` |
| **V3 Subunits** | `./launch_sweep_v3_subunits.sh` | `v3_subunits_sweep` | `sweep_summary_v3_*.csv` |
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

- `logs/`: すべての合成ログ (.log)
- `src/rtl/`: アーキテクチャ別のソースコード
- `run-*/`: 合成実行ごとの詳細データ (area.rpt, timing.rpt等)
- `launch_*.sh`: 実行用シェルスクリプト
- `run_*.py`: 合成自動化用 Python スクリプト。以下の2種類の構造があります：
    - **TCL動的生成型** (`run_sweep_flopoco_all.py` 等): ターゲット（周波数や演算）ごとにファイルパスやエンティティ名が変わるため、Python側でテンプレートを埋めてその都度TCLを作成・実行します。
    - **TCL固定参照型** (`run_sweep_v2_3_addmul.py` 等): 対象ファイルは固定ですが、環境変数（例：`PARAM_PIPE`）を切り替えながら共通の `ret_*.tcl` を呼び出します。
- `ret_*.tcl`: Synopsys DC 合成スクリプト
