#!/bin/bash
##-------------------------------------------------------------------
## @copyright 2013
## File : fetch_post_utility.sh
## Author : filebat <markfilebat@126.com>
## Description :
## --
## Created : <2013-02-01>
## Updated: Time-stamp: <2013-07-22 11:15:31>
##-------------------------------------------------------------------
. /usr/bin/utility_xzb.sh

SLEEP_SECONDS=3
######################### platform websites ############################

function fetch_douban() {
    dst_dir=${1?}
    topic_id=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        for url in `generate_command "http://www.douban.com/group/$topic_id/discussion?start=$id&type=essence" | grep ^http`; do
            command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
            $command
        done;
    done;
    sleep $SLEEP_SECONDS
}

function fetch_douban_discussion() {
    dst_dir=${1?}
    topic_id=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        for url in `generate_command "http://www.douban.com/group/$topic_id/discussion?start=$id" | grep ^http`; do
            command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
            $command
        done;
    done;
    sleep $SLEEP_SECONDS
}

function fetch_zhihu() {
    dst_dir=${1?}
    topic_id=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        for url in `generate_command "http://www.zhihu.com/topic/$topic_id/top-answers?page=$id" | grep ^http`; do
            command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
            $command
        done;
    done;
    sleep $SLEEP_SECONDS
}

function fetch_weibo_direct_user() {
    dst_dir=${1?}
    userid=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        url="http://weibo.com/$userid?page=$id"
        command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
        $command
    done;
    sleep $SLEEP_SECONDS
}

function fetch_weibo() {
    dst_dir=${1?}
    userid=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        url="http://weibo.com/u/$userid?page=$id"
        command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
        $command
    done;
    sleep $SLEEP_SECONDS
}

function fetch_weibo_search() {
    dst_dir=${1?}
    topic_id=${2?}
    id_list=${3?}
    lists=($id_list)
    for id in ${lists[*]}; do
        url="http://s.weibo.com/weibo/$topic_id&page=$id"
        command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
        $command
    done;
    sleep $SLEEP_SECONDS
}

########################################################################

######################### vertical websites ############################
function fetch_haowenz() {
    dst_dir=${1?}
    id_list=${2?}
    lists=($id_list)
    for id in ${lists[*]}; do
        for url in `generate_command "http://haowenz.com/a/bl/list_4_$id.html" | grep ^http`; do
            command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
            $command
        done;
    done;
    sleep $SLEEP_SECONDS
}

function fetch_techcrunch() {
    dst_dir=${1?}
    for url in `generate_command "http://techcrunch.com/mobile" | grep ^http`; do
        command="xzb_mq_tool.py insert xzb_fetch_url.sh -d $dst_dir -f $url"
        $command
    done;
    sleep $SLEEP_SECONDS
}

########################################################################

######################### private functions ############################
function generate_seq() {
    start_id=${1?}
    end_id=${2?}
    val=""
    for((i=$start_id; i<= $end_id; i++)); do { val="$val $i" ;}; done
    echo "$val"
}

function generate_command() {
    generator_url=${1?}
    export GOPATH=$XZB_HOME/code/webcrawl_article/webcrawler
    cd $GOPATH
    go run ./src/main.go --fetch_url $generator_url --shall_generator
}
########################################################################
## File : fetch_post_utility.sh ends
