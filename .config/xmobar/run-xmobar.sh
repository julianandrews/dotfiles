#!/usr/bin/env sh

cleanup() { trap : TERM; kill 0; }
trap cleanup EXIT

xmobar
