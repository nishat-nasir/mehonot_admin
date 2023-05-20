import '../template/template.dart';

class NoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: SizedBox());
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 0.0);
}
