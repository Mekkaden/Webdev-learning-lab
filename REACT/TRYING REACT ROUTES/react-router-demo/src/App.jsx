import { createBrowserRouter, RouterProvider } from "react-router-dom";

import Layout from "./Layout";
import Home from "./Home";
import Diet from "./Diet";
import Splits from "./Splits";

const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />,
      },
      {
        path: "diet",
        element: <Diet />,
      },
      {
        path: "splits",
        element: <Splits />,
      },
    ],
  },
]);

function App() {
  return <RouterProvider router={router} />;
}

export default App;
