# Quête 1 - PostgreSQL dans Docker

## Sortie de `\dt` et du `SELECT * FROM products;`

```text
 id |     name     | price_cents 
----+--------------+-------------
  1 | Sticker D?mo |         150
(1 row)

         List of relations
 Schema |   Name   | Type  | Owner 
--------+----------+-------+-------
 public | products | table | demo
(1 row)
```

## 3 dernières lignes de `docker logs demo-db`

```text
2026-10-08 08:49:53.546 UTC [58] LOG:  database system was shut down at 2026-10-08 08:49:53 UTC
2026-10-08 08:49:53.551 UTC [1] LOG:  database system is ready to accept connections
PostgreSQL init process complete; ready for start up.
```
