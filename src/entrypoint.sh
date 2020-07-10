#!/bin/sh
touch entrypoint.txt
echo 'running entrypoint.sh' >> entrypoint.txt
devpi-init
devpi-server -c devpi.conf --theme semantic-ui &>/dev/null &
sleep 3
echo 'started running server' >> entrypoint.txt
devpi use http://localhost:3141
devpi user -c devpi password=devpi
devpi login devpi --password=devpi
devpi index -c stable bases=root/pypi
devpi index -c dev bases=root/pypi
echo 'finished entrypoint.sh' >> entrypoint.txt