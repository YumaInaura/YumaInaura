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