
export const ShowModalChild = (props: any) => {
  if (props.showModal) {
    return (
      <div>
        <button onClick={props.handleClick}>Click</button>
      </div>
    );
  } else {
    return (
      <></>
    )
  }
}
