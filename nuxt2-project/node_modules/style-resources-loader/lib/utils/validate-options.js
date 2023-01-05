"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateOptions = void 0;
const tslib_1 = require("tslib");
const schema_utils_1 = (0, tslib_1.__importDefault)(require("schema-utils"));
const schema_1 = require("../schema");
const constants_1 = require("./constants");
const validateOptions = options => (0, schema_utils_1.default)(schema_1.schema, options, {
    name: constants_1.LOADER_NAME,
    baseDataPath: constants_1.VALIDATION_BASE_DATA_PATH,
});
exports.validateOptions = validateOptions;
//# sourceMappingURL=validate-options.js.map