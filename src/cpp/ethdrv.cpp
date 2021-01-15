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

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

// static u16 XEmacLite_GetReceiveDataLength(UINTPTR BaseAddress);
u16 ethDrv_GetReceiveDataLength(UINTPTR BaseAddress, u16 headerOffset) {
	u16 Length;
    uint32_t* addr32 = reinterpret_cast<uint32_t*>(BaseAddress);

// #ifdef __LITTLE_ENDIAN__
// 	Length = (XEmacLite_ReadReg((BaseAddress),
// 			headerOffset + XEL_RXBUFF_OFFSET) &
// 			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
// 	Length = (u16) (((Length & 0xFF00) >> 8) | ((Length & 0x00FF) << 8));
// #else
// 	Length = ((XEmacLite_ReadReg((BaseAddress),
// 			headerOffset + XEL_RXBUFF_OFFSET) >>
// 			XEL_HEADER_SHIFT) &
// 			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
// #endif

#ifdef __LITTLE_ENDIAN__
	Length = (addr32[headerOffset / sizeof(uint32_t)] &
			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
	Length = (u16) (((Length & 0xFF00) >> 8) | ((Length & 0x00FF) << 8));
#else
	Length = ((addr32[headerOffset / sizeof(uint32_t)] >> XEL_HEADER_SHIFT) &
			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
#endif
    // printf("Extracting Data length %d from address %X, offset %d \n", Length, BaseAddress, headerOffset);

	return Length;
}

// u32 ethDrv_GetTxStatus(UINTPTR BaseAddress) {
// 	printf("Getting Tx status (readiness) at address %d \n", BaseAddress);
//     sleep(1); // in seconds
// 	return ~(XEL_TSR_PROG_MAC_ADDR); // returning just readiness only for MAC address setup
// }

// void ethDrv_SetTxStatus(UINTPTR BaseAddress, u32 Data) {
// 	printf("Updating Tx status at address %d with value %0lX \n", BaseAddress, Data);
// }

// u32 ethDrv_GetRxStatus(UINTPTR BaseAddress) {
// 	printf("Getting Rx status (readiness) at address %d \n", BaseAddress);
//     sleep(1); // in seconds
// 	return ~(XEL_RSR_RECV_DONE_MASK); // No data available
// }

// void ethDrv_SetRxStatus(UINTPTR BaseAddress, u32 Data) {
// 	printf("Updating Rx status at address %d with value %0lX \n", BaseAddress, Data);
// }

/************************** Variable Definitions *****************************/

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
// int XEmacLite_CfgInitialize(XEmacLite *InstancePtr,
// 				XEmacLite_Config *EmacLiteConfigPtr,
// 				UINTPTR EffectiveAddr)
int ethDrv_CfgInitialize(EthDrv *InstancePtr, XAxiDma& axiDma)
{

	/*
	 * Verify that each of the inputs are valid.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	// Xil_AssertNonvoid(EmacLiteConfigPtr != NULL);

	/*
	 * Zero the provided instance memory.
	 */
	memset(InstancePtr, 0, sizeof(EthDrv));

	/*
	 * Set some default values for instance data, don't indicate the device
	 * is ready to use until everything has been initialized successfully.
	 */
	// InstancePtr->EmacLiteConfig.BaseAddress = EffectiveAddr;
	// InstancePtr->EmacLiteConfig.DeviceId = EmacLiteConfigPtr->DeviceId;
	// InstancePtr->EmacLiteConfig.TxPingPong = EmacLiteConfigPtr->TxPingPong;
	// InstancePtr->EmacLiteConfig.RxPingPong = EmacLiteConfigPtr->RxPingPong;
	// InstancePtr->EmacLiteConfig.MdioInclude = EmacLiteConfigPtr->MdioInclude;
	// InstancePtr->EmacLiteConfig.Loopback = EmacLiteConfigPtr->Loopback;
	InstancePtr->EmacLiteConfig.txBaseAddress = XPAR_TX_MEM_CPU_S_AXI_BASEADDR;
	InstancePtr->EmacLiteConfig.rxBaseAddress = XPAR_RX_MEM_CPU_S_AXI_BASEADDR;
	// InstancePtr->EmacLiteConfig.TxPingPong = 1;
	// InstancePtr->EmacLiteConfig.RxPingPong = 1;

	InstancePtr->NextTxBufferToUse = 0x0;
	InstancePtr->NextRxBufferToUse = 0x0;
	// InstancePtr->RecvHandler = (XEmacLite_Handler) StubHandler;
	// InstancePtr->SendHandler = (XEmacLite_Handler) StubHandler;

	/*
	 * Clear the TX CSR's in case this is a restart.
	 */
	// XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
	// 			XEL_TSR_OFFSET, 0);
	// XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
	// 			XEL_BUFFER_OFFSET + XEL_TSR_OFFSET, 0);

	/*
	 * Since there were no failures, indicate the device is ready to use.
	 */
	// InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

	InstancePtr->axiDmaPtr = &axiDma;

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
// void XEmacLite_AlignedWrite(void *SrcPtr, UINTPTR *DestPtr, unsigned ByteCount)
void ethDrv_AlignedWrite(void *SrcPtr, UINTPTR *DestPtr, unsigned ByteCount)
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

	To32Ptr = (volatile u32*)DestPtr;

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
// void XEmacLite_AlignedRead(UINTPTR *SrcPtr, void *DestPtr, unsigned ByteCount)
void ethDrv_AlignedRead(UINTPTR *SrcPtr, void *DestPtr, unsigned ByteCount)
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

	From32Ptr = (u32 *) SrcPtr;

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
// int XEmacLite_Send(XEmacLite *InstancePtr, u8 *FramePtr, unsigned ByteCount)
int ethDrv_Send(EthDrv *InstancePtr, u8 *FramePtr, unsigned ByteCount)
{
	// u32 Register;
	UINTPTR BaseAddress;
	// UINTPTR EmacBaseAddress;
	// u32 IntrEnableStatus;

	/*
	 * Verify that each of the inputs are valid.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	/*
	 * Determine the expected TX buffer address.
	 */
	// BaseAddress = XEmacLite_NextTransmitAddr(InstancePtr);
	BaseAddress = ethDrv_NextTransmitAddr(InstancePtr);
	// EmacBaseAddress = InstancePtr->EmacLiteConfig.BaseAddress;

	/*
	 * Check the Length if it is too large, truncate it.
	 * The maximum Tx packet size is
	 * Ethernet header (14 Bytes) + Maximum MTU (1500 bytes).
	 */
	// if (ByteCount > XEL_MAX_TX_FRAME_SIZE) {

	// 	ByteCount = XEL_MAX_TX_FRAME_SIZE;
	// }

    // Checking if the engine is doing transfer
    while (!(XAxiDma_ReadReg(InstancePtr->axiDmaPtr->TxBdRing.ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) &&
	         XAxiDma_Busy   (InstancePtr->axiDmaPtr, XAXIDMA_DMA_TO_DEVICE)) {
      printf("Waiting untill previous Tx transfer finishes \n");
      // sleep(1); // in seconds, user wait process
    }

	/*
	 * Determine if the expected buffer address is empty.
	 */
	// Register = XEmacLite_GetTxStatus(BaseAddress);
	// Register = ethDrv_GetTxStatus(BaseAddress);

	/*
	 * If the expected buffer is available, fill it with the provided data
	 * Align if necessary.
	 */
	// if ((Register & (XEL_TSR_XMIT_BUSY_MASK |
	// 		XEL_TSR_XMIT_ACTIVE_MASK)) == 0) {

		/*
		 * Switch to next buffer if configured.
		 */
		// if (InstancePtr->EmacLiteConfig.TxPingPong != 0) {
		// 	InstancePtr->NextTxBufferToUse ^= XEL_BUFFER_OFFSET;
		// }

		/*
		 * Write the frame to the buffer.
		 */
		// XEmacLite_AlignedWrite(FramePtr, (UINTPTR *) BaseAddress,
		// 		       ByteCount);
		ethDrv_AlignedWrite(FramePtr, (UINTPTR *) BaseAddress, ByteCount);


		/*
		 * The frame is in the buffer, now send it.
		 */
		// XEmacLite_WriteReg(BaseAddress, XEL_TPLR_OFFSET,
		// 			(ByteCount & (XEL_TPLR_LENGTH_MASK_HI |
		// 			XEL_TPLR_LENGTH_MASK_LO)));

		/*
		 * Update the Tx Status Register to indicate that there is a
		 * frame to send.
		 * If the interrupt enable bit of Ping buffer(since this
		 * controls both the buffers) is enabled then set the
		 * XEL_TSR_XMIT_ACTIVE_MASK flag which is used by the interrupt
		 * handler to call the callback function provided by the user
		 * to indicate that the frame has been transmitted.
		 */
		// Register = XEmacLite_GetTxStatus(BaseAddress);
		// Register = ethDrv_GetTxStatus(BaseAddress);
		// Register |= XEL_TSR_XMIT_BUSY_MASK;
		// IntrEnableStatus = XEmacLite_GetTxStatus(EmacBaseAddress);
		// if ((IntrEnableStatus & XEL_TSR_XMIT_IE_MASK) != 0) {
		// 	Register |= XEL_TSR_XMIT_ACTIVE_MASK;
		// }
		// XEmacLite_SetTxStatus(BaseAddress, Register);
		// ethDrv_SetTxStatus(BaseAddress, Register);

        ByteCount = std::max((unsigned)ETH_MIN_PACK_SIZE, std::min(ByteCount, (unsigned)XEL_MAX_TX_FRAME_SIZE));
        int status = XAxiDma_SimpleTransfer(InstancePtr->axiDmaPtr, (UINTPTR)0, ByteCount, XAXIDMA_DMA_TO_DEVICE);
        if (XST_SUCCESS != status) {
          printf("\nERROR: Ethernet XAxiDma Tx transfer from addr %0X with lenth %d failed with status %d\n",
		          0, ByteCount, status);
	    }

		return status;
	// }

	/*
	 * If the expected buffer was full, try the other buffer if configured.
	 */
	// if (InstancePtr->EmacLiteConfig.TxPingPong != 0) {

	// 	BaseAddress ^= XEL_BUFFER_OFFSET;

	// 	/*
	// 	 * Determine if the expected buffer address is empty.
	// 	 */
	// 	// Register = XEmacLite_GetTxStatus(BaseAddress);
	// 	Register = ethDrv_GetTxStatus(BaseAddress);

	// 	/*
	// 	 * If the next buffer is available, fill it with the provided
	// 	 * data.
	// 	 */
	// 	if ((Register & (XEL_TSR_XMIT_BUSY_MASK |
	// 			XEL_TSR_XMIT_ACTIVE_MASK)) == 0) {

	// 		/*
	// 		 * Write the frame to the buffer.
	// 		 */
	// 		// XEmacLite_AlignedWrite(FramePtr, (UINTPTR *) BaseAddress,
	// 		// 		       ByteCount);
	// 		ethDrv_AlignedWrite(FramePtr, (UINTPTR *) BaseAddress, ByteCount);

	// 		/*
	// 		 * The frame is in the buffer, now send it.
	// 		 */
	// 		// XEmacLite_WriteReg(BaseAddress, XEL_TPLR_OFFSET,
	// 		// 		(ByteCount & (XEL_TPLR_LENGTH_MASK_HI |
	// 		// 		   XEL_TPLR_LENGTH_MASK_LO)));

	// 		/*
	// 		 * Update the Tx Status Register to indicate that there
	// 		 * is a frame to send.
	// 		 * If the interrupt enable bit of Ping buffer(since this
	// 		 * controls both the buffers) is enabled then set the
	// 		 * XEL_TSR_XMIT_ACTIVE_MASK flag which is used by the
	// 		 * interrupt handler to call the callback function
	// 		 * provided by the user to indicate that the frame has
	// 		 * been transmitted.
	// 		 */
	// 		// Register = XEmacLite_GetTxStatus(BaseAddress);
	// 		Register = ethDrv_GetTxStatus(BaseAddress);
	// 		Register |= XEL_TSR_XMIT_BUSY_MASK;
	// 		// IntrEnableStatus =
	// 		// 		XEmacLite_GetTxStatus(EmacBaseAddress);
	// 		// if ((IntrEnableStatus & XEL_TSR_XMIT_IE_MASK) != 0) {
	// 		// 	Register |= XEL_TSR_XMIT_ACTIVE_MASK;
	// 		// }
	// 		// XEmacLite_SetTxStatus(BaseAddress, Register);
	// 		ethDrv_SetTxStatus(BaseAddress, Register);

	// 		/*
	// 		 * Do not switch to next buffer, there is a sync problem
	// 		 * and the expected buffer should not change.
	// 		 */
	// 		return XST_SUCCESS;
	// 	}
	// }


	/*
	 * Buffer(s) was(were) full, return failure to allow for polling usage.
	 */
	// return XST_FAILURE;
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
// u16 XEmacLite_Recv(XEmacLite *InstancePtr, u8 *FramePtr)
u16 ethDrv_Recv(EthDrv *InstancePtr, u8 *FramePtr)
{
	u16 LengthType;
	u16 Length;
	// u32 Register;
	UINTPTR BaseAddress;

	/*
	 * Verify that each of the inputs are valid.
	 */

	Xil_AssertNonvoid(InstancePtr != NULL);

	/*
	 * Determine the expected buffer address.
	 */
	// BaseAddress = XEmacLite_NextReceiveAddr(InstancePtr);
	BaseAddress = ethDrv_NextReceiveAddr(InstancePtr);

	if (XAxiDma_Busy(InstancePtr->axiDmaPtr, XAXIDMA_DEVICE_TO_DMA)) {
	  return 0;
    }
    // printf("Some Rx frame is received \n");

	/*
	 * Verify which buffer has valid data.
	 */
	// Register = XEmacLite_GetRxStatus(BaseAddress);
	// Register = ethDrv_GetRxStatus(BaseAddress);

	// if ((Register & XEL_RSR_RECV_DONE_MASK) == XEL_RSR_RECV_DONE_MASK) {

	// 	/*
	// 	 * The driver is in sync, update the next expected buffer if
	// 	 * configured.
	// 	 */

	// 	if (InstancePtr->EmacLiteConfig.RxPingPong != 0) {
	// 		InstancePtr->NextRxBufferToUse ^= XEL_BUFFER_OFFSET;
	// 	}
	// }
	// else {
	// 	/*
	// 	 * The instance is out of sync, try other buffer if other
	// 	 * buffer is configured, return 0 otherwise. If the instance is
	// 	 * out of sync, do not update the 'NextRxBufferToUse' since it
	// 	 * will correct on subsequent calls.
	// 	 */
	// 	if (InstancePtr->EmacLiteConfig.RxPingPong != 0) {
	// 		BaseAddress ^= XEL_BUFFER_OFFSET;
	// 	}
	// 	else {
	// 		return 0;	/* No data was available */
	// 	}

	// 	/*
	// 	 * Verify that buffer has valid data.
	// 	 */
	// 	// Register = XEmacLite_GetRxStatus(BaseAddress);
	// 	Register = ethDrv_GetRxStatus(BaseAddress);
	// 	if ((Register & XEL_RSR_RECV_DONE_MASK) !=
	// 			XEL_RSR_RECV_DONE_MASK) {
	// 		return 0;	/* No data was available */
	// 	}
	// }

	/*
	 * Get the length of the frame that arrived.
	 */
	// LengthType = XEmacLite_GetReceiveDataLength(BaseAddress);
	LengthType = ethDrv_GetReceiveDataLength(BaseAddress, XEL_HEADER_OFFSET);

	/*
	 * Check if length is valid.
	 */
	if (LengthType > XEL_MAX_FRAME_SIZE) {


		if (LengthType == XEL_ETHER_PROTO_TYPE_IP) {

			/*
			 * The packet is a an IP Packet.
			 */
// #ifdef __LITTLE_ENDIAN__
// 			Length = (XEmacLite_ReadReg((BaseAddress),
// 					XEL_HEADER_IP_LENGTH_OFFSET +
// 					XEL_RXBUFF_OFFSET) &
// 					(XEL_RPLR_LENGTH_MASK_HI |
// 					XEL_RPLR_LENGTH_MASK_LO));
// 			Length = (u16) (((Length & 0xFF00) >> 8) | ((Length & 0x00FF) << 8));
// #else
// 			Length = ((XEmacLite_ReadReg((BaseAddress),
// 					XEL_HEADER_IP_LENGTH_OFFSET +
// 					XEL_RXBUFF_OFFSET) >>
// 					XEL_HEADER_SHIFT) &
// 					(XEL_RPLR_LENGTH_MASK_HI |
// 					XEL_RPLR_LENGTH_MASK_LO));
// #endif
	        Length = ethDrv_GetReceiveDataLength(BaseAddress, XEL_HEADER_IP_LENGTH_OFFSET);
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

	/*
	 * Read from the EmacLite.
	 */
	// XEmacLite_AlignedRead(((UINTPTR *) (BaseAddress + XEL_RXBUFF_OFFSET)),
	// 		      FramePtr, Length);
	ethDrv_AlignedRead(((UINTPTR *) BaseAddress), FramePtr, Length);

	/*
	 * Acknowledge the frame.
	 */
	// Register = XEmacLite_GetRxStatus(BaseAddress);
	// Register = ethDrv_GetRxStatus(BaseAddress);
	// Register &= ~XEL_RSR_RECV_DONE_MASK;
	// XEmacLite_SetRxStatus(BaseAddress, Register);
	// ethDrv_SetRxStatus(BaseAddress, Register);

	int status = XAxiDma_SimpleTransfer(InstancePtr->axiDmaPtr, (UINTPTR)0, XEL_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
    if (XST_SUCCESS != status) {
      printf("\nERROR: Ethernet XAxiDma Rx accept to addr %0X with max lenth %d failed with status %d\n",
		      0, XEL_MAX_FRAME_SIZE, status);
	}

	return Length;
}

/*****************************************************************************/
/**
*
* Set the MAC address for this device.  The address is a 48-bit value.
*
* @param	InstancePtr is a pointer to the XEmacLite instance.
* @param	AddressPtr is a pointer to a 6-byte MAC address.
*		the format of the MAC address is major octet to minor octet
*
* @return	None.
*
* @note
*
* 	- TX must be idle and RX should be idle for deterministic results.
*	It is recommended that this function should be called after the
*	initialization and before transmission of any packets from the device.
* 	- Function will not return if hardware is absent or not functioning
* 	properly.
*	- The MAC address can be programmed using any of the two transmit
*	buffers (if configured).
*
******************************************************************************/
// void XEmacLite_SetMacAddress(XEmacLite *InstancePtr, u8 *AddressPtr)
// void ethDrv_SetMacAddress(EthDrv *InstancePtr, u8 *AddressPtr)
// {
// 	UINTPTR BaseAddress;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertVoid(InstancePtr != NULL);

// 	/*
// 	 * Determine the expected TX buffer address.
// 	 */
// 	// BaseAddress = XEmacLite_NextTransmitAddr(InstancePtr);
// 	BaseAddress = ethDrv_NextTransmitAddr(InstancePtr);

// 	/*
// 	 * Copy the MAC address to the Transmit buffer.
// 	 */
// 	// XEmacLite_AlignedWrite(AddressPtr,
// 	// 			(UINTPTR *) BaseAddress,
// 	// 			XEL_MAC_ADDR_SIZE);
// 	ethDrv_AlignedWrite(AddressPtr,	(UINTPTR *) BaseAddress, XEL_MAC_ADDR_SIZE);

// 	/*
// 	 * Set the length.
// 	 */
// 	// XEmacLite_WriteReg(BaseAddress,
// 	// 			XEL_TPLR_OFFSET,
// 	// 			XEL_MAC_ADDR_SIZE);

// 	/*
// 	 * Update the MAC address in the EmacLite.
// 	 */
// 	// XEmacLite_SetTxStatus(BaseAddress, XEL_TSR_PROG_MAC_ADDR);
// 	ethDrv_SetTxStatus(BaseAddress, XEL_TSR_PROG_MAC_ADDR);


// 	/*
// 	 * Wait for EmacLite to finish with the MAC address update.
// 	 */
// 	// while ((XEmacLite_GetTxStatus(BaseAddress) &
// 	// 		XEL_TSR_PROG_MAC_ADDR) != 0);
// 	while ((ethDrv_GetTxStatus(BaseAddress) &
// 			XEL_TSR_PROG_MAC_ADDR) != 0);

// }

/******************************************************************************/
/**
*
* This is a stub for the send and receive callbacks. The stub
* is here in case the upper layers forget to set the handlers.
*
* @param	CallBackRef is a pointer to the upper layer callback reference.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
// void StubHandler(void *CallBackRef)
// {
// 	(void)(CallBackRef);
// 	Xil_AssertVoidAlways();
// }


/****************************************************************************/
/**
*
* Determine if there is a transmit buffer available.
*
* @param	InstancePtr is the pointer to the instance of the driver to
*		be worked on.
*
* @return
*		- TRUE if there is a TX buffer available for data to be written
*		- FALSE if Tx Buffer is not available.
*
* @note		None.
*
*****************************************************************************/
// int XEmacLite_TxBufferAvailable(XEmacLite *InstancePtr)
// {

// 	u32 Register;
// 	int TxPingBusy;
// 	int TxPongBusy;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertNonvoid(InstancePtr != NULL);

// 	/*
// 	 * Read the Tx Status and determine if the buffer is available.
// 	 */
// 	Register = XEmacLite_GetTxStatus(InstancePtr->EmacLiteConfig.
// 						BaseAddress);

// 	TxPingBusy = (Register & (XEL_TSR_XMIT_BUSY_MASK |
// 				 XEL_TSR_XMIT_ACTIVE_MASK));


// 	/*
// 	 * Read the Tx Status of the second buffer register and determine if the
// 	 * buffer is available.
// 	 */
// 	if (InstancePtr->EmacLiteConfig.TxPingPong != 0) {
// 		Register = XEmacLite_GetTxStatus(InstancePtr->EmacLiteConfig.
// 						BaseAddress +
// 						XEL_BUFFER_OFFSET);

// 		TxPongBusy = (Register & (XEL_TSR_XMIT_BUSY_MASK |
// 					XEL_TSR_XMIT_ACTIVE_MASK));

// 		return (!(TxPingBusy && TxPongBusy));
// 	}

// 	return (!TxPingBusy);


// }

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
int ethDrv_FlushReceive(EthDrv *InstancePtr) {
  // Checking if the engine is already in accept process
  while ((XAxiDma_ReadReg(InstancePtr->axiDmaPtr->RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK) ||
	     !XAxiDma_Busy   (InstancePtr->axiDmaPtr, XAXIDMA_DEVICE_TO_DMA)) {
    int status = XAxiDma_SimpleTransfer(InstancePtr->axiDmaPtr, (UINTPTR)0, XEL_MAX_FRAME_SIZE, XAXIDMA_DEVICE_TO_DMA);
    if (XST_SUCCESS != status) {
      printf("\nERROR: Initial Ethernet XAxiDma Rx accept to addr %0X with max lenth %d failed with status %d\n",
             0, XEL_MAX_FRAME_SIZE, status);
      return status;
    }
	printf("Flushing Rx data... \n");
  }

  return XST_SUCCESS;
}
// void XEmacLite_FlushReceive(XEmacLite *InstancePtr)
// {

// 	u32 Register;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertVoid(InstancePtr != NULL);

// 	/*
// 	 * Read the current buffer register and determine if the buffer is
// 	 * available.
// 	 */
// 	Register = XEmacLite_GetRxStatus(InstancePtr->EmacLiteConfig.
// 						BaseAddress);

// 	/*
// 	 * Preserve the IE bit.
// 	 */
// 	Register &= XEL_RSR_RECV_IE_MASK;

// 	/*
// 	 * Write out the value to flush the RX buffer.
// 	 */
// 	XEmacLite_SetRxStatus(InstancePtr->EmacLiteConfig.BaseAddress,
// 				Register);

// 	/*
// 	 * If the pong buffer is available, flush it also.
// 	 */
// 	if (InstancePtr->EmacLiteConfig.RxPingPong != 0) {
// 		/*
// 		 * Read the current buffer register and determine if the buffer
// 		 * is available.
// 		 */
// 		Register = XEmacLite_GetRxStatus(InstancePtr->EmacLiteConfig.
// 							BaseAddress +
// 							XEL_BUFFER_OFFSET);

// 		/*
// 		 * Preserve the IE bit.
// 		 */
// 		Register &= XEL_RSR_RECV_IE_MASK;

// 		/*
// 		 * Write out the value to flush the RX buffer.
// 		 */
// 		XEmacLite_SetRxStatus(InstancePtr->EmacLiteConfig.BaseAddress +
// 					XEL_BUFFER_OFFSET, Register);

// 	}

// }

/******************************************************************************/
/**
*
* Read the specified PHY register.
*
* @param	InstancePtr is the pointer to the instance of the driver.
* @param	PhyAddress is the address of the PHY device. The valid range is
*		is from 0 to 31.
* @param	RegNum is the register number in the PHY device which
*		is to be read. The valid range is is from 0 to 31.
* @param	PhyDataPtr is a pointer to the data in which the data read
*		from the PHY device is returned.
*
* @return
*		- XST_SUCCESS if the data is read from the PHY.
*		- XST_DEVICE_BUSY if MDIO is busy.
*
* @note		This function waits for the completion of MDIO data transfer.
*
*****************************************************************************/
// int XEmacLite_PhyRead(XEmacLite *InstancePtr, u32 PhyAddress, u32 RegNum,
// 			u16 *PhyDataPtr)
// {
// 	u32 PhyAddrReg;
// 	u32 MdioCtrlReg;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertNonvoid(InstancePtr != NULL);
// 	Xil_AssertNonvoid(InstancePtr->EmacLiteConfig.MdioInclude == TRUE);
// 	Xil_AssertNonvoid(PhyAddress <= 31);
// 	Xil_AssertNonvoid(RegNum <= 31);
// 	Xil_AssertNonvoid(PhyDataPtr != NULL);

// 	/*
// 	 * Verify MDIO master status.
// 	 */
// 	if (XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET) &
// 				XEL_MDIOCNTR_STATUS_MASK) {
// 		return XST_DEVICE_BUSY;
// 	}

// 	PhyAddrReg = ((((PhyAddress << XEL_MDIO_ADDRESS_SHIFT) &
// 			XEL_MDIO_ADDRESS_MASK) | RegNum) | XEL_MDIO_OP_MASK);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				 XEL_MDIOADDR_OFFSET, PhyAddrReg);

// 	/*
// 	 * Enable MDIO and start the transfer.
// 	 */
// 	MdioCtrlReg =
// 		XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_MDIOCNTR_OFFSET);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET,
// 				MdioCtrlReg |
// 				XEL_MDIOCNTR_STATUS_MASK |
// 				XEL_MDIOCNTR_ENABLE_MASK);

// 	/*
// 	 * Wait till the completion of transfer.
// 	 */
// 	while ((XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET) &
// 				XEL_MDIOCNTR_STATUS_MASK));

// 	/*
// 	 * Read data from MDIO read data register.
// 	 */
// 	*PhyDataPtr = (u16)XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_MDIORD_OFFSET);

// 	/*
// 	 * Disable the MDIO.
// 	 */
// 	MdioCtrlReg =
// 		XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_MDIOCNTR_OFFSET);

// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET,
// 				MdioCtrlReg & ~XEL_MDIOCNTR_ENABLE_MASK);


// 	return XST_SUCCESS;
// }

/******************************************************************************/
/**
*
* Write the given data to the specified register in the PHY device.
*
* @param	InstancePtr is the pointer to the instance of the driver.
* @param	PhyAddress is the address of the PHY device. The valid range is
*		is from 0 to 31.
* @param	RegNum is the register number in the PHY device which
*		is to be written. The valid range is is from 0 to 31.
* @param	PhyData is the data to be written to the specified register in
*		the PHY device.
*
* @return
*		- XST_SUCCESS if the data is written to the PHY.
*		- XST_DEVICE_BUSY if MDIO is busy.
*
* @note		This function waits for the completion of MDIO data transfer.
*
*******************************************************************************/
// int XEmacLite_PhyWrite(XEmacLite *InstancePtr, u32 PhyAddress, u32 RegNum,
// 			u16 PhyData)
// {
// 	u32 PhyAddrReg;
// 	u32 MdioCtrlReg;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertNonvoid(InstancePtr != NULL);
// 	Xil_AssertNonvoid(InstancePtr->EmacLiteConfig.MdioInclude == TRUE);
// 	Xil_AssertNonvoid(PhyAddress <= 31);
// 	Xil_AssertNonvoid(RegNum <= 31);

// 	/*
// 	 * Verify MDIO master status.
// 	 */
// 	if (XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET) &
// 				XEL_MDIOCNTR_STATUS_MASK) {
// 		return XST_DEVICE_BUSY;
// 	}



// 	PhyAddrReg = ((((PhyAddress << XEL_MDIO_ADDRESS_SHIFT) &
// 			XEL_MDIO_ADDRESS_MASK) | RegNum) & ~XEL_MDIO_OP_MASK);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOADDR_OFFSET, PhyAddrReg);

// 	/*
// 	 * Write data to MDIO write data register.
// 	 */
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOWR_OFFSET, (u32)PhyData);

// 	/*
// 	 * Enable MDIO and start the transfer.
// 	 */
// 	MdioCtrlReg =
// 		XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_MDIOCNTR_OFFSET);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET,
// 				MdioCtrlReg | XEL_MDIOCNTR_STATUS_MASK |
// 				XEL_MDIOCNTR_ENABLE_MASK);

// 	/*
// 	 * Wait till the completion of transfer.
// 	 */
// 	while ((XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET) & XEL_MDIOCNTR_STATUS_MASK));


// 	/*
// 	 * Disable the MDIO.
// 	 */
// 	MdioCtrlReg =
// 		XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_MDIOCNTR_OFFSET);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 				XEL_MDIOCNTR_OFFSET,
// 				MdioCtrlReg & ~XEL_MDIOCNTR_ENABLE_MASK);



// 	return XST_SUCCESS;
// }



/****************************************************************************/
/**
*
* Enable Internal loop back functionality.
*
* @param	InstancePtr is the pointer to the instance of the driver.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
// void XEmacLite_EnableLoopBack(XEmacLite *InstancePtr)
// {
// 	u32 TsrReg;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertVoid(InstancePtr != NULL);
// 	Xil_AssertVoid(InstancePtr->EmacLiteConfig.Loopback == TRUE);

// 	TsrReg = XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_TSR_OFFSET);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 			XEL_TSR_OFFSET,	TsrReg | XEL_TSR_LOOPBACK_MASK);
// }

/****************************************************************************/
/**
*
* Disable Internal loop back functionality.
*
* @param	InstancePtr is the pointer to the instance of the driver.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
// void XEmacLite_DisableLoopBack(XEmacLite *InstancePtr)
// {
// 	u32 TsrReg;

// 	/*
// 	 * Verify that each of the inputs are valid.
// 	 */
// 	Xil_AssertVoid(InstancePtr != NULL);
// 	Xil_AssertVoid(InstancePtr->EmacLiteConfig.Loopback == TRUE);

// 	TsrReg = XEmacLite_ReadReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 					XEL_TSR_OFFSET);
// 	XEmacLite_WriteReg(InstancePtr->EmacLiteConfig.BaseAddress,
// 			XEL_TSR_OFFSET,	TsrReg & (~XEL_TSR_LOOPBACK_MASK));
// }


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
// static u16 XEmacLite_GetReceiveDataLength(UINTPTR BaseAddress)
// {
// 	u16 Length;

// #ifdef __LITTLE_ENDIAN__
// 	Length = (XEmacLite_ReadReg((BaseAddress),
// 			XEL_HEADER_OFFSET + XEL_RXBUFF_OFFSET) &
// 			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
// 	Length = (u16) (((Length & 0xFF00) >> 8) | ((Length & 0x00FF) << 8));
// #else
// 	Length = ((XEmacLite_ReadReg((BaseAddress),
// 			XEL_HEADER_OFFSET + XEL_RXBUFF_OFFSET) >>
// 			XEL_HEADER_SHIFT) &
// 			(XEL_RPLR_LENGTH_MASK_HI | XEL_RPLR_LENGTH_MASK_LO));
// #endif

// 	return Length;
// }

/** @} */
