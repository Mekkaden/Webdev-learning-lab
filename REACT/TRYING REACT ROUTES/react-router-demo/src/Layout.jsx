import React from 'react'
import {Link , Outlet} from "react-router-dom";


const Layout = () => {
  return (
    <div>
      <nav>
        <Link to = "/" >home</Link>
        <Link to = "/diet" >diet</Link>
        <Link to = "/splits" >splits</Link>
      </nav>

    <Outlet/>
    </div>
  )
}

export default Layout;