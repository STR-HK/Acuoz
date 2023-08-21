import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

class Subject {
  final int id;
  final String counts;

  Subject({
    required this.id,
    required this.counts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'counts': counts,
    };
  }
}

Future<List<dynamic>> getCounts(table, primaryIndex) async {
  List<dynamic> counts = [0];
  try {
    await database
        .query(table, where: 'id = ?', whereArgs: [primaryIndex]).then((value) {
      if (value.isNotEmpty) {
        // ignore: unnecessary_cast
        counts = json.decode((value as List<dynamic>)[0]['counts']);
        // print('반환값: $counts');
        return counts;
      } else {
        Subject subject = Subject(
          id: primaryIndex,
          counts: [].toString(),
        );
        void foo() async {
          await database.insert(
            table,
            subject.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        foo();
        return [0];
      }
    });
  } catch (e) {
    database.execute(
      'CREATE TABLE IF NOT EXISTS 국어(id INTEGER PRIMARY KEY, counts TEXT)',
    );
    database.execute(
      'CREATE TABLE IF NOT EXISTS 수학(id INTEGER PRIMARY KEY, counts TEXT)',
    );
    database.execute(
      'CREATE TABLE IF NOT EXISTS 영어(id INTEGER PRIMARY KEY, counts TEXT)',
    );
    database.execute(
      'CREATE TABLE IF NOT EXISTS 통합과학(id INTEGER PRIMARY KEY, counts TEXT)',
    );
    database.execute(
      'CREATE TABLE IF NOT EXISTS 통합사회(id INTEGER PRIMARY KEY, counts TEXT)',
    );
    database.execute(
      'CREATE TABLE IF NOT EXISTS 한국사(id INTEGER PRIMARY KEY, counts TEXT)',
    );
  }
  return counts;
}

void setCounts(table, primaryIndex, secondaryIndex, newCount) async {
  getCounts(table, primaryIndex).then((value) {
    // print('get에서 가져온 값: $value');
    List<String> counts = [];
    for (int i = 0; i < value.length; i++) {
      counts.add(value[i].toString());
    }
    if (counts.length - 1 < secondaryIndex) {
      for (int i = counts.length; i <= secondaryIndex; i++) {
        counts.add('0');
      }
    }
    counts[secondaryIndex] = newCount.toString();

    Subject subject = Subject(
      id: primaryIndex,
      counts: counts.toString(),
    );
    void foo() async {
      await database.insert(
        table,
        subject.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    foo();
  });
}

Future<void> _init() async {
  // await getDatabasesPath().then((value) {
  // print(value);
  // });
  database = await openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE IF NOT EXISTS 국어(id INTEGER PRIMARY KEY, counts TEXT)',
      );
      db.execute(
        'CREATE TABLE IF NOT EXISTS 수학(id INTEGER PRIMARY KEY, counts TEXT)',
      );
      db.execute(
        'CREATE TABLE IF NOT EXISTS 영어(id INTEGER PRIMARY KEY, counts TEXT)',
      );
      db.execute(
        'CREATE TABLE IF NOT EXISTS 통합과학(id INTEGER PRIMARY KEY, counts TEXT)',
      );
      db.execute(
        'CREATE TABLE IF NOT EXISTS 통합사회(id INTEGER PRIMARY KEY, counts TEXT)',
      );
      db.execute(
        'CREATE TABLE IF NOT EXISTS 한국사(id INTEGER PRIMARY KEY, counts TEXT)',
      );
    },
    version: 1,
  );
}

class TableCellWidget extends StatefulWidget {
  const TableCellWidget({
    super.key,
    required this.parentColor,
    required this.title,
    required this.subtitle,
    required this.primaryIndex,
    required this.secondaryIndex,
    required this.table,
  });
  final Color parentColor;
  final String title;
  final String subtitle;

  final int primaryIndex;
  final int secondaryIndex;

  final String table;

  @override
  State<TableCellWidget> createState() => _TableCellWidgetState();
}

class _TableCellWidgetState extends State<TableCellWidget>
    with WidgetsBindingObserver {
  Color _color = CupertinoColors.systemFill;
  Color _textColor = CupertinoColors.label;
  int count = 0;
  bool initailized = false;

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String subtitle = widget.subtitle;

    if (count < 3) {
      _textColor = CupertinoColors.label.resolveFrom(context);
    } else {
      _textColor = CupertinoColors.white;
    }

    if (!initailized) {
      _init().then((value) {
        getCounts(widget.table, widget.primaryIndex).then((value) {
          setState(() {
            if (value.length - 1 >= widget.secondaryIndex) {
              count = value[widget.secondaryIndex];
            } else {
              count = 0;
            }

            if (count > 0) {
              _color = widget.parentColor.withOpacity(count * 0.333);
            } else {
              _color = CupertinoColors.systemFill;
            }
            if (count < 3) {
              _textColor = CupertinoColors.label.resolveFrom(context);
            } else {
              _textColor = CupertinoColors.white;
            }
          });
        });
      });
      initailized = true;
    }

    return Flexible(
      fit: FlexFit.tight,
      child: PullDownButton(
        itemBuilder: (context) => [
          PullDownMenuTitle(title: Text('회차 설정')),
          PullDownMenuActionsRow.medium(
            items: [
              PullDownMenuItem(
                onTap: () {
                  setState(() {
                    count = 1;

                    _init().then((value) {
                      setCounts(widget.table, widget.primaryIndex,
                          widget.secondaryIndex, count);
                    });
                    _color = widget.parentColor.withOpacity(count * 0.333);
                    _textColor = CupertinoColors.label.resolveFrom(context);
                  });
                },
                title: '1회',
                icon: CupertinoIcons.pencil,
              ),
              PullDownMenuItem(
                onTap: () {
                  setState(() {
                    count = 2;

                    _init().then((value) {
                      setCounts(widget.table, widget.primaryIndex,
                          widget.secondaryIndex, count);
                    });
                    _color = widget.parentColor.withOpacity(count * 0.333);
                    _textColor = CupertinoColors.label.resolveFrom(context);
                  });
                },
                title: '2회',
                icon: CupertinoIcons.doc_on_doc,
              ),
              PullDownMenuItem(
                onTap: () {
                  setState(() {
                    count = 3;

                    _init().then((value) {
                      setCounts(widget.table, widget.primaryIndex,
                          widget.secondaryIndex, count);
                    });
                    _color = widget.parentColor.withOpacity(count * 0.333);
                    _textColor = CupertinoColors.white;
                  });
                },
                title: '3회',
                icon: CupertinoIcons.check_mark,
              ),
            ],
          ),
          PullDownMenuItem(
            title: '횟수 초기화',
            onTap: () {
              setState(() {
                count = 0;

                _init().then((value) {
                  setCounts(widget.table, widget.primaryIndex,
                      widget.secondaryIndex, count);
                });
                _color = CupertinoColors.systemFill;
                _textColor = CupertinoColors.label.resolveFrom(context);
              });
            },
            isDestructive: true,
            icon: CupertinoIcons.delete,
          ),
        ],
        buttonBuilder: (context, showMenu) => CupertinoButton(
          onPressed: () {
            showMenu();
          },
          color: _color,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: _textColor),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textColor),
                textAlign: TextAlign.center,
              ),
              Text(
                '$count회',
                style: TextStyle(fontSize: 9, color: _textColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
