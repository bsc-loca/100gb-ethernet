/*****************************************************************************/
/**
*
* @file Initially started from Xilinx xemaclite.c
*
* Copyright (C) 2004 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
*
* @addtogroup emaclite_v4_6
* @{
*
* Functions in this file are the minimum required functions for the EmacLite
* driver. See xemaclite.h for a detailed description of the driver.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- --------------------------------------------------------
* 1.01a ecm  01/31/04 First release
* 1.11a mta  03/21/07 Updated to new coding style
* 1.11a ecm  05/18/07 Updated the TxBufferAvailable routine to look at both
*                     the active and busy bits
* 1.13a sv   02/1/08  Updated the TxBufferAvailable routine to return
*		      busy status properly
* 2.00a ktn  02/16/09 Added support for MDIO
* 2.01a ktn  07/20/09 Modified XEmacLite_Send function to use Ping buffers
*                     Interrupt enable bit since this alone is used to enable
*                     the interrupts for both Ping and Pong Buffers.
* 3.00a ktn  10/22/09 Updated driver to use the HAL APIs/macros.
*		      The macros have been renamed to remove _m from the name.
* 3.01a ktn  07/08/10 The macro XEmacLite_GetReceiveDataLength is changed to
*		      a static function.
*		      Updated the XEmacLite_GetReceiveDataLength and
*		      XEmacLite_Recv functions to support little endian
*		      MicroBlaze.
* 3.02a sdm  07/22/11 Removed redundant code in XEmacLite_Recv functions for
*		      CR617290
* 3.04a srt  04/13/13 Removed warnings (CR 705000).
* 4.2   sk   11/10/15 Used UINTPTR instead of u32 for Baseaddress CR# 867425.
*                     Changed the prototypes of XEmacLite_GetReceiveDataLength,
*                     XEmacLite_CfgInitialize API's.
*
* </pre>
******************************************************************************/

/***************************** Include Files *********************************/

// #include <stdio.h>
#include <unistd.h>
#include <algorithm>

#include "EthSyst.h"
#include "eth_defs.h"

//***************** Initialization of 100Gb Ethernet Core *****************
void EthSyst::ethCoreInit(bool gtLoopback) {
  xil_printf("------- Initializing Ethernet Core -------\n");
  // GT control via pins 
  uint32_t* gtCtrl = reinterpret_cast<uint32_t*>(XPAR_GT_CTL_BASEADDR);
  enum { GT_CTRL = XGPIO_DATA_OFFSET / sizeof(uint32_t) };
  enum { ETH_FULL_RST_ASSERT = RESET_REG_USR_RX_SERDES_RESET_MASK |
                               RESET_REG_USR_RX_RESET_MASK        |
                               RESET_REG_USR_TX_RESET_MASK,
         ETH_FULL_RST_DEASSERT = RESET_REG_USR_RX_SERDES_RESET_DEFAULT |
                                 RESET_REG_USR_RX_RESET_DEFAULT |
                                 RESET_REG_USR_TX_RESET_DEFAULT
  };

  xil_printf("Soft reset of Ethernet core:\n");
  xil_printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  ethCore[GT_RESET_REG] = GT_RESET_REG_GT_RESET_ALL_MASK;
  ethCore[RESET_REG]    = ETH_FULL_RST_ASSERT;
  xil_printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  if (ethCore[RESET_REG] != ETH_FULL_RST_ASSERT) {
    xil_printf("\nERROR: Incorrect Ethernet core RESET_REG readback, expected: %0X \n", ETH_FULL_RST_ASSERT);
    exit(1);
  }
  sleep(1); // in seconds
  ethCore[RESET_REG] = ETH_FULL_RST_DEASSERT;
  xil_printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n\n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  if (ethCore[RESET_REG] != ETH_FULL_RST_DEASSERT) {
    xil_printf("\nERROR: Incorrect Ethernet core RESET_REG readback, expected: %0X \n", ETH_FULL_RST_DEASSERT);
    exit(1);
  }
  sleep(1); // in seconds
  
  // Reading status via pins
  xil_printf("GT_POWER_PINS: %0lX \n",       gtCtrl  [GT_CTRL]);
  xil_printf("STAT_TX_STATUS_PINS: %0lX \n", rxtxCtrl[TX_CTRL]);
  xil_printf("STAT_RX_STATUS_PINS: %0lX \n", rxtxCtrl[RX_CTRL]);
  // Reading status and other regs via AXI
  xil_printf("GT_RESET_REG:          %0lX \n", ethCore[GT_RESET_REG]);
  xil_printf("RESET_REG:             %0lX \n", ethCore[RESET_REG]);
  xil_printf("CORE_VERSION_REG:      %0lX \n", ethCore[CORE_VERSION_REG]);
  xil_printf("CORE_MODE_REG:         %0lX \n", ethCore[CORE_MODE_REG]);
  xil_printf("SWITCH_CORE_MODE_REG:  %0lX \n", ethCore[SWITCH_CORE_MODE_REG]);
  xil_printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
  xil_printf("CONFIGURATION_RX_REG1: %0lX \n", ethCore[CONFIGURATION_RX_REG1]);
  xil_printf("STAT_TX_STATUS_REG:    %0lX \n", ethCore[STAT_TX_STATUS_REG]);
  xil_printf("STAT_RX_STATUS_REG:    %0lX \n", ethCore[STAT_RX_STATUS_REG]);
  xil_printf("GT_LOOPBACK_REG:       %0lX \n", ethCore[GT_LOOPBACK_REG]);
  xil_printf("\n");
  
  if (gtLoopback) {
    xil_printf("Enabling Near-End PMA Loopback\n");
    // gtCtrl[GT_CTRL] = 0x2222; // via GPIO: http://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88
    xil_printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    ethCore[GT_LOOPBACK_REG] = GT_LOOPBACK_REG_CTL_GT_LOOPBACK_MASK;
    xil_printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    if (ethCore[GT_LOOPBACK_REG] != GT_LOOPBACK_REG_CTL_GT_LOOPBACK_MASK) {
      xil_printf("\nERROR: Incorrect Ethernet core GT_LOOPBACK_REG readback, expected: %0X \n", GT_LOOPBACK_REG_CTL_GT_LOOPBACK_MASK);
      exit(1);
    }
  } else {
    xil_printf("Enabling GT normal operation with no loopback\n");
    // gtCtrl[GT_CTRL] = 0; // via GPIO
    xil_printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    ethCore[GT_LOOPBACK_REG] = GT_LOOPBACK_REG_CTL_GT_LOOPBACK_DEFAULT;
    xil_printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    if (ethCore[GT_LOOPBACK_REG] != GT_LOOPBACK_REG_CTL_GT_LOOPBACK_DEFAULT) {
      xil_printf("\nERROR: Incorrect Ethernet core GT_LOOPBACK_REG readback, expected: %0X \n", GT_LOOPBACK_REG_CTL_GT_LOOPBACK_DEFAULT);
      exit(1);
    }
  }
  xil_printf("\n");
  
  xil_printf("Ethernet core bring-up.\n");
  physConnOrder = PHYS_CONN_WAIT_INI;
  // http://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=204
  // via GPIO
  // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_MASK;
  // via AXI
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                      ethCore[CONFIGURATION_RX_REG1]);
  ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_MASK;
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                      ethCore[CONFIGURATION_RX_REG1]);
  xil_printf("\n");
                                                 
  xil_printf("Waiting for RX is aligned and RFI is got from TX side...\n");
  while(!(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_ALIGNED_MASK) ||
        !(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_REMOTE_FAULT_MASK)) {
    xil_printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    xil_printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                       ethCore[STAT_RX_STATUS_REG]);
    if (physConnOrder) physConnOrder--;
    sleep(1); // in seconds, user wait process
  }
  xil_printf("RX is aligned and RFI is got from TX side:\n");
  xil_printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  xil_printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                     ethCore[STAT_RX_STATUS_REG]);
  xil_printf("\n");

  xil_printf("Disabling TX_SEND_RFI:\n");
  if (!gtLoopback) sleep(1); // in seconds, timeout to make sure opposite side also got RFI
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_DEFAULT; // via GPIO
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                      ethCore[CONFIGURATION_RX_REG1]);
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_DEFAULT;
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                      ethCore[CONFIGURATION_RX_REG1]);
  xil_printf("\n");

  xil_printf("Waiting for RFI is stopped...\n");
  while(!(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_ALIGNED_MASK) ||
         (ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_REMOTE_FAULT_MASK)) {
    xil_printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    xil_printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                       ethCore[STAT_RX_STATUS_REG]);
    sleep(1); // in seconds, user wait process
  }
  xil_printf("RFI is stopped:\n");
  xil_printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  xil_printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                     ethCore[STAT_RX_STATUS_REG]);
  xil_printf("This Eth instance is physically connected in order (zero means 1st, non-zero means 2nd): %d \n", physConnOrder);
}


