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
 s= global* _* root:linea* _* { return generateCST(root); }

global = glo:".global"_ [a-zA-Z_][a-zA-Z0-9_]*  { return new Node("PR", glo); }
        / glo1:".section"  { return new Node("PR", glo1); }
        / glo2:".data"  { return new Node("PR", glo2); }
        / glo3:".text"  { return new Node("PR", glo3); }
        / glo4:".bss"  { return new Node("PR", glo4); }
        / reservadas _* valor 

reservadas = id:".word"   { return new Node("GLOBAL", "."+id); }
        /id:".half"   { return new Node("GLOBAL", "."+id); }
        /id:".byte"   { return new Node("GLOBAL", "."+id); }
        /id:".ascii"   { return new Node("GLOBAL", "."+id); }
        / id:".asciz"   { return new Node("GLOBAL", "."+id); }
        /id:".skip"   { return new Node("GLOBAL", "."+id); }
        /id:".float"   { return new Node("GLOBAL", "."+id); }
        / ".space"
        
        

valor = decim:[0-9]+ "." [0-9]+ { return new Node("decimal", decim); }
      / "0b" binar:[01]+ { return new Node("binario",'0b'+ binar ); }
      / ente:[0-9]+ { return new Node("entero", ente); }
      /"'" val:[A-Za-z]* "'" { return new Node("valor", val); }
      /'"' val:[^"]*'"'  { return new Node("valor", val); }//que es esto ?-----------------------------
      /id: ".space"  { return new Node("valor", id); }

linea = glo:global _* { return new Node("global", glo);}
	  / ins:instruccion _*{ return new Node("instruccion", ins);}
	  / comentario _* 
      / etiq:etiq _* { return new Node("etiqueta", etiq);}

comentario  
    = ("//" [^\n]*) 
    
etiq
    = ins:label ":" _* { return new Node("label", ins);}

instruccion 
    = ari:arithmetic_inst _* { return new Node("arithmetic_inst", ari);}
    / bitman:bitmanipulation_inst _* { return new Node("bitmanipulation_inst", bitman);}
    / logi:logica_inst _* { return new Node("logica_inst", logi);}
    / atom:atomic_inst _* { return new Node("atomic_inst", atom);}
    / bran:branch_inst _* { return new Node("branch_inst", bran);}
    / cond:cond_inst _* { return new Node("cond_inst", cond);}
    / load:loadnstore_inst _* { return new Node("loadnstore_inst", load);}
    / inst:instSalto _* { return new Node("instSalto", inst);}
    
instSalto = b1:"beq" _* label { return new Node("beq", b1);}
          / b2:"bne" _* label { return new Node("bne", b2);}
          / b3:"bgt" _* label { return new Node("bgt", b3);}
          / b4:"blt" _* label { return new Node("blt", b4);}
          / b5:"bl" _* label  { return new Node("bl", b5);}
          / b6:"b" _* label   { return new Node("b", b6);}
          / b7:"ret" _* label  { return new Node("ret", b7);}
          
arithmetic_inst 
    = adc:adc_inst  { return new Node("adc_inst", adc);}
     /add:add_inst  { return new Node("add_inst", add);}
     /adr:adr_inst  { return new Node("adr_inst", adr);}
     /adrp:adrp_inst  { return new Node("adrp_inst", adrp);}
     /cmn:cmn_inst  { return new Node("cmn_inst", cmn);}
     /cmp:cmp_inst  { return new Node("cmp_inst", cmp);}
     /madd:madd_inst  { return new Node("madd_inst", madd);}
     /mneg:mneg_inst  { return new Node("mneg_inst", mneg);}
     /msub:msub_inst  { return new Node("msub_inst", msub);}
     /mul:mul_inst  { return new Node("mul_inst", mul);}
     /neg:neg_inst  { return new Node("neg_inst", neg);}
     /ngc:ngc_inst  { return new Node("ngc_inst", ngc);}
     /sbc:sbc_inst  { return new Node("sbc_inst", sbc);}
     /sdiv:sdiv_inst  { return new Node("sdiv_inst", sdiv);}
     /smadd:smaddl_inst  { return new Node("smaddl_inst", smadd);}
     /smnegl:smnegl_inst  { return new Node("smnegl_inst", smnegl);}
     /smsubl:smsubl_inst  { return new Node("smsubl_inst", smsubl);}
     /smulh:smulh_inst  { return new Node("smulh_inst", smulh);}
     /smull:smull_inst  { return new Node("smull_inst", smull);}
     /sub:sub_inst  { return new Node("sub_inst", sub);}
     /udiv:udiv_inst  { return new Node("udiv_inst", udiv);}
     /umaddl:umaddl_inst  { return new Node("umaddl_inst", umaddl);}
     /umnegl:umnegl_inst  { return new Node("umnegl_inst", umnegl);}
     /umsubl:umsubl_inst  { return new Node("umsubl_inst", umsubl);}
     /umulh:umulh_inst  { return new Node("umulh_inst", umulh);}
     /umull:umull_inst  { return new Node("umull_inst", umull);}


//Instrucciones Aritmeticas
adc_inst 
    = "adc" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return new Node( r1, r2 , r3);}
     /"adc" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return new Node( r4, r5, r6);}

