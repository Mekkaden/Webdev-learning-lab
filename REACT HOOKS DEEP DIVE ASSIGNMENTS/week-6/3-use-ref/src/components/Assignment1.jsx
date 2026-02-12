import { useEffect, useRef } from "react";
//But in React:

// React controls the DOM.

// Your component does NOT automatically give you a variable called input.

// There is no input variable unless YOU create one.

export function Assignment1() {

    const inputRef = useRef(null);

    useEffect(() => {
        // Focus when component mounts
        inputRef.current.focus();
    }, []);

    const handleButtonClick = () => {
        // Focus when button is clicked
        inputRef.current.focus();
    };

    return (    
        <div>
            <input 
                type="text" 
                placeholder="Enter text here" 
                ref={inputRef} 
            />
            <button onClick={handleButtonClick}>
                Focus Input
            </button>
        </div>
    );
}
