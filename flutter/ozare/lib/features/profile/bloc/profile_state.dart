part of 'profile_bloc.dart';

enum ProfileStatus { loading, loaded, failure }

enum ProfileRoutes {
  profile,
  settings,
  editAccount,
  notifications,
  wallet,
  selectLanguage,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.loading,
    this.page = ProfileRoutes.profile,
    this.user = const OUser(uid: null, email: '', firstName: '', lastName: ''),
    this.message = '',
    this.history = const [],
    this.notifications = const [],
  });

  final ProfileStatus status;
  final ProfileRoutes page;
  final OUser user;
  final String message;
  final List<Bet> history;
  final List<Bet> notifications;

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileRoutes? page,
    OUser? user,
    String? message,
    List<Bet>? history,
    List<Bet>? notifications,
  }) {
    return ProfileState(
      status: status ?? this.status,
      page: page ?? this.page,
      user: user ?? this.user,
      message: message ?? this.message,
      history: history ?? this.history,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props =>
      [status, page, message, history, notifications, user];
}
