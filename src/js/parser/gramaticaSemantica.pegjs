/* -------------------------------------------------------------------------- */
/*                             GRAMATICA SEMANTICA                            */
/* -------------------------------------------------------------------------- */
{
  // Creando cst 
  let cst = new Cst();
  // Agregar nodos
  function newPath(idRoot, nameRoot, nodes) {
    cst.addNode(idRoot, nameRoot);
    for (let node of nodes) {
      if (typeof node !== "string"){
        cst.addEdge(idRoot, node?.id);
        continue;
      }
      let newNode = cst.newNode();
      cst.addNode(newNode, node);
      cst.addEdge(idRoot, newNode);
    }
  }

const errores = [];
function reportError(tipo, mensaje, location) {
    errores.push({ tipo:tipo, mensaje:mensaje, fila:location.start.line, columna:location.start.column });
  }
}

// Grammar
 Start
  = gs:GlobalSection _? ds1:DataSection? _? ts:TextSection _? ds2:DataSection? {
    let dataSectionConcat = []
    if (ds1 != null) dataSectionConcat = dataSectionConcat.concat(ds1.value);
    if (ds2 != null) dataSectionConcat = dataSectionConcat.concat(ds2.value);
    // Agregando raiz cst
    let idRoot = cst.newNode();
    newPath(idRoot, 'Start', [gs, ds1, ts, ds2]);
    return new Root(gs, dataSectionConcat, ts, cst);
  }
    

GlobalSection
  = ".global" _ id:label _ 
  {
    let idRoot = cst.newNode();
    newPath(idRoot, 'GlobalSection', ['.global', id]);
    return { id: idRoot, name: id};
  }
  

DataSection
  = ".section .data" _ dec:etiq*
  {
    let idRoot = cst.newNode();
    newPath(idRoot, 'DataSection', ['.section', '.data'].concat(dec));
    return { id: idRoot, value: dec};
  }
  / ".data" _ dec:etiq*
  {
    let idRoot = cst.newNode();
    newPath(idRoot, 'DataSection', ['.data'].concat(dec));
    return { id: idRoot, value: dec};
  }

TextSection
  = ".section"? ".text"? _? ident:label ":" _* ins:linea*
  {
    let idInst = cst.newNode();
    newPath(idInst, ident, ins);
    let idRoot = cst.newNode();
    newPath(idRoot, 'TextSection', [{ id:idInst }]);
    return new TextSection(idRoot, 'TextSection', ident, ins);
  }
  

linea =  ins:instruccion _*  { return ins }
	  / sss:comentario _*  {}
      / etiq:etiq      _*  {}

comentario  
    = "//" [^\n]* 
    
etiq
    = ins:label ":" _* {}

instruccion 
    = ari:arithmetic_inst _*            {}
    / bitman:bitmanipulation_inst _*    {}
    / logi:logica_inst _*               { return logi;}
    / atom:atomic_inst _*               {}
    / bran:branch_inst _*               {}
    / cond:cond_inst _*                 {}
    / load:loadnstore_inst _*           {return load;}
    / inst:instSalto _*                 {}
    
instSalto = "beq" _* b1:label   {}
          / "bne" _* b2:label   {}
          / "bgt" _* b3:label   {}
          / "blt" _* b4:label   {}
          / "ble" _* b5:label   {}
          / "bl" _* b6:label    {}
          / "b" _* b6:label     {}
          / "ret" _* b7:label   {}
          
arithmetic_inst 
    = adc:adc_inst          {}
     /add:add_inst          {}
     /adr:adr_inst          {}
     /adrp:adrp_inst        {}
     /cmn:cmn_inst          {}
     /cmp:cmp_inst          {}
     /madd:madd_inst        {}
     /mneg:mneg_inst        {}
     /msub:msub_inst        {}
     /mul:mul_inst          {}
     /neg:neg_inst          {}
     /ngc:ngc_inst          {}
     /sbc:sbc_inst          {}
     /sdiv:sdiv_inst        {}
     /smadd:smaddl_inst     {}
     /smnegl:smnegl_inst    {}
     /smsubl:smsubl_inst    {}
     /smulh:smulh_inst      {}
     /smull:smull_inst      {}
     /sub:sub_inst          {}
     /udiv:udiv_inst        {}
     /umaddl:umaddl_inst    {}
     /umnegl:umnegl_inst    {}
     /umsubl:umsubl_inst    {}
     /umulh:umulh_inst      {}
     /umull:umull_inst      {}


