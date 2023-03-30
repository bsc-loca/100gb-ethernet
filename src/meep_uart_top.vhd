library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Serial UART
entity meep_uart_top is
  generic (
    G_ADDR_WIDTH : integer := 3;
    G_DATA_WIDTH : integer := 32;
    G_RESP_WIDTH : integer := 2
  );
  port (
    s_axi_aclk    : in  std_logic;
    s_axi_aresetn : in  std_logic;
    s_axi_awaddr  : in  std_logic_vector(G_ADDR_WIDTH-1 downto 0);
    s_axi_awvalid : in  std_logic;
    s_axi_awready : out std_logic;
    s_axi_wdata   : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
    s_axi_wvalid  : in  std_logic;
    s_axi_wready  : out std_logic;
    s_axi_bresp   : out std_logic_vector(G_RESP_WIDTH-1 downto 0);
    s_axi_bvalid  : out std_logic;
    s_axi_bready  : in  std_logic;
    s_axi_araddr  : in  std_logic_vector (G_ADDR_WIDTH-1 downto 0);
    s_axi_arvalid : in  std_logic;
    s_axi_arready : out std_logic;
    s_axi_rdata   : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    s_axi_rresp   : out std_logic_vector(G_RESP_WIDTH-1 downto 0);
    s_axi_rvalid  : out std_logic;
    s_axi_rready  : in  std_logic;

    --
    ip2intc_irpt : out std_logic;          -- Interrupt output

    out1n : out std_logic;              -- Output 1
    out2n : out std_logic;              -- Output 2
    rtsn  : out std_logic;              -- RTS output
    dtrn  : out std_logic;              -- DTR output
    ctsn  : in  std_logic := '0';       -- CTS input
    dsrn  : in  std_logic := '0';       -- DSR input
    dcdn  : in  std_logic := '0';       -- DCD input
    rin   : in  std_logic := '0';       -- RI input
    sin   : in  std_logic;              -- Receiver input
    sout  : out std_logic               -- Transmitter output

    );
end meep_uart_top;


architecture rtl of meep_uart_top is

 -- Xilinx APB Axi bridge
  component axi_apb_bridge_0
    port (
      s_axi_aclk    : in  std_logic;
      s_axi_aresetn : in  std_logic;
      s_axi_awaddr  : in  std_logic_vector(G_ADDR_WIDTH-1 downto 0);
      s_axi_awvalid : in  std_logic;
      s_axi_awready : out std_logic;
      s_axi_wdata   : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
      s_axi_wvalid  : in  std_logic;
      s_axi_wready  : out std_logic;
      s_axi_bresp   : out std_logic_vector(G_RESP_WIDTH-1 downto 0);
      s_axi_bvalid  : out std_logic;
      s_axi_bready  : in  std_logic;
      s_axi_araddr  : in  std_logic_vector(G_ADDR_WIDTH-1 downto 0);
      s_axi_arvalid : in  std_logic;
      s_axi_arready : out std_logic;
      s_axi_rdata   : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      s_axi_rresp   : out std_logic_vector(G_RESP_WIDTH-1 downto 0);
      s_axi_rvalid  : out std_logic;
      s_axi_rready  : in  std_logic;
      m_apb_paddr   : out std_logic_vector(G_ADDR_WIDTH-1 downto 0);
      m_apb_psel    : out std_logic_vector(0 downto 0);
      m_apb_penable : out std_logic;
      m_apb_pwrite  : out std_logic;
      m_apb_pwdata  : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      m_apb_pready  : in  std_logic_vector(0 downto 0);
      m_apb_prdata  : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
      m_apb_pslverr : in  std_logic_vector(0 downto 0)
      );
  end component;


