FROM node:22.11-alpine

WORKDIR /app

# Copie des fichiers package avec les bons droits
COPY --chown=node:node package.json package-lock.json ./

# Installation des dependances
RUN npm ci --omit=dev

# Changement du proprietaire du repertoire (car le WORKDIR est cree par root)
RUN chown -R node:node /app

# Copie du code avec les bons droits
COPY --chown=node:node server.js db.js ./

EXPOSE 3000

# Healthcheck utilisant wget (curl n'est pas installe par defaut sur alpine)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

USER node

CMD ["node", "server.js"]
