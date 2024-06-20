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
    = arithmetic_inst 
    / bitmanipulation_inst
    / logica_inst 
    / atomic_inst
    / branch_inst
    /cond_inst

arithmetic_inst 
    = adc_inst
     /add_inst
     /adr_inst
     /adrp_inst
     /cmn_inst
     /cmp_inst
     /madd_inst
     /mneg_inst
     /msub_inst
     /mul_inst
     /neg_inst
     /ngc_inst
     /sbc_inst
     /sdiv_inst
     /smaddl_inst
     /smnegl_inst
     /smsubl_inst
     /smulh_inst
     /smull_inst
     /sub_inst
     /udiv_inst
     /umaddl_inst
     /umnegl_inst
     /umsubl_inst
     /umulh_inst
     /umull_inst

//Instrucciones Aritmeticas
adc_inst 
    = "adc" ("s")? _* reg64 "," _* reg64 "," _* reg64
     /"adc" ("s")? _* reg32 "," _* reg32 "," _* reg32

add_inst 
    = "add" ("s")? _* reg64 "," _* reg64 "," _* operando
    / "add" ("s")? _* reg32 "," _* reg32 "," _* operando
adr_inst
    = "adr" _* reg64 "," _* rel21

adrp_inst 
    = "adrp" _* reg64 "," _* rel33

cmn_inst
    = "cmn" _* reg64 "," _* operando
    / "cmn" _* reg32 "," _* operando

cmp_inst
    = "cmp" _* reg64 "," _* operando
    / "cmp" _* reg32 "," _* operando

madd_inst   
    = "madd" _* reg64 "," _* reg64 "," _* reg64 "," _* reg64 
    / "madd" _* reg32 "," _* reg32 "," _* reg32 "," _* reg32 

mneg_inst
    = "mneg" _* reg64 "," _* reg64 "," _* reg64
    / "mneg" _* reg32 "," _* reg32 "," _* reg32

msub_inst
    = "msub" _* reg64 "," _* reg64 "," _* reg64 "," _* reg64 
    / "msub" _* reg32 "," _* reg32 "," _* reg32 "," _* reg32 

mul_inst
    = "mul" _* reg64 "," _* reg64 "," _* reg64 
    / "mul" _* reg32 "," _* reg32 "," _* reg32

neg_inst
    = "neg" ("s")? _* reg64 "," _* operando
    / "neg" ("s")? _* reg32 "," _* operando

ngc_inst
    = "ngc" ("s")? _* reg64 "," _* reg64
    / "ngc" ("s")? _* reg32 "," _* reg32

sbc_inst
    = "sbc" ("s")? _* reg64 "," _* reg64 "," _* reg64 
    / "sbc" ("s")? _* reg32 "," _* reg32 "," _* reg32

sdiv_inst
    = "sdiv" _* reg64 "," _* reg64 "," _* reg64 
    / "sdiv" _* reg32 "," _* reg32 "," _* reg32

smaddl_inst
    = "smaddl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64

smnegl_inst
    = "smnegl" _* reg64 "," _* reg32 "," _* reg32

smsubl_inst
    = "smsubl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64

smulh_inst
    = "smulh" _* reg64 "," _* reg64 "," _* reg64 

smull_inst
    = "smull" _* reg64 "," _* reg32 "," _* reg32 

sub_inst
    = "sub" ("s")? _* reg64 "," _* reg64 "," _* operando
    / "sub" ("s")? _* reg32 "," _* reg32 "," _* operando

udiv_inst
    = "udiv" _* reg64 "," _* reg64 "," _* reg64 
    / "udiv" _* reg32 "," _* reg32 "," _* reg32

umaddl_inst
    = "umaddl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64

umnegl_inst
    = "umnegl" _* reg64 "," _* reg32 "," _* reg32

umsubl_inst
    = "umsubl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64

umulh_inst
    = "umulh" _* reg64 "," _* reg64 "," _* reg64 