//***************** Enabling Ethernet core Tx/Rx *****************
void EthSyst::ethTxRxEnable() {
  xil_printf("Enabling Ethernet TX/RX:\n");
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                       ethCore[CONFIGURATION_RX_REG1]);
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK; // via GPIO
  // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK; // via GPIO
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
  ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                       ethCore[CONFIGURATION_RX_REG1]);
}


//***************** Disabling Ethernet core Tx/Rx *****************
void EthSyst::ethTxRxDisable() {
  xil_printf("Disabling Ethernet TX/RX:\n");
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                       ethCore[CONFIGURATION_RX_REG1]);
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT; // via GPIO
  // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT; // via GPIO
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT;
  ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT;
  xil_printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                       ethCore[CONFIGURATION_RX_REG1]);
}


//***************** Initialization of Timer *****************
void EthSyst::timerCntInit() {
  // AXI Timer direct control: http://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
  xil_printf("------- Initializing Timer -------\n");
  // Controlling Timer via Xilinx driver.
  // Initialize the Timer driver so that it is ready to use
  int status = XTmrCtr_Initialize(&timerCnt, XPAR_TMRCTR_0_DEVICE_ID);
  if (status != XST_SUCCESS &&
      status != XST_DEVICE_IS_STARTED) { // in case a timer has already been initialized and started
    xil_printf("\nERROR: Timer initialization failed with status %d\n", status);
    exit(1);
  }
  // Perform a self-test and reset for both timers to ensure that the hardware was built correctly
  for (size_t cnt = 0; cnt < XTC_DEVICE_TIMER_COUNT; cnt++) {
    status = XTmrCtr_SelfTest(&timerCnt, cnt);
    if (XST_SUCCESS != status) {
      xil_printf("\nERROR: Timer %d selftest failed with status %d\n", cnt, status);
      exit(1);
    }
  }
}


//***************** Initialization of Interrupt Controller *****************
void EthSyst::intrCtrlInit() {
  xil_printf("------- Initializing Interrupt Controller -------\n");
  // Direct control of IntC: https://www.xilinx.com/support/documentation/ip_documentation/axi_intc/v4_1/pg099-axi-intc.pdf
  // Controlling IntC via Xilinx driver.
  // Initialize the interrupt controller driver so that it is ready to use
  int status = XIntc_Initialize(&intrCtrl, XPAR_INTC_0_DEVICE_ID);
  if (XST_SUCCESS != status) {
    xil_printf("\nERROR: Interrupt Controller initialization failed with status %d\n", status);
    exit(1);
  }

  // Disabling all available interrupts
  intrCtrlStop();
  for (size_t intrId = 0; intrId < XPAR_INTC_MAX_NUM_INTR_INPUTS; intrId++) {
    XIntc_Disable   (&intrCtrl, intrId);
    XIntc_Disconnect(&intrCtrl, intrId);
  }

  // Perform a self-test (interrupt simulation) in case hardware interrupts have not once been enabled,
  // if not, this is a write once bit such that simulation can't be done at this point
  // because the ISR register is no longer writable by software
  uint32_t merReg = XIntc_In32(XPAR_INTC_0_BASEADDR + XIN_MER_OFFSET);
  if (XIN_INT_HARDWARE_ENABLE_MASK & merReg)
    xil_printf("Skipping Interrupt Controller selftest because of once set HIE bit in MER: 0x%lX \n", merReg);
  else {
    status = XIntc_SelfTest(&intrCtrl);
    if (XST_SUCCESS != status) {
      xil_printf("\nERROR: Interrupt Controller selftest failed with status %d\n", status);
      exit(1);
    }
  }
}


//***************** Connection of specific Interrupt Id *****************
void EthSyst::intrCtrlConnect(uint8_t intrId, void(*deviceHandler)(void), bool fastIntr) {
  xil_printf("Connecting fast=%d interrupt %d to the Device Handler \n", fastIntr, intrId);
  // Connect a device driver handler that will be called when an interrupt for the device occurs,
  // the device driver handler performs the specific interrupt processing for the device.
  int status;
  if (fastIntr)
       status = XIntc_ConnectFastHandler(&intrCtrl, intrId, (XFastInterruptHandler)deviceHandler);
  else status = XIntc_Connect           (&intrCtrl, intrId, (    XInterruptHandler)deviceHandler, (void*)0);
  if (XST_SUCCESS != status) {
    xil_printf("\nERROR: fast=%d interrupt %d connection with device handler failed with status %d\n", fastIntr, intrId, status);
    exit(1);
  }
  XIntc_Enable(&intrCtrl, intrId); // Enable the interrupt for the device
}
// low-level version
void EthSyst::intrCtrlConnect_l(uint8_t intrId, void(*deviceHandler)(void), bool fastIntr) {
  xil_printf("Registering fast=%d interrupt %d with the Device Handler \n", fastIntr, intrId);
  if (fastIntr)
       XIntc_RegisterFastHandler(XPAR_INTC_0_BASEADDR, intrId, (XFastInterruptHandler)deviceHandler);
  else XIntc_RegisterHandler    (XPAR_INTC_0_BASEADDR, intrId, (    XInterruptHandler)deviceHandler, (void*)0);
  XIntc_EnableIntr(XPAR_INTC_0_BASEADDR,
        XIntc_In32(XPAR_INTC_0_BASEADDR + XIN_IER_OFFSET) | (1<<intrId)); // Enable specific interrupt(s) in the interrupt controller
}


