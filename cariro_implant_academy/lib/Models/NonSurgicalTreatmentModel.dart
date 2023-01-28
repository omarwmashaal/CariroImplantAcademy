class NonSurgicalTreatmentModelssss {
  int? ID;
  String? Date;
  String? Treatment;
  String? Operator;
  String? Supervisor;
  String? NextVisit;

  NonSurgicalTreatmentModelssss(
    this.ID,
    this.Date,
    this.Treatment,
    this.Operator,
    this.Supervisor,
    this.NextVisit,
  );

  static List<NonSurgicalTreatmentModelssss> models =
      <NonSurgicalTreatmentModelssss>[];
  static List<String> columns = [
    "ID",
    "Date",
    "Treatment",
    "Operator",
    "Supervisor",
    "Next Visit",
  ];
//NonSurgicalTreatmentDataSource dataSource = NonSurgicalTreatmentDataSource();

}
