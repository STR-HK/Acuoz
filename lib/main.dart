import 'dart:io';

import 'package:acuoz/tab/customize_tab.dart';
import 'package:acuoz/tab/dashboard_tab.dart';
import 'package:acuoz/tab/settings_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future main() async {
  if (kIsWeb) {
    // sqfliteFfiWebLoadSqlite3Wasm();
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }
  // databaseFactory.deleteDatabase(await getDatabasesPath());
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  runApp(AcuozApp());
}

class AcuozApp extends StatefulWidget {
  const AcuozApp({super.key});

  @override
  State<AcuozApp> createState() => _AcuozAppState();
}

class _AcuozAppState extends State<AcuozApp> with WidgetsBindingObserver {
  Brightness _brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // ignore: deprecated_member_use
    _brightness = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        // ignore: deprecated_member_use
        _brightness = WidgetsBinding.instance.window.platformBrightness;
      });
    }

    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MediaQuery.fromView(
        view: View.of(context),
        child: CupertinoApp(
          theme: CupertinoThemeData(
              brightness: _brightness,
              primaryColor: CupertinoColors.systemIndigo,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                    fontFamily: 'SF Pro',
                    color: CupertinoColors.label.resolveFrom(context)),
              )),
          home: CupertinoStoreHomePage(),
          // debugShowCheckedModeBanner: false,
        ));
  }
}

// class CupertinoStoreApp extends StatelessWidget {
//   const CupertinoStoreApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     final Brightness platformBrightness =
//         WidgetsBinding.instance.window.platformBrightness;

//     return CupertinoApp(
//       theme: CupertinoThemeData(
//           brightness: platformBrightness,
//           primaryColor: CupertinoColors.systemBlue,
//           textTheme: CupertinoTextThemeData(
//             textStyle:
//                 TextStyle(fontFamily: 'SF Pro', color: CupertinoColors.label),
//           )),
//       home: CupertinoStoreHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// MaterialApp(
//       theme: CupertinoThemeData(
//           brightness: MediaQuery.of(context).platformBrightness,
//           primaryColor: CupertinoColors.systemBlue,
//           textTheme: CupertinoTextThemeData(
//             textStyle: TextStyle(fontFamily: 'SF Pro'),
//           )),
//     )

// MediaQuery.fromView(
//         view: View.of(context),
//         child: CupertinoApp(
//           theme: CupertinoThemeData(
//               brightness: MediaQuery.of(context).platformBrightness,
//               primaryColor: CupertinoColors.systemBlue,
//               textTheme: CupertinoTextThemeData(
//                 textStyle: TextStyle(fontFamily: 'SF Pro'),
//               )),
//           home: CupertinoStoreHomePage(),
//           debugShowCheckedModeBanner: false,
//         ));

class CupertinoStoreHomePage extends StatelessWidget {
  CupertinoStoreHomePage({super.key});
  final List<Widget> _tabs = [
    DashboardTab(),
    CustomizeTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_on_rectangle_angled),
              label: '대시보드'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar), label: '사용자화'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: '설정'),
        ]),
        tabBuilder: (BuildContext context, index) {
          return _tabs[index];
        },
      ),
    );
  }
}
