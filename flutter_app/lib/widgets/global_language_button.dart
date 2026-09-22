import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class GlobalLanguageButton extends StatelessWidget {
  const GlobalLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final isHindi = localeProvider.locale.languageCode == 'hi';

    return IconButton(
      icon: Text(isHindi ? "🇬🇧" : "🇮🇳", style: const TextStyle(fontSize: 20)),
      onPressed: () => context.read<LocaleProvider>().toggleLocale(),
    );
  }
}
