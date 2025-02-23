import { Card } from '@/components/Card'
import { SimpleLayout } from '@/components/SimpleLayout'
import { getAllArticles } from '@/lib/articles'
import { formatDate } from '@/lib/formatDate'

function Article({ article }) {
  return (
    <article className="md:grid md:grid-cols-4 md:items-baseline">
      <Card className="md:col-span-3">
        <Card.Title href={`/linux/general/${article.slug}`}>
          {article.title}
        </Card.Title>
        <Card.Eyebrow
          as="time"
          dateTime={article.date}
          className="md:hidden"
          decorate
        >
          {formatDate(article.date)}
        </Card.Eyebrow>
        <Card.Description>{article.description}</Card.Description>
        <Card.Cta>Read article</Card.Cta>
      </Card>
      <Card.Eyebrow
        as="time"
        dateTime={article.date}
        className="mt-1 hidden md:block"
      >
        {formatDate(article.date)}
      </Card.Eyebrow>
    </article>
  )
}

export const metadata = {
  title: 'Linux Tutorials',
  description:
    'Immerse yourself in the world of Linux, where boundaries are shattered, and limitations are mere illusions. With Linux, every user becomes a pioneer, equipped with an arsenal of customizable tools and a robust foundation that empowers them to create, explore, and push the boundaries of what is possible.',
}

export default async function ArticlesIndex() {
  const folder = 'linux/general'
  let articles = await getAllArticles(folder)

  return (
    <SimpleLayout
      title="Linux Tutorials"
      intro="Immerse yourself in the world of Linux, where boundaries are shattered, and limitations are mere illusions. With Linux, every user becomes a pioneer, equipped with an arsenal of customizable tools and a robust foundation that empowers them to create, explore, and push the boundaries of what is possible."
    >
      <div className="md:pl-2">
        <div className="flex max-w-4xl flex-col space-y-2">
          {articles.length > 0 ? (
            articles.map((article) => (
              <Article key={article.slug} article={article} />
            ))
          ) : (
            <p className="text-center text-zinc-600 dark:text-zinc-400 pt-8">
              No articles found.
            </p>
          )}
        </div>
      </div>
    </SimpleLayout>
  )
}
