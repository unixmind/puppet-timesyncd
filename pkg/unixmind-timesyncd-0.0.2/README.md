# timesyncd

#### Table of Contents

1. [Description](#description)
1. [Usage](#usage)
1. [Limitations](#limitations)

## Description

Starting with Debian jessie, "ntp" package is no longer required to synchronize your server using NTP protocol.
New "systemd-timesyncd" service is the prefered method.

This module :
* Removes "ntp" package
* Creates "/etc/systemd/timesyncd.conf" file with "www.ntp.org" time references
* Starts and enables "systemd-timesyncd"

## Usage

include ::timesyncd

## Limitations

On Debian 8.x (jessie) only !

