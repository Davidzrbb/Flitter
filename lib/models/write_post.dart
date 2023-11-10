import 'dart:io';

class WritePost {
  final String content;
  final File? imageBase64;

  const WritePost({
    required this.content,
    this.imageBase64,
  });
}
