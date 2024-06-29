class Ast {
    constructor() {
        this.console = "VALIDO";
        this.errors = [];
        this.registers = new Registers()
        this.registersw = new Registers()
        this.consola = "";
    }

    setNewError(err){
        this.errors.push(err);
    }

    getErrors(){
        return this.errors;
    }

    getConsole(){
        return this.console;
    }
}