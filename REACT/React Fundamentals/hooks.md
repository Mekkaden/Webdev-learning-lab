-UseState = So usestate gives us a variable like a count(state) and a function to update that state , call it set count. (setstate)
-Anytime setstate (setcount) gets called the react rerenders the page

-Use Effect are functions that wrap around a sideeffect (an action that doesnt require you to change the UI OR Cause a rerender to the UI) 
-It has a function component and an array component , the contents in the array is called a dependency.
-The function will run only when the dependency changes
-After useEffect runs and calls setState, the UI re-renders because state changed.
But the useEffect itself does NOT run again unless one of its dependencies changes.
Usefect always runs first like it will always run once , when the COMPONENT MOUNTS;


-UseMemo is similar to useeffect  , it will help you skip a snippet if u need but the thing is unlike useffect it can return something and we can store it in a variable bcs in useeffect the return is used for clearling , but in usememo we can use it to assign it to a variable