add_inst 
    = "add" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return new Node(  r1, r2 , r3);}
    / "add" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:operando { return new Node( r4, r5, r6);}
adr_inst
    = "adr" _* r5:reg64 "," _* r6:rel21 { return new Node( "adr", r5, r6);}

adrp_inst 
    = "adrp" _* r5:reg64 "," _* r6:rel33 { return new Node( "adrp", r5, r6);}

cmn_inst
    = "cmn" _* r3:reg64 "," _* r2:operando { return new Node( "cmn", r3, r2);}
    / "cmn" _* r5:reg32 "," _* r6:operando { return new Node( "cmn", r5, r6);}

cmp_inst
    = "cmp" _* r5:reg64 "," _* r6:operando { return new Node( "cmp", r5, r6);}
    / "cmp" _* r7:reg32 "," _* r8:operando { return new Node( "cmp", r7, r8);}

madd_inst   
    = "madd" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64  { return new Node( "madd", r1+","+r2 , r3+","+r4);}
    / "madd" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  { return new Node( "madd", r5+","+r6 , r7+","+r8);}

mneg_inst
    = "mneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return new Node( r1, r2, r3);}
    / "mneg" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return new Node( r4, r5, r6);}

msub_inst
    = "msub" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64 { return new Node( "msub", r1+","+r2 , r3+","+r4);}
    / "msub" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  { return new Node( "madd", r5+","+r6 , r7+","+r8);}

mul_inst
    = "mul"  _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64{ return new Node( r1, r2, r3);}
    / "mul"_* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return new Node( r4, r5, r6);}

neg_inst
    = "neg" ("s")? _* reg64 "," _* operando { return new Node(  "neg", r2 , r3);} // aca me quede ---------------------------------
    / "neg" ("s")? _* reg32 "," _* operando { return new Node(  "neg", r2 , r3);}

ngc_inst
    = "ngc" ("s")? _* reg64 "," _* reg64 { return new Node( r4, r5, r6);}
    / "ngc" ("s")? _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

sbc_inst
    = "sbc" ("s")? _* reg64 "," _* reg64 "," _* reg64  { return new Node( r4, r5, r6);}
    / "sbc" ("s")? _* reg32 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

sdiv_inst
    = "sdiv" _* reg64 "," _* reg64 "," _* reg64 { return new Node( r4, r5, r6);}
    / "sdiv" _* reg32 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

smaddl_inst
    = "smaddl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64 { return new Node( r4, r5, r6);}

smnegl_inst
    = "smnegl" _* reg64 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

smsubl_inst
    = "smsubl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64 { return new Node( r4, r5, r6);}

