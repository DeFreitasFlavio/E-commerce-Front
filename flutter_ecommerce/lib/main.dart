import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce/screens/home_screen.dart';
import 'package:flutter_ecommerce/screens/loader.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

Future<Data> fetchData() async {
  final response = await http.get(Uri.parse('https://pokebuildapi.fr/api/v1/pokemon'));
  if (response.statusCode == 200) {
    print("coucou");
  } else {
    throw Exception('Failed to load Data');
  }
}

class Data {
  final int userId;

  const Data({
    required this.userId,
  });
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<Data> futurData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FutureBuilder<Data>(
              future: fetchData(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return const HomePage();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Loader();
              },
            ),
          ),
        ),
      )
    );
  }
}