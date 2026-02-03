function automatic string disp_36(input logic [35:0] v);
    string s;
    int i;
    begin
        s = "";
        for (i = 35; i >= 0; i--) begin
            s = {s, v[i] ? "1" : "0"};
            if (i % 4 == 0 && i != 0)
                s = {s, "_"};
        end
        return s;
    end
endfunction


function automatic string disp_32(input logic [31:0] v);
    string s;
    int i;
    begin
        s = "";
        for (i = 31; i >= 0; i--) begin
            s = {s, v[i] ? "1" : "0"};
            if (i % 4 == 0 && i != 0)
                s = {s, "_"};
        end
        return s;
    end
endfunction
