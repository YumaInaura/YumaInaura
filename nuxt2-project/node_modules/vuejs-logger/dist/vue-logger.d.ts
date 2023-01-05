import { ILogger } from "./interfaces/logger";
import { ILoggerOptions } from "./interfaces/logger-options";
declare class VueLogger implements ILogger {
    private errorMessage;
    private logLevels;
    install(Vue: any, options: ILoggerOptions): void;
    isValidOptions(options: ILoggerOptions, logLevels: string[]): boolean;
    private getMethodName;
    private initLoggerInstance;
    private printLogMessage;
    private getDefaultOptions;
}
declare const _default: VueLogger;
export default _default;
