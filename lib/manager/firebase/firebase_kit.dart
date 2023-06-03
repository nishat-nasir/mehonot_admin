import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseKit firebaseKit = FirebaseKit();

class FirebaseKit {
  // For User purpose
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection(fbUsersCl);

  final CollectionReference usersProfilesCollection =
  FirebaseFirestore.instance.collection(fbUserProfileFbCl);

  // For Ad & Notice purpose
  final CollectionReference noticeCollection =
  FirebaseFirestore.instance.collection(fbNoticeCl);

  final CollectionReference homeBannersCollection =
  FirebaseFirestore.instance.collection(fbHomeBannersCl);
  final CollectionReference settingsBannersCollection =
  FirebaseFirestore.instance.collection(fbSettingBannersCl);

  //For Job Requests lists Purpose
  final CollectionReference adsJobsCollection =
  FirebaseFirestore.instance.collection(fbAdsJobsCl);

  final CollectionReference requestedJobsCollection =
  FirebaseFirestore.instance.collection(fbReqJobCl);

  // For Job Category purpose
  final CollectionReference categoriesCollection =
  FirebaseFirestore.instance.collection(fbCategoriesCl);

  // For Job Place purpose
  final CollectionReference barisalJobsCollection =
  FirebaseFirestore.instance.collection(fbBslJobsCl);
  final CollectionReference chittagongJobsCollection =
  FirebaseFirestore.instance.collection(fbCtgJobsCl);
  final CollectionReference dhakaJobsCollection =
  FirebaseFirestore.instance.collection(fbDhkJobsCl);
  final CollectionReference khulnaJobsCollection =
  FirebaseFirestore.instance.collection(fbKhlJobsCl);
  final CollectionReference mymensinghJobsCollection =
  FirebaseFirestore.instance.collection(fbMymJobsCl);
  final CollectionReference rajshahiJobsCollection =
  FirebaseFirestore.instance.collection(fbRjsJobsCl);
  final CollectionReference rangpurJobsCollection =
  FirebaseFirestore.instance.collection(fbRngJobsCl);
  final CollectionReference sylhetJobsCollection =
  FirebaseFirestore.instance.collection(fbShlJobsCl);

  // For Feedback purpose
  final CollectionReference feedbackCollection =
  FirebaseFirestore.instance.collection(fbFeedbackCl);
}

const fbNoticeCl = "NOTICE";

const fbHomeBannersCl = "HOME_BANNERS";
const fbSettingBannersCl = "SETG_BANNERS";
const fbAdsJobsCl = "ADS_JOBS";
const fbReqJobCl = "REQ_JOBS";
const fbFeedbackCl = "FEEDBACK";

const fbCategoriesCl = "CATEGORIES";
const fbDhkJobsCl = "DHK_JOBS";
const fbCtgJobsCl = "CTG_JOBS";
const fbKhlJobsCl = "KHL_JOBS";
const fbRjsJobsCl = "RAJ_JOBS";
const fbBslJobsCl = "BAR_JOBS";
const fbShlJobsCl = "SYL_JOBS";
const fbRngJobsCl = "RNG_JOBS";
const fbMymJobsCl = "MYM_JOBS";

const fbUsersCl = "USERS";
const fbUserProfileFbCl = "USERS_PROFILES";

const fbJobImagesBannerStorageFolderName = "BANNER_IMAGES";
const fbJobImagesJobStorageFolderName = "JOB_IMAGES";

const String userProfileJobRelationsFbDb = "JOB_RELATIONS";
const String jobDetailsFbDb = "JOB_DETAILS";

const String jobAdsDocId = "k7Y7EOc2O2dqp0QkCfgr";
