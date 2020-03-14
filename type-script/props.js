"use strict";
// $ tsc --strict props.ts
// ../.ghq/github.com/YumaInaura/YumaInaura/type-script/props.ts:8:1 - error TS7053: Element implicitly has an 'any' type because expression of type '"A"' can't be used to index type '{}'.
//   Property 'A' does not exist on type '{}'.
// 8 props["A"] = "a"
//   ~~~~~~~~~~
// ../.ghq/github.com/YumaInaura/YumaInaura/type-script/props.ts:9:1 - error TS7053: Element implicitly has an 'any' type because expression of type '"B"' can't be used to index type '{}'.
//   Property 'B' does not exist on type '{}'.
// 9 props["B"] = { "b": "c"}
//   ~~~~~~~~~~
// Found 2 errors.
// let props = {}
var props = {};
props["A"] = "a";
props["B"] = { "b": "c" };
console.log(props["A"]);
console.log(props["B"]);
