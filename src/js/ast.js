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
    result = PEG.parse(x);
    console.log(result);
    

  
    terminal.innerHTML = "<h2>Analisis terminado sin errores</h2>"
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
      terminal.innerHTML = "<h2>Error desconocido</h2>"
    }
  }
});