//***************** Disconnection of specific Interrupt Id *****************
void EthSyst::intrCtrlDisconnect(uint8_t intrId) {
  xil_printf("Disconnecting interrupt %d from the Device Handler \n", intrId);
  XIntc_Disable   (&intrCtrl, intrId);
  XIntc_Disconnect(&intrCtrl, intrId);
}
// low-level version
void EthSyst::intrCtrlDisconnect_l(uint8_t intrId) {
  xil_printf("Disabling interrupt %d \n", intrId);
  XIntc_DisableIntr(XPAR_INTC_0_BASEADDR,
        ~XIntc_In32(XPAR_INTC_0_BASEADDR + XIN_IER_OFFSET) | (1<<intrId));
}


//***************** Starting the Interrupt Controller *****************
void EthSyst::intrCtrlStart(bool realNsimMode) {
  xil_printf("Start of Interrupt Controller in real/sim mode=%d \n", realNsimMode);
  // Start the Interrupt Controller such that interrupts are enabled for all devices that cause interrupts,
  // specify simulation mode so that an interrupt can be caused by software or a real hardware interrupt.
  int status = XIntc_Start(&intrCtrl, realNsimMode ? XIN_REAL_MODE : XIN_SIMULATION_MODE);
  if (XST_SUCCESS != status) {
    xil_printf("\nERROR: Start of Interrupt Controller in real/simulation mode: %d failed with status %d\n", realNsimMode, status);
    exit(1);
  }

  Xil_ExceptionInit(); // Initialize the exception table.
  // Register the interrupt controller handler with the exception table.
  Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XIntc_InterruptHandler, &intrCtrl);
  Xil_ExceptionEnable(); // Enable exceptions.
}
//low-level version
void EthSyst::intrCtrlStart_l(bool realNsimMode) {
  xil_printf("Enabling Interrupt Controller in real/sim mode=%d \n", realNsimMode);
  // Set the master enable bit.
  if (realNsimMode) XIntc_MasterEnable(XPAR_INTC_0_BASEADDR);
  // Here we do not enable hardware interrupts yet since we want to simulate an interrupt from software.
  else XIntc_Out32(XPAR_INTC_0_BASEADDR + XIN_MER_OFFSET, XIN_INT_MASTER_ENABLE_MASK);

  Xil_ExceptionInit(); // Initialize the exception table.
  // Register the interrupt controller handler with the exception table.
  Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XIntc_DeviceInterruptHandler, XPAR_INTC_0_DEVICE_ID);
  Xil_ExceptionEnable(); // Enable exceptions.
}


//***************** Stop of the Interrupt Controller *****************
void EthSyst::intrCtrlStop() {
  xil_printf("Stop of Interrupt Controller \n");
  Xil_ExceptionDisable();
  Xil_ExceptionRemoveHandler(XIL_EXCEPTION_ID_INT);
  XIntc_Stop(&intrCtrl);
}
//low-level version
void EthSyst::intrCtrlStop_l() {
  xil_printf("Disabling Interrupt Controller \n");
  Xil_ExceptionDisable();
  Xil_ExceptionRemoveHandler(XIL_EXCEPTION_ID_INT);
  XIntc_MasterDisable(XPAR_INTC_0_BASEADDR);
}


