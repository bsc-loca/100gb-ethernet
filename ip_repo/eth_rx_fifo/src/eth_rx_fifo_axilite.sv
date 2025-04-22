
module eth_rx_fifo_axilite (
    input clk,
    input rstn,

    input s_axi_arvalid,
    output s_axi_arready,
    input [13:0] s_axi_araddr,
    input [2:0] s_axi_arprot,
    output s_axi_rvalid,
    input s_axi_rready,
    output [31:0] s_axi_rdata,
    output [1:0] s_axi_rresp,

    input [31:0] dbg_corrupted_packets,
    input [31:0] dbg_dropped_packets,
    input [31:0] dbg_total_packets
);

    typedef enum bit [1:0] {
        AR,
        SELECT,
        R
    } RState_t;

    RState_t rstate = AR;

    reg [1:0] rresp;

    reg [13:0] raddr;
    reg [31:0] rdata;

    assign s_axi_arready = rstate == AR;
    assign s_axi_rvalid = rstate == R;
    assign s_axi_rdata = rdata;
    assign s_axi_rresp = rresp;

    always_ff @(posedge clk) begin

        case (rstate)

            AR: begin
                raddr <= s_axi_araddr;
                if (s_axi_arvalid) begin
                    rstate <= SELECT;
                end
            end

            SELECT: begin
                rresp <= 2'd0;
                case (raddr)

                    14'hC: begin
                        rdata <= dbg_corrupted_packets;
                    end

                    14'h10: begin
                        rdata <= dbg_dropped_packets;
                    end

                    14'h14: begin
                        rdata <= dbg_total_packets;
                    end

                    default: begin
                        rresp <= 2'b10;
                    end

                endcase
                rstate <= R;
            end

            R: begin
                if (s_axi_rready) begin
                    rstate <= AR;
                end
            end

        endcase

        if (!rstn) begin
            rstate <= AR;
        end
    end

endmodule
