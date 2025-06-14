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


:- object(packs,
	imports((packs_common, options))).

	:- info([
		version is 0:87:0,
		author is 'Paulo Moura',
		date is 2025-05-23,
		comment is 'Pack handling predicates.'
	]).

	:- public(available/2).
	:- mode(available(?atom, ?atom), zero_or_more).
	:- info(available/2, [
		comment is 'Enumerates, by backtracking, all available packs.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(available/1).
	:- mode(available(+atom), one).
	:- info(available/1, [
		comment is 'Lists all the packs that are available for installation from the given registry.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(available/0).
	:- mode(available, one).
	:- info(available/0, [
		comment is 'Lists all the packs that are available for installation from all defined registries.'
	]).

	:- public(installed/4).
	:- mode(installed(?atom, ?atom, ?compound, ?boolean), zero_or_more).
	:- info(installed/4, [
		comment is 'Enumerates by backtracking all installed packs.',
		argnames is ['Registry', 'Pack', 'Version', 'Pinned'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is neither a variable nor a compound term' - type_error(compound, 'Version'),
			'``Pinned`` is neither a variable nor a boolean' - type_error(boolean, 'Pinned')
		]
	]).

	:- public(installed/3).
	:- mode(installed(?atom, ?atom, ?compound), zero_or_more).
	:- info(installed/3, [
		comment is 'Enumerates by backtracking all installed packs.',
		argnames is ['Registry', 'Pack', 'Version'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is neither a variable nor a compound term' - type_error(compound, 'Version')
		]
	]).

	:- public(installed/1).
	:- mode(installed(+atom), zero_or_one).
	:- info(installed/1, [
		comment is 'Lists all the packs that are installed from the given registry. Fails if the registry is unknown.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		]
	]).

	:- public(installed/0).
	:- mode(installed, one).
	:- info(installed/0, [
		comment is 'Lists all the packs that are installed.'
	]).

	:- public(outdated/5).
	:- mode(outdated(?atom, ?atom, ?compound, ?compound, ++list(compound)), zero_or_more).
	:- info(outdated/5, [
		comment is 'Enumerates by backtracking all installed but outdated packs (together with the current version installed and the latest version available) using the given options.',
		argnames is ['Registry', 'Pack', 'Version', 'LatestVersion', 'Options'],
		remarks is [
			'``compatible(Boolean)`` option' - 'Restrict listing to compatible packs. Default is ``true``.',
			'``status(Status)`` option' - 'Restrict listing to updates with the given status. Default is ``[stable,rc,beta,alpha]``. Set to ``all`` to also list ``experimental`` and ``deprecated`` updates.'
		],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is neither a variable nor a compound term' - type_error(compound, 'Version'),
			'``LatestVersion`` is neither a variable nor a compound term' - type_error(compound, 'LatestVersion'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(outdated/4).
	:- mode(outdated(?atom, ?atom, ?compound, ?compound), zero_or_more).
	:- info(outdated/4, [
		comment is 'Enumerates by backtracking all installed but outdated packs (together with the current version installed and the latest version available) using default options.',
		argnames is ['Registry', 'Pack', 'Version', 'LatestVersion'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is neither a variable nor a compound term' - type_error(compound, 'Version'),
			'``LatestVersion`` is neither a variable nor a compound term' - type_error(compound, 'LatestVersion')
		],
		see_also is [outdated/5]
	]).

	:- public(outdated/2).
	:- mode(outdated(+atom, ++list(compound)), one).
	:- info(outdated/2, [
		comment is 'Lists all the packs from the given registry that are installed but outdated using the given options.',
		argnames is ['Registry', 'Options'],
		remarks is [
			'``compatible(Boolean)`` option' - 'Restrict installation to compatible packs. Default is ``true``.',
			'``status(Status)`` option' - 'Restrict listing to updates with the given status. Default is ``[stable,rc,beta,alpha]``. Set to ``all`` to also list ``experimental`` and ``deprecated`` updates.'
		],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(outdated/1).
	:- mode(outdated(+atom), one).
	:- info(outdated/1, [
		comment is 'Lists all the packs from the given registry that are installed but outdated using default options.',
		argnames is ['Registry'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry')
		],
		see_also is [outdated/2]
	]).

	:- public(outdated/0).
	:- mode(outdated, one).
	:- info(outdated/0, [
		comment is 'Lists all the packs that are installed but outdated using default options.'
	]).

	:- public(orphaned/2).
	:- mode(orphaned(?atom, ?atom), zero_or_more).
	:- info(orphaned/2, [
		comment is 'Lists all the packs that are installed but whose registry is no longer defined.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(orphaned/0).
	:- mode(orphaned, one).
	:- info(orphaned/0, [
		comment is 'Lists all the packs that are installed but whose registry is no longer defined.'
	]).

	:- public(versions/3).
	:- mode(versions(+atom, +atom, -list), zero_or_one).
	:- info(versions/3, [
		comment is 'Returns a list of all available pack versions. Fails if the pack is unknown.',
		argnames is ['Registry', 'Pack', 'Versions'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(describe/2).
	:- mode(describe(+atom, +atom), zero_or_one).
	:- info(describe/2, [
		comment is 'Describes a registered pack, including installed version if applicable. Fails if the pack is unknown.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(describe/1).
	:- mode(describe(+atom), zero_or_one).
	:- info(describe/1, [
		comment is 'Describes a registered pack, including installed version if applicable. Fails if the pack is unknown.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(search/1).
	:- mode(search(+atom), one).
	:- info(search/1, [
		comment is 'Searches packs whose name or description includes the search term (case sensitive).',
		argnames is ['Term'],
		exceptions is [
			'``Term`` is a variable' - instantiation_error,
			'``Term`` is neither a variable nor an atom' - type_error(atom, 'Term')
		]
	]).

	:- public(install/4).
	:- mode(install(+atom, +atom, ++compound, ++list(compound)), zero_or_one).
	:- info(install/4, [
		comment is 'Installs a new pack using the specified options. Fails if the pack is unknown or already installed but not using ``update(true)`` or ``force(true)`` options. Fails also if the pack version is unknown.',
		argnames is ['Registry', 'Pack', 'Version', 'Options'],
		remarks is [
			'``update(Boolean)`` option' - 'Update pack if already installed. Default is ``false``. Overrides the ``force/1`` option.',
			'``force(Boolean)`` option' - 'Force pack re-installation if already installed. Default is ``false``.',
			'``compatible(Boolean)`` option' - 'Restrict installation to compatible packs. Default is ``true``.',
			'``clean(Boolean)`` option' - 'Clean pack archive after installation. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose installing steps. Default is ``false``.',
			'``checksum(Boolean)`` option' - 'Verify pack archive checksum. Default is ``true``.',
			'``checksig(Boolean)`` option' - 'Verify pack archive signature. Default is ``false``.',
			'``git(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is a variable' - instantiation_error,
			'``Version`` is neither a variable nor a valid version' - type_error(pack_version, 'Version'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(install/3).
	:- mode(install(+atom, +atom, ?compound), zero_or_one).
	:- info(install/3, [
		comment is 'Installs the specified version of a pack from the given registry using default options. Fails if the pack is already installed or unknown. Fails also if the pack version is unknown.',
		argnames is ['Registry', 'Pack', 'Version'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is a variable' - instantiation_error,
			'``Version`` is neither a variable nor a valid version' - type_error(pack_version, 'Version')
		]
	]).

	:- public(install/2).
	:- mode(install(+atom, +atom), zero_or_one).
	:- info(install/2, [
		comment is 'Installs the latest version of a pack from the given registry using default options. Fails if the pack is already installed or unknown.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(install/1).
	:- mode(install(+atom), zero_or_one).
	:- info(install/1, [
		comment is 'Installs a pack (if its name is unique among all registries) using default options. Fails if the pack is already installed or unknown. Fails also if the pack is available from multiple registries.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is not an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(update/3).
	:- mode(update(+atom, ++callable, ++list(callable)), zero_or_one).
	:- info(update/3, [
		comment is 'Updates an outdated pack to the specified version using the specified options. Fails if the pack or the pack version is unknown or if the pack is not installed. Fails also if the pack is orphaned or pinned and not using a ``force(true)`` option.',
		argnames is ['Pack', 'Version', 'Options'],
		remarks is [
			'``install(Boolean)`` option' - 'Install pack latest version if not already installed. Default is ``false``.',
			'``force(Boolean)`` option' - 'Force update if the pack is pinned or breaks installed packs. Default is ``false``.',
			'``compatible(Boolean)`` option' - 'Restrict updating to compatible packs. Default is ``true``.',
			'``status(Status)`` option' - 'Specify allowed pack status. Default is ``[stable,rc,beta,alpha]``. Set to ``all`` to also allow ``experimental`` and ``deprecated``.',
			'``clean(Boolean)`` option' - 'Clean pack archive after updating. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose updating steps. Default is ``false``.',
			'``checksum(Boolean)`` option' - 'Verify pack archive checksum. Default is ``true``.',
			'``checksig(Boolean)`` option' - 'Verify pack archive signature. Default is ``false``.',
			'``git(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Version`` is a variable' - instantiation_error,
			'``Version`` is neither a variable nor a valid version' - type_error(pack_version, 'Version'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(update/2).
	:- mode(update(+atom, ++list(callable)), zero_or_one).
	:- info(update/2, [
		comment is 'Updates an outdated pack to its latest version using the specified options. Fails if the pack is orphaned, unknown, or not installed. Fails also if the pack is pinned and not using a ``force(true)`` option.',
		argnames is ['Pack', 'Options'],
		remarks is [
			'``install(Boolean)`` option' - 'Install pack latest version if not already installed. Default is ``false``.',
			'``force(Boolean)`` option' - 'Force update if the pack is pinned or breaks installed packs. Default is ``false``.',
			'``compatible(Boolean)`` option' - 'Restrict updating to compatible packs. Default is ``true``.',
			'``status(Status)`` option' - 'Specify allowed pack update status. Default is ``[stable,rc,beta,alpha]``. Set to ``all`` to also allow ``experimental`` and ``deprecated``.',
			'``clean(Boolean)`` option' - 'Clean pack archive after updating. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose updating steps. Default is ``false``.',
			'``checksum(Boolean)`` option' - 'Verify pack archive checksum. Default is ``true``.',
			'``checksig(Boolean)`` option' - 'Verify pack archive signature. Default is ``false``.',
			'``git(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
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
		comment is 'Updates an outdated pack to its latest version using default options. Fails if the pack is pinned, orphaned, not installed, unknown, or breaks installed packs.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		],
		see_also is [update/2, update/3]
	]).

	:- public(update/0).
	:- mode(update, zero_or_one).
	:- info(update/0, [
		comment is 'Updates all outdated packs (that are not pinned) using default options.'
	]).

	:- public(uninstall/2).
	:- mode(uninstall(+atom, ++list(compound)), zero_or_one).
	:- info(uninstall/2, [
		comment is 'Uninstalls a pack using the specified options. Fails if the pack is unknown or not installed. Fails also if the pack is pinned or have dependents and not using a ``force(true)`` option.',
		argnames is ['Pack', 'Options'],
		remarks is [
			'``force(Boolean)`` option' - 'Force deletion if the pack is pinned. Default is ``false``.',
			'``clean(Boolean)`` option' - 'Clean pack archive after deleting. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose uninstalling steps. Default is ``false``.'
		],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(uninstall/1).
	:- mode(uninstall(+atom), zero_or_one).
	:- info(uninstall/1, [
		comment is 'Uninstalls a pack using default options. Fails if the pack is pinned, have dependents, not installed, or unknown.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(uninstall/0).
	:- mode(uninstall, zero_or_one).
	:- info(uninstall/0, [
		comment is 'Uninstalls all packs using the ``force(true)`` option.'
	]).

	:- public(clean/2).
	:- mode(clean(+atom, +atom), zero_or_one).
	:- info(clean/2, [
		comment is 'Cleans all pack archives. Fails if the the pack is unknown.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(clean/1).
	:- mode(clean(+atom), zero_or_one).
	:- info(clean/1, [
		comment is 'Cleans all pack archives. Fails if the pack is unknown.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(clean/0).
	:- mode(clean, one).
	:- info(clean/0, [
		comment is 'Cleans all archives for all packs.'
	]).

	:- public(save/2).
	:- mode(save(+atom, ++list(compound)), one_or_error).
	:- info(save/2, [
		comment is 'Saves a list of all installed packs and registries plus pinning status to a file using the given options. Registries without installed packs are saved when using the option ``save(all)`` and skipped when using the option ``save(installed)`` (default).',
		argnames is ['File', 'Options'],
		exceptions is [
			'``File`` is a variable' - instantiation_error,
			'``File`` is neither a variable nor an atom' - type_error(atom, 'File'),
			'``File`` is an existing file but cannot be written' - permission_error(open, source_sink, 'File'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(save/1).
	:- mode(save(+atom), one_or_error).
	:- info(save/1, [
		comment is 'Saves a list of all installed packs and their registries plus pinning status to a file using default options.',
		argnames is ['File'],
		exceptions is [
			'``File`` is a variable' - instantiation_error,
			'``File`` is neither a variable nor an atom' - type_error(atom, 'File'),
			'``File`` is an existing file but cannot be written' - permission_error(open, source_sink, 'File')
		]
	]).

	:- public(restore/2).
	:- mode(restore(+atom, ++list(compound)), zero_or_one_or_error).
	:- info(restore/2, [
		comment is 'Restores a list of registries and packs plus their pinning status from a file using the given options. Fails if restoring is not possible.',
		argnames is ['File', 'Options'],
		remarks is [
			'``force(Boolean)`` option' - 'Force restoring if a registry is already defined or a pack is already installed. Default is ``true``.',
			'``compatible(Boolean)`` option' - 'Restrict installation to compatible packs. Default is ``true``.',
			'``clean(Boolean)`` option' - 'Clean registry and pack archives after restoring. Default is ``false``.',
			'``verbose(Boolean)`` option' - 'Verbose restoring steps. Default is ``false``.',
			'``checksum(Boolean)`` option' - 'Verify pack archive checksums. Default is ``true``.',
			'``checksig(Boolean)`` option' - 'Verify pack archive signatures. Default is ``false``.',
			'``git(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``downloader(Atom)`` option' - 'Downloader utility. Either ``curl`` or ``wget``. Default is ``curl``.',
			'``curl(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``wget(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``gpg(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.',
			'``tar(Atom)`` option' - 'Extra command-line options. Default is ``\'\'``.'
		],
		exceptions is [
			'``File`` is a variable' - instantiation_error,
			'``File`` is neither a variable nor an atom' - type_error(atom, 'File'),
			'``File`` is an atom but not an existing file' - existence_error(file, 'File'),
			'``File`` is an existing file but cannot be read' - permission_error(open, source_sink, 'File'),
			'``Options`` is a variable' - instantiation_error,
			'``Options`` is neither a variable nor a list' - type_error(list, 'Options'),
			'An element ``Option`` of the list ``Options`` is a variable' - instantiation_error,
			'An element ``Option`` of the list ``Options`` is neither a variable nor a compound term' - type_error(compound, 'Option'),
			'An element ``Option`` of the list ``Options`` is a compound term but not a valid option' - domain_error(option, 'Option')
		]
	]).

	:- public(restore/1).
	:- mode(restore(+atom), zero_or_one_or_error).
	:- info(restore/1, [
		comment is 'Restores a list of registries and packs plus their pinning status from a file using default options. Fails if restoring is not possible.',
		argnames is ['File'],
		exceptions is [
			'``File`` is a variable' - instantiation_error,
			'``File`` is neither a variable nor an atom' - type_error(atom, 'File'),
			'``File`` is an atom but not an existing file' - existence_error(file, 'File'),
			'``File`` is an existing file but cannot be read' - permission_error(open, source_sink, 'File')
		]
	]).

	:- public(dependents/3).
	:- mode(dependents(+atom, +atom, -list(atom)), zero_or_one).
	:- info(dependents/3, [
		comment is 'Returns a list of all installed packs that depend on the given pack from the given registry. Fails if the pack is unknown.',
		argnames is ['Registry', 'Pack', 'Dependents'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(dependents/2).
	:- mode(dependents(+atom, +atom), zero_or_one).
	:- info(dependents/2, [
		comment is 'Prints a list of all installed packs that depend on the given pack from the given registry. Fails if the pack is unknown.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(dependents/1).
	:- mode(dependents(+atom), zero_or_one).
	:- info(dependents/1, [
		comment is 'Prints a list of all installed packs that depend on the given pack if unique from all defined registries. Fails if the pack is unknown or available from multiple registries.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(lint/2).
	:- mode(lint(+atom, +atom), zero_or_one).
	:- info(lint/2, [
		comment is 'Checks the pack specification. Fails if the pack is unknown or if linting detects errors.',
		argnames is ['Registry', 'Pack'],
		exceptions is [
			'``Registry`` is a variable' - instantiation_error,
			'``Registry`` is neither a variable nor an atom' - type_error(atom, 'Registry'),
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(lint/1).
	:- mode(lint(+atom), zero_or_one).
	:- info(lint/1, [
		comment is 'Checks the pack specification. Fails if the pack is unknown, or available from multiple registries, or if linting detects errors.',
		argnames is ['Pack'],
		exceptions is [
			'``Pack`` is a variable' - instantiation_error,
			'``Pack`` is neither a variable nor an atom' - type_error(atom, 'Pack')
		]
	]).

	:- public(lint/0).
	:- mode(lint, one).
	:- info(lint/0, [
		comment is 'Checks all pack specifications.'
	]).

	:- uses(list, [
		member/2,  memberchk/2, sort/4
	]).

	:- uses(logtalk, [
		print_message/3
	]).

	:- uses(os, [
		delete_file/1, delete_directory/1, directory_exists/1, directory_files/3,
		decompose_file_name/3, decompose_file_name/4,
		ensure_file/1, file_exists/1, file_size/2,
		internal_os_path/2, make_directory_path/1, operating_system_type/1,
		path_concat/3,
		operating_system_name/1, operating_system_machine/1, operating_system_release/1,
		shell/1
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

	:- initialization(startup).

	startup :-
		print_message(comment, packs, @'Initializing/checking packs directory structure...'),
		^^setup,
		print_message(comment, packs, @'Verifying availability of the required shell utilities...'),
		^^verify_commands_availability,
		print_message(comment, packs, @'Loading existing registry and pack specifications...'),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, RegistriesDirectory),
		directory_files(RegistriesDirectory, Registries, [type(directory), dot_files(false), paths(absolute)]),
		forall(
			member(Registry, Registries),
			^^load_registry(Registry)
		),
		print_message(banner, packs, @'Packs manager ready. For basic help, type: packs::help.').

	% packs availability predicates

	available(Registry, Pack) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Pack),
		(	ground(Registry-Pack) ->
			registry_pack(Registry, Pack, _),
			!
		;	registry_pack(Registry, Pack, _)
		).

	available(Registry) :-
		check(atom, Registry),
		(	\+ (
				implements_protocol(RegistryObject, registry_protocol),
				RegistryObject::name(Registry)
			) ->
			print_message(error, packs, unknown_registry(Registry)),
			fail
		;	print_message(information, packs, 'Available packs from registry: ~q'+[Registry]),
			(	setof(Pack, PackObject^registry_pack(Registry, Pack, PackObject), Packs) ->
				print_message(information, packs, Packs)
			;	print_message(information, packs, @'  (none)')
			)
		).

	available :-
		print_message(information, packs, @'Available packs:'),
		setof(Pack, PackObject^registry_pack(Registry, Pack, PackObject), Packs),
		print_message(information, packs, Registry::Packs),
		fail.
	available :-
		\+ registry_pack(_, _, _),
		print_message(information, packs, @'  (none)'),
		fail.
	available.

	% packs directory predicates

	directory(Pack, Directory) :-
		check(var_or(atom), Pack),
		check(var_or(atom), Directory),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, LogtalkPacksDirectory),
		directory_files(LogtalkPacksDirectory, Packs, [type(directory), dot_files(false), paths(relative)]),
		(	var(Pack), var(Directory) ->
			member(Pack, Packs),
			path_concat(LogtalkPacksDirectory, Pack, Directory)
		;	var(Directory) ->
			memberchk(Pack, Packs),
			path_concat(LogtalkPacksDirectory, Pack, Directory)
		;	member(Pack, Packs),
			path_concat(LogtalkPacksDirectory, Pack, Directory),
			!
		).

	directory(Pack) :-
		check(atom, Pack),
		directory(Pack, Directory),
		internal_os_path(Directory, OSDirectory),
		print_message(information, packs, installation_directory(OSDirectory)).

	prefix(Directory) :-
		check(var_or(atom), Directory),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Directory).

	prefix :-
		prefix(Directory),
		internal_os_path(Directory, OSDirectory),
		print_message(information, packs, installation_directory(OSDirectory)).

	% installed pack predicates

	installed(Registry, Pack, Version, Pinned) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Pack),
		check(var_or(compound), Version),
		check(var_or(boolean), Pinned),
		installed_pack(Registry, Pack, Version, Pinned).

	installed(Registry, Pack, Version) :-
		installed(Registry, Pack, Version, _).

	installed(Registry) :-
		check(atom, Registry),
		(	\+ (
				implements_protocol(RegistryObject, registry_protocol),
				RegistryObject::name(Registry)
			) ->
			print_message(error, packs, unknown_registry(Registry)),
			!,
			fail
		;	fail
		).
	installed(Registry) :-
		print_message(information, packs, 'Installed packs from the ~q registry:'+[Registry]),
		setof(
			p(Registry, Pack, Version, Pinned),
			installed_pack(Registry, Pack, Version, Pinned),
			Packs
		),
		forall(
			member(p(Registry, Pack, Version, Pinned), Packs),
			print_message(information, packs, installed_pack(Registry, Pack, Version, Pinned))
		),
		fail.
	installed(Registry) :-
		\+ installed_pack(Registry, _, _, _),
		print_message(information, packs, @'  (none)'),
		fail.
	installed(_).

	installed :-
		print_message(information, packs, @'Installed packs:'),
		setof(
			p(Registry, Pack, Version, Pinned),
			installed_pack(Registry, Pack, Version, Pinned),
			Packs
		),
		forall(
			member(p(Registry, Pack, Version, Pinned), Packs),
			print_message(information, packs, installed_pack(Registry, Pack, Version, Pinned))
		),
		fail.
	installed :-
		\+ installed_pack(_, _, _, _),
		print_message(information, packs, @'  (none)'),
		fail.
	installed.

	% outdated pack predicates

	outdated(Registry, Pack, Version, LatestVersion, Options) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Pack),
		check(var_or(compound), Version),
		check(var_or(compound), LatestVersion),
		outdated_pack(Registry, Pack, Version, LatestVersion, Options).

	outdated(Registry, Pack, Version, LatestVersion) :-
		outdated(Registry, Pack, Version, LatestVersion, []).

	outdated(Registry, UserOptions) :-
		^^merge_options(UserOptions, Options),
		print_message(information, packs, 'Outdated packs from the ~q registry:'+[Registry]),
		setof(
			p(Registry, Pack, Version, LatestVersion),
			outdated(Registry, Pack, Version, LatestVersion, Options),
			Packs
		),
		forall(
			member(p(Registry, Pack, Version, LatestVersion), Packs),
			print_message(information, packs, outdated_pack(Registry, Pack, Version, LatestVersion))
		),
		fail.
	outdated(Registry, UserOptions) :-
		^^merge_options(UserOptions, Options),
		\+ outdated_pack(Registry, _, _, _, Options),
		print_message(information, packs, @'  (none)'),
		fail.
	outdated(_, _).

	outdated(Registry) :-
		check(atom, Registry),
		outdated(Registry, []).

	outdated :-
		^^merge_options([], Options),
		print_message(information, packs, @'Outdated packs:'),
		setof(
			p(Registry, Pack, Version, LatestVersion),
			outdated(Registry, Pack, Version, LatestVersion, Options),
			Packs
		),
		forall(
			member(p(Registry, Pack, Version, LatestVersion), Packs),
			print_message(information, packs, outdated_pack(Registry, Pack, Version, LatestVersion))
		),
		fail.
	outdated :-
		^^merge_options([], Options),
		\+ outdated_pack(_, _, _, _, Options),
		print_message(information, packs, @'  (none)'),
		fail.
	outdated.

	% pack search predicates

	search(Term) :-
		check(atom, Term),
		print_message(information, packs, 'Packs whose name or description contain the term: ~q'+[Term]),
		findall(
			(Registry::Pack)-Status,
			search_hit(Term, Registry, Pack, Status),
			Packs
		),
		(	Packs == [] ->
			print_message(information, packs, @'  (none)')
		;	print_message(information, packs, search_hits(Packs))
		).

	search_hit(Term, Registry, Pack, Status) :-
		registry_pack(Registry, Pack, PackObject),
		(	sub_atom(Pack, _, _, _, Term) ->
			true
		;	PackObject::description(Description),
			sub_atom(Description, _, _, _, Term)
		),
		(	installed(Registry, Pack, _) ->
			(	pinned(Pack) ->
				Status = '(installed; pinned)'
			;	Status = '(installed)'
			)
		;	Status = ''
		).

	% install pack predicates

	install(Registry, Pack, Version, UserOptions) :-
		check(atom, Registry),
		check(atom, Pack),
		check(pack_version, Version),
		^^check_options(UserOptions),
		^^merge_options([status(all)| UserOptions], Options),
		(	installed_pack(OtherRegistry, Pack, OldVersion, _),
			Registry \== OtherRegistry ->
			print_message(error, packs, pack_already_installed_from_different_registry(OtherRegistry, Pack, OldVersion)),
			fail
		;	installed_pack(Registry, Pack, OldVersion, _),
			^^option(update(true), Options) ->
			update_pack(Registry, Pack, OldVersion, Version, Options)
		;	installed_pack(Registry, Pack, _, _),
			^^option(force(false), Options) ->
			print_message(error, packs, pack_already_installed(Pack)),
			fail
		;	registry_pack(Registry, Pack, PackObject) ->
			(	PackObject::version(Version, _, URL, CheckSum, Dependencies, Portability),
				print_message(comment, packs, installing_pack(Registry, Pack, Version)),
				check_dependencies(Dependencies, Registry, Pack, Installs, Options),
				check_portability(Portability, Options),
				install_dependencies(Installs),
				install_pack(Registry, Pack, Version, URL, CheckSum, Options),
				print_message(comment, packs, pack_installed(Registry, Pack, Version)),
				print_note(install, Version, Pack)
			;	print_message(error, packs, unknown_pack_version(Registry, Pack, Version)),
				fail
			)
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	install(Registry, Pack, Version) :-
		install(Registry, Pack, Version, []).

	install(Registry, Pack) :-
		check(atom, Registry),
		check(atom, Pack),
		^^merge_options([], Options),
		(	installed_pack(_, Pack, _, _) ->
			print_message(error, packs, pack_already_installed(Pack)),
			fail
		;	latest_version(Registry, Pack, LatestVersion, _, URL, CheckSum, Dependencies, Portability, Options) ->
			print_message(comment, packs, installing_pack(Registry, Pack, LatestVersion)),
			check_dependencies(Dependencies, Registry, Pack, Installs, Options),
			check_portability(Portability, Options),
			install_dependencies(Installs),
			install_pack(Registry, Pack, LatestVersion, URL, CheckSum, Options),
			print_message(comment, packs, pack_installed(Registry, Pack, LatestVersion)),
			print_note(install, LatestVersion, Pack)
		;	latest_version(Registry, Pack, LatestVersion, LatestStatus, URL, CheckSum, Dependencies, Portability, [status(all)| Options]) ->
			print_message(error, packs, incompatible_pack_status(Registry, Pack, LatestVersion, LatestStatus)),
			fail
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	install(Pack) :-
		check(atom, Pack),
		findall(
			Registry-Pack,
			registry_pack(Registry, Pack, _),
			RegistryPacks
		),
		(	RegistryPacks == [] ->
			print_message(error, packs, unknown_pack(Pack)),
			fail
		;	RegistryPacks = [Registry-Pack] ->
			install(Registry, Pack)
		;	print_message(error, packs, @'Pack available from multiple registries!'),
			fail
		).

	install_pack(Registry, Pack, Version, URL, CheckSum, Options) :-
		decompose_file_name(URL, _, Name, Extension),
		(	Extension = '',
			sub_atom(URL, 0, _, _, 'file://') ->
			install_pack_directory(Registry, Pack, Version, URL, Options)
		;	^^supported_url_archive(URL) ->
			install_pack_archive(Registry, Pack, Version, URL, CheckSum, Options)
		;	atom_concat(Name, Extension, Archive),
			print_message(error, packs, unsupported_archive_format(Archive)),
			fail
		).

	install_pack_directory(Registry, Pack, Version, URL, Options) :-
		^^decode_url_spaces(URL, Decoded),
		atom_concat('file://', Directory0, Decoded),
		(	sub_atom(Directory0, _, _, 0, '/') ->
			sub_atom(Directory0, _, _, 1, Directory)
		;	Directory = Directory0
		),
		(	directory_exists(Directory) ->
			true
		;	print_message(error, packs, pack_directory_not_found(Pack, Directory)),
			fail
		),
		make_pack_installation_directory(Pack, Path, OSPath),
		path_concat(Directory, '.git', Git),
		(	directory_exists(Git) ->
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['git clone -v ', URL, ' "', OSPath, '"'], Command)
			;	atomic_list_concat(['git clone -q ', URL, ' "', OSPath, '"'], Command)
			),
			^^command(Command, pack_cloning_failed(Pack, URL))
		;	operating_system_type(windows) ->
			internal_os_path(Directory, OSDirectory),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['xcopy /e /i /y "', OSDirectory, '" "', OSPath, '"'], Command)
			;	atomic_list_concat(['xcopy /e /i /y /q "', OSDirectory, '" "', OSPath, '"'], Command)
			),
			^^command(Command, pack_directory_copy_failed(Pack, URL))
		;	internal_os_path(Directory, OSDirectory),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['cp -R -v "', OSDirectory, '/." "', OSPath, '"'], Command)
			;	atomic_list_concat(['cp -R "', OSDirectory, '/." "', OSPath, '"'], Command)
			),
			^^command(Command, pack_directory_copy_failed(Pack, URL))
		),
		save_version(Path, Version),
		save_registry(Path, Registry),
		^^print_readme_file_path(Path).

	install_pack_archive(Registry, Pack, Version, URL, CheckSum, Options) :-
		download_archive(Registry, Pack, URL, CheckSum, Options, Archive, IsGitArchive),
		(	^^option(checksum(true), Options) ->
			verify_checksum(Pack, Archive, CheckSum, Options)
		;	true
		),
		(	^^option(checksig(true), Options) ->
			download_signature(Registry, Pack, URL, Archive, Options, Signature),
			verify_checksig(Pack, Archive, Signature, Options)
		;	true
		),
		uncompress(Pack, Archive, Path, Options, IsGitArchive),
		save_version(Path, Version),
		save_registry(Path, Registry),
		^^print_readme_file_path(Path),
		(	^^option(clean(true), Options) ->
			delete_archives(Registry, Pack)
		;	true
		).

	% uninstall pack predicates

	uninstall(Pack, UserOptions) :-
		check(atom, Pack),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		(	installed_pack(Registry, Pack, Version, Pinned) ->
			(	Pinned == true,
				^^option(force(false), Options) ->
				print_message(error, packs, cannot_uninstall_pinned_pack(Pack)),
				fail
			;	dependents(Registry, Pack, Dependents),
				Dependents \== [],
				^^option(force(false), Options) ->
				print_message(error, packs, cannot_uninstall_pack_with_dependents(Pack, Dependents)),
				fail
			;	print_message(comment, packs, uninstalling_pack(Registry, Pack)),
				uninstall_pack(Registry, Pack, Options),
				print_message(comment, packs, pack_uninstalled(Registry, Pack)),
				print_note(uninstall, Version, Pack)
			)
		;	registry_pack(_, Pack, _) ->
			print_message(error, packs, pack_not_installed(Pack)),
			fail
		;	print_message(error, packs, unknown_pack(Pack)),
			fail
		).

	uninstall(Pack) :-
		uninstall(Pack, []).

	uninstall :-
		print_message(comment, packs, @'Uninstalling all packs'),
		forall(
			installed_pack(_, Pack, _, _),
			uninstall(Pack, [force(true)])
		),
		print_message(comment, packs, @'Uninstalled all packs').

	% pack versions predicates

	versions(Registry, Pack, Versions) :-
		check(atom, Registry),
		check(atom, Pack),
		(	registry_pack(Registry, Pack, PackObject) ->
			findall(
				Version,
				PackObject::version(Version, _, _, _, _, _),
				Versions
			)
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	% describe pack predicates

	describe(Registry, Pack) :-
		check(atom, Registry),
		check(atom, Pack),
		(	registry_pack(Registry, Pack, PackObject) ->
			describe_pack(Registry, Pack, PackObject)
		;	directory(Pack, Directory),
			read_registry(Directory, Registry) ->
			print_message(error, packs, orphaned_pack(Registry, Pack)),
			fail
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	describe(Pack) :-
		check(atom, Pack),
		(	\+ registry_pack(_, Pack, _) ->
			(	directory(Pack, Directory),
				read_registry(Directory, Registry) ->
				print_message(error, packs, orphaned_pack(Registry, Pack))
			;	print_message(error, packs, unknown_pack(Pack))
			),
			fail
		;	forall(
				registry_pack(Registry, Pack, PackObject),
				describe_pack(Registry, Pack, PackObject)
			)
		).

	describe_pack(Registry, Pack, PackObject) :-
		PackObject::description(Description),
		PackObject::license(License),
		PackObject::home(Home),
		findall(
			version(Version, Status, URL, Cached, Checksum, Dependencies, Portability),
			(	PackObject::version(Version, Status0, URL, Checksum, Dependencies, Portability),
				(	installed(Registry, Pack, Version) ->
					atom_concat(Status0, '; installed', Status1),
					(	pinned(Pack) ->
						atom_concat(Status1, '; pinned', Status)
					;	Status = Status1
					)
				;	Status = Status0
				),
				pack_archive_path(Registry, Pack, URL, _, Archive),
				(	file_exists(Archive) ->
					Cached = cached(Archive)
				;	Cached = uncached
				)
			),
			Versions
		),
		sort(1, (@>), Versions, Sorted),
		findall(note(Action,ForVersion,Note), PackObject::note(Action,ForVersion,Note), Notes),
		print_message(information, packs, pack_info(Registry,Pack,Description,License,Home,Sorted,Notes)).

	% pack readme predicates

	readme(Pack, ReadMeFile) :-
		check(var_or(atom), ReadMeFile),
		directory(Pack, Directory),
		^^readme_file_path(Directory, ReadMeFile).

	readme(Pack) :-
		directory(Pack, Directory),
		^^readme_file_path(Directory, ReadMeFile),
		internal_os_path(ReadMeFile, OSReadMeFile),
		print_message(information, packs, readme_file(OSReadMeFile)).

	% pinned pack handling

	pin(Pack) :-
		(	pin_file(Pack, File) ->
			ensure_file(File)
		;	print_message(error, packs, pack_not_installed(Pack)),
			fail
		).

	pin :-
		installed_pack(_, Pack, _, false),
			pin_file(Pack, File),
			ensure_file(File),
		fail.
	pin.

	unpin(Pack) :-
		(	pin_file(Pack, File) ->
			(	file_exists(File) ->
				delete_file(File)
			;	true
			)
		;	print_message(error, packs, pack_not_installed(Pack)),
			fail
		).

	unpin :-
		installed_pack(_, Pack, _, true),
			pin_file(Pack, File),
			file_exists(File),
			delete_file(File),
		fail.
	unpin.

	pinned(Pack) :-
		(	pin_file(Pack, File) ->
			file_exists(File)
		;	print_message(error, packs, pack_not_installed(Pack)),
			fail
		).

	pin_file(Pack, File) :-
		check(atom, Pack),
		directory(Pack, Directory),
		path_concat(Directory, 'PINNED.packs', File).

	% update pack predicates

	update(Pack, Version, UserOptions) :-
		check(atom, Pack),
		check(pack_version, Version),
		^^check_options(UserOptions),
		^^merge_options([status(all)| UserOptions], Options),
		(	installed_pack(Registry, Pack, OldVersion, Pinned) ->
			(	Pinned == true ->
				print_message(error, packs, cannot_update_pinned_pack(Pack)),
				fail
			;	update_pack(Registry, Pack, OldVersion, Version, Options)
			)
		;	registry_pack(Registry, Pack, _) ->
			(	member(install(true), Options) ->
				latest_version(Registry, Pack, Version, Options),
				install(Registry, Pack, Version, Options)
			;	print_message(error, packs, pack_not_installed(Pack)),
				fail
			)
		;	print_message(error, packs, unknown_pack(Pack)),
			fail
		).

	update(Pack, UserOptions) :-
		check(atom, Pack),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		(	orphaned(Registry, Pack) ->
			print_message(error, packs, orphaned_pack(Registry, Pack)),
			fail
		;	installed_pack(Registry, Pack, Version, Pinned) ->
			(	Pinned == true ->
				print_message(error, packs, cannot_update_pinned_pack(Pack)),
				fail
			;	update_pack(Registry, Pack, Version, Options)
			)
		;	registry_pack(Registry, Pack, _) ->
			(	member(install(true), Options) ->
				latest_version(Registry, Pack, Version, Options),
				install(Registry, Pack, Version, Options)
			;	print_message(error, packs, pack_not_installed(Pack)),
				fail
			)
		;	print_message(error, packs, unknown_pack(Pack)),
			fail
		).

	update(Pack) :-
		update(Pack, []).

	% use a failure-driven loop so that we don't stop updating
	% the installed packs if the update for one of them fails
	update :-
		print_message(comment, packs, @'Updating installed packs:'),
		installed_pack(Registry, Pack, Version, Pinned),
		(	Pinned == false ->
			^^default_options(Options),
			update_pack(Registry, Pack, Version, Options)
		;	print_message(comment, packs, pinned_pack(Registry, Pack, Version))
		),
		fail.
	update :-
		print_message(comment, packs, @'Packs updating completed').

	update_pack(Registry, Pack, Version, NewVersion, Options) :-
		(	Version == NewVersion ->
			print_message(comment, packs, up_to_date_pack(Registry, Pack, NewVersion))
		;	orphaned(Registry, Pack) ->
			print_message(error, packs, orphaned_pack(Registry, Pack)),
			fail
		;	pack_object(Pack, PackObject),
			PackObject::version(NewVersion, _, URL, CheckSum, Dependencies, Portability),
			(	print_message(comment, packs, updating_pack(Registry, Pack, Version, NewVersion)),
				check_availability(Registry, Pack, URL, CheckSum, Options),
				check_dependencies(Dependencies, Registry, Pack, Installs, Options),
				check_portability(Portability, Options),
				check_dependents(Registry, Pack, NewVersion, Options),
				uninstall_pack(Registry, Pack, Options),
				install_dependencies(Installs),
				install_pack(Registry, Pack, NewVersion, URL, CheckSum, Options) ->
				print_message(comment, packs, pack_updated(Registry, Pack, NewVersion)),
				print_note(update, NewVersion, Pack)
			;	print_message(error, packs, pack_update_failed(Registry, Pack, NewVersion)),
				fail
			)
		;	print_message(error, packs, unknown_pack_version(Registry, Pack, NewVersion)),
			fail
		),
		(	^^option(clean(true), Options) ->
			delete_archives(Registry, Pack)
		;	true
		).

	update_pack(Registry, Pack, Version, Options) :-
		(	orphaned(Registry, Pack) ->
			print_message(comment, packs, orphaned_pack(Registry, Pack, Version))
		;	latest_version(Registry, Pack, LatestVersion, _, URL, CheckSum, Dependencies, Portability, Options),
			Version @< LatestVersion ->
			(	print_message(comment, packs, updating_pack(Registry, Pack, Version, LatestVersion)),
				check_dependencies(Dependencies, Registry, Pack, Installs, Options),
				check_portability(Portability, Options),
				check_dependents(Registry, Pack, LatestVersion, Options),
				uninstall_pack(Registry, Pack, Options),
				install_dependencies(Installs),
				install_pack(Registry, Pack, LatestVersion, URL, CheckSum, Options) ->
				print_message(comment, packs, pack_updated(Registry, Pack, LatestVersion)),
				print_note(update, LatestVersion, Pack)
			;	print_message(error, packs, pack_update_failed(Registry, Pack, LatestVersion)),
				fail
			)
		;	print_message(comment, packs, up_to_date_pack(Registry, Pack, Version))
		),
		(	^^option(clean(true), Options) ->
			delete_archives(Registry, Pack)
		;	true
		).

	% clean predicates

	clean(Registry, Pack) :-
		check(atom, Registry),
		check(atom, Pack),
		(	registry_pack(Registry, Pack, _) ->
			print_message(comment, packs, cleaning_pack_archives(Registry, Pack)),
			delete_archives(Registry, Pack),
			print_message(comment, packs, cleaned_pack_archives(Registry, Pack))
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	clean(Pack) :-
		check(atom, Pack),
		findall(
			Registry-Pack,
			registry_pack(Registry, Pack, _),
			RegistryPacks
		),
		(	RegistryPacks == [] ->
			print_message(error, packs, unknown_pack(Pack)),
			fail
		;	RegistryPacks = [Registry-Pack] ->
			print_message(comment, packs, cleaning_pack_archives(Registry, Pack)),
			delete_archives(Registry, Pack),
			print_message(comment, packs, cleaned_pack_archives(Registry, Pack))
		;	print_message(error, packs, @'Pack available from multiple registries!'),
			fail
		).

	clean :-
		print_message(comment, packs, @'Cleaning all pack archives'),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, packs, ArchivesPacks),
		directory_files(ArchivesPacks, Registries, [type(directory), dot_files(false), paths(absolute)]),
		member(Registry, Registries),
		delete_archives(Registry),
		fail.
	clean :-
		print_message(comment, packs, @'Cleaned all pack archives').

	delete_archives(Registry, Pack) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, packs, ArchivesPacks),
		path_concat(ArchivesPacks, Registry, ArchivesPacksRegistry),
		path_concat(ArchivesPacksRegistry, Pack, ArchivesPacksRegistryPack),
		(	directory_exists(ArchivesPacksRegistryPack) ->
			directory_files(ArchivesPacksRegistryPack, Files, [type(regular), dot_files(false), paths(absolute)]),
			forall(member(File, Files), delete_file(File))
		;	true
		).

	delete_archives(Registry) :-
		directory_files(Registry, Packs, [type(directory), dot_files(false), paths(absolute)]),
		member(Pack, Packs),
		directory_files(Pack, Files, [type(regular), dot_files(false), paths(absolute)]),
		forall(member(File, Files), delete_file(File)),
		delete_directory(Pack),
		fail.
	delete_archives(Registry) :-
		delete_directory(Registry).

	% save and restore predicates

	save(File, UserOptions) :-
		check(atom, File),
		print_message(comment, packs, @'Saving current setup'),
		^^check_options(UserOptions),
		^^merge_options(UserOptions, Options),
		open(File, write, Stream),
		(	^^option(save(all), Options) ->
			findall(Registry, registries::defined(Registry, _, _, _), Registries)
		;	findall(Registry, installed_pack(Registry, _, _, _), Registries)
		),
		sort(Registries, SortedRegistries),
		forall(
			member(Registry, SortedRegistries),
			(	registries::defined(Registry, URL, _, _),
				writeq(Stream, registry(Registry, URL)), write(Stream, '.\n')
			)
		),
		findall(
			pack(Registry, Pack, Version),
			installed_pack(Registry, Pack, Version, _),
			PacksData0
		),
		sort(PacksData0, PacksData),
		forall(
			member(PackData, PacksData),
			(writeq(Stream, PackData), write(Stream, '.\n'))
		),
		forall(
			(member(Registry, SortedRegistries), registries::defined(Registry, _, _, true)),
			(writeq(Stream, pinned_registry(Registry)), write(Stream, '.\n'))
		),
		forall(
			installed_pack(_, Pack, _, true),
			(writeq(Stream, pinned_pack(Pack)), write(Stream, '.\n'))
		),
		close(Stream),
		print_message(comment, packs, @'Saved current setup').

	save(File) :-
		save(File, [save(installed)]).

	restore(File, UserOptions) :-
		print_message(comment, packs, @'Restoring setup'),
		check(file, File),
		^^check_options(UserOptions),
		(	member(force(_), UserOptions) ->
			UpdatedOptions = UserOptions
		;	% the restore/1-2 predicates use a different default for this option
			UpdatedOptions = [force(true)| UserOptions]
		),
		^^merge_options(UpdatedOptions, Options),
		open(File, read, Stream),
		read(Stream, Term),
		restore(Term, Stream, Options),
		print_message(comment, packs, @'Restored setup').

	restore(File) :-
		restore(File, []).

	restore(end_of_file, Stream, _) :-
		!,
		close(Stream).
	restore(registry(Registry, URL), Stream, Options) :-
		(	registries::add(Registry, URL, Options) ->
			read(Stream, Term),
			restore(Term, Stream, Options)
		;	close(Stream),
			print_message(error, packs, 'Restoring registries/packs setup failed while adding the ~q registry'+[Registry]),
			fail
		).
	restore(pack(Registry, Pack, Version), Stream, Options) :-
		(	install(Registry, Pack, Version, Options) ->
			read(Stream, Term),
			restore(Term, Stream, Options)
		;	close(Stream),
			print_message(error, packs, 'Restoring registries/packs setup failed while installing the ~q pack'+[Pack]),
			fail
		).
	restore(pinned_registry(Registry), Stream, Options) :-
		(	registries::pin(Registry) ->
			read(Stream, Term),
			restore(Term, Stream, Options)
		;	close(Stream),
			print_message(error, packs, 'Restoring registries/packs setup failed while pinning the ~q registry'+[Registry]),
			fail
		).
	restore(pinned_pack(Pack), Stream, Options) :-
		(	pin(Pack) ->
			read(Stream, Term),
			restore(Term, Stream, Options)
		;	close(Stream),
			print_message(error, packs, 'Restoring registries/packs setup failed while pinning the ~q pack'+[Pack]),
			fail
		).

	% orphaned pack predicates

	orphaned :-
		print_message(information, packs, @'Orphaned packs:'),
		orphaned_pack(Registry, Pack),
		print_message(information, packs, pack(Registry, Pack)),
		fail.
	orphaned :-
		\+ orphaned_pack(_, _),
		print_message(information, packs, @'  (none)'),
		fail.
	orphaned.

	orphaned(Registry, Pack) :-
		check(var_or(atom), Registry),
		check(var_or(atom), Pack),
		orphaned_pack(Registry, Pack).

	orphaned_pack(Registry, Pack) :-
		installed_pack(Registry, Pack, _, _),
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, registries, Registries),
		path_concat(Registries, Registry, Directory),
		\+ directory_exists(Directory).

	% pack dependents predicates

	dependents(Registry, Pack, Dependents) :-
		check(atom, Registry),
		check(atom, Pack),
		(	registry_pack(Registry, Pack, _) ->
			pack_dependents(Registry, Pack, Dependents)
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	dependents(Registry, Pack) :-
		dependents(Registry, Pack, Dependents),
		print_dependents(Registry, Pack, Dependents).

	dependents(Pack) :-
		check(atom, Pack),
		findall(
			Registry-Pack,
			registry_pack(Registry, Pack, _),
			RegistryPacks
		),
		(	RegistryPacks == [] ->
			print_message(error, packs, unknown_pack(Pack)),
			fail
		;	RegistryPacks = [Registry-Pack] ->
			pack_dependents(Registry, Pack, Dependents),
			print_dependents(Registry, Pack, Dependents)
		;	print_message(error, packs, @'Pack available from multiple registries!'),
			fail
		).

	print_dependents(Registry, Pack, Dependents) :-
		print_message(information, packs, 'Packs depending on pack: ~q::~q'+[Registry, Pack]),
		(	Dependents == [] ->
			print_message(information, packs, @'  (none)')
		;	print_message(information, packs, Dependents)
		).

	pack_dependents(Registry, Pack, Dependents) :-
		(	setof(Dependent, pack_dependent(Registry, Pack, Dependent), Dependents) ->
			true
		;	Dependents = []
		).

	pack_dependent(Registry, Pack, Dependent) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Directory),
		directory_files(Directory, Dependents, [type(directory), dot_files(false), paths(relative)]),
		member(Dependent, Dependents),
		implements_protocol(DependentObject, pack_protocol),
		DependentObject::name(Dependent),
		DependentObject::version(_, _, _, _, Dependencies, _),
		(	member(Dependency, Dependencies),
			dependency(Dependency, Registry::Pack) ->
			true
		;	fail
		).

	dependency(Dependency @>= _, Dependency).
	dependency(Dependency @=< _, Dependency).
	dependency(Dependency @>  _, Dependency).
	dependency(Dependency @<  _, Dependency).
	dependency(Dependency ==  _, Dependency).
	dependency(Dependency \== _, Dependency).

	% lint predicates

	lint(Registry, Pack) :-
		check(atom, Registry),
		check(atom, Pack),
		(	registry_pack(Registry, Pack, PackObject) ->
			lint_pack(Registry, Pack, PackObject)
		;	print_message(error, packs, unknown_pack(Registry, Pack)),
			fail
		).

	lint(Pack) :-
		check(atom, Pack),
		findall(
			registry_pack(Registry, Pack, PackObject),
			registry_pack(Registry, Pack, PackObject),
			RegistryPacks
		),
		(	RegistryPacks == [] ->
			print_message(error, packs, unknown_pack(Pack)),
			fail
		;	RegistryPacks = [registry_pack(Registry, Pack, PackObject)] ->
			lint_pack(Registry, Pack, PackObject)
		;	print_message(error, packs, @'Pack available from multiple registries!'),
			fail
		).

	lint :-
		print_message(comment, packs, @'Lint checking all packs'),
		registry_pack(Registry, Pack, PackObject),
		lint_pack(Registry, Pack, PackObject),
		fail.
	lint :-
		print_message(comment, packs, @'Lint checked all packs').

	lint_pack(Registry, Pack, PackObject) :-
		print_message(comment, packs, linting_pack(Registry, Pack)),
		lint_check(name, Pack, PackObject),
		lint_check(description, Pack, PackObject),
		lint_check(license, Pack, PackObject),
		lint_check(home, Pack, PackObject),
		lint_check(version, Pack, PackObject),
		lint_check(notes, Pack, PackObject),
		print_message(comment, packs, linted_pack(Registry, Pack)).

	lint_check(name, Pack, PackObject) :-
		atom_concat(Pack, '_pack', ExpectedPackObject),
		(	PackObject == ExpectedPackObject ->
			true
		;	print_message(warning, packs, 'Pack object expected name is ~q but ~q is used!'+[ExpectedPackObject, PackObject]),
			fail
		).
	lint_check(description, _Pack, PackObject) :-
		(	PackObject::description(_) ->
			true
		;	print_message(warning, packs, @'The description/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(license, _Pack, PackObject) :-
		(	PackObject::license(License),
			atom(License) ->
			true
		;	print_message(warning, packs, @'The license/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(home, _Pack, PackObject) :-
		(	PackObject::home(_) ->
			true
		;	print_message(warning, packs, @'The home/1 predicate is missing or failed safety check!'),
			fail
		).
	lint_check(version, Pack, PackObject) :-
		(	\+ PackObject::version(_, _, _, _, _, _) ->
			print_message(warning, packs, @'The version/6 predicate is missing or failed safety check!'),
			fail
		;	lint_check_versions(Pack, PackObject)
		).
	lint_check(notes, _Pack, PackObject) :-
		forall(
			PackObject::note(Action, Version, Note),
			lint_check_note(Action, Version, Note)
		).

	lint_check_versions(Pack, PackObject) :-
		PackObject::version(Version, Status, URL, CheckSum, Dependencies, Portability),
		(	valid_version(Version) ->
			true
		;	print_message(warning, packs, 'Invalid pack version: ~q'+[Version]),
			fail
		),
		(	valid_status(Status) ->
			true
		;	print_message(warning, packs, 'Unknown pack status: ~q'+[Status]),
			fail
		),
		decompose_file_name(URL, _, Name, _),
		(	sub_atom(URL, 0, _, _, 'file://') ->
			(	Name == Pack ->
				true
			;	^^supported_url_archive(URL) ->
				true
			;	print_message(warning, packs, 'Invalid version URL: ~q'+[URL]),
				fail
			)
		;	^^supported_url_archive(URL) ->
			true
		;	print_message(warning, packs, 'Invalid version URL: ~q'+[URL]),
			fail
		),
		(	CheckSum == none, sub_atom(URL, 0, _, _, 'file://') ->
			true
		;	CheckSum = sha256-Hash, atom(Hash) ->
			true
		;	print_message(warning, packs, 'Invalid pack checksum: ~q'+[CheckSum]),
			fail
		),
		(	Dependencies == [] ->
			true
		;	Dependencies \= [_| _] ->
			print_message(warning, packs, 'Invalid pack dependencies: ~q'+[Dependencies]),
			fail
		;	member(Dependency, Dependencies),
			\+ valid_dependency(Dependency, Pack) ->
			print_message(warning, packs, 'Invalid pack dependency: ~q'+[Dependency]),
			fail
		;	true
		),
		(	Portability == all ->
			true
		;	Portability \= [_| _] ->
			print_message(warning, packs, 'Invalid pack portability: ~q'+[Portability]),
			fail
		;	member(Backend, Portability),
			\+ valid_backend(Backend) ->
			print_message(warning, packs, 'Unknown Prolog backend: ~q'+[Backend]),
			fail
		;	true
		),
		fail.
	lint_check_versions(_, PackObject) :-
		findall(Version, PackObject::version(Version, _, _, _, _, _), Versions),
		(	sort(0, (@>), Versions, Versions) ->
			true
		;	print_message(warning, packs, 'Pack versions are not listed from newest to oldest: ~q'+[Versions])
		),
		fail.
	lint_check_versions(_, _).

	lint_check_note(Action, Version, Note) :-
		(	var(Action) ->
			true
		;	member(Action, [install, update, uninstall]) ->
			true
		;	print_message(warning, packs, @'The notes/3 predicate action argument is neither a variable nor install, update, or uninstall!'),
			fail
		),
		(	var(Version) ->
			true
		;	valid_version(Version) ->
			true
		;	print_message(warning, packs, @'The notes/3 predicate version argument is neither a variable nor a valid version!'),
			fail
		),
		(	atom(Note) ->
			true
		;	print_message(warning, packs, @'The notes/3 predicate note argument is not an atom!'),
			fail
		).

	valid_version(Major:Minor:Patch) :-
		integer(Major),
		integer(Minor),
		integer(Patch).

	valid_status(stable).
	valid_status(rc).
	valid_status(beta).
	valid_status(alpha).
	valid_status(experimental).
	valid_status(deprecated).

	compatible_status(Status, Options) :-
		(	member(status(CompatibleStatus), Options) ->
			(	CompatibleStatus == all ->
				true
			;	memberchk(Status, CompatibleStatus)
			)
		;	true
		).

	valid_dependency((Dependency; Dependencies), Pack) :-
		!,
		valid_dependency(Dependency, Pack),
		valid_dependency(Dependencies, Pack).
	valid_dependency(Dependency, Pack) :-
		functor(Dependency, Operator, 2),
		arg(1, Dependency, What),
		(	What == logtalk ->
			true
		;	atom(What), valid_backend(What) ->
			true
		;	What = (DependencyRegistry::DependencyPack) ->
			atom(DependencyRegistry),
			atom(DependencyPack),
			DependencyPack \== Pack
		;	What = os(Name, Machine),
			atom(Name),
			atom(Machine)
		),
		memberchk(Operator, [(@>=), (@>), (\==), (==), (@=<), (@<)]),
		arg(2, Dependency, Version),
		valid_dependency_version(Version, What).

	valid_backend(b).
	valid_backend(ciao).
	valid_backend(cx).
	valid_backend(eclipse).
	valid_backend(gnu).
	valid_backend(ji).
	valid_backend(xvm).
	valid_backend(quintus).
	valid_backend(sicstus).
	valid_backend(swi).
	valid_backend(tau).
	valid_backend(trealla).
	valid_backend(xsb).
	valid_backend(yap).

	valid_dependency_version(Major:Minor:Patch, _) :-
		integer(Major),
		integer(Minor),
		integer(Patch),
		!.
	valid_dependency_version(Major:Minor, _) :-
		integer(Major),
		integer(Minor),
		!.
	valid_dependency_version(Major, _) :-
		integer(Major),
		!.
	valid_dependency_version(Version, os(_, _)) :-
		atom(Version).

	% check availability of a pack update

	check_availability(Registry, Pack, URL, CheckSum, Options) :-
		decompose_file_name(URL, _, Name, Extension),
		(	Extension = '',
			sub_atom(URL, 0, _, _, 'file://') ->
			check_availability_directory(Pack, URL)
		;	^^supported_url_archive(URL) ->
			check_availability_archive(Registry, Pack, URL, CheckSum, Options)
		;	atom_concat(Name, Extension, Archive),
			print_message(error, packs, unsupported_archive_format(Archive)),
			fail
		).

	check_availability_directory(Pack, URL) :-
		^^decode_url_spaces(URL, Decoded),
		atom_concat('file://', Directory0, Decoded),
		(	sub_atom(Directory0, _, _, 0, '/') ->
			sub_atom(Directory0, _, _, 1, Directory)
		;	Directory = Directory0
		),
		(	directory_exists(Directory) ->
			true
		;	print_message(error, packs, pack_directory_not_found(Pack, Directory)),
			fail
		).

	check_availability_archive(Registry, Pack, URL, CheckSum, Options) :-
		download_archive(Registry, Pack, URL, CheckSum, Options, Archive, _),
		(	^^option(checksum(true), Options) ->
			verify_checksum(Pack, Archive, CheckSum, Options)
		;	true
		),
		(	^^option(checksig(true), Options) ->
			download_signature(Registry, Pack, URL, Archive, Options, Signature),
			verify_checksig(Pack, Archive, Signature, Options)
		;	true
		).

	% dependency checking predicates

	check_dependencies([], _, _, [], _).
	check_dependencies([Dependency1, Dependency2| Dependencies], Registry, Pack, [Action| Actions], Options) :-
		range_dependency(Dependency1, Dependency2, Dependency, Lower, Operator1, Upper, Operator2),
		!,
		check_range_dependency(Dependency, Lower, Operator1, Upper, Operator2, Action, Options),
		check_dependencies(Dependencies, Registry, Pack, Actions, Options).
	check_dependencies([Dependency| Dependencies], Registry, Pack, [Action| Actions], Options) :-
		check_dependency(Dependency, Registry, Pack, Action, Options),
		check_dependencies(Dependencies, Registry, Pack, Actions, Options).

	range_dependency(Dependency1, Dependency2, Registry::Pack, Lower, Operator1, Upper, Operator2) :-
		Dependency1 =.. [Operator1, Registry::Pack, Lower],
		Dependency2 =.. [Operator2, Registry::Pack, Upper],
		!.
	range_dependency(Dependency1, Dependency2, os(Name,Machine), Lower, Operator1, Upper, Operator2) :-
		Dependency1 =.. [Operator1, os(Name,Machine), Lower],
		Dependency2 =.. [Operator2, os(Name,Machine), Upper],
		!.
	range_dependency(Dependency1, Dependency2, Backend, Lower, Operator1, Upper, Operator2) :-
		backend(Backend, _),
		Dependency1 =.. [Operator1, Backend, Lower],
		Dependency2 =.. [Operator2, Backend, Upper].

	check_range_dependency(Registry::Pack, Lower, Operator1, Upper, Operator2, Action, Options) :-
		!,
		check_availability(Registry::Pack, Options),
		(	installed_pack(Registry, Pack, InstalledVersion, _) ->
			fix_version_for_comparison(Lower, InstalledVersion, LowerFixedVersion),
			fix_version_for_comparison(Upper, InstalledVersion, UpperFixedVersion),
			(	{call(Operator1, LowerFixedVersion, Lower)},
				{call(Operator2, UpperFixedVersion, Upper)} ->
				Action = none
			;	find_dependency_version(Operator1, Lower, Operator2, Upper, Registry, Pack, Version, Options) ->
				Action = update(Registry, Pack, Version, Options)
			;	\+ member('$or'(true), Options),
				print_message(error, packs, pack_dependency_not_available(Registry::Pack, Operator1, Lower, Operator2, Upper)),
				fail
			)
		;	find_dependency_version(Operator1, Lower, Operator2, Upper, Registry, Pack, Version, Options) ->
			Action = install(Registry, Pack, Version, Options)
		;	\+ member('$or'(true), Options),
			print_message(error, packs, pack_dependency_not_available(Registry::Pack, Operator1, Lower, Operator2, Upper)),
			fail
		).
	check_range_dependency(os(Name,Machine), Lower, Operator1, Upper, Operator2, Action, Options) :-
		!,
		(	operating_system_name(Name),
			operating_system_machine(Machine),
			operating_system_release(Version),
			{call(Operator1, Version, Lower)},
			{call(Operator2, Version, Upper)} ->
			Action = none
		;	^^option(compatible(false), Options) ->
			Action = os(Name, Machine, Operator1, Lower, Operator2, Upper)
		;	print_message(warning, packs, no_pack_version_compatible_with_os_version(Name, Machine, Version)),
			fail
		).
	check_range_dependency(logtalk, Lower, Operator1, Upper, Operator2, Action, Options) :-
		!,
		current_logtalk_flag(version_data, logtalk(Major,Minor,Patch,_)),
		fix_version_for_comparison(Lower, Major:Minor:Patch, LowerFixedVersion),
		fix_version_for_comparison(Upper, Major:Minor:Patch, UpperFixedVersion),
		(	{call(Operator1, LowerFixedVersion, Lower)},
			{call(Operator2, UpperFixedVersion, Upper)} ->
			Action = none
		;	^^option(compatible(false), Options) ->
			Action = logtalk(Operator1, Lower, Operator2, Upper)
		;	print_message(warning, packs, no_pack_version_compatible_with_logtalk_version(Major:Minor:Patch)),
			fail
		).
	% workaround the interim solution for allowing specifying two distinct compatible backend versions for a pack version
	check_range_dependency(Backend, Lower, (==), Upper, (==), Action, Options) :-
		current_logtalk_flag(prolog_dialect, Backend),
		!,
		current_logtalk_flag(prolog_version, v(Major,Minor,Patch)),
		fix_version_for_comparison(Lower, Major:Minor:Patch, LowerFixedVersion),
		fix_version_for_comparison(Upper, Major:Minor:Patch, UpperFixedVersion),
		(	(	LowerFixedVersion == Lower
			;	UpperFixedVersion == Upper
			) ->
			Action = none
		;	^^option(compatible(false), Options) ->
			backend(Backend, Name),
			Action = backend(Name, (==), Lower, (==), Upper)
		;	backend(Backend, Name),
			print_message(warning, packs, no_pack_version_compatible_with_backend_version(Name, Major:Minor:Patch)),
			fail
		).
	check_range_dependency(Backend, Lower, Operator1, Upper, Operator2, Action, Options) :-
		current_logtalk_flag(prolog_dialect, Backend),
		!,
		current_logtalk_flag(prolog_version, v(Major,Minor,Patch)),
		fix_version_for_comparison(Lower, Major:Minor:Patch, LowerFixedVersion),
		fix_version_for_comparison(Upper, Major:Minor:Patch, UpperFixedVersion),
		(	{call(Operator1, LowerFixedVersion, Lower)},
			{call(Operator2, UpperFixedVersion, Upper)} ->
			Action = none
		;	^^option(compatible(false), Options) ->
			backend(Backend, Name),
			Action = backend(Name, Operator1, Lower, Operator2, Upper)
		;	backend(Backend, Name),
			print_message(warning, packs, no_pack_version_compatible_with_backend_version(Name, Major:Minor:Patch)),
			fail
		).
	check_range_dependency(_, _, _, _, _, none, _).

	check_dependency((Dependency; Dependencies), Registry, Pack, Action, Options) :-
		!,
		(	check_dependency(Dependency, Registry, Pack, Action, ['$or'(true)| Options]) ->
			true
		;	check_dependency(Dependencies, Registry, Pack, Action, ['$or'(true)| Options]) ->
			true
		;	\+ member('$or'(true), Options),
			print_message(error, packs, pack_dependency_not_available(Registry, Pack)),
			fail
		).
	check_dependency((Dependency, Dependencies), Registry, Pack, Action, Options) :-
		!,
		check_dependencies([Dependency| Dependencies], Registry, Pack, Action, Options).
	check_dependency(Dependency, _, _, Action, Options) :-
		Dependency =.. [Operator, Resource, Version],
		check_availability(Resource, Options),
		check_version(Operator, Resource, Version, Dependency, Action, Options).

	check_availability(Registry::Pack, Options) :-
		!,
		(	registry_pack(Registry, Pack, _) ->
			true
		;	\+ member('$or'(true), Options),
			print_message(error, packs, pack_dependency_not_available(Registry, Pack)),
			fail
		).
	check_availability(_, _).

	check_version(Operator, Registry::Pack, RequiredVersion, Dependency, Action, Options) :-
		!,
		(	installed_pack(Registry, Pack, InstalledVersion, _) ->
			fix_version_for_comparison(RequiredVersion, InstalledVersion, FixedVersion),
			(	{call(Operator, FixedVersion, RequiredVersion)} ->
				Action = none
			;	find_dependency_version(Operator, RequiredVersion, Registry, Pack, Version, Options) ->
				Action = update(Registry, Pack, Version, Options)
			;	\+ member('$or'(true), Options),
				print_message(error, packs, pack_dependency_not_available(Dependency)),
				fail
			)
		;	find_dependency_version(Operator, RequiredVersion, Registry, Pack, Version, Options) ->
			Action = install(Registry, Pack, Version, Options)
		;	\+ member('$or'(true), Options),
			print_message(error, packs, pack_dependency_not_available(Dependency)),
			fail
		).
	check_version(Operator, os(Name,Machine), RequiredVersion, Dependency, Action, Options) :-
		!,
		(	operating_system_name(Name),
			operating_system_machine(Machine),
			operating_system_release(Version),
			{call(Operator, Version, RequiredVersion)} ->
			Action = none
		;	^^option(compatible(false), Options) ->
			Action = os(Name, Machine, RequiredVersion)
		;	\+ member('$or'(true), Options),
			print_message(error, packs, os_dependency_not_available(Dependency)),
			fail
		).
	check_version(Operator, logtalk, Version, Dependency, Action, Options) :-
		!,
		current_logtalk_flag(version_data, logtalk(Major,Minor,Patch,_)),
		fix_version_for_comparison(Version, Major:Minor:Patch, FixedVersion),
		(	{call(Operator, FixedVersion, Version)} ->
			Action = none
		;	^^option(compatible(false), Options) ->
			Action = logtalk(Operator, Version)
		;	\+ member('$or'(true), Options),
			print_message(error, packs, logtalk_dependency_not_available(Dependency)),
			fail
		).
	check_version(Operator, Backend, Version, Dependency, Action, Options) :-
		(	current_logtalk_flag(prolog_dialect, Backend) ->
			current_logtalk_flag(prolog_version, v(Major,Minor,Patch)),
			fix_version_for_comparison(Version, Major:Minor:Patch, FixedVersion),
			(	{call(Operator, FixedVersion, Version)} ->
				Action = none
			;	^^option(compatible(false), Options) ->
				backend(Backend, Name),
				Action = backend(Name, Operator, Version)
			;	\+ member('$or'(true), Options),
				print_message(error, packs, backend_dependency_not_available(Dependency)),
				fail
			)
		;	^^option(compatible(false), Options) ->
			backend(Backend, Name),
			Action = backend(Name, Operator, Version)
		;	\+ member('$or'(true), Options),
			print_message(error, packs, backend_dependency_not_available(Dependency)),
			fail
		).

	fix_version_for_comparison(_:_:_, Major:Minor:Patch, Major:Minor:Patch) :- !.
	fix_version_for_comparison(_:_,   Major:Minor:_,     Major:Minor) :- !.
	fix_version_for_comparison(_,     Major:_:_,         Major).

	fix_version_for_availability(Major:Minor:Patch, Major:Minor:Patch) :- !.
	fix_version_for_availability(Major:Minor,       Major:Minor:_) :- !.
	fix_version_for_availability(Major,             Major:_:_).

	find_dependency_version(Operator1, Lower, Operator2, Upper, Registry, Pack, Version, Options) :-
		registry_pack(Registry, Pack, PackObject),
		fix_version_for_availability(Lower, LowerFixed),
		fix_version_for_availability(Upper, UpperFixed),
		(	% first try to find a version that verifies both Logtalk,
			% Prolog backend, and operating-system dependencies
			PackObject::version(Version, _, _, _, Dependencies, _),
			{call(Operator1, Version, LowerFixed)},
			{call(Operator2, Version, UpperFixed)},
			check_dependencies(Dependencies, Registry, Pack, Actions, Options),
			\+ member(logtalk(_, _, _, _), Actions),
			\+ member(logtalk(_, _), Actions),
			\+ member(backend(_, _, _, _, _), Actions),
			\+ member(backend(_, _, _), Actions),
			\+ member(os(_, _, _, _, _, _), Actions),
			\+ member(os(_, _, _), Actions)
		;	% if none found, use the first version required by the pack
			^^option(compatible(false), Options),
			PackObject::version(Version, _, _, _, _, _),
			{call(Operator1, Version, LowerFixed)},
			{call(Operator2, Version, UpperFixed)}
		).

	find_dependency_version(Operator, RequiredVersion, Registry, Pack, Version, Options) :-
		registry_pack(Registry, Pack, PackObject),
		fix_version_for_availability(RequiredVersion, RequiredVersionFixed),
		(	% first try to find a version that verifies both Logtalk,
			% Prolog backend, and operating-system dependencies
			PackObject::version(Version, _, _, _, Dependencies, _),
			{call(Operator, Version, RequiredVersionFixed)},
			check_dependencies(Dependencies, Registry, Pack, Actions, Options),
			\+ member(logtalk(_, _, _, _), Actions),
			\+ member(logtalk(_, _), Actions),
			\+ member(backend(_, _, _, _, _), Actions),
			\+ member(backend(_, _, _), Actions),
			\+ member(os(_, _, _, _, _, _), Actions),
			\+ member(os(_, _, _), Actions)
		;	% if none found, use the first version required by the pack
			^^option(compatible(false), Options),
			PackObject::version(Version, _, _, _, _, _),
			{call(Operator, Version, RequiredVersionFixed)}
		).

	install_dependencies([]).
	install_dependencies([Dependency| Dependencies]) :-
		install_dependency(Dependency),
		install_dependencies(Dependencies).

	install_dependency(none).
	install_dependency(logtalk(Operator1, Lower, Operator2, Upper)) :-
		print_message(warning, packs, 'Pack requires updating Logtalk to a version ~w ~q and ~w ~q'+[Operator1, Lower, Operator2, Upper]).
	install_dependency(logtalk(Operator, Version)) :-
		print_message(warning, packs, 'Pack requires updating Logtalk to version ~w ~q'+[Operator, Version]).
	install_dependency(backend(Name, Operator1, Lower, Operator2, Upper)) :-
		print_message(warning, packs, 'Pack requires updating ~w to version ~w ~q and ~w ~q'+[Name, Operator1, Lower, Operator2, Upper]).
	install_dependency(backend(Name, Operator, Version)) :-
		print_message(warning, packs, 'Pack requires updating ~w to version ~w ~q'+[Name, Operator, Version]).
	install_dependency(os(Name, Machine, Operator1, Lower, Operator2, Upper)) :-
		print_message(warning, packs, 'Pack requires the ~w operating-system running on ~w at version ~w ~q and ~w ~q'+[Name, Machine, Operator1, Lower, Operator2, Upper]).
	install_dependency(os(Name, Machine, Version)) :-
		print_message(warning, packs, 'Pack requires the ~w operating-system running on ~w at version ~w'+[Name, Machine, Version]).
	install_dependency(install(Registry, Pack, Version, Options)) :-
		install(Registry, Pack, Version, Options).
	install_dependency(update(_Registry, Pack, Version, Options)) :-
		update(Pack, Version, Options).

	check_portability(all, _).
	check_portability([Backend| Backends], Options) :-
		current_logtalk_flag(prolog_dialect, Dialect),
		(	member(Dialect, [Backend| Backends]) ->
			true
		;	^^option(compatible(true), Options) ->
			backend(Dialect, Name),
			print_message(warning, packs, 'No pack version compatible with the current backend was found: ~w'+[Name]),
			fail
		;	Backends == [] ->
			backend(Backend, Name),
			print_message(warning, packs, 'Using the pack requires a different backend: ~w'+[Name])
		;	backends([Backend| Backends], Names),
			print_message(warning, packs, 'Using the pack requires one of the following backends: ~w'+[Names])
		).

	check_dependents(Registry, Pack, NewVersion, Options) :-
		dependents(Registry, Pack, Dependents),
		check_dependents(Dependents, Registry, Pack, NewVersion, Options).

	check_dependents([], _, _, _, _).
	check_dependents([Dependent| Dependents], Registry, Pack, NewVersion, Options) :-
		check_dependent(Dependent, Registry, Pack, NewVersion, Options),
		check_dependents(Dependents, Registry, Pack, NewVersion, Options).

	check_dependent(Dependent, Registry, Pack, NewVersion, Options) :-
		pack_object(Dependent, DependentObject),
		installed_pack(_, Dependent, Version, _),
		DependentObject::version(Version, _, _, _, Dependencies, _),
		check_dependent_dependencies(Dependencies, Dependent, Registry, Pack, NewVersion, Options).

	check_dependent_dependencies([], _, _, _, _, _).
	check_dependent_dependencies([Dependency| Dependencies], Dependent, Registry, Pack, NewVersion, Options) :-
		(	check_dependent_dependency(Dependency, Registry, Pack, NewVersion) ->
			check_dependent_dependencies(Dependencies, Dependent, Registry, Pack, NewVersion, Options)
		;	^^option(force(false), Options) ->
			print_message(error, packs, updating_pack_would_break_installed_pack(Registry::Pack, NewVersion, Dependent)),
			fail
		;	print_message(warning, packs, updating_pack_breaks_installed_pack(Registry::Pack, NewVersion, Dependent))
		).

	check_dependent_dependency((Dependency; Dependencies), Registry, Pack, NewVersion) :-
		!,
		(	check_dependent_dependency(Dependency, Registry, Pack, NewVersion) ->
			true
		;	check_dependent_dependency(Dependencies, Registry, Pack, NewVersion)
		).
	check_dependent_dependency(Dependency, Registry, Pack, NewVersion) :-
		Dependency =.. [Operator, Registry::Pack, RequiredVersion],
		!,
		fix_version_for_availability(RequiredVersion, FixedVersion),
		{call(Operator, NewVersion, FixedVersion)}.
	check_dependent_dependency(_, _, _, _).

	% auxiliary predicates

	registry_pack(Registry, Pack, PackObject) :-
		implements_protocol(RegistryObject, registry_protocol),
		RegistryObject::name(Registry),
		% check that the registry have not been deleted in the current session
		registries::directory(Registry, _),
		object_property(RegistryObject, file(_, Directory)),
		implements_protocol(PackObject, pack_protocol),
		PackObject::name(Pack),
		object_property(PackObject, file(_, Directory)).

	pack_object(Pack, PackObject) :-
		(	var(Pack) ->
			implements_protocol(PackObject, pack_protocol),
			PackObject::name(Pack)
		;	implements_protocol(PackObject, pack_protocol),
			PackObject::name(Pack) ->
			!
		;	print_message(error, packs, unknown_pack(Pack)),
			fail
		).

	installed_pack(Registry, Pack, Version, Pinned) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Directory),
		directory_files(Directory, Packs, [type(directory), dot_files(false), paths(relative)]),
		member(Pack, Packs),
		path_concat(Directory, Pack, Path),
		read_version(Path, Version),
		read_registry(Path, Registry),
		(	pinned(Pack) ->
			Pinned = true
		;	Pinned = false
		).

	outdated_pack(Registry, Pack, Version, LatestVersion, Options) :-
		installed_pack(Registry, Pack, Version, _),
		latest_version(Registry, Pack, LatestVersion, Options),
		Version @< LatestVersion.

	latest_version(Registry, Pack, LatestVersion, Options) :-
		registry_pack(Registry, Pack, PackObject),
		findall(
			Version,
			(	PackObject::version(Version, Status, _, _, _, _),
				compatible_status(Status, Options)
			),
			Versions
		),
		sort(0, (@>), Versions, [LatestVersion| _]).

	latest_version(Registry, Pack, LatestVersion, LatestStatus, URL, CheckSum, Dependencies, Portability, Options) :-
		registry_pack(Registry, Pack, PackObject),
		findall(
			version(Version, Status, URL, CheckSum, Dependencies, Portability),
			(	PackObject::version(Version, Status, URL, CheckSum, Dependencies, Portability),
				compatible_status(Status, Options)
			),
			Versions
		),
		sort(1, (@>), Versions, [version(LatestVersion,LatestStatus,URL,CheckSum,Dependencies,Portability)| _]).

	uninstall_pack(Registry, Pack, Options) :-
		directory(Pack, Directory0),
		internal_os_path(Directory0, Directory),
		delete_pack_installation_directory_command(Directory, Options, Command),
		^^command(Command, pack_uninstall_failed(Pack, Directory)),
		(	^^option(clean(true), Options) ->
			delete_archives(Registry, Pack)
		;	true
		).

	clean_pack_installation_directory(Pack, Path, Options, OSPath) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Packs),
		path_concat(Packs, Pack, Path),
		internal_os_path(Path, OSPath),
		(	\+ directory_exists(Path) ->
			true
		;	delete_pack_installation_directory_command(OSPath, Options, Command),
			^^command(Command, pack_directory_clean_failed(Pack, Path))
		).

	delete_pack_installation_directory_command(Directory, Options, Command) :-
		(	operating_system_type(windows) ->
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['del /f /s /q "', Directory, '" && rmdir /s /q "',       Directory, '"'],       Command)
			;	atomic_list_concat(['del /f /s /q "', Directory, '" > nul && rmdir /s /q "', Directory, '" > nul'], Command)
			)
		;	% assume unix
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['rm -rvf "', Directory, '"'], Command)
			;	atomic_list_concat(['rm -rf "',  Directory, '"'], Command)
			)
		).

	make_pack_installation_directory(Pack, Path, OSPath) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, packs, Packs),
		path_concat(Packs, Pack, Path),
		internal_os_path(Path, OSPath),
		make_directory_path(Path).

	download_archive(Registry, Pack, URL, CheckSum, Options, Archive, IsGitArchive) :-
		pack_archive_path(Registry, Pack, URL, ArchivesPacksRegistryPack, Archive),
		make_directory_path(ArchivesPacksRegistryPack),
		(	file_exists(Archive),
			(	verify_checksum(Pack, Archive, CheckSum, Options) ->
				(	git_archive_url(URL, _, _) ->
					IsGitArchive = true
				;	IsGitArchive = false
				)
			;	% assume incomplete download or corrupted archive and try to download again
				delete_file(Archive),
				print_message(error, packs, pack_archive_discarded(Pack)),
				fail
			)
		;	atom_concat('file://', File, URL) ->
			internal_os_path(File, OSFile),
			(	operating_system_type(windows) ->
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['echo f | xcopy /y "', OSFile, '" "', Archive, '"'], Command)
				;	atomic_list_concat(['echo f | xcopy /y /q "', OSFile, '" "', Archive, '"'], Command)
				)
			;	% assume POSIX
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['cp -v "', OSFile, '" "', Archive, '"'], Command)
				;	atomic_list_concat(['cp "', OSFile, '" "', Archive, '"'], Command)
				)
			),
			^^command(Command, pack_archive_copy_failed(Pack, URL))
		;	git_archive_url(URL, Remote, Tag) ->
			^^option(git(GitExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['git archive ', GitExtraOptions, ' -v -o "', Archive, '" --remote="', Remote, '" ', Tag], Command)
			;	atomic_list_concat(['git archive ', GitExtraOptions, ' -o "',    Archive, '" --remote="', Remote, '" ', Tag], Command)
			),
			(	^^command(Command, pack_archive_download_failed(Pack, Command)) ->
				IsGitArchive = true
			;	% when the remote connection fails, git archive still creates an empty file
				file_exists(Archive),
				file_size(Archive, 0),
				delete_file(Archive),
				fail
			)
		;	^^option(downloader(curl), Options) ->
			^^option(curl(CurlExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['curl ', CurlExtraOptions, ' -f -v -L -o "',    Archive, '" "', URL, '"'], Command)
			;	atomic_list_concat(['curl ', CurlExtraOptions, ' -f -s -S -L -o "', Archive, '" "', URL, '"'], Command)
			),
			^^command(Command, pack_archive_download_failed(Pack, Command)),
			IsGitArchive = false
		;	% ^^option(downloader(wget), Options),
			^^option(wget(WgetExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['wget ', WgetExtraOptions, ' -v -O "', Archive, '" "', URL, '"'], Command)
			;	atomic_list_concat(['wget ', WgetExtraOptions, ' -q -O "', Archive, '" "', URL, '"'], Command)
			),
			^^command(Command, pack_archive_download_failed(Pack, Command)),
			IsGitArchive = false
		).

	pack_archive_path(Registry, Pack, URL, ArchivesPacksRegistryPack, Archive) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, packs, ArchivesPacks),
		path_concat(ArchivesPacks, Registry, ArchivesPacksRegistry),
		path_concat(ArchivesPacksRegistry, Pack, ArchivesPacksRegistryPack),
		decompose_file_name(URL, _, Basename),
		path_concat(ArchivesPacksRegistryPack, Basename, Archive0),
		internal_os_path(Archive0, Archive).

	git_archive_url(URL, Remote, Tag) :-
		decompose_file_name(URL, Remote0, Archive),
		sub_atom(Remote0, 0, _, _, 'git@'),
		sub_atom(Remote0, _, _, 0, '.git/'),
		sub_atom(Remote0, 0, _, 1, Remote),
		^^supported_archive(Extension),
		atom_concat(Tag, Extension, Archive),
		!.

	download_signature(Registry, Pack, URL, _, Options, Signature) :-
		^^logtalk_packs(LogtalkPacks),
		path_concat(LogtalkPacks, archives, Archives),
		path_concat(Archives, packs, ArchivesPacks),
		path_concat(ArchivesPacks, Registry, ArchivesPacksRegistry),
		path_concat(ArchivesPacksRegistry, Pack, ArchivesPacksRegistryPack),
		% prefer .asc signature files
		(	atom_concat(URL, '.asc', URLSig)
		;	atom_concat(URL, '.sig', URLSig)
		),
		decompose_file_name(URLSig, _, Basename),
		path_concat(ArchivesPacksRegistryPack, Basename, Signature0),
		internal_os_path(Signature0, Signature),
		(	file_exists(Signature) ->
			true
		;	atom_concat('file://', File, URLSig) ->
			file_exists(File),
			internal_os_path(File, OSFile),
			(	operating_system_type(windows) ->
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['echo f | xcopy /y "', OSFile, '" "', Signature, '"'], Command)
				;	atomic_list_concat(['echo f | xcopy /y /q "', OSFile, '" "', Signature, '"'], Command)
				)
			;	% assume POSIX
				(	^^option(verbose(true), Options) ->
					atomic_list_concat(['cp -v "', OSFile, '" "', Signature, '"'], Command)
				;	atomic_list_concat(['cp "', OSFile, '" "', Signature, '"'], Command)
				)
			),
			shell(Command)
		;	^^option(downloader(curl), Options) ->
			^^option(curl(CurlExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['curl ', CurlExtraOptions, ' -f -v -L -o "',    Signature, '" "', URLSig, '"'], Command)
			;	atomic_list_concat(['curl ', CurlExtraOptions, ' -f -s -S -L -o "', Signature, '" "', URLSig, '"'], Command)
			),
			shell(Command)
		;	% ^^option(downloader(wget), Options),
			^^option(wget(WgetExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['wget ', WgetExtraOptions, ' -v -O "', Signature, '" "', URLSig, '"'], Command)
			;	atomic_list_concat(['wget ', WgetExtraOptions, ' -q -O "', Signature, '" "', URLSig, '"'], Command)
			),
			shell(Command)
		),
		!.
	download_signature(_, Pack, _, Archive, _, _) :-
		print_message(error, packs, pack_signature_download_failed(Pack, Archive)).

	verify_checksum(Pack, Archive, CheckSum, Options) :-
		operating_system_type(OS),
		verify_checksum(OS, Pack, Archive, CheckSum, Options).

	verify_checksum(unix, Pack, Archive, sha256-CheckSum, Options) :-
		^^sha256sum_command(Sha256sum),
		(	^^option(verbose(true), Options) ->
			atomic_list_concat(['echo "', CheckSum, ' \"', Archive, '\"" | ', Sha256sum, ' --check'],          Command)
		;	atomic_list_concat(['echo "', CheckSum, ' \"', Archive, '\"" | ', Sha256sum, ' --check --status'], Command)
		),
		^^command(Command, pack_archive_checksum_failed(Pack, Archive)).
	verify_checksum(windows, Pack, Archive, sha256-CheckSum, Options) :-
		(	^^option(verbose(true), Options) ->
			atomic_list_concat(['certutil -v -hashfile "', Archive, '" SHA256 | find /v "hash" | find "', CheckSum, '" > nul'], Command)
		;	atomic_list_concat(['certutil -hashfile "',    Archive, '" SHA256 | find /v "hash" | find "', CheckSum, '" > nul'], Command)
		),
		^^command(Command, pack_archive_checksum_failed(Pack, Archive)).
	verify_checksum(unknown, Pack, Archive, sha256-CheckSum, Options) :-
		verify_checksum(unix, Pack, Archive, sha256-CheckSum, Options).

	verify_checksig(Pack, Archive, ArchiveSig, Options) :-
		^^option(gpg(GpgExtraOptions), Options),
		(	^^option(verbose(true), Options) ->
			atomic_list_concat(['gpg ', GpgExtraOptions, ' -v --verify "', ArchiveSig, '" "', Archive, '"'], Command)
		;	operating_system_type(windows) ->
			atomic_list_concat(['gpg ', GpgExtraOptions, ' -q --verify "',    ArchiveSig, '" "', Archive, '" > nul 2>&1'],       Command)
		;	atomic_list_concat(['gpg ', GpgExtraOptions, ' -q --verify "',    ArchiveSig, '" "', Archive, '" > /dev/null 2>&1'], Command)
		),
		^^command(Command, pack_archive_checksig_failed(Pack, Archive)).

	uncompress(Pack, Archive0, Path, Options, IsGitArchive) :-
		clean_pack_installation_directory(Pack, Path, Options, OSPath),
		make_directory_path(Path),
		^^tar_command(Tar),
		^^option(tar(TarExtraOptions), Options),
		(	IsGitArchive == true ->
			Strip = 0
		;	Strip = 1
		),
		(	decompose_file_name(Archive0, _, _, '.gpg') ->
			% gpg encrypted archive
			sub_atom(Archive0, 0, _, 4, Archive),
			^^option(gpg(GpgExtraOptions), Options),
			(	^^option(verbose(true), Options) ->
				atomic_list_concat(['gpg ', GpgExtraOptions, ' --output "', Archive, '" -v -d "', Archive0, '"'], DecryptCommand)
			;	operating_system_type(windows) ->
				atomic_list_concat(['gpg ', GpgExtraOptions, ' --output "', Archive, '" -q -d "', Archive0, '" > nul 2>&1'], DecryptCommand)
			;	atomic_list_concat(['gpg ', GpgExtraOptions, ' --output "', Archive, '" -q -d "', Archive0, '" > /dev/null 2>&1'], DecryptCommand)
			),
			^^command(DecryptCommand, pack_archive_decrypt_failed(Pack, Archive0))
		;	% assume non-encrypted archive
			Archive = Archive0
		),
		(	^^option(verbose(true), Options) ->
			atomic_list_concat([Tar, ' ', TarExtraOptions, ' -xvf "', Archive, '" --strip-components ', Strip, ' --directory "', OSPath, '"'], UncompressCommand)
		;	atomic_list_concat([Tar, ' ', TarExtraOptions, ' -xf "',  Archive, '" --strip-components ', Strip, ' --directory "', OSPath, '"'], UncompressCommand)
		),
		^^command(UncompressCommand, pack_archive_uncompress_failed(Pack, Archive)).

	% installed pack version data handling

	save_version(Path, Version) :-
		path_concat(Path, 'VERSION.packs', File),
		open(File, write, Stream),
		write_canonical(Stream, Version), write(Stream, '.\n'),
		close(Stream).

	read_version(Path, Version) :-
		path_concat(Path, 'VERSION.packs', File),
		file_exists(File),
		open(File, read, Stream),
		read(Stream, Version),
		close(Stream).

	% installed pack registry data handling

	save_registry(Path, Registry) :-
		path_concat(Path, 'REGISTRY.packs', File),
		open(File, write, Stream),
		writeq(Stream, Registry), write(Stream, '.\n'),
		close(Stream).

	read_registry(Path, Registry) :-
		path_concat(Path, 'REGISTRY.packs', File),
		file_exists(File),
		open(File, read, Stream),
		read(Stream, Registry),
		close(Stream).

	% Logtalk + Prolog backend identifier table

	backend(logtalk, 'Logtalk').
	backend(b,       'B-Prolog').
	backend(ciao,    'Ciao Prolog').
	backend(cx,      'CxProlog').
	backend(eclipse, 'ECLiPSe').
	backend(gnu,     'GNU Prolog').
	backend(ji,      'JIProlog').
	backend(xvm,     'XVM').
	backend(quintus, 'Quintus Prolog').
	backend(sicstus, 'SICStus Prolog').
	backend(swi,     'SWI-Prolog').
	backend(tau,     'Tau Prolog').
	backend(trealla, 'Trealla Prolog').
	backend(xsb,     'XSB').
	backend(yap,     'YAP').

	backends([], []).
	backends([Backend| Backends], [Name| Names]) :-
		backend(Backend, Name),
		backends(Backends, Names).

	% options handling

	default_option(verbose(false)).
	default_option(clean(false)).
	default_option(install(false)).
	default_option(update(false)).
	default_option(compatible(true)).
	default_option(status([stable, rc, beta, alpha])).
	% the restore/1-2 predicates use force(true) instead
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
	% internal option
	valid_option('$or'(Boolean)) :-
		valid(boolean, Boolean).

	% notes

	print_note(Action, Version, Pack) :-
		pack_object(Pack, PackObject),
		(	PackObject::note(Action, Version, Note) ->
			print_message(information, packs, note(Note))
		;	true
		).

:- end_object.
