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
      title: 'Flutter Demo', // warning  // MaterialApp
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // warning

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
        title: Text(widget
            .title), // this example not using S but will not warn in the IDE
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('not translated text'), // warning
            // ignore: flutter_localization_linter_rule
            const Text('Still not translated text'), // no warning
            Text('translated text'.trim()), // warning
            const Text(''), // no warning
            const Text('  '), // no warning
            const Text('123%  '), // no warning
            Text('test ${widget.title}'), // warning
            RichText(text: const TextSpan(text: 'test')), // warning
            RichText(text: const TextSpan(text: ' ')), // warning
            Text("123 ${widget.title}"), // no warning
            Text(S.of(context).translated_text), // no warning
            Text(S.current.translated_text), // no warning
          ],
        ),
      ),
    );
  }
}
