import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_lens/controller/problem.dart';
import 'package:local_lens/util/color.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'User',
      'pic':
          'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1714273896~exp=1714277496~hmac=4e6bcf547e7a5c159db6ed183b3614cc39a499b9e02b8b313da20d060f113f25&w=740',
      'message': 'Follow the below link to solve the problem',
      'date': '2021-01-01s 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing:
                  Text(data[i]['date'], style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var pc = Get.find<ProblemController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Comment Page",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorApp.kPrimary,
        ),
        body: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath:
                  "https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1714273896~exp=1714277496~hmac=4e6bcf547e7a5c159db6ed183b3614cc39a499b9e02b8b313da20d060f113f25&w=740"),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                      'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1714273896~exp=1714277496~hmac=4e6bcf547e7a5c159db6ed183b3614cc39a499b9e02b8b313da20d060f113f25&w=740',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: ColorApp.kPrimary,
          textColor: Colors.white,
          sendWidget:
              const Icon(Icons.send_sharp, size: 30, color: Colors.white),
          child: commentChild(filedata),
        ),
      ),
    );
  }
}
