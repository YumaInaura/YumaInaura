// import '../../styles/globals.css'
import type { AppProps } from 'next/app'
import React, { useEffect, useRef, useState } from 'react';

export default function EnterIncrement({ Component, pageProps }: AppProps) {
  const inputElement = useRef(null);
  const [count, setCount] = useState(0);

  useEffect(() => {
    if (inputElement.current) {
      inputElement.current.focus();
    }
  }, []);

  return (
    <div>
      <label>
        <input type="text" defaultValue="Untitled" ref={inputElement} onKeyDown={() => setCount(count + 1)} size="1"/>
      </label>
      <p>You clicked {count} times</p>
    </div>
  );
}
