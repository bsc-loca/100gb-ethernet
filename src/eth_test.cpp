
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <algorithm>
// #include <vector>
// #include <string>
// #include <xil_sleeptimer.h>
// #include <cassert>
// #include <iostream>
// #include <fstream>
// #include <sstream>
// #include <thread>
// #include <chrono>
// #include <fcntl.h>
// #include <sys/stat.h>

#include "xparameters.h"
#include "xaxis_switch.h"
#include "xgpio.h"
#include "xaxidma.h"
#include "../../../project/ethernet_test_eth100gb_0_axi4_lite_registers.h" // generated during implementation if AXI-Lite is enabled in Ethernet core
#include "fsl.h" // FSL macros: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2016_4/oslib_rm.pdf#page=16

// using namespace std;

void transmitToChan(uint8_t packetWords, uint8_t chanDepth, bool rxCheck, bool txCheck) {
    printf("CPU: Transmitting %d whole packets with length %d words (+%d words) to channel with depth %d words \n",
            chanDepth/packetWords, packetWords, chanDepth%packetWords, chanDepth);
    uint32_t putData = 0;
    uint32_t getData = 0;
    bool fslNrdy = true;
    bool fslErr  = true;

    if (rxCheck) {
      // if initially Rx channel should be empty
      getfslx(getData, 0, FSL_NONBLOCKING);
      fsl_isinvalid(fslNrdy);
      fsl_iserror  (fslErr);
      if (!fslNrdy) {
        printf("\nERROR: Before starting filling Tx channel Rx channel is not empty: FSL0 = %0lX, Empty = %d, Err = %d \n",
                 getData, fslNrdy, fslErr);
        exit(1);
      }
    }

    srand(1);
    for (uint8_t word = 0; word < chanDepth;                 word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      putData = rand();
      // FSL id goes to macro as literal
      if (word%packetWords == (packetWords-1)) { // transmitting TLAST in last words (FSL 0 only is used to pass this control)
        if (chan==0)  putfslx(putData,  0, FSL_NONBLOCKING_CONTROL);
        if (chan==1)  putfslx(putData,  1, FSL_NONBLOCKING);
        if (chan==2)  putfslx(putData,  2, FSL_NONBLOCKING);
        if (chan==3)  putfslx(putData,  3, FSL_NONBLOCKING);
        if (chan==4)  putfslx(putData,  4, FSL_NONBLOCKING);
        if (chan==5)  putfslx(putData,  5, FSL_NONBLOCKING);
        if (chan==6)  putfslx(putData,  6, FSL_NONBLOCKING);
        if (chan==7)  putfslx(putData,  7, FSL_NONBLOCKING);
        if (chan==8)  putfslx(putData,  8, FSL_NONBLOCKING);
        if (chan==9)  putfslx(putData,  9, FSL_NONBLOCKING);
        if (chan==10) putfslx(putData, 10, FSL_NONBLOCKING);
        if (chan==11) putfslx(putData, 11, FSL_NONBLOCKING);
        if (chan==12) putfslx(putData, 12, FSL_NONBLOCKING);
        if (chan==13) putfslx(putData, 13, FSL_NONBLOCKING);
        if (chan==14) putfslx(putData, 14, FSL_NONBLOCKING);
        if (chan==15) putfslx(putData, 15, FSL_NONBLOCKING);
      } else {
        if (chan==0)  putfslx(putData,  0, FSL_NONBLOCKING);
        if (chan==1)  putfslx(putData,  1, FSL_NONBLOCKING_CONTROL);
        if (chan==2)  putfslx(putData,  2, FSL_NONBLOCKING_CONTROL);
        if (chan==3)  putfslx(putData,  3, FSL_NONBLOCKING_CONTROL);
        if (chan==4)  putfslx(putData,  4, FSL_NONBLOCKING_CONTROL);
        if (chan==5)  putfslx(putData,  5, FSL_NONBLOCKING_CONTROL);
        if (chan==6)  putfslx(putData,  6, FSL_NONBLOCKING_CONTROL);
        if (chan==7)  putfslx(putData,  7, FSL_NONBLOCKING_CONTROL);
        if (chan==8)  putfslx(putData,  8, FSL_NONBLOCKING_CONTROL);
        if (chan==9)  putfslx(putData,  9, FSL_NONBLOCKING_CONTROL);
        if (chan==10) putfslx(putData, 10, FSL_NONBLOCKING_CONTROL);
        if (chan==11) putfslx(putData, 11, FSL_NONBLOCKING_CONTROL);
        if (chan==12) putfslx(putData, 12, FSL_NONBLOCKING_CONTROL);
        if (chan==13) putfslx(putData, 13, FSL_NONBLOCKING_CONTROL);
        if (chan==14) putfslx(putData, 14, FSL_NONBLOCKING_CONTROL);
        if (chan==15) putfslx(putData, 15, FSL_NONBLOCKING_CONTROL);
      }
      fsl_isinvalid(fslNrdy);
      fsl_iserror  (fslErr);
      // printf("Writing word %d to FSL%d = %0lX, Full = %d, Err = %d \n", word, chan, putData, fslNrdy, fslErr);
      if (fslNrdy || fslErr) {
        printf("\nERROR: Failed write of word %d to FSL%d = %0lX, Full = %d, Err = %d \n", word, chan, putData, fslNrdy, fslErr);
        exit(1);
      }
    }
    if (txCheck) {
      // if full depth of Tx channel is used, here it should be full
      putfslx(putData, 0, FSL_NONBLOCKING);
      fsl_isinvalid(fslNrdy);
      if (!fslNrdy) {
        printf("\nERROR: After filling Tx channel it is still not full\n");
        exit(1);
      }
    }
}

