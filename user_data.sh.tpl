#!/bin/bash
# 更新hosts文件
echo "Updating hosts..."

# 写入hosts文件
echo "127.0.0.1 ${instance_name}" >> /etc/hosts
echo "Hosts updated with instance name ${instance_name}"