class AttachmentModel {
  late String label;
  late int path;
  late String size;

  AttachmentModel({this.label = '', this.path = -1, this.size = ''});

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    label = json['label'] ?? '';
    path = json['path'] ?? -1;
    size = json['size'] ?? '';
  }
}
