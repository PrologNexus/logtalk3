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


QUICK START INSTRUCTIONS
========================

Starting up Logtalk
-------------------

Install Logtalk by using either the [installer](https://logtalk.org/download.html)
provided for your operating-system or by following the manual installation
instructions in the [`INSTALL.md`](INSTALL.md) file. An alternative to installing
Logtalk (and backend and tools dependencies) locally in your system is to use one
of the Docker images available from [Docker Hub](https://hub.docker.com/u/logtalk/).

On POSIX operating-systems, the following shell scripts are installed by
default for running Logtalk with the supported backend Prolog compilers
(which must be installed and up-to-date before running these scripts):

* B-Prolog:       `bplgt`      (experimental)
* Ciao Prolog:    `ciaolgt`    (experimental; first run may require `sudo`)
* CxProlog:       `cxlgt`
* ECLiPSe:        `eclipselgt`
* GNU Prolog:     `gplgt`
* JIProlog:       `jiplgt`     (first run may require `sudo`)
* Quintus Prolog: `quintuslgt` (experimental)
* SICStus Prolog: `sicstuslgt`
* SWI-Prolog:     `swilgt`
* Tau Prolog:     `taulgt`
* Trealla Prolog: `tplgt`
* XSB:            `xsblgt`     (first run may require `sudo`)
* XVM:            `xvmlgt`
* YAP:            `yaplgt`

Man pages for all scripts are also provided on POSIX systems. HTML versions
of the man pages are available in the [Logtalk website](https://logtalk.org/documentation.html#man-pages).

On macOS systems, `/opt/local/bin` must be in your `PATH` to run the scripts
when using the provided installer. Terminal command files for running Logtalk
with selected backend Prolog compilers are also available on the Logtalk
installation folder (by default, `/opt/local/share/logtalk/scripts/macos/command_files`).
For easy access, the installer creates an alias to the Logtalk folder in
the Applications folder.

On Windows systems, shortcuts for running Logtalk with selected backend
Prolog compilers are created in the `Start Menu/Programs/Logtalk` menu.
The first run of the JIProlog and XSB integration shortcuts may require
administrator privileges depending on the JIProlog and XSB installation
(right-click on the shortcut and select the "Run as administrator" option).
PowerShell versions of the scripts listed above are also available (e.g.,
`gplgt.ps1`). PowerShell 7.3 or later version is required for running
these scripts.

If you get an unexpected failure when using one of the Prolog integration
scripts or shortcuts, consult the [`adapters/NOTES.md`](adapters/NOTES.md)
file in the Logtalk installation folder for compatibility notes. For the
integration scripts, see also the integration script `man` page.

For a quick overview of some of the main Logtalk concepts, see the
at [Learn X in Y minutes Where X=Logtalk](https://learnxinyminutes.com/docs/logtalk/)
tutorial. See also the bundled [Handbook](docs/handbook/index.html) by
opening the `~/logtalk/docs/handbook/index.html` file with a web browser
(the `~/logtalk` directory is created when you run Logtalk for the first
time). The [Installing Logtalk](docs/handbook/userman/installing.html) and
[Writing and running applications](docs/handbook/userman/programming.html)
sections in the User Manual will provide you with a basic understanding of
how to start Logtalk as well as how to compile and load Logtalk code.

Basic help on Logtalk usage at the top-level interpreter
--------------------------------------------------------

Start Logtalk and call the goal `{help(loader)}` followed by `help::help`.
This will provide you with an overview of how to get help and how to load
and debug your code. This tool can be automatically loaded at startup by
using a settings file (see the [CUSTOMIZE.md](CUSTOMIZE.md) file for details).

Help on understanding compiler errors and warnings
--------------------------------------------------

Start Logtalk and call the goal `{tutor(loader)}`. The `tutor` tool will
augment compiler errors and warnings with explanations and suggestions on
how to solve the reported problems. This tool can be automatically loaded
at startup by using a settings file (see the [CUSTOMIZE.md](CUSTOMIZE.md)
file for details).

Loading libraries, examples, and tools
--------------------------------------

From within a source file, use the goal `logtalk_load(<name>(loader))`. For
example, `logtalk_load(optionals(loader))`. At the top-level interpreter, a
`{<name>(loader)}` shortcut is available. For example, `{debugger(loader)}`.

Running an example
------------------

You may now try some examples. The [`examples/NOTES.md`](examples/NOTES.md)
file contains a brief description of each example. The
[learning guide](https://logtalk.org/learning.html) includes a suggested
walkthrough.

1. Select an example and open its directory.

2. Read the example `NOTES.md` file for a description of the example,
instructions on how to load it, and for sample queries that you may try
by copying and pasting them to your Prolog interpreter top-level or by
opening the `NOTES.md` file as a Jupyter notebook (after installing the
Logtalk kernel).

Writing your own programs
-------------------------

Ready to start writing your own programs?

1. Read the Handbook sections on "Writing and running applications" and
"Debugging". If you want to use your Prolog backend resources, read also
the section on "Prolog integration and migration".

2. Take a look at the [`coding`](coding) directory. There you will find
syntax  support files for popular text editors that enable syntax coloring
and other text services when editing Logtalk source files. There's also
support for syntax highlighters used for publishing source code and for
source code versioning systems.

3. The [`tools`](tools) directory contains a comprehensive set of developer
tools to help you test, debug, analyze, and document your applications.

4. Create a directory (preferably outside of your Logtalk user folder,
which is updated when you update Logtalk) with a suitable name to hold
all the files of your application.

5. Copy or rename the [`samples/settings-sample.lgt`](samples/settings-sample.lgt)
file to `settings.lgt`, and modify it to preload developer tools (e.g., the `help`
and `debugger` tools), to define library aliases for your applications, to
define default compiler flags, and more (see the comments in the file itself
and the [`CUSTOMIZE.md`](CUSTOMIZE.md) file for details).

6. Copy to your application directory the [`samples/loader-sample.lgt`](samples/loader-sample.lgt)
file, rename it to `loader.lgt`, and modify it to load your application source
files. You may also copy the [`samples/tester-sample.lgt`](samples/tester-sample.lgt)
and [`samples/tests-sample.lgt`](samples/tests-sample.lgt) files, renaming
them to `tester.lgt` and `tests.lgt`, and editing them to define and run your
application unit tests.

7. Have fun!
