"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resolveImportUrl = void 0;
const tslib_1 = require("tslib");
const path_1 = (0, tslib_1.__importDefault)(require("path"));
const regex = /@(?:import|require)\s+(?:\([a-z,\s]+\)\s*)?['"]?([^'"\s;]+)['"]?;?/gu;
const resolveImportUrl = (ctx, { file, content }) => ({
    file,
    content: content.replace(regex, (match, pathToResource) => {
        if (!pathToResource || /^[~/]/u.test(pathToResource)) {
            return match;
        }
        const absolutePathToResource = path_1.default.resolve(path_1.default.dirname(file), pathToResource);
        const relativePathFromContextToResource = path_1.default
            .relative(ctx.context, absolutePathToResource)
            .split(path_1.default.sep)
            .join('/');
        return match.replace(pathToResource, relativePathFromContextToResource);
    }),
});
exports.resolveImportUrl = resolveImportUrl;
//# sourceMappingURL=resolve-import-url.js.map