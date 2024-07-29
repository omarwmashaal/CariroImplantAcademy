class InstallmentItemEntity {
  int? index;
  int? amount;
  int? paidAmount;
  bool? paid;
  DateTime? dueDate;
  DateTime? lastDateOfPayment;

  InstallmentItemEntity({
    this.index,
    this.amount,
    this.paidAmount,
    this.paid,
    this.dueDate,
    this.lastDateOfPayment,
  });
}
