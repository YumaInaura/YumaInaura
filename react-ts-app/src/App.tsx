import { Routes, Route, BrowserRouter } from 'react-router-dom';


function Hello() {
  return <h2>Hello</h2>;
}

function Home() {
  return <h2>Home</h2>;
}

function App() {
  return (
    <BrowserRouter>
      <h1>Hello React Router v6</h1>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/hello" element={<Hello />} />
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
