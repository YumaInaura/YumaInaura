
import logo from './logo.svg';
import './App.scss';

import { useState} from "react"
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";

interface LoginForm {
  email: string;
  password: string;
}

const Example = () => {
  const { handleSubmit, control } = useForm();

  //   const [count, setCount] = useState(0)
//   const countup = () => {
//     setCount(prevState => prevState + 1)
//   }
//   const countdown = () => {
//     setCount(prevState => prevState - 1)
//   }

//   return (
//     <>
//       <button type="button" onClick={countup}>+</button>
//       <button type="button" onClick={countdown}>-</button>
//       {count}
//     </>
//   )
// }

// function App() {
//   return (
//     <div className="App">
//       <body>

//         {<Counter></Counter>}


//       </body>
//     </div>
//   );
return(<div></div>)
}

export default Example;
