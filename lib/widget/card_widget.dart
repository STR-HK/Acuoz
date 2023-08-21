import 'package:acuoz/page/subject_page.dart';
import 'package:flutter/cupertino.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.title,
      required this.color,
      required this.icon,
      this.disabled = false});
  final String title;
  final Color color;
  final IconData icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(16),
            onPressed: () {
              if (!disabled) {
                Navigator.push(
                  context,
                  CupertinoPageRoute<Widget>(
                    builder: (BuildContext context) {
                      return SubjectPage(
                        id: title,
                        icon: icon,
                        color: color,
                      );
                    },
                  ),
                );
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text('준비중'),
                    content: Text('아직 준비중인 과목입니다.'),
                    actions: [
                      CupertinoDialogAction(
                        textStyle: TextStyle(
                          color: color,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              }
            },
            color: color.withOpacity(0.2),
            child: Icon(
              icon,
              size: 38,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, left: 2),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  '$title 현황',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Text(
              //     '31/66 (47%)',
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 1,
              //     textAlign: TextAlign.start,
              //     softWrap: false,
              //     style: TextStyle(
              //       color: CupertinoColors.systemGrey,
              //       fontWeight: FontWeight.w100,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: Text(
              //     'Porfolio',
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 1,
              //     textAlign: TextAlign.start,
              //     softWrap: false,
              //     style: TextStyle(
              //       color: CupertinoColors.systemBlue
              //           .withOpacity(0.2),
              //       fontWeight: FontWeight.w100,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ],
    ));
  }
}