smulh_inst
    = "smulh" _* reg64 "," _* reg64 "," _* reg64  { return new Node( r4, r5, r6);}

smull_inst
    = "smull" _* reg64 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

sub_inst
    = "sub" ("s")? _* reg64 "," _* reg64 "," _* operando { return new Node( r4, r5, r6);}
    / "sub" ("s")? _* reg32 "," _* reg32 "," _* operando { return new Node( r4, r5, r6);}

udiv_inst
    = "udiv" _* reg64 "," _* reg64 "," _* reg64 { return new Node( r4, r5, r6);}
    / "udiv" _* reg32 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

umaddl_inst
    = "umaddl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64 { return new Node( r4, r5, r6);}

umnegl_inst 
    = "umnegl" _* reg64 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

umsubl_inst
    = "umsubl" _* reg64 "," _* reg32 "," _* reg32 "," _* reg64 { return new Node( r4, r5, r6);}

umulh_inst
    = "umulh" _* reg64 "," _* reg64 "," _* reg64 { return new Node( r4, r5, r6);}

umull_inst
    = "umull" _* reg64 "," _* reg32 "," _* reg32 { return new Node( r4, r5, r6);}

bitmanipulation_inst
    = bfi:bfi_inst  { return new Node("bfi_inst", bfi);}
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
    = "bfi" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate { return new Node( "bfi", r1+","+r2 , r3+","+r4);}
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
    = and:and_inst { return new Node("and_inst", and);}
    / asr:asr_inst { return new Node("asr_inst", asr);}
    / bic:bic_inst { return new Node("bic_inst", bic);}
    / eon:eon_inst { return new Node("eon_inst", eon);}
    / eor:eor_inst { return new Node("eor_inst", eor);}
    / lsl:lsl_inst { return new Node("lsl_inst", lsl);}
    / lsr:lsr_inst { return new Node("lsr_inst", lsr);}
    / movk:movk_inst { return new Node("movk_inst", movk);}
    / movn:movn_inst { return new Node("movn_inst", movn);}
    / movz:movz_inst { return new Node("movz_inst", movz);}
    / mov:mov_inst { return new Node("mov_inst", mov);}
    / mvn:mvn_inst { return new Node("mvn_inst", mvn);}
    / orn:orn_inst { return new Node("orn_inst", orn);}
    / orr:orr_inst { return new Node("orr_inst", orr);}
    / ror:ror_inst { return new Node("ror_inst", ror);}
    / tst:tst_inst { return new Node("tst_inst", tst);}

and_inst
    = "and" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return new Node( r1, r2, r3);}
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
    = "mov" _* reg64 "," _* (reg64 / immediate)*  
    / "mov" _* reg32 "," _* (reg32 / immediate)* 

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
    = bcc:bcc_inst { return new Node("bcc_inst", bcc);}
    / blr:blr_inst { return new Node("blr_inst", blr);}
    / bl:bl_inst  { return new Node("bl_inst", bl);}
    / br:br_inst { return new Node("br_inst", br);}
    / b:b_inst { return new Node("b_inst", b);}
    / cbnz:cbnz_inst { return new Node("cbnz_inst", cbnz);}
    / cbz:cbz_inst { return new Node("cbz_inst", cbz);}
    / ret:ret_inst { return new Node("ret_inst", ret);}
    / tbnz:tbnz_inst { return new Node("tbnz_inst", tbnz);}
    / tbz:tbz_inst { return new Node("tbz_inst", tbz);}

b_inst 
    = "b" _* r1:rel28 { return new Node( "b", r1);}

bcc_inst
    = "bcc" _* r1:rel21 { return new Node("bcc", r1);}

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
    = cas:cas_inst { return new Node("cas_inst", cas);}
    / ldao:ldao_inst { return new Node("ldao_inst", ldao);}
    / stao:stao_inst { return new Node("stao_inst", stao);}
    / swp:swp_inst { return new Node("swp_inst", swp);}

