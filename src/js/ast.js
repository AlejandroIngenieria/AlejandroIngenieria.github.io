let x;

document.getElementById("ast").addEventListener("click", function () {
  terminal.innerHTML = ""
  x = editor.getValue()
  const container = terminal;
  var cst = PEG.parse(x);


  vt = new VTree(container);
  var reader = new VTree.reader.Object();
  var data = reader.read(cst.root);
  vt.data(data)
    .update();


});

function isLexicalError(e) {
  const validIdentifier = /^[a-zA-Z_$][a-zA-Z0-9_$]*$/;
  const validInteger = /^[0-9]+$/;
  const validRegister = /^[a-zA-Z][0-9]+$/;
  const validCharacter = /^[a-zA-Z0-9_$,\[\]#"]$/;
  if (e.found) {
    if (!validIdentifier.test(e.found) &&
      !validInteger.test(e.found) &&
      !validRegister.test(e.found) &&
      !validCharacter.test(e.found)) {
      return true; // Error léxico
    }
  }
  return false; // Error sintáctico
}

playbtn.addEventListener("click", function () {

  terminal.innerHTML = ""
  x = editor.getValue()
  let result
  try {
    const tiempoInicio = performance.now();
    result = PEG.parse(x);
    const tiempoFin = performance.now();

    const tiempoTranscurrido = tiempoFin - tiempoInicio;

    terminal.innerHTML = `<h2>Analisis terminado sin errores en ${tiempoTranscurrido} milisegundos</h2>`
  } catch (e) {
    let errorHtml = `
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Línea</th>
                            <th>Columna</th>
                            <th>Tipo</th>
                            <th>Mensaje</th>
                        </tr>
                    </thead>
                    <tbody>
                `;
    if (e instanceof PEG.SyntaxError) {
      if (isLexicalError(e)) {
        errorHtml += `
                        <tr>
                            <td>1</td>
                            <td>${e.location.start.line}</td>
                            <td>${e.location.start.column}</td>
                            <td>Lexico</td>
                            <td>${e.message}</td>
                        </tr>
                    `;
        errorHtml += `
                    </tbody>
                </table>
                `;
        terminal.innerHTML = errorHtml;
      } else {
        errorHtml += `
                        <tr>
                            <td>1</td>
                            <td>${e.location.start.line}</td>
                            <td>${e.location.start.column}</td>
                            <td>Sintáctico</td>
                            <td>${e.message}</td>
                        </tr>
                    `;
        errorHtml += `
                    </tbody>
                </table>
                `;
        terminal.innerHTML = errorHtml;
      }
    } else {
      let errorHtml = `
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Línea</th>
                            <th>Columna</th>
                            <th>Tipo</th>
                            <th>Mensaje</th>
                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td>1</td>
                            <td>${e.location.start.line}</td>
                            <td>${e.location.start.column}</td>
                            <td>Lexico</td>
                            <td>${e.message}</td>
                        </tr>

                    </tbody>
                </table>
                `;
      terminal.innerHTML = errorHtml
    }
  }
});



cuadruplo.addEventListener('click', function () {
  terminal.innerHTML = "";
  x = editor.getValue();
  let result = PEG.parse(x);
  let cuadruplos = result.quad;
  console.log(cuadruplos);

  // Crear la tabla y el encabezado
  const tabla = document.createElement('table');
  tabla.classList.add('table', 'table-striped', 'table-bordered', 'table-hover');

  const encabezado = tabla.createTHead();
  const filaEncabezado = encabezado.insertRow();
  filaEncabezado.classList.add('table-primary');

  const encabezados = ['OP', 'ARG1', 'ARG2', 'ARG3', 'ARG4', 'RES'];
  for (const encabezadoTexto of encabezados) {
    const th = document.createElement('th');
    th.innerText = encabezadoTexto;
    filaEncabezado.appendChild(th);
  }

  // Agregar los datos de ArrCuad a la tabla
  const cuerpoTabla = tabla.createTBody();
  console.log(result);
  for (const cuadruplo of cuadruplos) {
    const fila = cuerpoTabla.insertRow();

    fila.insertCell().innerText = cuadruplo.op ? cuadruplo.op : "";
    fila.insertCell().innerText = cuadruplo.arg1 ? recorrer(cuadruplo.arg1) : "";
    fila.insertCell().innerText = cuadruplo.arg2 ? recorrer(cuadruplo.arg2) : "";
    fila.insertCell().innerText = cuadruplo.arg3 ? recorrer(cuadruplo.arg3) : "";
    fila.insertCell().innerText = cuadruplo.arg4 ? recorrer(cuadruplo.arg4) : "";
    fila.insertCell().innerText = cuadruplo.res ?  recorrer(cuadruplo.res) : "";
  }

  // Agregar la tabla al div con id 'terminal'
  terminal.appendChild(tabla);
});
