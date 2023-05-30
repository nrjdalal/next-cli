#!/bin/bash

DEV_MODE=true

if [ "$DEV_MODE" = true ]; then
  rm -rf next && mkdir next && cd next
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

pnpm add -D @ianvs/prettier-plugin-sort-imports prettier prettier-plugin-tailwindcss
curl -s "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.prettier.config.js?v=$RANDOM" | cat >.prettier.config.js
curl -s "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.eslintrc.json?v=$RANDOM" | cat >.eslintrc.json

pnpx shadcn-ui init <<AUTORESPONSE
yes
AUTORESPONSE

pnpx shadcn-ui add button input label toast dropdown-menu avatar <<AUTORESPONSE

AUTORESPONSE

mkdir -p app
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/layout.tsx?v=$RANDOM" | cat >app/layout.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/page.tsx?v=$RANDOM" | cat >app/page.tsx

mkdir -p components
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/icons.tsx?v=$RANDOM" | cat >components/icons.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/main-nav.tsx?v=$RANDOM" | cat >components/main-nav.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/site-header.tsx?v=$RANDOM" | cat >components/site-header.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/tailwind-indicator.tsx?v=$RANDOM" | cat >components/tailwind-indicator.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/theme-provider.tsx?v=$RANDOM" | cat >components/theme-provider.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/theme-toggle.tsx?v=$RANDOM" | cat >components/theme-toggle.tsx

mkdir -p config
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/site.ts?v=$RANDOM" | cat >config/site.ts

mkdir -p lib
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/fonts.ts?v=$RANDOM" | cat >lib/fonts.ts

mkdir -p types
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/nav.ts?v=$RANDOM" | cat >types/nav.ts

# adding next-auth and prisma

pnpm add @hookform/resolvers @next-auth/prisma-adapter @prisma/client next-auth react-hook-form zod && pnpm add -D prisma

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.env.example?v=$RANDOM" | cat >".env.example"

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/middleware.ts?v=$RANDOM" | cat >"middleware.ts"

mkdir -p 'app/(auth)/access' && mkdir -p 'app/api/auth/[...nextauth]'
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/(auth)/layout.tsx?v=$RANDOM" | cat >"app/(auth)/layout.tsx"
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/(auth)/access/page.tsx?v=$RANDOM" | cat >"app/(auth)/access/page.tsx"
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/api/auth/\[...nextauth\]/route.ts?v=$RANDOM" | cat >app/api/auth/\[...nextauth\]/route.ts

mkdir -p app/dashboard && mkdir -p app/dashboard/billing && mkdir -p app/dashboard/settings
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/layout.tsx?v=$RANDOM" | cat >app/dashboard/layout.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/page.tsx?v=$RANDOM" | cat >app/dashboard/page.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/billing/page.tsx?v=$RANDOM" | cat >app/dashboard/billing/page.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/app/dashboard/settings/page.tsx?v=$RANDOM" | cat >app/dashboard/settings/page.tsx

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/dashboard-nav.tsx?v=$RANDOM" | cat >components/dashboard-nav.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-account-nav.tsx?v=$RANDOM" | cat >components/user-account-nav.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-auth-form.tsx?v=$RANDOM" | cat >components/user-auth-form.tsx
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/components/user-avatar.tsx?v=$RANDOM" | cat >components/user-avatar.tsx

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/dashboard.ts?v=$RANDOM" | cat >config/dashboard.ts

mkdir -p lib/validations
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/auth.ts?v=$RANDOM" | cat >lib/auth.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/db.ts?v=$RANDOM" | cat >lib/db.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/session.ts?v=$RANDOM" | cat >lib/session.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/validations/auth.ts?v=$RANDOM" | cat >lib/validations/auth.ts

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/index.d.ts?v=$RANDOM" | cat >types/index.d.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/next-auth.d.ts?v=$RANDOM" | cat >types/next-auth.d.ts

pnpx prisma init
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/prisma/schema.prisma?v=$RANDOM" | cat >prisma/schema.prisma

pnpm add next@13.4.3
