import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/graphql_service.dart';

class BlogFormScreen extends StatefulWidget {
  final String? blogId;

  BlogFormScreen({this.blogId});

  @override
  _BlogFormScreenState createState() => _BlogFormScreenState();
}

class _BlogFormScreenState extends State<BlogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _subTitle = '';
  String _body = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.blogId == null ? 'Create Blog' : 'Edit Blog'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    children: [
    TextFormField(
    decoration: InputDecoration(labelText: 'Title'),
    onSaved: (value) {
    _title = value!;
    },
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter a title';
    }
    return null;
    },
    ),
    TextFormField(
    decoration: InputDecoration(labelText: 'SubTitle'),
    onSaved: (value) {
    _subTitle = value!;
    },
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter a subtitle';
    }
    return null;
    },
    ),
    TextFormField(
    decoration: InputDecoration(labelText: 'Body'),
    onSaved: (value) {
    _body = value!;
    },
    validator: (value) {
    if (value!.isEmpty) {
    return 'Please enter the body';
    }
    return null;
    },
    ),
    SizedBox(height:20),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            if (widget.blogId == null) {
              final mutationOptions = MutationOptions(
                document: gql(createBlogPost),
                variables: {'title': _title, 'subTitle': _subTitle, 'body': _body},
              );
              GraphQLProvider.of(context).value.mutate(mutationOptions).then((result) {
                if (result.hasException) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error creating blog post')),
                  );
                } else {
                  Navigator.pop(context);
                }
              });
            } else {
              final mutationOptions = MutationOptions(
                document: gql(updateBlogPost),
                variables: {'blogId': widget.blogId!, 'title': _title, 'subTitle': _subTitle, 'body': _body},
              );
              GraphQLProvider.of(context).value.mutate(mutationOptions).then((result) {
                if (result.hasException) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating blog post')),
                  );
                } else {
                  Navigator.pop(context);
                }
              });
            }
          }
        },
        child: Text(widget.blogId == null ? 'Create' : 'Update'),
      ),
    ],
    ),
    ),
        ),
    );
  }
}


