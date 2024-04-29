import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_lens/model/problem.dart';
import 'package:local_lens/util/api.dart';

class RemoteService {
  static Future<List<ProblemModel>> fetchProblems() async {
    try {
      var response = await Api.client.get(Uri.parse("${Api.baseUrl}/problems"));
      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body);
        if (jsonString is List) {
          // If the response is a list, map each item to a ProblemModel
          return jsonString.map((item) => ProblemModel.fromJson(item)).toList();
        } else {
          // Handle unexpected response format
          throw Exception("Unexpected response format");
        }
      } else {
        // Handle non-200 status code
        throw Exception("Failed to fetch problems: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any errors that occur during the fetch operation
      debugPrint("Error fetching problems: $e");
      throw e;
    }
  }

  static Future<void> postProblem({
    required String description,
    required String image,
    SuggestionElement? suggestion,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        "description": description,
        "image": image,
        "suggestion": suggestion,
      };

      var response = await Api.client.post(
        Uri.parse("${Api.baseUrl}/problems"),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to post problem: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any errors that occur during the post operation
      debugPrint("Error posting problem: $e");
      throw e;
    }
  }

  // Search Course Type
  static Future<List<dynamic>> fetchProblemById(String id) async {
    try {
      var response =
          await Api.client.get(Uri.parse("${Api.baseUrl}/problems/$id"));
      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body);
        if (jsonString is Map<String, dynamic>) {
          // If the suggestion is an object, convert it to a list with a single item
          jsonString['suggestion'] = jsonString['suggestion'] != null
              ? [jsonString['suggestion']]
              : null;
        }
        return [ProblemModel.fromJson(jsonString)];
      } else {
        throw Exception("Failed to fetch problem: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching problem: $e");
      throw e;
    }
  }

  // static Future fetchProblemById(String id) async {
  //   try {
  //     var response =
  //         await Api.client.get(Uri.parse("${Api.baseUrl}/problems/$id"));
  //     if (response.statusCode == 200) {
  //       var jsonString = json.decode(response.body);
  //       // Since we're fetching a single problem, we don't need to map it to a list
  //       return ProblemModel.fromJson(jsonString);
  //     } else {
  //       throw Exception("Failed to fetch problem: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching problem: $e");
  //     throw e;
  //   }
  // }
}
