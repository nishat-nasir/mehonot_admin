import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mehonot_admin/manager/models/Address/address_md.dart';
import 'package:mehonot_admin/manager/models/Job/job_dtl_md.dart';
import 'package:mehonot_admin/manager/models/Job/recruit_con_md.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../firebase/firebase_kit.dart';
import '../../models/Job/job_md.dart';
import '../../models/Job/work_con_md.dart';
import '../states/account_state.dart';
import '../states/jobs_state.dart';
import 'package:uuid/uuid.dart';

class JobsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    switch (action.runtimeType) {
      //----------------- GET Location -----------------
      case GetLocationAction:
        return _getLocationAction(store.state, action, next);

      //----------------- GET JOBS -----------------
      case GetJobsAction:
        return _getJobsAction(store.state, action, next);
      case GetJobDataByIdAction:
        return _getJobDataByIdAction(store.state, action, next);

      //----------------- GET JOB DETAILS -----------------
      case GetJobDetailsAction:
        return _getJobDetailsAction(store.state, action, next);
      case GetUpdateJobAction:
        return _getUpdateJobAction(store.state, action, next);
      case GetDeleteJobAction:
        return _getDeleteJobAction(store.state, action, next);
      case GetJobSearchAction:
        return _getJobSearchAction(store.state, action, next);

      //  --------------- GET REQ JOB  -----------------
      case GetCreateJobReqAction:
        return _getCreateJobReqAction(store.state, action, next);
      case GetCreateJobAction:
        return _getCreateJobAction(store.state, action, next);
      case GetReqJobsAction:
        return _getReqJobsAction(store.state, action, next);
      case GetReqJobDetailsAction:
        return _getReqJobDetailsAction(store.state, action, next);
      case GetAcceptReqJobAction:
        return _getAcceptReqJobAction(store.state, action, next);

      default:
        return next(action);
    }
  }
}

// ------------------------------------------------------------------------------

Future<Division> _getLocationAction(
    AppState state, GetLocationAction action, NextDispatcher next) async {
  Division curDiv = convertStringToDivision(action.divisionString);
  next(UpdateJobsStateAction(currentDivision: curDiv));
  return curDiv;
}

Future<bool> _getJobsAction(
    AppState state, GetJobsAction action, NextDispatcher next) async {
  try {
    logger("GetJobsAction -- Called");
    List<JobModel> allJobs = [];

    CollectionReference jobFromDivision =
        getDivisionCollection(action.division);

    await jobFromDivision.get().then((value) {
      value.docs.map((e) {
        logger(e.data(), hint: 'GetJobsAction MAP DATA');
        JobModel job = JobModel(
          jobId: e["jobId"],
          jobDetailsId: e["jobDetailsId"],
          title: e["title"],
          address: AddressModel(
            division: e["address"]["division"],
            district: e["address"]["district"],
            area: e["address"]["area"],
            city: e["address"]["city"],
          ),
          companyName: e["companyName"],
          images: e["images"],
          type: e["type"],
          workFinishTime: e["workFinishTime"],
          workStartTime: e["workStartTime"],
          postedByUserId: e["postedByUserId"],
          status: e["status"],
          wageAmount: e["wageAmount"],
          timestamp: e["timestamp"],
        );
        allJobs.add(job);
      }).toList();
      return allJobs;
    });

    switch (action.division) {
      case Division.Dhaka:
        appStore.dispatch(UpdateJobsStateAction(
          dhakaJobs: allJobs,
        ));
        break;
      case Division.Chittagong:
        appStore.dispatch(UpdateJobsStateAction(
          chittagongJobs: allJobs,
        ));
        break;
      case Division.Khulna:
        appStore.dispatch(UpdateJobsStateAction(
          khulnaJobs: allJobs,
        ));
        break;
      case Division.Rajshahi:
        appStore.dispatch(UpdateJobsStateAction(
          rajshahiJobs: allJobs,
        ));
        break;
      case Division.Barisal:
        appStore.dispatch(UpdateJobsStateAction(
          barisalJobs: allJobs,
        ));
        break;
      case Division.Sylhet:
        appStore.dispatch(UpdateJobsStateAction(
          sylhetJobs: allJobs,
        ));
        break;
      case Division.Rangpur:
        appStore.dispatch(UpdateJobsStateAction(
          rangpurJobs: allJobs,
        ));
        break;
      case Division.Mymensingh:
        appStore.dispatch(UpdateJobsStateAction(
          mymensinghJobs: allJobs,
        ));
        break;
      default:
        appStore.dispatch(UpdateJobsStateAction(
          dhakaJobs: allJobs,
        ));
    }

    appStore.dispatch(UpdateJobsStateAction(
      currentLocationJobsList: allJobs,
    ));

    // TODO:
    // HomeController.to.updateJobsOfCurrentLoc(allJobs);
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobsAction CATCH ERROR');
    return false;
  }
}

