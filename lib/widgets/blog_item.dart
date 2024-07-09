import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogItem extends StatelessWidget {
  final BlogPost blog;
  final VoidCallback onTap;

  BlogItem({required this.blog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(blog.title),
      subtitle: Text(blog.subTitle),
      onTap: onTap,
    );
  }
}