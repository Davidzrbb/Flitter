import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flitter/models/connexion_user.dart';
import 'package:flitter/services/connexion/connexion_bloc.dart';
import 'package:flitter/screens/connexion_screen.dart';

class MockConnexionBloc extends Mock implements ConnexionBloc {}

void main() {
  group('ConnexionScreen Widget Test', () {
    late MockConnexionBloc connexionBloc;

    setUp(() {
      connexionBloc = MockConnexionBloc();
    });

    testWidgets('ConnexionScreen renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ConnexionBloc>(
            create: (_) => connexionBloc,
            child: ConnexionScreen(),
          ),
        ),
      );

      expect(find.text('Connexion'), findsOneWidget);

      expect(find.byType(TextFormField), findsNWidgets(2));

      expect(find.text('Sign in'), findsOneWidget);

      expect(find.text("Don't have an account? Sign up."), findsOneWidget);
    });

    testWidgets('ConnexionScreen sign in button triggers sign in process', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ConnexionBloc>(
            create: (_) => connexionBloc,
            child: ConnexionScreen(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password');

      await tester.tap(find.text('Sign in'));
      await tester.pump();

      verify(connexionBloc.add(ConnexionSubmitted(const ConnexionUser(email: 'test@example.com', password: 'password')))).called(1);
    });

  });
}
