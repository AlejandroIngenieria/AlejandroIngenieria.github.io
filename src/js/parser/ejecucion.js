let playbtn = document.getElementById('play')
let quadTable, symbolTable, Arm64Editor, consoleResult;


const analysis = async () => {

    
    try {
        // Creando ast auxiliar
        let ast = new Ast();
        // Creando entorno global
        let env = new Environment(null, 'Global');
        // Creando generador
        let gen = new Generator();
        let text = editor.getValue()
        // Obteniendo raiz del árbol
        const tiempoInicio = performance.now();
        let result = PEGGY.parse(text);
        const tiempoFin = performance.now();
        const tiempoTranscurrido = tiempoFin - tiempoInicio;
        document.getElementById('time').innerHTML = `Tiempo: ${tiempoTranscurrido}`
        // Guardando data (variables)
        DataSectionExecuter(result, ast, env, gen);
        // Ejecutando instrucciones
        console.log(result);
        RootExecuter(result, ast, env, gen);
        // Generando gráfica
        generateCst(result.CstTree);
        // Generando cuádruplos
        console.log(ast.getErrors());
        // Agregando salida válida en consola
        if (ast.getErrors()?.length === 0) terminal.innerHTML=ast.getConsole();
        else terminal.innerHTML ='Se encontraron algunos errores en la ejecución.';
    } catch (e) {
        if (e instanceof PEGGY.SyntaxError) {
            if (isLexicalError(e)) {
                consoleResult.setValue('Error Léxico: ' + e.message);
            } else {
                consoleResult.setValue('Error Sintáctico: ' + e.message);
            }
        } else {
            console.error('Error desconocido:', e);
        }
    }

    
   
}

// Función para agregar datos a la tabla de cuadruplos
const addDataToQuadTable = (data) => {
    for (let quad of data) {
        quadTable.row.add(quad?.getQuadruple()).draw();
    }
}



// Función para mostrar un toast
function mostrarToast(mensaje, duracion, type) {
    M.toast({html: mensaje, displayLength: duracion, classes: type});
}


const generateCst = (CstObj) => {
    // Creando el arreglo de nodos
    let nodes = new vis.DataSet(CstObj.Nodes);
    // Creando el arreglo de conexiones
    let edges = new vis.DataSet(CstObj.Edges);
    // Obteniendo el elemento a imprimir
    let container = document.getElementById('mynetwork');
    // Agregando data y opciones
    let data = {
        nodes: nodes,
        edges: edges
    };

    let options = {
        layout: {
            hierarchical: {
                direction: "UD",
                sortMethod: "directed",
            },
        },
        nodes: {
            shape: "box"
        },
        edges: { 
            arrows: "to",
        },
    };

    // Generando grafico red
    let network = new vis.Network(container, data, options);
}



playbtn.addEventListener('click', () => analysis());