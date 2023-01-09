
import './App.scss';

import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import React from 'react'

const Example = () => {
  const { register, handleSubmit } = useForm();

  const items = ["アイテム１", "アイテム２", "アイテム３", "アイテム４"]
  const [val, setVal] = React.useState('アイテム１');

  const onSubmit = (data: any) => console.log(data);
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
    </div>
  );
}

export default Example;
