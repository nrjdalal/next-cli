import { SubscriptionPlan } from '@/types'

export const freePlan: SubscriptionPlan = {
  name: 'Free',
  description:
    'The free plan has limited features. Upgrade to the PRO plan to unlock all features.',
  stripePriceId: '',
}

export const proPlan: SubscriptionPlan = {
  name: 'PRO',
  description: 'The PRO plan has unlimited posts.',
  stripePriceId: process.env.STRIPE_PRO_MONTHLY_PLAN_ID || '',
}
