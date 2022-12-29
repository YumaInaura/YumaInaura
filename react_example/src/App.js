import logo from './logo.svg';
import './App.css';
import { useState } from "react";

function App() {
  const [className, setClassName] = useState("");
  const [className01, setClassName01] = useState("");

//colorクラスを付与
  const handleClick = () => {
    setClassName("color");
  };

//font-weightクラスを付与
  const handleClick02 = () => {
    setClassName01("font-weight");
  };

  return (
    <div className="App">
      <button onClick={handleClick}>color</button>
      <button onClick={handleClick02}>font-weight</button>


      <p className={`${className} ${className01}`}>This is a paragraph</p>
    </div>
  );
}

export default App;
