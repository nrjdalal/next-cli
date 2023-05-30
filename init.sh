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

mkdir -p lib && cat >lib/db.ts <<EOF
// @ts-ignore
import { PrismaClient } from '@prisma/client'

declare global {
  var cachedPrisma: PrismaClient
}

let prisma: PrismaClient
if (process.env.NODE_ENV === 'production') {
  prisma = new PrismaClient()
} else {
  if (!global.cachedPrisma) {
    global.cachedPrisma = new PrismaClient()
  }
  prisma = global.cachedPrisma
}

export const db = prisma
EOF

cat >lib/auth.ts <<EOF
import { PrismaAdapter } from '@next-auth/prisma-adapter'
import { NextAuthOptions } from 'next-auth'
import GitHubProvider from 'next-auth/providers/github'

import { db } from '@/lib/db'

export const authOptions: NextAuthOptions = {
  adapter: PrismaAdapter(db as any),
  session: {
    strategy: 'jwt',
  },
  pages: {
    signIn: '/access',
  },
  providers: [
    GitHubProvider({
      clientId: process.env.GITHUB_CLIENT_ID as string,
      clientSecret: process.env.GITHUB_CLIENT_SECRET as string,
    }),
  ],
  callbacks: {
    async session({ token, session }) {
      if (token) {
        session.user.id = token.id
        session.user.name = token.name
        session.user.email = token.email
        session.user.image = token.picture
      }

      return session
    },
    async jwt({ token, user }) {
      const dbUser = await db.user.findFirst({
        where: {
          email: token.email,
        },
      })

      if (!dbUser) {
        if (user) {
          token.id = user?.id
        }
        return token
      }

      return {
        id: dbUser.id,
        name: dbUser.name,
        email: dbUser.email,
        picture: dbUser.image,
      }
    },
  },
}
EOF

cat >lib/session.ts <<EOF
import { getServerSession } from "next-auth/next"

import { authOptions } from "@/lib/auth"

export async function getCurrentUser() {
  const session = await getServerSession(authOptions)

  return session?.user
}
EOF

mkdir -p types && cat >types/next-auth.d.ts <<EOF
import { User } from "next-auth"
import { JWT } from "next-auth/jwt"

type UserId = string

declare module "next-auth/jwt" {
  interface JWT {
    id: UserId
  }
}

declare module "next-auth" {
  interface Session {
    user: User & {
      id: UserId
    }
  }
}
EOF
