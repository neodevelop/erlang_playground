-module(linkmon).
-compile(export_all).

myproc() ->
  timer:sleep(5000),
  exit(reason).

chain(0) ->
  receive
    _ -> ok
  after 2000 ->
    exit("chain dies here")
 end;

chain(N) ->
  Pid = spawn(fun() -> chain(N-1) end),
  link(Pid),
  receive
    _ -> ok
  end.

start_critic() ->
  spawn(?MODULE, critic, []).

judge(Pid, Band, Album) ->
  Pid ! { self(), {Band, Album} },
  receive
    {Pid, Criticism} -> Criticism
  after 2000 ->
    timeout
  end.

critic() ->
  receive
    {From, {"Rage Against the Turing Machine", "Unit Testify"}} ->
      From ! { self(), "They are great!" };
    {From, {"System of a Downtime", "Memoize"}} ->
      From ! { self(), "That's ok!" };
    {From, {"Johnny Crash", "The token ring of fire"}} ->
      From ! { self(), "Simply incredible!" };
    {From, { _Band, _Album}} ->
      From ! { self(), "They sucks!" }
  end,
  critic().

start_critic2() ->
  spawn(?MODULE, restarter, []).

restarter() ->
  process_flag(trap_exit, true),
  % Pid = spawn_link(?MODULE, critic, []),
  Pid = spawn_link(?MODULE, critic2, []),
  register(critic, Pid),
  receive
    {'EXIT', Pid, normal} -> ok;
    {'EXIT', Pid, shutdown} -> ok;
    {'EXIT', Pid, _} -> restarter()
  end.

judge2(Band, Album) ->
  Ref = make_ref(),
  critic ! { self(), Ref, {Band, Album} },
  % critic ! { self(), {Band, Album} },
  % Pid = whereis(critic),
  receive
    {Ref, Criticism} -> Criticism
    % {Pid, Criticism} -> Criticism
  after 2000 ->
    timeout
  end.

critic2() ->
  receive
    {From, Ref, {"Rage Against the Turing Machine", "Unit Testify"}} ->
      From ! { Ref, "They are great!" };
    {From, Ref, {"System of a Downtime", "Memoize"}} ->
      From ! { Ref, "That's ok!" };
    {From, Ref, {"Johnny Crash", "The token ring of fire"}} ->
      From ! { Ref, "Simply incredible!" };
    {From, Ref, { _Band, _Album}} ->
      From ! { Ref, "They sucks!" }
  end,
  critic2().
