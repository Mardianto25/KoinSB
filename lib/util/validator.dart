import 'dart:async';

class Validator{
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String validateByLenght(String value, int length) {
    if (value.length < length)
      return 'Name must be more than $length charater';
    else
      return null;
  }

  static String validate(String value) {
    if (value.length < 3)
      return 'tidak boleh kosong';
    else
      return null;
  }

  static String validateEktp(String value) {
    if (value.length < 16)
      return 'Number must be more than 16 charater';
    else
      return null;
  }

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp _phone = RegExp(
    r'^(?:[+0]9)?[0-9]{10,13}$',
  );

  static final RegExp _ktp = RegExp(
    r'^(?:[+0]9)?[0-9]{16}$',
  );

  static final RegExp _string = RegExp(
    r'^([^a-z\s])|((^|\s)[a-z]{1,50}(\s|$))',
  );


  static isPhone(String phone){
    return _phone.hasMatch(phone);
  }
  static isKtp(String ktp){
    return _ktp.hasMatch(ktp);
  } 
  static isString(String string){
    return _string.hasMatch(string);
  }
  static isUsername(String username){
    return _phone.hasMatch(username);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static String validatePhoneNumber(String value) {
    if (value.length > 13 || value.length < 10)
      return 'Number must be more than 13 and less than 10 charater';
    else
      return null;
  }

  static String validatePassword(String value) {
    if (value.length < 8 )
      return 'password must be more than 8 ';
    else
      return null;
  }

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      if(email.contains("@")){
        sink.add(email);
      }else{
        sink.addError("Email is not valid");
      }
    }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length >2){
        sink.add(password);
      }else{
        sink.addError("Password length should be greater than 2 chars.");
      }
    }
  );

  var phoneValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (phone,sink){
      if(phone.length>4){
        sink.add(phone);
      }else{
        sink.addError("Number must be more than 13 and less than 10 charater");
      }
    }
  );
}