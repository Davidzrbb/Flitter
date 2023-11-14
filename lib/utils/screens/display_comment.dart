import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DisplayComment extends StatefulWidget {
  const DisplayComment({super.key, required this.state});

  final GoRouterState state;

  @override
  State<DisplayComment> createState() => _DisplayCommentState();
}

class _DisplayCommentState extends State<DisplayComment> {
  @override
  void initState() {
    _getCommentByIdPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Comment'),
      ),
      body: const Center(
        child: Text('Display Comment '),
      ),
    );
  }

  _getCommentByIdPost() {
    final postId = widget.state.pathParameters['postId'];
    if (postId != null) {
      //
    }
  }
}
