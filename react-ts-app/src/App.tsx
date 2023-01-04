import { Routes, Route, BrowserRouter } from 'react-router-dom';

import axios from "axios";
import FetchExample from "./FetchExample";
import React from 'react'

function AxiosGet() {
  const baseURL = "https://jsonplaceholder.typicode.com/posts/1";
  const [post, setPost] = React.useState(null);

  React.useEffect(() => {
    axios.get(baseURL).then((response) => {
      setPost(response.data);
    });
  }, []);

  if (!post) return null;

  return (
    <div>
      <h1>{post['title']}</h1>
      <p>{post['body']}</p>
    </div>
  );
}

function Hello() {
  return <h2>XXX</h2>;
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
        <Route path="/axiosget" element={<AxiosGet />} />
        <Route path="/fetch" element={<FetchExample />} />
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
