class LabPriceForDoctorEntity {
  final int optionId;
  int price;
  final int? doctorId;

  LabPriceForDoctorEntity({required this.doctorId, required this.optionId, required this.price});
}
