-module(sorting).
-export([mergesort/1]).

mergesort([]) -> [];
mergesort([H]) -> [H];
mergesort(L) ->
  {L1,L2} = split_list(L),
  mix(mergesort(L1), mergesort(L2)).

split_list(L) ->
  lists:split(length(L) div 2, L).

mix([], L) -> L;
mix(L, []) -> L;
mix([H1|T1], [H2|_]=L2) when H1 =< H2 ->
  [H1 | mix(T1, L2)];
mix(L1, [H2|T2]) ->
  [H2 | mix(L1, T2)].
