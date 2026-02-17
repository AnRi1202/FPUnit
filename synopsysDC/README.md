# FPU Synthesis and PPA Evaluation Environment

このディレクトリには、FloPoCoベースのBaselineデザインと、リタイミングを適用した改良版（V2）デザインの PPA (Power, Performance, Area) を評価するためのスクリプト群が含まれています。

## 統一合成制約 (Standardized Constraints)

公平な比較のため、すべての合成スクリプトで以下の制約を統一しています。

- **Clock Period**: 0.5 ns (目標 2.0 GHz)
- **I/O Delay**: 0.1 ns (周期の 20%)
- **Input Transition**: 0.05 ns
- **Output Load**: 0.1
- **Process**: Nangate 45nm Open Cell Library

---

## 実行コマンド一覧

### 1. 全スイープの並列実行 (推奨)
Baseline の周波数スイープと V2 のパイプラインスイープを `tmux` 上で同時に開始します。

```bash
./launch_sweeps_tmux.sh
```
- `baseline_sweep` ウィンドウ: Baseline (f100-f600) のスイープ
- `v2_6ops_sweep` ウィンドウ: V2 デザインのパイプライン段数スイープ
- `monitor` ウィンドウ: ログファイルの進捗監視

### 2. 全演算（Add/Mult）の並行実行 (tmux)
Baseline の Add/Mult と、V2 の Add/Mult パイプラインスイープを 4 つの tmux ウィンドウで並行実行します。

```bash
./launch_experiments_tmux.sh
```
- **Window 構成**:
    - `baseline_add`: Baseline FPAdd (f100-f600)
    - `baseline_mult`: Baseline FPMult (f100-f600)
    - `v2_add`: V2 Add (Pipe 1-12)
    - `v2_mult`: V2 Mult (Pipe 1-12)
- 個別の演算を並列で実行するため、`run_experiments_full.sh` よりも大幅に短時間で完了します。

### 3. モニタリング
ログファイルの進捗を監視します。

```bash
watch -n 1 'ls -ltr *.log | tail -n 20'
```

```bash
python3 run_sweep_f100_f600.py
```
- **対象バリエーション**:
    - `4OPS`: FP32 (Add, Mul, Sqrt, Div)
    - `5OPS`: Add Mixed (FP32 Add + BF16 Add x2)
    - `6OPS`: All Operations
    - `7OPS`: Mul Mixed (FP32 Mul + BF16 Mul x2)
- **出力**: `sweep_summary_f100_f600.csv`

### 3. V2 パイプラインスイープ (単体実行)
リタイミング版 V2 デザイン (`src/rtl/v2_bf16_full`) を対象に、パイプライン段数 (1-12) を変化させてスイープします。

```bash
python3 run_sweep_v2_6ops.py
```
- **出力**: `sweep_summary_v2_6ops.csv`

### 4. 全演算（Add/Mult）のシーケンシャル実行
Baseline の Add/Mult と、V2 の Add/Mult パイプラインスイープを連続して実行します。

```bash
./run_experiments_full.sh
```
- **実行内容**:
    - Baseline FPAdd (f100-f600)
    - Baseline FPMult (f100-f600)
    - V2 Retiming Add/Mult (Pipe 1-12)
- パイプライン化された V2 の Add と Mult を順次実行するため、時間がかかりますが、放置して全ての結果を得るのに適しています。

### 5. 個別モジュールのリタイミング合成
特定のパイプライン段数を指定して合成・解析を行いたい場合に使用します。内部で `PIPE` 環境変数を参照します。

```bash
# BF16 Add のパイプライン 10段設定で実行
setenv PIPE 10
dc_shell-xg-t -f ret_v2_1_add.tcl
```

---

## 結果の集計

各スクリプトが生成する CSV 以外に、ディレクトリ内の `.log` ファイルから最新の結果を抽出してサマリを作成できます。

```bash
python3 summarize_results.py
```
- **出力**: `final_summary.csv` (Entity名, 面積, 到着時間の一覧)

---

## 主要なファイル構成

- `run_ppa.tcl`: 合成のコアロジック（Baseline用）
- `run_sweep_*.py`: Pythonベースの自動スイーパ
- `ret_v2_*.tcl`: V2デザイン専用のリタイミング合成スクリプト
- `launch_sweeps_tmux.sh`: tmux を利用したバッチ実行スクリプト
