Create new project -

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/nrjdalal/next-cli/main/init.sh)"
```

Docker command to generate postgresql test database (it deletes itself on system reboot or on closing docker) -

```sh
docker run -d --rm -P -p 5432:5432 -e POSTGRES_USER="johndoe" -e POSTGRES_PASSWORD="randompassword" -e POSTGRES_DB="mydb" --name postgres postgres:alpine
```

How to generate NEXTAUTH_SECRET -

```sh
openssl rand -base64 12
```

How to generate Github Client ID and Client Secret -

1. Login to your Github account
2. Click on your profile picture on the top right corner
3. Go to Settings -> Developer Settings -> OAuth Apps -> New OAuth App
4. Fill in the details and click on Register Application

```
Application Name: Awesome Next App
Homepage URL: http://localhost:3000
Callback URL: http://localhost:3000/api/auth/callback/github
```

5. No need to enable device flow (it is disabled by default)
6. Copy the Client ID and Client Secret and paste it in the .env.local file
