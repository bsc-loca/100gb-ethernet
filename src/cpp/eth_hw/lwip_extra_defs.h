
#define XLWIP_CONFIG_INCLUDE_AXI_ETHERNET

//----- Replacement of built-in LwIP memory allocation with one based on dedicated Tx/Rx DMA memories
#include "xparameters.h"

// Buffers distribution table grabbed from LwIP execution
#define ADDR_memp_memory_PBUF_POOL_base      XPAR_RX_MEM_CPU_S_AXI_BASEADDR
#define SIZE_memp_memory_PBUF_POOL_base      (1792*512)   // x"pbuf_pool_size" param in LwIP config
#define ADDR_RX_MEM_UNALLOC                  (ADDR_memp_memory_PBUF_POOL_base + \
                                              SIZE_memp_memory_PBUF_POOL_base)

#define ADDR_ram_heap                        XPAR_TX_MEM_CPU_S_AXI_BASEADDR
#define SIZE_ram_heap                        (524288+128)  // aligned "mem_size" param in LwIP config
#define ADDR_memp_memory_UDP_PCB_base        (ADDR_ram_heap + \
                                              SIZE_ram_heap)
#define SIZE_memp_memory_UDP_PCB_base        (64*4)       // x"memp_n_udp_pcb" param in LwIP config
#define ADDR_memp_memory_TCP_PCB_base        (ADDR_memp_memory_UDP_PCB_base + \
                                              SIZE_memp_memory_UDP_PCB_base)
#define SIZE_memp_memory_TCP_PCB_base        (192*32)     // x"memp_n_tcp_pcb" param in LwIP config
#define ADDR_memp_memory_TCP_PCB_LISTEN_base (ADDR_memp_memory_TCP_PCB_base + \
                                              SIZE_memp_memory_TCP_PCB_base)
#define SIZE_memp_memory_TCP_PCB_LISTEN_base (64*8)       // x"memp_n_tcp_pcb_listen" param in LwIP config
#define ADDR_memp_memory_TCP_SEG_base        (ADDR_memp_memory_TCP_PCB_LISTEN_base + \
                                              SIZE_memp_memory_TCP_PCB_LISTEN_base)
#define SIZE_memp_memory_TCP_SEG_base        (64*1024)    // x"memp_n_tcp_seg" param in LwIP config
#define ADDR_memp_memory_REASSDATA_base      (ADDR_memp_memory_TCP_SEG_base + \
                                              SIZE_memp_memory_TCP_SEG_base)
#define SIZE_memp_memory_REASSDATA_base      (64*5)      // x"MEMP_NUM_REASSDATA" define
#define ADDR_memp_memory_FRAG_PBUF_base      (ADDR_memp_memory_REASSDATA_base + \
                                              SIZE_memp_memory_REASSDATA_base)
#define SIZE_memp_memory_FRAG_PBUF_base      (64*256)   // x"MEMP_NUM_FRAG_PBUF" define
#define ADDR_memp_memory_ARP_QUEUE_base      (ADDR_memp_memory_FRAG_PBUF_base + \
                                              SIZE_memp_memory_FRAG_PBUF_base)
#define SIZE_memp_memory_ARP_QUEUE_base      (64*30)    // x"MEMP_NUM_ARP_QUEUE" define
#define ADDR_memp_memory_PBUF_base           (ADDR_memp_memory_ARP_QUEUE_base + \
                                              SIZE_memp_memory_ARP_QUEUE_base)
#define SIZE_memp_memory_PBUF_base           (64*1024)  // x"memp_n_pbuf" param in LwIP config 
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
//                                                                         LWIP_MEM_ALIGN_SIZE(PBUF_POOL_BUFSIZE) )), PBUF_POOL_SIZE);
//- mem_init() function of mem.c:
//   xil_printf("ram_heap       size %d + %d \n", (LWIP_MEM_ALIGN_SIZE(MEM_SIZE) +
//                                             LWIP_MEM_ALIGN_SIZE(sizeof(struct mem))));

// Actual allocation function, sizes and memory fit violations are detected at compile time by zero division
#define LWIP_DECLARE_MEMORY_ALIGNED(var_name, size) \
  uint8_t* const var_name = (uint8_t*)(ADDR_##var_name / (size == SIZE_##var_name && \
                                                         (ADDR_RX_MEM_UNALLOC <= XPAR_RX_MEM_CPU_S_AXI_HIGHADDR+1) && \
                                                         (ADDR_TX_MEM_UNALLOC <= XPAR_TX_MEM_CPU_S_AXI_HIGHADDR+1)))
