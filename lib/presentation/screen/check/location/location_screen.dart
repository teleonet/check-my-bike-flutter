import 'package:check_my_bike_flutter/presentation/models/bike.dart';
import 'package:check_my_bike_flutter/presentation/models/location.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/location/distance_slider.dart';
import 'package:check_my_bike_flutter/presentation/widgets/bordered_button.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
  }

  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends BaseCheckState<LocationScreen> {
  Location? _location;
  List<Bike> _bikes = [];

  final GlobalKey? _locationButtonKey = GlobalKey<BorderedButtonState>();

  _LocationScreenState() : super("location") {
    // _location = Location(39.73, -104.98);
    _bikes = _buildBikes();
  }

  //todo: only for development
  List<Bike> _buildBikes() {
    return [
      Bike(410882, true, "Scott", "SWBD312L0482P", "stolen", "2018 Fuji ABOSLUTE 1.1", 2021, true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "Tallahassee, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"])
    ];
  }

  @override
  List<Widget> getWidgets() {
    return [_buildLocationButton(), _buildSlider(), _buildSearchButton(), _buildListView()];
  }

  Widget _buildLocationButton() {
    return BorderedButton("choose location",
        onPressed: () => print("choose location"), key: _locationButtonKey);
  }

  Widget _buildSlider() {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: DistanceSlider((value) => print("Choose distance: $value")));
  }

  Widget _buildSearchButton() {
    return BorderedButton("search", onPressed: () {
      BorderedButtonState? buttonState = _locationButtonKey?.currentState as BorderedButtonState?;
      if (_location != null) {
        buttonState?.setButtonStatus(Status.normal);
      } else {
        buttonState?.setButtonStatus(Status.error);
        //todo: add bloc request location
      }
    });
  }

  Widget _buildListView() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _bikes.length,
          itemBuilder: (context, index) {
            return Info(_bikes[index], onInfoPressed: (bike) => DetailsScreen.show(context, bike));
          },
        ));
  }
}
