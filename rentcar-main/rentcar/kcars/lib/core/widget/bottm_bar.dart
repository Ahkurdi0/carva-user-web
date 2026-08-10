import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.tabs,
  });
  final Function(int index) onTap;
  final List<BottmBarModel> tabs;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedIndex = 0;

  final int tabCount = 4;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      });
  }

  void _onItemTapped(int index) {
    _previousIndex = _selectedIndex;

    _controller.reset();
    _controller.forward();

    setState(() {
      _selectedIndex = index;
      widget.onTap(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      context.primary,
      context.secondary,
      context.primary,
      context.secondary,
    ];

    final sw = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 22.w,
      child: CustomPaint(
        painter: BottombarPainter(
          _animation.value,
          _selectedIndex,
          _previousIndex,
          Directionality.of(context),
          colors,
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 4.w),
          child: Row(
            children: [
              ...widget.tabs.asMap().entries.map(
                (entry) => SizedBox(
                  width: sw / widget.tabs.length,
                  child: BottomBarButton(
                    lable: entry.value.lable,
                    index: entry.key,
                    activeTab: _selectedIndex,
                    icon: entry.value.icon,
                    activeIcon: entry.value.activeIcon,
                    color: colors[entry.key],
                    onPress: () => _onItemTapped(entry.key),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottombarPainter extends CustomPainter {
  final double progress;
  final int activeTabIndex;
  final int previousTabIndex;
  final TextDirection textDirection;
  final List<Color> colors;

  BottombarPainter(
    this.progress,
    this.activeTabIndex,
    this.previousTabIndex,
    this.textDirection,
    this.colors,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Rounded top corners give the bar a modern "floating sheet" feel.
    final radius = Radius.circular(h * .28);
    final surfacePath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, w, h),
          topLeft: radius,
          topRight: radius,
        ),
      );

    // Soft drop shadow above the bar instead of a hard grey hairline.
    canvas.drawShadow(
      surfacePath.shift(const Offset(0, -2)),
      Colors.black.withValues(alpha: 0.18),
      8,
      false,
    );

    final surfacePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawPath(surfacePath, surfacePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BottmBarModel {
  final String lable;
  final String icon;
  final String activeIcon;

  BottmBarModel({
    required this.lable,
    required this.icon,
    required this.activeIcon,
  });
}

class BottomBarButton extends StatelessWidget {
  final Function onPress;
  final String lable;
  final int index;
  final int activeTab;
  final String icon;
  final String activeIcon;
  final Color color;

  const BottomBarButton({
    super.key,
    required this.lable,
    required this.index,
    required this.activeTab,
    required this.icon,
    required this.activeIcon,
    required this.onPress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = index == activeTab;
    return GestureDetector(
      onTap: () => onPress(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(animation), // Slight scale effect
                        child: child,
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    isActive ? activeIcon : icon,
                    key: ValueKey(
                      '$index-${index == activeTab}',
                    ), // Unique key per state
                    height: 6.w,
                    width: 6.w,
                  ),
                ),
                SizedBox(height: 1.w),
                AnimatedDefaultTextStyle(
                  style: context.label.copyWith(
                    color: isActive ? context.onSurface : context.outline,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    lable,
                    key: ValueKey('$index-${index == activeTab}'),
                  ), //
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
