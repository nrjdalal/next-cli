#!/bin/bash

DEV_MODE=true

if [ "$DEV_MODE" = true ]; then
  rm -rf next && mkdir next && cd next
fi

pnpm create next-app --ts --tailwind --eslint --app --import-alias "@/*" --use-pnpm . <<AUTORESPONSE

AUTORESPONSE

# moving devDependencies from dependencies to devDependencies
pnpm add -D $(npx depcheck --oneline | awk 'NR==2')
pnpm add -D $(cat package.json | grep 'eslint' | awk -F\" '{print $2}' | xargs)
pnpm add -D $(cat package.json | grep 'typescript' | awk -F\" '{print $2}' | xargs)

# adding useful dependencies
pnpm add sharp

# updating .gitignore
cat >>.gitignore <<EOF

# files
package-lock.json
yarn.lock

# folders
/.vscode
EOF

# adding prettier and plugins
pnpm add -D @ianvs/prettier-plugin-sort-imports prettier prettier-plugin-tailwindcss
curl -s "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/.prettier.config.js?v=$RANDOM" | cat >.prettier.config.js

# making repository compatible with shadcn/ui
pnpx shadcn-ui init <<AUTORESPONSE
yes
AUTORESPONSE

# configuring .eslintrc.json
curl -s "https://raw.githubusercontent.com/shadcn/next-template/main/.eslintrc.json?v=$RANDOM" | cat >.eslintrc.json

pnpm add @next-auth/prisma-adapter @prisma/client next-auth && pnpm add -D prisma

mkdir -p lib
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/db.ts?v=$RANDOM" | cat >lib/db.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/auth.ts?v=$RANDOM" | cat >lib/auth.ts
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/lib/session.ts?v=$RANDOM" | cat >lib/session.ts

mkdir -p types
curl "https://raw.githubusercontent.com/nrjdalal/next-cli/main/next/types/next-auth.d.ts?v=$RANDOM" | cat >types/next-auth.d.ts
