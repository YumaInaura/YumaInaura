import type { LoaderContext } from '../types';
import type { StyleResources, StyleResourcesLoaderNormalizedOptions } from '..';
export declare const injectResources: (ctx: LoaderContext, options: StyleResourcesLoaderNormalizedOptions, source: string, resources: StyleResources) => Promise<string>;
