-module(sorting).
-export([mergesort/1]).

mergesort([]) -> [];
mergesort([H]) -> [H];
mergesort(L) ->
  {L1,L2} = split_for_mergesort(L),
  mix_for_mergesort(mergesort(L1), mergesort(L2)).

split_for_mergesort(L) ->
  lists:split(length(L) div 2, L).

mix_for_mergesort([], L) -> L;
mix_for_mergesort(L, []) -> L;
mix_for_mergesort([H1|T1], [H2|_]=L2) when H1 =< H2 ->
  [H1 | mix_for_mergesort(T1, L2)];
mix_for_mergesort(L1, [H2|T2]) ->
  [H2 | mix_for_mergesort(L1, T2)].


