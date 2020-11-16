
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

    uint32_t* txSwitch = reinterpret_cast<uint32_t*>(XPAR_TX_AXIS_SWITCH_XBAR_BASEADDR);
    uint32_t* rxSwitch = reinterpret_cast<uint32_t*>(XPAR_RX_AXIS_SWITCH_XBAR_BASEADDR);
    uint8_t const outDirOffs = 0x0040/4;

    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);

    printf("Setting Loopback Mode\n");
    txSwitch[outDirOffs+0] = 0;          // Tx: directing to  Out0 (loopback)
    txSwitch[outDirOffs+1] = 0x80000000; // Tx: switching-off Out1
    rxSwitch[outDirOffs]   = 0;          // Rx: directing from In0 (loopback)

    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);
    sleep(1); // in seconds
    printf("\n");
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);

    printf("Commiting the setting\n");
    txSwitch[0] = 0x2;
    rxSwitch[0] = 0x2;

    printf("TX Control = %0lX, RX Control = %0lX\n", txSwitch[0], rxSwitch[0]);
    sleep(1); // in seconds
    printf("\n");
    printf("TX Switch: Control = %0lX, Out0 = %0lX, Out1 = %0lX \n", txSwitch[0], txSwitch[outDirOffs], txSwitch[outDirOffs+1]);
    printf("RX Switch: Control = %0lX, Out0 = %0lX \n",              rxSwitch[0], rxSwitch[outDirOffs]);

    return(0) ;
}
