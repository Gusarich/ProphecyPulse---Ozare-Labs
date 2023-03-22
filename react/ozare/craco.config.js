const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
const WebpackBar = require('webpackbar');
const CracoAlias = require('craco-alias');
const webpack = require('webpack');

process.env.BROWSER = 'none';

module.exports = {
  webpack: {
    plugins: [
      new WebpackBar({ profile: true }),
      ...(process.env.NODE_ENV === 'development' ? [new BundleAnalyzerPlugin({ openAnalyzer: false })] : []),
      // new webpack.ProvidePlugin({
      //   process: 'process/browser',
      //   Buffer: ['buffer', 'Buffer'],
      // }),
    ],
    // configure: (webpackConfig) => {
    //   webpackConfig.resolve.fallback = {
    //     ...webpackConfig.resolve.fallback,
    //     stream: require.resolve('stream-browserify'),
    //     buffer: require.resolve('buffer'),
    //   };
    //   webpackConfig.resolve.extensions = [...webpackConfig.resolve.extensions, '.ts', '.js'];
    //   return webpackConfig;
    // },
  },
  plugins: [
    {
      plugin: CracoAlias,
      options: {
        source: 'tsconfig',
        // baseUrl SHOULD be specified
        // plugin does not take it from tsconfig
        baseUrl: './src/',
        /* tsConfigPath should point to the file where "baseUrl" and "paths"
         are specified*/
        tsConfigPath: './tsconfig.paths.json',
      },
    },
  ],
};
