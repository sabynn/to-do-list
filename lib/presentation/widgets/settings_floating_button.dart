import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sm_to_do_list/common/styles.dart';

import '../../logic/dialog_util.dart';
import 'bottom_show_widget.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final Color bgColor = kPrimaryColor;

  AnimatedFloatingButton({Key? key}) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Transform.translate(
          offset: Offset(0, (_animation.value) * 56),
          child: Transform.scale(scale: 1.0 - _animation.value, child: child),
        );
      },
      child: Transform.rotate(
        angle: -pi / 2,
        child: FloatingActionButton(
          onPressed: () async {
            FullScreenDialog.getInstance().showDialog(context, BottomShowWidget(
              onExit: () {
                _controller.reverse();
              },
            ));
            _controller.forward();
          },
          child: Transform.rotate(
            angle: pi / 2,
            child: const Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
          ),
          backgroundColor: kPrimaryColor,
          shape: FloatingBorder(),
        ),
      ),
    );
  }
}

class FloatingBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Offset center = rect.center;
    double length = rect.width / 2;
    Point one = Point(center.dx - length, center.dy);
    Point two = Point(length / 2 + one.x, center.dy - ((sqrt(3) / 2) * length));
    Point three = Point(two.x + length, two.y);
    Point four = Point(one.x + length * 2, one.y);
    Point five = Point(three.x, center.dy + ((sqrt(3) / 2) * length));
    Point six = Point(two.x, five.y);

    return _drawRoundPolygon([one, two, three, four, five, six], 3);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  Path _drawRoundPolygon(List<Point> ps, double distance) {
    var path = Path();
    ps.add(ps[0]);
    ps.add(ps[1]);
    var p0 = LineInterCircle.intersectionPoint(ps[1], ps[0], distance);
    path.moveTo(p0.x.toDouble(), p0.y.toDouble());
    for (int i = 0; i < ps.length - 2; i++) {
      var p1 = ps[i];
      var p2 = ps[i + 1];
      var p3 = ps[i + 2];
      var interP1 = LineInterCircle.intersectionPoint(p1, p2, distance);
      var interP2 = LineInterCircle.intersectionPoint(p3, p2, distance);
      path.lineTo(interP1.x.toDouble(), interP1.y.toDouble());
      path.arcToPoint(
        Offset(interP2.x.toDouble(), interP2.y.toDouble()),
        radius: Radius.circular(distance * 6),
      );
    }
    return path;
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }
}

class LineInterCircle {
  static double paramA(Point p1, Point p2) {
    return (2 * Line.paramK(p1, p2) * Line.paramC(p1, p2) -
            2 * Line.paramK(p1, p2) * p2.y -
            2 * p2.x) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  static double paramB(Point p1, Point p2, double r) {
    return (p2.x * p2.x -
            r * r +
            (Line.paramC(p1, p2) - p2.y) * (Line.paramC(p1, p2) - p2.y)) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  static bool isIntersection(Point p1, Point p2, double r) {
    var delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    return delta >= 0.0;
  }

  static bool _betweenPoint(x, Point p1, Point p2) {
    if (p1.x > p2.x) {
      return x > p2.x && x < p1.x;
    } else {
      return x > p1.x && x < p2.x;
    }
  }

  static Point _equalX(Point p1, Point p2, double r) {
    if (p1.y > p2.y) {
      return Point(p2.x, p2.y + r);
    } else if (p1.y < p2.y) {
      return Point(p2.x, p2.y - r);
    } else {
      return p2;
    }
  }

  static Point _equalY(Point p1, Point p2, double r) {
    if (p1.x > p2.x) {
      return Point(p2.x + r, p2.y);
    } else if (p1.x < p2.x) {
      return Point(p2.x - r, p2.y);
    } else {
      return p2;
    }
  }

  static Point intersectionPoint(Point p1, Point p2, double r) {
    if (p1.x == p2.x) return _equalX(p1, p2, r);
    if (p1.y == p2.y) return _equalY(p1, p2, r);
    var delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    if (delta < 0.0) {
      //when no intersection, i will return the center of the circ  le.
      return p2;
    }
    var a_2 = -paramA(p1, p2) / 2.0;
    var x1 = a_2 + delta / 2;
    if (_betweenPoint(x1, p1, p2)) {
      var y1 = Line.paramK(p1, p2) * x1 + Line.paramC(p1, p2);
      return Point(x1, y1);
    }
    var x2 = a_2 - delta / 2;
    var y2 = Line.paramK(p1, p2) * x2 + Line.paramC(p1, p2);
    return Point(x2, y2);
  }
}

class Line {
  static double normalLine(x, {k = 0, c = 0}) {
    return k * x + c;
  }

  static double paramK(Point p1, Point p2) {
    if (p1.x == p2.x) return 0;
    return (p2.y - p1.y) / (p2.x - p1.x);
  }

  static double paramC(Point p1, Point p2) {
    return p1.y - paramK(p1, p2) * p1.x;
  }
}
