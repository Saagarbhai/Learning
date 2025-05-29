import 'package:learning/core/utils/app_export.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.language, color: Colors.black),
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
          title: Text(Lang.of(context).selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  context.read<LanguageBloc>().add(const ChangeLanguage('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('हिंदी'),
                onTap: () {
                  context.read<LanguageBloc>().add(const ChangeLanguage('hi'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ગુજરાતી'),
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
