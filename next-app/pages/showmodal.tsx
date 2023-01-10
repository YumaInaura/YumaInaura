import { useState } from 'react'
import { ShowModalChild } from './showmodalchild'

export const ShowModal = () => {
  const [showModal, setShow] = useState(false)
  const openModal = () => {
    setShow(true)
  }

  return (
    <>
      <div>
        <button onClick={openModal}>SHOW MODAL</button>
        <div>
          <ShowModalChild showModal={showModal}/>
        </div>
      </div>
    </>
  )

}

export default ShowModal;
