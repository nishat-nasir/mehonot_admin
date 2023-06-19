import '../../../presentation/template/template.dart';
import '../../models/Job/job_md.dart';
import '../../models/Job/job_dtl_md.dart';

@immutable
class AccountState {
  final List<JobModel> myPostedJobsData;
  final List<JobModel> myApplicationJobsData;

  const AccountState({
    required this.myPostedJobsData,
    required this.myApplicationJobsData,
  });

  factory AccountState.initial() {
    return AccountState(
      myPostedJobsData: [],
      myApplicationJobsData: [],
    );
  }

  AccountState copyWith({
    List<JobModel>? myPostedJobsData,
    List<JobModel>? myApplicationJobsData,
  }) {
    return AccountState(
      myPostedJobsData: myPostedJobsData ?? this.myPostedJobsData,
      myApplicationJobsData:
          myApplicationJobsData ?? this.myApplicationJobsData,
    );
  }
}

///------------------Update Account Action ---------
class UpdateAccountStateAction {
  final List<JobModel>? myPostedJobsData;
  final List<JobModel>? myApplicationJobsData;

  UpdateAccountStateAction({
    this.myPostedJobsData,
    this.myApplicationJobsData,
  });
}

///------------------Account Action ---------

class GetAllMyPostedJobsAction {
  GetAllMyPostedJobsAction();
}

class GetAllMyJobApplicationsAction {
  GetAllMyJobApplicationsAction();
}

class GetDeleteAccountAction {
  GetDeleteAccountAction();
}

class GetMakeAccountPremiumAction {
  GetMakeAccountPremiumAction();
}

class GetAddToMyJobsIdsAction {
  String jobId;

  GetAddToMyJobsIdsAction({required this.jobId});
}

class GetJobApplicationAction {
  JobModel jobModel;

  GetJobApplicationAction({required this.jobModel});
}

class GetRemoveJobApplicationAction {
  JobModel jobModel;

  GetRemoveJobApplicationAction({required this.jobModel});
}

class GetRemoveFromMyJobsIdsAction {
  JobModel jobModel;
  JobDetailModel jobDetailModel;
  bool? removingFromMyJobs;

  GetRemoveFromMyJobsIdsAction(
      {required this.jobModel,
      required this.jobDetailModel,
      this.removingFromMyJobs = true});
}
