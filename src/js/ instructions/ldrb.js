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
        let newvalue
        if (this.variable.name.includes('x')){
            let reg = this.variable.name
            newvalue = ast.registers?.getRegister(reg);
        }
        let valor
        try{
            let cadena = newvalue.value.toString()
            valor = cadena.charAt(0);
            cadena = cadena.slice(1);
            newvalue = parseInt(cadena,10)
        }catch{
            let cadena = newvalue.toString()
            valor= cadena.charAt(0);
            cadena = cadena.slice(1);
            newvalue = parseInt(cadena,10) 
        }
        
        console.log("valor: "+ valor)
        console.log("cadena: "+ newvalue)
        

        let setReg = '';
        let nuReg =''
        

        if (this.reg.includes('x')) {
            let nreg = this.variable.name
            setReg = ast.registers?.setRegister(this.reg, parseInt(valor,10));
            nuReg = ast.registers?.setRegister(nreg, newvalue);
        }else {
            let nreg = this.variable.name
            setReg = ast.registersw?.setRegister2(this.reg, parseInt(valor,10));
            nuReg = ast.registers?.setRegister(nreg, newvalue);
        }

        if (setReg === null) ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });



       /* if (this.reg.includes('w')){
            index = parseInt(this.reg.replace('w', '')) - 1 
            
        }else{
            index = parseInt(this.reg.replace('x', '')) - 1  
        }*/
         
        
    }
}