//Instrucciones Aritmeticas
adc_inst 
    = "adc" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 {}
     /"adc" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 {}

add_inst 
    = "add" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando {}
    / "add" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:operando {}
adr_inst
    = "adr" _* r5:reg64 "," _* r6:rel21 {}

adrp_inst 
    = "adrp" _* r5:reg64 "," _* r6:rel33 {}

cmn_inst
    = "cmn" _* r3:reg64 "," _* r2:operando {}
    / "cmn" _* r5:reg32 "," _* r6:operando {}

cmp_inst
    = "cmp" _* r5:reg64 "," _* r6:operando {}
    / "cmp" _* r7:reg32 "," _* r8:operando {}

madd_inst   
    = "madd" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64  {}
    / "madd" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  {}

mneg_inst
    = "mneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 {}
    / "mneg" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 {}

msub_inst
    = "msub" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64  {}
    / "msub" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  {}

mul_inst
    = "mul"  _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 {}
    / "mul"  _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 {}

neg_inst
    = "neg" ("s")? _* r2:reg64 "," _* r3:operando {} 
    / "neg" ("s")? _* r2:reg32 "," _* r3:operando {}

ngc_inst
    = "ngc" ("s")? _* r5:reg64 "," _* r6:reg64 {}
    / "ngc" ("s")? _* r5:reg32 "," _* r6:reg32 {}

sbc_inst
    = "sbc" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 {}
    / "sbc" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 {}

sdiv_inst
    = "sdiv" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 {}
    / "sdiv" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 {}

smaddl_inst
    = "smaddl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 {}

smnegl_inst
    = "smnegl" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 {}

smsubl_inst
    = "smsubl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 {}

smulh_inst
    = "smulh" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64  {}

smull_inst
    = "smull" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32  {}

sub_inst
    = "sub" ("s")? _* r4:reg64 "," _* r5:reg64 "," _* r6:operando {}
    / "sub" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:operando {}

udiv_inst
    = "udiv" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64  {}
    / "udiv" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32  {}

umaddl_inst
    = "umaddl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 {}

umnegl_inst 
    = "umnegl" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 {}

umsubl_inst
    = "umsubl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 {}

umulh_inst
    = "umulh" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64 {}

umull_inst
    = "umull" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 {}

bitmanipulation_inst
    = bfi:bfi_inst      {}
    /r1:bfxil_inst      {}
    /r2:cls_inst        {}
    /r3:clz_inst        {}
    /r4:extr_inst       {}
    /r5:rbit_inst       {}
    /r6:rev_inst        {}
    /r7:rev16_inst      {}
    /r8:rev32_inst      {}
    /r9:bfiz_inst       {}
    /r10:bfx_inst       {} 
    /r11:xt_inst        {}
//instruccion de manipulacion de bit
bfi_inst
    = "bfi" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate {}
    / "bfi" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate {}

bfxil_inst
    = "bfxil" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate {}
    / "bfxil" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate {}

cls_inst
    = "cls" _* r5:reg64 "," _* r6:reg64  {}
    / "cls" _* r5:reg32 "," _* r6:reg32  {}

clz_inst
    = "clz" _* r5:reg64 "," _* r6:reg64  {}
    / "clz" _* r5:reg32 "," _* r6:reg32  {}

extr_inst
    = "extr" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:immediate {}
    / "extr" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:immediate {}

rbit_inst
    = "rbit" _* r5:reg64 "," _* r6:reg64 {}
    / "rbit" _* r5:reg32 "," _* r6:reg32 {}