//***************** Initialization of DMA engine *****************
void EthSyst::axiDmaInit() {
  xil_printf("------- Initializing DMA -------\n");
  // AXI DMA direct control: http://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf
  uint32_t* dmaCore = reinterpret_cast<uint32_t*>(XPAR_ETH_DMA_BASEADDR);
  enum {
    MM2S_DMACR = (XAXIDMA_CR_OFFSET + XAXIDMA_TX_OFFSET) / sizeof(uint32_t),
    MM2S_DMASR = (XAXIDMA_SR_OFFSET + XAXIDMA_TX_OFFSET) / sizeof(uint32_t),
    S2MM_DMACR = (XAXIDMA_CR_OFFSET + XAXIDMA_RX_OFFSET) / sizeof(uint32_t),
    S2MM_DMASR = (XAXIDMA_SR_OFFSET + XAXIDMA_RX_OFFSET) / sizeof(uint32_t)
  };

  // Controlling DMA via Xilinx driver.
  // Initialize the XAxiDma device.
  XAxiDma_Config *cfgPtr = XAxiDma_LookupConfig(XPAR_ETH_DMA_DEVICE_ID);
  if (!cfgPtr || cfgPtr->BaseAddr != XPAR_ETH_DMA_BASEADDR) {
    xil_printf("\nERROR: No config found for XAxiDma %d at addr %x \n", XPAR_ETH_DMA_DEVICE_ID, XPAR_ETH_DMA_BASEADDR);
    exit(1);
  }
  // XAxiDma definitions initialization
  int status = XAxiDma_CfgInitialize(&axiDma, cfgPtr);
  if (XST_SUCCESS != status) {
    xil_printf("\nERROR: XAxiDma initialization failed with status %d\n", status);
    exit(1);
  }
  // XAxiDma reset with checking if reset is done 
  status = XAxiDma_Selftest(&axiDma);
  if (XST_SUCCESS != status) {
    xil_printf("\nERROR: XAxiDma selftest(reset) failed with status %d\n", status);
    exit(1);
  }
  // Setups for Simple and Scatter-Gather modes
  if(!XAxiDma_HasSg(&axiDma)) {
    xil_printf("XAxiDma is configured in Simple mode \n");
    // Disable interrupts, we use polling mode
    XAxiDma_IntrDisable(&axiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(&axiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
  } else {
    xil_printf("XAxiDma is configured in Scatter-Gather mode \n");
    dmaBDSetup(false); // setup of Tx BD ring
    dmaBDSetup(true ); // setup of Rx BD ring
  }

  xil_printf("XAxiDma is initialized and reset: \n");
  xil_printf("HasSg       = %d  \n", axiDma.HasSg);
  xil_printf("Initialized = %d  \n", axiDma.Initialized);
  if (0) {
    xil_printf("RegBase                  = %d  \n", axiDma.RegBase);
    xil_printf("HasMm2S                  = %d  \n", axiDma.HasMm2S);
    xil_printf("HasS2Mm                  = %d  \n", axiDma.HasS2Mm);
    xil_printf("TxNumChannels            = %d  \n", axiDma.TxNumChannels);
    xil_printf("RxNumChannels            = %d  \n", axiDma.RxNumChannels);
    xil_printf("MicroDmaMode             = %d  \n", axiDma.MicroDmaMode);
    xil_printf("AddrWidth                = %d  \n", axiDma.AddrWidth);
    xil_printf("TxBdRing.DataWidth       = %d  \n", axiDma.TxBdRing.DataWidth);
    xil_printf("TxBdRing.Addr_ext        = %d  \n", axiDma.TxBdRing.Addr_ext);
    xil_printf("TxBdRing.MaxTransferLen  = %lX \n", axiDma.TxBdRing.MaxTransferLen);
    xil_printf("TxBdRing.FirstBdPhysAddr = %d  \n", axiDma.TxBdRing.FirstBdPhysAddr);
    xil_printf("TxBdRing.FirstBdAddr     = %d  \n", axiDma.TxBdRing.FirstBdAddr);
    xil_printf("TxBdRing.LastBdAddr      = %d  \n", axiDma.TxBdRing.LastBdAddr);
    xil_printf("TxBdRing.Length          = %lX \n", axiDma.TxBdRing.Length);
    xil_printf("TxBdRing.Separation      = %d  \n", axiDma.TxBdRing.Separation);
    xil_printf("TxBdRing.Cyclic          = %d  \n", axiDma.TxBdRing.Cyclic);
    xil_printf("TxBdRing pointer         = %x  \n", size_t(XAxiDma_GetTxRing(&axiDma)));
    xil_printf("RxBdRing pointer         = %x  \n", size_t(XAxiDma_GetRxRing(&axiDma)));
    xil_printf("Tx_control reg = %0lX \n", dmaCore[MM2S_DMACR]);
    xil_printf("Tx_status  reg = %0lX \n", dmaCore[MM2S_DMASR]);
    xil_printf("Rx_control reg = %0lX \n", dmaCore[S2MM_DMACR]);
    xil_printf("Rx_status  reg = %0lX \n", dmaCore[S2MM_DMASR]);
    xil_printf("Initial DMA Tx busy state: %ld \n", XAxiDma_Busy(&axiDma,XAXIDMA_DEVICE_TO_DMA));
    xil_printf("Initial DMA Rx busy state: %ld \n", XAxiDma_Busy(&axiDma,XAXIDMA_DMA_TO_DEVICE));
  }

  timerCntInit(); // initializing Timer as we use it in DMA transfer measurements
}


//*************************************************************************
// Setup of TX/RX channel of the DMA engine in SG mode to be ready for packets transfer
void EthSyst::dmaBDSetup(bool RxnTx)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);

	// Disable all TX/RX interrupts before BD space setup
	XAxiDma_BdRingIntDisable(BdRingPtr, XAXIDMA_IRQ_ALL_MASK);

	// Set delay and coalesce
	int const Coalesce = 1;
	int const Delay    = 0;
	XAxiDma_BdRingSetCoalesce(BdRingPtr, Coalesce, Delay);

	// Setup BD space
	size_t const sgMemAddr = RxnTx ? RX_SG_MEM_ADDR : TX_SG_MEM_ADDR;
	size_t const sgMemSize = RxnTx ? RX_SG_MEM_SIZE : TX_SG_MEM_SIZE;
	uint32_t BdCount = XAxiDma_BdRingCntCalc(XAXIDMA_BD_MINIMUM_ALIGNMENT, sgMemSize);
	int Status = XAxiDma_BdRingCreate(BdRingPtr, sgMemAddr, sgMemAddr, XAXIDMA_BD_MINIMUM_ALIGNMENT, BdCount);
	if (Status != XST_SUCCESS) {
      xil_printf("\nERROR: RxnTx=%d, Creation of BD ring with %ld BDs at addr %x failed with status %d\r\n",
	               RxnTx, BdCount, sgMemAddr, Status);
      exit(1);
	}
    xil_printf("RxnTx=%d, DMA BD memory size %x at addr %x, BD ring with %ld BDs created \n", RxnTx, sgMemSize, sgMemAddr, BdCount);
	if (RxnTx) rxBdCount = BdCount;
	else       txBdCount = BdCount;

	// We create an all-zero BD as the template.
	XAxiDma_Bd BdTemplate;
	XAxiDma_BdClear(&BdTemplate);
	Status = XAxiDma_BdRingClone(BdRingPtr, &BdTemplate);
	if (Status != XST_SUCCESS) {
      xil_printf("\nERROR: RxnTx=%d, Clone of BD ring failed with status %d\r\n", RxnTx, Status);
      exit(1);
	}

	// Start DMA channel
	Status = XAxiDma_BdRingStart(BdRingPtr);
	if (Status != XST_SUCCESS) {
		xil_printf("\nERROR: RxnTx=%d, Start of BD ring failed with status %d\r\n", RxnTx, Status);
    exit(1);
	}
}


