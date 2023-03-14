import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ozare/app/app.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  Locale get selectedLocale => locale;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Select Language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Phoenix.rebirth(context);
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            LanguageTile(
              label: l10n.english,
              code: FlagsCode.US,
              isActive: selectedLocale.languageCode.contains('en'),
              onTap: () {
                setState(() {
                  locale = const Locale('en');
                });
              },
            ),
            LanguageTile(
              label: l10n.russian,
              code: FlagsCode.RU,
              isActive: selectedLocale.languageCode.contains('ru'),
              onTap: () {
                setState(() {
                  locale = const Locale('ru');
                });
              },
            ),
            LanguageTile(
              label: l10n.hindi,
              code: FlagsCode.IN,
              isActive: selectedLocale.languageCode.contains('hi'),
              onTap: () {
                setState(() {
                  locale = const Locale('hi');
                });
              },
            ),
            LanguageTile(
              label: l10n.german,
              code: FlagsCode.DE,
              isActive: selectedLocale.languageCode.contains('de'),
              onTap: () {
                setState(() {
                  locale = const Locale('de');
                });
              },
            ),
            LanguageTile(
              label: l10n.portuguese,
              code: FlagsCode.BR,
              isActive: selectedLocale.languageCode.contains('pt'),
              onTap: () {
                setState(() {
                  locale = const Locale('pt');
                });
              },
            ),
            LanguageTile(
              label: l10n.indonesian,
              code: FlagsCode.ID,
              isActive: selectedLocale.languageCode.contains('id'),
              onTap: () {
                setState(() {
                  locale = const Locale('id');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.onTap,
    required this.label,
    required this.code,
    required this.isActive,
  });

  final VoidCallback onTap;
  final String label;
  final FlagsCode code;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: isActive ? 12 : 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Colors.grey[200] : null,
        ),
        child: Row(children: [
          Flag.fromCode(code, height: 24, width: 24),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          if (isActive)
            const Icon(
              Icons.check,
              size: 18,
              color: primary2Color,
            ),
        ]),
      ),
    );
  }
}
