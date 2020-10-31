
#include <stdio.h>
// #include <unistd.h>
// #include <cassert>
//#include <iostream>
// #include <fstream>
// #include <sstream>
// #include <vector>
// #include <thread>
// #include <chrono>
// #include <fcntl.h>
// #include <sys/stat.h>

// #ifdef BAREMETAL
// #include "xil_cache.h"
// #else

// #include <sys/mman.h>

// #ifndef PYNQGCC
// #include "sds_lib.h"
// extern "C" { // addition to "sds_lib.h"
// unsigned long xlnkGetBufPhyAddr(void*);
// void xlnkFlushCache(unsigned int phys_addr, int size);
// void xlnkInvalidateCache(unsigned int phys_addr, int size);
// }
// #endif
// #endif

// #include "hello.h"

// using namespace std;

// enum HelloMode {
//   BRAM_CHECK  = 0,
//   DRAM_CHECK0 = 1,
//   DRAM_CHECK1 = 2,
//   DRAM_CHECK2 = 3,
//   DRAM_CHECK3 = 4
// };

// struct UserParam {
//   bool      fpgaInit;
//   HelloMode procMode;
//   uint32_t  wordsNum;
// };

// void printParam(UserParam& param) {
//     cout << endl<<"Current Parameter Settings:"         << endl
//          << "  FPGA initialization: " << param.fpgaInit << endl
//          << "  Mode: "                << param.procMode << endl
//          << "  Words num: "           << param.wordsNum << endl
//          << endl;
// }

// void help(UserParam& param) {
//     cout << "Parameters:\n"
//          << "  -h               Show this help"    << endl
//          << "  -init <bool>     If '0': Do not re-load FPGA, If '1': FPGA is re-loaded & initialized with ./base.bit firmware" << endl
//          << "  -mode <uint8_t>  Test mode:"        << endl
//          << "                   0    -BRAM_CHECK"  << endl
//          << "                   1,2,3-DRAM_CHECKs" << endl
//          << "  -num <uint32_t>  Words num"         << endl
//          << endl;
//     printParam(param);
//     exit(0);
// }

// void helloHW(uint32_t[], uint32_t[], uint32_t[], uint32_t[], uint32_t[], volatile uint8_t*);


int main(int argc, char *argv[])
{

    // cout << "HELLO world !!!!!" << endl;
    printf("HELLOOOO!!!! \n");


    // -------- Setting user parameters -------------
    // UserParam param;
    // param.fpgaInit = true;
    // param.procMode = DRAM_CHECK0;
    // param.wordsNum = 0x100; //min(BRAM_DATA_SIZE, DRAM_SW_WORDS);

    // vector<string> args;
    // for ( int i = 1; i < argc; ++i ) {
    //   args.push_back(argv[i]);
    // }

    // for ( uint8_t i = 0; i < args.size(); ++i ) {
    //   if ( args[i] == "-h" ) {
    //       help(param);
    //   }
    //   if ( args[i] == "-init" && uint8_t(i+1) < args.size() ) {
    //       param.fpgaInit = atoi(args[++i].c_str());
    //       continue;
    //   }
    //   if ( args[i] == "-mode" && uint8_t(i+1) < args.size() ) {
    //       param.procMode = HelloMode(atoi(args[++i].c_str()));
    //       continue;
    //   }
    //   if ( args[i] == "-num" && uint8_t(i+1) < args.size() ) {
    //       param.wordsNum = atoi(args[++i].c_str());
    //       continue;
    //   }
    //   cout << endl << "ERROR: Unknown parameter: " << args[i] << endl;
    //   help(param);
    // }
    // if (param.procMode != BRAM_CHECK  &&
    //     param.procMode != DRAM_CHECK0 &&
    //     param.procMode != DRAM_CHECK1 &&
    //     param.procMode != DRAM_CHECK2 &&
    //     param.procMode != DRAM_CHECK3) {
    //   cout << "ERROR: invalid test mode: " << param.procMode << endl;
    //   exit(1);
    // }
    // if (param.wordsNum > 0x100) {
    //   cout << "ERROR: words number is too much: " << param.wordsNum << endl;
    //   exit(1);
    // }

    return(0) ;
}
