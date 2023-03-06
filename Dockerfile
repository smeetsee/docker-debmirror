FROM ubuntu:jammy
MAINTAINER Xander Smeets <xander@smeets.ee>
RUN apt-get update && apt-get install -y debmirror rsync && && rm -rf /var/lib/apt/lists/*
