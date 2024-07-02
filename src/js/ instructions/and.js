class And extends Instruction {

    constructor(line, col, id, obj, value1, value2) {
        super();
        this.line = line;
        this.col = col;
        this.id = id;
        this.obj = obj;
        this.value1 = value1;
        this.value2 = value2;
    }

    execute(ast, env, gen) {
        let newValue1
        let newValue2
        // Validar tipo de valor1
        if (this.value1 instanceof Expression) newValue1 = this.value1?.execute(ast, env, gen);
        else if(!this.value1.includes('x') && !this.value1.includes('w')) newValue1 = parseInt( this.value1, 10);
        else if (this.value1.includes('w')) newValue1 = ast.registersw?.getRegister2(this.value1);
        else newValue1 = ast.registers?.getRegister(this.value1);

        console.log(newValue1)
        
        // Validaciones
        if (newValue1 === null) ast.setNewError({ msg: `El valor1 de asignación es incorrecto.`, line: this.line, col: this.col });
       
       // Validar tipo de valor
       if (this.value2 instanceof Expression) newValue2 = this.value2?.execute(ast, env, gen);
       else if(!this.value2.includes('x') && !this.value2.includes('w')) newValue2 = parseInt( this.value2, 10);
       else if (this.value2.includes('w')) newValue2 = ast.registersw?.getRegister2(this.value2);
       else newValue2 = ast.registers?.getRegister(this.value2);

       console.log(newValue2)
       // Validaciones
       if (newValue2 === null) ast.setNewError({ msg: `El valor2 de asignación es incorrecto.`, line: this.line, col: this.col });
       

        // Set register
        let setReg = '';
        let result=0;

        result = newValue1 & newValue2

        console.log("Resultado: "+result)

        if (this.obj.includes('x')) setReg = ast.registers?.setRegister(this.obj, result);
        else setReg = ast.registersw?.setRegister2(this.obj, result);
        
        if (setReg === null) ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });
        
    }
}