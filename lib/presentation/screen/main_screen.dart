import 'package:check_my_bike_flutter/resources/color_res.dart';
import 'package:flutter/material.dart';

import 'base/base_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorRes.startGradient, ColorRes.endGradient])),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                        child: Text("Check my bike",
                            style: TextStyle(
                                fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40)))),
              ]),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.subject, color: ColorRes.green, size: 48.0),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              const Text("serial",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
                            ],
                          ))),
                  Container(
                    height: 100,
                    width: 2,
                    margin: const EdgeInsets.only(top: 10),
                    color: ColorRes.divider,
                  ),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings, color: ColorRes.green, size: 48.0),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              const Text("manufacturer",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
                            ],
                          )))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    color: ColorRes.divider,
                  ),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.only(left: 10),
                    width: 100,
                    color: ColorRes.divider,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_tree_outlined, color: ColorRes.green, size: 48.0),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              const Text("custom",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
                            ],
                          ))),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 10),
                    width: 2,
                    color: ColorRes.divider,
                  ),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.place_outlined, color: ColorRes.green, size: 48.0),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              const Text("location",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
                            ],
                          )))
                ],
              ),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  Container(
                    height: 1,
                    width: 80,
                    color: ColorRes.green,
                  ),
                  SizedBox(
                      width: 80,
                      height: 80,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.search, color: ColorRes.green, size: 40.0),
                              const Text("check",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 16))
                            ],
                          )))
                ]),
                Column(children: [
                  Container(
                    height: 1,
                    width: 80,
                    color: ColorRes.divider,
                  ),
                  SizedBox(
                      width: 80,
                      height: 80,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.summarize, color: ColorRes.green, size: 40.0),
                              const Text("database",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 16))
                            ],
                          )))
                ]),
                Column(children: [
                  Container(
                    height: 1,
                    width: 80,
                    color: ColorRes.divider,
                  ),
                  SizedBox(
                      width: 80,
                      height: 80,
                      child: TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.info, color: ColorRes.green, size: 40.0),
                              const Text("about",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 16))
                            ],
                          )))
                ]),
              ]),
            ])));
  }
}
