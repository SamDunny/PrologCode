sigma(['0','1']).

%q0, initial state (at 0 index is start)

% delta: (Q x Sigma)-> Q
delta(Delta) :- Delta =
    [ [t('0',0),t('1',0),t('1',1)],
      [] ].

accept(Accepting) :- Accepting=[1].


