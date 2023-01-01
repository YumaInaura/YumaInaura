// import '../../styles/globals.css'
import type { AppProps } from 'next/app'
import React, { useState } from 'react';

export default function EnterIncrement({ Component, pageProps }: AppProps) {
  // const { count, increment, decrement } = useCounter(10);
  const [count, setCount] = useState(0);

  return (
    <div>
      <input type="text" onKeyDown={() => setCount(count + 1)} autoFocus={true} />
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
      <p>You clicked {count} times</p>
    </div>
  )
}
