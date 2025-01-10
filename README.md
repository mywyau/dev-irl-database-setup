# megaman

Repository responsible for database setup. We use docker containers and docker compose

### Set up database

```
setup_postgres.sh
```

### Clear down and clean up database


```
clear_down_postgres.sh
```

### Apply flyway migrations to database

To populate the database we can use flyway's migrations

```
setup_flyway_migrations.sh
```

### Clear down and clean up flyway migrations 


```
clear_down_flyway.sh
```



