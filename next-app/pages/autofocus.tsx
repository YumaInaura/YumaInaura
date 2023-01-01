import type { AppProps } from 'next/app'
import React, { useEffect, useRef, useState } from 'react';

export default function AutoFocus({ Component, pageProps }: AppProps) {
  const inputElement = useRef(null);

  useEffect(() => {
    if (inputElement.current) {
      inputElement.current.focus();
    }
  }, []);

  return (
    <div>
        <input type="text" ref={inputElement} />
    </div>
  );
}
