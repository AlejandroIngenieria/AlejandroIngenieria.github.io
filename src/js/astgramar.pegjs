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
 s= global*_ root:linea* _ { return generateCST(root);}

linea = ins:instruccion { return new Node("instruccion", ins); }
      / comentario 
      / etiq:etiqueta { return new Node("etiqueta", etiq); }
      / glo:global { return new Node("etiqueta", glo); }
      / ed:id { return new Node("id", id); }
      

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
        /id: ".space"

etiqueta = ide:id ":" _ { return new Node("etiqueta", ide); }

instruccion = ne:nemonico _ li:listaOp? _ { return new Node("instruccion", ne, li); }
			  

listaOp = op1:operando op2:("," _ operando)* { return new Node("listaOp", op1, op2); }

operando = regen:registroGen { return new Node("operando", regen); }
         / imd:immediateValue { return new Node("operando", imd); }
         / ident:id { return new Node("identifcador", ident); }
         / "[" op:operando "]" { return new Node("operando", op); }
         / "=" id:id { return new Node("operando", "="+id); }
         / val:valor { return new Node("operando", val); }
         



id =  id:[a-zA-Z_][a-zA-Z0-9_]* { return new Node("id", id); }
       

registroGen = 'x' regigen:[0-3][0-9]* { return new Node("registroGen", 'x'+regigen); }

registroFlo = 'W' regiflo:[0-3][0-9]* { return new Node("registroRed", 'w'+regiflo); }

immediateValue = '#' inmval:valor { return new Node("immediateValue", '#',inmval); }

registroPila = "SP" { return new Node ("registroPila","SP");}

valor = decim:[0-9]+ "." [0-9]+ { return new Node("decimal", decim); }
      / "0b" binar:[01]+ { return new Node("binario",'0b'+ binar ); }
      / ente:[0-9]+ { return new Node("entero", ente); }
      /"'" [A-Za-z]* "'"_
      /'"'[^"]*'"'_


comentario = ("//") (![\r\n] .)*_ 

_ = [ \t\n\r]*

nemonico = et1:etiquetaPila { return new Node("nemonico", et1); }
         / et2:etiquetaEsp { return new Node("nemonico", et2); }
         / et3:instSalto { return new Node("nemonico", et3); }
         / et4:instDes { return new Node("nemonico", et4); }
         / et5:instLog { return new Node("nemonico", et5); }
         / et6:instArit { return new Node("nemonico", et6); }
         / et7:instStore { return new Node("nemonico", et7); }
         / et8:instLoad { return new Node("nemonico", et8); }

instLoad = ins1:"LDR" { return new Node("instLoad", ins1); }
         / ins2:"LDRB" { return new Node("instLoad", ins2); }
         / ins3:"LDP" { return new Node("instLoad", ins3); }

instStore = inst2:"STRB" { return new Node("instStore", inst2); }
		  /inst1:"STR" { return new Node("instStore", inst1); }
          / inst3:"STP" { return new Node("instStore", inst3); }

instArit = arit1:"ADD" { return new Node("instArit", arit1); }
         / arit2:"SUB" { return new Node("instArit", arit2); }
         / arit3:"MUL" { return new Node("instArit", arit3); }
         / arit4:"UDIV" { return new Node("instArit", arit4); }
         / arit5:"SDIV" { return new Node("instArit", arit5); }

instLog = log1:"AND" { return new Node("instLog", log1); }
        / log1:"ORR" { return new Node("instLog", log2); }
        / log1:"EOR" { return new Node("instLog", log3); }
        / log1:"MVN" { return new Node("instLog", log4); }

instDes = des1:"LSL" { return new Node("instDes", des1); }
        / des2:"LSR" { return new Node("instDes", des2); }
        / des3:"ASR" { return new Node("instDes", des3); }
        / des4:"ROR" { return new Node("instDes", des4); }

instSalto = sal1:"BEQ"{ return new Node("instSalto", sal1); }
          / sal2:"BNE" { return new Node("instSalto", sal2); }
          / sal3:"BGT" { return new Node("instSalto", sal3); }
          / sal4:"BLT" { return new Node("instSalto", sal4); }
          / sal5:"B" { return new Node("instSalto", sal5); }
          / sal6:"BL" { return new Node("instSalto", sal6); }
          / sal7:"RET" { return new Node("instSalto", sal7); }

etiquetaEsp = esp1:"CMP" { return new Node("etiquetaEsp",esp1); }
            / esp2:"B.EQ" { return new Node("etiquetaEsp",esp2 ); }
            / esp3:"B.GT" { return new Node("etiquetaEsp", esp3); }
            / esp4:"B.LT" { return new Node("etiquetaEsp", esp4); }
            / esp5:"MOV" { return new Node("etiquetaEsp", esp5); }
            / esp6:"LOOP" { return new Node("etiquetaEsp", esp6); }
            / esp7:"SVC" { return new Node("etiquetaEsp",esp7 ); }

etiquetaPila = ms:"MSR" { return new Node("etiquetaPila", ms); }