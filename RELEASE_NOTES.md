
Introduction
============

YANG Suite consists of several Django applications with most working independently.

The core applications consist of:

- yangsuite - UI routing, central logging, general utility APIs, google analtics reporting, and user and plugin management
- yangsuite-devices - Device management
- yangsuite-filemanager - YANG file and YANG set management
- yangsuite-yangtree - Converts YANG files to JSON objects for general use
- yangsuite-netconf - Communicates with devices using NETCONF protocol

Optional plugins consist of:

- yangsuite-coverage - Analysis of YANG files presenting customizable spreadsheets and diffs
- yangsuite-grpc-telemetry - Model Driven Telemetry listener for device telemetry streams
- yangsuite-gnmi - Communicates with devices using gNMI protocol
- yangsuite-restconf - Communicates with devices using RESTCONF protocol

yangsuite
=========

2.8.2
-----

- Docker-compose opened port 443 for yangsuite-restconf plugin.
- Added yangsuite-gnmi and yangsuite-restconf to docker install.
- FIX: Docker container install not copying static files to right location.
- FIX: Manage plugin page "latest release" not valid and updates not working.
- FIX: X mark to close some dialog boxes is malformed
- FIX: When user deletes previous install of YANG Suite including data directory, several errors happen with new install.

yangsuite-devices
=================

2.8.7
-----

- FIX: cryptography<=3.3.1 dependency conflict with pyats installs
- FIX: User unable to delete all variables in device profile
- FIX: No online documetation for new TLS/SSL settings
- FIX: Dependent modules missing from default repository/yangset
- FIX: Check reachability only works from edit dialog box
- FIX: Unable to delete variables from device profile
