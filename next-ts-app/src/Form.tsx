
import './App.scss';
import axios from "axios";

import { useForm } from "react-hook-form";
import { useState } from 'react'

const Form = () => {
  const { register, handleSubmit } = useForm();

  const items = ["item１", "item２", "item３", "item４"]
  const [val, setVal] = useState('item１');

  const requestURL = "https://httpbin.org/post";
  const [getData, setResponse] = useState({ form: { content: "", item: "" }});

  const onSubmit = (data: any) => {
    axios.post(requestURL, new URLSearchParams(data)).then((response) => {
      setResponse(response.data);
    });
  };
  const handleChange = (e: any) => {
    setVal(e.target.value);
  };

  return (
    <div className="App">
      <h1>POST</h1>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div>
          <label htmlFor="content">content</label>
          <input id="content" {...register('content')} />
        </div>
        <div>
        </div>
        {items.map((item) => {
          return (
            <div key={item}>
              <input
                id={item}
                type="radio"
                {...register('item')}
                value={item}
                onChange={handleChange}
                checked={item === val}
              />
              <label htmlFor={item}>{item}</label>
            </div>
          );
        })}
        <button type="submit">Submit</button>
      </form>
      <div>
        <h2>Content</h2>
          <p>{getData['form']['content']}</p>
        <h2>Item</h2>
          <p>{getData['form']['item']}</p>
      </div>
    </div>

  );
}

export default Form;
