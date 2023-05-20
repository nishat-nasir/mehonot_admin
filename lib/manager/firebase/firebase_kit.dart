import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseKit firebaseKit = FirebaseKit();

class FirebaseKit {
  // For User purpose
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(fbUsersCl);

  // final CollectionReference userProfileCollection =
  //     FirebaseFirestore.instance.collection(fbProfileCl);
  // final CollectionReference myJobsCollection =
  //     FirebaseFirestore.instance.collection(fbMyJobsCl);

  // For Ad & Notice purpose
  final CollectionReference noticeCollection =
      FirebaseFirestore.instance.collection(fbNoticeCl);
  final CollectionReference topBannersCollection =
      FirebaseFirestore.instance.collection(fbTopBannersCl);
  final CollectionReference settingsBannersCollection =
      FirebaseFirestore.instance.collection(fbSettingsBannersCl);
  final CollectionReference midBannersCollection =
      FirebaseFirestore.instance.collection(fbMidBannersCl);

  // For Job details purpose
  // final CollectionReference skillsCollection =
  //     FirebaseFirestore.instance.collection(fbSkillsCl);
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
}

const fbNoticeCl = "NOTICE";
const fbTopBannersCl = "BANNERS";
const fbSettingsBannersCl = "SETTINGS_BANNERS";
const fbMidBannersCl = "MID_BANNERS";

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

// const fbProfileCl = "USER_PROFILE";
// const fbSkillsCl = "SKILLS";
// const fbMyJobsCl = "MY_JOBS";

const String userProfileFbDb = "USER_PROFILE";
const String jobDetailsFbDb = "JOB_DETAILS";
