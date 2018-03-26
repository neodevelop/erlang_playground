-module(hot_reload).
-export([code_change/0, init/0]).

init() ->
  loop().

code_change() ->
  loop().

loop() ->
  receive
    %% Any -> io:format("Original:  ~p~n", [Any])
    Any -> io:format("Original has changed:  ~p~n", [Any])
  end,
  hot_reload:code_change().

%% Steps to reproduce
%% 1> Pid = spawn(hot_reload, code_change, []).
%% <0.62.0>
%% 8> Pid ! "holase", ok.
%% Original:  "holase"
%% ok
%% 9> c(hot_reload).
%% Recompiling /Users/makingdevs/Desktop/erlang_project/src/hot_reload.erl
%% {ok,hot_reload}
%% 10> Pid ! "holase", ok.
%% Original:  "holase"
%% ok
%% 11> Pid ! "holases", ok.
%% Original has changed:  "holases"
%% ok
