#!/bin/sh
echo $(docker exec jupyter-build_jupyter_1 jupyter notebook list)
