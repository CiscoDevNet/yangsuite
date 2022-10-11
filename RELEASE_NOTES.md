
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

2.8.8
-----

- FIX: Python packaging library restriction conflicts with pyATS 22.1

2.8.9
-----

- FIX: MarkupSafe third part library version 2.1.0 gets soft_unicode import traceback error with new installs of yangsuite.

2.9.0
-----

- FEATURE: Switch from Django development web server to uwsgi.  Using “yangsuite —debug” reverts back to development server if needed.
- FEATURE: During plugin updates, a new message may be sent requiring you to manually reboot the yangsuite server if update requires it.

2.9.1
-----

- FIX: Getting uwsgi errors at install time.

2.9.2
-----

- FIX: Getting uwsgi error updating plugins.

2.9.3
-----

- FEATURE: Added support for Python 3.8.

- FIX: Lost your password? does not send me an email to reset password.


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

2.9.3
-----

- FIX: User gets Invalid IP address error when using FQDN host name instead of an IP address.


yangsuite-filemanager
=====================

1.8.1
-----

- FEATURE: Added Cisco Copyright to source code files.

- FIX: Some links broken in external documentation

1.8.2
-----

- FIX: APIs adjusted to use new yangtree APIs.

1.8.3
-----

- FIX - Yangset must be deleted to replace model version
- FIX - Lock error when multiple users are accessing multiple yangsets

1.8.4
-----

- FEATURE: Allow Multiple Versions of YANG Modules in One YANG Set (for yangsuite-mapper).

1.8.5
-----

- FEATURE: Allow users to add multiple versions of a YANG file into a single YANG set
    - This feature is for advanced users only, because adding multiple versions to a single YANG set may corrupt the tree

1.8.6
-----

- FIX: Error - Please wait yangset data is not ready yet.

1.9.0
-----

- FEATURE: Changed delete yangset APIs to comply with new yangset tree caching added in yangsuite-yangtree 2.0.0.

yangsuite-gnmi
==============

2.1.9
-----

- FIX: Version conflict with grpcio in fresh install

2.2.0
-----

- FEATURE: Modified to use new yangsuite-yangtree APIs for creating trees.

2.2.1
-----

- FEATURE: Modified to use new yangsuite-yangtree APIs for creating trees.

2.3.1
-----

- FEATURE: User can paste in a well-formed dictionary representing a gNMI request and Run RPC.

- FIX: RPC built using OpenConfig models resulted in malformed gNMI messages.
- FIX: User interface has large gaps of unused space in top portion.

2.3.2
-----

- FIX: Pasting in set request to run frame causes UnboundLocalError: on gnmi_string
- FIX: Setting a single leaf causes a malformed gNMI SetRequest.

2.3.3
-----

- FIX: Building JSON fails if the module the message is based on is not the first module.

2.4.1
-----

- FEATURE: Users can now edit the Run RPC(s) window similar to the NETCONF page.
  - Build an RPC using all the correct settings.
  - Run RPC and observe results.
  - Add parameters or change existing ones in the RPC window and the interface will run your new settings.
  - If you already have a well-formed python dict, you can:
    - Select a device (no need to load a module)
    - Still set all the correct parameters in the page such as supported encodings, origin, prefix, subscribe settings.
    - Click on the Run RPC button.

- FIX: Complicated RPCs with multiple heirachy such as what is in most OpenConfig models do not construct the gNMI message correctly

2.4.2
-----

- FIX: gNMI check reachability was broken in v2.4.1

2.5.0
-----

- FEATURE: PROTO encoding is now supported.
- FEATURE: If secure-channel is requested and no certificate is loaded in device profile an attempt is made to download the certificate from device.
- FEATURE: Module has been added to Path origin choices.  If module is selected, the module name will be assigned to the Path origin.
- FEATURE: You can now download an RPC in an ansible-playbook that runs over Ansible Collection nokia.grpc https://galaxy.ansible.com/nokia/grpc

- FIX: Have to choose a device just to build RPC.
- FIX: Prefix Path logic mixed up with Xpath prefix logic of JSON_IETF encoding
- FIX: Union datatype not handled properly resulting in strings instead of integers

2.5.1
-----

- FIX: Starting yangsuite gets error - cannot import name 'proto'

2.6.0
-----

- FEATURE: Changed create tree APIs to comply with new yangset tree caching added in yangsuite-yangtree 2.0.0 so now GNMI tree is cached.

2.6.1
-----

- FIX: RPC generated is not correct when update and replace are present
- FIX: RPC generated is not correct when multiple list entries are selected

2.7.0
-----

- FEATURE: Added support for ASCII encoding for GNMI operations

- FIX: Invalid element name in GNMI message CSCwb93492
- FIX: GNMI operation on list node with multiple keys

2.7.1
-----

- FEATURE:  Added support for gnmi.proto 0.8 which adds double_val.

yangsuite-grpc-telemetry
========================

1.0.0
-----

- FEATURE: Run multiple telemetry receivers at the same time.
- FEATURE: Connect gRPC secure-channel TLS using server certificate and key uploaded to device 

1.0.1
-----

- FIX: Missing content of streaming messages.
- FIX: Errors are not reported.

1.0.2
-----

- FIX: Duplicate messages reported in browser.
- FIX: Receiver running over a couple days cripples browser.
- FIX: Message sent from device is returned back to device after processing by receiver.


