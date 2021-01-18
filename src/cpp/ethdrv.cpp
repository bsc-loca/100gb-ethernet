/******************************************************************************
* Copyright (C) 2004 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

/*****************************************************************************/
/**
*
* @file taken from Xilinx xemaclite.c
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

#include <stdio.h>
#include <algorithm>

#include "../../../src/cpp/ethdrv.h"


/*****************************************************************************/
/**
*
* Initialize a specific XEmacLite instance/driver.  The initialization entails:
* - Initialize fields of the XEmacLite instance structure.
*
* The driver defaults to polled mode operation.
*
* @param	InstancePtr is a pointer to the XEmacLite instance.
* @param	EmacLiteConfigPtr points to the XEmacLite device configuration
*		structure.
* @param	EffectiveAddr is the device base address in the virtual memory
*		address space. If the address translation is not used then the
*		physical address is passed.
*		Unexpected errors may occur if the address mapping is changed
*		after this function is invoked.
*
* @return
* 		- XST_SUCCESS if initialization was successful.
*
* @note		The initialization of the PHY device is not done in this
*		function. The user needs to use XEmacLite_PhyRead and
*		XEmacLite_PhyWrite functions to access the PHY device.
*
******************************************************************************/
int EthSyst::cfgInitialize(XAxiDma& axiDma)
{
	txBaseAddress = XPAR_TX_MEM_CPU_S_AXI_BASEADDR;
	rxBaseAddress = XPAR_RX_MEM_CPU_S_AXI_BASEADDR;
	axiDmaPtr = &axiDma;

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
	volatile u32 AlignBuffer;
	volatile u32 *To32Ptr;
	u32 *From32Ptr;
	volatile u16 *To16Ptr;
	u16 *From16Ptr;
	volatile u8 *To8Ptr;
	u8 *From8Ptr;

	To32Ptr = (volatile u32*)txBaseAddress;

	if ((((u32) SrcPtr) & 0x00000003) == 0) {

		/*
		 * Word aligned buffer, no correction needed.
		 */
		From32Ptr = (u32 *) SrcPtr;

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
		To8Ptr = (u8 *) &AlignBuffer;
		From8Ptr = (u8 *) From32Ptr;

	}
	else if ((((u32) SrcPtr) & 0x00000001) != 0) {
		/*
		 * Byte aligned buffer, correct.
		 */
		AlignBuffer = 0;
		To8Ptr = (u8 *) &AlignBuffer;
		From8Ptr = (u8 *) SrcPtr;

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
			To8Ptr = (u8 *) &AlignBuffer;
			Length -= 4;
		}

		/*
		 * Set up to output the remaining data, zero the temp buffer
		 * first.
		 */
		AlignBuffer = 0;
		To8Ptr = (u8 *) &AlignBuffer;

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

		To16Ptr = (u16 *) ((void *) &AlignBuffer);
		From16Ptr = (u16 *) SrcPtr;

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
			To16Ptr = (u16 *) ((void *) &AlignBuffer);
			Length -= 4;
		}

		/*
		 * Set up to output the remaining data, zero the temp buffer
		 * first.
		 */
		AlignBuffer = 0;
		To8Ptr = (u8 *) &AlignBuffer;
		From8Ptr = (u8 *) From16Ptr;
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
int EthSyst::frameSend(u8 *FramePtr, unsigned ByteCount)
{

    // Checking if the engine is doing transfer
    while (!(XAxiDma_ReadReg(axiDmaPtr->TxBdRing.ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) &&
	         XAxiDma_Busy   (axiDmaPtr, XAXIDMA_DMA_TO_DEVICE)) {
      printf("Waiting untill previous Tx transfer finishes \n");
      // sleep(1); // in seconds, user wait process
    }

	alignedWrite(FramePtr, ByteCount);

	/*
	 * The frame is in the buffer, now send it.
	 */
    ByteCount = std::max((unsigned)ETH_MIN_PACK_SIZE, std::min(ByteCount, (unsigned)XEL_MAX_TX_FRAME_SIZE));
    int status = XAxiDma_SimpleTransfer(axiDmaPtr, (UINTPTR)0, ByteCount, XAXIDMA_DMA_TO_DEVICE);
    if (XST_SUCCESS != status) {
       printf("\nERROR: Ethernet XAxiDma Tx transfer from addr %0X with lenth %d failed with status %d\n",
	          0, ByteCount, status);
	}

	return status;
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
u16 EthSyst::getReceiveDataLength(u16 headerOffset) {
	u16 Length;
    uint32_t* addr32 = reinterpret_cast<uint32_t*>(rxBaseAddress);

#ifdef __LITTLE_ENDIAN__
	Length = (addr32[headerOffset / sizeof(uint32_t)] &
			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
	Length = (u16) (((Length & 0xFF00) >> 8) | ((Length & 0x00FF) << 8));
#else
	Length = ((addr32[headerOffset / sizeof(uint32_t)] >> XEL_HEADER_SHIFT) &
			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
#endif
    printf("   Accepting packet at mem addr 0x%X, extracting length/type 0x%X at offset %d \n", rxBaseAddress, Length, headerOffset);

	return Length;
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
	volatile u32 AlignBuffer;
	u32 *To32Ptr;
	volatile u32 *From32Ptr;
	u16 *To16Ptr;
	volatile u16 *From16Ptr;
	u8 *To8Ptr;
	volatile u8 *From8Ptr;

	From32Ptr = (u32 *)rxBaseAddress;

	if ((((u32) DestPtr) & 0x00000003) == 0) {

		/*
		 * Word aligned buffer, no correction needed.
		 */
		To32Ptr = (u32 *) DestPtr;

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
		To8Ptr = (u8 *) To32Ptr;

	}
	else if ((((u32) DestPtr) & 0x00000001) != 0) {
		/*
		 * Byte aligned buffer, correct.
		 */
		To8Ptr = (u8 *) DestPtr;

		while (Length > 3) {
			/*
			 * Copy each word into the temporary buffer.
			 */
			AlignBuffer = *From32Ptr++;
			From8Ptr = (u8 *) &AlignBuffer;

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
		To16Ptr = (u16 *) DestPtr;

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
			From16Ptr = (u16 *) ((void *) &AlignBuffer);

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
		To8Ptr = (u8 *) To16Ptr;
	}

	/*
	 * Read the remaining data.
	 */
	AlignBuffer = *From32Ptr++;
	From8Ptr = (u8 *) &AlignBuffer;

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
*		be stored. The buffer must be at least XEL_MAX_FRAME_SIZE bytes.
*		For optimal performance, a 32-bit aligned buffer should be used
*		but it is not required, the function will align the data if
*		necessary.
*
* @return
*
* The type/length field of the frame received.  When the type/length field
* contains the type, XEL_MAX_FRAME_SIZE bytes will be copied out of the
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
u16 EthSyst::frameRecv(u8 *FramePtr)
{
	u16 LengthType;
	u16 Length;

	if (XAxiDma_Busy(axiDmaPtr, XAXIDMA_DEVICE_TO_DMA)) {
	  return 0;
    }
    // printf("Some Rx frame is received \n");

	/*
	 * Get the length of the frame that arrived.
	 */
	LengthType = getReceiveDataLength(XEL_HEADER_OFFSET);

	/*
	 * Check if length is valid.
	 */
	if (LengthType > XEL_MAX_FRAME_SIZE) {


		if (LengthType == XEL_ETHER_PROTO_TYPE_IP) {

	        Length = getReceiveDataLength(XEL_HEADER_IP_LENGTH_OFFSET);
			Length += XEL_HEADER_SIZE + XEL_FCS_SIZE;

		} else if (LengthType == XEL_ETHER_PROTO_TYPE_ARP) {

			/*
			 * The packet is an ARP Packet.
			 */
			Length = XEL_ARP_PACKET_SIZE + XEL_HEADER_SIZE +
					XEL_FCS_SIZE;

		} else {
			/*
			 * Field contains type other than IP or ARP, use max
			 * frame size and let user parse it.
			 */
			Length = XEL_MAX_FRAME_SIZE;

		}
	} else {

		/*
		 * Use the length in the frame, plus the header and trailer.
		 */
		Length = LengthType + XEL_HEADER_SIZE + XEL_FCS_SIZE;
	}

	alignedRead(FramePtr, Length);

	/*
	 * Acknowledge the frame.
	 */
	int status = XAxiDma_SimpleTransfer(axiDmaPtr, (UINTPTR)0, XEL_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
    if (XST_SUCCESS != status) {
      printf("\nERROR: Ethernet XAxiDma Rx transfer to addr %0X with max lenth %d failed with status %d\n",
		      0, XEL_MAX_FRAME_SIZE, status);
	}

	return Length;
}


/****************************************************************************/
/**
*
* Flush the Receive buffers. All data will be lost.
*
* @param	InstancePtr is the pointer to the instance of the driver to
*		be worked on.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
int EthSyst::flushReceive() {
  // Checking if the engine is already in accept process
  while ((XAxiDma_ReadReg(axiDmaPtr->RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) ||
	     !XAxiDma_Busy   (axiDmaPtr, XAXIDMA_DEVICE_TO_DMA)) {
    int status = XAxiDma_SimpleTransfer(axiDmaPtr, (UINTPTR)0, XEL_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
    if (XST_SUCCESS != status) {
      printf("\nERROR: Initial Ethernet XAxiDma Rx transfer to addr %0X with max lenth %d failed with status %d\n",
             0, XEL_MAX_FRAME_SIZE, status);
      return status;
    }
	printf("Flushing Rx data... \n");
  }

  return XST_SUCCESS;
}
