import { getServerSession } from "next-auth/next"
import { z } from "zod"

import { authOptions } from "@/lib/auth"
import { stripe } from "@/lib/stripe"
import { getUserSubscriptionPlan } from "@/lib/subscription"

export async function GET(req: Request) {
  try {
    const session = await getServerSession(authOptions)

    if (!session?.user || !session?.user.email) {
      return new Response(null, { status: 403 })
    }

    const subscriptionPlan = await getUserSubscriptionPlan(session.user.id)

    let subscription = await stripe.subscriptions.retrieve(
      subscriptionPlan.stripeSubscriptionId
    )

    subscription = await stripe.subscriptions.update(
      subscriptionPlan.stripeSubscriptionId,
      {
        cancel_at_period_end: !subscription.cancel_at_period_end,
      }
    )

    return new Response(JSON.stringify(subscription))
  } catch (error) {
    if (error instanceof z.ZodError) {
      return new Response(JSON.stringify(error.issues), { status: 422 })
    }

    return new Response(null, { status: 500 })
  }
}
