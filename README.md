# Production Ready Postgres

A docker compose for production ready postgres on your own machine.

## Defining "production ready"

This is setup for a single host that can recover relatively quickly.

At the moment, this does not support an HA failover or replicas. While this is possible with Spilo and a TCP load balancer, that is not the current goal (that may be in the future). If you're at the scale where you need that, then either opt for using the [zolando operator](https://github.com/zalando/postgres-operator) on kubernetes, or just use a managed DB.

Production ready in this case means that automated processes are properly automated, monitoring is setup, and alerts are configured (depends on the user to implement these after shipping alerts, see [the alerting guide](ALERTING.md)).

## Cloud costs are getting insane

A Hetzner 48vCPU 192GB Mem 960GB disk VM costs ~$309/mo in their us-east region, including 60TB of egress. You can attach up to 10TB volumes as well.

Hetzner has a great terraform operator, docker swarm and kamal work great, and they even have [k8s controllers for load balancers and nodes](https://github.com/hetznercloud/hcloud-cloud-controller-manager).

EC2 costs over $2k for the same machine (and doesn't include the $540 worth of egress), RDS postgres costs $3k, Aurora $5k, and Aurora IO optimized $6.6k

Even DigitalOcean charges nearly $1.3k for a 40 vCPU machine (can't get more than that), and only comes with 9TB of transfer.

## Usage

### Prequisites

1. Docker installed
2. [Vector installed on the host](https://vector.dev/docs/setup/installation/operating-systems/) - this is so that it can access disk, network interfaces, and logs easily. See [vector-install-apt.sh](/vector-install-apt.sh) for a quick install for apt-based systems.

### Backup

[wal-g](https://github.com/wal-g/wal-g) is used for backup and restore. You can choose what ever S3 provider you want, but I like to use either Cloudflare R2 (slower, cheaper) or Backblaze B2 when I'm not using a specific platform. If I was on DigitalOcean I'd just use spaces, or on AWS I'd just use S3.

Since wal-g doesn't have an official docker image, we make one on the fly.

You need to configure the S3 credentials for walg to be able to backup and restore.

### Restore