rev_inst
    = "rev" _* r5:reg64 "," _* r6:reg64 {}
    / "rev" _* r5:reg32 "," _* r6:reg32 {}

rev16_inst
    = "rev16" _* r5:reg64 "," _* r6:reg64 {}
    / "rev16" _* r5:reg32 "," _* r6:reg32 {}

rev32_inst
    = "rev32" _* r5:reg64 "," _* r6:reg64 {}

bfiz_inst
    = ("s"/"u") "bfiz" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate {}
    / ("s"/"u") "bfiz" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate {}


bfx_inst
    = ("s"/"u") "bfx" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate {}
    / ("s"/"u") "bfx" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate {}


xt_inst
    = ("s"/"u") "xt" ("b"/"h")? _* r5:reg64 "," _* r6:reg32 {}
    / ("s"/"u") "xt" ("b"/"h")? _* r5:reg32 "," _* r6:reg32 {}

//instrucciones logicas
logica_inst 
    = and:and_inst      {}
    / asr:asr_inst      {}
    / bic:bic_inst      {}
    / eon:eon_inst      {}
    / eor:eor_inst      {}
    / lsl:lsl_inst      {}
    / lsr:lsr_inst      {}
    / movk:movk_inst    {}
    / movn:movn_inst    {}
    / movz:movz_inst    {}
    / mov:mov_inst      { return mov }
    / mvn:mvn_inst      {}
    / orn:orn_inst      {}
    / orr:orr_inst      {}
    / ror:ror_inst      {}
    / tst:tst_inst      {}

and_inst
    = "and" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando {}
    / "and" ("s")? _* r1:reg32 "," _* r2:reg32 "," _* r3:operando {}

asr_inst
    = "asr" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) {}
    / "asr" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) {}

bic_inst
    = "bic" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando {}
    / "bic" ("s")? _* r1:reg32 "," _* r2:reg32 "," _* r3:operando {}

eon_inst
    = r1:"eon" _* r2:reg64 "," _* r3:reg64 "," _* r4:operando {}
    / r1:"eon" _* r2:reg32 "," _* r3:reg32 "," _* r4:operando {}

eor_inst
    = r1:"eor" _* r2:reg64 "," _* r3:reg64 "," _* r4:operando {}
    / r1:"eor" _* r2:reg32 "," _* r3:reg32 "," _* r4:operando {}

lsl_inst
    = "lsl" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) {}
    / "lsl" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) {}

lsr_inst
    = "lsr" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) {}
    / "lsr" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) {}

mov_inst
    = mov:"mov" _* r1:reg64 "," _* r2:reg64  
    {
    const loc = location()?.start;
    const idRoot = cst.newNode();
    newPath(idRoot, 'Move', ['mov', r1, 'COMA', r2]);
    return new Move(loc?.line, loc?.column, idRoot, r1.name, r2.name);
    }
    / mov:"mov" _* r1:reg64 "," _* r2:immediate  
    {
    const loc = location()?.start;
    const idRoot = cst.newNode();
    newPath(idRoot, 'Move', ['mov', r1, 'COMA', r2]);
    return new Move(loc?.line, loc?.column, idRoot, r1.name, r2.name);
    }
    / mov:"mov" _* r1:reg32 "," _* r2:(reg32 / immediate)* 
    {
    const loc = location()?.start;
    const idRoot = cst.newNode();
    newPath(idRoot, 'Move', ['mov', r1, 'COMA', r2]);
    return new Move(loc?.line, loc?.column, idRoot, r1.name, r2.name);
  }

movk_inst
    = "movk" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}
    / "movk" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}

movn_inst
    = "movn" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}
    / "movn" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}

movz_inst
    = "movz" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}
    / "movz" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? {}

mvn_inst
    = "mvn" _* r1:reg64 "," _* r2:operando {}
    / "mvn" _* r1:reg32 "," _* r2:operando {}

orn_inst
    = "orn" _* r1:reg64 "," _* r2:reg64 "," _* r3:operando {}
    / "orn" _* r1:reg32 "," _* r2:reg32 "," _* r3:operando {}

