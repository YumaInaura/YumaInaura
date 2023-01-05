// https://www.suzu6.net/posts/165-axios-loop-break/

import {useState, useEffect} from 'react'

const ContinuousFetch = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    async function fetchData() {
      const response = await fetch('http://localhost:3000/');
      const data = await response.json();
      setData(data);
    }

    const interval = setInterval(() => {
      fetchData();
    }, 1000);

    return () => clearInterval(interval);
  }, []);

  return data ? <div>{data["time"]}</div> : <div>Loading...</div>;
}

export default ContinuousFetch;
