import { Routes, Route, BrowserRouter } from 'react-router-dom';
import { Link } from 'react-router-dom'

import FetchExample from "./FetchExample";
import AxiosGet from "./AxiosGet";
import RailsGet from "./RailsGet";

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
      </ul>
    </div>
  );
}

function App() {
  return (
    <BrowserRouter>
      <h1>Hello React Router v6</h1>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/hello" element={<Hello />} />
        <Route path="/axiosget" element={<AxiosGet />} />
        <Route path="/fetch" element={<FetchExample />} />
        <Route path="/railsget" element={<RailsGet />} />
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
