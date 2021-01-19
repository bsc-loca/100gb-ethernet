
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
#include "../../../src/cpp/ethdrv.h"

// using namespace std;

int pingReplyTest(EthSyst&);
int pingReqTest  (EthSyst&);


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


int main(int argc, char *argv[])
{
  EthSyst ethSyst; // Instance of the Ethernet System driver
  // Tx/Rx memories 
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
                           ETH_PACKET_LEN > DMA_AXI_BURST/32 ? DMA_AXI_BURST/16 : ETH_PACKET_LEN,
        ETH_PACKET_DECR = 7*sizeof(uint32_t) // optional length decrement for some packets for test purposes
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
    printf("  Single board self-diag/loopback tests: l\n");
    printf("  Two boards diag communication tests:   c\n");
    printf("  Two boards IP-based tests:             i\n");
    printf("  Finish:                                f\n");
    char choice;
    scanf("%s", &choice);
    printf("You have entered: %c\n\n", choice);


    switch (choice) {
      case 'l': {
        printf("------- Running CPU Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds
        transmitToChan(CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH, true, true);
        receiveFrChan (CPU_PACKET_WORDS, SHORT_LOOPBACK_DEPTH);
        printf("------- CPU Short Loopback test PASSED -------\n\n");

        ethSyst.ethCoreInit(true);

        printf("\n------- Running CPU Near-end Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, true, true);
        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX
    
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        printf("------- CPU Near-end Loopback test PASSED -------\n\n");


        printf("------- Running DMA Tx/Rx memory test -------\n");
        printf("Checking memories with random values from %0X to %0X \n", 0, RAND_MAX);
        // first clearing previously stored values
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = 0;
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;
        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = rand();
        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) {
          uint32_t expectVal = rand(); 
          if (ethSyst.txMem[addr] != expectVal) {
            printf("\nERROR: Incorrect readback of word at addr %0X from Tx Mem: %0lX, expected: %0lX \n", addr, ethSyst.txMem[addr], expectVal);
            exit(1);
          }
        }
        for (size_t addr = 0; addr < rxMemWords; ++addr) {
          uint32_t expectVal = rand(); 
          if (ethSyst.rxMem[addr] != expectVal) {
            printf("\nERROR: Incorrect readback of word at addr %0X from Rx Mem: %0lX, expected: %0lX \n", addr, ethSyst.rxMem[addr], expectVal);
            exit(1);
          }
        }
        printf("------- DMA Tx/Rx memory test PASSED -------\n\n");

        ethSyst.axiDmaInit();

        printf("\n------- Running DMA-CPU Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true);  // Tx switch: DMA->LB, CPU->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: LB->CPU, Eth->DMA
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();

        printf("DMA: Transmitting %d whole packets with length %d bytes to channel with depth %d words\n",
                DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS, CPU_PACKET_LEN, DMA_TX_LOOPBACK_DEPTH);
        // ethSyst.axiDmaPtr->HasSg = true; // checking debug messages work in driver call
        size_t dmaMemPtr = 0;
        for (size_t packet = 0; packet < DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS; packet++) {
		      int status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(ethSyst.axiDmaPtr, XAXIDMA_DMA_TO_DEVICE)) {
            printf("Waiting untill Tx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        receiveFrChan(CPU_PACKET_WORDS, (DMA_TX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_WORDS);
        printf("------- DMA-CPU Short Loopback test PASSED -------\n\n");


        printf("------- Running CPU-DMA Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: CPU->LB, DMA->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, true);  // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        transmitToChan(CPU_PACKET_WORDS, (DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_WORDS, true, CPU_PACKET_WORDS==1);

        printf("DMA: Receiving %d whole packets with length %d bytes from channel with depth %d words \n",
                DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS, CPU_PACKET_LEN, DMA_RX_LOOPBACK_DEPTH);
        // ethSyst.axiDmaPtr->HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS; packet++) {
		      int status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, CPU_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while (XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) {
            printf("Waiting untill Rx transfer %d finishes \n", packet);
            // sleep(1); // in seconds, user wait process
    		  }
          dmaMemPtr += CPU_PACKET_LEN;
        }

        srand(1);
        for (size_t addr = 0; addr < ((DMA_RX_LOOPBACK_DEPTH/CPU_PACKET_WORDS)*CPU_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          uint32_t expectVal = rand(); 
          if (ethSyst.rxMem[addr] != expectVal) {
            printf("\nERROR: Incorrect data recieved by DMA at addr %0X: %0lX, expected: %0lX \n", addr, ethSyst.rxMem[addr], expectVal);
            exit(1);
          }
        }
        printf("------- CPU-DMA Short Loopback test PASSED -------\n\n");


        printf("------- Running DMA Short Loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: DMA->LB, CPU->Eth
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: LB->DMA, Eth->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/DMA_PACKET_LEN, DMA_PACKET_LEN, txrxMemSize);
        // ethSyst.axiDmaPtr->HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/DMA_PACKET_LEN; packet++) {
		      int status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, DMA_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, DMA_PACKET_LEN, XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill last Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaMemPtr += DMA_PACKET_LEN;
    		}

        for (size_t addr = 0; addr < ((txrxMemSize/DMA_PACKET_LEN)*DMA_PACKET_LEN)/sizeof(uint32_t); ++addr) {
          if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
            printf("\nERROR: Incorrect data transferred by DMA at addr %d: %0lX, expected: %0lX \n", addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
            exit(1);
          }
        }
        printf("------- DMA Short Loopback test PASSED -------\n\n");


        printf("------- Running DMA Near-end loopback test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/ETH_MEMPACK_SIZE, ETH_PACKET_LEN, txrxMemSize);
        // ethSyst.axiDmaPtr->HasSg = true; // checking debug messages work in driver call
        dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++) {
		      int status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr,
                                          ETH_PACKET_LEN - (packet%3 ? 0 : ETH_PACKET_DECR), // decreasing length for some packets
                                          XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
    	  	}
          dmaMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++)
        for (size_t word   = 0; word < ETH_MEMPACK_SIZE/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (word < (ETH_PACKET_LEN - (packet%3 ? 0 : ETH_PACKET_DECR))/sizeof(uint32_t)) {
            if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
              printf("\nERROR: Incorrect data transferred by DMA in 32-bit word %d of packet %d at addr %d: %0lX, expected: %0lX \n",
                      word, packet, addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
              exit(1);
            }
          }
          else if (ethSyst.rxMem[addr] != 0) {
              printf("\nERROR: Data in 32-bit word %d of packet %d overwrite stored zero at addr %d: %0lX \n",
                      word, packet, addr, ethSyst.rxMem[addr]);
              exit(1);
          }
        }

        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
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

        ethSyst.ethCoreInit(false);

        printf("------- CPU 2-boards communication test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  true); // Tx switch: CPU->Eth, DMA->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, true); // Rx switch: Eth->CPU, LB->DMA
        sleep(1); // in seconds

        transmitToChan(CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH, false, true);
        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        sleep(1); // in seconds, delay not to use blocking read in receive process
        receiveFrChan (CPU_PACKET_WORDS, TRANSMIT_FIFO_DEPTH);
        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        printf("------- CPU 2-boards communication test PASSED -------\n\n");

        ethSyst.axiDmaInit();

        printf("------- DMA 2-boards communication test -------\n");
        ethSyst.switch_CPU_DMAxEth_LB(true,  false); // Tx switch: DMA->Eth, CPU->LB
        ethSyst.switch_CPU_DMAxEth_LB(false, false); // Rx switch: Eth->DMA, LB->CPU
        sleep(1); // in seconds

        srand(1);
        for (size_t addr = 0; addr < txMemWords; ++addr) ethSyst.txMem[addr] = rand();
        for (size_t addr = 0; addr < rxMemWords; ++addr) ethSyst.rxMem[addr] = 0;

        ethSyst.ethTxRxEnable(); // Enabling Ethernet TX/RX

        printf("DMA: Transferring %d whole packets with length %d bytes between memories with common size %d bytes \n",
                txrxMemSize/ETH_MEMPACK_SIZE, ETH_PACKET_LEN, txrxMemSize);
        // ethSyst.axiDmaPtr->HasSg = true; // checking debug messages work in driver call
        size_t dmaMemPtr = 0;
        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++) {
		      int status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr, ETH_PACKET_LEN, XAXIDMA_DEVICE_TO_DMA);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Rx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
          if (packet == 0) sleep(1); // in seconds, timeout before 1st packet Tx transfer to make sure opposite side also has set Rx transfer
		      status = XAxiDma_SimpleTransfer(ethSyst.axiDmaPtr, (UINTPTR)dmaMemPtr,
                                          ETH_PACKET_LEN - (packet%3 ? 0 : ETH_PACKET_DECR), // decreasing length for some packets
                                          XAXIDMA_DMA_TO_DEVICE);
         	if (XST_SUCCESS != status) {
            printf("\nERROR: XAxiDma Tx transfer %d failed with status %d\n", packet, status);
            exit(1);
	        }
		      while ((XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) ||
			           (XAxiDma_Busy(ethSyst.axiDmaPtr,XAXIDMA_DMA_TO_DEVICE))) {
            // printf("Waiting untill Tx/Rx transfer finishes \n");
            // sleep(1); // in seconds, user wait process
          }
          dmaMemPtr += ETH_MEMPACK_SIZE;
        }

        for (size_t packet = 0; packet < txrxMemSize/ETH_MEMPACK_SIZE; packet++)
        for (size_t word   = 0; word < ETH_MEMPACK_SIZE/sizeof(uint32_t); word++) {
          size_t addr = packet*ETH_MEMPACK_SIZE/sizeof(uint32_t) + word;
          if (word < (ETH_PACKET_LEN - (packet%3 ? 0 : ETH_PACKET_DECR))/sizeof(uint32_t)) {
            if (ethSyst.rxMem[addr] != ethSyst.txMem[addr]) {
              printf("\nERROR: Incorrect data transferred by DMA in 32-bit word %d of packet %d at addr %d: %0lX, expected: %0lX \n",
                      word, packet, addr, ethSyst.rxMem[addr], ethSyst.txMem[addr]);
              exit(1);
            }
          }
          else if (ethSyst.rxMem[addr] != 0) {
              printf("\nERROR: Data in 32-bit word %d of packet %d overwrite stored zero at addr %d: %0lX \n",
                      word, packet, addr, ethSyst.rxMem[addr]);
              exit(1);
          }
        }

        ethSyst.ethTxRxDisable(); //Disabling Ethernet TX/RX
        printf("------- DMA 2-boards communication test PASSED -------\n\n");
      }
      break;


      case 'i': {
        printf("------- Running 2-boards IP-based tests -------\n");
        printf("Please make sure that the same mode is running on the other side and confirm with 'y'...\n");
        char confirm;
        scanf("%s", &confirm);
        printf("%c\n", confirm);
        if (confirm != 'y') break;

        ethSyst.ethSystInit();

        while (true) {
          printf("Please choose particular IP-based test:\n");
          printf("  Ping reply test:   p\n");
          printf("  Ping request test: q\n");
          printf("  Exit to main menu: e\n");
          char choice;
          scanf("%s", &choice);
          printf("You have entered: %c\n\n", choice);

          switch (choice) {
            case 'p': {
              printf("------- Ping Reply test -------\n");
              int status = pingReplyTest(ethSyst);
              if (status != XST_SUCCESS) {
                printf("\nERROR: Ping Reply test failed with status %d\n", status);
                exit(1);
              }
              printf("------- Ping Reply test finished -------\n\n");
            }
            break;

            case 'q': {
              printf("------- Ping Request test -------\n");
            	int status = pingReqTest(ethSyst);
	            if (status != XST_SUCCESS) {
		            printf("\nERROR: Ping Request test failed with status %d\n", status);
                exit(1);
	            }
              printf("------- Ping Request test finished -------\n\n");
            }
            break;

            case 'e':
              printf("------- Exiting to main menu -------\n");
              break;

            default: printf("Please choose right option\n");
          }
          if (choice == 'e') break;
        }

        ethSyst.ethTxRxDisable();
      }
      break;

      case 'f':
        printf("------- Exiting the app -------\n");
        return(0);

      default: printf("Please choose right option\n");
    }
  }
}
