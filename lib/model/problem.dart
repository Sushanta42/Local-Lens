class ProblemModel {
  ProblemModel({
    required this.timestamp,
    required this.location,
    required this.description,
    required this.category,
    required this.suggestion,
    required this.image,
    required this.id,
  });

  final DateTime? timestamp;
  final List<String> location;
  final String? description;
  final String? category;
  final dynamic? suggestion;
  final String? image;
  final String? id;

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      location: json["location"] == null
          ? []
          : List<String>.from(json["location"]!.map((x) => x)),
      description: json["description"],
      category: json["category"],
      suggestion: json["suggestion"],
      image: json["image"],
      id: json["id"],
    );
  }
}

class SuggestionElement {
  SuggestionElement({
    required this.timestamp,
    required this.content,
  });

  final DateTime? timestamp;
  final String? content;

  factory SuggestionElement.fromJson(Map<String, dynamic> json) {
    return SuggestionElement(
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      content: json["content"],
    );
  }
}

class PurpleSuggestion {
  PurpleSuggestion({required this.json});
  final Map<String, dynamic> json;

  factory PurpleSuggestion.fromJson(Map<String, dynamic> json) {
    return PurpleSuggestion(json: json);
  }
}
