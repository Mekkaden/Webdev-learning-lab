import { useState } from "react";

//NOW APP IS LIKE THE ROOT COMPONENT , LIKE THE MAIN FUNCTION
function App() {

  //State Initialization 
  const [todos, setTodos] = useState([
    {
      title: "Learn React",
      description: "Try to learn react in 2 days",
      completed: false
    },
    {
      title: "Do a dsa problem",
      description: "Come on bro",
      completed: true
    },
    {
      title: "AHhh",
      description: "idk",
      completed: true
    }
  ]);

  // ✅ NEW TODO FUNCTION (THIS IS THE KEY PART)
  function addTodo() {
    // This ... todos means all the todos  + this new todo
    setTodos([
      ...todos,
      {
        title: "new Todo",
        description: "desc of new todo",
        completed: false
      }
    ]);
  }

  return (
    <div>
      <button onClick={addTodo}>Add new todo</button>

      {todos.map(function (todo, index) {
        return (
          <Todo
            key={index}
            title={todo.title}
            description={todo.description}
          />
        );
      })}
    </div>
  );
}

//component  todo , a component is just a function that returns a jsx thats it
function Todo(props) {
  return (
    <div>
      <h1>{props.title}</h1>
      <p>{props.description}</p>
    </div>
  );
}

export default App;
 