// React CSSで悩む全ての人へ【2022年版】
// https://ramble.impl.co.jp/1414/

// ラジオボタンの選択肢を画像にする【CSSのみでOK】
// https://mgmgblog.com/post-1935/

import './App.scss';
import axios from "axios";
import FormCssModule from "./Form.module.css";

import { useForm } from "react-hook-form";
import { useState } from 'react'

const Form = () => {
  const { register, handleSubmit } = useForm();

  const items = ["small", "large"]
  const [val, setVal] = useState('item１');

  const requestURL = "https://httpbin.org/post";
  const [getData, setResponse] = useState({ form: { content: "", item: "" } });

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
        <div className={FormCssModule["bg"]}>
AA
              </div>

        {items.map((item) => {
          return (
            <div key={item}>
              <label htmlFor={item} className={FormCssModule["item-label"]}>{item}</label>
              <input
                className={FormCssModule["item-input"]}
                id="sizeSelectSmall"
                type="radio"
                {...register('item')}
                value={item}
                onChange={handleChange}
                checked={item === val}
              />
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
