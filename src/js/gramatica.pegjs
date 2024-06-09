{
    class node{
  		constructor( value, left=null, right=null ) {
      	    this.value = value;
     		this.left = left;
      		this.right = right;
    	}
    }
    
    function generateDot(root) {
        let dot = "graph G {\n";
        let counter = { count: 0 };

        function traverse(node) {
            let current = counter.count++;
            dot += `  ${current} [label="${node.value}"];\n`;
            if (node.left) {
                let left = traverse(node.left);
                dot += `  ${current} -- ${left};\n`;
            }
            if (node.right) {
                let right = traverse(node.right);
                dot += `  ${current} -- ${right};\n`;
            }
            return current;
        }
        traverse(root);
        dot += "}\n";
        return dot;
    }

    const errors = [];
  
    function reportError(message, location, type) {
        errors.push({ message, location, type });
    }
}

s1 = root:e { return generateDot(root);}

e = left:t "+" right:e { return new node("+",left,right); }
    / t

t = left:f "*" right:t { return new node("*",left,right); }
    / f

f = _ num:[0-9]+ _ { return new node("f",num); }




s = _ linea* _

linea = instruccion 
      / comentario 
      / etiqueta

etiqueta = id ":" _

instruccion = nemonico _ listaOp? _

listaOp = operando ("," _ operando)*

operando = registroGen 
         / immediateValue 
         / id 
         / "[" operando "]"

nemonico = etiquetaPila 
         / etiquetaEsp 
         / instSalto 
         / instDes 
         / instLog 
         / instArit 
         / instStore 
         / instLoad

instLoad = "LDR" 
         / "LDRB" 
         / "LDP"

instStore = "STR" 
          / "STRB" 
          / "STP"

instArit = "ADD" 
         / "SUB" 
         / "MUL" 
         / "UDIV" 
         / "SDIV"

instLog = "AND" 
        / "ORR" 
        / "EOR" 
        / "MVN"

instDes = "LSL" 
        / "LSR" 
        / "ASR" 
        / "ROR"

instSalto = "BEQ" 
          / "BNE" 
          / "BGT" 
          / "BLT" 
          / "B" 
          / "BL" 
          / "RET"  

etiquetaEsp = "CMP" 
            / "B.EQ" 
            / "B.GT" 
            / "B.LT" 
            / "MOV" 
            / "LOOP" 
            / "SVC"

etiquetaPila = "MSR"

id = "MSP"
   / "PSP"
   / [a-zA-Z_][a-zA-Z0-9_]*

registroGen = 'x' [0-3][0-9]*

registroFlo = 'v' [0-3][0-9]*

immediateValue = '#' valor

valor = decimal 
      / binario 
      / entero

entero = [0-9]+

decimal = [0-9]+ "." [0-9]+

binario = "0b" [01]+

comentario = ("//" / ";") (![\r\n] .)*_

error
  = . {
      reportError("Unexpected character: " + text(), location(), "lexico");
      return { type: "Error", message: "Unexpected character: " + text() };
    }

_ = [ \t\n\r]*