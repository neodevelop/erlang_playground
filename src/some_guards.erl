-module(some_guards).
-export([area/2, area/3]).

area(cuadrado, Base) when is_number(Base) ->
  Base * Base;
area(circulo, Radio) when is_number(Radio) ->
  math:pi() * Radio * Radio.

area(rectangulo, Base, Altura)
  when is_number(Base), is_number(Altura) ->
    Base * Altura;
area(triangulo, Base, Altura)
  when is_number(Base), is_number(Altura) ->
    Base * Altura / 2.

