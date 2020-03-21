import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  static const routeName = '/about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost Of People"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50, right: 50, left: 50),
            child: Center(
              child: Text('عن التطبيق', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              ),),
            ),
          ),
          Divider(
            color: Colors.blue,
            indent: 60,
            endIndent: 60,

          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18,
              top: 50,
            ),
            child: Text(
              ' هو تطبيق يجمع  الاشخاص المفقوده من خلال المستخدم  عن طريق رفع بوست الخاص بالشخص المفقود وسيتم تحديد مكان البوست علي انه مكان الشخص المفقود ويتم التواصل مع  الشخص من خلال الفيس بوك او رقم التليفون الخاص بصاحب البوست  و يتوفر في التطبق خريطه لمعرفة مكان كل شخص مفقود علي الخريطه وعرض البيانات الخاصه بالشخص علي الخريطه وهناك ايضا تطبق خاص بنا ويتم فيه استخدام التعرف علي الشخص من خلال الكامره  والصور بمجرد رفع صورة للشخص سيتم التعارف عليه عن طريق البيانات الخاصه بيه والمتوفره عندنا في التطبيق ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
