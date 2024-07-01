const RootExecuter = async (root, ast, env, gen) => {
    const instructions = root?.textSection?.instructions ?? [];
    instructions.forEach(async inst => {
        if (inst != undefined){
            inst.execute(ast, env, gen);  
        }
             
    });
}

const DataSectionExecuter = async (root, ast, env, gen) => {
    const instructions = root?.dataSection ?? [];
    instructions.forEach(async inst => {
        if (inst != undefined){
            inst.execute(ast, env, gen);  
        }
    });
}