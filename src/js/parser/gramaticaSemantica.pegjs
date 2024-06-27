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
	  / sss:comentario _*  { return }
      / etiq:etiq      _*  { return }

comentario  
    = "//" [^\n]* 
    
etiq
    = ins:label ":" _* { return }

instruccion 
    = ari:arithmetic_inst _*            { return }
    / bitman:bitmanipulation_inst _*    { return }
    / logi:logica_inst _*               { return logi}
    / atom:atomic_inst _*               { return }
    / bran:branch_inst _*               { return }
    / cond:cond_inst _*                 { return }
    / load:loadnstore_inst _*           { return }
    / inst:instSalto _*                 { return }
    
instSalto = "beq" _* b1:label   { return }
          / "bne" _* b2:label   { return }
          / "bgt" _* b3:label   { return }
          / "blt" _* b4:label   { return }
          / "ble" _* b5:label   { return }
          / "bl" _* b6:label    { return }
          / "b" _* b6:label     { return }
          / "ret" _* b7:label   { return }
          
arithmetic_inst 
    = adc:adc_inst          { return }
     /add:add_inst          { return }
     /adr:adr_inst          { return }
     /adrp:adrp_inst        { return }
     /cmn:cmn_inst          { return }
     /cmp:cmp_inst          { return }
     /madd:madd_inst        { return }
     /mneg:mneg_inst        { return }
     /msub:msub_inst        { return }
     /mul:mul_inst          { return }
     /neg:neg_inst          { return }
     /ngc:ngc_inst          { return }
     /sbc:sbc_inst          { return }
     /sdiv:sdiv_inst        { return }
     /smadd:smaddl_inst     { return }
     /smnegl:smnegl_inst    { return }
     /smsubl:smsubl_inst    { return }
     /smulh:smulh_inst      { return }
     /smull:smull_inst      { return }
     /sub:sub_inst          { return }
     /udiv:udiv_inst        { return }
     /umaddl:umaddl_inst    { return }
     /umnegl:umnegl_inst    { return }
     /umsubl:umsubl_inst    { return }
     /umulh:umulh_inst      { return }
     /umull:umull_inst      { return }


//Instrucciones Aritmeticas
adc_inst 
    = "adc" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return }
     /"adc" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return }

add_inst 
    = "add" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return }
    / "add" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:operando { return }
adr_inst
    = "adr" _* r5:reg64 "," _* r6:rel21 { return }

adrp_inst 
    = "adrp" _* r5:reg64 "," _* r6:rel33 { return }

cmn_inst
    = "cmn" _* r3:reg64 "," _* r2:operando { return }
    / "cmn" _* r5:reg32 "," _* r6:operando { return }

cmp_inst
    = "cmp" _* r5:reg64 "," _* r6:operando { return }
    / "cmp" _* r7:reg32 "," _* r8:operando { return }

madd_inst   
    = "madd" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64  { return }
    / "madd" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  { return }

mneg_inst
    = "mneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return }
    / "mneg" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return }

msub_inst
    = "msub" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64  { return }
    / "msub" _* r5:reg32 "," _* r6:reg32 "," _* r7:reg32 "," _* r8:reg32  { return }

mul_inst
    = "mul"  _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return }
    / "mul"  _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return }

neg_inst
    = "neg" ("s")? _* r2:reg64 "," _* r3:operando { return } 
    / "neg" ("s")? _* r2:reg32 "," _* r3:operando { return }

ngc_inst
    = "ngc" ("s")? _* r5:reg64 "," _* r6:reg64 { return }
    / "ngc" ("s")? _* r5:reg32 "," _* r6:reg32 { return }

sbc_inst
    = "sbc" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return }
    / "sbc" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return }

sdiv_inst
    = "sdiv" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 { return }
    / "sdiv" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32 { return }

smaddl_inst
    = "smaddl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 { return }

smnegl_inst
    = "smnegl" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 { return }

smsubl_inst
    = "smsubl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 { return }

smulh_inst
    = "smulh" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64  { return }

smull_inst
    = "smull" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32  { return }

sub_inst
    = "sub" ("s")? _* r4:reg64 "," _* r5:reg64 "," _* r6:operando { return }
    / "sub" ("s")? _* r4:reg32 "," _* r5:reg32 "," _* r6:operando { return }

