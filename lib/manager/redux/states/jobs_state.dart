import 'package:hive/hive.dart';
import 'package:mehonot_admin/manager/hive_client.dart';

import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../models/Address/address_md.dart';
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
      dhakaJobs: [],
      chittagongJobs: [],
      khulnaJobs: [],
      rajshahiJobs: [],
      barisalJobs: [],
      sylhetJobs: [],
      rangpurJobs: [],
      mymensinghJobs: [],
      currentLocationJobsList: [],
      allRequestedJobs: [],
      selectedJobDetailModel: JobDetailModel(
        jobId: '',
        jobDetailsId: '',
        phone: '',
        ownerName: '',
        recruitCondition: RecruitConModel(
          deadline: '',
          education: '',
          age: 0,
          personnel: "1",
          gender: '',
        ),
        workCondition: WorkConModel(),
        website: '',
        email: '',
        description: '',
        category: '',
        moreDetails: '',
      ),
      searchJobList: [],
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

  GetJobsAction({
    required this.division,
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

  GetCreateJobReqAction({
    required this.jobModelReq,
    required this.jobDetailModelReq,
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

  GetUpdateJobAction({
    required this.jobModel,
    required this.jobDetailModel,
  });
}

class GetDeleteJobAction {
  final String jobId;
  final String jobDetailsId;
  final Division division;

  GetDeleteJobAction({
    required this.jobId,
    required this.jobDetailsId,
    required this.division,
  });
}

class GetJobSearchAction {
  final String searchText;

  GetJobSearchAction({
    required this.searchText,
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
  final Division division;
  final String jobId;
  final String jobDetailsId;

  GetReqJobDetailsAction({
    required this.division,
    required this.jobId,
    required this.jobDetailsId,
  });
}


class GetAcceptReqJobAction {
  JobModel jobMd;

  GetAcceptReqJobAction({required this.jobMd});
}
