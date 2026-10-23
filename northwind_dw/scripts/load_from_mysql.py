import os
import duckdb

# Fetch credentials from environment variables
db_host = os.environ.get("DB_HOST", "127.0.0.1")
db_user = os.environ.get("DB_USER", "root")
db_password = os.environ.get("DB_PASSWORD", "password123")
db_name = os.environ.get("DB_NAME", "northwind")

# Supprimez ou laissez recréer dev.duckdb proprement
conn = duckdb.connect("dev.duckdb")
print("Connexion à DuckDB établie.")

conn.execute("INSTALL mysql;")
conn.execute("LOAD mysql;")

print("Connexion à la base MySQL...")
attach_query = f"ATTACH 'host={db_host} user={db_user} password={db_password} database={db_name}' AS mysql_db (TYPE MYSQL);"
conn.execute(attach_query)

# 1. Créer le schéma raw pour isoler les données brutes
conn.execute("CREATE SCHEMA IF NOT EXISTS raw;")

# Cibler explicitement le schéma northwind dans la base attachée et décoder les bytes en str si nécessaire
tables_raw = conn.execute("SELECT table_name FROM mysql_db.information_schema.tables WHERE table_schema = 'northwind';").fetchall()
tables = [row[0].decode('utf-8') if isinstance(row[0], bytes) else str(row[0]) for row in tables_raw]

print(f"Tables trouvées dans Northwind : {len(tables)} -> {tables}")

# 2. Copier chaque table dans le schéma raw
for table_name in tables:
    print(f"Copie de la table dans raw : {table_name}")
    conn.execute(f"CREATE OR REPLACE TABLE raw.{table_name} AS SELECT * FROM mysql_db.{table_name};")

# 3. Vérifier les tables dans le schéma raw
final_tables = conn.execute("SHOW TABLES FROM raw;").fetchall()
print("\nTables brutes importées avec succès dans DuckDB (schéma raw) :", final_tables)

conn.close()
