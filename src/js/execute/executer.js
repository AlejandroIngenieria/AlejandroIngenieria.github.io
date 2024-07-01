const RootExecuter = async (root, ast, env, gen) => {
    const instructions = root?.textSection?.instructions ?? [];
    instructions.forEach(inst => {
        if (inst != undefined){
            inst.execute(ast, env, gen);  
        }
             
    });
}

const DataSectionExecuter = async (root, ast, env, gen) => {
    const instructions = root?.dataSection ?? [];
    instructions.forEach(inst => {
        inst.execute(ast, env, gen);
    });
}