#!/usr/bin/env python
"""Package definition for yangsuite."""

import os
from setuptools import setup, find_packages


setup(
    # Package description
    name="yangsuite",
    description="YANG Suite core application",
    long_description=read('README.rst'),
    url="https://wiki.cisco.com/display/DDMICIA/Yang-Suite",
    author="YANG Suite development team",
    author_email="yang-suite-dev@cisco.com",
    version=1.0.0.GA
    license=read('LICENSE.txt'),
    # Requirements
    python_requires='>=3.6,<3.9',
    install_requires=ys_required,
    # Package contents
    cmdclass=versioneer.get_cmdclass(),
    packages=ys_packages,
    include_package_data=True,
    entry_points={
        # Register yangsuite itself as a discoverable application plugin
        'yangsuite.apps': ['yangsuite = yangsuite.apps:_YangsuiteConfig'],
        # Start YANG Suite server
        'console_scripts': [
            'yangsuite = yangsuite.application:main',
        ],
    },

    # PyPI search categories
    # https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        'Development Status :: 4 - Beta',
        'Environment :: Web Environment',
        'Framework :: Django',
        'Framework :: Django :: 2.0',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'Intended Audience :: Telecommunications Industry',
        'License :: Other/Proprietary License',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: Microsoft :: Windows :: Windows 10',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: JavaScript',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Topic :: Software Development',
        'Topic :: Software Development :: Quality Assurance',
        'Topic :: Software Development :: Testing',
        'Topic :: System :: Networking',
        'Topic :: System :: Systems Administration',
    ],
    keywords='yang netconf rfc6020 rfc7950 yangsuite',
)
