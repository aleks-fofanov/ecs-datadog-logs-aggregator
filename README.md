<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

# ecs-datadog-logs-aggregator [![Build Status](https://travis-ci.org/aleks-fofanov/ecs-datadog-logs-aggregator.svg?branch=master)](https://travis-ci.org/aleks-fofanov/ecs-datadog-logs-aggregator) [![Latest Release](https://img.shields.io/github/release/aleks-fofanov/ecs-datadog-logs-aggregator.svg)](https://github.com/aleks-fofanov/ecs-datadog-logs-aggregator/releases/latest)


Customized Fluentd image designed to be deployed to AWS ECS cluster and ship containers logs to Datadog.


---


It's 100% Open Source and licensed under the [APACHE2](LICENSE).









## Introduction

This docker image is a customized version Fluentd image (`v1.4.2-debian-2.0`) designed to collect logs from your
ECS containers and ship them to Datadog.

**Why this project**:
Installing Datadog agent(s) on each node in your ECS cluster may not be an option for some users
as this can be expensive depending on the number of nodes in the cluster. Also, some users might want to build
a highly-available solution for logs collections & aggregation.

**Implementation notes and Warnings**:
- Datadog API key should be passed to container via `DD_API_KEY` environment variable
- Pefix your containers log tags with `docker.`, otherwise logs won't be processed
  ```json
  "logConfiguration": {
      "logDriver": "fluentd",
      "options": {
          "fluentd-address": "fluentd-address:24224",
          "tag": "docker.backend-app"
      }
  }
  ```

Fluentd is configured to be `json` logs friendly, meaning that it would try to parse log records as json
  and [set fields to the resulting record from parsed json](https://docs.fluentd.org/filter/parser#reserve_data).

**Exposed ports**:
- TCP 0.0.0.0 9880 (HTTP for healthcheck purposes only)
- TCP & UPD 0.0.0.0 24224 (Logs collection & forwarding to Datadog)

You can use the following command in ECS to setup a healthcheck for the container:
   `["CMD-SHELL", "curl http://0.0.0.0:9880/fluentd.healthcheck?json=%7B%22log%22%3A+%22health+check%22%7D || exit 1"]`

**Recommended deployment options**:
- Daemonset on ECS container instances (EC2)
- Autoscaling ECS Service on Fargate (you would also need to configure ECS Service Discovery in this case)


## Quick Start

To run container locally for testing:
```bash
docker run -d --name fluentd \
-e DD_API_KEY=YOUR_DATADOG_API_KEY -p 24224:24224 \
aleksfofanov/ecs-datadog-logs-aggregator
```
Then you can configure your containers to ship logs to `localhost:24224`.




## Makefile Targets
```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen

```




## References

For additional context, refer to some of these links. 

- [Building a scalable log solution aggregator with AWS Fargate, Fluentd, and Amazon Kinesis Data Firehose](https://aws.amazon.com/blogs/compute/building-a-scalable-log-solution-aggregator-with-aws-fargate-fluentd-and-amazon-kinesis-data-firehose/) - Building a scalable log solution aggregator with AWS Fargate, Fluentd, and Amazon Kinesis Data Firehose
- [Centralized Container Logging with Fluent Bit](https://aws.amazon.com/blogs/opensource/centralized-container-logging-fluent-bit/) - Centralized Container Logging with Fluent Bit


## Help

**Got a question?**

File a GitHub [issue](https://github.com/aleks-fofanov/ecs-datadog-logs-aggregator/issues).


