
module eth_rx_fifo_read #(
    parameter MAX_CLUSTER_SIZE = 0,
    localparam CLUSTER_ID_W = $clog2(MAX_CLUSTER_SIZE)
) (
    input clk,
    input rstn,

    input frame_q_empty,
    output logic frame_q_read,
    input [576:0] frame_q_dout,

    output logic so_tvalid,
    input so_tready,
    output logic [511:0] so_tdata,
    output logic [63:0] so_tkeep,
    output logic so_tlast
);

    typedef enum bit [0:0] {
        IDLE,
        DATA
    } State_t;

    State_t state = IDLE;

    wire [511:0] tdata;
    wire [63:0] tkeep;
    wire tlast;

    assign tdata = frame_q_dout[511:0];
    assign tkeep = frame_q_dout[575:512];
    assign tlast = frame_q_dout[576];
    
    assign so_tdata = tdata;
    assign so_tkeep = tkeep;
    assign so_tlast = tlast;

    always_comb begin

        frame_q_read = 1'b0;
        so_tvalid = 1'b0;

        case (state)

            IDLE: begin
                frame_q_read = !frame_q_empty;
            end

            DATA: begin
                so_tvalid = 1'b1;
                if (so_tready) begin
                    frame_q_read = !tlast;
                end
            end

        endcase
    end

    always_ff @(posedge clk) begin

        case (state)

            IDLE: begin
                if (!frame_q_empty) begin
                    state <= DATA;
                end
            end

            DATA: begin
                if (so_tready) begin
                    if (tlast) begin
                        state <= IDLE;
                    end
                end
            end

        endcase

        if (!rstn) begin
            state <= IDLE;
        end
    end

endmodule
