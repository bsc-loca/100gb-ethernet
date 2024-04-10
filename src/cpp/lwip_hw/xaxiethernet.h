/*****************************************************************************/
/**
*
* @file Initially started from original Xilinx xaxiethernet.h in Vitis-2021.2
*
* @addtogroup axiethernet_v5_13
* @{
* @details
*
* The Xilinx AXI Ethernet MAC driver component. This driver supports hard
* Ethernet core for Virtex-6(TM) devices and soft Ethernet core for
* Spartan-6(TM) and other supported devices. The supported speed can be
* 10/100/1000 Mbps and can reach up to 2000/2500 Mbps (1000Base-X versions).
*
* For a full description of AXI Ethernet features, please see the hardware
* spec.
* This driver supports the following features:
*   - Memory mapped access to host interface registers
*   - Virtual memory support
*   - Unicast, broadcast, and multicast receive address filtering
*   - Full duplex operation
*   - Automatic source address insertion or overwrite (programmable)
*   - Automatic PAD & FCS insertion and stripping (programmable)
*   - Flow control
*   - VLAN frame support
*   - Pause frame support
*   - Jumbo frame support
*   - Partial and full checksum offload
*   - Extended multicast addresses to 2**23.
*   - Extended VLAN translation, tagging and stripping supports.
*
* <h2>Driver Description</h2>
*
* The device driver enables higher layer software (e.g., an application) to
* configure a Axi Ethernet device. It is intended that this driver be used in
* cooperation with another driver (FIFO or DMA) for data communication. This
* device driver can support multiple devices even when those devices have
* significantly different configurations.
*
* <h2>Initialization & Configuration</h2>
*
* The XAxiEthernet_Config structure can be used by the driver to configure
* itself. This configuration structure is typically created by the tool-chain
* based on hardware build properties, although, other methods are allowed and
* currently used in some systems.
*
* To support multiple runtime loading and initialization strategies employed
* by various operating systems, the driver instance can be initialized using
* the XAxiEthernet_CfgInitialze() routine.
*
* <h2>Interrupts and Asynchronous Callbacks</h2>
*
* The driver has no dependencies on the interrupt controller. It provides
* no interrupt handlers. The application/OS software should set up its own
* interrupt handlers if required.
*
* <h2>Device Reset</h2>
*
* When a Axi Ethernet device is connected up to a FIFO or DMA core in hardware,
* errors may be reported on one of those cores (FIFO or DMA) such that it can
* be determined that the Axi Ethernet device needs to be reset. If a reset is
* performed, the calling code should also reconfigure and reapply the proper
* settings in the Axi Ethernet device.
*
* When a Axi Ethernet device reset is required, XAxiEthernet_Reset() should
* be utilized.
*
* <h2>Virtual Memory</h2>
*
* This driver may be used in systems with virtual memory support by passing
* the appropriate value for the <i>EffectiveAddress</i> parameter to the
* XAxiEthernet_CfgInitialize() routine.
*
* <h2>Transferring Data</h2>
*
* The Axi Ethernet core by itself is not capable of transmitting or receiving
* data in any meaningful way. Instead the Axi Ethernet device need to be
* connected to a FIFO or DMA core in hardware.
*
* This Axi Ethernet driver is modeled in a similar fashion where the
* application code or O/S adapter driver needs to make use of a separate FIFO
* or DMA driver in connection with this driver to establish meaningful
* communication over Ethernet.
*
* <h2>Checksum Offloading</h2>
*
* If configured, the device can compute a 16-bit checksum from frame data. In
* most circumstances this can lead to a substantial gain in throughput.
*
* The checksum offload settings for each frame sent or received are
* transmitted through the AXI4-Stream interface in hardware. What this means
* is that the checksum offload feature is indirectly controlled in the
* Axi Ethernet device through the driver for DMA core connected
* to the Axi Ethernet device.
*
* Refer to the documentation for DMA driver used for data
* communication on how to set the values for the relevant AXI4-Stream control
* words.
*
* Since this hardware implementation is general purpose in nature system
* software must perform pre and post frame processing to obtain the desired
* results for the types of packets being transferred. Most of the time this
* will be TCP/IP traffic.
*
* TCP/IP and UDP/IP frames contain separate checksums for the IP header and
* UDP/TCP header+data.
* For partial checksum offloading (enabled while configuring the hardware),
* the IP header checksum cannot be offloaded. Many stacks that support
* offloading will compute the IP header if required and use hardware to compute
* the UDP/TCP header+data checksum. There are other complications concerning
* the IP pseudo header that must be taken into consideration. Readers should
* consult a TCP/IP design reference for more details.
*
* For full checksum offloading (enabled while configuring the hardware), the
* IPv4 checksum calculation and validation can also be offloaded at the
* harwdare. Full checksum offload is supported only under certain conditions.
* IP checksum offload will be supported on valid IP datagrams that meet the
* following conditions.
*   - If present, the VLAN header is 4 bytes long
*   - Encapsulation into the Ethernet frame is either Ethernet II or Ethernet
*     SNAP format
*   - Only IPv4 is supported. IPv6 is not supported.
*   - IP header is a valid length
* TCP/UDP checksum offloading will be supported on valid TCP/UDP segments that
* meet the following conditions.
*   - Encapsulated in IPv4 (IPv6 is not supported)
*   - Good IP header checksum
*   - No fragmentation
*   - TCP or UDP segment
* When full checksum offload is enabled, the hardware does the following:
*   - Calculates the IP header checksum and inserts it in the IP header.
*   - Calculates the TCP/UDP Pseudo header from IP header.
*   - Calculates TCP/UDP header from, TCP/UDP psedu header, TCP/UDP header
*     and TCP/UDP payload.
*   - On the receive path, it again calculates all the above and validates
*     for IP header checksum and TCP/UDP checksum.
*
* There are certain device options that will affect the checksum calculation
* performed by hardware for Tx:
*
*   - FCS insertion disabled (XAE_FCS_INSERT_OPTION): software is required to
*     calculate and insert the FCS value at the end of the frame, but the
*     checksum must be known ahead of time prior to calculating the FCS.
*     Therefore checksum offloading cannot be used in this situation.
*
* And for Rx:
*
*   - FCS/PAD stripping disabled (XAE_FCS_STRIP_OPTION): The 4 byte FCS at the
*     end of frame will be included in the hardware calculated checksum.
*     software must subtract out this data.
*
*   - FCS/PAD stripping disabled (XAE_FCS_STRIP_OPTION): For frames smaller
*     than 64 bytes, padding will be included in the hardware calculated
*     checksum.
*     software must subtract out this data. It may be better to allow the
*     TCP/IP stack verify checksums for this type of packet.
*
*   - VLAN enabled (XAE_VLAN_OPTION): The 4 extra bytes in the Ethernet header
*     affect the hardware calculated checksum. software must subtract out the
*     1st two 16-bit words starting at the 15th byte.
*
* <h3>Transmit Checksum Offloading</h3>
*
* For partial checksum offloading, for the TX path, the software can specify
* where in the frame the checksum calculation is to start, where the result
* should be inserted, and a seed value. The checksum is calculated from
* the start point through the end of frame.
*
* For full checksum offloading, for the TX path, the software just need to
* enable Full Checksum offload in the appropriate AXI4-Stream Control word on
* a per packet basis.
*
* The checksum offloading settings are sent in the transmit AXI4 Stream control
* words. The relevant control word fields are described in brief below.
* Refer to the Axi Ethernet hardware specification for more details.
*
*<h4>AXI4-Stream Control Word 0:</h4>
*<pre>
*	Bits  1-0  : Transmit Checksum Enable: 	01 - Partial checsum offload,
*						10 - Full checksum offload
*						00 - No checksum offloading
*						11 - Not used, reserved
*	Bits 27-2  : Reserved
*	Bits 31-28 : Used for AXI4-Stream Control Mode flag
*</pre>
*
*<h4>AXI4-Stream Control Word 1:</h4>
*<pre>
*	Bits 31-16 (MSB): Transmit Checksum Calculation Starting Point: Offset
*			  in the frame where checksum calculation should begin.
*			  Relevant only for partial checksum offloading.
*	Bits 15-0  (LSB): Transmit Checksum Insertion Point: Frame offset where
*			  the computed checksum value is stored, which should be
*			  in the TCP or UDP header.
*			  Relevant only for partial checksum offloading.
*   </pre>
*
*<h4>AXI4-Stream Control Word 2:</h4>
*<pre>
*	Bits 31-16 (MSB): Reserved
*	Bits  0-15 (LSB): Transmit Checksum Calculation Initial Value: Checksum
*			  seed value.
*			  Relevant only for partial checksum offloading.
*</pre>
*
* <h3>Receive Checksum Offloading</h3>
*
* For partial checksum offload on the RX path, the 15th byte to end of frame
* is check summed. This range of bytes is the entire Ethernet payload (for
* non-VLAN frames).
*
* For full checksum offload on the RX path, both the IP and TCP checksums are
* validated if the packet meets the specified conditions.
*
* The checksum offloading information is sent in the receive AXI4-Stream
* status words. There are 4 relevant status words available. However
* only the relevant status words are described in brief below.
* Refer to the Axi Ethernet hardware specification for more details.
*
*<h4>AXI4-Stream Status Word 0:</h4>
*<pre>
*	Bits 31-28 (MSB): Always 0x5 to represent receive status frame
*	Bits 27-16	: Undefined
*	Bits 15-0  (LSB): MCAST_ADR_U. Upper 16 bits of the multicast
*			  destination address of the frame.
*
*<h4>AXI4-Stream Status Word 1:</h4>
*</pre>
*	Bits 31-0	: MCAST_ADR_L. The lower 32 bits of the multicast
*			  destination address.
*
*<h4>AXI4-Stream Status Word 2:</h4>
*</pre>
*	Bits 5-3 	: Specifies the receive full checksum status. This
*			  is relevant only for full checksum offloading.
*			  000 -> Neither the IP header nor the TCP/UDP
*				 checksums were checked.
*			  001 -> The IP header checksum was checked and was
*				 correct. The TCP/UDP checksum was not checked.
*			  010 -> Both the IP header checksum and the TCP
*				 checksum were checked and were correct.
*			  011 -> Both the IP header checksum and the UDP
*				 checksum were checked and were correct.
*			  100 -> Reserved.
*			  101 -> The IP header checksum was checked and was
*				 incorrect. The TCP/UDP checksum was not
*				 checked.
*			  110 -> The IP header checksum was checked and is
*				 correct but the TCP checksum was checked
*				 and was incorrect.
*			  111 -> The IP header checksum was checked and is
*				 correct but the UDP checksum was checked and
*				 was incorrect.
*
*<h4>AXI4-Stream Status Word 3:</h4>
*	Bits 31-16	: T_L_TPID. This is the value of 13th and 14th byte
*			  of the frame.
*	Bits 15-0 	: Receive Raw Checksum: Computed checksum value
*
*<h4>AXI4-Stream Status Word 3:</h4>
*	Bits 31-16	: VLAN_TAG. Value of 15th and 16th byte of the
*			 frame.
*	Bits 15-0 	: RX_BYTECNT. Received frame length.
*
*
* <h2>Extended multicast</h2>
* (XAE_EXT_MULTICAST_OPTION): Allow and perform address filtering more than 4
* multicast addresses. Hardware requires to enable promiscuous mode
* (XAE_PROMISCUOUS_OPTION) and disable legacy multicast mode
* (XAE_MULTICAST_OPTION) for this feature to work.
*
* <h2>Extended VLAN</h2>
*
* <h3>TX/RX VLAN stripping</h3>
* (XAE_EXT_[T|R]XVLAN_STRP_OPTION) handles transmit/receive one VLAN tag
* stripping in Ethernet frames. To enable this option, hardware requires to
* build with this feature and enable (XAE_FCS_INSERT_OPTION),
* (XAE_FCS_STRP_OPTION) and disable (XAE_VLAN_OPTION). Supports three modes,
* -XAE_VSTRP_NONE   : no stripping
* -XAE_VSTRP_ALL    : strip one tag from all frames
* -XAE_VSTRP_SELECT : strip one tag from selected frames
*
* <h3>TX/RX VLAN translation</h3>
* (XATE_EXT_[T|R]XVLAN_TRAN_OPTION) handles transmit/receive one VLAN tag
* translation in Ethernet frames. To enable this option, hardware requires to
* build with this feature and enable (XATE_FCS_INSERT_OPTION),
* (XAE_FCS_STRP_OPTION), and disable (XAE_VLAN_OPTION).
*
* <h3>TX/RX VLAN tagging</h3>
* (XAE_EXT_[T|R]XVLAN_TAG_OPTION) adds transmit/receive one VLAN tag in
* Ethernet frames. To enable this option, hardware requires to build with this
* feature and enable (XAE_FCS_INSERT_OPTION), (XAE_FCS_STRP_OPTION),
* (XAE_JUMBO_OPTION) and disable (XAE_VLAN_OPTION). Support four modes,
* -XAE_VTAG_NONE    : no tagging
* -XAE_VTAG_ALL     : tag all frames
* -XAE_VTAG_EXISTED : tag already tagged frames
* -XAE_VTAG_SELECT  : tag selected already tagged frames
*
* <h2>PHY Communication</h2>
*
* Prior to PHY access, the MDIO clock must be setup. This driver will set a
* safe default that should work with AXI4-Lite bus speeds of up to 150 MHz
* and keep the MDIO clock below 2.5 MHz. If the user wishes faster access to
* the PHY then the clock divisor can be set to a different value (see
* XAxiEthernet_PhySetMdioDivisor()).
*
* MII register access is performed through the functions XAxiEthernet_PhyRead()
* and XAxiEthernet_PhyWrite().
*
* <h2>Link Sync</h2>
*
* When the device is used in a multi speed environment, the link speed must be
* explicitly set using XAxiEthernet_SetOperatingSpeed() and must match the
* speed PHY has negotiated. If the speeds are mismatched, then the MAC will not
* pass traffic.
*
* The application/OS software may use the AutoNegotiation interrupt to be
* notified when the PHY has completed auto-negotiation.
*
* <h2>Asserts</h2>
*
* Asserts are used within all Xilinx drivers to enforce constraints on argument
* values. Asserts can be turned off on a system-wide basis by defining, at
* compile time, the NDEBUG identifier. By default, asserts are turned on and it
* is recommended that users leave asserts on during development. For deployment
* use -DNDEBUG compiler switch to remove assert code.
*
* <h2>Driver Errata</h2>
*
*   - A dropped receive frame indication may be reported by the driver after
*     calling XAxiEthernet_Stop() followed by XAxiEthernet_Start(). This can
*     occur if a frame is arriving when stop is called.
*   - On Rx with checksum offloading enabled and FCS/PAD stripping disabled,
*     FCS and PAD data will be included in the checksum result.
*   - On Tx with checksum offloading enabled and auto FCS insertion disabled,
*     the user calculated FCS will be included in the checksum result.
*
* @note
*
* Xilinx drivers are typically composed of two components, one is the driver
* and the other is the adapter.  The driver is independent of OS and processor
* and is intended to be highly portable.  The adapter is OS-specific and
* facilitates communication between the driver and an OS.
* <br><br>
* This driver is intended to be RTOS and processor independent. Any needs for
* dynamic memory management, threads or thread mutual exclusion, or cache
* control must be satisfied by the layer above this driver.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- ---------------------------------------------------------
* 1.00a asa  6/30/10  First release based on the ll temac driver
* 1.01a asa  12/10/10 Added macros XAxiEthernet_IsRxFullCsum and
*		      XAxiEthernet_IsTxFullCsum for supporting full checksum
*		      offload. The full checksum offload is only supported in
*		      newer versions of the core, please refer to the core
*		      HW datasheet.
* 1.02a asa  2/16/11  Inserted a delay in the driver function
*		      XAxiEthernet_Reset in file xaxiethernet.c. This is done
*		      because immediately after a core reset none of the
*		      AxiEthernet registers are accessible for some duration.
*		      Changed the value of XAE_LOOPS_TO_COME_OUT_OF_RST to
*		      10000 in file xaxiethernet_hw.h.
*
* 2.00a asa  8/29/11  A new major version of AxiEthernet driver is being
*		      released to accommodate the change in avb software. The
*		      AxiEthernet hardware v3_00_a has the latest avb
*		      hardware which needs a corresponding change in avb
*		      software (released in examples/avb folder). This change
*		      in avb software is not backwards compatible (which
*		      means this avb software will not work with older
*		      axiethernet hardware).
*		      Hence a new major version of axiethernet is being
*		      released.
*		      Added defines for Ability Reg, Identification Reg, Rx max
*		      Frame and Tx Max Frame registers.
*		      Changed define for TEMAC RGMII/SGMII Config (PHYC) Reg.
*
* 3.00a asa  4/10/12  A new major version of AxiEthernet is being released to
*		      accommodate the change in AVB example. From AxiEthernet
*		      core version 3.01a onwards the AVB implementation has
*		      changed. The AVB module is now a part of AxiEthernet IP.
*		      Because of this change, the AVB example works only
*		      when promiscuous mode is not enabled (unlike earlier
*		      implementation where promiscuous mode was required for
*		      AVB example to work). Hence the file xavb_example.c is
*		      changed so that the core is not put in promiscuous mode.
*		      Also since AVB is a part of AxiEthernet some of the
*		      register mappings in xavb_hw.h has changed.
*		      These changes are not backward compatible which means
*		      this changed example will not work for previous versions
*		      of cores.
*		      Hence a new major version of axiethernet is being
*		      released.
* 3.01a srt  02/03/13 - Added support for SGMII mode (CR 676793)
*	     	      - Added support for IPI designs (CR 698249)
*	     02/14/13 - Added support for Zynq (CR 681136)
* 3.02a srt  04/13/13 - Removed Warnings (CR 704998).
*            04/24/13 - Modified parameter *_SGMII_PHYADDR to *_PHYADDR, the
*                       config parameter C_PHYADDR applies to SGMII/1000BaseX
*	                modes of operation
*	     04/24/13 - Added support for 1000BaseX mode in examples (_util.c)
*		        (CR 704195)
*	     04/24/13 - Added support for RGMII mode in examples (_util.c)
* 3.02a srt  08/06/13 - Fixed CR 727634:
*			  Modified FifoHandler() function logic of FIFO
*			  interrupt example to reflect the bit changes in
*			  the Interrupt Status Register as per the latest
*			  AXI FIFO stream IP.
*		      - Fixed CR 721141:
*			  Added support to handle multiple instances of
*			  AxiEthernet FIFO interface (CR 721141)
*		      - Fixed CR 717949:
*			  Configures external Marvel 88E1111 PHY based on the
*			  AXI Ethernet physical interface type and allows to
*			  operate in specific interface mode without changing
*			  jumpers on the Microblaze boards. This change is in
*			  example_util.c
* 3.02a adk 15/11/13 - Fixed CR 761035 removed dependency with fifo in MDD file
* 4.0   adk 19/12/13 - Updated as per the New Tcl API's
*		asa 30/01/14 - Added defines for 1588 registers and bit masks
*					   Added config parameter for SGMII over LVDS
*
* 4.1  adk 21/04/14 - Fixed CR:780537 Changes are Made in the file
* 		      axiethernet test-app tcl
* 4.2  adk 08/08/14 - Fixed CR:810643 SDK generated 'xparamters.h' erroneously
*		      generated with errors due to part of '#define' misplaced
*		      changes are made in the driver tcl file.
* 4.3 adk 29/10/14 -  Added support for generating parameters for SGMII/1000BaseX
*		      modes When IP is configured with the PCS/PMA core.
*		      Changes are made in the driver tcl file (CR 828796).
* 4.4  adk  8/1/15 -  Fixed TCL errors when axiethernet is configured with the
*		      Axi stream fifo (CR 835605). Changes are made in the
*		      driver tcl file.
* 5.0  adk 13/06/15 - Updated the driver tcl for Hier IP(To support User parameters).
* 5.0  adk 28/07/15 - Fixed CR:870631 AXI Ethernet with FIFO will fail to
*		      Create the BSP if the interrupt pin on the FIFO is unconnected
* 5.1  sk  11/10/15 Used UINTPTR instead of u32 for Baseaddress CR# 867425.
*                   Changed the prototype of XAxiEthernet_CfgInitialize API.
* 5.1  adk 30/01/15  Fix compilation errors in case of zynqmp. CR#933825.
* 5.1  adk 02/11/16  Updated example to Support ZynqMp.
* 5.2  adk 13/05/16  Fixed CR#951669 Fix compilation errors when axi dma
* 		     interrupts are not connected.
* 5.3  adk 05/10/16  Fixed CR#961152 PMU template firmware fails to compile on
* 		     ZynqMP AXI-Ethernet designs.
* 5.4  adk 07/12/16  Added Support for TI PHY DP83867 changes are made in the
* 		     examples xaxiethernet_example_util.c file.
*       ms 01/23/17 Modified xil_printf statement in main function for all
*            examples to ensure that "Successfully ran" and "Failed" strings
*            are available in all examples. This is a fix for CR-965028.
*	adk 03/09/17 Fixed CR#971367 fix race condition in the tcl
*		     for a multi mac design(AXI_CONNECTED_TYPE defined for
*		     only one instance)
*       ms 03/17/17 Modified text file in examples folder for doxygen
*                   generation.
*       ms 04/05/17 Added tabspace for return statements in functions
*                   of axiethernet examples for proper documentation while
*                   generating doxygen.
* 5.5	adk 19/05/17 Increase Timeout value in the driver as per new h/w update
* 		     i.e. Increase of transceiver initialization times in
* 		     ultrascale+ devices (CR#976244).
* 5.6  adk 03/07/17 Fixed issue lwip stops working as soon as something is
*		    plugged to it`s AXI stream bus (CR#979634). Changes
*		    are made in the driver tcl and test app tcl.
* 5.6  adk 03/07/17 Fixed CR#979023 Intr fifo example failed to compile.
*      ms  04/18/17 Modified tcl file to add suffix U for all macro
*                   definitions of axiethernet in xparameters.h
*      adk 08/08/17 Fixed CR#981893 Fix bsp compilation error for axiethernet
*		    mcdma chiscope based designs.
*      ms  08/16/17 Fixed compilation warnings in xaxiethernet_sinit.c
*      adk 08/22/17 Fixed CR#983008 app generation errors for Specific IPI design.
*      adk 08/28/17 Fixed CR#982877 couple of dsv_ced tests are failing in peripheral
*		    app generation.
*      adk 09/21/17 Fixed CR#985686 bsp generation error with specific design.
*		    Changes are made in the driver tcl.
* 5.7  rsp 01/09/18 Add NumTableEntries member in XAxiEthernet_Config.
*                   Instead of #define XAE_MULTI_MAT_ENTRIES derive multicast table
*                   entries max count from ethernet config structure.
*          01/11/18 Fixed CR#976392 Use UINTPTR for DMA base address.
* </pre>
*
******************************************************************************/

