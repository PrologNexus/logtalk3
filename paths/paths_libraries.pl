%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Default standard library paths
%  Last updated on May 27, 2025
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


% logtalk_library_path(Library, Path)
%
% paths must always end with a "/"

:- multifile(logtalk_library_path/2).
:- dynamic(logtalk_library_path/2).

% libraries

logtalk_library_path(library, logtalk_user('library/')).

logtalk_library_path(arbitrary, library('arbitrary/')).
logtalk_library_path(assignvars, library('assignvars/')).
logtalk_library_path(base64, library('base64/')).
logtalk_library_path(basic_types, library('basic_types/')).
logtalk_library_path(coroutining, library('coroutining/')).
logtalk_library_path(cbor, library('cbor/')).
logtalk_library_path(csv, library('csv/')).
logtalk_library_path(dates, library('dates/')).
logtalk_library_path(dependents, library('dependents/')).
logtalk_library_path(dictionaries, library('dictionaries/')).
logtalk_library_path(dif, library('dif/')).
logtalk_library_path(edcg, library('edcg/')).
logtalk_library_path(events, library('events/')).
logtalk_library_path(expand_library_alias_paths, library('expand_library_alias_paths/')).
logtalk_library_path(expecteds, library('expecteds/')).
logtalk_library_path(format, library('format/')).
logtalk_library_path(gensym, library('gensym/')).
logtalk_library_path(genint, library('genint/')).
logtalk_library_path(git, library('git/')).
logtalk_library_path(grammars, library('grammars/')).
logtalk_library_path(heaps, library('heaps/')).
logtalk_library_path(hierarchies, library('hierarchies/')).
logtalk_library_path(hook_flows, library('hook_flows/')).
logtalk_library_path(hook_objects, library('hook_objects/')).
logtalk_library_path(html, library('html/')).
logtalk_library_path(ids, library('ids/')).
logtalk_library_path(intervals, library('intervals/')).
logtalk_library_path(java, library('java/')).
logtalk_library_path(json, library('json/')).
logtalk_library_path(json_lines, library('json_lines/')).
logtalk_library_path(listing, library('listing/')).
logtalk_library_path(logging, library('logging/')).
logtalk_library_path(loops, library('loops/')).
logtalk_library_path(meta, library('meta/')).
logtalk_library_path(meta_compiler, library('meta_compiler/')).
logtalk_library_path(mutations, library('mutations/')).
logtalk_library_path(nested_dictionaries, library('nested_dictionaries/')).
logtalk_library_path(optionals, library('optionals/')).
logtalk_library_path(options, library('options/')).
logtalk_library_path(os, library('os/')).
logtalk_library_path(queues, library('queues/')).
logtalk_library_path(random, library('random/')).
logtalk_library_path(reader, library('reader/')).
logtalk_library_path(recorded_database, library('recorded_database/')).
logtalk_library_path(redis, library('redis/')).
logtalk_library_path(sets, library('sets/')).
logtalk_library_path(statistics, library('statistics/')).
logtalk_library_path(term_io, library('term_io/')).
logtalk_library_path(timeout, library('timeout/')).
logtalk_library_path(tsv, library('tsv/')).
logtalk_library_path(types, library('types/')).
logtalk_library_path(ulid, library('ulid/')).
logtalk_library_path(union_find, library('union_find/')).
logtalk_library_path(uuid, library('uuid/')).
logtalk_library_path(zippers, library('zippers/')).
