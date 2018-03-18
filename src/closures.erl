-module(closures).
-compile([export_all]).

multiplicador(X) when is_integer(X) ->
  fun(Y) -> X * Y end.

enteros(Desde) ->
  fun() ->
    [Desde | enteros(Desde+1)]
  end.
