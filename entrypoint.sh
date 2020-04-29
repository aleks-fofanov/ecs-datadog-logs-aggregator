#!/usr/bin/env bash

set -e

export DD_INTAKE_HOST=${DD_INTAKE_HOST:-"intake.logs.datadoghq.com"}
export DD_INTAKE_PORT=${DD_INTAKE_PORT:-10514}
export DD_INTAKE_SSL_PORT=${DD_INTAKE_SSL_PORT:-10516}
export DD_USE_SSL=${DD_USE_SSL:-true}

exec env fluentd -c /fluentd/etc/${FLUENTD_CONF} --gemfile /fluentd/Gemfile ${FLUENTD_OPT}
