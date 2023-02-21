import { useState } from "react";

function InputDisplay() {
  const [text, setText] = useState("");

  return (
    <div>
      <div>
        <input type="text" value={text} onChange={(event) => setText(event.target.value)}></input>
      </div>
      <div>
        {text}
      </div>
    </div>
  );
}

export default InputDisplay;