orr_inst
    = "orr"  _* r1:reg64 "," _* r2:reg64 "," _* r3:operando {}
    / "orr"  _* r1:reg32 "," _* r2:reg32 "," _* r3:operando {}

ror_inst
    = "ror" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) {}
    / "ror" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) {}

tst_inst
    = "tst"  _* r1:reg64 "," _* r2:reg64 "," _* r3:operando  {}
    / "tst"  _* r1:reg32 "," _* r2:reg32 "," _* r3:operando  {}


// instrucciones branch
branch_inst
    = bcc:bcc_inst      {}
    / blr:blr_inst      {}
    / bl:bl_inst        {}
    / br:br_inst        {}
    / b:b_inst          {}
    / cbnz:cbnz_inst    {}
    / cbz:cbz_inst      {}
    / ret:ret_inst      {}
    / tbnz:tbnz_inst    {}
    / tbz:tbz_inst      {}

b_inst 
    = "b" _* r1:rel28   {}

bcc_inst
    = "bcc" _* r1:rel21 {}

bl_inst 
    = "bl" _* r1:rel28  {}

blr_inst    
    = "blr" _* r1:reg64 {}

br_inst  
    = "br" _* r1:reg64  {}

cbnz_inst
    = "cbnz" _* r5:reg64 "," _* r6:rel21 {}
    / "cbnz" _* r5:reg32 "," _* r6:rel21 {}

cbz_inst
    = "cbz" _* r5:reg64 "," _* r6:rel21 {}
    / "cbz" _* r5:reg32 "," _* r6:rel21 {}

ret_inst 
    = "ret" _* "{" r1:reg64 "}" {}

tbnz_inst
    = "tbnz" _* r1:reg64 "," _* r2:immediate "," _* r3:rel16 {}
    / "tbnz" _* r1:reg32 "," _* r2:immediate "," _* r3:rel16 {}

tbz_inst
    = "tbz" _* r1:reg64 "," _* r2:immediate "," _* r3:rel16     {}
    / "tbz" _* r1:reg32 "," _* r2:immediate "," _* r3:rel16     {}

// instrucciones atomic
atomic_inst
    = cas:cas_inst      {}
    / ldao:ldao_inst    {}
    / stao:stao_inst    {}
    / swp:swp_inst      {}

cas_inst
    = "cas" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64"]"                         {}
    / "cas" ("a"/"l")? "p" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64 "," "["r5:reg64"]"   {}
    / "cas" ("a"/"l")? "p" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg32 "," "["r5:reg64"]"   {}
    / "cas" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"                                    {}
    / "cas" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"                                    {}

ldao_inst
    = "ldao" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"     {}
    / "ldao" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"               {}
    / "ldao" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"               {}

stao_inst
    = "stao" ("a"/"l")? ("b"/"h") _* r1:reg32 ","  _* "["r2:reg64"]"        {}
    / "stao" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"   {}
    / "stao" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"   {}

swp_inst
    = "swp" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"      {}
    / "swp" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"                {}
    / "swp" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"                {}

//instrucciones condicionales
cond_inst
    = ccmn:ccmn_inst    {}
    / ccmp:ccmp_inst    {}
    / cinc:cinc_inst    {}
    / cinv:cinv_inst    {}
    / cneg:cneg_inst    {}
    / csel:csel_inst    {}
    / cset:cset_inst    {}
    / csetm:csetm_inst  {}
    / csinc:csinc_inst  {}
    / csinv:csinv_inst  {}
    / csneg:csneg_inst  {}

ccmn_inst
    = "ccmn" _* r1:reg64 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   {}
    / "ccmn" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:cc       {}
    / "ccmn" _* r1:reg32 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   {}
    / "ccmn" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:cc       {}

ccmp_inst
    = "ccmp" _* r1:reg64 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   {}
    / "ccmp" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:cc       {}
    / "ccmp" _* r1:reg32 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   {}
    / "ccmp" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:cc       {}

cinc_inst
    = "cinc" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc {}
    / "cinc" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc {}

cinv_inst
    = "cinv" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc {}
    / "cinv" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc {}

