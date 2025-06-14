#!/usr/bin/env bash

#############################################################################
##
##   Logtalk script for updating the HTML core, library, tools, ports,
##   contributions, and (optionally) packs documentation
##
##   Last updated on May 11, 2025
##
##   This file is part of Logtalk <https://logtalk.org/>
##   SPDX-FileCopyrightText: 1998-2025 Paulo Moura <pmoura@logtalk.org>
##   SPDX-License-Identifier: Apache-2.0
##
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##
##       http://www.apache.org/licenses/LICENSE-2.0
##
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
##
#############################################################################


# allow using this script from any directory
cd "$(dirname "$0")" || exit 1


operating_system=$(uname -s)

if [ "${operating_system:0:10}" == "MINGW32_NT" ] ; then
	# assume that we're running on Windows using the Git for Windows bash shell
	extension='.sh'
elif [ "$LOGTALKHOME" != "" ] && [ "$LOGTALKUSER" != "" ] && [ "$LOGTALKHOME" == "$LOGTALKUSER" ] ; then
	# assume that we're running Logtalk without using the installer scripts
	extension='.sh'
else
	extension=''
fi


# default to SWI-Prolog as some of the documentation should be
# generated using a multi-threaded backend Prolog compiler
backend=swi
logtalk="swilgt$extension -g"
include_packs='false'
if [ "$LOGTALKPACKS" != "" ] ; then
	logtalk_packs='$LOGTALKPACKS/'
else
	logtalk_packs='$HOME/logtalk_packs/'
fi

cwd=$(pwd)

set_goal() {
# documentation goal
	if [ "$include_packs" == 'true' ] ; then
		goal="set_logtalk_flag(source_data,on),logtalk_load([library(all_loader),library(packs_loader),tools(loader),issue_creator(loader),ports_profiler(loader),tutor(loader),wrapper(loader),lgtunit(coverage_report),lgtunit(automation_report),lgtunit(minimal_output),lgtunit(tap_output),lgtunit(tap_report),lgtunit(xunit_output),lgtunit(xunit_report),lgtunit(xunit_net_v2_output),lgtunit(xunit_net_v2_report),ports(loader),contributions(loader)]),lgtdoc::all([xml_docs_directory('$cwd'),omit_path_prefixes(['$LOGTALKUSER/','$LOGTALKHOME/', '$logtalk_packs'])]),halt."
	elif [ "$LOGTALKPACKS" != "" ] ; then
		goal="set_logtalk_flag(source_data,on),logtalk_load([library(all_loader),tools(loader),issue_creator(loader),ports_profiler(loader),tutor(loader),wrapper(loader),lgtunit(coverage_report),lgtunit(automation_report),lgtunit(minimal_output),lgtunit(tap_output),lgtunit(tap_report),lgtunit(xunit_output),lgtunit(xunit_report),lgtunit(xunit_net_v2_output),lgtunit(xunit_net_v2_report),ports(loader),contributions(loader)]),lgtdoc::all([xml_docs_directory('$cwd'),omit_path_prefixes(['$LOGTALKUSER/','$LOGTALKHOME/']),exclude_prefixes(['$HOME/logtalk_packs/','$LOGTALKPACKS/'])]),halt."
	else
		goal="set_logtalk_flag(source_data,on),logtalk_load([library(all_loader),tools(loader),issue_creator(loader),ports_profiler(loader),tutor(loader),wrapper(loader),lgtunit(coverage_report),lgtunit(automation_report),lgtunit(minimal_output),lgtunit(tap_output),lgtunit(tap_report),lgtunit(xunit_output),lgtunit(xunit_report),lgtunit(xunit_net_v2_output),lgtunit(xunit_net_v2_report),ports(loader),contributions(loader)]),lgtdoc::all([xml_docs_directory('$cwd'),omit_path_prefixes(['$LOGTALKUSER/','$LOGTALKHOME/']),exclude_prefixes(['$HOME/logtalk_packs/'])]),halt."
	fi
}

print_version() {
	echo "$(basename "$0") 0.30"
	exit 0
}


