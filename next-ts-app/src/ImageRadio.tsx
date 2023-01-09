// ラジオボタンの選択肢を画像にする【CSSのみでOK】
// https://mgmgblog.com/post-1935/

// https://teratail.com/questions/4mnejxlqd93kzu

import './App.scss';
import axios from "axios";
import ImageRadioCss from "./ImageRadio.module.css";

import { useForm } from "react-hook-form";
import { useState } from 'react'

const Form = () => {
  const { register, handleSubmit } = useForm();

  const items = ["item1", "item2"]
  const [selectedItem, setItem] = useState("");

  const requestURL = "https://httpbin.org/post";
  const [getData, setResponse] = useState({ form: { content: "", item: "" } });

  const onSubmit = (data: any) => {
    axios.post(requestURL, new URLSearchParams({ content: data.content, item: selectedItem })).then((response) => {
      setResponse(response.data);
    });
  };
  const handleChange = (e: any) => {
    setItem(e.target.value);
  };

  return (
    <div className="App">
      <h1>Form ImageRadio</h1>
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
                className={ImageRadioCss["item-input"]}
                id={item}
                type="radio"
                {...register('item')}
                value={item}
                onChange={handleChange}
                checked={item === selectedItem}
              />
              <label
                htmlFor={item}
                className={ImageRadioCss[item]}
              >
              </label>
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
