-module(twins).
-compile(export_all).

launch() ->
  spawn(twins, create, []),
  ok.

create() ->
  spawn_link(twins, zipi, [0]),
  timer:sleep(500),
  zape(0).

zipi(A) ->
  io:format("zipi - ~w~n", [A]),
  timer:sleep(1000),
  zipi(A+1).

zape(A) ->
  io:format("zape ~w~n", [A]),
  timer:sleep(1000),
  case A of
    A when A < 5 -> ok
  end,
  zape(A+1).
