
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
#include "fsl.h" // FSL macros: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2016_4/oslib_rm.pdf#page=16

// using namespace std;

enum TestMode {
  SHORT_LOOPBACK = 0,
  LONG_LOOPBACK  = 1
};

struct UserParam {
  TestMode procMode;
  uint32_t wordsNum;
};

void printParam(UserParam& param) {
    printf("\n\n");
    printf("------ Ethernet Test App ------\n");
    printf("Current Parameter Settings:\n");
    printf("  Mode: %d\n",       param.procMode);
    printf("  Words num: %ld\n", param.wordsNum);
    printf("\n");
}

void help(UserParam& param) {
    printf("Parameters:\n");
    printf("  -h               Show this help\n"    );
    printf("  -mode <uint8_t>  Test mode:\n"        );
    printf("                   0 - SHORT_LOOPBACK\n");
    printf("                   1 - LONG_LOOPBACK\n" );
    printf("  -num <uint32_t>  Words num\n"         );
    printf("\n");
    printParam(param);
    exit(0);
}

int main(int argc, char *argv[])
{
  sleep(1); // in seconds
  printf("\n");

  // -------- Setting user parameters -------------
  UserParam param;
  param.procMode = SHORT_LOOPBACK;
  param.wordsNum = 0x100;

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
    if ( args[i] == "-num" && uint8_t(i+1) < args.size() ) {
        param.wordsNum = atoi(args[++i].c_str());
        continue;
    }
    printf("ERROR: Unknown parameter: %s\n", args[i].c_str());
    help(param);
  }
  if (param.procMode != SHORT_LOOPBACK  &&
      param.procMode != LONG_LOOPBACK) {
      printf("ERROR: invalid test mode: %d", param.procMode);
      exit(1);
  }
  if (param.wordsNum > 0x100) {
      printf("ERROR: words number is too much: %ld", param.wordsNum);
      exit(1);
  }

  printParam(param);

  // AXIS switches control: https://www.xilinx.com/support/documentation/ip_documentation/axis_infrastructure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf#page=27
  uint32_t* txSwitch = reinterpret_cast<uint32_t*>(XPAR_TX_AXIS_SWITCH_BASEADDR);
  uint32_t* rxSwitch = reinterpret_cast<uint32_t*>(XPAR_RX_AXIS_SWITCH_BASEADDR);
  uint8_t const outDirOffs = 0x0040/4;

  //100Gb Ethernet subsystem control: https://www.xilinx.com/support/documentation/ip_documentation/cmac_usplus/v3_1/pg203-cmac-usplus.pdf#page=177
  uint32_t* ethCore = reinterpret_cast<uint32_t*>(XPAR_CMAC_USPLUS_0_BASEADDR);
  uint16_t const GT_RESET_REG = 0x0;
  uint16_t const RESET_REG    = 0x0004/4;

  if (param.procMode == SHORT_LOOPBACK) {

    printf("Resetting Ethernet core:\n");
    printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
    ethCore[GT_RESET_REG] = 0x1;
    ethCore[RESET_REG]    = 0xC00003FF;
    printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);
    sleep(2); // in seconds
    printf("\n");
    printf("GT_RESET_REG: %0lX, RESET_REG: %0lX \n", ethCore[GT_RESET_REG], ethCore[RESET_REG]);

    printf("Setting Short Loopback Mode:\n");
    // printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    // printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);
    txSwitch[outDirOffs+0] = 0;          // Tx: switching     Out0 to In0 (loopback)
    txSwitch[outDirOffs+1] = 0x80000000; // Tx: switching-off Out1
    rxSwitch[outDirOffs]   = 0;          // Rx: switching     Out0 to In0 (loopback)
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);
    printf("Commiting the setting\n");
    txSwitch[0] = 0x2;
    rxSwitch[0] = 0x2;
    printf("TX Control = %0lX, RX Control = %0lX\n", txSwitch[0], rxSwitch[0]);
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);
    sleep(1); // in seconds
    printf("\n");

    uint8_t const LOOPBACK_DEPTH = 52;
    printf("Transmitting data to loopback with depth %d:\n", LOOPBACK_DEPTH);
    uint32_t putData = 0xDEADBEEF;
    uint32_t fslNrdy = 1;
    uint32_t fslErr  = 1;

    for (uint8_t word = 0; word < LOOPBACK_DEPTH;            word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      // channel id goes to macro as literal 
      if (chan==0)  putfslx(putData,  0, FSL_NONBLOCKING);
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
      fsl_isinvalid(fslNrdy);
      fsl_iserror  (fslErr);
      // printf("Writing word %d to FSL%d = %0lX, Full = %0lX, Err = %0lX \n", word, chan, putData, fslNrdy, fslErr);
      if (fslNrdy || fslErr) {
        printf("\nERROR: Failed write of word %d to FSL%d = %0lX, Full = %0lX, Err = %0lX \n", word, chan, putData, fslNrdy, fslErr);
        exit(1);
      }
      putData += chan;
      putData = ~putData;
    }
    printf("\n");
    // here the loopback should be full
    putfslx(putData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    if (!fslNrdy) {
      printf("\nERROR: After filling whole loopback it is still not full\n");
      exit(1);
    }


    printf("Receiving data from loopback with depth %d:\n", LOOPBACK_DEPTH);
    uint32_t getData = 0;
    putData = 0xDEADBEEF;
    fslNrdy = 1;
    fslErr  = 1;

    for (uint8_t word = 0; word < LOOPBACK_DEPTH;            word++)
    for (uint8_t chan = 0; chan < XPAR_MICROBLAZE_FSL_LINKS; chan++) {
      // channel id goes to macro as literal 
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
      fsl_isinvalid(fslNrdy);
      fsl_iserror  (fslErr);
      // printf("Reading word %d from FSL%d = %0lX, Empty = %0lX, Err = %0lX \n", word, chan, getData, fslNrdy, fslErr);
      if (fslNrdy || fslErr || getData!=putData) {
        printf("\nERROR: Failed read of word %d from FSL%d = %0lX (expected %0lX), Empty = %0lX, Err = %0lX \n",
               word, chan, getData, putData, fslNrdy, fslErr);
        exit(1);
      }
      putData += chan;
      putData = ~putData;
    }
    printf("\n");
    // here the loopback should be empty
    getfslx(getData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    if (!fslNrdy) {
      printf("\nERROR: After reading out whole loopback it is still not empty\n");
      exit(1);
    }

    printf("Short Loopback test passed\n");

  }

  return(0) ;
}