Future<JobModel?> _getJobDataByIdAction(
    AppState state, GetJobDataByIdAction action, NextDispatcher next) async {
  try {
    logger("GetJobDataByIdAction -- Called");
    // Fetch Job Data by action.jobDivision and action.jobId

    JobModel? jobModel;

    CollectionReference jobFromDivision =
        getDivisionCollection(action.jobDivision);

    await jobFromDivision.doc(action.jobId).get().then((value) {
      logger(value.data(), hint: 'GetJobDataByIdAction MAP DATA');
      jobModel = JobModel(
        jobId: value["jobId"],
        jobDetailsId: value["jobDetailsId"],
        title: value["title"],
        address: AddressModel(
          division: value["address"]["division"],
          district: value["address"]["district"],
          area: value["address"]["area"],
          city: value["address"]["city"],
        ),
        companyName: value["companyName"],
        images: value["images"],
        type: value["type"],
        workFinishTime: value["workFinishTime"],
        workStartTime: value["workStartTime"],
        postedByUserId: value["postedByUserId"],
        status: value["status"],
        timestamp: value["timestamp"],
        wageAmount: value["wageAmount"],
      );
    });

    return jobModel;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobDataByIdAction CATCH ERROR');
    return null;
  }
}

// ------------------------------------------------------------------------------

