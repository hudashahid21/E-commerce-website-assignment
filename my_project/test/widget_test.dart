import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'custom_button.dart';
import 'custom_card.dart';
import 'custom_textfield.dart';

void main() {
  group('CustomTextField Tests', () {
    testWidgets('Should display the text field with label', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              label: 'Email',
              icon: Icons.email,
            ),
          ),
        ),
      );

      // Check if the label 'Email' exists
      expect(find.text('Email'), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });

  group('CustomButton Tests', () {
    testWidgets('Should trigger onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Login',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Login'), findsOneWidget);

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });

  group('CustomCard Tests', () {
    testWidgets('Should display product details', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(
              title: 'Test Product',
              price: '\$20',
              imageUrl: 'https://via.placeholder.com/150',
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('\$20'), findsOneWidget);
      expect(find.byType(Image, skipOffstage: false), findsOneWidget);
    });
  });
}