//*************************************************************************
XAxiDma_Bd* EthSyst::dmaBDAlloc(bool RxnTx, size_t packets, size_t packLen, size_t bufLen, size_t bufAddr)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);

  uint32_t freeBdCount = XAxiDma_BdRingGetFreeCnt(BdRingPtr);
  if (packets > 1) xil_printf("RxnTx=%d, DMA in SG mode: %ld free BDs of %d are available to transfer %d packets \n",
                               RxnTx, freeBdCount, RxnTx ? rxBdCount:txBdCount , packets);
  if (packets > freeBdCount) {
    xil_printf("\nERROR: RxnTx=%d, Insufficient %ld free BDs to transfer %d packets \r\n", RxnTx, freeBdCount, packets);
    exit(1);
  }

	// Allocate BDs
	XAxiDma_Bd* BdPtr;
	int Status = XAxiDma_BdRingAlloc(BdRingPtr, packets, &BdPtr);
	if (Status != XST_SUCCESS) {
      xil_printf("\nERROR: RxnTx=%d, Allocation of BD ring with %d BDs failed with status %d\r\n", RxnTx, packets, Status);
      exit(1);
	}
	freeBdCount = XAxiDma_BdRingGetFreeCnt(BdRingPtr);
    if (packets > 1) xil_printf("RxnTx=%d, DMA in SG mode: %ld free BDs are available after BDs allocation \n", RxnTx, freeBdCount);


	XAxiDma_Bd* CurBdPtr = BdPtr;
	for (size_t packet = 0; packet < packets; packet++) {
	  // Set up the BD using the information of the packet to transmit
	  Status = XAxiDma_BdSetBufAddr(CurBdPtr, bufAddr);
	  if (Status != XST_SUCCESS) {
	    xil_printf("\nERROR: RxnTx=%d, Set of transfer buffer at addr %x on BD %x failed for packet %d of %d with status %d\r\n",
		              RxnTx, bufAddr, size_t(CurBdPtr), packet, packets, Status);
        exit(1);
	  }

	  Status = XAxiDma_BdSetLength(CurBdPtr, packLen, BdRingPtr->MaxTransferLen);
	  if (Status != XST_SUCCESS) {
	    xil_printf("\nERROR: RxnTx=%d, Set of transfer length %d (max=%d) on BD %x failed for packet %d of %d with status %d\r\n",
		              RxnTx, packLen, BdRingPtr->MaxTransferLen, size_t(CurBdPtr), packet, packets, Status);
        exit(1);
	  }

      if (!RxnTx && XPAR_AXIDMA_0_SG_INCLUDE_STSCNTRL_STRM == 1) {
        int Status = XAxiDma_BdSetAppWord(CurBdPtr, XAXIDMA_LAST_APPWORD, packLen);
        // If Set app length failed, it is not fatal
        if (Status != XST_SUCCESS) {
          xil_printf("RxnTx=%d, Tx control stream: set app word failed for packet %d of %d with status %d\r\n", RxnTx, packet, packets, Status);
        }
      }

      // For each packet, setting both SOF and EOF for TX BDs,
      // RX BDs do not need to set anything for the control, the hw will set the SOF/EOF bits per stream status
      XAxiDma_BdSetCtrl(CurBdPtr, RxnTx ? 0 : XAXIDMA_BD_CTRL_TXEOF_MASK |
                                              XAXIDMA_BD_CTRL_TXSOF_MASK);
      XAxiDma_BdSetId  (CurBdPtr, bufAddr);

      bufAddr += bufLen;
      CurBdPtr = (XAxiDma_Bd*)XAxiDma_BdRingNext(BdRingPtr, CurBdPtr);
	}
  return BdPtr;
}


//*************************************************************************
// This non-blocking function kicks-off packet transfers through the DMA engine in SG mode
void EthSyst::dmaBDTransfer(bool RxnTx, size_t packets, size_t bunchSize, XAxiDma_Bd* BdPtr)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);
  XAxiDma_Bd* CurBdPtr = BdPtr;
  size_t packet = 0;
  int Status = XST_FAILURE;
  // (Re)Start both timers when transfer started from initially set zero value
  XTmrCtr_Start(&timerCnt, 1); // Start "Rx" Timer
  XTmrCtr_Start(&timerCnt, 0); // Start "Tx" Timer
  // Give the BDs to DMA to kick off the transfer with extra branching for perf measurement optimization
  if (bunchSize == packets)
    Status = XAxiDma_BdRingToHw(BdRingPtr, packets, CurBdPtr);
  else if (bunchSize == 1)
    for (packet = 0; packet < packets; packet++) {
      Status = XAxiDma_BdRingToHw(BdRingPtr, 1, CurBdPtr);
      if (Status != XST_SUCCESS) break;
      // (XAxiDma_Bd*)XAxiDma_BdRingNext(BdRingPtr, CurBdPtr);
      CurBdPtr = (XAxiDma_Bd*)((UINTPTR)CurBdPtr + (BdRingPtr->Separation));
    }
  else
    for (packet = 0; packet < packets; packet += bunchSize) {
      Status = XAxiDma_BdRingToHw(BdRingPtr, std::min(bunchSize, packets-packet), CurBdPtr);
      if (Status != XST_SUCCESS) break;
      CurBdPtr = (XAxiDma_Bd*)((UINTPTR)CurBdPtr + bunchSize * (BdRingPtr->Separation));
    }
  if (Status != XST_SUCCESS) {
    xil_printf("\nERROR: RxnTx=%d, Submit of BD %x to hw failed for packet %d of %d with status %d\r\n",
                RxnTx, size_t(CurBdPtr), packet, packets, Status);
    exit(1);
  }
}


//*************************************************************************
// Blocking polling process for finishing the transfer of packets through the DMA engine in SG mode
XAxiDma_Bd* EthSyst::dmaBDPoll(bool RxnTx, size_t packets)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);

	// Wait until the BD transfers are done
	XAxiDma_Bd* BdPtr = 0;
	uint32_t ProcessedBdCount = 0;
	while (ProcessedBdCount < packets) {
      XAxiDma_Bd* CurBdPtr;
      ProcessedBdCount += XAxiDma_BdRingFromHw(BdRingPtr, XAXIDMA_ALL_BDS, &CurBdPtr);
      if (ProcessedBdCount && !BdPtr) BdPtr = CurBdPtr;
      // xil_printf("RxnTx=%d, Waiting untill %d BD transfers finish: %ld BDs processed from BD %x \n",
      //             RxnTx, packets, ProcessedBdCount, size_t(CurBdPtr));
      // sleep(1); // in seconds, user wait process
	}
  XTmrCtr_Stop(&timerCnt, RxnTx ? 1:0); // Stop Timer when transfer is finished
  return BdPtr;
}


//*************************************************************************
// Freeing of all processed BDs
void EthSyst::dmaBDFree(bool RxnTx, size_t packets, size_t packCheckLen, XAxiDma_Bd* BdPtr)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);

  // check actual transferred packet length vs expected (if it is the same for all packets)
  if (packCheckLen) {
    XAxiDma_Bd* CurBdPtr = BdPtr;
    for (size_t packet = 0; packet < packets; packet++) {
      size_t packActLen = XAxiDma_BdGetActualLength(CurBdPtr, BdRingPtr->MaxTransferLen);
      if (packActLen != packCheckLen) {
        xil_printf("\nERROR: RxnTx=%d, Transferred length %d (max=%d) differes from expected %d in packet %d of transferred %ld \r\n",
                   RxnTx, packActLen, BdRingPtr->MaxTransferLen, packCheckLen, packet, packets);
        exit(1);
      }
      CurBdPtr = (XAxiDma_Bd*)XAxiDma_BdRingNext(BdRingPtr, CurBdPtr);
    }
  }

	// Free all processed BDs for future transfers
  int status = XAxiDma_BdRingFree(BdRingPtr, packets, BdPtr);
  if (status != XST_SUCCESS) {
    xil_printf("\nERROR: RxnTx=%d, Failed to free %ld BDs with status %d \r\n", RxnTx, packets, status);
    exit(1);
	}
	uint32_t freeBdCount = XAxiDma_BdRingGetFreeCnt(BdRingPtr);
  xil_printf("RxnTx=%d, DMA in SG mode: %ld BD transfers are waited up, %ld free BDs are available after their release \n",
              RxnTx, packets, freeBdCount);
}