umull_inst
    = "umull" _* reg64 "," _* reg32 "," _* reg32

bitmanipulation_inst
    =bfi_inst
    /bfxil_inst
    /cls_inst
    /clz_inst
    /extr_inst
    /rbit_inst
    /rev_inst
    /rev16_inst
    /rev32_inst
    /bfiz_inst
    /bfx_inst
    /xt_inst
//instruccion de manipulacion de bit
bfi_inst
    = "bfi" _* reg64 "," _* reg64 "," _* inmediate "," _* inmediate
    / "bfi" _* reg32 "," _* reg32 "," _* inmediate "," _* inmediate

bfxil_inst
    = "bfxil" _* reg64 "," _* reg64 "," _* inmediate "," _* inmediate
    / "bfxil" _* reg32 "," _* reg32 "," _* inmediate "," _* inmediate

cls_inst
    = "cls" _* reg64 "," _* reg64 
    / "cls" _* reg32 "," _* reg32 

clz_inst
    = "clz" _* reg64 "," _* reg64 
    / "clz" _* reg32 "," _* reg32 

extr_inst
    = "extr" _* reg64 "," _* reg64 "," _* reg64 "," _* inmediate
    / "extr" _* reg32 "," _* reg32 "," _* reg32 "," _* inmediate

rbit_inst
    = "rbit" _* reg64 "," _* reg64 
    / "rbit" _* reg32 "," _* reg32 

rev_inst
    = "rev" _* reg64 "," _* reg64 
    / "rev" _* reg32 "," _* reg32 

rev16_inst
    = "rev16" _* reg64 "," _* reg64 
    / "rev16" _* reg32 "," _* reg32 

rev32_inst
    = "rev32" _* reg64 "," _* reg64 

bfiz_inst
    = ("s"/"u") "bfiz" _* reg64 "," _* reg64 "," _* inmediate "," _* inmediate
    / ("s"/"u") "bfiz" _* reg32 "," _* reg32 "," _* inmediate "," _* inmediate

bfx_inst
    = ("s"/"u") "bfx" _* reg64 "," _* reg64 "," _* inmediate "," _* inmediate
    / ("s"/"u") "bfx" _* reg32 "," _* reg32 "," _* inmediate "," _* inmediate

xt_inst
    = ("s"/"u") "xt" ("b"/"h")? _* reg64 "," _* reg32
    / ("s"/"u") "xt" ("b"/"h")? _* reg32 "," _* reg32

//instrucciones logicas
logica_inst 
    = and_inst
    / asr_inst
    / bic_inst
    / eon_inst
    / eor_inst
    / lsl_inst
    / lsr_inst
    / movk_inst
    / movn_inst
    / movz_inst
    / mov_inst
    / mvn_inst
    / orn_inst
    / orr_inst
    / ror_inst
    / tst_inst

and_inst
    = "and" ("s")? _* reg64 "," _* reg64 "," _* operando
    / "and" ("s")? _* reg32 "," _* reg32 "," _* operando

asr_inst
    = "asr" _* reg64 "," _* reg64 "," _* (reg64 / inmediate)
    / "asr" _* reg32 "," _* reg32 "," _* (reg32 / inmediate)

bic_inst
    = "bic" ("s")? _* reg64 "," _* reg64 "," _* operando
    / "bic" ("s")? _* reg32 "," _* reg32 "," _* operando

eon_inst
    = "eon" _* reg64 "," _* reg64 "," _* operando
    / "eon" _* reg32 "," _* reg32 "," _* operando

eor_inst
    = "eor" _* reg64 "," _* reg64 "," _* operando
    / "eor" _* reg32 "," _* reg32 "," _* operando

lsl_inst
    = "lsl" _* reg64 "," _* reg64 "," _* (reg64 / inmediate)
    / "lsl" _* reg32 "," _* reg32 "," _* (reg32 / inmediate)

