import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(0));

  void setTab(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return emit(const HomeState(0));
      case 1:
        return emit(const HomeState(1));
      case 2:
        return emit(const HomeState(2));
      case 3:
        return emit(const HomeState(3));
    }
  }

  void enableHide() {
    emit(HomeState(state.tabIndex, hide: true));
  }

  void disableHide() {
    emit(HomeState(state.tabIndex, hide: false));
  }
}
