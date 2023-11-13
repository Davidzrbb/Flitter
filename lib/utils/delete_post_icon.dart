import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/post_delete_bloc/post_delete_bloc.dart';
import '../services/post_get_bloc/post_get_bloc.dart';

class DeletePostIcon extends StatefulWidget {
  const DeletePostIcon({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DeletePostIcon> createState() => _DeletePostIconState();
}

class _DeletePostIconState extends State<DeletePostIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDeleted(context),
      child: const Icon(
        Icons.delete_outlined,
        color: Colors.grey,
        size: 20,
      ),
    );
  }

  _onDeleted(BuildContext context) async {
    if (!mounted) {
      // The widget is no longer in the widget tree, so don't proceed
      return;
    }

    BlocProvider.of<PostDeleteBloc>(context).add(PostDelete(widget.id));
    BlocProvider.of<PostDeleteBloc>(context).stream.listen((state) {
      if (!mounted) {
        return;
      }

      if (state.status == PostDeleteStatus.success) {
        BlocProvider.of<PostGetBloc>(context).add(PostGetAll(refresh: true));
         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post supprimé'),
          duration: Duration(seconds: 3),
        ),
      );
      }
    });
  }
}
