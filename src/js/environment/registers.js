class Registers {
    constructor() {
        this.registers = new Array(32).fill(0);
    }

    getRegister(registerIndex) {
        try {
            // Validaciones
            if (!registerIndex.includes('x')) {
                return null;
            }
            let regNumber = parseInt(registerIndex.replace('x', ''));

            // Obtiene el valor de un registro
            if (regNumber >= 0 && regNumber < 32) {

                return this.registers[regNumber];
            } else {
                return null;
            }
        } catch (e) {
            return null;
        }
    }

    setRegister(registerIndex, value) {
        try {
            // Validaciones
            if (!registerIndex.includes('x')) {
                return null;
            }
            let regNumber = parseInt(registerIndex.replace('x', ''));
            // Establecer el valor de un registro específico
            if (regNumber >= 0 && regNumber < 32) {
                this.registers[regNumber] = value;
            } else {
                return null;
            }
        } catch (e) {
            return null;
        }
    }

    getRegister2(registerIndex) {
        console.log('entro')
        try {
            // Validaciones
            if (!registerIndex.includes('w')) {
                return null;
            }
            let regNumber = parseInt(registerIndex.replace('w', ''));
            console.log(regNumber)
            // Obtiene el valor de un registro
            if (regNumber >= 0 && regNumber < 32) {

                return this.registers[regNumber];
            } else {
                return null;
            }
        } catch (e) {
            return null;
        }
    }

    setRegister2(registerIndex, value) {
        try {
            // Validaciones
            if (!registerIndex.includes('w')) {
                return null;
            }
            let regNumber = parseInt(registerIndex.replace('w', ''));
            // Establecer el valor de un registro específico
            if (regNumber >= 0 && regNumber < 32) {
                this.registers[regNumber] = value;
            } else {
                return null;
            }
        } catch (e) {
            return null;
        }
    }

    getRegisterHexa() {
        let hexaArr = [];
        for (let i = 0; i < this.registers.length; i++) {
            hexaArr.push({ Register: `X${i}`, Data: this.registers[i]?.value?.toString(16) ?? '0x000000' });
        }
        return hexaArr;
    }

    getAllRegisters() {
        return this.registers;
    }
}