class MicrosoftAPI_Response {
  String? type;
  String? title;
  int? status;
  String? traceId;
  Map<String, dynamic>? errors;

  MicrosoftAPI_Response(
      {this.type, this.title, this.status, this.traceId, this.errors});

  MicrosoftAPI_Response.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    traceId = json['traceId'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['status'] = this.status;
    data['traceId'] = this.traceId;
    if (this.errors != null) {
      data['errors'] = this.errors!;
    }
    return data;
  }
}
