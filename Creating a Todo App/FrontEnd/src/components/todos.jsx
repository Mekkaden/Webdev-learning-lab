export function Todos({todos}){
    return <div>
         <div>
            {todos.map(function(todo){
                return <div>
                    <h1>{todo.title}</h1>
                    <h3>{todo.descryption}</h3>
                    <button>{todo.completed == true ? "Completed" : "Mark as Complete"}</button>
                    </div>
            })}
         </div>
           
    </div>
}