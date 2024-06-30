import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calenderapp/calendar.dart';
import 'package:calenderapp/classes/event.dart';

Type typeOf<T>() => T;

void main() {
  testWidgets('Calendar',
      (WidgetTester tester) async {
    DateTime? pressedDay;
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
  });

  testWidgets(
    'jika user tekan secara lama maka akan menjadi hijau',
    (WidgetTester tester) async {
      DateTime? pressedDay;

      final carousel = Calendar(
        weekFormat: true,
        height: 200.0,
        onDayPressed: (date, event) {
          pressedDay = date;
        },
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              child: carousel,
            ),
          ),
        ),
      );

      expect(find.byWidget(carousel), findsOneWidget);

      expect(pressedDay, isNull);

      await tester.tap(
          find.text(DateTime.now().subtract(Duration(days: 1)).day.toString()));

      await tester.pump();

      expect(pressedDay, isNotNull);
    },
  );

  testWidgets(
    'tidak akan terjadi apa apa jika di tekan oleh user',
    (WidgetTester tester) async {
      final carousel = Calendar(
        weekFormat: true,
        height: 200.0,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              child: carousel,
            ),
          ),
        ),
      );

      expect(find.byWidget(carousel), findsOneWidget);

      await tester.tap(
          find.text(DateTime.now().subtract(Duration(days: 1)).day.toString()));
      await tester.pump();
    },
  );

  testWidgets(
    'jika ditekan lama maka seharusnya ondaylongpressed terpanggil',
    (WidgetTester tester) async {
      DateTime? longPressedDay;

      final carousel = Calendar(
        weekFormat: true,
        height: 200.0,
        onDayLongPressed: (date) {
          longPressedDay = date;
        },
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              child: carousel,
            ),
          ),
        ),
      );

      expect(find.byWidget(carousel), findsOneWidget);

      expect(longPressedDay, isNull);

      await tester.longPress(
          find.text(DateTime.now().subtract(Duration(days: 1)).day.toString()));
      await tester.pump();

      expect(longPressedDay, isNotNull);
    },
  );

  testWidgets(
    'tidak terjadi apa apa jika user tekan lama',
    (WidgetTester tester) async {
      final carousel = Calendar(
        weekFormat: true,
        height: 200.0,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              child: carousel,
            ),
          ),
        ),
      );

      expect(find.byWidget(carousel), findsOneWidget);

      await tester.longPress(
          find.text(DateTime.now().subtract(Duration(days: 1)).day.toString()));
      await tester.pump();
    },
  );
}
