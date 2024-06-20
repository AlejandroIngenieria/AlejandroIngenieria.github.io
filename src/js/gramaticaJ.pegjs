{
class Node {
  constructor(value, left = null, right = null) {
    this.value = value;
    this.left = left;
    this.right = right;
  }
}


function generateCST(root) {
  return new Node("Program", root);
}


}

// Grammar
 s= root:linea* _ { return generateCST(root);}

linea = ins:instruccion { return new Node("instruccion", ins); }

instruccion 
    = crc_inst
    / loadAlm_inst
    / system_inst


/* -------------------------------------------------------------------------- */
/*                    Instrucciones de suma de comprobacion                   */
/* -------------------------------------------------------------------------- */

crc_inst
    = CRC32B_inst
    / CRC32H_inst
    / CRC32W_inst
    / CRC32X_inst
    / CRC32CB_inst
    / CRC32CH_inst
    / CRC32CW_inst
    / CRC32CX_inst


CRC32B_inst = "crc32b" _* reg32 "," _* reg32 "," _* reg32
CRC32H_inst = "crc32h" _* reg32 "," _* reg32 "," _* reg32
CRC32W_inst = "crc32w" _* reg32 "," _* reg32 "," _* reg32
CRC32X_inst = "crc32x" _* reg32 "," _* reg32 "," _* reg64
CRC32CB_inst = "crc32cb" _* reg32 "," _* reg32 "," _* reg32
CRC32CH_inst = "crc32ch" _* reg32 "," _* reg32 "," _* reg32
CRC32CW_inst = "crc32cw" _* reg32 "," _* reg32 "," _* reg32
CRC32CX_inst = "crc32cx" _* reg32 "," _* reg32 "," _* reg64


/* -------------------------------------------------------------------------- */
/*            Instrucciones de carga y almacenamiento con atributos           */
/* -------------------------------------------------------------------------- */
loadAlm_inst
    =   LDAXP_inst
    /   LDAXR_inst
    /   LDAXRB_inst
    /   LDAXRH_inst
    /   LDNP_inst
    /   LDTR_inst
    /   LDTRB_inst
    /   LDTRH_inst
    /   LDTRSB_inst
    /   LDTRSH_inst
    /   LDTRSW_inst
    /   STLR_inst
    /   STLRB_inst
    /   STLRH_inst
    /   STLXP_inst
    /   STLXR_inst
    /   STLXRB_inst
    /   STLXRH_inst
    /   STNP_inst
    /   STTR_inst
    /   STTRB_inst
    /   STTRH_inst

LDAXP_inst 
    =   "ldaxp" _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "ldaxp" _* reg64 "," _* reg64 "," _* "[" reg64 "]"
LDAXR_inst 
    =   "ldaxr" _* reg32 "," _* "[" reg64 "]"
    /   "ldaxr" _* reg64 "," _* "[" reg64 "]"
LDAXRB_inst 
    =    "ldaxrb" _* reg32 "," _* "[" reg64 "]"
LDAXRH_inst 
    =    "ldaxrh" _* reg32 "," _* "[" reg64 "]"
LDNP_inst 
    =   "ldnp" _* reg32 "," _* reg32 "," _* "[" inmediate "]"
    /   "ldnp" _* reg64 "," _* reg64 "," _* "[" inmediate "]"
LDTR_inst 
    =   "ldtr" _* reg32 "," _* "[" inmediate "]"
    /   "ldtr" _* reg64 "," _* "[" inmediate "]"
LDTRB_inst 
    =    "ldtrb" _* reg32 "," _* "[" inmediate "]"
LDTRH_inst 
    =    "ldtrh" _* reg32 "," _* "[" inmediate "]"
LDTRSB_inst
    =    "ldtrsb" _* reg32 "," _* "[" inmediate "]"
    /    "ldtrsb" _* reg64 "," _* "[" inmediate "]"
LDTRSH_inst
    =    "ldtrsh" _* reg32 "," _* "[" inmediate "]"
    /    "ldtrsh" _* reg64 "," _* "[" inmediate "]"
LDTRSW_inst
    =    "ldtrsw" _* reg64 "," _* "[" inmediate "]"
STLR_inst
    =   "stlr" _* reg32 "," _* "[" reg64 "]"
    /   "stlr" _* reg64 "," _* "[" reg64 "]"
STLRB_inst
    =   "stlrb" _* reg32 "," _* "[" reg64 "]"