lsr_inst
    = "lsr" _* reg64 "," _* reg64 "," _* (reg64 / inmediate)
    / "lsr" _* reg32 "," _* reg32 "," _* (reg32 / inmediate)

mov_inst
    = "mov" _* reg64 "," _* (reg64 / inmediate)
    / "mov" _* reg32 "," _* (reg32 / inmediate)

movk_inst
    = "movk" _* reg64 "," _* inmediate ("["entero"]"/"{"entero"}")?
    / "movk" _* reg32 "," _* inmediate ("["entero"]"/"{"entero"}")?

movn_inst
    = "movn" _* reg64 "," _* inmediate ("["entero"]"/"{"entero"}")?
    / "movn" _* reg32 "," _* inmediate ("["entero"]"/"{"entero"}")?

movz_inst
    = "movz" _* reg64 "," _* inmediate ("["entero"]"/"{"entero"}")?
    / "movz" _* reg32 "," _* inmediate ("["entero"]"/"{"entero"}")?

mvn_inst
    = "mvn" _* reg64 "," _* operando
    / "mvn" _* reg32 "," _* operando

orn_inst
    = "orn" _* reg64 "," _* reg64 "," _* operando
    / "orn" _* reg32 "," _* reg32 "," _* operando

orr_inst
    = "orr" _* reg64 "," _* reg64 "," _* operando
    / "orr" _* reg32 "," _* reg32 "," _* operando   

ror_inst
    = "ror" _* reg64 "," _* reg64 "," _* (reg64 / inmediate)
    / "ror" _* reg32 "," _* reg32 "," _* (reg32 / inmediate)

tst_inst
    = "tst" _* reg64 "," _* reg64 "," _* operando
    / "tst" _* reg32 "," _* reg32 "," _* operando


// instrucciones branch
branch_inst
    = bcc_inst
    / blr_inst 
    / bl_inst 
    / br_inst
    / b_inst
    / cbnz_inst
    / cbz_inst
    / ret_inst
    / tbnz_inst
    / tbz_inst

b_inst 
    = "b" _* rel28

bcc_inst
    = "bcc" _* rel21

bl_inst 
    = "bl" _* rel28

blr_inst    
    = "blr" _* reg64

br_inst 
    = "br" _* reg64

cbnz_inst
    = "cbnz" _* reg64 "," _* rel21
    / "cbnz" _* reg32 "," _* rel21

cbz_inst
    = "cbz" _* reg64 "," _* rel21
    / "cbz" _* reg32 "," _* rel21

ret_inst 
    = "ret" _* "{" reg64 "}"

tbnz_inst
    = "tbnz" _* reg64 "," _* inmediate "," _* rel16
    / "tbnz" _* reg32 "," _* inmediate "," _* rel16

tbz_inst
    = "tbz" _* reg64 "," _* inmediate "," _* rel16
    / "tbz" _* reg32 "," _* inmediate "," _* rel16

// instrucciones atomic
atomic_inst
    = cas_inst
    / ldao_inst
    / stao_inst
    / swp_inst

cas_inst
    = "cas" ("a"/"l")? ("b"/"h") _* reg32 "," _* reg32 "," _* "["reg64"]"
    /"cas" ("a"/"l")? "p" _* reg64 "," _* reg64 "," _* reg64 "," _* reg64 "," "["reg64"]"
    / "cas" ("a"/"l")? "p" _* reg32 "," _* reg32 "," _* reg32 "," _* reg32 "," "["reg64"]"
    / "cas" ("a"/"l")? _* reg64 "," _* reg64 "," _* "["reg64"]"
    / "cas" ("a"/"l")? _* reg32 "," _* reg32 "," _* "["reg64"]"

ldao_inst
    = "ldao" ("a"/"l")? ("b"/"h") _* reg32 "," _* reg32 "," _* "["reg64"]"
    / "ldao" ("a"/"l")? _* reg64 "," _* reg64 "," _* "["reg64"]"
    / "ldao" ("a"/"l")? _* reg32 "," _* reg32 "," _* "["reg64"]"

