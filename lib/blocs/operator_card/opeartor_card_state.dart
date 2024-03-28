part of 'opeartor_card_bloc.dart';

abstract class OpeartorCardState extends Equatable {
  const OpeartorCardState();

  @override
  List<Object> get props => [];
}

class OpeartorCardInitial extends OpeartorCardState {}

class OpeartorCardLoading extends OpeartorCardState {}

class OpeartorCardFailed extends OpeartorCardState {
  final String e;
  const OpeartorCardFailed(this.e);

  @override
  List<Object> get props => [e];
}

class OpeartorCardSuccess extends OpeartorCardState {
  final List<OperatorCardModel> operatorCard;
  const OpeartorCardSuccess(this.operatorCard);

  @override
  List<Object> get props => [operatorCard];
}
