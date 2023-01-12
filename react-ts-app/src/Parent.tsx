import { useState, useEffect } from 'react'

import Child from "./Child";

function Example() {
  const [task, setTask] = useState("");

  const handleClick = () => {
    setTask("task");
  };

  useEffect(() => {
    console.log("副作用が実行されました。");
  }, []);

  return (
    <div>
      <Child handleClick={handleClick}/>
      <div>
        {task}
      </div>
    </div>
  );
}

export default Example;