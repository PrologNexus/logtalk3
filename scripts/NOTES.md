________________________________________________________________________

This file is part of Logtalk <https://logtalk.org/>  
SPDX-FileCopyrightText: 1998-2025 Paulo Moura <pmoura@logtalk.org>  
SPDX-License-Identifier: Apache-2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
________________________________________________________________________


This directory contains support files for creating Docker containers and
shell scripts used for Logtalk documenting, testing, managing, packaging,
and installation.

Scripts with a `.sh` extension are Bash shell scripts for macOS, Linux,
and similar systems.

Scripts with a `.ps1` extension are PowerShell 7.3.x scripts for Windows
systems.

You can also use the Bash scripts on Windows operating-systems by installing
Git for Windows (which provides a Bash shell implementation and is available
from <http://msysgit.github.io>) and by adding the `$LOGTALKHOME/scripts`
and `$LOGTALKHOME/integration` directories plus the backend Prolog compiler
executable directories to the system path environment variable.

Depending on the details of you Logtalk installation, you may need to type
the scripts extensions when calling them.

Man pages are provided for all POSIX shell scripts, which can be listed
using the `apropos logtalk` command. HTML versions of the man pages are
also available in the Logtalk website.

- `build_release.sh`  
	helper script for building most of the distribution files of a new
	Logtalk release; must be run on a macOS computer due to its dependency
	on MacPorts to build the macOS installer

- `cleandist.sh`  
	script for cleaning a Logtalk distribution in preparation for packaging;
	expects to be called from the parent directory of the `scripts` directory

- `install.sh`  
	shell script for installing Logtalk in POSIX operating systems. When
	using the default installation directory prefix, it must be run from
	this directory by a user with administration privileges (for example,
	`sudo ./install.sh`). The default prefix is `/opt/local` on macOS,
	`/usr` on Debian systems, and `/usr/local` on other POSIX systems,
	resulting in Logtalk being installed in `$prefix/share` with useful
	scripts written to `$prefix/bin`, which should be in your path;
	the script also accepts as an optional argument a prefix for the
	installation directory (for example, `./install.sh -p $HOME`)

- `uninstall.sh`  
	shell script for uninstalling Logtalk in Unix and Unix-like operating
	systems (must be run from this directory by a user with administration
	privileges)

- `logtalk_tester.sh` and `logtalk_tester.ps1`  
	Bash shell script and PowerShell script for automating running unit tests
	in the current directory and recursively in all its sub-directories by
	scanning for either `tester.lgt` or `tester.logtalk` files;
	in its default output format, it reports, besides test results, compilation
	warnings and errors (please note that, depending on the tests and on the
	compilation mode, these warnings and errors might be expected);
	it can also write test results in the TAP and xUnit formats, generating files
	that can then be processed by continuous integration servers;
	known issue: the output of some multi-threading examples may interfere
	with the computation of the test/skipped/passed/failed totals;
	if the script detects either a `timeout` or a `gtimeout` command (provided
	by the GNU `coreutils` package), it will use it to run each test set if the
	`timeout` option is set to a value greater than zero;
	installation of the GNU `sed` command, when not available by default, is
	strongly recommended

- `logtalk_allure_report.sh` and `logtalk_allure_report.ps1`  
	Bash shell and PowerShell scripts for creating Allure test reports
	(https://allurereport.org/docs/); requires Allure 2.21.0 or a later
	version; these scripts should be called after running the `logtalk_tester.*`
	scripts using the `-f xunit` or `-f xunit_net_v2` command-line options

- `logtalk_doclet.sh` and `logtalk_doclet.ps1`  
	Bash shell script and PowerShell script for automating running doclets in
	the current directory and recursively in all its sub-directories by scanning
	for either `doclet.lgt` or `doclet.logtalk` files;
	if the script detects either a `timeout` or a `gtimeout` command (provided
	by the GNU `coreutils` package), it will use it to run each doclet if the
	`timeout` option is set to a value greater than zero

- `logtalk_version_select.sh`  
	shell script for switching between installed Logtalk versions for POSIX
	operating-systems; works with version 2.36.0 or later; doesn't change the
	Logtalk user folder; this script is loosely based on the `python_select`
	script

- `logtalk_backend_select.sh`  
	experimental shell script for defining an alias, logtalk, to a chosen
	backend Prolog integration script for POSIX operating-systems; the
	alias is created in the same directory where the `*lgt` integration
	scripts are found

- `debian`  
	directory containing support files for building the Debian package

- `docker`  
	directory containing support files for building Docker containers

- `embedding`  
	directory containing scripts for embedding the Logtalk compiler/runtime
	and Logtalk applications using selected backend Prolog compilers

- `freedesktop`  
	directory containing support files for adding the Logtalk mime-type
	to the freedesktop.org shared mime-info database

- `linux`  
	directory containing files used for building the RPM package

- `macos`  
	directory containing files used when building the macOS installer package

- `pack`  
	support files for creating a `logtalk` SWI-Prolog pack

- `pack-experimental`  
	support files for an experimental version of the SWI-Prolog pack
	that loads Logtalk into a `logtalk` module instead of loading it
	into `user`

- `windows`  
	directory containing files used when building the Windows GUI installer

- `logtalk_user_setup.sh` and `logtalk_user_setup.ps1`  
	end-user scripts for copying the Logtalk user-modifiable files and
	directories to the location pointed to by the environment variable
	`LOGTALKUSER` (defaults to `~/logtalk` on POSIX operating-systems
	and to `My Documents\Logtalk` on Windows when the variable is not
	defined); must be run by each end-user in order to ensure proper
	permissions for the copied files; the `LOGTALKHOME` environment
	variable must be defined (pointing to the Logtalk installation
	directory); the `logtalk_user_setup.ps1` script requires either
	running by a user with administration privileges due to the creation
	of symbolic links or turning on "Developer mode" in the
	Settings -> Update & Security -> For Developers panel

- `update_man_html_versions.sh`  
	shell script for updating the HTML versions of the man pages; requires
	[`roffit`](https://github.com/bagder/roffit) to be installed and available
	from the system PATH
