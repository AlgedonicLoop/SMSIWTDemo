#!/bin/sh
npm run demo:server:start &> server.log &
npm run demo:ui:start &> ui.log