udiv_inst
    = "udiv" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64  { return }
    / "udiv" _* r4:reg32 "," _* r5:reg32 "," _* r6:reg32  { return }

umaddl_inst
    = "umaddl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 { return }

umnegl_inst 
    = "umnegl" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 { return }

umsubl_inst
    = "umsubl" _* r1:reg64 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg64 { return }

umulh_inst
    = "umulh" _* r4:reg64 "," _* r5:reg64 "," _* r6:reg64 { return }

umull_inst
    = "umull" _* r4:reg64 "," _* r5:reg32 "," _* r6:reg32 { return }

bitmanipulation_inst
    = bfi:bfi_inst      { return }
    /r1:bfxil_inst      { return }
    /r2:cls_inst        { return }
    /r3:clz_inst        { return }
    /r4:extr_inst       { return }
    /r5:rbit_inst       { return }
    /r6:rev_inst        { return }
    /r7:rev16_inst      { return }
    /r8:rev32_inst      { return }
    /r9:bfiz_inst       { return }
    /r10:bfx_inst       { return } 
    /r11:xt_inst        { return }
//instruccion de manipulacion de bit
bfi_inst
    = "bfi" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate { return }
    / "bfi" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate { return }

bfxil_inst
    = "bfxil" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate { return }
    / "bfxil" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate { return }

cls_inst
    = "cls" _* r5:reg64 "," _* r6:reg64  { return }
    / "cls" _* r5:reg32 "," _* r6:reg32  { return }

clz_inst
    = "clz" _* r5:reg64 "," _* r6:reg64  { return }
    / "clz" _* r5:reg32 "," _* r6:reg32  { return }

extr_inst
    = "extr" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:immediate { return }
    / "extr" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:immediate { return }

rbit_inst
    = "rbit" _* r5:reg64 "," _* r6:reg64 { return }
    / "rbit" _* r5:reg32 "," _* r6:reg32 { return }

rev_inst
    = "rev" _* r5:reg64 "," _* r6:reg64 { return }
    / "rev" _* r5:reg32 "," _* r6:reg32 { return }

rev16_inst
    = "rev16" _* r5:reg64 "," _* r6:reg64 { return }
    / "rev16" _* r5:reg32 "," _* r6:reg32 { return }

rev32_inst
    = "rev32" _* r5:reg64 "," _* r6:reg64 { return }

bfiz_inst
    = ("s"/"u") "bfiz" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate { return }
    / ("s"/"u") "bfiz" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate { return }


bfx_inst
    = ("s"/"u") "bfx" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:immediate { return }
    / ("s"/"u") "bfx" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:immediate { return }


xt_inst
    = ("s"/"u") "xt" ("b"/"h")? _* r5:reg64 "," _* r6:reg32 { return }
    / ("s"/"u") "xt" ("b"/"h")? _* r5:reg32 "," _* r6:reg32 { return }

//instrucciones logicas
logica_inst 
    = and:and_inst      { return }
    / asr:asr_inst      { return }
    / bic:bic_inst      { return }
    / eon:eon_inst      { return }
    / eor:eor_inst      { return }
    / lsl:lsl_inst      { return }
    / lsr:lsr_inst      { return }
    / movk:movk_inst    { return }
    / movn:movn_inst    { return }
    / movz:movz_inst    { return }
    / mov:mov_inst      { return mov }
    / mvn:mvn_inst      { return }
    / orn:orn_inst      { return }
    / orr:orr_inst      { return }
    / ror:ror_inst      { return }
    / tst:tst_inst      { return }

and_inst
    = "and" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return }
    / "and" ("s")? _* r1:reg32 "," _* r2:reg32 "," _* r3:operando { return }

asr_inst
    = "asr" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) { return }
    / "asr" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) { return }

bic_inst
    = "bic" ("s")? _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return }
    / "bic" ("s")? _* r1:reg32 "," _* r2:reg32 "," _* r3:operando { return }

eon_inst
    = r1:"eon" _* r2:reg64 "," _* r3:reg64 "," _* r4:operando { return }
    / r1:"eon" _* r2:reg32 "," _* r3:reg32 "," _* r4:operando { return }

eor_inst
    = r1:"eor" _* r2:reg64 "," _* r3:reg64 "," _* r4:operando { return }
    / r1:"eor" _* r2:reg32 "," _* r3:reg32 "," _* r4:operando { return }

