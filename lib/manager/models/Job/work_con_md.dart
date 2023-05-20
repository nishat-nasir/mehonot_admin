class WorkConModel {
  String? workStartDay;
  String? workFinishDay;
  double? wageAmount;
  String? wageType;
  String? period;

  @override
  WorkConModel({
    this.workStartDay,
    this.workFinishDay,
    this.wageAmount,
    this.wageType,
    this.period,
  });

  WorkConModel.fromJson(Map json) {
    workStartDay = json["workStartDay"] as String?;
    workFinishDay = json["workFinishDay"] as String?;
    wageAmount = json["wageAmount"] as double?;
    wageType = json["wageType"] as String?;
    period = json["period"] as String?;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "workStartDay": workStartDay,
        "workFinishDay": workFinishDay,
        "wageAmount": wageAmount,
        "wageType": wageType,
        "period": period,
      };
}
