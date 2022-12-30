import React, { useState } from 'react';
import './App.css';

type stone = {
  //key
  key: number
  //trueであれば置ける
  isPut: boolean;
  //trueであれば黒, falseであれば白, nullは石がない状態
  isColor: boolean | null;
}

type stoneLine = {
  lineId: string,
  stoneLine: stone[],
}


type Props = {
  stoneBoardArr: stoneLine[]
}

const S_board = {
  display: "flex",
}

const S_stoneNone = {
  backgroundColor: "green",
  height: "50px",
  width: "50px",
  border: "solid 2px #000000",
  marginTop: "-2px",
  marginLeft: "-2px"
}

const S_canPutStoneNone = {
  backgroundColor: "#006400",
  height: "50px",
  width: "50px",
  border: "solid 2px #000000",
  marginTop: "-2px",
  marginLeft: "-2px"
}

const S_stoneBlack = {
  backgroundColor: "green",
  height: "50px",
  width: "50px",
  border: "solid 2px #000000",
  backgroundImage: "radial-gradient(circle closest-side,#000000 80%,transparent 60%)",
  marginTop: "-2px",
  marginLeft: "-2px"
}

const S_stoneWhite = {
  backgroundColor: "green",
  height: "50px",
  width: "50px",
  border: "solid 2px #000000",
  backgroundImage: "radial-gradient(circle closest-side,#FFFFFF 80%,transparent 60%)",
  marginTop: "-2px",
  marginLeft: "-2px"
}




// export const Board = (props:Props) => {
//   const { stoneBoardArr } = props;
//   return (
//       <>
//       {stoneBoardArr.map((stoneLine:stoneLine) => {
//         console.log((Math.random() + 1).toString(36).substring(7))
//          return(
//           <>
//               <div key={(Math.random() + 1).toString(36).substring(7)} style={S_board}>
//                 {stoneLine.lineId}
//               </div>
//           </>)
//       })}
//       </>
//   )
// }

function App() {

  const firstBoard: stoneLine[] =
    [
      {
        lineId: "line0", stoneLine: [
          { key: 0, isPut: false, isColor: null }, { key: 1, isPut: false, isColor: null }, { key: 2, isPut: false, isColor: null }, { key: 3, isPut: false, isColor: null },
          { key: 4, isPut: false, isColor: null }, { key: 5, isPut: false, isColor: null }, { key: 6, isPut: false, isColor: null }, { key: 7, isPut: false, isColor: null }
        ]
      }
    ];

  const [stoneBoardArr, setStoneBoardArr] = useState<stoneLine[]>(firstBoard);

  const onclickBoard = () => {
    setStoneBoardArr(firstBoard);
  }

  return (
    <>
      {stoneBoardArr.map((stoneLine: stoneLine) => {
        return (
          <div key={(Math.random() + 1).toString(36).substring(7)} style={S_board}>
            {stoneLine.lineId}
          </div>
        )
      })}


    </>

  );
}

export default App;