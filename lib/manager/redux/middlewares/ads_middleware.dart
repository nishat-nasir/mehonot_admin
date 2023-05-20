import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../presentation/template/template.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Sponsor/sponsor_md.dart';
import '../states/ads_state.dart';

class AdsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetSettingBannersAction:
        return _getSettingBannersAction(store.state, action, next);
      case GetHomeJobAdsAction:
        return _getHomeJobAdsAction(store.state, action, next);
      case GetHomeBannersAction:
        return _getHomeBannersAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

_getSettingBannersAction(
    AppState state, GetSettingBannersAction action, NextDispatcher next) async {
  try {
    logger("GetSettingBannersAction -- Called");

    List<BannerModel> allSettingsBanners = [];

    CollectionReference settingsAdsCollection =
        firebaseKit.settingsBannersCollection;
    await settingsAdsCollection.get().then((value) {
      value.docs.map((e) {
        BannerModel bannerModel = BannerModel(
          // jobId: e["jobId"],
          website: e['website'],
          phone: e['phone'],
          email: e['email'],
          description: e['description'],
          category: e['category'],
          type: e['type'],
          images: e['images'],
          companyName: e['companyName'],
          address: e['address'],
          title: e['title'],
          posterName: e['posterName'],
          time: e['time'],
        );
        allSettingsBanners.add(bannerModel);
      }).toList();
      return allSettingsBanners;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        settingsAds: allSettingsBanners,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetSettingBannersAction CATCH ERROR");
    return false;
  }
}

_getHomeJobAdsAction(
    AppState state, GetHomeJobAdsAction action, NextDispatcher next) async {
  try {
    logger("GetHomeJobAdsAction -- Called");

    List<BannerModel> allHomeJobAdds = [];

    CollectionReference homeMidAdsCollection = firebaseKit.midBannersCollection;
    await homeMidAdsCollection.get().then((value) {
      value.docs.map((e) {
        BannerModel bannerModel = BannerModel(
          // jobId: e["jobId"],
          website: e['website'],
          phone: e['phone'],
          email: e['email'],
          description: e['description'],
          category: e['category'],
          type: e['type'],
          images: e['images'],
          companyName: e['companyName'],
          address: e['address'],
          title: e['title'],
          posterName: e['posterName'],
          time: e['time'],
        );
        allHomeJobAdds.add(bannerModel);
      }).toList();
      return allHomeJobAdds;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeMidAds: allHomeJobAdds,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetHomeJobAdsAction CATCH ERROR");
    return false;
  }
}

_getHomeBannersAction(
    AppState state, GetHomeBannersAction action, NextDispatcher next) async {
  try {
    logger("GetHomeBannersAction -- Called");
    List<BannerModel> allHomeBanners = [];

    CollectionReference homeTopAdsCollection = firebaseKit.topBannersCollection;
    await homeTopAdsCollection.get().then((value) {
      value.docs.map((e) {
        BannerModel bannerModel = BannerModel(
          // jobId: e["jobId"],
          website: e['website'],
          phone: e['phone'],
          email: e['email'],
          description: e['description'],
          category: e['category'],
          type: e['type'],
          images: e['images'],
          companyName: e['companyName'],
          address: e['address'],
          title: e['title'],
          posterName: e['posterName'],
          time: e['time'],
        );
        allHomeBanners.add(bannerModel);
      }).toList();
      return allHomeBanners;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeTopAds: allHomeBanners,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetHomeBannersAction CATCH ERROR");
    return false;
  }
}
