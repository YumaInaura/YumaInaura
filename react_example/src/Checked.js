import React, { useParams, useState } from 'react';

function Checked() {

  const [camera_position, setCameraPosition] = useState();

  return (
    <div>
      <input
        type="radio"
        value="Home"
        checked={1===1}
      />
      <input
        type="radio"
        value="Away"
        checked={1===1}
      />
    </div>
  )

}

export default Checked;