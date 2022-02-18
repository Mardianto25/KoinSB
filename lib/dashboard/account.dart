import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/auth/auth_bloc.dart';
import 'package:flutter_base/bloc/auth/auth_event.dart';
import 'package:flutter_base/dashboard/change_password.dart';
import 'package:flutter_base/dashboard/change_profile.dart';
import 'package:flutter_base/dashboard/menu_webview.dart';
import 'package:flutter_base/style/custom_roundrec_button.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Akun",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
              Container(
                child: SvgPicture.asset(
                  "assets/svg/ic-notification.svg",
                ),
              )
            ],
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _userDataSection(),
              _ProfilSection(),
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
        ));
  }

  Widget _userDataSection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Nama Lengkap User",
                        style: CustomText.medium16White,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        "0857123456",
                        style: CustomText.regular12White,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        "email@email.co.id",
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
                      "0000000000000000",
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

  Widget _ProfilSection() {
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
                    MaterialPageRoute(builder: (context) => ChangeProfile()));
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
                    MaterialPageRoute(builder: (context) => ChangePassword()));
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
