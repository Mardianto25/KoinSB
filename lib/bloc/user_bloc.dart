import 'package:flutter_base/model/content/login.dart';
import 'package:flutter_base/model/response/user_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Object with Validator {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject = BehaviorSubject<UserResponse>();
  
  getUser() async {
    UserResponse response = await _repository.getUser();
    _subject.sink.add(response);
  }


  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

}
final bloc = UserBloc();