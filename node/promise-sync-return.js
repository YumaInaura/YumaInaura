function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function f() {
  await sleep(1000);
  return "XXX";
}

const result = f()
console.log(result)
// Promise { <pending> }

f().then(result => {
  console.log(result)
});
// XXX

const result2 = await f()
console.log(result2)
