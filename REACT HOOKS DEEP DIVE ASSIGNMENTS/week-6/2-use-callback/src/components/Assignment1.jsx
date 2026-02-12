import { useState, useCallback } from "react";

export function Assignment1() {
    // Standard state: [currentValue, functionToUpdateIt]
    const [count, setCount] = useState(0);

    // useCallback is like a 'Save' button for functions.
    // It prevents the computer from deleting and recreating this 
    // function every single time the screen refreshes.
    const handleIncrement = useCallback(function() {
        // We use a "callback" inside setCount to get the most 
        // recent value of count (prevCount) and add 1.
        setCount(function(currentCount) {
            return currentCount + 1;
        });
    }, []); // Empty array means: "Create this function once and never change it."

    const handleDecrement = useCallback(function() {
        setCount(function(currentCount) {
            return currentCount - 1;
        });
    }, []);

    return (
        <div>
            <p>Count: {count}</p>
            {/* We are passing our "saved" functions down to the child component */}
            <CounterButtons 
                onIncrement={handleIncrement} 
                onDecrement={handleDecrement} 
            />
        </div>
    );
};

// This is a Child Component. Think of it as a specialized "Button Module".
function CounterButtons(props) {
    // Instead of that weird ({ onIncrement }) syntax, 
    // we just use 'props' like a normal object.
    return (
        <div>
            <button onClick={props.onIncrement}>Increment</button>
            <button onClick={props.onDecrement}>Decrement</button>
        </div>
    );
}