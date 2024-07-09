import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/graphql_service.dart';
import '../models/blog_post.dart';
import 'blog_form.dart';


class BlogDetailScreen extends StatelessWidget {
  final String blogId;

  BlogDetailScreen({required this.blogId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogFormScreen(blogId: blogId),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final mutationOptions = MutationOptions(
                document: gql(deleteBlogPost),
                variables: {'blogId': blogId},
              );
              GraphQLProvider.of(context).value.mutate(mutationOptions).then((result) {
                if (result.hasException) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting blog post')),
                  );
                } else {
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getBlog),
          variables: {'blogId': blogId},
        ),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          BlogPost blog = BlogPost.fromJson(result.data!['blogPost']);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(blog.subTitle, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                SizedBox(height: 16),
                Text(blog.body, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Created on: ${blog.dateCreated}', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}
