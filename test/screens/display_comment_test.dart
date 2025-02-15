import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flitter/services/comment_get/get_comment_bloc.dart';
import 'package:flitter/services/comment_post/comment_post_bloc.dart';
import 'package:flitter/screens/display_comment.dart';

class MockGetCommentBloc extends Mock implements GetCommentBloc {}

class MockCommentPostBloc extends Mock implements CommentPostBloc {}

void main() {
  group('DisplayComment Widget Test', () {
    late MockGetCommentBloc getCommentBloc;
    late MockCommentPostBloc commentPostBloc;

    setUp(() {
      getCommentBloc = MockGetCommentBloc();
      commentPostBloc = MockCommentPostBloc();
    });
    

    /*testWidgets('DisplayComment renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<GetCommentBloc>.value(value: getCommentBloc),
              BlocProvider<CommentPostBloc>.value(value: commentPostBloc),
            ],
            child: const DisplayComment(state: null,),

          ),
        ),
      );

      expect(find.text('Display Comment'), findsOneWidget);

      expect(find.byIcon(Icons.comment_outlined), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });*/
  });
}