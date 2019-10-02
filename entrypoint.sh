#!/bin/sh

set -e

EC2_INTERNAL_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
EC2_PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

if [[ ! -z ${EC2_PUBLIC_HOSTNAME} ]]; then
    export EC2_HOSTNAME=${EC2_PUBLIC_HOSTNAME}
else
    export EC2_HOSTNAME=${EC2_INTERNAL_HOSTNAME}
fi

exec env fluentd -c /fluentd/etc/${FLUENTD_CONF} --gemfile /fluentd/Gemfile ${FLUENTD_OPT}
