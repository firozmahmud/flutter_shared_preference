import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  @override
  initState() {
    super.initState();
    init();
  }

  void init() async {
    int c = await getCounter();
    setState(() {
      counter = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("SharedPreference"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$counter',
                style: TextStyle(fontSize: 40),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () => {
                          setState(() {
                            counter--;
                            saveCounter(counter);
                          })
                        },
                        child: Text(
                          '-',
                          style: TextStyle(fontSize: 36),
                        ),
                        //other properties
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () => {
                          setState(() {
                            counter++;
                            saveCounter(counter);
                          })
                        },
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 36),
                        ),
                        //other properties
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  saveCounter(int counter) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("counter", counter);
  }

  Future<int> getCounter() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt("counter") ?? 0;
  }
}
