import nextMDX from '@next/mdx'

import { recmaPlugins } from './src/mdx/recma.mjs'
import { rehypePlugins } from './src/mdx/rehype.mjs'
import { remarkPlugins } from './src/mdx/remark.mjs'
import withSearch from './src/mdx/search.mjs'

const withMDX = nextMDX({
  extension: /\.mdx?$/,
  options: {
    remarkPlugins,
    rehypePlugins,
    recmaPlugins,
    providerImportSource: "@mdx-js/react",
  },
})

const nextConfig = {
  output: "export",
  reactStrictMode: true,
  pageExtensions: ['js', 'jsx', 'ts', 'tsx', 'mdx'],
  experimental: {
    outputFileTracingIncludes: {
      '/**/*': ['./src/app/**/*.mdx'],
    },
  },
}

export default withSearch(withMDX(nextConfig))

