import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

document.body.style.margin = "0";
document.body.style.backgroundColor = "#121212";
document.body.style.color = "white";
document.body.style.fontFamily = "sans-serif";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