//*************************************************************************
// Non-blocking check of finished transfers of packets through the DMA engine in SG mode
uint32_t EthSyst::dmaBDCheck(bool RxnTx)
{
	XAxiDma_BdRing* BdRingPtr = RxnTx ? XAxiDma_GetRxRing(&axiDma) :
	                                    XAxiDma_GetTxRing(&axiDma);

	// Wait until the BD transfers are done
	XAxiDma_Bd *BdPtr;
	uint32_t ProcessedBdCount = XAxiDma_BdRingFromHw(BdRingPtr, XAXIDMA_ALL_BDS, &BdPtr);

	// Free all processed BDs for future transfers
	int status = XAxiDma_BdRingFree(BdRingPtr, ProcessedBdCount, BdPtr);
  if (status != XST_SUCCESS) {
    xil_printf("\nERROR: RxnTx=%d, Failed to free %ld BDs with status %d \r\n", RxnTx, ProcessedBdCount, status);
    exit(1);
	}
  uint32_t freeBdCount = XAxiDma_BdRingGetFreeCnt(BdRingPtr);
  if (ProcessedBdCount > 1) xil_printf("RxnTx=%d, DMA in SG mode: %ld BD transfers are done, %ld free BDs are available after their release \n",
                                        RxnTx, ProcessedBdCount, freeBdCount);
  return ProcessedBdCount;
}


//***************** AXI-Stream Switches control *****************
void EthSyst::switch_CPU_DMAxEth_LB(bool txNrx, bool cpu2eth_dma2lb) {
  // AXIS switches control: http://www.xilinx.com/support/documentation/ip_documentation/axis_infrastructure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf#page=27
  uint32_t* strSwitch = txNrx ? reinterpret_cast<uint32_t*>(XPAR_TX_AXIS_SWITCH_BASEADDR) :
                                reinterpret_cast<uint32_t*>(XPAR_RX_AXIS_SWITCH_BASEADDR);
  enum {SW_CTR = XAXIS_SCR_CTRL_OFFSET         / sizeof(uint32_t),
        MI_MUX = XAXIS_SCR_MI_MUX_START_OFFSET / sizeof(uint32_t)
       };

  if (txNrx) xil_printf("TX ");
  else       xil_printf("RX ");
  xil_printf("Stream Switch state:\n");
  xil_printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  if (cpu2eth_dma2lb) {
    xil_printf("Connecting CPU to Ethernet core, DMA to Short LB, ");
    strSwitch[MI_MUX+0] = 1; // connect Out0(Tx:LB /Rx:CPU) to In1(Tx:DMA/Rx:Eth)
    strSwitch[MI_MUX+1] = 0; // connect Out1(Tx:Eth/Rx:DMA) to In0(Tx:CPU/Rx:LB)
  } else {
    xil_printf("Connecting DMA to Ethernet core, CPU to Short LB, ");
    strSwitch[MI_MUX+0] = 0; // connect Out0(Tx:LB /Rx:CPU) to In0(Tx:CPU/Rx:LB)
    strSwitch[MI_MUX+1] = 1; // connect Out1(Tx:Eth/Rx:DMA) to In1(Tx:DMA/Rx:Eth)
  }
  if (strSwitch[MI_MUX+0] != uint32_t( cpu2eth_dma2lb) ||
      strSwitch[MI_MUX+1] != uint32_t(!cpu2eth_dma2lb)) {
    xil_printf("\nERROR: Incorrect Stream Switch control readback: Out0 = %0lX, Out1 = %0lX, expected: Out0 = %0X, Out1 = %0X \n",
                strSwitch[MI_MUX], strSwitch[MI_MUX+1], cpu2eth_dma2lb, !cpu2eth_dma2lb);
    exit(1);
  }
  xil_printf("Commiting the setting\n");
  strSwitch[SW_CTR] = XAXIS_SCR_CTRL_REG_UPDATE_MASK;
  xil_printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  xil_printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  xil_printf("\n");
}


//***************** Initialization of Full Ethernet System *****************
void EthSyst::ethSystInit() {
  intrCtrlInit();
  timerCntInit();
  axiDmaInit();
  switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
  switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
  ethTxRxEnable();
  sleep(1); // in seconds
}


