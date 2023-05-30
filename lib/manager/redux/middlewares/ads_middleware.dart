import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/common/helper_function.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Banner/banner_md.dart';
import '../states/ads_state.dart';

class AdsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetHomeBannersAction:
        return _getHomeBannersAction(store.state, action, next);
      case GetSettingsBannersAction:
        return _getSettingsBannersAction(store.state, action, next);
      case GetHomeJobAdsAction:
        return _getHomeJobAdsAction(store.state, action, next);
      case GetCreateBannersAction:
        return _getCreateBannersAction(store.state, action, next);
      case GetUpdatedBannersAction:
        return _getUpdatedBannersAction(store.state, action, next);
      case GetPostHomeJobAdsAction:
        return _getPostHomeJobAdsAction(store.state, action, next);
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

Future<bool> _getHomeJobAdsAction(AppState state, GetHomeJobAdsAction action,
    NextDispatcher next) async {
  try {
    logger("GetHomeJobAdsAction -- Called");

    List<String> allHomeJobAdds = [];

    CollectionReference jobAdsCollection = firebaseKit.adsJobsCollection;
    await jobAdsCollection.get().then((value) {
      value.docs.map((e) {
        List<String> jobAds = e['jobAds'].cast<String>();
        allHomeJobAdds.addAll(jobAds);
      }).toList();
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        jobAds: allHomeJobAdds,
      ),
    );
    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetHomeJobAdsAction CATCH ERROR");
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
      "removeAt": DateTime.now().add(const Duration(days: 30)),
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
      "removeAt": DateTime.now().add(const Duration(days: 30)),
    });
    return true;

    //TODO: Next version add my ads
  } catch (e) {
    logger(e.toString(), hint: "GetUpdatedBannersAction CATCH ERROR");
    return false;
  }
}

_getPostHomeJobAdsAction(AppState state, GetPostHomeJobAdsAction action,
    NextDispatcher next) async {
  try {
    logger("GetPostHomeJobAdsAction -- Called");
    CollectionReference createAdsJobsCollection = firebaseKit.adsJobsCollection;

    await createAdsJobsCollection.doc().update({
      "jobIds": FieldValue.arrayUnion([action.jobId]),
    });
  } catch (e) {
    logger(e.toString(), hint: "GetCreateSettingBannerAction CATCH ERROR");
    return false;
  }
}
