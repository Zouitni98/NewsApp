import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/Screens/NewsScreen.dart';




void main() {

  testWidgets(
      "When given trees as query check if the images are loaded",
          (tester) async {
        // 1
        await tester.runAsync(() async {

          await tester.pumpWidget( MaterialApp(home: NewsScreen()));
          await tester.enterText(find.byType(TextField), "Sport");

        });

        final gesture = await tester.startGesture(const Offset(0, 300)); //Position of the scrollview
        await gesture.moveBy(const Offset(0, -300)); //How much to scroll by
        await tester.pump();
      });




}