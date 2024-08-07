let playbtn = document.getElementById('play')
let quadTable, symbolTable, Arm64Editor, consoleResult;
let tbody = document.getElementById('registros');
let step = document.getElementById('step')

if (tbody) {
  for (let index = 0; index < 32; index++) {
    const tr = document.createElement('tr');

    const td1 = document.createElement('td');
    td1.textContent = 'X' + index;
    tr.appendChild(td1);

    const td2 = document.createElement('td');
    td2.textContent = '';
    tr.appendChild(td2);

    tbody.appendChild(tr);
  }

  for (let index = 0; index < 32; index++) {
    const tr = document.createElement('tr');

    const td1 = document.createElement('td');
    td1.textContent = 'W' + index;
    tr.appendChild(td1);

    const td2 = document.createElement('td');
    td2.textContent = '';
    tr.appendChild(td2);

    tbody.appendChild(tr);
  }

  const tr = document.createElement('tr');

  const td1 = document.createElement('td');
  td1.textContent = 'SP';
  tr.appendChild(td1);

  const td2 = document.createElement('td');
  td2.textContent = '';
  tr.appendChild(td2);

  tbody.appendChild(tr);
}

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
    Swal.fire({
      toast: true,
      position: 'top-end', // Puedes cambiar la posición: 'top', 'top-start', 'top-end', 'center', 'center-start', 'center-end', 'bottom', 'bottom-start', 'bottom-end'
      icon: 'success', // Cambia el ícono a 'success', 'error', 'warning', 'info', o 'question'
      title: `Tiempo: ${tiempoTranscurrido} ms`,
      showConfirmButton: false, // Oculta el botón de confirmación
      timer: 3000, // Duración en milisegundos (3000 ms = 3 segundos)
      timerProgressBar: false, // Muestra una barra de progreso
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
      }
    });
    // Guardando data (variables)
    DataSectionExecuter(result, ast, env, gen);
    // Ejecutando instrucciones
    console.log(result);
    RootExecuter(result, ast, env, gen);
    // Generando gráfica
    console.log(ast);
    generateCst(result.CstTree);
    AddRegistros(ast.registers, ast.registersw)
    // Errores semanticos
    if (ast.getErrors()?.length === 0) terminal.innerHTML = ast.consola;
    else {
      const tableRows = ast.getErrors().map(item => `
  <tr>
    <td>Semantico</td>
    <td>${item.msg}, linea ${item.line}, columna ${item.col}</td>
  </tr>
`).join('');
      terminal.innerHTML = `<table class="errorTable">
                                          <thead>
                                            <tr>
                                              <th>Tipo de error</th>
                                              <th>Mensaje</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            ${tableRows}
                                          </tbody>
                                        </table>
                                        `
    }
  } catch (e) {
    if (e instanceof PEGGY.SyntaxError) {
      if (isLexicalError(e)) {
        terminal.innerHTML = `<table class="errorTable">
                                          <thead>
                                            <tr>
                                              <th>Tipo de error</th>
                                              <th>Mensaje</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td>Error Léxico</td>
                                              <td>${e.message}</td>
                                            </tr>
                                          </tbody>
                                        </table>
                                        `
      } else {
        terminal.innerHTML = `<table>
                                          <thead>
                                            <tr>
                                              <th>Tipo de error</th>
                                              <th>Mensaje</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td>Error Sintáctico</td>
                                              <td>${e.message}</td>
                                            </tr>
                                          </tbody>
                                        </table>
                                        `
      }
    } else {
      terminal.innerHTML = `<table>
                                          <thead>
                                            <tr>
                                              <th>Tipo de error</th>
                                              <th>Mensaje</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            <tr>
                                              <td>Error desconocido</td>
                                              <td>${e.message}</td>
                                            </tr>
                                          </tbody>
                                        </table>
                                        `
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
  M.toast({ html: mensaje, displayLength: duracion, classes: type });
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

function AddRegistros(data1, data2) {
  tbody.innerHTML = '';
  data1.registers.forEach((item, index) => {
    const tr = document.createElement('tr');

    const td1 = document.createElement('td');
    td1.textContent = 'X' + index;
    tr.appendChild(td1);

    const td2 = document.createElement('td');
    td2.textContent = typeof (item) === 'object' ? item.value : item;
    tr.appendChild(td2);

    tbody.appendChild(tr);


  }
  );
  data2.registers.forEach((item, index) => {
    const tr = document.createElement('tr');

    const td1 = document.createElement('td');
    td1.textContent = 'W' + index;
    tr.appendChild(td1);

    const td2 = document.createElement('td');
    td2.textContent = typeof (item) === 'object' ? item.value : item;
    tr.appendChild(td2);

    tbody.appendChild(tr);
  });

  const tr = document.createElement('tr');

  const td1 = document.createElement('td');
  td1.textContent = 'SP'
  tr.appendChild(td1);

  const td2 = document.createElement('td');
  td2.textContent = ''
  tr.appendChild(td2);

  tbody.appendChild(tr);
}

playbtn.addEventListener('click', async () => await analysis());
step.addEventListener('click', async () => await steps())

let counter = -1
async function steps() {
  try {
    counter++;
    // Creando ast auxiliar
    let ast = new Ast();
    // Creando entorno global
    let env = new Environment(null, 'Global');
    // Creando generador
    let gen = new Generator();
    // Creando parser
    let text = editor.getValue()
    let result = PEGGY.parse(text);
    // Guardando data (variables)
    DataSectionExecuter(result, ast, env, gen);
    // Creando analizador
    if (result) {
      instrucciones = result.textSection.instructions
      const filteredArray = instrucciones.filter(element => element !== undefined);
      //console.log(filteredArray)
      lineas = text.split('\n')
      linea = filteredArray[counter].line
      document.getElementById('linea').innerHTML = linea
      bloque = ''
      for (let index = 0; index < linea; index++) {
        bloque += lineas[index] + '\n'
      }
      let resultB = PEGGY.parse(bloque);
      // Guardando data (variables)
      DataSectionExecuter(resultB, ast, env, gen);
      // Ejecutando instrucciones
      console.log(resultB);
      RootExecuter(resultB, ast, env, gen);
      // Generando gráfica
      console.log(ast);
      generateCst(resultB.CstTree);
      AddRegistros(ast.registers, ast.registersw)
      if (ast.getErrors()?.length === 0) terminal.innerHTML = ast.consola;
      
    }
  } catch (error) {
    Swal.fire({
      toast: true,
      position: 'top-end', // Puedes cambiar la posición: 'top', 'top-start', 'top-end', 'center', 'center-start', 'center-end', 'bottom', 'bottom-start', 'bottom-end'
      icon: 'success', // Cambia el ícono a 'success', 'error', 'warning', 'info', o 'question'
      title: 'Ya terminaste todas las lineas',
      showConfirmButton: false, // Oculta el botón de confirmación
      timer: 3000, // Duración en milisegundos (3000 ms = 3 segundos)
      timerProgressBar: false, // Muestra una barra de progreso
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
      }
    });
    terminal.innerHTML=''
    counter = -1
  }

}