usage_help() {
	echo
	echo "This script updates the HTML documentation of the core entities, library,"
	echo "developer tools, ports, contributions, and optionally installed packs."
	echo
	echo "Usage:"
	echo "  $(basename "$0") [-p prolog] [-i]"
	echo "  $(basename "$0") -v"
	echo "  $(basename "$0") -h"
	echo
	echo "Optional arguments:"
	echo "  -p backend Prolog compiler (default is $backend)"
	echo "     (valid values are b, ciao, cx, eclipse, gnu, ji, xvm, sicstus, swi, swipack, tau, trealla, xsb, and yap)"
	echo "  -i include all installed packs"
	echo "  -v print version of $(basename "$0")"
	echo "  -h help"
	echo
}


while getopts "vip:m:d:h" option; do
	case $option in
		v) print_version;;
		p) p_arg="$OPTARG";;
		i) include_packs='true';;
		h) usage_help; exit 0;;
		*) usage_help; exit 1;;
	esac
done


if [ "$p_arg" == "b" ] ; then
	prolog='B-Prolog'
	logtalk="bplgt$extension -g"
elif [ "$p_arg" == "ciao" ] ; then
	logtalk="ciaolgt$extension -e"
elif [ "$p_arg" == "cx" ] ; then
	logtalk="cxlgt$extension --goal"
elif [ "$p_arg" == "eclipse" ] ; then
	logtalk="eclipselgt$extension -e"
elif [ "$p_arg" == "gnu" ] ; then
	logtalk="gplgt$extension --query-goal"
elif [ "$p_arg" == "ji" ] ; then
	logtalk="jiplgt$extension -n -g"
elif [ "$p_arg" == "xvm" ] ; then
	logtalk="xvmlgt$extension -g"
elif [ "$p_arg" == "sicstus" ] ; then
	logtalk="sicstuslgt$extension --goal"
elif [ "$p_arg" == "swi" ] ; then
	logtalk="swilgt$extension -g"
elif [ "$p_arg" == "swipack" ] ; then
	logtalk="swipl -g"
elif [ "$p_arg" == "tau" ] ; then
	logtalk="taulgt$extension -g"
elif [ "$p_arg" == "trealla" ] ; then
	logtalk="tplgt$extension -g"
elif [ "$p_arg" == "xsb" ] ; then
	logtalk="xsblgt$extension -e"
elif [ "$p_arg" == "yap" ] ; then
	logtalk="yaplgt$extension -g"
elif [ "$p_arg" != "" ] ; then
	echo "Error! Unsupported backend Prolog compiler: $p_arg" >&2
	usage_help
	exit 1
fi

set_goal
$logtalk "$goal"
lgt2rst -t "Logtalk APIs"
if [ "$include_packs" == 'true' ] ; then
	cp _templates/layout_packs.html _templates/layout.html
else
	cp _templates/layout_no_packs.html _templates/layout.html
fi
mv _conf.py conf.py

make clean
make html
make info
make latexpdf
make epub
make singlehtml
#make linkcheck

version_base=$(cat ../../../VERSION.txt | cut -f1 -d"-")
pandoc _build/singlehtml/index.html --wrap=none -t gfm-raw_html -o _build/singlehtml/LogtalkAPIs-$version_base.md

# Handle sed differences between GNU and BSD
case $(sed --help 2>&1) in
	*GNU*) sed_i () { sed -i "$@"; };;
	*) sed_i () { sed -i '' "$@"; };;
esac

# Remove heading link references from the Markdown file
sed_i -E 's/\[.\]\(#[-a-z0-9]+ "Link to this heading"\)//g' _build/singlehtml/LogtalkAPIs-$version_base.md
# Remove other links leaving only the text
sed_i -E 's/\[([^]]+)\]\([^)]+\)/\1/g' _build/singlehtml/LogtalkAPIs-$version_base.md

cp -R _build/html/* ../
cp _build/texinfo/LogtalkAPIs-*.info ../
cp _build/latex/LogtalkAPIs-*.pdf ../
cp _build/epub/LogtalkAPIs-*.epub ../
cp _build/singlehtml/LogtalkAPIs-*.md ../

make clean
rm _templates/layout.html
mv conf.py _conf.py
mv browserconfig.xml browserconfig.xml.saved
rm ./*.xml
mv browserconfig.xml.saved browserconfig.xml
rm ./*.rst

exit 0
