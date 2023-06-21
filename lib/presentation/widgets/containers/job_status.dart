import 'package:mehonot_admin/presentation/utils/constants.dart';

import '../../template/template.dart';

class JobStatusChip extends StatelessWidget {
  final JobStatus jobStatus;

  const JobStatusChip({Key? key, required this.jobStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: isDark(context) ? chipBgDark() : chipBgLight(),
            borderRadius: BorderRadius.circular(12.r)),
        child: SizedText(
          text: jobStatus.name,
          textStyle: ThemeTextMedium.k10.copyWith(
            color: chipTextColor(),
          ),
        ));
  }

  Color chipBgDark() {
    switch (jobStatus) {
      case JobStatus.pending:
        return ThemeColors.yellow400;
      case JobStatus.published:
        return ThemeColors.lime400;
      case JobStatus.rejected:
        return ThemeColors.red400;
      case JobStatus.expired:
        return ThemeColors.red400;
      case JobStatus.completed:
        return ThemeColors.green400;
      case JobStatus.test:
        return ThemeColors.cyan400;
      case JobStatus.cancelled:
        return ThemeColors.red400;
      case JobStatus.deleted:
        return ThemeColors.red400;
      case JobStatus.resubmitted:
        return ThemeColors.green400;
      case JobStatus.supplement:
        return ThemeColors.yellow400;
      default:
        return ThemeColors.green400;
    }
  }

  Color chipBgLight() {
    switch (jobStatus) {
      case JobStatus.pending:
        return ThemeColors.yellow200;
      case JobStatus.published:
        return ThemeColors.lime200;
      case JobStatus.rejected:
        return ThemeColors.red200;
      case JobStatus.expired:
        return ThemeColors.red200;
      case JobStatus.completed:
        return ThemeColors.green200;
      case JobStatus.test:
        return ThemeColors.cyan200;
      case JobStatus.cancelled:
        return ThemeColors.red200;
      case JobStatus.deleted:
        return ThemeColors.red200;
      case JobStatus.resubmitted:
        return ThemeColors.green200;
      case JobStatus.supplement:
        return ThemeColors.yellow200;
      default:
        return ThemeColors.green200;
    }
  }

  Color chipTextColor() {
    switch (jobStatus) {
      case JobStatus.pending:
        return ThemeColors.yellow900;
      case JobStatus.published:
        return ThemeColors.lime900;
      case JobStatus.rejected:
        return ThemeColors.red900;
      case JobStatus.expired:
        return ThemeColors.red900;
      case JobStatus.completed:
        return ThemeColors.green900;
      case JobStatus.test:
        return ThemeColors.cyan900;
      case JobStatus.cancelled:
        return ThemeColors.red900;
      case JobStatus.deleted:
        return ThemeColors.red900;
      case JobStatus.resubmitted:
        return ThemeColors.green900;
      case JobStatus.supplement:
        return ThemeColors.yellow900;
      default:
        return ThemeColors.green900;
    }
  }
}