-- Serial UART
  component apb_uart
    port (
      CLK     : in  std_logic;                      -- Clock
      RSTN    : in  std_logic;                      -- Reset negated
      --
      PSEL    : in  std_logic;                      -- APB psel signal
      PENABLE : in  std_logic;                      -- APB penable signal
      PWRITE  : in  std_logic;                      -- APB pwrite signal
      PADDR   : in  std_logic_vector(G_ADDR_WIDTH-1 downto 0); -- APB paddr signal
      PWDATA  : in  std_logic_vector(G_DATA_WIDTH-1 downto 0); -- APB pwdata signal
      PRDATA  : out std_logic_vector(G_DATA_WIDTH-1 downto 0); -- APB prdata signal
      PREADY  : out std_logic;                      -- APB pready signal
      PSLVERR : out std_logic;                      -- APB pslverr signal
      --
      INT     : out std_logic;                      -- Interrupt output
      --
      OUT1N   : out std_logic;                      -- Output 1
      OUT2N   : out std_logic;                      -- Output 2
      RTSN    : out std_logic;                      -- RTS output
      DTRN    : out std_logic;                      -- DTR output
      CTSN    : in  std_logic;                      -- CTS input
      DSRN    : in  std_logic;                      -- DSR input
      DCDN    : in  std_logic;                      -- DCD input
      RIN     : in  std_logic;                      -- RI input
      SIN     : in  std_logic;                      -- Receiver input
      SOUT    : out std_logic                       -- Transmitter output
      );
  end component;


  signal m_apb_psel    : std_logic_vector(0 downto 0);
  signal m_apb_penable : std_logic;
  signal m_apb_pwrite  : std_logic;
  signal m_apb_paddr   : std_logic_vector(G_ADDR_WIDTH-1 downto 0);
  signal m_apb_pwdata  : std_logic_vector(G_DATA_WIDTH-1 downto 0);
  signal m_apb_prdata  : std_logic_vector(G_DATA_WIDTH-1 downto 0);
  signal m_apb_pready  : std_logic_vector(0 downto 0);
  signal m_apb_pslverr : std_logic_vector(0 downto 0);


begin

  xilinx_apb_axi_bridge : axi_apb_bridge_0
    port map (
      s_axi_aclk    => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr  => s_axi_awaddr(G_ADDR_WIDTH-1 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,
      s_axi_wdata   => s_axi_wdata,
      s_axi_wvalid  => s_axi_wvalid,
      s_axi_wready  => s_axi_wready,
      s_axi_bresp   => s_axi_bresp,
      s_axi_bvalid  => s_axi_bvalid,
      s_axi_bready  => s_axi_bready,
      s_axi_araddr  => s_axi_araddr(G_ADDR_WIDTH-1 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arready => s_axi_arready,
      s_axi_rdata   => s_axi_rdata,
      s_axi_rresp   => s_axi_rresp,
      s_axi_rvalid  => s_axi_rvalid,
      s_axi_rready  => s_axi_rready,
      m_apb_paddr   => m_apb_paddr(G_ADDR_WIDTH-1 downto 0),
      m_apb_psel    => m_apb_psel,
      m_apb_penable => m_apb_penable,
      m_apb_pwrite  => m_apb_pwrite,
      m_apb_pwdata  => m_apb_pwdata,
      m_apb_pready  => m_apb_pready,
      m_apb_prdata  => m_apb_prdata,
      m_apb_pslverr => m_apb_pslverr
      );


  inst_pulp_apb_uart : apb_uart
    port map (
      CLK     => s_axi_aclk,
      RSTN    => s_axi_aresetn,
      --                       
      PSEL    => m_apb_psel(0),
      PENABLE => m_apb_penable,
      PWRITE  => m_apb_pwrite,
      PADDR   => m_apb_paddr(G_ADDR_WIDTH-1 downto 0),
      PWDATA  => m_apb_pwdata,
      PRDATA  => m_apb_prdata,
      PREADY  => m_apb_pready(0),
      PSLVERR => m_apb_pslverr(0),
      --                 
      INT => ip2intc_irpt,
      --                   
      OUT1N   => out1n,
      OUT2N   => out2n,
      RTSN    => rtsn,
      DTRN    => dtrn,
      CTSN    => ctsn,
      DSRN    => dsrn,
      DCDN    => dcdn,
      RIN     => rin,
      SIN     => sin,
      SOUT    => sout
      );

end rtl;
