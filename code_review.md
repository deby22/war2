## Uwagi do kodui

* [ ] Poprawa testów (fixtury) książka OTP strony 90-92
* [x] 1 "spade" - to nie jest prawidłowa karta
* [ ] brakuje @spec 0 na wysokopoziomowych modułach musi być
* [x] round/bet wrzucić do game [bet bym zostawił, ale round faktycznie]
* [x] validate_color_croupier / validate_player_croupier - bez sensu. Lepiej jako funkcja z parametrami
* [x] "suit-player": bet."suit-player" == player_card.suit - brzydkie - poprawiłem, ale teraz chyba overkill. Brzydki był string jako atom, czy sposób sprawdzenia?
* [x] try/rescue w bets - do wywalenia. 
* [x] card ogólnie OK, ale "ammount" powinien mieć default
* [x] round "play" bez sensu lepiej w jednej metodzie z parametrami
* [ ] budowanie kart - bardziej DDD. SUITS*RANKS (coś jak w Domain Modeling Made Functional)
* [x] Czy "color" jest potrzebny w karcie? -> tak. Jawne określenie co zawiera karta
* [ ] W DDD lepiej nie używać prymitywów. Czy tu nie będzie to overkil?
* [ ] Moduledoc i moduledoc false jeśli nie trzeba
* [ ] Typeparams
* [ ] Dializer na projekcie
* [ ] defimpl Inspect jako result bet (czytelniejsza forma) - https://github.com/blackode/elixir-tips/blob/master/part9.md#9-re-designing-custom-data-type-inspection-across-the-app


## Uwagi nowej implementacji
* Nie wiem czy nie przekombinowałem walidacji
* Wydaje mi się, że summary jest teraz bardziej skomplikowane - trochę overkill?