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
        let newValue
        if (this.variable.includes('x')){
            newValue = ast.registers?.getRegister(this.variable);
            if (newValue === null) return;
            let byteValue = newValue & 0xFF;

            let setReg = ast.registers?.setRegister(this.reg, newValue);
            if (setReg === null) {
            ast.setNewError({ msg: `El registro de destino es incorrecto. ldrb `, line: this.line, col: this.col });
            }

        }else{
            newValue = env?.getVariable(ast, this.line, this.col, this.variable);
            if (newValue.type === Type.NULL) return;

            let byteValue = newValue.value & 0xFF;

            let setReg = ast.registers?.setRegister(this.reg, { type: 'byte', value: byteValue });
            if (setReg === null) {
            ast.setNewError({ msg: `El registro de destino es incorrecto. ldrb `, line: this.line, col: this.col });
            }
        }
        
    }
}
