
import './App.scss';

import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";

const Example = () => {
  const { register, handleSubmit } = useForm();

  const onSubmit = (data: any) => console.log(data);

  return (
    <div className="App">
      <h1>ログイン</h1>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div>
          <label htmlFor="email">Email</label>
          <input id="email" {...register('email')} />
        </div>
        <div>
          <label htmlFor="password">Password</label>
          <input id="password" {...register('password')} type="password" />
        </div>
        <button type="submit">ログイン</button>
      </form>
    </div>
  );
}

export default Example;
