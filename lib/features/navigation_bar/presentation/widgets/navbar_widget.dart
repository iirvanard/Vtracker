import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vtracker/core/utils/theme.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({
    super.key,
    required this.navbarItems,
    required this.navigationShell,
  });
  final List<IconData> navbarItems;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgTextfieldDark,
          border: Border(top: BorderSide(color: blackColor, width: 2.sp))),
      child: Row(
        children: navbarItems.map(
          (val) {
            int index = navbarItems.indexOf(val);
            return Expanded(
              child: InkWell(
                onTap: navigationShell.currentIndex == index
                    ? null
                    : () {
                        navigationShell.goBranch(index);
                      },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.h, top: 15.h, left: 25.w, right: 25.w),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: navigationShell.currentIndex == index
                                    ? bgButtonDark
                                    : Colors.transparent,
                                width: 2.sp))),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Icon(
                        val,
                        size: 22.sp,
                        color: navigationShell.currentIndex == index
                            ? bgButtonDark
                            : textColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
