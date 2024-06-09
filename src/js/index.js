let playbtn = document.getElementById('play')
let clearbtn = document.getElementById('clear')
let terminal = document.getElementById('terminal')
let editor

// Initialize CodeMirror
document.addEventListener("DOMContentLoaded", function () {
    editor = CodeMirror.fromTextArea(document.getElementById('editor'), {
        lineNumbers: true,
        mode: "javascript",
        theme: "monokai",
        autoCloseTags: true,
        matchBrackets: true,
    });
});

clearbtn.addEventListener('click', function () {
    editor.setValue('')
    terminal.innerText = ""
});

// Obtener el botón upload y abrir el selector de archivos
document.getElementById('upload').addEventListener('click', function () {
    document.getElementById('file-input').click();
});

// Leer el archivo seleccionado y poner su contenido en CodeMirror
document.getElementById('file-input').addEventListener('change', function (event) {
    var file = event.target.files[0];
    if (file && file.name.endsWith('.s')) {
        var reader = new FileReader();
        reader.onload = function (e) {
            editor.setValue(e.target.result);
        };
        reader.readAsText(file);
    } else {
        alert('Por favor seleccione un archivo con extensión .s');
    }
});