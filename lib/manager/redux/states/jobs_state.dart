import 'package:mehonot_admin/manager/hive_client.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../models/Job/ReqModels/job_dtl_md_req.dart';
import '../../models/Job/ReqModels/job_md_req.dart';
import '../../models/Job/job_dtl_md.dart';
import '../../models/Job/job_md.dart';
import '../../models/Job/recruit_con_md.dart';
import '../../models/Job/work_con_md.dart';

@immutable
class JobsState {
  final List<JobModel> dhakaJobs;
  final List<JobModel> chittagongJobs;
  final List<JobModel> khulnaJobs;
  final List<JobModel> rajshahiJobs;
  final List<JobModel> barisalJobs;
  final List<JobModel> sylhetJobs;
  final List<JobModel> rangpurJobs;
  final List<JobModel> mymensinghJobs;
  final List<JobModel> allRequestedJobs;

  final List<JobModel> currentLocationJobsList;
  final JobDetailModel selectedJobDetailModel;

  final List<JobModel> searchJobList;
  final Division currentDivision;

  const JobsState({
    required this.dhakaJobs,
    required this.chittagongJobs,
    required this.khulnaJobs,
    required this.rajshahiJobs,
    required this.barisalJobs,
    required this.sylhetJobs,
    required this.rangpurJobs,
    required this.mymensinghJobs,
    required this.allRequestedJobs,
    required this.currentLocationJobsList,
    required this.selectedJobDetailModel,
    required this.searchJobList,
    required this.currentDivision,
  });

  factory JobsState.initial() {
    return JobsState(
      dhakaJobs: const [],
      chittagongJobs: const [],
      khulnaJobs: const [],
      rajshahiJobs: const [],
      barisalJobs: const [],
      sylhetJobs: const [],
      rangpurJobs: const [],
      mymensinghJobs: const [],
      currentLocationJobsList: const [],
      allRequestedJobs: const [],
      selectedJobDetailModel: JobDetailModel(
        jobId: '',
        jobDetailsId: '',
        phone: '',
        ownerName: '',
        recruitCondition: RecruitConModel(
          deadline: Timestamp.now(),
          education: '',
          age: '',
          personnel: "1",
          gender: '',
        ),
        workCondition: WorkConModel(),
        website: '',
        email: '',
        description: '',
        images: [],
        moreDetails: '',
      ),
      searchJobList: const [],
      currentDivision: convertStringToDivision(
          HiveClient.getDivision() ?? Constants.jobDivisionList.first.name),
    );
  }

  JobsState copyWith({
    List<JobModel>? dhakaJobs,
    List<JobModel>? chittagongJobs,
    List<JobModel>? khulnaJobs,
    List<JobModel>? rajshahiJobs,
    List<JobModel>? barisalJobs,
    List<JobModel>? sylhetJobs,
    List<JobModel>? rangpurJobs,
    List<JobModel>? mymensinghJobs,
    List<JobModel>? allRequestedJobs,
    List<JobModel>? currentLocationJobsList,
    JobDetailModel? selectedJobDetailModel,
    List<JobModel>? searchJobList,
    Division? currentDivision,
  }) {
    return JobsState(
      dhakaJobs: dhakaJobs ?? this.dhakaJobs,
      chittagongJobs: chittagongJobs ?? this.chittagongJobs,
      khulnaJobs: khulnaJobs ?? this.khulnaJobs,
      rajshahiJobs: rajshahiJobs ?? this.rajshahiJobs,
      barisalJobs: barisalJobs ?? this.barisalJobs,
      sylhetJobs: sylhetJobs ?? this.sylhetJobs,
      rangpurJobs: rangpurJobs ?? this.rangpurJobs,
      mymensinghJobs: mymensinghJobs ?? this.mymensinghJobs,
      allRequestedJobs: allRequestedJobs ?? this.allRequestedJobs,
      currentLocationJobsList:
          currentLocationJobsList ?? this.currentLocationJobsList,
      selectedJobDetailModel:
          selectedJobDetailModel ?? this.selectedJobDetailModel,
      searchJobList: searchJobList ?? this.searchJobList,
      currentDivision: currentDivision ?? this.currentDivision,
    );
  }
}

