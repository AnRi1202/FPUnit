module normalizer(
    input  logic       clk,
    input  fp_fmt_e    fmt,
    input  logic [27:0] X,
    output logic [4:0]  Count_h,
    output logic [4:0]  Count_l,
    output logic [27:0] R
);
    always_comb begin
        R = 28'b0;
        Count_l = 5'b0;
        Count_h = 5'b0;
        begin
            logic [13:0] level4_h, level3_h, level2_h, level1_h, level0_h;
            logic [13:0] level4_l, level3_l, level2_l, level1_l, level0_l;
            logic count4;
            logic count4_h, count3_h, count2_h, count1_h, count0_h;
            logic count4_l, count3_l, count2_l, count1_l, count0_l;
            // Stage 4: shift by 16 (FP32 lane only)

            count4 = ~(|X[27:12]);
            
            if (fmt ==FP32) begin
                {level4_h,level4_l} = count4 ? {X[11:0], 16'b0}: X;
                count4_h = count4;
                count4_l = count4;
            end else begin
                level4_h = X[27:14]; // no meaning 2 LSB bits
                level4_l = X[13:0];
                count4_h =1'b0;
                count4_l =1'b0;
            end
            // Stage 3: shift by 8
            count3_h = ~(|level4_h[13:6]);
            count3_l = (fmt ==FP32) ? count3_h :~(|level4_l[11:4]);
            if (fmt == FP32) begin
                level3_h = count3_h ? {level4_h[5:0],  level4_l[13:6]}: level4_h;
            end else begin 
                level3_h = count3_h ? {level4_h[5:2], 8'b0, 2'b0} : level4_h;
            end
            level3_l = count3_l ? {level4_l[5:0], 8'b0} : level4_l;

            // Stage 2: shift by 4            
            count2_h = ~(|level3_h[13:10]);
            count2_l = (fmt ==FP32) ? count2_h : ~(|level3_l[11:8]);
            if (fmt == FP32) begin
                level2_h = count2_h ? {level3_h[9:0],  level3_l[13:10]} :level3_h;
            end else begin 
                level2_h = count2_h ? {level3_h[9:2], 4'b0, 2'b0} : level3_h;
            end
            level2_l = count2_l ? {level3_l[9:0], 4'b0} : level3_l;
            // Stage 1: shift by 2
            count1_h = ~(|level2_h[13:12]);
            count1_l = (fmt ==FP32) ? count1_h :~(|level2_l[11:10]);
            if (fmt == FP32) begin
                level1_h = count1_h ? {level2_h[11:0],  level2_l[13:12]} : level2_h;
            end else begin 
                level1_h = count1_h ? {level2_h[11:2], 2'b0, 2'b0} : level2_h;
            end
            level1_l = count1_l ? {level2_l[11:0], 2'b0} : level2_l;
            // Stage 0: shift by 1
            count0_h = ~(|level1_h[13]);
            count0_l = (fmt ==FP32) ? count0_h : ~(|level1_l[11]);
            if (fmt == FP32) begin
                level0_h = count0_h ? {level1_h[12:0],  level1_l[13]}: level1_h;
            end else begin 
                level0_h = count0_h ? {level1_h[12:2], 1'b0, 2'b0} : level1_h;
            end
            level0_l = count0_l ? {level1_l[12:0], 1'b0} : level1_l;


            R = {level0_h, level0_l};
            Count_h = {count4_h, count3_h, count2_h, count1_h, count0_h};
            Count_l = {count4_l, count3_l, count2_l, count1_l, count0_l};
        end
    end
endmodule