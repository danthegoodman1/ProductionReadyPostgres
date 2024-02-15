# Alerting

WIP

## Understanding Vector metrics

Review the [Vector metrics schema](https://vector.dev/docs/about/under-the-hood/architecture/data-model/metric/#schema) to understand what the JSON looks like.

Vector collects from Postgres directly, but we also run [`postgrest-exporter`](https://github.com/prometheus-community/postgres_exporter) to collect more details metrics.

## Postres monitoring

Check for the `up` metric, this indicates whether vector is able to connect to the postgres instance.

You get very minimal gains alerting on metrics past CPU, mem, and disk usage. As long as you have dashboards to observe the different metrics, then being alerted by your code when timeouts are occurring (you have timeouts on your DB operations, right?) is a good universal indicator that something is wrong with the DB.

You'll want to at least have charts for the following metrics:

- [pg_stat_database_conflicts_confl_lock_total](https://vector.dev/docs/reference/configuration/sources/postgresql_metrics/#pg_stat_database_conflicts_confl_lock_total) - Number of queries in this database that have been canceled due to lock timeouts.
- [pg_stat_database_conflicts_confl_deadlock_total](https://vector.dev/docs/reference/configuration/sources/postgresql_metrics/#pg_stat_database_conflicts_confl_deadlock_total) - Number of transactions that canceled due to deadlocks (conflicts with other running transactions, thus restarted)
- [pg_stat_database_conflicts_confl_lock_total](https://vector.dev/docs/reference/configuration/sources/postgresql_metrics/#pg_stat_database_conflicts_confl_lock_total) - Number of transactions that are cancled due to lock timeouts (could not acquire lock in time)
- [`pg_stat_activity_max_tx_duration`](https://sysdig.com/blog/postgresql-monitoring/#:~:text=to%20be%20optimized.-,%237%20Latency,-First%2C%20we%20are) - How many active transactions are open that are taking greater than some duration.
- [`pg_settings_max_connections, pg_stat_activity_count, pg_settings_superuser_reserved_connections`](https://sysdig.com/blog/postgresql-monitoring/#:~:text=%236%20Number%20of%20available%20connections) - Number of used and available open connections.

These will help you debug issues that your code might be causing.

## Host monitoring

### Up

Check for the presence of logs and metrics coming in, good to know that your node is alive.

### Uptime

The `uptime` metric from the `host_metrics` source can indicate whether the node unexpectedly restarted.

### Memory usage

### CPU usage

### Disk capacity

Check the [`filesystem_used_ratio`](https://vector.dev/docs/reference/configuration/sources/host_metrics/#filesystem_used_ratio) to see how much of the file system is available. Only need to do this for the 
