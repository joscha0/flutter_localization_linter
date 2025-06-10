import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Flutter Demo', // this example not using S will warn in the IDE  // MaterialApp
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title:
              'Flutter Demo Home Page'), // this example not using S will warn in the IDE

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(widget.title), // this example not using S will warn in the IDE
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'not translated text',
            ), // this example not using S will warn in the IDE
            // ignore: smarter_translate_lint_use_s_role
            const Text(
              'Still not translated text',
            ), // this example not using S will warn in the IDE
            Text('translated text'
                .trim()), // this example not using S but also calling other string manipulations will warn in the IDE
            Text(S
                .of(context)
                .translated_text), // this example using S.of(context) will not warn in the IDE
            Text(S.current
                .translated_text), // this example using S.current will not warn in the IDE
          ],
        ),
      ),
    );
  }
}
