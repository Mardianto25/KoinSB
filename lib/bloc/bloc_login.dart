
import 'package:flutter/material.dart';
import 'package:flutter_base/email.dart';
import 'package:flutter_base/login.dart';
import 'package:flutter_base/model/content/login.dart';
import 'package:flutter_base/model/response/login_response.dart';
import 'package:flutter_base/repository/user/user_repository.dart';
import 'package:flutter_base/util/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


class CreateBloc extends Object with Validator{
  BuildContext _context;
  final UserRepository _repository = UserRepository();

  final phone = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();
  final PublishSubject<LoginState> _loginStateSubject = new PublishSubject();

  LoginModel _loginResource = LoginModel();
  // Observable<LoginState> get loginStateStream => _loginStateSubject.stream;
  // Observable<bool> get loading => _loadingData.stream;
  Stream<String> get phoneController => phone.stream.transform(phoneValidator);
  Stream<String> get passwordController => password.stream.transform(passwordValidator);
  // Stream<bool> get submitValid => Observable.combineLatest2(phoneController, passwordController, (phoneController,passwordController) => true);
  Function(String) get updatePhone => phone.sink.add;
  Function(String) get updatePassword => password.sink.add;

  void changeLoginState({LoginState state } ) => _loginStateSubject.sink.add(state);

  loginSubmit(imei){
    _loginResource.phonenumber=phone.value;
    _loginResource.password=password.value;
    _loginResource.imei=imei.toString();
    _loadingData.sink.add(true);
    // _loginResource.publicId="6248fe24-2393-4aae-965a-6cf5fe1c5064";
    // login();
  }

  // login() async{
  //   // authBloc.openSession(token);
  //   changeLoginState(state: LoginState( status: LoginStatus.LOGGING, message: "logging", loadingRequest: true) );
    
  //   // waiting for login response!
  //   LoginResponse response = await _repository.login(_loginResource);
  //   print(response);  

  //   if(response.status!=200){
  //     _loadingData.sink.add(false);
  //     changeLoginState(state: LoginState(status: LoginStatus.LOGIN_ERROR,
  //         message: response.message, loadingRequest: false)
  //     );
  //     // and after 1.5 seconds we make the error message disappear from UI.
  //     // you can do this in UI layer too
  //     Future.delayed(Duration(milliseconds: 1500), (){
  //     _loadingData.sink.add(false);
        
  //       // you can pass null to state property, will make the same effect
  //       changeLoginState(state: LoginState(status: LoginStatus.NON_LOGIN, loadingRequest: false)); });
  //   }

  //   else {
  //     _loadingData.sink.add(false);
  //     Navigator.push(_context, MaterialPageRoute(
  //       builder: (_context) => Email()
  //     ));
  //     // authBloc.openSession(response.response.data);
  //     changeLoginState(state: LoginState(status:
  //     LoginStatus.LOGIN_SUCCESS, message: "Login Success", loadingRequest: false));
  //   }
  // }


  @override
  void dispose() {
    _loadingData.close();
    _loginStateSubject.close();
    phone.close();
    password.close();
  }

 

}

final blocCreate = CreateBloc();