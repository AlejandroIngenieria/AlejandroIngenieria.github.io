let playbtn = document.getElementById('play')
let clearbtn = document.getElementById('clear')
let terminal = document.getElementById('terminal')
let editor
let download = document.getElementById('download')
let upload = document.getElementById('upload')
let tabs = document.getElementById('tabs');
let cuadruplo = document.getElementById('cuadruplo')

let filesContent = {};


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
upload.addEventListener('click', function () {
    document.getElementById('file-input').click();
});

// Leer los archivos seleccionados y crear pestañas
document.getElementById('file-input').addEventListener('change', function (event) {
    let files = event.target.files;
    for (let file of files) {
        if (file && file.name.endsWith('.s')) {
            let reader = new FileReader();
            reader.onload = function (e) {
                filesContent[file.name] = e.target.result;
                createTab(file.name);
                editor.setValue(e.target.result); // Set the content of the last file
            };
            reader.readAsText(file);
        } else {
            alert('Por favor seleccione archivos con extensión .s');
        }
    }
});

// Crear pestaña
function createTab(fileName) {
    let tab = document.createElement('button');
    tab.textContent = fileName;
    tab.className = 'tab';
    tab.addEventListener('click', function () {
        editor.setValue(filesContent[fileName]);
    });
    tabs.appendChild(tab);
}


download.addEventListener('click', function () {
    // Obtén el contenido del editor
    var editorContent = editor.getValue();

    // Crea un Blob con el contenido
    var blob = new Blob([editorContent], { type: 'text/plain' });

    // Crea un enlace para la descarga
    var downloadLink = document.createElement('a');
    downloadLink.href = window.URL.createObjectURL(blob);
    downloadLink.download = 'codigo.s'; // Nombre del archivo de descarga
    downloadLink.style.display = 'none';

    // Añade el enlace al documento
    document.body.appendChild(downloadLink);

    // Simula un clic en el enlace
    downloadLink.click();

    // Elimina el enlace del documento
    document.body.removeChild(downloadLink);
});

