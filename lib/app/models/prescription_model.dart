class PrescriptionModel {
  int? id;
  String? recipeCode;
  int? doctorId;
  String? status;
  String? date;
  int? customerId;
  String? recipeContent;

  PrescriptionModel(
      {this.id,
      this.recipeCode,
      this.doctorId,
      this.status,
      this.date,
      this.customerId,
      this.recipeContent});

      
}
