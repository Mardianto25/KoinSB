import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/dashboard/account.dart';
import 'package:flutter_base/dashboard/explore_product.dart';
import 'package:flutter_base/dashboard/help.dart';
import 'package:flutter_base/dashboard/home.dart';
import 'package:flutter_base/style/custom_text.dart';
import 'package:flutter_base/ui_bloc/home/home_page.dart';
import 'package:flutter_base/ui_bloc/login/login_main.dart';
import 'package:flutter_base/ui_bloc/profile/profile_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
void main() => runApp(new MaterialApp(home: new Main()));

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Main> {
  int _currentIndex = 0;
  static const snackBarDuration = Duration(seconds: 3);
  DateTime backButtonPressTime;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  choosePage() {
    switch (_currentIndex) {
      case 0:
        return new HomePage();
        break;

      case 1:
        return new ExploreProduct();
        break;

      case 2:
        return new Help();
        break;

      case 3:
        return new ProfilePage();
        break;
//
//      default:
//        return new Login();
//        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff068675));
    return WillPopScope(
      onWillPop: onWillPop,
      child: new MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => HomePage(),
        //   '/exp': (context) => ExploreProduct(),
        //   '/help': (context) => Help(),
        //   '/profile': (context) => ProfilePage(),
          
        // },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(title: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            primaryColor: Color(0xff27a08b),
            accentColor: Colors.teal,
            primarySwatch: Colors.teal,
            fontFamily: 'NeoSansW1g'),
        home: WillPopScope(
          onWillPop: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: Scaffold(
            body: choosePage(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              // this will be set when a new tab is tapped
              onTap: onTabTapped,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                BottomNavigationBarItem(
                  icon: new SvgPicture.asset("assets/svg/ic-dashboard-inactive.svg"),
                  activeIcon: new SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-dashboard-active.svg"),
                  title: new Text('Home', style: CustomText.regular12,),
                ),
                BottomNavigationBarItem(
                  icon: new SvgPicture.asset("assets/svg/ic-saving-inactive.svg"),
                  activeIcon: new SvgPicture.asset("assets/svg/jelajah-produk/pinjaman/ic-saving-active.svg"),
                  title: new Text('Jelajah produk', style: CustomText.regular12),
                ),
                BottomNavigationBarItem(
                  icon: new SvgPicture.asset("assets/svg/ic-help-inactive.svg"),
                  activeIcon: new SvgPicture.asset("assets/svg/bantuan/ic-saving-help-active.svg"),
                  title: new Text('Bantuan', style: CustomText.regular12),
                ),
                BottomNavigationBarItem(
                  icon: new SvgPicture.asset("assets/svg/dashboard/ai-svg/ic-user-inactive.svg"),
                  activeIcon: new SvgPicture.asset("assets/svg/ic-user-active.svg"),
                  title: new Text('Akun', style: CustomText.regular12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {}
    });
  }
}
