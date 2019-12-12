import React from "react";

import cs from './styles';

import { Link } from 'react-router-dom';


// import './styles.module.css'

function NavBar  () {

  const navStyle = {
    color: 'white'
  }


    return (
      <div>

        <nav className={cs.nav}>

          <h3>MLI</h3>
          <ul className={cs.nav_Links}>
          <Link style={navStyle} to="/about">  <li>About</li> </Link>
          <Link style={navStyle} to="/"> <li>Main</li> </Link>
          <Link style={navStyle} to="/definitions">  <li>Definitions</li></Link>

          </ul>

        </nav>

      </div>


    );
}


export default NavBar;
