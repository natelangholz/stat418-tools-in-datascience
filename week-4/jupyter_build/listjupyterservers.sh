#!/bin/sh
echo $(docker exec jupyter_build_jupyter_1 jupyter notebook list)
