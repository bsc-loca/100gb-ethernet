library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Serial UART
entity apb_uart_top is
  port (
    s_axi_aclk    : in  std_logic;
    s_axi_aresetn : in  std_logic;
    s_axi_awaddr  : in  std_logic_vector(31 downto 0);
    s_axi_awvalid : in  std_logic;
    s_axi_awready : out std_logic;
    s_axi_wdata   : in  std_logic_vector(31 downto 0);
    s_axi_wvalid  : in  std_logic;
    s_axi_wready  : out std_logic;
    s_axi_bresp   : out std_logic_vector(1 downto 0);
    s_axi_bvalid  : out std_logic;
    s_axi_bready  : in  std_logic;
    s_axi_araddr  : in  std_logic_vector(31 downto 0);
    s_axi_arvalid : in  std_logic;
    s_axi_arready : out std_logic;
    s_axi_rdata   : out std_logic_vector(31 downto 0);
    s_axi_rresp   : out std_logic_vector(1 downto 0);
    s_axi_rvalid  : out std_logic;
    s_axi_rready  : in  std_logic;

    --
    INTERRUPT : out std_logic;          -- Interrupt output

    OUT1N : out std_logic;              -- Output 1
    OUT2N : out std_logic;              -- Output 2
    RTSN  : out std_logic;              -- RTS output
    DTRN  : out std_logic;              -- DTR output
    CTSN  : in  std_logic := '0';       -- CTS input
    DSRN  : in  std_logic := '0';       -- DSR input
    DCDN  : in  std_logic := '0';       -- DCD input
    RIN   : in  std_logic := '0';       -- RI input
    SIN   : in  std_logic;              -- Receiver input
    SOUT  : out std_logic               -- Transmitter output

    );
end apb_uart_top;


architecture rtl of apb_uart_top is

 -- Xilinx APB Axi bridge
  component axi_apb_bridge_0
    port (
      s_axi_aclk    : in  std_logic;
      s_axi_aresetn : in  std_logic;
      s_axi_awaddr  : in  std_logic_vector(31 downto 0);
      s_axi_awvalid : in  std_logic;
      s_axi_awready : out std_logic;
      s_axi_wdata   : in  std_logic_vector(31 downto 0);
      s_axi_wvalid  : in  std_logic;
      s_axi_wready  : out std_logic;
      s_axi_bresp   : out std_logic_vector(1 downto 0);
      s_axi_bvalid  : out std_logic;
      s_axi_bready  : in  std_logic;
      s_axi_araddr  : in  std_logic_vector(31 downto 0);
      s_axi_arvalid : in  std_logic;
      s_axi_arready : out std_logic;
      s_axi_rdata   : out std_logic_vector(31 downto 0);
      s_axi_rresp   : out std_logic_vector(1 downto 0);
      s_axi_rvalid  : out std_logic;
      s_axi_rready  : in  std_logic;
      m_apb_paddr   : out std_logic_vector(31 downto 0);
      m_apb_psel    : out std_logic_vector(0 downto 0);
      m_apb_penable : out std_logic;
      m_apb_pwrite  : out std_logic;
      m_apb_pwdata  : out std_logic_vector(31 downto 0);
      m_apb_pready  : in  std_logic_vector(0 downto 0);
      m_apb_prdata  : in  std_logic_vector(31 downto 0);
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
      PADDR   : in  std_logic_vector(4 downto 0);   -- APB paddr signal
      PWDATA  : in  std_logic_vector(31 downto 0);  -- APB pwdata signal
      PRDATA  : out std_logic_vector(31 downto 0);  -- APB prdata signal
      PREADY  : out std_logic;                      -- APB pready signal
      PSLVERR : out std_logic;                      -- APB pslverr signal
      --
      INTERRUPT  : out std_logic;                      -- Interrupt output
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
  signal m_apb_paddr   : std_logic_vector(31 downto 0);
  signal m_apb_pwdata  : std_logic_vector(31 downto 0);
  signal m_apb_prdata  : std_logic_vector(31 downto 0);
  signal m_apb_pready  : std_logic_vector(0 downto 0);
  signal m_apb_pslverr : std_logic_vector(0 downto 0);


begin

  xilinx_apb_axi_bridge : axi_apb_bridge_0
    port map (
      s_axi_aclk    => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_awaddr  => s_axi_awaddr,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,
      s_axi_wdata   => s_axi_wdata,
      s_axi_wvalid  => s_axi_wvalid,
      s_axi_wready  => s_axi_wready,
      s_axi_bresp   => s_axi_bresp,
      s_axi_bvalid  => s_axi_bvalid,
      s_axi_bready  => s_axi_bready,
      s_axi_araddr  => s_axi_araddr,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arready => s_axi_arready,
      s_axi_rdata   => s_axi_rdata,
      s_axi_rresp   => s_axi_rresp,
      s_axi_rvalid  => s_axi_rvalid,
      s_axi_rready  => s_axi_rready,
      m_apb_paddr   => m_apb_paddr,
      m_apb_psel    => m_apb_psel,
      m_apb_penable => m_apb_penable,
      m_apb_pwrite  => m_apb_pwrite,
      m_apb_pwdata  => m_apb_pwdata,
      m_apb_pready  => m_apb_pready,
      m_apb_prdata  => m_apb_prdata,
      m_apb_pslverr => m_apb_pslverr
      );


  inst_cva6_apb_uart : apb_uart
    port map (
      CLK     => s_axi_aclk,
      RSTN    => s_axi_aresetn,
      --                       
      PSEL    => m_apb_psel(0),
      PENABLE => m_apb_penable,
      PWRITE  => m_apb_pwrite,
      PADDR   => m_apb_paddr(4 downto 0),
      PWDATA  => m_apb_pwdata,
      PRDATA  => m_apb_prdata,
      PREADY  => m_apb_pready(0),
      PSLVERR => m_apb_pslverr(0),
      --                 
      INTERRUPT => INTERRUPT,
      --                   
      OUT1N   => OUT1N,
      OUT2N   => OUT2N,
      RTSN    => RTSN,
      DTRN    => DTRN,
      CTSN    => CTSN,
      DSRN    => DSRN,
      DCDN    => DCDN,
      RIN     => RIN,
      SIN     => SIN,
      SOUT    => SOUT
      );

end rtl;