lsl_inst
    = "lsl" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) { return }
    / "lsl" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) { return }

lsr_inst
    = "lsr" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) { return }
    / "lsr" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) { return }

mov_inst
    = mov:"mov" _* r1:reg64 "," _* r2:reg64  
    {
    const loc = location()?.start;
    const idRoot = cst.newNode();
    newPath(idRoot, 'Move', ['mov', r1, 'COMA', r2]);
    return new Move(loc?.line, loc?.column, idRoot, r1.name, r2.name);
    }
    / mov:"mov" _* r1:reg64 "," _* r2: immediate  
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
    = "movk" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }
    / "movk" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }

movn_inst
    = "movn" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }
    / "movn" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }

movz_inst
    = "movz" _* r1:reg64 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }
    / "movz" _* r1:reg32 "," _* r2:immediate r3:("["entero"]"/"{"entero"}")? { return }

mvn_inst
    = "mvn" _* r1:reg64 "," _* r2:operando { return }
    / "mvn" _* r1:reg32 "," _* r2:operando { return }

orn_inst
    = "orn" _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return }
    / "orn" _* r1:reg32 "," _* r2:reg32 "," _* r3:operando { return }

orr_inst
    = "orr"  _* r1:reg64 "," _* r2:reg64 "," _* r3:operando { return }
    / "orr"  _* r1:reg32 "," _* r2:reg32 "," _* r3:operando { return }

ror_inst
    = "ror" _* r1:reg64 "," _* r2:reg64 "," _* r3:(reg64 / immediate) { return }
    / "ror" _* r1:reg32 "," _* r2:reg32 "," _* r3:(reg32 / immediate) { return }

tst_inst
    = "tst"  _* r1:reg64 "," _* r2:reg64 "," _* r3:operando  { return }
    / "tst"  _* r1:reg32 "," _* r2:reg32 "," _* r3:operando  { return }


// instrucciones branch
branch_inst
    = bcc:bcc_inst      { return }
    / blr:blr_inst      { return }
    / bl:bl_inst        { return }
    / br:br_inst        { return }
    / b:b_inst          { return }
    / cbnz:cbnz_inst    { return }
    / cbz:cbz_inst      { return }
    / ret:ret_inst      { return }
    / tbnz:tbnz_inst    { return }
    / tbz:tbz_inst      { return }

b_inst 
    = "b" _* r1:rel28   { return }

bcc_inst
    = "bcc" _* r1:rel21 { return }

bl_inst 
    = "bl" _* r1:rel28  { return }

blr_inst    
    = "blr" _* r1:reg64 { return }

br_inst  
    = "br" _* r1:reg64  { return }

cbnz_inst
    = "cbnz" _* r5:reg64 "," _* r6:rel21 { return }
    / "cbnz" _* r5:reg32 "," _* r6:rel21 { return }

cbz_inst
    = "cbz" _* r5:reg64 "," _* r6:rel21 { return }
    / "cbz" _* r5:reg32 "," _* r6:rel21 { return }

ret_inst 
    = "ret" _* "{" r1:reg64 "}" { return }

tbnz_inst
    = "tbnz" _* r1:reg64 "," _* r2:immediate "," _* r3:rel16 { return }
    / "tbnz" _* r1:reg32 "," _* r2:immediate "," _* r3:rel16 { return }

tbz_inst
    = "tbz" _* r1:reg64 "," _* r2:immediate "," _* r3:rel16     { return }
    / "tbz" _* r1:reg32 "," _* r2:immediate "," _* r3:rel16     { return }

// instrucciones atomic
atomic_inst
    = cas:cas_inst      { return }
    / ldao:ldao_inst    { return }
    / stao:stao_inst    { return }
    / swp:swp_inst      { return }

cas_inst
    = "cas" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64"]"                         { return }
    / "cas" ("a"/"l")? "p" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:reg64 "," "["r5:reg64"]"   { return }
    / "cas" ("a"/"l")? "p" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:reg32 "," "["r5:reg64"]"   { return }
    / "cas" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"                                    { return }
    / "cas" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"                                    { return }

ldao_inst
    = "ldao" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"     { return }
    / "ldao" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"               { return }
    / "ldao" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"               { return }

