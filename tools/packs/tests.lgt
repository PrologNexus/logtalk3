%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <https://logtalk.org/>
%  SPDX-FileCopyrightText: 1998-2025 Paulo Moura <pmoura@logtalk.org>
%  SPDX-License-Identifier: Apache-2.0
%
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%
%      http://www.apache.org/licenses/LICENSE-2.0
%
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 0:35:0,
		author is 'Paulo Moura',
		date is 2025-05-23,
		comment is 'Unit tests for the "packs" tool.'
	]).

	:- uses(list, [
		msort/2
	]).

	:- uses(user, [
		atomic_list_concat/2
	]).

	cover(packs_common).
	cover(registries).
	cover(packs).
	cover(registry_loader_hook).
	cover(packs_specs_hook).

	setup :-
		% the sample packs are defined using relative paths, which require
		% setting the working directory; but this hack to allow testing
		% pack installation may not work with all backend Prolog systems
		object_property(packs, file(_, Directory)),
		os::change_directory(Directory),
		% create a temporary key to test checking of pack signatures
		os::make_directory_path('.ring'),
		(	os::operating_system_type(windows) ->
			atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --quick-gen-key --batch --passphrase "" test_packs@logtalk.org > nul 2>&1'], Command1)
		;	atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --quick-gen-key --batch --passphrase "" test_packs@logtalk.org > /dev/null 2>&1'], Command1)
		),
		os::shell(Command1),
		(	os::operating_system_type(windows) ->
			atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --armor --detach-sign --local-user test_packs@logtalk.org "', Directory, '/test_files/asc/v1.0.0.tar.gz" > nul 2>&1'], Command2),
			atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --detach-sign --local-user test_packs@logtalk.org "', Directory, '/test_files/sig/v1.0.0.tar.gz" > nul 2>&1'], Command3)
		;	atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --armor --detach-sign --local-user test_packs@logtalk.org "', Directory, '/test_files/asc/v1.0.0.tar.gz" > /dev/null 2>&1'], Command2),
			atomic_list_concat(['gpg -q --homedir "', Directory, '.ring" --detach-sign --local-user test_packs@logtalk.org "', Directory, '/test_files/sig/v1.0.0.tar.gz" > /dev/null 2>&1'], Command3)
		),
		os::shell(Command2),
		os::shell(Command3).

	cleanup :-
		packs::reset,
		^^clean_file('.gpg'),
		^^clean_file('test_files/setup.txt'),
		^^clean_file('test_files/asc/v1.0.0.tar.gz.asc'),
		^^clean_file('test_files/sig/v1.0.0.tar.gz.sig'),
		object_property(packs, file(_, Directory)),
		atomic_list_concat([Directory, '.ring'], Ring),
		os::delete_directory_and_contents(Ring),
		atomic_list_concat([Directory, 'test_files/logtalk_packs'], LogtalkPacks),
		os::delete_directory_and_contents(LogtalkPacks).

	% we start with no defined registries or installed packs

	test(packs_registries_logtalk_packs_1_01, true(LogtalkPacks == Storage)) :-
		this(This),
		object_property(This, file(_, Directory)),
		atom_concat(Directory, 'test_files/logtalk_packs/', Storage),
		registries::logtalk_packs(LogtalkPacks).

	test(packs_packs_logtalk_packs_1_01, true(LogtalkPacks == Storage)) :-
		this(This),
		object_property(This, file(_, Directory)),
		atom_concat(Directory, 'test_files/logtalk_packs/', Storage),
		packs::logtalk_packs(LogtalkPacks).

	test(packs_registries_logtalk_packs_0_01, true) :-
		registries::logtalk_packs.

	test(packs_packs_logtalk_packs_0_02, true) :-
		packs::logtalk_packs.

	test(packs_registries_prefix_1_01, true(atom(Directory))) :-
		registries::prefix(Directory).

	test(packs_registries_prefix_0_01, true) :-
		registries::prefix.

	test(packs_packs_prefix_1_01, true(atom(Directory))) :-
		packs::prefix(Directory).

	test(packs_packs_prefix_0_01, true) :-
		packs::prefix.

	test(packs_registries_list_0_01, true) :-
		registries::list.

	test(packs_registries_defined_4_01, false) :-
		registries::defined(_, _, _, _).

	test(packs_packs_available_0_01, true) :-
		packs::available.

	test(packs_packs_installed_0_01, true) :-
		packs::installed.

	test(packs_packs_installed_4_01, false) :-
		packs::installed(_, _, _, _).

	test(packs_packs_installed_3_01, false) :-
		packs::installed(_, _, _).

	test(packs_packs_outdated_0_01, true) :-
		packs::outdated.

	test(packs_packs_outdated_4_01, false) :-
		packs::outdated(_, _, _, _).

	test(packs_packs_orphaned_0_01, true) :-
		packs::orphaned.

	test(packs_packs_orphaned_2_01, false) :-
		packs::orphaned(_, _).

	test(packs_registries_clean_0_01, true) :-
		registries::clean.

	test(packs_packs_clean_0_01, true) :-
		packs::clean.

	test(packs_registries_lint_0_01, true) :-
		registries::lint.

	test(packs_packs_lint_0_01, true) :-
		packs::lint.

	test(packs_registries_update_0_01, true) :-
		registries::update.

	test(packs_packs_update_0_01, true) :-
		packs::update.

	test(packs_registries_help_0_01, true) :-
		registries::help.

	test(packs_packs_help_0_01, true) :-
		packs::help.

	test(packs_packs_verify_commands_availability_0_01, true) :-
		packs::verify_commands_availability.

	% now we add a local registry

	test(packs_registries_add_1_01, true) :-
		this(This),
		object_property(This, file(_, Directory)),
		file_to_url(Directory, 'test_files/local_1_d', URL),
		registries::add(URL).

	test(packs_registries_add_3_01, true) :-
		this(This),
		object_property(This, file(_, Directory)),
		file_to_url(Directory, 'test_files/local_1_d', URL),
		registries::add(local_1_d, URL, [update(true)]).

	test(packs_registries_defined_4_02, true(Registries == [local_1_d])) :-
		findall(Registry, registries::defined(Registry, _, _, _), Registries).

	test(packs_registries_lint_1_01, true) :-
		registries::lint(local_1_d).

	% registry describe predicate

	test(packs_registries_describe_1_01, true) :-
		registries::describe(local_1_d).

	% registry directory

	test(packs_registries_directory_2_01, true(atom(Directory))) :-
		registries::directory(local_1_d, Directory).

	test(packs_registries_directory_1_01, true) :-
		registries::directory(local_1_d).

	% registry readme

	test(packs_registries_readme_2_01, true((Readme == FileUpperCase; Readme == FileLowerCase))) :-
		this(This),
		object_property(This, file(_, Directory)),
		atom_concat(Directory, 'test_files/logtalk_packs/registries/local_1_d/README.md', FileUpperCase),
		% some backends convert paths to lower case on Windows
		atom_concat(Directory, 'test_files/logtalk_packs/registries/local_1_d/readme.md', FileLowerCase),
		registries::readme(local_1_d, Readme).

	test(packs_registries_readme_1_01, true) :-
		registries::readme(local_1_d).

	test(packs_registries_provides_2_01, true(Pairs == [local_1_d-alt, local_1_d-asc, local_1_d-badcheck, local_1_d-badsig, local_1_d-bar, local_1_d-deprecated, local_1_d-foo, local_1_d-gpg, local_1_d-sig])) :-
		setof(Registry-Pack, registries::provides(Registry, Pack), Pairs).

	test(packs_registries_update_1_01, true) :-
		registries::update(local_1_d).

	test(packs_registries_clean_1_01, true) :-
		registries::clean(local_1_d).

	test(packs_registries_pin_1_01, true) :-
		registries::pin(local_1_d).

	test(packs_registries_pin_1_02, true) :-
		registries::pin(local_1_d),
		registries::pin(local_1_d).

	test(packs_registries_unpin_1_01, true) :-
		registries::unpin(local_1_d).

	test(packs_registries_unpin_1_02, true) :-
		registries::unpin(local_1_d),
		registries::unpin(local_1_d).

	test(packs_registries_pinned_1_01, true) :-
		registries::pin(local_1_d),
		registries::pinned(local_1_d).

	test(packs_registries_pinned_1_02, false) :-
		registries::unpin(local_1_d),
		registries::pinned(local_1_d).

	test(packs_packs_lint_2_01, true) :-
		packs::lint(local_1_d, foo).

	test(packs_packs_lint_1_01, true) :-
		packs::lint(foo).

	test(packs_packs_versions_3_01, true(Versions == [3:0:0,2:0:0,1:0:0])) :-
		packs::versions(local_1_d, foo, Versions).

	test(packs_packs_available_2_01, true(Packs == [local_1_d-alt, local_1_d-asc, local_1_d-badcheck, local_1_d-badsig, local_1_d-bar, local_1_d-deprecated, local_1_d-foo, local_1_d-gpg, local_1_d-sig])) :-
		findall(Registry-Pack, packs::available(Registry, Pack), Packs0),
		msort(Packs0, Packs).

	test(packs_packs_available_1_01, true) :-
		packs::available(local_1_d).

	test(packs_packs_dependents_3_01, true(Dependents == [])) :-
		packs::dependents(local_1_d, foo, Dependents).

	test(packs_packs_dependents_2_01, true) :-
		packs::dependents(local_1_d, foo).

	test(packs_packs_dependents_1_01, true) :-
		packs::dependents(foo).

	test(packs_packs_install_1_01, true) :-
		packs::install(bar).

	test(packs_packs_install_1_02, true(Version-Pinned == (1:0:0)-false)) :-
		packs::installed(local_1_d, bar, Version, Pinned).

	test(packs_packs_uninstall_1_01, true) :-
		packs::uninstall(bar).

	test(packs_packs_uninstall_1_02, false) :-
		packs::installed(local_1_d, bar, _, _).

	test(packs_packs_outdated_1_01, true) :-
		packs::outdated(local_1_d).

	% add a second local registry

	test(packs_registries_add_2_01, true) :-
		this(This),
		object_property(This, file(_, Directory)),
		file_to_url(Directory, 'test_files/local_2_d.zip', URL),
		registries::add(local_2_d, URL).

	test(packs_registries_defined_4_03, true(Registries == [local_1_d, local_2_d])) :-
		findall(Registry, registries::defined(Registry, _, _, _), Registries0),
		list::msort(Registries0, Registries).

	test(packs_registries_unpin_0_01, true) :-
		registries::unpin.

	test(packs_registries_unpin_0_02, false) :-
		registries::defined(_, _, _, true).

	test(packs_registries_pin_0_01, true) :-
		registries::pin.

	test(packs_registries_pin_0_02, true(Registries == [local_1_d, local_2_d])) :-
		findall(Registry, registries::defined(Registry, _, _, true), Registries0),
		list::msort(Registries0, Registries).

	test(packs_registries_provides_2_02, true(Pairs == [local_1_d-alt, local_1_d-asc, local_1_d-badcheck, local_1_d-badsig, local_1_d-bar, local_1_d-deprecated, local_1_d-foo, local_1_d-gpg, local_1_d-sig, local_2_d-baz])) :-
		setof(Registry-Pack, registries::provides(Registry, Pack), Pairs).

	test(packs_packs_available_2_02, true(Packs == [local_1_d-alt, local_1_d-asc, local_1_d-badcheck, local_1_d-badsig, local_1_d-bar,local_1_d-deprecated, local_1_d-foo, local_1_d-gpg, local_1_d-sig, local_2_d-baz])) :-
		findall(Registry-Pack, packs::available(Registry, Pack), Packs0),
		msort(Packs0, Packs).

	% install packs with dependencies

	test(packs_packs_install_4_01, true) :-
		packs::install(local_1_d, foo, 1:0:0, [compatible(false)]).

	test(packs_packs_install_4_02, true(Version-Pinned == (1:0:0)-false)) :-
		packs::installed(local_1_d, foo, Version, Pinned).

	test(packs_packs_install_4_03, true(Version-Pinned == (1:0:0)-false)) :-
		packs::installed(local_2_d, baz, Version, Pinned).

	test(packs_packs_install_4_04, true(Version-Pinned == (2:0:0)-false)) :-
		packs::install(local_1_d, foo, 2:0:0, [update(true), compatible(false)]),
		packs::installed(local_1_d, foo, Version, Pinned).

	test(packs_packs_install_4_05, true) :-
		packs::install(local_1_d, alt, 1:0:0, [compatible(false)]).

	test(packs_packs_install_4_06, true(Version-Pinned == (1:0:0)-false)) :-
		packs::installed(local_1_d, alt, Version, Pinned).

	test(packs_packs_install_4_07, false) :-
		packs::install(local_1_d, gpg, 1:0:0, [gpg('--no-sig-cache --batch --passphrase wrong456')]).

	test(packs_packs_install_4_08, true) :-
		packs::install(local_1_d, gpg, 1:0:0, [gpg('--no-sig-cache --batch --passphrase test123')]).

	test(packs_packs_install_4_09, false) :-
		object_property(packs, file(_, Directory)),
		atomic_list_concat(['--homedir "', Directory, '.ring"'], Homedir),
		packs::install(local_1_d, badsig, 1:0:0, [checksig(true), gpg(Homedir)]).

	test(packs_packs_install_4_10, true) :-
		object_property(packs, file(_, Directory)),
		atomic_list_concat(['--homedir "', Directory, '.ring"'], Homedir),
		packs::install(local_1_d, asc, 1:0:0, [checksig(true), gpg(Homedir)]).

	test(packs_packs_install_4_11, true) :-
		object_property(packs, file(_, Directory)),
		atomic_list_concat(['--homedir "', Directory, '.ring"'], Homedir),
		packs::install(local_1_d, sig, 1:0:0, [checksig(true), gpg(Homedir)]).

	test(packs_packs_install_4_12, false) :-
		packs::install(badcheck).

	test(packs_packs_dependents_3_02, true(Dependents == [foo])) :-
		packs::dependents(local_2_d, baz, Dependents).

	test(packs_packs_install_2_01, false) :-
		packs::install(local_1_d, deprecated).

	test(packs_packs_install_3_01, true) :-
		packs::install(local_1_d, deprecated, 1:0:0).

	% print installed packs

	test(packs_packs_installed_1_01, true) :-
		packs::installed(local_1_d).

	% update all installed packs

	test(packs_packs_update_2_01, true(OldVersion == NewVersion)) :-
		packs::installed(local_1_d, deprecated, OldVersion, _),
		packs::update(deprecated, []),
		packs::installed(local_1_d, deprecated, NewVersion, _).

	test(packs_packs_update_2_02, true(OldVersion \== NewVersion)) :-
		packs::installed(local_1_d, deprecated, OldVersion, _),
		packs::update(deprecated, [status(all)]),
		packs::installed(local_1_d, deprecated, NewVersion, _).

	test(packs_packs_update_2_03, true(Version-Pinned == (3:0:0)-false)) :-
		packs::uninstall(foo),
		packs::install(local_1_d, foo, 1:0:0, [compatible(false)]),
		packs::update(foo, [compatible(false)]),
		packs::installed(local_1_d, foo, Version, Pinned).

	% update packs

	test(packs_packs_update_1_01, true) :-
		packs::update(baz).

	test(packs_packs_update_2_04, true) :-
		packs::update(baz, [force(true)]).

	test(packs_packs_update_3_01, true) :-
		packs::uninstall(foo),
		packs::install(local_1_d, foo, 1:0:0, [compatible(false)]),
		packs::update(foo, 2:0:0, [clean(true), compatible(false)]).

	test(packs_packs_update_2_05, true(OldVersion == NewVersion)) :-
		packs::installed(local_1_d, foo, OldVersion, _),
		packs::update(foo, [status(stable)]),
		packs::installed(local_1_d, foo, NewVersion, _).

	% clean pack archives

	test(packs_packs_clean_2_01, true) :-
		packs::clean(local_2_d, baz).

	test(packs_packs_clean_1_01, true) :-
		packs::clean(foo).

	% pack directory

	test(packs_packs_directory_2_01, true(atom(Directory))) :-
		packs::directory(foo, Directory).

	test(packs_packs_directory_1_01, true) :-
		packs::directory(foo).

	% pack readme file

	test(packs_packs_readme_1_01, true) :-
		packs::readme(foo).

	test(packs_packs_readme_2_01, true(os::file_exists(ReadMeFile))) :-
		packs::readme(foo, ReadMeFile).

	% pack describe predicates

	test(packs_packs_describe_2_01, true) :-
		packs::describe(local_1_d, foo).

	test(packs_packs_describe_1_01, true) :-
		packs::describe(baz).

	% pin and unpin packs

	test(packs_packs_pin_1_01, true) :-
		packs::pin(foo).

	test(packs_packs_pinned_1_01, true) :-
		packs::pinned(foo).

	test(packs_packs_unpin_1_01, true) :-
		packs::unpin(foo).

	test(packs_packs_pinned_1_02, false) :-
		packs::pinned(foo).

	test(packs_packs_pin_0_01, true) :-
		packs::pin.

	test(packs_packs_pin_0_02, all(Pinned == true)) :-
		packs::installed(_, _, _, Pinned).

	test(packs_packs_unpin_0_01, true) :-
		packs::unpin.

	test(packs_packs_unpin_0_02, all(Pinned == false)) :-
		packs::installed(_, _, _, Pinned).

	% pack search predicates

	test(packs_packs_search_1_01, true) :-
		packs::search(local).

	% save and restore setups

	test(packs_packs_save_2_01, true(os::file_exists(Setup))) :-
		% avoid asking for passphrase when restoring due to the gpg encrypted pack
		packs::uninstall(gpg),
		this(This),
		object_property(This, file(_, Directory)),
		atom_concat(Directory, 'test_files/setup.txt', Setup),
		packs::save(Setup).

	test(packs_packs_restore_2_01, true) :-
		packs::uninstall,
		packs::clean,
		registries::delete,
		registries::clean.

	test(packs_packs_restore_2_02, false) :-
		packs::installed(_, _, _, _).

	test(packs_packs_restore_2_03, false) :-
		registries::defined(_, _, _, _).

	test(packs_packs_restore_2_04, true) :-
		this(This),
		object_property(This, file(_, Directory)),
		atom_concat(Directory, 'test_files/setup.txt', Setup),
		packs::restore(Setup, [compatible(false)]).

	test(packs_packs_restore_2_05, true(HowDefined-Pinned == directory-true)) :-
		registries::defined(local_1_d, _, HowDefined, Pinned).

	test(packs_packs_restore_2_06, true(HowDefined-Pinned == archive-true)) :-
		registries::defined(local_2_d, _, HowDefined, Pinned).

	test(packs_packs_restore_2_07, true(Version-Pinned == (2:0:0)-false)) :-
		packs::installed(local_1_d, foo, Version, Pinned).

	test(packs_packs_restore_2_08, true(Version-Pinned == (1:0:0)-false)) :-
		packs::installed(local_2_d, baz, Version, Pinned).

	% broken registry and pack specs

	test(packs_registries_add_1_02, true) :-
		this(This),
		object_property(This, file(_, Directory)),
		file_to_url(Directory, 'test_files/broken_d', URL),
		registries::add(URL).

	test(packs_registries_lint_1_02, false) :-
		registries::lint(broken_d).

	test(packs_packs_lint_1_02, false) :-
		packs::lint(broken).

	% uninstall packs

	test(packs_packs_uninstall_0_01, true) :-
		packs::uninstall.

	test(packs_packs_uninstall_0_02, false) :-
		packs::installed(_, _, _, _).

	% delete registries

	test(packs_registries_unpin_0_03, true) :-
		registries::unpin.

	test(packs_registries_delete_1_01, true) :-
		registries::delete(local_1_d).

	% suppress all packs tool messages to not pollute the unit tests output

	:- multifile(logtalk::message_hook/4).
	:- dynamic(logtalk::message_hook/4).

	logtalk::message_hook(_Message, _Kind, packs, _Tokens).

	% auxiliary predicates

	encode_spaces(URL0, URL) :-
		atom_chars(URL0, Chars0),
		encode_spaces_in_list(Chars0, Chars),
		atom_chars(URL, Chars).

	encode_spaces_in_list([], []).
	encode_spaces_in_list([' '| Chars0], ['%','2','0'| Chars]) :-
		!,
		encode_spaces_in_list(Chars0, Chars).
	encode_spaces_in_list([Char| Chars0], [Char| Chars]) :-
		encode_spaces_in_list(Chars0, Chars).

	file_to_url(Directory, File, URL) :-
		(	sub_atom(Directory, 0, _, _, '//C/') ->
			% assume ECLiPSe running on Windows
			atom_concat('//C/', Directory1, Directory),
			atomic_list_concat(['file://C:/', Directory1, File], URL0)
		;	% most common case
			atomic_list_concat(['file://', Directory, File], URL0)
		),
		encode_spaces(URL0, URL).

:- end_object.
