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
 s= global*_ root:linea* _*{ return generateCST(root);}

global = glo:".global"_ [a-zA-Z_][a-zA-Z0-9_]* _  { return new Node("PR", glo); }
        / glo1:".section" _ { return new Node("PR", glo1); }
        / glo2:".data" _ { return new Node("PR", glo2); }
        / glo3:".text" _ { return new Node("PR", glo3); }
        / glo4:".bss" _ { return new Node("PR", glo4); }
        / reservadas _ valor

reservadas = id:".word"   { return new Node("GLOBAL", "."+id); }
        /id:".half"   { return new Node("GLOBAL", "."+id); }
        /id:".byte"   { return new Node("GLOBAL", "."+id); }
        /id:".ascii"   { return new Node("GLOBAL", "."+id); }
        /id:".asciz"   { return new Node("GLOBAL", "."+id); }
        /id:".skip"   { return new Node("GLOBAL", "."+id); }
        /id:".float"   { return new Node("GLOBAL", "."+id); }

valor = decim:[0-9]+ "." [0-9]+ { return new Node("decimal", decim); }
      / "0b" binar:[01]+ { return new Node("binario",'0b'+ binar ); }
      / ente:[0-9]+ { return new Node("entero", ente); }
      /"'" [A-Za-z]* "'"_
      /'"'[^"]*'"'_
        /id: ".space"

linea = ins:instruccion { return new Node("instruccion", ins); } 
      / comentario 
      / etiq:etiq { return new Node("etiqueta", etiq); }
      / glo:global { return new Node("etiqueta", glo); }

etiq
    = label ":" _* 

instruccion 
    = arithmetic_inst 
    / bitmanipulation_inst
    / logica_inst 
    / atomic_inst
    / branch_inst
    / cond_inst
    / loadnstore_inst
    
comentario  
    = ("//" [^\n]*) 

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
    = "bfi" _* reg64 "," _* reg64 "," _* immediate "," _* immediate
    / "bfi" _* reg32 "," _* reg32 "," _* immediate "," _* immediate

bfxil_inst
    = "bfxil" _* reg64 "," _* reg64 "," _* immediate "," _* immediate
    / "bfxil" _* reg32 "," _* reg32 "," _* immediate "," _* immediate

cls_inst
    = "cls" _* reg64 "," _* reg64 
    / "cls" _* reg32 "," _* reg32 

clz_inst
    = "clz" _* reg64 "," _* reg64 
    / "clz" _* reg32 "," _* reg32 

extr_inst
    = "extr" _* reg64 "," _* reg64 "," _* reg64 "," _* immediate
    / "extr" _* reg32 "," _* reg32 "," _* reg32 "," _* immediate

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
    = ("s"/"u") "bfiz" _* reg64 "," _* reg64 "," _* immediate "," _* immediate
    / ("s"/"u") "bfiz" _* reg32 "," _* reg32 "," _* immediate "," _* immediate

bfx_inst
    = ("s"/"u") "bfx" _* reg64 "," _* reg64 "," _* immediate "," _* immediate
    / ("s"/"u") "bfx" _* reg32 "," _* reg32 "," _* immediate "," _* immediate

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
    = "asr" _* reg64 "," _* reg64 "," _* (reg64 / immediate)
    / "asr" _* reg32 "," _* reg32 "," _* (reg32 / immediate)

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
    = "lsl" _* reg64 "," _* reg64 "," _* (reg64 / immediate)
    / "lsl" _* reg32 "," _* reg32 "," _* (reg32 / immediate)

lsr_inst
    = "lsr" _* reg64 "," _* reg64 "," _* (reg64 / immediate)
    / "lsr" _* reg32 "," _* reg32 "," _* (reg32 / immediate)

mov_inst
    = "mov" _* reg64 "," _* (reg64 / immediate)* _* 
    / "mov" _* reg32 "," _* (reg32 / immediate)* _*

movk_inst
    = "movk" _* reg64 "," _* immediate ("["entero"]"/"{"entero"}")?
    / "movk" _* reg32 "," _* immediate ("["entero"]"/"{"entero"}")?

movn_inst
    = "movn" _* reg64 "," _* immediate ("["entero"]"/"{"entero"}")?
    / "movn" _* reg32 "," _* immediate ("["entero"]"/"{"entero"}")?

movz_inst
    = "movz" _* reg64 "," _* immediate ("["entero"]"/"{"entero"}")?
    / "movz" _* reg32 "," _* immediate ("["entero"]"/"{"entero"}")?

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
    = "ror" _* reg64 "," _* reg64 "," _* (reg64 / immediate)
    / "ror" _* reg32 "," _* reg32 "," _* (reg32 / immediate)

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
    = "tbnz" _* reg64 "," _* immediate "," _* rel16
    / "tbnz" _* reg32 "," _* immediate "," _* rel16

tbz_inst
    = "tbz" _* reg64 "," _* immediate "," _* rel16
    / "tbz" _* reg32 "," _* immediate "," _* rel16

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
    = "ccmn" _* reg64 "," _* immediate "," _* immediate "," _* cc
    / "ccmn" _* reg64 "," _* reg64 "," _* immediate "," _* cc
    / "ccmn" _* reg32 "," _* immediate "," _* immediate "," _* cc
    / "ccmn" _* reg32 "," _* reg32 "," _* immediate "," _* cc

ccmp_inst
    = "ccmp" _* reg64 "," _* immediate "," _* immediate "," _* cc
    / "ccmp" _* reg64 "," _* reg64 "," _* immediate "," _* cc
    / "ccmp" _* reg32 "," _* immediate "," _* immediate "," _* cc
    / "ccmp" _* reg32 "," _* reg32 "," _* immediate "," _* cc

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


//load and store instruccion

loadnstore_inst
    = ldpsw_inst
    / ldp_inst
    / ldursbh_inst
    / ldurbh_inst
    / ldursw_inst
    / ldur_inst
    / prfm_inst
    / sturbh_inst
    / stur_inst
    / stp_inst
    / crc_inst
    / loadAlm_inst
    / system_inst


ldpsw_inst 
    = "ldpsw" _* reg64 "," _* reg64 "," _* "["addr"]"
    /"ldpsw" _* reg32 "," _* reg32 "," _* "["addr"]"

ldp_inst
    = "ldp" _* reg64 "," _* reg64 "," _* "["addr"]"

ldursbh_inst
    = "ld" ("u")? "rs" ("b"/"h") _* reg64 "," _* "["addr"]"
    / "ld" ("u")? "rs" ("b"/"h") _* reg32 "," _* "["addr"]"

ldurbh_inst
    = "ld" ("u")? "r" ("b"/"h") _* reg32 "," _* "["addr"]"

ldursw_inst
    = "ld" ("u")? "rsw"  _* reg64 "," _* "["addr"]"

ldur_inst 
    = "ld" ("u")? "r"  _* reg64 "," _* "["addr"]"
    / "ld" ("u")? "r"  _* reg32 "," _* "["addr"]"

prfm_inst
    = "prfm" reg32 "," _* addr
    / "prfm" reg64 "," _* addr

sturbh_inst
    = "st" ("u")? "r" ("b"/"h") _* reg64 "," _* "["addr"]"

stur_inst
    = "st" ("u")? "r"  _* reg64 "," _* "["addr"]"
    / "st" ("u")? "r"  _* reg32 "," _* "["addr"]"

stp_inst
    = "stp" _* reg64 "," _* reg64 "," _* "["addr"]"
    / "stp" _* reg32 "," _* reg32 "," _* "["addr"]"



addr 
    = "=" l:label
        {
            l.value = '=' + l.value;
            return [l];
        }
    / "[" _* r:reg32 _* "," _* r2:reg32 _* "," _* s:shift_op _* i2:immediate _* "]"

    / "[" _* r:reg64 _* "," _* r2:reg64 _* "," _* s:shift_op _* i2:immediate _* "]"
        
    / "[" _* r:reg64 _* "," _* i:immediate _* "," _* s:shift_op _* i2:immediate _* "]"
        {
            return [r, i, s, i2];
        }
    / "[" _* r:reg64 _* "," _* i:immediate _* "," _* e:extend_op _* "]" 
        {
            return [r, i, e];
        }
    / "[" _* r:reg64 _* "," _* i:immediate _* "]"
        {
            return [r, i];
        }
    / "[" _* r:reg64 _* "]"
        {
            return [r];
        }

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
    =   "ldnp" _* reg32 "," _* reg32 "," _* "[" immediate "]"
    /   "ldnp" _* reg64 "," _* reg64 "," _* "[" immediate "]"
LDTR_inst 
    =   "ldtr" _* reg32 "," _* "[" immediate "]"
    /   "ldtr" _* reg64 "," _* "[" immediate "]"
LDTRB_inst 
    =    "ldtrb" _* reg32 "," _* "[" immediate "]"
LDTRH_inst 
    =    "ldtrh" _* reg32 "," _* "[" immediate "]"
LDTRSB_inst
    =    "ldtrsb" _* reg32 "," _* "[" immediate "]"
    /    "ldtrsb" _* reg64 "," _* "[" immediate "]"
LDTRSH_inst
    =    "ldtrsh" _* reg32 "," _* "[" immediate "]"
    /    "ldtrsh" _* reg64 "," _* "[" immediate "]"
LDTRSW_inst
    =    "ldtrsw" _* reg64 "," _* "[" immediate "]"
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
    =   "stnp" _* reg32 "," _* reg32 "," _* "[" immediate "]"
    /   "stnp" _* reg64 "," _* reg64 "," _* "[" immediate "]"
STTR_inst
    =   "sttr" _* reg32 "," _* "[" immediate "]"
    /   "sttr" _* reg64 "," _* "[" immediate "]"
STTRB_inst
    =   "sttrb" _* reg32 "," _* "[" immediate "]"
STTRH_inst
    =   "sttrh" _* reg32 "," _* "[" immediate "]"

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
BRK_inst    = "brk" _* immediate
CLREX_inst  = "clrex" _* (immediate)?
DMB_inst    = "dmb" _* barrierop
DSB_inst    = "dsb" _* barrierop
ERET_inst   = "eret"
HVC_inst    = "hvc" _* immediate
ISB_inst    = "isb" _* ("sy")?
MRS_inst    = "mrs" _* reg64 "," _* sysreg
MSR_inst    = "msr" _* msr_rules
NOP_inst    = "nop"
SEV_inst    = "sev" 
SEVL_inst   = "sevl"
SMC_inst    = "smc" _* immediate
SVC_inst    = "svc" _* immediate
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
/   "spsel" _* "," _* immediate
/   "daifset" _* "," _* immediate
/   "daifclr" _* "," _* immediate


//-----------------------------------------------------------------------------------------------------------------
    // Definición de valores inmediatos


reg64 
    = "x" ("30" / [12][0-9] / [0-9])
    / "sp"

reg32 = "w" ("30" / [12][0-9] / [0-9])
    / "sp"

operando = reg64 / reg32 / immediate

rel16 = sign? [0-9]{1,16}
rel21 = sign? [0-9]{1,21}
rel28 = sign? [0-9]{1,28}
rel33 = sign? [0-9]{1,33}
sign = ("+" / "-")

//immediate = "#" [0-9]+
immediate "Inmediato"
    = integer
    / "#" "'"letter"'"
    / "#" "0x" hex_literal
    / "#" "0b" binary_literal
    / "#" integer


extend_op "Operador de Extensión"
    = "UXTB"i
    / "UXTH"i 
    / "UXTW"i 
    / "UXTX"i
    / "SXTB"i
    / "SXTH"i
    / "SXTW"i 
    / "SXTX"i

integer 
    = [0-9]+


shift_op "Operador de Desplazamiento"
    = "LSL"i
    / "LSR"i
    / "ASR"i

label "Etiqueta"
    = [a-zA-Z_][a-zA-Z0-9_]*

letter
    = [a-zA-Z] 

binary_literal
  = [01]+ // Representa uno o más dígitos binarios
hex_literal
    = [0-9a-fA-F]+ // Representa uno o más dígitos hexadecimales

entero = [0-9]+

_ = [ \t\n\r]
