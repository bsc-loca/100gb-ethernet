
module eth_rx_frame_queue #(
    parameter WIDTH = 0,
    parameter LEN = 0
) (
    input clk,
    input rstn,

    output empty,
    input read,
    output reg [WIDTH-1:0] dout,

    output full,
    input write,
    input confirm,
    input erase,
    input [WIDTH-1:0] din
);

    localparam ADDR_W = $clog2(LEN);

    reg [ADDR_W:0] read_addr = '0;
    reg [ADDR_W:0] write_addr = '0;
    reg [ADDR_W:0] init_write_addr = '0;

    wire [ADDR_W:0] next_write_addr;
    wire [ADDR_W:0] next_read_addr;

    assign full = read_addr[ADDR_W-1:0] == write_addr[ADDR_W-1:0] && (read_addr[ADDR_W] != write_addr[ADDR_W]);
    assign empty = read_addr == init_write_addr;

    //Power of 2
    if (LEN & (LEN-1) == 0) begin
        assign next_write_addr = write_addr + {{ADDR_W{1'b0}},1'b1};
        assign next_read_addr  = read_addr  + {{ADDR_W{1'b0}},1'b1};
    end else begin
        assign next_write_addr[ADDR_W-1:0] = (write_addr[ADDR_W-1:0] == LEN-1) ? {ADDR_W{1'b0}} : write_addr[ADDR_W-1:0] + {{ADDR_W-1{1'b0}}, 1'b1};
        assign next_write_addr[ADDR_W]     = (write_addr[ADDR_W-1:0] == LEN-1) ? !write_addr[ADDR_W] : write_addr[ADDR_W];
        assign next_read_addr[ADDR_W-1:0]  = (read_addr[ADDR_W-1:0]  == LEN-1) ? {ADDR_W{1'b0}} : read_addr[ADDR_W-1:0] + {{ADDR_W-1{1'b0}}, 1'b1};
        assign next_read_addr[ADDR_W]      = (read_addr[ADDR_W-1:0]  == LEN-1) ? !read_addr[ADDR_W]  : read_addr[ADDR_W];
    end

    always_ff @(posedge clk) begin
        if (write) begin
            write_addr <= next_write_addr;
        end
        if (confirm) begin
            init_write_addr <= next_write_addr;
        end
        if (erase) begin
            write_addr <= init_write_addr;
        end
        if (read) begin
            read_addr <= next_read_addr;
        end

        if (!rstn) begin
            read_addr <= '0;
            write_addr <= '0;
            init_write_addr <= '0;
        end
    end

    reg [WIDTH-1:0] mem[LEN];

    always_ff @(posedge clk) begin
        if (write) begin
            mem[write_addr[ADDR_W-1:0]] <= din;
        end
        if (read) begin
            dout <= mem[read_addr[ADDR_W-1:0]];
        end
    end

endmodule
