class InternetHelpDetailModel {
  InternetHelpDetailModel({
    required this.image,
    required this.content,
  });
  late final String? image;
  late final String? content;

  InternetHelpDetailModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    content = json['content'];
  }
}
