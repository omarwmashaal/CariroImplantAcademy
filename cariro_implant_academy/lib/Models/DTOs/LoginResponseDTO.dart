import '../ApplicationUserModel.dart';

class LoginResponseDTO {
  String? token;
  String? role;
  ApplicationUserModel? user;

  LoginResponseDTO({this.token, this.role, this.user});

  LoginResponseDTO.fromJson(Map<String, dynamic> json) {
    token = json['token']??"";
    role = json['role']??"";
    user = json['user'] != null
        ? ApplicationUserModel.fromJson(json['user'])
        : ApplicationUserModel();
  }


}
