import { redirect } from 'next/navigation'

import { authOptions } from '@/lib/auth'

import { getCurrentUser } from '@/lib/session'

export const metadata = {
  title: 'Settings',
}

export default async function DashboardPage() {
  const user = await getCurrentUser()

  if (!user) {
    redirect(authOptions?.pages?.signIn || '/access')
  }

  return <div>Settings</div>
}