cneg_inst
    = "cneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc {}
    / "cneg" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc {}

csel_inst
    = "csel" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc {}
    / "csel" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc {}

cset_inst
    = "cset" _* r1:reg64 "," _* r2:cc {}
    / "cset" _* r1:reg32 "," _* r2:cc {}

csetm_inst
    = "csetm" _* r1:reg64 "," _* r2:cc {}
    / "csetm" _* r1:reg32 "," _* r2:cc {}

csinc_inst
    = "csinc" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc {}
    / "csinc" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc {}

csinv_inst
    = "csinv" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc {}
    / "csinv" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc {}

csneg_inst
    = "csneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc {}
    / "csneg" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc {}

cc = "eq"   {}
    / "ne"  {}
    / "hs"  {}
    / "lo"  {}
    / "mi"  {}
    / "pl"  {}
    / "vs"  {}
    / "vc"  {}
    / "hi"  {}
    / "ls"  {}
    / "ge"  {}
    / "lt"  {}
    / "gt"  {}
    / "le"  {}
    / "al"  {}


//load and store instruccion

loadnstore_inst
    = r1:ldpsw_inst     {}
    / r2:ldp_inst       {}
    / r3:ldursbh_inst   {}
    / r4:ldurbh_inst    {}
    / r5:ldursw_inst    {}
    / r6:ldur_inst      {}
    / r7:prfm_inst      {}
    / r8:sturbh_inst    {}
    / r9:stur_inst      {}
    / r10:stp_inst      {}
    / r11:crc_inst      {}
    / r12:loadAlm_inst  {}
    / r13:system_inst   {return r13;}


ldpsw_inst 
    = "ldpsw" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" {}
    / "ldpsw" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:addr"]" {}

ldp_inst
    = "ldp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" {}

ldursbh_inst
    = "ld" ("u")? "rs" ("b"/"h") _* r1:reg64 "," _* "["r2:addr"]" {}
    / "ld" ("u")? "rs" ("b"/"h") _* r1:reg32 "," _* "["r2:addr"]" {}

ldurbh_inst
    = "ld" ("u")? "r" ("b"/"h") _* r1:reg32 "," _* "["r2:addr"]"    {}
    / "ld" ("u")? "r" ("b"/"h") _* r1:reg32 "," _* r2:addr          {}
ldursw_inst
    = "ld" ("u")? "rsw"  _* r1:reg64 "," _* "["r2:addr"]"  {}

ldur_inst 
    = "ld" ("u")? "r"  _* r1:reg64 "," _* "["r2:addr"]"   {}
    / "ld" ("u")? "r"  _* r1:reg32 "," _* "["r2:addr"]"   {}
    / "ld" ("u")? "r"  _* r1:reg64 "," _* r2:addr         {}
prfm_inst
    = "prfm" r1:reg32 "," _* r2:addr {}
    / "prfm" r1:reg64 "," _* r2:addr {}

sturbh_inst
    = "st" ("u")? "r" ("b"/"h") _* r1:reg64 "," _* "["r2:addr"]" {}

stur_inst
    = "st" ("u")? "r"  _* r1:reg64 "," _* "["r2:addr"]" {}
    / "st" ("u")? "r"  _* r1:reg32 "," _* "["r2:addr"]" {}

stp_inst
    = "stp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" {}
    / "stp" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:addr"]" {}



addr 
    = "=" l:label                                                                   {}
    /  r1:reg32 _* "," _* r2:reg32 _* "," _* s:shift_op _* i2:immediate _*          {}                
    /  r1:reg64 _* "," _* r2:reg64 _* "," _* s:shift_op _* i2:immediate _*          {}                
    /   r1:reg64 _* "," _* i:immediate _* "," _* s:shift_op _* i2:immediate _*      {}                
    /   r1:reg64 _* "," _* i:immediate _* "," _* e:extend_op _*                     {}                
    /   r1:reg64 _* "," _* i:immediate _*                                           {}                
    /   r1:reg64 _* "," _* i:reg64 _*                                               {}                  
    /   r1:reg64 _*                                                                 {}                
