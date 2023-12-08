import 'package:flutter/material.dart';
import 'package:playdate/custom_playdate.dart';
import 'package:playdate/explore.dart';
import 'package:playdate/home.dart';
import 'package:playdate/invitefriends.dart';
import 'package:playdate/invites.dart';
import 'package:playdate/newinvite.dart';
import 'package:playdate/profile_screen.dart';
import 'package:playdate/settingspage.dart';
import 'package:provider/provider.dart';

class Destination {
  const Destination(this.index, this.title, this.icon, this.view);
  final int index;
  final String title;
  final IconData icon;
  final Widget view;
}

class NavigationController extends StatefulWidget {
  const NavigationController({super.key, required this.allDestinations});

  final List<Destination> allDestinations;

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController>
    with TickerProviderStateMixin<NavigationController> {
  List<Key>? _destinationKeys;
  List<AnimationController>? _faders;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _faders = widget.allDestinations
        .map<AnimationController>((Destination destination) {
      return AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
    }).toList();
    _faders?[_currentIndex].value = 1.0;
    _destinationKeys = List<Key>.generate(
        widget.allDestinations.length, (int index) => GlobalKey()).toList();
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: widget.allDestinations.map((Destination destination) {
            final customNavigator = Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (BuildContext context) {
                    switch (settings.name) {
                      case '/':
                        return destination.view;
                      case '/invite1':
                        return const NewInvitePlaydate();
                      case '/invite2':
                        return const InviteFriends();
                      case '/custom_playdate':
                        return const CreatePlaydateScreen();
                      case '/settings':
                        return const SettingsPage();
                    }
                    return destination.view;
                  },
                );
              },
            );

            final Widget view = FadeTransition(
              opacity: _faders![destination.index]
                  .drive(CurveTween(curve: Curves.fastOutSlowIn)),
              child: KeyedSubtree(
                  key: _destinationKeys?[destination.index],
                  child: customNavigator),
            );
            if (destination.index == _currentIndex) {
              _faders?[destination.index].forward();
              return view;
            } else {
              _faders?[destination.index].reverse();
              if (_faders![destination.index].isAnimating) {
                return IgnorePointer(child: view);
              }
              return Offstage(child: view);
            }
          }).toList(),
        ),
      ),
      bottomNavigationBar: ClipRect(
        child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: widget.allDestinations.map((Destination destination) {
              return NavigationDestination(
                  icon: Icon(destination.icon), label: destination.title);
            }).toList()),
      ),
    );
  }
}

void main() {
  const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home, HomePage()),
    Destination(1, 'Explore', Icons.search, Explore()),
    Destination(2, 'Inbox', Icons.inbox, InviteInbox()),
    Destination(3, 'Profile', Icons.person, ProfilePage()),
  ];

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Initialize the ThemeProvider
      child: const MyApp(allDestinations: allDestinations),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Destination> allDestinations;

  const MyApp({super.key, required this.allDestinations});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          home: NavigationController(allDestinations: allDestinations),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: themeProvider.themeColor,
                brightness: Brightness.light,
                shadow: Colors.transparent),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: themeProvider.themeColor,
                brightness: Brightness.dark,
                shadow: Colors.transparent),
          ),
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}

class ThemeProvider with ChangeNotifier {
  final List<Color> _themeColors = [
    Colors.blue,
    const Color.fromARGB(255, 238, 72, 94),
    const Color.fromARGB(255, 254, 200, 2),
    Colors.green
  ];
  int _currentColorIndex = 0;

  Color get themeColor => _themeColors[_currentColorIndex];

  void cycleThemeColor() {
    _currentColorIndex = (_currentColorIndex + 1) % _themeColors.length;
    notifyListeners();
  }
}
