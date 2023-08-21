// import 'package:acuoz/widget/nav_sliver.dart' as nav_sliver;
import 'package:acuoz/widget/segmeted_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:acuoz/widget/tablecell_widget.dart';
import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: CupertinoColors.label.resolveFrom(context)),
    );
  }
}

class SubjectPage extends StatefulWidget {
  const SubjectPage(
      {super.key, required this.id, required this.icon, required this.color});
  final String id;
  final IconData icon;
  final Color color;

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  int _groupValue = 0;

  // ignore: non_constant_identifier_names
  Map<String, Map<int, Widget>> Typeset = {
    '국어': {
      0: BoldText(text: '교과서 개념'),
      1: BoldText(text: '백발백중 개념'),
      2: BoldText(text: '백발백중 문제'),
      3: BoldText(text: '심화문제'),
    },
    '수학': {
      0: BoldText(text: '교과서 정리'),
      1: BoldText(text: '블랙라벨'),
      2: BoldText(text: '자이스토리'),
      3: BoldText(text: '절대등급'),
      4: BoldText(text: '마플시너지'),
    },
    '영어': {
      0: BoldText(text: '내용 암기'),
      1: BoldText(text: '문법 암기'),
      2: BoldText(text: '확인 문제'),
      3: BoldText(text: '변형 문제'),
    },
    '통합과학': {
      0: BoldText(text: '교과서 개념'),
      1: BoldText(text: '학습지 / 노트'),
      2: BoldText(text: '일등급 만들기'),
      3: BoldText(text: '기출 PICK'),
    },
    '통합사회': {
      0: BoldText(text: '교과서 개념'),
      1: BoldText(text: '학습지 / 노트'),
      2: BoldText(text: '평가문제집'),
      3: BoldText(text: '일등급 만들기'),
    },
    '한국사': {
      0: BoldText(text: '교과서 암기'),
      1: BoldText(text: '학습지 암기'),
      2: BoldText(text: '평가문제집'),
    },
  };

  // ignore: non_constant_identifier_names
  Map<String, List<List<String>>> Dataset = {
    '국어': [
      ['6-(1)', '가시리/진달래꽃'],
      ['6-(2)', '상춘곡/울타리 밖'],
      ['6-(3)', '춘향전'],
      ['7-(1)', '창의적 읽기'],
      ['7-(2)', '자발적 읽기'],
      ['7-(3)', '쓰기 과정 성찰'],
      ['8-(1)', '국어의 변화'],
    ],
    '수학': [
      ['8', '직선의 방정식'],
      ['9', '원의 방정식'],
      ['10', '도형의 이동'],
      ['11', '집합'],
      ['12', '명제'],
      ['13', '함수'],
      ['14', '유리함수'],
      ['15', '무리함수'],
    ],
    '영어': [
      ['모의고사', '21~24'],
      ['모의고사', '29~32'],
      ['모의고사', '33~36'],
      ['모의고사', '37~40'],
      ['모의고사', '41~42'],
      ['6', 'Traveling Peru'],
      ['7', 'Creation'],
      ['8', 'Green Life'],
    ],
    '통합과학': [
      ['물리 VIII-04', '에너지와 환경'],
      ['물리 IX-01', '전기 에너지 생산'],
      ['물리 IX-02', '전력 수송'],
      ['화학 VI-01', '화학 반응'],
      ['화학 VI-02', '산화 환원 반응'],
      ['생물 VII-02', '생물의 진화'],
      ['생물 VII-03', '생물 다양성'],
      ['생물 VIII-01', '생물과 환경'],
      ['지구 IV-01', '판의 운동'],
      ['지구 VII-01', '지질 시대'],
      ['지구 IV-01', '생물과 환경'],
    ],
    '통합사회': [
      ['VII-1', '세계 문화'],
      ['VII-2', '문화 변동'],
      ['VII-3', '문화 상대주의'],
      ['VII-4', '다문화 사회'],
      ['V-1', '합리적 선택'],
      ['V-2', '시장 경제 참여자'],
      ['V-3', '국제 분업과 무역'],
      ['V-4', '자산 관리'],
    ],
    '한국사': [
      ['II-4-1', '러일 전쟁'],
      ['II-4-2', '독도와 간도'],
      ['II-4-3', '항일 의병 전쟁'],
      ['II-4-4', '애국 계몽 운동'],
      ['II-5-1', '열강의 경제 침략'],
      ['II-5-2', '경제 변화'],
      ['II-5-3', '근대 문물'],
      ['III-1-1', '1차 세계 대전'],
      ['III-1-2', '무단 통치'],
      ['III-1-3', '민족 분열 통치'],
      ['III-2-1', '항일 비밀 결사'],
      ['III-2-2', '31운동의 전개'],
      ['III-2-3', '대한민국 임시정부'],
      ['III-3-1', '무장 독립 전쟁'],
      ['III-3-2', '의열 투쟁'],
      ['III-3-3', '실력 양성 운동'],
      ['III-3-4', '농민 노동 운동'],
      ['III-3-5', '학생 항일 운동'],
      ['III-3-6', '민족 유일당 운동'],
    ],
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          padding: EdgeInsetsDirectional.only(end: 16),
          previousPageTitle: '대시보드',
          // heroTag: '대시보드',
          // leading: CupertinoSliverBarBackButton(
          //   color: widget.color,
          //   onPressed: () {
          //     Navigator.maybePop(context);
          //   },
          //   previousPageTitle: '대시보드',
          // ),
          largeTitle: Text(
            widget.id,
            style: TextStyle(fontFamily: 'SF Pro'),
          ),
          trailing: Icon(
            widget.icon,
            color: widget.color,
          ),
          color: widget.color,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CupertinoSegmented(
                    groupValue: _groupValue,
                    thumbColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    children: Typeset[widget.id]!,
                    onValueChanged: (int? value) {
                      setState(() {
                        _groupValue = value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 6),
                for (List<String> item in Dataset[widget.id]!) ...[
                  Row(
                    children: [
                      for (int i in Iterable<int>.generate(
                          Typeset[widget.id]!.length)) ...[
                        TableCellWidget(
                          table: widget.id,
                          parentColor: widget.color,
                          title: item[0],
                          subtitle: item[1],
                          primaryIndex: i,
                          secondaryIndex: Dataset[widget.id]!.indexOf(item),
                        ),
                        if (i != Typeset[widget.id]!.length - 1)
                          SizedBox(width: 3),
                      ]
                    ],
                  ),
                  SizedBox(height: 3),
                ],
                // CupertinoButton(child: Text('초기화'), onPressed: () {
                //   _init()
                // })
              ],
            ),
          ),
        )
      ],
    ));
  }
}