Future<bool> _getJobDetailsAction(
    AppState state, GetJobDetailsAction action, NextDispatcher next) async {
  try {
    logger("GetJobDetailsAction -- Called");

    JobDetailModel jobDetailModel;

    CollectionReference jobFromDivision =
        getDivisionCollection(action.division);

    jobDetailModel = await jobFromDivision
        .doc(action.jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobDetailsId)
        .get()
        .then((value) {
      logger(value.data());
      return jobDetailModel = JobDetailModel(
        jobId: value["jobId"],
        phone: value["phone"],
        jobDetailsId: value["jobDetailsId"],
        category: value["category"],
        description: value["description"],
        email: value["email"],
        website: value["website"],
        workCondition: WorkConModel(
          period: value["workCondition"]["period"],
          wageType: value["workCondition"]["wageType"],
          workFinishDay: value["workCondition"]["workFinishDay"],
          workStartDay: value["workCondition"]["workStartDay"],
        ),
        recruitCondition: RecruitConModel(
          personnel: value["recruitCondition"]["personnel"],
          gender: value["recruitCondition"]["gender"],
          deadline: value["recruitCondition"]["deadline"],
          age: value["recruitCondition"]["age"],
          education: value["recruitCondition"]["education"],
        ),
        ownerName: value["ownerName"],
        moreDetails: value["moreDetails"],
      );
    });

    appStore.dispatch(UpdateJobsStateAction(
      selectedJobDetailModel: jobDetailModel,
    ));
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobDetailsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getReqJobsAction(
    AppState state, GetReqJobsAction action, NextDispatcher next) async {
  try {
    logger("GetReqJobsAction -- Called");

    List<JobModel> allReqJobs = [];

    CollectionReference requestedJobsCollection =
        FirebaseKit().requestedJobsCollection;

    await requestedJobsCollection.get().then((value) {
      logger(value.docs);
      value.docs.map((e) {
        JobModel job = JobModel(
          jobId: e["jobId"],
          jobDetailsId: e["jobDetailsId"],
          title: e["title"],
          address: AddressModel(
            division: e["address"]["division"],
            district: e["address"]["district"],
            area: e["address"]["area"],
            city: e["address"]["city"],
          ),
          companyName: e["companyName"],
          // Convert from List<dynamic> to List<String>, also check null or empty
          images: e["images"] != null && e["images"].isNotEmpty
              ? List<String>.from(e["images"].map((e) => e.toString()))
              : [],

          type: e["type"],
          workFinishTime: e["workFinishTime"],
          workStartTime: e["workStartTime"],
          postedByUserId: e["postedByUserId"],
          status: e["status"],
          timestamp: e["timestamp"],
          wageAmount: e["wageAmount"],
        );
        allReqJobs.add(job);
      }).toList();
    });

    appStore.dispatch(UpdateJobsStateAction(
      allRequestedJobs: allReqJobs,
    ));
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetReqJobsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateJobReqAction(
    AppState state, GetCreateJobReqAction action, NextDispatcher next) async {
  try {
    logger("GetCreateJobReqAction -- Called");
    // Show loading
    String jobUid = generateJobUuid(
      division: action.jobModelReq.address.division,
    );
    String jobDetailsUid =
        generateJobDetailsUuid(division: action.jobModelReq.address.division);

    ////TODO: FOR Images
    // String? downUrl;
    // if (action.jobModelReqRes.images != null) {
    //   downUrl = await appStore.dispatch(GetImageDownloadLinkAction(
    //     action.jobModelReqRes.images!,
    //     postId: _jobUid,
    //     postType: _jobPostUid,
    //   ));
    // }

    CollectionReference requestedJobsCollection =
        FirebaseKit().requestedJobsCollection;

    await requestedJobsCollection.doc(jobUid).set({
      "jobId": jobUid,
      "jobDetailsId": jobDetailsUid,
      "postedByUserId": action.jobModelReq.postedByUserId,
      "title": action.jobModelReq.title,
      "companyName": action.jobModelReq.companyName,
      "images": action.jobModelReq.images,
      "address": action.jobModelReq.address.toJson(),
      "type": action.jobModelReq.type,
      "workStartTime": action.jobModelReq.workStartTime,
      "workFinishTime": action.jobModelReq.workFinishTime,
      "status": action.jobModelReq.status,
      "wageAmount": action.jobModelReq.wageAmount,
    });
    logger('Job Created');

    await requestedJobsCollection
        .doc(jobUid)
        .collection(jobDetailsFbDb)
        .doc(jobDetailsUid)
        .set({
      "jobId": jobUid,
      "jobDetailsId": jobDetailsUid,
      "category": action.jobDetailModelReq.category,
      "createdAt": action.jobDetailModelReq.createdAt,
      "description": action.jobDetailModelReq.description,
      "email": action.jobDetailModelReq.email,
      "ownerName": action.jobDetailModelReq.ownerName,
      "phone": action.jobDetailModelReq.phone,
      "recruitCondition": action.jobDetailModelReq.recruitCondition!.toJson(),
      "website": action.jobDetailModelReq.website,
      "workCondition": action.jobDetailModelReq.workCondition!.toJson(),
      "moreDetails": action.jobDetailModelReq.moreDetails,
      "appliedBy": action.jobDetailModelReq.appliedBy
    });
    // Update "myJobsIds" in user profile
    await appStore.dispatch(GetAddToMyJobsIdsAction(
      jobId: jobUid,
    ));
    //TODO: ADD JOB STATUS
    // await appStore.dispatch(GetUpdateUserAction(postId: _postUid));
    // closeLoading();
    return true;
  } catch (e) {
    // closeLoading();
    logger(e.toString(), hint: 'GetCreateJobReqAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getAcceptReqJobAction(
    AppState state, GetAcceptReqJobAction action, NextDispatcher next) async {
  try {
    logger("GetAcceptReqJobAction -- Called");
    JobDetailModel jobDetailModel;

    CollectionReference requestedJobColl =
        FirebaseKit().requestedJobsCollection;

    jobDetailModel = await requestedJobColl
        .doc(action.jobMd.jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobMd.jobDetailsId)
        .get()
        .then((value) {
      logger(value.data());
      return jobDetailModel = JobDetailModel(
        jobId: value["jobId"],
        phone: value["phone"],
        jobDetailsId: value["jobDetailsId"],
        category: value["category"],
        description: value["description"],
        email: value["email"],
        website: value["website"],
        workCondition: WorkConModel(
          period: value["workCondition"]["period"],
          wageType: value["workCondition"]["wageType"],
          workFinishDay: value["workCondition"]["workFinishDay"],
          workStartDay: value["workCondition"]["workStartDay"],
        ),
        recruitCondition: RecruitConModel(
          personnel: value["recruitCondition"]["personnel"],
          gender: value["recruitCondition"]["gender"],
          deadline: value["recruitCondition"]["deadline"],
          age: value["recruitCondition"]["age"],
          education: value["recruitCondition"]["education"],
        ),
        ownerName: value["ownerName"],
        moreDetails: value["moreDetails"],
      );
    });

    bool success = await appStore.dispatch(GetCreateJobAction(
        jobModel: action.jobMd, jobDetailModel: jobDetailModel));

    if (success) {
      await requestedJobColl
          .doc(action.jobMd.jobId)
          .collection(jobDetailsFbDb)
          .doc(action.jobMd.jobDetailsId)
          .delete();
      await requestedJobColl.doc(action.jobMd.jobId).delete();
    }

    //remove from state
    appStore.dispatch(UpdateJobsStateAction(
        allRequestedJobs: state.jobsState.allRequestedJobs
            .where((element) => element.jobId != action.jobMd.jobId)
            .toList()));

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetAcceptReqJobAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getReqJobDetailsAction(
    AppState state, GetReqJobDetailsAction action, NextDispatcher next) async {
  try {
    logger("GetJobDetailsAction -- Called");

    JobDetailModel jobDetailModel;

    CollectionReference jobFromDivision = FirebaseKit().requestedJobsCollection;

    jobDetailModel = await jobFromDivision
        .doc(action.jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobDetailsId)
        .get()
        .then((value) {
      logger(value.data());
      return jobDetailModel = JobDetailModel(
        jobId: value["jobId"],
        phone: value["phone"],
        jobDetailsId: value["jobDetailsId"],
        category: value["category"],
        description: value["description"],
        email: value["email"],
        website: value["website"],
        workCondition: WorkConModel(
          period: value["workCondition"]["period"],
          wageType: value["workCondition"]["wageType"],
          workFinishDay: value["workCondition"]["workFinishDay"],
          workStartDay: value["workCondition"]["workStartDay"],
        ),
        recruitCondition: RecruitConModel(
          personnel: value["recruitCondition"]["personnel"],
          gender: value["recruitCondition"]["gender"],
          deadline: value["recruitCondition"]["deadline"],
          age: value["recruitCondition"]["age"],
          education: value["recruitCondition"]["education"],
        ),
        ownerName: value["ownerName"],
        moreDetails: value["moreDetails"],
      );
    });

    appStore.dispatch(UpdateJobsStateAction(
      selectedJobDetailModel: jobDetailModel,
    ));
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobDetailsAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getCreateJobAction(
    AppState state, GetCreateJobAction action, NextDispatcher next) async {
  try {
    logger("GetCreateJobAction -- Called");

    Division division =
        convertStringToDivision(action.jobModel.address.division);

    CollectionReference jobFromDivision = getDivisionCollection(division);

    String newJobId() {
      String input = action.jobModel.jobId;
      const suffix = '_req';
      if (input.endsWith(suffix)) {
        return input.substring(0, input.length - suffix.length);
      }
      return input;
    }

    await jobFromDivision.doc(newJobId()).set({
      "jobId": newJobId(),
      "jobDetailsId": action.jobModel.jobDetailsId,
      "postedByUserId": action.jobModel.postedByUserId,
      "title": action.jobModel.title,
      "companyName": action.jobModel.companyName,
      "images": action.jobModel.images,
      "address": action.jobModel.address.toJson(),
      "type": action.jobModel.type,
      "workStartTime": action.jobModel.workStartTime,
      "workFinishTime": action.jobModel.workFinishTime,
      "status": "published",
      "timestamp": action.jobModel.timestamp,
      "wageAmount": action.jobModel.wageAmount,
    });
    logger('Job Created');

    await jobFromDivision
        .doc(newJobId())
        .collection(jobDetailsFbDb)
        .doc(action.jobModel.jobDetailsId)
        .set({
      "jobId": newJobId(),
      "jobDetailsId": action.jobModel.jobDetailsId,
      "category": "",
      "description": action.jobDetailModel.description,
      "email": action.jobDetailModel.email,
      "ownerName": action.jobDetailModel.ownerName,
      "phone": action.jobDetailModel.phone,
      "recruitCondition": action.jobDetailModel.recruitCondition.toJson(),
      "website": action.jobDetailModel.website,
      "workCondition": action.jobDetailModel.workCondition.toJson(),
      "moreDetails": action.jobDetailModel.moreDetails,
      "appliedBy": action.jobDetailModel.appliedBy
    });
    // Update "myJobsIds" in user profile

    //Do not need because it is already updated just update the status
    // await appStore.dispatch(GetAddToMyJobsIdsAction(
    //   jobId: action.jobModel.jobId,
    // ));

    // await appStore.dispatch(GetUpdateUserAction(postId: _postUid));
    // closeLoading();
    return true;
  } catch (e) {
    // closeLoading();
    logger(e.toString(), hint: 'GetCreateProductAction CATCH ERROR');
    return false;
  }
}

_getUpdateJobAction(
    AppState state, GetUpdateJobAction action, NextDispatcher next) async {
  try {
    logger("GetUpdateJobAction -- Called");

    Division division =
        convertStringToDivision(action.jobModel.address.division);

    CollectionReference jobFromDivisionCollection =
        getDivisionCollection(division);

    await jobFromDivisionCollection.doc(action.jobModel.jobId).update({
      // "jobId": action.jobModel.jobId,
      "title": action.jobModel.title,
      // "companyName": action.jobModel.companyName,
      "images": action.jobModel.images,
      "address": action.jobModel.address.toJson(),
      "type": action.jobModel.type,
      "workStartTime": action.jobModel.workStartTime.toString(),
      "workFinishTime": action.jobModel.workFinishTime.toString(),
    }).then((value) async {
      await jobFromDivisionCollection
          .doc(action.jobModel.jobId)
          .collection(jobDetailsFbDb)
          .doc(action.jobDetailModel.jobDetailsId)
          .update({
        // "jobId": action.jobModel.jobId,
        // "jobDetailsId": action.jobDetailModel.jobDetailsId,
        "category": action.jobDetailModel.category,
        "description": action.jobDetailModel.description,
        "email": action.jobDetailModel.email,
        // "ownerName": action.jobDetailModel.ownerName,
        "phone": action.jobDetailModel.phone,
        "recruitCondition": action.jobDetailModel.recruitCondition.toJson(),
        "website": action.jobDetailModel.website,
        "workCondition": action.jobDetailModel.workCondition.toJson(),
      });
    });
  } catch (e) {
    logger(e.toString(), hint: 'GetUpdateJobAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getDeleteJobAction(
    AppState state, GetDeleteJobAction action, NextDispatcher next) async {
  try {
    String jobId = action.jobId;

    CollectionReference jobFromDivisionCollection =
        getDivisionCollection(action.division);

    await jobFromDivisionCollection
        .doc(jobId)
        .collection(jobDetailsFbDb)
        .doc(action.jobDetailsId)
        .delete()
        .then((value) async {
      await jobFromDivisionCollection.doc(jobId).delete().then((value) async {
        // remove job from state.jobsState.currentLocationJobsList
        List<JobModel> currentLocationJobsList =
            state.jobsState.currentLocationJobsList;

        currentLocationJobsList
            .removeWhere((element) => element.jobId == jobId);

        appStore.dispatch(UpdateJobsStateAction(
          currentLocationJobsList: currentLocationJobsList,
        ));

        switch (action.division) {
          case Division.Dhaka:
            appStore.dispatch(UpdateJobsStateAction(
              dhakaJobs: currentLocationJobsList,
            ));
            break;
          case Division.Chittagong:
            appStore.dispatch(UpdateJobsStateAction(
              chittagongJobs: currentLocationJobsList,
            ));
            break;
          case Division.Khulna:
            appStore.dispatch(UpdateJobsStateAction(
              khulnaJobs: currentLocationJobsList,
            ));
            break;
          case Division.Rajshahi:
            appStore.dispatch(UpdateJobsStateAction(
              rajshahiJobs: currentLocationJobsList,
            ));
            break;
          case Division.Barisal:
            appStore.dispatch(UpdateJobsStateAction(
              barisalJobs: currentLocationJobsList,
            ));
            break;
          case Division.Sylhet:
            appStore.dispatch(UpdateJobsStateAction(
              sylhetJobs: currentLocationJobsList,
            ));
            break;
          case Division.Rangpur:
            appStore.dispatch(UpdateJobsStateAction(
              rangpurJobs: currentLocationJobsList,
            ));
            break;
          case Division.Mymensingh:
            appStore.dispatch(UpdateJobsStateAction(
              mymensinghJobs: currentLocationJobsList,
            ));
            break;
        }
      });
    });
    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetDeleteJobAction CATCH ERROR');
    return false;
  }
}

Future<bool> _getJobSearchAction(
    AppState state, GetJobSearchAction action, NextDispatcher next) async {
  try {
    logger("GetJobSearchAction -- Called");
    next(UpdateJobsStateAction(searchJobList: []));

    CollectionReference jobFromDivisionCollection =
        getDivisionCollection(state.jobsState.currentDivision);

    List<JobModel> searchResult = [];

    await jobFromDivisionCollection
        .where("title", isGreaterThanOrEqualTo: action.searchText.toLowerCase())
        .where("title", isGreaterThanOrEqualTo: action.searchText.toUpperCase())
        .get()
        .then((value) {
      for (var element in value.docs) {
        searchResult
            .add(JobModel.fromJson(element.data() as Map<String, dynamic>));

        next(UpdateJobsStateAction(
          searchJobList: searchResult,
        ));
      }
    });

    appStore.dispatch(UpdateJobsStateAction(
      searchJobList: searchResult,
    ));

    return true;
  } catch (e) {
    logger(e.toString(), hint: 'GetJobSearchAction CATCH ERROR');
    return false;
  }
}

CollectionReference getDivisionCollection(Division division) {
  CollectionReference jobFromDivision;
  switch (division) {
    case Division.Dhaka:
      jobFromDivision = FirebaseKit().dhakaJobsCollection;
      break;
    case Division.Chittagong:
      jobFromDivision = FirebaseKit().chittagongJobsCollection;
      break;
    case Division.Khulna:
      jobFromDivision = FirebaseKit().khulnaJobsCollection;
      break;
    case Division.Rajshahi:
      jobFromDivision = FirebaseKit().rajshahiJobsCollection;
      break;
    case Division.Barisal:
      jobFromDivision = FirebaseKit().barisalJobsCollection;
      break;
    case Division.Sylhet:
      jobFromDivision = FirebaseKit().sylhetJobsCollection;
      break;
    case Division.Rangpur:
      jobFromDivision = FirebaseKit().rangpurJobsCollection;
      break;
    case Division.Mymensingh:
      jobFromDivision = FirebaseKit().mymensinghJobsCollection;
      break;
    default:
      jobFromDivision = FirebaseKit().dhakaJobsCollection;
  }
  return jobFromDivision;
}
