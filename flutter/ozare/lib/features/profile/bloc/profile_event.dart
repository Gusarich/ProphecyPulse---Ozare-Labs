part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileChanged extends ProfileEvent {
  const ProfileChanged({required this.oUser});
  final OUser oUser;
  @override
  List<Object> get props => [oUser];
}

class ProfilePageChanged extends ProfileEvent {
  const ProfilePageChanged(this.page);
  final ProfileRoutes page;
  @override
  List<Object> get props => [page];
}

class ProfileHistoryRequested extends ProfileEvent {
  const ProfileHistoryRequested();
  @override
  List<Object> get props => [];
}

class ProfileNotificationsRequested extends ProfileEvent {
  const ProfileNotificationsRequested();
  @override
  List<Object> get props => [];
}

class ProfileUpdateRequested extends ProfileEvent {
  const ProfileUpdateRequested(this.oUser);
  final OUser oUser;
  @override
  List<Object> get props => [oUser];
}

class ProfilePhotoUploadRequested extends ProfileEvent {
  const ProfilePhotoUploadRequested(this.imageFile);
  final XFile imageFile;
  @override
  List<Object> get props => [imageFile];
}
