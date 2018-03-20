-module(twins).
-compile(export_all).

launch() ->
  LauncherPid = launcher:init(),
  Zipi = spawn(twins, zipi, [0]),
  launcher:add(LauncherPid, Zipi),
  timer:sleep(500),
  Zape = spawn(twins, zape, [0]),
  launcher:add(LauncherPid, Zape),
  LauncherPid.

zipi(A) ->
  io:format("zipi - ~w~n", [A]),
  timer:sleep(1000),
  zipi(A+1).

zape(A) ->
  io:format("zape ~w~n", [A]),
  timer:sleep(1000),
  zape(A+1).
