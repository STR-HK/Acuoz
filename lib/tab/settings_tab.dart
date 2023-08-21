import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(
            '설정',
            style: TextStyle(fontFamily: 'SF Pro'),
          ),
          trailing: Icon(CupertinoIcons.settings),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                CupertinoButton(
                    color: CupertinoColors.destructiveRed,
                    child: Text('초기화'),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: Text('초기화'),
                          content: Text('모든 데이터가 삭제됩니다.'),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {
                                Future foo() async {
                                  await deleteDatabase(join(
                                      await getDatabasesPath(), 'database.db'));
                                }

                                foo().then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              isDestructiveAction: true,
                              child: Text('삭제'),
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              isDefaultAction: true,
                              child: Text('취소'),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        )
      ],
    ));
  }
}
