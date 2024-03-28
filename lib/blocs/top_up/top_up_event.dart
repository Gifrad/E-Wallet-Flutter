part of 'top_up_bloc.dart';

abstract class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object> get props => [];
}

class TopupPost extends TopUpEvent {
  final TopupFormModel data;
  const TopupPost(this.data);

  @override
  List<Object> get props => [data];
}
