// https://www.suzu6.net/posts/165-axios-loop-break/

import axios from "axios";
import React from 'react'

const AxiosGet = () => {
  // function sleep(time: any) {
  //   return new Promise((resolve, reject) => {
  //     setTimeout(() => {
  //       resolve(1);
  //     }, time);
  //   });
  // }


  // const sleep = msec => new Promise(resolve => setTimeout(resolve, msec));

  const numOfTime = 10;
  const delay = 1000;
  let response = null;


  const baseURL = "http://localhost:3000";
  const [json, setJson] = React.useState(null);

  React.useEffect(() => {
    const arr = Array.from({ length: numOfTime }, (v, k) => k);
    for (let i of arr) {
      axios.get(baseURL).then((response) => {
        setJson(response.data);
      });
      sleep(delay);
    }
  }, []);

  if (!json) return null;

  return (
    <div>
      <h1>{json['message']}</h1>
      <p>{json['time']}</p>
    </div>
  );
}

export default AxiosGet;
