
module eth_rx_fifo #(
    parameter FRAME_QUEUE_LEN = 0
) (
    input clk,
    input rstn,

    input rx_tvalid,
    input [511:0] rx_tdata,
    input [63:0] rx_tkeep,
    input rx_tuser,
    input rx_tlast,

    output so_tvalid,
    input so_tready,
    output [511:0] so_tdata,
    output [63:0] so_tkeep,
    output so_tlast,

    input s_axi_arvalid,
    output s_axi_arready,
    input [13:0] s_axi_araddr,
    input [2:0] s_axi_arprot,
    output s_axi_rvalid,
    input s_axi_rready,
    output [31:0] s_axi_rdata,
    output [1:0] s_axi_rresp
);

    wire frame_q_empty;
    wire frame_q_read;
    wire [576:0] frame_q_dout;

    wire frame_q_full;
    wire frame_q_write;
    wire frame_q_confirm;
    wire frame_q_erase;
    wire [576:0] frame_q_din;

    wire [31:0] dbg_corrupted_packets;
    wire [31:0] dbg_dropped_packets;
    wire [31:0] dbg_total_packets;

    eth_rx_fifo_axilite axilite_I (
        .clk(clk),
        .rstn(rstn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arprot(s_axi_arprot),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .dbg_corrupted_packets(dbg_corrupted_packets),
        .dbg_dropped_packets(dbg_dropped_packets),
        .dbg_total_packets(dbg_total_packets)
    );

    eth_rx_fifo_write fifo_write (
        .clk(clk),
        .rstn(rstn),
        .rx_tvalid(rx_tvalid),
        .rx_tdata(rx_tdata),
        .rx_tkeep(rx_tkeep),
        .rx_tuser(rx_tuser),
        .rx_tlast(rx_tlast),
        .frame_q_full(frame_q_full),
        .frame_q_confirm(frame_q_confirm),
        .frame_q_erase(frame_q_erase),
        .frame_q_write(frame_q_write),
        .frame_q_din(frame_q_din),
        .dbg_corrupted_packets(dbg_corrupted_packets),
        .dbg_dropped_packets(dbg_dropped_packets),
        .dbg_total_packets(dbg_total_packets)
    );

    eth_rx_frame_queue #(
        .LEN(FRAME_QUEUE_LEN),
        .WIDTH(577)
    ) frame_queue_I (
        .clk(clk),
        .rstn(rstn),
        .empty(frame_q_empty),
        .read(frame_q_read),
        .dout(frame_q_dout),
        .full(frame_q_full),
        .write(frame_q_write),
        .confirm(frame_q_confirm),
        .erase(frame_q_erase),
        .din(frame_q_din)
    );

    eth_rx_fifo_read fifo_read_I (
        .clk(clk),
        .rstn(rstn),
        .frame_q_empty(frame_q_empty),
        .frame_q_read(frame_q_read),
        .frame_q_dout(frame_q_dout),
        .so_tvalid(so_tvalid),
        .so_tready(so_tready),
        .so_tdata(so_tdata),
        .so_tkeep(so_tkeep),
        .so_tlast(so_tlast)
    );

endmodule
