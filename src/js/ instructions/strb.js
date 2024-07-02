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
        console.log("reg: "+ this.variable.name)
        

        let setReg = '';

        

        if (this.variable.name.includes('x')) {
            setReg = ast.registers?.setRegister(this.variable.name,newvalue);
        }else {
            setReg = ast.registersw?.setRegister2(this.variable.name, newvalue);
        }

        if (setReg === null) ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });



       /* if (this.reg.includes('w')){
            index = parseInt(this.reg.replace('w', '')) - 1 
            
        }else{
            index = parseInt(this.reg.replace('x', '')) - 1  
        }*/
         
        
    }
}
