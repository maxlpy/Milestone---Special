#!/bin/bash
git config --global user.name "Nikhil Katre"
git config --global user.email "nkatre@ncsu.edu"
git pull
git add .
git commit -m "committed the project for production release"
git push origin master
git push production master
#
