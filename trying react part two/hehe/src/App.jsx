
{/*  let state ={
  count:0
  This aint the one , we need to define the component as react says wrt to the hook,
}*/}
import {useState} from "react";
function App() {
const [count ,setCount] = useState(0);  // this use state returns an array [1,2,3]

  function onclickhandler(){
    setCount(count + 1);
  }
  return (
    <div>
      <button onClick = {onclickhandler}> COUNTER {count}</button>
    </div>
  )
}

export default App 
