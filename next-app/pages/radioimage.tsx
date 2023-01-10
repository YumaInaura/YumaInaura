
import axios from "axios";
import ImageRadioCss from "./ImageRadio.module.css";

import { useForm } from "react-hook-form";
import { useState } from 'react'

const ImageRadio = () => {
  const { register, handleSubmit } = useForm();

  const items = ["item1", "item2"]
  const [selectedItem, setItem] = useState("");

  const requestURL = "https://httpbin.org/post";
  const [getData, setResponse] = useState({ form: { item: "" } });

  const onSubmit = (data: any) => {
    axios.post(requestURL, new URLSearchParams({ item: selectedItem })).then((response) => {
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
        <h2>Item</h2>
        <p>{getData['form']['item']}</p>
      </div>
    </div>

  );
}

export default ImageRadio;
