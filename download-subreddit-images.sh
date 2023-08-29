#!/bin/bash

#cfg
useragent="Love by u/gadelat"

subreddit=$1
sort=$2
top_time=$3

if [ -z $sort ]; then
    sort="hot"
fi

if [ -z $top_time ];then
    top_time=""
fi

url="https://www.reddit.com/r/$subreddit/$sort/.json?raw_json=1&t=$top_time"
content=`curl -H "User-Agent: $useragent" $url`
mkdir -p $subreddit
while : ; do
    urls=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.preview.images[0].source.url')
    names=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.title')
    ids=$(echo -n "$content"| jq -r '.data.children[]|select(.data.post_hint|test("image")?) | .data.id')
    a=1
    wait # prevent spawning too many processes
    for url in $urls; do
        name=`echo -n "$names"|sed -n "$a"p`
        id=`echo -n "$ids"|sed -n "$a"p`
        ext=`echo -n "${url##*.}"|cut -d '?' -f 1`
        newname=`echo $name | sed "s/^\///;s/\// /g"`_"$subreddit"_$id.$ext
        echo $name
        curl -H "User-Agent: $useragent" --no-clobber --output "$subreddit/$newname" $url &>/dev/null &
        a=$(($a+1))
    done
    after=$(echo -n "$content"| jq -r '.data.after//empty')
    if [ -z $after ]; then
        break
    fi
    url="https://www.reddit.com/r/$subreddit/$sort/.json?count=200&after=$after&raw_json=1&t=$top_time"
    content=`curl -H "User-Agent: $useragent" $url`
done
