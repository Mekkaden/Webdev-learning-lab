const express = require("express");
const cors = require("cors");
const { createtodo  ,updatetodo} = require("./types");
const { createReadStream } = require("fs");
const { todo } = require("./db");

const app = express(); 
//express creates and returns an application object  - its ur web server ;
//my web server is actually a js object;

//This helps express to understand json;
app.use(express.json()); 
app.use(cors());

// post route
app.post("/todo",async function(req,res){
    const createpayload = req.body;
    const parsedpayload = createtodo.safeParse(createpayload);

    if(!parsedpayload.success){
        res.status(411).json({
            msg : "Wrong inputs bro"
        })
        return;
    }

    await todo.create({
        title : createpayload.title,
        descryption : createpayload.descryption,
        completed : false
    })
    
    //inline object creation
    res.json({  
        msg: "Todo created"

    })

})

app.get("/todos", async function(req, res) {
  const todos = await todo.find({});
  res.json({ todos });
});


app.put("/completed", async function(req, res) {
    const updatePayload = req.body;
    const parsedPayload = updatetodo.safeParse(updatePayload);
    if (!parsedPayload.success) {
        res.status(411).json({
            msg: "You sent the wrong inputs",
        })
        return;
    }

    await todo.update({
        _id: req.body.id
    }, {
      completed: true  
    })

    res.json({
        msg: "Todo marked as completed"
    })
})

app.listen(3000);


