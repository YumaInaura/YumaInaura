import axios from "axios";
import React from 'react'

function sleep(time) {
  return new Promise((resolve, reject) => {
      setTimeout(() => {
          resolve();
      }, time);
  });
}

const AxiosGet = () => {
  const numOfTime = 5;
  const delay = 1000;
  let response = null;


  const baseURL = "http://localhost:30001";
  const [json, setJson] = React.useState(null);

  React.useEffect(() => {

    const timer = setTimeout(() => {
      console.log(
        '10 seconds has passed. TimerID ' +
        String(timer) +
        ' has finished.'
      );
    }, 1  * 10000);
    console.log('TimerID ' + String(timer) + ' has started.');

    axios.get(baseURL).then((response) => {
      setJson(response.data);
    });
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
