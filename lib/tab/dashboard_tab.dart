import 'package:acuoz/widget/card_widget.dart';
import 'package:flutter/cupertino.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
            largeTitle: Text(
              '대시보드',
              style: TextStyle(fontFamily: 'SF Pro'),
            ),
            trailing: Icon(CupertinoIcons.rectangle_on_rectangle_angled)),
        SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CardWidget(
                        title: '국어',
                        color: CupertinoColors.systemPink,
                        icon: CupertinoIcons.pencil_ellipsis_rectangle,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '수학',
                        color: CupertinoColors.systemRed,
                        icon: CupertinoIcons.function,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '영어',
                        color: CupertinoColors.systemOrange,
                        icon: CupertinoIcons.textformat,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CardWidget(
                        title: '통합과학',
                        color: CupertinoColors.systemYellow,
                        icon: CupertinoIcons.cube,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '통합사회',
                        color: CupertinoColors.systemGreen,
                        icon: CupertinoIcons.map,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '한국사',
                        color: CupertinoColors.systemMint,
                        icon: CupertinoIcons.compass,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CardWidget(
                        title: '미정',
                        color: CupertinoColors.systemBlue,
                        disabled: true,
                        icon: CupertinoIcons.lightbulb,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '미정',
                        color: CupertinoColors.systemIndigo,
                        disabled: true,
                        icon: CupertinoIcons.lightbulb,
                      ),
                      SizedBox(width: 8),
                      CardWidget(
                        title: '미정',
                        color: CupertinoColors.systemPurple,
                        disabled: true,
                        icon: CupertinoIcons.lightbulb,
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
