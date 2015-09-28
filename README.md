# apcupsd

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures the apcupsd UPS monitor for APC UPS units.

## Usage

This module has only one class, and takes the following parameters:

### `upsname`

Give your UPS a name in log files and such. It should be 8 characters or less.

### `upscable`

Defines the type of cable connecting the UPS to your computer. Choose from:
`simple`, `smart`, `ether`, `usb`. Default: `usb`.

### `upstype`

Define the type of UPS you have. Choose from `apcsmart`, `usb`, `net`, `snmp`,
`dumb`, `pcnet`. Default: `usb`.

### `device`

For USB UPSes, leave `$device` blank. For other UPS types, you must specify an
appropriate port or address. Consult the table for example values for `$device`.
Default: `undef`.

`$upstype` | `$device`
-----------|-----------
`apcsmart` | `/dev/ttyS0`
`usb`      | `<BLANK>`
`net`      | `hostname:port`
`snmp`     | `hostname:port:vendor:community`
`dumb`     | `/dev/ttyS0`
`pcnet`    | `ipaddr:username:passphrase:port`

### `onbatterydelay`

Time in seconds from when a power failure is detected until we react to it with
an onbattery event. Default: `6`.

### `batterylevel`

If during a power failure, the remaining battery percentage (as reported by the
UPS) is below or equal to `$batterylevel`, apcupsd will initiate a system shutdown.
Default: `5`.

### `minutes`

If during a power failure, the remaining runtime in minutes (as calculated
internally by the UPS) is below or equal to `$minutes`, apcupsd will initiate a
system shutdown. Default: `3`.

### `netserver`

Enables the network information server. If netstatus is on, a network information
server process will be started for serving the STATUS and EVENT data over the
network (used by CGI programs). Choose from: `on`, `off`. Default: `on`.

## Limitations

This module was written for use with CentOS, although it should work on other
distributions too.

Currently this module only supports configuring a single UPS attached to the
local system. Future versions may support multiple UPSes on a single system or
network communication between systems sharing the same UPS, to co-ordinate
shutdown.

## Development

If you can contribute to improve this module, please send a pull request.

## Release Notes

### `0.1.0`

Initial release, with support for a single UPS on a single system.

### `0.2.0`

Added support for setting mail destination address for events scripts.
