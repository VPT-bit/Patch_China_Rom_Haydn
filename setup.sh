#!/bin/bash
su="sudo bash"

$su download_latest.sh "ssut/payload-dumper-go" "linux_amd64"
payload_dumper_go=$(find . -type f -name '*linux_amd64.tar.gz')
if [ -f payload_dumper_go ]; then
    echo "PASS"
else
    echo "FAIL"
fi
