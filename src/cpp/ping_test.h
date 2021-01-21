/*****************************************************************************/
/**
* @file Initially started from Xilinx xemaclite_ping_req_example.c
* @file Initially started from Xilinx xemaclite_ping_reply_example.c
*
* Copyright (C) 2008 - 2020 Xilinx, Inc.  All rights reserved.
* SPDX-License-Identifier: MIT
*****************************************************************************/

#ifndef PINGTEST_H  // prevent circular inclusions
#define PINGTEST_H  // by using protection macros


//***************************** Include Files *********************************
#include "ethdrv.h"


/************************** Ethernet Definitions *****************************/
#define BROADCAST_PACKET	1	    /* Broadcast packet */
#define MAC_MATCHED_PACKET	2 	    /* Dest MAC matched with local MAC */
#define IP_ADDR_SIZE		4	    /* IP Address size in Bytes */
#define HW_TYPE			    0x01	/* Hardware type (10/100 Mbps) */
#define IP_VERSION		    0x0604	/* IP version ipv4/ipv6 */
#define ARP_REQUEST 		0x0001	/* ARP Request bits in Rx packet */
#define ARP_REPLY 		    0x0002 	/* ARP status bits indicating reply */
#define ARP_REQ_PKT_SIZE	0x2A	/* ARP request packet size */
#define ARP_PACKET_SIZE 	0x3C    /* ARP packet len 60 Bytes */
#define ECHO_REPLY		    0x00	/* Echo reply */
#define ICMP_PACKET_SIZE 	0x4A    /* ICMP packet length 74 Bytes including Src and Dest MAC Address */
#define BROADCAST_ADDR 		0xFFFF  /* Broadcast Address */
#define CORRECT_CKSUM_VALUE	0xFFFF  /* Correct checksum value */
#define IDENT_FIELD_VALUE	0x9263	/* Identification field (random num) */
#define IDEN_NUM		    0x02	/* ICMP identifier number */

//--- Definitions for the locations and length of some of the fields in a IP packet. The lengths are defined in Half-Words (2 bytes).
#define SRC_MAC_ADDR_LOC	 3 /* Source MAC address location */
#define MAC_ADDR_LEN 		 3 /* MAC address length */
#define ETHER_PROTO_TYPE_LOC 6 /* Ethernet Proto type location */
#define ETHER_PROTO_TYPE_LEN 1 /* Ethernet protocol Type length  */

#define ARP_HW_TYPE_LEN 	1  /* Hardware Type length  */
#define ARP_PROTO_TYPE_LEN	1  /* Protocol Type length  */
#define ARP_HW_ADD_LEN		1  /* Hardware address length */
#define ARP_PROTO_ADD_LEN	1  /* Protocol address length */
#define ARP_ZEROS_LEN		9  /* Length to be filled with zeros */
#define ARP_REQ_STATUS_LOC 	10 /* ARP request location */
#define ARP_REQ_SRC_IP_LOC 	14 /* Src IP address location of ARP request */
#define ARP_REQ_DEST_IP_LOC_1 19 /* Destination IP's 1st half word location */
#define ARP_REQ_DEST_IP_LOC_2 20 /* Destination IP's 2nd half word location */

#define IP_VERSION_LEN 		1  /* IP Version length  */
#define IP_PACKET_LEN 		1  /* IP Packet length field  */
#define IP_TTL_ICM_LEN 		1  /* Time to live and ICM fields length */
#define IP_HDR_START_LOC 	7  /* IP header start location */
#define IP_HEADER_INFO_LEN	7  /* IP header information length */
#define IP_HDR_LEN 	    	10 /* IP Header length */
#define IP_FRAG_FIELD_LOC 	10 /* Fragment field location */
#define IP_FRAG_FIELD_LEN	1  /* Fragment field len in ICMP packet */
#define IP_CHECKSUM_LOC		12 /* IP header checksum location */
#define IP_CSUM_LOC_BACK	5  /* IP checksum location from end of frame */
#define IP_REQ_SRC_IP_LOC 	13 /* Src IP add loc of ICMP req */
#define IP_REQ_DEST_IP_LOC	15 /* Dest IP add loc of ICMP req */
#define IP_ADDR_LEN 		2  /* Size of IP address in half-words */

