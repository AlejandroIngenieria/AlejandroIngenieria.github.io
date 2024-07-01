class Strb extends Instruction {
    constructor(line, col, id, reg, variable) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.reg = reg;
        this.variable = variable;
    }

    execute(ast, env, gen) {
        // Obtener el valor del registro
        let regValue = ast.registers?.getRegister(this.reg);

        // Validar que el valor no sea nulo y que sea un byte válido
        if (!regValue || typeof regValue.value !== 'number' || regValue.value < 0 || regValue.value > 255) {
            ast.setNewError({ msg: `El valor en el registro no es un byte válido.`, line: this.line, col: this.col });
            return;
        }

        // Obtener la variable de destino
        let destinationVar = env?.getVariable(ast, this.line, this.col, this.variable);
        
        // Validar que la variable de destino exista
        if (destinationVar.type === Type.NULL) return;

        // Almacenar el byte en la variable de destino
        env.setVariable(ast, this.line, this.col, this.variable, { type: 'byte', value: regValue.value });
    }
}
