import 'package:flutter/material.dart';

class ask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

         ListView(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                title: Text("Lost Of People"),
                backgroundColor: Colors.blue,
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only( bottom: 20.0),
                      child: Text(
                        "أسئله متكرره",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only( bottom: 7.0),
                          child: Text(
                            "كيفية اضافة بوست للتطبيق؟",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),

                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            " كل ما عليك هو الذهاب الي <Manage data person>  وفي اعلي اليمين هناك ايكون اضافه  يمكنك الضغط عليه وادخال بيانات الشخص وهي الاسم والمكان ويوم الفقد وصوره له والضغط علي ايكون<Curent Location>لاخذ مكان الشخص وعرضه علي الخريطه.",
                              style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only( bottom: 7.0),
                          child: Text(
                            "كيف يمكنني  معرفة الاشخاص التي تم العثور عليها؟",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),

                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "  سيتم معرفة الاشخاص التي تم العثور عليها من خلال علامة قلب توضع علي كل بوست ان كان ذالك القلب مظللا  سيكون ذالك الشخص قد وجد بحمد الله   ",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only( bottom: 7.0),
                          child: Text(
                            "كيف يمكنني البحث عن الاشخاص  ؟",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),

                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "  سيتم البحث عن الشخص من خلال  ايكون بحث يتم وضع فيه اسم المكان  وسيتم عرض جميع الاشخاص المفقودون في هذا المكان  وايضا هناك بحث علي الخريطه عند الضعط او تقليب البوست سيتم تواجد مكانه علي الخريطه بكل سهوله وبشكل جميل",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],


    );
  }
}