void receiveFrChan(uint8_t packetWords, uint8_t chanDepth) {
    printf("CPU: Receiving %d whole packets with length %d words (+%d words) from channel with depth %d words \n",
            chanDepth/packetWords, packetWords, chanDepth%packetWords, chanDepth);
    uint32_t putData = 0;
    uint32_t getData = 0;
    bool fslNrdy = true;
    bool fslErr  = true;

    srand(1);
    for (uint8_t word = 0; word < chanDepth;                 word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      putData = rand();
      // FSL id goes to macro as literal 
      if (word%packetWords == (packetWords-1)) { // expecting TLAST in last words (populated to all FSLs)
        if (chan==0)  getfslx(getData,  0, FSL_NONBLOCKING_CONTROL);
        if (chan==1)  getfslx(getData,  1, FSL_NONBLOCKING_CONTROL);
        if (chan==2)  getfslx(getData,  2, FSL_NONBLOCKING_CONTROL);
        if (chan==3)  getfslx(getData,  3, FSL_NONBLOCKING_CONTROL);
        if (chan==4)  getfslx(getData,  4, FSL_NONBLOCKING_CONTROL);
        if (chan==5)  getfslx(getData,  5, FSL_NONBLOCKING_CONTROL);
        if (chan==6)  getfslx(getData,  6, FSL_NONBLOCKING_CONTROL);
        if (chan==7)  getfslx(getData,  7, FSL_NONBLOCKING_CONTROL);
        if (chan==8)  getfslx(getData,  8, FSL_NONBLOCKING_CONTROL);
        if (chan==9)  getfslx(getData,  9, FSL_NONBLOCKING_CONTROL);
        if (chan==10) getfslx(getData, 10, FSL_NONBLOCKING_CONTROL);
        if (chan==11) getfslx(getData, 11, FSL_NONBLOCKING_CONTROL);
        if (chan==12) getfslx(getData, 12, FSL_NONBLOCKING_CONTROL);
        if (chan==13) getfslx(getData, 13, FSL_NONBLOCKING_CONTROL);
        if (chan==14) getfslx(getData, 14, FSL_NONBLOCKING_CONTROL);
        if (chan==15) getfslx(getData, 15, FSL_NONBLOCKING_CONTROL);
      } else {
        if (chan==0)  getfslx(getData,  0, FSL_NONBLOCKING);
        if (chan==1)  getfslx(getData,  1, FSL_NONBLOCKING);
        if (chan==2)  getfslx(getData,  2, FSL_NONBLOCKING);
        if (chan==3)  getfslx(getData,  3, FSL_NONBLOCKING);
        if (chan==4)  getfslx(getData,  4, FSL_NONBLOCKING);
        if (chan==5)  getfslx(getData,  5, FSL_NONBLOCKING);
        if (chan==6)  getfslx(getData,  6, FSL_NONBLOCKING);
        if (chan==7)  getfslx(getData,  7, FSL_NONBLOCKING);
        if (chan==8)  getfslx(getData,  8, FSL_NONBLOCKING);
        if (chan==9)  getfslx(getData,  9, FSL_NONBLOCKING);
        if (chan==10) getfslx(getData, 10, FSL_NONBLOCKING);
        if (chan==11) getfslx(getData, 11, FSL_NONBLOCKING);
        if (chan==12) getfslx(getData, 12, FSL_NONBLOCKING);
        if (chan==13) getfslx(getData, 13, FSL_NONBLOCKING);
        if (chan==14) getfslx(getData, 14, FSL_NONBLOCKING);
        if (chan==15) getfslx(getData, 15, FSL_NONBLOCKING);
      }
      fsl_isinvalid(fslNrdy);
      fsl_iserror  (fslErr);
      // printf("Reading word %d from FSL%d = %0lX, Empty = %d, Err = %d \n", word, chan, getData, fslNrdy, fslErr);
      if (fslNrdy || fslErr || getData!=putData) {
        printf("\nERROR: Failed read of word %d from FSL%d = %0lX (expected %0lX), Empty = %d, Err = %d \n",
               word, chan, getData, putData, fslNrdy, fslErr);
        exit(1);
      }
    }
    // here Rx channel should be empty
    getfslx(getData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    fsl_iserror  (fslErr);
    if (!fslNrdy) {
      printf("\nERROR: After reading out Rx channel it is still not empty: FSL0 = %0lX, Empty = %d, Err = %d \n",
               getData, fslNrdy, fslErr);
      exit(1);
    }
}

void switch_CPU_DMAxEth_LB(bool txNrx, bool cpu2eth_dma2lb) {
  // AXIS switches control: https://www.xilinx.com/support/documentation/ip_documentation/axis_infrastructure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf#page=27
  uint32_t* strSwitch = txNrx ? reinterpret_cast<uint32_t*>(XPAR_TX_AXIS_SWITCH_BASEADDR) :
                                reinterpret_cast<uint32_t*>(XPAR_RX_AXIS_SWITCH_BASEADDR);
  enum {SW_CTR = XAXIS_SCR_CTRL_OFFSET         / sizeof(uint32_t),
        MI_MUX = XAXIS_SCR_MI_MUX_START_OFFSET / sizeof(uint32_t)
       };

  if (txNrx) printf("TX ");
  else       printf("RX ");
  printf("Stream Switch state:\n");
  printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  if (cpu2eth_dma2lb) {
    printf("Connecting CPU to Ethernet core, DMA to Short LB, ");
    strSwitch[MI_MUX+0] = 1; // connect Out0(Tx:LB /Rx:CPU) to In1(Tx:DMA/Rx:Eth)
    strSwitch[MI_MUX+1] = 0; // connect Out1(Tx:Eth/Rx:DMA) to In0(Tx:CPU/Rx:LB)
  } else {
    printf("Connecting DMA to Ethernet core, CPU to Short LB, ");
    strSwitch[MI_MUX+0] = 0; // connect Out0(Tx:LB /Rx:CPU) to In0(Tx:CPU/Rx:LB)
    strSwitch[MI_MUX+1] = 1; // connect Out1(Tx:Eth/Rx:DMA) to In1(Tx:DMA/Rx:Eth)
  }
  // printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  printf("Commiting the setting\n");
  strSwitch[SW_CTR] = XAXIS_SCR_CTRL_REG_UPDATE_MASK;
  printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  printf("Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", strSwitch[SW_CTR], strSwitch[MI_MUX], strSwitch[MI_MUX+1]);
  printf("\n");
}


//100Gb Ethernet subsystem registers: https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=177
uint32_t* ethCore = reinterpret_cast<uint32_t*>(XPAR_ETH100GB_BASEADDR);
enum {
  GT_RESET_REG          = GT_RESET_REG_OFFSET          / sizeof(uint32_t),
  RESET_REG             = RESET_REG_OFFSET             / sizeof(uint32_t),
  CORE_VERSION_REG      = CORE_VERSION_REG_OFFSET      / sizeof(uint32_t),
  CORE_MODE_REG         = CORE_MODE_REG_OFFSET         / sizeof(uint32_t),
  SWITCH_CORE_MODE_REG  = SWITCH_CORE_MODE_REG_OFFSET  / sizeof(uint32_t),
  CONFIGURATION_TX_REG1 = CONFIGURATION_TX_REG1_OFFSET / sizeof(uint32_t),
  CONFIGURATION_RX_REG1 = CONFIGURATION_RX_REG1_OFFSET / sizeof(uint32_t),
  STAT_TX_STATUS_REG    = STAT_TX_STATUS_REG_OFFSET    / sizeof(uint32_t),
  STAT_RX_STATUS_REG    = STAT_RX_STATUS_REG_OFFSET    / sizeof(uint32_t),
  GT_LOOPBACK_REG       = GT_LOOPBACK_REG_OFFSET       / sizeof(uint32_t)
};
// Ethernet core control via pins 
uint32_t* rxtxCtrl = reinterpret_cast<uint32_t*>(XPAR_TX_RX_CTL_STAT_BASEADDR);
enum {
  TX_CTRL = XGPIO_DATA_OFFSET  / sizeof(uint32_t),
  RX_CTRL = XGPIO_DATA2_OFFSET / sizeof(uint32_t)
};
void ethCoreSetup(bool gtLoopback) {
  printf("------- Initializing Ethernet Core -------\n");
  // GT control via pins 
  uint32_t* gtCtrl = reinterpret_cast<uint32_t*>(XPAR_GT_CTL_BASEADDR);
  enum { GT_CTRL = XGPIO_DATA_OFFSET / sizeof(uint32_t) };

  printf("Soft reset of Ethernet core:\n");
  printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  ethCore[GT_RESET_REG] = GT_RESET_REG_GT_RESET_ALL_MASK;
  ethCore[RESET_REG]    = RESET_REG_USR_RX_SERDES_RESET_MASK |
                          RESET_REG_USR_RX_RESET_MASK        |
                          RESET_REG_USR_TX_RESET_MASK;
  printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  sleep(1); // in seconds
  ethCore[RESET_REG] = RESET_REG_USR_RX_SERDES_RESET_DEFAULT |
                       RESET_REG_USR_RX_RESET_DEFAULT |
                       RESET_REG_USR_TX_RESET_DEFAULT;
  sleep(1); // in seconds
  printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n\n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
  
  // Reading status via pins
  printf("GT_POWER_PINS: %0lX \n", gtCtrl[GT_CTRL]);
  printf("STAT_TX_STATUS_PINS: %0lX \n", rxtxCtrl[TX_CTRL]);
  printf("STAT_RX_STATUS_PINS: %0lX \n", rxtxCtrl[RX_CTRL]);
  // Reading status and other regs via AXI
  printf("GT_RESET_REG:          %0lX \n", ethCore[GT_RESET_REG]);
  printf("RESET_REG:             %0lX \n", ethCore[RESET_REG]);
  printf("CORE_VERSION_REG:      %0lX \n", ethCore[CORE_VERSION_REG]);
  printf("CORE_MODE_REG:         %0lX \n", ethCore[CORE_MODE_REG]);
  printf("SWITCH_CORE_MODE_REG:  %0lX \n", ethCore[SWITCH_CORE_MODE_REG]);
  printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
  printf("CONFIGURATION_RX_REG1: %0lX \n", ethCore[CONFIGURATION_RX_REG1]);
  printf("STAT_TX_STATUS_REG:    %0lX \n", ethCore[STAT_TX_STATUS_REG]);
  printf("STAT_RX_STATUS_REG:    %0lX \n", ethCore[STAT_RX_STATUS_REG]);
  printf("GT_LOOPBACK_REG:       %0lX \n", ethCore[GT_LOOPBACK_REG]);
  printf("\n");
  
  if (gtLoopback) {
    printf("Enabling Near-End PMA Loopback\n");
    // gtCtrl[GT_CTRL] = 0x2222; // via GPIO: https://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88
    printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    ethCore[GT_LOOPBACK_REG] = GT_LOOPBACK_REG_CTL_GT_LOOPBACK_MASK;
    printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
  } else {
    printf("Enabling GT normal operation with no loopback\n");
    // gtCtrl[GT_CTRL] = 0; // via GPIO
    printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
    ethCore[GT_LOOPBACK_REG] = GT_LOOPBACK_REG_CTL_GT_LOOPBACK_DEFAULT;
    printf("GT_LOOPBACK_REG: %0lX \n", ethCore[GT_LOOPBACK_REG]);
  }
  printf("\n");
  
  printf("Ethernet core bring-up.\n");
  // https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=204
  // via GPIO
  // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_MASK;
  // via AXI
  printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                  ethCore[CONFIGURATION_RX_REG1]);
  ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_MASK;
  printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                  ethCore[CONFIGURATION_RX_REG1]);
  printf("\n");
                                                 
  printf("Waiting for RX is aligned and RFI is got from TX side...\n");
  while(!(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_ALIGNED_MASK) ||
        !(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_REMOTE_FAULT_MASK)) {
  printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                 ethCore[STAT_RX_STATUS_REG]);
    sleep(1); // in seconds, user wait process
  }
  printf("RX is aligned and RFI is got from TX side:\n");
  printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                 ethCore[STAT_RX_STATUS_REG]);
  printf("\n");

  printf("Disabling TX_SEND_RFI:\n");
  if (!gtLoopback) sleep(1); // in seconds, timeout to make sure opposite side also got RFI
  // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_DEFAULT; // via GPIO
  printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                  ethCore[CONFIGURATION_RX_REG1]);
  ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_DEFAULT;
  printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX\n", ethCore[CONFIGURATION_TX_REG1],
                                                  ethCore[CONFIGURATION_RX_REG1]);
  printf("\n");

  printf("Waiting for RFI is stopped...\n");
  while(!(ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_ALIGNED_MASK) ||
         (ethCore[STAT_RX_STATUS_REG] & STAT_RX_STATUS_REG_STAT_RX_REMOTE_FAULT_MASK)) {
  printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                 ethCore[STAT_RX_STATUS_REG]);
    sleep(1); // in seconds, user wait process
  }
  printf("RFI is stopped:\n");
  printf("STAT_TX/RX_STATUS_PINS: %0lX/%0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
  printf("STAT_TX/RX_STATUS_REGS: %0lX/%0lX \n", ethCore[STAT_TX_STATUS_REG],
                                                 ethCore[STAT_RX_STATUS_REG]);
}

