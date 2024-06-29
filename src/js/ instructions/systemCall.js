class SystemCall extends Instruction {

    constructor(line, col, id, arg) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.arg = arg;
    }

    execute(ast, env, gen) {
       
        // Obteniendo parámetros de la llamada
       
        let regtemp8 = ast?.registers?.getRegister('x8');
        
        // Validar número de llamada al sistema
        if(regtemp8 === 64){ // write
            let msg = ast?.registers?.getRegister('x1');
            let length = ast?.registers?.getRegister('x2');
            let strMsg = msg.value;
            for (let i = 0; i < length.value; i++) {
                ast.consola += strMsg[i];                
            }
            ast.consola += "\n";
        } 
        if(regtemp8 === 93){ // end
            ast.consola += ast?.registers?.getRegister('x0') + "\n";
            return;
        }
       
      
    }

    stdin(ast, env, gen){ // Entrada estándar
        // ToDo:
    }

    stdout(ast, env, gen){ // Salida estándar 
       
    }

    stderr(ast, env, gen){ // Salida de errores estándar
        // ToDo:
    }
}