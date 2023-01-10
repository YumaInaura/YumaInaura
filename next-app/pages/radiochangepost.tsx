import axios from "axios";
import { useState } from 'react'

const RadioChangePost = () => {
  const [val, setVal] = useState('');
  const requestURL = "https://httpbin.org/post";
  const [gotResponse, setResponse] = useState({ "form": { item: "" }});

  const HeatHandleChange = (data: any) => {
    setVal(data.target.value);
    axios.post(requestURL, new URLSearchParams({ item: data.target.value })).then((response) => {
      setResponse(response.data);
    });
  }

  return (
    <>
      <div>
        <input
          type="radio"
          value="heat"
          onChange={HeatHandleChange}
          checked={val === 'heat'}
        />
        Heat
      </div>
      <div>
        <input
          type="radio"
          value="cool"
          onChange={HeatHandleChange}
          checked={val === 'cool'}
        />
        Cool
      </div>
      <div>{gotResponse['form']["item"]}</div>
    </>
  );
}
export default RadioChangePost;