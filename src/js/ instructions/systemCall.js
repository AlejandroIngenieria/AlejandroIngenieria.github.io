async function obtenerValor() {
    return new Promise((resolve, reject) => {
        Swal.fire({
            title: 'Input your value',
            input: 'text',
            inputPlaceholder: 'Enter something',
            showCancelButton: true,
            confirmButtonText: 'Submit',
            cancelButtonText: 'Cancel',
            inputValidator: (value) => {
                if (!value) {
                    return 'You need to enter something!'
                }
            }
        }).then((result) => {
            if (result.isConfirmed) {
                resolve(result.value); // Resuelve la promesa con el valor ingresado
            } else {
                reject('User canceled'); // En caso de cancelación por el usuario
            }
        });
    });
}

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
            const stdInputText = await obtenerValor();
            console.log("Valor ingresado = "+stdInputText)
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

