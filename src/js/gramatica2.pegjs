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

reg64 = "x" ("30" / [12][0-9] / [0-9])
reg32 = "w" ("30" / [12][0-9] / [0-9])

operando = reg64 / reg32 / inmediate

rel21 = sign? [0-9]{1,21}
rel33 = sign? [0-9]{1,33}
sign = ("+" / "-")

inmediate = "#" [0-9]+

_ = [ \t\n\r]
