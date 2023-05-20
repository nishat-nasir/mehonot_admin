import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../presentation/template/template.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Sponsor/sponsor_md.dart';
import '../states/ads_state.dart';

class AdsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      case GetSettingsAdsAction:
        return _getSettingsAdsAction(store.state, action, next);
      case GetHomeMidAdsAction:
        return _getHomeMidAdsAction(store.state, action, next);
      case GetHomeTopAdsAction:
        return _getHomeTopAdsAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}

_getSettingsAdsAction(
    AppState state, GetSettingsAdsAction action, NextDispatcher next) async {
  try {
    logger("GetSettingsAdsAction -- Called");

    List<SponsorModel> allSettingsAds = [];

    CollectionReference settingsAdsCollection =
        firebaseKit.settingsBannersCollection;
    await settingsAdsCollection.get().then((value) {
      value.docs.map((e) {
        SponsorModel jobSponsorModel = SponsorModel(
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
        allSettingsAds.add(jobSponsorModel);
      }).toList();
      return allSettingsAds;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        settingsAds: allSettingsAds,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetSettingsAdsAction CATCH ERROR");
    return false;
  }
}

_getHomeMidAdsAction(
    AppState state, GetHomeMidAdsAction action, NextDispatcher next) async {
  try {
    logger("GetHomeMidAdsAction -- Called");

    List<SponsorModel> allHomeMidAds = [];

    CollectionReference homeMidAdsCollection = firebaseKit.midBannersCollection;
    await homeMidAdsCollection.get().then((value) {
      value.docs.map((e) {
        SponsorModel jobSponsorModel = SponsorModel(
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
        allHomeMidAds.add(jobSponsorModel);
      }).toList();
      return allHomeMidAds;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeMidAds: allHomeMidAds,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetHomeMidAdsAction CATCH ERROR");
    return false;
  }
}

_getHomeTopAdsAction(
    AppState state, GetHomeTopAdsAction action, NextDispatcher next) async {
  try {
    logger("GetHomeTopAdsAction -- Called");
    List<SponsorModel> allHomeTopAds = [];

    CollectionReference homeTopAdsCollection = firebaseKit.topBannersCollection;
    await homeTopAdsCollection.get().then((value) {
      value.docs.map((e) {
        SponsorModel jobSponsorModel = SponsorModel(
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
        allHomeTopAds.add(jobSponsorModel);
      }).toList();
      return allHomeTopAds;
    });
    await appStore.dispatch(
      UpdateAdsStateAction(
        homeTopAds: allHomeTopAds,
      ),
    );
  } catch (e) {
    logger(e.toString(), hint: "GetHomeTopAdsAction CATCH ERROR");
    return false;
  }
}
