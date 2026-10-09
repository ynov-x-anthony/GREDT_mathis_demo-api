# Quête 5 - La Persistance de demo-api

## Preuves d'exécution

Voici la preuve que la "Casquette Démo" survit à la suppression puis recréation du conteneur de base de données.

```text
=== 6. Ajout du produit 'Casquette Demo' ===
{"id":4,"name":"Casquette Démo","price_cents":1200,"created_at":"2026-10-09T06:59:22.127Z"}

=== 7. Suppression de la base et de l'API ===
demo-db
api

=== 8. Recreation de la base et de l'API ===
70ad9a76f25cd5ca26cd647c8861d436d1543ddb54e40733051afb961af6994e
En attente de la creation de la table products...
8f7cd799df43d8a2211f957e802a8e957e3fd1fab1f7fc0ba0976e88a45211df

=== 9. Verification de la persistance ===
Contenu de /products :
[
  {"id":4,"name":"Casquette Démo","price_cents":1200,"created_at":"2026-10-09T06:59:22.127Z"},
  {"id":3,"name":"T-shirt conteneur","price_cents":1990,"created_at":"2026-10-09T06:59:14.455Z"},
  {"id":2,"name":"Mug Docker","price_cents":990,"created_at":"2026-10-09T06:59:14.455Z"},
  {"id":1,"name":"Sticker Demo","price_cents":150,"created_at":"2026-10-09T06:59:14.455Z"}
]

=== 10. Volume et nettoyage final ===
Volumes :
local     demo_pgdata
Termine ! Le volume demo_pgdata a ete conserve.
```