#define ICMP_TYPE_LEN 	    	1  /* ICMP Type length */
#define ICMP_REQ_SRC_IP_LOC 	13 /* Src IP address location of ICMP request */
#define ICMP_ECHO_FIELD_LOC 	17 /* Echo field location */
#define ICMP_ECHO_FIELD_LEN 	2  /* Echo field length in half-words */
#define ICMP_DATA_START_LOC 	17 /* Data field start location */
#define ICMP_DATA_FIELD_LEN 	20 /* Data field length */
#define ICMP_DATA_LEN 		    18 /* ICMP data length */
#define ICMP_DATA_LOC 		    19 /* ICMP data location including identifier number and sequence number */
#define ICMP_DATA_CHECKSUM_LOC	18 /* ICMP data checksum location */
#define ICMP_DATA_CSUM_LOC_BACK 19 /* Data checksum location from end of frame */
#define ICMP_IDEN_FIELD_LOC	    19 /* Identifier field loc */
#define ICMP_SEQ_NO_LOC		    20 /* sequence number location */
#define ICMP_KNOWN_DATA_LOC	    21 /* ICMP known data start loc */
#define ICMP_KNOWN_DATA_LEN	    16 /* ICMP known data length */


//*********** Ping Request Class *************
class PingReqstTest {
  // Set up a local MAC address.
  uint8_t  LocalMacAddr[XEL_MAC_ADDR_SIZE] = {0x00, 0x0A, 0x35, 0x03, 0x02, 0x01};
  uint16_t DestMacAddr [MAC_ADDR_LEN]; // Destination MAC Address

  // The IP addresses. User need to set a free IP address based on the network on which this example is to be run.
  uint8_t LocalIpAddr[IP_ADDR_SIZE] = {172, 16, 63, 61 };
  uint8_t DestIpAddr [IP_ADDR_SIZE] = {172, 16, 63, 121}; // Set up a Destination IP address.

  // Known data transmitted in Echo request.
  uint16_t IcmpData[ICMP_KNOWN_DATA_LEN] = {
    0x6162,	0x6364,	0x6566, 0x6768, 0x696A,	0x6B6C, 0x6D6E,	0x6F70,
    0x7172, 0x7374, 0x7576, 0x7761, 0x6263,	0x6465, 0x6667,	0x6869
  };

  // IP header information -- each field has its own significance.
  // Icmp type, ipv4 typelength, packet length, identification field, Fragment type, time to live and ICM, checksum.
  uint16_t IpHeaderInfo[IP_HEADER_INFO_LEN] = {0x0800, 0x4500, 0x003C, 0x5566, 0x0000, 0x8001, 0x0000};

  // Buffers used for Transmission and Reception of Packets.
  uint8_t RxFrame[XEL_MAX_FRAME_SIZE];
  uint8_t TxFrame[XEL_MAX_FRAME_SIZE];

  int SeqNum; // Variable used to indicate the sequence number of the ICMP(echo) packet.
  int NumOfPingReqPkts; // Variable used to indicate the number of ping request packets to be send.

  void SendEchoReqFrame();
  void SendArpReqFrame();
  int ProcessRcvFrame();

  EthSyst* ethSystPtr; // Ethernet System hardware

  public:
  PingReqstTest(EthSyst*);
  int pingReqst();
};


//*********** Ping Reply Class *************
class PingReplyTest {
  // Set up a local MAC address.
  uint8_t LocalMacAddr[XEL_MAC_ADDR_SIZE] = {0x00, 0x0A, 0x35, 0x02, 0x22, 0x5E};

  // The IP address. User need to set a free IP address based on the network on which this example is to be run.
  uint8_t LocalIpAddr[IP_ADDR_SIZE] = {172, 16, 63, 121};

  // Buffers used for Transmission and Reception of Packets.
  uint8_t RxFrame[XEL_MAX_FRAME_SIZE];
  uint8_t TxFrame[XEL_MAX_FRAME_SIZE];

  uint32_t NumOfPingReplies; // Variable used to indicate the number of Ping replies sent.

  void ProcessRcvFrame();

  EthSyst* ethSystPtr; // Ethernet System hardware

  public:
  PingReplyTest(EthSyst*);
  int pingReply();
};

#endif // end of protection macro