STLRH_inst
    =   "stlrh" _* reg32 "," _* "[" reg64 "]"
STLXP_inst
    =   "stlxp" _* reg32 "," _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "stlxp" _* reg32 "," _* reg64 "," _* reg64 "," _* "[" reg64 "]"
STLXR_inst
    =   "stlxr" _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "stlxr" _* reg32 "," _* reg64 "," _* "[" reg64 "]"
STLXRB_inst
    =   "stlxrb" _* reg32 "," _* reg32 "," _* "[" reg64 "]"
STLXRH_inst
    =   "stlxrh" _* reg32 "," _* reg32 "," _* "[" reg64 "]"
STNP_inst
    =   "stnp" _* reg32 "," _* reg32 "," _* "[" inmediate "]"
    /   "stnp" _* reg64 "," _* reg64 "," _* "[" inmediate "]"
STTR_inst
    =   "sttr" _* reg32 "," _* "[" inmediate "]"
    /   "sttr" _* reg64 "," _* "[" inmediate "]"
STTRB_inst
    =   "sttrb" _* reg32 "," _* "[" inmediate "]"
STTRH_inst
    =   "sttrh" _* reg32 "," _* "[" inmediate "]"


/* -------------------------------------------------------------------------- */
/*                            Codigos de condicion                            */
/* -------------------------------------------------------------------------- */
conditional_inst 
    = "eq"
    / "ne"
    / "cs"
    / "hs"
    / "cc"
    / "lo"
    / "mi"
    / "pl"
    / "vs"
    / "vc"
    / "hi"
    / "ls"
    / "ge"
    / "lt"
    / "gt"
    / "le"
    / "al"

/* -------------------------------------------------------------------------- */
/*                          Instrucciones al sistema                          */
/* -------------------------------------------------------------------------- */
system_inst
=   AT_inst 
/   BRK_inst
/   CLREX_inst
/   DMB_inst
/   DSB_inst
/   ERET_inst
/   HVC_inst 
/   ISB_inst
/   MRS_inst
/   MSR_inst
/   NOP_inst
/   SEV_inst
/   SEVL_inst
/   SMC_inst
/   SVC_inst
/   WFE_inst
/   WFI_inst
/   YIELD_inst


AT_inst     = "at" _* at_operation "," _* reg64
BRK_inst    = "brk" _* inmediate
CLREX_inst  = "clrex" _* (inmediate)?
DMB_inst    = "dmb" _* barrierop
DSB_inst    = "dsb" _* barrierop
ERET_inst   = "eret"
HVC_inst    = "hvc" _* inmediate
ISB_inst    = "isb" _* ("sy")?
MRS_inst    = "mrs" _* reg64 "," _* sysreg
MSR_inst    = "msr" _* msr_rules
NOP_inst    = "nop"
SEV_inst    = "sev" 
SEVL_inst   = "sevl"
SMC_inst    = "smc" _* inmediate
SVC_inst    = "svc" _* inmediate
WFE_inst    = "wfe"
WFI_inst    = "wfi" 
YIELD_inst  = "yield" 

at_operation
=   "s1e1r"
/   "s1e1w"
/   "s1e0r"
/   "s1e0w"
/   "s1e2r"
/   "s1e2w"
/   "s1e3r"
/   "s1e3w"
/   "s12e1r"
/   "s12e1w"

barrierop
=   "sy"
/   "ish"
/   "ishst"
/   "nsh"
/   "nshst"
/   "osh"
/   "oshst"

sysreg
=   "sctlr"
/   "actlr"
/   "cpacr"
/   "scr"
/   "sder"
/   "nsacr"
/   "ttbr0"
/   "ttbr1"
/   "tcr"
/   "mair0"
/   "mair1"
/   "vbar"
/   "isr"
/   "fpcr"
/   "fpsr"
/   "dspsr"
/   "dfsr"
/   "elr_elx"
/   "sp_elx"
/   "nzcv"


msr_rules
=   sysreg "," _* reg64
/   "spsel" _* "," _* inmediate
/   "daifset" _* "," _* inmediate
/   "daifclr" _* "," _* inmediate

reg64 = "x" ("30" / [12][0-9] / [0-9])
reg32 = "w" ("30" / [12][0-9] / [0-9])

operando = reg64 / reg32 / inmediate

rel21 = sign? [0-9]{1,21}
rel33 = sign? [0-9]{1,33}
sign = ("+" / "-")

inmediate = "#" [0-9]+

_ = [ \t\n\r]
