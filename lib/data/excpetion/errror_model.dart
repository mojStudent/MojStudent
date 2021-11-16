class ApiErrorModel {
  ApiErrorModel({
    required this.code,
    required this.message,
  });
  late final int code;
  late final String message;


  ApiErrorModel.fromJson(Map<String, dynamic> json){
    json = json['error'];
    code = json['code'];
    message = json['message'];
  }
}