stao_inst
    = "stao" ("a"/"l")? ("b"/"h") _* r1:reg32 ","  _* "["r2:reg64"]"        { return }
    / "stao" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"   { return }
    / "stao" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"   { return }

swp_inst
    = "swp" ("a"/"l")? ("b"/"h") _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"      { return }
    / "swp" ("a"/"l")? _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64"]"                { return }
    / "swp" ("a"/"l")? _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64"]"                { return }

//instrucciones condicionales
cond_inst
    = ccmn:ccmn_inst    { return }
    / ccmp:ccmp_inst    { return }
    / cinc:cinc_inst    { return }
    / cinv:cinv_inst    { return }
    / cneg:cneg_inst    { return }
    / csel:csel_inst    { return }
    / cset:cset_inst    { return }
    / csetm:csetm_inst  { return }
    / csinc:csinc_inst  { return }
    / csinv:csinv_inst  { return }
    / csneg:csneg_inst  { return }

ccmn_inst
    = "ccmn" _* r1:reg64 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   { return }
    / "ccmn" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:cc       { return }
    / "ccmn" _* r1:reg32 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   { return }
    / "ccmn" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:cc       { return }

ccmp_inst
    = "ccmp" _* r1:reg64 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   { return }
    / "ccmp" _* r1:reg64 "," _* r2:reg64 "," _* r3:immediate "," _* r4:cc       { return }
    / "ccmp" _* r1:reg32 "," _* r2:immediate "," _* r3:immediate "," _* r4:cc   { return }
    / "ccmp" _* r1:reg32 "," _* r2:reg32 "," _* r3:immediate "," _* r4:cc       { return }

cinc_inst
    = "cinc" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc { return }
    / "cinc" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc { return }

cinv_inst
    = "cinv" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc { return }
    / "cinv" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc { return }

cneg_inst
    = "cneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:cc { return }
    / "cneg" _* r1:reg32 "," _* r2:reg32 "," _* r3:cc { return }

csel_inst
    = "csel" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc { return }
    / "csel" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc { return }

cset_inst
    = "cset" _* r1:reg64 "," _* r2:cc { return }
    / "cset" _* r1:reg32 "," _* r2:cc { return }

csetm_inst
    = "csetm" _* r1:reg64 "," _* r2:cc { return }
    / "csetm" _* r1:reg32 "," _* r2:cc { return }

csinc_inst
    = "csinc" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc { return }
    / "csinc" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc { return }

csinv_inst
    = "csinv" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc { return }
    / "csinv" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc { return }

csneg_inst
    = "csneg" _* r1:reg64 "," _* r2:reg64 "," _* r3:reg64 "," _* r4:cc { return }
    / "csneg" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* r4:cc { return }

cc = "eq"   { return }
    / "ne"  { return }
    / "hs"  { return }
    / "lo"  { return }
    / "mi"  { return }
    / "pl"  { return }
    / "vs"  { return }
    / "vc"  { return }
    / "hi"  { return }
    / "ls"  { return }
    / "ge"  { return }
    / "lt"  { return }
    / "gt"  { return }
    / "le"  { return }
    / "al"  { return }


//load and store instruccion

loadnstore_inst
    = r1:ldpsw_inst     { return }
    / r2:ldp_inst       { return }
    / r3:ldursbh_inst   { return }
    / r4:ldurbh_inst    { return }
    / r5:ldursw_inst    { return }
    / r6:ldur_inst      { return }
    / r7:prfm_inst      { return }
    / r8:sturbh_inst    { return }
    / r9:stur_inst      { return }
    / r10:stp_inst      { return }
    / r11:crc_inst      { return }
    / r12:loadAlm_inst  { return }
    / r13:system_inst   { return }


ldpsw_inst 
    = "ldpsw" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" { return }
    / "ldpsw" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:addr"]" { return }

ldp_inst
    = "ldp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" { return }

ldursbh_inst
    = "ld" ("u")? "rs" ("b"/"h") _* r1:reg64 "," _* "["r2:addr"]" { return }
    / "ld" ("u")? "rs" ("b"/"h") _* r1:reg32 "," _* "["r2:addr"]" { return }

ldurbh_inst
    = "ld" ("u")? "r" ("b"/"h") _* r1:reg32 "," _* "["r2:addr"]"    { return }
    / "ld" ("u")? "r" ("b"/"h") _* r1:reg32 "," _* r2:addr          { return }
