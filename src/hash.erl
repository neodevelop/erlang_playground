-module(hash).
-export([init/1, get/2, set/3]).

get(Pid, Key) ->
  Pid ! {get, self(), Key},
  receive
    Any -> Any
  end.

set(Pid, Key, Value) ->
  Pid ! {set, Key, Value},
  ok.

%% Init with node
init(Node) ->
  io:format("Started... ~n"),
  spawn(Node, fun() ->
      loop([{"hi", "hello"}, {"bye", "cya"}])
  end).

loop(Data) ->
  receive
    {get, From, Key} ->
      Val = proplists:get_value(Key, Data),
      From ! Val,
      loop(Data);
    {set, Key, Value} ->
      loop([{Key, Value} | Data]);
    stop ->
      ok
  end.

%% (node1@MBP-MakingDevs)6> c("src/hash").
%% {ok,hash}
%% (node1@MBP-MakingDevs)9> hash:init('node2@MBP-MakingDevs').
%% Started...
%% <7684.82.0>
%% (node1@MBP-MakingDevs)10> Pid = hash:init('node2@MBP-MakingDevs').
%% Started...
%% <7684.83.0>
%% (node1@MBP-MakingDevs)11> hash:get(Pid, "hi").
%% "hello"
%% (node1@MBP-MakingDevs)12> hash:set(Pid, "remote", "working").
%% ok
%% (node1@MBP-MakingDevs)13> node(Pid).
%% 'node2@MBP-MakingDevs'
