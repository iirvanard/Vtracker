import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/core/icons/vtracker_icons_icons.dart';
import 'package:vtracker/features/navigation_bar/presentation/widgets/navbar_widget.dart';

class ScaffoldBottomNavigationBar extends StatelessWidget {
  const ScaffoldBottomNavigationBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldBottomNavigationBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavbarWidget(
        navigationShell: navigationShell,
        navbarItems: const [
          VtrackerIcons.home,
          VtrackerIcons.static,
          VtrackerIcons.tier,
          VtrackerIcons.profile,
        ],
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: BottomNavigationBar(
//         fixedColor: Colors.red,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section_A'),
//           BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section_B'),
//         ],
//         currentIndex: navigationShell.currentIndex,
//         onTap: (int tappedIndex) {
//           navigationShell.goBranch(tappedIndex);
//         },
//       ),
//     );
//   }
// }
