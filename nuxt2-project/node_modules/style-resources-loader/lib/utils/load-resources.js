"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loadResources = void 0;
const get_resources_1 = require("./get-resources");
const inject_resources_1 = require("./inject-resources");
const normalize_options_1 = require("./normalize-options");
const loadResources = async (ctx, source, callback) => {
    try {
        const options = (0, normalize_options_1.normalizeOptions)(ctx);
        const resources = await (0, get_resources_1.getResources)(ctx, options);
        const content = await (0, inject_resources_1.injectResources)(ctx, options, source, resources);
        callback(null, content);
    }
    catch (err) {
        callback(err);
    }
};
exports.loadResources = loadResources;
//# sourceMappingURL=load-resources.js.map