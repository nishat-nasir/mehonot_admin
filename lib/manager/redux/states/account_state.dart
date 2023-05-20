import '../../../presentation/template/template.dart';
import '../../../presentation/utils/constants.dart';
import '../../models/Job/job_md.dart';

@immutable
class AccountState {
  final List<JobModel> myPostedJobsData;

  const AccountState({
    required this.myPostedJobsData,
  });

  factory AccountState.initial() {
    return AccountState(
      myPostedJobsData: [],
    );
  }

  AccountState copyWith({
    List<JobModel>? myPostedJobsData,
  }) {
    return AccountState(
      myPostedJobsData: myPostedJobsData ?? this.myPostedJobsData,
    );
  }
}

///------------------Update Account Action ---------
class UpdateAccountStateAction {
  final List<JobModel>? myPostedJobsData;

  UpdateAccountStateAction({
    this.myPostedJobsData,
  });
}

///------------------Account Action ---------

class GetAllMyPostedJobsAction {
  GetAllMyPostedJobsAction();
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

class GetRemoveFromMyJobsIdsAction {
  String jobId;
  String jobDetailsId;
  Division division;

  GetRemoveFromMyJobsIdsAction({
    required this.jobId,
    required this.jobDetailsId,
    required this.division,
  });
}