#ifndef XAXIETHERNET_H		/* prevent circular inclusions */
#define XAXIETHERNET_H		/* by using protection macros */

#include "eth_defs.h"

/**************************** Type Definitions *******************************/
/**
 * This typedef contains configuration information for a Axi Ethernet device.
 */
typedef struct XAxiEthernet_Config {
	UINTPTR BaseAddress; // BaseAddress is the physical base address of the device's registers
} XAxiEthernet_Config;

/**
 * struct XAxiEthernet is the type for Axi Ethernet driver instance data.
 * The calling code is required to use a unique instance of this structure
 * for every Axi Ethernet device used in the system. A reference to a structure
 * of this type is then passed to the driver API functions.
 */
typedef struct XAxiEthernet {
	u32 IsReady;		 /**< Device is initialized and ready */
} XAxiEthernet;

/*****************************************************************************/
/**
*
* XAxiEthernet_IsDma reports if the device is currently connected to DMA.
*
* @param	InstancePtr is a pointer to the Axi Ethernet instance to be
*		worked on.
* @return
*		- TRUE if the Axi Ethernet device is connected DMA.
*		- FALSE.if the Axi Ethernet device is NOT connected to DMA
*
* @note 	C-style signature:
* 		u32 XAxiEthernet_IsDma(XAxiEthernet *InstancePtr)
*
******************************************************************************/
// #define XAxiEthernet_IsDma(InstancePtr) (((InstancePtr)->Config.AxiDevType == XPAR_AXI_DMA) ? TRUE: FALSE)
#define XAxiEthernet_IsDma(InstancePtr) (TRUE)

