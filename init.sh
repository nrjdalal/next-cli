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

pnpx shadcn-ui add button <<AUTORESPONSE

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

pnpm add @next-auth/prisma-adapter @prisma/client next-auth && pnpm add -D prisma

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/auth.ts?v=$RANDOM" | cat >lib/auth.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/db.ts?v=$RANDOM" | cat >lib/db.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/session.ts?v=$RANDOM" | cat >lib/session.ts

curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/next-auth.d.ts?v=$RANDOM" | cat >types/next-auth.d.ts
