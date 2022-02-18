import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/bloc/get_foto_profile/get_foto_profile_bloc.dart';
import 'package:flutter_base/bloc/get_foto_profile/get_foto_profile_event.dart';
import 'package:flutter_base/bloc/profile/profile_bloc.dart';
import 'package:flutter_base/bloc/profile/profile_event.dart';
import 'package:flutter_base/bloc/profile/profile_state.dart';

import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/change_profile.dart';
import 'package:flutter_base/dashboard/main.dart';
import 'package:flutter_base/dashboard/menu_webview.dart';
import 'package:flutter_base/model/response/profile.dart';
import 'package:flutter_base/model/response/spesimen_response.dart';

import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/change_password/change_password_page.dart';
import 'package:flutter_base/ui_bloc/change_profile/change_profile_page.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProfileForm extends StatefulWidget {
  // String noac;
  // List<DataSimulasi> list ;

  // ProfileForm({Key key, @required this.noac, @required this.list}) : super(key: key);
  

  @override
  State<StatefulWidget> createState() {
    return _ProfileFormState();
  }
}

class _ProfileFormState extends State<ProfileForm> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  var passKey = GlobalKey<FormFieldState>();
  final formKey = new GlobalKey<FormState>();
  bool passwordVisible = true, _loading = false;
  ResponseProfile list ;
  String _response;
  ResponseData _resFoto;
  
  
  @override
  void initState() {
    super.initState();
    _onSubmited();
  }
  
  _onSubmited() {
    BlocProvider.of<ProfileBloc>(context).add(
      ProfileButtonPressed(
               
      ),
    );
  }

  _getProfile() {
    BlocProvider.of<GetFotoProfileBloc>(context).add(
      GetFotoProfileButtonPressed(
        status: ""
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
      },
      child:BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) { 
          if (state is ProfileLoading){
          // success2();
            return LoadingIndicator();
          }
          if (state is ProfileFailure) {
            // setState(() {
                _response = state.profile.response.respCode; 
                return  _page("");            
                            
                _loading = true;
                print(_response);
                if (_response == "04"){
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_){
                        return LoginMain();
                        }
                    )
                  );
                }
            // });
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );       
            
          }
          if (state is ProfileInitial) {
            // setState(() {
              list = state.profile.response;
              _resFoto = state.foto.response;
              if(_resFoto.data == null){
                String _base64 ="";
                Uint8List bytes = base64.decode(_base64);
                print(bytes);
                return  _page(bytes);
                
              }else{
                String _base64;
                _base64 = _resFoto.data.image;
                Uint8List bytes = base64.decode(_base64.replaceAll("data:image/png;base64, ", "")); 
                _loading = true;            
              // });
                return  _page(bytes);
              }
              
          }
          
        }
      )
    );
  }

  Widget _page(image){
    return 
      SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userDataSection(image),
          _profilSection(image),
          _SecuritySection(),
          _AboutSection(),
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 25, right: 16, left: 16),
            width: double.infinity,
            color: Colors.white,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  side: BorderSide(color: Color(0xffff2310))),
              onPressed: () async{
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => LoginMain()
                ));
                
              },
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text("keluar".toUpperCase(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffff2310),
                        fontFamily: 'NeoSansW1GMedium')),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userDataSection(image) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _resFoto.data == null ? Container(
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Colors.white,
                ) 
              ): 
              Container(
                  width: 80,
                  height: 80,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new MemoryImage(
                              image)
                      )
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        list.data.name == null ? "Nama Lengkap User" : list.data.name,
                        style: CustomText.medium16White,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        list.data.phonenumber == null ? "0857123456" : list.data.phonenumber,
                        style: CustomText.regular12White,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        list.data.email == null ? "email@email.co.id": list.data.email,
                        style: CustomText.regular12White,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            color: Colors.white,
            height: 0.5,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Nomor e-KTP",
                  style: CustomText.medium12White,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      list.data.ktp == null ? "0000000000000000" : list.data.ktp,
                      style: CustomText.medium12White,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profilSection(_image) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Profil",
            style: CustomText.medium16,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-profile.svg"),
              title: new Text(
                "Ubah Profil",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeProfilePage(email: list.data.email, name: list.data.name, image: _image,)));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-referral.svg"),
              title: new Text(
                "Kode Referral",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {},
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _SecuritySection() {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Keamanan",
            style: CustomText.medium16,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-password.svg"),
              title: new Text(
                "Ubah Password",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePasswordPage()));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-pin.svg"),
              title: new Text(
                "Ubah Pin Transaksi KOIN",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuWebView(
                            url: "https://www.google.com",
                            title: "Ubah Pin Transaksi KOIN")));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-pin.svg"),
              title: new Text(
                "Lupa Pin Transaksi KOIN",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuWebView(
                            url: "https://www.google.com",
                            title: "Lupa Pin Transaksi KOIN")));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _AboutSection() {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tentang",
            style: CustomText.medium16,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-help.svg"),
              title: new Text(
                "Bantuan",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuWebView(
                            url: "https://www.google.com", title: "Bantuan")));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-privacy.svg"),
              title: new Text(
                "Ketentuan Layanan & Kebijakan Privasi",
                style: CustomText.regular14,
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuWebView(
                            url: "https://www.google.com",
                            title: "Ketentuan Layanan & Kebijakan Privasi")));
              },
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              leading: new SvgPicture.asset("assets/svg/ic-rate.svg"),
              title: new Text(
                "Beri Kami Nilai",
                style: CustomText.regular14,
              ),
              trailing: Text(
                "Versi 2.0.0",
                style: CustomText.regular12Grey,
              ),
              onTap: () {},
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  
}
