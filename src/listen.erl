-module(listen).
-compile(export_all).

listen() ->
  receive
    {From, Message} ->
      io:format("received: ~p ~n",[Message]),
      From ! ok,
      listen();
    stop ->
      io:format("Process ended!")
  after 5000 ->
          io:format("Tell me something ~n"),
          listen()
  end.

stop(Pid) ->
  Pid ! stop,
  ok.

tell_me(Pid, Some) ->
  Pid ! {self(), Some},
  receive
    ok -> ok
  end,
  ok.

init() ->
  spawn(listen, listen, []).
