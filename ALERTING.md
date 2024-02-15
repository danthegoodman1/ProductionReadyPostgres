# Alerting

WIP

## Postres monitoring

Check for the `up` metric, this indicates whether vector is able to connect to the postgres instance

## Host monitoring

### Up

Check for the presence of logs and metrics coming in.

### Uptime

The `uptime` metric from the `host_metrics` source can indicate whether the node unexpectedly restarted.

### Memory usage

### CPU usage

### Disk capacity

Check the [`filesystem_used_ratio`](https://vector.dev/docs/reference/configuration/sources/host_metrics/#filesystem_used_ratio) to see how much of the file system is available. Only need to do this for the 
