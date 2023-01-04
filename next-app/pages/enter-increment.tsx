// https://tech-broccoli.life/articles/engineer/key-down-with-use-effect/
// https://sbfl.net/blog/2020/08/21/use-react-hooks-easy/

import React, { useEffect, useState } from 'react';

const EnterIncrement = () => {
  const [count, setCount] = useState(0);
  const handleKeyDownEnter = (event: KeyboardEvent) => {
    if (event.key === "Enter") {
      setCount(count + 1);
      console.log("Enter")
    }
  };

  useEffect(() => {
    document.addEventListener("keydown", handleKeyDownEnter);
    return () => {
      document.removeEventListener("keydown", handleKeyDownEnter);
    };
  }, [count]);

  return <div>{count}</div>
}

export default EnterIncrement
