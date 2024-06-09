let x;

document.getElementById("ast").addEventListener("click", function () {
  terminal.innerHTML = ""
  x = editor.getValue()
  const container = terminal;
  var cst = PEG.parse(x);
  console.log(cst);
  vt = new VTree(container);
  var reader = new VTree.reader.Object();
  var data = reader.read(cst);
  vt.data(data)
    .update();


});

playbtn.addEventListener("click", function () {

  terminal.innerHTML = ""
  x = editor.getValue()
  try {
    PEG.parse(x);
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

    if (e.location) {
      errorHtml += `
                        <tr>
                            <td>1</td>
                            <td>${e.location.start.line}</td>
                            <td>${e.location.start.column}</td>
                            <td>Sintáctico</td>
                            <td>${e.message}</td>
                        </tr>
                    `;
    } else {
      errorHtml += `
                        <tr>
                            <td>1</td>
                            <td>-</td>
                            <td>-</td>
                            <td>Lexico</td>
                            <td>${e.message}</td>
                        </tr>
                    `;
    }

    if (e.errors && e.errors.length) {
      e.errors.forEach((error, index) => {
        errorHtml += `
                            <tr>
                                <td>${index + 2}</td>
                                <td>${error.location.start.line}</td>
                                <td>${error.location.start.column}</td>
                                <td>${error.type}</td>
                                <td>${error.message}</td>
                            </tr>
                        `;
      });
    }

    errorHtml += `
                    </tbody>
                </table>
                `;
    terminal.innerHTML = errorHtml;
  }
});



