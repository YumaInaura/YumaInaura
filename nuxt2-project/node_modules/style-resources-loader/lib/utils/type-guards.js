"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isStyleFile = exports.isFunction = void 0;
const tslib_1 = require("tslib");
const path_1 = (0, tslib_1.__importDefault)(require("path"));
const constants_1 = require("./constants");
const isFunction = (arg) => typeof arg === 'function';
exports.isFunction = isFunction;
const isStyleFile = (file) => constants_1.SUPPORTED_FILE_EXTS.includes(path_1.default.extname(file));
exports.isStyleFile = isStyleFile;
//# sourceMappingURL=type-guards.js.map