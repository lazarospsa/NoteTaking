import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lara_fl/screen/home.dart';
import '../helper/dio.dart';

class CreateNewPostWidget extends StatefulWidget {
  const CreateNewPostWidget({Key? key}) : super(key: key);

  @override
  _CreateNewPostFormState createState() => _CreateNewPostFormState();
}

class _CreateNewPostFormState extends State<CreateNewPostWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final storage = FlutterSecureStorage();

  Future<void> createPost() async {
    final token = await storage.read(key: 'auth');

    // Dio.Response res = await dio().get('user/posts',
    //     options: Dio.Options(headers: {
    //       'Authorization': 'Bearer $token',
    //     }));
    // List posts = res.data;
    // Replace 'your_api_endpoint' with the actual endpoint for creating a new post
    try {
      final response = await dio().post(
        'user/posts',
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'title': titleController.text,
          'body': bodyController.text,
        },
      );

      if (response.statusCode == 201) {
        // Post created successfully
        // You may want to navigate to the posts screen or perform other actions
        // Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Home(), // Replace with the screen you want to navigate to
          ),
        );
      } else {
        print(response.data);
        // Handle errors, display a message, etc.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create post'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createPost,
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
