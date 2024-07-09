import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/graphql_service.dart';
import '../models/blog_post.dart';

import '../widgets/blog_item.dart';
import 'blog_detail.dart';
import 'blog_form.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Posts'), centerTitle: true, elevation: 3,),
      body: Query(
        options: QueryOptions(document: gql(fetchAllBlogs)),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          List<BlogPost> blogs = (result.data!['allBlogPosts'] as List)
              .map((blog) => BlogPost.fromJson(blog))
              .toList();

          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return BlogItem(
                blog: blogs[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailScreen(blogId: blogs[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlogFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
