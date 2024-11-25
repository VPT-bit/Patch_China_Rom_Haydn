#!/bin/bash

./download_latest.sh "ssut/payload-dumper-go" "linux_amd64"
payload_dumper_go=$(find . -type f -name *linux_amd64.tar.gz)
[[ -f payload_dumper_go ]] && echo "PASS" || echo "FAIL"
