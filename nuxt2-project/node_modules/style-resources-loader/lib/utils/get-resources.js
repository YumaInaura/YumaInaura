"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getResources = void 0;
const tslib_1 = require("tslib");
const fs_1 = (0, tslib_1.__importDefault)(require("fs"));
const util_1 = (0, tslib_1.__importDefault)(require("util"));
const match_files_1 = require("./match-files");
const resolve_import_url_1 = require("./resolve-import-url");
const getResources = async (ctx, options) => {
    const { resolveUrl } = options;
    const files = await (0, match_files_1.matchFiles)(ctx, options);
    files.forEach(file => ctx.dependency(file));
    const resources = await Promise.all(files.map(async (file) => {
        const content = await util_1.default.promisify(fs_1.default.readFile)(file, 'utf8');
        const resource = { file, content };
        return resolveUrl ? (0, resolve_import_url_1.resolveImportUrl)(ctx, resource) : resource;
    }));
    return resources;
};
exports.getResources = getResources;
//# sourceMappingURL=get-resources.js.map