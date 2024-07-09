// import 'package:blog_post/screens/blog_list.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'screens/blog_list.dart';
// import 'graphql/graphql_service.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final GraphQLService graphQLService = GraphQLService();
//
//   @override
//   Widget build(BuildContext context) {
//     final client = graphQLService.getClient();
//
//     return GraphQLProvider(
//       client: client,
//       child: CacheProvider(child: MaterialApp(
//         title: 'Simple Blog App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: BlogListScreen(),
//       ),),
//     );
//   }
// }
import 'package:blog_post/screens/blog_list.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql/graphql_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GraphQLService graphQLService = GraphQLService();

  @override
  Widget build(BuildContext context) {
    final client = graphQLService.getClient();

    return GraphQLProvider(
      client: ValueNotifier(client),
      child: CacheProvider(
        child: MaterialApp(
          title: 'Simple Blog App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlogListScreen(),
        ),
      ),
    );
  }
}
