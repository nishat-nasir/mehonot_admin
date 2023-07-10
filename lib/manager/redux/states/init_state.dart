import '../../../presentation/template/template.dart';
import '../../models/Feedback/feedback_md.dart';
import '../../models/sync/sync_reg_terms_md.dart';

@immutable
class InitState {
  final int countDhkJobs;
  final int countCtgJobs;
  final int countKhlJobs;
  final int countRajJobs;
  final int countBarJobs;
  final int countSylJobs;
  final int countRngJobs;
  final int countMymJobs;
  final int countAllJobs;
  final List<FeedbackMd> feedbackList;
  final SyncRegTermsMd syncRegTermsMd;

  const InitState({
    required this.countDhkJobs,
    required this.countCtgJobs,
    required this.countKhlJobs,
    required this.countRajJobs,
    required this.countBarJobs,
    required this.countSylJobs,
    required this.countRngJobs,
    required this.countMymJobs,
    required this.countAllJobs,
    required this.feedbackList,
    required this.syncRegTermsMd,
  });

  factory InitState.initial() {
    return InitState(
        countDhkJobs: 0,
        countCtgJobs: 0,
        countKhlJobs: 0,
        countRajJobs: 0,
        countBarJobs: 0,
        countSylJobs: 0,
        countRngJobs: 0,
        countMymJobs: 0,
        countAllJobs: 0,
        feedbackList: [],
        syncRegTermsMd: SyncRegTermsMd(
          id: "",
          version: "",
          createdDate: "",
          serviceTerms: '',
          marketingInfoTerms: '',
          personalInfoTerms: '',
          softwareTerms: '',
          halalTerms: '',
        ));
  }

  InitState copyWith({
    int? countDhkJobs,
    int? countCtgJobs,
    int? countKhlJobs,
    int? countRajJobs,
    int? countBarJobs,
    int? countSylJobs,
    int? countRngJobs,
    int? countMymJobs,
    int? countAllJobs,
    List<FeedbackMd>? feedbackList,
    SyncRegTermsMd? syncRegTermsMd,
  }) {
    return InitState(
      countDhkJobs: countDhkJobs ?? this.countDhkJobs,
      countCtgJobs: countCtgJobs ?? this.countCtgJobs,
      countKhlJobs: countKhlJobs ?? this.countKhlJobs,
      countRajJobs: countRajJobs ?? this.countRajJobs,
      countBarJobs: countBarJobs ?? this.countBarJobs,
      countSylJobs: countSylJobs ?? this.countSylJobs,
      countRngJobs: countRngJobs ?? this.countRngJobs,
      countMymJobs: countMymJobs ?? this.countMymJobs,
      countAllJobs: countAllJobs ?? this.countAllJobs,
      feedbackList: feedbackList ?? this.feedbackList,
      syncRegTermsMd: syncRegTermsMd ?? this.syncRegTermsMd,
    );
  }
}

///------------------Update INIT Action ---------

class UpdateInitStateAction {
  int? countDhkJobs;
  int? countCtgJobs;
  int? countKhlJobs;
  int? countRajJobs;
  int? countBarJobs;
  int? countSylJobs;
  int? countRngJobs;
  int? countMymJobs;
  int? countAllJobs;
  List<FeedbackMd>? feedbackList;
  SyncRegTermsMd? syncRegTermsMd;

  UpdateInitStateAction({
    this.countDhkJobs,
    this.countCtgJobs,
    this.countKhlJobs,
    this.countRajJobs,
    this.countBarJobs,
    this.countSylJobs,
    this.countRngJobs,
    this.countMymJobs,
    this.countAllJobs,
    this.feedbackList,
    this.syncRegTermsMd,
  });
}

///------------------INIT Action ---------

class GetStateInitAction {
  BuildContext context;

  GetStateInitAction({
    required this.context,
  });
}

class GetAllJobsCountAction {
  GetAllJobsCountAction();
}

class GetAllFeedbackAction {
  GetAllFeedbackAction();
}

class GetInternetConnectionCheckAction {
  BuildContext context;

  GetInternetConnectionCheckAction({
    required this.context,
  });
}

class GetTermsAndPoliciesAction {
  GetTermsAndPoliciesAction();
}

class GetUpdateTermsAndPoliciesAction {
  SyncRegTermsMd syncRegTermsMd;

  GetUpdateTermsAndPoliciesAction({
    required this.syncRegTermsMd,
  });
}
