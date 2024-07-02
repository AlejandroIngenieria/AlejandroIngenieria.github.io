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
            let num = 0
            if (this.reg.includes('x')){
                num = parseInt(this.reg.replace('x', ''))
            }else{
                num = parseInt(this.reg.replace('w', ''))
            }
            while (num != 0){
                valor = cadena.charAt(0);
                cadena = cadena.slice(1);
                console.log("nvalor: " + valor)
                num = num-1
            }
            
        }catch{
            let cadena = newvalue.toString()
            let num
            if (this.reg.includes('x')){
                num = parseInt(this.reg.replace('x', ''))
            }else{
                num = parseInt(this.reg.replace('w', ''))
            }
            while (num != 0){
                valor = cadena.charAt(0);
                cadena = cadena.slice(1);
                num = num-1
            }
        }
        
        console.log("valor: "+ valor)
        console.log("cadena: "+ newvalue)
        

        let setReg = '';
        

        if (this.reg.includes('x')) {
            setReg = ast.registers?.setRegister(this.reg, parseInt(valor,10));
        }else {
            setReg = ast.registersw?.setRegister2(this.reg, parseInt(valor,10));
        }

        if (setReg === null) ast.setNewError({ msg: `El registro de destino es incorrecto.`, line: this.line, col: this.col });



       /* if (this.reg.includes('w')){
            index = parseInt(this.reg.replace('w', '')) - 1 
            
        }else{
            index = parseInt(this.reg.replace('x', '')) - 1  
        }*/
         
        
    }
}
