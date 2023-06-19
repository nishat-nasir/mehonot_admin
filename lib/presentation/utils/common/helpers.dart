import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mehonot_admin/presentation/utils/constants.dart';
import 'package:uuid/uuid.dart';
import '../../../generated/rf_fit/l10n.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'dart:math';

final now = DateTime.now();
final currentDateAndTime =
    "${now.year}.${now.month}.${now.day}T${now.hour}.${now.minute}.${now.second}";
final currentDate = "${now.year}.${now.month}.${now.day}";

/////////////////////// USER RELATED ///////////////////////

final key = enc.Key.fromUtf8(Constants.ENCRYTORKEY);
final iv = enc.IV.fromLength(16);
final aes = enc.AES(key, padding: null);
final encryptor = enc.Encrypter(aes);
const userUuid = Uuid();

AppIntl S(BuildContext context) => AppIntl.of(context);

extension intl_helper on BuildContext {
  AppIntl get intl => AppIntl.of(this);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

// Try not to use it
SnackBar snackBar(snackBarText) => SnackBar(
      content: Text(snackBarText),
    );

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

String generateUserUuid() {
  final uid = userUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String userIdFormat = "USER_${dt}_$uid";
  return userIdFormat;
}

String generateUserProfileUuid() {
  final uid = userUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String userIdFormat = "USER_DTL_${dt}_$uid";
  return userIdFormat;
}

String generateUserProfileJobRelationUuid() {
  final uid = userUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String userIdFormat = "USER_DTL_JOBS_${dt}_$uid";
  return userIdFormat;
}

String encryptToken(String token) {
  return encryptor.encrypt(token, iv: iv).base64;
}

String decryptToken(String encrypted) {
  final String decStr =
      encryptor.decrypt(enc.Encrypted.from64(encrypted), iv: iv);
  return decStr;
}

///////////////// JOB RELATED ///////////////////////

const jobUuid = Uuid();

//Division.Dhaka_2023.3.16_23889e40-c3e0-11ed-a2a3-ad4fcaeb771a

String generateJobUuidForReq({required String division}) {
  // final uid = jobUuid.v1();
  // String dt = currentDate.replaceAll(".", "_");
  // String jobIdFormat = "${(division).toLowerCase()}_${dt}_$uid";

  String timestamp = DateTime.now().toUtc().toIso8601String();
  String jobUid = '${division}_${timestamp}_req';
  return jobUid;
}

String generateJobUuid({required String division}) {
  final uid = jobUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String jobIdFormat = "${(division).toLowerCase()}_${dt}_$uid";
  return jobIdFormat;
}

//DTL_Division.Dhaka_2023.3.16_2388c550-c3e0-11ed-a2a3-ad4fcaeb771a
String generateJobDetailsUuid({required String division}) {
  final uid = jobUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String jobDetailsIdFormat = "dtl_${(division).toLowerCase()}_${dt}_$uid";
  return jobDetailsIdFormat;
}

String generateJobImageName({required String division}) {
  // Implement your own logic to generate a unique name for the image file
  // Example code: return a combination of current timestamp and a random number
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String randomNumber = Random().nextInt(10000).toString();
  return 'img_${division.toLowerCase()}_job_$timestamp$randomNumber.jpg';
}

String generateBannerImageName({required String bannerType}) {
  // Implement your own logic to generate a unique name for the image file
  // Example code: return a combination of current timestamp and a random number
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String randomNumber = Random().nextInt(10000).toString();
  return 'img_${bannerType.toLowerCase()}_banner_$timestamp$randomNumber.jpg';
}

String generateCompanyLogImageName(
    {required String companyName, required String division}) {
  // Implement your own logic to generate a unique name for the image file
  // Example code: return a combination of current timestamp and a random number
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String randomNumber = Random().nextInt(10000).toString();
  return 'logo${division.toLowerCase()}_${companyName.replaceAll(" ", "_")}_$timestamp$randomNumber.jpg';
}

///////////////// BANNER RELATED ///////////////////////

const bannerUuid = Uuid();

//Dhaka_home_ad_2023.3.16_23889e40-c3e0-11ed-a2a3-ad4fcaeb771a
String generateHomeBannerUuid(
    {required String division, required String type}) {
  final uid = bannerUuid.v1();
  String dt = currentDate.replaceAll(".", "_");
  String jobIdFormat = "${(division).toLowerCase()}_${type}_ad_$uid";
  return jobIdFormat;
}

/////////////////// COMMON ///////////////////////

convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
  TimeOfDay val = timeOfDay;
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, val.hour, val.minute);
}

TimeOfDay convertDateTimeToTimeOfDay(DateTime dateTime) {
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

DateTime convertStringToDateTime(String dateTime) {
  return DateTime.parse(dateTime);
}

String convertDateTimeToTime(String dateTime) {
  return "${DateTime.parse(dateTime).hour}:${DateTime.parse(dateTime).minute}";
}

String convertTimeStampToTime(Timestamp timestamp) {
  return "${timestamp.toDate().hour}:${timestamp.toDate().minute}";
}

// convert string to timestamp
Timestamp convertStringToTimeStamp(String dateTime) {
  return Timestamp.fromDate(DateTime.parse(dateTime));
}

// get only date from timestamp String type
String convertTimeStampToDate(Timestamp timestamp) {
  return "${timestamp.toDate().year}.${timestamp.toDate().month}.${timestamp.toDate().day}";
}

showLoading() {
  // showLoadingDialog(Global.navState!.context);
}

closeLoading() {
  // appStore.dispatch(DismissPopupAction(all: true));
}

Division convertStringToDivision(String division) {
  Division location;
  switch (division) {
    case "Dhaka":
      location = Division.Dhaka;
      break;
    case "Chittagong":
      location = Division.Chittagong;
      break;
    case "Khulna":
      location = Division.Khulna;
      break;
    case "Rajshahi":
      location = Division.Rajshahi;
      break;
    case "Barisal":
      location = Division.Barisal;
      break;
    case "Sylhet":
      location = Division.Sylhet;
      break;
    case "Rangpur":
      location = Division.Rangpur;
      break;
    case "Mymensingh":
      location = Division.Mymensingh;
      break;
    default:
      location = Division.Dhaka;
  }
  return location;
}

String convertDivisionToString(Division division) {
  String location;
  switch (division) {
    case Division.Dhaka:
      location = "Dhaka";
      break;
    case Division.Chittagong:
      location = "Chittagong";
      break;
    case Division.Khulna:
      location = "Khulna";
      break;
    case Division.Rajshahi:
      location = "Rajshahi";
      break;
    case Division.Barisal:
      location = "Barisal";
      break;
    case Division.Sylhet:
      location = "Sylhet";
      break;
    case Division.Rangpur:
      location = "Rangpur";
      break;
    case Division.Mymensingh:
      location = "Mymensingh";
      break;
    default:
      location = "Dhaka";
  }
  return location;
}
