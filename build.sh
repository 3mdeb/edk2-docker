#!/bin/bash

USERNAME="3mdeb"
IMAGE="edk2"

docker build -t $USERNAME/$IMAGE:latest .
