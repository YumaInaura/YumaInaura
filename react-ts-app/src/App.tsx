import { Routes, Route, BrowserRouter } from 'react-router-dom';
import { Link } from 'react-router-dom'

import FetchExample from "./FetchExample";
import AxiosGet from "./AxiosGet";
import ContinuousFetch from "./ContinuousFetch";
import Sleep from "./Sleep";
import Example from "./Example";
import Form from "./Form";
import ImageRadio from "./ImageRadio";
import Parent from "./Parent";

function Hello() {
  return <h2>XXX</h2>;
}

function Home() {
  return(
    <div>
      <h2>Home</h2>
      <ul>
      <li><Link to="/axiosget">AxiosGet</Link></li>
      <li><Link to="/hello">Hello</Link></li>
      <li><Link to="/continuousfetch">ContinuousFetch</Link></li>
      <li><Link to="/sleep">Sleep</Link></li>
      <li><Link to="/form">Form</Link></li>
      <li><Link to="/example">Example</Link></li>
      </ul>
    </div>
  );
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/hello" element={<Hello />} />
        <Route path="/axiosget" element={<AxiosGet />} />
        <Route path="/fetch" element={<FetchExample />} />
        <Route path="/continuousfetch" element={<ContinuousFetch />} />
        <Route path="/sleep" element={<Sleep />} />
        <Route path="/form" element={<Form />} />
        <Route path="/imageradio" element={<ImageRadio />} />
        <Route path="/parent" element={<Parent />} />
        <Route path="/example" element={<Example />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;

// import React from 'react';
// import logo from './logo.svg';
// import './App.scss';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.tsx</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;
