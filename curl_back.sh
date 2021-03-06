#!/bin/bash

cmd_res=$1
host_api=$2
review_id=$3
BUILD_URL=$4

if [[ ${cmd_res} == 0 ]]; then
if [ -f $PWD/output-$review_id ]
then
cat $PWD/output-$review_id
curl -X POST -H Access-Token:${CHECK_TOKEN} ${host_api}/test_result/${review_id} -d "passed=0&comment=应用检测未通过.\njob details: ${BUILD_URL}console"
rm $PWD/output-$review_id
else
curl -X POST -H Access-Token:${CHECK_TOKEN} ${host_api}/test_result/${review_id} -d "passed=1&comment=应用检测通过.\njob details: ${BUILD_URL}console"
fi
else
	curl -X POST -H Access-Token:${CHECK_TOKEN} ${host_api}/test_result/${review_id} -d "passed=0&comment=应用检测失败.\njob details: ${BUILD_URL}console"
fi