ldursw_inst
    = "ld" ("u")? "rsw"  _* r1:reg64 "," _* "["r2:addr"]"  { return }

ldur_inst 
    = "ld" ("u")? "r"  _* r1:reg64 "," _* "["r2:addr"]"   { return }
    / "ld" ("u")? "r"  _* r1:reg32 "," _* "["r2:addr"]"   { return }
    / "ld" ("u")? "r"  _* r1:reg64 "," _* r2:addr         { return }
prfm_inst
    = "prfm" r1:reg32 "," _* r2:addr { return }
    / "prfm" r1:reg64 "," _* r2:addr { return }

sturbh_inst
    = "st" ("u")? "r" ("b"/"h") _* r1:reg64 "," _* "["r2:addr"]" { return }

stur_inst
    = "st" ("u")? "r"  _* r1:reg64 "," _* "["r2:addr"]" { return }
    / "st" ("u")? "r"  _* r1:reg32 "," _* "["r2:addr"]" { return }

stp_inst
    = "stp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:addr"]" { return }
    / "stp" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:addr"]" { return }



addr 
    = "=" l:label                                                                   { return }
    /  r1:reg32 _* "," _* r2:reg32 _* "," _* s:shift_op _* i2:immediate _*          { return }                
    /  r1:reg64 _* "," _* r2:reg64 _* "," _* s:shift_op _* i2:immediate _*          { return }                
    /   r1:reg64 _* "," _* i:immediate _* "," _* s:shift_op _* i2:immediate _*      { return }                
    /   r1:reg64 _* "," _* i:immediate _* "," _* e:extend_op _*                     { return }                
    /   r1:reg64 _* "," _* i:immediate _*                                           { return }                
    /   r1:reg64 _* "," _* i:reg64 _*                                               { return }                  
    /   r1:reg64 _*                                                                 { return }                
/* -------------------------------------------------------------------------- */
/*                    Instrucciones de suma de comprobacion                   */
/* -------------------------------------------------------------------------- */

crc_inst
    = r1:CRC32B_inst    { return }
    / r2:CRC32H_inst    { return }
    / r3:CRC32W_inst    { return }
    / r4:CRC32X_inst    { return }
    / r5:CRC32CB_inst   { return }
    / r6:CRC32CH_inst   { return }
    / r7:CRC32CW_inst   { return }
    / r8:CRC32CX_inst   { return }


CRC32B_inst = "crc32b" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      { return }
CRC32H_inst = "crc32h" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      { return }
CRC32W_inst = "crc32w" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32      { return }
CRC32X_inst = "crc32x" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg64      { return }
CRC32CB_inst = "crc32cb" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    { return }
CRC32CH_inst = "crc32ch" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    { return }
CRC32CW_inst = "crc32cw" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32    { return }
CRC32CX_inst = "crc32cx" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg64    { return }


/* -------------------------------------------------------------------------- */
/*            Instrucciones de carga y almacenamiento con atributos           */
/* -------------------------------------------------------------------------- */
loadAlm_inst
    =   r1:LDAXP_inst   { return }
    /   r2:LDAXR_inst   { return }
    /   r3:LDAXRB_inst  { return }
    /   r4:LDNP_inst    { return }
    /   r5:LDTR_inst    { return }
    /   r6:LDTRB_inst   { return }
    /   r7:LDTRSB_inst  { return }
    /   r8:LDTRSW_inst  { return }
    /   r9:STLR_inst    { return }
    /   r10:STLRB_inst  { return } 
    /   r11:STLXP_inst  { return }
    /   r12:STLXRB_inst { return }
    /   r13:STNP_inst   { return }
    /   r14:STTR_inst   { return }
    /   r15:STTRB_inst  { return }
    /   r16:STRB_inst   { return }
    /   r17:STR_inst    { return }
    /   r18:STP_inst    { return }

LDAXP_inst 
    =   "ld"("a")? "xp" _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)?"]"   { return }
    /   "ld"("a")? "xp" _* r1:reg64 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]"  { return }
LDAXR_inst 
    =   "ld"("a")? ("x")? "r" _* r1:reg32 "," _* "[" r2:reg64  ("," r4:operando)?"]" { return }
    /   "ld"("a")? ("x")? "r" _* r1:reg64 "," _* "[" r2:reg64 ("," r4:operando)? "]" { return }