yangsuite-netconf
=================

1.15.4
------

- FIX: Some key values and not updated correctly in xpath.

1.17.2
------

- FEATURE: Replays are now saved in pyATS. Genie format.

- FIX: Show, load, and save of replays have multiple issues.
- FIX: When a device certificate changes NETCONF cannot connect unless known_hosts is corrected.

1.17.3
------

- FIX: NETCONF page does not show run results.
- FIX: RPC malformed when nested list has multiple entries.

1.17.4
------

- FIX: When edit-op operation is added to list, duplicate list entries appear in RPC

1.17.5
------

- FIX: Saved replays take minutes to load.
- FIX: Replays with added list entries produces an extra entry in UI.
- FIX: User must "Build RPC" before saving a modified replay or changes don't register.

1.17.6
------

- FIX: Edit Operations on a single container does not show up when RPC is built.
- FIX: Reload of a replay does not cleanup the tree properly.
- FIX: Reload of a replay, tree does not include nested list in new list entry.

1.17.7
------

- FIX: Load replay - Operation not clearing in tree.
- FIX: Load replay - Case node not loading in tree.
- FIX: Load replay - Some nodes without prefixes not loading in tree.
- FIX: Build RPC from replay - some operations missing from rpc.
- FIX: Build RPC missing expected tag.

1.17.8
------

- FIX - Duplicate names of nodes in tree loaded from replay have wrong values
- FIX - Exported python script failing execution with latest ncclient

1.17.9
------

- FEATURE: In the Replay menu, user can now download an Ansible script based on a built RPC.

- FIX: NETCONF fails connectivity when certificate changes
- FIX: gNMI Build RPC does not handle union datatype.
- FIX: NETCONF replay load, operation not showing on extra list entry

1.17.10
-------

- FIX: Multiple leaf-list entries added and set in tree is not building multiple entries in RPC.
- FIX: If invalid XML is pasted into the text info and a user selects "Generate Ansible Playbook" no error is reported and the script still downloads.
- FIX: Saving and loading replays is broken for some cases of multiple list entries
- FIX: A list entry is not shown in tree when saved replay is loaded.

1.17.11
-------

- FIX: Cannot delete presence container
- FIX: Browser hangs up collapsing branches of large models
- FIX: Running RPCs, multiple tabs open in browser for same device log.

1.17.14
-------

- FIX: Creating replay, the RPC well formed XML format is not maintained in the yaml file

1.17.15
-------

- FIX: RPC reply has double-spacing between tags making it difficult to read


yangsuite-restconf
==================

2.0.3
-----

- FIX: Unable to collapse tree branch after expansion.
- FIX: Dropdown menus not closing after selection.

2.1.0
-----

- FEATURE: Changed create tree APIs to comply with new yangset tree caching added in yangsuite-yangtree 2.0.0 so now RESTCONF tree is cached.
- FEATURE: Added ability to download an Ansible script based on chosen Xpath, method, and value.
- FEATURE: Updated OpenAPI UI (Swagger) from version 2 to version 3, added depth limit option.


yangsuite-yangtree
==================

1.19.2
------

- FEATURE: Added Cisco Copyright to source code files.

- FIX: Some links broken in external documentation

1.19.3
------

- FIX: Yangset create, delete, update APIs are not backward compatible and have redundant parameters.

1.19.4
------

- FIX: 1.19.3 introduced an issue that caused an error when trying to load yangsets with names that contained spaces, uppercase, underscores, and dots.

1.19.5
------

- FIX: Augmenting submodule namespace not added to RPC.
- FIX: Show, load, and save of replays have multiple issues.
- FIX: Server memory is used up when multiple users have YANG sets loaded.

1.19.6
------

- FIX: Nested list produces malformed RPC in NETCONF page.

1.19.7
------

- FIX: RPC malformed when nested list has multiple entries.

1.19.8
------

- FIX: Switching from edit-config to get-config RPC still had edit-operations from Operation column.

1.19.9
------

- FEATURE: Added API to delete all added list entries from tree.

- FIX: Must delete entire yangset to replace one model with new version

1.19.10
-------

- FIX - Windows install gets error creating yangset
- FIX - Test section from replay yang action not named after replay
- FIX - Manage replays page missing data and editor hard to read
- FIX - Some prefixes not reflected in generated test xpaths
- FIX - KeyError validating some yangsets in greater depth

1.19.11
-------

- FIX: CSCwa21398 - Value of the parentkey/child key nodes doesn't show up correctly in RPC
- FIX: CSCwa61362 - gNMI Build RPC does not handle union datatype.
- FIX: Some mandatory nodes are not found when using xpath to search.

2.0.4
-----

- FEATURE:  Model tree caching improvements resulting in faster tree loading in browser. (This update requires a yangsuite server reboot.)

- FIX: Saved replay not working when RPC is pasted in

2.0.5
-----

- FIX: Browser hangs up collapsing branches of large models
- FIX: Ranges can have OR of single value defined but single value is not in properties

2.0.6
-----

- FIX: Cisco-IOS-XE-native module, browser hangs up when trying to collapse tree
- FIX: Saving replay, RPC well formed XML format is not maintained in the yaml file

2.0.7
-----

- FIX: Docker install fails RuntimeError: Model class ysyangtree.models.YangSetJSON
