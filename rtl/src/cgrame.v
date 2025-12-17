

module cgrame_FPAdder #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  FP_clk_en,
  R,
  X,
  Y,
  opcode
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [0:0] FP_clk_en;
    output [size-1:0] R;
    input [size-1:0] X;
    input [size-1:0] Y;
    input [1:0] opcode;
    FPAdd FPAdder (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .ce(~ (FP_clk_en) & (opcode == 0 )  ),
        .X(X),
        .Y(Y),
        .R(R)
    );


endmodule //cgrame_FPAdder

module cgrame_elastic_configcell_context_size7II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size7II1

module cgrame_FPDivider #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  FP_clk_en,
  R,
  X,
  Y,
  opcode
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [0:0] FP_clk_en;
    output [size-1:0] R;
    input [size-1:0] X;
    input [size-1:0] Y;
    input [1:0] opcode;
    FPDiv FPDivider (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .ce(~ (FP_clk_en) & (opcode == 2 )  ),
        .X(X),
        .Y(Y),
        .R(R)
    );


endmodule //cgrame_FPDivider

module cgrame_FPInput #(parameter contexts=1, parameter size_in=1, parameter size_out=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  R,
  X
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    output [size_out-1:0] R;
    input [size_in-1:0] X;
    InputIEEE2FloPoCo FPInput (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .X(X),
        .R(R)
    );


endmodule //cgrame_FPInput

module cgrame_elastic_join_2to1_size_32 #(parameter contexts=1, parameter size=1) (
  enable,
  enable_stop_upstream,
  enable_valid_upstream,
  in0,
  in0_stop_upstream,
  in0_valid_upstream,
  in1,
  in1_stop_upstream,
  in1_valid_upstream,
  out0,
  out1,
  out_stop_downstream,
  out_valid_downstream
);
parameter FANIN = 2;
    input [1:0] enable;
    output [0:0] enable_stop_upstream;
    output [0:0] enable_valid_upstream;
    input [size-1:0] in0;
    output reg [0:0] in0_stop_upstream;
    input [0:0] in0_valid_upstream;
    input [size-1:0] in1;
    output reg [0:0] in1_stop_upstream;
    input [0:0] in1_valid_upstream;
    output [size-1:0] out0;
    output [size-1:0] out1;
    input [0:0] out_stop_downstream;
    output [0:0] out_valid_downstream;
    wire [(FANIN-1):0] valid_upstream;
    wire [(FANIN-1):0] stop_upstream;
    assign valid_upstream = {in1_valid_upstream, in0_valid_upstream};
    assign  {in1_stop_upstream, in0_stop_upstream} = stop_upstream;
    wire [(FANIN-1):0] masked_valid_upstream;
    assign masked_valid_upstream = valid_upstream | (~enable);
    assign out_valid_downstream = &masked_valid_upstream;
    assign stop_upstream =  {FANIN{out_stop_downstream}} | (masked_valid_upstream & {FANIN{~(out_valid_downstream)}});

    assign out0 = in0;
    assign out1 = in1;
    assign enable_valid_upstream = out_valid_downstream;
    assign enable_stop_upstream = out_stop_downstream;


endmodule //cgrame_elastic_join_2to1_size_32

module cgrame_FPMultiplier #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  FP_clk_en,
  R,
  X,
  Y,
  opcode
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [0:0] FP_clk_en;
    output [size-1:0] R;
    input [size-1:0] X;
    input [size-1:0] Y;
    input [1:0] opcode;
    FPMult FPMultiplier (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .ce(~ (FP_clk_en) & (opcode == 3 )  ),
        .X(X),
        .Y(Y),
        .R(R)
    );


endmodule //cgrame_FPMultiplier

module cgrame_FPOutput #(parameter contexts=1, parameter size_in=1, parameter size_out=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  R,
  X
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    output [size_out-1:0] R;
    input [size_in-1:0] X;
    OutputFloPoCo2IEEE FPOutput (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .X(X),
        .R(R)
    );


endmodule //cgrame_FPOutput

module cgrame_FPSqrt #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  FP_clk_en,
  R,
  X,
  opcode
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [0:0] FP_clk_en;
    output [size-1:0] R;
    input [size-1:0] X;
    input [1:0] opcode;
    FPSqrt FPSqroot (
        .clk(CGRA_Clock),
        .rst(CGRA_Reset),
        .ce(~ (FP_clk_en) & (opcode == 1 )  ),
        .X(X),
        .R(R)
    );


endmodule //cgrame_FPSqrt

module cgrame_configcell_context_II_1_1_size2 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [contexts-1:0] context_counter = {size{1'b0}};

    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset) begin
            for (i = 0; i < contexts; i = i+1) begin
                config_reg[i] <= 'd0;
            end
        end
        else begin
            for (i = 0; i < contexts; i = i+1) begin
                if(i == 0) begin
                    config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                end
                else begin
                    config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                end
            end
        end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_configcell_context_II_1_1_size2

module cgrame_configcell_context_II_1_1_size32 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [contexts-1:0] context_counter = {size{1'b0}};

    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset) begin
            for (i = 0; i < contexts; i = i+1) begin
                config_reg[i] <= 'd0;
            end
        end
        else begin
            for (i = 0; i < contexts; i = i+1) begin
                if(i == 0) begin
                    config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                end
                else begin
                    config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                end
            end
        end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_configcell_context_II_1_1_size32

module cgrame_disconnected_source_1b1 #(parameter contexts=1, parameter size=1) (
  out
);
    output [size-1:0] out;
    assign out = 1'd1;


endmodule //cgrame_disconnected_source_1b1

module cgrame_elastic_buffer_enable_32b #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  data_in,
  data_in_stop_upstream,
  data_in_valid_upstream,
  data_out,
  data_out_stop_downstream,
  data_out_valid_downstream,
  enable,
  enable_stop_upstream,
  enable_valid_upstream
);
    parameter DATA_WIDTH = 32;
    parameter DEPTH = 2;
    parameter ADDRESS_WIDTH = $clog2(DEPTH);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [size-1:0] data_in;
    output reg [0:0] data_in_stop_upstream;
    input [0:0] data_in_valid_upstream;
    output [size-1:0] data_out;
    input [0:0] data_out_stop_downstream;
    output [0:0] data_out_valid_downstream;
    input [0:0] enable;
    output [0:0] enable_stop_upstream;
    output [0:0] enable_valid_upstream;
    wire eb_enable;
    assign eb_enable = enable;
    assign enable_valid_upstream = data_in_valid_upstream;
    assign enable_stop_upstream = data_in_stop_upstream;
    wire fifo_full, fifo_almost_full, fifo_empty, fifo_almost_empty;
    wire [DATA_WIDTH-1:0] fifo_read_data;
    wire [ADDRESS_WIDTH:0] fifo_word_count;
    wire fifo_write_en, fifo_read_en;
    assign fifo_write_en = (data_in_valid_upstream & eb_enable) & ~fifo_full;
    assign fifo_read_en = ~fifo_empty & ~data_out_stop_downstream;
    assign data_in_stop_upstream = fifo_full;
    assign data_out_valid_downstream = ~fifo_empty;
    assign data_out = fifo_read_data & {DATA_WIDTH{~fifo_empty}};
    // Instantiate FIFO
    fwft_fifo FIFO
    (
        .reset ( CGRA_Reset ),
        .clk ( CGRA_Clock ),
        .full ( fifo_full ),
        .write_en ( fifo_write_en ),
        .write_data ( data_in ),
        .empty ( fifo_empty ),
        .read_en ( fifo_read_en ),
        .read_data ( fifo_read_data ),
        .usedw ( fifo_word_count )
    );
    defparam FIFO.width = DATA_WIDTH;
    defparam FIFO.widthad = ADDRESS_WIDTH;
    defparam FIFO.depth = DEPTH;


endmodule //cgrame_elastic_buffer_enable_32b

module cgrame_elastic_configcell_context_size10II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size10II1

module cgrame_elastic_eager_fork_1to2_size_32 #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  enable_downstream,
  enable_downstream_stop_upstream,
  enable_downstream_valid_upstream,
  in,
  in_stop_upstream,
  in_valid_upstream,
  out0,
  out0_stop_downstream,
  out0_valid_downstream,
  out1,
  out1_stop_downstream,
  out1_valid_downstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [1:0] enable_downstream;
    output [0:0] enable_downstream_stop_upstream;
    output [0:0] enable_downstream_valid_upstream;
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output [size-1:0] out0;
    input [0:0] out0_stop_downstream;
    output [0:0] out0_valid_downstream;
    output [size-1:0] out1;
    input [0:0] out1_stop_downstream;
    output [0:0] out1_valid_downstream;
    wire stop_upstream;    elastic_eager_fork #(.FANOUT(2), .FORK_LAYERS(1), .UNIT_FORK_FANOUT(2)) efork (
        .clk(CGRA_Clock),
        .reset(CGRA_Reset),
        .valid_upstream(in_valid_upstream),
        .stop_upstream(stop_upstream),
        .valid_downstream({out1_valid_downstream, out0_valid_downstream}),
        .stop_downstream({out1_stop_downstream, out0_stop_downstream}),
        .enable_downstream(enable_downstream)
    );

    assign out0 = in & {32{CGRA_Enable}};
    assign out1 = in & {32{CGRA_Enable}};
    assign in_stop_upstream = stop_upstream;
    assign enable_downstream_valid_upstream = in_valid_upstream;
    assign enable_downstream_stop_upstream = in_stop_upstream;


endmodule //cgrame_elastic_eager_fork_1to2_size_32

module cgrame_elastic_configcell_context_size1II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= ConfigIn;
                    end
                    else begin
                        config_reg[i] <= config_reg[i-1];
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size1II1

module cgrame_elastic_configcell_context_size2II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size2II1

module cgrame_elastic_configcell_context_size3II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size3II1

module cgrame_elastic_configcell_context_size4II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size4II1

module cgrame_elastic_configcell_context_size8II1 #(parameter contexts=1, parameter size=1) (
  ConfigIn,
  ConfigOut,
  Config_Clock,
  Config_Reset,
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  select,
  valid,
  stop
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input ConfigIn;
    input Config_Clock;
    input Config_Reset;
    output ConfigOut;
    input valid;
    input stop;
    output [size-1:0] select;
    reg [size-1:0] config_reg [contexts-1:0];

    reg [0:0] context_counter;
    reg [0:0] contexts_used;
    integer i;

    always @(posedge Config_Clock, posedge Config_Reset)
        if (Config_Reset)
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    config_reg[i] <= 'd0;
                end
            end
        else
            begin
                for (i = 0; i < contexts; i = i+1) begin
                    if(i == 0) begin
                        config_reg[i] <= {ConfigIn,config_reg[i][size-1:1]};
                    end
                    else begin
                        config_reg[i] <= {config_reg[i-1][0],config_reg[i][size-1:1]};
                    end
                end
            end

    assign select = config_reg[0];
    assign ConfigOut = config_reg[contexts-1][0];

endmodule //cgrame_elastic_configcell_context_size8II1

module elastic_const_32b_U16 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  output [31:0] out,
  input [0:0] out_stop_downstream,
  output [0:0] out_valid_downstream
);
  //Wire declarations for instance 'ConstVal' (Module cgrame_configcell_context_II_1_1_size32)
  wire  ConstVal__CGRA_Clock;
  wire  ConstVal__CGRA_Enable;
  wire  ConstVal__CGRA_Reset;
  wire  ConstVal__ConfigIn;
  wire  ConstVal__ConfigOut;
  wire  ConstVal__Config_Clock;
  wire  ConstVal__Config_Reset;
  wire [31:0] ConstVal__select;
  cgrame_configcell_context_II_1_1_size32 #(.contexts(1),.size(32)) ConstVal(
    .CGRA_Clock(ConstVal__CGRA_Clock),
    .CGRA_Enable(ConstVal__CGRA_Enable),
    .CGRA_Reset(ConstVal__CGRA_Reset),
    .ConfigIn(ConstVal__ConfigIn),
    .ConfigOut(ConstVal__ConfigOut),
    .Config_Clock(ConstVal__Config_Clock),
    .Config_Reset(ConstVal__Config_Reset),
    .select(ConstVal__select)
  );

  //Wire declarations for instance 'dis' (Module cgrame_disconnected_source_1b1)
  wire [0:0] dis__out;
  cgrame_disconnected_source_1b1 #(.contexts(1),.size(1)) dis(
    .out(dis__out)
  );

  //All the connections
  assign ConstVal__CGRA_Clock = CGRA_Clock;
  assign ConstVal__CGRA_Reset = CGRA_Reset;
  assign ConstVal__CGRA_Enable = CGRA_Enable;
  assign ConstVal__Config_Clock = Config_Clock;
  assign ConstVal__Config_Reset = Config_Reset;
  assign out_valid_downstream[0:0] = dis__out[0:0];
  assign out[31:0] = ConstVal__select[31:0];
  assign ConstVal__ConfigIn = ConfigIn;
  assign ConfigOut = ConstVal__ConfigOut;

endmodule //elastic_const_32b_U16

module cgrame_elastic_eager_fork_1to7_size_32 #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  enable_downstream,
  enable_downstream_stop_upstream,
  enable_downstream_valid_upstream,
  in,
  in_stop_upstream,
  in_valid_upstream,
  out0,
  out0_stop_downstream,
  out0_valid_downstream,
  out1,
  out1_stop_downstream,
  out1_valid_downstream,
  out2,
  out2_stop_downstream,
  out2_valid_downstream,
  out3,
  out3_stop_downstream,
  out3_valid_downstream,
  out4,
  out4_stop_downstream,
  out4_valid_downstream,
  out5,
  out5_stop_downstream,
  out5_valid_downstream,
  out6,
  out6_stop_downstream,
  out6_valid_downstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [6:0] enable_downstream;
    output [0:0] enable_downstream_stop_upstream;
    output [0:0] enable_downstream_valid_upstream;
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output [size-1:0] out0;
    input [0:0] out0_stop_downstream;
    output [0:0] out0_valid_downstream;
    output [size-1:0] out1;
    input [0:0] out1_stop_downstream;
    output [0:0] out1_valid_downstream;
    output [size-1:0] out2;
    input [0:0] out2_stop_downstream;
    output [0:0] out2_valid_downstream;
    output [size-1:0] out3;
    input [0:0] out3_stop_downstream;
    output [0:0] out3_valid_downstream;
    output [size-1:0] out4;
    input [0:0] out4_stop_downstream;
    output [0:0] out4_valid_downstream;
    output [size-1:0] out5;
    input [0:0] out5_stop_downstream;
    output [0:0] out5_valid_downstream;
    output [size-1:0] out6;
    input [0:0] out6_stop_downstream;
    output [0:0] out6_valid_downstream;
    wire stop_upstream;    elastic_eager_fork #(.FANOUT(7), .FORK_LAYERS(3), .UNIT_FORK_FANOUT(2)) efork (
        .clk(CGRA_Clock),
        .reset(CGRA_Reset),
        .valid_upstream(in_valid_upstream),
        .stop_upstream(stop_upstream),
        .valid_downstream({out6_valid_downstream, out5_valid_downstream, out4_valid_downstream, out3_valid_downstream, out2_valid_downstream, out1_valid_downstream, out0_valid_downstream}),
        .stop_downstream({out6_stop_downstream, out5_stop_downstream, out4_stop_downstream, out3_stop_downstream, out2_stop_downstream, out1_stop_downstream, out0_stop_downstream}),
        .enable_downstream(enable_downstream)
    );

    assign out0 = in & {32{CGRA_Enable}};
    assign out1 = in & {32{CGRA_Enable}};
    assign out2 = in & {32{CGRA_Enable}};
    assign out3 = in & {32{CGRA_Enable}};
    assign out4 = in & {32{CGRA_Enable}};
    assign out5 = in & {32{CGRA_Enable}};
    assign out6 = in & {32{CGRA_Enable}};
    assign in_stop_upstream = stop_upstream;
    assign enable_downstream_valid_upstream = in_valid_upstream;
    assign enable_downstream_stop_upstream = in_stop_upstream;


endmodule //cgrame_elastic_eager_fork_1to7_size_32

module cgrame_elastic_demux_2to1_32b #(parameter contexts=1, parameter size=1) (
  in,
  in_stop_upstream,
  in_valid_upstream,
  out0,
  out0_stop_downstream,
  out0_valid_downstream,
  out1,
  out1_stop_downstream,
  out1_valid_downstream,
  select,
  select_stop_upstream,
  select_valid_upstream
);
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output reg [size-1:0] out0;
    input [0:0] out0_stop_downstream;
    output reg [0:0] out0_valid_downstream;
    output reg [size-1:0] out1;
    input [0:0] out1_stop_downstream;
    output reg [0:0] out1_valid_downstream;
    input [0:0] select;
    output [0:0] select_stop_upstream;
    output [0:0] select_valid_upstream;
    always @(*)
        case (select)
            0:begin
                 out0= in;
                 in_stop_upstream = out0_stop_downstream;
                 out0_valid_downstream = in_valid_upstream;
                 out1_valid_downstream = 1'b0;
                 out1 = {size{1'b0}};
            end
            1:begin
                 out0_valid_downstream = 1'b0;
                 out0 = {size{1'b0}};
                 out1= in;
                 in_stop_upstream = out1_stop_downstream;
                 out1_valid_downstream = in_valid_upstream;
            end
            default :begin
                 in_stop_upstream= 1'b0;
                 out0 = {size{1'b0}};
                 out0_valid_downstream = 1'b0;
                 out1 = {size{1'b0}};
                 out1_valid_downstream = 1'b0;
            end
        endcase

endmodule //cgrame_elastic_demux_2to1_32b

module cgrame_elastic_eager_fork_1to10_size_32 #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  enable_downstream,
  enable_downstream_stop_upstream,
  enable_downstream_valid_upstream,
  in,
  in_stop_upstream,
  in_valid_upstream,
  out0,
  out0_stop_downstream,
  out0_valid_downstream,
  out1,
  out1_stop_downstream,
  out1_valid_downstream,
  out2,
  out2_stop_downstream,
  out2_valid_downstream,
  out3,
  out3_stop_downstream,
  out3_valid_downstream,
  out4,
  out4_stop_downstream,
  out4_valid_downstream,
  out5,
  out5_stop_downstream,
  out5_valid_downstream,
  out6,
  out6_stop_downstream,
  out6_valid_downstream,
  out7,
  out7_stop_downstream,
  out7_valid_downstream,
  out8,
  out8_stop_downstream,
  out8_valid_downstream,
  out9,
  out9_stop_downstream,
  out9_valid_downstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [9:0] enable_downstream;
    output [0:0] enable_downstream_stop_upstream;
    output [0:0] enable_downstream_valid_upstream;
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output [size-1:0] out0;
    input [0:0] out0_stop_downstream;
    output [0:0] out0_valid_downstream;
    output [size-1:0] out1;
    input [0:0] out1_stop_downstream;
    output [0:0] out1_valid_downstream;
    output [size-1:0] out2;
    input [0:0] out2_stop_downstream;
    output [0:0] out2_valid_downstream;
    output [size-1:0] out3;
    input [0:0] out3_stop_downstream;
    output [0:0] out3_valid_downstream;
    output [size-1:0] out4;
    input [0:0] out4_stop_downstream;
    output [0:0] out4_valid_downstream;
    output [size-1:0] out5;
    input [0:0] out5_stop_downstream;
    output [0:0] out5_valid_downstream;
    output [size-1:0] out6;
    input [0:0] out6_stop_downstream;
    output [0:0] out6_valid_downstream;
    output [size-1:0] out7;
    input [0:0] out7_stop_downstream;
    output [0:0] out7_valid_downstream;
    output [size-1:0] out8;
    input [0:0] out8_stop_downstream;
    output [0:0] out8_valid_downstream;
    output [size-1:0] out9;
    input [0:0] out9_stop_downstream;
    output [0:0] out9_valid_downstream;
    wire stop_upstream;    elastic_eager_fork #(.FANOUT(10), .FORK_LAYERS(4), .UNIT_FORK_FANOUT(2)) efork (
        .clk(CGRA_Clock),
        .reset(CGRA_Reset),
        .valid_upstream(in_valid_upstream),
        .stop_upstream(stop_upstream),
        .valid_downstream({out9_valid_downstream, out8_valid_downstream, out7_valid_downstream, out6_valid_downstream, out5_valid_downstream, out4_valid_downstream, out3_valid_downstream, out2_valid_downstream, out1_valid_downstream, out0_valid_downstream}),
        .stop_downstream({out9_stop_downstream, out8_stop_downstream, out7_stop_downstream, out6_stop_downstream, out5_stop_downstream, out4_stop_downstream, out3_stop_downstream, out2_stop_downstream, out1_stop_downstream, out0_stop_downstream}),
        .enable_downstream(enable_downstream)
    );

    assign out0 = in & {32{CGRA_Enable}};
    assign out1 = in & {32{CGRA_Enable}};
    assign out2 = in & {32{CGRA_Enable}};
    assign out3 = in & {32{CGRA_Enable}};
    assign out4 = in & {32{CGRA_Enable}};
    assign out5 = in & {32{CGRA_Enable}};
    assign out6 = in & {32{CGRA_Enable}};
    assign out7 = in & {32{CGRA_Enable}};
    assign out8 = in & {32{CGRA_Enable}};
    assign out9 = in & {32{CGRA_Enable}};
    assign in_stop_upstream = stop_upstream;
    assign enable_downstream_valid_upstream = in_valid_upstream;
    assign enable_downstream_stop_upstream = in_stop_upstream;


endmodule //cgrame_elastic_eager_fork_1to10_size_32

module cgrame_elastic_eager_fork_1to8_size_32 #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  enable_downstream,
  enable_downstream_stop_upstream,
  enable_downstream_valid_upstream,
  in,
  in_stop_upstream,
  in_valid_upstream,
  out0,
  out0_stop_downstream,
  out0_valid_downstream,
  out1,
  out1_stop_downstream,
  out1_valid_downstream,
  out2,
  out2_stop_downstream,
  out2_valid_downstream,
  out3,
  out3_stop_downstream,
  out3_valid_downstream,
  out4,
  out4_stop_downstream,
  out4_valid_downstream,
  out5,
  out5_stop_downstream,
  out5_valid_downstream,
  out6,
  out6_stop_downstream,
  out6_valid_downstream,
  out7,
  out7_stop_downstream,
  out7_valid_downstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [7:0] enable_downstream;
    output [0:0] enable_downstream_stop_upstream;
    output [0:0] enable_downstream_valid_upstream;
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output [size-1:0] out0;
    input [0:0] out0_stop_downstream;
    output [0:0] out0_valid_downstream;
    output [size-1:0] out1;
    input [0:0] out1_stop_downstream;
    output [0:0] out1_valid_downstream;
    output [size-1:0] out2;
    input [0:0] out2_stop_downstream;
    output [0:0] out2_valid_downstream;
    output [size-1:0] out3;
    input [0:0] out3_stop_downstream;
    output [0:0] out3_valid_downstream;
    output [size-1:0] out4;
    input [0:0] out4_stop_downstream;
    output [0:0] out4_valid_downstream;
    output [size-1:0] out5;
    input [0:0] out5_stop_downstream;
    output [0:0] out5_valid_downstream;
    output [size-1:0] out6;
    input [0:0] out6_stop_downstream;
    output [0:0] out6_valid_downstream;
    output [size-1:0] out7;
    input [0:0] out7_stop_downstream;
    output [0:0] out7_valid_downstream;
    wire stop_upstream;    elastic_eager_fork #(.FANOUT(8), .FORK_LAYERS(3), .UNIT_FORK_FANOUT(2)) efork (
        .clk(CGRA_Clock),
        .reset(CGRA_Reset),
        .valid_upstream(in_valid_upstream),
        .stop_upstream(stop_upstream),
        .valid_downstream({out7_valid_downstream, out6_valid_downstream, out5_valid_downstream, out4_valid_downstream, out3_valid_downstream, out2_valid_downstream, out1_valid_downstream, out0_valid_downstream}),
        .stop_downstream({out7_stop_downstream, out6_stop_downstream, out5_stop_downstream, out4_stop_downstream, out3_stop_downstream, out2_stop_downstream, out1_stop_downstream, out0_stop_downstream}),
        .enable_downstream(enable_downstream)
    );

    assign out0 = in & {32{CGRA_Enable}};
    assign out1 = in & {32{CGRA_Enable}};
    assign out2 = in & {32{CGRA_Enable}};
    assign out3 = in & {32{CGRA_Enable}};
    assign out4 = in & {32{CGRA_Enable}};
    assign out5 = in & {32{CGRA_Enable}};
    assign out6 = in & {32{CGRA_Enable}};
    assign out7 = in & {32{CGRA_Enable}};
    assign in_stop_upstream = stop_upstream;
    assign enable_downstream_valid_upstream = in_valid_upstream;
    assign enable_downstream_stop_upstream = in_stop_upstream;


endmodule //cgrame_elastic_eager_fork_1to8_size_32

module cgrame_elastic_fu_vlu_adapter_32b #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  data_in,
  data_in_stop_upstream,
  data_in_valid_upstream,
  data_out,
  data_out_stop_downstream,
  data_out_valid_downstream,
  token,
  token_stop_upstream,
  token_valid_upstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [size-1:0] data_in;
    output reg [0:0] data_in_stop_upstream;
    input [0:0] data_in_valid_upstream;
    output [size-1:0] data_out;
    input [0:0] data_out_stop_downstream;
    output [0:0] data_out_valid_downstream;
    input [0:0] token;
    output [0:0] token_stop_upstream;
    output [0:0] token_valid_upstream;
    reg [0-1:0] counter;
    reg pass;

    always @(posedge CGRA_Clock, posedge CGRA_Reset) begin
        if (CGRA_Reset == 'b1) begin
            pass <= 'b0;
            counter <= 'b0;
        end else if (~data_out_stop_downstream) begin
                if (counter == 1) begin 
                    pass <= 1'b0;
                end else begin
                    pass <= token;
                    counter <= counter + 1'b1;
                end
        end
    end

    assign data_in_stop_upstream = data_out_stop_downstream;
    assign data_out_valid_downstream = data_in_valid_upstream | pass;
    assign token_stop_upstream = data_in_stop_upstream;
    assign token_valid_upstream = 'b1;
    assign data_out = data_in;


endmodule //cgrame_elastic_fu_vlu_adapter_32b

module cgrame_elastic_mux_2to1_32b #(parameter contexts=1, parameter size=1) (
  in0,
  in0_stop_upstream,
  in0_valid_upstream,
  in1,
  in1_stop_upstream,
  in1_valid_upstream,
  out,
  out_stop_downstream,
  out_valid_downstream,
  select,
  select_stop_upstream,
  select_valid_upstream
);
    input [size-1:0] in0;
    output reg [0:0] in0_stop_upstream;
    input [0:0] in0_valid_upstream;
    input [size-1:0] in1;
    output reg [0:0] in1_stop_upstream;
    input [0:0] in1_valid_upstream;
    output reg [size-1:0] out;
    input [0:0] out_stop_downstream;
    output reg [0:0] out_valid_downstream;
    input [0:0] select;
    output [0:0] select_stop_upstream;
    output [0:0] select_valid_upstream;
    always @(*)
        case (select)
            0:begin
                 out = in0;
                 out_valid_downstream = in0_valid_upstream;
                 in0_stop_upstream = out_stop_downstream;
                 in1_stop_upstream = 1'b1;
            end
            1:begin
                 out = in1;
                 out_valid_downstream = in1_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = out_stop_downstream;
            end
            default: out = {size{1'bx}};
        endcase
        assign select_stop_upstream = out_stop_downstream;
        assign select_valid_upstream = out_valid_downstream;


endmodule //cgrame_elastic_mux_2to1_32b

module cgrame_elastic_mux_6to1_32b #(parameter contexts=1, parameter size=1) (
  in0,
  in0_stop_upstream,
  in0_valid_upstream,
  in1,
  in1_stop_upstream,
  in1_valid_upstream,
  in2,
  in2_stop_upstream,
  in2_valid_upstream,
  in3,
  in3_stop_upstream,
  in3_valid_upstream,
  in4,
  in4_stop_upstream,
  in4_valid_upstream,
  in5,
  in5_stop_upstream,
  in5_valid_upstream,
  out,
  out_stop_downstream,
  out_valid_downstream,
  select,
  select_stop_upstream,
  select_valid_upstream
);
    input [size-1:0] in0;
    output reg [0:0] in0_stop_upstream;
    input [0:0] in0_valid_upstream;
    input [size-1:0] in1;
    output reg [0:0] in1_stop_upstream;
    input [0:0] in1_valid_upstream;
    input [size-1:0] in2;
    output reg [0:0] in2_stop_upstream;
    input [0:0] in2_valid_upstream;
    input [size-1:0] in3;
    output reg [0:0] in3_stop_upstream;
    input [0:0] in3_valid_upstream;
    input [size-1:0] in4;
    output reg [0:0] in4_stop_upstream;
    input [0:0] in4_valid_upstream;
    input [size-1:0] in5;
    output reg [0:0] in5_stop_upstream;
    input [0:0] in5_valid_upstream;
    output reg [size-1:0] out;
    input [0:0] out_stop_downstream;
    output reg [0:0] out_valid_downstream;
    input [2:0] select;
    output [0:0] select_stop_upstream;
    output [0:0] select_valid_upstream;
    always @(*)
        case (select)
            0:begin
                 out = in0;
                 out_valid_downstream = in0_valid_upstream;
                 in0_stop_upstream = out_stop_downstream;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
            end
            1:begin
                 out = in1;
                 out_valid_downstream = in1_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = out_stop_downstream;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
            end
            2:begin
                 out = in2;
                 out_valid_downstream = in2_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = out_stop_downstream;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
            end
            3:begin
                 out = in3;
                 out_valid_downstream = in3_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = out_stop_downstream;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
            end
            4:begin
                 out = in4;
                 out_valid_downstream = in4_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = out_stop_downstream;
                 in5_stop_upstream = 1'b1;
            end
            5:begin
                 out = in5;
                 out_valid_downstream = in5_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = out_stop_downstream;
            end
            default: out = {size{1'bx}};
        endcase
        assign select_stop_upstream = out_stop_downstream;
        assign select_valid_upstream = out_valid_downstream;


endmodule //cgrame_elastic_mux_6to1_32b

module elastic_crossbar_6in_7out_size_32_U21 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream
);
  //Wire declarations for instance 'ForkCrossbar0Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar0Config__CGRA_Clock;
  wire  ForkCrossbar0Config__CGRA_Enable;
  wire  ForkCrossbar0Config__CGRA_Reset;
  wire  ForkCrossbar0Config__ConfigIn;
  wire  ForkCrossbar0Config__ConfigOut;
  wire  ForkCrossbar0Config__Config_Clock;
  wire  ForkCrossbar0Config__Config_Reset;
  wire [6:0] ForkCrossbar0Config__select;
  wire [0:0] ForkCrossbar0Config__stop;
  wire [0:0] ForkCrossbar0Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar0Config(
    .CGRA_Clock(ForkCrossbar0Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar0Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar0Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar0Config__ConfigIn),
    .ConfigOut(ForkCrossbar0Config__ConfigOut),
    .Config_Clock(ForkCrossbar0Config__Config_Clock),
    .Config_Reset(ForkCrossbar0Config__Config_Reset),
    .select(ForkCrossbar0Config__select),
    .stop(ForkCrossbar0Config__stop),
    .valid(ForkCrossbar0Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar1Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar1Config__CGRA_Clock;
  wire  ForkCrossbar1Config__CGRA_Enable;
  wire  ForkCrossbar1Config__CGRA_Reset;
  wire  ForkCrossbar1Config__ConfigIn;
  wire  ForkCrossbar1Config__ConfigOut;
  wire  ForkCrossbar1Config__Config_Clock;
  wire  ForkCrossbar1Config__Config_Reset;
  wire [6:0] ForkCrossbar1Config__select;
  wire [0:0] ForkCrossbar1Config__stop;
  wire [0:0] ForkCrossbar1Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar1Config(
    .CGRA_Clock(ForkCrossbar1Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar1Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar1Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar1Config__ConfigIn),
    .ConfigOut(ForkCrossbar1Config__ConfigOut),
    .Config_Clock(ForkCrossbar1Config__Config_Clock),
    .Config_Reset(ForkCrossbar1Config__Config_Reset),
    .select(ForkCrossbar1Config__select),
    .stop(ForkCrossbar1Config__stop),
    .valid(ForkCrossbar1Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar2Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar2Config__CGRA_Clock;
  wire  ForkCrossbar2Config__CGRA_Enable;
  wire  ForkCrossbar2Config__CGRA_Reset;
  wire  ForkCrossbar2Config__ConfigIn;
  wire  ForkCrossbar2Config__ConfigOut;
  wire  ForkCrossbar2Config__Config_Clock;
  wire  ForkCrossbar2Config__Config_Reset;
  wire [6:0] ForkCrossbar2Config__select;
  wire [0:0] ForkCrossbar2Config__stop;
  wire [0:0] ForkCrossbar2Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar2Config(
    .CGRA_Clock(ForkCrossbar2Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar2Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar2Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar2Config__ConfigIn),
    .ConfigOut(ForkCrossbar2Config__ConfigOut),
    .Config_Clock(ForkCrossbar2Config__Config_Clock),
    .Config_Reset(ForkCrossbar2Config__Config_Reset),
    .select(ForkCrossbar2Config__select),
    .stop(ForkCrossbar2Config__stop),
    .valid(ForkCrossbar2Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar3Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar3Config__CGRA_Clock;
  wire  ForkCrossbar3Config__CGRA_Enable;
  wire  ForkCrossbar3Config__CGRA_Reset;
  wire  ForkCrossbar3Config__ConfigIn;
  wire  ForkCrossbar3Config__ConfigOut;
  wire  ForkCrossbar3Config__Config_Clock;
  wire  ForkCrossbar3Config__Config_Reset;
  wire [6:0] ForkCrossbar3Config__select;
  wire [0:0] ForkCrossbar3Config__stop;
  wire [0:0] ForkCrossbar3Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar3Config(
    .CGRA_Clock(ForkCrossbar3Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar3Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar3Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar3Config__ConfigIn),
    .ConfigOut(ForkCrossbar3Config__ConfigOut),
    .Config_Clock(ForkCrossbar3Config__Config_Clock),
    .Config_Reset(ForkCrossbar3Config__Config_Reset),
    .select(ForkCrossbar3Config__select),
    .stop(ForkCrossbar3Config__stop),
    .valid(ForkCrossbar3Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar4Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar4Config__CGRA_Clock;
  wire  ForkCrossbar4Config__CGRA_Enable;
  wire  ForkCrossbar4Config__CGRA_Reset;
  wire  ForkCrossbar4Config__ConfigIn;
  wire  ForkCrossbar4Config__ConfigOut;
  wire  ForkCrossbar4Config__Config_Clock;
  wire  ForkCrossbar4Config__Config_Reset;
  wire [6:0] ForkCrossbar4Config__select;
  wire [0:0] ForkCrossbar4Config__stop;
  wire [0:0] ForkCrossbar4Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar4Config(
    .CGRA_Clock(ForkCrossbar4Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar4Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar4Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar4Config__ConfigIn),
    .ConfigOut(ForkCrossbar4Config__ConfigOut),
    .Config_Clock(ForkCrossbar4Config__Config_Clock),
    .Config_Reset(ForkCrossbar4Config__Config_Reset),
    .select(ForkCrossbar4Config__select),
    .stop(ForkCrossbar4Config__stop),
    .valid(ForkCrossbar4Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar5Config' (Module cgrame_elastic_configcell_context_size7II1)
  wire  ForkCrossbar5Config__CGRA_Clock;
  wire  ForkCrossbar5Config__CGRA_Enable;
  wire  ForkCrossbar5Config__CGRA_Reset;
  wire  ForkCrossbar5Config__ConfigIn;
  wire  ForkCrossbar5Config__ConfigOut;
  wire  ForkCrossbar5Config__Config_Clock;
  wire  ForkCrossbar5Config__Config_Reset;
  wire [6:0] ForkCrossbar5Config__select;
  wire [0:0] ForkCrossbar5Config__stop;
  wire [0:0] ForkCrossbar5Config__valid;
  cgrame_elastic_configcell_context_size7II1 #(.contexts(1),.size(7)) ForkCrossbar5Config(
    .CGRA_Clock(ForkCrossbar5Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar5Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar5Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar5Config__ConfigIn),
    .ConfigOut(ForkCrossbar5Config__ConfigOut),
    .Config_Clock(ForkCrossbar5Config__Config_Clock),
    .Config_Reset(ForkCrossbar5Config__Config_Reset),
    .select(ForkCrossbar5Config__select),
    .stop(ForkCrossbar5Config__stop),
    .valid(ForkCrossbar5Config__valid)
  );

  //Wire declarations for instance 'Mux0config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux0config__CGRA_Clock;
  wire  Mux0config__CGRA_Enable;
  wire  Mux0config__CGRA_Reset;
  wire  Mux0config__ConfigIn;
  wire  Mux0config__ConfigOut;
  wire  Mux0config__Config_Clock;
  wire  Mux0config__Config_Reset;
  wire [2:0] Mux0config__select;
  wire [0:0] Mux0config__stop;
  wire [0:0] Mux0config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux0config(
    .CGRA_Clock(Mux0config__CGRA_Clock),
    .CGRA_Enable(Mux0config__CGRA_Enable),
    .CGRA_Reset(Mux0config__CGRA_Reset),
    .ConfigIn(Mux0config__ConfigIn),
    .ConfigOut(Mux0config__ConfigOut),
    .Config_Clock(Mux0config__Config_Clock),
    .Config_Reset(Mux0config__Config_Reset),
    .select(Mux0config__select),
    .stop(Mux0config__stop),
    .valid(Mux0config__valid)
  );

  //Wire declarations for instance 'Mux1config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux1config__CGRA_Clock;
  wire  Mux1config__CGRA_Enable;
  wire  Mux1config__CGRA_Reset;
  wire  Mux1config__ConfigIn;
  wire  Mux1config__ConfigOut;
  wire  Mux1config__Config_Clock;
  wire  Mux1config__Config_Reset;
  wire [2:0] Mux1config__select;
  wire [0:0] Mux1config__stop;
  wire [0:0] Mux1config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux1config(
    .CGRA_Clock(Mux1config__CGRA_Clock),
    .CGRA_Enable(Mux1config__CGRA_Enable),
    .CGRA_Reset(Mux1config__CGRA_Reset),
    .ConfigIn(Mux1config__ConfigIn),
    .ConfigOut(Mux1config__ConfigOut),
    .Config_Clock(Mux1config__Config_Clock),
    .Config_Reset(Mux1config__Config_Reset),
    .select(Mux1config__select),
    .stop(Mux1config__stop),
    .valid(Mux1config__valid)
  );

  //Wire declarations for instance 'Mux2config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux2config__CGRA_Clock;
  wire  Mux2config__CGRA_Enable;
  wire  Mux2config__CGRA_Reset;
  wire  Mux2config__ConfigIn;
  wire  Mux2config__ConfigOut;
  wire  Mux2config__Config_Clock;
  wire  Mux2config__Config_Reset;
  wire [2:0] Mux2config__select;
  wire [0:0] Mux2config__stop;
  wire [0:0] Mux2config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux2config(
    .CGRA_Clock(Mux2config__CGRA_Clock),
    .CGRA_Enable(Mux2config__CGRA_Enable),
    .CGRA_Reset(Mux2config__CGRA_Reset),
    .ConfigIn(Mux2config__ConfigIn),
    .ConfigOut(Mux2config__ConfigOut),
    .Config_Clock(Mux2config__Config_Clock),
    .Config_Reset(Mux2config__Config_Reset),
    .select(Mux2config__select),
    .stop(Mux2config__stop),
    .valid(Mux2config__valid)
  );

  //Wire declarations for instance 'Mux3config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux3config__CGRA_Clock;
  wire  Mux3config__CGRA_Enable;
  wire  Mux3config__CGRA_Reset;
  wire  Mux3config__ConfigIn;
  wire  Mux3config__ConfigOut;
  wire  Mux3config__Config_Clock;
  wire  Mux3config__Config_Reset;
  wire [2:0] Mux3config__select;
  wire [0:0] Mux3config__stop;
  wire [0:0] Mux3config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux3config(
    .CGRA_Clock(Mux3config__CGRA_Clock),
    .CGRA_Enable(Mux3config__CGRA_Enable),
    .CGRA_Reset(Mux3config__CGRA_Reset),
    .ConfigIn(Mux3config__ConfigIn),
    .ConfigOut(Mux3config__ConfigOut),
    .Config_Clock(Mux3config__Config_Clock),
    .Config_Reset(Mux3config__Config_Reset),
    .select(Mux3config__select),
    .stop(Mux3config__stop),
    .valid(Mux3config__valid)
  );

  //Wire declarations for instance 'Mux4config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux4config__CGRA_Clock;
  wire  Mux4config__CGRA_Enable;
  wire  Mux4config__CGRA_Reset;
  wire  Mux4config__ConfigIn;
  wire  Mux4config__ConfigOut;
  wire  Mux4config__Config_Clock;
  wire  Mux4config__Config_Reset;
  wire [2:0] Mux4config__select;
  wire [0:0] Mux4config__stop;
  wire [0:0] Mux4config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux4config(
    .CGRA_Clock(Mux4config__CGRA_Clock),
    .CGRA_Enable(Mux4config__CGRA_Enable),
    .CGRA_Reset(Mux4config__CGRA_Reset),
    .ConfigIn(Mux4config__ConfigIn),
    .ConfigOut(Mux4config__ConfigOut),
    .Config_Clock(Mux4config__Config_Clock),
    .Config_Reset(Mux4config__Config_Reset),
    .select(Mux4config__select),
    .stop(Mux4config__stop),
    .valid(Mux4config__valid)
  );

  //Wire declarations for instance 'Mux5config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux5config__CGRA_Clock;
  wire  Mux5config__CGRA_Enable;
  wire  Mux5config__CGRA_Reset;
  wire  Mux5config__ConfigIn;
  wire  Mux5config__ConfigOut;
  wire  Mux5config__Config_Clock;
  wire  Mux5config__Config_Reset;
  wire [2:0] Mux5config__select;
  wire [0:0] Mux5config__stop;
  wire [0:0] Mux5config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux5config(
    .CGRA_Clock(Mux5config__CGRA_Clock),
    .CGRA_Enable(Mux5config__CGRA_Enable),
    .CGRA_Reset(Mux5config__CGRA_Reset),
    .ConfigIn(Mux5config__ConfigIn),
    .ConfigOut(Mux5config__ConfigOut),
    .Config_Clock(Mux5config__Config_Clock),
    .Config_Reset(Mux5config__Config_Reset),
    .select(Mux5config__select),
    .stop(Mux5config__stop),
    .valid(Mux5config__valid)
  );

  //Wire declarations for instance 'Mux6config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux6config__CGRA_Clock;
  wire  Mux6config__CGRA_Enable;
  wire  Mux6config__CGRA_Reset;
  wire  Mux6config__ConfigIn;
  wire  Mux6config__ConfigOut;
  wire  Mux6config__Config_Clock;
  wire  Mux6config__Config_Reset;
  wire [2:0] Mux6config__select;
  wire [0:0] Mux6config__stop;
  wire [0:0] Mux6config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux6config(
    .CGRA_Clock(Mux6config__CGRA_Clock),
    .CGRA_Enable(Mux6config__CGRA_Enable),
    .CGRA_Reset(Mux6config__CGRA_Reset),
    .ConfigIn(Mux6config__ConfigIn),
    .ConfigOut(Mux6config__ConfigOut),
    .Config_Clock(Mux6config__Config_Clock),
    .Config_Reset(Mux6config__Config_Reset),
    .select(Mux6config__select),
    .stop(Mux6config__stop),
    .valid(Mux6config__valid)
  );

  //Wire declarations for instance 'fork_crossbar0' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar0__CGRA_Clock;
  wire  fork_crossbar0__CGRA_Enable;
  wire  fork_crossbar0__CGRA_Reset;
  wire [6:0] fork_crossbar0__enable_downstream;
  wire [0:0] fork_crossbar0__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar0__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar0__in;
  wire [0:0] fork_crossbar0__in_stop_upstream;
  wire [0:0] fork_crossbar0__in_valid_upstream;
  wire [31:0] fork_crossbar0__out0;
  wire [0:0] fork_crossbar0__out0_stop_downstream;
  wire [0:0] fork_crossbar0__out0_valid_downstream;
  wire [31:0] fork_crossbar0__out1;
  wire [0:0] fork_crossbar0__out1_stop_downstream;
  wire [0:0] fork_crossbar0__out1_valid_downstream;
  wire [31:0] fork_crossbar0__out2;
  wire [0:0] fork_crossbar0__out2_stop_downstream;
  wire [0:0] fork_crossbar0__out2_valid_downstream;
  wire [31:0] fork_crossbar0__out3;
  wire [0:0] fork_crossbar0__out3_stop_downstream;
  wire [0:0] fork_crossbar0__out3_valid_downstream;
  wire [31:0] fork_crossbar0__out4;
  wire [0:0] fork_crossbar0__out4_stop_downstream;
  wire [0:0] fork_crossbar0__out4_valid_downstream;
  wire [31:0] fork_crossbar0__out5;
  wire [0:0] fork_crossbar0__out5_stop_downstream;
  wire [0:0] fork_crossbar0__out5_valid_downstream;
  wire [31:0] fork_crossbar0__out6;
  wire [0:0] fork_crossbar0__out6_stop_downstream;
  wire [0:0] fork_crossbar0__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar0(
    .CGRA_Clock(fork_crossbar0__CGRA_Clock),
    .CGRA_Enable(fork_crossbar0__CGRA_Enable),
    .CGRA_Reset(fork_crossbar0__CGRA_Reset),
    .enable_downstream(fork_crossbar0__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar0__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar0__enable_downstream_valid_upstream),
    .in(fork_crossbar0__in),
    .in_stop_upstream(fork_crossbar0__in_stop_upstream),
    .in_valid_upstream(fork_crossbar0__in_valid_upstream),
    .out0(fork_crossbar0__out0),
    .out0_stop_downstream(fork_crossbar0__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar0__out0_valid_downstream),
    .out1(fork_crossbar0__out1),
    .out1_stop_downstream(fork_crossbar0__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar0__out1_valid_downstream),
    .out2(fork_crossbar0__out2),
    .out2_stop_downstream(fork_crossbar0__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar0__out2_valid_downstream),
    .out3(fork_crossbar0__out3),
    .out3_stop_downstream(fork_crossbar0__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar0__out3_valid_downstream),
    .out4(fork_crossbar0__out4),
    .out4_stop_downstream(fork_crossbar0__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar0__out4_valid_downstream),
    .out5(fork_crossbar0__out5),
    .out5_stop_downstream(fork_crossbar0__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar0__out5_valid_downstream),
    .out6(fork_crossbar0__out6),
    .out6_stop_downstream(fork_crossbar0__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar0__out6_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar1' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar1__CGRA_Clock;
  wire  fork_crossbar1__CGRA_Enable;
  wire  fork_crossbar1__CGRA_Reset;
  wire [6:0] fork_crossbar1__enable_downstream;
  wire [0:0] fork_crossbar1__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar1__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar1__in;
  wire [0:0] fork_crossbar1__in_stop_upstream;
  wire [0:0] fork_crossbar1__in_valid_upstream;
  wire [31:0] fork_crossbar1__out0;
  wire [0:0] fork_crossbar1__out0_stop_downstream;
  wire [0:0] fork_crossbar1__out0_valid_downstream;
  wire [31:0] fork_crossbar1__out1;
  wire [0:0] fork_crossbar1__out1_stop_downstream;
  wire [0:0] fork_crossbar1__out1_valid_downstream;
  wire [31:0] fork_crossbar1__out2;
  wire [0:0] fork_crossbar1__out2_stop_downstream;
  wire [0:0] fork_crossbar1__out2_valid_downstream;
  wire [31:0] fork_crossbar1__out3;
  wire [0:0] fork_crossbar1__out3_stop_downstream;
  wire [0:0] fork_crossbar1__out3_valid_downstream;
  wire [31:0] fork_crossbar1__out4;
  wire [0:0] fork_crossbar1__out4_stop_downstream;
  wire [0:0] fork_crossbar1__out4_valid_downstream;
  wire [31:0] fork_crossbar1__out5;
  wire [0:0] fork_crossbar1__out5_stop_downstream;
  wire [0:0] fork_crossbar1__out5_valid_downstream;
  wire [31:0] fork_crossbar1__out6;
  wire [0:0] fork_crossbar1__out6_stop_downstream;
  wire [0:0] fork_crossbar1__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar1(
    .CGRA_Clock(fork_crossbar1__CGRA_Clock),
    .CGRA_Enable(fork_crossbar1__CGRA_Enable),
    .CGRA_Reset(fork_crossbar1__CGRA_Reset),
    .enable_downstream(fork_crossbar1__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar1__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar1__enable_downstream_valid_upstream),
    .in(fork_crossbar1__in),
    .in_stop_upstream(fork_crossbar1__in_stop_upstream),
    .in_valid_upstream(fork_crossbar1__in_valid_upstream),
    .out0(fork_crossbar1__out0),
    .out0_stop_downstream(fork_crossbar1__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar1__out0_valid_downstream),
    .out1(fork_crossbar1__out1),
    .out1_stop_downstream(fork_crossbar1__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar1__out1_valid_downstream),
    .out2(fork_crossbar1__out2),
    .out2_stop_downstream(fork_crossbar1__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar1__out2_valid_downstream),
    .out3(fork_crossbar1__out3),
    .out3_stop_downstream(fork_crossbar1__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar1__out3_valid_downstream),
    .out4(fork_crossbar1__out4),
    .out4_stop_downstream(fork_crossbar1__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar1__out4_valid_downstream),
    .out5(fork_crossbar1__out5),
    .out5_stop_downstream(fork_crossbar1__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar1__out5_valid_downstream),
    .out6(fork_crossbar1__out6),
    .out6_stop_downstream(fork_crossbar1__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar1__out6_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar2' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar2__CGRA_Clock;
  wire  fork_crossbar2__CGRA_Enable;
  wire  fork_crossbar2__CGRA_Reset;
  wire [6:0] fork_crossbar2__enable_downstream;
  wire [0:0] fork_crossbar2__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar2__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar2__in;
  wire [0:0] fork_crossbar2__in_stop_upstream;
  wire [0:0] fork_crossbar2__in_valid_upstream;
  wire [31:0] fork_crossbar2__out0;
  wire [0:0] fork_crossbar2__out0_stop_downstream;
  wire [0:0] fork_crossbar2__out0_valid_downstream;
  wire [31:0] fork_crossbar2__out1;
  wire [0:0] fork_crossbar2__out1_stop_downstream;
  wire [0:0] fork_crossbar2__out1_valid_downstream;
  wire [31:0] fork_crossbar2__out2;
  wire [0:0] fork_crossbar2__out2_stop_downstream;
  wire [0:0] fork_crossbar2__out2_valid_downstream;
  wire [31:0] fork_crossbar2__out3;
  wire [0:0] fork_crossbar2__out3_stop_downstream;
  wire [0:0] fork_crossbar2__out3_valid_downstream;
  wire [31:0] fork_crossbar2__out4;
  wire [0:0] fork_crossbar2__out4_stop_downstream;
  wire [0:0] fork_crossbar2__out4_valid_downstream;
  wire [31:0] fork_crossbar2__out5;
  wire [0:0] fork_crossbar2__out5_stop_downstream;
  wire [0:0] fork_crossbar2__out5_valid_downstream;
  wire [31:0] fork_crossbar2__out6;
  wire [0:0] fork_crossbar2__out6_stop_downstream;
  wire [0:0] fork_crossbar2__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar2(
    .CGRA_Clock(fork_crossbar2__CGRA_Clock),
    .CGRA_Enable(fork_crossbar2__CGRA_Enable),
    .CGRA_Reset(fork_crossbar2__CGRA_Reset),
    .enable_downstream(fork_crossbar2__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar2__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar2__enable_downstream_valid_upstream),
    .in(fork_crossbar2__in),
    .in_stop_upstream(fork_crossbar2__in_stop_upstream),
    .in_valid_upstream(fork_crossbar2__in_valid_upstream),
    .out0(fork_crossbar2__out0),
    .out0_stop_downstream(fork_crossbar2__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar2__out0_valid_downstream),
    .out1(fork_crossbar2__out1),
    .out1_stop_downstream(fork_crossbar2__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar2__out1_valid_downstream),
    .out2(fork_crossbar2__out2),
    .out2_stop_downstream(fork_crossbar2__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar2__out2_valid_downstream),
    .out3(fork_crossbar2__out3),
    .out3_stop_downstream(fork_crossbar2__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar2__out3_valid_downstream),
    .out4(fork_crossbar2__out4),
    .out4_stop_downstream(fork_crossbar2__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar2__out4_valid_downstream),
    .out5(fork_crossbar2__out5),
    .out5_stop_downstream(fork_crossbar2__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar2__out5_valid_downstream),
    .out6(fork_crossbar2__out6),
    .out6_stop_downstream(fork_crossbar2__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar2__out6_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar3' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar3__CGRA_Clock;
  wire  fork_crossbar3__CGRA_Enable;
  wire  fork_crossbar3__CGRA_Reset;
  wire [6:0] fork_crossbar3__enable_downstream;
  wire [0:0] fork_crossbar3__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar3__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar3__in;
  wire [0:0] fork_crossbar3__in_stop_upstream;
  wire [0:0] fork_crossbar3__in_valid_upstream;
  wire [31:0] fork_crossbar3__out0;
  wire [0:0] fork_crossbar3__out0_stop_downstream;
  wire [0:0] fork_crossbar3__out0_valid_downstream;
  wire [31:0] fork_crossbar3__out1;
  wire [0:0] fork_crossbar3__out1_stop_downstream;
  wire [0:0] fork_crossbar3__out1_valid_downstream;
  wire [31:0] fork_crossbar3__out2;
  wire [0:0] fork_crossbar3__out2_stop_downstream;
  wire [0:0] fork_crossbar3__out2_valid_downstream;
  wire [31:0] fork_crossbar3__out3;
  wire [0:0] fork_crossbar3__out3_stop_downstream;
  wire [0:0] fork_crossbar3__out3_valid_downstream;
  wire [31:0] fork_crossbar3__out4;
  wire [0:0] fork_crossbar3__out4_stop_downstream;
  wire [0:0] fork_crossbar3__out4_valid_downstream;
  wire [31:0] fork_crossbar3__out5;
  wire [0:0] fork_crossbar3__out5_stop_downstream;
  wire [0:0] fork_crossbar3__out5_valid_downstream;
  wire [31:0] fork_crossbar3__out6;
  wire [0:0] fork_crossbar3__out6_stop_downstream;
  wire [0:0] fork_crossbar3__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar3(
    .CGRA_Clock(fork_crossbar3__CGRA_Clock),
    .CGRA_Enable(fork_crossbar3__CGRA_Enable),
    .CGRA_Reset(fork_crossbar3__CGRA_Reset),
    .enable_downstream(fork_crossbar3__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar3__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar3__enable_downstream_valid_upstream),
    .in(fork_crossbar3__in),
    .in_stop_upstream(fork_crossbar3__in_stop_upstream),
    .in_valid_upstream(fork_crossbar3__in_valid_upstream),
    .out0(fork_crossbar3__out0),
    .out0_stop_downstream(fork_crossbar3__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar3__out0_valid_downstream),
    .out1(fork_crossbar3__out1),
    .out1_stop_downstream(fork_crossbar3__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar3__out1_valid_downstream),
    .out2(fork_crossbar3__out2),
    .out2_stop_downstream(fork_crossbar3__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar3__out2_valid_downstream),
    .out3(fork_crossbar3__out3),
    .out3_stop_downstream(fork_crossbar3__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar3__out3_valid_downstream),
    .out4(fork_crossbar3__out4),
    .out4_stop_downstream(fork_crossbar3__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar3__out4_valid_downstream),
    .out5(fork_crossbar3__out5),
    .out5_stop_downstream(fork_crossbar3__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar3__out5_valid_downstream),
    .out6(fork_crossbar3__out6),
    .out6_stop_downstream(fork_crossbar3__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar3__out6_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar4' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar4__CGRA_Clock;
  wire  fork_crossbar4__CGRA_Enable;
  wire  fork_crossbar4__CGRA_Reset;
  wire [6:0] fork_crossbar4__enable_downstream;
  wire [0:0] fork_crossbar4__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar4__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar4__in;
  wire [0:0] fork_crossbar4__in_stop_upstream;
  wire [0:0] fork_crossbar4__in_valid_upstream;
  wire [31:0] fork_crossbar4__out0;
  wire [0:0] fork_crossbar4__out0_stop_downstream;
  wire [0:0] fork_crossbar4__out0_valid_downstream;
  wire [31:0] fork_crossbar4__out1;
  wire [0:0] fork_crossbar4__out1_stop_downstream;
  wire [0:0] fork_crossbar4__out1_valid_downstream;
  wire [31:0] fork_crossbar4__out2;
  wire [0:0] fork_crossbar4__out2_stop_downstream;
  wire [0:0] fork_crossbar4__out2_valid_downstream;
  wire [31:0] fork_crossbar4__out3;
  wire [0:0] fork_crossbar4__out3_stop_downstream;
  wire [0:0] fork_crossbar4__out3_valid_downstream;
  wire [31:0] fork_crossbar4__out4;
  wire [0:0] fork_crossbar4__out4_stop_downstream;
  wire [0:0] fork_crossbar4__out4_valid_downstream;
  wire [31:0] fork_crossbar4__out5;
  wire [0:0] fork_crossbar4__out5_stop_downstream;
  wire [0:0] fork_crossbar4__out5_valid_downstream;
  wire [31:0] fork_crossbar4__out6;
  wire [0:0] fork_crossbar4__out6_stop_downstream;
  wire [0:0] fork_crossbar4__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar4(
    .CGRA_Clock(fork_crossbar4__CGRA_Clock),
    .CGRA_Enable(fork_crossbar4__CGRA_Enable),
    .CGRA_Reset(fork_crossbar4__CGRA_Reset),
    .enable_downstream(fork_crossbar4__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar4__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar4__enable_downstream_valid_upstream),
    .in(fork_crossbar4__in),
    .in_stop_upstream(fork_crossbar4__in_stop_upstream),
    .in_valid_upstream(fork_crossbar4__in_valid_upstream),
    .out0(fork_crossbar4__out0),
    .out0_stop_downstream(fork_crossbar4__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar4__out0_valid_downstream),
    .out1(fork_crossbar4__out1),
    .out1_stop_downstream(fork_crossbar4__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar4__out1_valid_downstream),
    .out2(fork_crossbar4__out2),
    .out2_stop_downstream(fork_crossbar4__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar4__out2_valid_downstream),
    .out3(fork_crossbar4__out3),
    .out3_stop_downstream(fork_crossbar4__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar4__out3_valid_downstream),
    .out4(fork_crossbar4__out4),
    .out4_stop_downstream(fork_crossbar4__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar4__out4_valid_downstream),
    .out5(fork_crossbar4__out5),
    .out5_stop_downstream(fork_crossbar4__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar4__out5_valid_downstream),
    .out6(fork_crossbar4__out6),
    .out6_stop_downstream(fork_crossbar4__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar4__out6_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar5' (Module cgrame_elastic_eager_fork_1to7_size_32)
  wire  fork_crossbar5__CGRA_Clock;
  wire  fork_crossbar5__CGRA_Enable;
  wire  fork_crossbar5__CGRA_Reset;
  wire [6:0] fork_crossbar5__enable_downstream;
  wire [0:0] fork_crossbar5__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar5__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar5__in;
  wire [0:0] fork_crossbar5__in_stop_upstream;
  wire [0:0] fork_crossbar5__in_valid_upstream;
  wire [31:0] fork_crossbar5__out0;
  wire [0:0] fork_crossbar5__out0_stop_downstream;
  wire [0:0] fork_crossbar5__out0_valid_downstream;
  wire [31:0] fork_crossbar5__out1;
  wire [0:0] fork_crossbar5__out1_stop_downstream;
  wire [0:0] fork_crossbar5__out1_valid_downstream;
  wire [31:0] fork_crossbar5__out2;
  wire [0:0] fork_crossbar5__out2_stop_downstream;
  wire [0:0] fork_crossbar5__out2_valid_downstream;
  wire [31:0] fork_crossbar5__out3;
  wire [0:0] fork_crossbar5__out3_stop_downstream;
  wire [0:0] fork_crossbar5__out3_valid_downstream;
  wire [31:0] fork_crossbar5__out4;
  wire [0:0] fork_crossbar5__out4_stop_downstream;
  wire [0:0] fork_crossbar5__out4_valid_downstream;
  wire [31:0] fork_crossbar5__out5;
  wire [0:0] fork_crossbar5__out5_stop_downstream;
  wire [0:0] fork_crossbar5__out5_valid_downstream;
  wire [31:0] fork_crossbar5__out6;
  wire [0:0] fork_crossbar5__out6_stop_downstream;
  wire [0:0] fork_crossbar5__out6_valid_downstream;
  cgrame_elastic_eager_fork_1to7_size_32 #(.contexts(1),.size(32)) fork_crossbar5(
    .CGRA_Clock(fork_crossbar5__CGRA_Clock),
    .CGRA_Enable(fork_crossbar5__CGRA_Enable),
    .CGRA_Reset(fork_crossbar5__CGRA_Reset),
    .enable_downstream(fork_crossbar5__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar5__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar5__enable_downstream_valid_upstream),
    .in(fork_crossbar5__in),
    .in_stop_upstream(fork_crossbar5__in_stop_upstream),
    .in_valid_upstream(fork_crossbar5__in_valid_upstream),
    .out0(fork_crossbar5__out0),
    .out0_stop_downstream(fork_crossbar5__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar5__out0_valid_downstream),
    .out1(fork_crossbar5__out1),
    .out1_stop_downstream(fork_crossbar5__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar5__out1_valid_downstream),
    .out2(fork_crossbar5__out2),
    .out2_stop_downstream(fork_crossbar5__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar5__out2_valid_downstream),
    .out3(fork_crossbar5__out3),
    .out3_stop_downstream(fork_crossbar5__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar5__out3_valid_downstream),
    .out4(fork_crossbar5__out4),
    .out4_stop_downstream(fork_crossbar5__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar5__out4_valid_downstream),
    .out5(fork_crossbar5__out5),
    .out5_stop_downstream(fork_crossbar5__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar5__out5_valid_downstream),
    .out6(fork_crossbar5__out6),
    .out6_stop_downstream(fork_crossbar5__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar5__out6_valid_downstream)
  );

  //Wire declarations for instance 'mux_0' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_0__in0;
  wire [0:0] mux_0__in0_stop_upstream;
  wire [0:0] mux_0__in0_valid_upstream;
  wire [31:0] mux_0__in1;
  wire [0:0] mux_0__in1_stop_upstream;
  wire [0:0] mux_0__in1_valid_upstream;
  wire [31:0] mux_0__in2;
  wire [0:0] mux_0__in2_stop_upstream;
  wire [0:0] mux_0__in2_valid_upstream;
  wire [31:0] mux_0__in3;
  wire [0:0] mux_0__in3_stop_upstream;
  wire [0:0] mux_0__in3_valid_upstream;
  wire [31:0] mux_0__in4;
  wire [0:0] mux_0__in4_stop_upstream;
  wire [0:0] mux_0__in4_valid_upstream;
  wire [31:0] mux_0__in5;
  wire [0:0] mux_0__in5_stop_upstream;
  wire [0:0] mux_0__in5_valid_upstream;
  wire [31:0] mux_0__out;
  wire [0:0] mux_0__out_stop_downstream;
  wire [0:0] mux_0__out_valid_downstream;
  wire [2:0] mux_0__select;
  wire [0:0] mux_0__select_stop_upstream;
  wire [0:0] mux_0__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_0(
    .in0(mux_0__in0),
    .in0_stop_upstream(mux_0__in0_stop_upstream),
    .in0_valid_upstream(mux_0__in0_valid_upstream),
    .in1(mux_0__in1),
    .in1_stop_upstream(mux_0__in1_stop_upstream),
    .in1_valid_upstream(mux_0__in1_valid_upstream),
    .in2(mux_0__in2),
    .in2_stop_upstream(mux_0__in2_stop_upstream),
    .in2_valid_upstream(mux_0__in2_valid_upstream),
    .in3(mux_0__in3),
    .in3_stop_upstream(mux_0__in3_stop_upstream),
    .in3_valid_upstream(mux_0__in3_valid_upstream),
    .in4(mux_0__in4),
    .in4_stop_upstream(mux_0__in4_stop_upstream),
    .in4_valid_upstream(mux_0__in4_valid_upstream),
    .in5(mux_0__in5),
    .in5_stop_upstream(mux_0__in5_stop_upstream),
    .in5_valid_upstream(mux_0__in5_valid_upstream),
    .out(mux_0__out),
    .out_stop_downstream(mux_0__out_stop_downstream),
    .out_valid_downstream(mux_0__out_valid_downstream),
    .select(mux_0__select),
    .select_stop_upstream(mux_0__select_stop_upstream),
    .select_valid_upstream(mux_0__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_1' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_1__in0;
  wire [0:0] mux_1__in0_stop_upstream;
  wire [0:0] mux_1__in0_valid_upstream;
  wire [31:0] mux_1__in1;
  wire [0:0] mux_1__in1_stop_upstream;
  wire [0:0] mux_1__in1_valid_upstream;
  wire [31:0] mux_1__in2;
  wire [0:0] mux_1__in2_stop_upstream;
  wire [0:0] mux_1__in2_valid_upstream;
  wire [31:0] mux_1__in3;
  wire [0:0] mux_1__in3_stop_upstream;
  wire [0:0] mux_1__in3_valid_upstream;
  wire [31:0] mux_1__in4;
  wire [0:0] mux_1__in4_stop_upstream;
  wire [0:0] mux_1__in4_valid_upstream;
  wire [31:0] mux_1__in5;
  wire [0:0] mux_1__in5_stop_upstream;
  wire [0:0] mux_1__in5_valid_upstream;
  wire [31:0] mux_1__out;
  wire [0:0] mux_1__out_stop_downstream;
  wire [0:0] mux_1__out_valid_downstream;
  wire [2:0] mux_1__select;
  wire [0:0] mux_1__select_stop_upstream;
  wire [0:0] mux_1__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_1(
    .in0(mux_1__in0),
    .in0_stop_upstream(mux_1__in0_stop_upstream),
    .in0_valid_upstream(mux_1__in0_valid_upstream),
    .in1(mux_1__in1),
    .in1_stop_upstream(mux_1__in1_stop_upstream),
    .in1_valid_upstream(mux_1__in1_valid_upstream),
    .in2(mux_1__in2),
    .in2_stop_upstream(mux_1__in2_stop_upstream),
    .in2_valid_upstream(mux_1__in2_valid_upstream),
    .in3(mux_1__in3),
    .in3_stop_upstream(mux_1__in3_stop_upstream),
    .in3_valid_upstream(mux_1__in3_valid_upstream),
    .in4(mux_1__in4),
    .in4_stop_upstream(mux_1__in4_stop_upstream),
    .in4_valid_upstream(mux_1__in4_valid_upstream),
    .in5(mux_1__in5),
    .in5_stop_upstream(mux_1__in5_stop_upstream),
    .in5_valid_upstream(mux_1__in5_valid_upstream),
    .out(mux_1__out),
    .out_stop_downstream(mux_1__out_stop_downstream),
    .out_valid_downstream(mux_1__out_valid_downstream),
    .select(mux_1__select),
    .select_stop_upstream(mux_1__select_stop_upstream),
    .select_valid_upstream(mux_1__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_2' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_2__in0;
  wire [0:0] mux_2__in0_stop_upstream;
  wire [0:0] mux_2__in0_valid_upstream;
  wire [31:0] mux_2__in1;
  wire [0:0] mux_2__in1_stop_upstream;
  wire [0:0] mux_2__in1_valid_upstream;
  wire [31:0] mux_2__in2;
  wire [0:0] mux_2__in2_stop_upstream;
  wire [0:0] mux_2__in2_valid_upstream;
  wire [31:0] mux_2__in3;
  wire [0:0] mux_2__in3_stop_upstream;
  wire [0:0] mux_2__in3_valid_upstream;
  wire [31:0] mux_2__in4;
  wire [0:0] mux_2__in4_stop_upstream;
  wire [0:0] mux_2__in4_valid_upstream;
  wire [31:0] mux_2__in5;
  wire [0:0] mux_2__in5_stop_upstream;
  wire [0:0] mux_2__in5_valid_upstream;
  wire [31:0] mux_2__out;
  wire [0:0] mux_2__out_stop_downstream;
  wire [0:0] mux_2__out_valid_downstream;
  wire [2:0] mux_2__select;
  wire [0:0] mux_2__select_stop_upstream;
  wire [0:0] mux_2__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_2(
    .in0(mux_2__in0),
    .in0_stop_upstream(mux_2__in0_stop_upstream),
    .in0_valid_upstream(mux_2__in0_valid_upstream),
    .in1(mux_2__in1),
    .in1_stop_upstream(mux_2__in1_stop_upstream),
    .in1_valid_upstream(mux_2__in1_valid_upstream),
    .in2(mux_2__in2),
    .in2_stop_upstream(mux_2__in2_stop_upstream),
    .in2_valid_upstream(mux_2__in2_valid_upstream),
    .in3(mux_2__in3),
    .in3_stop_upstream(mux_2__in3_stop_upstream),
    .in3_valid_upstream(mux_2__in3_valid_upstream),
    .in4(mux_2__in4),
    .in4_stop_upstream(mux_2__in4_stop_upstream),
    .in4_valid_upstream(mux_2__in4_valid_upstream),
    .in5(mux_2__in5),
    .in5_stop_upstream(mux_2__in5_stop_upstream),
    .in5_valid_upstream(mux_2__in5_valid_upstream),
    .out(mux_2__out),
    .out_stop_downstream(mux_2__out_stop_downstream),
    .out_valid_downstream(mux_2__out_valid_downstream),
    .select(mux_2__select),
    .select_stop_upstream(mux_2__select_stop_upstream),
    .select_valid_upstream(mux_2__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_3' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_3__in0;
  wire [0:0] mux_3__in0_stop_upstream;
  wire [0:0] mux_3__in0_valid_upstream;
  wire [31:0] mux_3__in1;
  wire [0:0] mux_3__in1_stop_upstream;
  wire [0:0] mux_3__in1_valid_upstream;
  wire [31:0] mux_3__in2;
  wire [0:0] mux_3__in2_stop_upstream;
  wire [0:0] mux_3__in2_valid_upstream;
  wire [31:0] mux_3__in3;
  wire [0:0] mux_3__in3_stop_upstream;
  wire [0:0] mux_3__in3_valid_upstream;
  wire [31:0] mux_3__in4;
  wire [0:0] mux_3__in4_stop_upstream;
  wire [0:0] mux_3__in4_valid_upstream;
  wire [31:0] mux_3__in5;
  wire [0:0] mux_3__in5_stop_upstream;
  wire [0:0] mux_3__in5_valid_upstream;
  wire [31:0] mux_3__out;
  wire [0:0] mux_3__out_stop_downstream;
  wire [0:0] mux_3__out_valid_downstream;
  wire [2:0] mux_3__select;
  wire [0:0] mux_3__select_stop_upstream;
  wire [0:0] mux_3__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_3(
    .in0(mux_3__in0),
    .in0_stop_upstream(mux_3__in0_stop_upstream),
    .in0_valid_upstream(mux_3__in0_valid_upstream),
    .in1(mux_3__in1),
    .in1_stop_upstream(mux_3__in1_stop_upstream),
    .in1_valid_upstream(mux_3__in1_valid_upstream),
    .in2(mux_3__in2),
    .in2_stop_upstream(mux_3__in2_stop_upstream),
    .in2_valid_upstream(mux_3__in2_valid_upstream),
    .in3(mux_3__in3),
    .in3_stop_upstream(mux_3__in3_stop_upstream),
    .in3_valid_upstream(mux_3__in3_valid_upstream),
    .in4(mux_3__in4),
    .in4_stop_upstream(mux_3__in4_stop_upstream),
    .in4_valid_upstream(mux_3__in4_valid_upstream),
    .in5(mux_3__in5),
    .in5_stop_upstream(mux_3__in5_stop_upstream),
    .in5_valid_upstream(mux_3__in5_valid_upstream),
    .out(mux_3__out),
    .out_stop_downstream(mux_3__out_stop_downstream),
    .out_valid_downstream(mux_3__out_valid_downstream),
    .select(mux_3__select),
    .select_stop_upstream(mux_3__select_stop_upstream),
    .select_valid_upstream(mux_3__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_4' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_4__in0;
  wire [0:0] mux_4__in0_stop_upstream;
  wire [0:0] mux_4__in0_valid_upstream;
  wire [31:0] mux_4__in1;
  wire [0:0] mux_4__in1_stop_upstream;
  wire [0:0] mux_4__in1_valid_upstream;
  wire [31:0] mux_4__in2;
  wire [0:0] mux_4__in2_stop_upstream;
  wire [0:0] mux_4__in2_valid_upstream;
  wire [31:0] mux_4__in3;
  wire [0:0] mux_4__in3_stop_upstream;
  wire [0:0] mux_4__in3_valid_upstream;
  wire [31:0] mux_4__in4;
  wire [0:0] mux_4__in4_stop_upstream;
  wire [0:0] mux_4__in4_valid_upstream;
  wire [31:0] mux_4__in5;
  wire [0:0] mux_4__in5_stop_upstream;
  wire [0:0] mux_4__in5_valid_upstream;
  wire [31:0] mux_4__out;
  wire [0:0] mux_4__out_stop_downstream;
  wire [0:0] mux_4__out_valid_downstream;
  wire [2:0] mux_4__select;
  wire [0:0] mux_4__select_stop_upstream;
  wire [0:0] mux_4__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_4(
    .in0(mux_4__in0),
    .in0_stop_upstream(mux_4__in0_stop_upstream),
    .in0_valid_upstream(mux_4__in0_valid_upstream),
    .in1(mux_4__in1),
    .in1_stop_upstream(mux_4__in1_stop_upstream),
    .in1_valid_upstream(mux_4__in1_valid_upstream),
    .in2(mux_4__in2),
    .in2_stop_upstream(mux_4__in2_stop_upstream),
    .in2_valid_upstream(mux_4__in2_valid_upstream),
    .in3(mux_4__in3),
    .in3_stop_upstream(mux_4__in3_stop_upstream),
    .in3_valid_upstream(mux_4__in3_valid_upstream),
    .in4(mux_4__in4),
    .in4_stop_upstream(mux_4__in4_stop_upstream),
    .in4_valid_upstream(mux_4__in4_valid_upstream),
    .in5(mux_4__in5),
    .in5_stop_upstream(mux_4__in5_stop_upstream),
    .in5_valid_upstream(mux_4__in5_valid_upstream),
    .out(mux_4__out),
    .out_stop_downstream(mux_4__out_stop_downstream),
    .out_valid_downstream(mux_4__out_valid_downstream),
    .select(mux_4__select),
    .select_stop_upstream(mux_4__select_stop_upstream),
    .select_valid_upstream(mux_4__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_5' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_5__in0;
  wire [0:0] mux_5__in0_stop_upstream;
  wire [0:0] mux_5__in0_valid_upstream;
  wire [31:0] mux_5__in1;
  wire [0:0] mux_5__in1_stop_upstream;
  wire [0:0] mux_5__in1_valid_upstream;
  wire [31:0] mux_5__in2;
  wire [0:0] mux_5__in2_stop_upstream;
  wire [0:0] mux_5__in2_valid_upstream;
  wire [31:0] mux_5__in3;
  wire [0:0] mux_5__in3_stop_upstream;
  wire [0:0] mux_5__in3_valid_upstream;
  wire [31:0] mux_5__in4;
  wire [0:0] mux_5__in4_stop_upstream;
  wire [0:0] mux_5__in4_valid_upstream;
  wire [31:0] mux_5__in5;
  wire [0:0] mux_5__in5_stop_upstream;
  wire [0:0] mux_5__in5_valid_upstream;
  wire [31:0] mux_5__out;
  wire [0:0] mux_5__out_stop_downstream;
  wire [0:0] mux_5__out_valid_downstream;
  wire [2:0] mux_5__select;
  wire [0:0] mux_5__select_stop_upstream;
  wire [0:0] mux_5__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_5(
    .in0(mux_5__in0),
    .in0_stop_upstream(mux_5__in0_stop_upstream),
    .in0_valid_upstream(mux_5__in0_valid_upstream),
    .in1(mux_5__in1),
    .in1_stop_upstream(mux_5__in1_stop_upstream),
    .in1_valid_upstream(mux_5__in1_valid_upstream),
    .in2(mux_5__in2),
    .in2_stop_upstream(mux_5__in2_stop_upstream),
    .in2_valid_upstream(mux_5__in2_valid_upstream),
    .in3(mux_5__in3),
    .in3_stop_upstream(mux_5__in3_stop_upstream),
    .in3_valid_upstream(mux_5__in3_valid_upstream),
    .in4(mux_5__in4),
    .in4_stop_upstream(mux_5__in4_stop_upstream),
    .in4_valid_upstream(mux_5__in4_valid_upstream),
    .in5(mux_5__in5),
    .in5_stop_upstream(mux_5__in5_stop_upstream),
    .in5_valid_upstream(mux_5__in5_valid_upstream),
    .out(mux_5__out),
    .out_stop_downstream(mux_5__out_stop_downstream),
    .out_valid_downstream(mux_5__out_valid_downstream),
    .select(mux_5__select),
    .select_stop_upstream(mux_5__select_stop_upstream),
    .select_valid_upstream(mux_5__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_6' (Module cgrame_elastic_mux_6to1_32b)
  wire [31:0] mux_6__in0;
  wire [0:0] mux_6__in0_stop_upstream;
  wire [0:0] mux_6__in0_valid_upstream;
  wire [31:0] mux_6__in1;
  wire [0:0] mux_6__in1_stop_upstream;
  wire [0:0] mux_6__in1_valid_upstream;
  wire [31:0] mux_6__in2;
  wire [0:0] mux_6__in2_stop_upstream;
  wire [0:0] mux_6__in2_valid_upstream;
  wire [31:0] mux_6__in3;
  wire [0:0] mux_6__in3_stop_upstream;
  wire [0:0] mux_6__in3_valid_upstream;
  wire [31:0] mux_6__in4;
  wire [0:0] mux_6__in4_stop_upstream;
  wire [0:0] mux_6__in4_valid_upstream;
  wire [31:0] mux_6__in5;
  wire [0:0] mux_6__in5_stop_upstream;
  wire [0:0] mux_6__in5_valid_upstream;
  wire [31:0] mux_6__out;
  wire [0:0] mux_6__out_stop_downstream;
  wire [0:0] mux_6__out_valid_downstream;
  wire [2:0] mux_6__select;
  wire [0:0] mux_6__select_stop_upstream;
  wire [0:0] mux_6__select_valid_upstream;
  cgrame_elastic_mux_6to1_32b #(.contexts(1),.size(32)) mux_6(
    .in0(mux_6__in0),
    .in0_stop_upstream(mux_6__in0_stop_upstream),
    .in0_valid_upstream(mux_6__in0_valid_upstream),
    .in1(mux_6__in1),
    .in1_stop_upstream(mux_6__in1_stop_upstream),
    .in1_valid_upstream(mux_6__in1_valid_upstream),
    .in2(mux_6__in2),
    .in2_stop_upstream(mux_6__in2_stop_upstream),
    .in2_valid_upstream(mux_6__in2_valid_upstream),
    .in3(mux_6__in3),
    .in3_stop_upstream(mux_6__in3_stop_upstream),
    .in3_valid_upstream(mux_6__in3_valid_upstream),
    .in4(mux_6__in4),
    .in4_stop_upstream(mux_6__in4_stop_upstream),
    .in4_valid_upstream(mux_6__in4_valid_upstream),
    .in5(mux_6__in5),
    .in5_stop_upstream(mux_6__in5_stop_upstream),
    .in5_valid_upstream(mux_6__in5_valid_upstream),
    .out(mux_6__out),
    .out_stop_downstream(mux_6__out_stop_downstream),
    .out_valid_downstream(mux_6__out_valid_downstream),
    .select(mux_6__select),
    .select_stop_upstream(mux_6__select_stop_upstream),
    .select_valid_upstream(mux_6__select_valid_upstream)
  );

  //All the connections
  assign fork_crossbar0__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar1__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar2__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar3__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar4__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar5__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar0Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar1Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar2Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar3Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar4Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar5Config__CGRA_Clock = CGRA_Clock;
  assign Mux0config__CGRA_Clock = CGRA_Clock;
  assign Mux1config__CGRA_Clock = CGRA_Clock;
  assign Mux2config__CGRA_Clock = CGRA_Clock;
  assign Mux3config__CGRA_Clock = CGRA_Clock;
  assign Mux4config__CGRA_Clock = CGRA_Clock;
  assign Mux5config__CGRA_Clock = CGRA_Clock;
  assign Mux6config__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar0__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar1__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar2__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar3__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar4__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar5__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar0Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar1Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar2Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar3Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar4Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar5Config__CGRA_Reset = CGRA_Reset;
  assign Mux0config__CGRA_Reset = CGRA_Reset;
  assign Mux1config__CGRA_Reset = CGRA_Reset;
  assign Mux2config__CGRA_Reset = CGRA_Reset;
  assign Mux3config__CGRA_Reset = CGRA_Reset;
  assign Mux4config__CGRA_Reset = CGRA_Reset;
  assign Mux5config__CGRA_Reset = CGRA_Reset;
  assign Mux6config__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar0__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar1__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar2__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar3__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar4__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar5__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar1Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar2Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar3Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar4Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar5Config__CGRA_Enable = CGRA_Enable;
  assign Mux0config__CGRA_Enable = CGRA_Enable;
  assign Mux1config__CGRA_Enable = CGRA_Enable;
  assign Mux2config__CGRA_Enable = CGRA_Enable;
  assign Mux3config__CGRA_Enable = CGRA_Enable;
  assign Mux4config__CGRA_Enable = CGRA_Enable;
  assign Mux5config__CGRA_Enable = CGRA_Enable;
  assign Mux6config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__Config_Clock = Config_Clock;
  assign ForkCrossbar1Config__Config_Clock = Config_Clock;
  assign ForkCrossbar2Config__Config_Clock = Config_Clock;
  assign ForkCrossbar3Config__Config_Clock = Config_Clock;
  assign ForkCrossbar4Config__Config_Clock = Config_Clock;
  assign ForkCrossbar5Config__Config_Clock = Config_Clock;
  assign Mux0config__Config_Clock = Config_Clock;
  assign Mux1config__Config_Clock = Config_Clock;
  assign Mux2config__Config_Clock = Config_Clock;
  assign Mux3config__Config_Clock = Config_Clock;
  assign Mux4config__Config_Clock = Config_Clock;
  assign Mux5config__Config_Clock = Config_Clock;
  assign Mux6config__Config_Clock = Config_Clock;
  assign ForkCrossbar0Config__Config_Reset = Config_Reset;
  assign ForkCrossbar1Config__Config_Reset = Config_Reset;
  assign ForkCrossbar2Config__Config_Reset = Config_Reset;
  assign ForkCrossbar3Config__Config_Reset = Config_Reset;
  assign ForkCrossbar4Config__Config_Reset = Config_Reset;
  assign ForkCrossbar5Config__Config_Reset = Config_Reset;
  assign Mux0config__Config_Reset = Config_Reset;
  assign Mux1config__Config_Reset = Config_Reset;
  assign Mux2config__Config_Reset = Config_Reset;
  assign Mux3config__Config_Reset = Config_Reset;
  assign Mux4config__Config_Reset = Config_Reset;
  assign Mux5config__Config_Reset = Config_Reset;
  assign Mux6config__Config_Reset = Config_Reset;
  assign fork_crossbar5__out0_stop_downstream[0:0] = mux_0__in5_stop_upstream[0:0];
  assign fork_crossbar1__out0_stop_downstream[0:0] = mux_0__in1_stop_upstream[0:0];
  assign fork_crossbar4__out0_stop_downstream[0:0] = mux_0__in4_stop_upstream[0:0];
  assign fork_crossbar2__out0_stop_downstream[0:0] = mux_0__in2_stop_upstream[0:0];
  assign out0[31:0] = mux_0__out[31:0];
  assign out0_valid_downstream[0:0] = mux_0__out_valid_downstream[0:0];
  assign fork_crossbar3__out0_stop_downstream[0:0] = mux_0__in3_stop_upstream[0:0];
  assign fork_crossbar0__out0_stop_downstream[0:0] = mux_0__in0_stop_upstream[0:0];
  assign fork_crossbar0__out1_stop_downstream[0:0] = mux_1__in0_stop_upstream[0:0];
  assign fork_crossbar1__out1_stop_downstream[0:0] = mux_1__in1_stop_upstream[0:0];
  assign fork_crossbar2__out1_stop_downstream[0:0] = mux_1__in2_stop_upstream[0:0];
  assign fork_crossbar3__out1_stop_downstream[0:0] = mux_1__in3_stop_upstream[0:0];
  assign fork_crossbar4__out1_stop_downstream[0:0] = mux_1__in4_stop_upstream[0:0];
  assign fork_crossbar5__out1_stop_downstream[0:0] = mux_1__in5_stop_upstream[0:0];
  assign out1[31:0] = mux_1__out[31:0];
  assign out1_valid_downstream[0:0] = mux_1__out_valid_downstream[0:0];
  assign fork_crossbar0__out2_stop_downstream[0:0] = mux_2__in0_stop_upstream[0:0];
  assign fork_crossbar1__out2_stop_downstream[0:0] = mux_2__in1_stop_upstream[0:0];
  assign fork_crossbar2__out2_stop_downstream[0:0] = mux_2__in2_stop_upstream[0:0];
  assign fork_crossbar3__out2_stop_downstream[0:0] = mux_2__in3_stop_upstream[0:0];
  assign fork_crossbar4__out2_stop_downstream[0:0] = mux_2__in4_stop_upstream[0:0];
  assign fork_crossbar5__out2_stop_downstream[0:0] = mux_2__in5_stop_upstream[0:0];
  assign out2[31:0] = mux_2__out[31:0];
  assign out2_valid_downstream[0:0] = mux_2__out_valid_downstream[0:0];
  assign fork_crossbar0__out3_stop_downstream[0:0] = mux_3__in0_stop_upstream[0:0];
  assign fork_crossbar1__out3_stop_downstream[0:0] = mux_3__in1_stop_upstream[0:0];
  assign fork_crossbar2__out3_stop_downstream[0:0] = mux_3__in2_stop_upstream[0:0];
  assign fork_crossbar3__out3_stop_downstream[0:0] = mux_3__in3_stop_upstream[0:0];
  assign fork_crossbar4__out3_stop_downstream[0:0] = mux_3__in4_stop_upstream[0:0];
  assign fork_crossbar5__out3_stop_downstream[0:0] = mux_3__in5_stop_upstream[0:0];
  assign out3[31:0] = mux_3__out[31:0];
  assign out3_valid_downstream[0:0] = mux_3__out_valid_downstream[0:0];
  assign fork_crossbar0__out4_stop_downstream[0:0] = mux_4__in0_stop_upstream[0:0];
  assign fork_crossbar1__out4_stop_downstream[0:0] = mux_4__in1_stop_upstream[0:0];
  assign fork_crossbar2__out4_stop_downstream[0:0] = mux_4__in2_stop_upstream[0:0];
  assign fork_crossbar3__out4_stop_downstream[0:0] = mux_4__in3_stop_upstream[0:0];
  assign fork_crossbar4__out4_stop_downstream[0:0] = mux_4__in4_stop_upstream[0:0];
  assign fork_crossbar5__out4_stop_downstream[0:0] = mux_4__in5_stop_upstream[0:0];
  assign out4[31:0] = mux_4__out[31:0];
  assign out4_valid_downstream[0:0] = mux_4__out_valid_downstream[0:0];
  assign fork_crossbar0__out5_stop_downstream[0:0] = mux_5__in0_stop_upstream[0:0];
  assign fork_crossbar1__out5_stop_downstream[0:0] = mux_5__in1_stop_upstream[0:0];
  assign fork_crossbar2__out5_stop_downstream[0:0] = mux_5__in2_stop_upstream[0:0];
  assign fork_crossbar3__out5_stop_downstream[0:0] = mux_5__in3_stop_upstream[0:0];
  assign fork_crossbar4__out5_stop_downstream[0:0] = mux_5__in4_stop_upstream[0:0];
  assign fork_crossbar5__out5_stop_downstream[0:0] = mux_5__in5_stop_upstream[0:0];
  assign out5[31:0] = mux_5__out[31:0];
  assign out5_valid_downstream[0:0] = mux_5__out_valid_downstream[0:0];
  assign fork_crossbar0__out6_stop_downstream[0:0] = mux_6__in0_stop_upstream[0:0];
  assign fork_crossbar1__out6_stop_downstream[0:0] = mux_6__in1_stop_upstream[0:0];
  assign fork_crossbar2__out6_stop_downstream[0:0] = mux_6__in2_stop_upstream[0:0];
  assign fork_crossbar3__out6_stop_downstream[0:0] = mux_6__in3_stop_upstream[0:0];
  assign fork_crossbar4__out6_stop_downstream[0:0] = mux_6__in4_stop_upstream[0:0];
  assign fork_crossbar5__out6_stop_downstream[0:0] = mux_6__in5_stop_upstream[0:0];
  assign out6[31:0] = mux_6__out[31:0];
  assign out6_valid_downstream[0:0] = mux_6__out_valid_downstream[0:0];
  assign fork_crossbar0__in[31:0] = in0[31:0];
  assign fork_crossbar0__in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign in0_stop_upstream[0:0] = fork_crossbar0__in_stop_upstream[0:0];
  assign mux_0__in0[31:0] = fork_crossbar0__out0[31:0];
  assign mux_0__in0_valid_upstream[0:0] = fork_crossbar0__out0_valid_downstream[0:0];
  assign mux_1__in0[31:0] = fork_crossbar0__out1[31:0];
  assign mux_1__in0_valid_upstream[0:0] = fork_crossbar0__out1_valid_downstream[0:0];
  assign mux_2__in0[31:0] = fork_crossbar0__out2[31:0];
  assign mux_2__in0_valid_upstream[0:0] = fork_crossbar0__out2_valid_downstream[0:0];
  assign mux_3__in0[31:0] = fork_crossbar0__out3[31:0];
  assign mux_3__in0_valid_upstream[0:0] = fork_crossbar0__out3_valid_downstream[0:0];
  assign mux_4__in0[31:0] = fork_crossbar0__out4[31:0];
  assign mux_4__in0_valid_upstream[0:0] = fork_crossbar0__out4_valid_downstream[0:0];
  assign mux_5__in0[31:0] = fork_crossbar0__out5[31:0];
  assign mux_5__in0_valid_upstream[0:0] = fork_crossbar0__out5_valid_downstream[0:0];
  assign mux_6__in0[31:0] = fork_crossbar0__out6[31:0];
  assign mux_6__in0_valid_upstream[0:0] = fork_crossbar0__out6_valid_downstream[0:0];
  assign fork_crossbar1__in[31:0] = in1[31:0];
  assign fork_crossbar1__in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign in1_stop_upstream[0:0] = fork_crossbar1__in_stop_upstream[0:0];
  assign mux_0__in1[31:0] = fork_crossbar1__out0[31:0];
  assign mux_0__in1_valid_upstream[0:0] = fork_crossbar1__out0_valid_downstream[0:0];
  assign mux_1__in1[31:0] = fork_crossbar1__out1[31:0];
  assign mux_1__in1_valid_upstream[0:0] = fork_crossbar1__out1_valid_downstream[0:0];
  assign mux_2__in1[31:0] = fork_crossbar1__out2[31:0];
  assign mux_2__in1_valid_upstream[0:0] = fork_crossbar1__out2_valid_downstream[0:0];
  assign mux_3__in1[31:0] = fork_crossbar1__out3[31:0];
  assign mux_3__in1_valid_upstream[0:0] = fork_crossbar1__out3_valid_downstream[0:0];
  assign mux_4__in1[31:0] = fork_crossbar1__out4[31:0];
  assign mux_4__in1_valid_upstream[0:0] = fork_crossbar1__out4_valid_downstream[0:0];
  assign mux_5__in1[31:0] = fork_crossbar1__out5[31:0];
  assign mux_5__in1_valid_upstream[0:0] = fork_crossbar1__out5_valid_downstream[0:0];
  assign mux_6__in1[31:0] = fork_crossbar1__out6[31:0];
  assign mux_6__in1_valid_upstream[0:0] = fork_crossbar1__out6_valid_downstream[0:0];
  assign fork_crossbar2__in[31:0] = in2[31:0];
  assign fork_crossbar2__in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign in2_stop_upstream[0:0] = fork_crossbar2__in_stop_upstream[0:0];
  assign mux_0__in2[31:0] = fork_crossbar2__out0[31:0];
  assign mux_0__in2_valid_upstream[0:0] = fork_crossbar2__out0_valid_downstream[0:0];
  assign mux_1__in2[31:0] = fork_crossbar2__out1[31:0];
  assign mux_1__in2_valid_upstream[0:0] = fork_crossbar2__out1_valid_downstream[0:0];
  assign mux_2__in2[31:0] = fork_crossbar2__out2[31:0];
  assign mux_2__in2_valid_upstream[0:0] = fork_crossbar2__out2_valid_downstream[0:0];
  assign mux_3__in2[31:0] = fork_crossbar2__out3[31:0];
  assign mux_3__in2_valid_upstream[0:0] = fork_crossbar2__out3_valid_downstream[0:0];
  assign mux_4__in2[31:0] = fork_crossbar2__out4[31:0];
  assign mux_4__in2_valid_upstream[0:0] = fork_crossbar2__out4_valid_downstream[0:0];
  assign mux_5__in2[31:0] = fork_crossbar2__out5[31:0];
  assign mux_5__in2_valid_upstream[0:0] = fork_crossbar2__out5_valid_downstream[0:0];
  assign mux_6__in2[31:0] = fork_crossbar2__out6[31:0];
  assign mux_6__in2_valid_upstream[0:0] = fork_crossbar2__out6_valid_downstream[0:0];
  assign fork_crossbar3__in[31:0] = in3[31:0];
  assign fork_crossbar3__in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign in3_stop_upstream[0:0] = fork_crossbar3__in_stop_upstream[0:0];
  assign mux_0__in3[31:0] = fork_crossbar3__out0[31:0];
  assign mux_0__in3_valid_upstream[0:0] = fork_crossbar3__out0_valid_downstream[0:0];
  assign mux_1__in3[31:0] = fork_crossbar3__out1[31:0];
  assign mux_1__in3_valid_upstream[0:0] = fork_crossbar3__out1_valid_downstream[0:0];
  assign mux_2__in3[31:0] = fork_crossbar3__out2[31:0];
  assign mux_2__in3_valid_upstream[0:0] = fork_crossbar3__out2_valid_downstream[0:0];
  assign mux_3__in3[31:0] = fork_crossbar3__out3[31:0];
  assign mux_3__in3_valid_upstream[0:0] = fork_crossbar3__out3_valid_downstream[0:0];
  assign mux_4__in3[31:0] = fork_crossbar3__out4[31:0];
  assign mux_4__in3_valid_upstream[0:0] = fork_crossbar3__out4_valid_downstream[0:0];
  assign mux_5__in3[31:0] = fork_crossbar3__out5[31:0];
  assign mux_5__in3_valid_upstream[0:0] = fork_crossbar3__out5_valid_downstream[0:0];
  assign mux_6__in3[31:0] = fork_crossbar3__out6[31:0];
  assign mux_6__in3_valid_upstream[0:0] = fork_crossbar3__out6_valid_downstream[0:0];
  assign fork_crossbar4__in[31:0] = in4[31:0];
  assign fork_crossbar4__in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign in4_stop_upstream[0:0] = fork_crossbar4__in_stop_upstream[0:0];
  assign mux_0__in4[31:0] = fork_crossbar4__out0[31:0];
  assign mux_0__in4_valid_upstream[0:0] = fork_crossbar4__out0_valid_downstream[0:0];
  assign mux_1__in4[31:0] = fork_crossbar4__out1[31:0];
  assign mux_1__in4_valid_upstream[0:0] = fork_crossbar4__out1_valid_downstream[0:0];
  assign mux_2__in4[31:0] = fork_crossbar4__out2[31:0];
  assign mux_2__in4_valid_upstream[0:0] = fork_crossbar4__out2_valid_downstream[0:0];
  assign mux_3__in4[31:0] = fork_crossbar4__out3[31:0];
  assign mux_3__in4_valid_upstream[0:0] = fork_crossbar4__out3_valid_downstream[0:0];
  assign mux_4__in4[31:0] = fork_crossbar4__out4[31:0];
  assign mux_4__in4_valid_upstream[0:0] = fork_crossbar4__out4_valid_downstream[0:0];
  assign mux_5__in4[31:0] = fork_crossbar4__out5[31:0];
  assign mux_5__in4_valid_upstream[0:0] = fork_crossbar4__out5_valid_downstream[0:0];
  assign mux_6__in4[31:0] = fork_crossbar4__out6[31:0];
  assign mux_6__in4_valid_upstream[0:0] = fork_crossbar4__out6_valid_downstream[0:0];
  assign fork_crossbar5__in[31:0] = in5[31:0];
  assign fork_crossbar5__in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign in5_stop_upstream[0:0] = fork_crossbar5__in_stop_upstream[0:0];
  assign mux_0__in5[31:0] = fork_crossbar5__out0[31:0];
  assign mux_0__in5_valid_upstream[0:0] = fork_crossbar5__out0_valid_downstream[0:0];
  assign mux_1__in5[31:0] = fork_crossbar5__out1[31:0];
  assign mux_1__in5_valid_upstream[0:0] = fork_crossbar5__out1_valid_downstream[0:0];
  assign mux_2__in5[31:0] = fork_crossbar5__out2[31:0];
  assign mux_2__in5_valid_upstream[0:0] = fork_crossbar5__out2_valid_downstream[0:0];
  assign mux_3__in5[31:0] = fork_crossbar5__out3[31:0];
  assign mux_3__in5_valid_upstream[0:0] = fork_crossbar5__out3_valid_downstream[0:0];
  assign mux_4__in5[31:0] = fork_crossbar5__out4[31:0];
  assign mux_4__in5_valid_upstream[0:0] = fork_crossbar5__out4_valid_downstream[0:0];
  assign mux_5__in5[31:0] = fork_crossbar5__out5[31:0];
  assign mux_5__in5_valid_upstream[0:0] = fork_crossbar5__out5_valid_downstream[0:0];
  assign mux_6__in5[31:0] = fork_crossbar5__out6[31:0];
  assign mux_6__in5_valid_upstream[0:0] = fork_crossbar5__out6_valid_downstream[0:0];
  assign mux_0__out_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign mux_1__out_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign mux_2__out_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign mux_3__out_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign mux_4__out_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign mux_5__out_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign mux_6__out_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign fork_crossbar0__enable_downstream[6:0] = ForkCrossbar0Config__select[6:0];
  assign ForkCrossbar0Config__valid[0:0] = fork_crossbar0__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar0Config__stop[0:0] = fork_crossbar0__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar1__enable_downstream[6:0] = ForkCrossbar1Config__select[6:0];
  assign ForkCrossbar1Config__valid[0:0] = fork_crossbar1__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar1Config__stop[0:0] = fork_crossbar1__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar2__enable_downstream[6:0] = ForkCrossbar2Config__select[6:0];
  assign ForkCrossbar2Config__valid[0:0] = fork_crossbar2__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar2Config__stop[0:0] = fork_crossbar2__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar3__enable_downstream[6:0] = ForkCrossbar3Config__select[6:0];
  assign ForkCrossbar3Config__valid[0:0] = fork_crossbar3__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar3Config__stop[0:0] = fork_crossbar3__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar4__enable_downstream[6:0] = ForkCrossbar4Config__select[6:0];
  assign ForkCrossbar4Config__valid[0:0] = fork_crossbar4__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar4Config__stop[0:0] = fork_crossbar4__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar5__enable_downstream[6:0] = ForkCrossbar5Config__select[6:0];
  assign ForkCrossbar5Config__valid[0:0] = fork_crossbar5__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar5Config__stop[0:0] = fork_crossbar5__enable_downstream_stop_upstream[0:0];
  assign mux_0__select[2:0] = Mux0config__select[2:0];
  assign Mux0config__valid[0:0] = mux_0__select_valid_upstream[0:0];
  assign Mux0config__stop[0:0] = mux_0__select_stop_upstream[0:0];
  assign mux_1__select[2:0] = Mux1config__select[2:0];
  assign Mux1config__valid[0:0] = mux_1__select_valid_upstream[0:0];
  assign Mux1config__stop[0:0] = mux_1__select_stop_upstream[0:0];
  assign mux_2__select[2:0] = Mux2config__select[2:0];
  assign Mux2config__valid[0:0] = mux_2__select_valid_upstream[0:0];
  assign Mux2config__stop[0:0] = mux_2__select_stop_upstream[0:0];
  assign mux_3__select[2:0] = Mux3config__select[2:0];
  assign Mux3config__valid[0:0] = mux_3__select_valid_upstream[0:0];
  assign Mux3config__stop[0:0] = mux_3__select_stop_upstream[0:0];
  assign mux_4__select[2:0] = Mux4config__select[2:0];
  assign Mux4config__valid[0:0] = mux_4__select_valid_upstream[0:0];
  assign Mux4config__stop[0:0] = mux_4__select_stop_upstream[0:0];
  assign mux_5__select[2:0] = Mux5config__select[2:0];
  assign Mux5config__valid[0:0] = mux_5__select_valid_upstream[0:0];
  assign Mux5config__stop[0:0] = mux_5__select_stop_upstream[0:0];
  assign mux_6__select[2:0] = Mux6config__select[2:0];
  assign Mux6config__valid[0:0] = mux_6__select_valid_upstream[0:0];
  assign Mux6config__stop[0:0] = mux_6__select_stop_upstream[0:0];
  assign ForkCrossbar0Config__ConfigIn = ConfigIn;
  assign ForkCrossbar1Config__ConfigIn = ForkCrossbar0Config__ConfigOut;
  assign ForkCrossbar2Config__ConfigIn = ForkCrossbar1Config__ConfigOut;
  assign ForkCrossbar3Config__ConfigIn = ForkCrossbar2Config__ConfigOut;
  assign ForkCrossbar4Config__ConfigIn = ForkCrossbar3Config__ConfigOut;
  assign ForkCrossbar5Config__ConfigIn = ForkCrossbar4Config__ConfigOut;
  assign Mux0config__ConfigIn = ForkCrossbar5Config__ConfigOut;
  assign Mux1config__ConfigIn = Mux0config__ConfigOut;
  assign Mux2config__ConfigIn = Mux1config__ConfigOut;
  assign Mux3config__ConfigIn = Mux2config__ConfigOut;
  assign Mux4config__ConfigIn = Mux3config__ConfigOut;
  assign Mux5config__ConfigIn = Mux4config__ConfigOut;
  assign Mux6config__ConfigIn = Mux5config__ConfigOut;
  assign ConfigOut = Mux6config__ConfigOut;

endmodule //elastic_crossbar_6in_7out_size_32_U21

module cgrame_elastic_mux_7to1_32b #(parameter contexts=1, parameter size=1) (
  in0,
  in0_stop_upstream,
  in0_valid_upstream,
  in1,
  in1_stop_upstream,
  in1_valid_upstream,
  in2,
  in2_stop_upstream,
  in2_valid_upstream,
  in3,
  in3_stop_upstream,
  in3_valid_upstream,
  in4,
  in4_stop_upstream,
  in4_valid_upstream,
  in5,
  in5_stop_upstream,
  in5_valid_upstream,
  in6,
  in6_stop_upstream,
  in6_valid_upstream,
  out,
  out_stop_downstream,
  out_valid_downstream,
  select,
  select_stop_upstream,
  select_valid_upstream
);
    input [size-1:0] in0;
    output reg [0:0] in0_stop_upstream;
    input [0:0] in0_valid_upstream;
    input [size-1:0] in1;
    output reg [0:0] in1_stop_upstream;
    input [0:0] in1_valid_upstream;
    input [size-1:0] in2;
    output reg [0:0] in2_stop_upstream;
    input [0:0] in2_valid_upstream;
    input [size-1:0] in3;
    output reg [0:0] in3_stop_upstream;
    input [0:0] in3_valid_upstream;
    input [size-1:0] in4;
    output reg [0:0] in4_stop_upstream;
    input [0:0] in4_valid_upstream;
    input [size-1:0] in5;
    output reg [0:0] in5_stop_upstream;
    input [0:0] in5_valid_upstream;
    input [size-1:0] in6;
    output reg [0:0] in6_stop_upstream;
    input [0:0] in6_valid_upstream;
    output reg [size-1:0] out;
    input [0:0] out_stop_downstream;
    output reg [0:0] out_valid_downstream;
    input [2:0] select;
    output [0:0] select_stop_upstream;
    output [0:0] select_valid_upstream;
    always @(*)
        case (select)
            0:begin
                 out = in0;
                 out_valid_downstream = in0_valid_upstream;
                 in0_stop_upstream = out_stop_downstream;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
            end
            1:begin
                 out = in1;
                 out_valid_downstream = in1_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = out_stop_downstream;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
            end
            2:begin
                 out = in2;
                 out_valid_downstream = in2_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = out_stop_downstream;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
            end
            3:begin
                 out = in3;
                 out_valid_downstream = in3_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = out_stop_downstream;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
            end
            4:begin
                 out = in4;
                 out_valid_downstream = in4_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = out_stop_downstream;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
            end
            5:begin
                 out = in5;
                 out_valid_downstream = in5_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = out_stop_downstream;
                 in6_stop_upstream = 1'b1;
            end
            6:begin
                 out = in6;
                 out_valid_downstream = in6_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = out_stop_downstream;
            end
            default: out = {size{1'bx}};
        endcase
        assign select_stop_upstream = out_stop_downstream;
        assign select_valid_upstream = out_valid_downstream;


endmodule //cgrame_elastic_mux_7to1_32b

module elastic_crossbar_7in_8out_size_32_U19 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream
);
  //Wire declarations for instance 'ForkCrossbar0Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar0Config__CGRA_Clock;
  wire  ForkCrossbar0Config__CGRA_Enable;
  wire  ForkCrossbar0Config__CGRA_Reset;
  wire  ForkCrossbar0Config__ConfigIn;
  wire  ForkCrossbar0Config__ConfigOut;
  wire  ForkCrossbar0Config__Config_Clock;
  wire  ForkCrossbar0Config__Config_Reset;
  wire [7:0] ForkCrossbar0Config__select;
  wire [0:0] ForkCrossbar0Config__stop;
  wire [0:0] ForkCrossbar0Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar0Config(
    .CGRA_Clock(ForkCrossbar0Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar0Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar0Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar0Config__ConfigIn),
    .ConfigOut(ForkCrossbar0Config__ConfigOut),
    .Config_Clock(ForkCrossbar0Config__Config_Clock),
    .Config_Reset(ForkCrossbar0Config__Config_Reset),
    .select(ForkCrossbar0Config__select),
    .stop(ForkCrossbar0Config__stop),
    .valid(ForkCrossbar0Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar1Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar1Config__CGRA_Clock;
  wire  ForkCrossbar1Config__CGRA_Enable;
  wire  ForkCrossbar1Config__CGRA_Reset;
  wire  ForkCrossbar1Config__ConfigIn;
  wire  ForkCrossbar1Config__ConfigOut;
  wire  ForkCrossbar1Config__Config_Clock;
  wire  ForkCrossbar1Config__Config_Reset;
  wire [7:0] ForkCrossbar1Config__select;
  wire [0:0] ForkCrossbar1Config__stop;
  wire [0:0] ForkCrossbar1Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar1Config(
    .CGRA_Clock(ForkCrossbar1Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar1Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar1Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar1Config__ConfigIn),
    .ConfigOut(ForkCrossbar1Config__ConfigOut),
    .Config_Clock(ForkCrossbar1Config__Config_Clock),
    .Config_Reset(ForkCrossbar1Config__Config_Reset),
    .select(ForkCrossbar1Config__select),
    .stop(ForkCrossbar1Config__stop),
    .valid(ForkCrossbar1Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar2Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar2Config__CGRA_Clock;
  wire  ForkCrossbar2Config__CGRA_Enable;
  wire  ForkCrossbar2Config__CGRA_Reset;
  wire  ForkCrossbar2Config__ConfigIn;
  wire  ForkCrossbar2Config__ConfigOut;
  wire  ForkCrossbar2Config__Config_Clock;
  wire  ForkCrossbar2Config__Config_Reset;
  wire [7:0] ForkCrossbar2Config__select;
  wire [0:0] ForkCrossbar2Config__stop;
  wire [0:0] ForkCrossbar2Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar2Config(
    .CGRA_Clock(ForkCrossbar2Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar2Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar2Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar2Config__ConfigIn),
    .ConfigOut(ForkCrossbar2Config__ConfigOut),
    .Config_Clock(ForkCrossbar2Config__Config_Clock),
    .Config_Reset(ForkCrossbar2Config__Config_Reset),
    .select(ForkCrossbar2Config__select),
    .stop(ForkCrossbar2Config__stop),
    .valid(ForkCrossbar2Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar3Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar3Config__CGRA_Clock;
  wire  ForkCrossbar3Config__CGRA_Enable;
  wire  ForkCrossbar3Config__CGRA_Reset;
  wire  ForkCrossbar3Config__ConfigIn;
  wire  ForkCrossbar3Config__ConfigOut;
  wire  ForkCrossbar3Config__Config_Clock;
  wire  ForkCrossbar3Config__Config_Reset;
  wire [7:0] ForkCrossbar3Config__select;
  wire [0:0] ForkCrossbar3Config__stop;
  wire [0:0] ForkCrossbar3Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar3Config(
    .CGRA_Clock(ForkCrossbar3Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar3Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar3Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar3Config__ConfigIn),
    .ConfigOut(ForkCrossbar3Config__ConfigOut),
    .Config_Clock(ForkCrossbar3Config__Config_Clock),
    .Config_Reset(ForkCrossbar3Config__Config_Reset),
    .select(ForkCrossbar3Config__select),
    .stop(ForkCrossbar3Config__stop),
    .valid(ForkCrossbar3Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar4Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar4Config__CGRA_Clock;
  wire  ForkCrossbar4Config__CGRA_Enable;
  wire  ForkCrossbar4Config__CGRA_Reset;
  wire  ForkCrossbar4Config__ConfigIn;
  wire  ForkCrossbar4Config__ConfigOut;
  wire  ForkCrossbar4Config__Config_Clock;
  wire  ForkCrossbar4Config__Config_Reset;
  wire [7:0] ForkCrossbar4Config__select;
  wire [0:0] ForkCrossbar4Config__stop;
  wire [0:0] ForkCrossbar4Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar4Config(
    .CGRA_Clock(ForkCrossbar4Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar4Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar4Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar4Config__ConfigIn),
    .ConfigOut(ForkCrossbar4Config__ConfigOut),
    .Config_Clock(ForkCrossbar4Config__Config_Clock),
    .Config_Reset(ForkCrossbar4Config__Config_Reset),
    .select(ForkCrossbar4Config__select),
    .stop(ForkCrossbar4Config__stop),
    .valid(ForkCrossbar4Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar5Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar5Config__CGRA_Clock;
  wire  ForkCrossbar5Config__CGRA_Enable;
  wire  ForkCrossbar5Config__CGRA_Reset;
  wire  ForkCrossbar5Config__ConfigIn;
  wire  ForkCrossbar5Config__ConfigOut;
  wire  ForkCrossbar5Config__Config_Clock;
  wire  ForkCrossbar5Config__Config_Reset;
  wire [7:0] ForkCrossbar5Config__select;
  wire [0:0] ForkCrossbar5Config__stop;
  wire [0:0] ForkCrossbar5Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar5Config(
    .CGRA_Clock(ForkCrossbar5Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar5Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar5Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar5Config__ConfigIn),
    .ConfigOut(ForkCrossbar5Config__ConfigOut),
    .Config_Clock(ForkCrossbar5Config__Config_Clock),
    .Config_Reset(ForkCrossbar5Config__Config_Reset),
    .select(ForkCrossbar5Config__select),
    .stop(ForkCrossbar5Config__stop),
    .valid(ForkCrossbar5Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar6Config' (Module cgrame_elastic_configcell_context_size8II1)
  wire  ForkCrossbar6Config__CGRA_Clock;
  wire  ForkCrossbar6Config__CGRA_Enable;
  wire  ForkCrossbar6Config__CGRA_Reset;
  wire  ForkCrossbar6Config__ConfigIn;
  wire  ForkCrossbar6Config__ConfigOut;
  wire  ForkCrossbar6Config__Config_Clock;
  wire  ForkCrossbar6Config__Config_Reset;
  wire [7:0] ForkCrossbar6Config__select;
  wire [0:0] ForkCrossbar6Config__stop;
  wire [0:0] ForkCrossbar6Config__valid;
  cgrame_elastic_configcell_context_size8II1 #(.contexts(1),.size(8)) ForkCrossbar6Config(
    .CGRA_Clock(ForkCrossbar6Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar6Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar6Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar6Config__ConfigIn),
    .ConfigOut(ForkCrossbar6Config__ConfigOut),
    .Config_Clock(ForkCrossbar6Config__Config_Clock),
    .Config_Reset(ForkCrossbar6Config__Config_Reset),
    .select(ForkCrossbar6Config__select),
    .stop(ForkCrossbar6Config__stop),
    .valid(ForkCrossbar6Config__valid)
  );

  //Wire declarations for instance 'Mux0config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux0config__CGRA_Clock;
  wire  Mux0config__CGRA_Enable;
  wire  Mux0config__CGRA_Reset;
  wire  Mux0config__ConfigIn;
  wire  Mux0config__ConfigOut;
  wire  Mux0config__Config_Clock;
  wire  Mux0config__Config_Reset;
  wire [2:0] Mux0config__select;
  wire [0:0] Mux0config__stop;
  wire [0:0] Mux0config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux0config(
    .CGRA_Clock(Mux0config__CGRA_Clock),
    .CGRA_Enable(Mux0config__CGRA_Enable),
    .CGRA_Reset(Mux0config__CGRA_Reset),
    .ConfigIn(Mux0config__ConfigIn),
    .ConfigOut(Mux0config__ConfigOut),
    .Config_Clock(Mux0config__Config_Clock),
    .Config_Reset(Mux0config__Config_Reset),
    .select(Mux0config__select),
    .stop(Mux0config__stop),
    .valid(Mux0config__valid)
  );

  //Wire declarations for instance 'Mux1config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux1config__CGRA_Clock;
  wire  Mux1config__CGRA_Enable;
  wire  Mux1config__CGRA_Reset;
  wire  Mux1config__ConfigIn;
  wire  Mux1config__ConfigOut;
  wire  Mux1config__Config_Clock;
  wire  Mux1config__Config_Reset;
  wire [2:0] Mux1config__select;
  wire [0:0] Mux1config__stop;
  wire [0:0] Mux1config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux1config(
    .CGRA_Clock(Mux1config__CGRA_Clock),
    .CGRA_Enable(Mux1config__CGRA_Enable),
    .CGRA_Reset(Mux1config__CGRA_Reset),
    .ConfigIn(Mux1config__ConfigIn),
    .ConfigOut(Mux1config__ConfigOut),
    .Config_Clock(Mux1config__Config_Clock),
    .Config_Reset(Mux1config__Config_Reset),
    .select(Mux1config__select),
    .stop(Mux1config__stop),
    .valid(Mux1config__valid)
  );

  //Wire declarations for instance 'Mux2config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux2config__CGRA_Clock;
  wire  Mux2config__CGRA_Enable;
  wire  Mux2config__CGRA_Reset;
  wire  Mux2config__ConfigIn;
  wire  Mux2config__ConfigOut;
  wire  Mux2config__Config_Clock;
  wire  Mux2config__Config_Reset;
  wire [2:0] Mux2config__select;
  wire [0:0] Mux2config__stop;
  wire [0:0] Mux2config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux2config(
    .CGRA_Clock(Mux2config__CGRA_Clock),
    .CGRA_Enable(Mux2config__CGRA_Enable),
    .CGRA_Reset(Mux2config__CGRA_Reset),
    .ConfigIn(Mux2config__ConfigIn),
    .ConfigOut(Mux2config__ConfigOut),
    .Config_Clock(Mux2config__Config_Clock),
    .Config_Reset(Mux2config__Config_Reset),
    .select(Mux2config__select),
    .stop(Mux2config__stop),
    .valid(Mux2config__valid)
  );

  //Wire declarations for instance 'Mux3config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux3config__CGRA_Clock;
  wire  Mux3config__CGRA_Enable;
  wire  Mux3config__CGRA_Reset;
  wire  Mux3config__ConfigIn;
  wire  Mux3config__ConfigOut;
  wire  Mux3config__Config_Clock;
  wire  Mux3config__Config_Reset;
  wire [2:0] Mux3config__select;
  wire [0:0] Mux3config__stop;
  wire [0:0] Mux3config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux3config(
    .CGRA_Clock(Mux3config__CGRA_Clock),
    .CGRA_Enable(Mux3config__CGRA_Enable),
    .CGRA_Reset(Mux3config__CGRA_Reset),
    .ConfigIn(Mux3config__ConfigIn),
    .ConfigOut(Mux3config__ConfigOut),
    .Config_Clock(Mux3config__Config_Clock),
    .Config_Reset(Mux3config__Config_Reset),
    .select(Mux3config__select),
    .stop(Mux3config__stop),
    .valid(Mux3config__valid)
  );

  //Wire declarations for instance 'Mux4config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux4config__CGRA_Clock;
  wire  Mux4config__CGRA_Enable;
  wire  Mux4config__CGRA_Reset;
  wire  Mux4config__ConfigIn;
  wire  Mux4config__ConfigOut;
  wire  Mux4config__Config_Clock;
  wire  Mux4config__Config_Reset;
  wire [2:0] Mux4config__select;
  wire [0:0] Mux4config__stop;
  wire [0:0] Mux4config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux4config(
    .CGRA_Clock(Mux4config__CGRA_Clock),
    .CGRA_Enable(Mux4config__CGRA_Enable),
    .CGRA_Reset(Mux4config__CGRA_Reset),
    .ConfigIn(Mux4config__ConfigIn),
    .ConfigOut(Mux4config__ConfigOut),
    .Config_Clock(Mux4config__Config_Clock),
    .Config_Reset(Mux4config__Config_Reset),
    .select(Mux4config__select),
    .stop(Mux4config__stop),
    .valid(Mux4config__valid)
  );

  //Wire declarations for instance 'Mux5config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux5config__CGRA_Clock;
  wire  Mux5config__CGRA_Enable;
  wire  Mux5config__CGRA_Reset;
  wire  Mux5config__ConfigIn;
  wire  Mux5config__ConfigOut;
  wire  Mux5config__Config_Clock;
  wire  Mux5config__Config_Reset;
  wire [2:0] Mux5config__select;
  wire [0:0] Mux5config__stop;
  wire [0:0] Mux5config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux5config(
    .CGRA_Clock(Mux5config__CGRA_Clock),
    .CGRA_Enable(Mux5config__CGRA_Enable),
    .CGRA_Reset(Mux5config__CGRA_Reset),
    .ConfigIn(Mux5config__ConfigIn),
    .ConfigOut(Mux5config__ConfigOut),
    .Config_Clock(Mux5config__Config_Clock),
    .Config_Reset(Mux5config__Config_Reset),
    .select(Mux5config__select),
    .stop(Mux5config__stop),
    .valid(Mux5config__valid)
  );

  //Wire declarations for instance 'Mux6config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux6config__CGRA_Clock;
  wire  Mux6config__CGRA_Enable;
  wire  Mux6config__CGRA_Reset;
  wire  Mux6config__ConfigIn;
  wire  Mux6config__ConfigOut;
  wire  Mux6config__Config_Clock;
  wire  Mux6config__Config_Reset;
  wire [2:0] Mux6config__select;
  wire [0:0] Mux6config__stop;
  wire [0:0] Mux6config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux6config(
    .CGRA_Clock(Mux6config__CGRA_Clock),
    .CGRA_Enable(Mux6config__CGRA_Enable),
    .CGRA_Reset(Mux6config__CGRA_Reset),
    .ConfigIn(Mux6config__ConfigIn),
    .ConfigOut(Mux6config__ConfigOut),
    .Config_Clock(Mux6config__Config_Clock),
    .Config_Reset(Mux6config__Config_Reset),
    .select(Mux6config__select),
    .stop(Mux6config__stop),
    .valid(Mux6config__valid)
  );

  //Wire declarations for instance 'Mux7config' (Module cgrame_elastic_configcell_context_size3II1)
  wire  Mux7config__CGRA_Clock;
  wire  Mux7config__CGRA_Enable;
  wire  Mux7config__CGRA_Reset;
  wire  Mux7config__ConfigIn;
  wire  Mux7config__ConfigOut;
  wire  Mux7config__Config_Clock;
  wire  Mux7config__Config_Reset;
  wire [2:0] Mux7config__select;
  wire [0:0] Mux7config__stop;
  wire [0:0] Mux7config__valid;
  cgrame_elastic_configcell_context_size3II1 #(.contexts(1),.size(3)) Mux7config(
    .CGRA_Clock(Mux7config__CGRA_Clock),
    .CGRA_Enable(Mux7config__CGRA_Enable),
    .CGRA_Reset(Mux7config__CGRA_Reset),
    .ConfigIn(Mux7config__ConfigIn),
    .ConfigOut(Mux7config__ConfigOut),
    .Config_Clock(Mux7config__Config_Clock),
    .Config_Reset(Mux7config__Config_Reset),
    .select(Mux7config__select),
    .stop(Mux7config__stop),
    .valid(Mux7config__valid)
  );

  //Wire declarations for instance 'fork_crossbar0' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar0__CGRA_Clock;
  wire  fork_crossbar0__CGRA_Enable;
  wire  fork_crossbar0__CGRA_Reset;
  wire [7:0] fork_crossbar0__enable_downstream;
  wire [0:0] fork_crossbar0__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar0__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar0__in;
  wire [0:0] fork_crossbar0__in_stop_upstream;
  wire [0:0] fork_crossbar0__in_valid_upstream;
  wire [31:0] fork_crossbar0__out0;
  wire [0:0] fork_crossbar0__out0_stop_downstream;
  wire [0:0] fork_crossbar0__out0_valid_downstream;
  wire [31:0] fork_crossbar0__out1;
  wire [0:0] fork_crossbar0__out1_stop_downstream;
  wire [0:0] fork_crossbar0__out1_valid_downstream;
  wire [31:0] fork_crossbar0__out2;
  wire [0:0] fork_crossbar0__out2_stop_downstream;
  wire [0:0] fork_crossbar0__out2_valid_downstream;
  wire [31:0] fork_crossbar0__out3;
  wire [0:0] fork_crossbar0__out3_stop_downstream;
  wire [0:0] fork_crossbar0__out3_valid_downstream;
  wire [31:0] fork_crossbar0__out4;
  wire [0:0] fork_crossbar0__out4_stop_downstream;
  wire [0:0] fork_crossbar0__out4_valid_downstream;
  wire [31:0] fork_crossbar0__out5;
  wire [0:0] fork_crossbar0__out5_stop_downstream;
  wire [0:0] fork_crossbar0__out5_valid_downstream;
  wire [31:0] fork_crossbar0__out6;
  wire [0:0] fork_crossbar0__out6_stop_downstream;
  wire [0:0] fork_crossbar0__out6_valid_downstream;
  wire [31:0] fork_crossbar0__out7;
  wire [0:0] fork_crossbar0__out7_stop_downstream;
  wire [0:0] fork_crossbar0__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar0(
    .CGRA_Clock(fork_crossbar0__CGRA_Clock),
    .CGRA_Enable(fork_crossbar0__CGRA_Enable),
    .CGRA_Reset(fork_crossbar0__CGRA_Reset),
    .enable_downstream(fork_crossbar0__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar0__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar0__enable_downstream_valid_upstream),
    .in(fork_crossbar0__in),
    .in_stop_upstream(fork_crossbar0__in_stop_upstream),
    .in_valid_upstream(fork_crossbar0__in_valid_upstream),
    .out0(fork_crossbar0__out0),
    .out0_stop_downstream(fork_crossbar0__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar0__out0_valid_downstream),
    .out1(fork_crossbar0__out1),
    .out1_stop_downstream(fork_crossbar0__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar0__out1_valid_downstream),
    .out2(fork_crossbar0__out2),
    .out2_stop_downstream(fork_crossbar0__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar0__out2_valid_downstream),
    .out3(fork_crossbar0__out3),
    .out3_stop_downstream(fork_crossbar0__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar0__out3_valid_downstream),
    .out4(fork_crossbar0__out4),
    .out4_stop_downstream(fork_crossbar0__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar0__out4_valid_downstream),
    .out5(fork_crossbar0__out5),
    .out5_stop_downstream(fork_crossbar0__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar0__out5_valid_downstream),
    .out6(fork_crossbar0__out6),
    .out6_stop_downstream(fork_crossbar0__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar0__out6_valid_downstream),
    .out7(fork_crossbar0__out7),
    .out7_stop_downstream(fork_crossbar0__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar0__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar1' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar1__CGRA_Clock;
  wire  fork_crossbar1__CGRA_Enable;
  wire  fork_crossbar1__CGRA_Reset;
  wire [7:0] fork_crossbar1__enable_downstream;
  wire [0:0] fork_crossbar1__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar1__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar1__in;
  wire [0:0] fork_crossbar1__in_stop_upstream;
  wire [0:0] fork_crossbar1__in_valid_upstream;
  wire [31:0] fork_crossbar1__out0;
  wire [0:0] fork_crossbar1__out0_stop_downstream;
  wire [0:0] fork_crossbar1__out0_valid_downstream;
  wire [31:0] fork_crossbar1__out1;
  wire [0:0] fork_crossbar1__out1_stop_downstream;
  wire [0:0] fork_crossbar1__out1_valid_downstream;
  wire [31:0] fork_crossbar1__out2;
  wire [0:0] fork_crossbar1__out2_stop_downstream;
  wire [0:0] fork_crossbar1__out2_valid_downstream;
  wire [31:0] fork_crossbar1__out3;
  wire [0:0] fork_crossbar1__out3_stop_downstream;
  wire [0:0] fork_crossbar1__out3_valid_downstream;
  wire [31:0] fork_crossbar1__out4;
  wire [0:0] fork_crossbar1__out4_stop_downstream;
  wire [0:0] fork_crossbar1__out4_valid_downstream;
  wire [31:0] fork_crossbar1__out5;
  wire [0:0] fork_crossbar1__out5_stop_downstream;
  wire [0:0] fork_crossbar1__out5_valid_downstream;
  wire [31:0] fork_crossbar1__out6;
  wire [0:0] fork_crossbar1__out6_stop_downstream;
  wire [0:0] fork_crossbar1__out6_valid_downstream;
  wire [31:0] fork_crossbar1__out7;
  wire [0:0] fork_crossbar1__out7_stop_downstream;
  wire [0:0] fork_crossbar1__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar1(
    .CGRA_Clock(fork_crossbar1__CGRA_Clock),
    .CGRA_Enable(fork_crossbar1__CGRA_Enable),
    .CGRA_Reset(fork_crossbar1__CGRA_Reset),
    .enable_downstream(fork_crossbar1__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar1__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar1__enable_downstream_valid_upstream),
    .in(fork_crossbar1__in),
    .in_stop_upstream(fork_crossbar1__in_stop_upstream),
    .in_valid_upstream(fork_crossbar1__in_valid_upstream),
    .out0(fork_crossbar1__out0),
    .out0_stop_downstream(fork_crossbar1__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar1__out0_valid_downstream),
    .out1(fork_crossbar1__out1),
    .out1_stop_downstream(fork_crossbar1__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar1__out1_valid_downstream),
    .out2(fork_crossbar1__out2),
    .out2_stop_downstream(fork_crossbar1__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar1__out2_valid_downstream),
    .out3(fork_crossbar1__out3),
    .out3_stop_downstream(fork_crossbar1__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar1__out3_valid_downstream),
    .out4(fork_crossbar1__out4),
    .out4_stop_downstream(fork_crossbar1__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar1__out4_valid_downstream),
    .out5(fork_crossbar1__out5),
    .out5_stop_downstream(fork_crossbar1__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar1__out5_valid_downstream),
    .out6(fork_crossbar1__out6),
    .out6_stop_downstream(fork_crossbar1__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar1__out6_valid_downstream),
    .out7(fork_crossbar1__out7),
    .out7_stop_downstream(fork_crossbar1__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar1__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar2' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar2__CGRA_Clock;
  wire  fork_crossbar2__CGRA_Enable;
  wire  fork_crossbar2__CGRA_Reset;
  wire [7:0] fork_crossbar2__enable_downstream;
  wire [0:0] fork_crossbar2__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar2__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar2__in;
  wire [0:0] fork_crossbar2__in_stop_upstream;
  wire [0:0] fork_crossbar2__in_valid_upstream;
  wire [31:0] fork_crossbar2__out0;
  wire [0:0] fork_crossbar2__out0_stop_downstream;
  wire [0:0] fork_crossbar2__out0_valid_downstream;
  wire [31:0] fork_crossbar2__out1;
  wire [0:0] fork_crossbar2__out1_stop_downstream;
  wire [0:0] fork_crossbar2__out1_valid_downstream;
  wire [31:0] fork_crossbar2__out2;
  wire [0:0] fork_crossbar2__out2_stop_downstream;
  wire [0:0] fork_crossbar2__out2_valid_downstream;
  wire [31:0] fork_crossbar2__out3;
  wire [0:0] fork_crossbar2__out3_stop_downstream;
  wire [0:0] fork_crossbar2__out3_valid_downstream;
  wire [31:0] fork_crossbar2__out4;
  wire [0:0] fork_crossbar2__out4_stop_downstream;
  wire [0:0] fork_crossbar2__out4_valid_downstream;
  wire [31:0] fork_crossbar2__out5;
  wire [0:0] fork_crossbar2__out5_stop_downstream;
  wire [0:0] fork_crossbar2__out5_valid_downstream;
  wire [31:0] fork_crossbar2__out6;
  wire [0:0] fork_crossbar2__out6_stop_downstream;
  wire [0:0] fork_crossbar2__out6_valid_downstream;
  wire [31:0] fork_crossbar2__out7;
  wire [0:0] fork_crossbar2__out7_stop_downstream;
  wire [0:0] fork_crossbar2__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar2(
    .CGRA_Clock(fork_crossbar2__CGRA_Clock),
    .CGRA_Enable(fork_crossbar2__CGRA_Enable),
    .CGRA_Reset(fork_crossbar2__CGRA_Reset),
    .enable_downstream(fork_crossbar2__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar2__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar2__enable_downstream_valid_upstream),
    .in(fork_crossbar2__in),
    .in_stop_upstream(fork_crossbar2__in_stop_upstream),
    .in_valid_upstream(fork_crossbar2__in_valid_upstream),
    .out0(fork_crossbar2__out0),
    .out0_stop_downstream(fork_crossbar2__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar2__out0_valid_downstream),
    .out1(fork_crossbar2__out1),
    .out1_stop_downstream(fork_crossbar2__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar2__out1_valid_downstream),
    .out2(fork_crossbar2__out2),
    .out2_stop_downstream(fork_crossbar2__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar2__out2_valid_downstream),
    .out3(fork_crossbar2__out3),
    .out3_stop_downstream(fork_crossbar2__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar2__out3_valid_downstream),
    .out4(fork_crossbar2__out4),
    .out4_stop_downstream(fork_crossbar2__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar2__out4_valid_downstream),
    .out5(fork_crossbar2__out5),
    .out5_stop_downstream(fork_crossbar2__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar2__out5_valid_downstream),
    .out6(fork_crossbar2__out6),
    .out6_stop_downstream(fork_crossbar2__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar2__out6_valid_downstream),
    .out7(fork_crossbar2__out7),
    .out7_stop_downstream(fork_crossbar2__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar2__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar3' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar3__CGRA_Clock;
  wire  fork_crossbar3__CGRA_Enable;
  wire  fork_crossbar3__CGRA_Reset;
  wire [7:0] fork_crossbar3__enable_downstream;
  wire [0:0] fork_crossbar3__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar3__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar3__in;
  wire [0:0] fork_crossbar3__in_stop_upstream;
  wire [0:0] fork_crossbar3__in_valid_upstream;
  wire [31:0] fork_crossbar3__out0;
  wire [0:0] fork_crossbar3__out0_stop_downstream;
  wire [0:0] fork_crossbar3__out0_valid_downstream;
  wire [31:0] fork_crossbar3__out1;
  wire [0:0] fork_crossbar3__out1_stop_downstream;
  wire [0:0] fork_crossbar3__out1_valid_downstream;
  wire [31:0] fork_crossbar3__out2;
  wire [0:0] fork_crossbar3__out2_stop_downstream;
  wire [0:0] fork_crossbar3__out2_valid_downstream;
  wire [31:0] fork_crossbar3__out3;
  wire [0:0] fork_crossbar3__out3_stop_downstream;
  wire [0:0] fork_crossbar3__out3_valid_downstream;
  wire [31:0] fork_crossbar3__out4;
  wire [0:0] fork_crossbar3__out4_stop_downstream;
  wire [0:0] fork_crossbar3__out4_valid_downstream;
  wire [31:0] fork_crossbar3__out5;
  wire [0:0] fork_crossbar3__out5_stop_downstream;
  wire [0:0] fork_crossbar3__out5_valid_downstream;
  wire [31:0] fork_crossbar3__out6;
  wire [0:0] fork_crossbar3__out6_stop_downstream;
  wire [0:0] fork_crossbar3__out6_valid_downstream;
  wire [31:0] fork_crossbar3__out7;
  wire [0:0] fork_crossbar3__out7_stop_downstream;
  wire [0:0] fork_crossbar3__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar3(
    .CGRA_Clock(fork_crossbar3__CGRA_Clock),
    .CGRA_Enable(fork_crossbar3__CGRA_Enable),
    .CGRA_Reset(fork_crossbar3__CGRA_Reset),
    .enable_downstream(fork_crossbar3__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar3__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar3__enable_downstream_valid_upstream),
    .in(fork_crossbar3__in),
    .in_stop_upstream(fork_crossbar3__in_stop_upstream),
    .in_valid_upstream(fork_crossbar3__in_valid_upstream),
    .out0(fork_crossbar3__out0),
    .out0_stop_downstream(fork_crossbar3__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar3__out0_valid_downstream),
    .out1(fork_crossbar3__out1),
    .out1_stop_downstream(fork_crossbar3__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar3__out1_valid_downstream),
    .out2(fork_crossbar3__out2),
    .out2_stop_downstream(fork_crossbar3__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar3__out2_valid_downstream),
    .out3(fork_crossbar3__out3),
    .out3_stop_downstream(fork_crossbar3__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar3__out3_valid_downstream),
    .out4(fork_crossbar3__out4),
    .out4_stop_downstream(fork_crossbar3__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar3__out4_valid_downstream),
    .out5(fork_crossbar3__out5),
    .out5_stop_downstream(fork_crossbar3__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar3__out5_valid_downstream),
    .out6(fork_crossbar3__out6),
    .out6_stop_downstream(fork_crossbar3__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar3__out6_valid_downstream),
    .out7(fork_crossbar3__out7),
    .out7_stop_downstream(fork_crossbar3__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar3__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar4' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar4__CGRA_Clock;
  wire  fork_crossbar4__CGRA_Enable;
  wire  fork_crossbar4__CGRA_Reset;
  wire [7:0] fork_crossbar4__enable_downstream;
  wire [0:0] fork_crossbar4__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar4__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar4__in;
  wire [0:0] fork_crossbar4__in_stop_upstream;
  wire [0:0] fork_crossbar4__in_valid_upstream;
  wire [31:0] fork_crossbar4__out0;
  wire [0:0] fork_crossbar4__out0_stop_downstream;
  wire [0:0] fork_crossbar4__out0_valid_downstream;
  wire [31:0] fork_crossbar4__out1;
  wire [0:0] fork_crossbar4__out1_stop_downstream;
  wire [0:0] fork_crossbar4__out1_valid_downstream;
  wire [31:0] fork_crossbar4__out2;
  wire [0:0] fork_crossbar4__out2_stop_downstream;
  wire [0:0] fork_crossbar4__out2_valid_downstream;
  wire [31:0] fork_crossbar4__out3;
  wire [0:0] fork_crossbar4__out3_stop_downstream;
  wire [0:0] fork_crossbar4__out3_valid_downstream;
  wire [31:0] fork_crossbar4__out4;
  wire [0:0] fork_crossbar4__out4_stop_downstream;
  wire [0:0] fork_crossbar4__out4_valid_downstream;
  wire [31:0] fork_crossbar4__out5;
  wire [0:0] fork_crossbar4__out5_stop_downstream;
  wire [0:0] fork_crossbar4__out5_valid_downstream;
  wire [31:0] fork_crossbar4__out6;
  wire [0:0] fork_crossbar4__out6_stop_downstream;
  wire [0:0] fork_crossbar4__out6_valid_downstream;
  wire [31:0] fork_crossbar4__out7;
  wire [0:0] fork_crossbar4__out7_stop_downstream;
  wire [0:0] fork_crossbar4__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar4(
    .CGRA_Clock(fork_crossbar4__CGRA_Clock),
    .CGRA_Enable(fork_crossbar4__CGRA_Enable),
    .CGRA_Reset(fork_crossbar4__CGRA_Reset),
    .enable_downstream(fork_crossbar4__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar4__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar4__enable_downstream_valid_upstream),
    .in(fork_crossbar4__in),
    .in_stop_upstream(fork_crossbar4__in_stop_upstream),
    .in_valid_upstream(fork_crossbar4__in_valid_upstream),
    .out0(fork_crossbar4__out0),
    .out0_stop_downstream(fork_crossbar4__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar4__out0_valid_downstream),
    .out1(fork_crossbar4__out1),
    .out1_stop_downstream(fork_crossbar4__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar4__out1_valid_downstream),
    .out2(fork_crossbar4__out2),
    .out2_stop_downstream(fork_crossbar4__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar4__out2_valid_downstream),
    .out3(fork_crossbar4__out3),
    .out3_stop_downstream(fork_crossbar4__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar4__out3_valid_downstream),
    .out4(fork_crossbar4__out4),
    .out4_stop_downstream(fork_crossbar4__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar4__out4_valid_downstream),
    .out5(fork_crossbar4__out5),
    .out5_stop_downstream(fork_crossbar4__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar4__out5_valid_downstream),
    .out6(fork_crossbar4__out6),
    .out6_stop_downstream(fork_crossbar4__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar4__out6_valid_downstream),
    .out7(fork_crossbar4__out7),
    .out7_stop_downstream(fork_crossbar4__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar4__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar5' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar5__CGRA_Clock;
  wire  fork_crossbar5__CGRA_Enable;
  wire  fork_crossbar5__CGRA_Reset;
  wire [7:0] fork_crossbar5__enable_downstream;
  wire [0:0] fork_crossbar5__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar5__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar5__in;
  wire [0:0] fork_crossbar5__in_stop_upstream;
  wire [0:0] fork_crossbar5__in_valid_upstream;
  wire [31:0] fork_crossbar5__out0;
  wire [0:0] fork_crossbar5__out0_stop_downstream;
  wire [0:0] fork_crossbar5__out0_valid_downstream;
  wire [31:0] fork_crossbar5__out1;
  wire [0:0] fork_crossbar5__out1_stop_downstream;
  wire [0:0] fork_crossbar5__out1_valid_downstream;
  wire [31:0] fork_crossbar5__out2;
  wire [0:0] fork_crossbar5__out2_stop_downstream;
  wire [0:0] fork_crossbar5__out2_valid_downstream;
  wire [31:0] fork_crossbar5__out3;
  wire [0:0] fork_crossbar5__out3_stop_downstream;
  wire [0:0] fork_crossbar5__out3_valid_downstream;
  wire [31:0] fork_crossbar5__out4;
  wire [0:0] fork_crossbar5__out4_stop_downstream;
  wire [0:0] fork_crossbar5__out4_valid_downstream;
  wire [31:0] fork_crossbar5__out5;
  wire [0:0] fork_crossbar5__out5_stop_downstream;
  wire [0:0] fork_crossbar5__out5_valid_downstream;
  wire [31:0] fork_crossbar5__out6;
  wire [0:0] fork_crossbar5__out6_stop_downstream;
  wire [0:0] fork_crossbar5__out6_valid_downstream;
  wire [31:0] fork_crossbar5__out7;
  wire [0:0] fork_crossbar5__out7_stop_downstream;
  wire [0:0] fork_crossbar5__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar5(
    .CGRA_Clock(fork_crossbar5__CGRA_Clock),
    .CGRA_Enable(fork_crossbar5__CGRA_Enable),
    .CGRA_Reset(fork_crossbar5__CGRA_Reset),
    .enable_downstream(fork_crossbar5__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar5__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar5__enable_downstream_valid_upstream),
    .in(fork_crossbar5__in),
    .in_stop_upstream(fork_crossbar5__in_stop_upstream),
    .in_valid_upstream(fork_crossbar5__in_valid_upstream),
    .out0(fork_crossbar5__out0),
    .out0_stop_downstream(fork_crossbar5__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar5__out0_valid_downstream),
    .out1(fork_crossbar5__out1),
    .out1_stop_downstream(fork_crossbar5__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar5__out1_valid_downstream),
    .out2(fork_crossbar5__out2),
    .out2_stop_downstream(fork_crossbar5__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar5__out2_valid_downstream),
    .out3(fork_crossbar5__out3),
    .out3_stop_downstream(fork_crossbar5__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar5__out3_valid_downstream),
    .out4(fork_crossbar5__out4),
    .out4_stop_downstream(fork_crossbar5__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar5__out4_valid_downstream),
    .out5(fork_crossbar5__out5),
    .out5_stop_downstream(fork_crossbar5__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar5__out5_valid_downstream),
    .out6(fork_crossbar5__out6),
    .out6_stop_downstream(fork_crossbar5__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar5__out6_valid_downstream),
    .out7(fork_crossbar5__out7),
    .out7_stop_downstream(fork_crossbar5__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar5__out7_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar6' (Module cgrame_elastic_eager_fork_1to8_size_32)
  wire  fork_crossbar6__CGRA_Clock;
  wire  fork_crossbar6__CGRA_Enable;
  wire  fork_crossbar6__CGRA_Reset;
  wire [7:0] fork_crossbar6__enable_downstream;
  wire [0:0] fork_crossbar6__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar6__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar6__in;
  wire [0:0] fork_crossbar6__in_stop_upstream;
  wire [0:0] fork_crossbar6__in_valid_upstream;
  wire [31:0] fork_crossbar6__out0;
  wire [0:0] fork_crossbar6__out0_stop_downstream;
  wire [0:0] fork_crossbar6__out0_valid_downstream;
  wire [31:0] fork_crossbar6__out1;
  wire [0:0] fork_crossbar6__out1_stop_downstream;
  wire [0:0] fork_crossbar6__out1_valid_downstream;
  wire [31:0] fork_crossbar6__out2;
  wire [0:0] fork_crossbar6__out2_stop_downstream;
  wire [0:0] fork_crossbar6__out2_valid_downstream;
  wire [31:0] fork_crossbar6__out3;
  wire [0:0] fork_crossbar6__out3_stop_downstream;
  wire [0:0] fork_crossbar6__out3_valid_downstream;
  wire [31:0] fork_crossbar6__out4;
  wire [0:0] fork_crossbar6__out4_stop_downstream;
  wire [0:0] fork_crossbar6__out4_valid_downstream;
  wire [31:0] fork_crossbar6__out5;
  wire [0:0] fork_crossbar6__out5_stop_downstream;
  wire [0:0] fork_crossbar6__out5_valid_downstream;
  wire [31:0] fork_crossbar6__out6;
  wire [0:0] fork_crossbar6__out6_stop_downstream;
  wire [0:0] fork_crossbar6__out6_valid_downstream;
  wire [31:0] fork_crossbar6__out7;
  wire [0:0] fork_crossbar6__out7_stop_downstream;
  wire [0:0] fork_crossbar6__out7_valid_downstream;
  cgrame_elastic_eager_fork_1to8_size_32 #(.contexts(1),.size(32)) fork_crossbar6(
    .CGRA_Clock(fork_crossbar6__CGRA_Clock),
    .CGRA_Enable(fork_crossbar6__CGRA_Enable),
    .CGRA_Reset(fork_crossbar6__CGRA_Reset),
    .enable_downstream(fork_crossbar6__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar6__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar6__enable_downstream_valid_upstream),
    .in(fork_crossbar6__in),
    .in_stop_upstream(fork_crossbar6__in_stop_upstream),
    .in_valid_upstream(fork_crossbar6__in_valid_upstream),
    .out0(fork_crossbar6__out0),
    .out0_stop_downstream(fork_crossbar6__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar6__out0_valid_downstream),
    .out1(fork_crossbar6__out1),
    .out1_stop_downstream(fork_crossbar6__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar6__out1_valid_downstream),
    .out2(fork_crossbar6__out2),
    .out2_stop_downstream(fork_crossbar6__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar6__out2_valid_downstream),
    .out3(fork_crossbar6__out3),
    .out3_stop_downstream(fork_crossbar6__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar6__out3_valid_downstream),
    .out4(fork_crossbar6__out4),
    .out4_stop_downstream(fork_crossbar6__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar6__out4_valid_downstream),
    .out5(fork_crossbar6__out5),
    .out5_stop_downstream(fork_crossbar6__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar6__out5_valid_downstream),
    .out6(fork_crossbar6__out6),
    .out6_stop_downstream(fork_crossbar6__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar6__out6_valid_downstream),
    .out7(fork_crossbar6__out7),
    .out7_stop_downstream(fork_crossbar6__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar6__out7_valid_downstream)
  );

  //Wire declarations for instance 'mux_0' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_0__in0;
  wire [0:0] mux_0__in0_stop_upstream;
  wire [0:0] mux_0__in0_valid_upstream;
  wire [31:0] mux_0__in1;
  wire [0:0] mux_0__in1_stop_upstream;
  wire [0:0] mux_0__in1_valid_upstream;
  wire [31:0] mux_0__in2;
  wire [0:0] mux_0__in2_stop_upstream;
  wire [0:0] mux_0__in2_valid_upstream;
  wire [31:0] mux_0__in3;
  wire [0:0] mux_0__in3_stop_upstream;
  wire [0:0] mux_0__in3_valid_upstream;
  wire [31:0] mux_0__in4;
  wire [0:0] mux_0__in4_stop_upstream;
  wire [0:0] mux_0__in4_valid_upstream;
  wire [31:0] mux_0__in5;
  wire [0:0] mux_0__in5_stop_upstream;
  wire [0:0] mux_0__in5_valid_upstream;
  wire [31:0] mux_0__in6;
  wire [0:0] mux_0__in6_stop_upstream;
  wire [0:0] mux_0__in6_valid_upstream;
  wire [31:0] mux_0__out;
  wire [0:0] mux_0__out_stop_downstream;
  wire [0:0] mux_0__out_valid_downstream;
  wire [2:0] mux_0__select;
  wire [0:0] mux_0__select_stop_upstream;
  wire [0:0] mux_0__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_0(
    .in0(mux_0__in0),
    .in0_stop_upstream(mux_0__in0_stop_upstream),
    .in0_valid_upstream(mux_0__in0_valid_upstream),
    .in1(mux_0__in1),
    .in1_stop_upstream(mux_0__in1_stop_upstream),
    .in1_valid_upstream(mux_0__in1_valid_upstream),
    .in2(mux_0__in2),
    .in2_stop_upstream(mux_0__in2_stop_upstream),
    .in2_valid_upstream(mux_0__in2_valid_upstream),
    .in3(mux_0__in3),
    .in3_stop_upstream(mux_0__in3_stop_upstream),
    .in3_valid_upstream(mux_0__in3_valid_upstream),
    .in4(mux_0__in4),
    .in4_stop_upstream(mux_0__in4_stop_upstream),
    .in4_valid_upstream(mux_0__in4_valid_upstream),
    .in5(mux_0__in5),
    .in5_stop_upstream(mux_0__in5_stop_upstream),
    .in5_valid_upstream(mux_0__in5_valid_upstream),
    .in6(mux_0__in6),
    .in6_stop_upstream(mux_0__in6_stop_upstream),
    .in6_valid_upstream(mux_0__in6_valid_upstream),
    .out(mux_0__out),
    .out_stop_downstream(mux_0__out_stop_downstream),
    .out_valid_downstream(mux_0__out_valid_downstream),
    .select(mux_0__select),
    .select_stop_upstream(mux_0__select_stop_upstream),
    .select_valid_upstream(mux_0__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_1' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_1__in0;
  wire [0:0] mux_1__in0_stop_upstream;
  wire [0:0] mux_1__in0_valid_upstream;
  wire [31:0] mux_1__in1;
  wire [0:0] mux_1__in1_stop_upstream;
  wire [0:0] mux_1__in1_valid_upstream;
  wire [31:0] mux_1__in2;
  wire [0:0] mux_1__in2_stop_upstream;
  wire [0:0] mux_1__in2_valid_upstream;
  wire [31:0] mux_1__in3;
  wire [0:0] mux_1__in3_stop_upstream;
  wire [0:0] mux_1__in3_valid_upstream;
  wire [31:0] mux_1__in4;
  wire [0:0] mux_1__in4_stop_upstream;
  wire [0:0] mux_1__in4_valid_upstream;
  wire [31:0] mux_1__in5;
  wire [0:0] mux_1__in5_stop_upstream;
  wire [0:0] mux_1__in5_valid_upstream;
  wire [31:0] mux_1__in6;
  wire [0:0] mux_1__in6_stop_upstream;
  wire [0:0] mux_1__in6_valid_upstream;
  wire [31:0] mux_1__out;
  wire [0:0] mux_1__out_stop_downstream;
  wire [0:0] mux_1__out_valid_downstream;
  wire [2:0] mux_1__select;
  wire [0:0] mux_1__select_stop_upstream;
  wire [0:0] mux_1__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_1(
    .in0(mux_1__in0),
    .in0_stop_upstream(mux_1__in0_stop_upstream),
    .in0_valid_upstream(mux_1__in0_valid_upstream),
    .in1(mux_1__in1),
    .in1_stop_upstream(mux_1__in1_stop_upstream),
    .in1_valid_upstream(mux_1__in1_valid_upstream),
    .in2(mux_1__in2),
    .in2_stop_upstream(mux_1__in2_stop_upstream),
    .in2_valid_upstream(mux_1__in2_valid_upstream),
    .in3(mux_1__in3),
    .in3_stop_upstream(mux_1__in3_stop_upstream),
    .in3_valid_upstream(mux_1__in3_valid_upstream),
    .in4(mux_1__in4),
    .in4_stop_upstream(mux_1__in4_stop_upstream),
    .in4_valid_upstream(mux_1__in4_valid_upstream),
    .in5(mux_1__in5),
    .in5_stop_upstream(mux_1__in5_stop_upstream),
    .in5_valid_upstream(mux_1__in5_valid_upstream),
    .in6(mux_1__in6),
    .in6_stop_upstream(mux_1__in6_stop_upstream),
    .in6_valid_upstream(mux_1__in6_valid_upstream),
    .out(mux_1__out),
    .out_stop_downstream(mux_1__out_stop_downstream),
    .out_valid_downstream(mux_1__out_valid_downstream),
    .select(mux_1__select),
    .select_stop_upstream(mux_1__select_stop_upstream),
    .select_valid_upstream(mux_1__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_2' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_2__in0;
  wire [0:0] mux_2__in0_stop_upstream;
  wire [0:0] mux_2__in0_valid_upstream;
  wire [31:0] mux_2__in1;
  wire [0:0] mux_2__in1_stop_upstream;
  wire [0:0] mux_2__in1_valid_upstream;
  wire [31:0] mux_2__in2;
  wire [0:0] mux_2__in2_stop_upstream;
  wire [0:0] mux_2__in2_valid_upstream;
  wire [31:0] mux_2__in3;
  wire [0:0] mux_2__in3_stop_upstream;
  wire [0:0] mux_2__in3_valid_upstream;
  wire [31:0] mux_2__in4;
  wire [0:0] mux_2__in4_stop_upstream;
  wire [0:0] mux_2__in4_valid_upstream;
  wire [31:0] mux_2__in5;
  wire [0:0] mux_2__in5_stop_upstream;
  wire [0:0] mux_2__in5_valid_upstream;
  wire [31:0] mux_2__in6;
  wire [0:0] mux_2__in6_stop_upstream;
  wire [0:0] mux_2__in6_valid_upstream;
  wire [31:0] mux_2__out;
  wire [0:0] mux_2__out_stop_downstream;
  wire [0:0] mux_2__out_valid_downstream;
  wire [2:0] mux_2__select;
  wire [0:0] mux_2__select_stop_upstream;
  wire [0:0] mux_2__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_2(
    .in0(mux_2__in0),
    .in0_stop_upstream(mux_2__in0_stop_upstream),
    .in0_valid_upstream(mux_2__in0_valid_upstream),
    .in1(mux_2__in1),
    .in1_stop_upstream(mux_2__in1_stop_upstream),
    .in1_valid_upstream(mux_2__in1_valid_upstream),
    .in2(mux_2__in2),
    .in2_stop_upstream(mux_2__in2_stop_upstream),
    .in2_valid_upstream(mux_2__in2_valid_upstream),
    .in3(mux_2__in3),
    .in3_stop_upstream(mux_2__in3_stop_upstream),
    .in3_valid_upstream(mux_2__in3_valid_upstream),
    .in4(mux_2__in4),
    .in4_stop_upstream(mux_2__in4_stop_upstream),
    .in4_valid_upstream(mux_2__in4_valid_upstream),
    .in5(mux_2__in5),
    .in5_stop_upstream(mux_2__in5_stop_upstream),
    .in5_valid_upstream(mux_2__in5_valid_upstream),
    .in6(mux_2__in6),
    .in6_stop_upstream(mux_2__in6_stop_upstream),
    .in6_valid_upstream(mux_2__in6_valid_upstream),
    .out(mux_2__out),
    .out_stop_downstream(mux_2__out_stop_downstream),
    .out_valid_downstream(mux_2__out_valid_downstream),
    .select(mux_2__select),
    .select_stop_upstream(mux_2__select_stop_upstream),
    .select_valid_upstream(mux_2__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_3' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_3__in0;
  wire [0:0] mux_3__in0_stop_upstream;
  wire [0:0] mux_3__in0_valid_upstream;
  wire [31:0] mux_3__in1;
  wire [0:0] mux_3__in1_stop_upstream;
  wire [0:0] mux_3__in1_valid_upstream;
  wire [31:0] mux_3__in2;
  wire [0:0] mux_3__in2_stop_upstream;
  wire [0:0] mux_3__in2_valid_upstream;
  wire [31:0] mux_3__in3;
  wire [0:0] mux_3__in3_stop_upstream;
  wire [0:0] mux_3__in3_valid_upstream;
  wire [31:0] mux_3__in4;
  wire [0:0] mux_3__in4_stop_upstream;
  wire [0:0] mux_3__in4_valid_upstream;
  wire [31:0] mux_3__in5;
  wire [0:0] mux_3__in5_stop_upstream;
  wire [0:0] mux_3__in5_valid_upstream;
  wire [31:0] mux_3__in6;
  wire [0:0] mux_3__in6_stop_upstream;
  wire [0:0] mux_3__in6_valid_upstream;
  wire [31:0] mux_3__out;
  wire [0:0] mux_3__out_stop_downstream;
  wire [0:0] mux_3__out_valid_downstream;
  wire [2:0] mux_3__select;
  wire [0:0] mux_3__select_stop_upstream;
  wire [0:0] mux_3__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_3(
    .in0(mux_3__in0),
    .in0_stop_upstream(mux_3__in0_stop_upstream),
    .in0_valid_upstream(mux_3__in0_valid_upstream),
    .in1(mux_3__in1),
    .in1_stop_upstream(mux_3__in1_stop_upstream),
    .in1_valid_upstream(mux_3__in1_valid_upstream),
    .in2(mux_3__in2),
    .in2_stop_upstream(mux_3__in2_stop_upstream),
    .in2_valid_upstream(mux_3__in2_valid_upstream),
    .in3(mux_3__in3),
    .in3_stop_upstream(mux_3__in3_stop_upstream),
    .in3_valid_upstream(mux_3__in3_valid_upstream),
    .in4(mux_3__in4),
    .in4_stop_upstream(mux_3__in4_stop_upstream),
    .in4_valid_upstream(mux_3__in4_valid_upstream),
    .in5(mux_3__in5),
    .in5_stop_upstream(mux_3__in5_stop_upstream),
    .in5_valid_upstream(mux_3__in5_valid_upstream),
    .in6(mux_3__in6),
    .in6_stop_upstream(mux_3__in6_stop_upstream),
    .in6_valid_upstream(mux_3__in6_valid_upstream),
    .out(mux_3__out),
    .out_stop_downstream(mux_3__out_stop_downstream),
    .out_valid_downstream(mux_3__out_valid_downstream),
    .select(mux_3__select),
    .select_stop_upstream(mux_3__select_stop_upstream),
    .select_valid_upstream(mux_3__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_4' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_4__in0;
  wire [0:0] mux_4__in0_stop_upstream;
  wire [0:0] mux_4__in0_valid_upstream;
  wire [31:0] mux_4__in1;
  wire [0:0] mux_4__in1_stop_upstream;
  wire [0:0] mux_4__in1_valid_upstream;
  wire [31:0] mux_4__in2;
  wire [0:0] mux_4__in2_stop_upstream;
  wire [0:0] mux_4__in2_valid_upstream;
  wire [31:0] mux_4__in3;
  wire [0:0] mux_4__in3_stop_upstream;
  wire [0:0] mux_4__in3_valid_upstream;
  wire [31:0] mux_4__in4;
  wire [0:0] mux_4__in4_stop_upstream;
  wire [0:0] mux_4__in4_valid_upstream;
  wire [31:0] mux_4__in5;
  wire [0:0] mux_4__in5_stop_upstream;
  wire [0:0] mux_4__in5_valid_upstream;
  wire [31:0] mux_4__in6;
  wire [0:0] mux_4__in6_stop_upstream;
  wire [0:0] mux_4__in6_valid_upstream;
  wire [31:0] mux_4__out;
  wire [0:0] mux_4__out_stop_downstream;
  wire [0:0] mux_4__out_valid_downstream;
  wire [2:0] mux_4__select;
  wire [0:0] mux_4__select_stop_upstream;
  wire [0:0] mux_4__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_4(
    .in0(mux_4__in0),
    .in0_stop_upstream(mux_4__in0_stop_upstream),
    .in0_valid_upstream(mux_4__in0_valid_upstream),
    .in1(mux_4__in1),
    .in1_stop_upstream(mux_4__in1_stop_upstream),
    .in1_valid_upstream(mux_4__in1_valid_upstream),
    .in2(mux_4__in2),
    .in2_stop_upstream(mux_4__in2_stop_upstream),
    .in2_valid_upstream(mux_4__in2_valid_upstream),
    .in3(mux_4__in3),
    .in3_stop_upstream(mux_4__in3_stop_upstream),
    .in3_valid_upstream(mux_4__in3_valid_upstream),
    .in4(mux_4__in4),
    .in4_stop_upstream(mux_4__in4_stop_upstream),
    .in4_valid_upstream(mux_4__in4_valid_upstream),
    .in5(mux_4__in5),
    .in5_stop_upstream(mux_4__in5_stop_upstream),
    .in5_valid_upstream(mux_4__in5_valid_upstream),
    .in6(mux_4__in6),
    .in6_stop_upstream(mux_4__in6_stop_upstream),
    .in6_valid_upstream(mux_4__in6_valid_upstream),
    .out(mux_4__out),
    .out_stop_downstream(mux_4__out_stop_downstream),
    .out_valid_downstream(mux_4__out_valid_downstream),
    .select(mux_4__select),
    .select_stop_upstream(mux_4__select_stop_upstream),
    .select_valid_upstream(mux_4__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_5' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_5__in0;
  wire [0:0] mux_5__in0_stop_upstream;
  wire [0:0] mux_5__in0_valid_upstream;
  wire [31:0] mux_5__in1;
  wire [0:0] mux_5__in1_stop_upstream;
  wire [0:0] mux_5__in1_valid_upstream;
  wire [31:0] mux_5__in2;
  wire [0:0] mux_5__in2_stop_upstream;
  wire [0:0] mux_5__in2_valid_upstream;
  wire [31:0] mux_5__in3;
  wire [0:0] mux_5__in3_stop_upstream;
  wire [0:0] mux_5__in3_valid_upstream;
  wire [31:0] mux_5__in4;
  wire [0:0] mux_5__in4_stop_upstream;
  wire [0:0] mux_5__in4_valid_upstream;
  wire [31:0] mux_5__in5;
  wire [0:0] mux_5__in5_stop_upstream;
  wire [0:0] mux_5__in5_valid_upstream;
  wire [31:0] mux_5__in6;
  wire [0:0] mux_5__in6_stop_upstream;
  wire [0:0] mux_5__in6_valid_upstream;
  wire [31:0] mux_5__out;
  wire [0:0] mux_5__out_stop_downstream;
  wire [0:0] mux_5__out_valid_downstream;
  wire [2:0] mux_5__select;
  wire [0:0] mux_5__select_stop_upstream;
  wire [0:0] mux_5__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_5(
    .in0(mux_5__in0),
    .in0_stop_upstream(mux_5__in0_stop_upstream),
    .in0_valid_upstream(mux_5__in0_valid_upstream),
    .in1(mux_5__in1),
    .in1_stop_upstream(mux_5__in1_stop_upstream),
    .in1_valid_upstream(mux_5__in1_valid_upstream),
    .in2(mux_5__in2),
    .in2_stop_upstream(mux_5__in2_stop_upstream),
    .in2_valid_upstream(mux_5__in2_valid_upstream),
    .in3(mux_5__in3),
    .in3_stop_upstream(mux_5__in3_stop_upstream),
    .in3_valid_upstream(mux_5__in3_valid_upstream),
    .in4(mux_5__in4),
    .in4_stop_upstream(mux_5__in4_stop_upstream),
    .in4_valid_upstream(mux_5__in4_valid_upstream),
    .in5(mux_5__in5),
    .in5_stop_upstream(mux_5__in5_stop_upstream),
    .in5_valid_upstream(mux_5__in5_valid_upstream),
    .in6(mux_5__in6),
    .in6_stop_upstream(mux_5__in6_stop_upstream),
    .in6_valid_upstream(mux_5__in6_valid_upstream),
    .out(mux_5__out),
    .out_stop_downstream(mux_5__out_stop_downstream),
    .out_valid_downstream(mux_5__out_valid_downstream),
    .select(mux_5__select),
    .select_stop_upstream(mux_5__select_stop_upstream),
    .select_valid_upstream(mux_5__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_6' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_6__in0;
  wire [0:0] mux_6__in0_stop_upstream;
  wire [0:0] mux_6__in0_valid_upstream;
  wire [31:0] mux_6__in1;
  wire [0:0] mux_6__in1_stop_upstream;
  wire [0:0] mux_6__in1_valid_upstream;
  wire [31:0] mux_6__in2;
  wire [0:0] mux_6__in2_stop_upstream;
  wire [0:0] mux_6__in2_valid_upstream;
  wire [31:0] mux_6__in3;
  wire [0:0] mux_6__in3_stop_upstream;
  wire [0:0] mux_6__in3_valid_upstream;
  wire [31:0] mux_6__in4;
  wire [0:0] mux_6__in4_stop_upstream;
  wire [0:0] mux_6__in4_valid_upstream;
  wire [31:0] mux_6__in5;
  wire [0:0] mux_6__in5_stop_upstream;
  wire [0:0] mux_6__in5_valid_upstream;
  wire [31:0] mux_6__in6;
  wire [0:0] mux_6__in6_stop_upstream;
  wire [0:0] mux_6__in6_valid_upstream;
  wire [31:0] mux_6__out;
  wire [0:0] mux_6__out_stop_downstream;
  wire [0:0] mux_6__out_valid_downstream;
  wire [2:0] mux_6__select;
  wire [0:0] mux_6__select_stop_upstream;
  wire [0:0] mux_6__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_6(
    .in0(mux_6__in0),
    .in0_stop_upstream(mux_6__in0_stop_upstream),
    .in0_valid_upstream(mux_6__in0_valid_upstream),
    .in1(mux_6__in1),
    .in1_stop_upstream(mux_6__in1_stop_upstream),
    .in1_valid_upstream(mux_6__in1_valid_upstream),
    .in2(mux_6__in2),
    .in2_stop_upstream(mux_6__in2_stop_upstream),
    .in2_valid_upstream(mux_6__in2_valid_upstream),
    .in3(mux_6__in3),
    .in3_stop_upstream(mux_6__in3_stop_upstream),
    .in3_valid_upstream(mux_6__in3_valid_upstream),
    .in4(mux_6__in4),
    .in4_stop_upstream(mux_6__in4_stop_upstream),
    .in4_valid_upstream(mux_6__in4_valid_upstream),
    .in5(mux_6__in5),
    .in5_stop_upstream(mux_6__in5_stop_upstream),
    .in5_valid_upstream(mux_6__in5_valid_upstream),
    .in6(mux_6__in6),
    .in6_stop_upstream(mux_6__in6_stop_upstream),
    .in6_valid_upstream(mux_6__in6_valid_upstream),
    .out(mux_6__out),
    .out_stop_downstream(mux_6__out_stop_downstream),
    .out_valid_downstream(mux_6__out_valid_downstream),
    .select(mux_6__select),
    .select_stop_upstream(mux_6__select_stop_upstream),
    .select_valid_upstream(mux_6__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_7' (Module cgrame_elastic_mux_7to1_32b)
  wire [31:0] mux_7__in0;
  wire [0:0] mux_7__in0_stop_upstream;
  wire [0:0] mux_7__in0_valid_upstream;
  wire [31:0] mux_7__in1;
  wire [0:0] mux_7__in1_stop_upstream;
  wire [0:0] mux_7__in1_valid_upstream;
  wire [31:0] mux_7__in2;
  wire [0:0] mux_7__in2_stop_upstream;
  wire [0:0] mux_7__in2_valid_upstream;
  wire [31:0] mux_7__in3;
  wire [0:0] mux_7__in3_stop_upstream;
  wire [0:0] mux_7__in3_valid_upstream;
  wire [31:0] mux_7__in4;
  wire [0:0] mux_7__in4_stop_upstream;
  wire [0:0] mux_7__in4_valid_upstream;
  wire [31:0] mux_7__in5;
  wire [0:0] mux_7__in5_stop_upstream;
  wire [0:0] mux_7__in5_valid_upstream;
  wire [31:0] mux_7__in6;
  wire [0:0] mux_7__in6_stop_upstream;
  wire [0:0] mux_7__in6_valid_upstream;
  wire [31:0] mux_7__out;
  wire [0:0] mux_7__out_stop_downstream;
  wire [0:0] mux_7__out_valid_downstream;
  wire [2:0] mux_7__select;
  wire [0:0] mux_7__select_stop_upstream;
  wire [0:0] mux_7__select_valid_upstream;
  cgrame_elastic_mux_7to1_32b #(.contexts(1),.size(32)) mux_7(
    .in0(mux_7__in0),
    .in0_stop_upstream(mux_7__in0_stop_upstream),
    .in0_valid_upstream(mux_7__in0_valid_upstream),
    .in1(mux_7__in1),
    .in1_stop_upstream(mux_7__in1_stop_upstream),
    .in1_valid_upstream(mux_7__in1_valid_upstream),
    .in2(mux_7__in2),
    .in2_stop_upstream(mux_7__in2_stop_upstream),
    .in2_valid_upstream(mux_7__in2_valid_upstream),
    .in3(mux_7__in3),
    .in3_stop_upstream(mux_7__in3_stop_upstream),
    .in3_valid_upstream(mux_7__in3_valid_upstream),
    .in4(mux_7__in4),
    .in4_stop_upstream(mux_7__in4_stop_upstream),
    .in4_valid_upstream(mux_7__in4_valid_upstream),
    .in5(mux_7__in5),
    .in5_stop_upstream(mux_7__in5_stop_upstream),
    .in5_valid_upstream(mux_7__in5_valid_upstream),
    .in6(mux_7__in6),
    .in6_stop_upstream(mux_7__in6_stop_upstream),
    .in6_valid_upstream(mux_7__in6_valid_upstream),
    .out(mux_7__out),
    .out_stop_downstream(mux_7__out_stop_downstream),
    .out_valid_downstream(mux_7__out_valid_downstream),
    .select(mux_7__select),
    .select_stop_upstream(mux_7__select_stop_upstream),
    .select_valid_upstream(mux_7__select_valid_upstream)
  );

  //All the connections
  assign fork_crossbar0__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar1__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar2__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar3__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar4__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar5__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar6__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar0Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar1Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar2Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar3Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar4Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar5Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar6Config__CGRA_Clock = CGRA_Clock;
  assign Mux0config__CGRA_Clock = CGRA_Clock;
  assign Mux1config__CGRA_Clock = CGRA_Clock;
  assign Mux2config__CGRA_Clock = CGRA_Clock;
  assign Mux3config__CGRA_Clock = CGRA_Clock;
  assign Mux4config__CGRA_Clock = CGRA_Clock;
  assign Mux5config__CGRA_Clock = CGRA_Clock;
  assign Mux6config__CGRA_Clock = CGRA_Clock;
  assign Mux7config__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar0__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar1__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar2__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar3__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar4__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar5__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar6__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar0Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar1Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar2Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar3Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar4Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar5Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar6Config__CGRA_Reset = CGRA_Reset;
  assign Mux0config__CGRA_Reset = CGRA_Reset;
  assign Mux1config__CGRA_Reset = CGRA_Reset;
  assign Mux2config__CGRA_Reset = CGRA_Reset;
  assign Mux3config__CGRA_Reset = CGRA_Reset;
  assign Mux4config__CGRA_Reset = CGRA_Reset;
  assign Mux5config__CGRA_Reset = CGRA_Reset;
  assign Mux6config__CGRA_Reset = CGRA_Reset;
  assign Mux7config__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar0__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar1__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar2__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar3__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar4__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar5__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar6__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar1Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar2Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar3Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar4Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar5Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar6Config__CGRA_Enable = CGRA_Enable;
  assign Mux0config__CGRA_Enable = CGRA_Enable;
  assign Mux1config__CGRA_Enable = CGRA_Enable;
  assign Mux2config__CGRA_Enable = CGRA_Enable;
  assign Mux3config__CGRA_Enable = CGRA_Enable;
  assign Mux4config__CGRA_Enable = CGRA_Enable;
  assign Mux5config__CGRA_Enable = CGRA_Enable;
  assign Mux6config__CGRA_Enable = CGRA_Enable;
  assign Mux7config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__Config_Clock = Config_Clock;
  assign ForkCrossbar1Config__Config_Clock = Config_Clock;
  assign ForkCrossbar2Config__Config_Clock = Config_Clock;
  assign ForkCrossbar3Config__Config_Clock = Config_Clock;
  assign ForkCrossbar4Config__Config_Clock = Config_Clock;
  assign ForkCrossbar5Config__Config_Clock = Config_Clock;
  assign ForkCrossbar6Config__Config_Clock = Config_Clock;
  assign Mux0config__Config_Clock = Config_Clock;
  assign Mux1config__Config_Clock = Config_Clock;
  assign Mux2config__Config_Clock = Config_Clock;
  assign Mux3config__Config_Clock = Config_Clock;
  assign Mux4config__Config_Clock = Config_Clock;
  assign Mux5config__Config_Clock = Config_Clock;
  assign Mux6config__Config_Clock = Config_Clock;
  assign Mux7config__Config_Clock = Config_Clock;
  assign ForkCrossbar0Config__Config_Reset = Config_Reset;
  assign ForkCrossbar1Config__Config_Reset = Config_Reset;
  assign ForkCrossbar2Config__Config_Reset = Config_Reset;
  assign ForkCrossbar3Config__Config_Reset = Config_Reset;
  assign ForkCrossbar4Config__Config_Reset = Config_Reset;
  assign ForkCrossbar5Config__Config_Reset = Config_Reset;
  assign ForkCrossbar6Config__Config_Reset = Config_Reset;
  assign Mux0config__Config_Reset = Config_Reset;
  assign Mux1config__Config_Reset = Config_Reset;
  assign Mux2config__Config_Reset = Config_Reset;
  assign Mux3config__Config_Reset = Config_Reset;
  assign Mux4config__Config_Reset = Config_Reset;
  assign Mux5config__Config_Reset = Config_Reset;
  assign Mux6config__Config_Reset = Config_Reset;
  assign Mux7config__Config_Reset = Config_Reset;
  assign fork_crossbar0__out0_stop_downstream[0:0] = mux_0__in0_stop_upstream[0:0];
  assign fork_crossbar1__out0_stop_downstream[0:0] = mux_0__in1_stop_upstream[0:0];
  assign fork_crossbar2__out0_stop_downstream[0:0] = mux_0__in2_stop_upstream[0:0];
  assign fork_crossbar3__out0_stop_downstream[0:0] = mux_0__in3_stop_upstream[0:0];
  assign fork_crossbar4__out0_stop_downstream[0:0] = mux_0__in4_stop_upstream[0:0];
  assign fork_crossbar5__out0_stop_downstream[0:0] = mux_0__in5_stop_upstream[0:0];
  assign fork_crossbar6__out0_stop_downstream[0:0] = mux_0__in6_stop_upstream[0:0];
  assign out0[31:0] = mux_0__out[31:0];
  assign out0_valid_downstream[0:0] = mux_0__out_valid_downstream[0:0];
  assign fork_crossbar0__out1_stop_downstream[0:0] = mux_1__in0_stop_upstream[0:0];
  assign fork_crossbar1__out1_stop_downstream[0:0] = mux_1__in1_stop_upstream[0:0];
  assign fork_crossbar2__out1_stop_downstream[0:0] = mux_1__in2_stop_upstream[0:0];
  assign fork_crossbar3__out1_stop_downstream[0:0] = mux_1__in3_stop_upstream[0:0];
  assign fork_crossbar4__out1_stop_downstream[0:0] = mux_1__in4_stop_upstream[0:0];
  assign fork_crossbar5__out1_stop_downstream[0:0] = mux_1__in5_stop_upstream[0:0];
  assign fork_crossbar6__out1_stop_downstream[0:0] = mux_1__in6_stop_upstream[0:0];
  assign out1[31:0] = mux_1__out[31:0];
  assign out1_valid_downstream[0:0] = mux_1__out_valid_downstream[0:0];
  assign fork_crossbar0__out2_stop_downstream[0:0] = mux_2__in0_stop_upstream[0:0];
  assign fork_crossbar1__out2_stop_downstream[0:0] = mux_2__in1_stop_upstream[0:0];
  assign fork_crossbar2__out2_stop_downstream[0:0] = mux_2__in2_stop_upstream[0:0];
  assign fork_crossbar3__out2_stop_downstream[0:0] = mux_2__in3_stop_upstream[0:0];
  assign fork_crossbar4__out2_stop_downstream[0:0] = mux_2__in4_stop_upstream[0:0];
  assign fork_crossbar5__out2_stop_downstream[0:0] = mux_2__in5_stop_upstream[0:0];
  assign fork_crossbar6__out2_stop_downstream[0:0] = mux_2__in6_stop_upstream[0:0];
  assign out2[31:0] = mux_2__out[31:0];
  assign out2_valid_downstream[0:0] = mux_2__out_valid_downstream[0:0];
  assign fork_crossbar0__out3_stop_downstream[0:0] = mux_3__in0_stop_upstream[0:0];
  assign fork_crossbar1__out3_stop_downstream[0:0] = mux_3__in1_stop_upstream[0:0];
  assign fork_crossbar2__out3_stop_downstream[0:0] = mux_3__in2_stop_upstream[0:0];
  assign fork_crossbar3__out3_stop_downstream[0:0] = mux_3__in3_stop_upstream[0:0];
  assign fork_crossbar4__out3_stop_downstream[0:0] = mux_3__in4_stop_upstream[0:0];
  assign fork_crossbar5__out3_stop_downstream[0:0] = mux_3__in5_stop_upstream[0:0];
  assign fork_crossbar6__out3_stop_downstream[0:0] = mux_3__in6_stop_upstream[0:0];
  assign out3[31:0] = mux_3__out[31:0];
  assign out3_valid_downstream[0:0] = mux_3__out_valid_downstream[0:0];
  assign fork_crossbar0__out4_stop_downstream[0:0] = mux_4__in0_stop_upstream[0:0];
  assign fork_crossbar1__out4_stop_downstream[0:0] = mux_4__in1_stop_upstream[0:0];
  assign fork_crossbar2__out4_stop_downstream[0:0] = mux_4__in2_stop_upstream[0:0];
  assign fork_crossbar3__out4_stop_downstream[0:0] = mux_4__in3_stop_upstream[0:0];
  assign fork_crossbar4__out4_stop_downstream[0:0] = mux_4__in4_stop_upstream[0:0];
  assign fork_crossbar5__out4_stop_downstream[0:0] = mux_4__in5_stop_upstream[0:0];
  assign fork_crossbar6__out4_stop_downstream[0:0] = mux_4__in6_stop_upstream[0:0];
  assign out4[31:0] = mux_4__out[31:0];
  assign out4_valid_downstream[0:0] = mux_4__out_valid_downstream[0:0];
  assign fork_crossbar0__out5_stop_downstream[0:0] = mux_5__in0_stop_upstream[0:0];
  assign fork_crossbar1__out5_stop_downstream[0:0] = mux_5__in1_stop_upstream[0:0];
  assign fork_crossbar2__out5_stop_downstream[0:0] = mux_5__in2_stop_upstream[0:0];
  assign fork_crossbar3__out5_stop_downstream[0:0] = mux_5__in3_stop_upstream[0:0];
  assign fork_crossbar4__out5_stop_downstream[0:0] = mux_5__in4_stop_upstream[0:0];
  assign fork_crossbar5__out5_stop_downstream[0:0] = mux_5__in5_stop_upstream[0:0];
  assign fork_crossbar6__out5_stop_downstream[0:0] = mux_5__in6_stop_upstream[0:0];
  assign out5[31:0] = mux_5__out[31:0];
  assign out5_valid_downstream[0:0] = mux_5__out_valid_downstream[0:0];
  assign fork_crossbar0__out6_stop_downstream[0:0] = mux_6__in0_stop_upstream[0:0];
  assign fork_crossbar1__out6_stop_downstream[0:0] = mux_6__in1_stop_upstream[0:0];
  assign fork_crossbar2__out6_stop_downstream[0:0] = mux_6__in2_stop_upstream[0:0];
  assign fork_crossbar3__out6_stop_downstream[0:0] = mux_6__in3_stop_upstream[0:0];
  assign fork_crossbar4__out6_stop_downstream[0:0] = mux_6__in4_stop_upstream[0:0];
  assign fork_crossbar5__out6_stop_downstream[0:0] = mux_6__in5_stop_upstream[0:0];
  assign fork_crossbar6__out6_stop_downstream[0:0] = mux_6__in6_stop_upstream[0:0];
  assign out6[31:0] = mux_6__out[31:0];
  assign out6_valid_downstream[0:0] = mux_6__out_valid_downstream[0:0];
  assign fork_crossbar0__out7_stop_downstream[0:0] = mux_7__in0_stop_upstream[0:0];
  assign fork_crossbar1__out7_stop_downstream[0:0] = mux_7__in1_stop_upstream[0:0];
  assign fork_crossbar2__out7_stop_downstream[0:0] = mux_7__in2_stop_upstream[0:0];
  assign fork_crossbar3__out7_stop_downstream[0:0] = mux_7__in3_stop_upstream[0:0];
  assign fork_crossbar4__out7_stop_downstream[0:0] = mux_7__in4_stop_upstream[0:0];
  assign fork_crossbar5__out7_stop_downstream[0:0] = mux_7__in5_stop_upstream[0:0];
  assign fork_crossbar6__out7_stop_downstream[0:0] = mux_7__in6_stop_upstream[0:0];
  assign out7[31:0] = mux_7__out[31:0];
  assign out7_valid_downstream[0:0] = mux_7__out_valid_downstream[0:0];
  assign fork_crossbar0__in[31:0] = in0[31:0];
  assign fork_crossbar0__in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign in0_stop_upstream[0:0] = fork_crossbar0__in_stop_upstream[0:0];
  assign mux_0__in0[31:0] = fork_crossbar0__out0[31:0];
  assign mux_0__in0_valid_upstream[0:0] = fork_crossbar0__out0_valid_downstream[0:0];
  assign mux_1__in0[31:0] = fork_crossbar0__out1[31:0];
  assign mux_1__in0_valid_upstream[0:0] = fork_crossbar0__out1_valid_downstream[0:0];
  assign mux_2__in0[31:0] = fork_crossbar0__out2[31:0];
  assign mux_2__in0_valid_upstream[0:0] = fork_crossbar0__out2_valid_downstream[0:0];
  assign mux_3__in0[31:0] = fork_crossbar0__out3[31:0];
  assign mux_3__in0_valid_upstream[0:0] = fork_crossbar0__out3_valid_downstream[0:0];
  assign mux_4__in0[31:0] = fork_crossbar0__out4[31:0];
  assign mux_4__in0_valid_upstream[0:0] = fork_crossbar0__out4_valid_downstream[0:0];
  assign mux_5__in0[31:0] = fork_crossbar0__out5[31:0];
  assign mux_5__in0_valid_upstream[0:0] = fork_crossbar0__out5_valid_downstream[0:0];
  assign mux_6__in0[31:0] = fork_crossbar0__out6[31:0];
  assign mux_6__in0_valid_upstream[0:0] = fork_crossbar0__out6_valid_downstream[0:0];
  assign mux_7__in0[31:0] = fork_crossbar0__out7[31:0];
  assign mux_7__in0_valid_upstream[0:0] = fork_crossbar0__out7_valid_downstream[0:0];
  assign fork_crossbar1__in[31:0] = in1[31:0];
  assign fork_crossbar1__in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign in1_stop_upstream[0:0] = fork_crossbar1__in_stop_upstream[0:0];
  assign mux_0__in1[31:0] = fork_crossbar1__out0[31:0];
  assign mux_0__in1_valid_upstream[0:0] = fork_crossbar1__out0_valid_downstream[0:0];
  assign mux_1__in1[31:0] = fork_crossbar1__out1[31:0];
  assign mux_1__in1_valid_upstream[0:0] = fork_crossbar1__out1_valid_downstream[0:0];
  assign mux_2__in1[31:0] = fork_crossbar1__out2[31:0];
  assign mux_2__in1_valid_upstream[0:0] = fork_crossbar1__out2_valid_downstream[0:0];
  assign mux_3__in1[31:0] = fork_crossbar1__out3[31:0];
  assign mux_3__in1_valid_upstream[0:0] = fork_crossbar1__out3_valid_downstream[0:0];
  assign mux_4__in1[31:0] = fork_crossbar1__out4[31:0];
  assign mux_4__in1_valid_upstream[0:0] = fork_crossbar1__out4_valid_downstream[0:0];
  assign mux_5__in1[31:0] = fork_crossbar1__out5[31:0];
  assign mux_5__in1_valid_upstream[0:0] = fork_crossbar1__out5_valid_downstream[0:0];
  assign mux_6__in1[31:0] = fork_crossbar1__out6[31:0];
  assign mux_6__in1_valid_upstream[0:0] = fork_crossbar1__out6_valid_downstream[0:0];
  assign mux_7__in1[31:0] = fork_crossbar1__out7[31:0];
  assign mux_7__in1_valid_upstream[0:0] = fork_crossbar1__out7_valid_downstream[0:0];
  assign fork_crossbar2__in[31:0] = in2[31:0];
  assign fork_crossbar2__in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign in2_stop_upstream[0:0] = fork_crossbar2__in_stop_upstream[0:0];
  assign mux_0__in2[31:0] = fork_crossbar2__out0[31:0];
  assign mux_0__in2_valid_upstream[0:0] = fork_crossbar2__out0_valid_downstream[0:0];
  assign mux_1__in2[31:0] = fork_crossbar2__out1[31:0];
  assign mux_1__in2_valid_upstream[0:0] = fork_crossbar2__out1_valid_downstream[0:0];
  assign mux_2__in2[31:0] = fork_crossbar2__out2[31:0];
  assign mux_2__in2_valid_upstream[0:0] = fork_crossbar2__out2_valid_downstream[0:0];
  assign mux_3__in2[31:0] = fork_crossbar2__out3[31:0];
  assign mux_3__in2_valid_upstream[0:0] = fork_crossbar2__out3_valid_downstream[0:0];
  assign mux_4__in2[31:0] = fork_crossbar2__out4[31:0];
  assign mux_4__in2_valid_upstream[0:0] = fork_crossbar2__out4_valid_downstream[0:0];
  assign mux_5__in2[31:0] = fork_crossbar2__out5[31:0];
  assign mux_5__in2_valid_upstream[0:0] = fork_crossbar2__out5_valid_downstream[0:0];
  assign mux_6__in2[31:0] = fork_crossbar2__out6[31:0];
  assign mux_6__in2_valid_upstream[0:0] = fork_crossbar2__out6_valid_downstream[0:0];
  assign mux_7__in2[31:0] = fork_crossbar2__out7[31:0];
  assign mux_7__in2_valid_upstream[0:0] = fork_crossbar2__out7_valid_downstream[0:0];
  assign fork_crossbar3__in[31:0] = in3[31:0];
  assign fork_crossbar3__in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign in3_stop_upstream[0:0] = fork_crossbar3__in_stop_upstream[0:0];
  assign mux_0__in3[31:0] = fork_crossbar3__out0[31:0];
  assign mux_0__in3_valid_upstream[0:0] = fork_crossbar3__out0_valid_downstream[0:0];
  assign mux_1__in3[31:0] = fork_crossbar3__out1[31:0];
  assign mux_1__in3_valid_upstream[0:0] = fork_crossbar3__out1_valid_downstream[0:0];
  assign mux_2__in3[31:0] = fork_crossbar3__out2[31:0];
  assign mux_2__in3_valid_upstream[0:0] = fork_crossbar3__out2_valid_downstream[0:0];
  assign mux_3__in3[31:0] = fork_crossbar3__out3[31:0];
  assign mux_3__in3_valid_upstream[0:0] = fork_crossbar3__out3_valid_downstream[0:0];
  assign mux_4__in3[31:0] = fork_crossbar3__out4[31:0];
  assign mux_4__in3_valid_upstream[0:0] = fork_crossbar3__out4_valid_downstream[0:0];
  assign mux_5__in3[31:0] = fork_crossbar3__out5[31:0];
  assign mux_5__in3_valid_upstream[0:0] = fork_crossbar3__out5_valid_downstream[0:0];
  assign mux_6__in3[31:0] = fork_crossbar3__out6[31:0];
  assign mux_6__in3_valid_upstream[0:0] = fork_crossbar3__out6_valid_downstream[0:0];
  assign mux_7__in3[31:0] = fork_crossbar3__out7[31:0];
  assign mux_7__in3_valid_upstream[0:0] = fork_crossbar3__out7_valid_downstream[0:0];
  assign fork_crossbar4__in[31:0] = in4[31:0];
  assign fork_crossbar4__in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign in4_stop_upstream[0:0] = fork_crossbar4__in_stop_upstream[0:0];
  assign mux_0__in4[31:0] = fork_crossbar4__out0[31:0];
  assign mux_0__in4_valid_upstream[0:0] = fork_crossbar4__out0_valid_downstream[0:0];
  assign mux_1__in4[31:0] = fork_crossbar4__out1[31:0];
  assign mux_1__in4_valid_upstream[0:0] = fork_crossbar4__out1_valid_downstream[0:0];
  assign mux_2__in4[31:0] = fork_crossbar4__out2[31:0];
  assign mux_2__in4_valid_upstream[0:0] = fork_crossbar4__out2_valid_downstream[0:0];
  assign mux_3__in4[31:0] = fork_crossbar4__out3[31:0];
  assign mux_3__in4_valid_upstream[0:0] = fork_crossbar4__out3_valid_downstream[0:0];
  assign mux_4__in4[31:0] = fork_crossbar4__out4[31:0];
  assign mux_4__in4_valid_upstream[0:0] = fork_crossbar4__out4_valid_downstream[0:0];
  assign mux_5__in4[31:0] = fork_crossbar4__out5[31:0];
  assign mux_5__in4_valid_upstream[0:0] = fork_crossbar4__out5_valid_downstream[0:0];
  assign mux_6__in4[31:0] = fork_crossbar4__out6[31:0];
  assign mux_6__in4_valid_upstream[0:0] = fork_crossbar4__out6_valid_downstream[0:0];
  assign mux_7__in4[31:0] = fork_crossbar4__out7[31:0];
  assign mux_7__in4_valid_upstream[0:0] = fork_crossbar4__out7_valid_downstream[0:0];
  assign fork_crossbar5__in[31:0] = in5[31:0];
  assign fork_crossbar5__in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign in5_stop_upstream[0:0] = fork_crossbar5__in_stop_upstream[0:0];
  assign mux_0__in5[31:0] = fork_crossbar5__out0[31:0];
  assign mux_0__in5_valid_upstream[0:0] = fork_crossbar5__out0_valid_downstream[0:0];
  assign mux_1__in5[31:0] = fork_crossbar5__out1[31:0];
  assign mux_1__in5_valid_upstream[0:0] = fork_crossbar5__out1_valid_downstream[0:0];
  assign mux_2__in5[31:0] = fork_crossbar5__out2[31:0];
  assign mux_2__in5_valid_upstream[0:0] = fork_crossbar5__out2_valid_downstream[0:0];
  assign mux_3__in5[31:0] = fork_crossbar5__out3[31:0];
  assign mux_3__in5_valid_upstream[0:0] = fork_crossbar5__out3_valid_downstream[0:0];
  assign mux_4__in5[31:0] = fork_crossbar5__out4[31:0];
  assign mux_4__in5_valid_upstream[0:0] = fork_crossbar5__out4_valid_downstream[0:0];
  assign mux_5__in5[31:0] = fork_crossbar5__out5[31:0];
  assign mux_5__in5_valid_upstream[0:0] = fork_crossbar5__out5_valid_downstream[0:0];
  assign mux_6__in5[31:0] = fork_crossbar5__out6[31:0];
  assign mux_6__in5_valid_upstream[0:0] = fork_crossbar5__out6_valid_downstream[0:0];
  assign mux_7__in5[31:0] = fork_crossbar5__out7[31:0];
  assign mux_7__in5_valid_upstream[0:0] = fork_crossbar5__out7_valid_downstream[0:0];
  assign fork_crossbar6__in[31:0] = in6[31:0];
  assign fork_crossbar6__in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign in6_stop_upstream[0:0] = fork_crossbar6__in_stop_upstream[0:0];
  assign mux_0__in6[31:0] = fork_crossbar6__out0[31:0];
  assign mux_0__in6_valid_upstream[0:0] = fork_crossbar6__out0_valid_downstream[0:0];
  assign mux_1__in6[31:0] = fork_crossbar6__out1[31:0];
  assign mux_1__in6_valid_upstream[0:0] = fork_crossbar6__out1_valid_downstream[0:0];
  assign mux_2__in6[31:0] = fork_crossbar6__out2[31:0];
  assign mux_2__in6_valid_upstream[0:0] = fork_crossbar6__out2_valid_downstream[0:0];
  assign mux_3__in6[31:0] = fork_crossbar6__out3[31:0];
  assign mux_3__in6_valid_upstream[0:0] = fork_crossbar6__out3_valid_downstream[0:0];
  assign mux_4__in6[31:0] = fork_crossbar6__out4[31:0];
  assign mux_4__in6_valid_upstream[0:0] = fork_crossbar6__out4_valid_downstream[0:0];
  assign mux_5__in6[31:0] = fork_crossbar6__out5[31:0];
  assign mux_5__in6_valid_upstream[0:0] = fork_crossbar6__out5_valid_downstream[0:0];
  assign mux_6__in6[31:0] = fork_crossbar6__out6[31:0];
  assign mux_6__in6_valid_upstream[0:0] = fork_crossbar6__out6_valid_downstream[0:0];
  assign mux_7__in6[31:0] = fork_crossbar6__out7[31:0];
  assign mux_7__in6_valid_upstream[0:0] = fork_crossbar6__out7_valid_downstream[0:0];
  assign mux_0__out_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign mux_1__out_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign mux_2__out_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign mux_3__out_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign mux_4__out_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign mux_5__out_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign mux_6__out_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign mux_7__out_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign fork_crossbar0__enable_downstream[7:0] = ForkCrossbar0Config__select[7:0];
  assign ForkCrossbar0Config__valid[0:0] = fork_crossbar0__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar0Config__stop[0:0] = fork_crossbar0__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar1__enable_downstream[7:0] = ForkCrossbar1Config__select[7:0];
  assign ForkCrossbar1Config__valid[0:0] = fork_crossbar1__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar1Config__stop[0:0] = fork_crossbar1__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar2__enable_downstream[7:0] = ForkCrossbar2Config__select[7:0];
  assign ForkCrossbar2Config__valid[0:0] = fork_crossbar2__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar2Config__stop[0:0] = fork_crossbar2__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar3__enable_downstream[7:0] = ForkCrossbar3Config__select[7:0];
  assign ForkCrossbar3Config__valid[0:0] = fork_crossbar3__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar3Config__stop[0:0] = fork_crossbar3__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar4__enable_downstream[7:0] = ForkCrossbar4Config__select[7:0];
  assign ForkCrossbar4Config__valid[0:0] = fork_crossbar4__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar4Config__stop[0:0] = fork_crossbar4__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar5__enable_downstream[7:0] = ForkCrossbar5Config__select[7:0];
  assign ForkCrossbar5Config__valid[0:0] = fork_crossbar5__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar5Config__stop[0:0] = fork_crossbar5__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar6__enable_downstream[7:0] = ForkCrossbar6Config__select[7:0];
  assign ForkCrossbar6Config__valid[0:0] = fork_crossbar6__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar6Config__stop[0:0] = fork_crossbar6__enable_downstream_stop_upstream[0:0];
  assign mux_0__select[2:0] = Mux0config__select[2:0];
  assign Mux0config__valid[0:0] = mux_0__select_valid_upstream[0:0];
  assign Mux0config__stop[0:0] = mux_0__select_stop_upstream[0:0];
  assign mux_1__select[2:0] = Mux1config__select[2:0];
  assign Mux1config__valid[0:0] = mux_1__select_valid_upstream[0:0];
  assign Mux1config__stop[0:0] = mux_1__select_stop_upstream[0:0];
  assign mux_2__select[2:0] = Mux2config__select[2:0];
  assign Mux2config__valid[0:0] = mux_2__select_valid_upstream[0:0];
  assign Mux2config__stop[0:0] = mux_2__select_stop_upstream[0:0];
  assign mux_3__select[2:0] = Mux3config__select[2:0];
  assign Mux3config__valid[0:0] = mux_3__select_valid_upstream[0:0];
  assign Mux3config__stop[0:0] = mux_3__select_stop_upstream[0:0];
  assign mux_4__select[2:0] = Mux4config__select[2:0];
  assign Mux4config__valid[0:0] = mux_4__select_valid_upstream[0:0];
  assign Mux4config__stop[0:0] = mux_4__select_stop_upstream[0:0];
  assign mux_5__select[2:0] = Mux5config__select[2:0];
  assign Mux5config__valid[0:0] = mux_5__select_valid_upstream[0:0];
  assign Mux5config__stop[0:0] = mux_5__select_stop_upstream[0:0];
  assign mux_6__select[2:0] = Mux6config__select[2:0];
  assign Mux6config__valid[0:0] = mux_6__select_valid_upstream[0:0];
  assign Mux6config__stop[0:0] = mux_6__select_stop_upstream[0:0];
  assign mux_7__select[2:0] = Mux7config__select[2:0];
  assign Mux7config__valid[0:0] = mux_7__select_valid_upstream[0:0];
  assign Mux7config__stop[0:0] = mux_7__select_stop_upstream[0:0];
  assign ForkCrossbar0Config__ConfigIn = ConfigIn;
  assign ForkCrossbar1Config__ConfigIn = ForkCrossbar0Config__ConfigOut;
  assign ForkCrossbar2Config__ConfigIn = ForkCrossbar1Config__ConfigOut;
  assign ForkCrossbar3Config__ConfigIn = ForkCrossbar2Config__ConfigOut;
  assign ForkCrossbar4Config__ConfigIn = ForkCrossbar3Config__ConfigOut;
  assign ForkCrossbar5Config__ConfigIn = ForkCrossbar4Config__ConfigOut;
  assign ForkCrossbar6Config__ConfigIn = ForkCrossbar5Config__ConfigOut;
  assign Mux0config__ConfigIn = ForkCrossbar6Config__ConfigOut;
  assign Mux1config__ConfigIn = Mux0config__ConfigOut;
  assign Mux2config__ConfigIn = Mux1config__ConfigOut;
  assign Mux3config__ConfigIn = Mux2config__ConfigOut;
  assign Mux4config__ConfigIn = Mux3config__ConfigOut;
  assign Mux5config__ConfigIn = Mux4config__ConfigOut;
  assign Mux6config__ConfigIn = Mux5config__ConfigOut;
  assign Mux7config__ConfigIn = Mux6config__ConfigOut;
  assign ConfigOut = Mux7config__ConfigOut;

endmodule //elastic_crossbar_7in_8out_size_32_U19

module cgrame_elastic_mux_9to1_32b #(parameter contexts=1, parameter size=1) (
  in0,
  in0_stop_upstream,
  in0_valid_upstream,
  in1,
  in1_stop_upstream,
  in1_valid_upstream,
  in2,
  in2_stop_upstream,
  in2_valid_upstream,
  in3,
  in3_stop_upstream,
  in3_valid_upstream,
  in4,
  in4_stop_upstream,
  in4_valid_upstream,
  in5,
  in5_stop_upstream,
  in5_valid_upstream,
  in6,
  in6_stop_upstream,
  in6_valid_upstream,
  in7,
  in7_stop_upstream,
  in7_valid_upstream,
  in8,
  in8_stop_upstream,
  in8_valid_upstream,
  out,
  out_stop_downstream,
  out_valid_downstream,
  select,
  select_stop_upstream,
  select_valid_upstream
);
    input [size-1:0] in0;
    output reg [0:0] in0_stop_upstream;
    input [0:0] in0_valid_upstream;
    input [size-1:0] in1;
    output reg [0:0] in1_stop_upstream;
    input [0:0] in1_valid_upstream;
    input [size-1:0] in2;
    output reg [0:0] in2_stop_upstream;
    input [0:0] in2_valid_upstream;
    input [size-1:0] in3;
    output reg [0:0] in3_stop_upstream;
    input [0:0] in3_valid_upstream;
    input [size-1:0] in4;
    output reg [0:0] in4_stop_upstream;
    input [0:0] in4_valid_upstream;
    input [size-1:0] in5;
    output reg [0:0] in5_stop_upstream;
    input [0:0] in5_valid_upstream;
    input [size-1:0] in6;
    output reg [0:0] in6_stop_upstream;
    input [0:0] in6_valid_upstream;
    input [size-1:0] in7;
    output reg [0:0] in7_stop_upstream;
    input [0:0] in7_valid_upstream;
    input [size-1:0] in8;
    output reg [0:0] in8_stop_upstream;
    input [0:0] in8_valid_upstream;
    output reg [size-1:0] out;
    input [0:0] out_stop_downstream;
    output reg [0:0] out_valid_downstream;
    input [3:0] select;
    output [0:0] select_stop_upstream;
    output [0:0] select_valid_upstream;
    always @(*)
        case (select)
            0:begin
                 out = in0;
                 out_valid_downstream = in0_valid_upstream;
                 in0_stop_upstream = out_stop_downstream;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            1:begin
                 out = in1;
                 out_valid_downstream = in1_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = out_stop_downstream;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            2:begin
                 out = in2;
                 out_valid_downstream = in2_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = out_stop_downstream;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            3:begin
                 out = in3;
                 out_valid_downstream = in3_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = out_stop_downstream;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            4:begin
                 out = in4;
                 out_valid_downstream = in4_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = out_stop_downstream;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            5:begin
                 out = in5;
                 out_valid_downstream = in5_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = out_stop_downstream;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            6:begin
                 out = in6;
                 out_valid_downstream = in6_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = out_stop_downstream;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = 1'b1;
            end
            7:begin
                 out = in7;
                 out_valid_downstream = in7_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = out_stop_downstream;
                 in8_stop_upstream = 1'b1;
            end
            8:begin
                 out = in8;
                 out_valid_downstream = in8_valid_upstream;
                 in0_stop_upstream = 1'b1;
                 in1_stop_upstream = 1'b1;
                 in2_stop_upstream = 1'b1;
                 in3_stop_upstream = 1'b1;
                 in4_stop_upstream = 1'b1;
                 in5_stop_upstream = 1'b1;
                 in6_stop_upstream = 1'b1;
                 in7_stop_upstream = 1'b1;
                 in8_stop_upstream = out_stop_downstream;
            end
            default: out = {size{1'bx}};
        endcase
        assign select_stop_upstream = out_stop_downstream;
        assign select_valid_upstream = out_valid_downstream;


endmodule //cgrame_elastic_mux_9to1_32b

module elastic_crossbar_9in_10out_size_32_U22 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  input [31:0] in7,
  output [0:0] in7_stop_upstream,
  input [0:0] in7_valid_upstream,
  input [31:0] in8,
  output [0:0] in8_stop_upstream,
  input [0:0] in8_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream,
  output [31:0] out8,
  input [0:0] out8_stop_downstream,
  output [0:0] out8_valid_downstream,
  output [31:0] out9,
  input [0:0] out9_stop_downstream,
  output [0:0] out9_valid_downstream
);
  //Wire declarations for instance 'ForkCrossbar0Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar0Config__CGRA_Clock;
  wire  ForkCrossbar0Config__CGRA_Enable;
  wire  ForkCrossbar0Config__CGRA_Reset;
  wire  ForkCrossbar0Config__ConfigIn;
  wire  ForkCrossbar0Config__ConfigOut;
  wire  ForkCrossbar0Config__Config_Clock;
  wire  ForkCrossbar0Config__Config_Reset;
  wire [9:0] ForkCrossbar0Config__select;
  wire [0:0] ForkCrossbar0Config__stop;
  wire [0:0] ForkCrossbar0Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar0Config(
    .CGRA_Clock(ForkCrossbar0Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar0Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar0Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar0Config__ConfigIn),
    .ConfigOut(ForkCrossbar0Config__ConfigOut),
    .Config_Clock(ForkCrossbar0Config__Config_Clock),
    .Config_Reset(ForkCrossbar0Config__Config_Reset),
    .select(ForkCrossbar0Config__select),
    .stop(ForkCrossbar0Config__stop),
    .valid(ForkCrossbar0Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar1Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar1Config__CGRA_Clock;
  wire  ForkCrossbar1Config__CGRA_Enable;
  wire  ForkCrossbar1Config__CGRA_Reset;
  wire  ForkCrossbar1Config__ConfigIn;
  wire  ForkCrossbar1Config__ConfigOut;
  wire  ForkCrossbar1Config__Config_Clock;
  wire  ForkCrossbar1Config__Config_Reset;
  wire [9:0] ForkCrossbar1Config__select;
  wire [0:0] ForkCrossbar1Config__stop;
  wire [0:0] ForkCrossbar1Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar1Config(
    .CGRA_Clock(ForkCrossbar1Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar1Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar1Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar1Config__ConfigIn),
    .ConfigOut(ForkCrossbar1Config__ConfigOut),
    .Config_Clock(ForkCrossbar1Config__Config_Clock),
    .Config_Reset(ForkCrossbar1Config__Config_Reset),
    .select(ForkCrossbar1Config__select),
    .stop(ForkCrossbar1Config__stop),
    .valid(ForkCrossbar1Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar2Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar2Config__CGRA_Clock;
  wire  ForkCrossbar2Config__CGRA_Enable;
  wire  ForkCrossbar2Config__CGRA_Reset;
  wire  ForkCrossbar2Config__ConfigIn;
  wire  ForkCrossbar2Config__ConfigOut;
  wire  ForkCrossbar2Config__Config_Clock;
  wire  ForkCrossbar2Config__Config_Reset;
  wire [9:0] ForkCrossbar2Config__select;
  wire [0:0] ForkCrossbar2Config__stop;
  wire [0:0] ForkCrossbar2Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar2Config(
    .CGRA_Clock(ForkCrossbar2Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar2Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar2Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar2Config__ConfigIn),
    .ConfigOut(ForkCrossbar2Config__ConfigOut),
    .Config_Clock(ForkCrossbar2Config__Config_Clock),
    .Config_Reset(ForkCrossbar2Config__Config_Reset),
    .select(ForkCrossbar2Config__select),
    .stop(ForkCrossbar2Config__stop),
    .valid(ForkCrossbar2Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar3Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar3Config__CGRA_Clock;
  wire  ForkCrossbar3Config__CGRA_Enable;
  wire  ForkCrossbar3Config__CGRA_Reset;
  wire  ForkCrossbar3Config__ConfigIn;
  wire  ForkCrossbar3Config__ConfigOut;
  wire  ForkCrossbar3Config__Config_Clock;
  wire  ForkCrossbar3Config__Config_Reset;
  wire [9:0] ForkCrossbar3Config__select;
  wire [0:0] ForkCrossbar3Config__stop;
  wire [0:0] ForkCrossbar3Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar3Config(
    .CGRA_Clock(ForkCrossbar3Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar3Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar3Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar3Config__ConfigIn),
    .ConfigOut(ForkCrossbar3Config__ConfigOut),
    .Config_Clock(ForkCrossbar3Config__Config_Clock),
    .Config_Reset(ForkCrossbar3Config__Config_Reset),
    .select(ForkCrossbar3Config__select),
    .stop(ForkCrossbar3Config__stop),
    .valid(ForkCrossbar3Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar4Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar4Config__CGRA_Clock;
  wire  ForkCrossbar4Config__CGRA_Enable;
  wire  ForkCrossbar4Config__CGRA_Reset;
  wire  ForkCrossbar4Config__ConfigIn;
  wire  ForkCrossbar4Config__ConfigOut;
  wire  ForkCrossbar4Config__Config_Clock;
  wire  ForkCrossbar4Config__Config_Reset;
  wire [9:0] ForkCrossbar4Config__select;
  wire [0:0] ForkCrossbar4Config__stop;
  wire [0:0] ForkCrossbar4Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar4Config(
    .CGRA_Clock(ForkCrossbar4Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar4Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar4Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar4Config__ConfigIn),
    .ConfigOut(ForkCrossbar4Config__ConfigOut),
    .Config_Clock(ForkCrossbar4Config__Config_Clock),
    .Config_Reset(ForkCrossbar4Config__Config_Reset),
    .select(ForkCrossbar4Config__select),
    .stop(ForkCrossbar4Config__stop),
    .valid(ForkCrossbar4Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar5Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar5Config__CGRA_Clock;
  wire  ForkCrossbar5Config__CGRA_Enable;
  wire  ForkCrossbar5Config__CGRA_Reset;
  wire  ForkCrossbar5Config__ConfigIn;
  wire  ForkCrossbar5Config__ConfigOut;
  wire  ForkCrossbar5Config__Config_Clock;
  wire  ForkCrossbar5Config__Config_Reset;
  wire [9:0] ForkCrossbar5Config__select;
  wire [0:0] ForkCrossbar5Config__stop;
  wire [0:0] ForkCrossbar5Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar5Config(
    .CGRA_Clock(ForkCrossbar5Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar5Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar5Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar5Config__ConfigIn),
    .ConfigOut(ForkCrossbar5Config__ConfigOut),
    .Config_Clock(ForkCrossbar5Config__Config_Clock),
    .Config_Reset(ForkCrossbar5Config__Config_Reset),
    .select(ForkCrossbar5Config__select),
    .stop(ForkCrossbar5Config__stop),
    .valid(ForkCrossbar5Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar6Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar6Config__CGRA_Clock;
  wire  ForkCrossbar6Config__CGRA_Enable;
  wire  ForkCrossbar6Config__CGRA_Reset;
  wire  ForkCrossbar6Config__ConfigIn;
  wire  ForkCrossbar6Config__ConfigOut;
  wire  ForkCrossbar6Config__Config_Clock;
  wire  ForkCrossbar6Config__Config_Reset;
  wire [9:0] ForkCrossbar6Config__select;
  wire [0:0] ForkCrossbar6Config__stop;
  wire [0:0] ForkCrossbar6Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar6Config(
    .CGRA_Clock(ForkCrossbar6Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar6Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar6Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar6Config__ConfigIn),
    .ConfigOut(ForkCrossbar6Config__ConfigOut),
    .Config_Clock(ForkCrossbar6Config__Config_Clock),
    .Config_Reset(ForkCrossbar6Config__Config_Reset),
    .select(ForkCrossbar6Config__select),
    .stop(ForkCrossbar6Config__stop),
    .valid(ForkCrossbar6Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar7Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar7Config__CGRA_Clock;
  wire  ForkCrossbar7Config__CGRA_Enable;
  wire  ForkCrossbar7Config__CGRA_Reset;
  wire  ForkCrossbar7Config__ConfigIn;
  wire  ForkCrossbar7Config__ConfigOut;
  wire  ForkCrossbar7Config__Config_Clock;
  wire  ForkCrossbar7Config__Config_Reset;
  wire [9:0] ForkCrossbar7Config__select;
  wire [0:0] ForkCrossbar7Config__stop;
  wire [0:0] ForkCrossbar7Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar7Config(
    .CGRA_Clock(ForkCrossbar7Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar7Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar7Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar7Config__ConfigIn),
    .ConfigOut(ForkCrossbar7Config__ConfigOut),
    .Config_Clock(ForkCrossbar7Config__Config_Clock),
    .Config_Reset(ForkCrossbar7Config__Config_Reset),
    .select(ForkCrossbar7Config__select),
    .stop(ForkCrossbar7Config__stop),
    .valid(ForkCrossbar7Config__valid)
  );

  //Wire declarations for instance 'ForkCrossbar8Config' (Module cgrame_elastic_configcell_context_size10II1)
  wire  ForkCrossbar8Config__CGRA_Clock;
  wire  ForkCrossbar8Config__CGRA_Enable;
  wire  ForkCrossbar8Config__CGRA_Reset;
  wire  ForkCrossbar8Config__ConfigIn;
  wire  ForkCrossbar8Config__ConfigOut;
  wire  ForkCrossbar8Config__Config_Clock;
  wire  ForkCrossbar8Config__Config_Reset;
  wire [9:0] ForkCrossbar8Config__select;
  wire [0:0] ForkCrossbar8Config__stop;
  wire [0:0] ForkCrossbar8Config__valid;
  cgrame_elastic_configcell_context_size10II1 #(.contexts(1),.size(10)) ForkCrossbar8Config(
    .CGRA_Clock(ForkCrossbar8Config__CGRA_Clock),
    .CGRA_Enable(ForkCrossbar8Config__CGRA_Enable),
    .CGRA_Reset(ForkCrossbar8Config__CGRA_Reset),
    .ConfigIn(ForkCrossbar8Config__ConfigIn),
    .ConfigOut(ForkCrossbar8Config__ConfigOut),
    .Config_Clock(ForkCrossbar8Config__Config_Clock),
    .Config_Reset(ForkCrossbar8Config__Config_Reset),
    .select(ForkCrossbar8Config__select),
    .stop(ForkCrossbar8Config__stop),
    .valid(ForkCrossbar8Config__valid)
  );

  //Wire declarations for instance 'Mux0config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux0config__CGRA_Clock;
  wire  Mux0config__CGRA_Enable;
  wire  Mux0config__CGRA_Reset;
  wire  Mux0config__ConfigIn;
  wire  Mux0config__ConfigOut;
  wire  Mux0config__Config_Clock;
  wire  Mux0config__Config_Reset;
  wire [3:0] Mux0config__select;
  wire [0:0] Mux0config__stop;
  wire [0:0] Mux0config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux0config(
    .CGRA_Clock(Mux0config__CGRA_Clock),
    .CGRA_Enable(Mux0config__CGRA_Enable),
    .CGRA_Reset(Mux0config__CGRA_Reset),
    .ConfigIn(Mux0config__ConfigIn),
    .ConfigOut(Mux0config__ConfigOut),
    .Config_Clock(Mux0config__Config_Clock),
    .Config_Reset(Mux0config__Config_Reset),
    .select(Mux0config__select),
    .stop(Mux0config__stop),
    .valid(Mux0config__valid)
  );

  //Wire declarations for instance 'Mux1config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux1config__CGRA_Clock;
  wire  Mux1config__CGRA_Enable;
  wire  Mux1config__CGRA_Reset;
  wire  Mux1config__ConfigIn;
  wire  Mux1config__ConfigOut;
  wire  Mux1config__Config_Clock;
  wire  Mux1config__Config_Reset;
  wire [3:0] Mux1config__select;
  wire [0:0] Mux1config__stop;
  wire [0:0] Mux1config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux1config(
    .CGRA_Clock(Mux1config__CGRA_Clock),
    .CGRA_Enable(Mux1config__CGRA_Enable),
    .CGRA_Reset(Mux1config__CGRA_Reset),
    .ConfigIn(Mux1config__ConfigIn),
    .ConfigOut(Mux1config__ConfigOut),
    .Config_Clock(Mux1config__Config_Clock),
    .Config_Reset(Mux1config__Config_Reset),
    .select(Mux1config__select),
    .stop(Mux1config__stop),
    .valid(Mux1config__valid)
  );

  //Wire declarations for instance 'Mux2config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux2config__CGRA_Clock;
  wire  Mux2config__CGRA_Enable;
  wire  Mux2config__CGRA_Reset;
  wire  Mux2config__ConfigIn;
  wire  Mux2config__ConfigOut;
  wire  Mux2config__Config_Clock;
  wire  Mux2config__Config_Reset;
  wire [3:0] Mux2config__select;
  wire [0:0] Mux2config__stop;
  wire [0:0] Mux2config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux2config(
    .CGRA_Clock(Mux2config__CGRA_Clock),
    .CGRA_Enable(Mux2config__CGRA_Enable),
    .CGRA_Reset(Mux2config__CGRA_Reset),
    .ConfigIn(Mux2config__ConfigIn),
    .ConfigOut(Mux2config__ConfigOut),
    .Config_Clock(Mux2config__Config_Clock),
    .Config_Reset(Mux2config__Config_Reset),
    .select(Mux2config__select),
    .stop(Mux2config__stop),
    .valid(Mux2config__valid)
  );

  //Wire declarations for instance 'Mux3config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux3config__CGRA_Clock;
  wire  Mux3config__CGRA_Enable;
  wire  Mux3config__CGRA_Reset;
  wire  Mux3config__ConfigIn;
  wire  Mux3config__ConfigOut;
  wire  Mux3config__Config_Clock;
  wire  Mux3config__Config_Reset;
  wire [3:0] Mux3config__select;
  wire [0:0] Mux3config__stop;
  wire [0:0] Mux3config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux3config(
    .CGRA_Clock(Mux3config__CGRA_Clock),
    .CGRA_Enable(Mux3config__CGRA_Enable),
    .CGRA_Reset(Mux3config__CGRA_Reset),
    .ConfigIn(Mux3config__ConfigIn),
    .ConfigOut(Mux3config__ConfigOut),
    .Config_Clock(Mux3config__Config_Clock),
    .Config_Reset(Mux3config__Config_Reset),
    .select(Mux3config__select),
    .stop(Mux3config__stop),
    .valid(Mux3config__valid)
  );

  //Wire declarations for instance 'Mux4config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux4config__CGRA_Clock;
  wire  Mux4config__CGRA_Enable;
  wire  Mux4config__CGRA_Reset;
  wire  Mux4config__ConfigIn;
  wire  Mux4config__ConfigOut;
  wire  Mux4config__Config_Clock;
  wire  Mux4config__Config_Reset;
  wire [3:0] Mux4config__select;
  wire [0:0] Mux4config__stop;
  wire [0:0] Mux4config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux4config(
    .CGRA_Clock(Mux4config__CGRA_Clock),
    .CGRA_Enable(Mux4config__CGRA_Enable),
    .CGRA_Reset(Mux4config__CGRA_Reset),
    .ConfigIn(Mux4config__ConfigIn),
    .ConfigOut(Mux4config__ConfigOut),
    .Config_Clock(Mux4config__Config_Clock),
    .Config_Reset(Mux4config__Config_Reset),
    .select(Mux4config__select),
    .stop(Mux4config__stop),
    .valid(Mux4config__valid)
  );

  //Wire declarations for instance 'Mux5config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux5config__CGRA_Clock;
  wire  Mux5config__CGRA_Enable;
  wire  Mux5config__CGRA_Reset;
  wire  Mux5config__ConfigIn;
  wire  Mux5config__ConfigOut;
  wire  Mux5config__Config_Clock;
  wire  Mux5config__Config_Reset;
  wire [3:0] Mux5config__select;
  wire [0:0] Mux5config__stop;
  wire [0:0] Mux5config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux5config(
    .CGRA_Clock(Mux5config__CGRA_Clock),
    .CGRA_Enable(Mux5config__CGRA_Enable),
    .CGRA_Reset(Mux5config__CGRA_Reset),
    .ConfigIn(Mux5config__ConfigIn),
    .ConfigOut(Mux5config__ConfigOut),
    .Config_Clock(Mux5config__Config_Clock),
    .Config_Reset(Mux5config__Config_Reset),
    .select(Mux5config__select),
    .stop(Mux5config__stop),
    .valid(Mux5config__valid)
  );

  //Wire declarations for instance 'Mux6config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux6config__CGRA_Clock;
  wire  Mux6config__CGRA_Enable;
  wire  Mux6config__CGRA_Reset;
  wire  Mux6config__ConfigIn;
  wire  Mux6config__ConfigOut;
  wire  Mux6config__Config_Clock;
  wire  Mux6config__Config_Reset;
  wire [3:0] Mux6config__select;
  wire [0:0] Mux6config__stop;
  wire [0:0] Mux6config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux6config(
    .CGRA_Clock(Mux6config__CGRA_Clock),
    .CGRA_Enable(Mux6config__CGRA_Enable),
    .CGRA_Reset(Mux6config__CGRA_Reset),
    .ConfigIn(Mux6config__ConfigIn),
    .ConfigOut(Mux6config__ConfigOut),
    .Config_Clock(Mux6config__Config_Clock),
    .Config_Reset(Mux6config__Config_Reset),
    .select(Mux6config__select),
    .stop(Mux6config__stop),
    .valid(Mux6config__valid)
  );

  //Wire declarations for instance 'Mux7config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux7config__CGRA_Clock;
  wire  Mux7config__CGRA_Enable;
  wire  Mux7config__CGRA_Reset;
  wire  Mux7config__ConfigIn;
  wire  Mux7config__ConfigOut;
  wire  Mux7config__Config_Clock;
  wire  Mux7config__Config_Reset;
  wire [3:0] Mux7config__select;
  wire [0:0] Mux7config__stop;
  wire [0:0] Mux7config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux7config(
    .CGRA_Clock(Mux7config__CGRA_Clock),
    .CGRA_Enable(Mux7config__CGRA_Enable),
    .CGRA_Reset(Mux7config__CGRA_Reset),
    .ConfigIn(Mux7config__ConfigIn),
    .ConfigOut(Mux7config__ConfigOut),
    .Config_Clock(Mux7config__Config_Clock),
    .Config_Reset(Mux7config__Config_Reset),
    .select(Mux7config__select),
    .stop(Mux7config__stop),
    .valid(Mux7config__valid)
  );

  //Wire declarations for instance 'Mux8config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux8config__CGRA_Clock;
  wire  Mux8config__CGRA_Enable;
  wire  Mux8config__CGRA_Reset;
  wire  Mux8config__ConfigIn;
  wire  Mux8config__ConfigOut;
  wire  Mux8config__Config_Clock;
  wire  Mux8config__Config_Reset;
  wire [3:0] Mux8config__select;
  wire [0:0] Mux8config__stop;
  wire [0:0] Mux8config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux8config(
    .CGRA_Clock(Mux8config__CGRA_Clock),
    .CGRA_Enable(Mux8config__CGRA_Enable),
    .CGRA_Reset(Mux8config__CGRA_Reset),
    .ConfigIn(Mux8config__ConfigIn),
    .ConfigOut(Mux8config__ConfigOut),
    .Config_Clock(Mux8config__Config_Clock),
    .Config_Reset(Mux8config__Config_Reset),
    .select(Mux8config__select),
    .stop(Mux8config__stop),
    .valid(Mux8config__valid)
  );

  //Wire declarations for instance 'Mux9config' (Module cgrame_elastic_configcell_context_size4II1)
  wire  Mux9config__CGRA_Clock;
  wire  Mux9config__CGRA_Enable;
  wire  Mux9config__CGRA_Reset;
  wire  Mux9config__ConfigIn;
  wire  Mux9config__ConfigOut;
  wire  Mux9config__Config_Clock;
  wire  Mux9config__Config_Reset;
  wire [3:0] Mux9config__select;
  wire [0:0] Mux9config__stop;
  wire [0:0] Mux9config__valid;
  cgrame_elastic_configcell_context_size4II1 #(.contexts(1),.size(4)) Mux9config(
    .CGRA_Clock(Mux9config__CGRA_Clock),
    .CGRA_Enable(Mux9config__CGRA_Enable),
    .CGRA_Reset(Mux9config__CGRA_Reset),
    .ConfigIn(Mux9config__ConfigIn),
    .ConfigOut(Mux9config__ConfigOut),
    .Config_Clock(Mux9config__Config_Clock),
    .Config_Reset(Mux9config__Config_Reset),
    .select(Mux9config__select),
    .stop(Mux9config__stop),
    .valid(Mux9config__valid)
  );

  //Wire declarations for instance 'fork_crossbar0' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar0__CGRA_Clock;
  wire  fork_crossbar0__CGRA_Enable;
  wire  fork_crossbar0__CGRA_Reset;
  wire [9:0] fork_crossbar0__enable_downstream;
  wire [0:0] fork_crossbar0__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar0__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar0__in;
  wire [0:0] fork_crossbar0__in_stop_upstream;
  wire [0:0] fork_crossbar0__in_valid_upstream;
  wire [31:0] fork_crossbar0__out0;
  wire [0:0] fork_crossbar0__out0_stop_downstream;
  wire [0:0] fork_crossbar0__out0_valid_downstream;
  wire [31:0] fork_crossbar0__out1;
  wire [0:0] fork_crossbar0__out1_stop_downstream;
  wire [0:0] fork_crossbar0__out1_valid_downstream;
  wire [31:0] fork_crossbar0__out2;
  wire [0:0] fork_crossbar0__out2_stop_downstream;
  wire [0:0] fork_crossbar0__out2_valid_downstream;
  wire [31:0] fork_crossbar0__out3;
  wire [0:0] fork_crossbar0__out3_stop_downstream;
  wire [0:0] fork_crossbar0__out3_valid_downstream;
  wire [31:0] fork_crossbar0__out4;
  wire [0:0] fork_crossbar0__out4_stop_downstream;
  wire [0:0] fork_crossbar0__out4_valid_downstream;
  wire [31:0] fork_crossbar0__out5;
  wire [0:0] fork_crossbar0__out5_stop_downstream;
  wire [0:0] fork_crossbar0__out5_valid_downstream;
  wire [31:0] fork_crossbar0__out6;
  wire [0:0] fork_crossbar0__out6_stop_downstream;
  wire [0:0] fork_crossbar0__out6_valid_downstream;
  wire [31:0] fork_crossbar0__out7;
  wire [0:0] fork_crossbar0__out7_stop_downstream;
  wire [0:0] fork_crossbar0__out7_valid_downstream;
  wire [31:0] fork_crossbar0__out8;
  wire [0:0] fork_crossbar0__out8_stop_downstream;
  wire [0:0] fork_crossbar0__out8_valid_downstream;
  wire [31:0] fork_crossbar0__out9;
  wire [0:0] fork_crossbar0__out9_stop_downstream;
  wire [0:0] fork_crossbar0__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar0(
    .CGRA_Clock(fork_crossbar0__CGRA_Clock),
    .CGRA_Enable(fork_crossbar0__CGRA_Enable),
    .CGRA_Reset(fork_crossbar0__CGRA_Reset),
    .enable_downstream(fork_crossbar0__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar0__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar0__enable_downstream_valid_upstream),
    .in(fork_crossbar0__in),
    .in_stop_upstream(fork_crossbar0__in_stop_upstream),
    .in_valid_upstream(fork_crossbar0__in_valid_upstream),
    .out0(fork_crossbar0__out0),
    .out0_stop_downstream(fork_crossbar0__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar0__out0_valid_downstream),
    .out1(fork_crossbar0__out1),
    .out1_stop_downstream(fork_crossbar0__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar0__out1_valid_downstream),
    .out2(fork_crossbar0__out2),
    .out2_stop_downstream(fork_crossbar0__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar0__out2_valid_downstream),
    .out3(fork_crossbar0__out3),
    .out3_stop_downstream(fork_crossbar0__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar0__out3_valid_downstream),
    .out4(fork_crossbar0__out4),
    .out4_stop_downstream(fork_crossbar0__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar0__out4_valid_downstream),
    .out5(fork_crossbar0__out5),
    .out5_stop_downstream(fork_crossbar0__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar0__out5_valid_downstream),
    .out6(fork_crossbar0__out6),
    .out6_stop_downstream(fork_crossbar0__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar0__out6_valid_downstream),
    .out7(fork_crossbar0__out7),
    .out7_stop_downstream(fork_crossbar0__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar0__out7_valid_downstream),
    .out8(fork_crossbar0__out8),
    .out8_stop_downstream(fork_crossbar0__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar0__out8_valid_downstream),
    .out9(fork_crossbar0__out9),
    .out9_stop_downstream(fork_crossbar0__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar0__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar1' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar1__CGRA_Clock;
  wire  fork_crossbar1__CGRA_Enable;
  wire  fork_crossbar1__CGRA_Reset;
  wire [9:0] fork_crossbar1__enable_downstream;
  wire [0:0] fork_crossbar1__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar1__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar1__in;
  wire [0:0] fork_crossbar1__in_stop_upstream;
  wire [0:0] fork_crossbar1__in_valid_upstream;
  wire [31:0] fork_crossbar1__out0;
  wire [0:0] fork_crossbar1__out0_stop_downstream;
  wire [0:0] fork_crossbar1__out0_valid_downstream;
  wire [31:0] fork_crossbar1__out1;
  wire [0:0] fork_crossbar1__out1_stop_downstream;
  wire [0:0] fork_crossbar1__out1_valid_downstream;
  wire [31:0] fork_crossbar1__out2;
  wire [0:0] fork_crossbar1__out2_stop_downstream;
  wire [0:0] fork_crossbar1__out2_valid_downstream;
  wire [31:0] fork_crossbar1__out3;
  wire [0:0] fork_crossbar1__out3_stop_downstream;
  wire [0:0] fork_crossbar1__out3_valid_downstream;
  wire [31:0] fork_crossbar1__out4;
  wire [0:0] fork_crossbar1__out4_stop_downstream;
  wire [0:0] fork_crossbar1__out4_valid_downstream;
  wire [31:0] fork_crossbar1__out5;
  wire [0:0] fork_crossbar1__out5_stop_downstream;
  wire [0:0] fork_crossbar1__out5_valid_downstream;
  wire [31:0] fork_crossbar1__out6;
  wire [0:0] fork_crossbar1__out6_stop_downstream;
  wire [0:0] fork_crossbar1__out6_valid_downstream;
  wire [31:0] fork_crossbar1__out7;
  wire [0:0] fork_crossbar1__out7_stop_downstream;
  wire [0:0] fork_crossbar1__out7_valid_downstream;
  wire [31:0] fork_crossbar1__out8;
  wire [0:0] fork_crossbar1__out8_stop_downstream;
  wire [0:0] fork_crossbar1__out8_valid_downstream;
  wire [31:0] fork_crossbar1__out9;
  wire [0:0] fork_crossbar1__out9_stop_downstream;
  wire [0:0] fork_crossbar1__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar1(
    .CGRA_Clock(fork_crossbar1__CGRA_Clock),
    .CGRA_Enable(fork_crossbar1__CGRA_Enable),
    .CGRA_Reset(fork_crossbar1__CGRA_Reset),
    .enable_downstream(fork_crossbar1__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar1__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar1__enable_downstream_valid_upstream),
    .in(fork_crossbar1__in),
    .in_stop_upstream(fork_crossbar1__in_stop_upstream),
    .in_valid_upstream(fork_crossbar1__in_valid_upstream),
    .out0(fork_crossbar1__out0),
    .out0_stop_downstream(fork_crossbar1__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar1__out0_valid_downstream),
    .out1(fork_crossbar1__out1),
    .out1_stop_downstream(fork_crossbar1__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar1__out1_valid_downstream),
    .out2(fork_crossbar1__out2),
    .out2_stop_downstream(fork_crossbar1__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar1__out2_valid_downstream),
    .out3(fork_crossbar1__out3),
    .out3_stop_downstream(fork_crossbar1__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar1__out3_valid_downstream),
    .out4(fork_crossbar1__out4),
    .out4_stop_downstream(fork_crossbar1__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar1__out4_valid_downstream),
    .out5(fork_crossbar1__out5),
    .out5_stop_downstream(fork_crossbar1__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar1__out5_valid_downstream),
    .out6(fork_crossbar1__out6),
    .out6_stop_downstream(fork_crossbar1__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar1__out6_valid_downstream),
    .out7(fork_crossbar1__out7),
    .out7_stop_downstream(fork_crossbar1__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar1__out7_valid_downstream),
    .out8(fork_crossbar1__out8),
    .out8_stop_downstream(fork_crossbar1__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar1__out8_valid_downstream),
    .out9(fork_crossbar1__out9),
    .out9_stop_downstream(fork_crossbar1__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar1__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar2' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar2__CGRA_Clock;
  wire  fork_crossbar2__CGRA_Enable;
  wire  fork_crossbar2__CGRA_Reset;
  wire [9:0] fork_crossbar2__enable_downstream;
  wire [0:0] fork_crossbar2__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar2__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar2__in;
  wire [0:0] fork_crossbar2__in_stop_upstream;
  wire [0:0] fork_crossbar2__in_valid_upstream;
  wire [31:0] fork_crossbar2__out0;
  wire [0:0] fork_crossbar2__out0_stop_downstream;
  wire [0:0] fork_crossbar2__out0_valid_downstream;
  wire [31:0] fork_crossbar2__out1;
  wire [0:0] fork_crossbar2__out1_stop_downstream;
  wire [0:0] fork_crossbar2__out1_valid_downstream;
  wire [31:0] fork_crossbar2__out2;
  wire [0:0] fork_crossbar2__out2_stop_downstream;
  wire [0:0] fork_crossbar2__out2_valid_downstream;
  wire [31:0] fork_crossbar2__out3;
  wire [0:0] fork_crossbar2__out3_stop_downstream;
  wire [0:0] fork_crossbar2__out3_valid_downstream;
  wire [31:0] fork_crossbar2__out4;
  wire [0:0] fork_crossbar2__out4_stop_downstream;
  wire [0:0] fork_crossbar2__out4_valid_downstream;
  wire [31:0] fork_crossbar2__out5;
  wire [0:0] fork_crossbar2__out5_stop_downstream;
  wire [0:0] fork_crossbar2__out5_valid_downstream;
  wire [31:0] fork_crossbar2__out6;
  wire [0:0] fork_crossbar2__out6_stop_downstream;
  wire [0:0] fork_crossbar2__out6_valid_downstream;
  wire [31:0] fork_crossbar2__out7;
  wire [0:0] fork_crossbar2__out7_stop_downstream;
  wire [0:0] fork_crossbar2__out7_valid_downstream;
  wire [31:0] fork_crossbar2__out8;
  wire [0:0] fork_crossbar2__out8_stop_downstream;
  wire [0:0] fork_crossbar2__out8_valid_downstream;
  wire [31:0] fork_crossbar2__out9;
  wire [0:0] fork_crossbar2__out9_stop_downstream;
  wire [0:0] fork_crossbar2__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar2(
    .CGRA_Clock(fork_crossbar2__CGRA_Clock),
    .CGRA_Enable(fork_crossbar2__CGRA_Enable),
    .CGRA_Reset(fork_crossbar2__CGRA_Reset),
    .enable_downstream(fork_crossbar2__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar2__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar2__enable_downstream_valid_upstream),
    .in(fork_crossbar2__in),
    .in_stop_upstream(fork_crossbar2__in_stop_upstream),
    .in_valid_upstream(fork_crossbar2__in_valid_upstream),
    .out0(fork_crossbar2__out0),
    .out0_stop_downstream(fork_crossbar2__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar2__out0_valid_downstream),
    .out1(fork_crossbar2__out1),
    .out1_stop_downstream(fork_crossbar2__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar2__out1_valid_downstream),
    .out2(fork_crossbar2__out2),
    .out2_stop_downstream(fork_crossbar2__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar2__out2_valid_downstream),
    .out3(fork_crossbar2__out3),
    .out3_stop_downstream(fork_crossbar2__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar2__out3_valid_downstream),
    .out4(fork_crossbar2__out4),
    .out4_stop_downstream(fork_crossbar2__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar2__out4_valid_downstream),
    .out5(fork_crossbar2__out5),
    .out5_stop_downstream(fork_crossbar2__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar2__out5_valid_downstream),
    .out6(fork_crossbar2__out6),
    .out6_stop_downstream(fork_crossbar2__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar2__out6_valid_downstream),
    .out7(fork_crossbar2__out7),
    .out7_stop_downstream(fork_crossbar2__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar2__out7_valid_downstream),
    .out8(fork_crossbar2__out8),
    .out8_stop_downstream(fork_crossbar2__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar2__out8_valid_downstream),
    .out9(fork_crossbar2__out9),
    .out9_stop_downstream(fork_crossbar2__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar2__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar3' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar3__CGRA_Clock;
  wire  fork_crossbar3__CGRA_Enable;
  wire  fork_crossbar3__CGRA_Reset;
  wire [9:0] fork_crossbar3__enable_downstream;
  wire [0:0] fork_crossbar3__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar3__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar3__in;
  wire [0:0] fork_crossbar3__in_stop_upstream;
  wire [0:0] fork_crossbar3__in_valid_upstream;
  wire [31:0] fork_crossbar3__out0;
  wire [0:0] fork_crossbar3__out0_stop_downstream;
  wire [0:0] fork_crossbar3__out0_valid_downstream;
  wire [31:0] fork_crossbar3__out1;
  wire [0:0] fork_crossbar3__out1_stop_downstream;
  wire [0:0] fork_crossbar3__out1_valid_downstream;
  wire [31:0] fork_crossbar3__out2;
  wire [0:0] fork_crossbar3__out2_stop_downstream;
  wire [0:0] fork_crossbar3__out2_valid_downstream;
  wire [31:0] fork_crossbar3__out3;
  wire [0:0] fork_crossbar3__out3_stop_downstream;
  wire [0:0] fork_crossbar3__out3_valid_downstream;
  wire [31:0] fork_crossbar3__out4;
  wire [0:0] fork_crossbar3__out4_stop_downstream;
  wire [0:0] fork_crossbar3__out4_valid_downstream;
  wire [31:0] fork_crossbar3__out5;
  wire [0:0] fork_crossbar3__out5_stop_downstream;
  wire [0:0] fork_crossbar3__out5_valid_downstream;
  wire [31:0] fork_crossbar3__out6;
  wire [0:0] fork_crossbar3__out6_stop_downstream;
  wire [0:0] fork_crossbar3__out6_valid_downstream;
  wire [31:0] fork_crossbar3__out7;
  wire [0:0] fork_crossbar3__out7_stop_downstream;
  wire [0:0] fork_crossbar3__out7_valid_downstream;
  wire [31:0] fork_crossbar3__out8;
  wire [0:0] fork_crossbar3__out8_stop_downstream;
  wire [0:0] fork_crossbar3__out8_valid_downstream;
  wire [31:0] fork_crossbar3__out9;
  wire [0:0] fork_crossbar3__out9_stop_downstream;
  wire [0:0] fork_crossbar3__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar3(
    .CGRA_Clock(fork_crossbar3__CGRA_Clock),
    .CGRA_Enable(fork_crossbar3__CGRA_Enable),
    .CGRA_Reset(fork_crossbar3__CGRA_Reset),
    .enable_downstream(fork_crossbar3__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar3__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar3__enable_downstream_valid_upstream),
    .in(fork_crossbar3__in),
    .in_stop_upstream(fork_crossbar3__in_stop_upstream),
    .in_valid_upstream(fork_crossbar3__in_valid_upstream),
    .out0(fork_crossbar3__out0),
    .out0_stop_downstream(fork_crossbar3__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar3__out0_valid_downstream),
    .out1(fork_crossbar3__out1),
    .out1_stop_downstream(fork_crossbar3__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar3__out1_valid_downstream),
    .out2(fork_crossbar3__out2),
    .out2_stop_downstream(fork_crossbar3__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar3__out2_valid_downstream),
    .out3(fork_crossbar3__out3),
    .out3_stop_downstream(fork_crossbar3__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar3__out3_valid_downstream),
    .out4(fork_crossbar3__out4),
    .out4_stop_downstream(fork_crossbar3__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar3__out4_valid_downstream),
    .out5(fork_crossbar3__out5),
    .out5_stop_downstream(fork_crossbar3__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar3__out5_valid_downstream),
    .out6(fork_crossbar3__out6),
    .out6_stop_downstream(fork_crossbar3__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar3__out6_valid_downstream),
    .out7(fork_crossbar3__out7),
    .out7_stop_downstream(fork_crossbar3__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar3__out7_valid_downstream),
    .out8(fork_crossbar3__out8),
    .out8_stop_downstream(fork_crossbar3__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar3__out8_valid_downstream),
    .out9(fork_crossbar3__out9),
    .out9_stop_downstream(fork_crossbar3__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar3__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar4' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar4__CGRA_Clock;
  wire  fork_crossbar4__CGRA_Enable;
  wire  fork_crossbar4__CGRA_Reset;
  wire [9:0] fork_crossbar4__enable_downstream;
  wire [0:0] fork_crossbar4__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar4__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar4__in;
  wire [0:0] fork_crossbar4__in_stop_upstream;
  wire [0:0] fork_crossbar4__in_valid_upstream;
  wire [31:0] fork_crossbar4__out0;
  wire [0:0] fork_crossbar4__out0_stop_downstream;
  wire [0:0] fork_crossbar4__out0_valid_downstream;
  wire [31:0] fork_crossbar4__out1;
  wire [0:0] fork_crossbar4__out1_stop_downstream;
  wire [0:0] fork_crossbar4__out1_valid_downstream;
  wire [31:0] fork_crossbar4__out2;
  wire [0:0] fork_crossbar4__out2_stop_downstream;
  wire [0:0] fork_crossbar4__out2_valid_downstream;
  wire [31:0] fork_crossbar4__out3;
  wire [0:0] fork_crossbar4__out3_stop_downstream;
  wire [0:0] fork_crossbar4__out3_valid_downstream;
  wire [31:0] fork_crossbar4__out4;
  wire [0:0] fork_crossbar4__out4_stop_downstream;
  wire [0:0] fork_crossbar4__out4_valid_downstream;
  wire [31:0] fork_crossbar4__out5;
  wire [0:0] fork_crossbar4__out5_stop_downstream;
  wire [0:0] fork_crossbar4__out5_valid_downstream;
  wire [31:0] fork_crossbar4__out6;
  wire [0:0] fork_crossbar4__out6_stop_downstream;
  wire [0:0] fork_crossbar4__out6_valid_downstream;
  wire [31:0] fork_crossbar4__out7;
  wire [0:0] fork_crossbar4__out7_stop_downstream;
  wire [0:0] fork_crossbar4__out7_valid_downstream;
  wire [31:0] fork_crossbar4__out8;
  wire [0:0] fork_crossbar4__out8_stop_downstream;
  wire [0:0] fork_crossbar4__out8_valid_downstream;
  wire [31:0] fork_crossbar4__out9;
  wire [0:0] fork_crossbar4__out9_stop_downstream;
  wire [0:0] fork_crossbar4__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar4(
    .CGRA_Clock(fork_crossbar4__CGRA_Clock),
    .CGRA_Enable(fork_crossbar4__CGRA_Enable),
    .CGRA_Reset(fork_crossbar4__CGRA_Reset),
    .enable_downstream(fork_crossbar4__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar4__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar4__enable_downstream_valid_upstream),
    .in(fork_crossbar4__in),
    .in_stop_upstream(fork_crossbar4__in_stop_upstream),
    .in_valid_upstream(fork_crossbar4__in_valid_upstream),
    .out0(fork_crossbar4__out0),
    .out0_stop_downstream(fork_crossbar4__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar4__out0_valid_downstream),
    .out1(fork_crossbar4__out1),
    .out1_stop_downstream(fork_crossbar4__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar4__out1_valid_downstream),
    .out2(fork_crossbar4__out2),
    .out2_stop_downstream(fork_crossbar4__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar4__out2_valid_downstream),
    .out3(fork_crossbar4__out3),
    .out3_stop_downstream(fork_crossbar4__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar4__out3_valid_downstream),
    .out4(fork_crossbar4__out4),
    .out4_stop_downstream(fork_crossbar4__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar4__out4_valid_downstream),
    .out5(fork_crossbar4__out5),
    .out5_stop_downstream(fork_crossbar4__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar4__out5_valid_downstream),
    .out6(fork_crossbar4__out6),
    .out6_stop_downstream(fork_crossbar4__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar4__out6_valid_downstream),
    .out7(fork_crossbar4__out7),
    .out7_stop_downstream(fork_crossbar4__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar4__out7_valid_downstream),
    .out8(fork_crossbar4__out8),
    .out8_stop_downstream(fork_crossbar4__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar4__out8_valid_downstream),
    .out9(fork_crossbar4__out9),
    .out9_stop_downstream(fork_crossbar4__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar4__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar5' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar5__CGRA_Clock;
  wire  fork_crossbar5__CGRA_Enable;
  wire  fork_crossbar5__CGRA_Reset;
  wire [9:0] fork_crossbar5__enable_downstream;
  wire [0:0] fork_crossbar5__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar5__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar5__in;
  wire [0:0] fork_crossbar5__in_stop_upstream;
  wire [0:0] fork_crossbar5__in_valid_upstream;
  wire [31:0] fork_crossbar5__out0;
  wire [0:0] fork_crossbar5__out0_stop_downstream;
  wire [0:0] fork_crossbar5__out0_valid_downstream;
  wire [31:0] fork_crossbar5__out1;
  wire [0:0] fork_crossbar5__out1_stop_downstream;
  wire [0:0] fork_crossbar5__out1_valid_downstream;
  wire [31:0] fork_crossbar5__out2;
  wire [0:0] fork_crossbar5__out2_stop_downstream;
  wire [0:0] fork_crossbar5__out2_valid_downstream;
  wire [31:0] fork_crossbar5__out3;
  wire [0:0] fork_crossbar5__out3_stop_downstream;
  wire [0:0] fork_crossbar5__out3_valid_downstream;
  wire [31:0] fork_crossbar5__out4;
  wire [0:0] fork_crossbar5__out4_stop_downstream;
  wire [0:0] fork_crossbar5__out4_valid_downstream;
  wire [31:0] fork_crossbar5__out5;
  wire [0:0] fork_crossbar5__out5_stop_downstream;
  wire [0:0] fork_crossbar5__out5_valid_downstream;
  wire [31:0] fork_crossbar5__out6;
  wire [0:0] fork_crossbar5__out6_stop_downstream;
  wire [0:0] fork_crossbar5__out6_valid_downstream;
  wire [31:0] fork_crossbar5__out7;
  wire [0:0] fork_crossbar5__out7_stop_downstream;
  wire [0:0] fork_crossbar5__out7_valid_downstream;
  wire [31:0] fork_crossbar5__out8;
  wire [0:0] fork_crossbar5__out8_stop_downstream;
  wire [0:0] fork_crossbar5__out8_valid_downstream;
  wire [31:0] fork_crossbar5__out9;
  wire [0:0] fork_crossbar5__out9_stop_downstream;
  wire [0:0] fork_crossbar5__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar5(
    .CGRA_Clock(fork_crossbar5__CGRA_Clock),
    .CGRA_Enable(fork_crossbar5__CGRA_Enable),
    .CGRA_Reset(fork_crossbar5__CGRA_Reset),
    .enable_downstream(fork_crossbar5__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar5__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar5__enable_downstream_valid_upstream),
    .in(fork_crossbar5__in),
    .in_stop_upstream(fork_crossbar5__in_stop_upstream),
    .in_valid_upstream(fork_crossbar5__in_valid_upstream),
    .out0(fork_crossbar5__out0),
    .out0_stop_downstream(fork_crossbar5__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar5__out0_valid_downstream),
    .out1(fork_crossbar5__out1),
    .out1_stop_downstream(fork_crossbar5__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar5__out1_valid_downstream),
    .out2(fork_crossbar5__out2),
    .out2_stop_downstream(fork_crossbar5__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar5__out2_valid_downstream),
    .out3(fork_crossbar5__out3),
    .out3_stop_downstream(fork_crossbar5__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar5__out3_valid_downstream),
    .out4(fork_crossbar5__out4),
    .out4_stop_downstream(fork_crossbar5__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar5__out4_valid_downstream),
    .out5(fork_crossbar5__out5),
    .out5_stop_downstream(fork_crossbar5__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar5__out5_valid_downstream),
    .out6(fork_crossbar5__out6),
    .out6_stop_downstream(fork_crossbar5__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar5__out6_valid_downstream),
    .out7(fork_crossbar5__out7),
    .out7_stop_downstream(fork_crossbar5__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar5__out7_valid_downstream),
    .out8(fork_crossbar5__out8),
    .out8_stop_downstream(fork_crossbar5__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar5__out8_valid_downstream),
    .out9(fork_crossbar5__out9),
    .out9_stop_downstream(fork_crossbar5__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar5__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar6' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar6__CGRA_Clock;
  wire  fork_crossbar6__CGRA_Enable;
  wire  fork_crossbar6__CGRA_Reset;
  wire [9:0] fork_crossbar6__enable_downstream;
  wire [0:0] fork_crossbar6__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar6__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar6__in;
  wire [0:0] fork_crossbar6__in_stop_upstream;
  wire [0:0] fork_crossbar6__in_valid_upstream;
  wire [31:0] fork_crossbar6__out0;
  wire [0:0] fork_crossbar6__out0_stop_downstream;
  wire [0:0] fork_crossbar6__out0_valid_downstream;
  wire [31:0] fork_crossbar6__out1;
  wire [0:0] fork_crossbar6__out1_stop_downstream;
  wire [0:0] fork_crossbar6__out1_valid_downstream;
  wire [31:0] fork_crossbar6__out2;
  wire [0:0] fork_crossbar6__out2_stop_downstream;
  wire [0:0] fork_crossbar6__out2_valid_downstream;
  wire [31:0] fork_crossbar6__out3;
  wire [0:0] fork_crossbar6__out3_stop_downstream;
  wire [0:0] fork_crossbar6__out3_valid_downstream;
  wire [31:0] fork_crossbar6__out4;
  wire [0:0] fork_crossbar6__out4_stop_downstream;
  wire [0:0] fork_crossbar6__out4_valid_downstream;
  wire [31:0] fork_crossbar6__out5;
  wire [0:0] fork_crossbar6__out5_stop_downstream;
  wire [0:0] fork_crossbar6__out5_valid_downstream;
  wire [31:0] fork_crossbar6__out6;
  wire [0:0] fork_crossbar6__out6_stop_downstream;
  wire [0:0] fork_crossbar6__out6_valid_downstream;
  wire [31:0] fork_crossbar6__out7;
  wire [0:0] fork_crossbar6__out7_stop_downstream;
  wire [0:0] fork_crossbar6__out7_valid_downstream;
  wire [31:0] fork_crossbar6__out8;
  wire [0:0] fork_crossbar6__out8_stop_downstream;
  wire [0:0] fork_crossbar6__out8_valid_downstream;
  wire [31:0] fork_crossbar6__out9;
  wire [0:0] fork_crossbar6__out9_stop_downstream;
  wire [0:0] fork_crossbar6__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar6(
    .CGRA_Clock(fork_crossbar6__CGRA_Clock),
    .CGRA_Enable(fork_crossbar6__CGRA_Enable),
    .CGRA_Reset(fork_crossbar6__CGRA_Reset),
    .enable_downstream(fork_crossbar6__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar6__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar6__enable_downstream_valid_upstream),
    .in(fork_crossbar6__in),
    .in_stop_upstream(fork_crossbar6__in_stop_upstream),
    .in_valid_upstream(fork_crossbar6__in_valid_upstream),
    .out0(fork_crossbar6__out0),
    .out0_stop_downstream(fork_crossbar6__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar6__out0_valid_downstream),
    .out1(fork_crossbar6__out1),
    .out1_stop_downstream(fork_crossbar6__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar6__out1_valid_downstream),
    .out2(fork_crossbar6__out2),
    .out2_stop_downstream(fork_crossbar6__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar6__out2_valid_downstream),
    .out3(fork_crossbar6__out3),
    .out3_stop_downstream(fork_crossbar6__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar6__out3_valid_downstream),
    .out4(fork_crossbar6__out4),
    .out4_stop_downstream(fork_crossbar6__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar6__out4_valid_downstream),
    .out5(fork_crossbar6__out5),
    .out5_stop_downstream(fork_crossbar6__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar6__out5_valid_downstream),
    .out6(fork_crossbar6__out6),
    .out6_stop_downstream(fork_crossbar6__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar6__out6_valid_downstream),
    .out7(fork_crossbar6__out7),
    .out7_stop_downstream(fork_crossbar6__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar6__out7_valid_downstream),
    .out8(fork_crossbar6__out8),
    .out8_stop_downstream(fork_crossbar6__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar6__out8_valid_downstream),
    .out9(fork_crossbar6__out9),
    .out9_stop_downstream(fork_crossbar6__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar6__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar7' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar7__CGRA_Clock;
  wire  fork_crossbar7__CGRA_Enable;
  wire  fork_crossbar7__CGRA_Reset;
  wire [9:0] fork_crossbar7__enable_downstream;
  wire [0:0] fork_crossbar7__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar7__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar7__in;
  wire [0:0] fork_crossbar7__in_stop_upstream;
  wire [0:0] fork_crossbar7__in_valid_upstream;
  wire [31:0] fork_crossbar7__out0;
  wire [0:0] fork_crossbar7__out0_stop_downstream;
  wire [0:0] fork_crossbar7__out0_valid_downstream;
  wire [31:0] fork_crossbar7__out1;
  wire [0:0] fork_crossbar7__out1_stop_downstream;
  wire [0:0] fork_crossbar7__out1_valid_downstream;
  wire [31:0] fork_crossbar7__out2;
  wire [0:0] fork_crossbar7__out2_stop_downstream;
  wire [0:0] fork_crossbar7__out2_valid_downstream;
  wire [31:0] fork_crossbar7__out3;
  wire [0:0] fork_crossbar7__out3_stop_downstream;
  wire [0:0] fork_crossbar7__out3_valid_downstream;
  wire [31:0] fork_crossbar7__out4;
  wire [0:0] fork_crossbar7__out4_stop_downstream;
  wire [0:0] fork_crossbar7__out4_valid_downstream;
  wire [31:0] fork_crossbar7__out5;
  wire [0:0] fork_crossbar7__out5_stop_downstream;
  wire [0:0] fork_crossbar7__out5_valid_downstream;
  wire [31:0] fork_crossbar7__out6;
  wire [0:0] fork_crossbar7__out6_stop_downstream;
  wire [0:0] fork_crossbar7__out6_valid_downstream;
  wire [31:0] fork_crossbar7__out7;
  wire [0:0] fork_crossbar7__out7_stop_downstream;
  wire [0:0] fork_crossbar7__out7_valid_downstream;
  wire [31:0] fork_crossbar7__out8;
  wire [0:0] fork_crossbar7__out8_stop_downstream;
  wire [0:0] fork_crossbar7__out8_valid_downstream;
  wire [31:0] fork_crossbar7__out9;
  wire [0:0] fork_crossbar7__out9_stop_downstream;
  wire [0:0] fork_crossbar7__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar7(
    .CGRA_Clock(fork_crossbar7__CGRA_Clock),
    .CGRA_Enable(fork_crossbar7__CGRA_Enable),
    .CGRA_Reset(fork_crossbar7__CGRA_Reset),
    .enable_downstream(fork_crossbar7__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar7__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar7__enable_downstream_valid_upstream),
    .in(fork_crossbar7__in),
    .in_stop_upstream(fork_crossbar7__in_stop_upstream),
    .in_valid_upstream(fork_crossbar7__in_valid_upstream),
    .out0(fork_crossbar7__out0),
    .out0_stop_downstream(fork_crossbar7__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar7__out0_valid_downstream),
    .out1(fork_crossbar7__out1),
    .out1_stop_downstream(fork_crossbar7__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar7__out1_valid_downstream),
    .out2(fork_crossbar7__out2),
    .out2_stop_downstream(fork_crossbar7__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar7__out2_valid_downstream),
    .out3(fork_crossbar7__out3),
    .out3_stop_downstream(fork_crossbar7__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar7__out3_valid_downstream),
    .out4(fork_crossbar7__out4),
    .out4_stop_downstream(fork_crossbar7__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar7__out4_valid_downstream),
    .out5(fork_crossbar7__out5),
    .out5_stop_downstream(fork_crossbar7__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar7__out5_valid_downstream),
    .out6(fork_crossbar7__out6),
    .out6_stop_downstream(fork_crossbar7__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar7__out6_valid_downstream),
    .out7(fork_crossbar7__out7),
    .out7_stop_downstream(fork_crossbar7__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar7__out7_valid_downstream),
    .out8(fork_crossbar7__out8),
    .out8_stop_downstream(fork_crossbar7__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar7__out8_valid_downstream),
    .out9(fork_crossbar7__out9),
    .out9_stop_downstream(fork_crossbar7__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar7__out9_valid_downstream)
  );

  //Wire declarations for instance 'fork_crossbar8' (Module cgrame_elastic_eager_fork_1to10_size_32)
  wire  fork_crossbar8__CGRA_Clock;
  wire  fork_crossbar8__CGRA_Enable;
  wire  fork_crossbar8__CGRA_Reset;
  wire [9:0] fork_crossbar8__enable_downstream;
  wire [0:0] fork_crossbar8__enable_downstream_stop_upstream;
  wire [0:0] fork_crossbar8__enable_downstream_valid_upstream;
  wire [31:0] fork_crossbar8__in;
  wire [0:0] fork_crossbar8__in_stop_upstream;
  wire [0:0] fork_crossbar8__in_valid_upstream;
  wire [31:0] fork_crossbar8__out0;
  wire [0:0] fork_crossbar8__out0_stop_downstream;
  wire [0:0] fork_crossbar8__out0_valid_downstream;
  wire [31:0] fork_crossbar8__out1;
  wire [0:0] fork_crossbar8__out1_stop_downstream;
  wire [0:0] fork_crossbar8__out1_valid_downstream;
  wire [31:0] fork_crossbar8__out2;
  wire [0:0] fork_crossbar8__out2_stop_downstream;
  wire [0:0] fork_crossbar8__out2_valid_downstream;
  wire [31:0] fork_crossbar8__out3;
  wire [0:0] fork_crossbar8__out3_stop_downstream;
  wire [0:0] fork_crossbar8__out3_valid_downstream;
  wire [31:0] fork_crossbar8__out4;
  wire [0:0] fork_crossbar8__out4_stop_downstream;
  wire [0:0] fork_crossbar8__out4_valid_downstream;
  wire [31:0] fork_crossbar8__out5;
  wire [0:0] fork_crossbar8__out5_stop_downstream;
  wire [0:0] fork_crossbar8__out5_valid_downstream;
  wire [31:0] fork_crossbar8__out6;
  wire [0:0] fork_crossbar8__out6_stop_downstream;
  wire [0:0] fork_crossbar8__out6_valid_downstream;
  wire [31:0] fork_crossbar8__out7;
  wire [0:0] fork_crossbar8__out7_stop_downstream;
  wire [0:0] fork_crossbar8__out7_valid_downstream;
  wire [31:0] fork_crossbar8__out8;
  wire [0:0] fork_crossbar8__out8_stop_downstream;
  wire [0:0] fork_crossbar8__out8_valid_downstream;
  wire [31:0] fork_crossbar8__out9;
  wire [0:0] fork_crossbar8__out9_stop_downstream;
  wire [0:0] fork_crossbar8__out9_valid_downstream;
  cgrame_elastic_eager_fork_1to10_size_32 #(.contexts(1),.size(32)) fork_crossbar8(
    .CGRA_Clock(fork_crossbar8__CGRA_Clock),
    .CGRA_Enable(fork_crossbar8__CGRA_Enable),
    .CGRA_Reset(fork_crossbar8__CGRA_Reset),
    .enable_downstream(fork_crossbar8__enable_downstream),
    .enable_downstream_stop_upstream(fork_crossbar8__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(fork_crossbar8__enable_downstream_valid_upstream),
    .in(fork_crossbar8__in),
    .in_stop_upstream(fork_crossbar8__in_stop_upstream),
    .in_valid_upstream(fork_crossbar8__in_valid_upstream),
    .out0(fork_crossbar8__out0),
    .out0_stop_downstream(fork_crossbar8__out0_stop_downstream),
    .out0_valid_downstream(fork_crossbar8__out0_valid_downstream),
    .out1(fork_crossbar8__out1),
    .out1_stop_downstream(fork_crossbar8__out1_stop_downstream),
    .out1_valid_downstream(fork_crossbar8__out1_valid_downstream),
    .out2(fork_crossbar8__out2),
    .out2_stop_downstream(fork_crossbar8__out2_stop_downstream),
    .out2_valid_downstream(fork_crossbar8__out2_valid_downstream),
    .out3(fork_crossbar8__out3),
    .out3_stop_downstream(fork_crossbar8__out3_stop_downstream),
    .out3_valid_downstream(fork_crossbar8__out3_valid_downstream),
    .out4(fork_crossbar8__out4),
    .out4_stop_downstream(fork_crossbar8__out4_stop_downstream),
    .out4_valid_downstream(fork_crossbar8__out4_valid_downstream),
    .out5(fork_crossbar8__out5),
    .out5_stop_downstream(fork_crossbar8__out5_stop_downstream),
    .out5_valid_downstream(fork_crossbar8__out5_valid_downstream),
    .out6(fork_crossbar8__out6),
    .out6_stop_downstream(fork_crossbar8__out6_stop_downstream),
    .out6_valid_downstream(fork_crossbar8__out6_valid_downstream),
    .out7(fork_crossbar8__out7),
    .out7_stop_downstream(fork_crossbar8__out7_stop_downstream),
    .out7_valid_downstream(fork_crossbar8__out7_valid_downstream),
    .out8(fork_crossbar8__out8),
    .out8_stop_downstream(fork_crossbar8__out8_stop_downstream),
    .out8_valid_downstream(fork_crossbar8__out8_valid_downstream),
    .out9(fork_crossbar8__out9),
    .out9_stop_downstream(fork_crossbar8__out9_stop_downstream),
    .out9_valid_downstream(fork_crossbar8__out9_valid_downstream)
  );

  //Wire declarations for instance 'mux_0' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_0__in0;
  wire [0:0] mux_0__in0_stop_upstream;
  wire [0:0] mux_0__in0_valid_upstream;
  wire [31:0] mux_0__in1;
  wire [0:0] mux_0__in1_stop_upstream;
  wire [0:0] mux_0__in1_valid_upstream;
  wire [31:0] mux_0__in2;
  wire [0:0] mux_0__in2_stop_upstream;
  wire [0:0] mux_0__in2_valid_upstream;
  wire [31:0] mux_0__in3;
  wire [0:0] mux_0__in3_stop_upstream;
  wire [0:0] mux_0__in3_valid_upstream;
  wire [31:0] mux_0__in4;
  wire [0:0] mux_0__in4_stop_upstream;
  wire [0:0] mux_0__in4_valid_upstream;
  wire [31:0] mux_0__in5;
  wire [0:0] mux_0__in5_stop_upstream;
  wire [0:0] mux_0__in5_valid_upstream;
  wire [31:0] mux_0__in6;
  wire [0:0] mux_0__in6_stop_upstream;
  wire [0:0] mux_0__in6_valid_upstream;
  wire [31:0] mux_0__in7;
  wire [0:0] mux_0__in7_stop_upstream;
  wire [0:0] mux_0__in7_valid_upstream;
  wire [31:0] mux_0__in8;
  wire [0:0] mux_0__in8_stop_upstream;
  wire [0:0] mux_0__in8_valid_upstream;
  wire [31:0] mux_0__out;
  wire [0:0] mux_0__out_stop_downstream;
  wire [0:0] mux_0__out_valid_downstream;
  wire [3:0] mux_0__select;
  wire [0:0] mux_0__select_stop_upstream;
  wire [0:0] mux_0__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_0(
    .in0(mux_0__in0),
    .in0_stop_upstream(mux_0__in0_stop_upstream),
    .in0_valid_upstream(mux_0__in0_valid_upstream),
    .in1(mux_0__in1),
    .in1_stop_upstream(mux_0__in1_stop_upstream),
    .in1_valid_upstream(mux_0__in1_valid_upstream),
    .in2(mux_0__in2),
    .in2_stop_upstream(mux_0__in2_stop_upstream),
    .in2_valid_upstream(mux_0__in2_valid_upstream),
    .in3(mux_0__in3),
    .in3_stop_upstream(mux_0__in3_stop_upstream),
    .in3_valid_upstream(mux_0__in3_valid_upstream),
    .in4(mux_0__in4),
    .in4_stop_upstream(mux_0__in4_stop_upstream),
    .in4_valid_upstream(mux_0__in4_valid_upstream),
    .in5(mux_0__in5),
    .in5_stop_upstream(mux_0__in5_stop_upstream),
    .in5_valid_upstream(mux_0__in5_valid_upstream),
    .in6(mux_0__in6),
    .in6_stop_upstream(mux_0__in6_stop_upstream),
    .in6_valid_upstream(mux_0__in6_valid_upstream),
    .in7(mux_0__in7),
    .in7_stop_upstream(mux_0__in7_stop_upstream),
    .in7_valid_upstream(mux_0__in7_valid_upstream),
    .in8(mux_0__in8),
    .in8_stop_upstream(mux_0__in8_stop_upstream),
    .in8_valid_upstream(mux_0__in8_valid_upstream),
    .out(mux_0__out),
    .out_stop_downstream(mux_0__out_stop_downstream),
    .out_valid_downstream(mux_0__out_valid_downstream),
    .select(mux_0__select),
    .select_stop_upstream(mux_0__select_stop_upstream),
    .select_valid_upstream(mux_0__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_1' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_1__in0;
  wire [0:0] mux_1__in0_stop_upstream;
  wire [0:0] mux_1__in0_valid_upstream;
  wire [31:0] mux_1__in1;
  wire [0:0] mux_1__in1_stop_upstream;
  wire [0:0] mux_1__in1_valid_upstream;
  wire [31:0] mux_1__in2;
  wire [0:0] mux_1__in2_stop_upstream;
  wire [0:0] mux_1__in2_valid_upstream;
  wire [31:0] mux_1__in3;
  wire [0:0] mux_1__in3_stop_upstream;
  wire [0:0] mux_1__in3_valid_upstream;
  wire [31:0] mux_1__in4;
  wire [0:0] mux_1__in4_stop_upstream;
  wire [0:0] mux_1__in4_valid_upstream;
  wire [31:0] mux_1__in5;
  wire [0:0] mux_1__in5_stop_upstream;
  wire [0:0] mux_1__in5_valid_upstream;
  wire [31:0] mux_1__in6;
  wire [0:0] mux_1__in6_stop_upstream;
  wire [0:0] mux_1__in6_valid_upstream;
  wire [31:0] mux_1__in7;
  wire [0:0] mux_1__in7_stop_upstream;
  wire [0:0] mux_1__in7_valid_upstream;
  wire [31:0] mux_1__in8;
  wire [0:0] mux_1__in8_stop_upstream;
  wire [0:0] mux_1__in8_valid_upstream;
  wire [31:0] mux_1__out;
  wire [0:0] mux_1__out_stop_downstream;
  wire [0:0] mux_1__out_valid_downstream;
  wire [3:0] mux_1__select;
  wire [0:0] mux_1__select_stop_upstream;
  wire [0:0] mux_1__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_1(
    .in0(mux_1__in0),
    .in0_stop_upstream(mux_1__in0_stop_upstream),
    .in0_valid_upstream(mux_1__in0_valid_upstream),
    .in1(mux_1__in1),
    .in1_stop_upstream(mux_1__in1_stop_upstream),
    .in1_valid_upstream(mux_1__in1_valid_upstream),
    .in2(mux_1__in2),
    .in2_stop_upstream(mux_1__in2_stop_upstream),
    .in2_valid_upstream(mux_1__in2_valid_upstream),
    .in3(mux_1__in3),
    .in3_stop_upstream(mux_1__in3_stop_upstream),
    .in3_valid_upstream(mux_1__in3_valid_upstream),
    .in4(mux_1__in4),
    .in4_stop_upstream(mux_1__in4_stop_upstream),
    .in4_valid_upstream(mux_1__in4_valid_upstream),
    .in5(mux_1__in5),
    .in5_stop_upstream(mux_1__in5_stop_upstream),
    .in5_valid_upstream(mux_1__in5_valid_upstream),
    .in6(mux_1__in6),
    .in6_stop_upstream(mux_1__in6_stop_upstream),
    .in6_valid_upstream(mux_1__in6_valid_upstream),
    .in7(mux_1__in7),
    .in7_stop_upstream(mux_1__in7_stop_upstream),
    .in7_valid_upstream(mux_1__in7_valid_upstream),
    .in8(mux_1__in8),
    .in8_stop_upstream(mux_1__in8_stop_upstream),
    .in8_valid_upstream(mux_1__in8_valid_upstream),
    .out(mux_1__out),
    .out_stop_downstream(mux_1__out_stop_downstream),
    .out_valid_downstream(mux_1__out_valid_downstream),
    .select(mux_1__select),
    .select_stop_upstream(mux_1__select_stop_upstream),
    .select_valid_upstream(mux_1__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_2' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_2__in0;
  wire [0:0] mux_2__in0_stop_upstream;
  wire [0:0] mux_2__in0_valid_upstream;
  wire [31:0] mux_2__in1;
  wire [0:0] mux_2__in1_stop_upstream;
  wire [0:0] mux_2__in1_valid_upstream;
  wire [31:0] mux_2__in2;
  wire [0:0] mux_2__in2_stop_upstream;
  wire [0:0] mux_2__in2_valid_upstream;
  wire [31:0] mux_2__in3;
  wire [0:0] mux_2__in3_stop_upstream;
  wire [0:0] mux_2__in3_valid_upstream;
  wire [31:0] mux_2__in4;
  wire [0:0] mux_2__in4_stop_upstream;
  wire [0:0] mux_2__in4_valid_upstream;
  wire [31:0] mux_2__in5;
  wire [0:0] mux_2__in5_stop_upstream;
  wire [0:0] mux_2__in5_valid_upstream;
  wire [31:0] mux_2__in6;
  wire [0:0] mux_2__in6_stop_upstream;
  wire [0:0] mux_2__in6_valid_upstream;
  wire [31:0] mux_2__in7;
  wire [0:0] mux_2__in7_stop_upstream;
  wire [0:0] mux_2__in7_valid_upstream;
  wire [31:0] mux_2__in8;
  wire [0:0] mux_2__in8_stop_upstream;
  wire [0:0] mux_2__in8_valid_upstream;
  wire [31:0] mux_2__out;
  wire [0:0] mux_2__out_stop_downstream;
  wire [0:0] mux_2__out_valid_downstream;
  wire [3:0] mux_2__select;
  wire [0:0] mux_2__select_stop_upstream;
  wire [0:0] mux_2__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_2(
    .in0(mux_2__in0),
    .in0_stop_upstream(mux_2__in0_stop_upstream),
    .in0_valid_upstream(mux_2__in0_valid_upstream),
    .in1(mux_2__in1),
    .in1_stop_upstream(mux_2__in1_stop_upstream),
    .in1_valid_upstream(mux_2__in1_valid_upstream),
    .in2(mux_2__in2),
    .in2_stop_upstream(mux_2__in2_stop_upstream),
    .in2_valid_upstream(mux_2__in2_valid_upstream),
    .in3(mux_2__in3),
    .in3_stop_upstream(mux_2__in3_stop_upstream),
    .in3_valid_upstream(mux_2__in3_valid_upstream),
    .in4(mux_2__in4),
    .in4_stop_upstream(mux_2__in4_stop_upstream),
    .in4_valid_upstream(mux_2__in4_valid_upstream),
    .in5(mux_2__in5),
    .in5_stop_upstream(mux_2__in5_stop_upstream),
    .in5_valid_upstream(mux_2__in5_valid_upstream),
    .in6(mux_2__in6),
    .in6_stop_upstream(mux_2__in6_stop_upstream),
    .in6_valid_upstream(mux_2__in6_valid_upstream),
    .in7(mux_2__in7),
    .in7_stop_upstream(mux_2__in7_stop_upstream),
    .in7_valid_upstream(mux_2__in7_valid_upstream),
    .in8(mux_2__in8),
    .in8_stop_upstream(mux_2__in8_stop_upstream),
    .in8_valid_upstream(mux_2__in8_valid_upstream),
    .out(mux_2__out),
    .out_stop_downstream(mux_2__out_stop_downstream),
    .out_valid_downstream(mux_2__out_valid_downstream),
    .select(mux_2__select),
    .select_stop_upstream(mux_2__select_stop_upstream),
    .select_valid_upstream(mux_2__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_3' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_3__in0;
  wire [0:0] mux_3__in0_stop_upstream;
  wire [0:0] mux_3__in0_valid_upstream;
  wire [31:0] mux_3__in1;
  wire [0:0] mux_3__in1_stop_upstream;
  wire [0:0] mux_3__in1_valid_upstream;
  wire [31:0] mux_3__in2;
  wire [0:0] mux_3__in2_stop_upstream;
  wire [0:0] mux_3__in2_valid_upstream;
  wire [31:0] mux_3__in3;
  wire [0:0] mux_3__in3_stop_upstream;
  wire [0:0] mux_3__in3_valid_upstream;
  wire [31:0] mux_3__in4;
  wire [0:0] mux_3__in4_stop_upstream;
  wire [0:0] mux_3__in4_valid_upstream;
  wire [31:0] mux_3__in5;
  wire [0:0] mux_3__in5_stop_upstream;
  wire [0:0] mux_3__in5_valid_upstream;
  wire [31:0] mux_3__in6;
  wire [0:0] mux_3__in6_stop_upstream;
  wire [0:0] mux_3__in6_valid_upstream;
  wire [31:0] mux_3__in7;
  wire [0:0] mux_3__in7_stop_upstream;
  wire [0:0] mux_3__in7_valid_upstream;
  wire [31:0] mux_3__in8;
  wire [0:0] mux_3__in8_stop_upstream;
  wire [0:0] mux_3__in8_valid_upstream;
  wire [31:0] mux_3__out;
  wire [0:0] mux_3__out_stop_downstream;
  wire [0:0] mux_3__out_valid_downstream;
  wire [3:0] mux_3__select;
  wire [0:0] mux_3__select_stop_upstream;
  wire [0:0] mux_3__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_3(
    .in0(mux_3__in0),
    .in0_stop_upstream(mux_3__in0_stop_upstream),
    .in0_valid_upstream(mux_3__in0_valid_upstream),
    .in1(mux_3__in1),
    .in1_stop_upstream(mux_3__in1_stop_upstream),
    .in1_valid_upstream(mux_3__in1_valid_upstream),
    .in2(mux_3__in2),
    .in2_stop_upstream(mux_3__in2_stop_upstream),
    .in2_valid_upstream(mux_3__in2_valid_upstream),
    .in3(mux_3__in3),
    .in3_stop_upstream(mux_3__in3_stop_upstream),
    .in3_valid_upstream(mux_3__in3_valid_upstream),
    .in4(mux_3__in4),
    .in4_stop_upstream(mux_3__in4_stop_upstream),
    .in4_valid_upstream(mux_3__in4_valid_upstream),
    .in5(mux_3__in5),
    .in5_stop_upstream(mux_3__in5_stop_upstream),
    .in5_valid_upstream(mux_3__in5_valid_upstream),
    .in6(mux_3__in6),
    .in6_stop_upstream(mux_3__in6_stop_upstream),
    .in6_valid_upstream(mux_3__in6_valid_upstream),
    .in7(mux_3__in7),
    .in7_stop_upstream(mux_3__in7_stop_upstream),
    .in7_valid_upstream(mux_3__in7_valid_upstream),
    .in8(mux_3__in8),
    .in8_stop_upstream(mux_3__in8_stop_upstream),
    .in8_valid_upstream(mux_3__in8_valid_upstream),
    .out(mux_3__out),
    .out_stop_downstream(mux_3__out_stop_downstream),
    .out_valid_downstream(mux_3__out_valid_downstream),
    .select(mux_3__select),
    .select_stop_upstream(mux_3__select_stop_upstream),
    .select_valid_upstream(mux_3__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_4' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_4__in0;
  wire [0:0] mux_4__in0_stop_upstream;
  wire [0:0] mux_4__in0_valid_upstream;
  wire [31:0] mux_4__in1;
  wire [0:0] mux_4__in1_stop_upstream;
  wire [0:0] mux_4__in1_valid_upstream;
  wire [31:0] mux_4__in2;
  wire [0:0] mux_4__in2_stop_upstream;
  wire [0:0] mux_4__in2_valid_upstream;
  wire [31:0] mux_4__in3;
  wire [0:0] mux_4__in3_stop_upstream;
  wire [0:0] mux_4__in3_valid_upstream;
  wire [31:0] mux_4__in4;
  wire [0:0] mux_4__in4_stop_upstream;
  wire [0:0] mux_4__in4_valid_upstream;
  wire [31:0] mux_4__in5;
  wire [0:0] mux_4__in5_stop_upstream;
  wire [0:0] mux_4__in5_valid_upstream;
  wire [31:0] mux_4__in6;
  wire [0:0] mux_4__in6_stop_upstream;
  wire [0:0] mux_4__in6_valid_upstream;
  wire [31:0] mux_4__in7;
  wire [0:0] mux_4__in7_stop_upstream;
  wire [0:0] mux_4__in7_valid_upstream;
  wire [31:0] mux_4__in8;
  wire [0:0] mux_4__in8_stop_upstream;
  wire [0:0] mux_4__in8_valid_upstream;
  wire [31:0] mux_4__out;
  wire [0:0] mux_4__out_stop_downstream;
  wire [0:0] mux_4__out_valid_downstream;
  wire [3:0] mux_4__select;
  wire [0:0] mux_4__select_stop_upstream;
  wire [0:0] mux_4__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_4(
    .in0(mux_4__in0),
    .in0_stop_upstream(mux_4__in0_stop_upstream),
    .in0_valid_upstream(mux_4__in0_valid_upstream),
    .in1(mux_4__in1),
    .in1_stop_upstream(mux_4__in1_stop_upstream),
    .in1_valid_upstream(mux_4__in1_valid_upstream),
    .in2(mux_4__in2),
    .in2_stop_upstream(mux_4__in2_stop_upstream),
    .in2_valid_upstream(mux_4__in2_valid_upstream),
    .in3(mux_4__in3),
    .in3_stop_upstream(mux_4__in3_stop_upstream),
    .in3_valid_upstream(mux_4__in3_valid_upstream),
    .in4(mux_4__in4),
    .in4_stop_upstream(mux_4__in4_stop_upstream),
    .in4_valid_upstream(mux_4__in4_valid_upstream),
    .in5(mux_4__in5),
    .in5_stop_upstream(mux_4__in5_stop_upstream),
    .in5_valid_upstream(mux_4__in5_valid_upstream),
    .in6(mux_4__in6),
    .in6_stop_upstream(mux_4__in6_stop_upstream),
    .in6_valid_upstream(mux_4__in6_valid_upstream),
    .in7(mux_4__in7),
    .in7_stop_upstream(mux_4__in7_stop_upstream),
    .in7_valid_upstream(mux_4__in7_valid_upstream),
    .in8(mux_4__in8),
    .in8_stop_upstream(mux_4__in8_stop_upstream),
    .in8_valid_upstream(mux_4__in8_valid_upstream),
    .out(mux_4__out),
    .out_stop_downstream(mux_4__out_stop_downstream),
    .out_valid_downstream(mux_4__out_valid_downstream),
    .select(mux_4__select),
    .select_stop_upstream(mux_4__select_stop_upstream),
    .select_valid_upstream(mux_4__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_5' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_5__in0;
  wire [0:0] mux_5__in0_stop_upstream;
  wire [0:0] mux_5__in0_valid_upstream;
  wire [31:0] mux_5__in1;
  wire [0:0] mux_5__in1_stop_upstream;
  wire [0:0] mux_5__in1_valid_upstream;
  wire [31:0] mux_5__in2;
  wire [0:0] mux_5__in2_stop_upstream;
  wire [0:0] mux_5__in2_valid_upstream;
  wire [31:0] mux_5__in3;
  wire [0:0] mux_5__in3_stop_upstream;
  wire [0:0] mux_5__in3_valid_upstream;
  wire [31:0] mux_5__in4;
  wire [0:0] mux_5__in4_stop_upstream;
  wire [0:0] mux_5__in4_valid_upstream;
  wire [31:0] mux_5__in5;
  wire [0:0] mux_5__in5_stop_upstream;
  wire [0:0] mux_5__in5_valid_upstream;
  wire [31:0] mux_5__in6;
  wire [0:0] mux_5__in6_stop_upstream;
  wire [0:0] mux_5__in6_valid_upstream;
  wire [31:0] mux_5__in7;
  wire [0:0] mux_5__in7_stop_upstream;
  wire [0:0] mux_5__in7_valid_upstream;
  wire [31:0] mux_5__in8;
  wire [0:0] mux_5__in8_stop_upstream;
  wire [0:0] mux_5__in8_valid_upstream;
  wire [31:0] mux_5__out;
  wire [0:0] mux_5__out_stop_downstream;
  wire [0:0] mux_5__out_valid_downstream;
  wire [3:0] mux_5__select;
  wire [0:0] mux_5__select_stop_upstream;
  wire [0:0] mux_5__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_5(
    .in0(mux_5__in0),
    .in0_stop_upstream(mux_5__in0_stop_upstream),
    .in0_valid_upstream(mux_5__in0_valid_upstream),
    .in1(mux_5__in1),
    .in1_stop_upstream(mux_5__in1_stop_upstream),
    .in1_valid_upstream(mux_5__in1_valid_upstream),
    .in2(mux_5__in2),
    .in2_stop_upstream(mux_5__in2_stop_upstream),
    .in2_valid_upstream(mux_5__in2_valid_upstream),
    .in3(mux_5__in3),
    .in3_stop_upstream(mux_5__in3_stop_upstream),
    .in3_valid_upstream(mux_5__in3_valid_upstream),
    .in4(mux_5__in4),
    .in4_stop_upstream(mux_5__in4_stop_upstream),
    .in4_valid_upstream(mux_5__in4_valid_upstream),
    .in5(mux_5__in5),
    .in5_stop_upstream(mux_5__in5_stop_upstream),
    .in5_valid_upstream(mux_5__in5_valid_upstream),
    .in6(mux_5__in6),
    .in6_stop_upstream(mux_5__in6_stop_upstream),
    .in6_valid_upstream(mux_5__in6_valid_upstream),
    .in7(mux_5__in7),
    .in7_stop_upstream(mux_5__in7_stop_upstream),
    .in7_valid_upstream(mux_5__in7_valid_upstream),
    .in8(mux_5__in8),
    .in8_stop_upstream(mux_5__in8_stop_upstream),
    .in8_valid_upstream(mux_5__in8_valid_upstream),
    .out(mux_5__out),
    .out_stop_downstream(mux_5__out_stop_downstream),
    .out_valid_downstream(mux_5__out_valid_downstream),
    .select(mux_5__select),
    .select_stop_upstream(mux_5__select_stop_upstream),
    .select_valid_upstream(mux_5__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_6' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_6__in0;
  wire [0:0] mux_6__in0_stop_upstream;
  wire [0:0] mux_6__in0_valid_upstream;
  wire [31:0] mux_6__in1;
  wire [0:0] mux_6__in1_stop_upstream;
  wire [0:0] mux_6__in1_valid_upstream;
  wire [31:0] mux_6__in2;
  wire [0:0] mux_6__in2_stop_upstream;
  wire [0:0] mux_6__in2_valid_upstream;
  wire [31:0] mux_6__in3;
  wire [0:0] mux_6__in3_stop_upstream;
  wire [0:0] mux_6__in3_valid_upstream;
  wire [31:0] mux_6__in4;
  wire [0:0] mux_6__in4_stop_upstream;
  wire [0:0] mux_6__in4_valid_upstream;
  wire [31:0] mux_6__in5;
  wire [0:0] mux_6__in5_stop_upstream;
  wire [0:0] mux_6__in5_valid_upstream;
  wire [31:0] mux_6__in6;
  wire [0:0] mux_6__in6_stop_upstream;
  wire [0:0] mux_6__in6_valid_upstream;
  wire [31:0] mux_6__in7;
  wire [0:0] mux_6__in7_stop_upstream;
  wire [0:0] mux_6__in7_valid_upstream;
  wire [31:0] mux_6__in8;
  wire [0:0] mux_6__in8_stop_upstream;
  wire [0:0] mux_6__in8_valid_upstream;
  wire [31:0] mux_6__out;
  wire [0:0] mux_6__out_stop_downstream;
  wire [0:0] mux_6__out_valid_downstream;
  wire [3:0] mux_6__select;
  wire [0:0] mux_6__select_stop_upstream;
  wire [0:0] mux_6__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_6(
    .in0(mux_6__in0),
    .in0_stop_upstream(mux_6__in0_stop_upstream),
    .in0_valid_upstream(mux_6__in0_valid_upstream),
    .in1(mux_6__in1),
    .in1_stop_upstream(mux_6__in1_stop_upstream),
    .in1_valid_upstream(mux_6__in1_valid_upstream),
    .in2(mux_6__in2),
    .in2_stop_upstream(mux_6__in2_stop_upstream),
    .in2_valid_upstream(mux_6__in2_valid_upstream),
    .in3(mux_6__in3),
    .in3_stop_upstream(mux_6__in3_stop_upstream),
    .in3_valid_upstream(mux_6__in3_valid_upstream),
    .in4(mux_6__in4),
    .in4_stop_upstream(mux_6__in4_stop_upstream),
    .in4_valid_upstream(mux_6__in4_valid_upstream),
    .in5(mux_6__in5),
    .in5_stop_upstream(mux_6__in5_stop_upstream),
    .in5_valid_upstream(mux_6__in5_valid_upstream),
    .in6(mux_6__in6),
    .in6_stop_upstream(mux_6__in6_stop_upstream),
    .in6_valid_upstream(mux_6__in6_valid_upstream),
    .in7(mux_6__in7),
    .in7_stop_upstream(mux_6__in7_stop_upstream),
    .in7_valid_upstream(mux_6__in7_valid_upstream),
    .in8(mux_6__in8),
    .in8_stop_upstream(mux_6__in8_stop_upstream),
    .in8_valid_upstream(mux_6__in8_valid_upstream),
    .out(mux_6__out),
    .out_stop_downstream(mux_6__out_stop_downstream),
    .out_valid_downstream(mux_6__out_valid_downstream),
    .select(mux_6__select),
    .select_stop_upstream(mux_6__select_stop_upstream),
    .select_valid_upstream(mux_6__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_7' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_7__in0;
  wire [0:0] mux_7__in0_stop_upstream;
  wire [0:0] mux_7__in0_valid_upstream;
  wire [31:0] mux_7__in1;
  wire [0:0] mux_7__in1_stop_upstream;
  wire [0:0] mux_7__in1_valid_upstream;
  wire [31:0] mux_7__in2;
  wire [0:0] mux_7__in2_stop_upstream;
  wire [0:0] mux_7__in2_valid_upstream;
  wire [31:0] mux_7__in3;
  wire [0:0] mux_7__in3_stop_upstream;
  wire [0:0] mux_7__in3_valid_upstream;
  wire [31:0] mux_7__in4;
  wire [0:0] mux_7__in4_stop_upstream;
  wire [0:0] mux_7__in4_valid_upstream;
  wire [31:0] mux_7__in5;
  wire [0:0] mux_7__in5_stop_upstream;
  wire [0:0] mux_7__in5_valid_upstream;
  wire [31:0] mux_7__in6;
  wire [0:0] mux_7__in6_stop_upstream;
  wire [0:0] mux_7__in6_valid_upstream;
  wire [31:0] mux_7__in7;
  wire [0:0] mux_7__in7_stop_upstream;
  wire [0:0] mux_7__in7_valid_upstream;
  wire [31:0] mux_7__in8;
  wire [0:0] mux_7__in8_stop_upstream;
  wire [0:0] mux_7__in8_valid_upstream;
  wire [31:0] mux_7__out;
  wire [0:0] mux_7__out_stop_downstream;
  wire [0:0] mux_7__out_valid_downstream;
  wire [3:0] mux_7__select;
  wire [0:0] mux_7__select_stop_upstream;
  wire [0:0] mux_7__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_7(
    .in0(mux_7__in0),
    .in0_stop_upstream(mux_7__in0_stop_upstream),
    .in0_valid_upstream(mux_7__in0_valid_upstream),
    .in1(mux_7__in1),
    .in1_stop_upstream(mux_7__in1_stop_upstream),
    .in1_valid_upstream(mux_7__in1_valid_upstream),
    .in2(mux_7__in2),
    .in2_stop_upstream(mux_7__in2_stop_upstream),
    .in2_valid_upstream(mux_7__in2_valid_upstream),
    .in3(mux_7__in3),
    .in3_stop_upstream(mux_7__in3_stop_upstream),
    .in3_valid_upstream(mux_7__in3_valid_upstream),
    .in4(mux_7__in4),
    .in4_stop_upstream(mux_7__in4_stop_upstream),
    .in4_valid_upstream(mux_7__in4_valid_upstream),
    .in5(mux_7__in5),
    .in5_stop_upstream(mux_7__in5_stop_upstream),
    .in5_valid_upstream(mux_7__in5_valid_upstream),
    .in6(mux_7__in6),
    .in6_stop_upstream(mux_7__in6_stop_upstream),
    .in6_valid_upstream(mux_7__in6_valid_upstream),
    .in7(mux_7__in7),
    .in7_stop_upstream(mux_7__in7_stop_upstream),
    .in7_valid_upstream(mux_7__in7_valid_upstream),
    .in8(mux_7__in8),
    .in8_stop_upstream(mux_7__in8_stop_upstream),
    .in8_valid_upstream(mux_7__in8_valid_upstream),
    .out(mux_7__out),
    .out_stop_downstream(mux_7__out_stop_downstream),
    .out_valid_downstream(mux_7__out_valid_downstream),
    .select(mux_7__select),
    .select_stop_upstream(mux_7__select_stop_upstream),
    .select_valid_upstream(mux_7__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_8' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_8__in0;
  wire [0:0] mux_8__in0_stop_upstream;
  wire [0:0] mux_8__in0_valid_upstream;
  wire [31:0] mux_8__in1;
  wire [0:0] mux_8__in1_stop_upstream;
  wire [0:0] mux_8__in1_valid_upstream;
  wire [31:0] mux_8__in2;
  wire [0:0] mux_8__in2_stop_upstream;
  wire [0:0] mux_8__in2_valid_upstream;
  wire [31:0] mux_8__in3;
  wire [0:0] mux_8__in3_stop_upstream;
  wire [0:0] mux_8__in3_valid_upstream;
  wire [31:0] mux_8__in4;
  wire [0:0] mux_8__in4_stop_upstream;
  wire [0:0] mux_8__in4_valid_upstream;
  wire [31:0] mux_8__in5;
  wire [0:0] mux_8__in5_stop_upstream;
  wire [0:0] mux_8__in5_valid_upstream;
  wire [31:0] mux_8__in6;
  wire [0:0] mux_8__in6_stop_upstream;
  wire [0:0] mux_8__in6_valid_upstream;
  wire [31:0] mux_8__in7;
  wire [0:0] mux_8__in7_stop_upstream;
  wire [0:0] mux_8__in7_valid_upstream;
  wire [31:0] mux_8__in8;
  wire [0:0] mux_8__in8_stop_upstream;
  wire [0:0] mux_8__in8_valid_upstream;
  wire [31:0] mux_8__out;
  wire [0:0] mux_8__out_stop_downstream;
  wire [0:0] mux_8__out_valid_downstream;
  wire [3:0] mux_8__select;
  wire [0:0] mux_8__select_stop_upstream;
  wire [0:0] mux_8__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_8(
    .in0(mux_8__in0),
    .in0_stop_upstream(mux_8__in0_stop_upstream),
    .in0_valid_upstream(mux_8__in0_valid_upstream),
    .in1(mux_8__in1),
    .in1_stop_upstream(mux_8__in1_stop_upstream),
    .in1_valid_upstream(mux_8__in1_valid_upstream),
    .in2(mux_8__in2),
    .in2_stop_upstream(mux_8__in2_stop_upstream),
    .in2_valid_upstream(mux_8__in2_valid_upstream),
    .in3(mux_8__in3),
    .in3_stop_upstream(mux_8__in3_stop_upstream),
    .in3_valid_upstream(mux_8__in3_valid_upstream),
    .in4(mux_8__in4),
    .in4_stop_upstream(mux_8__in4_stop_upstream),
    .in4_valid_upstream(mux_8__in4_valid_upstream),
    .in5(mux_8__in5),
    .in5_stop_upstream(mux_8__in5_stop_upstream),
    .in5_valid_upstream(mux_8__in5_valid_upstream),
    .in6(mux_8__in6),
    .in6_stop_upstream(mux_8__in6_stop_upstream),
    .in6_valid_upstream(mux_8__in6_valid_upstream),
    .in7(mux_8__in7),
    .in7_stop_upstream(mux_8__in7_stop_upstream),
    .in7_valid_upstream(mux_8__in7_valid_upstream),
    .in8(mux_8__in8),
    .in8_stop_upstream(mux_8__in8_stop_upstream),
    .in8_valid_upstream(mux_8__in8_valid_upstream),
    .out(mux_8__out),
    .out_stop_downstream(mux_8__out_stop_downstream),
    .out_valid_downstream(mux_8__out_valid_downstream),
    .select(mux_8__select),
    .select_stop_upstream(mux_8__select_stop_upstream),
    .select_valid_upstream(mux_8__select_valid_upstream)
  );

  //Wire declarations for instance 'mux_9' (Module cgrame_elastic_mux_9to1_32b)
  wire [31:0] mux_9__in0;
  wire [0:0] mux_9__in0_stop_upstream;
  wire [0:0] mux_9__in0_valid_upstream;
  wire [31:0] mux_9__in1;
  wire [0:0] mux_9__in1_stop_upstream;
  wire [0:0] mux_9__in1_valid_upstream;
  wire [31:0] mux_9__in2;
  wire [0:0] mux_9__in2_stop_upstream;
  wire [0:0] mux_9__in2_valid_upstream;
  wire [31:0] mux_9__in3;
  wire [0:0] mux_9__in3_stop_upstream;
  wire [0:0] mux_9__in3_valid_upstream;
  wire [31:0] mux_9__in4;
  wire [0:0] mux_9__in4_stop_upstream;
  wire [0:0] mux_9__in4_valid_upstream;
  wire [31:0] mux_9__in5;
  wire [0:0] mux_9__in5_stop_upstream;
  wire [0:0] mux_9__in5_valid_upstream;
  wire [31:0] mux_9__in6;
  wire [0:0] mux_9__in6_stop_upstream;
  wire [0:0] mux_9__in6_valid_upstream;
  wire [31:0] mux_9__in7;
  wire [0:0] mux_9__in7_stop_upstream;
  wire [0:0] mux_9__in7_valid_upstream;
  wire [31:0] mux_9__in8;
  wire [0:0] mux_9__in8_stop_upstream;
  wire [0:0] mux_9__in8_valid_upstream;
  wire [31:0] mux_9__out;
  wire [0:0] mux_9__out_stop_downstream;
  wire [0:0] mux_9__out_valid_downstream;
  wire [3:0] mux_9__select;
  wire [0:0] mux_9__select_stop_upstream;
  wire [0:0] mux_9__select_valid_upstream;
  cgrame_elastic_mux_9to1_32b #(.contexts(1),.size(32)) mux_9(
    .in0(mux_9__in0),
    .in0_stop_upstream(mux_9__in0_stop_upstream),
    .in0_valid_upstream(mux_9__in0_valid_upstream),
    .in1(mux_9__in1),
    .in1_stop_upstream(mux_9__in1_stop_upstream),
    .in1_valid_upstream(mux_9__in1_valid_upstream),
    .in2(mux_9__in2),
    .in2_stop_upstream(mux_9__in2_stop_upstream),
    .in2_valid_upstream(mux_9__in2_valid_upstream),
    .in3(mux_9__in3),
    .in3_stop_upstream(mux_9__in3_stop_upstream),
    .in3_valid_upstream(mux_9__in3_valid_upstream),
    .in4(mux_9__in4),
    .in4_stop_upstream(mux_9__in4_stop_upstream),
    .in4_valid_upstream(mux_9__in4_valid_upstream),
    .in5(mux_9__in5),
    .in5_stop_upstream(mux_9__in5_stop_upstream),
    .in5_valid_upstream(mux_9__in5_valid_upstream),
    .in6(mux_9__in6),
    .in6_stop_upstream(mux_9__in6_stop_upstream),
    .in6_valid_upstream(mux_9__in6_valid_upstream),
    .in7(mux_9__in7),
    .in7_stop_upstream(mux_9__in7_stop_upstream),
    .in7_valid_upstream(mux_9__in7_valid_upstream),
    .in8(mux_9__in8),
    .in8_stop_upstream(mux_9__in8_stop_upstream),
    .in8_valid_upstream(mux_9__in8_valid_upstream),
    .out(mux_9__out),
    .out_stop_downstream(mux_9__out_stop_downstream),
    .out_valid_downstream(mux_9__out_valid_downstream),
    .select(mux_9__select),
    .select_stop_upstream(mux_9__select_stop_upstream),
    .select_valid_upstream(mux_9__select_valid_upstream)
  );

  //All the connections
  assign fork_crossbar0__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar1__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar2__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar3__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar4__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar5__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar6__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar7__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar8__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar0Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar1Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar2Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar3Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar4Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar5Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar6Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar7Config__CGRA_Clock = CGRA_Clock;
  assign ForkCrossbar8Config__CGRA_Clock = CGRA_Clock;
  assign Mux0config__CGRA_Clock = CGRA_Clock;
  assign Mux1config__CGRA_Clock = CGRA_Clock;
  assign Mux2config__CGRA_Clock = CGRA_Clock;
  assign Mux3config__CGRA_Clock = CGRA_Clock;
  assign Mux4config__CGRA_Clock = CGRA_Clock;
  assign Mux5config__CGRA_Clock = CGRA_Clock;
  assign Mux6config__CGRA_Clock = CGRA_Clock;
  assign Mux7config__CGRA_Clock = CGRA_Clock;
  assign Mux8config__CGRA_Clock = CGRA_Clock;
  assign Mux9config__CGRA_Clock = CGRA_Clock;
  assign fork_crossbar0__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar1__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar2__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar3__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar4__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar5__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar6__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar7__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar8__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar0Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar1Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar2Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar3Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar4Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar5Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar6Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar7Config__CGRA_Reset = CGRA_Reset;
  assign ForkCrossbar8Config__CGRA_Reset = CGRA_Reset;
  assign Mux0config__CGRA_Reset = CGRA_Reset;
  assign Mux1config__CGRA_Reset = CGRA_Reset;
  assign Mux2config__CGRA_Reset = CGRA_Reset;
  assign Mux3config__CGRA_Reset = CGRA_Reset;
  assign Mux4config__CGRA_Reset = CGRA_Reset;
  assign Mux5config__CGRA_Reset = CGRA_Reset;
  assign Mux6config__CGRA_Reset = CGRA_Reset;
  assign Mux7config__CGRA_Reset = CGRA_Reset;
  assign Mux8config__CGRA_Reset = CGRA_Reset;
  assign Mux9config__CGRA_Reset = CGRA_Reset;
  assign fork_crossbar0__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar1__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar2__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar3__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar4__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar5__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar6__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar7__CGRA_Enable = CGRA_Enable;
  assign fork_crossbar8__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar1Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar2Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar3Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar4Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar5Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar6Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar7Config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar8Config__CGRA_Enable = CGRA_Enable;
  assign Mux0config__CGRA_Enable = CGRA_Enable;
  assign Mux1config__CGRA_Enable = CGRA_Enable;
  assign Mux2config__CGRA_Enable = CGRA_Enable;
  assign Mux3config__CGRA_Enable = CGRA_Enable;
  assign Mux4config__CGRA_Enable = CGRA_Enable;
  assign Mux5config__CGRA_Enable = CGRA_Enable;
  assign Mux6config__CGRA_Enable = CGRA_Enable;
  assign Mux7config__CGRA_Enable = CGRA_Enable;
  assign Mux8config__CGRA_Enable = CGRA_Enable;
  assign Mux9config__CGRA_Enable = CGRA_Enable;
  assign ForkCrossbar0Config__Config_Clock = Config_Clock;
  assign ForkCrossbar1Config__Config_Clock = Config_Clock;
  assign ForkCrossbar2Config__Config_Clock = Config_Clock;
  assign ForkCrossbar3Config__Config_Clock = Config_Clock;
  assign ForkCrossbar4Config__Config_Clock = Config_Clock;
  assign ForkCrossbar5Config__Config_Clock = Config_Clock;
  assign ForkCrossbar6Config__Config_Clock = Config_Clock;
  assign ForkCrossbar7Config__Config_Clock = Config_Clock;
  assign ForkCrossbar8Config__Config_Clock = Config_Clock;
  assign Mux0config__Config_Clock = Config_Clock;
  assign Mux1config__Config_Clock = Config_Clock;
  assign Mux2config__Config_Clock = Config_Clock;
  assign Mux3config__Config_Clock = Config_Clock;
  assign Mux4config__Config_Clock = Config_Clock;
  assign Mux5config__Config_Clock = Config_Clock;
  assign Mux6config__Config_Clock = Config_Clock;
  assign Mux7config__Config_Clock = Config_Clock;
  assign Mux8config__Config_Clock = Config_Clock;
  assign Mux9config__Config_Clock = Config_Clock;
  assign ForkCrossbar0Config__Config_Reset = Config_Reset;
  assign ForkCrossbar1Config__Config_Reset = Config_Reset;
  assign ForkCrossbar2Config__Config_Reset = Config_Reset;
  assign ForkCrossbar3Config__Config_Reset = Config_Reset;
  assign ForkCrossbar4Config__Config_Reset = Config_Reset;
  assign ForkCrossbar5Config__Config_Reset = Config_Reset;
  assign ForkCrossbar6Config__Config_Reset = Config_Reset;
  assign ForkCrossbar7Config__Config_Reset = Config_Reset;
  assign ForkCrossbar8Config__Config_Reset = Config_Reset;
  assign Mux0config__Config_Reset = Config_Reset;
  assign Mux1config__Config_Reset = Config_Reset;
  assign Mux2config__Config_Reset = Config_Reset;
  assign Mux3config__Config_Reset = Config_Reset;
  assign Mux4config__Config_Reset = Config_Reset;
  assign Mux5config__Config_Reset = Config_Reset;
  assign Mux6config__Config_Reset = Config_Reset;
  assign Mux7config__Config_Reset = Config_Reset;
  assign Mux8config__Config_Reset = Config_Reset;
  assign Mux9config__Config_Reset = Config_Reset;
  assign fork_crossbar0__out0_stop_downstream[0:0] = mux_0__in0_stop_upstream[0:0];
  assign fork_crossbar1__out0_stop_downstream[0:0] = mux_0__in1_stop_upstream[0:0];
  assign fork_crossbar2__out0_stop_downstream[0:0] = mux_0__in2_stop_upstream[0:0];
  assign fork_crossbar3__out0_stop_downstream[0:0] = mux_0__in3_stop_upstream[0:0];
  assign fork_crossbar4__out0_stop_downstream[0:0] = mux_0__in4_stop_upstream[0:0];
  assign fork_crossbar5__out0_stop_downstream[0:0] = mux_0__in5_stop_upstream[0:0];
  assign fork_crossbar6__out0_stop_downstream[0:0] = mux_0__in6_stop_upstream[0:0];
  assign fork_crossbar7__out0_stop_downstream[0:0] = mux_0__in7_stop_upstream[0:0];
  assign fork_crossbar8__out0_stop_downstream[0:0] = mux_0__in8_stop_upstream[0:0];
  assign out0[31:0] = mux_0__out[31:0];
  assign out0_valid_downstream[0:0] = mux_0__out_valid_downstream[0:0];
  assign fork_crossbar0__out1_stop_downstream[0:0] = mux_1__in0_stop_upstream[0:0];
  assign fork_crossbar1__out1_stop_downstream[0:0] = mux_1__in1_stop_upstream[0:0];
  assign fork_crossbar2__out1_stop_downstream[0:0] = mux_1__in2_stop_upstream[0:0];
  assign fork_crossbar3__out1_stop_downstream[0:0] = mux_1__in3_stop_upstream[0:0];
  assign fork_crossbar4__out1_stop_downstream[0:0] = mux_1__in4_stop_upstream[0:0];
  assign fork_crossbar5__out1_stop_downstream[0:0] = mux_1__in5_stop_upstream[0:0];
  assign fork_crossbar6__out1_stop_downstream[0:0] = mux_1__in6_stop_upstream[0:0];
  assign fork_crossbar7__out1_stop_downstream[0:0] = mux_1__in7_stop_upstream[0:0];
  assign fork_crossbar8__out1_stop_downstream[0:0] = mux_1__in8_stop_upstream[0:0];
  assign out1[31:0] = mux_1__out[31:0];
  assign out1_valid_downstream[0:0] = mux_1__out_valid_downstream[0:0];
  assign fork_crossbar0__out2_stop_downstream[0:0] = mux_2__in0_stop_upstream[0:0];
  assign fork_crossbar1__out2_stop_downstream[0:0] = mux_2__in1_stop_upstream[0:0];
  assign fork_crossbar2__out2_stop_downstream[0:0] = mux_2__in2_stop_upstream[0:0];
  assign fork_crossbar3__out2_stop_downstream[0:0] = mux_2__in3_stop_upstream[0:0];
  assign fork_crossbar4__out2_stop_downstream[0:0] = mux_2__in4_stop_upstream[0:0];
  assign fork_crossbar5__out2_stop_downstream[0:0] = mux_2__in5_stop_upstream[0:0];
  assign fork_crossbar6__out2_stop_downstream[0:0] = mux_2__in6_stop_upstream[0:0];
  assign fork_crossbar7__out2_stop_downstream[0:0] = mux_2__in7_stop_upstream[0:0];
  assign fork_crossbar8__out2_stop_downstream[0:0] = mux_2__in8_stop_upstream[0:0];
  assign out2[31:0] = mux_2__out[31:0];
  assign out2_valid_downstream[0:0] = mux_2__out_valid_downstream[0:0];
  assign fork_crossbar0__out3_stop_downstream[0:0] = mux_3__in0_stop_upstream[0:0];
  assign fork_crossbar1__out3_stop_downstream[0:0] = mux_3__in1_stop_upstream[0:0];
  assign fork_crossbar2__out3_stop_downstream[0:0] = mux_3__in2_stop_upstream[0:0];
  assign fork_crossbar3__out3_stop_downstream[0:0] = mux_3__in3_stop_upstream[0:0];
  assign fork_crossbar4__out3_stop_downstream[0:0] = mux_3__in4_stop_upstream[0:0];
  assign fork_crossbar5__out3_stop_downstream[0:0] = mux_3__in5_stop_upstream[0:0];
  assign fork_crossbar6__out3_stop_downstream[0:0] = mux_3__in6_stop_upstream[0:0];
  assign fork_crossbar7__out3_stop_downstream[0:0] = mux_3__in7_stop_upstream[0:0];
  assign fork_crossbar8__out3_stop_downstream[0:0] = mux_3__in8_stop_upstream[0:0];
  assign out3[31:0] = mux_3__out[31:0];
  assign out3_valid_downstream[0:0] = mux_3__out_valid_downstream[0:0];
  assign fork_crossbar0__out4_stop_downstream[0:0] = mux_4__in0_stop_upstream[0:0];
  assign fork_crossbar1__out4_stop_downstream[0:0] = mux_4__in1_stop_upstream[0:0];
  assign fork_crossbar2__out4_stop_downstream[0:0] = mux_4__in2_stop_upstream[0:0];
  assign fork_crossbar3__out4_stop_downstream[0:0] = mux_4__in3_stop_upstream[0:0];
  assign fork_crossbar4__out4_stop_downstream[0:0] = mux_4__in4_stop_upstream[0:0];
  assign fork_crossbar5__out4_stop_downstream[0:0] = mux_4__in5_stop_upstream[0:0];
  assign fork_crossbar6__out4_stop_downstream[0:0] = mux_4__in6_stop_upstream[0:0];
  assign fork_crossbar7__out4_stop_downstream[0:0] = mux_4__in7_stop_upstream[0:0];
  assign fork_crossbar8__out4_stop_downstream[0:0] = mux_4__in8_stop_upstream[0:0];
  assign out4[31:0] = mux_4__out[31:0];
  assign out4_valid_downstream[0:0] = mux_4__out_valid_downstream[0:0];
  assign fork_crossbar0__out5_stop_downstream[0:0] = mux_5__in0_stop_upstream[0:0];
  assign fork_crossbar1__out5_stop_downstream[0:0] = mux_5__in1_stop_upstream[0:0];
  assign fork_crossbar2__out5_stop_downstream[0:0] = mux_5__in2_stop_upstream[0:0];
  assign fork_crossbar3__out5_stop_downstream[0:0] = mux_5__in3_stop_upstream[0:0];
  assign fork_crossbar4__out5_stop_downstream[0:0] = mux_5__in4_stop_upstream[0:0];
  assign fork_crossbar5__out5_stop_downstream[0:0] = mux_5__in5_stop_upstream[0:0];
  assign fork_crossbar6__out5_stop_downstream[0:0] = mux_5__in6_stop_upstream[0:0];
  assign fork_crossbar7__out5_stop_downstream[0:0] = mux_5__in7_stop_upstream[0:0];
  assign fork_crossbar8__out5_stop_downstream[0:0] = mux_5__in8_stop_upstream[0:0];
  assign out5[31:0] = mux_5__out[31:0];
  assign out5_valid_downstream[0:0] = mux_5__out_valid_downstream[0:0];
  assign fork_crossbar0__out6_stop_downstream[0:0] = mux_6__in0_stop_upstream[0:0];
  assign fork_crossbar1__out6_stop_downstream[0:0] = mux_6__in1_stop_upstream[0:0];
  assign fork_crossbar2__out6_stop_downstream[0:0] = mux_6__in2_stop_upstream[0:0];
  assign fork_crossbar3__out6_stop_downstream[0:0] = mux_6__in3_stop_upstream[0:0];
  assign fork_crossbar4__out6_stop_downstream[0:0] = mux_6__in4_stop_upstream[0:0];
  assign fork_crossbar5__out6_stop_downstream[0:0] = mux_6__in5_stop_upstream[0:0];
  assign fork_crossbar6__out6_stop_downstream[0:0] = mux_6__in6_stop_upstream[0:0];
  assign fork_crossbar7__out6_stop_downstream[0:0] = mux_6__in7_stop_upstream[0:0];
  assign fork_crossbar8__out6_stop_downstream[0:0] = mux_6__in8_stop_upstream[0:0];
  assign out6[31:0] = mux_6__out[31:0];
  assign out6_valid_downstream[0:0] = mux_6__out_valid_downstream[0:0];
  assign fork_crossbar0__out7_stop_downstream[0:0] = mux_7__in0_stop_upstream[0:0];
  assign fork_crossbar1__out7_stop_downstream[0:0] = mux_7__in1_stop_upstream[0:0];
  assign fork_crossbar2__out7_stop_downstream[0:0] = mux_7__in2_stop_upstream[0:0];
  assign fork_crossbar3__out7_stop_downstream[0:0] = mux_7__in3_stop_upstream[0:0];
  assign fork_crossbar4__out7_stop_downstream[0:0] = mux_7__in4_stop_upstream[0:0];
  assign fork_crossbar5__out7_stop_downstream[0:0] = mux_7__in5_stop_upstream[0:0];
  assign fork_crossbar6__out7_stop_downstream[0:0] = mux_7__in6_stop_upstream[0:0];
  assign fork_crossbar7__out7_stop_downstream[0:0] = mux_7__in7_stop_upstream[0:0];
  assign fork_crossbar8__out7_stop_downstream[0:0] = mux_7__in8_stop_upstream[0:0];
  assign out7[31:0] = mux_7__out[31:0];
  assign out7_valid_downstream[0:0] = mux_7__out_valid_downstream[0:0];
  assign fork_crossbar0__out8_stop_downstream[0:0] = mux_8__in0_stop_upstream[0:0];
  assign fork_crossbar1__out8_stop_downstream[0:0] = mux_8__in1_stop_upstream[0:0];
  assign fork_crossbar2__out8_stop_downstream[0:0] = mux_8__in2_stop_upstream[0:0];
  assign fork_crossbar3__out8_stop_downstream[0:0] = mux_8__in3_stop_upstream[0:0];
  assign fork_crossbar4__out8_stop_downstream[0:0] = mux_8__in4_stop_upstream[0:0];
  assign fork_crossbar5__out8_stop_downstream[0:0] = mux_8__in5_stop_upstream[0:0];
  assign fork_crossbar6__out8_stop_downstream[0:0] = mux_8__in6_stop_upstream[0:0];
  assign fork_crossbar7__out8_stop_downstream[0:0] = mux_8__in7_stop_upstream[0:0];
  assign fork_crossbar8__out8_stop_downstream[0:0] = mux_8__in8_stop_upstream[0:0];
  assign out8[31:0] = mux_8__out[31:0];
  assign out8_valid_downstream[0:0] = mux_8__out_valid_downstream[0:0];
  assign fork_crossbar0__out9_stop_downstream[0:0] = mux_9__in0_stop_upstream[0:0];
  assign fork_crossbar1__out9_stop_downstream[0:0] = mux_9__in1_stop_upstream[0:0];
  assign fork_crossbar2__out9_stop_downstream[0:0] = mux_9__in2_stop_upstream[0:0];
  assign fork_crossbar3__out9_stop_downstream[0:0] = mux_9__in3_stop_upstream[0:0];
  assign fork_crossbar4__out9_stop_downstream[0:0] = mux_9__in4_stop_upstream[0:0];
  assign fork_crossbar5__out9_stop_downstream[0:0] = mux_9__in5_stop_upstream[0:0];
  assign fork_crossbar6__out9_stop_downstream[0:0] = mux_9__in6_stop_upstream[0:0];
  assign fork_crossbar7__out9_stop_downstream[0:0] = mux_9__in7_stop_upstream[0:0];
  assign fork_crossbar8__out9_stop_downstream[0:0] = mux_9__in8_stop_upstream[0:0];
  assign out9[31:0] = mux_9__out[31:0];
  assign out9_valid_downstream[0:0] = mux_9__out_valid_downstream[0:0];
  assign fork_crossbar0__in[31:0] = in0[31:0];
  assign fork_crossbar0__in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign in0_stop_upstream[0:0] = fork_crossbar0__in_stop_upstream[0:0];
  assign mux_0__in0[31:0] = fork_crossbar0__out0[31:0];
  assign mux_0__in0_valid_upstream[0:0] = fork_crossbar0__out0_valid_downstream[0:0];
  assign mux_1__in0[31:0] = fork_crossbar0__out1[31:0];
  assign mux_1__in0_valid_upstream[0:0] = fork_crossbar0__out1_valid_downstream[0:0];
  assign mux_2__in0[31:0] = fork_crossbar0__out2[31:0];
  assign mux_2__in0_valid_upstream[0:0] = fork_crossbar0__out2_valid_downstream[0:0];
  assign mux_3__in0[31:0] = fork_crossbar0__out3[31:0];
  assign mux_3__in0_valid_upstream[0:0] = fork_crossbar0__out3_valid_downstream[0:0];
  assign mux_4__in0[31:0] = fork_crossbar0__out4[31:0];
  assign mux_4__in0_valid_upstream[0:0] = fork_crossbar0__out4_valid_downstream[0:0];
  assign mux_5__in0[31:0] = fork_crossbar0__out5[31:0];
  assign mux_5__in0_valid_upstream[0:0] = fork_crossbar0__out5_valid_downstream[0:0];
  assign mux_6__in0[31:0] = fork_crossbar0__out6[31:0];
  assign mux_6__in0_valid_upstream[0:0] = fork_crossbar0__out6_valid_downstream[0:0];
  assign mux_7__in0[31:0] = fork_crossbar0__out7[31:0];
  assign mux_7__in0_valid_upstream[0:0] = fork_crossbar0__out7_valid_downstream[0:0];
  assign mux_8__in0[31:0] = fork_crossbar0__out8[31:0];
  assign mux_8__in0_valid_upstream[0:0] = fork_crossbar0__out8_valid_downstream[0:0];
  assign mux_9__in0[31:0] = fork_crossbar0__out9[31:0];
  assign mux_9__in0_valid_upstream[0:0] = fork_crossbar0__out9_valid_downstream[0:0];
  assign fork_crossbar1__in[31:0] = in1[31:0];
  assign fork_crossbar1__in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign in1_stop_upstream[0:0] = fork_crossbar1__in_stop_upstream[0:0];
  assign mux_0__in1[31:0] = fork_crossbar1__out0[31:0];
  assign mux_0__in1_valid_upstream[0:0] = fork_crossbar1__out0_valid_downstream[0:0];
  assign mux_1__in1[31:0] = fork_crossbar1__out1[31:0];
  assign mux_1__in1_valid_upstream[0:0] = fork_crossbar1__out1_valid_downstream[0:0];
  assign mux_2__in1[31:0] = fork_crossbar1__out2[31:0];
  assign mux_2__in1_valid_upstream[0:0] = fork_crossbar1__out2_valid_downstream[0:0];
  assign mux_3__in1[31:0] = fork_crossbar1__out3[31:0];
  assign mux_3__in1_valid_upstream[0:0] = fork_crossbar1__out3_valid_downstream[0:0];
  assign mux_4__in1[31:0] = fork_crossbar1__out4[31:0];
  assign mux_4__in1_valid_upstream[0:0] = fork_crossbar1__out4_valid_downstream[0:0];
  assign mux_5__in1[31:0] = fork_crossbar1__out5[31:0];
  assign mux_5__in1_valid_upstream[0:0] = fork_crossbar1__out5_valid_downstream[0:0];
  assign mux_6__in1[31:0] = fork_crossbar1__out6[31:0];
  assign mux_6__in1_valid_upstream[0:0] = fork_crossbar1__out6_valid_downstream[0:0];
  assign mux_7__in1[31:0] = fork_crossbar1__out7[31:0];
  assign mux_7__in1_valid_upstream[0:0] = fork_crossbar1__out7_valid_downstream[0:0];
  assign mux_8__in1[31:0] = fork_crossbar1__out8[31:0];
  assign mux_8__in1_valid_upstream[0:0] = fork_crossbar1__out8_valid_downstream[0:0];
  assign mux_9__in1[31:0] = fork_crossbar1__out9[31:0];
  assign mux_9__in1_valid_upstream[0:0] = fork_crossbar1__out9_valid_downstream[0:0];
  assign fork_crossbar2__in[31:0] = in2[31:0];
  assign fork_crossbar2__in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign in2_stop_upstream[0:0] = fork_crossbar2__in_stop_upstream[0:0];
  assign mux_0__in2[31:0] = fork_crossbar2__out0[31:0];
  assign mux_0__in2_valid_upstream[0:0] = fork_crossbar2__out0_valid_downstream[0:0];
  assign mux_1__in2[31:0] = fork_crossbar2__out1[31:0];
  assign mux_1__in2_valid_upstream[0:0] = fork_crossbar2__out1_valid_downstream[0:0];
  assign mux_2__in2[31:0] = fork_crossbar2__out2[31:0];
  assign mux_2__in2_valid_upstream[0:0] = fork_crossbar2__out2_valid_downstream[0:0];
  assign mux_3__in2[31:0] = fork_crossbar2__out3[31:0];
  assign mux_3__in2_valid_upstream[0:0] = fork_crossbar2__out3_valid_downstream[0:0];
  assign mux_4__in2[31:0] = fork_crossbar2__out4[31:0];
  assign mux_4__in2_valid_upstream[0:0] = fork_crossbar2__out4_valid_downstream[0:0];
  assign mux_5__in2[31:0] = fork_crossbar2__out5[31:0];
  assign mux_5__in2_valid_upstream[0:0] = fork_crossbar2__out5_valid_downstream[0:0];
  assign mux_6__in2[31:0] = fork_crossbar2__out6[31:0];
  assign mux_6__in2_valid_upstream[0:0] = fork_crossbar2__out6_valid_downstream[0:0];
  assign mux_7__in2[31:0] = fork_crossbar2__out7[31:0];
  assign mux_7__in2_valid_upstream[0:0] = fork_crossbar2__out7_valid_downstream[0:0];
  assign mux_8__in2[31:0] = fork_crossbar2__out8[31:0];
  assign mux_8__in2_valid_upstream[0:0] = fork_crossbar2__out8_valid_downstream[0:0];
  assign mux_9__in2[31:0] = fork_crossbar2__out9[31:0];
  assign mux_9__in2_valid_upstream[0:0] = fork_crossbar2__out9_valid_downstream[0:0];
  assign fork_crossbar3__in[31:0] = in3[31:0];
  assign fork_crossbar3__in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign in3_stop_upstream[0:0] = fork_crossbar3__in_stop_upstream[0:0];
  assign mux_0__in3[31:0] = fork_crossbar3__out0[31:0];
  assign mux_0__in3_valid_upstream[0:0] = fork_crossbar3__out0_valid_downstream[0:0];
  assign mux_1__in3[31:0] = fork_crossbar3__out1[31:0];
  assign mux_1__in3_valid_upstream[0:0] = fork_crossbar3__out1_valid_downstream[0:0];
  assign mux_2__in3[31:0] = fork_crossbar3__out2[31:0];
  assign mux_2__in3_valid_upstream[0:0] = fork_crossbar3__out2_valid_downstream[0:0];
  assign mux_3__in3[31:0] = fork_crossbar3__out3[31:0];
  assign mux_3__in3_valid_upstream[0:0] = fork_crossbar3__out3_valid_downstream[0:0];
  assign mux_4__in3[31:0] = fork_crossbar3__out4[31:0];
  assign mux_4__in3_valid_upstream[0:0] = fork_crossbar3__out4_valid_downstream[0:0];
  assign mux_5__in3[31:0] = fork_crossbar3__out5[31:0];
  assign mux_5__in3_valid_upstream[0:0] = fork_crossbar3__out5_valid_downstream[0:0];
  assign mux_6__in3[31:0] = fork_crossbar3__out6[31:0];
  assign mux_6__in3_valid_upstream[0:0] = fork_crossbar3__out6_valid_downstream[0:0];
  assign mux_7__in3[31:0] = fork_crossbar3__out7[31:0];
  assign mux_7__in3_valid_upstream[0:0] = fork_crossbar3__out7_valid_downstream[0:0];
  assign mux_8__in3[31:0] = fork_crossbar3__out8[31:0];
  assign mux_8__in3_valid_upstream[0:0] = fork_crossbar3__out8_valid_downstream[0:0];
  assign mux_9__in3[31:0] = fork_crossbar3__out9[31:0];
  assign mux_9__in3_valid_upstream[0:0] = fork_crossbar3__out9_valid_downstream[0:0];
  assign fork_crossbar4__in[31:0] = in4[31:0];
  assign fork_crossbar4__in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign in4_stop_upstream[0:0] = fork_crossbar4__in_stop_upstream[0:0];
  assign mux_0__in4[31:0] = fork_crossbar4__out0[31:0];
  assign mux_0__in4_valid_upstream[0:0] = fork_crossbar4__out0_valid_downstream[0:0];
  assign mux_1__in4[31:0] = fork_crossbar4__out1[31:0];
  assign mux_1__in4_valid_upstream[0:0] = fork_crossbar4__out1_valid_downstream[0:0];
  assign mux_2__in4[31:0] = fork_crossbar4__out2[31:0];
  assign mux_2__in4_valid_upstream[0:0] = fork_crossbar4__out2_valid_downstream[0:0];
  assign mux_3__in4[31:0] = fork_crossbar4__out3[31:0];
  assign mux_3__in4_valid_upstream[0:0] = fork_crossbar4__out3_valid_downstream[0:0];
  assign mux_4__in4[31:0] = fork_crossbar4__out4[31:0];
  assign mux_4__in4_valid_upstream[0:0] = fork_crossbar4__out4_valid_downstream[0:0];
  assign mux_5__in4[31:0] = fork_crossbar4__out5[31:0];
  assign mux_5__in4_valid_upstream[0:0] = fork_crossbar4__out5_valid_downstream[0:0];
  assign mux_6__in4[31:0] = fork_crossbar4__out6[31:0];
  assign mux_6__in4_valid_upstream[0:0] = fork_crossbar4__out6_valid_downstream[0:0];
  assign mux_7__in4[31:0] = fork_crossbar4__out7[31:0];
  assign mux_7__in4_valid_upstream[0:0] = fork_crossbar4__out7_valid_downstream[0:0];
  assign mux_8__in4[31:0] = fork_crossbar4__out8[31:0];
  assign mux_8__in4_valid_upstream[0:0] = fork_crossbar4__out8_valid_downstream[0:0];
  assign mux_9__in4[31:0] = fork_crossbar4__out9[31:0];
  assign mux_9__in4_valid_upstream[0:0] = fork_crossbar4__out9_valid_downstream[0:0];
  assign fork_crossbar5__in[31:0] = in5[31:0];
  assign fork_crossbar5__in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign in5_stop_upstream[0:0] = fork_crossbar5__in_stop_upstream[0:0];
  assign mux_0__in5[31:0] = fork_crossbar5__out0[31:0];
  assign mux_0__in5_valid_upstream[0:0] = fork_crossbar5__out0_valid_downstream[0:0];
  assign mux_1__in5[31:0] = fork_crossbar5__out1[31:0];
  assign mux_1__in5_valid_upstream[0:0] = fork_crossbar5__out1_valid_downstream[0:0];
  assign mux_2__in5[31:0] = fork_crossbar5__out2[31:0];
  assign mux_2__in5_valid_upstream[0:0] = fork_crossbar5__out2_valid_downstream[0:0];
  assign mux_3__in5[31:0] = fork_crossbar5__out3[31:0];
  assign mux_3__in5_valid_upstream[0:0] = fork_crossbar5__out3_valid_downstream[0:0];
  assign mux_4__in5[31:0] = fork_crossbar5__out4[31:0];
  assign mux_4__in5_valid_upstream[0:0] = fork_crossbar5__out4_valid_downstream[0:0];
  assign mux_5__in5[31:0] = fork_crossbar5__out5[31:0];
  assign mux_5__in5_valid_upstream[0:0] = fork_crossbar5__out5_valid_downstream[0:0];
  assign mux_6__in5[31:0] = fork_crossbar5__out6[31:0];
  assign mux_6__in5_valid_upstream[0:0] = fork_crossbar5__out6_valid_downstream[0:0];
  assign mux_7__in5[31:0] = fork_crossbar5__out7[31:0];
  assign mux_7__in5_valid_upstream[0:0] = fork_crossbar5__out7_valid_downstream[0:0];
  assign mux_8__in5[31:0] = fork_crossbar5__out8[31:0];
  assign mux_8__in5_valid_upstream[0:0] = fork_crossbar5__out8_valid_downstream[0:0];
  assign mux_9__in5[31:0] = fork_crossbar5__out9[31:0];
  assign mux_9__in5_valid_upstream[0:0] = fork_crossbar5__out9_valid_downstream[0:0];
  assign fork_crossbar6__in[31:0] = in6[31:0];
  assign fork_crossbar6__in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign in6_stop_upstream[0:0] = fork_crossbar6__in_stop_upstream[0:0];
  assign mux_0__in6[31:0] = fork_crossbar6__out0[31:0];
  assign mux_0__in6_valid_upstream[0:0] = fork_crossbar6__out0_valid_downstream[0:0];
  assign mux_1__in6[31:0] = fork_crossbar6__out1[31:0];
  assign mux_1__in6_valid_upstream[0:0] = fork_crossbar6__out1_valid_downstream[0:0];
  assign mux_2__in6[31:0] = fork_crossbar6__out2[31:0];
  assign mux_2__in6_valid_upstream[0:0] = fork_crossbar6__out2_valid_downstream[0:0];
  assign mux_3__in6[31:0] = fork_crossbar6__out3[31:0];
  assign mux_3__in6_valid_upstream[0:0] = fork_crossbar6__out3_valid_downstream[0:0];
  assign mux_4__in6[31:0] = fork_crossbar6__out4[31:0];
  assign mux_4__in6_valid_upstream[0:0] = fork_crossbar6__out4_valid_downstream[0:0];
  assign mux_5__in6[31:0] = fork_crossbar6__out5[31:0];
  assign mux_5__in6_valid_upstream[0:0] = fork_crossbar6__out5_valid_downstream[0:0];
  assign mux_6__in6[31:0] = fork_crossbar6__out6[31:0];
  assign mux_6__in6_valid_upstream[0:0] = fork_crossbar6__out6_valid_downstream[0:0];
  assign mux_7__in6[31:0] = fork_crossbar6__out7[31:0];
  assign mux_7__in6_valid_upstream[0:0] = fork_crossbar6__out7_valid_downstream[0:0];
  assign mux_8__in6[31:0] = fork_crossbar6__out8[31:0];
  assign mux_8__in6_valid_upstream[0:0] = fork_crossbar6__out8_valid_downstream[0:0];
  assign mux_9__in6[31:0] = fork_crossbar6__out9[31:0];
  assign mux_9__in6_valid_upstream[0:0] = fork_crossbar6__out9_valid_downstream[0:0];
  assign fork_crossbar7__in[31:0] = in7[31:0];
  assign fork_crossbar7__in_valid_upstream[0:0] = in7_valid_upstream[0:0];
  assign in7_stop_upstream[0:0] = fork_crossbar7__in_stop_upstream[0:0];
  assign mux_0__in7[31:0] = fork_crossbar7__out0[31:0];
  assign mux_0__in7_valid_upstream[0:0] = fork_crossbar7__out0_valid_downstream[0:0];
  assign mux_1__in7[31:0] = fork_crossbar7__out1[31:0];
  assign mux_1__in7_valid_upstream[0:0] = fork_crossbar7__out1_valid_downstream[0:0];
  assign mux_2__in7[31:0] = fork_crossbar7__out2[31:0];
  assign mux_2__in7_valid_upstream[0:0] = fork_crossbar7__out2_valid_downstream[0:0];
  assign mux_3__in7[31:0] = fork_crossbar7__out3[31:0];
  assign mux_3__in7_valid_upstream[0:0] = fork_crossbar7__out3_valid_downstream[0:0];
  assign mux_4__in7[31:0] = fork_crossbar7__out4[31:0];
  assign mux_4__in7_valid_upstream[0:0] = fork_crossbar7__out4_valid_downstream[0:0];
  assign mux_5__in7[31:0] = fork_crossbar7__out5[31:0];
  assign mux_5__in7_valid_upstream[0:0] = fork_crossbar7__out5_valid_downstream[0:0];
  assign mux_6__in7[31:0] = fork_crossbar7__out6[31:0];
  assign mux_6__in7_valid_upstream[0:0] = fork_crossbar7__out6_valid_downstream[0:0];
  assign mux_7__in7[31:0] = fork_crossbar7__out7[31:0];
  assign mux_7__in7_valid_upstream[0:0] = fork_crossbar7__out7_valid_downstream[0:0];
  assign mux_8__in7[31:0] = fork_crossbar7__out8[31:0];
  assign mux_8__in7_valid_upstream[0:0] = fork_crossbar7__out8_valid_downstream[0:0];
  assign mux_9__in7[31:0] = fork_crossbar7__out9[31:0];
  assign mux_9__in7_valid_upstream[0:0] = fork_crossbar7__out9_valid_downstream[0:0];
  assign fork_crossbar8__in[31:0] = in8[31:0];
  assign fork_crossbar8__in_valid_upstream[0:0] = in8_valid_upstream[0:0];
  assign in8_stop_upstream[0:0] = fork_crossbar8__in_stop_upstream[0:0];
  assign mux_0__in8[31:0] = fork_crossbar8__out0[31:0];
  assign mux_0__in8_valid_upstream[0:0] = fork_crossbar8__out0_valid_downstream[0:0];
  assign mux_1__in8[31:0] = fork_crossbar8__out1[31:0];
  assign mux_1__in8_valid_upstream[0:0] = fork_crossbar8__out1_valid_downstream[0:0];
  assign mux_2__in8[31:0] = fork_crossbar8__out2[31:0];
  assign mux_2__in8_valid_upstream[0:0] = fork_crossbar8__out2_valid_downstream[0:0];
  assign mux_3__in8[31:0] = fork_crossbar8__out3[31:0];
  assign mux_3__in8_valid_upstream[0:0] = fork_crossbar8__out3_valid_downstream[0:0];
  assign mux_4__in8[31:0] = fork_crossbar8__out4[31:0];
  assign mux_4__in8_valid_upstream[0:0] = fork_crossbar8__out4_valid_downstream[0:0];
  assign mux_5__in8[31:0] = fork_crossbar8__out5[31:0];
  assign mux_5__in8_valid_upstream[0:0] = fork_crossbar8__out5_valid_downstream[0:0];
  assign mux_6__in8[31:0] = fork_crossbar8__out6[31:0];
  assign mux_6__in8_valid_upstream[0:0] = fork_crossbar8__out6_valid_downstream[0:0];
  assign mux_7__in8[31:0] = fork_crossbar8__out7[31:0];
  assign mux_7__in8_valid_upstream[0:0] = fork_crossbar8__out7_valid_downstream[0:0];
  assign mux_8__in8[31:0] = fork_crossbar8__out8[31:0];
  assign mux_8__in8_valid_upstream[0:0] = fork_crossbar8__out8_valid_downstream[0:0];
  assign mux_9__in8[31:0] = fork_crossbar8__out9[31:0];
  assign mux_9__in8_valid_upstream[0:0] = fork_crossbar8__out9_valid_downstream[0:0];
  assign mux_0__out_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign mux_1__out_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign mux_2__out_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign mux_3__out_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign mux_4__out_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign mux_5__out_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign mux_6__out_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign mux_7__out_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign mux_8__out_stop_downstream[0:0] = out8_stop_downstream[0:0];
  assign mux_9__out_stop_downstream[0:0] = out9_stop_downstream[0:0];
  assign fork_crossbar0__enable_downstream[9:0] = ForkCrossbar0Config__select[9:0];
  assign ForkCrossbar0Config__valid[0:0] = fork_crossbar0__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar0Config__stop[0:0] = fork_crossbar0__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar1__enable_downstream[9:0] = ForkCrossbar1Config__select[9:0];
  assign ForkCrossbar1Config__valid[0:0] = fork_crossbar1__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar1Config__stop[0:0] = fork_crossbar1__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar2__enable_downstream[9:0] = ForkCrossbar2Config__select[9:0];
  assign ForkCrossbar2Config__valid[0:0] = fork_crossbar2__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar2Config__stop[0:0] = fork_crossbar2__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar3__enable_downstream[9:0] = ForkCrossbar3Config__select[9:0];
  assign ForkCrossbar3Config__valid[0:0] = fork_crossbar3__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar3Config__stop[0:0] = fork_crossbar3__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar4__enable_downstream[9:0] = ForkCrossbar4Config__select[9:0];
  assign ForkCrossbar4Config__valid[0:0] = fork_crossbar4__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar4Config__stop[0:0] = fork_crossbar4__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar5__enable_downstream[9:0] = ForkCrossbar5Config__select[9:0];
  assign ForkCrossbar5Config__valid[0:0] = fork_crossbar5__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar5Config__stop[0:0] = fork_crossbar5__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar6__enable_downstream[9:0] = ForkCrossbar6Config__select[9:0];
  assign ForkCrossbar6Config__valid[0:0] = fork_crossbar6__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar6Config__stop[0:0] = fork_crossbar6__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar7__enable_downstream[9:0] = ForkCrossbar7Config__select[9:0];
  assign ForkCrossbar7Config__valid[0:0] = fork_crossbar7__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar7Config__stop[0:0] = fork_crossbar7__enable_downstream_stop_upstream[0:0];
  assign fork_crossbar8__enable_downstream[9:0] = ForkCrossbar8Config__select[9:0];
  assign ForkCrossbar8Config__valid[0:0] = fork_crossbar8__enable_downstream_valid_upstream[0:0];
  assign ForkCrossbar8Config__stop[0:0] = fork_crossbar8__enable_downstream_stop_upstream[0:0];
  assign mux_0__select[3:0] = Mux0config__select[3:0];
  assign Mux0config__valid[0:0] = mux_0__select_valid_upstream[0:0];
  assign Mux0config__stop[0:0] = mux_0__select_stop_upstream[0:0];
  assign mux_1__select[3:0] = Mux1config__select[3:0];
  assign Mux1config__valid[0:0] = mux_1__select_valid_upstream[0:0];
  assign Mux1config__stop[0:0] = mux_1__select_stop_upstream[0:0];
  assign mux_2__select[3:0] = Mux2config__select[3:0];
  assign Mux2config__valid[0:0] = mux_2__select_valid_upstream[0:0];
  assign Mux2config__stop[0:0] = mux_2__select_stop_upstream[0:0];
  assign mux_3__select[3:0] = Mux3config__select[3:0];
  assign Mux3config__valid[0:0] = mux_3__select_valid_upstream[0:0];
  assign Mux3config__stop[0:0] = mux_3__select_stop_upstream[0:0];
  assign mux_4__select[3:0] = Mux4config__select[3:0];
  assign Mux4config__valid[0:0] = mux_4__select_valid_upstream[0:0];
  assign Mux4config__stop[0:0] = mux_4__select_stop_upstream[0:0];
  assign mux_5__select[3:0] = Mux5config__select[3:0];
  assign Mux5config__valid[0:0] = mux_5__select_valid_upstream[0:0];
  assign Mux5config__stop[0:0] = mux_5__select_stop_upstream[0:0];
  assign mux_6__select[3:0] = Mux6config__select[3:0];
  assign Mux6config__valid[0:0] = mux_6__select_valid_upstream[0:0];
  assign Mux6config__stop[0:0] = mux_6__select_stop_upstream[0:0];
  assign mux_7__select[3:0] = Mux7config__select[3:0];
  assign Mux7config__valid[0:0] = mux_7__select_valid_upstream[0:0];
  assign Mux7config__stop[0:0] = mux_7__select_stop_upstream[0:0];
  assign mux_8__select[3:0] = Mux8config__select[3:0];
  assign Mux8config__valid[0:0] = mux_8__select_valid_upstream[0:0];
  assign Mux8config__stop[0:0] = mux_8__select_stop_upstream[0:0];
  assign mux_9__select[3:0] = Mux9config__select[3:0];
  assign Mux9config__valid[0:0] = mux_9__select_valid_upstream[0:0];
  assign Mux9config__stop[0:0] = mux_9__select_stop_upstream[0:0];
  assign ForkCrossbar0Config__ConfigIn = ConfigIn;
  assign ForkCrossbar1Config__ConfigIn = ForkCrossbar0Config__ConfigOut;
  assign ForkCrossbar2Config__ConfigIn = ForkCrossbar1Config__ConfigOut;
  assign ForkCrossbar3Config__ConfigIn = ForkCrossbar2Config__ConfigOut;
  assign ForkCrossbar4Config__ConfigIn = ForkCrossbar3Config__ConfigOut;
  assign ForkCrossbar5Config__ConfigIn = ForkCrossbar4Config__ConfigOut;
  assign ForkCrossbar6Config__ConfigIn = ForkCrossbar5Config__ConfigOut;
  assign ForkCrossbar7Config__ConfigIn = ForkCrossbar6Config__ConfigOut;
  assign ForkCrossbar8Config__ConfigIn = ForkCrossbar7Config__ConfigOut;
  assign Mux0config__ConfigIn = ForkCrossbar8Config__ConfigOut;
  assign Mux1config__ConfigIn = Mux0config__ConfigOut;
  assign Mux2config__ConfigIn = Mux1config__ConfigOut;
  assign Mux3config__ConfigIn = Mux2config__ConfigOut;
  assign Mux4config__ConfigIn = Mux3config__ConfigOut;
  assign Mux5config__ConfigIn = Mux4config__ConfigOut;
  assign Mux6config__ConfigIn = Mux5config__ConfigOut;
  assign Mux7config__ConfigIn = Mux6config__ConfigOut;
  assign Mux8config__ConfigIn = Mux7config__ConfigOut;
  assign Mux9config__ConfigIn = Mux8config__ConfigOut;
  assign ConfigOut = Mux9config__ConfigOut;

endmodule //elastic_crossbar_9in_10out_size_32_U22

module cgrame_elastic_register_32b #(parameter contexts=1, parameter size=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  enable,
  enable_stop_upstream,
  enable_valid_upstream,
  in,
  in_stop_upstream,
  in_valid_upstream,
  out,
  out_stop_downstream,
  out_valid_downstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [0:0] enable;
    output [0:0] enable_stop_upstream;
    output [0:0] enable_valid_upstream;
    input [size-1:0] in;
    output reg [0:0] in_stop_upstream;
    input [0:0] in_valid_upstream;
    output reg [size-1:0] out;
    input [0:0] out_stop_downstream;
    output reg [0:0] out_valid_downstream;
    always @(posedge CGRA_Clock, posedge CGRA_Reset)
        if (CGRA_Reset == 1) begin
            out <= 0;
            out_valid_downstream <= 0;
        end
        else if (enable & CGRA_Enable & ~in_stop_upstream) begin
            out <= in;
            out_valid_downstream <= in_valid_upstream;
        end
    assign enable_stop_upstream = in_stop_upstream;
    assign enable_valid_upstream = in_valid_upstream;
    assign in_stop_upstream = out_stop_downstream;


endmodule //cgrame_elastic_register_32b

module elastic_io_32b_U1 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] bidir_in,
  output [0:0] bidir_in_stop_upstream,
  input [0:0] bidir_in_valid_upstream,
  output [31:0] bidir_out,
  input [0:0] bidir_out_stop_downstream,
  output [0:0] bidir_out_valid_downstream,
  input [31:0] in,
  output [0:0] in_stop_upstream,
  input [0:0] in_valid_upstream,
  output [31:0] out,
  input [0:0] out_stop_downstream,
  output [0:0] out_valid_downstream
);
  //Wire declarations for instance 'demuxIO' (Module cgrame_elastic_demux_2to1_32b)
  wire [31:0] demuxIO__in;
  wire [0:0] demuxIO__in_stop_upstream;
  wire [0:0] demuxIO__in_valid_upstream;
  wire [31:0] demuxIO__out0;
  wire [0:0] demuxIO__out0_stop_downstream;
  wire [0:0] demuxIO__out0_valid_downstream;
  wire [31:0] demuxIO__out1;
  wire [0:0] demuxIO__out1_stop_downstream;
  wire [0:0] demuxIO__out1_valid_downstream;
  wire [0:0] demuxIO__select;
  wire [0:0] demuxIO__select_stop_upstream;
  wire [0:0] demuxIO__select_valid_upstream;
  cgrame_elastic_demux_2to1_32b #(.contexts(1),.size(32)) demuxIO(
    .in(demuxIO__in),
    .in_stop_upstream(demuxIO__in_stop_upstream),
    .in_valid_upstream(demuxIO__in_valid_upstream),
    .out0(demuxIO__out0),
    .out0_stop_downstream(demuxIO__out0_stop_downstream),
    .out0_valid_downstream(demuxIO__out0_valid_downstream),
    .out1(demuxIO__out1),
    .out1_stop_downstream(demuxIO__out1_stop_downstream),
    .out1_valid_downstream(demuxIO__out1_valid_downstream),
    .select(demuxIO__select),
    .select_stop_upstream(demuxIO__select_stop_upstream),
    .select_valid_upstream(demuxIO__select_valid_upstream)
  );

  //Wire declarations for instance 'demuxIOConfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  demuxIOConfig__CGRA_Clock;
  wire  demuxIOConfig__CGRA_Enable;
  wire  demuxIOConfig__CGRA_Reset;
  wire  demuxIOConfig__ConfigIn;
  wire  demuxIOConfig__ConfigOut;
  wire  demuxIOConfig__Config_Clock;
  wire  demuxIOConfig__Config_Reset;
  wire [0:0] demuxIOConfig__select;
  wire [0:0] demuxIOConfig__stop;
  wire [0:0] demuxIOConfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) demuxIOConfig(
    .CGRA_Clock(demuxIOConfig__CGRA_Clock),
    .CGRA_Enable(demuxIOConfig__CGRA_Enable),
    .CGRA_Reset(demuxIOConfig__CGRA_Reset),
    .ConfigIn(demuxIOConfig__ConfigIn),
    .ConfigOut(demuxIOConfig__ConfigOut),
    .Config_Clock(demuxIOConfig__Config_Clock),
    .Config_Reset(demuxIOConfig__Config_Reset),
    .select(demuxIOConfig__select),
    .stop(demuxIOConfig__stop),
    .valid(demuxIOConfig__valid)
  );

  //Wire declarations for instance 'muxIO' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxIO__in0;
  wire [0:0] muxIO__in0_stop_upstream;
  wire [0:0] muxIO__in0_valid_upstream;
  wire [31:0] muxIO__in1;
  wire [0:0] muxIO__in1_stop_upstream;
  wire [0:0] muxIO__in1_valid_upstream;
  wire [31:0] muxIO__out;
  wire [0:0] muxIO__out_stop_downstream;
  wire [0:0] muxIO__out_valid_downstream;
  wire [0:0] muxIO__select;
  wire [0:0] muxIO__select_stop_upstream;
  wire [0:0] muxIO__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxIO(
    .in0(muxIO__in0),
    .in0_stop_upstream(muxIO__in0_stop_upstream),
    .in0_valid_upstream(muxIO__in0_valid_upstream),
    .in1(muxIO__in1),
    .in1_stop_upstream(muxIO__in1_stop_upstream),
    .in1_valid_upstream(muxIO__in1_valid_upstream),
    .out(muxIO__out),
    .out_stop_downstream(muxIO__out_stop_downstream),
    .out_valid_downstream(muxIO__out_valid_downstream),
    .select(muxIO__select),
    .select_stop_upstream(muxIO__select_stop_upstream),
    .select_valid_upstream(muxIO__select_valid_upstream)
  );

  //Wire declarations for instance 'muxIOConfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  muxIOConfig__CGRA_Clock;
  wire  muxIOConfig__CGRA_Enable;
  wire  muxIOConfig__CGRA_Reset;
  wire  muxIOConfig__ConfigIn;
  wire  muxIOConfig__ConfigOut;
  wire  muxIOConfig__Config_Clock;
  wire  muxIOConfig__Config_Reset;
  wire [0:0] muxIOConfig__select;
  wire [0:0] muxIOConfig__stop;
  wire [0:0] muxIOConfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) muxIOConfig(
    .CGRA_Clock(muxIOConfig__CGRA_Clock),
    .CGRA_Enable(muxIOConfig__CGRA_Enable),
    .CGRA_Reset(muxIOConfig__CGRA_Reset),
    .ConfigIn(muxIOConfig__ConfigIn),
    .ConfigOut(muxIOConfig__ConfigOut),
    .Config_Clock(muxIOConfig__Config_Clock),
    .Config_Reset(muxIOConfig__Config_Reset),
    .select(muxIOConfig__select),
    .stop(muxIOConfig__stop),
    .valid(muxIOConfig__valid)
  );

  //Wire declarations for instance 'reg_io' (Module cgrame_elastic_register_32b)
  wire  reg_io__CGRA_Clock;
  wire  reg_io__CGRA_Enable;
  wire  reg_io__CGRA_Reset;
  wire [0:0] reg_io__enable;
  wire [0:0] reg_io__enable_stop_upstream;
  wire [0:0] reg_io__enable_valid_upstream;
  wire [31:0] reg_io__in;
  wire [0:0] reg_io__in_stop_upstream;
  wire [0:0] reg_io__in_valid_upstream;
  wire [31:0] reg_io__out;
  wire [0:0] reg_io__out_stop_downstream;
  wire [0:0] reg_io__out_valid_downstream;
  cgrame_elastic_register_32b #(.contexts(1),.size(32)) reg_io(
    .CGRA_Clock(reg_io__CGRA_Clock),
    .CGRA_Enable(reg_io__CGRA_Enable),
    .CGRA_Reset(reg_io__CGRA_Reset),
    .enable(reg_io__enable),
    .enable_stop_upstream(reg_io__enable_stop_upstream),
    .enable_valid_upstream(reg_io__enable_valid_upstream),
    .in(reg_io__in),
    .in_stop_upstream(reg_io__in_stop_upstream),
    .in_valid_upstream(reg_io__in_valid_upstream),
    .out(reg_io__out),
    .out_stop_downstream(reg_io__out_stop_downstream),
    .out_valid_downstream(reg_io__out_valid_downstream)
  );

  //Wire declarations for instance 'reg_ioConfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  reg_ioConfig__CGRA_Clock;
  wire  reg_ioConfig__CGRA_Enable;
  wire  reg_ioConfig__CGRA_Reset;
  wire  reg_ioConfig__ConfigIn;
  wire  reg_ioConfig__ConfigOut;
  wire  reg_ioConfig__Config_Clock;
  wire  reg_ioConfig__Config_Reset;
  wire [0:0] reg_ioConfig__select;
  wire [0:0] reg_ioConfig__stop;
  wire [0:0] reg_ioConfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) reg_ioConfig(
    .CGRA_Clock(reg_ioConfig__CGRA_Clock),
    .CGRA_Enable(reg_ioConfig__CGRA_Enable),
    .CGRA_Reset(reg_ioConfig__CGRA_Reset),
    .ConfigIn(reg_ioConfig__ConfigIn),
    .ConfigOut(reg_ioConfig__ConfigOut),
    .Config_Clock(reg_ioConfig__Config_Clock),
    .Config_Reset(reg_ioConfig__Config_Reset),
    .select(reg_ioConfig__select),
    .stop(reg_ioConfig__stop),
    .valid(reg_ioConfig__valid)
  );

  //All the connections
  assign reg_io__CGRA_Clock = CGRA_Clock;
  assign demuxIOConfig__CGRA_Clock = CGRA_Clock;
  assign muxIOConfig__CGRA_Clock = CGRA_Clock;
  assign reg_ioConfig__CGRA_Clock = CGRA_Clock;
  assign reg_io__CGRA_Reset = CGRA_Reset;
  assign demuxIOConfig__CGRA_Reset = CGRA_Reset;
  assign muxIOConfig__CGRA_Reset = CGRA_Reset;
  assign reg_ioConfig__CGRA_Reset = CGRA_Reset;
  assign reg_io__CGRA_Enable = CGRA_Enable;
  assign demuxIOConfig__CGRA_Enable = CGRA_Enable;
  assign muxIOConfig__CGRA_Enable = CGRA_Enable;
  assign reg_ioConfig__CGRA_Enable = CGRA_Enable;
  assign demuxIOConfig__Config_Clock = Config_Clock;
  assign muxIOConfig__Config_Clock = Config_Clock;
  assign reg_ioConfig__Config_Clock = Config_Clock;
  assign demuxIOConfig__Config_Reset = Config_Reset;
  assign muxIOConfig__Config_Reset = Config_Reset;
  assign reg_ioConfig__Config_Reset = Config_Reset;
  assign muxIO__in0[31:0] = in[31:0];
  assign muxIO__in0_valid_upstream[0:0] = in_valid_upstream[0:0];
  assign demuxIO__out1_stop_downstream[0:0] = out_stop_downstream[0:0];
  assign muxIO__in1[31:0] = bidir_in[31:0];
  assign muxIO__in1_valid_upstream[0:0] = bidir_in_valid_upstream[0:0];
  assign demuxIO__out0_stop_downstream[0:0] = bidir_out_stop_downstream[0:0];
  assign muxIO__out_stop_downstream[0:0] = reg_io__in_stop_upstream[0:0];
  assign demuxIO__in[31:0] = reg_io__out[31:0];
  assign demuxIO__in_valid_upstream[0:0] = reg_io__out_valid_downstream[0:0];
  assign in_stop_upstream[0:0] = muxIO__in0_stop_upstream[0:0];
  assign bidir_in_stop_upstream[0:0] = muxIO__in1_stop_upstream[0:0];
  assign reg_io__in[31:0] = muxIO__out[31:0];
  assign reg_io__in_valid_upstream[0:0] = muxIO__out_valid_downstream[0:0];
  assign reg_io__out_stop_downstream[0:0] = demuxIO__in_stop_upstream[0:0];
  assign bidir_out[31:0] = demuxIO__out0[31:0];
  assign bidir_out_valid_downstream[0:0] = demuxIO__out0_valid_downstream[0:0];
  assign out[31:0] = demuxIO__out1[31:0];
  assign out_valid_downstream[0:0] = demuxIO__out1_valid_downstream[0:0];
  assign demuxIO__select[0:0] = demuxIOConfig__select[0:0];
  assign demuxIOConfig__valid[0:0] = demuxIO__select_valid_upstream[0:0];
  assign demuxIOConfig__stop[0:0] = demuxIO__select_stop_upstream[0:0];
  assign muxIO__select[0:0] = muxIOConfig__select[0:0];
  assign muxIOConfig__valid[0:0] = muxIO__select_valid_upstream[0:0];
  assign muxIOConfig__stop[0:0] = muxIO__select_stop_upstream[0:0];
  assign reg_io__enable[0:0] = reg_ioConfig__select[0:0];
  assign reg_ioConfig__valid[0:0] = reg_io__enable_valid_upstream[0:0];
  assign reg_ioConfig__stop[0:0] = reg_io__enable_stop_upstream[0:0];
  assign demuxIOConfig__ConfigIn = ConfigIn;
  assign muxIOConfig__ConfigIn = demuxIOConfig__ConfigOut;
  assign reg_ioConfig__ConfigIn = muxIOConfig__ConfigOut;
  assign ConfigOut = reg_ioConfig__ConfigOut;

endmodule //elastic_io_32b_U1

module cgrame_mux_4to1_34b #(parameter contexts=1, parameter size=1) (
  in0,
  in1,
  in2,
  in3,
  out,
  select
);
    input [size-1:0] in0;
    input [size-1:0] in1;
    input [size-1:0] in2;
    input [size-1:0] in3;
    output reg [size-1:0] out;
    input [1:0] select;
    always @(*)
        case (select)
            0: out = in0;
            1: out = in1;
            2: out = in2;
            3: out = in3;
            default: out = {size{1'bx}};
        endcase

endmodule //cgrame_mux_4to1_34b

module fpunit_32b_add_sqrt_divide_multiply_U36 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input [0:0] FP_clk_en,
  input [31:0] in_a,
  input [31:0] in_b,
  input [1:0] opcode,
  output [31:0] out
);
  //Wire declarations for instance 'fpadd' (Module cgrame_FPAdder)
  wire  fpadd__CGRA_Clock;
  wire  fpadd__CGRA_Enable;
  wire  fpadd__CGRA_Reset;
  wire [0:0] fpadd__FP_clk_en;
  wire [33:0] fpadd__R;
  wire [33:0] fpadd__X;
  wire [33:0] fpadd__Y;
  wire [1:0] fpadd__opcode;
  cgrame_FPAdder #(.contexts(1),.size(34)) fpadd(
    .CGRA_Clock(fpadd__CGRA_Clock),
    .CGRA_Enable(fpadd__CGRA_Enable),
    .CGRA_Reset(fpadd__CGRA_Reset),
    .FP_clk_en(fpadd__FP_clk_en),
    .R(fpadd__R),
    .X(fpadd__X),
    .Y(fpadd__Y),
    .opcode(fpadd__opcode)
  );

  //Wire declarations for instance 'fpdiv' (Module cgrame_FPDivider)
  wire  fpdiv__CGRA_Clock;
  wire  fpdiv__CGRA_Enable;
  wire  fpdiv__CGRA_Reset;
  wire [0:0] fpdiv__FP_clk_en;
  wire [33:0] fpdiv__R;
  wire [33:0] fpdiv__X;
  wire [33:0] fpdiv__Y;
  wire [1:0] fpdiv__opcode;
  cgrame_FPDivider #(.contexts(1),.size(34)) fpdiv(
    .CGRA_Clock(fpdiv__CGRA_Clock),
    .CGRA_Enable(fpdiv__CGRA_Enable),
    .CGRA_Reset(fpdiv__CGRA_Reset),
    .FP_clk_en(fpdiv__FP_clk_en),
    .R(fpdiv__R),
    .X(fpdiv__X),
    .Y(fpdiv__Y),
    .opcode(fpdiv__opcode)
  );

  //Wire declarations for instance 'fpinput1' (Module cgrame_FPInput)
  wire  fpinput1__CGRA_Clock;
  wire  fpinput1__CGRA_Enable;
  wire  fpinput1__CGRA_Reset;
  wire [33:0] fpinput1__R;
  wire [31:0] fpinput1__X;
  cgrame_FPInput #(.contexts(1),.size_in(32),.size_out(34)) fpinput1(
    .CGRA_Clock(fpinput1__CGRA_Clock),
    .CGRA_Enable(fpinput1__CGRA_Enable),
    .CGRA_Reset(fpinput1__CGRA_Reset),
    .R(fpinput1__R),
    .X(fpinput1__X)
  );

  //Wire declarations for instance 'fpinput2' (Module cgrame_FPInput)
  wire  fpinput2__CGRA_Clock;
  wire  fpinput2__CGRA_Enable;
  wire  fpinput2__CGRA_Reset;
  wire [33:0] fpinput2__R;
  wire [31:0] fpinput2__X;
  cgrame_FPInput #(.contexts(1),.size_in(32),.size_out(34)) fpinput2(
    .CGRA_Clock(fpinput2__CGRA_Clock),
    .CGRA_Enable(fpinput2__CGRA_Enable),
    .CGRA_Reset(fpinput2__CGRA_Reset),
    .R(fpinput2__R),
    .X(fpinput2__X)
  );

  //Wire declarations for instance 'fpmult' (Module cgrame_FPMultiplier)
  wire  fpmult__CGRA_Clock;
  wire  fpmult__CGRA_Enable;
  wire  fpmult__CGRA_Reset;
  wire [0:0] fpmult__FP_clk_en;
  wire [33:0] fpmult__R;
  wire [33:0] fpmult__X;
  wire [33:0] fpmult__Y;
  wire [1:0] fpmult__opcode;
  cgrame_FPMultiplier #(.contexts(1),.size(34)) fpmult(
    .CGRA_Clock(fpmult__CGRA_Clock),
    .CGRA_Enable(fpmult__CGRA_Enable),
    .CGRA_Reset(fpmult__CGRA_Reset),
    .FP_clk_en(fpmult__FP_clk_en),
    .R(fpmult__R),
    .X(fpmult__X),
    .Y(fpmult__Y),
    .opcode(fpmult__opcode)
  );

  //Wire declarations for instance 'fpoutput' (Module cgrame_FPOutput)
  wire  fpoutput__CGRA_Clock;
  wire  fpoutput__CGRA_Enable;
  wire  fpoutput__CGRA_Reset;
  wire [31:0] fpoutput__R;
  wire [33:0] fpoutput__X;
  cgrame_FPOutput #(.contexts(1),.size_in(34),.size_out(32)) fpoutput(
    .CGRA_Clock(fpoutput__CGRA_Clock),
    .CGRA_Enable(fpoutput__CGRA_Enable),
    .CGRA_Reset(fpoutput__CGRA_Reset),
    .R(fpoutput__R),
    .X(fpoutput__X)
  );

  //Wire declarations for instance 'fpsqroot' (Module cgrame_FPSqrt)
  wire  fpsqroot__CGRA_Clock;
  wire  fpsqroot__CGRA_Enable;
  wire  fpsqroot__CGRA_Reset;
  wire [0:0] fpsqroot__FP_clk_en;
  wire [33:0] fpsqroot__R;
  wire [33:0] fpsqroot__X;
  wire [1:0] fpsqroot__opcode;
  cgrame_FPSqrt #(.contexts(1),.size(34)) fpsqroot(
    .CGRA_Clock(fpsqroot__CGRA_Clock),
    .CGRA_Enable(fpsqroot__CGRA_Enable),
    .CGRA_Reset(fpsqroot__CGRA_Reset),
    .FP_clk_en(fpsqroot__FP_clk_en),
    .R(fpsqroot__R),
    .X(fpsqroot__X),
    .opcode(fpsqroot__opcode)
  );

  //Wire declarations for instance 'result_mux' (Module cgrame_mux_4to1_34b)
  wire [33:0] result_mux__in0;
  wire [33:0] result_mux__in1;
  wire [33:0] result_mux__in2;
  wire [33:0] result_mux__in3;
  wire [33:0] result_mux__out;
  wire [1:0] result_mux__select;
  cgrame_mux_4to1_34b #(.contexts(1),.size(34)) result_mux(
    .in0(result_mux__in0),
    .in1(result_mux__in1),
    .in2(result_mux__in2),
    .in3(result_mux__in3),
    .out(result_mux__out),
    .select(result_mux__select)
  );

  //All the connections
  assign fpadd__CGRA_Clock = CGRA_Clock;
  assign fpdiv__CGRA_Clock = CGRA_Clock;
  assign fpinput1__CGRA_Clock = CGRA_Clock;
  assign fpinput2__CGRA_Clock = CGRA_Clock;
  assign fpmult__CGRA_Clock = CGRA_Clock;
  assign fpoutput__CGRA_Clock = CGRA_Clock;
  assign fpsqroot__CGRA_Clock = CGRA_Clock;
  assign fpadd__CGRA_Reset = CGRA_Reset;
  assign fpdiv__CGRA_Reset = CGRA_Reset;
  assign fpinput1__CGRA_Reset = CGRA_Reset;
  assign fpinput2__CGRA_Reset = CGRA_Reset;
  assign fpmult__CGRA_Reset = CGRA_Reset;
  assign fpoutput__CGRA_Reset = CGRA_Reset;
  assign fpsqroot__CGRA_Reset = CGRA_Reset;
  assign fpadd__CGRA_Enable = CGRA_Enable;
  assign fpdiv__CGRA_Enable = CGRA_Enable;
  assign fpinput1__CGRA_Enable = CGRA_Enable;
  assign fpinput2__CGRA_Enable = CGRA_Enable;
  assign fpmult__CGRA_Enable = CGRA_Enable;
  assign fpoutput__CGRA_Enable = CGRA_Enable;
  assign fpsqroot__CGRA_Enable = CGRA_Enable;
  assign fpinput1__X[31:0] = in_a[31:0];
  assign fpinput2__X[31:0] = in_b[31:0];
  assign result_mux__select[1:0] = opcode[1:0];
  assign fpadd__opcode[1:0] = opcode[1:0];
  assign fpsqroot__opcode[1:0] = opcode[1:0];
  assign fpdiv__opcode[1:0] = opcode[1:0];
  assign fpmult__opcode[1:0] = opcode[1:0];
  assign fpadd__FP_clk_en[0:0] = FP_clk_en[0:0];
  assign fpsqroot__FP_clk_en[0:0] = FP_clk_en[0:0];
  assign fpdiv__FP_clk_en[0:0] = FP_clk_en[0:0];
  assign fpmult__FP_clk_en[0:0] = FP_clk_en[0:0];
  assign fpadd__X[33:0] = fpinput1__R[33:0];
  assign fpsqroot__X[33:0] = fpinput1__R[33:0];
  assign fpdiv__X[33:0] = fpinput1__R[33:0];
  assign fpmult__X[33:0] = fpinput1__R[33:0];
  assign fpadd__Y[33:0] = fpinput2__R[33:0];
  assign fpdiv__Y[33:0] = fpinput2__R[33:0];
  assign fpmult__Y[33:0] = fpinput2__R[33:0];
  assign result_mux__in0[33:0] = fpadd__R[33:0];
  assign result_mux__in1[33:0] = fpsqroot__R[33:0];
  assign result_mux__in2[33:0] = fpdiv__R[33:0];
  assign result_mux__in3[33:0] = fpmult__R[33:0];
  assign fpoutput__X[33:0] = result_mux__out[33:0];
  assign out[31:0] = fpoutput__R[31:0];

endmodule //fpunit_32b_add_sqrt_divide_multiply_U36

module cgrame_fpunit_wrapper_size_32_add_sqrt_divide_multiply #(parameter contexts=1) (
  CGRA_Clock,
  CGRA_Reset,
  CGRA_Enable,
  opcode,
  stop_downstream,
  stop_upstream,
  valid_downstream,
  valid_upstream
);
    input CGRA_Clock;
    input CGRA_Reset;
    input CGRA_Enable;
    input [1:0] opcode;
    input [0:0] stop_downstream;
    output reg [0:0] stop_upstream;
    output reg [0:0] valid_downstream;
    input [0:0] valid_upstream;
    reg [22:0] register;
    reg [1:0] curr_opcode;

    always@(posedge CGRA_Clock) begin
        if (CGRA_Reset) begin
            stop_upstream <= 0;
            curr_opcode <= 0;
        end
        else if (opcode != curr_opcode) begin
            if (|register) begin
                stop_upstream <= 1;
            end else begin
                stop_upstream <= 0;
                curr_opcode <= opcode;
            end
        end
        else if (opcode == curr_opcode) begin
            curr_opcode <= opcode;
        end
        if (~stop_downstream) begin
            stop_upstream <= 0;
        end
        else if (stop_downstream) begin
            stop_upstream <= 1;
        end
    end

    always@(posedge CGRA_Clock) begin
        if (CGRA_Reset) begin
            register <= 0;
        end
        else if (~stop_downstream) begin
            register <= {valid_upstream, register[22:1]};
        end
        else if (stop_downstream) begin
            register <= register;
        end
    end

    always@(*) begin
        if (CGRA_Reset) begin
            valid_downstream <= 0;
        end
        else begin
            if (curr_opcode == 0) begin
                //Latency of my FPAdd is 3 
                //23-Latency=23-3=20
                if (~register[20]) begin
                    valid_downstream <= 0;
                end
                else if (register[20]) begin
                    valid_downstream <= 1;
                end
            end
            else if (curr_opcode == 1) begin
                //Latency of my FPSqrt is 10 
                if (~register[13]) begin
                    valid_downstream <= 0;
                end
                else if (register[13]) begin
                    valid_downstream <= 1;
                end
            end
            else if (curr_opcode == 2) begin
                //Latency of my FPDiv is 15
                if (~register[8]) begin
                    valid_downstream <= 0;
                end
                else if (register[8]) begin
                    valid_downstream <= 1;
                end
            end
            else if (curr_opcode == 3) begin
                //Latency of my FPMult is 5
                if (~register[18]) begin
                    valid_downstream <= 0;
                end
                else if (register[18]) begin
                    valid_downstream <= 1;
                end
            end
        end
    end


endmodule //cgrame_fpunit_wrapper_size_32_add_sqrt_divide_multiply

module elastic_fp_unit_FuncUnit_size_32_U15 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in_a,
  output [0:0] in_a_stop_upstream,
  input [0:0] in_a_valid_upstream,
  input [31:0] in_b,
  output [0:0] in_b_stop_upstream,
  input [0:0] in_b_valid_upstream,
  output [31:0] out,
  input [0:0] out_stop_downstream,
  output [0:0] out_valid_downstream
);
  //Wire declarations for instance 'FuncUnit_FPALU' (Module fpunit_32b_add_sqrt_divide_multiply_U36)
  wire  FuncUnit_FPALU__CGRA_Clock;
  wire  FuncUnit_FPALU__CGRA_Enable;
  wire  FuncUnit_FPALU__CGRA_Reset;
  wire [0:0] FuncUnit_FPALU__FP_clk_en;
  wire [31:0] FuncUnit_FPALU__in_a;
  wire [31:0] FuncUnit_FPALU__in_b;
  wire [1:0] FuncUnit_FPALU__opcode;
  wire [31:0] FuncUnit_FPALU__out;
  fpunit_32b_add_sqrt_divide_multiply_U36 FuncUnit_FPALU(
    .CGRA_Clock(FuncUnit_FPALU__CGRA_Clock),
    .CGRA_Enable(FuncUnit_FPALU__CGRA_Enable),
    .CGRA_Reset(FuncUnit_FPALU__CGRA_Reset),
    .FP_clk_en(FuncUnit_FPALU__FP_clk_en),
    .in_a(FuncUnit_FPALU__in_a),
    .in_b(FuncUnit_FPALU__in_b),
    .opcode(FuncUnit_FPALU__opcode),
    .out(FuncUnit_FPALU__out)
  );

  //Wire declarations for instance 'FuncUnit_FPUnitConfig' (Module cgrame_configcell_context_II_1_1_size2)
  wire  FuncUnit_FPUnitConfig__CGRA_Clock;
  wire  FuncUnit_FPUnitConfig__CGRA_Enable;
  wire  FuncUnit_FPUnitConfig__CGRA_Reset;
  wire  FuncUnit_FPUnitConfig__ConfigIn;
  wire  FuncUnit_FPUnitConfig__ConfigOut;
  wire  FuncUnit_FPUnitConfig__Config_Clock;
  wire  FuncUnit_FPUnitConfig__Config_Reset;
  wire [1:0] FuncUnit_FPUnitConfig__select;
  cgrame_configcell_context_II_1_1_size2 #(.contexts(1),.size(2)) FuncUnit_FPUnitConfig(
    .CGRA_Clock(FuncUnit_FPUnitConfig__CGRA_Clock),
    .CGRA_Enable(FuncUnit_FPUnitConfig__CGRA_Enable),
    .CGRA_Reset(FuncUnit_FPUnitConfig__CGRA_Reset),
    .ConfigIn(FuncUnit_FPUnitConfig__ConfigIn),
    .ConfigOut(FuncUnit_FPUnitConfig__ConfigOut),
    .Config_Clock(FuncUnit_FPUnitConfig__Config_Clock),
    .Config_Reset(FuncUnit_FPUnitConfig__Config_Reset),
    .select(FuncUnit_FPUnitConfig__select)
  );

  //Wire declarations for instance 'FuncUnit_InputJoinConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  FuncUnit_InputJoinConfig__CGRA_Clock;
  wire  FuncUnit_InputJoinConfig__CGRA_Enable;
  wire  FuncUnit_InputJoinConfig__CGRA_Reset;
  wire  FuncUnit_InputJoinConfig__ConfigIn;
  wire  FuncUnit_InputJoinConfig__ConfigOut;
  wire  FuncUnit_InputJoinConfig__Config_Clock;
  wire  FuncUnit_InputJoinConfig__Config_Reset;
  wire [1:0] FuncUnit_InputJoinConfig__select;
  wire [0:0] FuncUnit_InputJoinConfig__stop;
  wire [0:0] FuncUnit_InputJoinConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) FuncUnit_InputJoinConfig(
    .CGRA_Clock(FuncUnit_InputJoinConfig__CGRA_Clock),
    .CGRA_Enable(FuncUnit_InputJoinConfig__CGRA_Enable),
    .CGRA_Reset(FuncUnit_InputJoinConfig__CGRA_Reset),
    .ConfigIn(FuncUnit_InputJoinConfig__ConfigIn),
    .ConfigOut(FuncUnit_InputJoinConfig__ConfigOut),
    .Config_Clock(FuncUnit_InputJoinConfig__Config_Clock),
    .Config_Reset(FuncUnit_InputJoinConfig__Config_Reset),
    .select(FuncUnit_InputJoinConfig__select),
    .stop(FuncUnit_InputJoinConfig__stop),
    .valid(FuncUnit_InputJoinConfig__valid)
  );

  //Wire declarations for instance 'FuncUnit_adapterToken' (Module cgrame_elastic_configcell_context_size1II1)
  wire  FuncUnit_adapterToken__CGRA_Clock;
  wire  FuncUnit_adapterToken__CGRA_Enable;
  wire  FuncUnit_adapterToken__CGRA_Reset;
  wire  FuncUnit_adapterToken__ConfigIn;
  wire  FuncUnit_adapterToken__ConfigOut;
  wire  FuncUnit_adapterToken__Config_Clock;
  wire  FuncUnit_adapterToken__Config_Reset;
  wire [0:0] FuncUnit_adapterToken__select;
  wire [0:0] FuncUnit_adapterToken__stop;
  wire [0:0] FuncUnit_adapterToken__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) FuncUnit_adapterToken(
    .CGRA_Clock(FuncUnit_adapterToken__CGRA_Clock),
    .CGRA_Enable(FuncUnit_adapterToken__CGRA_Enable),
    .CGRA_Reset(FuncUnit_adapterToken__CGRA_Reset),
    .ConfigIn(FuncUnit_adapterToken__ConfigIn),
    .ConfigOut(FuncUnit_adapterToken__ConfigOut),
    .Config_Clock(FuncUnit_adapterToken__Config_Clock),
    .Config_Reset(FuncUnit_adapterToken__Config_Reset),
    .select(FuncUnit_adapterToken__select),
    .stop(FuncUnit_adapterToken__stop),
    .valid(FuncUnit_adapterToken__valid)
  );

  //Wire declarations for instance 'FuncUnit_fp_wrapper' (Module cgrame_fpunit_wrapper_size_32_add_sqrt_divide_multiply)
  wire  FuncUnit_fp_wrapper__CGRA_Clock;
  wire  FuncUnit_fp_wrapper__CGRA_Enable;
  wire  FuncUnit_fp_wrapper__CGRA_Reset;
  wire [1:0] FuncUnit_fp_wrapper__opcode;
  wire [0:0] FuncUnit_fp_wrapper__stop_downstream;
  wire [0:0] FuncUnit_fp_wrapper__stop_upstream;
  wire [0:0] FuncUnit_fp_wrapper__valid_downstream;
  wire [0:0] FuncUnit_fp_wrapper__valid_upstream;
  cgrame_fpunit_wrapper_size_32_add_sqrt_divide_multiply #(.contexts(1)) FuncUnit_fp_wrapper(
    .CGRA_Clock(FuncUnit_fp_wrapper__CGRA_Clock),
    .CGRA_Enable(FuncUnit_fp_wrapper__CGRA_Enable),
    .CGRA_Reset(FuncUnit_fp_wrapper__CGRA_Reset),
    .opcode(FuncUnit_fp_wrapper__opcode),
    .stop_downstream(FuncUnit_fp_wrapper__stop_downstream),
    .stop_upstream(FuncUnit_fp_wrapper__stop_upstream),
    .valid_downstream(FuncUnit_fp_wrapper__valid_downstream),
    .valid_upstream(FuncUnit_fp_wrapper__valid_upstream)
  );

  //Wire declarations for instance 'FuncUnit_join' (Module cgrame_elastic_join_2to1_size_32)
  wire [1:0] FuncUnit_join__enable;
  wire [0:0] FuncUnit_join__enable_stop_upstream;
  wire [0:0] FuncUnit_join__enable_valid_upstream;
  wire [31:0] FuncUnit_join__in0;
  wire [0:0] FuncUnit_join__in0_stop_upstream;
  wire [0:0] FuncUnit_join__in0_valid_upstream;
  wire [31:0] FuncUnit_join__in1;
  wire [0:0] FuncUnit_join__in1_stop_upstream;
  wire [0:0] FuncUnit_join__in1_valid_upstream;
  wire [31:0] FuncUnit_join__out0;
  wire [31:0] FuncUnit_join__out1;
  wire [0:0] FuncUnit_join__out_stop_downstream;
  wire [0:0] FuncUnit_join__out_valid_downstream;
  cgrame_elastic_join_2to1_size_32 #(.contexts(1),.size(32)) FuncUnit_join(
    .enable(FuncUnit_join__enable),
    .enable_stop_upstream(FuncUnit_join__enable_stop_upstream),
    .enable_valid_upstream(FuncUnit_join__enable_valid_upstream),
    .in0(FuncUnit_join__in0),
    .in0_stop_upstream(FuncUnit_join__in0_stop_upstream),
    .in0_valid_upstream(FuncUnit_join__in0_valid_upstream),
    .in1(FuncUnit_join__in1),
    .in1_stop_upstream(FuncUnit_join__in1_stop_upstream),
    .in1_valid_upstream(FuncUnit_join__in1_valid_upstream),
    .out0(FuncUnit_join__out0),
    .out1(FuncUnit_join__out1),
    .out_stop_downstream(FuncUnit_join__out_stop_downstream),
    .out_valid_downstream(FuncUnit_join__out_valid_downstream)
  );

  //Wire declarations for instance 'FuncUnit_token_inducer' (Module cgrame_elastic_fu_vlu_adapter_32b)
  wire  FuncUnit_token_inducer__CGRA_Clock;
  wire  FuncUnit_token_inducer__CGRA_Enable;
  wire  FuncUnit_token_inducer__CGRA_Reset;
  wire [31:0] FuncUnit_token_inducer__data_in;
  wire [0:0] FuncUnit_token_inducer__data_in_stop_upstream;
  wire [0:0] FuncUnit_token_inducer__data_in_valid_upstream;
  wire [31:0] FuncUnit_token_inducer__data_out;
  wire [0:0] FuncUnit_token_inducer__data_out_stop_downstream;
  wire [0:0] FuncUnit_token_inducer__data_out_valid_downstream;
  wire [0:0] FuncUnit_token_inducer__token;
  wire [0:0] FuncUnit_token_inducer__token_stop_upstream;
  wire [0:0] FuncUnit_token_inducer__token_valid_upstream;
  cgrame_elastic_fu_vlu_adapter_32b #(.contexts(1),.size(32)) FuncUnit_token_inducer(
    .CGRA_Clock(FuncUnit_token_inducer__CGRA_Clock),
    .CGRA_Enable(FuncUnit_token_inducer__CGRA_Enable),
    .CGRA_Reset(FuncUnit_token_inducer__CGRA_Reset),
    .data_in(FuncUnit_token_inducer__data_in),
    .data_in_stop_upstream(FuncUnit_token_inducer__data_in_stop_upstream),
    .data_in_valid_upstream(FuncUnit_token_inducer__data_in_valid_upstream),
    .data_out(FuncUnit_token_inducer__data_out),
    .data_out_stop_downstream(FuncUnit_token_inducer__data_out_stop_downstream),
    .data_out_valid_downstream(FuncUnit_token_inducer__data_out_valid_downstream),
    .token(FuncUnit_token_inducer__token),
    .token_stop_upstream(FuncUnit_token_inducer__token_stop_upstream),
    .token_valid_upstream(FuncUnit_token_inducer__token_valid_upstream)
  );

  //All the connections
  assign FuncUnit_FPALU__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_fp_wrapper__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_token_inducer__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_FPUnitConfig__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_InputJoinConfig__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_adapterToken__CGRA_Clock = CGRA_Clock;
  assign FuncUnit_FPALU__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_fp_wrapper__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_token_inducer__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_FPUnitConfig__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_InputJoinConfig__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_adapterToken__CGRA_Reset = CGRA_Reset;
  assign FuncUnit_FPALU__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_fp_wrapper__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_token_inducer__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_FPUnitConfig__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_InputJoinConfig__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_adapterToken__CGRA_Enable = CGRA_Enable;
  assign FuncUnit_FPUnitConfig__Config_Clock = Config_Clock;
  assign FuncUnit_InputJoinConfig__Config_Clock = Config_Clock;
  assign FuncUnit_adapterToken__Config_Clock = Config_Clock;
  assign FuncUnit_FPUnitConfig__Config_Reset = Config_Reset;
  assign FuncUnit_InputJoinConfig__Config_Reset = Config_Reset;
  assign FuncUnit_adapterToken__Config_Reset = Config_Reset;
  assign FuncUnit_fp_wrapper__stop_downstream[0:0] = FuncUnit_token_inducer__data_in_stop_upstream[0:0];
  assign FuncUnit_token_inducer__data_in_valid_upstream[0:0] = FuncUnit_fp_wrapper__valid_downstream[0:0];
  assign FuncUnit_FPALU__in_a[31:0] = FuncUnit_join__out0[31:0];
  assign FuncUnit_join__out_stop_downstream[0:0] = FuncUnit_fp_wrapper__stop_upstream[0:0];
  assign in_b_stop_upstream[0:0] = FuncUnit_join__in1_stop_upstream[0:0];
  assign FuncUnit_FPALU__in_b[31:0] = FuncUnit_join__out1[31:0];
  assign FuncUnit_fp_wrapper__valid_upstream[0:0] = FuncUnit_join__out_valid_downstream[0:0];
  assign in_a_stop_upstream[0:0] = FuncUnit_join__in0_stop_upstream[0:0];
  assign out[31:0] = FuncUnit_token_inducer__data_out[31:0];
  assign out_valid_downstream[0:0] = FuncUnit_token_inducer__data_out_valid_downstream[0:0];
  assign FuncUnit_join__in0[31:0] = in_a[31:0];
  assign FuncUnit_join__in0_valid_upstream[0:0] = in_a_valid_upstream[0:0];
  assign FuncUnit_join__in1[31:0] = in_b[31:0];
  assign FuncUnit_join__in1_valid_upstream[0:0] = in_b_valid_upstream[0:0];
  assign FuncUnit_FPALU__FP_clk_en[0:0] = out_stop_downstream[0:0];
  assign FuncUnit_token_inducer__data_out_stop_downstream[0:0] = out_stop_downstream[0:0];
  assign FuncUnit_token_inducer__data_in[31:0] = FuncUnit_FPALU__out[31:0];
  assign FuncUnit_FPALU__opcode[1:0] = FuncUnit_FPUnitConfig__select[1:0];
  assign FuncUnit_fp_wrapper__opcode[1:0] = FuncUnit_FPUnitConfig__select[1:0];
  assign FuncUnit_join__enable[1:0] = FuncUnit_InputJoinConfig__select[1:0];
  assign FuncUnit_InputJoinConfig__valid[0:0] = FuncUnit_join__enable_valid_upstream[0:0];
  assign FuncUnit_InputJoinConfig__stop[0:0] = FuncUnit_join__enable_stop_upstream[0:0];
  assign FuncUnit_token_inducer__token[0:0] = FuncUnit_adapterToken__select[0:0];
  assign FuncUnit_adapterToken__valid[0:0] = FuncUnit_token_inducer__token_valid_upstream[0:0];
  assign FuncUnit_adapterToken__stop[0:0] = FuncUnit_token_inducer__token_stop_upstream[0:0];
  assign FuncUnit_FPUnitConfig__ConfigIn = ConfigIn;
  assign FuncUnit_InputJoinConfig__ConfigIn = FuncUnit_FPUnitConfig__ConfigOut;
  assign FuncUnit_adapterToken__ConfigIn = FuncUnit_InputJoinConfig__ConfigOut;
  assign ConfigOut = FuncUnit_adapterToken__ConfigOut;

endmodule //elastic_fp_unit_FuncUnit_size_32_U15

module elastic_riken_in255_out255_default_U6 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  input [31:0] in7,
  output [0:0] in7_stop_upstream,
  input [0:0] in7_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff4' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff4__CGRA_Clock;
  wire  buff4__CGRA_Enable;
  wire  buff4__CGRA_Reset;
  wire [31:0] buff4__data_in;
  wire [0:0] buff4__data_in_stop_upstream;
  wire [0:0] buff4__data_in_valid_upstream;
  wire [31:0] buff4__data_out;
  wire [0:0] buff4__data_out_stop_downstream;
  wire [0:0] buff4__data_out_valid_downstream;
  wire [0:0] buff4__enable;
  wire [0:0] buff4__enable_stop_upstream;
  wire [0:0] buff4__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff4(
    .CGRA_Clock(buff4__CGRA_Clock),
    .CGRA_Enable(buff4__CGRA_Enable),
    .CGRA_Reset(buff4__CGRA_Reset),
    .data_in(buff4__data_in),
    .data_in_stop_upstream(buff4__data_in_stop_upstream),
    .data_in_valid_upstream(buff4__data_in_valid_upstream),
    .data_out(buff4__data_out),
    .data_out_stop_downstream(buff4__data_out_stop_downstream),
    .data_out_valid_downstream(buff4__data_out_valid_downstream),
    .enable(buff4__enable),
    .enable_stop_upstream(buff4__enable_stop_upstream),
    .enable_valid_upstream(buff4__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff4Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff4Enable__CGRA_Clock;
  wire  buff4Enable__CGRA_Enable;
  wire  buff4Enable__CGRA_Reset;
  wire  buff4Enable__ConfigIn;
  wire  buff4Enable__ConfigOut;
  wire  buff4Enable__Config_Clock;
  wire  buff4Enable__Config_Reset;
  wire [0:0] buff4Enable__select;
  wire [0:0] buff4Enable__stop;
  wire [0:0] buff4Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff4Enable(
    .CGRA_Clock(buff4Enable__CGRA_Clock),
    .CGRA_Enable(buff4Enable__CGRA_Enable),
    .CGRA_Reset(buff4Enable__CGRA_Reset),
    .ConfigIn(buff4Enable__ConfigIn),
    .ConfigOut(buff4Enable__ConfigOut),
    .Config_Clock(buff4Enable__Config_Clock),
    .Config_Reset(buff4Enable__Config_Reset),
    .select(buff4Enable__select),
    .stop(buff4Enable__stop),
    .valid(buff4Enable__valid)
  );

  //Wire declarations for instance 'buff5' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff5__CGRA_Clock;
  wire  buff5__CGRA_Enable;
  wire  buff5__CGRA_Reset;
  wire [31:0] buff5__data_in;
  wire [0:0] buff5__data_in_stop_upstream;
  wire [0:0] buff5__data_in_valid_upstream;
  wire [31:0] buff5__data_out;
  wire [0:0] buff5__data_out_stop_downstream;
  wire [0:0] buff5__data_out_valid_downstream;
  wire [0:0] buff5__enable;
  wire [0:0] buff5__enable_stop_upstream;
  wire [0:0] buff5__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff5(
    .CGRA_Clock(buff5__CGRA_Clock),
    .CGRA_Enable(buff5__CGRA_Enable),
    .CGRA_Reset(buff5__CGRA_Reset),
    .data_in(buff5__data_in),
    .data_in_stop_upstream(buff5__data_in_stop_upstream),
    .data_in_valid_upstream(buff5__data_in_valid_upstream),
    .data_out(buff5__data_out),
    .data_out_stop_downstream(buff5__data_out_stop_downstream),
    .data_out_valid_downstream(buff5__data_out_valid_downstream),
    .enable(buff5__enable),
    .enable_stop_upstream(buff5__enable_stop_upstream),
    .enable_valid_upstream(buff5__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff5Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff5Enable__CGRA_Clock;
  wire  buff5Enable__CGRA_Enable;
  wire  buff5Enable__CGRA_Reset;
  wire  buff5Enable__ConfigIn;
  wire  buff5Enable__ConfigOut;
  wire  buff5Enable__Config_Clock;
  wire  buff5Enable__Config_Reset;
  wire [0:0] buff5Enable__select;
  wire [0:0] buff5Enable__stop;
  wire [0:0] buff5Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff5Enable(
    .CGRA_Clock(buff5Enable__CGRA_Clock),
    .CGRA_Enable(buff5Enable__CGRA_Enable),
    .CGRA_Reset(buff5Enable__CGRA_Reset),
    .ConfigIn(buff5Enable__ConfigIn),
    .ConfigOut(buff5Enable__ConfigOut),
    .Config_Clock(buff5Enable__Config_Clock),
    .Config_Reset(buff5Enable__Config_Reset),
    .select(buff5Enable__select),
    .stop(buff5Enable__stop),
    .valid(buff5Enable__valid)
  );

  //Wire declarations for instance 'buff6' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff6__CGRA_Clock;
  wire  buff6__CGRA_Enable;
  wire  buff6__CGRA_Reset;
  wire [31:0] buff6__data_in;
  wire [0:0] buff6__data_in_stop_upstream;
  wire [0:0] buff6__data_in_valid_upstream;
  wire [31:0] buff6__data_out;
  wire [0:0] buff6__data_out_stop_downstream;
  wire [0:0] buff6__data_out_valid_downstream;
  wire [0:0] buff6__enable;
  wire [0:0] buff6__enable_stop_upstream;
  wire [0:0] buff6__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff6(
    .CGRA_Clock(buff6__CGRA_Clock),
    .CGRA_Enable(buff6__CGRA_Enable),
    .CGRA_Reset(buff6__CGRA_Reset),
    .data_in(buff6__data_in),
    .data_in_stop_upstream(buff6__data_in_stop_upstream),
    .data_in_valid_upstream(buff6__data_in_valid_upstream),
    .data_out(buff6__data_out),
    .data_out_stop_downstream(buff6__data_out_stop_downstream),
    .data_out_valid_downstream(buff6__data_out_valid_downstream),
    .enable(buff6__enable),
    .enable_stop_upstream(buff6__enable_stop_upstream),
    .enable_valid_upstream(buff6__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff6Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff6Enable__CGRA_Clock;
  wire  buff6Enable__CGRA_Enable;
  wire  buff6Enable__CGRA_Reset;
  wire  buff6Enable__ConfigIn;
  wire  buff6Enable__ConfigOut;
  wire  buff6Enable__Config_Clock;
  wire  buff6Enable__Config_Reset;
  wire [0:0] buff6Enable__select;
  wire [0:0] buff6Enable__stop;
  wire [0:0] buff6Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff6Enable(
    .CGRA_Clock(buff6Enable__CGRA_Clock),
    .CGRA_Enable(buff6Enable__CGRA_Enable),
    .CGRA_Reset(buff6Enable__CGRA_Reset),
    .ConfigIn(buff6Enable__ConfigIn),
    .ConfigOut(buff6Enable__ConfigOut),
    .Config_Clock(buff6Enable__Config_Clock),
    .Config_Reset(buff6Enable__Config_Reset),
    .select(buff6Enable__select),
    .stop(buff6Enable__stop),
    .valid(buff6Enable__valid)
  );

  //Wire declarations for instance 'buff7' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff7__CGRA_Clock;
  wire  buff7__CGRA_Enable;
  wire  buff7__CGRA_Reset;
  wire [31:0] buff7__data_in;
  wire [0:0] buff7__data_in_stop_upstream;
  wire [0:0] buff7__data_in_valid_upstream;
  wire [31:0] buff7__data_out;
  wire [0:0] buff7__data_out_stop_downstream;
  wire [0:0] buff7__data_out_valid_downstream;
  wire [0:0] buff7__enable;
  wire [0:0] buff7__enable_stop_upstream;
  wire [0:0] buff7__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff7(
    .CGRA_Clock(buff7__CGRA_Clock),
    .CGRA_Enable(buff7__CGRA_Enable),
    .CGRA_Reset(buff7__CGRA_Reset),
    .data_in(buff7__data_in),
    .data_in_stop_upstream(buff7__data_in_stop_upstream),
    .data_in_valid_upstream(buff7__data_in_valid_upstream),
    .data_out(buff7__data_out),
    .data_out_stop_downstream(buff7__data_out_stop_downstream),
    .data_out_valid_downstream(buff7__data_out_valid_downstream),
    .enable(buff7__enable),
    .enable_stop_upstream(buff7__enable_stop_upstream),
    .enable_valid_upstream(buff7__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff7Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff7Enable__CGRA_Clock;
  wire  buff7Enable__CGRA_Enable;
  wire  buff7Enable__CGRA_Reset;
  wire  buff7Enable__ConfigIn;
  wire  buff7Enable__ConfigOut;
  wire  buff7Enable__Config_Clock;
  wire  buff7Enable__Config_Reset;
  wire [0:0] buff7Enable__select;
  wire [0:0] buff7Enable__stop;
  wire [0:0] buff7Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff7Enable(
    .CGRA_Clock(buff7Enable__CGRA_Clock),
    .CGRA_Enable(buff7Enable__CGRA_Enable),
    .CGRA_Reset(buff7Enable__CGRA_Reset),
    .ConfigIn(buff7Enable__ConfigIn),
    .ConfigOut(buff7Enable__ConfigOut),
    .Config_Clock(buff7Enable__Config_Clock),
    .Config_Reset(buff7Enable__Config_Reset),
    .select(buff7Enable__select),
    .stop(buff7Enable__stop),
    .valid(buff7Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_9in_10out_size_32_U22)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__in6;
  wire [0:0] crossbar__in6_stop_upstream;
  wire [0:0] crossbar__in6_valid_upstream;
  wire [31:0] crossbar__in7;
  wire [0:0] crossbar__in7_stop_upstream;
  wire [0:0] crossbar__in7_valid_upstream;
  wire [31:0] crossbar__in8;
  wire [0:0] crossbar__in8_stop_upstream;
  wire [0:0] crossbar__in8_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  wire [31:0] crossbar__out7;
  wire [0:0] crossbar__out7_stop_downstream;
  wire [0:0] crossbar__out7_valid_downstream;
  wire [31:0] crossbar__out8;
  wire [0:0] crossbar__out8_stop_downstream;
  wire [0:0] crossbar__out8_valid_downstream;
  wire [31:0] crossbar__out9;
  wire [0:0] crossbar__out9_stop_downstream;
  wire [0:0] crossbar__out9_valid_downstream;
  elastic_crossbar_9in_10out_size_32_U22 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .in6(crossbar__in6),
    .in6_stop_upstream(crossbar__in6_stop_upstream),
    .in6_valid_upstream(crossbar__in6_valid_upstream),
    .in7(crossbar__in7),
    .in7_stop_upstream(crossbar__in7_stop_upstream),
    .in7_valid_upstream(crossbar__in7_valid_upstream),
    .in8(crossbar__in8),
    .in8_stop_upstream(crossbar__in8_stop_upstream),
    .in8_valid_upstream(crossbar__in8_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream),
    .out7(crossbar__out7),
    .out7_stop_downstream(crossbar__out7_stop_downstream),
    .out7_valid_downstream(crossbar__out7_valid_downstream),
    .out8(crossbar__out8),
    .out8_stop_downstream(crossbar__out8_stop_downstream),
    .out8_valid_downstream(crossbar__out8_valid_downstream),
    .out9(crossbar__out9),
    .out9_stop_downstream(crossbar__out9_stop_downstream),
    .out9_valid_downstream(crossbar__out9_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff4Enable__Config_Clock = Config_Clock;
  assign buff5Enable__Config_Clock = Config_Clock;
  assign buff6Enable__Config_Clock = Config_Clock;
  assign buff7Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff4Enable__Config_Reset = Config_Reset;
  assign buff5Enable__Config_Reset = Config_Reset;
  assign buff6Enable__Config_Reset = Config_Reset;
  assign buff7Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff4__CGRA_Clock = CGRA_Clock;
  assign buff5__CGRA_Clock = CGRA_Clock;
  assign buff6__CGRA_Clock = CGRA_Clock;
  assign buff7__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff4Enable__CGRA_Clock = CGRA_Clock;
  assign buff5Enable__CGRA_Clock = CGRA_Clock;
  assign buff6Enable__CGRA_Clock = CGRA_Clock;
  assign buff7Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff4__CGRA_Reset = CGRA_Reset;
  assign buff5__CGRA_Reset = CGRA_Reset;
  assign buff6__CGRA_Reset = CGRA_Reset;
  assign buff7__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff4Enable__CGRA_Reset = CGRA_Reset;
  assign buff5Enable__CGRA_Reset = CGRA_Reset;
  assign buff6Enable__CGRA_Reset = CGRA_Reset;
  assign buff7Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff4__CGRA_Enable = CGRA_Enable;
  assign buff5__CGRA_Enable = CGRA_Enable;
  assign buff6__CGRA_Enable = CGRA_Enable;
  assign buff7__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff4Enable__CGRA_Enable = CGRA_Enable;
  assign buff5Enable__CGRA_Enable = CGRA_Enable;
  assign buff6Enable__CGRA_Enable = CGRA_Enable;
  assign buff7Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out8_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out9_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in8[31:0] = buffOut__data_out[31:0];
  assign crossbar__in8_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff4__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buff5__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign buff6__data_out_stop_downstream[0:0] = crossbar__in6_stop_upstream[0:0];
  assign buff7__data_out_stop_downstream[0:0] = crossbar__in7_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in8_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out4[31:0] = crossbar__out4[31:0];
  assign out4_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign out5[31:0] = crossbar__out5[31:0];
  assign out5_valid_downstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign out6[31:0] = crossbar__out6[31:0];
  assign out6_valid_downstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign out7[31:0] = crossbar__out7[31:0];
  assign out7_valid_downstream[0:0] = crossbar__out7_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out8[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out8_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out9[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out9_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in4_stop_upstream[0:0] = buff4__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff4__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff4__data_out_valid_downstream[0:0];
  assign in5_stop_upstream[0:0] = buff5__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buff5__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buff5__data_out_valid_downstream[0:0];
  assign in6_stop_upstream[0:0] = buff6__data_in_stop_upstream[0:0];
  assign crossbar__in6[31:0] = buff6__data_out[31:0];
  assign crossbar__in6_valid_upstream[0:0] = buff6__data_out_valid_downstream[0:0];
  assign in7_stop_upstream[0:0] = buff7__data_in_stop_upstream[0:0];
  assign crossbar__in7[31:0] = buff7__data_out[31:0];
  assign crossbar__in7_valid_upstream[0:0] = buff7__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff4__data_in[31:0] = in4[31:0];
  assign buff4__data_in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign buff5__data_in[31:0] = in5[31:0];
  assign buff5__data_in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign buff6__data_in[31:0] = in6[31:0];
  assign buff6__data_in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign buff7__data_in[31:0] = in7[31:0];
  assign buff7__data_in_valid_upstream[0:0] = in7_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign crossbar__out6_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign crossbar__out7_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff4__enable[0:0] = buff4Enable__select[0:0];
  assign buff4Enable__valid[0:0] = buff4__enable_valid_upstream[0:0];
  assign buff4Enable__stop[0:0] = buff4__enable_stop_upstream[0:0];
  assign buff5__enable[0:0] = buff5Enable__select[0:0];
  assign buff5Enable__valid[0:0] = buff5__enable_valid_upstream[0:0];
  assign buff5Enable__stop[0:0] = buff5__enable_stop_upstream[0:0];
  assign buff6__enable[0:0] = buff6Enable__select[0:0];
  assign buff6Enable__valid[0:0] = buff6__enable_valid_upstream[0:0];
  assign buff6Enable__stop[0:0] = buff6__enable_stop_upstream[0:0];
  assign buff7__enable[0:0] = buff7Enable__select[0:0];
  assign buff7Enable__valid[0:0] = buff7__enable_valid_upstream[0:0];
  assign buff7Enable__stop[0:0] = buff7__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff4Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buff5Enable__ConfigIn = buff4Enable__ConfigOut;
  assign buff6Enable__ConfigIn = buff5Enable__ConfigOut;
  assign buff7Enable__ConfigIn = buff6Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff7Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in255_out255_default_U6

module elastic_riken_in63_out63_default_U7 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff4' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff4__CGRA_Clock;
  wire  buff4__CGRA_Enable;
  wire  buff4__CGRA_Reset;
  wire [31:0] buff4__data_in;
  wire [0:0] buff4__data_in_stop_upstream;
  wire [0:0] buff4__data_in_valid_upstream;
  wire [31:0] buff4__data_out;
  wire [0:0] buff4__data_out_stop_downstream;
  wire [0:0] buff4__data_out_valid_downstream;
  wire [0:0] buff4__enable;
  wire [0:0] buff4__enable_stop_upstream;
  wire [0:0] buff4__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff4(
    .CGRA_Clock(buff4__CGRA_Clock),
    .CGRA_Enable(buff4__CGRA_Enable),
    .CGRA_Reset(buff4__CGRA_Reset),
    .data_in(buff4__data_in),
    .data_in_stop_upstream(buff4__data_in_stop_upstream),
    .data_in_valid_upstream(buff4__data_in_valid_upstream),
    .data_out(buff4__data_out),
    .data_out_stop_downstream(buff4__data_out_stop_downstream),
    .data_out_valid_downstream(buff4__data_out_valid_downstream),
    .enable(buff4__enable),
    .enable_stop_upstream(buff4__enable_stop_upstream),
    .enable_valid_upstream(buff4__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff4Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff4Enable__CGRA_Clock;
  wire  buff4Enable__CGRA_Enable;
  wire  buff4Enable__CGRA_Reset;
  wire  buff4Enable__ConfigIn;
  wire  buff4Enable__ConfigOut;
  wire  buff4Enable__Config_Clock;
  wire  buff4Enable__Config_Reset;
  wire [0:0] buff4Enable__select;
  wire [0:0] buff4Enable__stop;
  wire [0:0] buff4Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff4Enable(
    .CGRA_Clock(buff4Enable__CGRA_Clock),
    .CGRA_Enable(buff4Enable__CGRA_Enable),
    .CGRA_Reset(buff4Enable__CGRA_Reset),
    .ConfigIn(buff4Enable__ConfigIn),
    .ConfigOut(buff4Enable__ConfigOut),
    .Config_Clock(buff4Enable__Config_Clock),
    .Config_Reset(buff4Enable__Config_Reset),
    .select(buff4Enable__select),
    .stop(buff4Enable__stop),
    .valid(buff4Enable__valid)
  );

  //Wire declarations for instance 'buff5' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff5__CGRA_Clock;
  wire  buff5__CGRA_Enable;
  wire  buff5__CGRA_Reset;
  wire [31:0] buff5__data_in;
  wire [0:0] buff5__data_in_stop_upstream;
  wire [0:0] buff5__data_in_valid_upstream;
  wire [31:0] buff5__data_out;
  wire [0:0] buff5__data_out_stop_downstream;
  wire [0:0] buff5__data_out_valid_downstream;
  wire [0:0] buff5__enable;
  wire [0:0] buff5__enable_stop_upstream;
  wire [0:0] buff5__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff5(
    .CGRA_Clock(buff5__CGRA_Clock),
    .CGRA_Enable(buff5__CGRA_Enable),
    .CGRA_Reset(buff5__CGRA_Reset),
    .data_in(buff5__data_in),
    .data_in_stop_upstream(buff5__data_in_stop_upstream),
    .data_in_valid_upstream(buff5__data_in_valid_upstream),
    .data_out(buff5__data_out),
    .data_out_stop_downstream(buff5__data_out_stop_downstream),
    .data_out_valid_downstream(buff5__data_out_valid_downstream),
    .enable(buff5__enable),
    .enable_stop_upstream(buff5__enable_stop_upstream),
    .enable_valid_upstream(buff5__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff5Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff5Enable__CGRA_Clock;
  wire  buff5Enable__CGRA_Enable;
  wire  buff5Enable__CGRA_Reset;
  wire  buff5Enable__ConfigIn;
  wire  buff5Enable__ConfigOut;
  wire  buff5Enable__Config_Clock;
  wire  buff5Enable__Config_Reset;
  wire [0:0] buff5Enable__select;
  wire [0:0] buff5Enable__stop;
  wire [0:0] buff5Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff5Enable(
    .CGRA_Clock(buff5Enable__CGRA_Clock),
    .CGRA_Enable(buff5Enable__CGRA_Enable),
    .CGRA_Reset(buff5Enable__CGRA_Reset),
    .ConfigIn(buff5Enable__ConfigIn),
    .ConfigOut(buff5Enable__ConfigOut),
    .Config_Clock(buff5Enable__Config_Clock),
    .Config_Reset(buff5Enable__Config_Reset),
    .select(buff5Enable__select),
    .stop(buff5Enable__stop),
    .valid(buff5Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_7in_8out_size_32_U19)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__in6;
  wire [0:0] crossbar__in6_stop_upstream;
  wire [0:0] crossbar__in6_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  wire [31:0] crossbar__out7;
  wire [0:0] crossbar__out7_stop_downstream;
  wire [0:0] crossbar__out7_valid_downstream;
  elastic_crossbar_7in_8out_size_32_U19 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .in6(crossbar__in6),
    .in6_stop_upstream(crossbar__in6_stop_upstream),
    .in6_valid_upstream(crossbar__in6_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream),
    .out7(crossbar__out7),
    .out7_stop_downstream(crossbar__out7_stop_downstream),
    .out7_valid_downstream(crossbar__out7_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff4Enable__Config_Clock = Config_Clock;
  assign buff5Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff4Enable__Config_Reset = Config_Reset;
  assign buff5Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff4__CGRA_Clock = CGRA_Clock;
  assign buff5__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff4Enable__CGRA_Clock = CGRA_Clock;
  assign buff5Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff4__CGRA_Reset = CGRA_Reset;
  assign buff5__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff4Enable__CGRA_Reset = CGRA_Reset;
  assign buff5Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff4__CGRA_Enable = CGRA_Enable;
  assign buff5__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff4Enable__CGRA_Enable = CGRA_Enable;
  assign buff5Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out6_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out7_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in6[31:0] = buffOut__data_out[31:0];
  assign crossbar__in6_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff4__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buff5__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in6_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out4[31:0] = crossbar__out4[31:0];
  assign out4_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign out5[31:0] = crossbar__out5[31:0];
  assign out5_valid_downstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out6[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out7[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out7_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in4_stop_upstream[0:0] = buff4__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff4__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff4__data_out_valid_downstream[0:0];
  assign in5_stop_upstream[0:0] = buff5__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buff5__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buff5__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff4__data_in[31:0] = in4[31:0];
  assign buff4__data_in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign buff5__data_in[31:0] = in5[31:0];
  assign buff5__data_in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff4__enable[0:0] = buff4Enable__select[0:0];
  assign buff4Enable__valid[0:0] = buff4__enable_valid_upstream[0:0];
  assign buff4Enable__stop[0:0] = buff4__enable_stop_upstream[0:0];
  assign buff5__enable[0:0] = buff5Enable__select[0:0];
  assign buff5Enable__valid[0:0] = buff5__enable_valid_upstream[0:0];
  assign buff5Enable__stop[0:0] = buff5__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff4Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buff5Enable__ConfigIn = buff4Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff5Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in63_out63_default_U7

module elastic_riken_in159_out159_default_U9 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  input [31:0] in7,
  output [0:0] in7_stop_upstream,
  input [0:0] in7_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff4' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff4__CGRA_Clock;
  wire  buff4__CGRA_Enable;
  wire  buff4__CGRA_Reset;
  wire [31:0] buff4__data_in;
  wire [0:0] buff4__data_in_stop_upstream;
  wire [0:0] buff4__data_in_valid_upstream;
  wire [31:0] buff4__data_out;
  wire [0:0] buff4__data_out_stop_downstream;
  wire [0:0] buff4__data_out_valid_downstream;
  wire [0:0] buff4__enable;
  wire [0:0] buff4__enable_stop_upstream;
  wire [0:0] buff4__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff4(
    .CGRA_Clock(buff4__CGRA_Clock),
    .CGRA_Enable(buff4__CGRA_Enable),
    .CGRA_Reset(buff4__CGRA_Reset),
    .data_in(buff4__data_in),
    .data_in_stop_upstream(buff4__data_in_stop_upstream),
    .data_in_valid_upstream(buff4__data_in_valid_upstream),
    .data_out(buff4__data_out),
    .data_out_stop_downstream(buff4__data_out_stop_downstream),
    .data_out_valid_downstream(buff4__data_out_valid_downstream),
    .enable(buff4__enable),
    .enable_stop_upstream(buff4__enable_stop_upstream),
    .enable_valid_upstream(buff4__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff4Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff4Enable__CGRA_Clock;
  wire  buff4Enable__CGRA_Enable;
  wire  buff4Enable__CGRA_Reset;
  wire  buff4Enable__ConfigIn;
  wire  buff4Enable__ConfigOut;
  wire  buff4Enable__Config_Clock;
  wire  buff4Enable__Config_Reset;
  wire [0:0] buff4Enable__select;
  wire [0:0] buff4Enable__stop;
  wire [0:0] buff4Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff4Enable(
    .CGRA_Clock(buff4Enable__CGRA_Clock),
    .CGRA_Enable(buff4Enable__CGRA_Enable),
    .CGRA_Reset(buff4Enable__CGRA_Reset),
    .ConfigIn(buff4Enable__ConfigIn),
    .ConfigOut(buff4Enable__ConfigOut),
    .Config_Clock(buff4Enable__Config_Clock),
    .Config_Reset(buff4Enable__Config_Reset),
    .select(buff4Enable__select),
    .stop(buff4Enable__stop),
    .valid(buff4Enable__valid)
  );

  //Wire declarations for instance 'buff7' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff7__CGRA_Clock;
  wire  buff7__CGRA_Enable;
  wire  buff7__CGRA_Reset;
  wire [31:0] buff7__data_in;
  wire [0:0] buff7__data_in_stop_upstream;
  wire [0:0] buff7__data_in_valid_upstream;
  wire [31:0] buff7__data_out;
  wire [0:0] buff7__data_out_stop_downstream;
  wire [0:0] buff7__data_out_valid_downstream;
  wire [0:0] buff7__enable;
  wire [0:0] buff7__enable_stop_upstream;
  wire [0:0] buff7__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff7(
    .CGRA_Clock(buff7__CGRA_Clock),
    .CGRA_Enable(buff7__CGRA_Enable),
    .CGRA_Reset(buff7__CGRA_Reset),
    .data_in(buff7__data_in),
    .data_in_stop_upstream(buff7__data_in_stop_upstream),
    .data_in_valid_upstream(buff7__data_in_valid_upstream),
    .data_out(buff7__data_out),
    .data_out_stop_downstream(buff7__data_out_stop_downstream),
    .data_out_valid_downstream(buff7__data_out_valid_downstream),
    .enable(buff7__enable),
    .enable_stop_upstream(buff7__enable_stop_upstream),
    .enable_valid_upstream(buff7__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff7Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff7Enable__CGRA_Clock;
  wire  buff7Enable__CGRA_Enable;
  wire  buff7Enable__CGRA_Reset;
  wire  buff7Enable__ConfigIn;
  wire  buff7Enable__ConfigOut;
  wire  buff7Enable__Config_Clock;
  wire  buff7Enable__Config_Reset;
  wire [0:0] buff7Enable__select;
  wire [0:0] buff7Enable__stop;
  wire [0:0] buff7Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff7Enable(
    .CGRA_Clock(buff7Enable__CGRA_Clock),
    .CGRA_Enable(buff7Enable__CGRA_Enable),
    .CGRA_Reset(buff7Enable__CGRA_Reset),
    .ConfigIn(buff7Enable__ConfigIn),
    .ConfigOut(buff7Enable__ConfigOut),
    .Config_Clock(buff7Enable__Config_Clock),
    .Config_Reset(buff7Enable__Config_Reset),
    .select(buff7Enable__select),
    .stop(buff7Enable__stop),
    .valid(buff7Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_7in_8out_size_32_U19)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__in6;
  wire [0:0] crossbar__in6_stop_upstream;
  wire [0:0] crossbar__in6_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  wire [31:0] crossbar__out7;
  wire [0:0] crossbar__out7_stop_downstream;
  wire [0:0] crossbar__out7_valid_downstream;
  elastic_crossbar_7in_8out_size_32_U19 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .in6(crossbar__in6),
    .in6_stop_upstream(crossbar__in6_stop_upstream),
    .in6_valid_upstream(crossbar__in6_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream),
    .out7(crossbar__out7),
    .out7_stop_downstream(crossbar__out7_stop_downstream),
    .out7_valid_downstream(crossbar__out7_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff4Enable__Config_Clock = Config_Clock;
  assign buff7Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff4Enable__Config_Reset = Config_Reset;
  assign buff7Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff4__CGRA_Clock = CGRA_Clock;
  assign buff7__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff4Enable__CGRA_Clock = CGRA_Clock;
  assign buff7Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff4__CGRA_Reset = CGRA_Reset;
  assign buff7__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff4Enable__CGRA_Reset = CGRA_Reset;
  assign buff7Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff4__CGRA_Enable = CGRA_Enable;
  assign buff7__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff4Enable__CGRA_Enable = CGRA_Enable;
  assign buff7Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out6_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out7_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in6[31:0] = buffOut__data_out[31:0];
  assign crossbar__in6_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff4__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buff7__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in6_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out4[31:0] = crossbar__out4[31:0];
  assign out4_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign out7[31:0] = crossbar__out5[31:0];
  assign out7_valid_downstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out6[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out7[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out7_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in4_stop_upstream[0:0] = buff4__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff4__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff4__data_out_valid_downstream[0:0];
  assign in7_stop_upstream[0:0] = buff7__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buff7__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buff7__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff4__data_in[31:0] = in4[31:0];
  assign buff4__data_in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign buff7__data_in[31:0] = in7[31:0];
  assign buff7__data_in_valid_upstream[0:0] = in7_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff4__enable[0:0] = buff4Enable__select[0:0];
  assign buff4Enable__valid[0:0] = buff4__enable_valid_upstream[0:0];
  assign buff4Enable__stop[0:0] = buff4__enable_stop_upstream[0:0];
  assign buff7__enable[0:0] = buff7Enable__select[0:0];
  assign buff7Enable__valid[0:0] = buff7__enable_valid_upstream[0:0];
  assign buff7Enable__stop[0:0] = buff7__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff4Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buff7Enable__ConfigIn = buff4Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff7Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in159_out159_default_U9

module elastic_riken_in143_out143_default_U8 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in7,
  output [0:0] in7_stop_upstream,
  input [0:0] in7_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff7' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff7__CGRA_Clock;
  wire  buff7__CGRA_Enable;
  wire  buff7__CGRA_Reset;
  wire [31:0] buff7__data_in;
  wire [0:0] buff7__data_in_stop_upstream;
  wire [0:0] buff7__data_in_valid_upstream;
  wire [31:0] buff7__data_out;
  wire [0:0] buff7__data_out_stop_downstream;
  wire [0:0] buff7__data_out_valid_downstream;
  wire [0:0] buff7__enable;
  wire [0:0] buff7__enable_stop_upstream;
  wire [0:0] buff7__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff7(
    .CGRA_Clock(buff7__CGRA_Clock),
    .CGRA_Enable(buff7__CGRA_Enable),
    .CGRA_Reset(buff7__CGRA_Reset),
    .data_in(buff7__data_in),
    .data_in_stop_upstream(buff7__data_in_stop_upstream),
    .data_in_valid_upstream(buff7__data_in_valid_upstream),
    .data_out(buff7__data_out),
    .data_out_stop_downstream(buff7__data_out_stop_downstream),
    .data_out_valid_downstream(buff7__data_out_valid_downstream),
    .enable(buff7__enable),
    .enable_stop_upstream(buff7__enable_stop_upstream),
    .enable_valid_upstream(buff7__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff7Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff7Enable__CGRA_Clock;
  wire  buff7Enable__CGRA_Enable;
  wire  buff7Enable__CGRA_Reset;
  wire  buff7Enable__ConfigIn;
  wire  buff7Enable__ConfigOut;
  wire  buff7Enable__Config_Clock;
  wire  buff7Enable__Config_Reset;
  wire [0:0] buff7Enable__select;
  wire [0:0] buff7Enable__stop;
  wire [0:0] buff7Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff7Enable(
    .CGRA_Clock(buff7Enable__CGRA_Clock),
    .CGRA_Enable(buff7Enable__CGRA_Enable),
    .CGRA_Reset(buff7Enable__CGRA_Reset),
    .ConfigIn(buff7Enable__ConfigIn),
    .ConfigOut(buff7Enable__ConfigOut),
    .Config_Clock(buff7Enable__Config_Clock),
    .Config_Reset(buff7Enable__Config_Reset),
    .select(buff7Enable__select),
    .stop(buff7Enable__stop),
    .valid(buff7Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_6in_7out_size_32_U21)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  elastic_crossbar_6in_7out_size_32_U21 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign buff7Enable__CGRA_Enable = CGRA_Enable;
  assign buff7Enable__CGRA_Reset = CGRA_Reset;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff7Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff7Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff7__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff7Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff7__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff7__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out5_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out6_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buffOut__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff7__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out7[31:0] = crossbar__out4[31:0];
  assign out7_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out5[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out6[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in7_stop_upstream[0:0] = buff7__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff7__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff7__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff7__data_in[31:0] = in7[31:0];
  assign buff7__data_in_valid_upstream[0:0] = in7_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff7__enable[0:0] = buff7Enable__select[0:0];
  assign buff7Enable__valid[0:0] = buff7__enable_valid_upstream[0:0];
  assign buff7Enable__stop[0:0] = buff7__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff7Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff7Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in143_out143_default_U8

module elastic_riken_in47_out47_default_U4 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff5' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff5__CGRA_Clock;
  wire  buff5__CGRA_Enable;
  wire  buff5__CGRA_Reset;
  wire [31:0] buff5__data_in;
  wire [0:0] buff5__data_in_stop_upstream;
  wire [0:0] buff5__data_in_valid_upstream;
  wire [31:0] buff5__data_out;
  wire [0:0] buff5__data_out_stop_downstream;
  wire [0:0] buff5__data_out_valid_downstream;
  wire [0:0] buff5__enable;
  wire [0:0] buff5__enable_stop_upstream;
  wire [0:0] buff5__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff5(
    .CGRA_Clock(buff5__CGRA_Clock),
    .CGRA_Enable(buff5__CGRA_Enable),
    .CGRA_Reset(buff5__CGRA_Reset),
    .data_in(buff5__data_in),
    .data_in_stop_upstream(buff5__data_in_stop_upstream),
    .data_in_valid_upstream(buff5__data_in_valid_upstream),
    .data_out(buff5__data_out),
    .data_out_stop_downstream(buff5__data_out_stop_downstream),
    .data_out_valid_downstream(buff5__data_out_valid_downstream),
    .enable(buff5__enable),
    .enable_stop_upstream(buff5__enable_stop_upstream),
    .enable_valid_upstream(buff5__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff5Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff5Enable__CGRA_Clock;
  wire  buff5Enable__CGRA_Enable;
  wire  buff5Enable__CGRA_Reset;
  wire  buff5Enable__ConfigIn;
  wire  buff5Enable__ConfigOut;
  wire  buff5Enable__Config_Clock;
  wire  buff5Enable__Config_Reset;
  wire [0:0] buff5Enable__select;
  wire [0:0] buff5Enable__stop;
  wire [0:0] buff5Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff5Enable(
    .CGRA_Clock(buff5Enable__CGRA_Clock),
    .CGRA_Enable(buff5Enable__CGRA_Enable),
    .CGRA_Reset(buff5Enable__CGRA_Reset),
    .ConfigIn(buff5Enable__ConfigIn),
    .ConfigOut(buff5Enable__ConfigOut),
    .Config_Clock(buff5Enable__Config_Clock),
    .Config_Reset(buff5Enable__Config_Reset),
    .select(buff5Enable__select),
    .stop(buff5Enable__stop),
    .valid(buff5Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_6in_7out_size_32_U21)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  elastic_crossbar_6in_7out_size_32_U21 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff5Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff5Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff5__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff5Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff5__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff5Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff5__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff5Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out5_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out6_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buffOut__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff5__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out5[31:0] = crossbar__out4[31:0];
  assign out5_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out5[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out6[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in5_stop_upstream[0:0] = buff5__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff5__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff5__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff5__data_in[31:0] = in5[31:0];
  assign buff5__data_in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff5__enable[0:0] = buff5Enable__select[0:0];
  assign buff5Enable__valid[0:0] = buff5__enable_valid_upstream[0:0];
  assign buff5Enable__stop[0:0] = buff5__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff5Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff5Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in47_out47_default_U4

module elastic_riken_in111_out111_default_U3 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in5,
  output [0:0] in5_stop_upstream,
  input [0:0] in5_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out5,
  input [0:0] out5_stop_downstream,
  output [0:0] out5_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff5' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff5__CGRA_Clock;
  wire  buff5__CGRA_Enable;
  wire  buff5__CGRA_Reset;
  wire [31:0] buff5__data_in;
  wire [0:0] buff5__data_in_stop_upstream;
  wire [0:0] buff5__data_in_valid_upstream;
  wire [31:0] buff5__data_out;
  wire [0:0] buff5__data_out_stop_downstream;
  wire [0:0] buff5__data_out_valid_downstream;
  wire [0:0] buff5__enable;
  wire [0:0] buff5__enable_stop_upstream;
  wire [0:0] buff5__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff5(
    .CGRA_Clock(buff5__CGRA_Clock),
    .CGRA_Enable(buff5__CGRA_Enable),
    .CGRA_Reset(buff5__CGRA_Reset),
    .data_in(buff5__data_in),
    .data_in_stop_upstream(buff5__data_in_stop_upstream),
    .data_in_valid_upstream(buff5__data_in_valid_upstream),
    .data_out(buff5__data_out),
    .data_out_stop_downstream(buff5__data_out_stop_downstream),
    .data_out_valid_downstream(buff5__data_out_valid_downstream),
    .enable(buff5__enable),
    .enable_stop_upstream(buff5__enable_stop_upstream),
    .enable_valid_upstream(buff5__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff5Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff5Enable__CGRA_Clock;
  wire  buff5Enable__CGRA_Enable;
  wire  buff5Enable__CGRA_Reset;
  wire  buff5Enable__ConfigIn;
  wire  buff5Enable__ConfigOut;
  wire  buff5Enable__Config_Clock;
  wire  buff5Enable__Config_Reset;
  wire [0:0] buff5Enable__select;
  wire [0:0] buff5Enable__stop;
  wire [0:0] buff5Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff5Enable(
    .CGRA_Clock(buff5Enable__CGRA_Clock),
    .CGRA_Enable(buff5Enable__CGRA_Enable),
    .CGRA_Reset(buff5Enable__CGRA_Reset),
    .ConfigIn(buff5Enable__ConfigIn),
    .ConfigOut(buff5Enable__ConfigOut),
    .Config_Clock(buff5Enable__Config_Clock),
    .Config_Reset(buff5Enable__Config_Reset),
    .select(buff5Enable__select),
    .stop(buff5Enable__stop),
    .valid(buff5Enable__valid)
  );

  //Wire declarations for instance 'buff6' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff6__CGRA_Clock;
  wire  buff6__CGRA_Enable;
  wire  buff6__CGRA_Reset;
  wire [31:0] buff6__data_in;
  wire [0:0] buff6__data_in_stop_upstream;
  wire [0:0] buff6__data_in_valid_upstream;
  wire [31:0] buff6__data_out;
  wire [0:0] buff6__data_out_stop_downstream;
  wire [0:0] buff6__data_out_valid_downstream;
  wire [0:0] buff6__enable;
  wire [0:0] buff6__enable_stop_upstream;
  wire [0:0] buff6__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff6(
    .CGRA_Clock(buff6__CGRA_Clock),
    .CGRA_Enable(buff6__CGRA_Enable),
    .CGRA_Reset(buff6__CGRA_Reset),
    .data_in(buff6__data_in),
    .data_in_stop_upstream(buff6__data_in_stop_upstream),
    .data_in_valid_upstream(buff6__data_in_valid_upstream),
    .data_out(buff6__data_out),
    .data_out_stop_downstream(buff6__data_out_stop_downstream),
    .data_out_valid_downstream(buff6__data_out_valid_downstream),
    .enable(buff6__enable),
    .enable_stop_upstream(buff6__enable_stop_upstream),
    .enable_valid_upstream(buff6__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff6Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff6Enable__CGRA_Clock;
  wire  buff6Enable__CGRA_Enable;
  wire  buff6Enable__CGRA_Reset;
  wire  buff6Enable__ConfigIn;
  wire  buff6Enable__ConfigOut;
  wire  buff6Enable__Config_Clock;
  wire  buff6Enable__Config_Reset;
  wire [0:0] buff6Enable__select;
  wire [0:0] buff6Enable__stop;
  wire [0:0] buff6Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff6Enable(
    .CGRA_Clock(buff6Enable__CGRA_Clock),
    .CGRA_Enable(buff6Enable__CGRA_Enable),
    .CGRA_Reset(buff6Enable__CGRA_Reset),
    .ConfigIn(buff6Enable__ConfigIn),
    .ConfigOut(buff6Enable__ConfigOut),
    .Config_Clock(buff6Enable__Config_Clock),
    .Config_Reset(buff6Enable__Config_Reset),
    .select(buff6Enable__select),
    .stop(buff6Enable__stop),
    .valid(buff6Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_7in_8out_size_32_U19)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__in6;
  wire [0:0] crossbar__in6_stop_upstream;
  wire [0:0] crossbar__in6_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  wire [31:0] crossbar__out7;
  wire [0:0] crossbar__out7_stop_downstream;
  wire [0:0] crossbar__out7_valid_downstream;
  elastic_crossbar_7in_8out_size_32_U19 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .in6(crossbar__in6),
    .in6_stop_upstream(crossbar__in6_stop_upstream),
    .in6_valid_upstream(crossbar__in6_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream),
    .out7(crossbar__out7),
    .out7_stop_downstream(crossbar__out7_stop_downstream),
    .out7_valid_downstream(crossbar__out7_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff5Enable__Config_Clock = Config_Clock;
  assign buff6Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff5Enable__Config_Reset = Config_Reset;
  assign buff6Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff5__CGRA_Clock = CGRA_Clock;
  assign buff6__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff5Enable__CGRA_Clock = CGRA_Clock;
  assign buff6Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff5__CGRA_Reset = CGRA_Reset;
  assign buff6__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff5Enable__CGRA_Reset = CGRA_Reset;
  assign buff6Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff5__CGRA_Enable = CGRA_Enable;
  assign buff6__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff5Enable__CGRA_Enable = CGRA_Enable;
  assign buff6Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out6_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out7_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in6[31:0] = buffOut__data_out[31:0];
  assign crossbar__in6_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff5__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buff6__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in6_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out5[31:0] = crossbar__out4[31:0];
  assign out5_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign out6[31:0] = crossbar__out5[31:0];
  assign out6_valid_downstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out6[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out7[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out7_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in5_stop_upstream[0:0] = buff5__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff5__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff5__data_out_valid_downstream[0:0];
  assign in6_stop_upstream[0:0] = buff6__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buff6__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buff6__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff5__data_in[31:0] = in5[31:0];
  assign buff5__data_in_valid_upstream[0:0] = in5_valid_upstream[0:0];
  assign buff6__data_in[31:0] = in6[31:0];
  assign buff6__data_in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out5_stop_downstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff5__enable[0:0] = buff5Enable__select[0:0];
  assign buff5Enable__valid[0:0] = buff5__enable_valid_upstream[0:0];
  assign buff5Enable__stop[0:0] = buff5__enable_stop_upstream[0:0];
  assign buff6__enable[0:0] = buff6Enable__select[0:0];
  assign buff6Enable__valid[0:0] = buff6__enable_valid_upstream[0:0];
  assign buff6Enable__stop[0:0] = buff6__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff5Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buff6Enable__ConfigIn = buff5Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff6Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in111_out111_default_U3

module elastic_riken_in31_out31_default_U10 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in4,
  output [0:0] in4_stop_upstream,
  input [0:0] in4_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out4,
  input [0:0] out4_stop_downstream,
  output [0:0] out4_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff4' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff4__CGRA_Clock;
  wire  buff4__CGRA_Enable;
  wire  buff4__CGRA_Reset;
  wire [31:0] buff4__data_in;
  wire [0:0] buff4__data_in_stop_upstream;
  wire [0:0] buff4__data_in_valid_upstream;
  wire [31:0] buff4__data_out;
  wire [0:0] buff4__data_out_stop_downstream;
  wire [0:0] buff4__data_out_valid_downstream;
  wire [0:0] buff4__enable;
  wire [0:0] buff4__enable_stop_upstream;
  wire [0:0] buff4__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff4(
    .CGRA_Clock(buff4__CGRA_Clock),
    .CGRA_Enable(buff4__CGRA_Enable),
    .CGRA_Reset(buff4__CGRA_Reset),
    .data_in(buff4__data_in),
    .data_in_stop_upstream(buff4__data_in_stop_upstream),
    .data_in_valid_upstream(buff4__data_in_valid_upstream),
    .data_out(buff4__data_out),
    .data_out_stop_downstream(buff4__data_out_stop_downstream),
    .data_out_valid_downstream(buff4__data_out_valid_downstream),
    .enable(buff4__enable),
    .enable_stop_upstream(buff4__enable_stop_upstream),
    .enable_valid_upstream(buff4__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff4Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff4Enable__CGRA_Clock;
  wire  buff4Enable__CGRA_Enable;
  wire  buff4Enable__CGRA_Reset;
  wire  buff4Enable__ConfigIn;
  wire  buff4Enable__ConfigOut;
  wire  buff4Enable__Config_Clock;
  wire  buff4Enable__Config_Reset;
  wire [0:0] buff4Enable__select;
  wire [0:0] buff4Enable__stop;
  wire [0:0] buff4Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff4Enable(
    .CGRA_Clock(buff4Enable__CGRA_Clock),
    .CGRA_Enable(buff4Enable__CGRA_Enable),
    .CGRA_Reset(buff4Enable__CGRA_Reset),
    .ConfigIn(buff4Enable__ConfigIn),
    .ConfigOut(buff4Enable__ConfigOut),
    .Config_Clock(buff4Enable__Config_Clock),
    .Config_Reset(buff4Enable__Config_Reset),
    .select(buff4Enable__select),
    .stop(buff4Enable__stop),
    .valid(buff4Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_6in_7out_size_32_U21)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  elastic_crossbar_6in_7out_size_32_U21 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff4Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff4Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff4__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff4Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff4__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff4Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff4__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff4Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out5_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out6_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buffOut__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff4__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out4[31:0] = crossbar__out4[31:0];
  assign out4_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out5[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out6[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in4_stop_upstream[0:0] = buff4__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff4__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff4__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff4__data_in[31:0] = in4[31:0];
  assign buff4__data_in_valid_upstream[0:0] = in4_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out4_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff4__enable[0:0] = buff4Enable__select[0:0];
  assign buff4Enable__valid[0:0] = buff4__enable_valid_upstream[0:0];
  assign buff4Enable__stop[0:0] = buff4__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff4Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff4Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in31_out31_default_U10

module elastic_riken_in79_out79_default_U2 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff6' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff6__CGRA_Clock;
  wire  buff6__CGRA_Enable;
  wire  buff6__CGRA_Reset;
  wire [31:0] buff6__data_in;
  wire [0:0] buff6__data_in_stop_upstream;
  wire [0:0] buff6__data_in_valid_upstream;
  wire [31:0] buff6__data_out;
  wire [0:0] buff6__data_out_stop_downstream;
  wire [0:0] buff6__data_out_valid_downstream;
  wire [0:0] buff6__enable;
  wire [0:0] buff6__enable_stop_upstream;
  wire [0:0] buff6__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff6(
    .CGRA_Clock(buff6__CGRA_Clock),
    .CGRA_Enable(buff6__CGRA_Enable),
    .CGRA_Reset(buff6__CGRA_Reset),
    .data_in(buff6__data_in),
    .data_in_stop_upstream(buff6__data_in_stop_upstream),
    .data_in_valid_upstream(buff6__data_in_valid_upstream),
    .data_out(buff6__data_out),
    .data_out_stop_downstream(buff6__data_out_stop_downstream),
    .data_out_valid_downstream(buff6__data_out_valid_downstream),
    .enable(buff6__enable),
    .enable_stop_upstream(buff6__enable_stop_upstream),
    .enable_valid_upstream(buff6__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff6Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff6Enable__CGRA_Clock;
  wire  buff6Enable__CGRA_Enable;
  wire  buff6Enable__CGRA_Reset;
  wire  buff6Enable__ConfigIn;
  wire  buff6Enable__ConfigOut;
  wire  buff6Enable__Config_Clock;
  wire  buff6Enable__Config_Reset;
  wire [0:0] buff6Enable__select;
  wire [0:0] buff6Enable__stop;
  wire [0:0] buff6Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff6Enable(
    .CGRA_Clock(buff6Enable__CGRA_Clock),
    .CGRA_Enable(buff6Enable__CGRA_Enable),
    .CGRA_Reset(buff6Enable__CGRA_Reset),
    .ConfigIn(buff6Enable__ConfigIn),
    .ConfigOut(buff6Enable__ConfigOut),
    .Config_Clock(buff6Enable__Config_Clock),
    .Config_Reset(buff6Enable__Config_Reset),
    .select(buff6Enable__select),
    .stop(buff6Enable__stop),
    .valid(buff6Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_6in_7out_size_32_U21)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  elastic_crossbar_6in_7out_size_32_U21 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff6Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff6Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff6__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff6Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff6__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff6Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff6__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff6Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign crossbar__out6_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buffOut__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff6__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out6[31:0] = crossbar__out4[31:0];
  assign out6_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out5[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out6[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in6_stop_upstream[0:0] = buff6__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff6__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff6__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff6__data_in[31:0] = in6[31:0];
  assign buff6__data_in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff6__enable[0:0] = buff6Enable__select[0:0];
  assign buff6Enable__valid[0:0] = buff6__enable_valid_upstream[0:0];
  assign buff6Enable__stop[0:0] = buff6__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff6Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff6Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in79_out79_default_U2

module elastic_riken_in207_out207_default_U5 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] in0,
  output [0:0] in0_stop_upstream,
  input [0:0] in0_valid_upstream,
  input [31:0] in1,
  output [0:0] in1_stop_upstream,
  input [0:0] in1_valid_upstream,
  input [31:0] in2,
  output [0:0] in2_stop_upstream,
  input [0:0] in2_valid_upstream,
  input [31:0] in3,
  output [0:0] in3_stop_upstream,
  input [0:0] in3_valid_upstream,
  input [31:0] in6,
  output [0:0] in6_stop_upstream,
  input [0:0] in6_valid_upstream,
  input [31:0] in7,
  output [0:0] in7_stop_upstream,
  input [0:0] in7_valid_upstream,
  output [31:0] out0,
  input [0:0] out0_stop_downstream,
  output [0:0] out0_valid_downstream,
  output [31:0] out1,
  input [0:0] out1_stop_downstream,
  output [0:0] out1_valid_downstream,
  output [31:0] out2,
  input [0:0] out2_stop_downstream,
  output [0:0] out2_valid_downstream,
  output [31:0] out3,
  input [0:0] out3_stop_downstream,
  output [0:0] out3_valid_downstream,
  output [31:0] out6,
  input [0:0] out6_stop_downstream,
  output [0:0] out6_valid_downstream,
  output [31:0] out7,
  input [0:0] out7_stop_downstream,
  output [0:0] out7_valid_downstream
);
  //Wire declarations for instance 'ALUMuxAconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxAconfig__CGRA_Clock;
  wire  ALUMuxAconfig__CGRA_Enable;
  wire  ALUMuxAconfig__CGRA_Reset;
  wire  ALUMuxAconfig__ConfigIn;
  wire  ALUMuxAconfig__ConfigOut;
  wire  ALUMuxAconfig__Config_Clock;
  wire  ALUMuxAconfig__Config_Reset;
  wire [0:0] ALUMuxAconfig__select;
  wire [0:0] ALUMuxAconfig__stop;
  wire [0:0] ALUMuxAconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxAconfig(
    .CGRA_Clock(ALUMuxAconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxAconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxAconfig__CGRA_Reset),
    .ConfigIn(ALUMuxAconfig__ConfigIn),
    .ConfigOut(ALUMuxAconfig__ConfigOut),
    .Config_Clock(ALUMuxAconfig__Config_Clock),
    .Config_Reset(ALUMuxAconfig__Config_Reset),
    .select(ALUMuxAconfig__select),
    .stop(ALUMuxAconfig__stop),
    .valid(ALUMuxAconfig__valid)
  );

  //Wire declarations for instance 'ALUMuxBconfig' (Module cgrame_elastic_configcell_context_size1II1)
  wire  ALUMuxBconfig__CGRA_Clock;
  wire  ALUMuxBconfig__CGRA_Enable;
  wire  ALUMuxBconfig__CGRA_Reset;
  wire  ALUMuxBconfig__ConfigIn;
  wire  ALUMuxBconfig__ConfigOut;
  wire  ALUMuxBconfig__Config_Clock;
  wire  ALUMuxBconfig__Config_Reset;
  wire [0:0] ALUMuxBconfig__select;
  wire [0:0] ALUMuxBconfig__stop;
  wire [0:0] ALUMuxBconfig__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) ALUMuxBconfig(
    .CGRA_Clock(ALUMuxBconfig__CGRA_Clock),
    .CGRA_Enable(ALUMuxBconfig__CGRA_Enable),
    .CGRA_Reset(ALUMuxBconfig__CGRA_Reset),
    .ConfigIn(ALUMuxBconfig__ConfigIn),
    .ConfigOut(ALUMuxBconfig__ConfigOut),
    .Config_Clock(ALUMuxBconfig__Config_Clock),
    .Config_Reset(ALUMuxBconfig__Config_Reset),
    .select(ALUMuxBconfig__select),
    .stop(ALUMuxBconfig__stop),
    .valid(ALUMuxBconfig__valid)
  );

  //Wire declarations for instance 'ConstForkConfig' (Module cgrame_elastic_configcell_context_size2II1)
  wire  ConstForkConfig__CGRA_Clock;
  wire  ConstForkConfig__CGRA_Enable;
  wire  ConstForkConfig__CGRA_Reset;
  wire  ConstForkConfig__ConfigIn;
  wire  ConstForkConfig__ConfigOut;
  wire  ConstForkConfig__Config_Clock;
  wire  ConstForkConfig__Config_Reset;
  wire [1:0] ConstForkConfig__select;
  wire [0:0] ConstForkConfig__stop;
  wire [0:0] ConstForkConfig__valid;
  cgrame_elastic_configcell_context_size2II1 #(.contexts(1),.size(2)) ConstForkConfig(
    .CGRA_Clock(ConstForkConfig__CGRA_Clock),
    .CGRA_Enable(ConstForkConfig__CGRA_Enable),
    .CGRA_Reset(ConstForkConfig__CGRA_Reset),
    .ConfigIn(ConstForkConfig__ConfigIn),
    .ConfigOut(ConstForkConfig__ConfigOut),
    .Config_Clock(ConstForkConfig__Config_Clock),
    .Config_Reset(ConstForkConfig__Config_Reset),
    .select(ConstForkConfig__select),
    .stop(ConstForkConfig__stop),
    .valid(ConstForkConfig__valid)
  );

  //Wire declarations for instance 'EBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  EBEnable__CGRA_Clock;
  wire  EBEnable__CGRA_Enable;
  wire  EBEnable__CGRA_Reset;
  wire  EBEnable__ConfigIn;
  wire  EBEnable__ConfigOut;
  wire  EBEnable__Config_Clock;
  wire  EBEnable__Config_Reset;
  wire [0:0] EBEnable__select;
  wire [0:0] EBEnable__stop;
  wire [0:0] EBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) EBEnable(
    .CGRA_Clock(EBEnable__CGRA_Clock),
    .CGRA_Enable(EBEnable__CGRA_Enable),
    .CGRA_Reset(EBEnable__CGRA_Reset),
    .ConfigIn(EBEnable__ConfigIn),
    .ConfigOut(EBEnable__ConfigOut),
    .Config_Clock(EBEnable__Config_Clock),
    .Config_Reset(EBEnable__Config_Reset),
    .select(EBEnable__select),
    .stop(EBEnable__stop),
    .valid(EBEnable__valid)
  );

  //Wire declarations for instance 'FuncUnit' (Module elastic_fp_unit_FuncUnit_size_32_U15)
  wire  FuncUnit__CGRA_Clock;
  wire  FuncUnit__CGRA_Enable;
  wire  FuncUnit__CGRA_Reset;
  wire  FuncUnit__ConfigIn;
  wire  FuncUnit__ConfigOut;
  wire  FuncUnit__Config_Clock;
  wire  FuncUnit__Config_Reset;
  wire [31:0] FuncUnit__in_a;
  wire [0:0] FuncUnit__in_a_stop_upstream;
  wire [0:0] FuncUnit__in_a_valid_upstream;
  wire [31:0] FuncUnit__in_b;
  wire [0:0] FuncUnit__in_b_stop_upstream;
  wire [0:0] FuncUnit__in_b_valid_upstream;
  wire [31:0] FuncUnit__out;
  wire [0:0] FuncUnit__out_stop_downstream;
  wire [0:0] FuncUnit__out_valid_downstream;
  elastic_fp_unit_FuncUnit_size_32_U15 FuncUnit(
    .CGRA_Clock(FuncUnit__CGRA_Clock),
    .CGRA_Enable(FuncUnit__CGRA_Enable),
    .CGRA_Reset(FuncUnit__CGRA_Reset),
    .ConfigIn(FuncUnit__ConfigIn),
    .ConfigOut(FuncUnit__ConfigOut),
    .Config_Clock(FuncUnit__Config_Clock),
    .Config_Reset(FuncUnit__Config_Reset),
    .in_a(FuncUnit__in_a),
    .in_a_stop_upstream(FuncUnit__in_a_stop_upstream),
    .in_a_valid_upstream(FuncUnit__in_a_valid_upstream),
    .in_b(FuncUnit__in_b),
    .in_b_stop_upstream(FuncUnit__in_b_stop_upstream),
    .in_b_valid_upstream(FuncUnit__in_b_valid_upstream),
    .out(FuncUnit__out),
    .out_stop_downstream(FuncUnit__out_stop_downstream),
    .out_valid_downstream(FuncUnit__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm' (Module elastic_const_32b_U16)
  wire  Imm__CGRA_Clock;
  wire  Imm__CGRA_Enable;
  wire  Imm__CGRA_Reset;
  wire  Imm__ConfigIn;
  wire  Imm__ConfigOut;
  wire  Imm__Config_Clock;
  wire  Imm__Config_Reset;
  wire [31:0] Imm__out;
  wire [0:0] Imm__out_stop_downstream;
  wire [0:0] Imm__out_valid_downstream;
  elastic_const_32b_U16 Imm(
    .CGRA_Clock(Imm__CGRA_Clock),
    .CGRA_Enable(Imm__CGRA_Enable),
    .CGRA_Reset(Imm__CGRA_Reset),
    .ConfigIn(Imm__ConfigIn),
    .ConfigOut(Imm__ConfigOut),
    .Config_Clock(Imm__Config_Clock),
    .Config_Reset(Imm__Config_Reset),
    .out(Imm__out),
    .out_stop_downstream(Imm__out_stop_downstream),
    .out_valid_downstream(Imm__out_valid_downstream)
  );

  //Wire declarations for instance 'Imm_fork' (Module cgrame_elastic_eager_fork_1to2_size_32)
  wire  Imm_fork__CGRA_Clock;
  wire  Imm_fork__CGRA_Enable;
  wire  Imm_fork__CGRA_Reset;
  wire [1:0] Imm_fork__enable_downstream;
  wire [0:0] Imm_fork__enable_downstream_stop_upstream;
  wire [0:0] Imm_fork__enable_downstream_valid_upstream;
  wire [31:0] Imm_fork__in;
  wire [0:0] Imm_fork__in_stop_upstream;
  wire [0:0] Imm_fork__in_valid_upstream;
  wire [31:0] Imm_fork__out0;
  wire [0:0] Imm_fork__out0_stop_downstream;
  wire [0:0] Imm_fork__out0_valid_downstream;
  wire [31:0] Imm_fork__out1;
  wire [0:0] Imm_fork__out1_stop_downstream;
  wire [0:0] Imm_fork__out1_valid_downstream;
  cgrame_elastic_eager_fork_1to2_size_32 #(.contexts(1),.size(32)) Imm_fork(
    .CGRA_Clock(Imm_fork__CGRA_Clock),
    .CGRA_Enable(Imm_fork__CGRA_Enable),
    .CGRA_Reset(Imm_fork__CGRA_Reset),
    .enable_downstream(Imm_fork__enable_downstream),
    .enable_downstream_stop_upstream(Imm_fork__enable_downstream_stop_upstream),
    .enable_downstream_valid_upstream(Imm_fork__enable_downstream_valid_upstream),
    .in(Imm_fork__in),
    .in_stop_upstream(Imm_fork__in_stop_upstream),
    .in_valid_upstream(Imm_fork__in_valid_upstream),
    .out0(Imm_fork__out0),
    .out0_stop_downstream(Imm_fork__out0_stop_downstream),
    .out0_valid_downstream(Imm_fork__out0_valid_downstream),
    .out1(Imm_fork__out1),
    .out1_stop_downstream(Imm_fork__out1_stop_downstream),
    .out1_valid_downstream(Imm_fork__out1_valid_downstream)
  );

  //Wire declarations for instance 'buff0' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff0__CGRA_Clock;
  wire  buff0__CGRA_Enable;
  wire  buff0__CGRA_Reset;
  wire [31:0] buff0__data_in;
  wire [0:0] buff0__data_in_stop_upstream;
  wire [0:0] buff0__data_in_valid_upstream;
  wire [31:0] buff0__data_out;
  wire [0:0] buff0__data_out_stop_downstream;
  wire [0:0] buff0__data_out_valid_downstream;
  wire [0:0] buff0__enable;
  wire [0:0] buff0__enable_stop_upstream;
  wire [0:0] buff0__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff0(
    .CGRA_Clock(buff0__CGRA_Clock),
    .CGRA_Enable(buff0__CGRA_Enable),
    .CGRA_Reset(buff0__CGRA_Reset),
    .data_in(buff0__data_in),
    .data_in_stop_upstream(buff0__data_in_stop_upstream),
    .data_in_valid_upstream(buff0__data_in_valid_upstream),
    .data_out(buff0__data_out),
    .data_out_stop_downstream(buff0__data_out_stop_downstream),
    .data_out_valid_downstream(buff0__data_out_valid_downstream),
    .enable(buff0__enable),
    .enable_stop_upstream(buff0__enable_stop_upstream),
    .enable_valid_upstream(buff0__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff0Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff0Enable__CGRA_Clock;
  wire  buff0Enable__CGRA_Enable;
  wire  buff0Enable__CGRA_Reset;
  wire  buff0Enable__ConfigIn;
  wire  buff0Enable__ConfigOut;
  wire  buff0Enable__Config_Clock;
  wire  buff0Enable__Config_Reset;
  wire [0:0] buff0Enable__select;
  wire [0:0] buff0Enable__stop;
  wire [0:0] buff0Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff0Enable(
    .CGRA_Clock(buff0Enable__CGRA_Clock),
    .CGRA_Enable(buff0Enable__CGRA_Enable),
    .CGRA_Reset(buff0Enable__CGRA_Reset),
    .ConfigIn(buff0Enable__ConfigIn),
    .ConfigOut(buff0Enable__ConfigOut),
    .Config_Clock(buff0Enable__Config_Clock),
    .Config_Reset(buff0Enable__Config_Reset),
    .select(buff0Enable__select),
    .stop(buff0Enable__stop),
    .valid(buff0Enable__valid)
  );

  //Wire declarations for instance 'buff1' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff1__CGRA_Clock;
  wire  buff1__CGRA_Enable;
  wire  buff1__CGRA_Reset;
  wire [31:0] buff1__data_in;
  wire [0:0] buff1__data_in_stop_upstream;
  wire [0:0] buff1__data_in_valid_upstream;
  wire [31:0] buff1__data_out;
  wire [0:0] buff1__data_out_stop_downstream;
  wire [0:0] buff1__data_out_valid_downstream;
  wire [0:0] buff1__enable;
  wire [0:0] buff1__enable_stop_upstream;
  wire [0:0] buff1__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff1(
    .CGRA_Clock(buff1__CGRA_Clock),
    .CGRA_Enable(buff1__CGRA_Enable),
    .CGRA_Reset(buff1__CGRA_Reset),
    .data_in(buff1__data_in),
    .data_in_stop_upstream(buff1__data_in_stop_upstream),
    .data_in_valid_upstream(buff1__data_in_valid_upstream),
    .data_out(buff1__data_out),
    .data_out_stop_downstream(buff1__data_out_stop_downstream),
    .data_out_valid_downstream(buff1__data_out_valid_downstream),
    .enable(buff1__enable),
    .enable_stop_upstream(buff1__enable_stop_upstream),
    .enable_valid_upstream(buff1__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff1Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff1Enable__CGRA_Clock;
  wire  buff1Enable__CGRA_Enable;
  wire  buff1Enable__CGRA_Reset;
  wire  buff1Enable__ConfigIn;
  wire  buff1Enable__ConfigOut;
  wire  buff1Enable__Config_Clock;
  wire  buff1Enable__Config_Reset;
  wire [0:0] buff1Enable__select;
  wire [0:0] buff1Enable__stop;
  wire [0:0] buff1Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff1Enable(
    .CGRA_Clock(buff1Enable__CGRA_Clock),
    .CGRA_Enable(buff1Enable__CGRA_Enable),
    .CGRA_Reset(buff1Enable__CGRA_Reset),
    .ConfigIn(buff1Enable__ConfigIn),
    .ConfigOut(buff1Enable__ConfigOut),
    .Config_Clock(buff1Enable__Config_Clock),
    .Config_Reset(buff1Enable__Config_Reset),
    .select(buff1Enable__select),
    .stop(buff1Enable__stop),
    .valid(buff1Enable__valid)
  );

  //Wire declarations for instance 'buff2' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff2__CGRA_Clock;
  wire  buff2__CGRA_Enable;
  wire  buff2__CGRA_Reset;
  wire [31:0] buff2__data_in;
  wire [0:0] buff2__data_in_stop_upstream;
  wire [0:0] buff2__data_in_valid_upstream;
  wire [31:0] buff2__data_out;
  wire [0:0] buff2__data_out_stop_downstream;
  wire [0:0] buff2__data_out_valid_downstream;
  wire [0:0] buff2__enable;
  wire [0:0] buff2__enable_stop_upstream;
  wire [0:0] buff2__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff2(
    .CGRA_Clock(buff2__CGRA_Clock),
    .CGRA_Enable(buff2__CGRA_Enable),
    .CGRA_Reset(buff2__CGRA_Reset),
    .data_in(buff2__data_in),
    .data_in_stop_upstream(buff2__data_in_stop_upstream),
    .data_in_valid_upstream(buff2__data_in_valid_upstream),
    .data_out(buff2__data_out),
    .data_out_stop_downstream(buff2__data_out_stop_downstream),
    .data_out_valid_downstream(buff2__data_out_valid_downstream),
    .enable(buff2__enable),
    .enable_stop_upstream(buff2__enable_stop_upstream),
    .enable_valid_upstream(buff2__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff2Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff2Enable__CGRA_Clock;
  wire  buff2Enable__CGRA_Enable;
  wire  buff2Enable__CGRA_Reset;
  wire  buff2Enable__ConfigIn;
  wire  buff2Enable__ConfigOut;
  wire  buff2Enable__Config_Clock;
  wire  buff2Enable__Config_Reset;
  wire [0:0] buff2Enable__select;
  wire [0:0] buff2Enable__stop;
  wire [0:0] buff2Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff2Enable(
    .CGRA_Clock(buff2Enable__CGRA_Clock),
    .CGRA_Enable(buff2Enable__CGRA_Enable),
    .CGRA_Reset(buff2Enable__CGRA_Reset),
    .ConfigIn(buff2Enable__ConfigIn),
    .ConfigOut(buff2Enable__ConfigOut),
    .Config_Clock(buff2Enable__Config_Clock),
    .Config_Reset(buff2Enable__Config_Reset),
    .select(buff2Enable__select),
    .stop(buff2Enable__stop),
    .valid(buff2Enable__valid)
  );

  //Wire declarations for instance 'buff3' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff3__CGRA_Clock;
  wire  buff3__CGRA_Enable;
  wire  buff3__CGRA_Reset;
  wire [31:0] buff3__data_in;
  wire [0:0] buff3__data_in_stop_upstream;
  wire [0:0] buff3__data_in_valid_upstream;
  wire [31:0] buff3__data_out;
  wire [0:0] buff3__data_out_stop_downstream;
  wire [0:0] buff3__data_out_valid_downstream;
  wire [0:0] buff3__enable;
  wire [0:0] buff3__enable_stop_upstream;
  wire [0:0] buff3__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff3(
    .CGRA_Clock(buff3__CGRA_Clock),
    .CGRA_Enable(buff3__CGRA_Enable),
    .CGRA_Reset(buff3__CGRA_Reset),
    .data_in(buff3__data_in),
    .data_in_stop_upstream(buff3__data_in_stop_upstream),
    .data_in_valid_upstream(buff3__data_in_valid_upstream),
    .data_out(buff3__data_out),
    .data_out_stop_downstream(buff3__data_out_stop_downstream),
    .data_out_valid_downstream(buff3__data_out_valid_downstream),
    .enable(buff3__enable),
    .enable_stop_upstream(buff3__enable_stop_upstream),
    .enable_valid_upstream(buff3__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff3Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff3Enable__CGRA_Clock;
  wire  buff3Enable__CGRA_Enable;
  wire  buff3Enable__CGRA_Reset;
  wire  buff3Enable__ConfigIn;
  wire  buff3Enable__ConfigOut;
  wire  buff3Enable__Config_Clock;
  wire  buff3Enable__Config_Reset;
  wire [0:0] buff3Enable__select;
  wire [0:0] buff3Enable__stop;
  wire [0:0] buff3Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff3Enable(
    .CGRA_Clock(buff3Enable__CGRA_Clock),
    .CGRA_Enable(buff3Enable__CGRA_Enable),
    .CGRA_Reset(buff3Enable__CGRA_Reset),
    .ConfigIn(buff3Enable__ConfigIn),
    .ConfigOut(buff3Enable__ConfigOut),
    .Config_Clock(buff3Enable__Config_Clock),
    .Config_Reset(buff3Enable__Config_Reset),
    .select(buff3Enable__select),
    .stop(buff3Enable__stop),
    .valid(buff3Enable__valid)
  );

  //Wire declarations for instance 'buff6' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff6__CGRA_Clock;
  wire  buff6__CGRA_Enable;
  wire  buff6__CGRA_Reset;
  wire [31:0] buff6__data_in;
  wire [0:0] buff6__data_in_stop_upstream;
  wire [0:0] buff6__data_in_valid_upstream;
  wire [31:0] buff6__data_out;
  wire [0:0] buff6__data_out_stop_downstream;
  wire [0:0] buff6__data_out_valid_downstream;
  wire [0:0] buff6__enable;
  wire [0:0] buff6__enable_stop_upstream;
  wire [0:0] buff6__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff6(
    .CGRA_Clock(buff6__CGRA_Clock),
    .CGRA_Enable(buff6__CGRA_Enable),
    .CGRA_Reset(buff6__CGRA_Reset),
    .data_in(buff6__data_in),
    .data_in_stop_upstream(buff6__data_in_stop_upstream),
    .data_in_valid_upstream(buff6__data_in_valid_upstream),
    .data_out(buff6__data_out),
    .data_out_stop_downstream(buff6__data_out_stop_downstream),
    .data_out_valid_downstream(buff6__data_out_valid_downstream),
    .enable(buff6__enable),
    .enable_stop_upstream(buff6__enable_stop_upstream),
    .enable_valid_upstream(buff6__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff6Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff6Enable__CGRA_Clock;
  wire  buff6Enable__CGRA_Enable;
  wire  buff6Enable__CGRA_Reset;
  wire  buff6Enable__ConfigIn;
  wire  buff6Enable__ConfigOut;
  wire  buff6Enable__Config_Clock;
  wire  buff6Enable__Config_Reset;
  wire [0:0] buff6Enable__select;
  wire [0:0] buff6Enable__stop;
  wire [0:0] buff6Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff6Enable(
    .CGRA_Clock(buff6Enable__CGRA_Clock),
    .CGRA_Enable(buff6Enable__CGRA_Enable),
    .CGRA_Reset(buff6Enable__CGRA_Reset),
    .ConfigIn(buff6Enable__ConfigIn),
    .ConfigOut(buff6Enable__ConfigOut),
    .Config_Clock(buff6Enable__Config_Clock),
    .Config_Reset(buff6Enable__Config_Reset),
    .select(buff6Enable__select),
    .stop(buff6Enable__stop),
    .valid(buff6Enable__valid)
  );

  //Wire declarations for instance 'buff7' (Module cgrame_elastic_buffer_enable_32b)
  wire  buff7__CGRA_Clock;
  wire  buff7__CGRA_Enable;
  wire  buff7__CGRA_Reset;
  wire [31:0] buff7__data_in;
  wire [0:0] buff7__data_in_stop_upstream;
  wire [0:0] buff7__data_in_valid_upstream;
  wire [31:0] buff7__data_out;
  wire [0:0] buff7__data_out_stop_downstream;
  wire [0:0] buff7__data_out_valid_downstream;
  wire [0:0] buff7__enable;
  wire [0:0] buff7__enable_stop_upstream;
  wire [0:0] buff7__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buff7(
    .CGRA_Clock(buff7__CGRA_Clock),
    .CGRA_Enable(buff7__CGRA_Enable),
    .CGRA_Reset(buff7__CGRA_Reset),
    .data_in(buff7__data_in),
    .data_in_stop_upstream(buff7__data_in_stop_upstream),
    .data_in_valid_upstream(buff7__data_in_valid_upstream),
    .data_out(buff7__data_out),
    .data_out_stop_downstream(buff7__data_out_stop_downstream),
    .data_out_valid_downstream(buff7__data_out_valid_downstream),
    .enable(buff7__enable),
    .enable_stop_upstream(buff7__enable_stop_upstream),
    .enable_valid_upstream(buff7__enable_valid_upstream)
  );

  //Wire declarations for instance 'buff7Enable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buff7Enable__CGRA_Clock;
  wire  buff7Enable__CGRA_Enable;
  wire  buff7Enable__CGRA_Reset;
  wire  buff7Enable__ConfigIn;
  wire  buff7Enable__ConfigOut;
  wire  buff7Enable__Config_Clock;
  wire  buff7Enable__Config_Reset;
  wire [0:0] buff7Enable__select;
  wire [0:0] buff7Enable__stop;
  wire [0:0] buff7Enable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buff7Enable(
    .CGRA_Clock(buff7Enable__CGRA_Clock),
    .CGRA_Enable(buff7Enable__CGRA_Enable),
    .CGRA_Reset(buff7Enable__CGRA_Reset),
    .ConfigIn(buff7Enable__ConfigIn),
    .ConfigOut(buff7Enable__ConfigOut),
    .Config_Clock(buff7Enable__Config_Clock),
    .Config_Reset(buff7Enable__Config_Reset),
    .select(buff7Enable__select),
    .stop(buff7Enable__stop),
    .valid(buff7Enable__valid)
  );

  //Wire declarations for instance 'buffA' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffA__CGRA_Clock;
  wire  buffA__CGRA_Enable;
  wire  buffA__CGRA_Reset;
  wire [31:0] buffA__data_in;
  wire [0:0] buffA__data_in_stop_upstream;
  wire [0:0] buffA__data_in_valid_upstream;
  wire [31:0] buffA__data_out;
  wire [0:0] buffA__data_out_stop_downstream;
  wire [0:0] buffA__data_out_valid_downstream;
  wire [0:0] buffA__enable;
  wire [0:0] buffA__enable_stop_upstream;
  wire [0:0] buffA__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffA(
    .CGRA_Clock(buffA__CGRA_Clock),
    .CGRA_Enable(buffA__CGRA_Enable),
    .CGRA_Reset(buffA__CGRA_Reset),
    .data_in(buffA__data_in),
    .data_in_stop_upstream(buffA__data_in_stop_upstream),
    .data_in_valid_upstream(buffA__data_in_valid_upstream),
    .data_out(buffA__data_out),
    .data_out_stop_downstream(buffA__data_out_stop_downstream),
    .data_out_valid_downstream(buffA__data_out_valid_downstream),
    .enable(buffA__enable),
    .enable_stop_upstream(buffA__enable_stop_upstream),
    .enable_valid_upstream(buffA__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffAEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffAEnable__CGRA_Clock;
  wire  buffAEnable__CGRA_Enable;
  wire  buffAEnable__CGRA_Reset;
  wire  buffAEnable__ConfigIn;
  wire  buffAEnable__ConfigOut;
  wire  buffAEnable__Config_Clock;
  wire  buffAEnable__Config_Reset;
  wire [0:0] buffAEnable__select;
  wire [0:0] buffAEnable__stop;
  wire [0:0] buffAEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffAEnable(
    .CGRA_Clock(buffAEnable__CGRA_Clock),
    .CGRA_Enable(buffAEnable__CGRA_Enable),
    .CGRA_Reset(buffAEnable__CGRA_Reset),
    .ConfigIn(buffAEnable__ConfigIn),
    .ConfigOut(buffAEnable__ConfigOut),
    .Config_Clock(buffAEnable__Config_Clock),
    .Config_Reset(buffAEnable__Config_Reset),
    .select(buffAEnable__select),
    .stop(buffAEnable__stop),
    .valid(buffAEnable__valid)
  );

  //Wire declarations for instance 'buffB' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffB__CGRA_Clock;
  wire  buffB__CGRA_Enable;
  wire  buffB__CGRA_Reset;
  wire [31:0] buffB__data_in;
  wire [0:0] buffB__data_in_stop_upstream;
  wire [0:0] buffB__data_in_valid_upstream;
  wire [31:0] buffB__data_out;
  wire [0:0] buffB__data_out_stop_downstream;
  wire [0:0] buffB__data_out_valid_downstream;
  wire [0:0] buffB__enable;
  wire [0:0] buffB__enable_stop_upstream;
  wire [0:0] buffB__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffB(
    .CGRA_Clock(buffB__CGRA_Clock),
    .CGRA_Enable(buffB__CGRA_Enable),
    .CGRA_Reset(buffB__CGRA_Reset),
    .data_in(buffB__data_in),
    .data_in_stop_upstream(buffB__data_in_stop_upstream),
    .data_in_valid_upstream(buffB__data_in_valid_upstream),
    .data_out(buffB__data_out),
    .data_out_stop_downstream(buffB__data_out_stop_downstream),
    .data_out_valid_downstream(buffB__data_out_valid_downstream),
    .enable(buffB__enable),
    .enable_stop_upstream(buffB__enable_stop_upstream),
    .enable_valid_upstream(buffB__enable_valid_upstream)
  );

  //Wire declarations for instance 'buffBEnable' (Module cgrame_elastic_configcell_context_size1II1)
  wire  buffBEnable__CGRA_Clock;
  wire  buffBEnable__CGRA_Enable;
  wire  buffBEnable__CGRA_Reset;
  wire  buffBEnable__ConfigIn;
  wire  buffBEnable__ConfigOut;
  wire  buffBEnable__Config_Clock;
  wire  buffBEnable__Config_Reset;
  wire [0:0] buffBEnable__select;
  wire [0:0] buffBEnable__stop;
  wire [0:0] buffBEnable__valid;
  cgrame_elastic_configcell_context_size1II1 #(.contexts(1),.size(1)) buffBEnable(
    .CGRA_Clock(buffBEnable__CGRA_Clock),
    .CGRA_Enable(buffBEnable__CGRA_Enable),
    .CGRA_Reset(buffBEnable__CGRA_Reset),
    .ConfigIn(buffBEnable__ConfigIn),
    .ConfigOut(buffBEnable__ConfigOut),
    .Config_Clock(buffBEnable__Config_Clock),
    .Config_Reset(buffBEnable__Config_Reset),
    .select(buffBEnable__select),
    .stop(buffBEnable__stop),
    .valid(buffBEnable__valid)
  );

  //Wire declarations for instance 'buffOut' (Module cgrame_elastic_buffer_enable_32b)
  wire  buffOut__CGRA_Clock;
  wire  buffOut__CGRA_Enable;
  wire  buffOut__CGRA_Reset;
  wire [31:0] buffOut__data_in;
  wire [0:0] buffOut__data_in_stop_upstream;
  wire [0:0] buffOut__data_in_valid_upstream;
  wire [31:0] buffOut__data_out;
  wire [0:0] buffOut__data_out_stop_downstream;
  wire [0:0] buffOut__data_out_valid_downstream;
  wire [0:0] buffOut__enable;
  wire [0:0] buffOut__enable_stop_upstream;
  wire [0:0] buffOut__enable_valid_upstream;
  cgrame_elastic_buffer_enable_32b #(.contexts(1),.size(32)) buffOut(
    .CGRA_Clock(buffOut__CGRA_Clock),
    .CGRA_Enable(buffOut__CGRA_Enable),
    .CGRA_Reset(buffOut__CGRA_Reset),
    .data_in(buffOut__data_in),
    .data_in_stop_upstream(buffOut__data_in_stop_upstream),
    .data_in_valid_upstream(buffOut__data_in_valid_upstream),
    .data_out(buffOut__data_out),
    .data_out_stop_downstream(buffOut__data_out_stop_downstream),
    .data_out_valid_downstream(buffOut__data_out_valid_downstream),
    .enable(buffOut__enable),
    .enable_stop_upstream(buffOut__enable_stop_upstream),
    .enable_valid_upstream(buffOut__enable_valid_upstream)
  );

  //Wire declarations for instance 'crossbar' (Module elastic_crossbar_7in_8out_size_32_U19)
  wire  crossbar__CGRA_Clock;
  wire  crossbar__CGRA_Enable;
  wire  crossbar__CGRA_Reset;
  wire  crossbar__ConfigIn;
  wire  crossbar__ConfigOut;
  wire  crossbar__Config_Clock;
  wire  crossbar__Config_Reset;
  wire [31:0] crossbar__in0;
  wire [0:0] crossbar__in0_stop_upstream;
  wire [0:0] crossbar__in0_valid_upstream;
  wire [31:0] crossbar__in1;
  wire [0:0] crossbar__in1_stop_upstream;
  wire [0:0] crossbar__in1_valid_upstream;
  wire [31:0] crossbar__in2;
  wire [0:0] crossbar__in2_stop_upstream;
  wire [0:0] crossbar__in2_valid_upstream;
  wire [31:0] crossbar__in3;
  wire [0:0] crossbar__in3_stop_upstream;
  wire [0:0] crossbar__in3_valid_upstream;
  wire [31:0] crossbar__in4;
  wire [0:0] crossbar__in4_stop_upstream;
  wire [0:0] crossbar__in4_valid_upstream;
  wire [31:0] crossbar__in5;
  wire [0:0] crossbar__in5_stop_upstream;
  wire [0:0] crossbar__in5_valid_upstream;
  wire [31:0] crossbar__in6;
  wire [0:0] crossbar__in6_stop_upstream;
  wire [0:0] crossbar__in6_valid_upstream;
  wire [31:0] crossbar__out0;
  wire [0:0] crossbar__out0_stop_downstream;
  wire [0:0] crossbar__out0_valid_downstream;
  wire [31:0] crossbar__out1;
  wire [0:0] crossbar__out1_stop_downstream;
  wire [0:0] crossbar__out1_valid_downstream;
  wire [31:0] crossbar__out2;
  wire [0:0] crossbar__out2_stop_downstream;
  wire [0:0] crossbar__out2_valid_downstream;
  wire [31:0] crossbar__out3;
  wire [0:0] crossbar__out3_stop_downstream;
  wire [0:0] crossbar__out3_valid_downstream;
  wire [31:0] crossbar__out4;
  wire [0:0] crossbar__out4_stop_downstream;
  wire [0:0] crossbar__out4_valid_downstream;
  wire [31:0] crossbar__out5;
  wire [0:0] crossbar__out5_stop_downstream;
  wire [0:0] crossbar__out5_valid_downstream;
  wire [31:0] crossbar__out6;
  wire [0:0] crossbar__out6_stop_downstream;
  wire [0:0] crossbar__out6_valid_downstream;
  wire [31:0] crossbar__out7;
  wire [0:0] crossbar__out7_stop_downstream;
  wire [0:0] crossbar__out7_valid_downstream;
  elastic_crossbar_7in_8out_size_32_U19 crossbar(
    .CGRA_Clock(crossbar__CGRA_Clock),
    .CGRA_Enable(crossbar__CGRA_Enable),
    .CGRA_Reset(crossbar__CGRA_Reset),
    .ConfigIn(crossbar__ConfigIn),
    .ConfigOut(crossbar__ConfigOut),
    .Config_Clock(crossbar__Config_Clock),
    .Config_Reset(crossbar__Config_Reset),
    .in0(crossbar__in0),
    .in0_stop_upstream(crossbar__in0_stop_upstream),
    .in0_valid_upstream(crossbar__in0_valid_upstream),
    .in1(crossbar__in1),
    .in1_stop_upstream(crossbar__in1_stop_upstream),
    .in1_valid_upstream(crossbar__in1_valid_upstream),
    .in2(crossbar__in2),
    .in2_stop_upstream(crossbar__in2_stop_upstream),
    .in2_valid_upstream(crossbar__in2_valid_upstream),
    .in3(crossbar__in3),
    .in3_stop_upstream(crossbar__in3_stop_upstream),
    .in3_valid_upstream(crossbar__in3_valid_upstream),
    .in4(crossbar__in4),
    .in4_stop_upstream(crossbar__in4_stop_upstream),
    .in4_valid_upstream(crossbar__in4_valid_upstream),
    .in5(crossbar__in5),
    .in5_stop_upstream(crossbar__in5_stop_upstream),
    .in5_valid_upstream(crossbar__in5_valid_upstream),
    .in6(crossbar__in6),
    .in6_stop_upstream(crossbar__in6_stop_upstream),
    .in6_valid_upstream(crossbar__in6_valid_upstream),
    .out0(crossbar__out0),
    .out0_stop_downstream(crossbar__out0_stop_downstream),
    .out0_valid_downstream(crossbar__out0_valid_downstream),
    .out1(crossbar__out1),
    .out1_stop_downstream(crossbar__out1_stop_downstream),
    .out1_valid_downstream(crossbar__out1_valid_downstream),
    .out2(crossbar__out2),
    .out2_stop_downstream(crossbar__out2_stop_downstream),
    .out2_valid_downstream(crossbar__out2_valid_downstream),
    .out3(crossbar__out3),
    .out3_stop_downstream(crossbar__out3_stop_downstream),
    .out3_valid_downstream(crossbar__out3_valid_downstream),
    .out4(crossbar__out4),
    .out4_stop_downstream(crossbar__out4_stop_downstream),
    .out4_valid_downstream(crossbar__out4_valid_downstream),
    .out5(crossbar__out5),
    .out5_stop_downstream(crossbar__out5_stop_downstream),
    .out5_valid_downstream(crossbar__out5_valid_downstream),
    .out6(crossbar__out6),
    .out6_stop_downstream(crossbar__out6_stop_downstream),
    .out6_valid_downstream(crossbar__out6_valid_downstream),
    .out7(crossbar__out7),
    .out7_stop_downstream(crossbar__out7_stop_downstream),
    .out7_valid_downstream(crossbar__out7_valid_downstream)
  );

  //Wire declarations for instance 'muxA' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxA__in0;
  wire [0:0] muxA__in0_stop_upstream;
  wire [0:0] muxA__in0_valid_upstream;
  wire [31:0] muxA__in1;
  wire [0:0] muxA__in1_stop_upstream;
  wire [0:0] muxA__in1_valid_upstream;
  wire [31:0] muxA__out;
  wire [0:0] muxA__out_stop_downstream;
  wire [0:0] muxA__out_valid_downstream;
  wire [0:0] muxA__select;
  wire [0:0] muxA__select_stop_upstream;
  wire [0:0] muxA__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxA(
    .in0(muxA__in0),
    .in0_stop_upstream(muxA__in0_stop_upstream),
    .in0_valid_upstream(muxA__in0_valid_upstream),
    .in1(muxA__in1),
    .in1_stop_upstream(muxA__in1_stop_upstream),
    .in1_valid_upstream(muxA__in1_valid_upstream),
    .out(muxA__out),
    .out_stop_downstream(muxA__out_stop_downstream),
    .out_valid_downstream(muxA__out_valid_downstream),
    .select(muxA__select),
    .select_stop_upstream(muxA__select_stop_upstream),
    .select_valid_upstream(muxA__select_valid_upstream)
  );

  //Wire declarations for instance 'muxB' (Module cgrame_elastic_mux_2to1_32b)
  wire [31:0] muxB__in0;
  wire [0:0] muxB__in0_stop_upstream;
  wire [0:0] muxB__in0_valid_upstream;
  wire [31:0] muxB__in1;
  wire [0:0] muxB__in1_stop_upstream;
  wire [0:0] muxB__in1_valid_upstream;
  wire [31:0] muxB__out;
  wire [0:0] muxB__out_stop_downstream;
  wire [0:0] muxB__out_valid_downstream;
  wire [0:0] muxB__select;
  wire [0:0] muxB__select_stop_upstream;
  wire [0:0] muxB__select_valid_upstream;
  cgrame_elastic_mux_2to1_32b #(.contexts(1),.size(32)) muxB(
    .in0(muxB__in0),
    .in0_stop_upstream(muxB__in0_stop_upstream),
    .in0_valid_upstream(muxB__in0_valid_upstream),
    .in1(muxB__in1),
    .in1_stop_upstream(muxB__in1_stop_upstream),
    .in1_valid_upstream(muxB__in1_valid_upstream),
    .out(muxB__out),
    .out_stop_downstream(muxB__out_stop_downstream),
    .out_valid_downstream(muxB__out_valid_downstream),
    .select(muxB__select),
    .select_stop_upstream(muxB__select_stop_upstream),
    .select_valid_upstream(muxB__select_valid_upstream)
  );

  //All the connections
  assign FuncUnit__Config_Clock = Config_Clock;
  assign Imm__Config_Clock = Config_Clock;
  assign crossbar__Config_Clock = Config_Clock;
  assign ALUMuxAconfig__Config_Clock = Config_Clock;
  assign ALUMuxBconfig__Config_Clock = Config_Clock;
  assign ConstForkConfig__Config_Clock = Config_Clock;
  assign EBEnable__Config_Clock = Config_Clock;
  assign buff0Enable__Config_Clock = Config_Clock;
  assign buff1Enable__Config_Clock = Config_Clock;
  assign buff2Enable__Config_Clock = Config_Clock;
  assign buff3Enable__Config_Clock = Config_Clock;
  assign buff6Enable__Config_Clock = Config_Clock;
  assign buff7Enable__Config_Clock = Config_Clock;
  assign buffAEnable__Config_Clock = Config_Clock;
  assign buffBEnable__Config_Clock = Config_Clock;
  assign FuncUnit__Config_Reset = Config_Reset;
  assign Imm__Config_Reset = Config_Reset;
  assign crossbar__Config_Reset = Config_Reset;
  assign ALUMuxAconfig__Config_Reset = Config_Reset;
  assign ALUMuxBconfig__Config_Reset = Config_Reset;
  assign ConstForkConfig__Config_Reset = Config_Reset;
  assign EBEnable__Config_Reset = Config_Reset;
  assign buff0Enable__Config_Reset = Config_Reset;
  assign buff1Enable__Config_Reset = Config_Reset;
  assign buff2Enable__Config_Reset = Config_Reset;
  assign buff3Enable__Config_Reset = Config_Reset;
  assign buff6Enable__Config_Reset = Config_Reset;
  assign buff7Enable__Config_Reset = Config_Reset;
  assign buffAEnable__Config_Reset = Config_Reset;
  assign buffBEnable__Config_Reset = Config_Reset;
  assign FuncUnit__CGRA_Clock = CGRA_Clock;
  assign Imm__CGRA_Clock = CGRA_Clock;
  assign Imm_fork__CGRA_Clock = CGRA_Clock;
  assign buff0__CGRA_Clock = CGRA_Clock;
  assign buff1__CGRA_Clock = CGRA_Clock;
  assign buff2__CGRA_Clock = CGRA_Clock;
  assign buff3__CGRA_Clock = CGRA_Clock;
  assign buff6__CGRA_Clock = CGRA_Clock;
  assign buff7__CGRA_Clock = CGRA_Clock;
  assign buffA__CGRA_Clock = CGRA_Clock;
  assign buffB__CGRA_Clock = CGRA_Clock;
  assign buffOut__CGRA_Clock = CGRA_Clock;
  assign crossbar__CGRA_Clock = CGRA_Clock;
  assign ALUMuxAconfig__CGRA_Clock = CGRA_Clock;
  assign ALUMuxBconfig__CGRA_Clock = CGRA_Clock;
  assign ConstForkConfig__CGRA_Clock = CGRA_Clock;
  assign EBEnable__CGRA_Clock = CGRA_Clock;
  assign buff0Enable__CGRA_Clock = CGRA_Clock;
  assign buff1Enable__CGRA_Clock = CGRA_Clock;
  assign buff2Enable__CGRA_Clock = CGRA_Clock;
  assign buff3Enable__CGRA_Clock = CGRA_Clock;
  assign buff6Enable__CGRA_Clock = CGRA_Clock;
  assign buff7Enable__CGRA_Clock = CGRA_Clock;
  assign buffAEnable__CGRA_Clock = CGRA_Clock;
  assign buffBEnable__CGRA_Clock = CGRA_Clock;
  assign FuncUnit__CGRA_Reset = CGRA_Reset;
  assign Imm__CGRA_Reset = CGRA_Reset;
  assign Imm_fork__CGRA_Reset = CGRA_Reset;
  assign buff0__CGRA_Reset = CGRA_Reset;
  assign buff1__CGRA_Reset = CGRA_Reset;
  assign buff2__CGRA_Reset = CGRA_Reset;
  assign buff3__CGRA_Reset = CGRA_Reset;
  assign buff6__CGRA_Reset = CGRA_Reset;
  assign buff7__CGRA_Reset = CGRA_Reset;
  assign buffA__CGRA_Reset = CGRA_Reset;
  assign buffB__CGRA_Reset = CGRA_Reset;
  assign buffOut__CGRA_Reset = CGRA_Reset;
  assign crossbar__CGRA_Reset = CGRA_Reset;
  assign ALUMuxAconfig__CGRA_Reset = CGRA_Reset;
  assign ALUMuxBconfig__CGRA_Reset = CGRA_Reset;
  assign ConstForkConfig__CGRA_Reset = CGRA_Reset;
  assign EBEnable__CGRA_Reset = CGRA_Reset;
  assign buff0Enable__CGRA_Reset = CGRA_Reset;
  assign buff1Enable__CGRA_Reset = CGRA_Reset;
  assign buff2Enable__CGRA_Reset = CGRA_Reset;
  assign buff3Enable__CGRA_Reset = CGRA_Reset;
  assign buff6Enable__CGRA_Reset = CGRA_Reset;
  assign buff7Enable__CGRA_Reset = CGRA_Reset;
  assign buffAEnable__CGRA_Reset = CGRA_Reset;
  assign buffBEnable__CGRA_Reset = CGRA_Reset;
  assign FuncUnit__CGRA_Enable = CGRA_Enable;
  assign Imm__CGRA_Enable = CGRA_Enable;
  assign Imm_fork__CGRA_Enable = CGRA_Enable;
  assign buff0__CGRA_Enable = CGRA_Enable;
  assign buff1__CGRA_Enable = CGRA_Enable;
  assign buff2__CGRA_Enable = CGRA_Enable;
  assign buff3__CGRA_Enable = CGRA_Enable;
  assign buff6__CGRA_Enable = CGRA_Enable;
  assign buff7__CGRA_Enable = CGRA_Enable;
  assign buffA__CGRA_Enable = CGRA_Enable;
  assign buffB__CGRA_Enable = CGRA_Enable;
  assign buffOut__CGRA_Enable = CGRA_Enable;
  assign crossbar__CGRA_Enable = CGRA_Enable;
  assign ALUMuxAconfig__CGRA_Enable = CGRA_Enable;
  assign ALUMuxBconfig__CGRA_Enable = CGRA_Enable;
  assign ConstForkConfig__CGRA_Enable = CGRA_Enable;
  assign EBEnable__CGRA_Enable = CGRA_Enable;
  assign buff0Enable__CGRA_Enable = CGRA_Enable;
  assign buff1Enable__CGRA_Enable = CGRA_Enable;
  assign buff2Enable__CGRA_Enable = CGRA_Enable;
  assign buff3Enable__CGRA_Enable = CGRA_Enable;
  assign buff6Enable__CGRA_Enable = CGRA_Enable;
  assign buff7Enable__CGRA_Enable = CGRA_Enable;
  assign buffAEnable__CGRA_Enable = CGRA_Enable;
  assign buffBEnable__CGRA_Enable = CGRA_Enable;
  assign crossbar__out6_stop_downstream[0:0] = buffA__data_in_stop_upstream[0:0];
  assign muxA__in0[31:0] = buffA__data_out[31:0];
  assign muxA__in0_valid_upstream[0:0] = buffA__data_out_valid_downstream[0:0];
  assign crossbar__out7_stop_downstream[0:0] = buffB__data_in_stop_upstream[0:0];
  assign muxB__in0[31:0] = buffB__data_out[31:0];
  assign muxB__in0_valid_upstream[0:0] = buffB__data_out_valid_downstream[0:0];
  assign Imm_fork__in[31:0] = Imm__out[31:0];
  assign Imm_fork__in_valid_upstream[0:0] = Imm__out_valid_downstream[0:0];
  assign Imm__out_stop_downstream[0:0] = Imm_fork__in_stop_upstream[0:0];
  assign muxA__in1[31:0] = Imm_fork__out0[31:0];
  assign muxA__in1_valid_upstream[0:0] = Imm_fork__out0_valid_downstream[0:0];
  assign muxB__in1[31:0] = Imm_fork__out1[31:0];
  assign muxB__in1_valid_upstream[0:0] = Imm_fork__out1_valid_downstream[0:0];
  assign buffA__data_out_stop_downstream[0:0] = muxA__in0_stop_upstream[0:0];
  assign Imm_fork__out0_stop_downstream[0:0] = muxA__in1_stop_upstream[0:0];
  assign FuncUnit__in_a[31:0] = muxA__out[31:0];
  assign FuncUnit__in_a_valid_upstream[0:0] = muxA__out_valid_downstream[0:0];
  assign buffB__data_out_stop_downstream[0:0] = muxB__in0_stop_upstream[0:0];
  assign Imm_fork__out1_stop_downstream[0:0] = muxB__in1_stop_upstream[0:0];
  assign FuncUnit__in_b[31:0] = muxB__out[31:0];
  assign FuncUnit__in_b_valid_upstream[0:0] = muxB__out_valid_downstream[0:0];
  assign FuncUnit__out_stop_downstream[0:0] = buffOut__data_in_stop_upstream[0:0];
  assign crossbar__in6[31:0] = buffOut__data_out[31:0];
  assign crossbar__in6_valid_upstream[0:0] = buffOut__data_out_valid_downstream[0:0];
  assign muxA__out_stop_downstream[0:0] = FuncUnit__in_a_stop_upstream[0:0];
  assign muxB__out_stop_downstream[0:0] = FuncUnit__in_b_stop_upstream[0:0];
  assign buffOut__data_in[31:0] = FuncUnit__out[31:0];
  assign buffOut__data_in_valid_upstream[0:0] = FuncUnit__out_valid_downstream[0:0];
  assign buff0__data_out_stop_downstream[0:0] = crossbar__in0_stop_upstream[0:0];
  assign buff1__data_out_stop_downstream[0:0] = crossbar__in1_stop_upstream[0:0];
  assign buff2__data_out_stop_downstream[0:0] = crossbar__in2_stop_upstream[0:0];
  assign buff3__data_out_stop_downstream[0:0] = crossbar__in3_stop_upstream[0:0];
  assign buff6__data_out_stop_downstream[0:0] = crossbar__in4_stop_upstream[0:0];
  assign buff7__data_out_stop_downstream[0:0] = crossbar__in5_stop_upstream[0:0];
  assign buffOut__data_out_stop_downstream[0:0] = crossbar__in6_stop_upstream[0:0];
  assign out0[31:0] = crossbar__out0[31:0];
  assign out0_valid_downstream[0:0] = crossbar__out0_valid_downstream[0:0];
  assign out1[31:0] = crossbar__out1[31:0];
  assign out1_valid_downstream[0:0] = crossbar__out1_valid_downstream[0:0];
  assign out2[31:0] = crossbar__out2[31:0];
  assign out2_valid_downstream[0:0] = crossbar__out2_valid_downstream[0:0];
  assign out3[31:0] = crossbar__out3[31:0];
  assign out3_valid_downstream[0:0] = crossbar__out3_valid_downstream[0:0];
  assign out6[31:0] = crossbar__out4[31:0];
  assign out6_valid_downstream[0:0] = crossbar__out4_valid_downstream[0:0];
  assign out7[31:0] = crossbar__out5[31:0];
  assign out7_valid_downstream[0:0] = crossbar__out5_valid_downstream[0:0];
  assign buffA__data_in[31:0] = crossbar__out6[31:0];
  assign buffA__data_in_valid_upstream[0:0] = crossbar__out6_valid_downstream[0:0];
  assign buffB__data_in[31:0] = crossbar__out7[31:0];
  assign buffB__data_in_valid_upstream[0:0] = crossbar__out7_valid_downstream[0:0];
  assign in0_stop_upstream[0:0] = buff0__data_in_stop_upstream[0:0];
  assign crossbar__in0[31:0] = buff0__data_out[31:0];
  assign crossbar__in0_valid_upstream[0:0] = buff0__data_out_valid_downstream[0:0];
  assign in1_stop_upstream[0:0] = buff1__data_in_stop_upstream[0:0];
  assign crossbar__in1[31:0] = buff1__data_out[31:0];
  assign crossbar__in1_valid_upstream[0:0] = buff1__data_out_valid_downstream[0:0];
  assign in2_stop_upstream[0:0] = buff2__data_in_stop_upstream[0:0];
  assign crossbar__in2[31:0] = buff2__data_out[31:0];
  assign crossbar__in2_valid_upstream[0:0] = buff2__data_out_valid_downstream[0:0];
  assign in3_stop_upstream[0:0] = buff3__data_in_stop_upstream[0:0];
  assign crossbar__in3[31:0] = buff3__data_out[31:0];
  assign crossbar__in3_valid_upstream[0:0] = buff3__data_out_valid_downstream[0:0];
  assign in6_stop_upstream[0:0] = buff6__data_in_stop_upstream[0:0];
  assign crossbar__in4[31:0] = buff6__data_out[31:0];
  assign crossbar__in4_valid_upstream[0:0] = buff6__data_out_valid_downstream[0:0];
  assign in7_stop_upstream[0:0] = buff7__data_in_stop_upstream[0:0];
  assign crossbar__in5[31:0] = buff7__data_out[31:0];
  assign crossbar__in5_valid_upstream[0:0] = buff7__data_out_valid_downstream[0:0];
  assign buff0__data_in[31:0] = in0[31:0];
  assign buff0__data_in_valid_upstream[0:0] = in0_valid_upstream[0:0];
  assign buff1__data_in[31:0] = in1[31:0];
  assign buff1__data_in_valid_upstream[0:0] = in1_valid_upstream[0:0];
  assign buff2__data_in[31:0] = in2[31:0];
  assign buff2__data_in_valid_upstream[0:0] = in2_valid_upstream[0:0];
  assign buff3__data_in[31:0] = in3[31:0];
  assign buff3__data_in_valid_upstream[0:0] = in3_valid_upstream[0:0];
  assign buff6__data_in[31:0] = in6[31:0];
  assign buff6__data_in_valid_upstream[0:0] = in6_valid_upstream[0:0];
  assign buff7__data_in[31:0] = in7[31:0];
  assign buff7__data_in_valid_upstream[0:0] = in7_valid_upstream[0:0];
  assign crossbar__out0_stop_downstream[0:0] = out0_stop_downstream[0:0];
  assign crossbar__out1_stop_downstream[0:0] = out1_stop_downstream[0:0];
  assign crossbar__out2_stop_downstream[0:0] = out2_stop_downstream[0:0];
  assign crossbar__out3_stop_downstream[0:0] = out3_stop_downstream[0:0];
  assign crossbar__out4_stop_downstream[0:0] = out6_stop_downstream[0:0];
  assign crossbar__out5_stop_downstream[0:0] = out7_stop_downstream[0:0];
  assign muxA__select[0:0] = ALUMuxAconfig__select[0:0];
  assign ALUMuxAconfig__valid[0:0] = muxA__select_valid_upstream[0:0];
  assign ALUMuxAconfig__stop[0:0] = muxA__select_stop_upstream[0:0];
  assign muxB__select[0:0] = ALUMuxBconfig__select[0:0];
  assign ALUMuxBconfig__valid[0:0] = muxB__select_valid_upstream[0:0];
  assign ALUMuxBconfig__stop[0:0] = muxB__select_stop_upstream[0:0];
  assign Imm_fork__enable_downstream[1:0] = ConstForkConfig__select[1:0];
  assign ConstForkConfig__valid[0:0] = Imm_fork__enable_downstream_valid_upstream[0:0];
  assign ConstForkConfig__stop[0:0] = Imm_fork__enable_downstream_stop_upstream[0:0];
  assign buffOut__enable[0:0] = EBEnable__select[0:0];
  assign EBEnable__valid[0:0] = buffOut__enable_valid_upstream[0:0];
  assign EBEnable__stop[0:0] = buffOut__enable_stop_upstream[0:0];
  assign buff0__enable[0:0] = buff0Enable__select[0:0];
  assign buff0Enable__valid[0:0] = buff0__enable_valid_upstream[0:0];
  assign buff0Enable__stop[0:0] = buff0__enable_stop_upstream[0:0];
  assign buff1__enable[0:0] = buff1Enable__select[0:0];
  assign buff1Enable__valid[0:0] = buff1__enable_valid_upstream[0:0];
  assign buff1Enable__stop[0:0] = buff1__enable_stop_upstream[0:0];
  assign buff2__enable[0:0] = buff2Enable__select[0:0];
  assign buff2Enable__valid[0:0] = buff2__enable_valid_upstream[0:0];
  assign buff2Enable__stop[0:0] = buff2__enable_stop_upstream[0:0];
  assign buff3__enable[0:0] = buff3Enable__select[0:0];
  assign buff3Enable__valid[0:0] = buff3__enable_valid_upstream[0:0];
  assign buff3Enable__stop[0:0] = buff3__enable_stop_upstream[0:0];
  assign buff6__enable[0:0] = buff6Enable__select[0:0];
  assign buff6Enable__valid[0:0] = buff6__enable_valid_upstream[0:0];
  assign buff6Enable__stop[0:0] = buff6__enable_stop_upstream[0:0];
  assign buff7__enable[0:0] = buff7Enable__select[0:0];
  assign buff7Enable__valid[0:0] = buff7__enable_valid_upstream[0:0];
  assign buff7Enable__stop[0:0] = buff7__enable_stop_upstream[0:0];
  assign buffA__enable[0:0] = buffAEnable__select[0:0];
  assign buffAEnable__valid[0:0] = buffA__enable_valid_upstream[0:0];
  assign buffAEnable__stop[0:0] = buffA__enable_stop_upstream[0:0];
  assign buffB__enable[0:0] = buffBEnable__select[0:0];
  assign buffBEnable__valid[0:0] = buffB__enable_valid_upstream[0:0];
  assign buffBEnable__stop[0:0] = buffB__enable_stop_upstream[0:0];
  assign ALUMuxAconfig__ConfigIn = ConfigIn;
  assign ALUMuxBconfig__ConfigIn = ALUMuxAconfig__ConfigOut;
  assign ConstForkConfig__ConfigIn = ALUMuxBconfig__ConfigOut;
  assign EBEnable__ConfigIn = ConstForkConfig__ConfigOut;
  assign buff0Enable__ConfigIn = EBEnable__ConfigOut;
  assign buff1Enable__ConfigIn = buff0Enable__ConfigOut;
  assign buff2Enable__ConfigIn = buff1Enable__ConfigOut;
  assign buff3Enable__ConfigIn = buff2Enable__ConfigOut;
  assign buff6Enable__ConfigIn = buff3Enable__ConfigOut;
  assign buff7Enable__ConfigIn = buff6Enable__ConfigOut;
  assign buffAEnable__ConfigIn = buff7Enable__ConfigOut;
  assign buffBEnable__ConfigIn = buffAEnable__ConfigOut;
  assign FuncUnit__ConfigIn = buffBEnable__ConfigOut;
  assign Imm__ConfigIn = FuncUnit__ConfigOut;
  assign crossbar__ConfigIn = Imm__ConfigOut;
  assign ConfigOut = crossbar__ConfigOut;

endmodule //elastic_riken_in207_out207_default_U5

module cgra_U0 (
  input  CGRA_Clock,
  input  CGRA_Enable,
  input  CGRA_Reset,
  input  ConfigIn,
  output  ConfigOut,
  input  Config_Clock,
  input  Config_Reset,
  input [31:0] io_bottom_0_bidir_in,
  output [0:0] io_bottom_0_bidir_in_stop_upstream,
  input [0:0] io_bottom_0_bidir_in_valid_upstream,
  output [31:0] io_bottom_0_bidir_out,
  input [0:0] io_bottom_0_bidir_out_stop_downstream,
  output [0:0] io_bottom_0_bidir_out_valid_downstream,
  input [31:0] io_bottom_1_bidir_in,
  output [0:0] io_bottom_1_bidir_in_stop_upstream,
  input [0:0] io_bottom_1_bidir_in_valid_upstream,
  output [31:0] io_bottom_1_bidir_out,
  input [0:0] io_bottom_1_bidir_out_stop_downstream,
  output [0:0] io_bottom_1_bidir_out_valid_downstream,
  input [31:0] io_bottom_2_bidir_in,
  output [0:0] io_bottom_2_bidir_in_stop_upstream,
  input [0:0] io_bottom_2_bidir_in_valid_upstream,
  output [31:0] io_bottom_2_bidir_out,
  input [0:0] io_bottom_2_bidir_out_stop_downstream,
  output [0:0] io_bottom_2_bidir_out_valid_downstream,
  input [31:0] io_bottom_3_bidir_in,
  output [0:0] io_bottom_3_bidir_in_stop_upstream,
  input [0:0] io_bottom_3_bidir_in_valid_upstream,
  output [31:0] io_bottom_3_bidir_out,
  input [0:0] io_bottom_3_bidir_out_stop_downstream,
  output [0:0] io_bottom_3_bidir_out_valid_downstream,
  input [31:0] io_left_0_bidir_in,
  output [0:0] io_left_0_bidir_in_stop_upstream,
  input [0:0] io_left_0_bidir_in_valid_upstream,
  output [31:0] io_left_0_bidir_out,
  input [0:0] io_left_0_bidir_out_stop_downstream,
  output [0:0] io_left_0_bidir_out_valid_downstream,
  input [31:0] io_left_1_bidir_in,
  output [0:0] io_left_1_bidir_in_stop_upstream,
  input [0:0] io_left_1_bidir_in_valid_upstream,
  output [31:0] io_left_1_bidir_out,
  input [0:0] io_left_1_bidir_out_stop_downstream,
  output [0:0] io_left_1_bidir_out_valid_downstream,
  input [31:0] io_left_2_bidir_in,
  output [0:0] io_left_2_bidir_in_stop_upstream,
  input [0:0] io_left_2_bidir_in_valid_upstream,
  output [31:0] io_left_2_bidir_out,
  input [0:0] io_left_2_bidir_out_stop_downstream,
  output [0:0] io_left_2_bidir_out_valid_downstream,
  input [31:0] io_left_3_bidir_in,
  output [0:0] io_left_3_bidir_in_stop_upstream,
  input [0:0] io_left_3_bidir_in_valid_upstream,
  output [31:0] io_left_3_bidir_out,
  input [0:0] io_left_3_bidir_out_stop_downstream,
  output [0:0] io_left_3_bidir_out_valid_downstream,
  input [31:0] io_right_0_bidir_in,
  output [0:0] io_right_0_bidir_in_stop_upstream,
  input [0:0] io_right_0_bidir_in_valid_upstream,
  output [31:0] io_right_0_bidir_out,
  input [0:0] io_right_0_bidir_out_stop_downstream,
  output [0:0] io_right_0_bidir_out_valid_downstream,
  input [31:0] io_right_1_bidir_in,
  output [0:0] io_right_1_bidir_in_stop_upstream,
  input [0:0] io_right_1_bidir_in_valid_upstream,
  output [31:0] io_right_1_bidir_out,
  input [0:0] io_right_1_bidir_out_stop_downstream,
  output [0:0] io_right_1_bidir_out_valid_downstream,
  input [31:0] io_right_2_bidir_in,
  output [0:0] io_right_2_bidir_in_stop_upstream,
  input [0:0] io_right_2_bidir_in_valid_upstream,
  output [31:0] io_right_2_bidir_out,
  input [0:0] io_right_2_bidir_out_stop_downstream,
  output [0:0] io_right_2_bidir_out_valid_downstream,
  input [31:0] io_right_3_bidir_in,
  output [0:0] io_right_3_bidir_in_stop_upstream,
  input [0:0] io_right_3_bidir_in_valid_upstream,
  output [31:0] io_right_3_bidir_out,
  input [0:0] io_right_3_bidir_out_stop_downstream,
  output [0:0] io_right_3_bidir_out_valid_downstream,
  input [31:0] io_top_0_bidir_in,
  output [0:0] io_top_0_bidir_in_stop_upstream,
  input [0:0] io_top_0_bidir_in_valid_upstream,
  output [31:0] io_top_0_bidir_out,
  input [0:0] io_top_0_bidir_out_stop_downstream,
  output [0:0] io_top_0_bidir_out_valid_downstream,
  input [31:0] io_top_1_bidir_in,
  output [0:0] io_top_1_bidir_in_stop_upstream,
  input [0:0] io_top_1_bidir_in_valid_upstream,
  output [31:0] io_top_1_bidir_out,
  input [0:0] io_top_1_bidir_out_stop_downstream,
  output [0:0] io_top_1_bidir_out_valid_downstream,
  input [31:0] io_top_2_bidir_in,
  output [0:0] io_top_2_bidir_in_stop_upstream,
  input [0:0] io_top_2_bidir_in_valid_upstream,
  output [31:0] io_top_2_bidir_out,
  input [0:0] io_top_2_bidir_out_stop_downstream,
  output [0:0] io_top_2_bidir_out_valid_downstream,
  input [31:0] io_top_3_bidir_in,
  output [0:0] io_top_3_bidir_in_stop_upstream,
  input [0:0] io_top_3_bidir_in_valid_upstream,
  output [31:0] io_top_3_bidir_out,
  input [0:0] io_top_3_bidir_out_stop_downstream,
  output [0:0] io_top_3_bidir_out_valid_downstream
);
  //Wire declarations for instance 'io_bottom_0' (Module elastic_io_32b_U1)
  wire  io_bottom_0__CGRA_Clock;
  wire  io_bottom_0__CGRA_Enable;
  wire  io_bottom_0__CGRA_Reset;
  wire  io_bottom_0__ConfigIn;
  wire  io_bottom_0__ConfigOut;
  wire  io_bottom_0__Config_Clock;
  wire  io_bottom_0__Config_Reset;
  wire [31:0] io_bottom_0__bidir_in;
  wire [0:0] io_bottom_0__bidir_in_stop_upstream;
  wire [0:0] io_bottom_0__bidir_in_valid_upstream;
  wire [31:0] io_bottom_0__bidir_out;
  wire [0:0] io_bottom_0__bidir_out_stop_downstream;
  wire [0:0] io_bottom_0__bidir_out_valid_downstream;
  wire [31:0] io_bottom_0__in;
  wire [0:0] io_bottom_0__in_stop_upstream;
  wire [0:0] io_bottom_0__in_valid_upstream;
  wire [31:0] io_bottom_0__out;
  wire [0:0] io_bottom_0__out_stop_downstream;
  wire [0:0] io_bottom_0__out_valid_downstream;
  elastic_io_32b_U1 io_bottom_0(
    .CGRA_Clock(io_bottom_0__CGRA_Clock),
    .CGRA_Enable(io_bottom_0__CGRA_Enable),
    .CGRA_Reset(io_bottom_0__CGRA_Reset),
    .ConfigIn(io_bottom_0__ConfigIn),
    .ConfigOut(io_bottom_0__ConfigOut),
    .Config_Clock(io_bottom_0__Config_Clock),
    .Config_Reset(io_bottom_0__Config_Reset),
    .bidir_in(io_bottom_0__bidir_in),
    .bidir_in_stop_upstream(io_bottom_0__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_bottom_0__bidir_in_valid_upstream),
    .bidir_out(io_bottom_0__bidir_out),
    .bidir_out_stop_downstream(io_bottom_0__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_bottom_0__bidir_out_valid_downstream),
    .in(io_bottom_0__in),
    .in_stop_upstream(io_bottom_0__in_stop_upstream),
    .in_valid_upstream(io_bottom_0__in_valid_upstream),
    .out(io_bottom_0__out),
    .out_stop_downstream(io_bottom_0__out_stop_downstream),
    .out_valid_downstream(io_bottom_0__out_valid_downstream)
  );

  //Wire declarations for instance 'io_bottom_1' (Module elastic_io_32b_U1)
  wire  io_bottom_1__CGRA_Clock;
  wire  io_bottom_1__CGRA_Enable;
  wire  io_bottom_1__CGRA_Reset;
  wire  io_bottom_1__ConfigIn;
  wire  io_bottom_1__ConfigOut;
  wire  io_bottom_1__Config_Clock;
  wire  io_bottom_1__Config_Reset;
  wire [31:0] io_bottom_1__bidir_in;
  wire [0:0] io_bottom_1__bidir_in_stop_upstream;
  wire [0:0] io_bottom_1__bidir_in_valid_upstream;
  wire [31:0] io_bottom_1__bidir_out;
  wire [0:0] io_bottom_1__bidir_out_stop_downstream;
  wire [0:0] io_bottom_1__bidir_out_valid_downstream;
  wire [31:0] io_bottom_1__in;
  wire [0:0] io_bottom_1__in_stop_upstream;
  wire [0:0] io_bottom_1__in_valid_upstream;
  wire [31:0] io_bottom_1__out;
  wire [0:0] io_bottom_1__out_stop_downstream;
  wire [0:0] io_bottom_1__out_valid_downstream;
  elastic_io_32b_U1 io_bottom_1(
    .CGRA_Clock(io_bottom_1__CGRA_Clock),
    .CGRA_Enable(io_bottom_1__CGRA_Enable),
    .CGRA_Reset(io_bottom_1__CGRA_Reset),
    .ConfigIn(io_bottom_1__ConfigIn),
    .ConfigOut(io_bottom_1__ConfigOut),
    .Config_Clock(io_bottom_1__Config_Clock),
    .Config_Reset(io_bottom_1__Config_Reset),
    .bidir_in(io_bottom_1__bidir_in),
    .bidir_in_stop_upstream(io_bottom_1__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_bottom_1__bidir_in_valid_upstream),
    .bidir_out(io_bottom_1__bidir_out),
    .bidir_out_stop_downstream(io_bottom_1__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_bottom_1__bidir_out_valid_downstream),
    .in(io_bottom_1__in),
    .in_stop_upstream(io_bottom_1__in_stop_upstream),
    .in_valid_upstream(io_bottom_1__in_valid_upstream),
    .out(io_bottom_1__out),
    .out_stop_downstream(io_bottom_1__out_stop_downstream),
    .out_valid_downstream(io_bottom_1__out_valid_downstream)
  );

  //Wire declarations for instance 'io_bottom_2' (Module elastic_io_32b_U1)
  wire  io_bottom_2__CGRA_Clock;
  wire  io_bottom_2__CGRA_Enable;
  wire  io_bottom_2__CGRA_Reset;
  wire  io_bottom_2__ConfigIn;
  wire  io_bottom_2__ConfigOut;
  wire  io_bottom_2__Config_Clock;
  wire  io_bottom_2__Config_Reset;
  wire [31:0] io_bottom_2__bidir_in;
  wire [0:0] io_bottom_2__bidir_in_stop_upstream;
  wire [0:0] io_bottom_2__bidir_in_valid_upstream;
  wire [31:0] io_bottom_2__bidir_out;
  wire [0:0] io_bottom_2__bidir_out_stop_downstream;
  wire [0:0] io_bottom_2__bidir_out_valid_downstream;
  wire [31:0] io_bottom_2__in;
  wire [0:0] io_bottom_2__in_stop_upstream;
  wire [0:0] io_bottom_2__in_valid_upstream;
  wire [31:0] io_bottom_2__out;
  wire [0:0] io_bottom_2__out_stop_downstream;
  wire [0:0] io_bottom_2__out_valid_downstream;
  elastic_io_32b_U1 io_bottom_2(
    .CGRA_Clock(io_bottom_2__CGRA_Clock),
    .CGRA_Enable(io_bottom_2__CGRA_Enable),
    .CGRA_Reset(io_bottom_2__CGRA_Reset),
    .ConfigIn(io_bottom_2__ConfigIn),
    .ConfigOut(io_bottom_2__ConfigOut),
    .Config_Clock(io_bottom_2__Config_Clock),
    .Config_Reset(io_bottom_2__Config_Reset),
    .bidir_in(io_bottom_2__bidir_in),
    .bidir_in_stop_upstream(io_bottom_2__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_bottom_2__bidir_in_valid_upstream),
    .bidir_out(io_bottom_2__bidir_out),
    .bidir_out_stop_downstream(io_bottom_2__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_bottom_2__bidir_out_valid_downstream),
    .in(io_bottom_2__in),
    .in_stop_upstream(io_bottom_2__in_stop_upstream),
    .in_valid_upstream(io_bottom_2__in_valid_upstream),
    .out(io_bottom_2__out),
    .out_stop_downstream(io_bottom_2__out_stop_downstream),
    .out_valid_downstream(io_bottom_2__out_valid_downstream)
  );

  //Wire declarations for instance 'io_bottom_3' (Module elastic_io_32b_U1)
  wire  io_bottom_3__CGRA_Clock;
  wire  io_bottom_3__CGRA_Enable;
  wire  io_bottom_3__CGRA_Reset;
  wire  io_bottom_3__ConfigIn;
  wire  io_bottom_3__ConfigOut;
  wire  io_bottom_3__Config_Clock;
  wire  io_bottom_3__Config_Reset;
  wire [31:0] io_bottom_3__bidir_in;
  wire [0:0] io_bottom_3__bidir_in_stop_upstream;
  wire [0:0] io_bottom_3__bidir_in_valid_upstream;
  wire [31:0] io_bottom_3__bidir_out;
  wire [0:0] io_bottom_3__bidir_out_stop_downstream;
  wire [0:0] io_bottom_3__bidir_out_valid_downstream;
  wire [31:0] io_bottom_3__in;
  wire [0:0] io_bottom_3__in_stop_upstream;
  wire [0:0] io_bottom_3__in_valid_upstream;
  wire [31:0] io_bottom_3__out;
  wire [0:0] io_bottom_3__out_stop_downstream;
  wire [0:0] io_bottom_3__out_valid_downstream;
  elastic_io_32b_U1 io_bottom_3(
    .CGRA_Clock(io_bottom_3__CGRA_Clock),
    .CGRA_Enable(io_bottom_3__CGRA_Enable),
    .CGRA_Reset(io_bottom_3__CGRA_Reset),
    .ConfigIn(io_bottom_3__ConfigIn),
    .ConfigOut(io_bottom_3__ConfigOut),
    .Config_Clock(io_bottom_3__Config_Clock),
    .Config_Reset(io_bottom_3__Config_Reset),
    .bidir_in(io_bottom_3__bidir_in),
    .bidir_in_stop_upstream(io_bottom_3__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_bottom_3__bidir_in_valid_upstream),
    .bidir_out(io_bottom_3__bidir_out),
    .bidir_out_stop_downstream(io_bottom_3__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_bottom_3__bidir_out_valid_downstream),
    .in(io_bottom_3__in),
    .in_stop_upstream(io_bottom_3__in_stop_upstream),
    .in_valid_upstream(io_bottom_3__in_valid_upstream),
    .out(io_bottom_3__out),
    .out_stop_downstream(io_bottom_3__out_stop_downstream),
    .out_valid_downstream(io_bottom_3__out_valid_downstream)
  );

  //Wire declarations for instance 'io_left_0' (Module elastic_io_32b_U1)
  wire  io_left_0__CGRA_Clock;
  wire  io_left_0__CGRA_Enable;
  wire  io_left_0__CGRA_Reset;
  wire  io_left_0__ConfigIn;
  wire  io_left_0__ConfigOut;
  wire  io_left_0__Config_Clock;
  wire  io_left_0__Config_Reset;
  wire [31:0] io_left_0__bidir_in;
  wire [0:0] io_left_0__bidir_in_stop_upstream;
  wire [0:0] io_left_0__bidir_in_valid_upstream;
  wire [31:0] io_left_0__bidir_out;
  wire [0:0] io_left_0__bidir_out_stop_downstream;
  wire [0:0] io_left_0__bidir_out_valid_downstream;
  wire [31:0] io_left_0__in;
  wire [0:0] io_left_0__in_stop_upstream;
  wire [0:0] io_left_0__in_valid_upstream;
  wire [31:0] io_left_0__out;
  wire [0:0] io_left_0__out_stop_downstream;
  wire [0:0] io_left_0__out_valid_downstream;
  elastic_io_32b_U1 io_left_0(
    .CGRA_Clock(io_left_0__CGRA_Clock),
    .CGRA_Enable(io_left_0__CGRA_Enable),
    .CGRA_Reset(io_left_0__CGRA_Reset),
    .ConfigIn(io_left_0__ConfigIn),
    .ConfigOut(io_left_0__ConfigOut),
    .Config_Clock(io_left_0__Config_Clock),
    .Config_Reset(io_left_0__Config_Reset),
    .bidir_in(io_left_0__bidir_in),
    .bidir_in_stop_upstream(io_left_0__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_left_0__bidir_in_valid_upstream),
    .bidir_out(io_left_0__bidir_out),
    .bidir_out_stop_downstream(io_left_0__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_left_0__bidir_out_valid_downstream),
    .in(io_left_0__in),
    .in_stop_upstream(io_left_0__in_stop_upstream),
    .in_valid_upstream(io_left_0__in_valid_upstream),
    .out(io_left_0__out),
    .out_stop_downstream(io_left_0__out_stop_downstream),
    .out_valid_downstream(io_left_0__out_valid_downstream)
  );

  //Wire declarations for instance 'io_left_1' (Module elastic_io_32b_U1)
  wire  io_left_1__CGRA_Clock;
  wire  io_left_1__CGRA_Enable;
  wire  io_left_1__CGRA_Reset;
  wire  io_left_1__ConfigIn;
  wire  io_left_1__ConfigOut;
  wire  io_left_1__Config_Clock;
  wire  io_left_1__Config_Reset;
  wire [31:0] io_left_1__bidir_in;
  wire [0:0] io_left_1__bidir_in_stop_upstream;
  wire [0:0] io_left_1__bidir_in_valid_upstream;
  wire [31:0] io_left_1__bidir_out;
  wire [0:0] io_left_1__bidir_out_stop_downstream;
  wire [0:0] io_left_1__bidir_out_valid_downstream;
  wire [31:0] io_left_1__in;
  wire [0:0] io_left_1__in_stop_upstream;
  wire [0:0] io_left_1__in_valid_upstream;
  wire [31:0] io_left_1__out;
  wire [0:0] io_left_1__out_stop_downstream;
  wire [0:0] io_left_1__out_valid_downstream;
  elastic_io_32b_U1 io_left_1(
    .CGRA_Clock(io_left_1__CGRA_Clock),
    .CGRA_Enable(io_left_1__CGRA_Enable),
    .CGRA_Reset(io_left_1__CGRA_Reset),
    .ConfigIn(io_left_1__ConfigIn),
    .ConfigOut(io_left_1__ConfigOut),
    .Config_Clock(io_left_1__Config_Clock),
    .Config_Reset(io_left_1__Config_Reset),
    .bidir_in(io_left_1__bidir_in),
    .bidir_in_stop_upstream(io_left_1__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_left_1__bidir_in_valid_upstream),
    .bidir_out(io_left_1__bidir_out),
    .bidir_out_stop_downstream(io_left_1__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_left_1__bidir_out_valid_downstream),
    .in(io_left_1__in),
    .in_stop_upstream(io_left_1__in_stop_upstream),
    .in_valid_upstream(io_left_1__in_valid_upstream),
    .out(io_left_1__out),
    .out_stop_downstream(io_left_1__out_stop_downstream),
    .out_valid_downstream(io_left_1__out_valid_downstream)
  );

  //Wire declarations for instance 'io_left_2' (Module elastic_io_32b_U1)
  wire  io_left_2__CGRA_Clock;
  wire  io_left_2__CGRA_Enable;
  wire  io_left_2__CGRA_Reset;
  wire  io_left_2__ConfigIn;
  wire  io_left_2__ConfigOut;
  wire  io_left_2__Config_Clock;
  wire  io_left_2__Config_Reset;
  wire [31:0] io_left_2__bidir_in;
  wire [0:0] io_left_2__bidir_in_stop_upstream;
  wire [0:0] io_left_2__bidir_in_valid_upstream;
  wire [31:0] io_left_2__bidir_out;
  wire [0:0] io_left_2__bidir_out_stop_downstream;
  wire [0:0] io_left_2__bidir_out_valid_downstream;
  wire [31:0] io_left_2__in;
  wire [0:0] io_left_2__in_stop_upstream;
  wire [0:0] io_left_2__in_valid_upstream;
  wire [31:0] io_left_2__out;
  wire [0:0] io_left_2__out_stop_downstream;
  wire [0:0] io_left_2__out_valid_downstream;
  elastic_io_32b_U1 io_left_2(
    .CGRA_Clock(io_left_2__CGRA_Clock),
    .CGRA_Enable(io_left_2__CGRA_Enable),
    .CGRA_Reset(io_left_2__CGRA_Reset),
    .ConfigIn(io_left_2__ConfigIn),
    .ConfigOut(io_left_2__ConfigOut),
    .Config_Clock(io_left_2__Config_Clock),
    .Config_Reset(io_left_2__Config_Reset),
    .bidir_in(io_left_2__bidir_in),
    .bidir_in_stop_upstream(io_left_2__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_left_2__bidir_in_valid_upstream),
    .bidir_out(io_left_2__bidir_out),
    .bidir_out_stop_downstream(io_left_2__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_left_2__bidir_out_valid_downstream),
    .in(io_left_2__in),
    .in_stop_upstream(io_left_2__in_stop_upstream),
    .in_valid_upstream(io_left_2__in_valid_upstream),
    .out(io_left_2__out),
    .out_stop_downstream(io_left_2__out_stop_downstream),
    .out_valid_downstream(io_left_2__out_valid_downstream)
  );

  //Wire declarations for instance 'io_left_3' (Module elastic_io_32b_U1)
  wire  io_left_3__CGRA_Clock;
  wire  io_left_3__CGRA_Enable;
  wire  io_left_3__CGRA_Reset;
  wire  io_left_3__ConfigIn;
  wire  io_left_3__ConfigOut;
  wire  io_left_3__Config_Clock;
  wire  io_left_3__Config_Reset;
  wire [31:0] io_left_3__bidir_in;
  wire [0:0] io_left_3__bidir_in_stop_upstream;
  wire [0:0] io_left_3__bidir_in_valid_upstream;
  wire [31:0] io_left_3__bidir_out;
  wire [0:0] io_left_3__bidir_out_stop_downstream;
  wire [0:0] io_left_3__bidir_out_valid_downstream;
  wire [31:0] io_left_3__in;
  wire [0:0] io_left_3__in_stop_upstream;
  wire [0:0] io_left_3__in_valid_upstream;
  wire [31:0] io_left_3__out;
  wire [0:0] io_left_3__out_stop_downstream;
  wire [0:0] io_left_3__out_valid_downstream;
  elastic_io_32b_U1 io_left_3(
    .CGRA_Clock(io_left_3__CGRA_Clock),
    .CGRA_Enable(io_left_3__CGRA_Enable),
    .CGRA_Reset(io_left_3__CGRA_Reset),
    .ConfigIn(io_left_3__ConfigIn),
    .ConfigOut(io_left_3__ConfigOut),
    .Config_Clock(io_left_3__Config_Clock),
    .Config_Reset(io_left_3__Config_Reset),
    .bidir_in(io_left_3__bidir_in),
    .bidir_in_stop_upstream(io_left_3__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_left_3__bidir_in_valid_upstream),
    .bidir_out(io_left_3__bidir_out),
    .bidir_out_stop_downstream(io_left_3__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_left_3__bidir_out_valid_downstream),
    .in(io_left_3__in),
    .in_stop_upstream(io_left_3__in_stop_upstream),
    .in_valid_upstream(io_left_3__in_valid_upstream),
    .out(io_left_3__out),
    .out_stop_downstream(io_left_3__out_stop_downstream),
    .out_valid_downstream(io_left_3__out_valid_downstream)
  );

  //Wire declarations for instance 'io_right_0' (Module elastic_io_32b_U1)
  wire  io_right_0__CGRA_Clock;
  wire  io_right_0__CGRA_Enable;
  wire  io_right_0__CGRA_Reset;
  wire  io_right_0__ConfigIn;
  wire  io_right_0__ConfigOut;
  wire  io_right_0__Config_Clock;
  wire  io_right_0__Config_Reset;
  wire [31:0] io_right_0__bidir_in;
  wire [0:0] io_right_0__bidir_in_stop_upstream;
  wire [0:0] io_right_0__bidir_in_valid_upstream;
  wire [31:0] io_right_0__bidir_out;
  wire [0:0] io_right_0__bidir_out_stop_downstream;
  wire [0:0] io_right_0__bidir_out_valid_downstream;
  wire [31:0] io_right_0__in;
  wire [0:0] io_right_0__in_stop_upstream;
  wire [0:0] io_right_0__in_valid_upstream;
  wire [31:0] io_right_0__out;
  wire [0:0] io_right_0__out_stop_downstream;
  wire [0:0] io_right_0__out_valid_downstream;
  elastic_io_32b_U1 io_right_0(
    .CGRA_Clock(io_right_0__CGRA_Clock),
    .CGRA_Enable(io_right_0__CGRA_Enable),
    .CGRA_Reset(io_right_0__CGRA_Reset),
    .ConfigIn(io_right_0__ConfigIn),
    .ConfigOut(io_right_0__ConfigOut),
    .Config_Clock(io_right_0__Config_Clock),
    .Config_Reset(io_right_0__Config_Reset),
    .bidir_in(io_right_0__bidir_in),
    .bidir_in_stop_upstream(io_right_0__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_right_0__bidir_in_valid_upstream),
    .bidir_out(io_right_0__bidir_out),
    .bidir_out_stop_downstream(io_right_0__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_right_0__bidir_out_valid_downstream),
    .in(io_right_0__in),
    .in_stop_upstream(io_right_0__in_stop_upstream),
    .in_valid_upstream(io_right_0__in_valid_upstream),
    .out(io_right_0__out),
    .out_stop_downstream(io_right_0__out_stop_downstream),
    .out_valid_downstream(io_right_0__out_valid_downstream)
  );

  //Wire declarations for instance 'io_right_1' (Module elastic_io_32b_U1)
  wire  io_right_1__CGRA_Clock;
  wire  io_right_1__CGRA_Enable;
  wire  io_right_1__CGRA_Reset;
  wire  io_right_1__ConfigIn;
  wire  io_right_1__ConfigOut;
  wire  io_right_1__Config_Clock;
  wire  io_right_1__Config_Reset;
  wire [31:0] io_right_1__bidir_in;
  wire [0:0] io_right_1__bidir_in_stop_upstream;
  wire [0:0] io_right_1__bidir_in_valid_upstream;
  wire [31:0] io_right_1__bidir_out;
  wire [0:0] io_right_1__bidir_out_stop_downstream;
  wire [0:0] io_right_1__bidir_out_valid_downstream;
  wire [31:0] io_right_1__in;
  wire [0:0] io_right_1__in_stop_upstream;
  wire [0:0] io_right_1__in_valid_upstream;
  wire [31:0] io_right_1__out;
  wire [0:0] io_right_1__out_stop_downstream;
  wire [0:0] io_right_1__out_valid_downstream;
  elastic_io_32b_U1 io_right_1(
    .CGRA_Clock(io_right_1__CGRA_Clock),
    .CGRA_Enable(io_right_1__CGRA_Enable),
    .CGRA_Reset(io_right_1__CGRA_Reset),
    .ConfigIn(io_right_1__ConfigIn),
    .ConfigOut(io_right_1__ConfigOut),
    .Config_Clock(io_right_1__Config_Clock),
    .Config_Reset(io_right_1__Config_Reset),
    .bidir_in(io_right_1__bidir_in),
    .bidir_in_stop_upstream(io_right_1__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_right_1__bidir_in_valid_upstream),
    .bidir_out(io_right_1__bidir_out),
    .bidir_out_stop_downstream(io_right_1__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_right_1__bidir_out_valid_downstream),
    .in(io_right_1__in),
    .in_stop_upstream(io_right_1__in_stop_upstream),
    .in_valid_upstream(io_right_1__in_valid_upstream),
    .out(io_right_1__out),
    .out_stop_downstream(io_right_1__out_stop_downstream),
    .out_valid_downstream(io_right_1__out_valid_downstream)
  );

  //Wire declarations for instance 'io_right_2' (Module elastic_io_32b_U1)
  wire  io_right_2__CGRA_Clock;
  wire  io_right_2__CGRA_Enable;
  wire  io_right_2__CGRA_Reset;
  wire  io_right_2__ConfigIn;
  wire  io_right_2__ConfigOut;
  wire  io_right_2__Config_Clock;
  wire  io_right_2__Config_Reset;
  wire [31:0] io_right_2__bidir_in;
  wire [0:0] io_right_2__bidir_in_stop_upstream;
  wire [0:0] io_right_2__bidir_in_valid_upstream;
  wire [31:0] io_right_2__bidir_out;
  wire [0:0] io_right_2__bidir_out_stop_downstream;
  wire [0:0] io_right_2__bidir_out_valid_downstream;
  wire [31:0] io_right_2__in;
  wire [0:0] io_right_2__in_stop_upstream;
  wire [0:0] io_right_2__in_valid_upstream;
  wire [31:0] io_right_2__out;
  wire [0:0] io_right_2__out_stop_downstream;
  wire [0:0] io_right_2__out_valid_downstream;
  elastic_io_32b_U1 io_right_2(
    .CGRA_Clock(io_right_2__CGRA_Clock),
    .CGRA_Enable(io_right_2__CGRA_Enable),
    .CGRA_Reset(io_right_2__CGRA_Reset),
    .ConfigIn(io_right_2__ConfigIn),
    .ConfigOut(io_right_2__ConfigOut),
    .Config_Clock(io_right_2__Config_Clock),
    .Config_Reset(io_right_2__Config_Reset),
    .bidir_in(io_right_2__bidir_in),
    .bidir_in_stop_upstream(io_right_2__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_right_2__bidir_in_valid_upstream),
    .bidir_out(io_right_2__bidir_out),
    .bidir_out_stop_downstream(io_right_2__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_right_2__bidir_out_valid_downstream),
    .in(io_right_2__in),
    .in_stop_upstream(io_right_2__in_stop_upstream),
    .in_valid_upstream(io_right_2__in_valid_upstream),
    .out(io_right_2__out),
    .out_stop_downstream(io_right_2__out_stop_downstream),
    .out_valid_downstream(io_right_2__out_valid_downstream)
  );

  //Wire declarations for instance 'io_right_3' (Module elastic_io_32b_U1)
  wire  io_right_3__CGRA_Clock;
  wire  io_right_3__CGRA_Enable;
  wire  io_right_3__CGRA_Reset;
  wire  io_right_3__ConfigIn;
  wire  io_right_3__ConfigOut;
  wire  io_right_3__Config_Clock;
  wire  io_right_3__Config_Reset;
  wire [31:0] io_right_3__bidir_in;
  wire [0:0] io_right_3__bidir_in_stop_upstream;
  wire [0:0] io_right_3__bidir_in_valid_upstream;
  wire [31:0] io_right_3__bidir_out;
  wire [0:0] io_right_3__bidir_out_stop_downstream;
  wire [0:0] io_right_3__bidir_out_valid_downstream;
  wire [31:0] io_right_3__in;
  wire [0:0] io_right_3__in_stop_upstream;
  wire [0:0] io_right_3__in_valid_upstream;
  wire [31:0] io_right_3__out;
  wire [0:0] io_right_3__out_stop_downstream;
  wire [0:0] io_right_3__out_valid_downstream;
  elastic_io_32b_U1 io_right_3(
    .CGRA_Clock(io_right_3__CGRA_Clock),
    .CGRA_Enable(io_right_3__CGRA_Enable),
    .CGRA_Reset(io_right_3__CGRA_Reset),
    .ConfigIn(io_right_3__ConfigIn),
    .ConfigOut(io_right_3__ConfigOut),
    .Config_Clock(io_right_3__Config_Clock),
    .Config_Reset(io_right_3__Config_Reset),
    .bidir_in(io_right_3__bidir_in),
    .bidir_in_stop_upstream(io_right_3__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_right_3__bidir_in_valid_upstream),
    .bidir_out(io_right_3__bidir_out),
    .bidir_out_stop_downstream(io_right_3__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_right_3__bidir_out_valid_downstream),
    .in(io_right_3__in),
    .in_stop_upstream(io_right_3__in_stop_upstream),
    .in_valid_upstream(io_right_3__in_valid_upstream),
    .out(io_right_3__out),
    .out_stop_downstream(io_right_3__out_stop_downstream),
    .out_valid_downstream(io_right_3__out_valid_downstream)
  );

  //Wire declarations for instance 'io_top_0' (Module elastic_io_32b_U1)
  wire  io_top_0__CGRA_Clock;
  wire  io_top_0__CGRA_Enable;
  wire  io_top_0__CGRA_Reset;
  wire  io_top_0__ConfigIn;
  wire  io_top_0__ConfigOut;
  wire  io_top_0__Config_Clock;
  wire  io_top_0__Config_Reset;
  wire [31:0] io_top_0__bidir_in;
  wire [0:0] io_top_0__bidir_in_stop_upstream;
  wire [0:0] io_top_0__bidir_in_valid_upstream;
  wire [31:0] io_top_0__bidir_out;
  wire [0:0] io_top_0__bidir_out_stop_downstream;
  wire [0:0] io_top_0__bidir_out_valid_downstream;
  wire [31:0] io_top_0__in;
  wire [0:0] io_top_0__in_stop_upstream;
  wire [0:0] io_top_0__in_valid_upstream;
  wire [31:0] io_top_0__out;
  wire [0:0] io_top_0__out_stop_downstream;
  wire [0:0] io_top_0__out_valid_downstream;
  elastic_io_32b_U1 io_top_0(
    .CGRA_Clock(io_top_0__CGRA_Clock),
    .CGRA_Enable(io_top_0__CGRA_Enable),
    .CGRA_Reset(io_top_0__CGRA_Reset),
    .ConfigIn(io_top_0__ConfigIn),
    .ConfigOut(io_top_0__ConfigOut),
    .Config_Clock(io_top_0__Config_Clock),
    .Config_Reset(io_top_0__Config_Reset),
    .bidir_in(io_top_0__bidir_in),
    .bidir_in_stop_upstream(io_top_0__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_top_0__bidir_in_valid_upstream),
    .bidir_out(io_top_0__bidir_out),
    .bidir_out_stop_downstream(io_top_0__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_top_0__bidir_out_valid_downstream),
    .in(io_top_0__in),
    .in_stop_upstream(io_top_0__in_stop_upstream),
    .in_valid_upstream(io_top_0__in_valid_upstream),
    .out(io_top_0__out),
    .out_stop_downstream(io_top_0__out_stop_downstream),
    .out_valid_downstream(io_top_0__out_valid_downstream)
  );

  //Wire declarations for instance 'io_top_1' (Module elastic_io_32b_U1)
  wire  io_top_1__CGRA_Clock;
  wire  io_top_1__CGRA_Enable;
  wire  io_top_1__CGRA_Reset;
  wire  io_top_1__ConfigIn;
  wire  io_top_1__ConfigOut;
  wire  io_top_1__Config_Clock;
  wire  io_top_1__Config_Reset;
  wire [31:0] io_top_1__bidir_in;
  wire [0:0] io_top_1__bidir_in_stop_upstream;
  wire [0:0] io_top_1__bidir_in_valid_upstream;
  wire [31:0] io_top_1__bidir_out;
  wire [0:0] io_top_1__bidir_out_stop_downstream;
  wire [0:0] io_top_1__bidir_out_valid_downstream;
  wire [31:0] io_top_1__in;
  wire [0:0] io_top_1__in_stop_upstream;
  wire [0:0] io_top_1__in_valid_upstream;
  wire [31:0] io_top_1__out;
  wire [0:0] io_top_1__out_stop_downstream;
  wire [0:0] io_top_1__out_valid_downstream;
  elastic_io_32b_U1 io_top_1(
    .CGRA_Clock(io_top_1__CGRA_Clock),
    .CGRA_Enable(io_top_1__CGRA_Enable),
    .CGRA_Reset(io_top_1__CGRA_Reset),
    .ConfigIn(io_top_1__ConfigIn),
    .ConfigOut(io_top_1__ConfigOut),
    .Config_Clock(io_top_1__Config_Clock),
    .Config_Reset(io_top_1__Config_Reset),
    .bidir_in(io_top_1__bidir_in),
    .bidir_in_stop_upstream(io_top_1__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_top_1__bidir_in_valid_upstream),
    .bidir_out(io_top_1__bidir_out),
    .bidir_out_stop_downstream(io_top_1__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_top_1__bidir_out_valid_downstream),
    .in(io_top_1__in),
    .in_stop_upstream(io_top_1__in_stop_upstream),
    .in_valid_upstream(io_top_1__in_valid_upstream),
    .out(io_top_1__out),
    .out_stop_downstream(io_top_1__out_stop_downstream),
    .out_valid_downstream(io_top_1__out_valid_downstream)
  );

  //Wire declarations for instance 'io_top_2' (Module elastic_io_32b_U1)
  wire  io_top_2__CGRA_Clock;
  wire  io_top_2__CGRA_Enable;
  wire  io_top_2__CGRA_Reset;
  wire  io_top_2__ConfigIn;
  wire  io_top_2__ConfigOut;
  wire  io_top_2__Config_Clock;
  wire  io_top_2__Config_Reset;
  wire [31:0] io_top_2__bidir_in;
  wire [0:0] io_top_2__bidir_in_stop_upstream;
  wire [0:0] io_top_2__bidir_in_valid_upstream;
  wire [31:0] io_top_2__bidir_out;
  wire [0:0] io_top_2__bidir_out_stop_downstream;
  wire [0:0] io_top_2__bidir_out_valid_downstream;
  wire [31:0] io_top_2__in;
  wire [0:0] io_top_2__in_stop_upstream;
  wire [0:0] io_top_2__in_valid_upstream;
  wire [31:0] io_top_2__out;
  wire [0:0] io_top_2__out_stop_downstream;
  wire [0:0] io_top_2__out_valid_downstream;
  elastic_io_32b_U1 io_top_2(
    .CGRA_Clock(io_top_2__CGRA_Clock),
    .CGRA_Enable(io_top_2__CGRA_Enable),
    .CGRA_Reset(io_top_2__CGRA_Reset),
    .ConfigIn(io_top_2__ConfigIn),
    .ConfigOut(io_top_2__ConfigOut),
    .Config_Clock(io_top_2__Config_Clock),
    .Config_Reset(io_top_2__Config_Reset),
    .bidir_in(io_top_2__bidir_in),
    .bidir_in_stop_upstream(io_top_2__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_top_2__bidir_in_valid_upstream),
    .bidir_out(io_top_2__bidir_out),
    .bidir_out_stop_downstream(io_top_2__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_top_2__bidir_out_valid_downstream),
    .in(io_top_2__in),
    .in_stop_upstream(io_top_2__in_stop_upstream),
    .in_valid_upstream(io_top_2__in_valid_upstream),
    .out(io_top_2__out),
    .out_stop_downstream(io_top_2__out_stop_downstream),
    .out_valid_downstream(io_top_2__out_valid_downstream)
  );

  //Wire declarations for instance 'io_top_3' (Module elastic_io_32b_U1)
  wire  io_top_3__CGRA_Clock;
  wire  io_top_3__CGRA_Enable;
  wire  io_top_3__CGRA_Reset;
  wire  io_top_3__ConfigIn;
  wire  io_top_3__ConfigOut;
  wire  io_top_3__Config_Clock;
  wire  io_top_3__Config_Reset;
  wire [31:0] io_top_3__bidir_in;
  wire [0:0] io_top_3__bidir_in_stop_upstream;
  wire [0:0] io_top_3__bidir_in_valid_upstream;
  wire [31:0] io_top_3__bidir_out;
  wire [0:0] io_top_3__bidir_out_stop_downstream;
  wire [0:0] io_top_3__bidir_out_valid_downstream;
  wire [31:0] io_top_3__in;
  wire [0:0] io_top_3__in_stop_upstream;
  wire [0:0] io_top_3__in_valid_upstream;
  wire [31:0] io_top_3__out;
  wire [0:0] io_top_3__out_stop_downstream;
  wire [0:0] io_top_3__out_valid_downstream;
  elastic_io_32b_U1 io_top_3(
    .CGRA_Clock(io_top_3__CGRA_Clock),
    .CGRA_Enable(io_top_3__CGRA_Enable),
    .CGRA_Reset(io_top_3__CGRA_Reset),
    .ConfigIn(io_top_3__ConfigIn),
    .ConfigOut(io_top_3__ConfigOut),
    .Config_Clock(io_top_3__Config_Clock),
    .Config_Reset(io_top_3__Config_Reset),
    .bidir_in(io_top_3__bidir_in),
    .bidir_in_stop_upstream(io_top_3__bidir_in_stop_upstream),
    .bidir_in_valid_upstream(io_top_3__bidir_in_valid_upstream),
    .bidir_out(io_top_3__bidir_out),
    .bidir_out_stop_downstream(io_top_3__bidir_out_stop_downstream),
    .bidir_out_valid_downstream(io_top_3__bidir_out_valid_downstream),
    .in(io_top_3__in),
    .in_stop_upstream(io_top_3__in_stop_upstream),
    .in_valid_upstream(io_top_3__in_valid_upstream),
    .out(io_top_3__out),
    .out_stop_downstream(io_top_3__out_stop_downstream),
    .out_valid_downstream(io_top_3__out_valid_downstream)
  );

  //Wire declarations for instance 'pe_c0_r0' (Module elastic_riken_in79_out79_default_U2)
  wire  pe_c0_r0__CGRA_Clock;
  wire  pe_c0_r0__CGRA_Enable;
  wire  pe_c0_r0__CGRA_Reset;
  wire  pe_c0_r0__ConfigIn;
  wire  pe_c0_r0__ConfigOut;
  wire  pe_c0_r0__Config_Clock;
  wire  pe_c0_r0__Config_Reset;
  wire [31:0] pe_c0_r0__in0;
  wire [0:0] pe_c0_r0__in0_stop_upstream;
  wire [0:0] pe_c0_r0__in0_valid_upstream;
  wire [31:0] pe_c0_r0__in1;
  wire [0:0] pe_c0_r0__in1_stop_upstream;
  wire [0:0] pe_c0_r0__in1_valid_upstream;
  wire [31:0] pe_c0_r0__in2;
  wire [0:0] pe_c0_r0__in2_stop_upstream;
  wire [0:0] pe_c0_r0__in2_valid_upstream;
  wire [31:0] pe_c0_r0__in3;
  wire [0:0] pe_c0_r0__in3_stop_upstream;
  wire [0:0] pe_c0_r0__in3_valid_upstream;
  wire [31:0] pe_c0_r0__in6;
  wire [0:0] pe_c0_r0__in6_stop_upstream;
  wire [0:0] pe_c0_r0__in6_valid_upstream;
  wire [31:0] pe_c0_r0__out0;
  wire [0:0] pe_c0_r0__out0_stop_downstream;
  wire [0:0] pe_c0_r0__out0_valid_downstream;
  wire [31:0] pe_c0_r0__out1;
  wire [0:0] pe_c0_r0__out1_stop_downstream;
  wire [0:0] pe_c0_r0__out1_valid_downstream;
  wire [31:0] pe_c0_r0__out2;
  wire [0:0] pe_c0_r0__out2_stop_downstream;
  wire [0:0] pe_c0_r0__out2_valid_downstream;
  wire [31:0] pe_c0_r0__out3;
  wire [0:0] pe_c0_r0__out3_stop_downstream;
  wire [0:0] pe_c0_r0__out3_valid_downstream;
  wire [31:0] pe_c0_r0__out6;
  wire [0:0] pe_c0_r0__out6_stop_downstream;
  wire [0:0] pe_c0_r0__out6_valid_downstream;
  elastic_riken_in79_out79_default_U2 pe_c0_r0(
    .CGRA_Clock(pe_c0_r0__CGRA_Clock),
    .CGRA_Enable(pe_c0_r0__CGRA_Enable),
    .CGRA_Reset(pe_c0_r0__CGRA_Reset),
    .ConfigIn(pe_c0_r0__ConfigIn),
    .ConfigOut(pe_c0_r0__ConfigOut),
    .Config_Clock(pe_c0_r0__Config_Clock),
    .Config_Reset(pe_c0_r0__Config_Reset),
    .in0(pe_c0_r0__in0),
    .in0_stop_upstream(pe_c0_r0__in0_stop_upstream),
    .in0_valid_upstream(pe_c0_r0__in0_valid_upstream),
    .in1(pe_c0_r0__in1),
    .in1_stop_upstream(pe_c0_r0__in1_stop_upstream),
    .in1_valid_upstream(pe_c0_r0__in1_valid_upstream),
    .in2(pe_c0_r0__in2),
    .in2_stop_upstream(pe_c0_r0__in2_stop_upstream),
    .in2_valid_upstream(pe_c0_r0__in2_valid_upstream),
    .in3(pe_c0_r0__in3),
    .in3_stop_upstream(pe_c0_r0__in3_stop_upstream),
    .in3_valid_upstream(pe_c0_r0__in3_valid_upstream),
    .in6(pe_c0_r0__in6),
    .in6_stop_upstream(pe_c0_r0__in6_stop_upstream),
    .in6_valid_upstream(pe_c0_r0__in6_valid_upstream),
    .out0(pe_c0_r0__out0),
    .out0_stop_downstream(pe_c0_r0__out0_stop_downstream),
    .out0_valid_downstream(pe_c0_r0__out0_valid_downstream),
    .out1(pe_c0_r0__out1),
    .out1_stop_downstream(pe_c0_r0__out1_stop_downstream),
    .out1_valid_downstream(pe_c0_r0__out1_valid_downstream),
    .out2(pe_c0_r0__out2),
    .out2_stop_downstream(pe_c0_r0__out2_stop_downstream),
    .out2_valid_downstream(pe_c0_r0__out2_valid_downstream),
    .out3(pe_c0_r0__out3),
    .out3_stop_downstream(pe_c0_r0__out3_stop_downstream),
    .out3_valid_downstream(pe_c0_r0__out3_valid_downstream),
    .out6(pe_c0_r0__out6),
    .out6_stop_downstream(pe_c0_r0__out6_stop_downstream),
    .out6_valid_downstream(pe_c0_r0__out6_valid_downstream)
  );

  //Wire declarations for instance 'pe_c0_r1' (Module elastic_riken_in111_out111_default_U3)
  wire  pe_c0_r1__CGRA_Clock;
  wire  pe_c0_r1__CGRA_Enable;
  wire  pe_c0_r1__CGRA_Reset;
  wire  pe_c0_r1__ConfigIn;
  wire  pe_c0_r1__ConfigOut;
  wire  pe_c0_r1__Config_Clock;
  wire  pe_c0_r1__Config_Reset;
  wire [31:0] pe_c0_r1__in0;
  wire [0:0] pe_c0_r1__in0_stop_upstream;
  wire [0:0] pe_c0_r1__in0_valid_upstream;
  wire [31:0] pe_c0_r1__in1;
  wire [0:0] pe_c0_r1__in1_stop_upstream;
  wire [0:0] pe_c0_r1__in1_valid_upstream;
  wire [31:0] pe_c0_r1__in2;
  wire [0:0] pe_c0_r1__in2_stop_upstream;
  wire [0:0] pe_c0_r1__in2_valid_upstream;
  wire [31:0] pe_c0_r1__in3;
  wire [0:0] pe_c0_r1__in3_stop_upstream;
  wire [0:0] pe_c0_r1__in3_valid_upstream;
  wire [31:0] pe_c0_r1__in5;
  wire [0:0] pe_c0_r1__in5_stop_upstream;
  wire [0:0] pe_c0_r1__in5_valid_upstream;
  wire [31:0] pe_c0_r1__in6;
  wire [0:0] pe_c0_r1__in6_stop_upstream;
  wire [0:0] pe_c0_r1__in6_valid_upstream;
  wire [31:0] pe_c0_r1__out0;
  wire [0:0] pe_c0_r1__out0_stop_downstream;
  wire [0:0] pe_c0_r1__out0_valid_downstream;
  wire [31:0] pe_c0_r1__out1;
  wire [0:0] pe_c0_r1__out1_stop_downstream;
  wire [0:0] pe_c0_r1__out1_valid_downstream;
  wire [31:0] pe_c0_r1__out2;
  wire [0:0] pe_c0_r1__out2_stop_downstream;
  wire [0:0] pe_c0_r1__out2_valid_downstream;
  wire [31:0] pe_c0_r1__out3;
  wire [0:0] pe_c0_r1__out3_stop_downstream;
  wire [0:0] pe_c0_r1__out3_valid_downstream;
  wire [31:0] pe_c0_r1__out5;
  wire [0:0] pe_c0_r1__out5_stop_downstream;
  wire [0:0] pe_c0_r1__out5_valid_downstream;
  wire [31:0] pe_c0_r1__out6;
  wire [0:0] pe_c0_r1__out6_stop_downstream;
  wire [0:0] pe_c0_r1__out6_valid_downstream;
  elastic_riken_in111_out111_default_U3 pe_c0_r1(
    .CGRA_Clock(pe_c0_r1__CGRA_Clock),
    .CGRA_Enable(pe_c0_r1__CGRA_Enable),
    .CGRA_Reset(pe_c0_r1__CGRA_Reset),
    .ConfigIn(pe_c0_r1__ConfigIn),
    .ConfigOut(pe_c0_r1__ConfigOut),
    .Config_Clock(pe_c0_r1__Config_Clock),
    .Config_Reset(pe_c0_r1__Config_Reset),
    .in0(pe_c0_r1__in0),
    .in0_stop_upstream(pe_c0_r1__in0_stop_upstream),
    .in0_valid_upstream(pe_c0_r1__in0_valid_upstream),
    .in1(pe_c0_r1__in1),
    .in1_stop_upstream(pe_c0_r1__in1_stop_upstream),
    .in1_valid_upstream(pe_c0_r1__in1_valid_upstream),
    .in2(pe_c0_r1__in2),
    .in2_stop_upstream(pe_c0_r1__in2_stop_upstream),
    .in2_valid_upstream(pe_c0_r1__in2_valid_upstream),
    .in3(pe_c0_r1__in3),
    .in3_stop_upstream(pe_c0_r1__in3_stop_upstream),
    .in3_valid_upstream(pe_c0_r1__in3_valid_upstream),
    .in5(pe_c0_r1__in5),
    .in5_stop_upstream(pe_c0_r1__in5_stop_upstream),
    .in5_valid_upstream(pe_c0_r1__in5_valid_upstream),
    .in6(pe_c0_r1__in6),
    .in6_stop_upstream(pe_c0_r1__in6_stop_upstream),
    .in6_valid_upstream(pe_c0_r1__in6_valid_upstream),
    .out0(pe_c0_r1__out0),
    .out0_stop_downstream(pe_c0_r1__out0_stop_downstream),
    .out0_valid_downstream(pe_c0_r1__out0_valid_downstream),
    .out1(pe_c0_r1__out1),
    .out1_stop_downstream(pe_c0_r1__out1_stop_downstream),
    .out1_valid_downstream(pe_c0_r1__out1_valid_downstream),
    .out2(pe_c0_r1__out2),
    .out2_stop_downstream(pe_c0_r1__out2_stop_downstream),
    .out2_valid_downstream(pe_c0_r1__out2_valid_downstream),
    .out3(pe_c0_r1__out3),
    .out3_stop_downstream(pe_c0_r1__out3_stop_downstream),
    .out3_valid_downstream(pe_c0_r1__out3_valid_downstream),
    .out5(pe_c0_r1__out5),
    .out5_stop_downstream(pe_c0_r1__out5_stop_downstream),
    .out5_valid_downstream(pe_c0_r1__out5_valid_downstream),
    .out6(pe_c0_r1__out6),
    .out6_stop_downstream(pe_c0_r1__out6_stop_downstream),
    .out6_valid_downstream(pe_c0_r1__out6_valid_downstream)
  );

  //Wire declarations for instance 'pe_c0_r2' (Module elastic_riken_in111_out111_default_U3)
  wire  pe_c0_r2__CGRA_Clock;
  wire  pe_c0_r2__CGRA_Enable;
  wire  pe_c0_r2__CGRA_Reset;
  wire  pe_c0_r2__ConfigIn;
  wire  pe_c0_r2__ConfigOut;
  wire  pe_c0_r2__Config_Clock;
  wire  pe_c0_r2__Config_Reset;
  wire [31:0] pe_c0_r2__in0;
  wire [0:0] pe_c0_r2__in0_stop_upstream;
  wire [0:0] pe_c0_r2__in0_valid_upstream;
  wire [31:0] pe_c0_r2__in1;
  wire [0:0] pe_c0_r2__in1_stop_upstream;
  wire [0:0] pe_c0_r2__in1_valid_upstream;
  wire [31:0] pe_c0_r2__in2;
  wire [0:0] pe_c0_r2__in2_stop_upstream;
  wire [0:0] pe_c0_r2__in2_valid_upstream;
  wire [31:0] pe_c0_r2__in3;
  wire [0:0] pe_c0_r2__in3_stop_upstream;
  wire [0:0] pe_c0_r2__in3_valid_upstream;
  wire [31:0] pe_c0_r2__in5;
  wire [0:0] pe_c0_r2__in5_stop_upstream;
  wire [0:0] pe_c0_r2__in5_valid_upstream;
  wire [31:0] pe_c0_r2__in6;
  wire [0:0] pe_c0_r2__in6_stop_upstream;
  wire [0:0] pe_c0_r2__in6_valid_upstream;
  wire [31:0] pe_c0_r2__out0;
  wire [0:0] pe_c0_r2__out0_stop_downstream;
  wire [0:0] pe_c0_r2__out0_valid_downstream;
  wire [31:0] pe_c0_r2__out1;
  wire [0:0] pe_c0_r2__out1_stop_downstream;
  wire [0:0] pe_c0_r2__out1_valid_downstream;
  wire [31:0] pe_c0_r2__out2;
  wire [0:0] pe_c0_r2__out2_stop_downstream;
  wire [0:0] pe_c0_r2__out2_valid_downstream;
  wire [31:0] pe_c0_r2__out3;
  wire [0:0] pe_c0_r2__out3_stop_downstream;
  wire [0:0] pe_c0_r2__out3_valid_downstream;
  wire [31:0] pe_c0_r2__out5;
  wire [0:0] pe_c0_r2__out5_stop_downstream;
  wire [0:0] pe_c0_r2__out5_valid_downstream;
  wire [31:0] pe_c0_r2__out6;
  wire [0:0] pe_c0_r2__out6_stop_downstream;
  wire [0:0] pe_c0_r2__out6_valid_downstream;
  elastic_riken_in111_out111_default_U3 pe_c0_r2(
    .CGRA_Clock(pe_c0_r2__CGRA_Clock),
    .CGRA_Enable(pe_c0_r2__CGRA_Enable),
    .CGRA_Reset(pe_c0_r2__CGRA_Reset),
    .ConfigIn(pe_c0_r2__ConfigIn),
    .ConfigOut(pe_c0_r2__ConfigOut),
    .Config_Clock(pe_c0_r2__Config_Clock),
    .Config_Reset(pe_c0_r2__Config_Reset),
    .in0(pe_c0_r2__in0),
    .in0_stop_upstream(pe_c0_r2__in0_stop_upstream),
    .in0_valid_upstream(pe_c0_r2__in0_valid_upstream),
    .in1(pe_c0_r2__in1),
    .in1_stop_upstream(pe_c0_r2__in1_stop_upstream),
    .in1_valid_upstream(pe_c0_r2__in1_valid_upstream),
    .in2(pe_c0_r2__in2),
    .in2_stop_upstream(pe_c0_r2__in2_stop_upstream),
    .in2_valid_upstream(pe_c0_r2__in2_valid_upstream),
    .in3(pe_c0_r2__in3),
    .in3_stop_upstream(pe_c0_r2__in3_stop_upstream),
    .in3_valid_upstream(pe_c0_r2__in3_valid_upstream),
    .in5(pe_c0_r2__in5),
    .in5_stop_upstream(pe_c0_r2__in5_stop_upstream),
    .in5_valid_upstream(pe_c0_r2__in5_valid_upstream),
    .in6(pe_c0_r2__in6),
    .in6_stop_upstream(pe_c0_r2__in6_stop_upstream),
    .in6_valid_upstream(pe_c0_r2__in6_valid_upstream),
    .out0(pe_c0_r2__out0),
    .out0_stop_downstream(pe_c0_r2__out0_stop_downstream),
    .out0_valid_downstream(pe_c0_r2__out0_valid_downstream),
    .out1(pe_c0_r2__out1),
    .out1_stop_downstream(pe_c0_r2__out1_stop_downstream),
    .out1_valid_downstream(pe_c0_r2__out1_valid_downstream),
    .out2(pe_c0_r2__out2),
    .out2_stop_downstream(pe_c0_r2__out2_stop_downstream),
    .out2_valid_downstream(pe_c0_r2__out2_valid_downstream),
    .out3(pe_c0_r2__out3),
    .out3_stop_downstream(pe_c0_r2__out3_stop_downstream),
    .out3_valid_downstream(pe_c0_r2__out3_valid_downstream),
    .out5(pe_c0_r2__out5),
    .out5_stop_downstream(pe_c0_r2__out5_stop_downstream),
    .out5_valid_downstream(pe_c0_r2__out5_valid_downstream),
    .out6(pe_c0_r2__out6),
    .out6_stop_downstream(pe_c0_r2__out6_stop_downstream),
    .out6_valid_downstream(pe_c0_r2__out6_valid_downstream)
  );

  //Wire declarations for instance 'pe_c0_r3' (Module elastic_riken_in47_out47_default_U4)
  wire  pe_c0_r3__CGRA_Clock;
  wire  pe_c0_r3__CGRA_Enable;
  wire  pe_c0_r3__CGRA_Reset;
  wire  pe_c0_r3__ConfigIn;
  wire  pe_c0_r3__ConfigOut;
  wire  pe_c0_r3__Config_Clock;
  wire  pe_c0_r3__Config_Reset;
  wire [31:0] pe_c0_r3__in0;
  wire [0:0] pe_c0_r3__in0_stop_upstream;
  wire [0:0] pe_c0_r3__in0_valid_upstream;
  wire [31:0] pe_c0_r3__in1;
  wire [0:0] pe_c0_r3__in1_stop_upstream;
  wire [0:0] pe_c0_r3__in1_valid_upstream;
  wire [31:0] pe_c0_r3__in2;
  wire [0:0] pe_c0_r3__in2_stop_upstream;
  wire [0:0] pe_c0_r3__in2_valid_upstream;
  wire [31:0] pe_c0_r3__in3;
  wire [0:0] pe_c0_r3__in3_stop_upstream;
  wire [0:0] pe_c0_r3__in3_valid_upstream;
  wire [31:0] pe_c0_r3__in5;
  wire [0:0] pe_c0_r3__in5_stop_upstream;
  wire [0:0] pe_c0_r3__in5_valid_upstream;
  wire [31:0] pe_c0_r3__out0;
  wire [0:0] pe_c0_r3__out0_stop_downstream;
  wire [0:0] pe_c0_r3__out0_valid_downstream;
  wire [31:0] pe_c0_r3__out1;
  wire [0:0] pe_c0_r3__out1_stop_downstream;
  wire [0:0] pe_c0_r3__out1_valid_downstream;
  wire [31:0] pe_c0_r3__out2;
  wire [0:0] pe_c0_r3__out2_stop_downstream;
  wire [0:0] pe_c0_r3__out2_valid_downstream;
  wire [31:0] pe_c0_r3__out3;
  wire [0:0] pe_c0_r3__out3_stop_downstream;
  wire [0:0] pe_c0_r3__out3_valid_downstream;
  wire [31:0] pe_c0_r3__out5;
  wire [0:0] pe_c0_r3__out5_stop_downstream;
  wire [0:0] pe_c0_r3__out5_valid_downstream;
  elastic_riken_in47_out47_default_U4 pe_c0_r3(
    .CGRA_Clock(pe_c0_r3__CGRA_Clock),
    .CGRA_Enable(pe_c0_r3__CGRA_Enable),
    .CGRA_Reset(pe_c0_r3__CGRA_Reset),
    .ConfigIn(pe_c0_r3__ConfigIn),
    .ConfigOut(pe_c0_r3__ConfigOut),
    .Config_Clock(pe_c0_r3__Config_Clock),
    .Config_Reset(pe_c0_r3__Config_Reset),
    .in0(pe_c0_r3__in0),
    .in0_stop_upstream(pe_c0_r3__in0_stop_upstream),
    .in0_valid_upstream(pe_c0_r3__in0_valid_upstream),
    .in1(pe_c0_r3__in1),
    .in1_stop_upstream(pe_c0_r3__in1_stop_upstream),
    .in1_valid_upstream(pe_c0_r3__in1_valid_upstream),
    .in2(pe_c0_r3__in2),
    .in2_stop_upstream(pe_c0_r3__in2_stop_upstream),
    .in2_valid_upstream(pe_c0_r3__in2_valid_upstream),
    .in3(pe_c0_r3__in3),
    .in3_stop_upstream(pe_c0_r3__in3_stop_upstream),
    .in3_valid_upstream(pe_c0_r3__in3_valid_upstream),
    .in5(pe_c0_r3__in5),
    .in5_stop_upstream(pe_c0_r3__in5_stop_upstream),
    .in5_valid_upstream(pe_c0_r3__in5_valid_upstream),
    .out0(pe_c0_r3__out0),
    .out0_stop_downstream(pe_c0_r3__out0_stop_downstream),
    .out0_valid_downstream(pe_c0_r3__out0_valid_downstream),
    .out1(pe_c0_r3__out1),
    .out1_stop_downstream(pe_c0_r3__out1_stop_downstream),
    .out1_valid_downstream(pe_c0_r3__out1_valid_downstream),
    .out2(pe_c0_r3__out2),
    .out2_stop_downstream(pe_c0_r3__out2_stop_downstream),
    .out2_valid_downstream(pe_c0_r3__out2_valid_downstream),
    .out3(pe_c0_r3__out3),
    .out3_stop_downstream(pe_c0_r3__out3_stop_downstream),
    .out3_valid_downstream(pe_c0_r3__out3_valid_downstream),
    .out5(pe_c0_r3__out5),
    .out5_stop_downstream(pe_c0_r3__out5_stop_downstream),
    .out5_valid_downstream(pe_c0_r3__out5_valid_downstream)
  );

  //Wire declarations for instance 'pe_c1_r0' (Module elastic_riken_in207_out207_default_U5)
  wire  pe_c1_r0__CGRA_Clock;
  wire  pe_c1_r0__CGRA_Enable;
  wire  pe_c1_r0__CGRA_Reset;
  wire  pe_c1_r0__ConfigIn;
  wire  pe_c1_r0__ConfigOut;
  wire  pe_c1_r0__Config_Clock;
  wire  pe_c1_r0__Config_Reset;
  wire [31:0] pe_c1_r0__in0;
  wire [0:0] pe_c1_r0__in0_stop_upstream;
  wire [0:0] pe_c1_r0__in0_valid_upstream;
  wire [31:0] pe_c1_r0__in1;
  wire [0:0] pe_c1_r0__in1_stop_upstream;
  wire [0:0] pe_c1_r0__in1_valid_upstream;
  wire [31:0] pe_c1_r0__in2;
  wire [0:0] pe_c1_r0__in2_stop_upstream;
  wire [0:0] pe_c1_r0__in2_valid_upstream;
  wire [31:0] pe_c1_r0__in3;
  wire [0:0] pe_c1_r0__in3_stop_upstream;
  wire [0:0] pe_c1_r0__in3_valid_upstream;
  wire [31:0] pe_c1_r0__in6;
  wire [0:0] pe_c1_r0__in6_stop_upstream;
  wire [0:0] pe_c1_r0__in6_valid_upstream;
  wire [31:0] pe_c1_r0__in7;
  wire [0:0] pe_c1_r0__in7_stop_upstream;
  wire [0:0] pe_c1_r0__in7_valid_upstream;
  wire [31:0] pe_c1_r0__out0;
  wire [0:0] pe_c1_r0__out0_stop_downstream;
  wire [0:0] pe_c1_r0__out0_valid_downstream;
  wire [31:0] pe_c1_r0__out1;
  wire [0:0] pe_c1_r0__out1_stop_downstream;
  wire [0:0] pe_c1_r0__out1_valid_downstream;
  wire [31:0] pe_c1_r0__out2;
  wire [0:0] pe_c1_r0__out2_stop_downstream;
  wire [0:0] pe_c1_r0__out2_valid_downstream;
  wire [31:0] pe_c1_r0__out3;
  wire [0:0] pe_c1_r0__out3_stop_downstream;
  wire [0:0] pe_c1_r0__out3_valid_downstream;
  wire [31:0] pe_c1_r0__out6;
  wire [0:0] pe_c1_r0__out6_stop_downstream;
  wire [0:0] pe_c1_r0__out6_valid_downstream;
  wire [31:0] pe_c1_r0__out7;
  wire [0:0] pe_c1_r0__out7_stop_downstream;
  wire [0:0] pe_c1_r0__out7_valid_downstream;
  elastic_riken_in207_out207_default_U5 pe_c1_r0(
    .CGRA_Clock(pe_c1_r0__CGRA_Clock),
    .CGRA_Enable(pe_c1_r0__CGRA_Enable),
    .CGRA_Reset(pe_c1_r0__CGRA_Reset),
    .ConfigIn(pe_c1_r0__ConfigIn),
    .ConfigOut(pe_c1_r0__ConfigOut),
    .Config_Clock(pe_c1_r0__Config_Clock),
    .Config_Reset(pe_c1_r0__Config_Reset),
    .in0(pe_c1_r0__in0),
    .in0_stop_upstream(pe_c1_r0__in0_stop_upstream),
    .in0_valid_upstream(pe_c1_r0__in0_valid_upstream),
    .in1(pe_c1_r0__in1),
    .in1_stop_upstream(pe_c1_r0__in1_stop_upstream),
    .in1_valid_upstream(pe_c1_r0__in1_valid_upstream),
    .in2(pe_c1_r0__in2),
    .in2_stop_upstream(pe_c1_r0__in2_stop_upstream),
    .in2_valid_upstream(pe_c1_r0__in2_valid_upstream),
    .in3(pe_c1_r0__in3),
    .in3_stop_upstream(pe_c1_r0__in3_stop_upstream),
    .in3_valid_upstream(pe_c1_r0__in3_valid_upstream),
    .in6(pe_c1_r0__in6),
    .in6_stop_upstream(pe_c1_r0__in6_stop_upstream),
    .in6_valid_upstream(pe_c1_r0__in6_valid_upstream),
    .in7(pe_c1_r0__in7),
    .in7_stop_upstream(pe_c1_r0__in7_stop_upstream),
    .in7_valid_upstream(pe_c1_r0__in7_valid_upstream),
    .out0(pe_c1_r0__out0),
    .out0_stop_downstream(pe_c1_r0__out0_stop_downstream),
    .out0_valid_downstream(pe_c1_r0__out0_valid_downstream),
    .out1(pe_c1_r0__out1),
    .out1_stop_downstream(pe_c1_r0__out1_stop_downstream),
    .out1_valid_downstream(pe_c1_r0__out1_valid_downstream),
    .out2(pe_c1_r0__out2),
    .out2_stop_downstream(pe_c1_r0__out2_stop_downstream),
    .out2_valid_downstream(pe_c1_r0__out2_valid_downstream),
    .out3(pe_c1_r0__out3),
    .out3_stop_downstream(pe_c1_r0__out3_stop_downstream),
    .out3_valid_downstream(pe_c1_r0__out3_valid_downstream),
    .out6(pe_c1_r0__out6),
    .out6_stop_downstream(pe_c1_r0__out6_stop_downstream),
    .out6_valid_downstream(pe_c1_r0__out6_valid_downstream),
    .out7(pe_c1_r0__out7),
    .out7_stop_downstream(pe_c1_r0__out7_stop_downstream),
    .out7_valid_downstream(pe_c1_r0__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c1_r1' (Module elastic_riken_in255_out255_default_U6)
  wire  pe_c1_r1__CGRA_Clock;
  wire  pe_c1_r1__CGRA_Enable;
  wire  pe_c1_r1__CGRA_Reset;
  wire  pe_c1_r1__ConfigIn;
  wire  pe_c1_r1__ConfigOut;
  wire  pe_c1_r1__Config_Clock;
  wire  pe_c1_r1__Config_Reset;
  wire [31:0] pe_c1_r1__in0;
  wire [0:0] pe_c1_r1__in0_stop_upstream;
  wire [0:0] pe_c1_r1__in0_valid_upstream;
  wire [31:0] pe_c1_r1__in1;
  wire [0:0] pe_c1_r1__in1_stop_upstream;
  wire [0:0] pe_c1_r1__in1_valid_upstream;
  wire [31:0] pe_c1_r1__in2;
  wire [0:0] pe_c1_r1__in2_stop_upstream;
  wire [0:0] pe_c1_r1__in2_valid_upstream;
  wire [31:0] pe_c1_r1__in3;
  wire [0:0] pe_c1_r1__in3_stop_upstream;
  wire [0:0] pe_c1_r1__in3_valid_upstream;
  wire [31:0] pe_c1_r1__in4;
  wire [0:0] pe_c1_r1__in4_stop_upstream;
  wire [0:0] pe_c1_r1__in4_valid_upstream;
  wire [31:0] pe_c1_r1__in5;
  wire [0:0] pe_c1_r1__in5_stop_upstream;
  wire [0:0] pe_c1_r1__in5_valid_upstream;
  wire [31:0] pe_c1_r1__in6;
  wire [0:0] pe_c1_r1__in6_stop_upstream;
  wire [0:0] pe_c1_r1__in6_valid_upstream;
  wire [31:0] pe_c1_r1__in7;
  wire [0:0] pe_c1_r1__in7_stop_upstream;
  wire [0:0] pe_c1_r1__in7_valid_upstream;
  wire [31:0] pe_c1_r1__out0;
  wire [0:0] pe_c1_r1__out0_stop_downstream;
  wire [0:0] pe_c1_r1__out0_valid_downstream;
  wire [31:0] pe_c1_r1__out1;
  wire [0:0] pe_c1_r1__out1_stop_downstream;
  wire [0:0] pe_c1_r1__out1_valid_downstream;
  wire [31:0] pe_c1_r1__out2;
  wire [0:0] pe_c1_r1__out2_stop_downstream;
  wire [0:0] pe_c1_r1__out2_valid_downstream;
  wire [31:0] pe_c1_r1__out3;
  wire [0:0] pe_c1_r1__out3_stop_downstream;
  wire [0:0] pe_c1_r1__out3_valid_downstream;
  wire [31:0] pe_c1_r1__out4;
  wire [0:0] pe_c1_r1__out4_stop_downstream;
  wire [0:0] pe_c1_r1__out4_valid_downstream;
  wire [31:0] pe_c1_r1__out5;
  wire [0:0] pe_c1_r1__out5_stop_downstream;
  wire [0:0] pe_c1_r1__out5_valid_downstream;
  wire [31:0] pe_c1_r1__out6;
  wire [0:0] pe_c1_r1__out6_stop_downstream;
  wire [0:0] pe_c1_r1__out6_valid_downstream;
  wire [31:0] pe_c1_r1__out7;
  wire [0:0] pe_c1_r1__out7_stop_downstream;
  wire [0:0] pe_c1_r1__out7_valid_downstream;
  elastic_riken_in255_out255_default_U6 pe_c1_r1(
    .CGRA_Clock(pe_c1_r1__CGRA_Clock),
    .CGRA_Enable(pe_c1_r1__CGRA_Enable),
    .CGRA_Reset(pe_c1_r1__CGRA_Reset),
    .ConfigIn(pe_c1_r1__ConfigIn),
    .ConfigOut(pe_c1_r1__ConfigOut),
    .Config_Clock(pe_c1_r1__Config_Clock),
    .Config_Reset(pe_c1_r1__Config_Reset),
    .in0(pe_c1_r1__in0),
    .in0_stop_upstream(pe_c1_r1__in0_stop_upstream),
    .in0_valid_upstream(pe_c1_r1__in0_valid_upstream),
    .in1(pe_c1_r1__in1),
    .in1_stop_upstream(pe_c1_r1__in1_stop_upstream),
    .in1_valid_upstream(pe_c1_r1__in1_valid_upstream),
    .in2(pe_c1_r1__in2),
    .in2_stop_upstream(pe_c1_r1__in2_stop_upstream),
    .in2_valid_upstream(pe_c1_r1__in2_valid_upstream),
    .in3(pe_c1_r1__in3),
    .in3_stop_upstream(pe_c1_r1__in3_stop_upstream),
    .in3_valid_upstream(pe_c1_r1__in3_valid_upstream),
    .in4(pe_c1_r1__in4),
    .in4_stop_upstream(pe_c1_r1__in4_stop_upstream),
    .in4_valid_upstream(pe_c1_r1__in4_valid_upstream),
    .in5(pe_c1_r1__in5),
    .in5_stop_upstream(pe_c1_r1__in5_stop_upstream),
    .in5_valid_upstream(pe_c1_r1__in5_valid_upstream),
    .in6(pe_c1_r1__in6),
    .in6_stop_upstream(pe_c1_r1__in6_stop_upstream),
    .in6_valid_upstream(pe_c1_r1__in6_valid_upstream),
    .in7(pe_c1_r1__in7),
    .in7_stop_upstream(pe_c1_r1__in7_stop_upstream),
    .in7_valid_upstream(pe_c1_r1__in7_valid_upstream),
    .out0(pe_c1_r1__out0),
    .out0_stop_downstream(pe_c1_r1__out0_stop_downstream),
    .out0_valid_downstream(pe_c1_r1__out0_valid_downstream),
    .out1(pe_c1_r1__out1),
    .out1_stop_downstream(pe_c1_r1__out1_stop_downstream),
    .out1_valid_downstream(pe_c1_r1__out1_valid_downstream),
    .out2(pe_c1_r1__out2),
    .out2_stop_downstream(pe_c1_r1__out2_stop_downstream),
    .out2_valid_downstream(pe_c1_r1__out2_valid_downstream),
    .out3(pe_c1_r1__out3),
    .out3_stop_downstream(pe_c1_r1__out3_stop_downstream),
    .out3_valid_downstream(pe_c1_r1__out3_valid_downstream),
    .out4(pe_c1_r1__out4),
    .out4_stop_downstream(pe_c1_r1__out4_stop_downstream),
    .out4_valid_downstream(pe_c1_r1__out4_valid_downstream),
    .out5(pe_c1_r1__out5),
    .out5_stop_downstream(pe_c1_r1__out5_stop_downstream),
    .out5_valid_downstream(pe_c1_r1__out5_valid_downstream),
    .out6(pe_c1_r1__out6),
    .out6_stop_downstream(pe_c1_r1__out6_stop_downstream),
    .out6_valid_downstream(pe_c1_r1__out6_valid_downstream),
    .out7(pe_c1_r1__out7),
    .out7_stop_downstream(pe_c1_r1__out7_stop_downstream),
    .out7_valid_downstream(pe_c1_r1__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c1_r2' (Module elastic_riken_in255_out255_default_U6)
  wire  pe_c1_r2__CGRA_Clock;
  wire  pe_c1_r2__CGRA_Enable;
  wire  pe_c1_r2__CGRA_Reset;
  wire  pe_c1_r2__ConfigIn;
  wire  pe_c1_r2__ConfigOut;
  wire  pe_c1_r2__Config_Clock;
  wire  pe_c1_r2__Config_Reset;
  wire [31:0] pe_c1_r2__in0;
  wire [0:0] pe_c1_r2__in0_stop_upstream;
  wire [0:0] pe_c1_r2__in0_valid_upstream;
  wire [31:0] pe_c1_r2__in1;
  wire [0:0] pe_c1_r2__in1_stop_upstream;
  wire [0:0] pe_c1_r2__in1_valid_upstream;
  wire [31:0] pe_c1_r2__in2;
  wire [0:0] pe_c1_r2__in2_stop_upstream;
  wire [0:0] pe_c1_r2__in2_valid_upstream;
  wire [31:0] pe_c1_r2__in3;
  wire [0:0] pe_c1_r2__in3_stop_upstream;
  wire [0:0] pe_c1_r2__in3_valid_upstream;
  wire [31:0] pe_c1_r2__in4;
  wire [0:0] pe_c1_r2__in4_stop_upstream;
  wire [0:0] pe_c1_r2__in4_valid_upstream;
  wire [31:0] pe_c1_r2__in5;
  wire [0:0] pe_c1_r2__in5_stop_upstream;
  wire [0:0] pe_c1_r2__in5_valid_upstream;
  wire [31:0] pe_c1_r2__in6;
  wire [0:0] pe_c1_r2__in6_stop_upstream;
  wire [0:0] pe_c1_r2__in6_valid_upstream;
  wire [31:0] pe_c1_r2__in7;
  wire [0:0] pe_c1_r2__in7_stop_upstream;
  wire [0:0] pe_c1_r2__in7_valid_upstream;
  wire [31:0] pe_c1_r2__out0;
  wire [0:0] pe_c1_r2__out0_stop_downstream;
  wire [0:0] pe_c1_r2__out0_valid_downstream;
  wire [31:0] pe_c1_r2__out1;
  wire [0:0] pe_c1_r2__out1_stop_downstream;
  wire [0:0] pe_c1_r2__out1_valid_downstream;
  wire [31:0] pe_c1_r2__out2;
  wire [0:0] pe_c1_r2__out2_stop_downstream;
  wire [0:0] pe_c1_r2__out2_valid_downstream;
  wire [31:0] pe_c1_r2__out3;
  wire [0:0] pe_c1_r2__out3_stop_downstream;
  wire [0:0] pe_c1_r2__out3_valid_downstream;
  wire [31:0] pe_c1_r2__out4;
  wire [0:0] pe_c1_r2__out4_stop_downstream;
  wire [0:0] pe_c1_r2__out4_valid_downstream;
  wire [31:0] pe_c1_r2__out5;
  wire [0:0] pe_c1_r2__out5_stop_downstream;
  wire [0:0] pe_c1_r2__out5_valid_downstream;
  wire [31:0] pe_c1_r2__out6;
  wire [0:0] pe_c1_r2__out6_stop_downstream;
  wire [0:0] pe_c1_r2__out6_valid_downstream;
  wire [31:0] pe_c1_r2__out7;
  wire [0:0] pe_c1_r2__out7_stop_downstream;
  wire [0:0] pe_c1_r2__out7_valid_downstream;
  elastic_riken_in255_out255_default_U6 pe_c1_r2(
    .CGRA_Clock(pe_c1_r2__CGRA_Clock),
    .CGRA_Enable(pe_c1_r2__CGRA_Enable),
    .CGRA_Reset(pe_c1_r2__CGRA_Reset),
    .ConfigIn(pe_c1_r2__ConfigIn),
    .ConfigOut(pe_c1_r2__ConfigOut),
    .Config_Clock(pe_c1_r2__Config_Clock),
    .Config_Reset(pe_c1_r2__Config_Reset),
    .in0(pe_c1_r2__in0),
    .in0_stop_upstream(pe_c1_r2__in0_stop_upstream),
    .in0_valid_upstream(pe_c1_r2__in0_valid_upstream),
    .in1(pe_c1_r2__in1),
    .in1_stop_upstream(pe_c1_r2__in1_stop_upstream),
    .in1_valid_upstream(pe_c1_r2__in1_valid_upstream),
    .in2(pe_c1_r2__in2),
    .in2_stop_upstream(pe_c1_r2__in2_stop_upstream),
    .in2_valid_upstream(pe_c1_r2__in2_valid_upstream),
    .in3(pe_c1_r2__in3),
    .in3_stop_upstream(pe_c1_r2__in3_stop_upstream),
    .in3_valid_upstream(pe_c1_r2__in3_valid_upstream),
    .in4(pe_c1_r2__in4),
    .in4_stop_upstream(pe_c1_r2__in4_stop_upstream),
    .in4_valid_upstream(pe_c1_r2__in4_valid_upstream),
    .in5(pe_c1_r2__in5),
    .in5_stop_upstream(pe_c1_r2__in5_stop_upstream),
    .in5_valid_upstream(pe_c1_r2__in5_valid_upstream),
    .in6(pe_c1_r2__in6),
    .in6_stop_upstream(pe_c1_r2__in6_stop_upstream),
    .in6_valid_upstream(pe_c1_r2__in6_valid_upstream),
    .in7(pe_c1_r2__in7),
    .in7_stop_upstream(pe_c1_r2__in7_stop_upstream),
    .in7_valid_upstream(pe_c1_r2__in7_valid_upstream),
    .out0(pe_c1_r2__out0),
    .out0_stop_downstream(pe_c1_r2__out0_stop_downstream),
    .out0_valid_downstream(pe_c1_r2__out0_valid_downstream),
    .out1(pe_c1_r2__out1),
    .out1_stop_downstream(pe_c1_r2__out1_stop_downstream),
    .out1_valid_downstream(pe_c1_r2__out1_valid_downstream),
    .out2(pe_c1_r2__out2),
    .out2_stop_downstream(pe_c1_r2__out2_stop_downstream),
    .out2_valid_downstream(pe_c1_r2__out2_valid_downstream),
    .out3(pe_c1_r2__out3),
    .out3_stop_downstream(pe_c1_r2__out3_stop_downstream),
    .out3_valid_downstream(pe_c1_r2__out3_valid_downstream),
    .out4(pe_c1_r2__out4),
    .out4_stop_downstream(pe_c1_r2__out4_stop_downstream),
    .out4_valid_downstream(pe_c1_r2__out4_valid_downstream),
    .out5(pe_c1_r2__out5),
    .out5_stop_downstream(pe_c1_r2__out5_stop_downstream),
    .out5_valid_downstream(pe_c1_r2__out5_valid_downstream),
    .out6(pe_c1_r2__out6),
    .out6_stop_downstream(pe_c1_r2__out6_stop_downstream),
    .out6_valid_downstream(pe_c1_r2__out6_valid_downstream),
    .out7(pe_c1_r2__out7),
    .out7_stop_downstream(pe_c1_r2__out7_stop_downstream),
    .out7_valid_downstream(pe_c1_r2__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c1_r3' (Module elastic_riken_in63_out63_default_U7)
  wire  pe_c1_r3__CGRA_Clock;
  wire  pe_c1_r3__CGRA_Enable;
  wire  pe_c1_r3__CGRA_Reset;
  wire  pe_c1_r3__ConfigIn;
  wire  pe_c1_r3__ConfigOut;
  wire  pe_c1_r3__Config_Clock;
  wire  pe_c1_r3__Config_Reset;
  wire [31:0] pe_c1_r3__in0;
  wire [0:0] pe_c1_r3__in0_stop_upstream;
  wire [0:0] pe_c1_r3__in0_valid_upstream;
  wire [31:0] pe_c1_r3__in1;
  wire [0:0] pe_c1_r3__in1_stop_upstream;
  wire [0:0] pe_c1_r3__in1_valid_upstream;
  wire [31:0] pe_c1_r3__in2;
  wire [0:0] pe_c1_r3__in2_stop_upstream;
  wire [0:0] pe_c1_r3__in2_valid_upstream;
  wire [31:0] pe_c1_r3__in3;
  wire [0:0] pe_c1_r3__in3_stop_upstream;
  wire [0:0] pe_c1_r3__in3_valid_upstream;
  wire [31:0] pe_c1_r3__in4;
  wire [0:0] pe_c1_r3__in4_stop_upstream;
  wire [0:0] pe_c1_r3__in4_valid_upstream;
  wire [31:0] pe_c1_r3__in5;
  wire [0:0] pe_c1_r3__in5_stop_upstream;
  wire [0:0] pe_c1_r3__in5_valid_upstream;
  wire [31:0] pe_c1_r3__out0;
  wire [0:0] pe_c1_r3__out0_stop_downstream;
  wire [0:0] pe_c1_r3__out0_valid_downstream;
  wire [31:0] pe_c1_r3__out1;
  wire [0:0] pe_c1_r3__out1_stop_downstream;
  wire [0:0] pe_c1_r3__out1_valid_downstream;
  wire [31:0] pe_c1_r3__out2;
  wire [0:0] pe_c1_r3__out2_stop_downstream;
  wire [0:0] pe_c1_r3__out2_valid_downstream;
  wire [31:0] pe_c1_r3__out3;
  wire [0:0] pe_c1_r3__out3_stop_downstream;
  wire [0:0] pe_c1_r3__out3_valid_downstream;
  wire [31:0] pe_c1_r3__out4;
  wire [0:0] pe_c1_r3__out4_stop_downstream;
  wire [0:0] pe_c1_r3__out4_valid_downstream;
  wire [31:0] pe_c1_r3__out5;
  wire [0:0] pe_c1_r3__out5_stop_downstream;
  wire [0:0] pe_c1_r3__out5_valid_downstream;
  elastic_riken_in63_out63_default_U7 pe_c1_r3(
    .CGRA_Clock(pe_c1_r3__CGRA_Clock),
    .CGRA_Enable(pe_c1_r3__CGRA_Enable),
    .CGRA_Reset(pe_c1_r3__CGRA_Reset),
    .ConfigIn(pe_c1_r3__ConfigIn),
    .ConfigOut(pe_c1_r3__ConfigOut),
    .Config_Clock(pe_c1_r3__Config_Clock),
    .Config_Reset(pe_c1_r3__Config_Reset),
    .in0(pe_c1_r3__in0),
    .in0_stop_upstream(pe_c1_r3__in0_stop_upstream),
    .in0_valid_upstream(pe_c1_r3__in0_valid_upstream),
    .in1(pe_c1_r3__in1),
    .in1_stop_upstream(pe_c1_r3__in1_stop_upstream),
    .in1_valid_upstream(pe_c1_r3__in1_valid_upstream),
    .in2(pe_c1_r3__in2),
    .in2_stop_upstream(pe_c1_r3__in2_stop_upstream),
    .in2_valid_upstream(pe_c1_r3__in2_valid_upstream),
    .in3(pe_c1_r3__in3),
    .in3_stop_upstream(pe_c1_r3__in3_stop_upstream),
    .in3_valid_upstream(pe_c1_r3__in3_valid_upstream),
    .in4(pe_c1_r3__in4),
    .in4_stop_upstream(pe_c1_r3__in4_stop_upstream),
    .in4_valid_upstream(pe_c1_r3__in4_valid_upstream),
    .in5(pe_c1_r3__in5),
    .in5_stop_upstream(pe_c1_r3__in5_stop_upstream),
    .in5_valid_upstream(pe_c1_r3__in5_valid_upstream),
    .out0(pe_c1_r3__out0),
    .out0_stop_downstream(pe_c1_r3__out0_stop_downstream),
    .out0_valid_downstream(pe_c1_r3__out0_valid_downstream),
    .out1(pe_c1_r3__out1),
    .out1_stop_downstream(pe_c1_r3__out1_stop_downstream),
    .out1_valid_downstream(pe_c1_r3__out1_valid_downstream),
    .out2(pe_c1_r3__out2),
    .out2_stop_downstream(pe_c1_r3__out2_stop_downstream),
    .out2_valid_downstream(pe_c1_r3__out2_valid_downstream),
    .out3(pe_c1_r3__out3),
    .out3_stop_downstream(pe_c1_r3__out3_stop_downstream),
    .out3_valid_downstream(pe_c1_r3__out3_valid_downstream),
    .out4(pe_c1_r3__out4),
    .out4_stop_downstream(pe_c1_r3__out4_stop_downstream),
    .out4_valid_downstream(pe_c1_r3__out4_valid_downstream),
    .out5(pe_c1_r3__out5),
    .out5_stop_downstream(pe_c1_r3__out5_stop_downstream),
    .out5_valid_downstream(pe_c1_r3__out5_valid_downstream)
  );

  //Wire declarations for instance 'pe_c2_r0' (Module elastic_riken_in207_out207_default_U5)
  wire  pe_c2_r0__CGRA_Clock;
  wire  pe_c2_r0__CGRA_Enable;
  wire  pe_c2_r0__CGRA_Reset;
  wire  pe_c2_r0__ConfigIn;
  wire  pe_c2_r0__ConfigOut;
  wire  pe_c2_r0__Config_Clock;
  wire  pe_c2_r0__Config_Reset;
  wire [31:0] pe_c2_r0__in0;
  wire [0:0] pe_c2_r0__in0_stop_upstream;
  wire [0:0] pe_c2_r0__in0_valid_upstream;
  wire [31:0] pe_c2_r0__in1;
  wire [0:0] pe_c2_r0__in1_stop_upstream;
  wire [0:0] pe_c2_r0__in1_valid_upstream;
  wire [31:0] pe_c2_r0__in2;
  wire [0:0] pe_c2_r0__in2_stop_upstream;
  wire [0:0] pe_c2_r0__in2_valid_upstream;
  wire [31:0] pe_c2_r0__in3;
  wire [0:0] pe_c2_r0__in3_stop_upstream;
  wire [0:0] pe_c2_r0__in3_valid_upstream;
  wire [31:0] pe_c2_r0__in6;
  wire [0:0] pe_c2_r0__in6_stop_upstream;
  wire [0:0] pe_c2_r0__in6_valid_upstream;
  wire [31:0] pe_c2_r0__in7;
  wire [0:0] pe_c2_r0__in7_stop_upstream;
  wire [0:0] pe_c2_r0__in7_valid_upstream;
  wire [31:0] pe_c2_r0__out0;
  wire [0:0] pe_c2_r0__out0_stop_downstream;
  wire [0:0] pe_c2_r0__out0_valid_downstream;
  wire [31:0] pe_c2_r0__out1;
  wire [0:0] pe_c2_r0__out1_stop_downstream;
  wire [0:0] pe_c2_r0__out1_valid_downstream;
  wire [31:0] pe_c2_r0__out2;
  wire [0:0] pe_c2_r0__out2_stop_downstream;
  wire [0:0] pe_c2_r0__out2_valid_downstream;
  wire [31:0] pe_c2_r0__out3;
  wire [0:0] pe_c2_r0__out3_stop_downstream;
  wire [0:0] pe_c2_r0__out3_valid_downstream;
  wire [31:0] pe_c2_r0__out6;
  wire [0:0] pe_c2_r0__out6_stop_downstream;
  wire [0:0] pe_c2_r0__out6_valid_downstream;
  wire [31:0] pe_c2_r0__out7;
  wire [0:0] pe_c2_r0__out7_stop_downstream;
  wire [0:0] pe_c2_r0__out7_valid_downstream;
  elastic_riken_in207_out207_default_U5 pe_c2_r0(
    .CGRA_Clock(pe_c2_r0__CGRA_Clock),
    .CGRA_Enable(pe_c2_r0__CGRA_Enable),
    .CGRA_Reset(pe_c2_r0__CGRA_Reset),
    .ConfigIn(pe_c2_r0__ConfigIn),
    .ConfigOut(pe_c2_r0__ConfigOut),
    .Config_Clock(pe_c2_r0__Config_Clock),
    .Config_Reset(pe_c2_r0__Config_Reset),
    .in0(pe_c2_r0__in0),
    .in0_stop_upstream(pe_c2_r0__in0_stop_upstream),
    .in0_valid_upstream(pe_c2_r0__in0_valid_upstream),
    .in1(pe_c2_r0__in1),
    .in1_stop_upstream(pe_c2_r0__in1_stop_upstream),
    .in1_valid_upstream(pe_c2_r0__in1_valid_upstream),
    .in2(pe_c2_r0__in2),
    .in2_stop_upstream(pe_c2_r0__in2_stop_upstream),
    .in2_valid_upstream(pe_c2_r0__in2_valid_upstream),
    .in3(pe_c2_r0__in3),
    .in3_stop_upstream(pe_c2_r0__in3_stop_upstream),
    .in3_valid_upstream(pe_c2_r0__in3_valid_upstream),
    .in6(pe_c2_r0__in6),
    .in6_stop_upstream(pe_c2_r0__in6_stop_upstream),
    .in6_valid_upstream(pe_c2_r0__in6_valid_upstream),
    .in7(pe_c2_r0__in7),
    .in7_stop_upstream(pe_c2_r0__in7_stop_upstream),
    .in7_valid_upstream(pe_c2_r0__in7_valid_upstream),
    .out0(pe_c2_r0__out0),
    .out0_stop_downstream(pe_c2_r0__out0_stop_downstream),
    .out0_valid_downstream(pe_c2_r0__out0_valid_downstream),
    .out1(pe_c2_r0__out1),
    .out1_stop_downstream(pe_c2_r0__out1_stop_downstream),
    .out1_valid_downstream(pe_c2_r0__out1_valid_downstream),
    .out2(pe_c2_r0__out2),
    .out2_stop_downstream(pe_c2_r0__out2_stop_downstream),
    .out2_valid_downstream(pe_c2_r0__out2_valid_downstream),
    .out3(pe_c2_r0__out3),
    .out3_stop_downstream(pe_c2_r0__out3_stop_downstream),
    .out3_valid_downstream(pe_c2_r0__out3_valid_downstream),
    .out6(pe_c2_r0__out6),
    .out6_stop_downstream(pe_c2_r0__out6_stop_downstream),
    .out6_valid_downstream(pe_c2_r0__out6_valid_downstream),
    .out7(pe_c2_r0__out7),
    .out7_stop_downstream(pe_c2_r0__out7_stop_downstream),
    .out7_valid_downstream(pe_c2_r0__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c2_r1' (Module elastic_riken_in255_out255_default_U6)
  wire  pe_c2_r1__CGRA_Clock;
  wire  pe_c2_r1__CGRA_Enable;
  wire  pe_c2_r1__CGRA_Reset;
  wire  pe_c2_r1__ConfigIn;
  wire  pe_c2_r1__ConfigOut;
  wire  pe_c2_r1__Config_Clock;
  wire  pe_c2_r1__Config_Reset;
  wire [31:0] pe_c2_r1__in0;
  wire [0:0] pe_c2_r1__in0_stop_upstream;
  wire [0:0] pe_c2_r1__in0_valid_upstream;
  wire [31:0] pe_c2_r1__in1;
  wire [0:0] pe_c2_r1__in1_stop_upstream;
  wire [0:0] pe_c2_r1__in1_valid_upstream;
  wire [31:0] pe_c2_r1__in2;
  wire [0:0] pe_c2_r1__in2_stop_upstream;
  wire [0:0] pe_c2_r1__in2_valid_upstream;
  wire [31:0] pe_c2_r1__in3;
  wire [0:0] pe_c2_r1__in3_stop_upstream;
  wire [0:0] pe_c2_r1__in3_valid_upstream;
  wire [31:0] pe_c2_r1__in4;
  wire [0:0] pe_c2_r1__in4_stop_upstream;
  wire [0:0] pe_c2_r1__in4_valid_upstream;
  wire [31:0] pe_c2_r1__in5;
  wire [0:0] pe_c2_r1__in5_stop_upstream;
  wire [0:0] pe_c2_r1__in5_valid_upstream;
  wire [31:0] pe_c2_r1__in6;
  wire [0:0] pe_c2_r1__in6_stop_upstream;
  wire [0:0] pe_c2_r1__in6_valid_upstream;
  wire [31:0] pe_c2_r1__in7;
  wire [0:0] pe_c2_r1__in7_stop_upstream;
  wire [0:0] pe_c2_r1__in7_valid_upstream;
  wire [31:0] pe_c2_r1__out0;
  wire [0:0] pe_c2_r1__out0_stop_downstream;
  wire [0:0] pe_c2_r1__out0_valid_downstream;
  wire [31:0] pe_c2_r1__out1;
  wire [0:0] pe_c2_r1__out1_stop_downstream;
  wire [0:0] pe_c2_r1__out1_valid_downstream;
  wire [31:0] pe_c2_r1__out2;
  wire [0:0] pe_c2_r1__out2_stop_downstream;
  wire [0:0] pe_c2_r1__out2_valid_downstream;
  wire [31:0] pe_c2_r1__out3;
  wire [0:0] pe_c2_r1__out3_stop_downstream;
  wire [0:0] pe_c2_r1__out3_valid_downstream;
  wire [31:0] pe_c2_r1__out4;
  wire [0:0] pe_c2_r1__out4_stop_downstream;
  wire [0:0] pe_c2_r1__out4_valid_downstream;
  wire [31:0] pe_c2_r1__out5;
  wire [0:0] pe_c2_r1__out5_stop_downstream;
  wire [0:0] pe_c2_r1__out5_valid_downstream;
  wire [31:0] pe_c2_r1__out6;
  wire [0:0] pe_c2_r1__out6_stop_downstream;
  wire [0:0] pe_c2_r1__out6_valid_downstream;
  wire [31:0] pe_c2_r1__out7;
  wire [0:0] pe_c2_r1__out7_stop_downstream;
  wire [0:0] pe_c2_r1__out7_valid_downstream;
  elastic_riken_in255_out255_default_U6 pe_c2_r1(
    .CGRA_Clock(pe_c2_r1__CGRA_Clock),
    .CGRA_Enable(pe_c2_r1__CGRA_Enable),
    .CGRA_Reset(pe_c2_r1__CGRA_Reset),
    .ConfigIn(pe_c2_r1__ConfigIn),
    .ConfigOut(pe_c2_r1__ConfigOut),
    .Config_Clock(pe_c2_r1__Config_Clock),
    .Config_Reset(pe_c2_r1__Config_Reset),
    .in0(pe_c2_r1__in0),
    .in0_stop_upstream(pe_c2_r1__in0_stop_upstream),
    .in0_valid_upstream(pe_c2_r1__in0_valid_upstream),
    .in1(pe_c2_r1__in1),
    .in1_stop_upstream(pe_c2_r1__in1_stop_upstream),
    .in1_valid_upstream(pe_c2_r1__in1_valid_upstream),
    .in2(pe_c2_r1__in2),
    .in2_stop_upstream(pe_c2_r1__in2_stop_upstream),
    .in2_valid_upstream(pe_c2_r1__in2_valid_upstream),
    .in3(pe_c2_r1__in3),
    .in3_stop_upstream(pe_c2_r1__in3_stop_upstream),
    .in3_valid_upstream(pe_c2_r1__in3_valid_upstream),
    .in4(pe_c2_r1__in4),
    .in4_stop_upstream(pe_c2_r1__in4_stop_upstream),
    .in4_valid_upstream(pe_c2_r1__in4_valid_upstream),
    .in5(pe_c2_r1__in5),
    .in5_stop_upstream(pe_c2_r1__in5_stop_upstream),
    .in5_valid_upstream(pe_c2_r1__in5_valid_upstream),
    .in6(pe_c2_r1__in6),
    .in6_stop_upstream(pe_c2_r1__in6_stop_upstream),
    .in6_valid_upstream(pe_c2_r1__in6_valid_upstream),
    .in7(pe_c2_r1__in7),
    .in7_stop_upstream(pe_c2_r1__in7_stop_upstream),
    .in7_valid_upstream(pe_c2_r1__in7_valid_upstream),
    .out0(pe_c2_r1__out0),
    .out0_stop_downstream(pe_c2_r1__out0_stop_downstream),
    .out0_valid_downstream(pe_c2_r1__out0_valid_downstream),
    .out1(pe_c2_r1__out1),
    .out1_stop_downstream(pe_c2_r1__out1_stop_downstream),
    .out1_valid_downstream(pe_c2_r1__out1_valid_downstream),
    .out2(pe_c2_r1__out2),
    .out2_stop_downstream(pe_c2_r1__out2_stop_downstream),
    .out2_valid_downstream(pe_c2_r1__out2_valid_downstream),
    .out3(pe_c2_r1__out3),
    .out3_stop_downstream(pe_c2_r1__out3_stop_downstream),
    .out3_valid_downstream(pe_c2_r1__out3_valid_downstream),
    .out4(pe_c2_r1__out4),
    .out4_stop_downstream(pe_c2_r1__out4_stop_downstream),
    .out4_valid_downstream(pe_c2_r1__out4_valid_downstream),
    .out5(pe_c2_r1__out5),
    .out5_stop_downstream(pe_c2_r1__out5_stop_downstream),
    .out5_valid_downstream(pe_c2_r1__out5_valid_downstream),
    .out6(pe_c2_r1__out6),
    .out6_stop_downstream(pe_c2_r1__out6_stop_downstream),
    .out6_valid_downstream(pe_c2_r1__out6_valid_downstream),
    .out7(pe_c2_r1__out7),
    .out7_stop_downstream(pe_c2_r1__out7_stop_downstream),
    .out7_valid_downstream(pe_c2_r1__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c2_r2' (Module elastic_riken_in255_out255_default_U6)
  wire  pe_c2_r2__CGRA_Clock;
  wire  pe_c2_r2__CGRA_Enable;
  wire  pe_c2_r2__CGRA_Reset;
  wire  pe_c2_r2__ConfigIn;
  wire  pe_c2_r2__ConfigOut;
  wire  pe_c2_r2__Config_Clock;
  wire  pe_c2_r2__Config_Reset;
  wire [31:0] pe_c2_r2__in0;
  wire [0:0] pe_c2_r2__in0_stop_upstream;
  wire [0:0] pe_c2_r2__in0_valid_upstream;
  wire [31:0] pe_c2_r2__in1;
  wire [0:0] pe_c2_r2__in1_stop_upstream;
  wire [0:0] pe_c2_r2__in1_valid_upstream;
  wire [31:0] pe_c2_r2__in2;
  wire [0:0] pe_c2_r2__in2_stop_upstream;
  wire [0:0] pe_c2_r2__in2_valid_upstream;
  wire [31:0] pe_c2_r2__in3;
  wire [0:0] pe_c2_r2__in3_stop_upstream;
  wire [0:0] pe_c2_r2__in3_valid_upstream;
  wire [31:0] pe_c2_r2__in4;
  wire [0:0] pe_c2_r2__in4_stop_upstream;
  wire [0:0] pe_c2_r2__in4_valid_upstream;
  wire [31:0] pe_c2_r2__in5;
  wire [0:0] pe_c2_r2__in5_stop_upstream;
  wire [0:0] pe_c2_r2__in5_valid_upstream;
  wire [31:0] pe_c2_r2__in6;
  wire [0:0] pe_c2_r2__in6_stop_upstream;
  wire [0:0] pe_c2_r2__in6_valid_upstream;
  wire [31:0] pe_c2_r2__in7;
  wire [0:0] pe_c2_r2__in7_stop_upstream;
  wire [0:0] pe_c2_r2__in7_valid_upstream;
  wire [31:0] pe_c2_r2__out0;
  wire [0:0] pe_c2_r2__out0_stop_downstream;
  wire [0:0] pe_c2_r2__out0_valid_downstream;
  wire [31:0] pe_c2_r2__out1;
  wire [0:0] pe_c2_r2__out1_stop_downstream;
  wire [0:0] pe_c2_r2__out1_valid_downstream;
  wire [31:0] pe_c2_r2__out2;
  wire [0:0] pe_c2_r2__out2_stop_downstream;
  wire [0:0] pe_c2_r2__out2_valid_downstream;
  wire [31:0] pe_c2_r2__out3;
  wire [0:0] pe_c2_r2__out3_stop_downstream;
  wire [0:0] pe_c2_r2__out3_valid_downstream;
  wire [31:0] pe_c2_r2__out4;
  wire [0:0] pe_c2_r2__out4_stop_downstream;
  wire [0:0] pe_c2_r2__out4_valid_downstream;
  wire [31:0] pe_c2_r2__out5;
  wire [0:0] pe_c2_r2__out5_stop_downstream;
  wire [0:0] pe_c2_r2__out5_valid_downstream;
  wire [31:0] pe_c2_r2__out6;
  wire [0:0] pe_c2_r2__out6_stop_downstream;
  wire [0:0] pe_c2_r2__out6_valid_downstream;
  wire [31:0] pe_c2_r2__out7;
  wire [0:0] pe_c2_r2__out7_stop_downstream;
  wire [0:0] pe_c2_r2__out7_valid_downstream;
  elastic_riken_in255_out255_default_U6 pe_c2_r2(
    .CGRA_Clock(pe_c2_r2__CGRA_Clock),
    .CGRA_Enable(pe_c2_r2__CGRA_Enable),
    .CGRA_Reset(pe_c2_r2__CGRA_Reset),
    .ConfigIn(pe_c2_r2__ConfigIn),
    .ConfigOut(pe_c2_r2__ConfigOut),
    .Config_Clock(pe_c2_r2__Config_Clock),
    .Config_Reset(pe_c2_r2__Config_Reset),
    .in0(pe_c2_r2__in0),
    .in0_stop_upstream(pe_c2_r2__in0_stop_upstream),
    .in0_valid_upstream(pe_c2_r2__in0_valid_upstream),
    .in1(pe_c2_r2__in1),
    .in1_stop_upstream(pe_c2_r2__in1_stop_upstream),
    .in1_valid_upstream(pe_c2_r2__in1_valid_upstream),
    .in2(pe_c2_r2__in2),
    .in2_stop_upstream(pe_c2_r2__in2_stop_upstream),
    .in2_valid_upstream(pe_c2_r2__in2_valid_upstream),
    .in3(pe_c2_r2__in3),
    .in3_stop_upstream(pe_c2_r2__in3_stop_upstream),
    .in3_valid_upstream(pe_c2_r2__in3_valid_upstream),
    .in4(pe_c2_r2__in4),
    .in4_stop_upstream(pe_c2_r2__in4_stop_upstream),
    .in4_valid_upstream(pe_c2_r2__in4_valid_upstream),
    .in5(pe_c2_r2__in5),
    .in5_stop_upstream(pe_c2_r2__in5_stop_upstream),
    .in5_valid_upstream(pe_c2_r2__in5_valid_upstream),
    .in6(pe_c2_r2__in6),
    .in6_stop_upstream(pe_c2_r2__in6_stop_upstream),
    .in6_valid_upstream(pe_c2_r2__in6_valid_upstream),
    .in7(pe_c2_r2__in7),
    .in7_stop_upstream(pe_c2_r2__in7_stop_upstream),
    .in7_valid_upstream(pe_c2_r2__in7_valid_upstream),
    .out0(pe_c2_r2__out0),
    .out0_stop_downstream(pe_c2_r2__out0_stop_downstream),
    .out0_valid_downstream(pe_c2_r2__out0_valid_downstream),
    .out1(pe_c2_r2__out1),
    .out1_stop_downstream(pe_c2_r2__out1_stop_downstream),
    .out1_valid_downstream(pe_c2_r2__out1_valid_downstream),
    .out2(pe_c2_r2__out2),
    .out2_stop_downstream(pe_c2_r2__out2_stop_downstream),
    .out2_valid_downstream(pe_c2_r2__out2_valid_downstream),
    .out3(pe_c2_r2__out3),
    .out3_stop_downstream(pe_c2_r2__out3_stop_downstream),
    .out3_valid_downstream(pe_c2_r2__out3_valid_downstream),
    .out4(pe_c2_r2__out4),
    .out4_stop_downstream(pe_c2_r2__out4_stop_downstream),
    .out4_valid_downstream(pe_c2_r2__out4_valid_downstream),
    .out5(pe_c2_r2__out5),
    .out5_stop_downstream(pe_c2_r2__out5_stop_downstream),
    .out5_valid_downstream(pe_c2_r2__out5_valid_downstream),
    .out6(pe_c2_r2__out6),
    .out6_stop_downstream(pe_c2_r2__out6_stop_downstream),
    .out6_valid_downstream(pe_c2_r2__out6_valid_downstream),
    .out7(pe_c2_r2__out7),
    .out7_stop_downstream(pe_c2_r2__out7_stop_downstream),
    .out7_valid_downstream(pe_c2_r2__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c2_r3' (Module elastic_riken_in63_out63_default_U7)
  wire  pe_c2_r3__CGRA_Clock;
  wire  pe_c2_r3__CGRA_Enable;
  wire  pe_c2_r3__CGRA_Reset;
  wire  pe_c2_r3__ConfigIn;
  wire  pe_c2_r3__ConfigOut;
  wire  pe_c2_r3__Config_Clock;
  wire  pe_c2_r3__Config_Reset;
  wire [31:0] pe_c2_r3__in0;
  wire [0:0] pe_c2_r3__in0_stop_upstream;
  wire [0:0] pe_c2_r3__in0_valid_upstream;
  wire [31:0] pe_c2_r3__in1;
  wire [0:0] pe_c2_r3__in1_stop_upstream;
  wire [0:0] pe_c2_r3__in1_valid_upstream;
  wire [31:0] pe_c2_r3__in2;
  wire [0:0] pe_c2_r3__in2_stop_upstream;
  wire [0:0] pe_c2_r3__in2_valid_upstream;
  wire [31:0] pe_c2_r3__in3;
  wire [0:0] pe_c2_r3__in3_stop_upstream;
  wire [0:0] pe_c2_r3__in3_valid_upstream;
  wire [31:0] pe_c2_r3__in4;
  wire [0:0] pe_c2_r3__in4_stop_upstream;
  wire [0:0] pe_c2_r3__in4_valid_upstream;
  wire [31:0] pe_c2_r3__in5;
  wire [0:0] pe_c2_r3__in5_stop_upstream;
  wire [0:0] pe_c2_r3__in5_valid_upstream;
  wire [31:0] pe_c2_r3__out0;
  wire [0:0] pe_c2_r3__out0_stop_downstream;
  wire [0:0] pe_c2_r3__out0_valid_downstream;
  wire [31:0] pe_c2_r3__out1;
  wire [0:0] pe_c2_r3__out1_stop_downstream;
  wire [0:0] pe_c2_r3__out1_valid_downstream;
  wire [31:0] pe_c2_r3__out2;
  wire [0:0] pe_c2_r3__out2_stop_downstream;
  wire [0:0] pe_c2_r3__out2_valid_downstream;
  wire [31:0] pe_c2_r3__out3;
  wire [0:0] pe_c2_r3__out3_stop_downstream;
  wire [0:0] pe_c2_r3__out3_valid_downstream;
  wire [31:0] pe_c2_r3__out4;
  wire [0:0] pe_c2_r3__out4_stop_downstream;
  wire [0:0] pe_c2_r3__out4_valid_downstream;
  wire [31:0] pe_c2_r3__out5;
  wire [0:0] pe_c2_r3__out5_stop_downstream;
  wire [0:0] pe_c2_r3__out5_valid_downstream;
  elastic_riken_in63_out63_default_U7 pe_c2_r3(
    .CGRA_Clock(pe_c2_r3__CGRA_Clock),
    .CGRA_Enable(pe_c2_r3__CGRA_Enable),
    .CGRA_Reset(pe_c2_r3__CGRA_Reset),
    .ConfigIn(pe_c2_r3__ConfigIn),
    .ConfigOut(pe_c2_r3__ConfigOut),
    .Config_Clock(pe_c2_r3__Config_Clock),
    .Config_Reset(pe_c2_r3__Config_Reset),
    .in0(pe_c2_r3__in0),
    .in0_stop_upstream(pe_c2_r3__in0_stop_upstream),
    .in0_valid_upstream(pe_c2_r3__in0_valid_upstream),
    .in1(pe_c2_r3__in1),
    .in1_stop_upstream(pe_c2_r3__in1_stop_upstream),
    .in1_valid_upstream(pe_c2_r3__in1_valid_upstream),
    .in2(pe_c2_r3__in2),
    .in2_stop_upstream(pe_c2_r3__in2_stop_upstream),
    .in2_valid_upstream(pe_c2_r3__in2_valid_upstream),
    .in3(pe_c2_r3__in3),
    .in3_stop_upstream(pe_c2_r3__in3_stop_upstream),
    .in3_valid_upstream(pe_c2_r3__in3_valid_upstream),
    .in4(pe_c2_r3__in4),
    .in4_stop_upstream(pe_c2_r3__in4_stop_upstream),
    .in4_valid_upstream(pe_c2_r3__in4_valid_upstream),
    .in5(pe_c2_r3__in5),
    .in5_stop_upstream(pe_c2_r3__in5_stop_upstream),
    .in5_valid_upstream(pe_c2_r3__in5_valid_upstream),
    .out0(pe_c2_r3__out0),
    .out0_stop_downstream(pe_c2_r3__out0_stop_downstream),
    .out0_valid_downstream(pe_c2_r3__out0_valid_downstream),
    .out1(pe_c2_r3__out1),
    .out1_stop_downstream(pe_c2_r3__out1_stop_downstream),
    .out1_valid_downstream(pe_c2_r3__out1_valid_downstream),
    .out2(pe_c2_r3__out2),
    .out2_stop_downstream(pe_c2_r3__out2_stop_downstream),
    .out2_valid_downstream(pe_c2_r3__out2_valid_downstream),
    .out3(pe_c2_r3__out3),
    .out3_stop_downstream(pe_c2_r3__out3_stop_downstream),
    .out3_valid_downstream(pe_c2_r3__out3_valid_downstream),
    .out4(pe_c2_r3__out4),
    .out4_stop_downstream(pe_c2_r3__out4_stop_downstream),
    .out4_valid_downstream(pe_c2_r3__out4_valid_downstream),
    .out5(pe_c2_r3__out5),
    .out5_stop_downstream(pe_c2_r3__out5_stop_downstream),
    .out5_valid_downstream(pe_c2_r3__out5_valid_downstream)
  );

  //Wire declarations for instance 'pe_c3_r0' (Module elastic_riken_in143_out143_default_U8)
  wire  pe_c3_r0__CGRA_Clock;
  wire  pe_c3_r0__CGRA_Enable;
  wire  pe_c3_r0__CGRA_Reset;
  wire  pe_c3_r0__ConfigIn;
  wire  pe_c3_r0__ConfigOut;
  wire  pe_c3_r0__Config_Clock;
  wire  pe_c3_r0__Config_Reset;
  wire [31:0] pe_c3_r0__in0;
  wire [0:0] pe_c3_r0__in0_stop_upstream;
  wire [0:0] pe_c3_r0__in0_valid_upstream;
  wire [31:0] pe_c3_r0__in1;
  wire [0:0] pe_c3_r0__in1_stop_upstream;
  wire [0:0] pe_c3_r0__in1_valid_upstream;
  wire [31:0] pe_c3_r0__in2;
  wire [0:0] pe_c3_r0__in2_stop_upstream;
  wire [0:0] pe_c3_r0__in2_valid_upstream;
  wire [31:0] pe_c3_r0__in3;
  wire [0:0] pe_c3_r0__in3_stop_upstream;
  wire [0:0] pe_c3_r0__in3_valid_upstream;
  wire [31:0] pe_c3_r0__in7;
  wire [0:0] pe_c3_r0__in7_stop_upstream;
  wire [0:0] pe_c3_r0__in7_valid_upstream;
  wire [31:0] pe_c3_r0__out0;
  wire [0:0] pe_c3_r0__out0_stop_downstream;
  wire [0:0] pe_c3_r0__out0_valid_downstream;
  wire [31:0] pe_c3_r0__out1;
  wire [0:0] pe_c3_r0__out1_stop_downstream;
  wire [0:0] pe_c3_r0__out1_valid_downstream;
  wire [31:0] pe_c3_r0__out2;
  wire [0:0] pe_c3_r0__out2_stop_downstream;
  wire [0:0] pe_c3_r0__out2_valid_downstream;
  wire [31:0] pe_c3_r0__out3;
  wire [0:0] pe_c3_r0__out3_stop_downstream;
  wire [0:0] pe_c3_r0__out3_valid_downstream;
  wire [31:0] pe_c3_r0__out7;
  wire [0:0] pe_c3_r0__out7_stop_downstream;
  wire [0:0] pe_c3_r0__out7_valid_downstream;
  elastic_riken_in143_out143_default_U8 pe_c3_r0(
    .CGRA_Clock(pe_c3_r0__CGRA_Clock),
    .CGRA_Enable(pe_c3_r0__CGRA_Enable),
    .CGRA_Reset(pe_c3_r0__CGRA_Reset),
    .ConfigIn(pe_c3_r0__ConfigIn),
    .ConfigOut(pe_c3_r0__ConfigOut),
    .Config_Clock(pe_c3_r0__Config_Clock),
    .Config_Reset(pe_c3_r0__Config_Reset),
    .in0(pe_c3_r0__in0),
    .in0_stop_upstream(pe_c3_r0__in0_stop_upstream),
    .in0_valid_upstream(pe_c3_r0__in0_valid_upstream),
    .in1(pe_c3_r0__in1),
    .in1_stop_upstream(pe_c3_r0__in1_stop_upstream),
    .in1_valid_upstream(pe_c3_r0__in1_valid_upstream),
    .in2(pe_c3_r0__in2),
    .in2_stop_upstream(pe_c3_r0__in2_stop_upstream),
    .in2_valid_upstream(pe_c3_r0__in2_valid_upstream),
    .in3(pe_c3_r0__in3),
    .in3_stop_upstream(pe_c3_r0__in3_stop_upstream),
    .in3_valid_upstream(pe_c3_r0__in3_valid_upstream),
    .in7(pe_c3_r0__in7),
    .in7_stop_upstream(pe_c3_r0__in7_stop_upstream),
    .in7_valid_upstream(pe_c3_r0__in7_valid_upstream),
    .out0(pe_c3_r0__out0),
    .out0_stop_downstream(pe_c3_r0__out0_stop_downstream),
    .out0_valid_downstream(pe_c3_r0__out0_valid_downstream),
    .out1(pe_c3_r0__out1),
    .out1_stop_downstream(pe_c3_r0__out1_stop_downstream),
    .out1_valid_downstream(pe_c3_r0__out1_valid_downstream),
    .out2(pe_c3_r0__out2),
    .out2_stop_downstream(pe_c3_r0__out2_stop_downstream),
    .out2_valid_downstream(pe_c3_r0__out2_valid_downstream),
    .out3(pe_c3_r0__out3),
    .out3_stop_downstream(pe_c3_r0__out3_stop_downstream),
    .out3_valid_downstream(pe_c3_r0__out3_valid_downstream),
    .out7(pe_c3_r0__out7),
    .out7_stop_downstream(pe_c3_r0__out7_stop_downstream),
    .out7_valid_downstream(pe_c3_r0__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c3_r1' (Module elastic_riken_in159_out159_default_U9)
  wire  pe_c3_r1__CGRA_Clock;
  wire  pe_c3_r1__CGRA_Enable;
  wire  pe_c3_r1__CGRA_Reset;
  wire  pe_c3_r1__ConfigIn;
  wire  pe_c3_r1__ConfigOut;
  wire  pe_c3_r1__Config_Clock;
  wire  pe_c3_r1__Config_Reset;
  wire [31:0] pe_c3_r1__in0;
  wire [0:0] pe_c3_r1__in0_stop_upstream;
  wire [0:0] pe_c3_r1__in0_valid_upstream;
  wire [31:0] pe_c3_r1__in1;
  wire [0:0] pe_c3_r1__in1_stop_upstream;
  wire [0:0] pe_c3_r1__in1_valid_upstream;
  wire [31:0] pe_c3_r1__in2;
  wire [0:0] pe_c3_r1__in2_stop_upstream;
  wire [0:0] pe_c3_r1__in2_valid_upstream;
  wire [31:0] pe_c3_r1__in3;
  wire [0:0] pe_c3_r1__in3_stop_upstream;
  wire [0:0] pe_c3_r1__in3_valid_upstream;
  wire [31:0] pe_c3_r1__in4;
  wire [0:0] pe_c3_r1__in4_stop_upstream;
  wire [0:0] pe_c3_r1__in4_valid_upstream;
  wire [31:0] pe_c3_r1__in7;
  wire [0:0] pe_c3_r1__in7_stop_upstream;
  wire [0:0] pe_c3_r1__in7_valid_upstream;
  wire [31:0] pe_c3_r1__out0;
  wire [0:0] pe_c3_r1__out0_stop_downstream;
  wire [0:0] pe_c3_r1__out0_valid_downstream;
  wire [31:0] pe_c3_r1__out1;
  wire [0:0] pe_c3_r1__out1_stop_downstream;
  wire [0:0] pe_c3_r1__out1_valid_downstream;
  wire [31:0] pe_c3_r1__out2;
  wire [0:0] pe_c3_r1__out2_stop_downstream;
  wire [0:0] pe_c3_r1__out2_valid_downstream;
  wire [31:0] pe_c3_r1__out3;
  wire [0:0] pe_c3_r1__out3_stop_downstream;
  wire [0:0] pe_c3_r1__out3_valid_downstream;
  wire [31:0] pe_c3_r1__out4;
  wire [0:0] pe_c3_r1__out4_stop_downstream;
  wire [0:0] pe_c3_r1__out4_valid_downstream;
  wire [31:0] pe_c3_r1__out7;
  wire [0:0] pe_c3_r1__out7_stop_downstream;
  wire [0:0] pe_c3_r1__out7_valid_downstream;
  elastic_riken_in159_out159_default_U9 pe_c3_r1(
    .CGRA_Clock(pe_c3_r1__CGRA_Clock),
    .CGRA_Enable(pe_c3_r1__CGRA_Enable),
    .CGRA_Reset(pe_c3_r1__CGRA_Reset),
    .ConfigIn(pe_c3_r1__ConfigIn),
    .ConfigOut(pe_c3_r1__ConfigOut),
    .Config_Clock(pe_c3_r1__Config_Clock),
    .Config_Reset(pe_c3_r1__Config_Reset),
    .in0(pe_c3_r1__in0),
    .in0_stop_upstream(pe_c3_r1__in0_stop_upstream),
    .in0_valid_upstream(pe_c3_r1__in0_valid_upstream),
    .in1(pe_c3_r1__in1),
    .in1_stop_upstream(pe_c3_r1__in1_stop_upstream),
    .in1_valid_upstream(pe_c3_r1__in1_valid_upstream),
    .in2(pe_c3_r1__in2),
    .in2_stop_upstream(pe_c3_r1__in2_stop_upstream),
    .in2_valid_upstream(pe_c3_r1__in2_valid_upstream),
    .in3(pe_c3_r1__in3),
    .in3_stop_upstream(pe_c3_r1__in3_stop_upstream),
    .in3_valid_upstream(pe_c3_r1__in3_valid_upstream),
    .in4(pe_c3_r1__in4),
    .in4_stop_upstream(pe_c3_r1__in4_stop_upstream),
    .in4_valid_upstream(pe_c3_r1__in4_valid_upstream),
    .in7(pe_c3_r1__in7),
    .in7_stop_upstream(pe_c3_r1__in7_stop_upstream),
    .in7_valid_upstream(pe_c3_r1__in7_valid_upstream),
    .out0(pe_c3_r1__out0),
    .out0_stop_downstream(pe_c3_r1__out0_stop_downstream),
    .out0_valid_downstream(pe_c3_r1__out0_valid_downstream),
    .out1(pe_c3_r1__out1),
    .out1_stop_downstream(pe_c3_r1__out1_stop_downstream),
    .out1_valid_downstream(pe_c3_r1__out1_valid_downstream),
    .out2(pe_c3_r1__out2),
    .out2_stop_downstream(pe_c3_r1__out2_stop_downstream),
    .out2_valid_downstream(pe_c3_r1__out2_valid_downstream),
    .out3(pe_c3_r1__out3),
    .out3_stop_downstream(pe_c3_r1__out3_stop_downstream),
    .out3_valid_downstream(pe_c3_r1__out3_valid_downstream),
    .out4(pe_c3_r1__out4),
    .out4_stop_downstream(pe_c3_r1__out4_stop_downstream),
    .out4_valid_downstream(pe_c3_r1__out4_valid_downstream),
    .out7(pe_c3_r1__out7),
    .out7_stop_downstream(pe_c3_r1__out7_stop_downstream),
    .out7_valid_downstream(pe_c3_r1__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c3_r2' (Module elastic_riken_in159_out159_default_U9)
  wire  pe_c3_r2__CGRA_Clock;
  wire  pe_c3_r2__CGRA_Enable;
  wire  pe_c3_r2__CGRA_Reset;
  wire  pe_c3_r2__ConfigIn;
  wire  pe_c3_r2__ConfigOut;
  wire  pe_c3_r2__Config_Clock;
  wire  pe_c3_r2__Config_Reset;
  wire [31:0] pe_c3_r2__in0;
  wire [0:0] pe_c3_r2__in0_stop_upstream;
  wire [0:0] pe_c3_r2__in0_valid_upstream;
  wire [31:0] pe_c3_r2__in1;
  wire [0:0] pe_c3_r2__in1_stop_upstream;
  wire [0:0] pe_c3_r2__in1_valid_upstream;
  wire [31:0] pe_c3_r2__in2;
  wire [0:0] pe_c3_r2__in2_stop_upstream;
  wire [0:0] pe_c3_r2__in2_valid_upstream;
  wire [31:0] pe_c3_r2__in3;
  wire [0:0] pe_c3_r2__in3_stop_upstream;
  wire [0:0] pe_c3_r2__in3_valid_upstream;
  wire [31:0] pe_c3_r2__in4;
  wire [0:0] pe_c3_r2__in4_stop_upstream;
  wire [0:0] pe_c3_r2__in4_valid_upstream;
  wire [31:0] pe_c3_r2__in7;
  wire [0:0] pe_c3_r2__in7_stop_upstream;
  wire [0:0] pe_c3_r2__in7_valid_upstream;
  wire [31:0] pe_c3_r2__out0;
  wire [0:0] pe_c3_r2__out0_stop_downstream;
  wire [0:0] pe_c3_r2__out0_valid_downstream;
  wire [31:0] pe_c3_r2__out1;
  wire [0:0] pe_c3_r2__out1_stop_downstream;
  wire [0:0] pe_c3_r2__out1_valid_downstream;
  wire [31:0] pe_c3_r2__out2;
  wire [0:0] pe_c3_r2__out2_stop_downstream;
  wire [0:0] pe_c3_r2__out2_valid_downstream;
  wire [31:0] pe_c3_r2__out3;
  wire [0:0] pe_c3_r2__out3_stop_downstream;
  wire [0:0] pe_c3_r2__out3_valid_downstream;
  wire [31:0] pe_c3_r2__out4;
  wire [0:0] pe_c3_r2__out4_stop_downstream;
  wire [0:0] pe_c3_r2__out4_valid_downstream;
  wire [31:0] pe_c3_r2__out7;
  wire [0:0] pe_c3_r2__out7_stop_downstream;
  wire [0:0] pe_c3_r2__out7_valid_downstream;
  elastic_riken_in159_out159_default_U9 pe_c3_r2(
    .CGRA_Clock(pe_c3_r2__CGRA_Clock),
    .CGRA_Enable(pe_c3_r2__CGRA_Enable),
    .CGRA_Reset(pe_c3_r2__CGRA_Reset),
    .ConfigIn(pe_c3_r2__ConfigIn),
    .ConfigOut(pe_c3_r2__ConfigOut),
    .Config_Clock(pe_c3_r2__Config_Clock),
    .Config_Reset(pe_c3_r2__Config_Reset),
    .in0(pe_c3_r2__in0),
    .in0_stop_upstream(pe_c3_r2__in0_stop_upstream),
    .in0_valid_upstream(pe_c3_r2__in0_valid_upstream),
    .in1(pe_c3_r2__in1),
    .in1_stop_upstream(pe_c3_r2__in1_stop_upstream),
    .in1_valid_upstream(pe_c3_r2__in1_valid_upstream),
    .in2(pe_c3_r2__in2),
    .in2_stop_upstream(pe_c3_r2__in2_stop_upstream),
    .in2_valid_upstream(pe_c3_r2__in2_valid_upstream),
    .in3(pe_c3_r2__in3),
    .in3_stop_upstream(pe_c3_r2__in3_stop_upstream),
    .in3_valid_upstream(pe_c3_r2__in3_valid_upstream),
    .in4(pe_c3_r2__in4),
    .in4_stop_upstream(pe_c3_r2__in4_stop_upstream),
    .in4_valid_upstream(pe_c3_r2__in4_valid_upstream),
    .in7(pe_c3_r2__in7),
    .in7_stop_upstream(pe_c3_r2__in7_stop_upstream),
    .in7_valid_upstream(pe_c3_r2__in7_valid_upstream),
    .out0(pe_c3_r2__out0),
    .out0_stop_downstream(pe_c3_r2__out0_stop_downstream),
    .out0_valid_downstream(pe_c3_r2__out0_valid_downstream),
    .out1(pe_c3_r2__out1),
    .out1_stop_downstream(pe_c3_r2__out1_stop_downstream),
    .out1_valid_downstream(pe_c3_r2__out1_valid_downstream),
    .out2(pe_c3_r2__out2),
    .out2_stop_downstream(pe_c3_r2__out2_stop_downstream),
    .out2_valid_downstream(pe_c3_r2__out2_valid_downstream),
    .out3(pe_c3_r2__out3),
    .out3_stop_downstream(pe_c3_r2__out3_stop_downstream),
    .out3_valid_downstream(pe_c3_r2__out3_valid_downstream),
    .out4(pe_c3_r2__out4),
    .out4_stop_downstream(pe_c3_r2__out4_stop_downstream),
    .out4_valid_downstream(pe_c3_r2__out4_valid_downstream),
    .out7(pe_c3_r2__out7),
    .out7_stop_downstream(pe_c3_r2__out7_stop_downstream),
    .out7_valid_downstream(pe_c3_r2__out7_valid_downstream)
  );

  //Wire declarations for instance 'pe_c3_r3' (Module elastic_riken_in31_out31_default_U10)
  wire  pe_c3_r3__CGRA_Clock;
  wire  pe_c3_r3__CGRA_Enable;
  wire  pe_c3_r3__CGRA_Reset;
  wire  pe_c3_r3__ConfigIn;
  wire  pe_c3_r3__ConfigOut;
  wire  pe_c3_r3__Config_Clock;
  wire  pe_c3_r3__Config_Reset;
  wire [31:0] pe_c3_r3__in0;
  wire [0:0] pe_c3_r3__in0_stop_upstream;
  wire [0:0] pe_c3_r3__in0_valid_upstream;
  wire [31:0] pe_c3_r3__in1;
  wire [0:0] pe_c3_r3__in1_stop_upstream;
  wire [0:0] pe_c3_r3__in1_valid_upstream;
  wire [31:0] pe_c3_r3__in2;
  wire [0:0] pe_c3_r3__in2_stop_upstream;
  wire [0:0] pe_c3_r3__in2_valid_upstream;
  wire [31:0] pe_c3_r3__in3;
  wire [0:0] pe_c3_r3__in3_stop_upstream;
  wire [0:0] pe_c3_r3__in3_valid_upstream;
  wire [31:0] pe_c3_r3__in4;
  wire [0:0] pe_c3_r3__in4_stop_upstream;
  wire [0:0] pe_c3_r3__in4_valid_upstream;
  wire [31:0] pe_c3_r3__out0;
  wire [0:0] pe_c3_r3__out0_stop_downstream;
  wire [0:0] pe_c3_r3__out0_valid_downstream;
  wire [31:0] pe_c3_r3__out1;
  wire [0:0] pe_c3_r3__out1_stop_downstream;
  wire [0:0] pe_c3_r3__out1_valid_downstream;
  wire [31:0] pe_c3_r3__out2;
  wire [0:0] pe_c3_r3__out2_stop_downstream;
  wire [0:0] pe_c3_r3__out2_valid_downstream;
  wire [31:0] pe_c3_r3__out3;
  wire [0:0] pe_c3_r3__out3_stop_downstream;
  wire [0:0] pe_c3_r3__out3_valid_downstream;
  wire [31:0] pe_c3_r3__out4;
  wire [0:0] pe_c3_r3__out4_stop_downstream;
  wire [0:0] pe_c3_r3__out4_valid_downstream;
  elastic_riken_in31_out31_default_U10 pe_c3_r3(
    .CGRA_Clock(pe_c3_r3__CGRA_Clock),
    .CGRA_Enable(pe_c3_r3__CGRA_Enable),
    .CGRA_Reset(pe_c3_r3__CGRA_Reset),
    .ConfigIn(pe_c3_r3__ConfigIn),
    .ConfigOut(pe_c3_r3__ConfigOut),
    .Config_Clock(pe_c3_r3__Config_Clock),
    .Config_Reset(pe_c3_r3__Config_Reset),
    .in0(pe_c3_r3__in0),
    .in0_stop_upstream(pe_c3_r3__in0_stop_upstream),
    .in0_valid_upstream(pe_c3_r3__in0_valid_upstream),
    .in1(pe_c3_r3__in1),
    .in1_stop_upstream(pe_c3_r3__in1_stop_upstream),
    .in1_valid_upstream(pe_c3_r3__in1_valid_upstream),
    .in2(pe_c3_r3__in2),
    .in2_stop_upstream(pe_c3_r3__in2_stop_upstream),
    .in2_valid_upstream(pe_c3_r3__in2_valid_upstream),
    .in3(pe_c3_r3__in3),
    .in3_stop_upstream(pe_c3_r3__in3_stop_upstream),
    .in3_valid_upstream(pe_c3_r3__in3_valid_upstream),
    .in4(pe_c3_r3__in4),
    .in4_stop_upstream(pe_c3_r3__in4_stop_upstream),
    .in4_valid_upstream(pe_c3_r3__in4_valid_upstream),
    .out0(pe_c3_r3__out0),
    .out0_stop_downstream(pe_c3_r3__out0_stop_downstream),
    .out0_valid_downstream(pe_c3_r3__out0_valid_downstream),
    .out1(pe_c3_r3__out1),
    .out1_stop_downstream(pe_c3_r3__out1_stop_downstream),
    .out1_valid_downstream(pe_c3_r3__out1_valid_downstream),
    .out2(pe_c3_r3__out2),
    .out2_stop_downstream(pe_c3_r3__out2_stop_downstream),
    .out2_valid_downstream(pe_c3_r3__out2_valid_downstream),
    .out3(pe_c3_r3__out3),
    .out3_stop_downstream(pe_c3_r3__out3_stop_downstream),
    .out3_valid_downstream(pe_c3_r3__out3_valid_downstream),
    .out4(pe_c3_r3__out4),
    .out4_stop_downstream(pe_c3_r3__out4_stop_downstream),
    .out4_valid_downstream(pe_c3_r3__out4_valid_downstream)
  );

  //All the connections
  assign io_bottom_0__Config_Clock = Config_Clock;
  assign io_bottom_1__Config_Clock = Config_Clock;
  assign io_bottom_2__Config_Clock = Config_Clock;
  assign io_bottom_3__Config_Clock = Config_Clock;
  assign io_left_0__Config_Clock = Config_Clock;
  assign io_left_1__Config_Clock = Config_Clock;
  assign io_left_2__Config_Clock = Config_Clock;
  assign io_left_3__Config_Clock = Config_Clock;
  assign io_right_0__Config_Clock = Config_Clock;
  assign io_right_1__Config_Clock = Config_Clock;
  assign io_right_2__Config_Clock = Config_Clock;
  assign io_right_3__Config_Clock = Config_Clock;
  assign io_top_0__Config_Clock = Config_Clock;
  assign io_top_1__Config_Clock = Config_Clock;
  assign io_top_2__Config_Clock = Config_Clock;
  assign io_top_3__Config_Clock = Config_Clock;
  assign pe_c0_r0__Config_Clock = Config_Clock;
  assign pe_c0_r1__Config_Clock = Config_Clock;
  assign pe_c0_r2__Config_Clock = Config_Clock;
  assign pe_c0_r3__Config_Clock = Config_Clock;
  assign pe_c1_r0__Config_Clock = Config_Clock;
  assign pe_c1_r1__Config_Clock = Config_Clock;
  assign pe_c1_r2__Config_Clock = Config_Clock;
  assign pe_c1_r3__Config_Clock = Config_Clock;
  assign pe_c2_r0__Config_Clock = Config_Clock;
  assign pe_c2_r1__Config_Clock = Config_Clock;
  assign pe_c2_r2__Config_Clock = Config_Clock;
  assign pe_c2_r3__Config_Clock = Config_Clock;
  assign pe_c3_r0__Config_Clock = Config_Clock;
  assign pe_c3_r1__Config_Clock = Config_Clock;
  assign pe_c3_r2__Config_Clock = Config_Clock;
  assign pe_c3_r3__Config_Clock = Config_Clock;
  assign io_bottom_0__Config_Reset = Config_Reset;
  assign io_bottom_1__Config_Reset = Config_Reset;
  assign io_bottom_2__Config_Reset = Config_Reset;
  assign io_bottom_3__Config_Reset = Config_Reset;
  assign io_left_0__Config_Reset = Config_Reset;
  assign io_left_1__Config_Reset = Config_Reset;
  assign io_left_2__Config_Reset = Config_Reset;
  assign io_left_3__Config_Reset = Config_Reset;
  assign io_right_0__Config_Reset = Config_Reset;
  assign io_right_1__Config_Reset = Config_Reset;
  assign io_right_2__Config_Reset = Config_Reset;
  assign io_right_3__Config_Reset = Config_Reset;
  assign io_top_0__Config_Reset = Config_Reset;
  assign io_top_1__Config_Reset = Config_Reset;
  assign io_top_2__Config_Reset = Config_Reset;
  assign io_top_3__Config_Reset = Config_Reset;
  assign pe_c0_r0__Config_Reset = Config_Reset;
  assign pe_c0_r1__Config_Reset = Config_Reset;
  assign pe_c0_r2__Config_Reset = Config_Reset;
  assign pe_c0_r3__Config_Reset = Config_Reset;
  assign pe_c1_r0__Config_Reset = Config_Reset;
  assign pe_c1_r1__Config_Reset = Config_Reset;
  assign pe_c1_r2__Config_Reset = Config_Reset;
  assign pe_c1_r3__Config_Reset = Config_Reset;
  assign pe_c2_r0__Config_Reset = Config_Reset;
  assign pe_c2_r1__Config_Reset = Config_Reset;
  assign pe_c2_r2__Config_Reset = Config_Reset;
  assign pe_c2_r3__Config_Reset = Config_Reset;
  assign pe_c3_r0__Config_Reset = Config_Reset;
  assign pe_c3_r1__Config_Reset = Config_Reset;
  assign pe_c3_r2__Config_Reset = Config_Reset;
  assign pe_c3_r3__Config_Reset = Config_Reset;
  assign io_bottom_0__CGRA_Clock = CGRA_Clock;
  assign io_bottom_1__CGRA_Clock = CGRA_Clock;
  assign io_bottom_2__CGRA_Clock = CGRA_Clock;
  assign io_bottom_3__CGRA_Clock = CGRA_Clock;
  assign io_left_0__CGRA_Clock = CGRA_Clock;
  assign io_left_1__CGRA_Clock = CGRA_Clock;
  assign io_left_2__CGRA_Clock = CGRA_Clock;
  assign io_left_3__CGRA_Clock = CGRA_Clock;
  assign io_right_0__CGRA_Clock = CGRA_Clock;
  assign io_right_1__CGRA_Clock = CGRA_Clock;
  assign io_right_2__CGRA_Clock = CGRA_Clock;
  assign io_right_3__CGRA_Clock = CGRA_Clock;
  assign io_top_0__CGRA_Clock = CGRA_Clock;
  assign io_top_1__CGRA_Clock = CGRA_Clock;
  assign io_top_2__CGRA_Clock = CGRA_Clock;
  assign io_top_3__CGRA_Clock = CGRA_Clock;
  assign pe_c0_r0__CGRA_Clock = CGRA_Clock;
  assign pe_c0_r1__CGRA_Clock = CGRA_Clock;
  assign pe_c0_r2__CGRA_Clock = CGRA_Clock;
  assign pe_c0_r3__CGRA_Clock = CGRA_Clock;
  assign pe_c1_r0__CGRA_Clock = CGRA_Clock;
  assign pe_c1_r1__CGRA_Clock = CGRA_Clock;
  assign pe_c1_r2__CGRA_Clock = CGRA_Clock;
  assign pe_c1_r3__CGRA_Clock = CGRA_Clock;
  assign pe_c2_r0__CGRA_Clock = CGRA_Clock;
  assign pe_c2_r1__CGRA_Clock = CGRA_Clock;
  assign pe_c2_r2__CGRA_Clock = CGRA_Clock;
  assign pe_c2_r3__CGRA_Clock = CGRA_Clock;
  assign pe_c3_r0__CGRA_Clock = CGRA_Clock;
  assign pe_c3_r1__CGRA_Clock = CGRA_Clock;
  assign pe_c3_r2__CGRA_Clock = CGRA_Clock;
  assign pe_c3_r3__CGRA_Clock = CGRA_Clock;
  assign io_bottom_0__CGRA_Reset = CGRA_Reset;
  assign io_bottom_1__CGRA_Reset = CGRA_Reset;
  assign io_bottom_2__CGRA_Reset = CGRA_Reset;
  assign io_bottom_3__CGRA_Reset = CGRA_Reset;
  assign io_left_0__CGRA_Reset = CGRA_Reset;
  assign io_left_1__CGRA_Reset = CGRA_Reset;
  assign io_left_2__CGRA_Reset = CGRA_Reset;
  assign io_left_3__CGRA_Reset = CGRA_Reset;
  assign io_right_0__CGRA_Reset = CGRA_Reset;
  assign io_right_1__CGRA_Reset = CGRA_Reset;
  assign io_right_2__CGRA_Reset = CGRA_Reset;
  assign io_right_3__CGRA_Reset = CGRA_Reset;
  assign io_top_0__CGRA_Reset = CGRA_Reset;
  assign io_top_1__CGRA_Reset = CGRA_Reset;
  assign io_top_2__CGRA_Reset = CGRA_Reset;
  assign io_top_3__CGRA_Reset = CGRA_Reset;
  assign pe_c0_r0__CGRA_Reset = CGRA_Reset;
  assign pe_c0_r1__CGRA_Reset = CGRA_Reset;
  assign pe_c0_r2__CGRA_Reset = CGRA_Reset;
  assign pe_c0_r3__CGRA_Reset = CGRA_Reset;
  assign pe_c1_r0__CGRA_Reset = CGRA_Reset;
  assign pe_c1_r1__CGRA_Reset = CGRA_Reset;
  assign pe_c1_r2__CGRA_Reset = CGRA_Reset;
  assign pe_c1_r3__CGRA_Reset = CGRA_Reset;
  assign pe_c2_r0__CGRA_Reset = CGRA_Reset;
  assign pe_c2_r1__CGRA_Reset = CGRA_Reset;
  assign pe_c2_r2__CGRA_Reset = CGRA_Reset;
  assign pe_c2_r3__CGRA_Reset = CGRA_Reset;
  assign pe_c3_r0__CGRA_Reset = CGRA_Reset;
  assign pe_c3_r1__CGRA_Reset = CGRA_Reset;
  assign pe_c3_r2__CGRA_Reset = CGRA_Reset;
  assign pe_c3_r3__CGRA_Reset = CGRA_Reset;
  assign io_bottom_0__CGRA_Enable = CGRA_Enable;
  assign io_bottom_1__CGRA_Enable = CGRA_Enable;
  assign io_bottom_2__CGRA_Enable = CGRA_Enable;
  assign io_bottom_3__CGRA_Enable = CGRA_Enable;
  assign io_left_0__CGRA_Enable = CGRA_Enable;
  assign io_left_1__CGRA_Enable = CGRA_Enable;
  assign io_left_2__CGRA_Enable = CGRA_Enable;
  assign io_left_3__CGRA_Enable = CGRA_Enable;
  assign io_right_0__CGRA_Enable = CGRA_Enable;
  assign io_right_1__CGRA_Enable = CGRA_Enable;
  assign io_right_2__CGRA_Enable = CGRA_Enable;
  assign io_right_3__CGRA_Enable = CGRA_Enable;
  assign io_top_0__CGRA_Enable = CGRA_Enable;
  assign io_top_1__CGRA_Enable = CGRA_Enable;
  assign io_top_2__CGRA_Enable = CGRA_Enable;
  assign io_top_3__CGRA_Enable = CGRA_Enable;
  assign pe_c0_r0__CGRA_Enable = CGRA_Enable;
  assign pe_c0_r1__CGRA_Enable = CGRA_Enable;
  assign pe_c0_r2__CGRA_Enable = CGRA_Enable;
  assign pe_c0_r3__CGRA_Enable = CGRA_Enable;
  assign pe_c1_r0__CGRA_Enable = CGRA_Enable;
  assign pe_c1_r1__CGRA_Enable = CGRA_Enable;
  assign pe_c1_r2__CGRA_Enable = CGRA_Enable;
  assign pe_c1_r3__CGRA_Enable = CGRA_Enable;
  assign pe_c2_r0__CGRA_Enable = CGRA_Enable;
  assign pe_c2_r1__CGRA_Enable = CGRA_Enable;
  assign pe_c2_r2__CGRA_Enable = CGRA_Enable;
  assign pe_c2_r3__CGRA_Enable = CGRA_Enable;
  assign pe_c3_r0__CGRA_Enable = CGRA_Enable;
  assign pe_c3_r1__CGRA_Enable = CGRA_Enable;
  assign pe_c3_r2__CGRA_Enable = CGRA_Enable;
  assign pe_c3_r3__CGRA_Enable = CGRA_Enable;
  assign io_top_0__out_stop_downstream[0:0] = pe_c0_r0__in0_stop_upstream[0:0];
  assign pe_c1_r0__out3_stop_downstream[0:0] = pe_c0_r0__in1_stop_upstream[0:0];
  assign pe_c0_r1__out0_stop_downstream[0:0] = pe_c0_r0__in2_stop_upstream[0:0];
  assign io_left_0__out_stop_downstream[0:0] = pe_c0_r0__in3_stop_upstream[0:0];
  assign pe_c1_r1__out4_stop_downstream[0:0] = pe_c0_r0__in6_stop_upstream[0:0];
  assign io_top_0__in[31:0] = pe_c0_r0__out0[31:0];
  assign io_top_0__in_valid_upstream[0:0] = pe_c0_r0__out0_valid_downstream[0:0];
  assign pe_c1_r0__in3[31:0] = pe_c0_r0__out1[31:0];
  assign pe_c1_r0__in3_valid_upstream[0:0] = pe_c0_r0__out1_valid_downstream[0:0];
  assign pe_c0_r1__in0[31:0] = pe_c0_r0__out2[31:0];
  assign pe_c0_r1__in0_valid_upstream[0:0] = pe_c0_r0__out2_valid_downstream[0:0];
  assign io_left_0__in[31:0] = pe_c0_r0__out3[31:0];
  assign io_left_0__in_valid_upstream[0:0] = pe_c0_r0__out3_valid_downstream[0:0];
  assign pe_c1_r1__in4[31:0] = pe_c0_r0__out6[31:0];
  assign pe_c1_r1__in4_valid_upstream[0:0] = pe_c0_r0__out6_valid_downstream[0:0];
  assign pe_c0_r0__out2_stop_downstream[0:0] = pe_c0_r1__in0_stop_upstream[0:0];
  assign pe_c1_r1__out3_stop_downstream[0:0] = pe_c0_r1__in1_stop_upstream[0:0];
  assign pe_c0_r2__out0_stop_downstream[0:0] = pe_c0_r1__in2_stop_upstream[0:0];
  assign io_left_1__out_stop_downstream[0:0] = pe_c0_r1__in3_stop_upstream[0:0];
  assign pe_c1_r0__out7_stop_downstream[0:0] = pe_c0_r1__in5_stop_upstream[0:0];
  assign pe_c1_r2__out4_stop_downstream[0:0] = pe_c0_r1__in6_stop_upstream[0:0];
  assign pe_c0_r0__in2[31:0] = pe_c0_r1__out0[31:0];
  assign pe_c0_r0__in2_valid_upstream[0:0] = pe_c0_r1__out0_valid_downstream[0:0];
  assign pe_c1_r1__in3[31:0] = pe_c0_r1__out1[31:0];
  assign pe_c1_r1__in3_valid_upstream[0:0] = pe_c0_r1__out1_valid_downstream[0:0];
  assign pe_c0_r2__in0[31:0] = pe_c0_r1__out2[31:0];
  assign pe_c0_r2__in0_valid_upstream[0:0] = pe_c0_r1__out2_valid_downstream[0:0];
  assign io_left_1__in[31:0] = pe_c0_r1__out3[31:0];
  assign io_left_1__in_valid_upstream[0:0] = pe_c0_r1__out3_valid_downstream[0:0];
  assign pe_c1_r0__in7[31:0] = pe_c0_r1__out5[31:0];
  assign pe_c1_r0__in7_valid_upstream[0:0] = pe_c0_r1__out5_valid_downstream[0:0];
  assign pe_c1_r2__in4[31:0] = pe_c0_r1__out6[31:0];
  assign pe_c1_r2__in4_valid_upstream[0:0] = pe_c0_r1__out6_valid_downstream[0:0];
  assign pe_c0_r1__out2_stop_downstream[0:0] = pe_c0_r2__in0_stop_upstream[0:0];
  assign pe_c1_r2__out3_stop_downstream[0:0] = pe_c0_r2__in1_stop_upstream[0:0];
  assign pe_c0_r3__out0_stop_downstream[0:0] = pe_c0_r2__in2_stop_upstream[0:0];
  assign io_left_2__out_stop_downstream[0:0] = pe_c0_r2__in3_stop_upstream[0:0];
  assign pe_c1_r1__out7_stop_downstream[0:0] = pe_c0_r2__in5_stop_upstream[0:0];
  assign pe_c1_r3__out4_stop_downstream[0:0] = pe_c0_r2__in6_stop_upstream[0:0];
  assign pe_c0_r1__in2[31:0] = pe_c0_r2__out0[31:0];
  assign pe_c0_r1__in2_valid_upstream[0:0] = pe_c0_r2__out0_valid_downstream[0:0];
  assign pe_c1_r2__in3[31:0] = pe_c0_r2__out1[31:0];
  assign pe_c1_r2__in3_valid_upstream[0:0] = pe_c0_r2__out1_valid_downstream[0:0];
  assign pe_c0_r3__in0[31:0] = pe_c0_r2__out2[31:0];
  assign pe_c0_r3__in0_valid_upstream[0:0] = pe_c0_r2__out2_valid_downstream[0:0];
  assign io_left_2__in[31:0] = pe_c0_r2__out3[31:0];
  assign io_left_2__in_valid_upstream[0:0] = pe_c0_r2__out3_valid_downstream[0:0];
  assign pe_c1_r1__in7[31:0] = pe_c0_r2__out5[31:0];
  assign pe_c1_r1__in7_valid_upstream[0:0] = pe_c0_r2__out5_valid_downstream[0:0];
  assign pe_c1_r3__in4[31:0] = pe_c0_r2__out6[31:0];
  assign pe_c1_r3__in4_valid_upstream[0:0] = pe_c0_r2__out6_valid_downstream[0:0];
  assign pe_c0_r2__out2_stop_downstream[0:0] = pe_c0_r3__in0_stop_upstream[0:0];
  assign pe_c1_r3__out3_stop_downstream[0:0] = pe_c0_r3__in1_stop_upstream[0:0];
  assign io_bottom_0__out_stop_downstream[0:0] = pe_c0_r3__in2_stop_upstream[0:0];
  assign io_left_3__out_stop_downstream[0:0] = pe_c0_r3__in3_stop_upstream[0:0];
  assign pe_c1_r2__out7_stop_downstream[0:0] = pe_c0_r3__in5_stop_upstream[0:0];
  assign pe_c0_r2__in2[31:0] = pe_c0_r3__out0[31:0];
  assign pe_c0_r2__in2_valid_upstream[0:0] = pe_c0_r3__out0_valid_downstream[0:0];
  assign pe_c1_r3__in3[31:0] = pe_c0_r3__out1[31:0];
  assign pe_c1_r3__in3_valid_upstream[0:0] = pe_c0_r3__out1_valid_downstream[0:0];
  assign io_bottom_0__in[31:0] = pe_c0_r3__out2[31:0];
  assign io_bottom_0__in_valid_upstream[0:0] = pe_c0_r3__out2_valid_downstream[0:0];
  assign io_left_3__in[31:0] = pe_c0_r3__out3[31:0];
  assign io_left_3__in_valid_upstream[0:0] = pe_c0_r3__out3_valid_downstream[0:0];
  assign pe_c1_r2__in7[31:0] = pe_c0_r3__out5[31:0];
  assign pe_c1_r2__in7_valid_upstream[0:0] = pe_c0_r3__out5_valid_downstream[0:0];
  assign io_top_1__out_stop_downstream[0:0] = pe_c1_r0__in0_stop_upstream[0:0];
  assign pe_c2_r0__out3_stop_downstream[0:0] = pe_c1_r0__in1_stop_upstream[0:0];
  assign pe_c1_r1__out0_stop_downstream[0:0] = pe_c1_r0__in2_stop_upstream[0:0];
  assign pe_c0_r0__out1_stop_downstream[0:0] = pe_c1_r0__in3_stop_upstream[0:0];
  assign pe_c2_r1__out4_stop_downstream[0:0] = pe_c1_r0__in6_stop_upstream[0:0];
  assign pe_c0_r1__out5_stop_downstream[0:0] = pe_c1_r0__in7_stop_upstream[0:0];
  assign io_top_1__in[31:0] = pe_c1_r0__out0[31:0];
  assign io_top_1__in_valid_upstream[0:0] = pe_c1_r0__out0_valid_downstream[0:0];
  assign pe_c2_r0__in3[31:0] = pe_c1_r0__out1[31:0];
  assign pe_c2_r0__in3_valid_upstream[0:0] = pe_c1_r0__out1_valid_downstream[0:0];
  assign pe_c1_r1__in0[31:0] = pe_c1_r0__out2[31:0];
  assign pe_c1_r1__in0_valid_upstream[0:0] = pe_c1_r0__out2_valid_downstream[0:0];
  assign pe_c0_r0__in1[31:0] = pe_c1_r0__out3[31:0];
  assign pe_c0_r0__in1_valid_upstream[0:0] = pe_c1_r0__out3_valid_downstream[0:0];
  assign pe_c2_r1__in4[31:0] = pe_c1_r0__out6[31:0];
  assign pe_c2_r1__in4_valid_upstream[0:0] = pe_c1_r0__out6_valid_downstream[0:0];
  assign pe_c0_r1__in5[31:0] = pe_c1_r0__out7[31:0];
  assign pe_c0_r1__in5_valid_upstream[0:0] = pe_c1_r0__out7_valid_downstream[0:0];
  assign pe_c1_r0__out2_stop_downstream[0:0] = pe_c1_r1__in0_stop_upstream[0:0];
  assign pe_c2_r1__out3_stop_downstream[0:0] = pe_c1_r1__in1_stop_upstream[0:0];
  assign pe_c1_r2__out0_stop_downstream[0:0] = pe_c1_r1__in2_stop_upstream[0:0];
  assign pe_c0_r1__out1_stop_downstream[0:0] = pe_c1_r1__in3_stop_upstream[0:0];
  assign pe_c0_r0__out6_stop_downstream[0:0] = pe_c1_r1__in4_stop_upstream[0:0];
  assign pe_c2_r0__out7_stop_downstream[0:0] = pe_c1_r1__in5_stop_upstream[0:0];
  assign pe_c2_r2__out4_stop_downstream[0:0] = pe_c1_r1__in6_stop_upstream[0:0];
  assign pe_c0_r2__out5_stop_downstream[0:0] = pe_c1_r1__in7_stop_upstream[0:0];
  assign pe_c1_r0__in2[31:0] = pe_c1_r1__out0[31:0];
  assign pe_c1_r0__in2_valid_upstream[0:0] = pe_c1_r1__out0_valid_downstream[0:0];
  assign pe_c2_r1__in3[31:0] = pe_c1_r1__out1[31:0];
  assign pe_c2_r1__in3_valid_upstream[0:0] = pe_c1_r1__out1_valid_downstream[0:0];
  assign pe_c1_r2__in0[31:0] = pe_c1_r1__out2[31:0];
  assign pe_c1_r2__in0_valid_upstream[0:0] = pe_c1_r1__out2_valid_downstream[0:0];
  assign pe_c0_r1__in1[31:0] = pe_c1_r1__out3[31:0];
  assign pe_c0_r1__in1_valid_upstream[0:0] = pe_c1_r1__out3_valid_downstream[0:0];
  assign pe_c0_r0__in6[31:0] = pe_c1_r1__out4[31:0];
  assign pe_c0_r0__in6_valid_upstream[0:0] = pe_c1_r1__out4_valid_downstream[0:0];
  assign pe_c2_r0__in7[31:0] = pe_c1_r1__out5[31:0];
  assign pe_c2_r0__in7_valid_upstream[0:0] = pe_c1_r1__out5_valid_downstream[0:0];
  assign pe_c2_r2__in4[31:0] = pe_c1_r1__out6[31:0];
  assign pe_c2_r2__in4_valid_upstream[0:0] = pe_c1_r1__out6_valid_downstream[0:0];
  assign pe_c0_r2__in5[31:0] = pe_c1_r1__out7[31:0];
  assign pe_c0_r2__in5_valid_upstream[0:0] = pe_c1_r1__out7_valid_downstream[0:0];
  assign pe_c1_r1__out2_stop_downstream[0:0] = pe_c1_r2__in0_stop_upstream[0:0];
  assign pe_c2_r2__out3_stop_downstream[0:0] = pe_c1_r2__in1_stop_upstream[0:0];
  assign pe_c1_r3__out0_stop_downstream[0:0] = pe_c1_r2__in2_stop_upstream[0:0];
  assign pe_c0_r2__out1_stop_downstream[0:0] = pe_c1_r2__in3_stop_upstream[0:0];
  assign pe_c0_r1__out6_stop_downstream[0:0] = pe_c1_r2__in4_stop_upstream[0:0];
  assign pe_c2_r1__out7_stop_downstream[0:0] = pe_c1_r2__in5_stop_upstream[0:0];
  assign pe_c2_r3__out4_stop_downstream[0:0] = pe_c1_r2__in6_stop_upstream[0:0];
  assign pe_c0_r3__out5_stop_downstream[0:0] = pe_c1_r2__in7_stop_upstream[0:0];
  assign pe_c1_r1__in2[31:0] = pe_c1_r2__out0[31:0];
  assign pe_c1_r1__in2_valid_upstream[0:0] = pe_c1_r2__out0_valid_downstream[0:0];
  assign pe_c2_r2__in3[31:0] = pe_c1_r2__out1[31:0];
  assign pe_c2_r2__in3_valid_upstream[0:0] = pe_c1_r2__out1_valid_downstream[0:0];
  assign pe_c1_r3__in0[31:0] = pe_c1_r2__out2[31:0];
  assign pe_c1_r3__in0_valid_upstream[0:0] = pe_c1_r2__out2_valid_downstream[0:0];
  assign pe_c0_r2__in1[31:0] = pe_c1_r2__out3[31:0];
  assign pe_c0_r2__in1_valid_upstream[0:0] = pe_c1_r2__out3_valid_downstream[0:0];
  assign pe_c0_r1__in6[31:0] = pe_c1_r2__out4[31:0];
  assign pe_c0_r1__in6_valid_upstream[0:0] = pe_c1_r2__out4_valid_downstream[0:0];
  assign pe_c2_r1__in7[31:0] = pe_c1_r2__out5[31:0];
  assign pe_c2_r1__in7_valid_upstream[0:0] = pe_c1_r2__out5_valid_downstream[0:0];
  assign pe_c2_r3__in4[31:0] = pe_c1_r2__out6[31:0];
  assign pe_c2_r3__in4_valid_upstream[0:0] = pe_c1_r2__out6_valid_downstream[0:0];
  assign pe_c0_r3__in5[31:0] = pe_c1_r2__out7[31:0];
  assign pe_c0_r3__in5_valid_upstream[0:0] = pe_c1_r2__out7_valid_downstream[0:0];
  assign pe_c1_r2__out2_stop_downstream[0:0] = pe_c1_r3__in0_stop_upstream[0:0];
  assign pe_c2_r3__out3_stop_downstream[0:0] = pe_c1_r3__in1_stop_upstream[0:0];
  assign io_bottom_1__out_stop_downstream[0:0] = pe_c1_r3__in2_stop_upstream[0:0];
  assign pe_c0_r3__out1_stop_downstream[0:0] = pe_c1_r3__in3_stop_upstream[0:0];
  assign pe_c0_r2__out6_stop_downstream[0:0] = pe_c1_r3__in4_stop_upstream[0:0];
  assign pe_c2_r2__out7_stop_downstream[0:0] = pe_c1_r3__in5_stop_upstream[0:0];
  assign pe_c1_r2__in2[31:0] = pe_c1_r3__out0[31:0];
  assign pe_c1_r2__in2_valid_upstream[0:0] = pe_c1_r3__out0_valid_downstream[0:0];
  assign pe_c2_r3__in3[31:0] = pe_c1_r3__out1[31:0];
  assign pe_c2_r3__in3_valid_upstream[0:0] = pe_c1_r3__out1_valid_downstream[0:0];
  assign io_bottom_1__in[31:0] = pe_c1_r3__out2[31:0];
  assign io_bottom_1__in_valid_upstream[0:0] = pe_c1_r3__out2_valid_downstream[0:0];
  assign pe_c0_r3__in1[31:0] = pe_c1_r3__out3[31:0];
  assign pe_c0_r3__in1_valid_upstream[0:0] = pe_c1_r3__out3_valid_downstream[0:0];
  assign pe_c0_r2__in6[31:0] = pe_c1_r3__out4[31:0];
  assign pe_c0_r2__in6_valid_upstream[0:0] = pe_c1_r3__out4_valid_downstream[0:0];
  assign pe_c2_r2__in7[31:0] = pe_c1_r3__out5[31:0];
  assign pe_c2_r2__in7_valid_upstream[0:0] = pe_c1_r3__out5_valid_downstream[0:0];
  assign io_top_2__out_stop_downstream[0:0] = pe_c2_r0__in0_stop_upstream[0:0];
  assign pe_c3_r0__out3_stop_downstream[0:0] = pe_c2_r0__in1_stop_upstream[0:0];
  assign pe_c2_r1__out0_stop_downstream[0:0] = pe_c2_r0__in2_stop_upstream[0:0];
  assign pe_c1_r0__out1_stop_downstream[0:0] = pe_c2_r0__in3_stop_upstream[0:0];
  assign pe_c3_r1__out4_stop_downstream[0:0] = pe_c2_r0__in6_stop_upstream[0:0];
  assign pe_c1_r1__out5_stop_downstream[0:0] = pe_c2_r0__in7_stop_upstream[0:0];
  assign io_top_2__in[31:0] = pe_c2_r0__out0[31:0];
  assign io_top_2__in_valid_upstream[0:0] = pe_c2_r0__out0_valid_downstream[0:0];
  assign pe_c3_r0__in3[31:0] = pe_c2_r0__out1[31:0];
  assign pe_c3_r0__in3_valid_upstream[0:0] = pe_c2_r0__out1_valid_downstream[0:0];
  assign pe_c2_r1__in0[31:0] = pe_c2_r0__out2[31:0];
  assign pe_c2_r1__in0_valid_upstream[0:0] = pe_c2_r0__out2_valid_downstream[0:0];
  assign pe_c1_r0__in1[31:0] = pe_c2_r0__out3[31:0];
  assign pe_c1_r0__in1_valid_upstream[0:0] = pe_c2_r0__out3_valid_downstream[0:0];
  assign pe_c3_r1__in4[31:0] = pe_c2_r0__out6[31:0];
  assign pe_c3_r1__in4_valid_upstream[0:0] = pe_c2_r0__out6_valid_downstream[0:0];
  assign pe_c1_r1__in5[31:0] = pe_c2_r0__out7[31:0];
  assign pe_c1_r1__in5_valid_upstream[0:0] = pe_c2_r0__out7_valid_downstream[0:0];
  assign pe_c2_r0__out2_stop_downstream[0:0] = pe_c2_r1__in0_stop_upstream[0:0];
  assign pe_c3_r1__out3_stop_downstream[0:0] = pe_c2_r1__in1_stop_upstream[0:0];
  assign pe_c2_r2__out0_stop_downstream[0:0] = pe_c2_r1__in2_stop_upstream[0:0];
  assign pe_c1_r1__out1_stop_downstream[0:0] = pe_c2_r1__in3_stop_upstream[0:0];
  assign pe_c1_r0__out6_stop_downstream[0:0] = pe_c2_r1__in4_stop_upstream[0:0];
  assign pe_c3_r0__out7_stop_downstream[0:0] = pe_c2_r1__in5_stop_upstream[0:0];
  assign pe_c3_r2__out4_stop_downstream[0:0] = pe_c2_r1__in6_stop_upstream[0:0];
  assign pe_c1_r2__out5_stop_downstream[0:0] = pe_c2_r1__in7_stop_upstream[0:0];
  assign pe_c2_r0__in2[31:0] = pe_c2_r1__out0[31:0];
  assign pe_c2_r0__in2_valid_upstream[0:0] = pe_c2_r1__out0_valid_downstream[0:0];
  assign pe_c3_r1__in3[31:0] = pe_c2_r1__out1[31:0];
  assign pe_c3_r1__in3_valid_upstream[0:0] = pe_c2_r1__out1_valid_downstream[0:0];
  assign pe_c2_r2__in0[31:0] = pe_c2_r1__out2[31:0];
  assign pe_c2_r2__in0_valid_upstream[0:0] = pe_c2_r1__out2_valid_downstream[0:0];
  assign pe_c1_r1__in1[31:0] = pe_c2_r1__out3[31:0];
  assign pe_c1_r1__in1_valid_upstream[0:0] = pe_c2_r1__out3_valid_downstream[0:0];
  assign pe_c1_r0__in6[31:0] = pe_c2_r1__out4[31:0];
  assign pe_c1_r0__in6_valid_upstream[0:0] = pe_c2_r1__out4_valid_downstream[0:0];
  assign pe_c3_r0__in7[31:0] = pe_c2_r1__out5[31:0];
  assign pe_c3_r0__in7_valid_upstream[0:0] = pe_c2_r1__out5_valid_downstream[0:0];
  assign pe_c3_r2__in4[31:0] = pe_c2_r1__out6[31:0];
  assign pe_c3_r2__in4_valid_upstream[0:0] = pe_c2_r1__out6_valid_downstream[0:0];
  assign pe_c1_r2__in5[31:0] = pe_c2_r1__out7[31:0];
  assign pe_c1_r2__in5_valid_upstream[0:0] = pe_c2_r1__out7_valid_downstream[0:0];
  assign pe_c2_r1__out2_stop_downstream[0:0] = pe_c2_r2__in0_stop_upstream[0:0];
  assign pe_c3_r2__out3_stop_downstream[0:0] = pe_c2_r2__in1_stop_upstream[0:0];
  assign pe_c2_r3__out0_stop_downstream[0:0] = pe_c2_r2__in2_stop_upstream[0:0];
  assign pe_c1_r2__out1_stop_downstream[0:0] = pe_c2_r2__in3_stop_upstream[0:0];
  assign pe_c1_r1__out6_stop_downstream[0:0] = pe_c2_r2__in4_stop_upstream[0:0];
  assign pe_c3_r1__out7_stop_downstream[0:0] = pe_c2_r2__in5_stop_upstream[0:0];
  assign pe_c3_r3__out4_stop_downstream[0:0] = pe_c2_r2__in6_stop_upstream[0:0];
  assign pe_c1_r3__out5_stop_downstream[0:0] = pe_c2_r2__in7_stop_upstream[0:0];
  assign pe_c2_r1__in2[31:0] = pe_c2_r2__out0[31:0];
  assign pe_c2_r1__in2_valid_upstream[0:0] = pe_c2_r2__out0_valid_downstream[0:0];
  assign pe_c3_r2__in3[31:0] = pe_c2_r2__out1[31:0];
  assign pe_c3_r2__in3_valid_upstream[0:0] = pe_c2_r2__out1_valid_downstream[0:0];
  assign pe_c2_r3__in0[31:0] = pe_c2_r2__out2[31:0];
  assign pe_c2_r3__in0_valid_upstream[0:0] = pe_c2_r2__out2_valid_downstream[0:0];
  assign pe_c1_r2__in1[31:0] = pe_c2_r2__out3[31:0];
  assign pe_c1_r2__in1_valid_upstream[0:0] = pe_c2_r2__out3_valid_downstream[0:0];
  assign pe_c1_r1__in6[31:0] = pe_c2_r2__out4[31:0];
  assign pe_c1_r1__in6_valid_upstream[0:0] = pe_c2_r2__out4_valid_downstream[0:0];
  assign pe_c3_r1__in7[31:0] = pe_c2_r2__out5[31:0];
  assign pe_c3_r1__in7_valid_upstream[0:0] = pe_c2_r2__out5_valid_downstream[0:0];
  assign pe_c3_r3__in4[31:0] = pe_c2_r2__out6[31:0];
  assign pe_c3_r3__in4_valid_upstream[0:0] = pe_c2_r2__out6_valid_downstream[0:0];
  assign pe_c1_r3__in5[31:0] = pe_c2_r2__out7[31:0];
  assign pe_c1_r3__in5_valid_upstream[0:0] = pe_c2_r2__out7_valid_downstream[0:0];
  assign pe_c2_r2__out2_stop_downstream[0:0] = pe_c2_r3__in0_stop_upstream[0:0];
  assign pe_c3_r3__out3_stop_downstream[0:0] = pe_c2_r3__in1_stop_upstream[0:0];
  assign io_bottom_2__out_stop_downstream[0:0] = pe_c2_r3__in2_stop_upstream[0:0];
  assign pe_c1_r3__out1_stop_downstream[0:0] = pe_c2_r3__in3_stop_upstream[0:0];
  assign pe_c1_r2__out6_stop_downstream[0:0] = pe_c2_r3__in4_stop_upstream[0:0];
  assign pe_c3_r2__out7_stop_downstream[0:0] = pe_c2_r3__in5_stop_upstream[0:0];
  assign pe_c2_r2__in2[31:0] = pe_c2_r3__out0[31:0];
  assign pe_c2_r2__in2_valid_upstream[0:0] = pe_c2_r3__out0_valid_downstream[0:0];
  assign pe_c3_r3__in3[31:0] = pe_c2_r3__out1[31:0];
  assign pe_c3_r3__in3_valid_upstream[0:0] = pe_c2_r3__out1_valid_downstream[0:0];
  assign io_bottom_2__in[31:0] = pe_c2_r3__out2[31:0];
  assign io_bottom_2__in_valid_upstream[0:0] = pe_c2_r3__out2_valid_downstream[0:0];
  assign pe_c1_r3__in1[31:0] = pe_c2_r3__out3[31:0];
  assign pe_c1_r3__in1_valid_upstream[0:0] = pe_c2_r3__out3_valid_downstream[0:0];
  assign pe_c1_r2__in6[31:0] = pe_c2_r3__out4[31:0];
  assign pe_c1_r2__in6_valid_upstream[0:0] = pe_c2_r3__out4_valid_downstream[0:0];
  assign pe_c3_r2__in7[31:0] = pe_c2_r3__out5[31:0];
  assign pe_c3_r2__in7_valid_upstream[0:0] = pe_c2_r3__out5_valid_downstream[0:0];
  assign io_top_3__out_stop_downstream[0:0] = pe_c3_r0__in0_stop_upstream[0:0];
  assign io_right_0__out_stop_downstream[0:0] = pe_c3_r0__in1_stop_upstream[0:0];
  assign pe_c3_r1__out0_stop_downstream[0:0] = pe_c3_r0__in2_stop_upstream[0:0];
  assign pe_c2_r0__out1_stop_downstream[0:0] = pe_c3_r0__in3_stop_upstream[0:0];
  assign pe_c2_r1__out5_stop_downstream[0:0] = pe_c3_r0__in7_stop_upstream[0:0];
  assign io_top_3__in[31:0] = pe_c3_r0__out0[31:0];
  assign io_top_3__in_valid_upstream[0:0] = pe_c3_r0__out0_valid_downstream[0:0];
  assign io_right_0__in[31:0] = pe_c3_r0__out1[31:0];
  assign io_right_0__in_valid_upstream[0:0] = pe_c3_r0__out1_valid_downstream[0:0];
  assign pe_c3_r1__in0[31:0] = pe_c3_r0__out2[31:0];
  assign pe_c3_r1__in0_valid_upstream[0:0] = pe_c3_r0__out2_valid_downstream[0:0];
  assign pe_c2_r0__in1[31:0] = pe_c3_r0__out3[31:0];
  assign pe_c2_r0__in1_valid_upstream[0:0] = pe_c3_r0__out3_valid_downstream[0:0];
  assign pe_c2_r1__in5[31:0] = pe_c3_r0__out7[31:0];
  assign pe_c2_r1__in5_valid_upstream[0:0] = pe_c3_r0__out7_valid_downstream[0:0];
  assign pe_c3_r0__out2_stop_downstream[0:0] = pe_c3_r1__in0_stop_upstream[0:0];
  assign io_right_1__out_stop_downstream[0:0] = pe_c3_r1__in1_stop_upstream[0:0];
  assign pe_c3_r2__out0_stop_downstream[0:0] = pe_c3_r1__in2_stop_upstream[0:0];
  assign pe_c2_r1__out1_stop_downstream[0:0] = pe_c3_r1__in3_stop_upstream[0:0];
  assign pe_c2_r0__out6_stop_downstream[0:0] = pe_c3_r1__in4_stop_upstream[0:0];
  assign pe_c2_r2__out5_stop_downstream[0:0] = pe_c3_r1__in7_stop_upstream[0:0];
  assign pe_c3_r0__in2[31:0] = pe_c3_r1__out0[31:0];
  assign pe_c3_r0__in2_valid_upstream[0:0] = pe_c3_r1__out0_valid_downstream[0:0];
  assign io_right_1__in[31:0] = pe_c3_r1__out1[31:0];
  assign io_right_1__in_valid_upstream[0:0] = pe_c3_r1__out1_valid_downstream[0:0];
  assign pe_c3_r2__in0[31:0] = pe_c3_r1__out2[31:0];
  assign pe_c3_r2__in0_valid_upstream[0:0] = pe_c3_r1__out2_valid_downstream[0:0];
  assign pe_c2_r1__in1[31:0] = pe_c3_r1__out3[31:0];
  assign pe_c2_r1__in1_valid_upstream[0:0] = pe_c3_r1__out3_valid_downstream[0:0];
  assign pe_c2_r0__in6[31:0] = pe_c3_r1__out4[31:0];
  assign pe_c2_r0__in6_valid_upstream[0:0] = pe_c3_r1__out4_valid_downstream[0:0];
  assign pe_c2_r2__in5[31:0] = pe_c3_r1__out7[31:0];
  assign pe_c2_r2__in5_valid_upstream[0:0] = pe_c3_r1__out7_valid_downstream[0:0];
  assign pe_c3_r1__out2_stop_downstream[0:0] = pe_c3_r2__in0_stop_upstream[0:0];
  assign io_right_2__out_stop_downstream[0:0] = pe_c3_r2__in1_stop_upstream[0:0];
  assign pe_c3_r3__out0_stop_downstream[0:0] = pe_c3_r2__in2_stop_upstream[0:0];
  assign pe_c2_r2__out1_stop_downstream[0:0] = pe_c3_r2__in3_stop_upstream[0:0];
  assign pe_c2_r1__out6_stop_downstream[0:0] = pe_c3_r2__in4_stop_upstream[0:0];
  assign pe_c2_r3__out5_stop_downstream[0:0] = pe_c3_r2__in7_stop_upstream[0:0];
  assign pe_c3_r1__in2[31:0] = pe_c3_r2__out0[31:0];
  assign pe_c3_r1__in2_valid_upstream[0:0] = pe_c3_r2__out0_valid_downstream[0:0];
  assign io_right_2__in[31:0] = pe_c3_r2__out1[31:0];
  assign io_right_2__in_valid_upstream[0:0] = pe_c3_r2__out1_valid_downstream[0:0];
  assign pe_c3_r3__in0[31:0] = pe_c3_r2__out2[31:0];
  assign pe_c3_r3__in0_valid_upstream[0:0] = pe_c3_r2__out2_valid_downstream[0:0];
  assign pe_c2_r2__in1[31:0] = pe_c3_r2__out3[31:0];
  assign pe_c2_r2__in1_valid_upstream[0:0] = pe_c3_r2__out3_valid_downstream[0:0];
  assign pe_c2_r1__in6[31:0] = pe_c3_r2__out4[31:0];
  assign pe_c2_r1__in6_valid_upstream[0:0] = pe_c3_r2__out4_valid_downstream[0:0];
  assign pe_c2_r3__in5[31:0] = pe_c3_r2__out7[31:0];
  assign pe_c2_r3__in5_valid_upstream[0:0] = pe_c3_r2__out7_valid_downstream[0:0];
  assign pe_c3_r2__out2_stop_downstream[0:0] = pe_c3_r3__in0_stop_upstream[0:0];
  assign io_right_3__out_stop_downstream[0:0] = pe_c3_r3__in1_stop_upstream[0:0];
  assign io_bottom_3__out_stop_downstream[0:0] = pe_c3_r3__in2_stop_upstream[0:0];
  assign pe_c2_r3__out1_stop_downstream[0:0] = pe_c3_r3__in3_stop_upstream[0:0];
  assign pe_c2_r2__out6_stop_downstream[0:0] = pe_c3_r3__in4_stop_upstream[0:0];
  assign pe_c3_r2__in2[31:0] = pe_c3_r3__out0[31:0];
  assign pe_c3_r2__in2_valid_upstream[0:0] = pe_c3_r3__out0_valid_downstream[0:0];
  assign io_right_3__in[31:0] = pe_c3_r3__out1[31:0];
  assign io_right_3__in_valid_upstream[0:0] = pe_c3_r3__out1_valid_downstream[0:0];
  assign io_bottom_3__in[31:0] = pe_c3_r3__out2[31:0];
  assign io_bottom_3__in_valid_upstream[0:0] = pe_c3_r3__out2_valid_downstream[0:0];
  assign pe_c2_r3__in1[31:0] = pe_c3_r3__out3[31:0];
  assign pe_c2_r3__in1_valid_upstream[0:0] = pe_c3_r3__out3_valid_downstream[0:0];
  assign pe_c2_r2__in6[31:0] = pe_c3_r3__out4[31:0];
  assign pe_c2_r2__in6_valid_upstream[0:0] = pe_c3_r3__out4_valid_downstream[0:0];
  assign pe_c0_r0__out0_stop_downstream[0:0] = io_top_0__in_stop_upstream[0:0];
  assign pe_c0_r0__in0[31:0] = io_top_0__out[31:0];
  assign pe_c0_r0__in0_valid_upstream[0:0] = io_top_0__out_valid_downstream[0:0];
  assign pe_c0_r3__out2_stop_downstream[0:0] = io_bottom_0__in_stop_upstream[0:0];
  assign pe_c0_r3__in2[31:0] = io_bottom_0__out[31:0];
  assign pe_c0_r3__in2_valid_upstream[0:0] = io_bottom_0__out_valid_downstream[0:0];
  assign pe_c1_r0__out0_stop_downstream[0:0] = io_top_1__in_stop_upstream[0:0];
  assign pe_c1_r0__in0[31:0] = io_top_1__out[31:0];
  assign pe_c1_r0__in0_valid_upstream[0:0] = io_top_1__out_valid_downstream[0:0];
  assign pe_c1_r3__out2_stop_downstream[0:0] = io_bottom_1__in_stop_upstream[0:0];
  assign pe_c1_r3__in2[31:0] = io_bottom_1__out[31:0];
  assign pe_c1_r3__in2_valid_upstream[0:0] = io_bottom_1__out_valid_downstream[0:0];
  assign pe_c2_r0__out0_stop_downstream[0:0] = io_top_2__in_stop_upstream[0:0];
  assign pe_c2_r0__in0[31:0] = io_top_2__out[31:0];
  assign pe_c2_r0__in0_valid_upstream[0:0] = io_top_2__out_valid_downstream[0:0];
  assign pe_c2_r3__out2_stop_downstream[0:0] = io_bottom_2__in_stop_upstream[0:0];
  assign pe_c2_r3__in2[31:0] = io_bottom_2__out[31:0];
  assign pe_c2_r3__in2_valid_upstream[0:0] = io_bottom_2__out_valid_downstream[0:0];
  assign pe_c3_r0__out0_stop_downstream[0:0] = io_top_3__in_stop_upstream[0:0];
  assign pe_c3_r0__in0[31:0] = io_top_3__out[31:0];
  assign pe_c3_r0__in0_valid_upstream[0:0] = io_top_3__out_valid_downstream[0:0];
  assign pe_c3_r3__out2_stop_downstream[0:0] = io_bottom_3__in_stop_upstream[0:0];
  assign pe_c3_r3__in2[31:0] = io_bottom_3__out[31:0];
  assign pe_c3_r3__in2_valid_upstream[0:0] = io_bottom_3__out_valid_downstream[0:0];
  assign pe_c0_r0__out3_stop_downstream[0:0] = io_left_0__in_stop_upstream[0:0];
  assign pe_c0_r0__in3[31:0] = io_left_0__out[31:0];
  assign pe_c0_r0__in3_valid_upstream[0:0] = io_left_0__out_valid_downstream[0:0];
  assign pe_c3_r0__out1_stop_downstream[0:0] = io_right_0__in_stop_upstream[0:0];
  assign pe_c3_r0__in1[31:0] = io_right_0__out[31:0];
  assign pe_c3_r0__in1_valid_upstream[0:0] = io_right_0__out_valid_downstream[0:0];
  assign pe_c0_r1__out3_stop_downstream[0:0] = io_left_1__in_stop_upstream[0:0];
  assign pe_c0_r1__in3[31:0] = io_left_1__out[31:0];
  assign pe_c0_r1__in3_valid_upstream[0:0] = io_left_1__out_valid_downstream[0:0];
  assign pe_c3_r1__out1_stop_downstream[0:0] = io_right_1__in_stop_upstream[0:0];
  assign pe_c3_r1__in1[31:0] = io_right_1__out[31:0];
  assign pe_c3_r1__in1_valid_upstream[0:0] = io_right_1__out_valid_downstream[0:0];
  assign pe_c0_r2__out3_stop_downstream[0:0] = io_left_2__in_stop_upstream[0:0];
  assign pe_c0_r2__in3[31:0] = io_left_2__out[31:0];
  assign pe_c0_r2__in3_valid_upstream[0:0] = io_left_2__out_valid_downstream[0:0];
  assign pe_c3_r2__out1_stop_downstream[0:0] = io_right_2__in_stop_upstream[0:0];
  assign pe_c3_r2__in1[31:0] = io_right_2__out[31:0];
  assign pe_c3_r2__in1_valid_upstream[0:0] = io_right_2__out_valid_downstream[0:0];
  assign pe_c0_r3__out3_stop_downstream[0:0] = io_left_3__in_stop_upstream[0:0];
  assign pe_c0_r3__in3[31:0] = io_left_3__out[31:0];
  assign pe_c0_r3__in3_valid_upstream[0:0] = io_left_3__out_valid_downstream[0:0];
  assign pe_c3_r3__out1_stop_downstream[0:0] = io_right_3__in_stop_upstream[0:0];
  assign pe_c3_r3__in1[31:0] = io_right_3__out[31:0];
  assign pe_c3_r3__in1_valid_upstream[0:0] = io_right_3__out_valid_downstream[0:0];
  assign io_bottom_0__ConfigIn = ConfigIn;
  assign io_bottom_1__ConfigIn = io_bottom_0__ConfigOut;
  assign io_bottom_2__ConfigIn = io_bottom_1__ConfigOut;
  assign io_bottom_3__ConfigIn = io_bottom_2__ConfigOut;
  assign io_left_0__ConfigIn = io_bottom_3__ConfigOut;
  assign io_left_1__ConfigIn = io_left_0__ConfigOut;
  assign io_left_2__ConfigIn = io_left_1__ConfigOut;
  assign io_left_3__ConfigIn = io_left_2__ConfigOut;
  assign io_right_0__ConfigIn = io_left_3__ConfigOut;
  assign io_right_1__ConfigIn = io_right_0__ConfigOut;
  assign io_right_2__ConfigIn = io_right_1__ConfigOut;
  assign io_right_3__ConfigIn = io_right_2__ConfigOut;
  assign io_top_0__ConfigIn = io_right_3__ConfigOut;
  assign io_top_1__ConfigIn = io_top_0__ConfigOut;
  assign io_top_2__ConfigIn = io_top_1__ConfigOut;
  assign io_top_3__ConfigIn = io_top_2__ConfigOut;
  assign pe_c0_r0__ConfigIn = io_top_3__ConfigOut;
  assign pe_c0_r1__ConfigIn = pe_c0_r0__ConfigOut;
  assign pe_c0_r2__ConfigIn = pe_c0_r1__ConfigOut;
  assign pe_c0_r3__ConfigIn = pe_c0_r2__ConfigOut;
  assign pe_c1_r0__ConfigIn = pe_c0_r3__ConfigOut;
  assign pe_c1_r1__ConfigIn = pe_c1_r0__ConfigOut;
  assign pe_c1_r2__ConfigIn = pe_c1_r1__ConfigOut;
  assign pe_c1_r3__ConfigIn = pe_c1_r2__ConfigOut;
  assign pe_c2_r0__ConfigIn = pe_c1_r3__ConfigOut;
  assign pe_c2_r1__ConfigIn = pe_c2_r0__ConfigOut;
  assign pe_c2_r2__ConfigIn = pe_c2_r1__ConfigOut;
  assign pe_c2_r3__ConfigIn = pe_c2_r2__ConfigOut;
  assign pe_c3_r0__ConfigIn = pe_c2_r3__ConfigOut;
  assign pe_c3_r1__ConfigIn = pe_c3_r0__ConfigOut;
  assign pe_c3_r2__ConfigIn = pe_c3_r1__ConfigOut;
  assign pe_c3_r3__ConfigIn = pe_c3_r2__ConfigOut;
  assign ConfigOut = pe_c3_r3__ConfigOut;
  assign io_bottom_0__bidir_in[31:0] = io_bottom_0_bidir_in[31:0];
  assign io_bottom_0_bidir_out[31:0] = io_bottom_0__bidir_out[31:0];
  assign io_bottom_0__bidir_in_valid_upstream[0:0] = io_bottom_0_bidir_in_valid_upstream[0:0];
  assign io_bottom_0_bidir_in_stop_upstream[0:0] = io_bottom_0__bidir_in_stop_upstream[0:0];
  assign io_bottom_0_bidir_out_valid_downstream[0:0] = io_bottom_0__bidir_out_valid_downstream[0:0];
  assign io_bottom_0__bidir_out_stop_downstream[0:0] = io_bottom_0_bidir_out_stop_downstream[0:0];
  assign io_bottom_1__bidir_in[31:0] = io_bottom_1_bidir_in[31:0];
  assign io_bottom_1_bidir_out[31:0] = io_bottom_1__bidir_out[31:0];
  assign io_bottom_1__bidir_in_valid_upstream[0:0] = io_bottom_1_bidir_in_valid_upstream[0:0];
  assign io_bottom_1_bidir_in_stop_upstream[0:0] = io_bottom_1__bidir_in_stop_upstream[0:0];
  assign io_bottom_1_bidir_out_valid_downstream[0:0] = io_bottom_1__bidir_out_valid_downstream[0:0];
  assign io_bottom_1__bidir_out_stop_downstream[0:0] = io_bottom_1_bidir_out_stop_downstream[0:0];
  assign io_bottom_2__bidir_in[31:0] = io_bottom_2_bidir_in[31:0];
  assign io_bottom_2_bidir_out[31:0] = io_bottom_2__bidir_out[31:0];
  assign io_bottom_2__bidir_in_valid_upstream[0:0] = io_bottom_2_bidir_in_valid_upstream[0:0];
  assign io_bottom_2_bidir_in_stop_upstream[0:0] = io_bottom_2__bidir_in_stop_upstream[0:0];
  assign io_bottom_2_bidir_out_valid_downstream[0:0] = io_bottom_2__bidir_out_valid_downstream[0:0];
  assign io_bottom_2__bidir_out_stop_downstream[0:0] = io_bottom_2_bidir_out_stop_downstream[0:0];
  assign io_bottom_3__bidir_in_valid_upstream[0:0] = io_bottom_3_bidir_in_valid_upstream[0:0];
  assign io_bottom_3__bidir_in[31:0] = io_bottom_3_bidir_in[31:0];
  assign io_bottom_3_bidir_out[31:0] = io_bottom_3__bidir_out[31:0];
  assign io_bottom_3_bidir_in_stop_upstream[0:0] = io_bottom_3__bidir_in_stop_upstream[0:0];
  assign io_bottom_3_bidir_out_valid_downstream[0:0] = io_bottom_3__bidir_out_valid_downstream[0:0];
  assign io_bottom_3__bidir_out_stop_downstream[0:0] = io_bottom_3_bidir_out_stop_downstream[0:0];
  assign io_left_0__bidir_in[31:0] = io_left_0_bidir_in[31:0];
  assign io_left_0_bidir_in_stop_upstream[0:0] = io_left_0__bidir_in_stop_upstream[0:0];
  assign io_left_0_bidir_out[31:0] = io_left_0__bidir_out[31:0];
  assign io_left_0__bidir_in_valid_upstream[0:0] = io_left_0_bidir_in_valid_upstream[0:0];
  assign io_left_0_bidir_out_valid_downstream[0:0] = io_left_0__bidir_out_valid_downstream[0:0];
  assign io_left_0__bidir_out_stop_downstream[0:0] = io_left_0_bidir_out_stop_downstream[0:0];
  assign io_right_1__bidir_in[31:0] = io_right_1_bidir_in[31:0];
  assign io_left_1__bidir_in[31:0] = io_left_1_bidir_in[31:0];
  assign io_left_1__bidir_in_valid_upstream[0:0] = io_left_1_bidir_in_valid_upstream[0:0];
  assign io_left_1_bidir_out[31:0] = io_left_1__bidir_out[31:0];
  assign io_left_1_bidir_in_stop_upstream[0:0] = io_left_1__bidir_in_stop_upstream[0:0];
  assign io_left_2__bidir_in[31:0] = io_left_2_bidir_in[31:0];
  assign io_left_1_bidir_out_valid_downstream[0:0] = io_left_1__bidir_out_valid_downstream[0:0];
  assign io_left_1__bidir_out_stop_downstream[0:0] = io_left_1_bidir_out_stop_downstream[0:0];
  assign io_left_2_bidir_out[31:0] = io_left_2__bidir_out[31:0];
  assign io_left_2__bidir_in_valid_upstream[0:0] = io_left_2_bidir_in_valid_upstream[0:0];
  assign io_left_2_bidir_in_stop_upstream[0:0] = io_left_2__bidir_in_stop_upstream[0:0];
  assign io_left_2_bidir_out_valid_downstream[0:0] = io_left_2__bidir_out_valid_downstream[0:0];
  assign io_left_2__bidir_out_stop_downstream[0:0] = io_left_2_bidir_out_stop_downstream[0:0];
  assign io_left_3__bidir_in[31:0] = io_left_3_bidir_in[31:0];
  assign io_left_3_bidir_out[31:0] = io_left_3__bidir_out[31:0];
  assign io_left_3__bidir_in_valid_upstream[0:0] = io_left_3_bidir_in_valid_upstream[0:0];
  assign io_left_3_bidir_in_stop_upstream[0:0] = io_left_3__bidir_in_stop_upstream[0:0];
  assign io_left_3_bidir_out_valid_downstream[0:0] = io_left_3__bidir_out_valid_downstream[0:0];
  assign io_left_3__bidir_out_stop_downstream[0:0] = io_left_3_bidir_out_stop_downstream[0:0];
  assign io_right_0_bidir_out[31:0] = io_right_0__bidir_out[31:0];
  assign io_right_0__bidir_in[31:0] = io_right_0_bidir_in[31:0];
  assign io_right_0__bidir_in_valid_upstream[0:0] = io_right_0_bidir_in_valid_upstream[0:0];
  assign io_right_0_bidir_in_stop_upstream[0:0] = io_right_0__bidir_in_stop_upstream[0:0];
  assign io_right_0_bidir_out_valid_downstream[0:0] = io_right_0__bidir_out_valid_downstream[0:0];
  assign io_right_0__bidir_out_stop_downstream[0:0] = io_right_0_bidir_out_stop_downstream[0:0];
  assign io_right_1_bidir_out[31:0] = io_right_1__bidir_out[31:0];
  assign io_right_1__bidir_in_valid_upstream[0:0] = io_right_1_bidir_in_valid_upstream[0:0];
  assign io_right_1_bidir_in_stop_upstream[0:0] = io_right_1__bidir_in_stop_upstream[0:0];
  assign io_right_1_bidir_out_valid_downstream[0:0] = io_right_1__bidir_out_valid_downstream[0:0];
  assign io_right_1__bidir_out_stop_downstream[0:0] = io_right_1_bidir_out_stop_downstream[0:0];
  assign io_right_2__bidir_in[31:0] = io_right_2_bidir_in[31:0];
  assign io_right_2__bidir_in_valid_upstream[0:0] = io_right_2_bidir_in_valid_upstream[0:0];
  assign io_right_2_bidir_out[31:0] = io_right_2__bidir_out[31:0];
  assign io_right_2_bidir_in_stop_upstream[0:0] = io_right_2__bidir_in_stop_upstream[0:0];
  assign io_right_2_bidir_out_valid_downstream[0:0] = io_right_2__bidir_out_valid_downstream[0:0];
  assign io_right_2__bidir_out_stop_downstream[0:0] = io_right_2_bidir_out_stop_downstream[0:0];
  assign io_right_3__bidir_in[31:0] = io_right_3_bidir_in[31:0];
  assign io_right_3__bidir_in_valid_upstream[0:0] = io_right_3_bidir_in_valid_upstream[0:0];
  assign io_right_3_bidir_out[31:0] = io_right_3__bidir_out[31:0];
  assign io_right_3_bidir_in_stop_upstream[0:0] = io_right_3__bidir_in_stop_upstream[0:0];
  assign io_right_3_bidir_out_valid_downstream[0:0] = io_right_3__bidir_out_valid_downstream[0:0];
  assign io_right_3__bidir_out_stop_downstream[0:0] = io_right_3_bidir_out_stop_downstream[0:0];
  assign io_top_0__bidir_in[31:0] = io_top_0_bidir_in[31:0];
  assign io_top_0_bidir_out[31:0] = io_top_0__bidir_out[31:0];
  assign io_top_1__bidir_in[31:0] = io_top_1_bidir_in[31:0];
  assign io_top_1_bidir_out[31:0] = io_top_1__bidir_out[31:0];
  assign io_top_0__bidir_in_valid_upstream[0:0] = io_top_0_bidir_in_valid_upstream[0:0];
  assign io_top_0_bidir_in_stop_upstream[0:0] = io_top_0__bidir_in_stop_upstream[0:0];
  assign io_top_0_bidir_out_valid_downstream[0:0] = io_top_0__bidir_out_valid_downstream[0:0];
  assign io_top_0__bidir_out_stop_downstream[0:0] = io_top_0_bidir_out_stop_downstream[0:0];
  assign io_top_1__bidir_in_valid_upstream[0:0] = io_top_1_bidir_in_valid_upstream[0:0];
  assign io_top_1_bidir_in_stop_upstream[0:0] = io_top_1__bidir_in_stop_upstream[0:0];
  assign io_top_1_bidir_out_valid_downstream[0:0] = io_top_1__bidir_out_valid_downstream[0:0];
  assign io_top_1__bidir_out_stop_downstream[0:0] = io_top_1_bidir_out_stop_downstream[0:0];
  assign io_top_2__bidir_in[31:0] = io_top_2_bidir_in[31:0];
  assign io_top_2_bidir_out[31:0] = io_top_2__bidir_out[31:0];
  assign io_top_2__bidir_in_valid_upstream[0:0] = io_top_2_bidir_in_valid_upstream[0:0];
  assign io_top_2_bidir_in_stop_upstream[0:0] = io_top_2__bidir_in_stop_upstream[0:0];
  assign io_top_2_bidir_out_valid_downstream[0:0] = io_top_2__bidir_out_valid_downstream[0:0];
  assign io_top_2__bidir_out_stop_downstream[0:0] = io_top_2_bidir_out_stop_downstream[0:0];
  assign io_top_3__bidir_in[31:0] = io_top_3_bidir_in[31:0];
  assign io_top_3_bidir_out[31:0] = io_top_3__bidir_out[31:0];
  assign io_top_3__bidir_in_valid_upstream[0:0] = io_top_3_bidir_in_valid_upstream[0:0];
  assign io_top_3_bidir_in_stop_upstream[0:0] = io_top_3__bidir_in_stop_upstream[0:0];
  assign io_top_3_bidir_out_valid_downstream[0:0] = io_top_3__bidir_out_valid_downstream[0:0];
  assign io_top_3__bidir_out_stop_downstream[0:0] = io_top_3_bidir_out_stop_downstream[0:0];

endmodule //cgra_U0
