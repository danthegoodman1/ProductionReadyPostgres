# Alerting

WIP

## Understanding Vector metrics

Review the [Vector metrics schema](https://vector.dev/docs/about/under-the-hood/architecture/data-model/metric/#schema) to understand what the JSON looks like

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