/* -------------------------------------------------------------------------- */
/*                    Instrucciones de suma de comprobacion                   */
/* -------------------------------------------------------------------------- */

crc_inst
    = r1:CRC32B_inst    {}
    / r2:CRC32H_inst    {}
    / r3:CRC32W_inst    {}
    / r4:CRC32X_inst    {}
    / r5:CRC32CB_inst   {}
    / r6:CRC32CH_inst   {}
    / r7:CRC32CW_inst   {}
    / r8:CRC32CX_inst   {}


CRC32B_inst = "crc32b" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      {}
CRC32H_inst = "crc32h" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      {}
CRC32W_inst = "crc32w" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      {}
CRC32X_inst = "crc32x" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg64      {}
CRC32CB_inst = "crc32cb" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    {}
CRC32CH_inst = "crc32ch" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    {}
CRC32CW_inst = "crc32cw" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    {}
CRC32CX_inst = "crc32cx" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg64    {}


/* -------------------------------------------------------------------------- */
/*            Instrucciones de carga y almacenamiento con atributos           */
/* -------------------------------------------------------------------------- */
loadAlm_inst
    =   r1:LDAXP_inst   {}
    /   r2:LDAXR_inst   {}
    /   r3:LDAXRB_inst  {}
    /   r4:LDNP_inst    {}
    /   r5:LDTR_inst    {}
    /   r6:LDTRB_inst   {}
    /   r7:LDTRSB_inst  {}
    /   r8:LDTRSW_inst  {}
    /   r9:STLR_inst    {}
    /   r10:STLRB_inst  {} 
    /   r11:STLXP_inst  {}
    /   r12:STLXRB_inst {}
    /   r13:STNP_inst   {}
    /   r14:STTR_inst   {}
    /   r15:STTRB_inst  {}
    /   r16:STRB_inst   {}
    /   r17:STR_inst    {}
    /   r18:STP_inst    {}

LDAXP_inst 
    =   "ld"("a")? "xp" _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)?"]"   {}
    /   "ld"("a")? "xp" _* r1:reg64 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]"  {}
LDAXR_inst 
    =   "ld"("a")? ("x")? "r" _* r1:reg32 "," _* "[" r2:reg64  ("," r4:operando)?"]" {}
    /   "ld"("a")? ("x")? "r" _* r1:reg64 "," _* "[" r2:reg64 ("," r4:operando)? "]" {}
LDAXRB_inst 
    =    "ld"("a")? ("x")? "r" ("b"/"h")? _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
LDNP_inst 
    =   "ldnp" _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
    /   "ldnp" _* r1:reg64 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
LDTR_inst 
    =   "ldtr" _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]" {}
    /   "ldtr" _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" {}
LDTRB_inst 
    =    "ldtr" ("b"/"h")? _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]" {}
LDTRSB_inst
    =    "ldtrs" ("b"/"h")? _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]"  {}
    /    "ldtrsb" ("b"/"h")? _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" {}
LDTRSW_inst
    =    "ldtrsw" _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" {}
STLR_inst
    =   "stlr" _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
    /   "stlr" _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
STLRB_inst
    =   "stlr"  ("b"/"h")? _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" {}
STLXP_inst
    =   "st" ("l")? "xp" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* "[" r4:reg64 ("," operando )? "]"       {}
    /   "st" ("l")? "xp" _* r1:reg32 "," _* r2:reg64 "," _* r3:reg64 "," _* "[" r4:reg64 ("," operando )?"]"        {}
    /   "st" ("l")? "xp"  _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]"                    {}
    /   "st" ("l")? "xp"  _* r1:reg32 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]"                    {}
STLXRB_inst 
    =   "st" ("l")? "xr" ("b"/"h")? _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)?"]" {}
STNP_inst
    =   "stnp" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64 ("," r4:operando )?"]" {}
    /   "stnp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64 ("," r4:operando )?"]" {}
