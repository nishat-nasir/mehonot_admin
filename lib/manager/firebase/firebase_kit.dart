import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseKit firebaseKit = FirebaseKit();

class FirebaseKit {
  // For User purpose
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection(fbUsersCl);

  // For Ad & Notice purpose
  final CollectionReference noticeCollection =
  FirebaseFirestore.instance.collection(fbNoticeCl);
  final CollectionReference bannersCollection =
  FirebaseFirestore.instance.collection(fbBannersCl);

  //For Job Requests lists Puspose
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
}

const fbNoticeCl = "NOTICE";

const fbBannersCl = "BANNERS";
const fbAdsJobsCl = "ADS_JOBS";
const fbReqJobCl = "REQ_JOBS";

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
