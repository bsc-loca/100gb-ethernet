
//----- General definitions
#define XLWIP_CONFIG_INCLUDE_AXI_ETHERNET // defining presence of Ethernet core, actually one which we mimic for LwIP
// #define XLWIP_CONFIG_INCLUDE_AXI_ETHERNET_DMA // defining presence of DMA for Ethernet core (used at app build stage)
#define LWIPERF_CHECK_RX_DATA 1

#define LWIP_NETIF_TX_SINGLE_PBUF 1 // TCP packet shouldn't be cut among few allocations for DMA+100GbEth cores proper functioning
// #define TCP_OVERSIZE           1 // required by above define but cannot be propagated from here (so done in build_app.tcl) 

//----- Additional debug messaging
// #define ETHARP_DEBUG     LWIP_DBG_ON
// #define TCP_INPUT_DEBUG  LWIP_DBG_ON
// #define TCP_OUTPUT_DEBUG LWIP_DBG_ON
// #define TCP_WND_DEBUG    LWIP_DBG_ON
// #define TCP_CWND_DEBUG   LWIP_DBG_ON
// #define TCP_QLEN_DEBUG   LWIP_DBG_ON
// #define TCP_RTO_DEBUG    LWIP_DBG_ON
// #define TCP_FR_DEBUG     LWIP_DBG_ON
// #define TCP_RST_DEBUG    LWIP_DBG_ON
// #define TCPIP_DEBUG      LWIP_DBG_ON
// #define API_MSG_DEBUG    LWIP_DBG_ON
// #define MEMP_DEBUG       LWIP_DBG_ON


//----- Replacement of built-in LwIP memory allocation with one based on dedicated Tx/Rx DMA memories
#include "xparameters.h"
//We want DMA+100GbEth cores compliant memory alignment like for ETH_MEMPACK_SIZE in eth_test.cpp,
//so for packet size below 2KB the alignment should be at least 2KB:
#define DMA_AXI_BURST (64*64) // the parameter set in Vivado AXI_DMA IP
#define MEMPACK_ALIGN_SIZE (DMA_AXI_BURST/2)
#define LWIP_MEM_ALIGN_SIZE(size) (((size) + MEMPACK_ALIGN_SIZE-1) / MEMPACK_ALIGN_SIZE * MEMPACK_ALIGN_SIZE)

// Buffers distribution table grabbed from LwIP execution
#define ADDR_memp_memory_PBUF_POOL_base      XPAR_RX_MEM_CPU_S_AXI_BASEADDR
#define SIZE_memp_memory_PBUF_POOL_base      (4096*256)    // originally (1792 x pbuf_pool_size) for pbuf_pool_bufsize=1700 in LwIP config
#define ADDR_RX_MEM_UNALLOC                  (ADDR_memp_memory_PBUF_POOL_base + \
                                              SIZE_memp_memory_PBUF_POOL_base)

#define ADDR_ram_heap                        XPAR_TX_MEM_CPU_S_AXI_BASEADDR
#define SIZE_ram_heap                        (31*2048+4096)  // originally (mem_size + 128)
#define ADDR_memp_memory_UDP_PCB_base        (ADDR_ram_heap + \
                                              SIZE_ram_heap)
#define SIZE_memp_memory_UDP_PCB_base        (2048*4)      // originally (64 x memp_n_udp_pcb)
#define ADDR_memp_memory_TCP_PCB_base        (ADDR_memp_memory_UDP_PCB_base + \
                                              SIZE_memp_memory_UDP_PCB_base)
#define SIZE_memp_memory_TCP_PCB_base        (2048*32)     // originally (192 x memp_n_tcp_pcb)
#define ADDR_memp_memory_TCP_PCB_LISTEN_base (ADDR_memp_memory_TCP_PCB_base + \
                                              SIZE_memp_memory_TCP_PCB_base)
#define SIZE_memp_memory_TCP_PCB_LISTEN_base (2048*8)      // originally (64 x memp_n_tcp_pcb_listen)
#define ADDR_memp_memory_TCP_SEG_base        (ADDR_memp_memory_TCP_PCB_LISTEN_base + \
                                              SIZE_memp_memory_TCP_PCB_LISTEN_base)
