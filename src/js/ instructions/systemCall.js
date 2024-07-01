class SystemCall extends Instruction {

    constructor(line, col, id, arg) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.arg = arg;
    }

    async execute(ast, env, gen) {
        // Obteniendo parámetros de la llamada
        let regtemp8 = ast?.registers?.getRegister('x8');
        if (regtemp8 === 63) { // read
            try {
                // Espera la entrada del usuario de manera síncrona
                let stdInputText = prompt("ingrese dato");
                let idBuffer = ast?.registers?.getRegister('x1')?.id;
                let length = ast?.registers?.getRegister('x2');
                // Creando nuevo símbolo
                let sym = new Symbol(this.line, this.col, idBuffer, Type.ASCIZ, '');
                console.log("SYM = "+sym.value)
                sym.value = ''
                // Agregando valores según tamaño
                for (let i = 0; i < length; i++) {
                    sym.value += stdInputText[i] ?? '';
                }
                // Guardando la data obtenida
                console.log("SYM = "+sym.value)
                env.setVariable(ast, this.line, this.col, idBuffer, sym);
            } catch (error) {
                // Manejo de error si el usuario cancela
                console.error('Error:', error);
            }
        } else if (regtemp8 === 64) { // write
            let msg = ast?.registers?.getRegister('x1');
            let length = ast?.registers?.getRegister('x2');
            let strMsg = msg.value;
            for (let i = 0; i < length; i++) {
                if (strMsg[i] !== undefined) ast.consola += strMsg[i];
                
            }
            ast.consola += "<br>";
        } else if (regtemp8 === 93) { // end
            ast.consola += ast?.registers?.getRegister('x0') + "<br>";
            return;
        }
    }
}
