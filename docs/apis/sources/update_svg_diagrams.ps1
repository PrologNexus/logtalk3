#############################################################################
##
##   Logtalk script for updating the HTML library and tools SVG diagrams
##
##   Last updated on May 28, 2025
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


#Requires -Version 7.3

[CmdletBinding()]
param(
	[Parameter()]
	# default to SWI-Prolog as the backend compiler
	[String]$p = "swi",
	[Switch]$i,
	[Switch]$v,
	[Switch]$h
)

function Write-Script-Version {
	$myFullName = $MyInvocation.ScriptName
	$myName = Split-Path -Path $myFullName -leaf -Resolve
	Write-Output "$myName 0.30"
}

function Write-Usage-Help() {
	$myFullName = $MyInvocation.ScriptName
	$myName = Split-Path -Path $myFullName -leaf -Resolve

	Write-Output ""
	Write-Output "This script updates the SVG diagrams of the core entities, library,"
	Write-Output "developer tools, ports, contributions, and optionally installed packs."
	Write-Output ""
	Write-Output "Usage:"
	Write-Output "  $myName [-p prolog] [-i]"
	Write-Output "  $myName -v"
	Write-Output "  $myName -h"
	Write-Output ""
	Write-Output "Optional arguments:"
	Write-Output "  -p backend Prolog compiler (default is $p)"
	Write-Output "     (valid values are b, ciao, cx, eclipse, gnu, ji, xvm, sicstus, swi, swipack, tau, trealla, xsb, and yap)"
	Write-Output "  -i include all installed packs"
	Write-Output "  -v print version"
	Write-Output "  -h help"
	Write-Output ""
}


$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Push-Location $dir

$logtalk="swilgt$extension -g"

if ($v -eq $true) {
	Write-Script-Version
	Exit 0
}

if ($h -eq $true) {
	Write-Usage-Help
	Exit 0
}

if ("$p" -eq "b") {
	$logtalk="bplgt -g"
} elseif ("$p" -eq "ciao") {
	$logtalk="ciaolgt -e"
} elseif ("$p" -eq "cx") {
	$logtalk="cxlgt --goal"
} elseif ("$p" -eq "eclipse") {
	$logtalk="eclipselgt -e"
} elseif ("$p" -eq "gnu") {
	$logtalk="gplgt --query-goal"
} elseif ("$p" -eq "ji") {
	$logtalk="jiplgt -n -g"
} elseif ("$p" -eq "sicstus") {
	$logtalk="sicstuslgt --goal"
} elseif ("$p" -eq "swi") {
	$logtalk="swilgt -g"
} elseif ("$p" -eq "swipack") {
	$logtalk="swipl -g"
} elseif ("$p" -eq "tau") {
	$logtalk="taulgt -g"
} elseif ("$p" -eq "trealla") {
	$logtalk="tplgt -g"
} elseif ("$p" -eq "xsb") {
	$logtalk="xsblgt -e"
} elseif ("$p" -eq "xvm") {
	$logtalk="xvmlgt -g"
} elseif ("$p" -eq "yap") {
	$logtalk="yaplgt -g"
} else {
	Write-Error "Error! Unsupported backend Prolog compiler: $p"
	Write-Usage-Help
	Exit 1
}

if ($env:LOGTALKPACKS -ne "") {
	$logtalk_packs = '$env:LOGTALKPACKS/'
} else {
	$logtalk_packs = '$env:USERPROFILE/logtalk_packs/'
}

# documentation goals

$core_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on), inheritance_diagram::library(core,[title('Logtalk core entities'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/'])]), halt."

$library_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on), logtalk_load(library(all_loader)), inheritance_diagram::rlibrary(library, [title('Logtalk library'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/'])]), halt."

if ($i -eq $true) {
	$packs_goal="git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on), logtalk_load(library(all_loader)), logtalk_load(library(packs_loader)), inheritance_diagram::rdirectory(packs, '$logtalk_packs', [title('Logtalk packs'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/', '$logtalk_packs','$env:USERPROFILE/'])]), halt."
}

if ($env:LOGTALKPACKS -ne "") {
	$tools_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on),logtalk_load([library(all_loader),tools(loader),issue_creator(loader),ports_profiler(loader),tutor(loader),wrapper(loader),lgtunit(coverage_report),lgtunit(automation_report),lgtunit(minimal_output),lgtunit(tap_output),lgtunit(tap_report),lgtunit(xunit_output),lgtunit(xunit_report),lgtunit(xunit_net_v2_output),lgtunit(xunit_net_v2_report)]), inheritance_diagram::rlibrary(tools, [title('Logtalk development tools'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/']),exclude_directories(['$env:USERPROFILE/logtalk_packs/','$env:LOGTALKPACKS/'])]), halt."
} else {
	$tools_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on),logtalk_load([library(all_loader),tools(loader),issue_creator(loader),ports_profiler(loader),tutor(loader),wrapper(loader),lgtunit(coverage_report),lgtunit(automation_report),lgtunit(minimal_output),lgtunit(tap_output),lgtunit(tap_report),lgtunit(xunit_output),lgtunit(xunit_report),lgtunit(xunit_net_v2_output),lgtunit(xunit_net_v2_report)]), inheritance_diagram::rlibrary(tools, [title('Logtalk development tools'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/']),exclude_directories(['$env:USERPROFILE/logtalk_packs/'])]), halt."
}

$ports_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on), logtalk_load(ports(loader)), inheritance_diagram::rlibrary(ports, [title('Logtalk ports of third-party software'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/'])]), halt."

$contributions_goal = "git_hash(Hash,[]), atomic_list_concat(['https://github.com/LogtalkDotOrg/logtalk3/tree/',Hash,'/'],GitHub), logtalk_load(diagrams(loader)), set_logtalk_flag(source_data,on), logtalk_load(contributions(loader)), inheritance_diagram::rlibrary(contributions, [title('Logtalk third-party contributions'),node_type_captions(true),zoom(true),output_directory('./'),path_url_prefixes('$env:LOGTALKUSER/',GitHub,'https://logtalk.org/library/'),output_directory('./'),path_url_prefixes('$env:LOGTALKHOME/',GitHub,'https://logtalk.org/library/'),omit_path_prefixes(['$env:LOGTALKUSER/','$env:LOGTALKHOME/','$env:USERPROFILE/'])]), halt."

Push-Location ..

& $logtalk ($core_goal -replace '\\', '/')
& $logtalk ($library_goal -replace '\\', '/')
if ($i -eq $true) {
    & $logtalk ($packs_goal -replace '\\', '/')
}
& $logtalk ($tools_goal -replace '\\', '/')
& $logtalk ($contributions_goal -replace '\\', '/')
& $logtalk ($ports_goal -replace '\\', '/')

lgt2svg

try {
	Remove-Item ./*.dot
} catch {
	Write-Error "Error occurred at cleanup"
}

Pop-Location
Pop-Location
