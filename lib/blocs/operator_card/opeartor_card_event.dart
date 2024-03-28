part of 'opeartor_card_bloc.dart';

abstract class OpeartorCardEvent extends Equatable {
  const OpeartorCardEvent();

  @override
  List<Object> get props => [];
}

class OperatorCardGet extends OpeartorCardEvent{}