/*****************************************************************************/
/**
*
* XAxiEthernet_IsFifo reports if the device is currently connected to a fifo
* core.
*
* @param	InstancePtr is a pointer to the Axi Ethernet instance to be
*		worked on.
*
* @return
*		- TRUE if the Axi Ethernet device is connected to a fifo
*		- FALSE if the Axi Ethernet device is NOT connected to a fifo.
*
* @note 	C-style signature:
* 		u32 XAxiEthernet_IsFifo(XAxiEthernet *InstancePtr)
*
******************************************************************************/
// #define XAxiEthernet_IsFifo(InstancePtr) (((InstancePtr)->Config.AxiDevType == XPAR_AXI_FIFO) ? TRUE: FALSE)
#define XAxiEthernet_IsFifo(InstancePtr) (FALSE)

/*****************************************************************************/
/**
*
* XAxiEthernet_IsMcDma reports if the device is currently connected to MCDMA.
*
* @param	InstancePtr is a pointer to the Axi Ethernet instance to be
*		worked on.
* @return
*		- TRUE if the Axi Ethernet device is connected MCDMA.
*		- FALSE.if the Axi Ethernet device is NOT connected to MCDMA
*
* @note 	C-style signature:
* 		u32 XAxiEthernet_IsMcDma(XAxiEthernet *InstancePtr)
*
******************************************************************************/
// #define XAxiEthernet_IsMcDma(InstancePtr) (((InstancePtr)->Config.AxiDevType == XPAR_AXI_MCDMA) ? TRUE: FALSE)
#define XAxiEthernet_IsMcDma(InstancePtr) (FALSE)

/************************** Function Prototypes ******************************/

/*
 * Initialization functions in xaxiethernet.c
 */
// int XAxiEthernet_Initialize(XAxiEthernet *InstancePtr,
// 			    XAxiEthernet_Config *CfgPtr, UINTPTR VirtualAddress);
#define XAxiEthernet_Initialize(InstancePtr, CfgPtr, VirtualAddress)

XAxiEthernet_Config * xaxiemac_lookup_config(unsigned mac_base);

// void init_axiemac(xaxiemacif_s *xaxiemacif, struct netif *netif);
#define init_axiemac(xaxiemacif, netif)

#endif /* end of protection macro */
/** @} */
