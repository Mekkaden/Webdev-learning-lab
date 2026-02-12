//ZOD IS LIKE A RUNTIME VALIDATOR
const zod = require("zod");

//creating a zod schema
//create todo is now holding a jsvalidatorobject

const createtodo =  zod.object({
    title : zod.string() , 
    descryption : zod.string()
})

const updatetodo = zod.object({
    id: zod.string()
});

module.exports = {
    createtodo , updatetodo
};