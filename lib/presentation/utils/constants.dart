import '../../manager/models/codes_model.dart';
import '../../manager/models/resume/education_md.dart';
import '../../manager/models/resume/experience_md.dart';
import '../../manager/models/resume/skill_md.dart';

class Constants {
  static const String appName = 'ADMIN';

  static Codes locationsBd() =>
      Codes.from({
        '01': 'Dhaka',
        '02': 'Chittagong',
        '03': 'Khulna',
        '04': 'Rajshahi',
        '05': 'Barisal',
        '06': 'Sylhet',
        '07': 'Rangpur',
        '08': 'Mymensingh',
      });

  static const localUserIdKey = "USERIDKEY";
  static const ENCRYTORKEY = "N7YI4KQ3UETGOEMOBTEG3BDJACI0LW==";

  ////////////////////////////////
  ////////////////////////////////

  static List<String> jobPeriodList = [
    "N/A",
    "1 Month",
    "2 Months",
    "3 Months",
    "6 Months",
    "12 Months",
    "24 Months"
  ];

  static List<String> jobEducationList = [
    "N/A",
    "SSC",
    "HSC",
    "Diploma",
    "Bachelor",
    "Master",
    "PhD",
    "None"
  ];

  static List<String> jobPaymentTypeList = [
    "Hourly",
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly"
  ];

  static List<Division> jobDivisionList = [
    Division.Dhaka,
    Division.Chittagong,
    Division.Rajshahi,
    Division.Sylhet,
    Division.Barisal,
    Division.Rangpur,
    Division.Khulna,
    Division.Mymensingh
  ];

  static List<String> daysList = [
    "Sat",
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
  ];

  static List<String> jobTypeList = [
    "Part Time",
    "One day",
    "Internship",
    "Full Time",
  ];

  static List<String> jobPersonnelList = [
    "1 person",
    "2 persons",
    "3 persons",
    "4 persons",
    "5 persons",
    "6 persons",
    "7 persons",
    "8 persons",
    "9 + persons",
  ];


  static Division currentlySelectedDivision = Division.Dhaka;
}

enum Division {
  Dhaka,
  Chittagong,
  Khulna,
  Rajshahi,
  Barisal,
  Sylhet,
  Rangpur,
  Mymensingh
}
