import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/Job/job_md.dart';

import '../../../presentation/template/template.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Banner/banner_md.dart';
import '../states/ads_state.dart';

class AdsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetBannersAction:
        return _getBannersAction(store.state, action, next);
      case GetHomeJobAdsAction:
        return _getHomeJobAdsAction(store.state, action, next);

      case GetCreateBannersAction:
        return _getCreateBannersAction(store.state, action, next);

      case GetPostHomeJobAdsAction:
        return _getPostHomeJobAdsAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

Future<bool> _getBannersAction(
    AppState state, GetBannersAction action, NextDispatcher next) async {
  try {
    logger("GetBannersAction -- Called");

    List<BannerModel> allHomeBanners = [];
    List<BannerModel> allSettingBanners = [];

    CollectionReference settingsAdsCollection = firebaseKit.bannersCollection;

    await settingsAdsCollection.get().then((value) {
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
          images: e['images'],
          companyName: e['companyName'],
          createdAt: e['createdAt'],
          postedById: e['postedById'],
          removeAt: e['removeAt'],
        );
        if (bannerModel.bannerType == "home") {
          allHomeBanners.add(bannerModel);
        } else {
          allSettingBanners.add(bannerModel);
        }
      }).toList();
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeBanners: allHomeBanners,
        settingBanner: allSettingBanners,
      ),
    );
    return true;
  } catch (e) {
    logger(e.toString(), hint: "GetBannersAction CATCH ERROR");
    return false;
  }
}

Future<bool> _getHomeJobAdsAction(
    AppState state, GetHomeJobAdsAction action, NextDispatcher next) async {
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

Future<bool> _getCreateBannersAction(
    AppState state, GetCreateBannersAction action, NextDispatcher next) async {
  try {
    logger("GetCreateBannersAction -- Called");
    // Show loading
    String bannerUuid = generateHomeBannerUuid(
      division: state.userState.userProfileData.address.division,
      type: action.bannerType,
    );
    ////TODO: FOR Images
    // String? downUrl;
    // if (action.jobModelReqRes.images != null) {
    //   downUrl = await appStore.dispatch(GetImageDownloadLinkAction(
    //     action.jobModelReqRes.images!,
    //     postId: _jobUid,
    //     postType: _jobPostUid,
    //   ));
    // }

    CollectionReference createBannerAdsCollection =
        firebaseKit.bannersCollection;

    await createBannerAdsCollection.doc(bannerUuid).set({
      "id": bannerUuid,
      "title": action.bannerModel.title,
      "companyName": action.bannerModel.companyName,
      "postedById": state.userState.userData.userId,
      "email": action.bannerModel.email,
      "phone": action.bannerModel.phone,
      "images": action.bannerModel.images,
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

_getPostHomeJobAdsAction(
    AppState state, GetPostHomeJobAdsAction action, NextDispatcher next) async {
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
