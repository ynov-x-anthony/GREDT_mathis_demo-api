#!/bin/bash
set -e

echo "=== 1. Build de l'API ==="
docker build -t demo-api:1.0 ./api

echo -e "\n=== 2. Nettoyage initial et creation du reseau et du volume ==="
docker rm -f demo-db api 2>/dev/null || true
docker network rm demo_net 2>/dev/null || true
docker volume rm demo_pgdata 2>/dev/null || true

docker network create demo_net
docker volume create demo_pgdata

echo -e "\n=== 3. Lancement de la base de donnees ==="
docker run -d --name demo-db \
  --network demo_net \
  -v demo_pgdata:/var/lib/postgresql/data \
  -v $(pwd)/db/init.sql:/docker-entrypoint-initdb.d/init.sql:ro \
  -e POSTGRES_USER=demo \
  -e POSTGRES_PASSWORD=demo \
  -e POSTGRES_DB=demo \
  postgres:16-alpine

echo -e "\n=== 4. Attente de la base de donnees et de l'initialisation ==="
until docker exec demo-db psql -U demo -d demo -c "SELECT 1 FROM products;" >/dev/null 2>&1; do
  echo "En attente de la creation de la table products..."
  sleep 2
done
sleep 1

echo -e "\n=== 5. Lancement de l'API ==="
docker run -d --name api \
  --network demo_net \
  -p 8080:3000 \
  -e PGHOST=demo-db \
  demo-api:1.0

sleep 3 # Le temps que l'API demarre

echo -e "\n=== 6. Ajout du produit 'Casquette Demo' ==="
curl -s -X POST -H 'content-type: application/json' \
  -d '{"name":"Casquette Démo","price_cents":1200}' localhost:8080/products
echo ""

echo -e "\n=== 7. Suppression de la base et de l'API ==="
docker rm -f demo-db api

echo -e "\n=== 8. Recreation de la base et de l'API ==="
docker run -d --name demo-db \
  --network demo_net \
  -v demo_pgdata:/var/lib/postgresql/data \
  -e POSTGRES_USER=demo \
  -e POSTGRES_PASSWORD=demo \
  -e POSTGRES_DB=demo \
  postgres:16-alpine

until docker exec demo-db psql -U demo -d demo -c "SELECT 1 FROM products;" >/dev/null 2>&1; do
  sleep 2
done
sleep 1

docker run -d --name api \
  --network demo_net \
  -p 8080:3000 \
  -e PGHOST=demo-db \
  demo-api:1.0

sleep 3

echo -e "\n=== 9. Verification de la persistance ==="
echo "Contenu de /products :"
curl -s localhost:8080/products
echo ""

echo -e "\n=== 10. Volume et nettoyage final ==="
echo "Volumes :"
docker volume ls | grep demo_pgdata

docker rm -f demo-db api
docker network rm demo_net

# docker volume rm demo_pgdata
echo "Termine ! Le volume demo_pgdata a ete conserve."