cas_inst
    = "cas" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64"]" { return new Node( r1, r2, r3);}
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
    = ccmn:ccmn_inst { return new Node("ccmn_inst", ccmn);}
    / ccmp:ccmp_inst { return new Node("ccmp_inst", ccmp);}
    / cinc:cinc_inst { return new Node("cinc_inst", cinc);}
    / cinv:cinv_inst { return new Node("cinv_inst", cinv);}
    / cneg:cneg_inst { return new Node("cneg_inst", cneg);}
    / csel:csel_inst { return new Node("csel_inst", csel);}
    / cset:cset_inst { return new Node("cset_inst", cset);}
    / csetm:csetm_inst { return new Node("csetm_inst", csetm);}
    / csinc:csinc_inst { return new Node("csinc_inst", csinc);}
    / csinv:csinv_inst { return new Node("csinv_inst", csinv);}
    / csneg:csneg_inst { return new Node("csneg_inst", csneg);}

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

cc = "eq" { return new Node("cc", "eq");}
    / "ne" { return new Node("cc", "ne");}
    / "hs" { return new Node("cc", "hs");}
    / "lo" { return new Node("cc", "lo");}
    / "mi" { return new Node("cc", "mi");}
    / "pl" { return new Node("cc", "pl");}
    / "vs" { return new Node("cc", "vs");}
    / "vc" { return new Node("cc", "vc");}
    / "hi" { return new Node("cc", "hi");}
    / "ls" { return new Node("cc", "ls");}
    / "ge" { return new Node("cc", "ge");}
    / "lt" { return new Node("cc", "lt");}
    / "gt" { return new Node("cc", "gt");}
    / "le" { return new Node("cc", "le");}
    / "al" { return new Node("cc", "al");}


//load and store instruccion

loadnstore_inst
    = r1:ldpsw_inst { return new Node("ldpsw_inst",r1);}
    / r2:ldp_inst { return new Node("ldp_inst",r2);}
    / r3:ldursbh_inst { return new Node("ldursbh_inst",r3);}
    / r4:ldurbh_inst { return new Node("ldurbh_inst",r4);}
    / r5:ldursw_inst { return new Node("ldursw_inst",r5);}
    / r6:ldur_inst { return new Node("ldur_inst",r6);}
    / r7:prfm_inst { return new Node("prfm_inst",r7);}
    / r8:sturbh_inst { return new Node("sturbh_inst",r8);}
    / r9:stur_inst { return new Node("stur_inst",r9);}
    / r10:stp_inst { return new Node("stp_inst",r10);}
    / r11:crc_inst { return new Node("crc_inst",r11);}
    / r12:loadAlm_inst { return new Node("loadAlm_inst",r12);}
    / r13:system_inst { return new Node("system_inst",r13);}


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
       
    / "[" _* r:reg32 _* "," _* r2:reg32 _* "," _* s:shift_op _* i2:immediate _* "]"

    / "[" _* r:reg64 _* "," _* r2:reg64 _* "," _* s:shift_op _* i2:immediate _* "]"
        
    / "[" _* r:reg64 _* "," _* i:immediate _* "," _* s:shift_op _* i2:immediate _* "]"
      
    / "[" _* r:reg64 _* "," _* i:immediate _* "," _* e:extend_op _* "]" 
       
    / "[" _* r:reg64 _* "," _* i:immediate _* "]"
        
    / "[" _* r:reg64 _* "]"
        

/* -------------------------------------------------------------------------- */
/*                    Instrucciones de suma de comprobacion                   */
/* -------------------------------------------------------------------------- */

