import './App.css';
import { BrowserRouter, Route, Link, Switch } from 'react-router-dom';

import React, { Component } from 'react';

function App() {
  return (
    <BrowserRouter>
      <h1>Hello React Router</h1>
      <Route path="/sasa">
        <Home />
      </Route>
    </BrowserRouter>
    );
}

class Home extends Component {
  render() {
    return <h2>PageAです</h2>;
  }
}


export default App;
