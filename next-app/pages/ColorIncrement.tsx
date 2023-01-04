import React, { useEffect, useState } from 'react';

const ColorIncrement = () => {
  const [count, setCount] = useState(0);
  const handleKeyDownEnter = (event: KeyboardEvent) => {
    if (event.key === "Enter") {
      setCount(count + 1);
      console.log("Enter")
    }
  };

  useEffect(() => {
    document.addEventListener("keydown", handleKeyDownEnter);
    return () => {
      document.removeEventListener("keydown", handleKeyDownEnter);
    };
  }, [count]);

  var color_flagment = ( '00' + count.toString(16) ).slice( -2 );

  var color = '#' + color_flagment + color_flagment + color_flagment
  var style = {color: color, background: "white", fontSize: "50pt"}
  return <div style={style}>{color}</div>
}

export default ColorIncrement
