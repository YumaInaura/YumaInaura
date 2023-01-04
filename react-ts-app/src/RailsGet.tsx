import axios from "axios";
import React from 'react'

const AxiosGet = () => {
  const baseURL = "http://localhost:3000";
  const [json, setJson] = React.useState(null);

  React.useEffect(() => {
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
