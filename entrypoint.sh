#!/usr/bin/env bash

set -e

export EC2_HOSTNAME="$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)"

exec env fluentd -c /fluentd/etc/${FLUENTD_CONF} --gemfile /fluentd/Gemfile ${FLUENTD_OPT}
