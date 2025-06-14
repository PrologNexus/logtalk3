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


This directory contains the sources for the Logtalk documentation (which
include the User Manual, Reference Manual, FAQ, and Glossary). The sources
are written using the reStructuredText markup language and converted to
HTML, PDF, ePub, Texinfo, and Markdown formats using Sphinx:

http://sphinx-doc.org/

The Markdown format is a LLM friendly single file version. Users can copy
this single file to their project directory when using AI coding tools to
help avoid hallucinations and generate quality code.

The conversion uses the `sphinx_rtd_theme` theme:

https://github.com/rtfd/sphinx_rtd_theme

The included Makefile allows exporting the documentation in the final
formats. For example:

	$ make clean && make html && make latexpdf && make epub

After completion, the exported files are found in the `_build` directory.
The `build.sh` and `build.ps1` scripts can be used to both export all the
final formats and move the final files to the `manuals` root directory in
the distribution.

The required Python packages can be installed using the commands:

	$ python3 -m pip install --upgrade pygments
	$ python3 -m pip install --upgrade sphinx
	$ python3 -m pip install --upgrade sphinx_rtd_theme

Required versions are:

- Sphinx 7.4.7 or later
- RTD theme 2.0.0 or later
- Pygments 2.19.1 or later

Also required is `pandoc` (used e.g. to convert the general, non-API,
documentation of library, ports, and contributions from Markdown to
reStructuredText). Required version:

- Pandoc 2.19.2 or later
