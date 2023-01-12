
const Example = () => {

  const handleOnclick = (e: any) => {
    console.log(e.target.textContent)
  }

  return (
    <>
      <div>
        <button onClick={handleOnclick}>Click me</button>
      </div>
    </>
  );
}
export default Example;