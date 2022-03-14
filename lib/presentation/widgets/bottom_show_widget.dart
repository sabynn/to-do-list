import 'dart:math';

import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:sm_to_do_list/common/styles.dart';
import 'package:sm_to_do_list/presentation/pages/bookmark_page.dart';
import 'package:sm_to_do_list/presentation/pages/finished_task.dart';
import '../pages/about_me.dart';
import '../pages/add_to_do.dart';

class BottomShowWidget extends StatefulWidget {
  final VoidCallback? onExit;

  BottomShowWidget({this.onExit});

  @override
  _BottomShowWidgetState createState() => _BottomShowWidgetState();
}

class _BottomShowWidgetState extends State<BottomShowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<IconData> _icons = [
    Icons.check,
    Icons.person,
    Icons.bookmark_add_rounded,
    Icons.add,
  ];

  final List<String> _toolTip = [
    "done",
    "profile",
    "bookmark",
    "add",
  ];
  final List<String> _routes = [
    FinishedPage.ROUTE_NAME,
    AboutMe.ROUTE_NAME,
    BookMarkPage.ROUTE_NAME,
    AddToDoPage.ROUTE_NAME,
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    debugPrint("BottomShowWidget");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final minSize = min(size.height, size.width);
    final circleSize = minSize;
    final Offset circleOrigin = Offset((size.width - circleSize) / 2, 0);

    return WillPopScope(
      onWillPop: () {
        doExit(context, _controller);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          doExit(context, _controller);
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0),
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 20,
                  left: size.width / 2 - 28,
                  child: AnimatedBuilder(
                      animation: _animation,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.2),
                            shape: BoxShape.circle),
                      ),
                      builder: (ctx, child) {
                        return Transform.scale(
                          scale: (max(size.height, size.width) / 28) *
                              (_animation.value),
                          child: child,
                        );
                      }),
                ),
                Positioned(
                  left: circleOrigin.dx,
                  top: circleOrigin.dy,
                  child: AnimatedBuilder(
                    animation: _animation,
                    child: CircleList(
                      origin: Offset(0, -min(size.height, size.width) / 2 + 20),
                      showInitialAnimation: true,
                      children: List.generate(_icons.length, (index) {
                        return IconButton(
                          onPressed: () {
                            doExit(context, _controller);
                            Navigator.pushNamed(
                              context,
                              _routes[index],
                            );
                          },
                          tooltip: _toolTip[index],
                          icon: Icon(
                            _icons[index],
                            size: 40,
                            color: kBlueColor,
                          ),
                        );
                      }),
                      innerCircleColor: kPrimaryColor,
                      outerCircleColor: kWhiteColor,
                      innerCircleRotateWithChildren: true,
                      centerWidget: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return Container();
                                }).then((v) {
                              doExit(context, _controller);
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: kDarkColor,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.circle_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: () {
                                  doExit(context, _controller);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )),
                    ),
                    builder: (ctx, child) {
                      return Transform.translate(
                          offset: Offset(
                              0,
                              MediaQuery.of(context).size.height -
                                  (_animation.value) * circleSize),
                          child: Transform.scale(
                              scale: _animation.value, child: child));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future doExit(BuildContext context, AnimationController controller) async {
    widget.onExit!();
    await controller.reverse();
    Navigator.of(context).pop();
  }
}
