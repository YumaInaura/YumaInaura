import '../styles/globals.css'
import type { AppProps } from 'next/app'

export const getStaticPaths = async () => {
  const products = fetch(`http://example.com/movies.json`)
            .then(data => data.json())
console.log(products)
console.log("aaa")
  // const response = await fetch(`https://firestore.googleapis.com/v1/projects/next-auth-app-2aa40/databases/(default)/documents/posts`)
  //   response.json().then((data) => {
  //   console.log(data);
  // });

  // const res = await fetch(
  //   "https://firestore.googleapis.com/v1/projects/next-auth-app-2aa40/databases/(default)/documents/posts"
  // );
  // console.log(response)
  // const data = await res.json();

  // const paths = data.map((post) => {
  //   return {
  //     params: { id: post.id.toString() },
  //   };
  // });

  // return {
  //   paths,
  //   fallback: false,
  // };
};

export default function App({ Component, pageProps }: AppProps) {
getStaticPaths();
  // const s = fetch('http://example.com/movies.json');

  return <Component {...pageProps} />
}