#define SIZE_memp_memory_TCP_SEG_base        (2048*128)     // originally (64 x memp_n_tcp_seg)
#define ADDR_memp_memory_REASSDATA_base      (ADDR_memp_memory_TCP_SEG_base + \
                                              SIZE_memp_memory_TCP_SEG_base)
#define SIZE_memp_memory_REASSDATA_base      (2048*5)      // originally (64 x MEMP_NUM_REASSDATA)
#define ADDR_memp_memory_FRAG_PBUF_base      (ADDR_memp_memory_REASSDATA_base + \
                                              SIZE_memp_memory_REASSDATA_base)
#define SIZE_memp_memory_FRAG_PBUF_base      (2048*256)    // originally (64 x MEMP_NUM_FRAG_PBUF)
#define ADDR_memp_memory_ARP_QUEUE_base      (ADDR_memp_memory_FRAG_PBUF_base + \
                                              SIZE_memp_memory_FRAG_PBUF_base)
#define SIZE_memp_memory_ARP_QUEUE_base      (2048*30)     // originally (64 x MEMP_NUM_ARP_QUEUE)
#define ADDR_memp_memory_PBUF_base           (ADDR_memp_memory_ARP_QUEUE_base + \
                                              SIZE_memp_memory_ARP_QUEUE_base)
#define SIZE_memp_memory_PBUF_base           (2048*16)     // originally (64 x memp_n_pbuf)
#define ADDR_TX_MEM_UNALLOC                  (ADDR_memp_memory_PBUF_base + \
                                              SIZE_memp_memory_PBUF_base)

//This code discovers above sizes being inserted to :
//- memp_init() function of memp.c:
//   xil_printf("UDP_PCB        size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct udp_pcb))),         MEMP_NUM_UDP_PCB);
//   xil_printf("TCP_PCB        size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct tcp_pcb))),         MEMP_NUM_TCP_PCB);
//   xil_printf("TCP_PCB_LISTEN size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct tcp_pcb_listen))),  MEMP_NUM_TCP_PCB_LISTEN);
//   xil_printf("TCP_SEG        size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct tcp_seg))),         MEMP_NUM_TCP_SEG);
//   xil_printf("REASSDATA      size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct ip_reassdata))),    MEMP_NUM_REASSDATA);
//   xil_printf("FRAG_PBUF      size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct pbuf_custom_ref))), MEMP_NUM_FRAG_PBUF);
//   xil_printf("ARP_QUEUE      size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct etharp_q_entry))),  MEMP_NUM_ARP_QUEUE);
//   xil_printf("PBUF           size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(sizeof(struct pbuf))),            MEMP_NUM_PBUF);
//   xil_printf("PBUF_POOL      size %d x %d \n", (MEMP_SIZE + MEMP_ALIGN_SIZE(LWIP_MEM_ALIGN_SIZE(sizeof(struct pbuf)) +
//                                                                             LWIP_MEM_ALIGN_SIZE(PBUF_POOL_BUFSIZE) )), PBUF_POOL_SIZE);
//- mem_init() function of mem.c:
//   xil_printf("ram_heap       size %d + %d \n", LWIP_MEM_ALIGN_SIZE(MEM_SIZE),
//                                              2*LWIP_MEM_ALIGN_SIZE(sizeof(struct mem)));

//Actual allocation function, sizes and memory fit violations are detected at compile time by zero division
#define LWIP_DECLARE_MEMORY_ALIGNED(var_name, size) \
  uint8_t* const var_name = (uint8_t*)(ADDR_##var_name / (size == SIZE_##var_name && \
                                                         (ADDR_RX_MEM_UNALLOC <= XPAR_RX_MEM_CPU_S_AXI_HIGHADDR+1) && \
                                                         (ADDR_TX_MEM_UNALLOC <= XPAR_TX_MEM_CPU_S_AXI_HIGHADDR+1)))
