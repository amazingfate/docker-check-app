#!/bin/bash
source /docker-check-app/params.env
check_app(){
    app=$2
    runtime=${1:-10m}
    mypid=$$
    $app &
    apppid=$!
    echo "My PID=$mypid. App's PID=$apppid"
    ps -f $apppid
    #Sleep for the specified time.
    sleep $runtime
    kill $apppid || echo "$app not start" >> output-$REVIEW_ID
}
apt-get update
apt-get -y install python python-apt coreutils python-pycurl
cd /docker-check-app
python /docker-check-app/get_sourcelist.py
rm /etc/apt/sources.list
mv base.list /etc/apt/sources.list.d/
mv rpa.list /etc/apt/sources.list.d/
apt-get update
DEBIAN_FRONTEND='noninteractive' apt-get -yq dist-upgrade
while read apps
do 
    check_app 10s $apps
done < app.list
