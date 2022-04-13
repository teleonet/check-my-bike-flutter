import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends BaseScreenState<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                  child: Text("Check my bike",
                      style: TextStyle(
                          fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40)))),
          const Spacer(),
          Row(children: [
            const Spacer(),
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
                    ))),
            const Spacer()
          ]),
          Row(children: [
            const Spacer(),
            Container(
              height: 2,
              width: 100,
              color: ColorRes.divider,
            ),
            const Spacer(),
            Container(
              height: 2,
              width: 100,
              color: ColorRes.divider,
            ),
            const Spacer(),
          ]),
          Row(children: [
            const Spacer(),
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
                        Icon(Icons.place_outlined, color: ColorRes.green, size: 48.0),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        const Text("location",
                            style: TextStyle(
                                fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))
                      ],
                    ))),
            const Spacer()
          ]),
          const Spacer()
        ]));
  }
}
