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


:- object(registries,
	imports((packs_common, options))).

	:- info([
		version is 0:61:0,
		author is 'Paulo Moura',
		date is 2025-05-27,
		comment is 'Registry handling predicates.'
	]).

	:- public(list/0).
	:- mode(list, one).
	:- info(list/0, [
		comment is 'Prints a list of all defined registries, including how defined (``git``, ``archive``, or ``directory``) and  if they are pinned.'
	]).

	:- public(describe/1).
	:- mode(describe(+atom), one).
	:- info(describe/1, [
		comment is 'Prints all registry entries.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(defined/4).
	:- mode(defined(?atom, ?atom, ?atom, ?boolean), zero_or_more).
	:- info(defined/4, [
		comment is 'Enumerates by backtracking all defined registries, their definition URL, how they are defined (``git``, ``archive``, or ``directory``), and if they are pinned.',
		argnames is ['Registry', 'URL', 'HowDefined', 'Pinned'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``URL`` is neither a variable nor an atom' - type_error(atom, 'URL'),
			'``HowDefined`` is neither a variable nor an atom' - type_error(atom, 'HowDefined'),
			'``Pinned`` is neither a variable nor a boolean' - type_error(boolean, 'Pinned')
		]
	]).

	:- public(add/3).
	:- mode(add(+atom, +atom, ++list(compound)), zero_or_one).
	:- info(add/3, [
		comment is 'Adds a new registry using the given options. Fails if the registry cannot be added or if it is already defined but not using ``update(true)`` or ``force(true)`` options. A ``file://`` URL can be used for a local directory or archive.',
		argnames is ['Registry', 'URL', 'Options'],
		remarks is [
			'Registry name' - 'Must be the URL basename when using a git URL or a local directory URL. Must also be the declared registry name in the registry specification object.',
			'HTTPS URLs' - 'Must end with either a ``.git`` extension or an archive extension.',
			'``update(Boolean)`` option' - 'Update registry if already defined. Default is ``false``. Overrides the ``force/1`` option.',
			'``force(Boolean)`` option' - 'Force registry re-installation if already defined by first deleting the previous installation. Default is ``false``.',
			'``clean(Boolean)`` option' - 'Clean registry archive after updating. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose adding steps. Default is ``false``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``URL`` is a variable' - instantiation_error,
			'``URL`` is neither a variable nor an atom' - type_error(atom, 'URL'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(add/2).
	:- mode(add(+atom, +atom), zero_or_one).
	:- info(add/2, [
		comment is 'Adds a new registry using default options. Fails if the registry cannot be added or if it is already defined. HTTPS URLs must end with either a ``.git`` extension or an archive extension. A ``file://`` URL can be used for a local directory or archive.',
		argnames is ['Registry', 'URL'],
		remarks is [
			'Registry name' - 'Must be the URL basename when using a git URL or a local directory URL. Must also be the declared registry name in the registry specification object.'
		],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``URL`` is a variable' - instantiation_error,
			'``URL`` is neither a variable nor an atom' - type_error(atom, 'URL')
		]
	]).

	:- public(add/1).
	:- mode(add(+atom), zero_or_one).
	:- info(add/1, [
		comment is 'Adds a new registry using default options. Fails if the registry cannot be added or if it is already defined. HTTPS URLs must end with a ``.git`` extension or an archive extension. A ``file://`` URL can be used for a local directory or archive.',
		argnames is ['URL'],
		remarks is [
			'Registry name' - 'Taken from the URL basename.'
		],
		exceptions is [
			'``URL`` is a variable' - instantiation_error,
			'``URL`` is neither a variable nor an atom' - type_error(atom, 'URL')
		]
	]).

	:- public(update/2).
	:- mode(update(+atom, ++list(compound)), zero_or_one).
	:- info(update/2, [
		comment is 'Updates a defined registry using the specified options. Fails if the registry is not defined.',
		argnames is ['Registry', 'Options'],
		remarks is [
			'``force(Boolean)`` option' - 'Force update if the registry is pinned. Default is ``false``.',
			'``clean(Boolean)`` option' - 'Clean registry archive after updating. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose updating steps. Default is ``false``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(update/1).
	:- mode(update(+atom), zero_or_one).
	:- info(update/1, [
		comment is 'Updates a defined registry using default options. Fails if the registry is not defined.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(update/0).
	:- mode(update, zero_or_one).
	:- info(update/0, [
		comment is 'Updates all defined registries using default options.'
	]).

	:- public(delete/2).
	:- mode(delete(+atom, ++list(compound)), zero_or_one).
	:- info(delete/2, [
		comment is 'Deletes a registry using the specified options (if not pinned).',
		argnames is ['Registry', 'Options'],
		remarks is [
			'``force(Boolean)`` option' - 'Force deletion if the registry is pinned or there are installed registry packs. Default is ``false``.',
			'``clean(Boolean)`` option' - 'Clean registry archive after deleting. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose deleting steps. Default is ``false``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(delete/1).
	:- mode(delete(+atom), zero_or_one).
	:- info(delete/1, [
		comment is 'Deletes a registry using default options.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(delete/0).
	:- mode(delete, zero_or_one).
	:- info(delete/0, [
		comment is 'Deletes all registries using the ``force(true)`` option.'
	]).

	:- public(clean/1).
	:- mode(clean(+atom), zero_or_one).
	:- info(clean/1, [
		comment is 'Cleans all registry archives. Fails if the registry is not defined.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(clean/0).
	:- mode(clean, one).
	:- info(clean/0, [
		comment is 'Cleans all archives for all registries.'
	]).

	:- public(provides/2).
	:- mode(provides(?atom, ?atom), zero_or_more).
	:- info(provides/2, [
		comment is 'Enumerates by backtracking all packs provided by a registry.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(lint/1).
	:- mode(lint(+atom), zero_or_one).
	:- info(lint/1, [
		comment is 'Checks the registry specification. Fails if the registry is not defined or if linting detects errors.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(lint/0).
	:- mode(lint, one).
	:- info(lint/0, [
		comment is 'Checks all registry specifications.'
	]).

	:- uses(list, [
		member/2, memberchk/2
	]).

	:- uses(logtalk, [
		loaded_file_property/2, print_message/3
	]).

	:- uses(os, [
		decompose_file_name/3, decompose_file_name/4, delete_directory/1,
		delete_file/1, directory_exists/1, directory_files/3, ensure_file/1,
		file_exists/1, internal_os_path/2, make_directory_path/1,
		operating_system_type/1, path_concat/3, shell/1
	]).

	:- if(current_logtalk_flag(prolog_dialect, ciao)).
		:- multifile(type::check/2).
	:- endif.

	:- uses(type, [
		check/2, valid/2
	]).

	:- uses(user, [
		atomic_list_concat/2
	]).

	% registry info predicates

	list :-
		print_message(information, packs, @'Defined registries:'),
		findall(
			defined(Registry, URL, HowDefined, Pinned),
			defined(Registry, URL, HowDefined, Pinned),
			DefinedRegistries
		),
		(	DefinedRegistries == [] ->
			print_message(information, packs, @'  (none)')
		;	print_message(information, packs, defined_registries(DefinedRegistries))
		).

	describe(Registry) :-
		check(atom, Registry),
		(	registry_object(Registry, RegistryObject) ->
			RegistryObject::description(Description),
			RegistryObject::home(Home),
			RegistryObject::clone(Clone),
			RegistryObject::archive(Archive),
			(	pinned(Registry) ->
				Pinned = true
			;	Pinned = false
			),
			findall(note(Action,Note), RegistryObject::note(Action,Note), Notes),
			print_message(information, packs, registry_info(Registry,Description,Home,Clone,Archive,Notes,Pinned))
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	defined(Registry, URL, HowDefined, Pinned) :-
		check(var_or(atom), Registry),
		check(var_or(atom), URL),
		check(var_or(atom), HowDefined),
		check(var_or(boolean), Pinned),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Directory),
		directory_files(Directory, Registries, [type(directory), dot_files(false), paths(relative)]),
		member(Registry, Registries),
		path_concat(Directory, Registry, Path),
		read_url(Path, URL),
		decompose_file_name(URL, _, _, Extension),
		(	Extension == '.git' ->
			HowDefined = git
		;	^^supported_url_archive(URL) ->
			HowDefined = archive
		;	HowDefined = directory
		),
		(	pinned(Registry) ->
			Pinned = true
		;	Pinned = false
		).

	% registry directory predicates

	directory(Registry, Directory) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Directory),
		(	var(Registry) ->
			implements_protocol(RegistryObject, registry_protocol),
			RegistryObject::name(Registry)
		;	check(atom, Registry),
			implements_protocol(RegistryObject, registry_protocol),
			RegistryObject::name(Registry),
			!
		),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Registries),
		path_concat(Registries, Registry, Directory),
		directory_exists(Directory),
		read_url(Directory, _).

	directory(Registry) :-
		check(atom, Registry),
		directory(Registry, Directory),
		internal_os_path(Directory, OSDirectory),
		print_message(information, packs, installation_directory(OSDirectory)).

	prefix(Directory) :-
		check(var_or(atom), Directory),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Directory).

	prefix :-
		prefix(Directory),
		internal_os_path(Directory, OSDirectory),
		print_message(information, packs, installation_directory(OSDirectory)).

	% add registry predicates

	add(Registry, URL, UserOptions) :-
		check(atom, Registry),
		check(atom, URL),
		fix_url(URL, URLFixed),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		add_registry(Registry, URLFixed, Options),
		print_note(add, Registry).

	add(Registry, URL) :-
		check(atom, Registry),
		check(atom, URL),
		fix_url(URL, URLFixed),
		^^default_options(Options),
		add_registry(Registry, URLFixed, Options).

	add(URL) :-
		check(atom, URL),
		fix_url(URL, URLFixed),
		decompose_file_name(URLFixed, _, Registry, _),
		^^default_options(Options),
		add_registry(Registry, URLFixed, Options).

	fix_url(URL, URLFixed) :-
		(	sub_atom(URL, _, _, 0, '/') ->
			sub_atom(URL, 0, _, 1, URLFixed)
		;	URLFixed = URL
		).

	add_registry(Registry, _, Options) :-
		registry_object(Registry, _),
		^^option(update(true), Options),
		!,
		update_registry(Registry, Options).
	add_registry(Registry, URL, Options) :-
		print_message(comment, packs, adding_registry(Registry)),
		(	registry_object(Registry, _) ->
			(	^^option(force(false), Options) ->
				print_message(error, packs, registry_already_defined(Registry)),
				fail
			;	delete(Registry, Options)
			)
		;	true
		),
		decompose_file_name(URL, _, Name, Extension),
		(	Extension = '',
			sub_atom(URL, 0, _, _, 'file://') ->
			(	Name \== Registry ->
				print_message(error, packs, registry_name_must_be(Name)),
				fail
			;	add_directory(Registry, URL, Path, Options)
			)
		;	Extension == '.git' ->
			(	Name \== Registry ->
				print_message(error, packs, registry_name_must_be(Name)),
				fail
			;	clone(Registry, URL, Path, Options)
			)
		;	^^supported_url_archive(URL) ->
			download(Registry, URL, Archive, Options),
			uncompress(Registry, Archive, Path, Options)
		;	atom_concat(Name, Extension, Archive),
			print_message(error, packs, unsupported_archive_format(Archive)),
			fail
		),
		save_url(Path, URL),
		^^load_registry(Path),
		(	^^option(clean(true), Options) ->
			delete_archives(Registry)
		;	true
		),
		^^print_readme_file_path(Path),
		print_message(comment, packs, registry_added(Registry)).

	add_directory(Registry, URL, Path, Options) :-
		^^decode_url_spaces(URL, Decoded),
		atom_concat('file://', Directory0, Decoded),
		(	sub_atom(Directory0, _, _, 0, '/') ->
			sub_atom(Directory0, _, _, 1, Directory)
		;	Directory = Directory0
		),
		make_registry_installation_directory(Registry, Path, OSPath),
		path_concat(Directory, '.git', Git),
		(	directory_exists(Git) ->
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['git clone -v ', URL, ' "', OSPath, '"'], Command)
			;	atomic_list_concat(['git clone -q ', URL, ' "', OSPath, '"'], Command)
			),
			^^command(Command, registry_cloning_failed(Registry, URL))
		;	operating_system_type(windows) ->
			internal_os_path(Directory, OSDirectory),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['xcopy /E /I /Y "', OSDirectory, '" "', OSPath, '"'], Command)
			;	atomic_list_concat(['xcopy /E /I /Y /Q "', OSDirectory, '" "', OSPath, '"'], Command)
			),
			^^command(Command, registry_directory_copy_failed(Registry, URL))
		;	internal_os_path(Directory, OSDirectory),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['cp -R -v "', OSDirectory, '/." "', OSPath, '"'], Command)
			;	atomic_list_concat(['cp -R "', OSDirectory, '/." "', OSPath, '"'], Command)
			),
			^^command(Command, registry_directory_copy_failed(Registry, URL))
		).

	% delete registry predicates

	delete(Registry, UserOptions) :-
		check(atom, Registry),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		print_message(comment, packs, deleting_registry(Registry)),
		(	directory(Registry, Directory0) ->
			(	pinned(Registry),
				^^option(force(false), Options) ->
				print_message(error, packs, cannot_delete_pinned_registry(Registry)),
				fail
			;	true
			),
			(	installed_registry_packs(Registry),
				^^option(force(false), Options) ->
				print_message(error, packs, cannot_delete_registry_with_installed_packs(Registry)),
				fail
			;	true
			),
			internal_os_path(Directory0, Directory),
			(	operating_system_type(windows) ->
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['del /f /s /q "', Directory, '" && rmdir /s /q "',            Directory, '"'],            Command)
				;	atomic_list_concat(['del /f /s /q "', Directory, '" > nul 2>&1 && rmdir /s /q "', Directory, '" > nul 2>&1'], Command)
				)
			;	% assume unix
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['rm -rvf "', Directory, '"'], Command)
				;	atomic_list_concat(['rm -rf "',  Directory, '"'], Command)
				)
			),
			^^command(Command, registry_deletion_failed(Registry, Directory)),
			(	^^option(clean(true), Options) ->
				delete_archives(Registry)
			;	true
			),
			print_message(comment, packs, registry_deleted(Registry)),
			print_note(delete, Registry)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	delete(Registry) :-
		delete(Registry, []).

	delete :-
		print_message(comment, packs, @'Deleting all registries'),
		forall(
			defined(Registry, _, _, _),
			delete(Registry, [force(true)])
		),
		print_message(comment, packs, @'Deleted all registries').

	% update registry predicates

	update(Registry, UserOptions) :-
		check(atom, Registry),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		update_registry(Registry, Options).

	update(Registry) :-
		update(Registry, []).

	% use a failure-driven loop so that we don't stop updating
	% the defined registries if the update for one of them fails
	update :-
		print_message(comment, packs, @'Updating defined registries:'),
		defined(Registry, URL, _, Pinned),
		(	Pinned == true ->
			print_message(comment, packs, pinned_registry(Registry, URL))
		;	^^default_options(Options),
			update_registry(Registry, Options)
		),
		fail.
	update :-
		\+ defined(_, _, _, _),
		print_message(comment, packs, @'  (none)'),
		fail.
	update :-
		print_message(comment, packs, @'Registries updating completed').

	update_registry(Registry, Options) :-
		(	registry_object(Registry, RegistryObject) ->
			(	pinned(Registry),
				^^option(force(false), Options) ->
				print_message(error, packs, cannot_update_pinned_registry(Registry)),
				fail
			;	true
			),
			^^logtalk_packs(LogtalkPacks),
			path_concat(LogtalkPacks, registries, Registries),
			path_concat(Registries, Registry, Path),
			read_url(Path, URL),
			decompose_file_name(URL, _, _, Extension),
			(	Extension = '',
				sub_atom(URL, 0, _, _, 'file://') ->
				update_directory(Registry, URL, Path, Updated, Options)
			;	Extension == '.git' ->
				update_clone(Registry, URL, Path, Updated, Options)
			;	RegistryObject::archive(URL),
				update_archive(Registry, URL, Updated, Options)
			),
			(	Updated == false ->
				print_message(comment, packs, up_to_date_registry(Registry, URL))
			;	object_property(RegistryObject, file(File)),
				loaded_file_property(File, parent(Loader)),
				logtalk_load(Loader, [reload(always), source_data(on), hook(registry_loader_hook)]),
				(	^^option(clean(true), Options) ->
					delete_archives(Registry)
				;	true
				),
				print_message(comment, packs, registry_updated(Registry, URL)),
				print_note(update, Registry)
			)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	update_directory(Registry, URL, Path, Updated, Options) :-
		^^decode_url_spaces(URL, Decoded),
		atom_concat('file://', Directory0, Decoded),
		(	sub_atom(Directory0, _, _, 0, '/') ->
			sub_atom(Directory0, _, _, 1, Directory)
		;	Directory = Directory0
		),
		path_concat(Directory, '.git', Git),
		(	directory_exists(Git) ->
			update_clone(Registry, URL, Path, Updated, Options)
		;	operating_system_type(windows) ->
			internal_os_path(Directory, OSDirectory),
			internal_os_path(Path, OSPath),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['xcopy /e /i /y "', OSDirectory, '" "', OSPath, '"'], Command)
			;	atomic_list_concat(['xcopy /e /i /y /q "', OSDirectory, '" "', OSPath, '"'], Command)
			),
			^^command(Command, registry_directory_copy_failed(Registry, URL)),
			Updated = true
		;	internal_os_path(Directory, OSDirectory),
			internal_os_path(Path, OSPath),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['cp -R -v "', OSDirectory, '/." "', OSPath, '"'], Command)
			;	atomic_list_concat(['cp -R "', OSDirectory, '/." "', OSPath, '"'], Command)
			),
			^^command(Command, registry_directory_copy_failed(Registry, URL)),
			Updated = true
		).

	update_clone(_, _, Path, false, _) :-
		internal_os_path(Path, OSPath),
		(	operating_system_type(windows) ->
			atomic_list_concat(['git -C "', OSPath, '" remote update > nul 2>&1 && git -C "',       OSPath, '" status -uno | find "up to date" > nul'], Command)
		;	atomic_list_concat(['git -C "', OSPath, '" remote update > /dev/null 2>&1 && git -C "', OSPath, '" status -uno | grep -q "up to date"'],    Command)
		),
		shell(Command),
		!.
	update_clone(Registry, URL, Path, true, Options) :-
		print_message(comment, packs, updating_registry(Registry, URL)),
		internal_os_path(Path, OSPath),
		(	^^option(verbose(true), Options) ->
			atomic_list_concat(['git -C "', OSPath, '" pull -v'], Command)
		;	atomic_list_concat(['git -C "', OSPath, '" pull -q'], Command)
		),
		^^command(Command, registry_clone_pull_failed(Registry, OSPath)).

	update_archive(Registry, URL, true, Options) :-
		print_message(comment, packs, updating_registry(Registry, URL)),
		download(Registry, URL, Archive, Options),
		uncompress(Registry, Archive, _, Options).

	% clean predicates

	clean(Registry) :-
		check(atom, Registry),
		(	registry_object(Registry, _) ->
			delete_archives(Registry)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	clean :-
		print_message(comment, packs, @'Cleaning all registry archives'),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, registries, ArchivesRegistries),
		directory_files(ArchivesRegistries, Registries, [type(directory), dot_files(false), paths(absolute)]),
		member(Registry, Registries),
		directory_files(Registry, Files, [type(regular), dot_files(false), paths(absolute)]),
		forall(member(File, Files), delete_file(File)),
		delete_directory(Registry),
		fail.
	clean :-
		print_message(comment, packs, @'Cleaned all registry archives').

	delete_archives(Registry) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, registries, ArchivesRegistries),
		path_concat(ArchivesRegistries, Registry, ArchivesRegistriesRegistry),
		(	directory_exists(ArchivesRegistriesRegistry) ->
			directory_files(ArchivesRegistriesRegistry, Files, [type(regular), dot_files(false), paths(absolute)]),
			forall(member(File, Files), delete_file(File)),
			delete_directory(ArchivesRegistriesRegistry)
		;	true
		).

	% provides predicates

	provides(Registry, Pack) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Pack),
		registry_object(Registry, RegistryObject),
		object_property(RegistryObject, file(RegistryFile)),
		loaded_file_property(RegistryFile, parent(Loader)),
		loaded_file_property(PackFile, parent(Loader)),
		loaded_file_property(PackFile, object(PackObject)),
		implements_protocol(PackObject, pack_protocol),
		PackObject::name(Pack).

	% options handling

	default_option(verbose(false)).
	default_option(clean(false)).
	default_option(install(false)).
	default_option(update(false)).
	default_option(compatible(false)).
	default_option(status([stable, rc, beta, alpha])).
	default_option(force(false)).
	default_option(checksum(true)).
	default_option(checksig(false)).
	default_option(save(installed)).
	default_option(git('')).
	default_option(downloader(curl)).
	default_option(curl('')).
	default_option(wget('')).
	default_option(gpg('')).
	default_option(tar('')).

	valid_option(verbose(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(clean(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(install(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(update(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(compatible(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(status(CompatibleStatus)) :-
		once((CompatibleStatus == all; forall(member(Status, CompatibleStatus), memberchk(Status, [stable, rc, beta, alpha, experimental, deprecated])))).
	valid_option(force(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(checksum(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(checksig(Boolean)) :-
		valid(boolean, Boolean).
	valid_option(save(What)) :-
		once((What == all; What == installed)).
	valid_option(git(Atom)) :-
		atom(Atom).
	valid_option(downloader(Downloader)) :-
		once((Downloader == curl; Downloader == wget)).
	valid_option(curl(Atom)) :-
		atom(Atom).
	valid_option(wget(Atom)) :-
		atom(Atom).
	valid_option(gpg(Atom)) :-
		atom(Atom).
	valid_option(tar(Atom)) :-
		atom(Atom).

	% pinned registry handling

	pin(Registry) :-
		(	pin_file(Registry, File) ->
			ensure_file(File)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	pin :-
		defined(Registry, _, _, false),
			pin_file(Registry, File),
			ensure_file(File),
		fail.
	pin.

	unpin(Registry) :-
		(	pin_file(Registry, File) ->
			(	file_exists(File) ->
				delete_file(File)
			;	true
			)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	unpin :-
		defined(Registry, _, _, true),
			pin_file(Registry, File),
			file_exists(File),
			delete_file(File),
		fail.
	unpin.

	pinned(Registry) :-
		(	pin_file(Registry, File) ->
			file_exists(File)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	pin_file(Registry, File) :-
		check(atom, Registry),
		directory(Registry, Directory),
		path_concat(Directory, 'PINNED.packs', File).

	% registry URL definition predicates

	save_url(Path, URL) :-
		path_concat(Path, 'URL.packs', File),
		open(File, write, Stream),
		writeq(Stream, URL), write(Stream, '.\n'),
		close(Stream).

	read_url(Path, URL) :-
		path_concat(Path, 'URL.packs', File),
		file_exists(File),
		open(File, read, Stream),
		read(Stream, URL),
		close(Stream).

	% registry readme predicates

	readme(Registry, ReadMeFile) :-
		check(var_or(atom), ReadMeFile),
		directory(Registry, Directory),
		^^readme_file_path(Directory, ReadMeFile).

	readme(Registry) :-
		directory(Registry, Directory),
		^^readme_file_path(Directory, ReadMeFile),
		internal_os_path(ReadMeFile, OSReadMeFile),
		print_message(information, packs, readme_file(OSReadMeFile)).

	% lint predicates

	lint(Registry) :-
		check(atom, Registry),
		(	registry_object(Registry, RegistryObject) ->
			lint_registry(Registry, RegistryObject)
		;	print_message(error, packs, unknown_registry(Registry)),
			fail
		).

	lint :-
		print_message(comment, packs, @'Lint checking all registries'),
		registry_object(Registry, RegistryObject),
		lint_registry(Registry, RegistryObject),
		fail.
	lint :-
		print_message(comment, packs, @'Lint checked all registries').

	lint_registry(Registry, RegistryObject) :-
		print_message(comment, packs, linting_registry(Registry)),
		lint_check(name, Registry, RegistryObject),
		lint_check(description, Registry, RegistryObject),
		lint_check(home, Registry, RegistryObject),
		lint_check(clone, Registry, RegistryObject),
		lint_check(archive, Registry, RegistryObject),
		lint_check(notes, Registry, RegistryObject),
		print_message(comment, packs, linted_registry(Registry)).

	lint_check(name, Registry, RegistryObject) :-
		atom_concat(Registry, '_registry', ExpectedRegistryObject),
		(	RegistryObject == ExpectedRegistryObject ->
			true
		;	print_message(warning, packs, 'Registry object expected name is ~q but ~q is used!'+[ExpectedRegistryObject, RegistryObject]),
			fail
		).
	lint_check(description, _Registry, RegistryObject) :-
		(	RegistryObject::description(_) ->
			true
		;	print_message(warning, packs, @'The description/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(home, _Registry, RegistryObject) :-
		(	RegistryObject::home(_) ->
			true
		;	print_message(warning, packs, @'The home/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(clone, Registry, RegistryObject) :-
		(	RegistryObject::clone(URL) ->
			lint_check_clone_url(Registry, URL)
		;	print_message(warning, packs, @'The clone/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(archive, _Registry, RegistryObject) :-
		(	RegistryObject::archive(URL) ->
			lint_check_archive_url(URL)
		;	print_message(warning, packs, @'The archive/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(notes, _Registry, RegistryObject) :-
		forall(
			RegistryObject::note(Action, Note),
			lint_check_note(Action, Note)
		).

	lint_check_clone_url(Registry, URL):-
		decompose_file_name(URL, _, Name, Extension),
		(	Extension \== '.git' ->
			print_message(warning, packs, @'Git cloning URL should end with ".git"!'),
			fail
		;	Name == Registry ->
			true
		;	print_message(warning, packs, @'Git repos should have the same name as the registry!'),
			fail
		).
	lint_check_archive_url(URL) :-
		(	^^supported_url_archive(URL) ->
			true
		;	decompose_file_name(URL, _, _, Extension),
			Extension == '' ->
			print_message(warning, packs, @'Archive extension missing!'),
			fail
		;	print_message(warning, packs, @'Archive extension not supported!'),
			fail
		).

	lint_check_note(Action, Notes) :-
		(	var(Action) ->
			true
		;	member(Action, [add, update, delete]) ->
			true
		;	print_message(warning, packs, @'The notes/2 predicate action argument is neither a variable nor add, update, or delete!'),
			fail
		),
		(	atom(Notes) ->
			true
		;	print_message(warning, packs, @'The notes/2 predicate notes argument is not an atom!'),
			fail
		).

	% auxiliary predicates

	registry_object(Registry, RegistryObject) :-
		(	var(Registry) ->
			implements_protocol(RegistryObject, registry_protocol),
			RegistryObject::name(Registry)
		;	implements_protocol(RegistryObject, registry_protocol),
			RegistryObject::name(Registry),
			!
		),
		directory(Registry, _).

	clone(Registry, URL, Path, Options) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Registries),
		path_concat(Registries, Registry, Path),
		internal_os_path(Path, OSPath),
		(	^^option(verbose(true), Options) ->
			atomic_list_concat(['git clone -v ', URL, ' "', OSPath, '"'], Command)
		;	atomic_list_concat(['git clone -q ', URL, ' "', OSPath, '"'], Command)
		),
		^^command(Command, registry_cloning_failed(Registry, URL)).

	download(Registry, URL, Archive, Options) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, registries, ArchivesRegistries),
		path_concat(ArchivesRegistries, Registry, ArchivesRegistriesRegistry),
		decompose_file_name(URL, _, Basename),
		path_concat(ArchivesRegistriesRegistry, Basename, Archive0),
		internal_os_path(Archive0, Archive),
		make_directory_path(ArchivesRegistriesRegistry),
		^^option(downloader(Downloader), Options),
		(	Downloader == curl ->
			^^option(curl(CurlExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['curl ', CurlExtraOptions, ' -f -v -L -o "',    Archive, '" "', URL, '"'], Command)
			;	atomic_list_concat(['curl ', CurlExtraOptions, ' -f -s -S -L -o "', Archive, '" "', URL, '"'], Command)
			)
		;	% Downloader == wget,
			^^option(wget(WgetExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['wget ', WgetExtraOptions, ' -v -O "', Archive, '" "', URL, '"'], Command)
			;	atomic_list_concat(['wget ', WgetExtraOptions, ' -q -O "', Archive, '" "', URL, '"'], Command)
			)
		),
		^^command(Command, registry_download_failed(Registry, Command)).

	uncompress(Registry, Archive, Path, Options) :-
		make_registry_installation_directory(Registry, Path, OSPath),
		^^tar_command(Tar),
		^^option(tar(TarExtraOptions), Options),
		(	decompose_file_name(Archive, _, _, '.gpg') ->
			^^option(gpg(GpgExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['gpg ', GpgExtraOptions, ' -v -d ', Archive, ' | ', Tar, ' ', TarExtraOptions, ' --strip 1 --directory "', OSPath, '" -xvf -'], Command)
			;	atomic_list_concat(['gpg ', GpgExtraOptions, ' -q -d ', Archive, ' | ', Tar, ' ', TarExtraOptions, ' --strip 1 --directory "', OSPath, '" -xf -'],  Command)
			)
		;	% assume non-encrypted archive
			(	^^option(verbose(true), Options) ->
				atomic_list_concat([Tar, ' ', TarExtraOptions, ' -xvf "', Archive, '" --strip 1 --directory "', OSPath, '"'], Command)
			;	atomic_list_concat([Tar, ' ', TarExtraOptions, ' -xf "',  Archive, '" --strip 1 --directory "', OSPath, '"'], Command)
			)
		),
		^^command(Command, registry_archive_uncompress_failed(Registry, OSPath)).

	installed_registry_packs(Registry) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Directory),
		directory_files(Directory, Packs, [type(directory), dot_files(false), paths(absolute)]),
		member(Pack, Packs),
		path_concat(Pack, 'REGISTRY.packs', File),
		file_exists(File),
		open(File, read, Stream),
		read(Stream, PackRegistry),
		close(Stream),
		PackRegistry == Registry,
		!.

	make_registry_installation_directory(Registry, Path, OSPath) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Registries),
		path_concat(Registries, Registry, Path),
		internal_os_path(Path, OSPath),
		make_directory_path(Path).

	% notes

	print_note(Action, Registry) :-
		implements_protocol(RegistryObject, registry_protocol),
		RegistryObject::name(Registry), !,
		(	RegistryObject::note(Action, Note) ->
			print_message(information, packs, note(Note))
		;	true
		).

:- end_object.
