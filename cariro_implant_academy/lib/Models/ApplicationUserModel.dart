class ApplicationUserModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  String? graduatedFrom;
  String? classYear;
  String? speciality;
  String? maritalStatus;
  String? address;
  String? city;
  int? idInt;
  int? registeredById;
  ApplicationUserModel? registeredBy;
  String? registerationDate;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;

  ApplicationUserModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.graduatedFrom,
    this.classYear,
    this.speciality,
    this.maritalStatus,
    this.address,
    this.city,
    this.idInt,
    this.registeredById,
    this.registeredBy,
    this.registerationDate,
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  ApplicationUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    graduatedFrom = json['graduatedFrom'];
    classYear = json['classYear'];
    speciality = json['speciality'];
    maritalStatus = json['maritalStatus'];
    address = json['address'];
    city = json['city'];
    idInt = json['idInt'];
    registeredById = json['registeredById'];
    registeredBy = json['registeredBy'];
    registerationDate = json['registerationDate'];
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['graduatedFrom'] = this.graduatedFrom;
    data['classYear'] = this.classYear;
    data['speciality'] = this.speciality;
    data['maritalStatus'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['idInt'] = this.idInt;
    data['registeredById'] = this.registeredById;
    data['registeredBy'] = this.registeredBy;
    data['registerationDate'] = this.registerationDate;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;

    return data;
  }
}
