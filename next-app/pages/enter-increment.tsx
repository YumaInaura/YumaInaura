import React, { useEffect, useState } from 'react';

export default function EnterIncrement()  {
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

  return <div>{count}</div>
}

// https://tech-broccoli.life/articles/engineer/key-down-with-use-effect/

