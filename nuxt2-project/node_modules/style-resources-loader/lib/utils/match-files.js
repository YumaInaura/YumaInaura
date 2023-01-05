"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.matchFiles = void 0;
const tslib_1 = require("tslib");
const path_1 = (0, tslib_1.__importDefault)(require("path"));
const util_1 = (0, tslib_1.__importDefault)(require("util"));
const glob_1 = (0, tslib_1.__importDefault)(require("glob"));
const type_guards_1 = require("./type-guards");
const isLegacyWebpack = (ctx) => !!ctx.options;
const getRootContext = (ctx) => {
    if (isLegacyWebpack(ctx)) {
        return ctx.options.context;
    }
    return ctx.rootContext;
};
const flatten = (items) => {
    const emptyItems = [];
    return emptyItems.concat(...items);
};
const matchFiles = async (ctx, options) => {
    const { patterns, globOptions } = options;
    const files = await Promise.all(patterns.map(async (pattern) => {
        const rootContext = getRootContext(ctx);
        const absolutePattern = path_1.default.isAbsolute(pattern) ? pattern : path_1.default.resolve(rootContext, pattern);
        const partialFiles = await util_1.default.promisify(glob_1.default)(absolutePattern, globOptions);
        return partialFiles.filter(type_guards_1.isStyleFile);
    }));
    return [...new Set(flatten(files))].map(file => path_1.default.resolve(file));
};
exports.matchFiles = matchFiles;
//# sourceMappingURL=match-files.js.map