LDAXRB_inst 
    =    "ld"("a")? ("x")? "r" ("b"/"h")? _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
LDNP_inst 
    =   "ldnp" _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
    /   "ldnp" _* r1:reg64 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
LDTR_inst 
    =   "ldtr" _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]" { return }
    /   "ldtr" _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" { return }
LDTRB_inst 
    =    "ldtr" ("b"/"h")? _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]" { return }
LDTRSB_inst
    =    "ldtrs" ("b"/"h")? _* r1:reg32 "," _* "[" r2:reg64 ("," r3:operando)? "]"  { return }
    /    "ldtrsb" ("b"/"h")? _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" { return }
LDTRSW_inst
    =    "ldtrsw" _* r1:reg64 "," _* "[" r2:reg64 ("," r3:operando)? "]" { return }
STLR_inst
    =   "stlr" _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
    /   "stlr" _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
STLRB_inst
    =   "stlr"  ("b"/"h")? _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]" { return }
STLXP_inst
    =   "st" ("l")? "xp" _* r1:reg32 "," _* r2:reg32 "," _* r3:reg32 "," _* "[" r4:reg64 ("," operando )? "]"       { return }
    /   "st" ("l")? "xp" _* r1:reg32 "," _* r2:reg64 "," _* r3:reg64 "," _* "[" r4:reg64 ("," operando )?"]"        { return }
    /   "st" ("l")? "xp"  _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)? "]"                    { return }
    /   "st" ("l")? "xp"  _* r1:reg32 "," _* r2:reg64 "," _* "[" r3:reg64 ("," r4:operando)? "]"                    { return }
STLXRB_inst 
    =   "st" ("l")? "xr" ("b"/"h")? _* r1:reg32 "," _* r2:reg32 "," _* "[" r3:reg64 ("," r4:operando)?"]" { return }
STNP_inst
    =   "stnp" _* r1:reg32 "," _* r2:reg32 "," _* "["r3:reg64 ("," r4:operando )?"]" { return }
    /   "stnp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64 ("," r4:operando )?"]" { return }
STTR_inst
    =   "sttr" _* r1:reg32 "," _* "["r2:reg64 ("," r3:operando )?"]" { return }
    /   "sttr" _* r1:reg64 "," _* "["r2:reg64 ("," r3:operando )?"]" { return }

STTRB_inst
     =   "sttr" ("b"/"h")? _* r1:reg32 "," _* "["r2:reg64 ("," r3:operando )?"]" { return }
STRB_inst
	=  "strb"  _* r1:reg32 "," _* "["r2:reg64 ("," _* r7:operando)?"]" { return }
STR_inst
	= "str" _* r2:reg64 "," _* "["r3:reg64 ("," operando )?"]" { return }
STP_inst
	= "stp" _* r1:reg64 "," _* r2:reg64 "," _* "["r3:reg64 ("," operando )?"]" { return }
/* -------------------------------------------------------------------------- */
/*                          Instrucciones al sistema                          */
/* -------------------------------------------------------------------------- */
system_inst
=   arg:AT_inst     { return }
/   arg:BRK_inst    { return }
/   arg:CLREX_inst  { return }
/   arg:DMB_inst    { return }
/   arg:DSB_inst    { return }
/   arg:ERET_inst   { return }
/   arg:HVC_inst    { return }
/   arg:ISB_inst    { return }
/   arg:MRS_inst    { return }
/   arg:MSR_inst    { return }
/   arg:NOP_inst    { return }
/   arg:SEV_inst    { return }
/   arg:SEVL_inst   { return }
/   arg:SMC_inst    { return }
/   arg:SVC_inst    { return }
/   arg:WFE_inst    { return }
/   arg:WFI_inst    { return }
/   arg:YIELD_inst  { return }