stao_inst
    = "stao" ("a"/"l")? ("b"/"h") _* reg32 ","  _* "["reg64"]"
    / "stao" ("a"/"l")? _* reg64 "," _* reg64 "," _* "["reg64"]"
    / "stao" ("a"/"l")? _* reg32 "," _* reg32 "," _* "["reg64"]"

swp_inst
    = "swp" ("a"/"l")? ("b"/"h") _* reg32 "," _* reg32 "," _* "["reg64"]"
    / "swp" ("a"/"l")? _* reg64 "," _* reg64 "," _* "["reg64"]"
    / "swp" ("a"/"l")? _* reg32 "," _* reg32 "," _* "["reg64"]"

//instrucciones condicionales
cond_inst
    = ccmn_inst
    / ccmp_inst
    / cinc_inst
    / cinv_inst
    / cneg_inst
    / csel_inst
    / cset_inst
    / csetm_inst
    / csinc_inst
    / csinv_inst
    / csneg_inst
ccmn_inst
    = "ccmn" _* reg64 "," _* inmediate "," _* inmediate "," _* cc
    / "ccmn" _* reg64 "," _* reg64 "," _* inmediate "," _* cc
    / "ccmn" _* reg32 "," _* inmediate "," _* inmediate "," _* cc
    / "ccmn" _* reg32 "," _* reg32 "," _* inmediate "," _* cc

ccmp_inst
    = "ccmp" _* reg64 "," _* inmediate "," _* inmediate "," _* cc
    / "ccmp" _* reg64 "," _* reg64 "," _* inmediate "," _* cc
    / "ccmp" _* reg32 "," _* inmediate "," _* inmediate "," _* cc
    / "ccmp" _* reg32 "," _* reg32 "," _* inmediate "," _* cc

cinc_inst
    = "cinc" _* reg64 "," _* reg64 "," _* cc
    / "cinc" _* reg32 "," _* reg32 "," _* cc

cinv_inst
    = "cinv" _* reg64 "," _* reg64 "," _* cc
    / "cinv" _* reg32 "," _* reg32 "," _* cc

cneg_inst
    = "cneg" _* reg64 "," _* reg64 "," _* cc
    / "cneg" _* reg32 "," _* reg32 "," _* cc

csel_inst
    = "csel" _* reg64 "," _* reg64 "," _* reg64 "," _* cc
    / "csel" _* reg32 "," _* reg32 "," _* reg32 "," _* cc

cset_inst
    = "cset" _* reg64 "," _* cc
    / "cset" _* reg32 "," _* cc

csetm_inst
    = "csetm" _* reg64 "," _* cc
    / "csetm" _* reg32 "," _* cc

csinc_inst
    = "csinc" _* reg64 "," _* reg64 "," _* reg64 "," _* cc
    / "csinc" _* reg32 "," _* reg32 "," _* reg32 "," _* cc

csinv_inst
    = "csinv" _* reg64 "," _* reg64 "," _* reg64 "," _* cc
    / "csinv" _* reg32 "," _* reg32 "," _* reg32 "," _* cc

csneg_inst
    = "csneg" _* reg64 "," _* reg64 "," _* reg64 "," _* cc
    / "csneg" _* reg32 "," _* reg32 "," _* reg32 "," _* cc

cc = "eq"
    / "ne"
    / "hs"
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

reg64 = "x" ("30" / [12][0-9] / [0-9])
reg32 = "w" ("30" / [12][0-9] / [0-9])

operando = reg64 / reg32 / inmediate

rel16 = sign? [0-9]{1,16}
rel21 = sign? [0-9]{1,21}
rel28 = sign? [0-9]{1,28}
rel33 = sign? [0-9]{1,33}
sign = ("+" / "-")

inmediate = "#" [0-9]+
entero = [0-9]+

_ = [ \t\n\r]
