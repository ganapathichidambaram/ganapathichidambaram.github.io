import clsx from 'clsx'

import { Container } from '@/components/Container'

export function PageIntro({ eyebrow, title, children, centered = false }) {
  return (
    <Container
      className={clsx('mt-1 sm:mt-3 lg:mt-4', centered && 'text-center')}
    >
        <h1>
          <span className="font-display text-3xl font-semibold text-neutral-950">
            {eyebrow}
          </span>
        </h1>

    </Container>
  )
}