AT_inst     = "at" _* arg:at_operation "," _* arg2:reg64                { return }
BRK_inst    = "brk" _* arg:immediate                                    { return }
CLREX_inst  = "clrex" _* arg:(immediate)?                               { return }
DMB_inst    = "dmb" _* arg:barrierop                                    { return }
DSB_inst    = "dsb" _* arg:barrierop                                    { return }
ERET_inst   = "eret"                                                    { return }
HVC_inst    = "hvc" _* arg:immediate                                    { return }
ISB_inst    = "isb" _* ("sy")?                                          { return }
MRS_inst    = "mrs" _* arg:reg64 "," _* arg2:sysreg                     { return }
MSR_inst    = "msr" _* arg:msr_rules                                    { return }
NOP_inst    = "nop"                                                     { return }
SEV_inst    = "sev"                                                     { return }
SEVL_inst   = "sevl"                                                    { return }
SMC_inst    = "smc" _* arg:immediate                                    { return }
SVC_inst    = "svc" _* arg:immediate                                    { return }
WFE_inst    = "wfe"                                                     { return }
WFI_inst    = "wfi"                                                     { return }
YIELD_inst  = "yield"                                                   { return }

at_operation
=   "s1e1r"     { return }
/   "s1e1w"     { return }
/   "s1e0r"     { return }
/   "s1e0w"     { return }
/   "s1e2r"     { return }
/   "s1e2w"     { return }
/   "s1e3r"     { return }
/   "s1e3w"     { return }
/   "s12e1r"    { return }
/   "s12e1w"    { return }

barrierop
=   "sy"        { return }
/   "ish"       { return }
/   "ishst"     { return }
/   "nsh"       { return }
/   "nshst"     { return }
/   "osh"       { return }
/   "oshst"     { return }

sysreg
=   "sctlr"     { return }
/   "actlr"     { return }
/   "cpacr"     { return }
/   "scr"       { return }
/   "sder"      { return }
/   "nsacr"     { return }
/   "ttbr0"     { return }
/   "ttbr1"     { return }
/   "tcr"       { return }
/   "mair0"     { return }
/   "mair1"     { return }
/   "vbar"      { return }
/   "isr"       { return }
/   "fpcr"      { return }
/   "fpsr"      { return }
/   "dspsr"     { return }
/   "dfsr"      { return }
/   "elr_elx"   { return }
/   "sp_elx"    { return }
/   "nzcv"      { return }


msr_rules
=   arg1:sysreg "," _* arg:reg64        { return }
/   "spsel" _* "," _* arg:immediate     { return }
/   "daifset" _* "," _* arg:immediate   { return }
/   "daifclr" _* "," _* arg:immediate   { return }


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
    

reg32 = "w" arg:("30" / [12][0-9] / [0-9])          { return }
    / "sp"                                          { return }

operando = arg:reg64                                { return }
        / arg:reg32                                 { return }
        / arg:immediate                             { return }

rel16 = sign? [0-9]{1,16}
rel21 = sign? [0-9]{1,21}
rel28 = sign? [0-9]{1,28}
rel33 = arg1:sign? arg2:[0-9]{1,33} 
sign = arg:("+" / "-") 

//immediate = "#" [0-9]+
immediate "Inmediato"
    = ("#")?"'"arg:letter"'"                        { return  arg}
    / ("#")?"0x" arg:hex_literal                    { return arg } 
    / ("#")?"0b" arg:binary_literal                 { return arg } 
    / ("#")? arg:integer                            { return arg }
    / ("#")? sign arg:integer                           { return  arg}


extend_op "Operador de Extensión"
    = "UXTB"i { return }
    / "UXTH"i { return }
    / "UXTW"i { return }
    / "UXTX"i { return }
    / "SXTB"i { return }
    / "SXTH"i { return }
    / "SXTW"i { return }
    / "SXTX"i { return }

integer 
    = arg: [0-9]+ 
    {
    const loc = location()?.start;
    let idRoot = cst.newNode();
    newPath(idRoot, 'integer', [text()]);
    return new Primitive(loc?.line, loc?.column, idRoot, Type.WORD, parseInt(text(), 10));
  }


shift_op "Operador de Desplazamiento"
    = "LSL"i { return }
    / "LSR"i { return }
    / "ASR"i { return }

label "Etiqueta"
    = id:([a-zA-Z_][a-zA-Z0-9_]*) 
    {
    let completeId = id[0]+id[1]?.join('');
    return completeId; 
    }

letter
    = arg: [a-zA-Z] { return }

// Representa uno o más dígitos binarios
binary_literal
  = arg:[01]+ { return }
  
// Representa uno o más dígitos hexadecimales
hex_literal
    = arg:[0-9a-fA-F]+  { return }

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