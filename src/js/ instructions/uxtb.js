class Uxtb extends Instruction {
    constructor(line, col, id, obj, value) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.obj = obj;
        this.value = value;
    }

    execute(ast, gen, env) {
        let newValue;

        // Validar tipo de valor
        if (this.value instanceof Expression) {
            newValue = this.value?.execute(ast, env, gen);
        } else if (!this.value.includes('x') && !this.value.includes('w')) {
            newValue = parseInt(this.value, 10);
        } else if (this.value.includes('w')) {
            newValue = ast.registersw?.getRegister2(this.value);
        } else {
            newValue = ast.registers?.getRegister(this.value);
        }

        console.log(`Valor original: ${newValue}`);

        // Validaciones
        if (newValue === null) {
            ast.setNewError({ msg: `El valor de asignación es incorrecto.`, line: this.line, col: this.col });
            return;
        }

        // Extender el byte menos significativo a 64 bits
        newValue = newValue & 0xFF;
        console.log(`Valor extendido: ${newValue}`);

        // Set register
        let setReg;

        if (this.obj.includes('x')) {
            setReg = ast.registers?.setRegister(this.obj, newValue);
        } else {
            setReg = ast.registersw?.setRegister2(this.obj, newValue);
        }

        if (setReg === null) {
            ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });
        }
    }
}
