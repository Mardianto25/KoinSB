import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/bloc/get_status/general_get_bloc.dart';
import 'package:flutter_base/bloc/get_status/general_get_event.dart';
import 'package:flutter_base/bloc/get_status/general_get_state.dart';

import 'package:flutter_base/bloc/show_data/show_data_state.dart';
import 'package:flutter_base/model/response/show.dart';
import 'package:flutter_base/resource/strings.dart';
import 'package:flutter_base/ui/login_indicator.dart';
import 'package:flutter_base/ui_bloc/address_data/address_data_page.dart';
import 'package:flutter_base/ui_bloc/email_otp/email_page.dart';
import 'package:flutter_base/ui_bloc/job_data/job_data_page.dart';
import 'package:flutter_base/ui_bloc/login/login_page.dart';
import 'package:flutter_base/ui_bloc/member_data_save/member_data_save_page.dart';
import 'package:flutter_base/ui_bloc/personal_data/personal_data_page.dart';
import 'package:flutter_base/ui_bloc/phone_otp/phone_otp_page.dart';
import 'package:flutter_base/ui_bloc/set_password/set_password_page.dart';
import 'package:flutter_base/welcome.dart';
import 'package:flutter_base/widget/custom_registration_button.dart';
import 'package:flutter_base/widget/intro_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OnboardingForm extends StatefulWidget {
  @override
  _OnboardingFormState createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  CekStatusBloc _getDataAll;
  double screenWidth = 0.0;
  double screenheight = 0.0;

  int currentPageValue = 0;
  int previousPageValue = 0;
  PageController controller;
  double _moveBar = 0.0;
  bool _visible = false;

  ShowData list;

  @override
  void initState() {
    // TODO: implement initState
    getLast();    
    _getDataAll = BlocProvider.of<CekStatusBloc>(context);
    _getData();
    super.initState();
    controller = PageController(initialPage: currentPageValue);
    
  }

  _getData() {
    BlocProvider.of<CekStatusBloc>(context).add(
      CekStatusButtonPressed(
        status: ""
      )
    );
  }

  void getLast() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _last = prefs.getString('last');
    if (_last.isNotEmpty || _last != null){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage()
      ));
    }
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');

    if (previousPageValue == 0) {
      previousPageValue = page;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < page) {
        previousPageValue = page;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = page;
        _moveBar = _moveBar - 0.14;
      }
    }

    setState(() {
      currentPageValue = page;
      if(currentPageValue == 2)
        _visible = true;
      else
        _visible = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    final List<Widget> introWidgetsList = <Widget>[
      IntroWidget(
          image: 'assets/svg/ic-onboard-1.svg',
          subText: "Semakin mudah melakukan transfer antar anggota, pembelian pulsa & paket data hingga pembayaran tagihan",
          title: Strings.onboarding1),
      IntroWidget(
          image: 'assets/svg/ic-onboard-2.svg',
          subText: "Manfaatkan produk simpanan & pinjaman dengan jasa dan manfaat terbaik untuk Anggota KSP Sejahtera Bersama",
          title: Strings.onboarding2),
      IntroWidget(
          image: 'assets/svg/ic-onboard-3.svg',
          subText: "Sebuah kemajuan di dunia perkoperasian Indonesia, semua layanan koperasi ditawarkan secara digital kepada masyarakat Indonesia",
          title: Strings.onboarding3),

    ];
    return BlocListener<CekStatusBloc, CekStatusState>(
      listener: (context, state) {
        if (state is PostDataFailure) {
          
        }
        if (state is PostDataInitial) {
          
        }
       
      },
        
    child:
      BlocBuilder<CekStatusBloc, CekStatusState>(
        bloc: _getDataAll,
        builder: (context, state) {
          if (state is CekStatusLoading){
            return LoadingIndicator();
          }
          if (state is CekStatusInitial){
              if(state.status.response.data.proses == "verifikasi_ktp"){
                return EmailPage();
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (_) {
                //           return EmailPage();
                //         }
                        
                //     )
                //   );
              }
              if(state.status.response.data.proses == "verifikasi_email"){
                return PhoneOtpPage();
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (_) {
                //           return PhoneOtpPage();
                //         }
                        
                //     )
                //   );
              }

              if(state.status.response.data.proses == "verifikasi_phonenumber"){
                return SetPasswordPage();
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (_) {
                //           return SetPasswordPage();
                //         }
                //     )
                //   );
              }
          }
          
          if(state is CekStatusFailure){
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 12,
                    child: Container(
                      child:
                        Container(
                          child: Stack(
                            children: <Widget>[
                              PageView.builder(
                                physics: ClampingScrollPhysics(),
                                itemCount: introWidgetsList.length,
                                onPageChanged: (int page) {
                                  getChangedPageAndMoveBar(page);
                                },
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return introWidgetsList[index];
                                },
                              ),

                            ],
                          )
                        )
                    ),
                  ),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 35),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < introWidgetsList.length; i++)
                                if (i == currentPageValue) ...[circleBar(true)] else
                                  circleBar(false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
//                            Navigator.of(context).pushReplacement(
//                                SlideRightRoute(
//                                    page: Welcome()
//                                )
//                            );
                          setState(() {
                            currentPageValue = 2;
                            _visible = true;
                          });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "LEWATI",
                              style: CustomText.bold12Primary
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (_visible)?false:true,
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  if(currentPageValue < introWidgetsList.length-1){
                                    setState(() {
                                      currentPageValue = currentPageValue + 1;
                                    });
                                    controller.jumpToPage(currentPageValue);
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Welcome()
                                        )
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(bottom: 48, right: 26),
                                  decoration: BoxDecoration(
                                      color: Color(0xffe6c125),
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                  ),
                                  child: Image.asset(
                                    "assets/images/right_arrow.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              )
                          ),
                        ),
                        Visibility(
                          visible: _visible,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Welcome()
                                  )
                              );
                            },
                            child:
                            Container(
                              height: 75,
                              margin: EdgeInsets.only(bottom: 32),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: CustomRegistrationButton("MULAI", true),
                            ),
                          )
                        )
                      ],
                    )
                ],
              ),
            );
          }
        }
        
      ) 
    );
  }
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,

      decoration: BoxDecoration(
          color: isActive ? Color(0xff096d5c) : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

}
