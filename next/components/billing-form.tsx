"use client"

import * as React from "react"
import { useRouter } from "next/navigation"
import { UserSubscriptionPlan } from "@/types"

import { cn, formatDate } from "@/lib/utils"
import { buttonVariants } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { toast } from "@/components/ui/use-toast"
import { Icons } from "@/components/icons"

interface BillingFormProps extends React.HTMLAttributes<HTMLFormElement> {
  subscriptionPlan: UserSubscriptionPlan & {
    isCanceled: boolean
  }
}

export function BillingForm({
  subscriptionPlan,
  className,
  ...props
}: BillingFormProps) {
  const router = useRouter()

  const [isLoading, setIsLoading] = React.useState<boolean>(false)

  const upgradeToPro = async () => {
    setIsLoading(!isLoading)

    // Get a Stripe session URL.
    const response = await fetch("/api/users/stripe")

    if (!response?.ok) {
      return toast({
        title: "Something went wrong.",
        description: "Please refresh the page and try again.",
        variant: "destructive",
      })
    }

    // Redirect to the Stripe session.
    // This could be a checkout page for initial upgrade.
    // Or portal to manage existing subscription.
    const session = await response.json()
    if (session) {
      window.location.href = session.url
    }
  }

  const cancelSubscription = async () => {
    const response = await fetch("/api/users/cancel")

    if (!response?.ok) {
      return toast({
        title: "Something went wrong.",
        description: "Please refresh the page and try again.",
        variant: "destructive",
      })
    }

    const subscription = await response.json()
    if (subscription) {
      toast({
        title: `Your subscription has been ${
          subscription.cancel_at_period_end ? "canceled" : "resumed"
        }.`,
        description: subscription.cancel_at_period_end
          ? "You will be able to use your plan until it expires."
          : "You subscription will continue after it expires.",
      })

      router.refresh()
    }
  }

  const getInvoice = async () => {
    const response = await fetch("/api/users/invoice")

    if (!response?.ok) {
      return toast({
        title: "Something went wrong.",
        description: "Please refresh the page and try again.",
        variant: "destructive",
      })
    }

    const invoice = await response.json()
    if (invoice) {
      window.open(invoice.url, "_blank")
    }
  }

  return (
    <main>
      <Card>
        <CardHeader>
          <CardTitle>Subscription Plan</CardTitle>
          <CardDescription>
            You are currently on the <strong>{subscriptionPlan.name}</strong>{" "}
            plan.
          </CardDescription>
        </CardHeader>
        <CardContent>{subscriptionPlan.description}</CardContent>
        <CardFooter className="flex flex-col items-start space-y-2 lg:flex-row lg:justify-between lg:space-x-0">
          {subscriptionPlan.isPro ? (
            <div className="flex gap-4">
              <button
                className={cn(buttonVariants())}
                disabled={isLoading}
                onClick={() => {
                  cancelSubscription()
                }}
              >
                {isLoading && (
                  <Icons.spinner className="mr-2 h-4 w-4 animate-spin" />
                )}
                {subscriptionPlan.isCanceled
                  ? "Resume subscription"
                  : "Cancel subscription"}
              </button>

              <button
                className={cn(buttonVariants())}
                disabled={isLoading}
                onClick={() => {
                  getInvoice()
                }}
              >
                Latest Invoice
              </button>
            </div>
          ) : (
            <button
              className={cn(buttonVariants())}
              disabled={isLoading}
              onClick={() => {
                upgradeToPro()
              }}
            >
              {isLoading && (
                <Icons.spinner className="mr-2 h-4 w-4 animate-spin" />
              )}
              Upgrade to PRO
            </button>
          )}

          {subscriptionPlan.isPro ? (
            <p className="rounded-full text-xs font-medium">
              {subscriptionPlan.isCanceled
                ? "Your plan will be canceled on "
                : "Your plan renews on "}
              {formatDate(subscriptionPlan.stripeCurrentPeriodEnd)}.
            </p>
          ) : null}
        </CardFooter>
      </Card>
    </main>
  )
}
