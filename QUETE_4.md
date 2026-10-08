# Quête 4 - demo-api en multi-étapes

## Preuves et Comparaisons

**Tableau taille avant / après (`docker image ls demo-api`) :**
```text
REPOSITORY   TAG        IMAGE ID       CREATED          SIZE
demo-api     naive      22e90312835b   23 seconds ago   1.65GB
demo-api     multi      1c62fa23869a   15 seconds ago   228MB
```
> L'image `multi` (228MB) est plus de **7 fois plus petite** que l'image `naive` (1.65GB) !

**Preuve que le secret n'apparaît pas dans l'historique :**
```bash
$ docker history --no-trunc demo-api:multi | grep -i FAKE-123
# (Aucune sortie, la ligne est bien absente)
```

**Preuve que le faux fichier `.npmrc` n'existe pas dans l'image finale :**
```bash
$ docker run --rm -u root demo-api:multi sh -c 'cat /root/.npmrc 2>&1'
cat: can't open '/root/.npmrc': No such file or directory
```
*(Note : testé avec `root` pour confirmer l'absence du fichier, car l'utilisateur `node` se prend une erreur "Permission denied" sur `/root` quoiqu'il arrive).*

**Le conteneur tourne toujours :**
```bash
$ docker run -d --name multi -p 8080:3000 demo-api:multi
029fd208efd08b43f78ed9b283cfb68790d3c4d0381eace1b2b4eb5c50460e87

$ curl -s localhost:8080/health
{"status":"UP"}
```
