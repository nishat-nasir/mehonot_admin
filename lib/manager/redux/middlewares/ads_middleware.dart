import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/common/helper_function.dart';
import '../../../presentation/utils/constants.dart';
import '../../firebase/firebase_kit.dart';
import '../../../manager/models/Ads/banner_ads/banner_md.dart';
import '../../models/Ads/job_ads/job_ads_ids_md.dart';
import '../states/ads_state.dart';
import 'jobs_middleware .dart';

class AdsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetHomeBannersAction:
        return _getHomeBannersAction(store.state, action, next);
      case GetSettingsBannersAction:
        return _getSettingsBannersAction(store.state, action, next);
      case GetCreateBannersAction:
        return _getCreateBannersAction(store.state, action, next);
      case GetUpdatedBannersAction:
        return _getUpdatedBannersAction(store.state, action, next);

      case GetJobAdsIdsAction:
        return _getJobAdsIdsAction(store.state, action, next);
      case GetJobAdsDetailAction:
        return _getJobAdsDetailAction(store.state, action, next);
      case GetCreateJobAdsAction:
        return _getCreateJobAdsAction(store.state, action, next);
      case GetRemoveJobAdsAction:
        return _getRemoveJobAdsAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

Future<bool> _getHomeBannersAction(AppState state, GetHomeBannersAction action,
    NextDispatcher next) async {
  try {
    logger("GetHomeBannersAction -- Called");

    List<BannerModel> allHomeBanners = [];

    CollectionReference homeBannerCollection =
        firebaseKit.homeBannersCollection;

    await homeBannerCollection.get().then((value) {
      value.docs.map((e) {
        BannerModel bannerModel = BannerModel(
          id: e.id,
          title: e['title'],
          website: e['website'],
          phone: e['phone'],
          email: e['email'],
          description: e['description'],
          category: e['category'],
          bannerType: e['bannerType'],
          image: e['image'],
          companyName: e['companyName'],
          createdAt: e['createdAt'],
          postedById: e['postedById'],
          startAt: e['startAt'],
          removeAt: e['removeAt'],
        );
        allHomeBanners.add(bannerModel);
      }).toList();
    });
    logger("GetSettingsBannersAction ---- ${allHomeBanners.length}");
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeBanners: allHomeBanners,
      ),
    );
    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetHomeBannersAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getSettingsBannersAction(AppState state,
    GetSettingsBannersAction action, NextDispatcher next) async {
  try {
    logger("GetSettingsBannersAction -- Called");

    List<BannerModel> allSettingsBanners = [];

    CollectionReference settingBannerCollection =
        firebaseKit.settingsBannersCollection;

    await settingBannerCollection.get().then((value) {
      value.docs.map((e) {
        BannerModel bannerModel = BannerModel(
          id: e.id,
          title: e['title'],
          website: e['website'],
          phone: e['phone'],
          email: e['email'],
          description: e['description'],
          category: e['category'],
          bannerType: e['bannerType'],
          image: e['image'],
          companyName: e['companyName'],
          createdAt: e['createdAt'],
          startAt: e['startAt'],
          postedById: e['postedById'],
          removeAt: e['removeAt'],
        );
        allSettingsBanners.add(bannerModel);
      }).toList();
    });
    logger("GetSettingsBannersAction ---- ${allSettingsBanners.length}");
    await appStore
        .dispatch(UpdateAdsStateAction(settingBanner: allSettingsBanners));
    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetSettingsBannersAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getJobAdsIdsAction(AppState state,
    GetJobAdsIdsAction action, NextDispatcher next) async {
  try {
    logger("GetJobAdsIdsAction -- Called");

    JobAdsIdsMd jobAdsIdsModel = JobAdsIdsMd(
      dhakaJobAds: [],
      chittagongJobAds: [],
      rajshahiJobAds: [],
      khulnaJobAds: [],
      barisalJobAds: [],
      sylhetJobAds: [],
      rangpurJobAds: [],
      mymensinghJobAds: [],
    );

    CollectionReference jobAdsIdsCollection =
        firebaseKit.adsJobsCollection;

    await jobAdsIdsCollection.doc("jobAdsIds").get().then((value) {
      jobAdsIdsModel = JobAdsIdsMd(
        dhakaJobAds: value['dhkJobAds'] ?? [],
        chittagongJobAds: value['khlJobAds'] ?? [],
        rajshahiJobAds: value['rajJobAds'] ?? [],
        khulnaJobAds: value['rngJobAds'] ?? [],
        barisalJobAds: value['sylJobAds'] ?? [],
        sylhetJobAds: value['barJobAds'] ?? [],
        rangpurJobAds: value['ctgJobAds'] ?? [],
        mymensinghJobAds: value['mymJobAds'] ?? [],
      );
    });

    await appStore.dispatch(UpdateAdsStateAction(allJobAdsIds: jobAdsIdsModel));

    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetJobAdsIdsAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getJobAdsDetailAction(AppState state,
    GetJobAdsDetailAction action,
    NextDispatcher next) async {
  try {
    logger("GetJobAdsDetailAction -- Called");

    List<String> curLocAds = [];
    List<JobModel> allAds = [];

    CollectionReference jobFromDivision =
    getDivisionCollection(action.division);

    switch (action.division) {
      case Division.Dhaka:
        curLocAds = state.adsState.allJobAdsIds.dhakaJobAds ?? [];
        break;
      case Division.Chittagong:
        curLocAds = state.adsState.allJobAdsIds.chittagongJobAds ?? [];
        break;
      case Division.Rajshahi:
        curLocAds = state.adsState.allJobAdsIds.rajshahiJobAds ?? [];
        break;
      case Division.Khulna:
        curLocAds = state.adsState.allJobAdsIds.khulnaJobAds ?? [];
        break;
      case Division.Barisal:
        curLocAds = state.adsState.allJobAdsIds.barisalJobAds ?? [];
        break;
      case Division.Sylhet:
        curLocAds = state.adsState.allJobAdsIds.sylhetJobAds ?? [];
        break;
      case Division.Rangpur:
        curLocAds = state.adsState.allJobAdsIds.rangpurJobAds ?? [];
        break;
      case Division.Mymensingh:
        curLocAds = state.adsState.allJobAdsIds.mymensinghJobAds ?? [];
        break;
    }

    for (int i = 0; i < curLocAds.length; i++) {
      JobModel job = await jobFromDivision
          .doc(curLocAds[i])
          .get()
          .then((value) {
        JobModel jobModel = JobModel(
          jobId: value['jobId'],
          postedByUserId: value['postedByUserId'],
          workStartTime: value['workStartTime'],
          workFinishTime: value['workFinishTime'],
          address: value['address'],
          type: value['type'],
          status: value['status'],
          companyName: value['companyName'],
          title: value['title'],
          timestamp: value['timestamp'],
          wageAmount: value['wageAmount'],
          jobDetailsId: value['jobDetailsId'],
          images: value['images'],
        );
        return jobModel;
      });
      allAds.add(job);
    }

    switch (action.division) {
      case Division.Dhaka:
        await appStore.dispatch(UpdateAdsStateAction(
          dhakaJobAds: allAds,
        ));
        break;
      case Division.Chittagong:
        await appStore.dispatch(UpdateAdsStateAction(
          chittagongJobAds: allAds,
        ));
        break;
      case Division.Rajshahi:
        await appStore.dispatch(UpdateAdsStateAction(
          rajshahiJobAds: allAds,
        ));
        break;
      case Division.Khulna:
        await appStore.dispatch(UpdateAdsStateAction(
          khulnaJobAds: allAds,
        ));
        break;
      case Division.Barisal:
        await appStore.dispatch(UpdateAdsStateAction(
          barisalJobAds: allAds,
        ));
        break;
      case Division.Sylhet:
        await appStore.dispatch(UpdateAdsStateAction(
          sylhetJobAds: allAds,
        ));
        break;
      case Division.Rangpur:
        await appStore.dispatch(UpdateAdsStateAction(
          rangpurJobAds: allAds,
        ));
        break;
      case Division.Mymensingh:
        await appStore.dispatch(UpdateAdsStateAction(
          mymensinghJobAds: allAds,
        ));
        break;
    }

    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetJobAdsDetailAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getCreateBannersAction(AppState state,
    GetCreateBannersAction action, NextDispatcher next) async {
  try {
    logger("GetCreateBannersAction -- Called");
    // Show loading
    String bannerUuid = generateHomeBannerUuid(
      division: action.division.name,
      type: action.bannerType,
    );

    File? imageToUpload = await compressImageFunc(action.bannerImg);

    String? imageUrl;

    final jobImgId =
    generateBannerImageName(bannerType: action.bannerModel.bannerType);

    if (imageToUpload != null) {
      String? imgLink = await fbUploadBannerImgAndGetLink(
        imageFile: imageToUpload,
        postImageId: jobImgId,
      );
      if (imgLink != null) {
        imageUrl = imgLink;
        logger('Image Upload Success $imgLink');
      } else {
        logger('Image Upload Failed');
      }
    }

    CollectionReference createBannerAdsCollection;

    if (action.bannerType == "home") {
      createBannerAdsCollection = firebaseKit.homeBannersCollection;
    } else {
      createBannerAdsCollection = firebaseKit.settingsBannersCollection;
    }

    await createBannerAdsCollection.doc(bannerUuid).set({
      "id": bannerUuid,
      "title": action.bannerModel.title,
      "companyName": action.bannerModel.companyName,
      "postedById": state.userState.userData.userId,
      "email": action.bannerModel.email,
      "phone": action.bannerModel.phone,
      "image": imageUrl ?? "",
      "description": action.bannerModel.description,
      "website": action.bannerModel.website,
      "bannerType": action.bannerModel.bannerType,
      "category": action.bannerModel.category,
      "createdAt": DateTime.now(),
      "startAt": action.bannerModel.startAt,
      "removeAt":
      Timestamp.fromDate(DateTime.now().add(const Duration(days: 60))),
    });
    return true;

    //TODO: Next version add my ads
  } catch (e) {
    logger(e.toString(), hint: "GetCreateBannersAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getUpdatedBannersAction(AppState state,
    GetUpdatedBannersAction action, NextDispatcher next) async {
  try {
    logger("GetUpdatedBannersAction -- Called");
    // Show loading

    String bannerUuid = generateHomeBannerUuid(
      division: action.division.name,
      type: action.bannerType,
    );

    if (action.imageUrlsToDelete != null &&
        action.imageUrlsToDelete!.isNotEmpty) {
      for (int i = 0; i < action.imageUrlsToDelete!.length; i++) {
        await fbDeleteJobImg(postImageId: action.imageUrlsToDelete![i]);
      }
    }

    final imageUrls = <String>[];

    if (action.imageFilesToAdd != null && action.imageFilesToAdd!.isNotEmpty) {
      List<File?> imageToUpload = [];

      for (int i = 0; i < action.imageFilesToAdd!.length; i++) {
        imageToUpload.add(await compressImageFunc(action.imageFilesToAdd![i]));
      }

      for (int i = 0; i < imageToUpload.length; i++) {
        logger('Image Files_count: ${imageToUpload.length}');
        logger(bannerUuid);

        String? imgLink = await fbUploadJobImgAndGetLink(
          imageFile: imageToUpload[i]!,
          postImageId: bannerUuid,
        );
        if (imgLink != null) {
          imageUrls.add(imgLink);
          logger('Image Upload Success $imgLink');
        } else {
          logger('Image Upload Failed');
        }
      }
    }

    imageUrls.addAll(action.imageUrlsToAdd ?? []);

    CollectionReference createBannerAdsCollection;
    if (action.bannerType == "home") {
      createBannerAdsCollection = firebaseKit.homeBannersCollection;
    } else {
      createBannerAdsCollection = firebaseKit.settingsBannersCollection;
    }

    await createBannerAdsCollection.doc(bannerUuid).update({
      "title": action.bannerModel.title,
      "companyName": action.bannerModel.companyName,
      "postedById": state.userState.userData.userId,
      "email": action.bannerModel.email,
      "phone": action.bannerModel.phone,
      "image": imageUrls,
      "description": action.bannerModel.description,
      "website": action.bannerModel.website,
      "bannerType": action.bannerModel.bannerType,
      "category": action.bannerModel.category,
      "removeAt":
      Timestamp.fromDate(DateTime.now().add(const Duration(days: 60))),
    });
    return true;

    //TODO: Next version add my ads
  } catch (e) {
    logger(e.toString(), hint: "GetUpdatedBannersAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getCreateJobAdsAction(AppState state,
    GetCreateJobAdsAction action, NextDispatcher next) async {
  try {
    logger("GetCreateJobAdsAction -- Called");
    CollectionReference createAdsJobsCollection = firebaseKit.adsJobsCollection;

    switch (action.division) {
      case Division.Dhaka:
        await createAdsJobsCollection.doc().update({
          "dhkJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Khulna:
        await createAdsJobsCollection.doc().update({
          "khlJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Rajshahi:
        await createAdsJobsCollection.doc().update({
          "rajJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Rangpur:
        await createAdsJobsCollection.doc().update({
          "rngJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Sylhet:
        await createAdsJobsCollection.doc().update({
          "sylJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Barisal:
        await createAdsJobsCollection.doc().update({
          "barJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Chittagong:
        await createAdsJobsCollection.doc().update({
          "ctgJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
      case Division.Mymensingh:
        await createAdsJobsCollection.doc().update({
          "mymJobAds": FieldValue.arrayUnion([action.jobId]),
        });
        break;
    }

    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetCreateSettingBannerAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getRemoveJobAdsAction(AppState state,
    GetRemoveJobAdsAction action, NextDispatcher next) async {
  try {
    logger("GetRemoveJobAdsAction -- Called");
    CollectionReference createAdsJobsCollection = firebaseKit.adsJobsCollection;

    switch (action.division) {
      case Division.Dhaka:
        await createAdsJobsCollection.doc().update({
          "dhkJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Khulna:
        await createAdsJobsCollection.doc().update({
          "khlJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Rajshahi:
        await createAdsJobsCollection.doc().update({
          "rajJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Rangpur:
        await createAdsJobsCollection.doc().update({
          "rngJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Sylhet:
        await createAdsJobsCollection.doc().update({
          "sylJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Barisal:
        await createAdsJobsCollection.doc().update({
          "barJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Chittagong:
        await createAdsJobsCollection.doc().update({
          "ctgJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
      case Division.Mymensingh:
        await createAdsJobsCollection.doc().update({
          "mymJobAds": FieldValue.arrayRemove([action.jobId]),
        });
        break;
    }

    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetCreateSettingBannerAction CATCH ERROR");
    return false;
  }
}
