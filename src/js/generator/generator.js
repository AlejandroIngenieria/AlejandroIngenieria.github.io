class Generator {
    constructor() {
        this.code = '';
        this.temporal = 0;
        this.quadruples = [];  // Aquí se almacenan los cuádruplos
    }

    newTemp(){
        let temp = this.temporal;
        this.temporal++;
        return `t${temp}`;
    }

   
}