#!/bin/bash

sudo apt update
sudo apt-get install stress
#stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=NRAK-SU1ZZRPZANYV9RN57EHQ2JGECS6 NEW_RELIC_ACCOUNT_ID=4300582 /usr/local/bin/newrelic install