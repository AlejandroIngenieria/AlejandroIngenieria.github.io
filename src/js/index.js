let playbtn = document.getElementById('play')
let clearbtn = document.getElementById('clear')
let editor = document.getElementById('editor')
let terminal = document.getElementById('terminal')

playbtn.addEventListener('click', function () {
    terminal.innerText = "Build successfull!"

    let editorContent = editor.innerHTML;
    // Reemplazar <br> por saltos de línea
    editorContent = editorContent.replace(/<div\s*\/?>/gi, '\n');
    // Opcional: Quitar otras etiquetas HTML si es necesario
    editorContent = editorContent.replace(/<\/?[^>]+(>|$)/g, "");

    console.log(editorContent)
});


clearbtn.addEventListener('click', function () {
    terminal.innerText = ""
});
