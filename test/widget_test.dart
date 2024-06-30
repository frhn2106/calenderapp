
import 'package:calenderapp/classes/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calenderapp/calendar.dart';

///import 'package:calenderapp/lib/classes/event.dart';

void main() {
  DateTime? pressedDay;
  testWidgets('Calendar',
          (WidgetTester tester) async {
        //  Build our app and trigger a frame.
        final carousel = Calendar(
          daysHaveCircularBorder: null,
          weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          thisMonthDayBorderColor: Colors.grey,
          headerText: 'Weekdays',
          weekFormat: true,
          height: 200.0,
          showIconBehindDayText: true,
          customGridViewPhysics: NeverScrollableScrollPhysics(),
          markedDateShowIcon: true,
          markedDateIconMaxShown: 2,
          selectedDayTextStyle: TextStyle(
            color: Colors.yellow,
          ),
          todayTextStyle: TextStyle(
            color: Colors.blue,
          ),
          markedDateIconBuilder: (Event event) {
            return event.icon ?? Icon(Icons.help_outline);
          },
          todayButtonColor: Colors.transparent,
          todayBorderColor: Colors.green,
          markedDateMoreShowTotal: true,
          // null for not showing hidden events indicator
          onDayPressed: (date, event) {
            pressedDay = date;
          },
        );
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: Container(
              child: carousel,
            ),
          ),
        ));

        expect(find.byWidget(carousel), findsOneWidget);

        expect(pressedDay, isNull);

        await tester.tap(
            find.text(DateTime.now().subtract(Duration(days: 1)).day.toString()));

        await tester.pump();

        expect(pressedDay, isNotNull);
      });
}