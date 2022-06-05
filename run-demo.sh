#!/bin/sh
node demo/server/index.js &> server.log &
node demo/ui/server.js &> ui.log
