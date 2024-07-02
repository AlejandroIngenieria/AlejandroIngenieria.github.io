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
        // Obteniendo valor
        let newvalue
        if (this.reg.includes('x')){
            newvalue = ast.registers?.getRegister(this.reg);
        }else{
            newvalue = ast.registersw?.getRegister2(this.reg); 
        }

        console.log("valor: "+ newvalue)
        console.log("valor2: "+ ast.registers.getRegister(this.variable.name).value)
        
        

        let setReg = '';

               
        
        if (this.variable.name.includes('x')) {
            ast.registers.getRegister(this.variable.name).value = newvalue
            setReg = ast.registers.getRegister(this.variable.name)
        }else {
            ast.registers.getRegister2(this.variable.name).value = newvalue
            setReg = ast.registers.getRegister2(this.variable.name)
        }

        if (setReg === null) ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });
        


       /* if (this.reg.includes('w')){
            index = parseInt(this.reg.replace('w', '')) - 1 
            
        }else{
            index = parseInt(this.reg.replace('x', '')) - 1  
        }*/
         
        
    }
}
