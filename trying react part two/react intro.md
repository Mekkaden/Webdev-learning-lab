Imagine if we wanted to do like const a = arr[0] , const b = arr[1] 

Like we need to pull out values of array and put them into variables

We can do this shorthandly like this  : const [a,b] = arr;

This is the shortcut way of doing it.


earlier counter app if we used react then it would look like this : 

import React from "react";

function App() {
  const [count, setCount] = React.useState(0); // array destructuring.
// 0 here means initial value  0  like let count  = 0 ; React.use state returns an  array

  return (
    <div>
      <Button count={count} setCount={setCount}></Button>
    </div>
  );
}

//NOW THIS IS THE BUTTON COMPONENT FUNCTION WE HAVE DEFINED IN THE DOM METHOD
function Button(props) {
  function onButtonClick() {
    props.setCount(props.count + 1);
  }

  return (
    <button onClick={onButtonClick}>
      Counter {props.count}
    </button>
  );
}

export default App;



Also react compiles everything to jsut html,css and javascript only like if u hit npm run build u will get a folder called dist and after that point u dont need anything else u just need the dist to post ur website nothing more nothing else react was just a tool.
