import { useState } from "react";

export function CreateTodo(props) {
    // react-query
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");

//see the thing above is equal to the mental model:
//     let title = "";
// function setTitle(v) {
//   title = v;
//   rerender();
// }

    return <div>
        <input id="title" style={{
            padding: 10,
            margin: 10
        }} type="text" placeholder="title" onChange={function(e) {
            setTitle(e.target.value);
            //“Every time user types → grab the text → store it in state”
        }}></input> <br />
    
        <input id="desc" style={{
            padding: 10,
            margin: 10
        }} type="text" placeholder="description" onChange={function(e) {
            const value = e.target.value;
            setDescription(e.target.value);
        }}></input> <br />

        <button style={{
            padding: 10,
            margin: 10
        }} onClick={() => {
            // axios
            fetch("http://localhost:3000/todo", {
                method: "POST",
                body: JSON.stringify({
                    title: title,
                    description: description
                }),
                headers: {
                    "Content-type": "application/json"
                }
            })
                .then(async function(res) {
                    const json = await res.json();
                    alert("Todo added");
                })
        }}>Add a todo</button>
    </div>
}
