import 'package:flutter/cupertino.dart';

class CustomizeTab extends StatefulWidget {
  const CustomizeTab({super.key});

  @override
  State<CustomizeTab> createState() => _CustomizeTabState();
}

class _CustomizeTabState extends State<CustomizeTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(
            '사용자화',
            style: TextStyle(fontFamily: 'SF Pro'),
          ),
          trailing: Icon(CupertinoIcons.calendar),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                CupertinoListSection(
                  header: Text('데이터'),
                  children: [
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.envelope_open),
                      title: Text('PR 열기'),
                      trailing: CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.cloud_upload),
                      title: Text('실시간 동기화'),
                      trailing: CupertinoSwitch(
                        value: false,
                        onChanged: (bool value) {},
                      ),
                      onTap: () {},
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.shuffle_medium),
                      title: Text('마지막 커밋 보기'),
                      additionalInfo: Text('12일 전'),
                      trailing: CupertinoListTileChevron(),
                      onTap: () {},
                    ),
                  ],
                ),
                CupertinoListSection(
                  header: Text('데이터베이스'),
                  children: [
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.table),
                      title: Text('데이터베이스 테이블 목록'),
                      trailing: CupertinoListTileChevron(),
                      onTap: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Text('데이터베이스 사용자화'),
                            content: Text('테이블 목록 반환'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
