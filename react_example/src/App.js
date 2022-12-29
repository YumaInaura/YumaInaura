import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Route } from 'react-router-dom';

function App() {

  return (
    <BrowserRouter>
      <h1>Hello React Router</h1>
      <Route path="/">
        <Home />
      </Route>
    </BrowserRouter>
  );
}

function Home() {
  return <h2>Home</h2>;
}


export default App;
