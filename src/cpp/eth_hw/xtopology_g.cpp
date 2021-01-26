#include "netif/xtopology.h"
#include "xparameters.h"

// From xtopology.h:
// enum xemac_types { xemac_type_unknown = -1, xemac_type_xps_emaclite, xemac_type_xps_ll_temac, xemac_type_axi_ethernet, xemac_type_emacps };
// struct xtopology_t {
// 	unsigned emac_baseaddr;
// 	enum xemac_types emac_type;
// 	unsigned intc_baseaddr;
// 	unsigned intc_emac_intr;	// valid only for xemac_type_xps_emaclite
// 	unsigned scugic_baseaddr;   // valid only for Zynq
// 	unsigned scugic_emac_intr;  // valid only for GEM
// };

struct xtopology_t xtopology[] = {
	{
		XPAR_ETH100GB_BASEADDR,
		xemac_type_axi_ethernet,
		XPAR_INTC_0_BASEADDR,
		XPAR_INTC_0_EMACLITE_0_VEC_ID,
		0x0,
		0x0,
	},
};

int xtopology_n_emacs = 1;
