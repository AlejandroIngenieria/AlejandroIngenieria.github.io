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
 //JSON.stringify(result.quad, void 0, 2)

 //document.getElementById('innertable').innerHTML = buildTable(JSON.stringify(result.quad, void 0, 2));
 terminal.appendChild(buildTable(result.quad, void 0, 2));
 console.log(buildTable(JSON.stringify(result.quad, void 0, 2)));
 
});

function buildTable(a) {
  var e = document.createElement("table"), d, b;
  if (isArray(a))
      return buildArray(a);
  for (var c in a)
      "object" != typeof a[c] || isArray(a[c]) ? "object" == typeof a[c] && isArray(a[c]) ? (d = e.insertRow(-1),
      b = d.insertCell(-1),
      b.colSpan = 2,
      b.innerHTML = '<div class="td_head">' + encodeText(c) + '</div><table style="width:100%">' + $(buildArray(a[c]), !1).html() + "</table>") : (d = e.insertRow(-1),
      b = d.insertCell(-1),
      b.innerHTML = "<div class='td_head'>" + encodeText(c) + "</div>",
      d = d.insertCell(-1),
      d.innerHTML = "<div class='td_row_even'>" + encodeText(a[c]) + "</div>") : (d = e.insertRow(-1),
      b = d.insertCell(-1),
      b.colSpan = 2,
      b.innerHTML = '<div class="td_head">' + encodeText(c) + '</div><table style="width:100%">' + $(buildTable(a[c]), !1).html() + "</table>");
  return e
}
function isArray(a) {
  return "[object Array]" === Object.prototype.toString.call(a)
}



function buildArray(a) {
  var e = document.createElement("table"), d, b, c = !1, p = !1, m = {}, h = -1, n = 0, l;
  l = "";
  if (0 == a.length)
      return "<div></div>";
  d = e.insertRow(-1);
  for (var f = 0; f < a.length; f++)
      if ("object" != typeof a[f] || isArray(a[f]))
          "object" == typeof a[f] && isArray(a[f]) ? (b = d.insertCell(h),
          b.colSpan = 2,
          b.innerHTML = '<div class="td_head"></div><table style="width:100%">' + $(buildArray(a[f]), !1).html() + "</table>",
          c = !0) : p || (h += 1,
          p = !0,
          b = d.insertCell(h),
          m.empty = h,
          b.innerHTML = "<div class='td_head'>&nbsp;</div>");
      else
          for (var k in a[f])
              l = "-" + k,
              l in m || (c = !0,
              h += 1,
              b = d.insertCell(h),
              m[l] = h,
              b.innerHTML = "<div class='td_head'>" + encodeText(k) + "</div>");
  c || e.deleteRow(0);
  n = h + 1;
  for (f = 0; f < a.length; f++)
      if (d = e.insertRow(-1),
      td_class = isEven(f) ? "td_row_even" : "td_row_odd",
      "object" != typeof a[f] || isArray(a[f]))
          if ("object" == typeof a[f] && isArray(a[f]))
              for (h = m.empty,
              c = 0; c < n; c++)
                  b = d.insertCell(c),
                  b.className = td_class,
                  l = c == h ? '<table style="width:100%">' + $(buildArray(a[f]), !1).html() + "</table>" : " ",
                  b.innerHTML = "<div class='" + td_class + "'>" + encodeText(l) + "</div>";
          else
              for (h = m.empty,
              c = 0; c < n; c++)
                  b = d.insertCell(c),
                  l = c == h ? a[f] : " ",
                  b.className = td_class,
                  b.innerHTML = "<div class='" + td_class + "'>" + encodeText(l) + "</div>";
      else {
          for (c = 0; c < n; c++)
              b = d.insertCell(c),
              b.className = td_class,
              b.innerHTML = "<div class='" + td_class + "'>&nbsp;</div>";
          for (k in a[f])
              c = a[f],
              l = "-" + k,
              h = m[l],
              b = d.cells[h],
              b.className = td_class,
              "object" != typeof c[k] || isArray(c[k]) ? "object" == typeof c[k] && isArray(c[k]) ? b.innerHTML = '<table style="width:100%">' + $(buildArray(c[k]), !1).html() + "</table>" : b.innerHTML = "<div class='" + td_class + "'>" + encodeText(c[k]) + "</div>" : b.innerHTML = '<table style="width:100%">' + $(buildTable(c[k]), !1).html() + "</table>"
      }
  return e
}
function encodeText(a) {
  return $("<div />").text(a).html()

}
function isEven(a) {
  return 0 == a % 2
}