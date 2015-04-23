#!/bin/bash
#ssh -t 127.0.0.1 "sudo command"
sudo git config --global user.name "Nikhil Katre"
sudo git config --global user.email "nkatre@ncsu.edu"
sudo git pull origin master
sudo git push production master
#
