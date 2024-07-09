import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final HttpLink httpLink = HttpLink('https://uat-api.vmodel.app/graphql/');

  GraphQLClient getClient() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}

const String fetchAllBlogs = """
query fetchAllBlogs {
  allBlogPosts {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";

// const String getBlog = """
// query getBlog {
//   blogPost(blogId: "587") {
//     id
//     title
//     subTitle
//     body
//     dateCreated
//   }
// }
// """;
const String getBlog = r'''
query getBlog($blogId: String!) {
  blogPost(blogId: $blogId) {
    id
    title
    subTitle
    body
    dateCreated
  }
}
''';

const String createBlogPost = """
mutation createBlogPost(\$title: String!, \$subTitle: String!, \$body: String!) {
  createBlog(title: \$title, subTitle: \$subTitle, body: \$body) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
    }
  }
}
""";

const String updateBlogPost = """
mutation updateBlogPost(\$blogId: String!, \$title: String!, \$subTitle: String!, \$body: String!) {
  updateBlog(blogId: \$blogId, title: \$title, subTitle: \$subTitle, body: \$body) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
    }
  }
}
""";

const String deleteBlogPost = """
mutation deleteBlogPost {
  deleteBlog(blogId: "1") {
    success
  }
}
""";
