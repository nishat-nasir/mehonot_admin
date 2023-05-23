class WorkConModel {
  String? workStartDay;
  String? workFinishDay;
  String? wageType;
  String? period;

  @override
  WorkConModel({
    this.workStartDay,
    this.workFinishDay,
    this.wageType,
    this.period,
  });

  WorkConModel.fromJson(Map json) {
    workStartDay = json["workStartDay"] as String?;
    workFinishDay = json["workFinishDay"] as String?;
    wageType = json["wageType"] as String?;
    period = json["period"] as String?;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "workStartDay": workStartDay,
        "workFinishDay": workFinishDay,
        "wageType": wageType,
        "period": period,
      };
}
