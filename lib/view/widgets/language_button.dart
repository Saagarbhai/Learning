import 'package:learning/core/utils/app_export.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language, color: Colors.black, size: 24.sp),
      iconSize: 24.sp,
      padding: EdgeInsets.all(8.r),
      onPressed: () {
        _showLanguageDialog(context);
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Lang.of(context).selectLanguage,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'English',
                  style: TextStyle(fontSize: 16.sp),
                ),
                onTap: () {
                  context.read<LanguageBloc>().add(const ChangeLanguage('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'हिंदी',
                  style: TextStyle(fontSize: 16.sp),
                ),
                onTap: () {
                  context.read<LanguageBloc>().add(const ChangeLanguage('hi'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'ગુજરાતી',
                  style: TextStyle(fontSize: 16.sp),
                ),
                onTap: () {
                  context.read<LanguageBloc>().add(const ChangeLanguage('gu'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
