# Quête 5 - Durcir demo-api

## Preuves

**Preuve non-root (`docker run --rm demo-api:hardened id`) :**
```text
uid=1000(node) gid=1000(node) groups=1000(node)
```

**La commande `docker run` durcie utilisée :**
```bash
docker run -d --name api -p 8080:3000 \
  --read-only --tmpfs /tmp:size=16m \
  --cap-drop ALL --security-opt no-new-privileges \
  --pids-limit 200 --memory 256m --cpus 1 \
  --network demo_net -e PGHOST=demo-db \
  demo-api:hardened
```

**Test d'écriture refusé et preuve de durcissement :**
```text
$ curl -s localhost:8080/health
{"status":"UP"}

$ docker exec api sh -c 'touch /app/x 2>&1 || echo "rootfs read-only OK"'
touch: /app/x: Read-only file system
rootfs read-only OK

$ docker inspect -f 'readonly={{.HostConfig.ReadonlyRootfs}} capdrop={{.HostConfig.CapDrop}}' api
readonly=true capdrop=[ALL]
```
