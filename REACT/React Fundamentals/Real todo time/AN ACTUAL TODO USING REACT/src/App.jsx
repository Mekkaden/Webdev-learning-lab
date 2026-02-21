import { useState , useEffect} from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {

  const [input ,setinput] = useState("")
  const [todos,settodos] = useState([ 
    {
      title : "Do laundry" ,
      completed : false
    }
  ])

useEffect(() => {
  const savedTodos = localStorage.getItem("todos");
  if (savedTodos) {
    settodos(JSON.parse(savedTodos));
  }
}, []);

useEffect(() => {
  localStorage.setItem("todos", JSON.stringify(todos));
}, [todos]);

// useMemo skips re-computing expensive logic


  

return <div>
  <h3>NEW ITEM</h3>

  <input 
  type = "text" placeholder='Enter Todo' 
  value = {input} onChange={(e) => setinput(e.target.value)
  }
  ></input>


  <br></br>
  <br></br>


 <button onClick={() => {
settodos([
  ...todos,
  { title: input, 
    completed : false
   }

]);

  setinput("")
}}>
  ADD TODO
</button>


  <ol>
  {
    todos.map((todo,index)=>(
      <li key = {index}>
        {todo.title}</li>
    ))
  }

  </ol> 

</div>

}

export default App
