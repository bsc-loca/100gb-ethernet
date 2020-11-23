
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
#include <unistd.h>
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
#include "../../../src/ethernet_test_cmac_usplus_0_0_axi4_lite_registers.h"
#include "fsl.h" // FSL macros: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2016_4/oslib_rm.pdf#page=16

// using namespace std;

enum TestMode {
  LOOPBACK_MODE = 0
};

struct UserParam {
  TestMode procMode;
  // uint32_t wordsNum;
};

void printParam(UserParam& param) {
    printf("\n\n");
    printf("------ Ethernet Test App ------\n");
    printf("Current Parameter Settings:\n");
    printf("  Mode: %d\n",       param.procMode);
    // printf("  Words num: %ld\n", param.wordsNum);
    printf("\n");
}

void help(UserParam& param) {
    printf("Parameters:\n");
    printf("  -h               Show this help\n"   );
    printf("  -mode <uint8_t>  Test mode:\n"       );
    printf("                   0 - LOOPBACK_MODE\n");
    // printf("  -num <uint32_t>  Words num\n"         );
    printf("\n");
    printParam(param);
    exit(0);
}

void transmitToChan(uint8_t chanDepth) {
    printf("Transmitting data to channel with depth %d:\n", chanDepth);
    uint32_t putData = 0xDEADBEEF;
    uint32_t getData = 0;
    bool fslNrdy = true;
    bool fslErr  = true;

    // initially the channel should be empty
    getfslx(getData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    if (!fslNrdy) {
      printf("\nERROR: Before starting filling the channel it is not empty\n");
      exit(1);
    }
    for (uint8_t word = 0; word < chanDepth;                 word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      // FSL id goes to macro as literal
      if (word%2) { // transmitting TLAST in odd words (FSL 0 only is used to pass this control)
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
      putData += chan;
      putData = ~putData;
    }
    printf("\n");
    // here the channel should be full
    putfslx(putData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    if (!fslNrdy) {
      printf("\nERROR: After filling whole channel it is still not full\n");
      exit(1);
    }
}

void receiveFrChan(uint8_t chanDepth) {
    printf("Receiving data from channel with depth %d:\n", chanDepth);
    uint32_t putData = 0xDEADBEEF;
    uint32_t getData = 0;
    bool fslNrdy = true;
    bool fslErr  = true;

    for (uint8_t word = 0; word < chanDepth     ;            word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      // FSL id goes to macro as literal 
      if (word%2) { // expecting TLAST in odd words (populated to all FSLs)
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
      putData += chan;
      putData = ~putData;
    }
    printf("\n");
    // here the channel should be empty
    getfslx(getData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    if (!fslNrdy) {
      printf("\nERROR: After reading out whole channel it is still not empty\n");
      exit(1);
    }
}

int main(int argc, char *argv[])
{
  sleep(1); // in seconds
  printf("\n");

  // -------- Setting user parameters -------------
  UserParam param;
  param.procMode = LOOPBACK_MODE;
  // param.wordsNum = 0x100;

  std::vector<std::string> args;
  for ( int i = 1; i < argc; ++i ) {
    args.push_back(argv[i]);
  }

  for ( uint8_t i = 0; i < args.size(); ++i ) {
    if ( args[i] == "-h" ) {
        help(param);
    }
    if ( args[i] == "-mode" && uint8_t(i+1) < args.size() ) {
        param.procMode = TestMode(atoi(args[++i].c_str()));
        continue;
    }
    // if ( args[i] == "-num" && uint8_t(i+1) < args.size() ) {
    //     param.wordsNum = atoi(args[++i].c_str());
    //     continue;
    // }
    printf("ERROR: Unknown parameter: %s\n", args[i].c_str());
    help(param);
  }
  if (param.procMode != LOOPBACK_MODE) {
      printf("ERROR: invalid test mode: %d", param.procMode);
      exit(1);
  }
  // if (param.wordsNum > 0x100) {
  //     printf("ERROR: words number is too much: %ld", param.wordsNum);
  //     exit(1);
  // }

  printParam(param);

  // AXIS switches control: https://www.xilinx.com/support/documentation/ip_documentation/axis_infrastructure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf#page=27
  uint32_t* txSwitch = reinterpret_cast<uint32_t*>(XPAR_TX_AXIS_SWITCH_BASEADDR);
  uint32_t* rxSwitch = reinterpret_cast<uint32_t*>(XPAR_RX_AXIS_SWITCH_BASEADDR);
  enum {MI_MUX = 0x0040 / sizeof(uint32_t)};

  //100Gb Ethernet subsystem registers: https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=177
  // uint32_t* ethCore = reinterpret_cast<uint32_t*>(XPAR_CMAC_USPLUS_0_BASEADDR);
  enum {
    GT_RESET_REG          = GT_RESET_REG_OFFSET          / sizeof(uint32_t),
    RESET_REG             = RESET_REG_OFFSET             / sizeof(uint32_t),
    CORE_VERSION_REG      = CORE_VERSION_REG_OFFSET      / sizeof(uint32_t),
    CORE_MODE_REG         = CORE_MODE_REG_OFFSET         / sizeof(uint32_t),
    SWITCH_CORE_MODE_REG  = SWITCH_CORE_MODE_REG_OFFSET  / sizeof(uint32_t),
    CONFIGURATION_TX_REG1 = CONFIGURATION_TX_REG1_OFFSET / sizeof(uint32_t),
    CONFIGURATION_RX_REG1 = CONFIGURATION_RX_REG1_OFFSET / sizeof(uint32_t),
    GT_LOOPBACK_REG       = GT_LOOPBACK_REG_OFFSET       / sizeof(uint32_t)
  };

  // Ethernet core control via GPIO 
  uint32_t* rxtxCtrl = reinterpret_cast<uint32_t*>(XPAR_TX_RX_CTL_STAT_BASEADDR);
  enum {
    TX_CTRL = 0x0000 / sizeof(uint32_t),
    RX_CTRL = 0x0008 / sizeof(uint32_t)
  };
  uint32_t* gtCtrl = reinterpret_cast<uint32_t*>(XPAR_GT_CTL_BASEADDR);

  if (param.procMode == LOOPBACK_MODE) {

    printf("------- Running Short Loopback test -------\n");
    printf("Tx/Rx streams switches state:\n");
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    printf("Setting switches to Short Loopback Mode:\n");
    txSwitch[MI_MUX+0] = 0;          // Tx: switching     Out0(Short loopback) to In0
    txSwitch[MI_MUX+1] = 0x80000000; // Tx: switching-off Out1(Ethernet core)
    rxSwitch[MI_MUX]   = 0;          // Rx: switching     Out0 to In0(Short loopback)
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    printf("Commiting the setting\n");
    txSwitch[0] = 0x2;
    rxSwitch[0] = 0x2;
    printf("TX Control = %0lX, RX Control = %0lX\n", txSwitch[0], rxSwitch[0]);
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    sleep(1); // in seconds
    printf("\n");

    enum {SHORT_LOOPBACK_DEPTH = 100};
    transmitToChan(SHORT_LOOPBACK_DEPTH);
    receiveFrChan (SHORT_LOOPBACK_DEPTH);

    printf("------- Short Loopback test passed -------\n\n");


    printf("------- Running Near-end Loopback test -------\n");
    printf("Tx/Rx streams switches state:\n");
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    printf("Setting switches to Near-End Loopback Mode:\n");
    txSwitch[MI_MUX+0] = 0x80000000; // Tx: switching-off Out0(Short loopback)
    txSwitch[MI_MUX+1] = 0;          // Tx: switching     Out1(Ethernet core) to In0
    rxSwitch[MI_MUX]   = 1;          // Rx: switching     Out0 to In1(Ethernet core)
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    printf("Commiting the setting\n");
    txSwitch[0] = 0x2;
    rxSwitch[0] = 0x2;
    printf("TX Control = %0lX, RX Control = %0lX\n", txSwitch[0], rxSwitch[0]);
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[MI_MUX], txSwitch[MI_MUX+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[MI_MUX]);
    sleep(1); // in seconds
    printf("\n");

    // printf("Resetting Ethernet core:\n");
    // printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
    // ethCore[GT_RESET_REG] = ethCore[GT_RESET_REG] |
    //                         GT_RESET_REG_GT_RESET_ALL_MASK;
    // ethCore[RESET_REG]    = ethCore[RESET_REG] |
    //                         RESET_REG_USR_RX_SERDES_RESET_MASK |
    //                         RESET_REG_USR_RX_RESET_MASK        |
    //                         RESET_REG_USR_TX_RESET_MASK;
    // printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
    // sleep(2); // in seconds
    // printf("\n");
    // printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);

    //100Gb Ethernet subsystem bring-up: https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=204
    // printf("CORE_VERSION_REG:      %0lX \n", ethCore[CORE_VERSION_REG]);
    // printf("CORE_MODE_REG:         %0lX \n", ethCore[CORE_MODE_REG]);
    // printf("SWITCH_CORE_MODE_REG:  %0lX \n", ethCore[SWITCH_CORE_MODE_REG]);
    // printf("CONFIGURATION_TX_REG1: %0lX \n", ethCore[CONFIGURATION_TX_REG1]);
    // printf("CONFIGURATION_RX_REG1: %0lX \n", ethCore[CONFIGURATION_RX_REG1]);

    // printf("GT_LOOPBACK_REG:       %0lX \n", ethCore[GT_LOOPBACK_REG]);
    // ethCore[GT_LOOPBACK_REG] = GT_LOOPBACK_REG_CTL_GT_LOOPBACK_MASK;
    // printf("GT_LOOPBACK_REG:       %0lX \n", ethCore[GT_LOOPBACK_REG]);
    // sleep(1); // in seconds
    // printf("GT_LOOPBACK_REG:       %0lX \n", ethCore[GT_LOOPBACK_REG]);

    printf("GT_STATUS: %0lX \n", gtCtrl[0]);
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);

    printf("Enabling Near-End PMA Loopback, Ethernet core bring-up.\n");
    gtCtrl[0] = 0x2222; // https://www.xilinx.com/support/documentation/user_guides/ug578-ultrascale-gty-transceivers.pdf#page=88
    //100Gb Ethernet subsystem bring-up: https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=204
    rxtxCtrl[RX_CTRL] = CONFIGURATION_RX_REG1_CTL_RX_ENABLE_MASK;
    rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_SEND_RFI_MASK;
    printf("Waiting for Rx is aligned:\n");
    while(!(rxtxCtrl[RX_CTRL] & STAT_RX_STATUS_REG_STAT_RX_ALIGNED_MASK)) {
      printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    }
    printf("Rx is aligned:\n");
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    printf("Disabling TX_SEND_RFI:\n");
    rxtxCtrl[TX_CTRL] = 0;
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);

    enum {TRANSMIT_DEPTH = 38};
    transmitToChan(TRANSMIT_DEPTH);
    printf("Enabling Transmit:\n");
    rxtxCtrl[TX_CTRL] = CONFIGURATION_TX_REG1_CTL_TX_ENABLE_MASK;
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    printf("TX_STATUS: %0lX, RX_STATUS: %0lX \n", rxtxCtrl[TX_CTRL], rxtxCtrl[RX_CTRL]);
    receiveFrChan (TRANSMIT_DEPTH);

    printf("------- Near-end Loopback test passed -------\n\n");

  }

  return(0) ;
}
