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

    x = editor.getValue()
    terminal.innerHTML= ""
    try {
      PEG.parse(x);
      terminal.innerHTML = "<h2>Analisis terminado sin errores</h2>"
    } catch (error) {
      terminal.innerHTML = `<h2>Error:${error}</h2>`
    }


});



