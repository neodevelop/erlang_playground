-module(event).
-export([loop/1]).

loop(State) ->
  receive
    {Server, Ref, cancel} ->
      % ...
  after Delay
        % ...
  end.
