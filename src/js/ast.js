let x;

document.getElementById("play").addEventListener("click", function () {

    x = document.getElementById("editor").textContent;
    const container = document.getElementById("terminal");
    var cst = PEG.parse(x);
    console.log(cst);
    vt = new VTree(container);
    var reader = new VTree.reader.Object();
    var data = reader.read(cst);
    vt.data(data)
      .update();


});



