class API_Response {
  Object? result;
  String? errorMessage;
  int? statusCode;

  API_Response({this.result, this.errorMessage, this.statusCode});

  API_Response.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}
