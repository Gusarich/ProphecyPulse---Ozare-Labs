part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class BasketLeaguesRequested extends BasketEvent {
  const BasketLeaguesRequested({required this.isNew});
  final bool isNew;

  @override
  List<Object> get props => [isNew];
}

class BasketToggleLive extends BasketEvent {
  const BasketToggleLive();

  @override
  List<Object> get props => [];
}
