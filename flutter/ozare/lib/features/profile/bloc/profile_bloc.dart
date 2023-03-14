// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:authentication_repository/authentication_repository.dart'
    as auth;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozare_repository/ozare_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileRepository profileRepository,
    required auth.OzareRepository authRepository,
  })  : _profileRepository = profileRepository,
        _ozareRepository = authRepository,
        super(const ProfileState()) {
    oUser = OUser.fromJson(_ozareRepository.getLocalOwner()!);

    on<ProfilePageChanged>(_onProfilePageChanged);
    on<ProfileChanged>(_onProfileChanged);
    on<ProfileHistoryRequested>(_onProfileHistoryRequested);
    on<ProfileNotificationsRequested>(_onProfileNotificationsRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfilePhotoUploadRequested>(_onProfilePhotoUploadRequested);
    _oUserSubscription = _profileRepository
        .oUserStream(oUser.uid!)
        .listen((user) => add(ProfileChanged(oUser: oUser)));
  }

  final ProfileRepository _profileRepository;
  final auth.OzareRepository _ozareRepository;
  late OUser oUser;
  late StreamSubscription<OUser> _oUserSubscription;

  @override
  Future<void> close() {
    _oUserSubscription.cancel();
    return super.close();
  }

  /// EVENT HANDLERS
  /// [ProfilePageChanged] event handler
  void _onProfilePageChanged(
    ProfilePageChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(page: event.page));
  }

  /// [ProfileChanged] event handler
  void _onProfileChanged(
    ProfileChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(user: event.oUser, status: ProfileStatus.loaded));
  }

  /// [ProfileHistoryRequested] event handler
  Future<void> _onProfileHistoryRequested(
    ProfileHistoryRequested event,
    Emitter<ProfileState> emit,
  ) async {
    /// listen to history stream
    await emit.forEach(
      _profileRepository.historyStream(oUser.uid!),
      onData: (history) => state.copyWith(history: history),
    );
  }

  /// [ProfileNotificationsRequested] event handler
  Future<void> _onProfileNotificationsRequested(
    ProfileNotificationsRequested event,
    Emitter<ProfileState> emit,
  ) async {
    /// listen to notifications stream
    await emit.forEach(
      _profileRepository.notificationStream(oUser.uid!),
      onData: (notifications) => state.copyWith(notifications: notifications),
    );
  }

  /// [ProfileUpdated] event handler
  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await _profileRepository.updateProfile(event.oUser);
    add(const ProfilePageChanged(ProfileRoutes.profile));
  }

  /// [ProfilePhotoUploadRequested] event handler
  /// Upload the user's profile photo
  /// and update the user's profile
  /// with the new photo url
  Future<void> _onProfilePhotoUploadRequested(
    ProfilePhotoUploadRequested event,
    Emitter<ProfileState> emit,
) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final photoUrl = await _profileRepository.uploadPhoto(
      state.user.uid!,
      event.imageFile,
    );

    final oUser = state.user.copyWith(photoURL: photoUrl);

    await _profileRepository.updateProfile(oUser);
    emit(state.copyWith(user: oUser, status: ProfileStatus.loaded));
  }
}