///------------------Update Jobs Action ---------
class UpdateJobsStateAction {
  List<JobModel>? dhakaJobs;
  List<JobModel>? chittagongJobs;
  List<JobModel>? khulnaJobs;
  List<JobModel>? rajshahiJobs;
  List<JobModel>? barisalJobs;
  List<JobModel>? sylhetJobs;
  List<JobModel>? rangpurJobs;
  List<JobModel>? mymensinghJobs;
  List<JobModel>? allRequestedJobs;
  List<JobModel>? currentLocationJobsList;
  JobDetailModel? selectedJobDetailModel;
  List<JobModel>? searchJobList;
  Division? currentDivision;

  UpdateJobsStateAction({
    this.dhakaJobs,
    this.chittagongJobs,
    this.khulnaJobs,
    this.rajshahiJobs,
    this.barisalJobs,
    this.sylhetJobs,
    this.rangpurJobs,
    this.mymensinghJobs,
    this.allRequestedJobs,
    this.currentLocationJobsList,
    this.selectedJobDetailModel,
    this.searchJobList,
    this.currentDivision,
  });
}

///------------------Jobs Action ---------

class GetJobsAction {
  final Division division;
  String? lastDocumentId;

  GetJobsAction({
    required this.division,
    this.lastDocumentId,
  });
}

class GetJobDataByIdAction {
  final Division jobDivision;
  final String jobId;

  GetJobDataByIdAction({
    required this.jobDivision,
    required this.jobId,
  });
}

class GetJobDetailsAction {
  final Division division;
  final String jobId;
  final String jobDetailsId;

  GetJobDetailsAction({
    required this.division,
    required this.jobId,
    required this.jobDetailsId,
  });
}

class GetCreateJobReqAction {
  final JobModelReq jobModelReq;
  final JobDetailModelReq jobDetailModelReq;
  List<File>? imageFiles;
  File? companyLogoImg;

  GetCreateJobReqAction({
    required this.jobModelReq,
    required this.jobDetailModelReq,
    this.imageFiles,
    this.companyLogoImg,
  });
}

class GetCreateJobAction {
  final JobModel jobModel;
  final JobDetailModel jobDetailModel;

  GetCreateJobAction({
    required this.jobModel,
    required this.jobDetailModel,
  });
}

class GetUpdateJobAction {
  final JobModel jobModel;
  final JobDetailModel jobDetailModel;
  List<File>? imageFilesToAdd;
  List<String>? imageUrlsToAdd;
  List<String>? imageUrlsToDelete;

  GetUpdateJobAction({
    required this.jobModel,
    required this.jobDetailModel,
    this.imageFilesToAdd,
    this.imageUrlsToAdd,
    this.imageUrlsToDelete,
  });
}

class GetDeleteJobAction {
  JobModel jobModel;
  JobDetailModel jobDetailModel;

  GetDeleteJobAction({required this.jobModel, required this.jobDetailModel});
}

class GetJobSearchAction {
  final String searchText;
  final List<String> searchCategory;

  GetJobSearchAction({
    required this.searchText,
    required this.searchCategory,
  });
}

class GetLocationAction {
  String divisionString;

  GetLocationAction({
    required this.divisionString,
  });
}

class GetReqJobsAction {
  GetReqJobsAction();
}

class GetReqJobDetailsAction {
  final String jobId;
  final String jobDetailsId;

  GetReqJobDetailsAction({
    required this.jobId,
    required this.jobDetailsId,
  });
}

class GetAcceptReqJobAction {
  JobModel jobMd;

  GetAcceptReqJobAction({required this.jobMd});
}
