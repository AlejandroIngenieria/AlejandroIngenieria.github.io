class Ldrb extends Instruction {
    constructor(line, col, id, reg, variable) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.reg = reg;
        this.variable = variable;
    }

    execute(ast, env, gen) {
        // Obteniendo valor
        let newValue = env?.getVariable(ast, this.line, this.col, this.variable);

        // Validando retorno
        if (newValue.type === Type.NULL) return;

        // Si el valor no es de tipo byte, manejar el error o convertir el valor apropiadamente
        if (typeof newValue.value !== 'number' || newValue.value < 0 || newValue.value > 255) {
            ast.setNewError({ msg: `El valor no es un byte válido.`, line: this.line, col: this.col });
            return;
        }

        // Cargar solo un byte (el valor debe ser de 0 a 255)
        let byteValue = newValue.value & 0xFF;

        // Set register
        let setReg = ast.registers?.setRegister(this.reg, { type: 'byte', value: byteValue });
        if (setReg === null) {
            ast.setNewError({ msg: `El registro de destino es incorrecto. ldrb `, line: this.line, col: this.col });
        }
    }
}
