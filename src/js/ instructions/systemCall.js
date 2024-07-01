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
            // realizando una lectura en el sistema
            const stdInputText = await window.openModal();
            const idBuffer = ast?.registers?.getRegister('x1')?.id;
            let length = ast?.registers?.getRegister('x2');
            // Creando nuevo simbolo
            let sym = new Symbol(this.line, this.col, idBuffer, Type.ASCIZ, '');
            // Agregando valores segun tamaño
            for (let i = 0; i < length.value; i++) {
                sym.value += stdInputText[i] ?? '0';
            }
            // Guardando la data obtenida
            env.setVariable(ast, this.line, this.col, idBuffer, sym)
        } else if (regtemp8 === 64) { // write
            let msg = ast?.registers?.getRegister('x1');
            let length = ast?.registers?.getRegister('x2');
            let strMsg = msg.value;
            for (let i = 0; i < length; i++) {
                ast.consola += strMsg[i];
            }
            ast.consola += "<br>";
        } else if (regtemp8 === 93) { // end
            ast.consola += ast?.registers?.getRegister('x0') + "<br>";
            return;
        }

    }
}