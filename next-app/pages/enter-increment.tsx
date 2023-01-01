import React, { useEffect, useState } from 'react';
import EnterIncrementModule from "../styles/EnterIncrement.module.css";

const EnterIncrement = () => {
  const [count, setCount] = useState(0);

  const handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Enter') {
      setCount(count+1)
      console.log('keydown Enter Key')
    }
  }

  useEffect(() => {
    document.addEventListener('keydown', handleKeyDown, false)
  }, [count])

  return <div className={EnterIncrementModule.body}>{count}</div>
}

export default EnterIncrement

// https://tech-broccoli.life/articles/engineer/key-down-with-use-effect/

