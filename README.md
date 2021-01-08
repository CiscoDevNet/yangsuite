YANG Suite
==========

YANG Suite core Django application.

Capable of dynamic discovery of installed application plugins.
Provides common library APIs for logging, filesystem access,
GUI appearance and behavior, and client-server communication.

Authors:  Michael Ott and the other members of yang-suite-dev@cisco.com
Supports: Python 3.6, Python 3.7, Python 3.8

YANG Suite can be installed as a Docker container or through Python
package management.  Docker-compose is the recommended install.

Docker installation and use
---------------------------

Installation
~~~~~~~~~~~~

WARNING: Change admin username/password default in docker-compose.yml file first!

To ensure you have the latest release of the YANG Suite Docker container,
from a terminal or PowerShell window, git clone git@github.com:CiscoDevNet/yangsuite.git
and run this command in the yangsuite/docker/ directory ::

    docker-compose up

The yangsuite/docker/yangsuite/production.py file contains Django settings.

Adding/Updating plugins can be done through the Admin-->Manage plugins page or by copying
the plugin wheels into the yangsuite/docker/yangsuite/ directory, uncommenting the appropriate
lines in the yangsuite/docker/yangsuite/dockerfile, and running ::

    docker-compose up --build

Access with web browser
~~~~~~~~~~~~~~~~~~~~~~~

- Connect to http://localhost:8480.
- Default (administrator) login is ysadmin/superysadmin. You should change this after your first login.

Python package installation and use
-----------------------------------

Installation (virtualenv)
~~~~~~~~~~~~~~~~~~~~~~~~~

- Create a python 3.6, 3.7, or 3.8 virtural environment and activate it.
- Type ``pip install yangsuite[core]``
- Type ``yangsuite`` to start the yangsuite server.

Installation with pyATS
~~~~~~~~~~~~~~~~~~~~~~~

- Create a python 3.6, 3.7, or 3.8 virtural environment and activate it.
- Type ``pip install pyats[full]``
- Type ``pip install yangsuite[core]``
- Type ``yangsuite`` to start the yangsuite server.

Configuring yangsuite Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Activate the virtual environment
- Type ``yangsuite -h``
