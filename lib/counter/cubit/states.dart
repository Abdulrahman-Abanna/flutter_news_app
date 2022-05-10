
abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterMinusState extends CounterStates {
  final counter;

  CounterMinusState(this.counter);
}

class CounterPlusState extends CounterStates {
  final counter;

  CounterPlusState(this.counter);
}
