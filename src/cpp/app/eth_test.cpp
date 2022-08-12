
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

#include "fsl.h" // FSL macros: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2016_4/oslib_rm.pdf#page=16
#include "EthSyst.h"
#include "ping_test.h"

// using namespace std;

int udp_perf_client();
int udp_perf_server();
int tcp_perf_client();
int tcp_perf_server();


void transmitToChan(uint8_t packetWords, uint8_t chanDepth, bool rxCheck, bool txCheck) {
    xil_printf("CPU: Transmitting %d whole packets with length %d words (+%d words) to channel with depth %d words \n",
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
        xil_printf("\nERROR: Before starting filling Tx channel Rx channel is not empty: FSL0 = %0lX, Empty = %d, Err = %d \n",
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
      // xil_printf("Writing word %d to FSL%d = %0lX, Full = %d, Err = %d \n", word, chan, putData, fslNrdy, fslErr);
      if (fslNrdy || fslErr) {
        xil_printf("\nERROR: Failed write of word %d to FSL%d = %0lX, Full = %d, Err = %d \n", word, chan, putData, fslNrdy, fslErr);
        exit(1);
      }
    }
    if (txCheck) {
      // if full depth of Tx channel is used, here it should be full
      putfslx(putData, 0, FSL_NONBLOCKING);
      fsl_isinvalid(fslNrdy);
      if (!fslNrdy) {
        xil_printf("\nERROR: After filling Tx channel it is still not full\n");
        exit(1);
      }
    }
}

void receiveFrChan(uint8_t packetWords, uint8_t chanDepth) {
    xil_printf("CPU: Receiving %d whole packets with length %d words (+%d words) from channel with depth %d words \n",
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
      // xil_printf("Reading word %d from FSL%d = %0lX, Empty = %d, Err = %d \n", word, chan, getData, fslNrdy, fslErr);
      if (fslNrdy || fslErr || getData!=putData) {
        xil_printf("\nERROR: Failed read of word %d from FSL%d = %0lX (expected %0lX), Empty = %d, Err = %d \n",
                    word, chan, getData, putData, fslNrdy, fslErr);
        exit(1);
      }
    }
    // here Rx channel should be empty
    getfslx(getData, 0, FSL_NONBLOCKING);
    fsl_isinvalid(fslNrdy);
    fsl_iserror  (fslErr);
    if (!fslNrdy) {
      xil_printf("\nERROR: After reading out Rx channel it is still not empty: FSL0 = %0lX, Empty = %d, Err = %d \n",
                  getData, fslNrdy, fslErr);
      exit(1);
    }
}

// Test interrupt handlers
void dmaTxTestFastHandler(void) __attribute__ ((fast_interrupt));
void dmaRxTestFastHandler(void) __attribute__ ((fast_interrupt));

bool txIntrProcessed;
void dmaTxTestHandler() {
  xil_printf("Tx Handler has started: %d\n", txIntrProcessed);
  // Indicate the interrupt has been processed using a shared variable.
	txIntrProcessed = true;
}
void dmaTxTestFastHandler() {
  xil_printf("Fast ");
  dmaTxTestHandler();
}

bool rxIntrProcessed;
void dmaRxTestHandler()
{
  xil_printf("Rx Handler has started: %d\n", rxIntrProcessed);
  // Indicate the interrupt has been processed using a shared variable.
	rxIntrProcessed = true;
}
void dmaRxTestFastHandler() {
  xil_printf("Fast ");
  dmaRxTestHandler();
}

int main(int argc, char *argv[])
{
  EthSyst ethSyst; // Instance of the Ethernet System driver
  // Tx/Rx memories 
  size_t const txMemSize  = (TX_MEM_HIGHADDR+1 -
                             TX_MEM_BASEADDR);
  size_t const rxMemSize  = (RX_MEM_HIGHADDR+1 -
                             RX_MEM_BASEADDR);
  size_t const sgMemSize  = (SG_MEM_HIGHADDR+1 -
                             SG_MEM_BASEADDR);
  size_t const extMemSize = sgMemSize/8; // small size just for testing
  size_t const txrxMemSize = std::min(txMemSize, rxMemSize);
  size_t const txMemWords  = txMemSize  / sizeof(uint32_t);
  size_t const rxMemWords  = rxMemSize  / sizeof(uint32_t);
  size_t const sgMemWords  = sgMemSize  / sizeof(uint32_t);
  size_t const extMemWords = extMemSize / sizeof(uint32_t);

  enum {ETH_WORD_SIZE = sizeof(uint32_t) * XPAR_MICROBLAZE_FSL_LINKS,
        DMA_AXI_BURST = ETH_WORD_SIZE * std::max(XPAR_ETH_DMA_MM2S_BURST_SIZE, // the parameter set in Vivado AXI_DMA IP
                                                 XPAR_ETH_DMA_S2MM_BURST_SIZE),
        CPU_PACKET_LEN   = ETH_WORD_SIZE * 8, // the parameter to play with
        CPU_PACKET_WORDS = (CPU_PACKET_LEN + ETH_WORD_SIZE - 1) / ETH_WORD_SIZE,
        DMA_PACKET_LEN   = txrxMemSize/3     - sizeof(uint32_t), // the parameter to play with (no issies met for any values and granularities)
        ETH_PACKET_LEN   = ETH_WORD_SIZE*150 - sizeof(uint32_t), // the parameter to play with (no issues met for granularity=sizeof(uint32_t) and range=[(1...~150)*ETH_WORD_SIZE]
                                                                 // (defaults in Eth100Gb IP as min/max packet length=64...9600(but only upto 9596 works)))
      #ifdef DMA_MEM_HBM
        ETH_MEMPACK_SIZE = ETH_PACKET_LEN
      #else
        ETH_MEMPACK_SIZE = ETH_PACKET_LEN > DMA_AXI_BURST/2  ? ((ETH_PACKET_LEN + DMA_AXI_BURST-1) / DMA_AXI_BURST) * DMA_AXI_BURST :
                           ETH_PACKET_LEN > DMA_AXI_BURST/4  ? DMA_AXI_BURST/2  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/8  ? DMA_AXI_BURST/4  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/16 ? DMA_AXI_BURST/8  :
                           ETH_PACKET_LEN > DMA_AXI_BURST/32 ? DMA_AXI_BURST/16 : ETH_PACKET_LEN
      #endif
        // ETH_PACKET_DECR = 7*sizeof(uint32_t) // optional length decrement for some packets for test purposes
  };
  enum { // hardware defined depths of channels
        SHORT_LOOPBACK_DEPTH  = 104,
        TRANSMIT_FIFO_DEPTH   = 40,
        DMA_TX_LOOPBACK_DEPTH = CPU_PACKET_WORDS==1 ? 95 : 96,
        DMA_RX_LOOPBACK_DEPTH = CPU_PACKET_WORDS==1 ? 43 : 40
  };


  while (true) {

    xil_printf("\n");
    xil_printf("------ Ethernet Test App ------\n");
    xil_printf("Please enter test mode:\n");
    xil_printf("  Single board self-diag/loopback tests: l\n");
    xil_printf("  Two boards diag communication tests:   c\n");
    xil_printf("  Two boards IP-based tests:             i\n");
    xil_printf("  Finish:                                f\n");
    char choice;
    scanf("%s", &choice);
    xil_printf("You have entered: %c\n\n", choice);


    switch (choice) {
      case 'l': {
        xil_printf("------- Running CPU Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds
        transmitToChan(CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH, true, true);
        receiveFrChan (CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH);
        xil_printf("------- CPU Short Loopback test PASSED -------\n\n");

        ethSyst.ethCoreInit(true);

        xil_printf("\n------- Running CPU Near-end Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, true, true);
        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX
    
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        xil_printf("------- CPU Near-end Loopback test PASSED -------\n\n");


        xil_printf("------- Running SDRAM test -------\n");
        xil_printf("Checking memory with random values from %0X to %0X \n", 0, RAND_MAX);

        uint8_t  volatile* extMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.extMem);
        uint16_t volatile* extMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.extMem);
        uint32_t volatile* extMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.extMem);
        uint64_t volatile* extMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.extMem);
        uint8_t  volatile* sysMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.sysMem);
        uint16_t volatile* sysMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.sysMem);
        uint32_t volatile* sysMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.sysMem);
        uint64_t volatile* sysMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.sysMem);
        size_t axiWidth = 256 / 8;

        xil_printf("Write to direct HBM at addr 0x%X, Read from cached HBM at addr 0x%X with %d bytes\n",
                   size_t(ethSyst.extMem), size_t(ethSyst.sysMem), extMemSize);
        // first clearing previously stored values in both views of same segment
        for (size_t addr = 0; addr < extMemWords; ++addr) ethSyst.extMem[addr] = 0;
        for (size_t addr = 0; addr < extMemWords; ++addr) ethSyst.sysMem[addr] = 0;
        // filling the memory with random values
        srand(1);
        uint64_t val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) extMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) extMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) extMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) extMem64[addr/8] = val;
        }

        // checking written values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 sysMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from cached HBM: %x, expected: %lx \n", addr, sysMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && sysMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from cached HBM: %x, expected: %lx \n", addr, sysMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && sysMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from cached HBM: %x, expected: %lx \n", addr, sysMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && sysMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from cached HBM: %lx, expected: %lx \n", addr, sysMem64[addr/8], val);
            exit(1);
          }
        }

        xil_printf("Write to cached HBM at addr 0x%X, Read from direct HBM at addr 0x%X with %d bytes\n",
                   size_t(ethSyst.sysMem), size_t(ethSyst.extMem), extMemSize);
        // first clearing previously stored values in both views of same segment
        for (size_t addr = 0; addr < extMemWords; ++addr) ethSyst.extMem[addr] = 0;
        for (size_t addr = 0; addr < extMemWords; ++addr) ethSyst.sysMem[addr] = 0;
        // filling the memory with random values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) sysMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) sysMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) sysMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) sysMem64[addr/8] = val;
        }

        // checking written values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 extMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from direct HBM: %x, expected: %lx \n", addr, extMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && extMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from direct HBM: %x, expected: %lx \n", addr, extMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && extMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from direct HBM: %x, expected: %lx \n", addr, extMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && extMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from direct HBM: %lx, expected: %lx \n", addr, extMem64[addr/8], val);
            exit(1);
          }
        }

        uint8_t  volatile* ddrMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.ddrMem);
        uint16_t volatile* ddrMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.ddrMem);
        uint32_t volatile* ddrMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.ddrMem);
        uint64_t volatile* ddrMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.ddrMem);
        axiWidth = 512 / 8;

        xil_printf("Checking cached DDR memory at addr 0x%X by size %d \n", size_t(ethSyst.ddrMem), extMemSize);
        // first clearing previously stored values in both views of same segment
        for (size_t addr = 0; addr < extMemWords; ++addr) ethSyst.ddrMem[addr] = 0;
        // filling the memory with random values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) ddrMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) ddrMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) ddrMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) ddrMem64[addr/8] = val;
        }

        // checking written values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < extMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 ddrMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from cached DDR: %x, expected: %lx \n", addr, ddrMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && ddrMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from cached DDR: %x, expected: %lx \n", addr, ddrMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && ddrMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from cached DDR: %x, expected: %lx \n", addr, ddrMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && ddrMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from cached DDR: %lx, expected: %lx \n", addr, ddrMem64[addr/8], val);
            exit(1);
          }
        }
        xil_printf("------- SDRAM test PASSED -------\n\n");


        #ifdef DMA_MEM_HBM
        xil_printf("------- Running DMA Tx/Rx/SG memory test (HBM-based) -------\n");
        #else
        xil_printf("------- Running DMA Tx/Rx/SG memory test (SRAM-based) -------\n");
        #endif
        xil_printf("Checking memories with random values from %0X to %0X \n", 0, RAND_MAX);
        // first clearing previously stored values
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = 0;
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;
        for (size_t addr = 0; addr < sgMemWords; ++addr) ethSyst.sgMem[addr] = 0;

        uint8_t  volatile* txMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.txMem);
        uint16_t volatile* txMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.txMem);
        uint32_t volatile* txMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.txMem);
        uint64_t volatile* txMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.txMem);
        uint8_t  volatile* rxMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.rxMem);
        uint16_t volatile* rxMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.rxMem);
        uint32_t volatile* rxMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.rxMem);
        uint64_t volatile* rxMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.rxMem);
        uint8_t  volatile* sgMem8  = reinterpret_cast<uint8_t  volatile*>(ethSyst.sgMem);
        uint16_t volatile* sgMem16 = reinterpret_cast<uint16_t volatile*>(ethSyst.sgMem);
        uint32_t volatile* sgMem32 = reinterpret_cast<uint32_t volatile*>(ethSyst.sgMem);
        uint64_t volatile* sgMem64 = reinterpret_cast<uint64_t volatile*>(ethSyst.sgMem);
        axiWidth = 512 / 8;

        // filling the memories with random values
        srand(1);
        val = 0;
        for (size_t addr = 0; addr < txMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) txMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) txMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) txMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) txMem64[addr/8] = val;
        }
        for (size_t addr = 0; addr < rxMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) rxMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) rxMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) rxMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) rxMem64[addr/8] = val;
        }
        for (size_t addr = 0; addr < sgMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          size_t axiWordIdx = addr/axiWidth;
          // changing written data type every wide AXI word
          if (axiWordIdx%4 == 0) sgMem8 [addr  ] = val >> 56;
          if (axiWordIdx%4 == 1) sgMem16[addr/2] = val >> 48;
          if (axiWordIdx%4 == 2) sgMem32[addr/4] = val >> 32;
          if (axiWordIdx%4 == 3) sgMem64[addr/8] = val;
        }

        // checking written values
        srand(1);
        val = 0;
        xil_printf("Checking TX memory at addr 0x%X with size %d \n", size_t(ethSyst.txMem), txMemSize);
        for (size_t addr = 0; addr < txMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 txMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from Tx Mem: %x, expected: %lx \n", addr, txMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && txMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from Tx Mem: %x, expected: %lx \n", addr, txMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && txMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from Tx Mem: %x, expected: %lx \n", addr, txMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && txMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from Tx Mem: %lx, expected: %lx \n", addr, txMem64[addr/8], val);
            exit(1);
          }
        }
        xil_printf("Checking RX memory at addr 0x%X with size %d \n", size_t(ethSyst.rxMem), rxMemSize);
        for (size_t addr = 0; addr < rxMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 rxMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from Rx Mem: %x, expected: %lx \n", addr, rxMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && rxMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from Rx Mem: %x, expected: %lx \n", addr, rxMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && rxMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from Rx Mem: %x, expected: %lx \n", addr, rxMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && rxMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from Rx Mem: %lx, expected: %lx \n", addr, rxMem64[addr/8], val);
            exit(1);
          }
        }
        xil_printf("Checking BD memory at addr 0x%X with size %d \n", size_t(ethSyst.sgMem), sgMemSize);
        for (size_t addr = 0; addr < sgMemSize; ++addr) {
          uint64_t rand64 = rand();
          val = (val >> 8) | (rand64 << 56);
          // checking readback using different data types
          if (                 sgMem8 [addr  ] != (val >> 56)) {
            xil_printf("\nERROR: Incorrect readback of Byte at addr %lx from BD Mem: %x, expected: %lx \n", addr, sgMem8[addr], val >> 56);
            exit(1);
          }
          if ((addr%2) == 1 && sgMem16[addr/2] != (val >> 48)) {
            xil_printf("\nERROR: Incorrect readback of Word-16 at addr %lx from BD Mem: %x, expected: %lx \n", addr, sgMem16[addr/2], val >> 48);
            exit(1);
          }
          if ((addr%4) == 3 && sgMem32[addr/4] != (val >> 32)) {
            xil_printf("\nERROR: Incorrect readback of Word-32 at addr %lx from BD Mem: %x, expected: %lx \n", addr, sgMem32[addr/4], val >> 32);
            exit(1);
          }
          if ((addr%8) == 7 && sgMem64[addr/8] !=  val)        {
            xil_printf("\nERROR: Incorrect readback of Word-64 at addr %lx from BD Mem: %lx, expected: %lx \n", addr, sgMem64[addr/8], val);
            exit(1);
          }
        }
        xil_printf("------- DMA Tx/Rx/SG memory test PASSED -------\n\n");

        ethSyst.axiDmaInit();

        xil_printf("\n------- Running DMA-CPU Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true);  // Tx switch: DMA->LB, CPU->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();

        size_t packets = DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS;
        xil_printf("DMA: Transmitting %d whole packets with length %d bytes to channel with depth %d words\n",
                    packets, CPU_PACKET_LEN, DMA_TX_LOOPBACK_DEPTH);
        size_t dmaMemPtr = size_t(ethSyst.txMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* BdPtr = ethSyst.dmaBDAlloc(false, packets, CPU_PACKET_LEN, CPU_PACKET_LEN, dmaMemPtr);
          ethSyst.dmaBDTransfer                 (false, packets, packets,        BdPtr);
          BdPtr             = ethSyst.dmaBDPoll (false, packets);
          ethSyst.dmaBDFree                     (false, packets, CPU_PACKET_LEN, BdPtr);
          uint32_t transDat = packets * CPU_PACKET_LEN;
          float txTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 0) * ethSyst.TIMER_TICK;
          float speed = (transDat * 8) / txTime;
          printf("Transfer: %ld Bytes, Tx time: %f ns, Speed: %f Gb/s \n", transDat, txTime, speed);
        }
        else for (size_t packet = 0; packet < packets; packet++) {
		      int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(&(ethSyst.axiDma), XAXIDMA_DMA_TO_DEVICE)) {
            xil_printf("Waiting untill Tx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        receiveFrChan(CPU_PACKET_WORDS, packets * CPU_PACKET_WORDS);
        xil_printf("------- DMA-CPU Short Loopback test PASSED -------\n\n");


        xil_printf("------- Running CPU-DMA Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, true);  // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        packets = DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS;
        transmitToChan(CPU_PACKET_WORDS, packets * CPU_PACKET_WORDS, true, CPU_PACKET_WORDS==1);

        xil_printf("DMA: Receiving %d whole packets with length %d bytes from channel with depth %d words \n",
                packets, CPU_PACKET_LEN, DMA_RX_LOOPBACK_DEPTH);
        dmaMemPtr = size_t(ethSyst.rxMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* BdPtr = ethSyst.dmaBDAlloc(true, packets, CPU_PACKET_LEN, CPU_PACKET_LEN, dmaMemPtr);
          ethSyst.dmaBDTransfer                 (true, packets, packets,        BdPtr);
          BdPtr             = ethSyst.dmaBDPoll (true, packets);
          ethSyst.dmaBDFree                     (true, packets, CPU_PACKET_LEN, BdPtr);
          uint32_t transDat = packets * CPU_PACKET_LEN;
          float rxTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 1) * ethSyst.TIMER_TICK;
          float speed = (transDat * 8) / rxTime;
          printf("Transfer: %ld Bytes, Rx time: %f ns, Speed: %f Gb/s \n", transDat, rxTime, speed);
        }
        else for (size_t packet = 0; packet < packets; packet++) {
		      int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DEVICE_TO_DMA)) {
            xil_printf("Waiting untill Rx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        srand(1);
        for (size_t addr = 0; addr < (packets * CPU_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          uint32_t expectVal = rand(); 
          if (ethSyst.rxMem[addr] != expectVal) {
            xil_printf("\nERROR: Incorrect data recieved by DMA at addr %0X: %0lX, expected: %0lX \n", addr, ethSyst.rxMem[addr], expectVal);
            exit(1);
          }
        }
        xil_printf("------- CPU-DMA Short Loopback test PASSED -------\n\n");


        xil_printf("------- Running DMA Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: DMA->LB, CPU->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        packets = txrxMemSize/DMA_PACKET_LEN;
        if (XAxiDma_HasSg(&ethSyst.axiDma))
          packets = std::min(packets,
                    std::min(ethSyst.txBdCount,
                             ethSyst.rxBdCount));
        xil_printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                    packets, DMA_PACKET_LEN, txrxMemSize);
        size_t dmaTxMemPtr = size_t(ethSyst.txMem);
        size_t dmaRxMemPtr = size_t(ethSyst.rxMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* rxBdPtr = ethSyst.dmaBDAlloc(true,  packets, DMA_PACKET_LEN, DMA_PACKET_LEN, dmaRxMemPtr); // Rx
          XAxiDma_Bd* txBdPtr = ethSyst.dmaBDAlloc(false, packets, DMA_PACKET_LEN, DMA_PACKET_LEN, dmaTxMemPtr); // Tx
          ethSyst.dmaBDTransfer                   (true,  packets, packets,        rxBdPtr); // Rx
          ethSyst.dmaBDTransfer                   (false, packets, packets,        txBdPtr); // Tx
          txBdPtr             = ethSyst.dmaBDPoll (false, packets); // Tx
          rxBdPtr             = ethSyst.dmaBDPoll (true,  packets); // Rx
          ethSyst.dmaBDFree                       (false, packets, DMA_PACKET_LEN, txBdPtr); // Tx
          ethSyst.dmaBDFree                       (true,  packets, DMA_PACKET_LEN, rxBdPtr); // Rx

          uint32_t transDat = packets * DMA_PACKET_LEN;
          float txTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 0) * ethSyst.TIMER_TICK;
          float rxTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 1) * ethSyst.TIMER_TICK;
          float txSpeed = (transDat * 8) / txTime;
          float rxSpeed = (transDat * 8) / rxTime;
          xil_printf("Transfer: %ld Bytes \n", transDat);
          printf("Tx time: %f ns, Speed: %f Gb/s \n", txTime, txSpeed);
          printf("Rx time: %f ns, Speed: %f Gb/s \n", rxTime, rxSpeed);

        }
        else for (size_t packet = 0; packet < packets; packet++) {
		      int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaRxMemPtr, DMA_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaTxMemPtr, DMA_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DMA_TO_DEVICE))) {
            // xil_printf("Waiting untill last Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaTxMemPtr += DMA_PACKET_LEN;
          dmaRxMemPtr += DMA_PACKET_LEN;
    		}

        for (size_t addr = 0; addr < (packets * DMA_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
            xil_printf("\nERROR: Incorrect data transferred by DMA at addr %d: %0lX, expected: %0lX \n", addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
            exit(1);
          }
        }
        xil_printf("------- DMA Short Loopback test PASSED -------\n\n");


        xil_printf("------- Running DMA Near-end loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        packets = txrxMemSize/ETH_MEMPACK_SIZE;
        if (XAxiDma_HasSg(&ethSyst.axiDma))
          packets = std::min(packets,
                    std::min(ethSyst.txBdCount,
                             ethSyst.rxBdCount));
        size_t txBunch = ETH_PACKET_LEN > ETH_WORD_SIZE*4 ? 1 : packets; // whole bunch Tx kick-off for small packets
        xil_printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes (packet mem alignment: %d bytes) \n",
                    packets, ETH_PACKET_LEN, txrxMemSize, ETH_MEMPACK_SIZE);
        dmaTxMemPtr = size_t(ethSyst.txMem);
        dmaRxMemPtr = size_t(ethSyst.rxMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* rxBdPtr = ethSyst.dmaBDAlloc(true,  packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaRxMemPtr); // Rx
          XAxiDma_Bd* txBdPtr = ethSyst.dmaBDAlloc(false, packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaTxMemPtr); // Tx
          ethSyst.dmaBDTransfer                   (true,  packets, packets,        rxBdPtr); // Rx
          ethSyst.dmaBDTransfer                   (false, packets, txBunch,        txBdPtr); // Tx, each packet kick-off for big packets
          txBdPtr             = ethSyst.dmaBDPoll (false, packets); // Tx
          rxBdPtr             = ethSyst.dmaBDPoll (true,  packets); // Rx
          ethSyst.dmaBDFree                       (false, packets, ETH_PACKET_LEN, txBdPtr); // Tx
          ethSyst.dmaBDFree                       (true,  packets, ETH_PACKET_LEN, rxBdPtr); // Rx

          uint32_t transDat = packets * ETH_PACKET_LEN;
          float txTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 0) * ethSyst.TIMER_TICK;
          float rxTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 1) * ethSyst.TIMER_TICK;
          float txSpeed = (transDat * 8) / txTime;
          float rxSpeed = (transDat * 8) / rxTime;
          xil_printf("Transfer: %ld Bytes \n", transDat);
          printf("Tx time: %f ns, Speed: %f Gb/s \n", txTime, txSpeed);
          printf("Rx time: %f ns, Speed: %f Gb/s \n", rxTime, rxSpeed);
        }
        else for (size_t packet = 0; packet < packets; packet++) {
          int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaRxMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaTxMemPtr, ETH_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          while ((XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DEVICE_TO_DMA)) ||
                 (XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DMA_TO_DEVICE))) {
            // xil_printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaTxMemPtr += ETH_MEMPACK_SIZE;
          dmaRxMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < packets; packet++)
        for (size_t word   = 0; word < ETH_MEMPACK_SIZE/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (word < ETH_PACKET_LEN/sizeof(uint32_t)) {
            if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
              xil_printf("\nERROR: Incorrect data transferred by DMA in 32-bit word %d of packet %d at addr %d: %0lX, expected: %0lX \n",
                          word, packet, addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
              exit(1);
            }
          }
          else if (ethSyst.rxMem[addr] != 0) {
              xil_printf("\nERROR: Data in 32-bit word %d of packet %d overwrite stored zero at addr %d: %0lX \n",
                         word, packet, addr, ethSyst.rxMem[addr]);
              exit(1);
          }
        }

        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        xil_printf("------- DMA Near-end loopback test PASSED -------\n\n");


        xil_printf("------- Running Interrupt Controller test -------\n");
        ethSyst.intrCtrlInit();

        // Further testing is based on interrupt simulation and is possible in case hardware interrupts have not once been enabled,
        // if not, this is a write once bit such that simulation can't be done further because the ISR register is no longer writable
        uint32_t merReg = XIntc_In32(XPAR_INTC_0_BASEADDR + XIN_MER_OFFSET);
        if (XIN_INT_HARDWARE_ENABLE_MASK & merReg)
          xil_printf("Skipping interrupt simulation test as hw interrupts have been once enabled: 0X%lX \n", merReg);
        else {

          //--- low-level access case ---
          ethSyst.intrCtrlConnect_l(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, dmaTxTestHandler, false);
          ethSyst.intrCtrlConnect_l(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, dmaRxTestHandler, false);
          ethSyst.intrCtrlStart_l(false); // start Interrupt Controller in simulation mode
          // Simulate the Interrupts.
          txIntrProcessed = false;
          rxIntrProcessed = false;
          // Simulation is done by writing a 1 to the interrupt status bit for the device interrupt.
          XIntc_Out32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET, XPAR_ETH_DMA_MM2S_INTROUT_MASK);
          XIntc_Out32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET, XPAR_ETH_DMA_S2MM_INTROUT_MASK);
          // Wait for the interrupts to be processed, if the interrupt does not occur this loop will wait forever.
          do {
           // If the interrupt occurred which is indicated by the global variable which is set in the device driver handler, stop waiting.
           xil_printf("Waiting for Tx/Rx DMA handlers are executed: %d/%d \n", txIntrProcessed, rxIntrProcessed);
           // sleep(1); // in seconds
          } while (!txIntrProcessed || !rxIntrProcessed);
          ethSyst.intrCtrlStop_l();
          ethSyst.intrCtrlDisconnect_l(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
          ethSyst.intrCtrlDisconnect_l(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);

          //--- high-level access case ---
          xil_printf("\n");
          ethSyst.intrCtrlConnect(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, dmaTxTestHandler, false);
          ethSyst.intrCtrlConnect(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, dmaRxTestHandler, false);
          ethSyst.intrCtrlStart(false); // start Interrupt Controller in simulation mode
          // Simulate the Interrupts.
          txIntrProcessed = false;
          rxIntrProcessed = false;
          int status = XIntc_SimulateIntr(&(ethSyst.intrCtrl), XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: Simulation of DMA TX Interrupt %d failed with status %d\n", XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, status);
            exit(1);
          }
          status = XIntc_SimulateIntr(&(ethSyst.intrCtrl), XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: Simulation of DMA RX Interrupt %d failed with status %d\n", XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, status);
            exit(1);
          }
          // Wait for the interrupts to be processed, if the interrupt does not occur this loop will wait forever.
          do {
           // If the interrupt occurred which is indicated by the global variable which is set in the device driver handler, stop waiting.
           xil_printf("Waiting for Tx/Rx DMA handlers are executed: %d/%d \n", txIntrProcessed, rxIntrProcessed);
           // sleep(1); // in seconds
          } while (!txIntrProcessed || !rxIntrProcessed);
          ethSyst.intrCtrlStop();
          ethSyst.intrCtrlDisconnect(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
          ethSyst.intrCtrlDisconnect(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);

          if (XPAR_INTC_0_HAS_FAST) {
            xil_printf("\nChecking fast interrupt mode... \n");
            //--- low-level access case ---
            ethSyst.intrCtrlConnect_l(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, dmaTxTestFastHandler, true);
            ethSyst.intrCtrlConnect_l(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, dmaRxTestFastHandler, true);
            ethSyst.intrCtrlStart_l(false); // start Interrupt Controller in simulation mode
            // Simulate the Interrupts.
            txIntrProcessed = false;
            rxIntrProcessed = false;
            // Simulation is done by writing a 1 to the interrupt status bit for the device interrupt.
            XIntc_Out32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET, XPAR_ETH_DMA_MM2S_INTROUT_MASK);
            XIntc_Out32(XPAR_INTC_0_BASEADDR + XIN_ISR_OFFSET, XPAR_ETH_DMA_S2MM_INTROUT_MASK);
            // Wait for the interrupts to be processed, if the interrupt does not occur this loop will wait forever.
            do {
             // If the interrupt occurred which is indicated by the global variable which is set in the device driver handler, stop waiting.
             xil_printf("Waiting for Tx/Rx DMA fast handlers are executed: %d/%d \n", txIntrProcessed, rxIntrProcessed);
             // sleep(1); // in seconds
            } while (!txIntrProcessed || !rxIntrProcessed);
            ethSyst.intrCtrlStop_l();
            ethSyst.intrCtrlDisconnect_l(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
            ethSyst.intrCtrlDisconnect_l(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);

            //--- high-level access case ---
            xil_printf("\n");
            ethSyst.intrCtrlConnect(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, dmaTxTestFastHandler, true);
            ethSyst.intrCtrlConnect(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, dmaRxTestFastHandler, true);
            ethSyst.intrCtrlStart(false); // start Interrupt Controller in simulation mode
            // Simulate the Interrupts.
            txIntrProcessed = false;
            rxIntrProcessed = false;
            status = XIntc_SimulateIntr(&(ethSyst.intrCtrl), XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
            if (XST_SUCCESS != status) {
              xil_printf("\nERROR: Simulation of DMA TX fast Interrupt %d failed with status %d\n", XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID, status);
              exit(1);
            }
            status = XIntc_SimulateIntr(&(ethSyst.intrCtrl), XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);
            if (XST_SUCCESS != status) {
              xil_printf("\nERROR: Simulation of DMA RX fast Interrupt %d failed with status %d\n", XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID, status);
              exit(1);
            }
            // Wait for the interrupts to be processed, if the interrupt does not occur this loop will wait forever.
            do {
             // If the interrupt occurred which is indicated by the global variable which is set in the device driver handler, stop waiting.
             xil_printf("Waiting for Tx/Rx DMA fast handlers are executed: %d/%d \n", txIntrProcessed, rxIntrProcessed);
             // sleep(1); // in seconds
            } while (!txIntrProcessed || !rxIntrProcessed);
            ethSyst.intrCtrlStop();
            ethSyst.intrCtrlDisconnect(XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID);
            ethSyst.intrCtrlDisconnect(XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID);
          }
        }
        xil_printf("------- Interrupt Controller test PASSED -------\n\n");
      }
      break;


      case 'c': {
        xil_printf("------- Running 2-boards communication test -------\n");
        xil_printf("Please make sure that the same mode is running on the other side and confirm with 'y'...\n");
        char confirm;
        scanf("%s", &confirm);
        xil_printf("%c\n", confirm);
        if (confirm != 'y') break;

        ethSyst.ethCoreInit(false);

        xil_printf("------- CPU 2-boards communication test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, false, true);
        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        sleep(1); // in seconds, delay not to use blocking read in receive process
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        xil_printf("------- CPU 2-boards communication test PASSED -------\n\n");

        ethSyst.axiDmaInit();

        xil_printf("------- Async DMA 2-boards communication test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        size_t packets = txrxMemSize/ETH_MEMPACK_SIZE;
        if (XAxiDma_HasSg(&ethSyst.axiDma))
          packets = std::min(packets,
                    std::min(ethSyst.txBdCount,
                             ethSyst.rxBdCount));
        size_t txBunch = ETH_PACKET_LEN > ETH_WORD_SIZE*4 ? 1 : packets; // whole bunch Tx kick-off for small packets
        xil_printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes (packet mem alignment: %d bytes) \n",
                    packets, ETH_PACKET_LEN, txrxMemSize, ETH_MEMPACK_SIZE);
        size_t dmaTxMemPtr = size_t(ethSyst.txMem);
        size_t dmaRxMemPtr = size_t(ethSyst.rxMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* rxBdPtr = ethSyst.dmaBDAlloc(true,  packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaRxMemPtr); // Rx
          XAxiDma_Bd* txBdPtr = ethSyst.dmaBDAlloc(false, packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaTxMemPtr); // Tx
          ethSyst.dmaBDTransfer                   (true,  packets, packets,        rxBdPtr); // Rx
          sleep(1); // in seconds, timeout before Tx transfer to make sure opposite side also has set Rx transfer
          ethSyst.dmaBDTransfer                   (false, packets, txBunch,        txBdPtr); // Tx, each packet kick-off for big packets
          txBdPtr             = ethSyst.dmaBDPoll (false, packets); // Tx
          rxBdPtr             = ethSyst.dmaBDPoll (true,  packets); // Rx
          ethSyst.dmaBDFree                       (false, packets, ETH_PACKET_LEN, txBdPtr); // Tx
          ethSyst.dmaBDFree                       (true,  packets, ETH_PACKET_LEN, rxBdPtr); // Rx

          uint32_t transDat = packets * ETH_PACKET_LEN;
          float txTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 0) * ethSyst.TIMER_TICK;
          float rxTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 1) * ethSyst.TIMER_TICK;
          float txSpeed = (transDat * 8) / txTime;
          float rxSpeed = (transDat * 8) / rxTime;
          xil_printf("Transfer: %ld Bytes \n", transDat);
          printf("Tx time: %f ns, Speed: %f Gb/s \n", txTime, txSpeed);
          if (0) printf("Rx time: %f ns, Speed: %f Gb/s \n", rxTime, rxSpeed); // meaningless here
        }
        else for (size_t packet = 0; packet < packets; packet++) {
          int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaRxMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          if (packet == 0) sleep(1); // in seconds, timeout before 1st packet Tx transfer to make sure opposite side also has set Rx transfer
          status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaTxMemPtr, ETH_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          while ((XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DEVICE_TO_DMA)) ||
                 (XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DMA_TO_DEVICE))) {
            // xil_printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaTxMemPtr += ETH_MEMPACK_SIZE;
          dmaRxMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < packets; packet++)
        for (size_t word   = 0; word < ETH_MEMPACK_SIZE/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (word < ETH_PACKET_LEN/sizeof(uint32_t)) {
            if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
              xil_printf("\nERROR: Incorrect data transferred by DMA in 32-bit word %d of packet %d at addr %d: %0lX, expected: %0lX \n",
                          word, packet, addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
              exit(1);
            }
          }
          else if (ethSyst.rxMem[addr] != 0) {
              xil_printf("\nERROR: Data in 32-bit word %d of packet %d overwrite stored zero at addr %d: %0lX \n",
                          word, packet, addr, ethSyst.rxMem[addr]);
              exit(1);
          }
        }

        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        xil_printf("------- Async DMA 2-boards communication test PASSED -------\n\n");


        xil_printf("------- Round-trip DMA 2-boards communication test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        packets = txrxMemSize/ETH_MEMPACK_SIZE;
        if (XAxiDma_HasSg(&ethSyst.axiDma))
          packets = std::min(packets,
                    std::min(ethSyst.txBdCount,
                             ethSyst.rxBdCount));
        txBunch = ETH_PACKET_LEN > ETH_WORD_SIZE*4 ? 1 : packets; // whole bunch Tx kick-off for small packets
        xil_printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes (packet mem alignment: %d bytes) \n",
                    packets, ETH_PACKET_LEN, txrxMemSize, ETH_MEMPACK_SIZE);
        dmaTxMemPtr = size_t(ethSyst.txMem);
        dmaRxMemPtr = size_t(ethSyst.rxMem);
        if (XAxiDma_HasSg(&ethSyst.axiDma)) {
          XAxiDma_Bd* rxBdPtr = ethSyst.dmaBDAlloc(true,  packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaRxMemPtr); // Rx
          XAxiDma_Bd* txBdPtr = ethSyst.dmaBDAlloc(false, packets, ETH_PACKET_LEN, ETH_MEMPACK_SIZE, dmaTxMemPtr); // Tx
          ethSyst.dmaBDTransfer                   (true,  packets, packets,        rxBdPtr); // Rx
          if (ethSyst.physConnOrder) { // depending on board instance play "initiator" role
            xil_printf("Initiator side: starting the transfer and receiving it back \n");
            sleep(1); // in seconds, timeout before Tx transfer to make sure opposite side also has set Rx transfer
            ethSyst.dmaBDTransfer                 (false, packets, txBunch,        txBdPtr); // Tx, each packet kick-off for big packets
            txBdPtr           = ethSyst.dmaBDPoll (false, packets); // Tx
            rxBdPtr           = ethSyst.dmaBDPoll (true,  packets); // Rx
          } else { // depending on board instance play "responder" role
            xil_printf("Responder side: accepting the transfer and sending it back \n");
            rxBdPtr           = ethSyst.dmaBDPoll (true,  packets); // Rx
            ethSyst.dmaBDTransfer                 (false, packets, txBunch,        txBdPtr); // Tx, each packet kick-off for big packets
            txBdPtr           = ethSyst.dmaBDPoll (false, packets); // Tx
          }
          ethSyst.dmaBDFree                       (false, packets, ETH_PACKET_LEN, txBdPtr); // Tx
          ethSyst.dmaBDFree                       (true,  packets, ETH_PACKET_LEN, rxBdPtr); // Rx
          uint32_t transDat = packets * ETH_PACKET_LEN;
          float txTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 0) * ethSyst.TIMER_TICK;
          float rxTime = XTmrCtr_GetValue(&ethSyst.timerCnt, 1) * ethSyst.TIMER_TICK;
          float txSpeed = (    transDat * 8) / txTime;
          float rxSpeed = (2 * transDat * 8) / rxTime; //transfer is doubled due to round-trip
          xil_printf("Transfer: %ld Bytes \n", transDat);
          printf("Tx time: %f ns, Speed: %f Gb/s \n", txTime, txSpeed);
          if (ethSyst.physConnOrder) printf("Rx time: %f ns, Speed: %f Gb/s \n", rxTime, rxSpeed);
        }
        else {
          xil_printf("For Simple DMA mode no Round-trip exchange is done, Asynch exchange is executed instead \n");
          for (size_t packet = 0; packet < packets; packet++) {
          int status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaRxMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          if (packet == 0) sleep(1); // in seconds, timeout before 1st packet Tx transfer to make sure opposite side also has set Rx transfer
          status = XAxiDma_SimpleTransfer(&(ethSyst.axiDma), dmaTxMemPtr, ETH_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
          if (XST_SUCCESS != status) {
            xil_printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
          }
          while ((XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DEVICE_TO_DMA)) ||
                 (XAxiDma_Busy(&(ethSyst.axiDma),XAXIDMA_DMA_TO_DEVICE))) {
            // xil_printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaTxMemPtr += ETH_MEMPACK_SIZE;
          dmaRxMemPtr += ETH_MEMPACK_SIZE;
          }
        }

        for (size_t packet = 0; packet < packets; packet++)
        for (size_t word   = 0; word < ETH_MEMPACK_SIZE/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (word < ETH_PACKET_LEN/sizeof(uint32_t)) {
            if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
              xil_printf("\nERROR: Incorrect data transferred by DMA in 32-bit word %d of packet %d at addr %d: %0lX, expected: %0lX \n",
                          word, packet, addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
              exit(1);
            }
          }
          else if (ethSyst.rxMem[addr] != 0) {
              xil_printf("\nERROR: Data in 32-bit word %d of packet %d overwrite stored zero at addr %d: %0lX \n",
                          word, packet, addr, ethSyst.rxMem[addr]);
              exit(1);
          }
        }

        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        xil_printf("------- Round-trip DMA 2-boards communication test PASSED -------\n\n");
      }
      break;


      case 'i': {
        xil_printf("------- Running 2-boards IP-based tests -------\n");
        xil_printf("Please make sure that the same mode is running on the other side and confirm with 'y'...\n");
        char confirm;
        scanf("%s", &confirm);
        xil_printf("%c\n", confirm);
        if (confirm != 'y') break;

        ethSyst.ethCoreInit(false); // non-loopback mode
        xil_printf("\n------- Physical connection is established -------\n");

        while (true) {
          ethSyst.ethSystInit(); // resetting hardware before any test
          xil_printf("\n------- Please choose particular IP-based test:\n");
          xil_printf("  Ping reply test:      p\n");
          xil_printf("  Ping request test:    q\n");
          xil_printf("  LwIP UDP Perf Server: u\n");
          xil_printf("  LwIP UDP Perf Client: d\n");
          xil_printf("  LwIP TCP Perf Server: t\n");
          xil_printf("  LwIP TCP Perf Client: c\n");
          xil_printf("  Exit to main menu:    e\n");
          char choice;
          scanf("%s", &choice);
          xil_printf("You have entered: %c\n\n", choice);

          switch (choice) {
            case 'p': {
              xil_printf("------- Ping Reply test -------\n");
              PingReplyTest pingReplyTest(&ethSyst);
              int status = pingReplyTest.pingReply();
              if (status != XST_SUCCESS) {
                xil_printf("\nERROR: Ping Reply test failed with status %d\n", status);
                exit(1);
              }
              xil_printf("------- Ping Reply test finished -------\n\n");
            }
            break;

            case 'q': {
              xil_printf("------- Ping Request test -------\n");
              PingReqstTest pingReqstTest(&ethSyst);
            	int status = pingReqstTest.pingReqst();
	            if (status != XST_SUCCESS) {
		            xil_printf("\nERROR: Ping Request test failed with status %d\n", status);
                exit(1);
	            }
              xil_printf("------- Ping Request test finished -------\n\n");
            }
            break;

            case 'u': {
              xil_printf("------- LwIP UDP Perf Server -------\n");
            	int status = udp_perf_server();
	            if (status != XST_SUCCESS) {
		            xil_printf("\nERROR: LwIP UDP Perf Server failed with status %d\n", status);
                exit(1);
	            }
              xil_printf("------- LwIP UDP Perf Server finished -------\n\n");
            }
            break;

            case 'd': {
              xil_printf("------- LwIP UDP Perf Client -------\n");
            	int status = udp_perf_client();
	            if (status != XST_SUCCESS) {
		            xil_printf("\nERROR: LwIP UDP Perf Client failed with status %d\n", status);
                exit(1);
	            }
              xil_printf("------- LwIP UDP Perf Client finished -------\n\n");
            }
            break;

            case 't': {
              xil_printf("------- LwIP TCP Perf Server -------\n");
            	int status = tcp_perf_server();
	            if (status != XST_SUCCESS) {
		            xil_printf("\nERROR: LwIP TCP Perf Server failed with status %d\n", status);
                exit(1);
	            }
              xil_printf("------- LwIP TCP Perf Server finished -------\n\n");
            }
            break;

            case 'c': {
              xil_printf("------- LwIP TCP Perf Client -------\n");
            	int status = tcp_perf_client();
	            if (status != XST_SUCCESS) {
		            xil_printf("\nERROR: LwIP TCP Perf Client failed with status %d\n", status);
                exit(1);
	            }
              xil_printf("------- LwIP TCP Perf Client finished -------\n\n");
            }
            break;

            case 'e':
              xil_printf("------- Exiting to main menu -------\n");
              break;

            default: xil_printf("Please choose right option\n");
          }
          if (choice == 'e') break;
        }

        ethSyst.ethTxRxDisable();
      }
      break;

      case 'f':
        xil_printf("------- Exiting the app -------\n");
        return(0);

      default: xil_printf("Please choose right option\n");
    }
  }
}
