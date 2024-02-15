
import 'package:flitter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flitter/utils/ui/post_list.dart';
import 'package:flitter/models/write_post.dart';
import 'package:flitter/services/connexion/connexion_bloc.dart';
import 'package:flitter/services/post_create/post_bloc.dart';
import 'package:flitter/utils/ui/floating_action_button_screen.dart';
import 'package:flitter/screens/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnexionBloc extends Mock implements ConnexionBloc {}

class MockPostBloc extends Mock implements PostBloc {}

void main() {
  group('HomeScreen Widget Test', () {
    late MockConnexionBloc connexionBloc;
    late MockPostBloc postBloc;

    setUp(() {
      connexionBloc = MockConnexionBloc();
      postBloc = MockPostBloc();
    });

    testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
      when(connexionBloc.state).thenReturn(ConnexionState(user: User()));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ConnexionBloc>.value(value: connexionBloc),
              BlocProvider<PostBloc>.value(value: postBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      expect(find.text('Flitter'), findsOneWidget);

      expect(find.byIcon(Icons.power_off_outlined), findsOneWidget);

      expect(find.byType(PostListScreen), findsOneWidget);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('HomeScreen log out button triggers sign out', (WidgetTester tester) async {
      when(connexionBloc.state).thenReturn(ConnexionState(user: User()));

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ConnexionBloc>.value(value: connexionBloc),
              BlocProvider<PostBloc>.value(value: postBloc),
            ],
            child: HomeScreen(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.power_off_outlined));
      await tester.pump();

      verify(connexionBloc.add(Disconnected())).called(1);
    });
  });
}