import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_lens/util/color.dart';
import 'package:local_lens/util/image_store_methods.dart';
import 'package:local_lens/util/utils.dart';
import 'package:local_lens/service/service.dart';

import '../controller/problem.dart'; // Import the service.dart file

class PostImageView extends StatefulWidget {
  const PostImageView({Key? key}) : super(key: key);

  @override
  State<PostImageView> createState() => _PostImageViewState();
}

class _PostImageViewState extends State<PostImageView> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;

  void postImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase
      String firebaseImageUrl = await ImageStoreMethods()
          .uploadPost(_descriptionController.text, _file!);

      // Upload image URL to API endpoint
      await RemoteService.postProblem(
        description: _descriptionController.text,
        image: firebaseImageUrl, // Use the firebaseImageUrl as the image URL
        suggestion: null, // Provide suggestion if needed
      );

      // After successfully posting, update the list of problems
      Get.find<ProblemController>().getProblems();

      setState(() {
        _isLoading = false;
      });

      showSnackBar('Posted', context);
      clearImage();
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  _imageSelect(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Image"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(
                  ImageSource.camera,
                );
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose From Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(
                  ImageSource.gallery,
                );
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Post Image",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorApp.kPrimary,
        ),
        body: _file == null
            ? Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => _imageSelect(context),
                      icon: const Icon(Icons.photo),
                      iconSize: 300,
                      color: ColorApp.kPrimary,
                    ),
                    const Text(
                      "CLICK THE IMAGE ICON",
                      style: TextStyle(fontSize: 28.0, color: ColorApp.kPrimary),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      _isLoading
                          ? const LinearProgressIndicator()
                          : const Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                              ),
                            ),
                      const Divider(),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: TextField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                hintText: 'Write a Description',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: postImage,
                            child: const Text("Post"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
