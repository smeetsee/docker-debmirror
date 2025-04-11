FROM ubuntu:noble
MAINTAINER Xander Smeets <xander@smeets.ee>
RUN apt-get update && apt-get install -y debmirror rsync gnupg xz-utils && rm -rf /var/lib/apt/lists/*
