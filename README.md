Docker command to generate postgresql temp database -

```sh
docker run --rm -P -p 5432:5432 -e POSTGRES_USER="johndoe" -e POSTGRES_PASSWORD="randompassword" -e POSTGRES_DB="mydb" --name postgres postgres:alpine
```
