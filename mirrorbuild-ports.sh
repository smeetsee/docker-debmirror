
## Taken from https://help.ubuntu.com/community/Debmirror?action=recall&rev=42
#### Start script to automate building of Ubuntu mirror #####
## THE NEXT LINE IS NEEDED THE REST OF THE LINES STARTING WITH A # CAN BE DELETED

#!/bin/bash

## Setting variables with explanations.

#
# Don't touch the user's keyring, have our own instead
#
export GNUPGHOME=/opt/mirror/keyring-ubuntu-ports

# Arch=         -a      # Architecture. For Ubuntu can be i386, powerpc or amd64.
# sparc, only starts in dapper, it is only the later models of sparc.
# For multiple  architecture, use ",". like "i386,amd64"

arch=arm64

# Minimum Ubuntu system requires main, restricted
# Section=      -s      # Section (One of the following - main/restricted/universe/multiverse).
# You can add extra file with $Section/debian-installer. ex: main/debian-installer,universe/debian-installer,multiverse/debian-installer,restricted/debian-installer
#
section=main,restricted,universe,multiverse

# Release=      -d      # Release of the system (, focal ), and the -updates and -security ( -backports can be added if desired)
# List of updated releases in: https://wiki.ubuntu.com/Releases
# List of sort codenames used: http://archive.ubuntu.com/ubuntu/dists/

release=focal,focal-security,focal-updates,jammy,jammy-security,jammy-updates

# Server=       -h      # Server name, minus the protocol and the path at the end
# CHANGE "*" to equal the mirror you want to create your mirror from. au. in Australia  ca. in Canada.
# This can be found in your own /etc/apt/sources.list file, assuming you have Ubuntu installed.
#
server=nl.ports.ubuntu.com

# Dir=          -r      # Path from the main server, so http://my.web.server/$dir, Server dependant
#
inPath=/ubuntu-ports

# Proto=        --method=       # Protocol to use for transfer (http, ftp, hftp, rsync)
# Choose one - http is most usual the service, and the service must be available on the server you point at.
# For some "rsync" may be faster.
proto=rsync

# Outpath=              # Directory to store the mirror in
# Make this a full path to where you want to mirror the material.
#
outPath=/opt/mirror/ubuntu-ports

## ADDED BY Xander Smeets, used to copy GPG keys from Docker image
mkdir -p $GNUPGHOME
rm -f $GNUPGHOME/trustedkeys.gpg
gpg --no-default-keyring --keyring $GNUPGHOME/trustedkeys.gpg --import /usr/share/keyrings/ubuntu-archive-keyring.gpg
chown -R root:root $GNUPGHOME
chmod -R 555 $GNUPGHOME
## END ADDED BY Xander Smeets

# The --nosource option only downloads debs and not deb-src's
# The --progress option shows files as they are downloaded
# --source \ in the place of --no-source \ if you want sources also.
# --nocleanup  Do not clean up the local mirror after mirroring is complete. Use this option to keep older repository
# Start script
#
debmirror       -a $arch \
                --no-source \
                -s $section \
                -h $server \
                -d $release \
                -r $inPath \
                --progress \
                --method=$proto \
                --exclude-deb-section=games \
                $outPath


#### End script to automate building of Ubuntu mirror ####