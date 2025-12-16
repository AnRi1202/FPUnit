srcに入ったvhdlをsynthする仕組み
ただし、flopocoのファイル命名規則に従っているものだけ。あと、freqを微調整したい場合には,tclファイルのfreqをしているところに追加する必要あり


今は、src_divsqrtなどを作っているので、divsqrtを改めてsynthしたい場合は、フォルダ名を変えれば良い



 diff -u run-20251216-145000/report/original/power_f1_add.rpt run-20251216-150839/report/new/FPAdd_power.rpt




## 結果
### FPAdd_Kin_f1_origin



### FPMult_Kin_f1_origin


### FPDiv_Kin_f1_origin


### FPMult_Kin_f1_origin