STTR_inst
    =   "sttr" _* r1:reg32 "," _* "["r2:reg64 ("," r3:operando )?"]" {}
    /   "sttr" _* r1:reg64 "," _* "["r2:reg64 ("," r3:operando )?"]" {}

STTRB_inst
     =   "sttr" ("b"/"h")? _* r1:reg32 "," _* "["r2:reg64 ("," r3:operando )?"]" {}
STRB_inst
	=  "strb"  _* r1:reg32 "," _* "["r2:reg64 ("," _* r7:operando)?"]" {}
STR_inst
	= "str" _* r2:reg64 "," _* "["r3:reg64 ("," operando )?"]" {}
STP_inst
	= "stp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64 ("," operando )?"]" {}
/* -------------------------------------------------------------------------- */
/*                          Instrucciones al sistema                          */
/* -------------------------------------------------------------------------- */
system_inst
=   arg:AT_inst     {}
/   arg:BRK_inst    {}
/   arg:CLREX_inst  {}
/   arg:DMB_inst    {}
/   arg:DSB_inst    {}
/   arg:ERET_inst   {}
/   arg:HVC_inst    {}
/   arg:ISB_inst    {}
/   arg:MRS_inst    {}
/   arg:MSR_inst    {}
/   arg:NOP_inst    {}
/   arg:SEV_inst    {}
/   arg:SEVL_inst   {}
/   arg:SMC_inst    {}
/   arg:SVC_inst    {return arg;}
/   arg:WFE_inst    {}
/   arg:WFI_inst    {}
/   arg:YIELD_inst  {}


AT_inst     = "at" _* arg:at_operation "," _* arg2:reg64                {}
BRK_inst    = "brk" _* arg:immediate                                    {}
CLREX_inst  = "clrex" _* arg:(immediate)?                               {}
DMB_inst    = "dmb" _* arg:barrierop                                    {}
DSB_inst    = "dsb" _* arg:barrierop                                    {}
ERET_inst   = "eret"                                                    {}
HVC_inst    = "hvc" _* arg:immediate                                    {}
ISB_inst    = "isb" _* ("sy")?                                          {}
MRS_inst    = "mrs" _* arg:reg64 "," _* arg2:sysreg                     {}
MSR_inst    = "msr" _* arg:msr_rules                                    {}
NOP_inst    = "nop"                                                     {}
SEV_inst    = "sev"                                                     {}
SEVL_inst   = "sevl"                                                    {}
SMC_inst    = "smc" _* arg:immediate                                    {}
SVC_inst    = "svc" _* arg:integer                                    
{
    const loc = location()?.start;
    let idRoot = cst.newNode();
    newPath(idRoot, 'SystemCall', ["svc", arg]);
    return new SystemCall(loc?.line, loc?.column, idRoot, arg);
}
WFE_inst    = "wfe"                                                     {}
WFI_inst    = "wfi"                                                     {}
YIELD_inst  = "yield"                                                   {}

at_operation
=   "s1e1r"     {}
/   "s1e1w"     {}
/   "s1e0r"     {}
/   "s1e0w"     {}
/   "s1e2r"     {}
/   "s1e2w"     {}
/   "s1e3r"     {}
/   "s1e3w"     {}
/   "s12e1r"    {}
/   "s12e1w"    {}

barrierop
=   "sy"        {}
/   "ish"       {}
/   "ishst"     {}
/   "nsh"       {}
/   "nshst"     {}
/   "osh"       {}
/   "oshst"     {}

sysreg
=   "sctlr"     {}
/   "actlr"     {}
/   "cpacr"     {}
/   "scr"       {}
/   "sder"      {}
/   "nsacr"     {}
/   "ttbr0"     {}
/   "ttbr1"     {}
/   "tcr"       {}
/   "mair0"     {}
/   "mair1"     {}
/   "vbar"      {}
/   "isr"       {}
/   "fpcr"      {}
/   "fpsr"      {}
/   "dspsr"     {}
/   "dfsr"      {}
/   "elr_elx"   {}
/   "sp_elx"    {}
/   "nzcv"      {}


