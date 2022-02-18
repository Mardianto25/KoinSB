import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/dashboard/main.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'http://118.97.94.134:8030/pin-auth';
// String selectedUrl = 'https://www.google.com/';


// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

class MyWebview extends StatefulWidget {
  const MyWebview({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyWebviewState createState() => _MyWebviewState();
}

class _MyWebviewState extends State<MyWebview> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool _reloadUrl = false;
  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = TextEditingController(text: selectedUrl);

  final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  int _angka = 0;
  

  @override
  void initState() {
    super.initState();
  
    flutterWebViewPlugin.close();

    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_){_showDialog();});

    // Add a listener to on url changed
   flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        // // flutterWebViewPlugin.dispose();
        if (url == ("http://118.97.94.134:8030/pin-transaksi")){
          setState(() {
            _reloadUrl = true;  
          });
          
        }else{
          // flutterWebViewPlugin.launch("http://118.97.94.134:8030/detailrekening");
          setState(() {
            _reloadUrl = false;          
          }); 
        }
        setState(() {
          print(url);
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in Y Direction: $y');
        });
      }
    });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in X Direction: $x');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          print('onStateChanged: ${state.type} ${state.url}');
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        setState(() {
          _history.clear();
          flutterWebViewPlugin.close();
        });
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Main()
        ));
       
        
      } ,
      child: Scaffold(
        body: SafeArea(
          child: WebviewScaffold(
            url: selectedUrl,
            javascriptChannels: jsChannels,
            mediaPlaybackRequiresUserGesture: false,
            appBar:!_reloadUrl ? null : AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              leading: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Main()
                  ));
                    setState(() {
                      _history.clear();
                    });
                    flutterWebViewPlugin.close();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: const Text('PIN Transaksi'),
            ),
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            withJavascript: true,
            initialChild: Container(
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    onPressed: () {
                      _reload();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  

  void _reload(){
    flutterWebViewPlugin.reload();
    
    // // _onUrlChanged.resume();
    // Timer.periodic(new Duration(seconds: 6), (timer) {
    //   // _onUrlChanged.pause(); 
    // });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }
}