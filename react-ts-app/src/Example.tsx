
import logo from './logo.svg';
import './App.scss';

import { useState } from "react"

function Counter() {
  const [count, setCount] = useState(0)
  const countup = () => {
    setCount(prevState => prevState + 1)
  }
  const countdown = () => {
    setCount(prevState => prevState - 1)
  }

  return (
    <>
      <button type="button" onClick={countup}>+</button>
      <button type="button" onClick={countdown}>-</button>
      {count}
    </>
  )
}

function App() {
  return (
    <div className="App">
      <body>

        {<Counter></Counter>}


      </body>
    </div>
  );
}

export default App;
