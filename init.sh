#!/bin/bash

DEV_MODE=false

if [ "$DEV_MODE" = true ]; then
  cd next && rm -rf * .*
fi

pnpm create next-app --ts --tailwind --eslint --app --import-alias "@/*" --use-pnpm . <<AUTORESPONSE

AUTORESPONSE

# managing dependencies

pnpm add -D $(npx depcheck --oneline | awk 'NR==2')
pnpm add -D $(cat package.json | grep 'eslint' | awk -F\" '{print $2}' | xargs)
pnpm add -D $(cat package.json | grep 'typescript' | awk -F\" '{print $2}' | xargs)

# adding dependencies

pnpm add next-themes sharp

# adding files and folders to .gitignore

cat >>.gitignore <<EOF

# files
package-lock.json
yarn.lock

# folders
/.vscode
EOF

# adding configuration files

pnpm add -D @ianvs/prettier-plugin-sort-imports prettier prettier-plugin-tailwindcss eslint-config-prettier eslint-plugin-tailwindcss
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/prettier.config.js?v=$RANDOM" | cat >prettier.config.js
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.prettierignore?v=$RANDOM" | cat >.prettierignore
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.eslintrc.json?v=$RANDOM" | cat >.eslintrc.json

# adding required shadcn/ui config and components

pnpm add lucide-react
pnpx shadcn-ui@latest init -y

pnpx shadcn-ui@latest add button input label toast dropdown-menu avatar alert card <<AUTORESPONSE

AUTORESPONSE

# adding required folders and files

mkdir -p app
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/layout.tsx?v=$RANDOM" | cat >app/layout.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/page.tsx?v=$RANDOM" | cat >app/page.tsx

mkdir -p components
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/icons.tsx?v=$RANDOM" | cat >components/icons.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/main-nav.tsx?v=$RANDOM" | cat >components/main-nav.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/site-header.tsx?v=$RANDOM" | cat >components/site-header.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/tailwind-indicator.tsx?v=$RANDOM" | cat >components/tailwind-indicator.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/theme-provider.tsx?v=$RANDOM" | cat >components/theme-provider.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/toaster.tsx?v=$RANDOM" | cat >components/toaster.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/theme-toggle.tsx?v=$RANDOM" | cat >components/theme-toggle.tsx

mkdir -p config
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/site.ts?v=$RANDOM" | cat >config/site.ts

mkdir -p lib
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/fonts.ts?v=$RANDOM" | cat >lib/fonts.ts

mkdir -p types
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/nav.ts?v=$RANDOM" | cat >types/nav.ts

# adding next-auth and prisma

pnpm add @hookform/resolvers @next-auth/prisma-adapter @prisma/client next-auth react-hook-form zod && pnpm add -D prisma

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.env.example?v=$RANDOM" | cat >".env.example"
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.env.example?v=$RANDOM" | cat >".env.local"

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/middleware.ts?v=$RANDOM" | cat >"middleware.ts"

mkdir -p 'app/(auth)/access' && mkdir -p 'app/api/auth/[...nextauth]'
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/(auth)/layout.tsx?v=$RANDOM" | cat >"app/(auth)/layout.tsx"
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/(auth)/access/page.tsx?v=$RANDOM" | cat >"app/(auth)/access/page.tsx"
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/auth/\[...nextauth\]/route.ts?v=$RANDOM" | cat >app/api/auth/\[...nextauth\]/route.ts

mkdir -p app/dashboard && mkdir -p app/dashboard/settings
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/layout.tsx?v=$RANDOM" | cat >app/dashboard/layout.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/page.tsx?v=$RANDOM" | cat >app/dashboard/page.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/settings/page.tsx?v=$RANDOM" | cat >app/dashboard/settings/page.tsx

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/dashboard-nav.tsx?v=$RANDOM" | cat >components/dashboard-nav.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-account-nav.tsx?v=$RANDOM" | cat >components/user-account-nav.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-auth-form.tsx?v=$RANDOM" | cat >components/user-auth-form.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-avatar.tsx?v=$RANDOM" | cat >components/user-avatar.tsx

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/dashboard.ts?v=$RANDOM" | cat >config/dashboard.ts

mkdir -p lib/validations
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/auth.ts?v=$RANDOM" | cat >lib/auth.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/db.ts?v=$RANDOM" | cat >lib/db.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/session.ts?v=$RANDOM" | cat >lib/session.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/validations/auth.ts?v=$RANDOM" | cat >lib/validations/auth.ts

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/index.d.ts?v=$RANDOM" | cat >types/index.d.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/next-auth.d.ts?v=$RANDOM" | cat >types/next-auth.d.ts

pnpx prisma init
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/prisma/schema.prisma?v=$RANDOM" | cat >prisma/schema.prisma

# adding stripe
pnpm add stripe

mkdir -p app/dashboard/billing
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/billing/page.tsx?v=$RANDOM" | cat >app/dashboard/billing/page.tsx

mkdir -p app/api/users/stripe && mkdir -p app/api/users/invoice && mkdir -p app/api/users/cancel && mkdir -p app/api/webhooks/stripe
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/users/cancel/route.ts?v=$RANDOM" | cat >app/api/users/cancel/route.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/users/invoice/route.ts?v=$RANDOM" | cat >app/api/users/invoice/route.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/users/stripe/route.ts?v=$RANDOM" | cat >app/api/users/stripe/route.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/webhooks/stripe/route.ts?v=$RANDOM" | cat >app/api/webhooks/stripe/route.ts

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/billing-form.tsx?v=$RANDOM" | cat >components/billing-form.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/header.tsx?v=$RANDOM" | cat >components/header.tsx
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/shell.tsx?v=$RANDOM" | cat >components/shell.tsx

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/subscriptions.ts?v=$RANDOM" | cat >config/subscriptions.ts

curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/stripe.ts?v=$RANDOM" | cat >lib/stripe.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/subscription.ts?v=$RANDOM" | cat >lib/subscription.ts
curl -fsSL "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/utils.ts?v=$RANDOM" | cat >lib/utils.ts

# running prettier
pnpx prettier --write .
