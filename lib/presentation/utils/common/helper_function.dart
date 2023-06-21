import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import '../../../manager/firebase/firebase_kit.dart';
import '../../../manager/redux/states/init_state.dart';
import '../../template/template.dart';
import '../constants.dart';
import 'log_tester.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<bool> fbDeleteBannerImg({required String postImageId}) async {
  try {
    final url = FirebaseStorage.instance.refFromURL(postImageId);
    await url.delete();
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'FBDELETEIMG CATCH ERROR');
    return false;
  }
}

Future<String?> fbUploadCompanyLogoAndGetLink(
    {required File imageFile, required String postImageId}) async {
  try {
    final reference = FirebaseStorage.instance
        .ref("$fbCompanyLogoImgStorageFolderName/$postImageId");
    final uploadTask = reference.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      logger('Image upload failed', hint: 'fbUploadImgAndGetLink');
      return null;
    }
  } catch (e) {
    logger(e.toString(),
        hint: 'fbUploadCompanyLogoAndGetLink CATCH ERROR'.toUpperCase());
    return null;
  }
}

Future<String?> fbUploadJobImgAndGetLink({
  required File imageFile,
  required String postImageId,
}) async {
  try {
    final reference = FirebaseStorage.instance
        .ref("$fbJobImagesJobStorageFolderName/$postImageId");
    final uploadTask = reference.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      logger('Image upload failed', hint: 'fbUploadImgAndGetLink');
      return null;
    }
  } catch (e) {
    logger(e.toString(), hint: 'FB_UPLOAD_IMG_AND_GET_LINK CATCH ERROR');
    return null;
  }
}

Future<void> fbDeleteJobImg({required String imageId}) async {
  Uri uri = Uri.parse(imageId);
  String fullPath = uri.path;
  String decodedPath = Uri.decodeComponent(fullPath);
  String fileName = decodedPath.substring(decodedPath.lastIndexOf('/') + 1);
  try {
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref(fbJobImagesJobStorageFolderName);
    final ref = storageRef.child(fileName);
    await ref.delete();
    logger('File deleted successfully');
  } catch (e) {
    logger('Error IMG DELETE file: $e');
  }
}

Future<void> fbDeleteCompanyLogo({required String logoId}) async {
  Uri uri = Uri.parse(logoId);
  String fullPath = uri.path;
  String decodedPath = Uri.decodeComponent(fullPath);
  String fileName = decodedPath.substring(decodedPath.lastIndexOf('/') + 1);
  try {
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref(fbCompanyLogoImgStorageFolderName);
    final ref = storageRef.child(fileName);
    await ref.delete();
    logger('File deleted successfully');
  } catch (e) {
    logger('Error LOGO DELETE file: $e');
  }
}

Future<String?> fbUploadBannerImgAndGetLink({
  required File imageFile,
  required String postImageId,
}) async {
  try {
    final reference = FirebaseStorage.instance
        .ref("$fbJobImagesBannerStorageFolderName/$postImageId");
    final uploadTask = reference.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      logger('Image upload failed', hint: 'fbUploadImgAndGetLink');
      return null;
    }
  } catch (e) {
    logger(e.toString(), hint: 'FB_UPLOAD_IMG_AND_GET_LINK CATCH ERROR');
    return null;
  }
}

Future<File?> compressImageFunc(File file) async {
  File compressedFile = File(file.path);
  int fileSize = compressedFile.lengthSync();
  if (fileSize <= 3 * 1024 * 1024) {
    return file;
  }
  double quality = 0.8;
  int attempts = 0;
  while (fileSize > 3 * 1024 * 1024 && attempts < 5) {
    attempts++;
    XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
      compressedFile.path,
      compressedFile.path,
      quality: (quality * 100).round(),
      minHeight: 1920,
      minWidth: 1080,
    );
    if (compressedImage != null) {
      compressedFile = File(compressedImage.path);
      fileSize = compressedFile.lengthSync();
      quality -= 0.1;
    } else {
      break;
    }
  }
  if (fileSize > 3 * 1024 * 1024) {
    return null;
  } else {
    return compressedFile;
  }
}

String calculateDuration(Timestamp timestamp, BuildContext context) {
  final postDate = timestamp.toDate();
  final now = DateTime.now();
  final difference = now.difference(postDate).inDays;
  if (difference > 30) {
    return DateFormat('yyyy-MM-dd').format(postDate);
  }
  if (difference == 0) {
    return S(context).todayStr;
  } else if (difference == 1) {
    return S(context).yesterdayStr;
  } else {
    return '$difference ${S(context).daysAgoStr}';
  }
}

