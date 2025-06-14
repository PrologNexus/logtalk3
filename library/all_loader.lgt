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


:- initialization(
	logtalk_load([
		types(loader),
		arbitrary(loader),
		os(loader),
		dates(loader),
		events(loader),
		dependents(loader),
		dictionaries(loader),
		nested_dictionaries(loader),
		heaps(loader),
		queues(loader),
		sets(loader),
		hierarchies(loader),
		meta(loader),
		loops(loader),
		random(loader),
		statistics(loader),
		ids(loader),
		intervals(loader),
		logging(loader),
		meta_compiler(loader),
		assignvars(loader),
		hook_flows(loader),
		hook_objects(loader),
		java(loader),
		redis(loader),
		recorded_database(loader),
		optionals(loader),
		options(loader),
		expecteds(loader),
		expand_library_alias_paths(loader),
		edcg(loader),
		dif(loader),
		coroutining(loader),
		zippers(loader),
		reader(loader),
		term_io(loader),
		timeout(loader),
		gensym(loader),
		genint(loader),
		git(loader),
		grammars(loader),
		csv(loader),
		tsv(loader),
		json(loader),
		json_lines(loader),
		cbor(loader),
		base64(loader),
		ulid(loader),
		uuid(loader),
		html(loader),
		format(loader),
		union_find(loader),
		mutations(loader),
		listing(loader),
		cloning,
		counters,
		streamvars
	], [
		optimize(on)
	])
).