//***************** Flush the Receive buffers. All data will be lost. *****************
int EthSyst::flushReceive() {
  // Checking if the engine is already in accept process
  if(XAxiDma_HasSg(&axiDma)) { // in SG mode
	  uint32_t rxdBDs = 0;
	  do {
        XAxiDma_Bd* BdPtr = dmaBDAlloc(true, 1, XAE_MAX_FRAME_SIZE, XAE_MAX_FRAME_SIZE, size_t(rxMem));
        dmaBDTransfer(true, 1, 1, BdPtr);
        rxdBDs = dmaBDCheck(true);
        xil_printf("Flushing %ld Rx transfers \n", rxdBDs);
	  } while (rxdBDs != 0);
  } else // in simple mode
    while ((XAxiDma_ReadReg(axiDma.RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) ||
	       !XAxiDma_Busy   (&axiDma, XAXIDMA_DEVICE_TO_DMA)) {
      int status = XAxiDma_SimpleTransfer(&axiDma, size_t(rxMem), XAE_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
      if (XST_SUCCESS != status) {
        xil_printf("\nERROR: Initial Ethernet XAxiDma Rx transfer to addr %0X with max lenth %d failed with status %d\n",
                   size_t(rxMem), XAE_MAX_FRAME_SIZE, status);
        return status;
      }
	  xil_printf("Flushing Rx data... \n");
    }

  return XST_SUCCESS;
}


/******************************************************************************/
/**
*
* This function aligns the incoming data and writes it out to a 32-bit
* aligned destination address range.
*
* @param	SrcPtr is a pointer to incoming data of any alignment.
* @param	DestPtr is a pointer to outgoing data of 32-bit alignment.
* @param	ByteCount is the number of bytes to write.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void EthSyst::alignedWrite(void* SrcPtr, unsigned ByteCount)
{
	unsigned Index;
	unsigned Length = ByteCount;
	volatile uint32_t AlignBuffer;
	volatile uint32_t *To32Ptr;
	uint32_t* From32Ptr;
	volatile uint16_t* To16Ptr;
	uint16_t* From16Ptr;
	volatile uint8_t* To8Ptr;
	uint8_t* From8Ptr;

	To32Ptr = (volatile uint32_t*)txMem;

	if ((((uint32_t) SrcPtr) & 0x00000003) == 0) {

		/*
		 * Word aligned buffer, no correction needed.
		 */
		From32Ptr = (uint32_t*) SrcPtr;

		while (Length > 3) {
			/*
			 * Output each word destination.
			 */
			*To32Ptr++ = *From32Ptr++;

			/*
			 * Adjust length accordingly
			 */
			Length -= 4;
		}

		/*
		 * Set up to output the remaining data, zero the temp buffer
		 first.
		 */
		AlignBuffer = 0;
		To8Ptr   = (uint8_t*) &AlignBuffer;
		From8Ptr = (uint8_t*) From32Ptr;

	}
	else if ((((uint32_t) SrcPtr) & 0x00000001) != 0) {
		/*
		 * Byte aligned buffer, correct.
		 */
		AlignBuffer = 0;
		To8Ptr   = (uint8_t*) &AlignBuffer;
		From8Ptr = (uint8_t*) SrcPtr;

		while (Length > 3) {
			/*
			 * Copy each byte into the temporary buffer.
			 */
			for (Index = 0; Index < 4; Index++) {
				*To8Ptr++ = *From8Ptr++;
			}

			/*
			 * Output the buffer
			 */
			*To32Ptr++ = AlignBuffer;

			/*.
			 * Reset the temporary buffer pointer and adjust length.
			 */
			To8Ptr = (uint8_t*) &AlignBuffer;
			Length -= 4;
		}

		/*
		 * Set up to output the remaining data, zero the temp buffer
		 * first.
		 */
		AlignBuffer = 0;
		To8Ptr = (uint8_t*) &AlignBuffer;

	}
	else {
		/*
		 * Half-Word aligned buffer, correct.
		 */
		AlignBuffer = 0;

		/*
		 * This is a funny looking cast. The new gcc, version 3.3.x has
		 * a strict cast check for 16 bit pointers, aka short pointers.
		 * The following warning is issued if the initial 'void *' cast
		 * is  not used:
		 * 'dereferencing type-punned pointer will break strict-aliasing
		 * rules'
		 */

		// To16Ptr   = (uint16_t*) ((void*) &AlignBuffer);
		To16Ptr   = (uint16_t*) &AlignBuffer;
		From16Ptr = (uint16_t*) SrcPtr;

		while (Length > 3) {
			/*
			 * Copy each half word into the temporary buffer.
			 */
			for (Index = 0; Index < 2; Index++) {
				*To16Ptr++ = *From16Ptr++;
			}

			/*
			 * Output the buffer.
			 */
			*To32Ptr++ = AlignBuffer;

			/*
			 * Reset the temporary buffer pointer and adjust length.
			 */

			/*
			 * This is a funny looking cast. The new gcc, version
			 * 3.3.x has a strict cast check for 16 bit pointers,
			 * aka short  pointers. The following warning is issued
			 * if the initial 'void *' cast is not used:
			 * 'dereferencing type-punned pointer will break
			 * strict-aliasing  rules'
			 */
			// To16Ptr = (uint16_t*) ((void*) &AlignBuffer);
			To16Ptr = (uint16_t*) &AlignBuffer;
			Length -= 4;
		}

		/*
		 * Set up to output the remaining data, zero the temp buffer
		 * first.
		 */
		AlignBuffer = 0;
		To8Ptr   = (uint8_t*) &AlignBuffer;
		From8Ptr = (uint8_t*) From16Ptr;
	}

	/*
	 * Output the remaining data, zero the temp buffer first.
	 */
	for (Index = 0; Index < Length; Index++) {
		*To8Ptr++ = *From8Ptr++;
	}
	if (Length) {
		*To32Ptr++ = AlignBuffer;
	}
}


/*****************************************************************************/
/**
*
* Send an Ethernet frame. The ByteCount is the total frame size, including
* header.
*
* @param	InstancePtr is a pointer to the XEmacLite instance.
* @param	FramePtr is a pointer to frame. For optimal performance, a
*		32-bit aligned buffer should be used but it is not required, the
*		function will align the data if necessary.
* @param	ByteCount is the size, in bytes, of the frame
*
* @return
*		- XST_SUCCESS if data was transmitted.
*		- XST_FAILURE if buffer(s) was (were) full and no valid data was
*	 	transmitted.
*
* @note
*
* This function call is not blocking in nature, i.e. it will not wait until the
* frame is transmitted.
*
******************************************************************************/
int EthSyst::frameSend(uint8_t* FramePtr, unsigned ByteCount)
{
    // Checking if the engine is doing transfer
    if(XAxiDma_HasSg(&axiDma)) { // in SG mode
      XAxiDma_BdRing* BdRingPtr = XAxiDma_GetTxRing(&axiDma);
	  while (size_t(XAxiDma_BdRingGetFreeCnt(BdRingPtr)) < txBdCount) {
        uint32_t txdBDs = dmaBDCheck(false);
        if (txdBDs > 1) xil_printf("DMA SG mode: Waiting untill previous Tx transfer finishes: %ld \n", txdBDs);
        // sleep(1); // in seconds, user wait process
	  }
	} else // in simple mode
      while (!(XAxiDma_ReadReg(axiDma.TxBdRing.ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) &&
	           XAxiDma_Busy   (&axiDma, XAXIDMA_DMA_TO_DEVICE)) {
        xil_printf("DMA simple mode: Waiting untill previous Tx transfer finishes \n");
        // sleep(1); // in seconds, user wait process
      }

	alignedWrite(FramePtr, ByteCount);

	/*
	 * The frame is in the buffer, now send it.
	 */
    ByteCount = std::max((unsigned)ETH_MIN_PACK_SIZE, std::min(ByteCount, (unsigned)XAE_MAX_TX_FRAME_SIZE));
    if(XAxiDma_HasSg(&axiDma)) { // in SG mode
      XAxiDma_Bd* BdPtr = dmaBDAlloc(false, 1, ByteCount, ByteCount, size_t(txMem));
      dmaBDTransfer(false, 1, 1, BdPtr);
	    return XST_SUCCESS;
    } else { // in simple mode
      int status = XAxiDma_SimpleTransfer(&axiDma, size_t(txMem), ByteCount, XAXIDMA_DMA_TO_DEVICE);
      if (XST_SUCCESS != status) {
         xil_printf("\nERROR: Ethernet XAxiDma Tx transfer from addr %0X with lenth %d failed with status %d\n",
                size_t(txMem), ByteCount, status);
      }
	  return status;
	}
}


/*****************************************************************************/
/**
*
* Return the length of the data in the Receive Buffer.
*
* @param	BaseAddress contains the base address of the device.
*
* @return	The type/length field of the frame received.
*
* @note		None.
*
******************************************************************************/
uint16_t EthSyst::getReceiveDataLength(uint16_t headerOffset) {

	uint16_t length = rxMem[headerOffset / sizeof(uint32_t)];
	length = ((length & 0xFF00) >> 8) | ((length & 0x00FF) << 8);

  xil_printf("   Accepting packet at mem addr 0x%X, extracting length/type %d(0x%X) at offset %d \n",
              size_t(rxMem), length, length, headerOffset);

	return length;
}


/******************************************************************************/
/**
*
* This function reads from a 32-bit aligned source address range and aligns
* the writes to the provided destination pointer alignment.
*
* @param	SrcPtr is a pointer to incoming data of 32-bit alignment.
* @param	DestPtr is a pointer to outgoing data of any alignment.
* @param	ByteCount is the number of bytes to read.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void EthSyst::alignedRead(void* DestPtr, unsigned ByteCount)
{
	unsigned Index;
	unsigned Length = ByteCount;
	volatile uint32_t AlignBuffer;
	uint32_t* To32Ptr;
	volatile uint32_t* From32Ptr;
	uint16_t* To16Ptr;
	volatile uint16_t* From16Ptr;
	uint8_t* To8Ptr;
	volatile uint8_t* From8Ptr;

	From32Ptr = (uint32_t*)rxMem;

	if ((((uint32_t) DestPtr) & 0x00000003) == 0) {

		/*
		 * Word aligned buffer, no correction needed.
		 */
		To32Ptr = (uint32_t*) DestPtr;

		while (Length > 3) {
			/*
			 * Output each word.
			 */
			*To32Ptr++ = *From32Ptr++;

			/*
			 * Adjust length accordingly.
			 */
			Length -= 4;
		}

		/*
		 * Set up to read the remaining data.
		 */
		To8Ptr = (uint8_t*) To32Ptr;

	}
	else if ((((uint32_t) DestPtr) & 0x00000001) != 0) {
		/*
		 * Byte aligned buffer, correct.
		 */
		To8Ptr = (uint8_t*) DestPtr;

		while (Length > 3) {
			/*
			 * Copy each word into the temporary buffer.
			 */
			AlignBuffer = *From32Ptr++;
			From8Ptr = (uint8_t*) &AlignBuffer;

			/*
			 * Write data to destination.
			 */
			for (Index = 0; Index < 4; Index++) {
				*To8Ptr++ = *From8Ptr++;
			}

			/*
			 * Adjust length
			 */
			Length -= 4;
		}

	}
	else {
		/*
		 * Half-Word aligned buffer, correct.
		 */
		To16Ptr = (uint16_t*) DestPtr;

		while (Length > 3) {
			/*
			 * Copy each word into the temporary buffer.
			 */
			AlignBuffer = *From32Ptr++;

			/*
			 * This is a funny looking cast. The new gcc, version
			 * 3.3.x has a strict cast check for 16 bit pointers,
			 * aka short pointers. The following warning is issued
			 * if the initial 'void *' cast is not used:
			 * 'dereferencing type-punned pointer will break
			 *  strict-aliasing rules'
			 */
			// From16Ptr = (uint16_t*) ((void*) &AlignBuffer);
			From16Ptr = (uint16_t*) &AlignBuffer;

			/*
			 * Write data to destination.
			 */
			for (Index = 0; Index < 2; Index++) {
				*To16Ptr++ = *From16Ptr++;
			}

			/*
			 * Adjust length.
			 */
			Length -= 4;
		}

		/*
		 * Set up to read the remaining data.
		 */
		To8Ptr = (uint8_t*) To16Ptr;
	}

	/*
	 * Read the remaining data.
	 */
	AlignBuffer = *From32Ptr++;
	From8Ptr = (uint8_t*) &AlignBuffer;

	for (Index = 0; Index < Length; Index++) {
		*To8Ptr++ = *From8Ptr++;
	}
}


