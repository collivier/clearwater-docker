#!/bin/bash
while ! usr/share/clearwater/ellis/env/bin/python /usr/share/clearwater/ellis/src/metaswitch/ellis/tools/create_numbers.py --start 6505550000 --count 1000 >> /var/log/create_numbers.log 2>&1
do
  sleep 1
done
cat /var/log/create_numbers.log
