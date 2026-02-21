import { useMemo,useState } from "react";

// In this assignment, your task is to create a component that performs an expensive calculation (finding the factorial) based on a user input. 
// Use useMemo to ensure that the calculation is only recomputed when the input changes, not on every render.

export function Assignment1() {
    const [input, setInput] = useState(0);
    const [isDarkMode, setIsDarkMode] = useState(false);    

    const expensiveValue = useMemo(()=>{
        console.log("THIS IS AN EXPENSIVE OPERATION")
        let v = input;
        let f = 1;
        while(v > 0){
            f = f* v;
            v--;
        }
        return f;
    
    },[input])

    return (
    <div style={{ 
        backgroundColor: isDarkMode ? "#222" : "#fff", 
        color: isDarkMode ? "#fff" : "#000",
        padding: "20px",
        minHeight: "100vh"
    }}>
        <button onClick={() => setIsDarkMode(!isDarkMode)}>
            Toggle Dark Mode
        </button>
        <br></br>
        <br></br>
        <input 
            type="number" 
            value={input} 
            onChange={(e) => setInput(Number(e.target.value))} 
        />
        <p>Calculated Value: {expensiveValue}</p>
    </div>


);
}