checkConnectivity({required BuildContext context}) async {
  bool availableInternet = await appStore
      .dispatch(GetInternetConnectionCheckAction(context: context));
  if (availableInternet) {
    return;
  } else {
    if (context.mounted) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                  title: Text(S(context).noInternet),
                  content: Text(S(context).noInternetCheck),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          bool haveInternet = await appStore.dispatch(
                              GetInternetConnectionCheckAction(
                                  context: context));
                          if (!haveInternet) {
                            return;
                          } else {
                            if (context.mounted) {
                              context.popRoute();
                            }
                          }
                        },
                        child: Text(S(context).refresh)),
                  ]));
    }
  }
}

String formatWages(num value) {
  if (value == 0) {
    return '';
  } else if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}K';
  } else {
    return value.toString();
  }
}

String calculateRemainingTime(
    {required Timestamp deadline, required BuildContext context}) {
  DateTime now = DateTime.now();
  DateTime deadlineDate = deadline.toDate();
  Duration remainingDuration = deadlineDate.difference(now);
  if (remainingDuration.isNegative) {
    return S(context).deadlineHasPassed;
  }
  if (remainingDuration.inDays >= 30) {
    int months = (remainingDuration.inDays / 30).floor();
    return '$months ${S(context).monthLeft}';
  } else if (remainingDuration.inDays >= 7) {
    int weeks = (remainingDuration.inDays / 7).floor();
    return '$weeks ${S(context).weekLeft}';
  } else {
    return '${remainingDuration.inDays} ${S(context).dayLeft}';
  }
}

int calculateRemainingTimeInDays(Timestamp deadline) {
  DateTime now = DateTime.now();
  DateTime deadlineDate = deadline.toDate();
  Duration remainingDuration = deadlineDate.difference(now);
  if (remainingDuration.isNegative) {
    return 0;
  }
  return remainingDuration.inDays;
}

JobStatus getStatus(String status) {
  switch (status) {
    case "pending":
      return JobStatus.pending;
    case "published":
      return JobStatus.published;
    case "rejected":
      return JobStatus.rejected;
    case "expired":
      return JobStatus.expired;
    case "completed":
      return JobStatus.completed;
    case "cancelled":
      return JobStatus.cancelled;
    case "deleted":
      return JobStatus.deleted;
    case "resubmitted":
      return JobStatus.resubmitted;
    case "supplement":
      return JobStatus.supplement;
    case "test":
      return JobStatus.test;
    default:
      throw Exception("Invalid status: $status");
  }
}

trLocationName({required String locationName, required BuildContext context}) {
  switch (locationName) {
    case 'Dhaka':
      return S(context).divDhk;
    case 'Chittagong':
      return S(context).divCtg;
    case 'Sylhet':
      return S(context).divSyl;
    case 'Khulna':
      return S(context).divKhl;
    case 'Barisal':
      return S(context).divBar;
    case 'Rajshahi':
      return S(context).divRaj;
    case 'Rangpur':
      return S(context).divRng;
    case 'Mymensingh':
      return S(context).divMym;
    default:
      return S(context).divDhk;
  }
}

trJobType({required String jobType, required BuildContext context}) {
  switch (jobType) {
    case 'Full Time':
      return S(context).fullTimeStr;
    case 'Part Time':
      return S(context).partTimeStr;
    case 'Contractual':
      return S(context).contractualStr;
    case 'Internship':
      return S(context).internshipStr;
    case 'Volunteer':
      return S(context).volunteerStr;
    case 'Remote':
      return S(context).remoteStr;
    default:
      return jobType;
  }
}

trPaymentType({required String paymentType, required BuildContext context}) {
  switch (paymentType) {
    case 'Hourly':
      return S(context).hourlyStr;
    case 'Daily':
      return S(context).dailyStr;
    case 'Weekly':
      return S(context).weeklyStr;
    case 'Monthly':
      return S(context).monthlyStr;
    case 'Yearly':
      return S(context).yearlyStr;
    default:
      return paymentType;
  }
}

trDayType({required String day, required BuildContext context}) {
  switch (day) {
    case 'Mon':
      return S(context).monStr;
    case 'Tue':
      return S(context).tueStr;
    case 'Wed':
      return S(context).wedStr;
    case 'Thu':
      return S(context).thuStr;
    case 'Fri':
      return S(context).friStr;
    case 'Sat':
      return S(context).satStr;
    case 'Sun':
      return S(context).sunStr;
    default:
      return day;
  }
}
