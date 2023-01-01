import '../styles/globals.css'
import type { AppProps } from 'next/app'
import React from "react";

export const doFetch = async () => {
  const res = await fetch('https://api.github.com/repos/zeit/next.js')
  const json = await res.json()
  console.log(json);
}

export default function App({ Component, pageProps }: AppProps) {
  const res = fetch('https://api.github.com/repos/zeit/next.js')
  console.log(res.json())
  return <Component {...pageProps} />
}