XAxiDma axiDma; // AXI DMA instance definitions
void axiDmaSetup() {
  printf("------- Initializing DMA -------\n");
  // Direct AXI DMA control: http://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf
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
    printf("\nERROR: No config found for XAxiDma %d\n", XPAR_ETH_DMA_DEVICE_ID);
    exit(1);
  }
  // XAxiDma definitions initialization
  int status = XAxiDma_CfgInitialize(&axiDma, cfgPtr);
  if (XST_SUCCESS != status) {
    printf("\nERROR: XAxiDma initialization failed with status %d\n", status);
    exit(1);
  }
 	// XAxiDma reset with checking if reset is done 
  status = XAxiDma_Selftest(&axiDma);
  if (XST_SUCCESS != status) {
    printf("\nERROR: XAxiDma selftest(reset) failed with status %d\n", status);
    exit(1);
  }
  // Confirming XAxiDma is not in Scatter-Gather mode
 	if(XAxiDma_HasSg(&axiDma)) {
	  printf("\nERROR: XAxiDma configured as Scatter-Gather mode \n");
    exit(1);
  }
 	// Disable interrupts, we use polling mode
  XAxiDma_IntrDisable(&axiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
  XAxiDma_IntrDisable(&axiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

  printf("XAxiDma is initialized and reset: \n");
  printf("MicroDmaMode             = %d  \n", axiDma.MicroDmaMode);
  printf("AddrWidth                = %d  \n", axiDma.AddrWidth);
  printf("TxBdRing.DataWidth       = %d  \n", axiDma.TxBdRing.DataWidth);
  printf("TxBdRing.Addr_ext        = %d  \n", axiDma.TxBdRing.Addr_ext);
  printf("TxBdRing.MaxTransferLen  = %lX \n", axiDma.TxBdRing.MaxTransferLen);
  printf("TxBdRing.FirstBdPhysAddr = %d  \n", axiDma.TxBdRing.FirstBdPhysAddr);
  printf("TxBdRing.FirstBdAddr     = %d  \n", axiDma.TxBdRing.FirstBdAddr);
  printf("TxBdRing.LastBdAddr      = %d  \n", axiDma.TxBdRing.LastBdAddr);
  printf("TxBdRing.Length          = %lX \n", axiDma.TxBdRing.Length);
  printf("TxBdRing.Separation      = %d  \n", axiDma.TxBdRing.Separation);
  printf("TxBdRing.Cyclic          = %d  \n", axiDma.TxBdRing.Cyclic);
  printf("Tx_control reg = %0lX \n", dmaCore[MM2S_DMACR]);
  printf("Tx_status  reg = %0lX \n", dmaCore[MM2S_DMASR]);
  printf("Rx_control reg = %0lX \n", dmaCore[S2MM_DMACR]);
  printf("Rx_status  reg = %0lX \n", dmaCore[S2MM_DMASR]);
}


int main(int argc, char *argv[])
{
  // Tx/Rx memories 
  uint32_t* txMem = reinterpret_cast<uint32_t*>(XPAR_TX_MEM_CPU_S_AXI_BASEADDR);
  uint32_t* rxMem = reinterpret_cast<uint32_t*>(XPAR_RX_MEM_CPU_S_AXI_BASEADDR);
  size_t const txMemSize  = (XPAR_TX_MEM_CPU_S_AXI_HIGHADDR+1 -
                             XPAR_TX_MEM_CPU_S_AXI_BASEADDR);
  size_t const rxMemSize  = (XPAR_RX_MEM_CPU_S_AXI_HIGHADDR+1 -
                             XPAR_RX_MEM_CPU_S_AXI_BASEADDR);
  size_t const txrxMemSize = std::min(txMemSize, rxMemSize);
  size_t const txMemWords = txMemSize / sizeof(uint32_t);
  size_t const rxMemWords = rxMemSize / sizeof(uint32_t);

  enum {ETH_WORD_SIZE = sizeof(uint32_t) * XPAR_MICROBLAZE_FSL_LINKS,
        DMA_AXI_BURST = ETH_WORD_SIZE * std::max(XPAR_ETH_DMA_MM2S_BURST_SIZE, // the parameter set in Vivado AXI_DMA IP
                                                 XPAR_ETH_DMA_S2MM_BURST_SIZE),
        CPU_PACKET_LEN   = ETH_WORD_SIZE * 8, // the parameter to play with
        CPU_PACKET_WORDS = (CPU_PACKET_LEN + ETH_WORD_SIZE - 1) / ETH_WORD_SIZE,
        DMA_PACKET_LEN   = ETH_WORD_SIZE*(64*3+3) + sizeof(uint32_t) + 3, // the parameter to play with (no issies met for any values and granularities)
        ETH_PACKET_LEN   = ETH_WORD_SIZE*150 - sizeof(uint32_t), // the parameter to play with (no issues for granularity=sizeof(uint32_t) and 
                                                                 // range=[(1...~150)*ETH_WORD_SIZE] (defaults in Eth100Gb IP as min/max packet length=64...9600))
        ETH_MEMPACK_SIZE = ETH_PACKET_LEN > DMA_AXI_BURST/2  ? ((ETH_PACKET_LEN + DMA_AXI_BURST-1) / DMA_AXI_BURST) * DMA_AXI_BURST :
                           ETH_PACKET_LEN > DMA_AXI_BURST/4  ? DMA_AXI_BURST/2  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/8  ? DMA_AXI_BURST/4  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/16 ? DMA_AXI_BURST/8  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/32 ? DMA_AXI_BURST/16 : ETH_PACKET_LEN
  };
  enum { // hardware defined depths of channels
        SHORT_LOOPBACK_DEPTH  = 104,
        TRANSMIT_FIFO_DEPTH   = 40,
        DMA_TX_LOOPBACK_DEPTH = CPU_PACKET_WORDS==1 ? 95 : 96,
        DMA_RX_LOOPBACK_DEPTH = CPU_PACKET_WORDS==1 ? 43 : 40
  };


  while (true) {

    printf("\n");
    printf("------ Ethernet Test App ------\n");
    printf("Please enter test mode:\n");
    printf("  Loopback tests:              l\n");
    printf("  2-boards communication test: c\n");
    printf("  Finish:                      f\n");
    char choice;
    scanf("%s", &choice);
    printf("You have entered: %c\n\n", choice);


    switch (choice) {
      case 'l': {
        printf("------- Running CPU Short Loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds
        transmitToChan(CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH, true, true);
        receiveFrChan (CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH);
        printf("------- CPU Short Loopback test PASSED -------\n\n");

        ethCoreSetup(true);

        printf("\n------- Running CPU Near-end Loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, true, true);
        printf("Enabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
    
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        printf("Disabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
    
        printf("------- CPU Near-end Loopback test PASSED -------\n\n");


        printf("------- Running DMA Tx/Rx memory test -------\n");
        printf("Checking memories with random values from %0X to %0X \n", 0, RAND_MAX);
        // first clearing previously stored values
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = 0;
        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = 0;
        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = rand();
        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) {
          uint32_t expectVal = rand(); 
          if (txMem[addr] != expectVal) {
            printf("\nERROR: Incorret readback of word at addr %0X from Tx Mem: %0lX, expected: %0lX \n", addr, txMem[addr], expectVal);
            exit(1);
          }
        }
        for (size_t addr = 0; addr < rxMemWords; ++addr) {
          uint32_t expectVal = rand(); 
          if (rxMem[addr] != expectVal) {
            printf("\nERROR: Incorret readback of word at addr %0X from Rx Mem: %0lX, expected: %0lX \n", addr, rxMem[addr], expectVal);
            exit(1);
          }
        }
        printf("------- DMA Tx/Rx memory test PASSED -------\n\n");

        axiDmaSetup();

        printf("\n------- Running DMA-CPU Short Loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  true);  // Tx switch: DMA->LB, CPU->Eth
        switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = rand();

        printf("DMA: Transmitting %d whole packets with length %d bytes to channel with depth %d words\n",
                DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS, CPU_PACKET_LEN, DMA_TX_LOOPBACK_DEPTH);
        // axiDma.HasSg = true; // checking debug messages work in driver call
        size_t dmaMemPtr = 0;
        for (size_t packet = 0; packet < DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS; packet++) {
		      int status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(&axiDma, XAXIDMA_DMA_TO_DEVICE)) {
            printf("Waiting untill Tx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        receiveFrChan(CPU_PACKET_WORDS, (DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_WORDS);
        printf("------- DMA-CPU Short Loopback test PASSED -------\n\n");


        printf("------- Running CPU-DMA Short Loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        switch_CPU_DMAxEth_LB(false, true);  // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = 0;

        transmitToChan(CPU_PACKET_WORDS, (DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_WORDS, true, CPU_PACKET_WORDS==1);

        printf("DMA: Receiving %d whole packets with length %d bytes from channel with depth %d words \n",
                DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS, CPU_PACKET_LEN, DMA_RX_LOOPBACK_DEPTH);
        // axiDma.HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS; packet++) {
		      int status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(&axiDma,XAXIDMA_DEVICE_TO_DMA)) {
            printf("Waiting untill Rx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        srand(1);
        for (size_t addr = 0; addr < ((DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          uint32_t expectVal = rand(); 
          if (rxMem[addr] != expectVal) {
            printf("\nERROR: Incorrect data recieved by DMA at addr %0X: %0lX, expected: %0lX \n", addr, rxMem[addr], expectVal);
            exit(1);
          }
        }
        printf("------- CPU-DMA Short Loopback test PASSED -------\n\n");


        printf("------- Running DMA Short Loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  true); // Tx switch: DMA->LB, CPU->Eth
        switch_CPU_DMAxEth_LB(false, true); // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = 0;

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/DMA_PACKET_LEN, DMA_PACKET_LEN, txrxMemSize);
        // axiDma.HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/DMA_PACKET_LEN; packet++) {
		      int status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, DMA_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, DMA_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(&axiDma,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(&axiDma,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill last Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaMemPtr += DMA_PACKET_LEN;
    		}

        for (size_t addr = 0; addr < ((txrxMemSize/DMA_PACKET_LEN)*DMA_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          if (rxMem[addr] != txMem[addr]) {
            printf("\nERROR: Incorrect data transferred by DMA at addr %d: %0lX, expected: %0lX \n", addr, rxMem[addr], txMem[addr]);
            exit(1);
          }
        }
        printf("------- DMA Short Loopback test PASSED -------\n\n");


        printf("------- Running DMA Near-end loopback test -------\n");
        switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = 0;

        printf("Enabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/ETH_MEMPACK_SIZE, ETH_PACKET_LEN, txrxMemSize);
        // axiDma.HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++) {
		      int status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(&axiDma,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(&axiDma,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
    	  	}
          dmaMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++)
        for (size_t word   = 0; word < ETH_PACKET_LEN/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (rxMem[addr] != txMem[addr]) {
            printf("\nERROR: Incorrect data transferred by DMA in packet %d at addr %d: %0lX, expected: %0lX \n",
                    packet, addr, rxMem[addr], txMem[addr]);
            exit(1);
          }
        }

        printf("Disabling Ethernet TX/RX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT; // via GPIO
        // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT; // via GPIO
        printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                         ethCore[CONFIGURATION_RX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT;
        ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT;
        printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                         ethCore[CONFIGURATION_RX_REG1]);
        printf("------- DMA Near-end loopback test PASSED -------\n\n");
      }
      break;


      case 'c': {
        printf("------- Running 2-boards communication test -------\n");
        printf("Please make sure that the same mode is running on the other side and confirm with 'y'...\n");
        char confirm;
        scanf("%s", &confirm);
        printf("%c\n", confirm);
        if (confirm != 'y') break;

        ethCoreSetup(false);

        printf("------- CPU 2-boards communication test -------\n");
        switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, false, true);
        printf("Enabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);

        sleep(1); // in seconds, delay not to use blocking read in receive process
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        printf("Disabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
    
        printf("------- CPU 2-boards communication test PASSED -------\n\n");

        axiDmaSetup();

        printf("------- DMA 2-boards communication test -------\n");
        switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) rxMem[addr] = 0;

        printf("Enabling Ethernet TX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK; // via GPIO
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
        printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/ETH_MEMPACK_SIZE, ETH_PACKET_LEN, txrxMemSize);
        // axiDma.HasSg = true; // checking debug messages work in driver call
        size_t dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++) {
		      int status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
          if (packet == 0) sleep(1); // in seconds, timeout before 1st packet Tx transfer to make sure opposite side also has set Rx transfer
		      status = XAxiDma_SimpleTransfer(&axiDma, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(&axiDma,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(&axiDma,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
    		}
          dmaMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++)
        for (size_t word   = 0; word < ETH_PACKET_LEN/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (rxMem[addr] != txMem[addr]) {
            printf("\nERROR: Incorrect data transferred by DMA in packet %d at addr %d: %0lX, expected: %0lX \n",
                    packet, addr, rxMem[addr], txMem[addr]);
            exit(1);
          }
        }

        printf("Disabling Ethernet TX/RX:\n");
        // rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT; // via GPIO
        // rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT; // via GPIO
        printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                         ethCore[CONFIGURATION_RX_REG1]);
        ethCore[CONFIGURATION_TX_REG1] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_DEFAULT;
        ethCore[CONFIGURATION_RX_REG1] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_DEFAULT;
        printf("CONFIGURATION_TX/RX_REG1: %0lX/%0lX \n", ethCore[CONFIGURATION_TX_REG1],
                                                         ethCore[CONFIGURATION_RX_REG1]);
    
        printf("------- DMA 2-boards communication test PASSED -------\n\n");
      }
      break;


      case 'f':
        printf("------- Exiting the app -------\n");
        return(0);

      default:
        printf("Please choose right option\n");
    }
  }
}
