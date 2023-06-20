import '../../template/template.dart';
import '../../utils/constants.dart';

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
        return ThemeColors.lime500;
      case JobStatus.rejected:
        return ThemeColors.red500;
      case JobStatus.expired:
        return ThemeColors.red800;
      case JobStatus.completed:
        return ThemeColors.green800;
      case JobStatus.test:
        return ThemeColors.cyan700;
      case JobStatus.cancelled:
        return ThemeColors.red800;
      case JobStatus.deleted:
        return ThemeColors.red800;
      case JobStatus.resubmitted:
        return ThemeColors.green800;
      case JobStatus.suppliment:
        return ThemeColors.yellow600;
      default:
        return ThemeColors.green800;
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
        return ThemeColors.red700;
      case JobStatus.completed:
        return ThemeColors.green700;
      case JobStatus.test:
        return ThemeColors.cyan700;
      case JobStatus.cancelled:
        return ThemeColors.red700;
      case JobStatus.deleted:
        return ThemeColors.red700;
      case JobStatus.resubmitted:
        return ThemeColors.green700;
      case JobStatus.suppliment:
        return ThemeColors.yellow600;
      default:
        return ThemeColors.green700;
    }
  }

  Color chipTextColor() {
    switch (jobStatus) {
      case JobStatus.pending:
        return ThemeColors.yellow800;
      case JobStatus.published:
        return ThemeColors.lime800;
      case JobStatus.rejected:
        return ThemeColors.red800;
      case JobStatus.expired:
        return ThemeColors.red800;
      case JobStatus.completed:
        return ThemeColors.green800;
      case JobStatus.test:
        return ThemeColors.cyan800;
      case JobStatus.cancelled:
        return ThemeColors.red800;
      case JobStatus.deleted:
        return ThemeColors.red800;
      case JobStatus.resubmitted:
        return ThemeColors.green800;
      case JobStatus.suppliment:
        return ThemeColors.yellow800;
      default:
        return ThemeColors.green800;
    }
  }
}
