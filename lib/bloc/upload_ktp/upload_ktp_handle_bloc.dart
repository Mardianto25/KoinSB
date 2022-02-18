import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_event.dart';
import 'package:flutter_base/bloc/upload_ktp/upload_ktp_state.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadKtpHandleBloc extends Bloc<UploadKtpEvent, UploadKtpState> {
  final UserRepository userRepository;

  UploadKtpHandleBloc({@required this.userRepository}): assert(userRepository != null);

  @override
  // TODO: implement initialState
  UploadKtpState get initialState => UploadKtpUninitialized();

  @override
  Stream<UploadKtpState> mapEventToState(UploadKtpEvent event) async* {
    if (event is UploadKtpStarted) {
    final bool hasEmail = await userRepository.hasEmail();

    if (hasEmail) {
        yield UploadKtpAuthenticated();
      } else {
        yield UploadKtpUnauthenticated();
      }
    }

    if (event is UploadKtpSuccess) {
      yield UploadKtpAuthLoading();
      yield UploadKtpAuthenticated();
    }

    if (event is UploadKtpError) {
      yield UploadKtpAuthLoading();
      yield UploadKtpUnauthenticated();
    }
  }
}
