#!/bin/bash

oc apply -f user-workload-config-basic.yaml

oc apply -f prometheusrules.yaml

oc -n openshift-user-workload-monitoring create secret generic alertmanager-user-workload --from-file=alertmanager.yaml=alertmanager-sns.yaml --from-file=sns-alert.tmpl --dry-run=client -o=yaml |  oc -n openshift-user-workload-monitoring replace secret --filename=-

sleep 30


oc rsh alertmanager-user-workload-0 kill -HUP 1; oc rsh alertmanager-user-workload-1 kill -HUP 1
