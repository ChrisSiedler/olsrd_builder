#!/bin/bash
docker build . -t olsrd

#docker run --rm -it -v ./output/:/output/ olsrd:latest bash

docker run --rm -v $(pwd)/output:/output/ olsrd:latest bash -c 'cp olsrd*.deb /output/'

