# IPL Data Project - PostgreSQL
## Setup Database
Run:
psql -U postgres -f create_database.sql
## Create Tables
psql -U ipl_user -d ipl_database -f create_tables.sql
## Load IPL Data
psql -U ipl_user -d ipl_database -f load_data.sql
## Run IPL Queries
psql -U ipl_user -d ipl_database -f ipl_queries.sql
## Cleanup
psql -U postgres -f cleanup.sql