/*****************************************************************************/
/**
*
* Receive a frame. Intended to be called from the interrupt context or
* with a wrapper which waits for the receive frame to be available.
*
* @param	InstancePtr is a pointer to the XEmacLite instance.
* @param 	FramePtr is a pointer to a buffer where the frame will
*		be stored. The buffer must be at least XAE_MAX_FRAME_SIZE bytes.
*		For optimal performance, a 32-bit aligned buffer should be used
*		but it is not required, the function will align the data if
*		necessary.
*
* @return
*
* The type/length field of the frame received.  When the type/length field
* contains the type, XAE_MAX_FRAME_SIZE bytes will be copied out of the
* buffer and it is up to the higher layers to sort out the frame.
* Function returns 0 if there is no data waiting in the receive buffer or
* the pong buffer if configured.
*
* @note
*
* This function call is not blocking in nature, i.e. it will not wait until
* a frame arrives.
*
******************************************************************************/
uint16_t EthSyst::frameRecv(uint8_t* FramePtr)
{
	uint16_t LengthType;
	uint16_t Length;

  if(XAxiDma_HasSg(&axiDma)) { // in SG mode
      if (dmaBDCheck(true) == 0) return 0;
  } else // in simple mode
    if (XAxiDma_Busy(&axiDma, XAXIDMA_DEVICE_TO_DMA)) return 0;

    // xil_printf("Some Rx frame is received \n");

	/*
	 * Get the length of the frame that arrived.
	 */
	LengthType = getReceiveDataLength(XAE_HEADER_OFFSET);

	/*
	 * Check if length is valid.
	 */
	if (LengthType > XAE_MAX_FRAME_SIZE) {


		if (LengthType == XAE_ETHER_PROTO_TYPE_IP) {

      Length = getReceiveDataLength(XAE_HEADER_IP_LENGTH_OFFSET);
      Length += XAE_HDR_SIZE + XAE_TRL_SIZE;

    } else if (LengthType == XAE_ETHER_PROTO_TYPE_ARP) {

			/*
			 * The packet is an ARP Packet.
			 */
			Length = XAE_ARP_PACKET_SIZE + XAE_HDR_SIZE + XAE_TRL_SIZE;

		} else {
			/*
			 * Field contains type other than IP or ARP, use max
			 * frame size and let user parse it.
			 */
			Length = XAE_MAX_FRAME_SIZE;

		}
	} else {

		/*
		 * Use the length in the frame, plus the header and trailer.
		 */
		Length = LengthType + XAE_HDR_SIZE + XAE_TRL_SIZE;
	}

	alignedRead(FramePtr, Length);

	/*
	 * Acknowledge the frame.
	 */
  if(XAxiDma_HasSg(&axiDma)) { // in SG mode
      XAxiDma_Bd* BdPtr = dmaBDAlloc(true, 1, XAE_MAX_FRAME_SIZE, XAE_MAX_FRAME_SIZE, size_t(rxMem));
      dmaBDTransfer(true, 1, 1, BdPtr);
  }
	else { // in simple mode
	  int status = XAxiDma_SimpleTransfer(&axiDma, size_t(rxMem), XAE_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
      if (XST_SUCCESS != status) {
        xil_printf("\nERROR: Ethernet XAxiDma Rx transfer to addr %0X with max lenth %d failed with status %d\n",
		       size_t(rxMem), XAE_MAX_FRAME_SIZE, status);
	  }
	}

	return Length;
}
