import glob from 'fast-glob'

import { Providers } from '@/app/providers'
import { Layout } from '@/components/Layout'
import { HeroPattern } from '@/components/HeroPattern'

import '@/styles/tailwind.css'

export const metadata = {
  title: {
    template: '%s - Your Gateway to Tech Excellence',
    default: 'Your Gateway to Tech Excellence',
  },
  generator: 'TechnoBureau',
  applicationName: 'TechnoBureau',
  referrer: 'origin-when-cross-origin',
  publisher: 'TechnoBureau',
  creator: 'Ganapathi Chidambaram',
  authors: [{ name: 'Ganapathi Chidambaram' }, { url: 'https://github.com/GanapathiChidambaram' }],

  description: 'We offers a wealth of information, news, and insights into the ever-evolving world of technology. Whether you are a tech enthusiast, professional, or simply curious about the latest trends, TechnoBureau provides you with a one-stop hub to stay up-to-date and explore the fascinating realm of innovation.',
  keywords: 'technobureau,linux,documentation,devops,kubernetes',
  metadataBase: new URL('https://ganapathichidambaram.github.io'),
  alternates: {
    canonical: '/',
  },
  openGraph: {
    images: '/favicon.ico',
    title: 'Your Gateway to Tech Excellence',
    description: 'We offers a wealth of information, news, and insights into the ever-evolving world of technology. Whether you are a tech enthusiast, professional, or simply curious about the latest trends, TechnoBureau provides you with a one-stop hub to stay up-to-date and explore the fascinating realm of innovation.',
    url: 'https://ganapathichidambaram.github.io',
    siteName: 'TechnoBureau',
    type: 'website',
    locale: 'en_US',
    authors: ['Ganapathi Chidambaram'],
  },
  robots: 'index, follow',
}

export default async function RootLayout({ children }) {
  let pages = await glob('**/*.mdx', { cwd: 'src/app' })
  let allSectionsEntries = await Promise.all(
    pages.map(async (filename) => [
      '/' + filename.replace(/(^|\/)page\.mdx$/, ''),
      (await import(`./${filename}`)).sections,
    ]),
  )
  let allSections = Object.fromEntries(allSectionsEntries)

  return (
    <html lang="en" className="h-full" suppressHydrationWarning>
      <body className="flex min-h-full bg-white antialiased dark:bg-zinc-900">
        <Providers>
          <div className="w-full">
            <HeroPattern />
            <Layout allSections={allSections}>{children}</Layout>
          </div>
        </Providers>
      </body>
    </html>
  )
}
