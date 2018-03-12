-module(evserv).
-compile(export_all).

loop(State) ->
  receive
    {Pid, MsgRef, {subscribe, Client}} ->
      % ...
    {Pid, MsgRef, {add, Name, Description, TimeOut}} ->
      % ...
    {Pid, MsgRef, {cancel, Name}} ->
      % ...
    {done, Name} ->
      % ...
    {'DOWN', Ref, process, _Pid, _Reason} ->
      % ...
    code_change ->
      % ...
    Unknown ->
      io:format("Unknown message: ~p~n", [Unknown]),
      loop(State)
  end.
