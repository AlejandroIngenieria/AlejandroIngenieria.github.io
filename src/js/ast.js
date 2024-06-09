let x;

document.getElementById("play").addEventListener("click", function () {

    x = document.getElementById("editor").textContent;
    const container = document.getElementById("terminal");
    var cst = PEG.parse(x);
    console.log(cst);
    const nodes = [];
    const edges = [];
    let idCounter = 0;
    
    function traverse(node, parentId = null) {
        const nodeId = idCounter++;
        nodes.push({ id: nodeId, label: node.value });
    
        if (parentId !== null) {
            edges.push({ from: parentId, to: nodeId });
        }
    
        if (Array.isArray(node.left)) {
            for (const child of node.left) {
                traverse(child, nodeId);
            }
        } else if (node.left) {
            traverse(node.left, nodeId);
        }
    
        if (Array.isArray(node.right)) {
            for (const child of node.right) {
                traverse(child, nodeId);
            }
        } else if (node.right) {
            traverse(node.right, nodeId);
        }
    }
    
    traverse(cst);
    
    
    const data = {
        nodes: new vis.DataSet(nodes),
        edges: new vis.DataSet(edges)
    };
    var options = {
        nodes: {
            widthConstraint: 20,
        },        
        layout: {
            hierarchical: {
                levelSeparation: 60,
                nodeSpacing: 80,
                parentCentralization: true,
                direction: 'UD',        // UD, DU, LR, RL
                sortMethod: 'directed',  // hubsize, directed
                shakeTowards: 'roots'  // roots, leaves                        
            },
        },                        
    };
    const network = new vis.Network(container, data, options);




});


