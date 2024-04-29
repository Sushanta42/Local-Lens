import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_lens/controller/problem.dart';
import 'package:local_lens/util/color.dart';
import 'package:local_lens/util/size.dart';
import 'package:local_lens/view/commentbox.dart';
import 'package:local_lens/view/postimage.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var pc = Get.find<ProblemController>();
    pc.getProblems();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text(
              "Local Lens",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
            backgroundColor: ColorApp.kPrimary,
          ),
          body: Obx(() {
            if (pc.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Layout.screenPadding),
                  child: Column(
                    children: [
                      const UploadImage(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pc.problems.length,
                          itemBuilder: (BuildContext context, int index) {
                            var problem = pc.problems[index];
                            return Card(
                              child: Column(
                                children: [
                                  // Image.network(
                                  //   "${problem.image}",
                                  // ),
                                  CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    // width: AppSize.screenWidth,
                                    // height: AppSize.screenHeight,
                                    imageUrl: "${problem.image}",
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${problem.description}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            pc.getProblemsId(problem
                                                .id); // Use getProblemsId instead of problemsbyid
                                            Get.to(() => CommentPage());
                                          },
                                          child: const Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Comments",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Icon(Icons.comment, size: 32),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              );
            }
          })),
    );
  }
}

//UploadImage
class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // This ensures square corners
        side: BorderSide(
          color: Colors.white, // Adjust the color of the border as needed
          width: 2, // Adjust the width of the border as needed
        ),
      ),
      color: ColorApp.kSecondary,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: const Icon(
          Icons.picture_in_picture,
          color: Colors.white,
          size: 30,
        ),
        title: const Text(
          "Capture a Picture",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: const Text(
            "Report a problem with a image by clicking on capture",
            style: TextStyle(color: Colors.white)),
        trailing: MaterialButton(
            color: Colors.white,
            onPressed: () {
              Get.to(() => const PostImageView());
            },
            child: const Text("Capture")),
      ),
    );
  }
}
