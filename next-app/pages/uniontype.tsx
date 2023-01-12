import React, { useState, useEffect } from 'react';

export const UnionType = () => {
  type ValueTypes = 'A' | 'B';

  const [value, setValue] = useState<ValueTypes>();

  const clickA = () => {
    setValue("A")
  }

  const clickB = () => {
    setValue("B")
  }

  // Error
  // const clickC = () => {
  //   setValue("C")
  // }

  useEffect(() => {
    switch (value) {
      case "A":
        console.log("is A")
        break
      case "B":
        console.log("is B")
        break
      // Error
      // case "C":
      //   console.log("is C")

    };
  });


  return (
    <div>
      <button onClick={clickA}>ClickA</button>
      <button onClick={clickB}>ClickB</button>
    </div>
  );

};

export default UnionType;