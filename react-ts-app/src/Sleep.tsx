import {useState, useEffect} from 'react'

const Sleep = () => {
  const [data, setData] = useState("");

  useEffect(() => {
    const interval = setInterval(() => {
      setData(Date().toLocaleString());
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  return data ? <div>{data}</div> : <div>Loading...</div>;
}

export default Sleep;
