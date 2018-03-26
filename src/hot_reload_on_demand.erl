-module(hot_reload_on_demand).
-export([code_change/0]).

code_change() ->
  loop().

loop() ->
  receive
    update ->
      code:purge(?MODULE),
      code:load_file(?MODULE),
      ?MODULE:code_change();
    Any ->
      %% io:format("Original: ~p~n", [Any]),
      io:format("Original has change: ~p~n", [Any]),
      loop()
  end.

%% Steps to reproduce
%% 1> Pid = spawn(hot_reload, code_change, []).
%% <0.62.0>
%% 8> Pid ! "holase", ok.
%% Original:  "holase"
%% ok
%%
%% > erlang_project:master* λ erl -make
%% Recompile: src/hot_reload_on_demand
%%
%% 9> Pid ! update.
%% update
%% 10> Pid ! "Hello".
%% Original has change: "Hello"
%% "Hello"
