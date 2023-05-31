import { DashboardConfig } from '@/types'

export const dashboardConfig: DashboardConfig = {
  mainNav: [
    {
      title: 'Documentation',
      href: '/docs',
      disabled: true,
    },
    {
      title: 'Support',
      href: '/support',
      disabled: true,
    },
  ],
  sidebarNav: [
    {
      title: 'Dashboard',
      href: '/dashboard',
      icon: 'sun',
    },
    {
      title: 'Billing',
      href: '/dashboard/billing',
      icon: 'moon',
    },
    {
      title: 'Settings',
      href: '/dashboard/settings',
      icon: 'spinner',
    },
  ],
}