msr_rules
=   arg1:sysreg "," _* arg:reg64        {}
/   "spsel" _* "," _* arg:immediate     {}
/   "daifset" _* "," _* arg:immediate   {}
/   "daifclr" _* "," _* arg:immediate   {}


//-----------------------------------------------------------------------------------------------------------------
    // Definición de valores inmediatos


reg64 
    = "x" arg:("30" / [12][0-9] / [0-9])            
     {
    let idRoot = cst.newNode(); 
    //newPath(idRoot, 'register', [text()]);
    return { id: idRoot, name: text() }
  }
    / "sp"                                          
     {
    let idRoot = cst.newNode(); 
    //newPath(idRoot, 'register', [text()]);
    return { id: idRoot, name: text() }
  }
    / "=" l:label                                   
    

reg32 = "w" arg:("30" / [12][0-9] / [0-9])          {}
    / "sp"                                          {}

operando = arg:reg64                                {}
        / arg:reg32                                 {}
        / arg:immediate                             {}

rel16 = sign? [0-9]{1,16}
rel21 = sign? [0-9]{1,21}
rel28 = sign? [0-9]{1,28}
rel33 = arg1:sign? arg2:[0-9]{1,33} 
sign = arg:("+" / "-") 

//immediate = "#" [0-9]+
immediate "Inmediato"
    = ("#")?"'"arg:letter"'"   
      {
          let idRoot = cst.newNode(); 
          //newPath(idRoot, 'register', [text()]);
          return { id: idRoot, name: text() }
      }
    / ("#")?"0x" arg:hex_literal                   
      {
          let idRoot = cst.newNode(); 
          //newPath(idRoot, 'register', [text()]);
          return { id: idRoot, name: text() }
      } 
    / ("#")?"0b" arg:binary_literal                 
      {
          let idRoot = cst.newNode(); 
          //newPath(idRoot, 'register', [text()]);
          return { id: idRoot, name: text() }
      }
    / ("#")? arg:integer                            
      {
          let idRoot = cst.newNode(); 
          //newPath(idRoot, 'register', [text()]);
          return { id: idRoot, name: text() }
      }
    / ("#")? sign arg:integer                           
      {
          let idRoot = cst.newNode(); 
          //newPath(idRoot, 'register', [text()]);
          return { id: idRoot, name: text() }
      }


extend_op "Operador de Extensión"
    = "UXTB"i {}
    / "UXTH"i {}
    / "UXTW"i {}
    / "UXTX"i {}
    / "SXTB"i {}
    / "SXTH"i {}
    / "SXTW"i {}
    / "SXTX"i {}

integer 
    = arg: [0-9]+ 
    {
    const loc = location()?.start;
    let idRoot = cst.newNode();
    newPath(idRoot, 'integer', [text()]);
    return new Primitive(loc?.line, loc?.column, idRoot, Type.WORD, parseInt(text(), 10));
  }


shift_op "Operador de Desplazamiento"
    = "LSL"i {}
    / "LSR"i {}
    / "ASR"i {}

label "Etiqueta"
    = id:([a-zA-Z_][a-zA-Z0-9_]*) 
    {
    let completeId = id[0]+id[1]?.join('');
    return completeId; 
    }

letter
    = arg: [a-zA-Z] {}

// Representa uno o más dígitos binarios
binary_literal
  = arg:[01]+ {}
  
// Representa uno o más dígitos hexadecimales
hex_literal
    = arg:[0-9a-fA-F]+  {}

string "string"
  = "\"" chars:[^\"]* "\"" _ 
  {
    const loc = location()?.start;
    let idRoot = cst.newNode();
    newPath(idRoot, 'string', [chars.join('')]);
    return new Primitive(loc?.line, loc?.column, idRoot, Type.ASCIZ, chars.join(''));
  }

entero = arg: [0-9]+    
{
    const loc = location()?.start;
    let idRoot = cst.newNode();
    newPath(idRoot, 'integer', [text()]);
    return new Primitive(loc?.line, loc?.column, idRoot, Type.WORD, parseInt(text(), 10));
  }

_ = [ \t\n\r]