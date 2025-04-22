
module eth_rx_fifo_wrapper #(
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
    output so_tlast

    /*input s_axi_arvalid,
    output s_axi_arready,
    input [13:0] s_axi_araddr,
    input [2:0] s_axi_arprot,
    output s_axi_rvalid,
    input s_axi_rready,
    output [31:0] s_axi_rdata,
    output [1:0] s_axi_rresp*/
);
eth_rx_fifo #(
    .FRAME_QUEUE_LEN(FRAME_QUEUE_LEN)
) eth_rx_fifo_I (
    .clk(clk),
    .rstn(rstn),
    .rx_tvalid(rx_tvalid),
    .rx_tdata(rx_tdata),
    .rx_tkeep(rx_tkeep),
    .rx_tuser(rx_tuser),
    .rx_tlast(rx_tlast),
    .so_tvalid(so_tvalid),
    .so_tready(so_tready),
    .so_tdata(so_tdata),
    .so_tkeep(so_tkeep),
    .so_tlast(so_tlast),
    .s_axi_arvalid(1'b0),
    .s_axi_arready(),
    .s_axi_araddr(14'd0),
    .s_axi_arprot(3'd0),
    .s_axi_rvalid(),
    .s_axi_rready(1'b1),
    .s_axi_rdata(),
    .s_axi_rresp()
);
endmodule
