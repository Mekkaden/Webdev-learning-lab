const mongoose = require("mongoose");
mongoose.connect("mongodb://127.0.0.1:27017");

const todoschema = mongoose.Schema({
    title : String , 
    descryption : String ,
    completed : Boolean

})

const todo = mongoose.model('todos' , todoschema);
module.exports = {
    todo
    
}


