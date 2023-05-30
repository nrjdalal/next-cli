#!/bin/bash

DEV_MODE=true

if [ "$DEV_MODE" = true ]; then
  rm -rf next && mkdir next && cd next
fi

pnpm create next-app --ts --tailwind --eslint --app --import-alias "@/*" --use-pnpm . <<AUTORESPONSE

AUTORESPONSE

pnpm add -D $(npx depcheck --oneline | awk 'NR==2')
pnpm add -D $(cat package.json | grep 'eslint' | awk -F\" '{print $2}' | xargs)
pnpm add -D $(cat package.json | grep 'typescript' | awk -F\" '{print $2}' | xargs)

pnpm add sharp

cat >>.gitignore <<EOF

# files
package-lock.json
yarn.lock

# folders
/.vscode
EOF

pnpm add -D @ianvs/prettier-plugin-sort-imports prettier prettier-plugin-tailwindcss
curl -s "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.prettier.config.js?v=$RANDOM" | cat >.prettier.config.js

pnpx shadcn-ui init <<AUTORESPONSE
yes
AUTORESPONSE

curl -s "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.eslintrc.json?v=$RANDOM" | cat >.eslintrc.json

pnpm add @next-auth/prisma-adapter @prisma/client next-auth && pnpm add -D prisma

mkdir -p lib
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/auth.ts?v=$RANDOM" | cat >lib/auth.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/db.ts?v=$RANDOM" | cat >lib/db.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/fonts.ts?v=$RANDOM" | cat >lib/fonts.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/session.ts?v=$RANDOM" | cat >lib/session.ts

mkdir -p types
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/next-auth.d.ts?v=$RANDOM" | cat >types/next-auth.d.ts

mkdir -p config
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/config/site.ts?v=$RANDOM" | cat >config/site.ts