crc_inst
    = r1:CRC32B_inst { return new Node("CRC32B_inst",r1);}
    / r2:CRC32H_inst { return new Node("CRC32H_inst",r2);}
    / r3:CRC32W_inst { return new Node("CRC32W_inst",r3);}
    / r4:CRC32X_inst { return new Node("CRC32X_inst",r4);}
    / r5:CRC32CB_inst { return new Node("CRC32CB_inst",r5);}
    / r6:CRC32CH_inst { return new Node("CRC32CH_inst",r6);}
    / r7:CRC32CW_inst { return new Node("CRC32CW_inst",r7);}
    / r8:CRC32CX_inst { return new Node("CRC32CX_inst",r8);}


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
    /   LDNP_inst
    /   LDTR_inst
    /   LDTRB_inst
    /   LDTRSB_inst
    /   LDTRSW_inst
    /   STLR_inst
    /   STLRB_inst
    /   STLXP_inst
    /   STLXRB_inst
    /   STNP_inst
    /   STTR_inst
    /   STTRB_inst
    / STRB_inst
    / STR_inst
    / STP_inst

LDAXP_inst 
    =   "ld"("a")? "xp" _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "ld"("a")? "xp" _* reg64 "," _* reg64 "," _* "[" reg64 "]"
LDAXR_inst 
    =   "ld"("a")? ("x")? "r" _* reg32 "," _* "[" reg64 "]"
    /   "ld"("a")? ("x")? "r" _* reg64 "," _* "[" reg64 "]"
LDAXRB_inst 
    =    "ld"("a")? ("x")? "r" ("b"/"h")? _* reg32 "," _* "[" reg64 "]"
LDNP_inst 
    =   "ldnp" _* reg32 "," _* reg32 "," _* "[" reg64 ("," immediate)? "]"
    /   "ldnp" _* reg64 "," _* reg64 "," _* "[" reg64 ("," immediate)? "]"
LDTR_inst 
    =   "ldtr" _* reg32 "," _* "[" reg64 ("," immediate)? "]"
    /   "ldtr" _* reg64 "," _* "[" reg64 ("," immediate)? "]"
LDTRB_inst 
    =    "ldtr" ("b"/"h")? _* reg32 "," _* "[" reg64 ("," immediate)? "]"
LDTRSB_inst
    =    "ldtrs" ("b"/"h")? _* reg32 "," _* "[" reg64 ("," immediate)? "]"
    /    "ldtrsb" ("b"/"h")? _* reg64 "," _* "[" reg64 ("," immediate)? "]"
LDTRSW_inst
    =    "ldtrsw" _* reg64 "," _* "[" reg64 ("," immediate)? "]"
STLR_inst
    =   "stlr" _* reg32 "," _* "[" reg64 "]"
    /   "stlr" _* reg64 "," _* "[" reg64 "]"
STLRB_inst
    =   "stlr"  ("b"/"h")? _* reg32 "," _* "[" reg64 "]"
STLXP_inst
    =   "st" ("l")? "xp" _* reg32 "," _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "st" ("l")? "xp" _* reg32 "," _* reg64 "," _* reg64 "," _* "[" reg64 "]"
    /   "st" ("l")? "xp"  _* reg32 "," _* reg32 "," _* "[" reg64 "]"
    /   "st" ("l")? "xp"  _* reg32 "," _* reg64 "," _* "[" reg64 "]"
STLXRB_inst
    =   "st" ("l")? "xr" ("b"/"h")? _* reg32 "," _* reg32 "," _* "[" reg64 "]"
STNP_inst
    =   "stnp" _* reg32 "," _* reg32 "," _* "["reg64 ("," immediate )?"]"
    /   "stnp" _* reg64 "," _* reg64 "," _* "["reg64 ("," immediate )?"]"
STTR_inst
    =   "sttr" _* reg32 "," _* "["reg64 ("," immediate )?"]"
    /   "sttr" _* reg64 "," _* "["reg64 ("," immediate )?"]"

STTRB_inst
     =   "sttr" ("b"/"h")? _* reg32 "," _* "["reg64 ("," immediate )?"]"
STRB_inst
	=  "strb"  _* reg32 "," _* "["reg64 ("," _* immediate)?"]"
STR_inst
	= "str" _* reg64 "," _* "["reg64 "]"
STP_inst
	= "stp" _* reg64 "," _* reg64 "," _* "["reg64 "]"

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
