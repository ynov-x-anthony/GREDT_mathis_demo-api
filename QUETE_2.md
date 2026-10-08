# Quête 2 - Dockerfile demo-api

## Preuve de création de l'image

**Sortie de `docker image ls demo-api` :**
```text
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
demo-api     1.0       8137b69e3f61   17 minutes ago   252MB
```

## Preuve du cache Docker

**Sortie de la construction prouvant le cache sur `npm ci` :**
```text
#6 [2/5] WORKDIR /app
#6 CACHED

#7 [3/5] COPY package.json package-lock.json ./
#7 CACHED

#8 [4/5] RUN npm ci --omit=dev
#8 CACHED

#9 [5/5] COPY server.js db.js ./
#9 DONE 0.0s
```

## Liens du rendu

- **Lien du repository GitHub :** https://github.com/ynov-x-anthony/GREDT_mathis_demo-api
- **Lien de l'image Docker Hub publiée :** https://hub.docker.com/r/arcenstone/demo-api
