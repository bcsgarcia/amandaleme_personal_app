import 'package:flutter/cupertino.dart';

class CustomAppBarShape extends OutlinedBorder {

  const CustomAppBarShape({super.side});

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return CustomAppBarShape(side: side ?? this.side);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);

  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) {
      return;
    }

    canvas.drawPath(getOuterPath(rect), side.toPaint());
  }

  @override
  ShapeBorder scale(double t) {
    return CustomAppBarShape(side: side.scale(t));
  }

  Path _getPath(Rect rect) {
    final path = Path();
    const radius = 45.0; // Ajuste o raio conforme necessário

    // Desenha um retângulo com bordas inferiores arredondadas
    path.moveTo(rect.left, rect.top);
    path.lineTo(rect.right, rect.top);
    path.lineTo(rect.right, rect.bottom - radius);
    path.quadraticBezierTo(rect.right, rect.bottom, rect.right - radius, rect.bottom);
    path.lineTo(rect.left + radius, rect.bottom);
    path.quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - radius);
    path.lineTo(rect.left, rect.top);
    path.close();

    return path;
  }
}


/*

final size = Size(rect.width, rect.height * 1.75);
    //
    // final startPoint = size.height * 0.5;
    // path.lineTo(0, startPoint);
    //
    // final center  = Offset(size.width * 0.5, size.height);
    // final endPoint = Offset(size.width, startPoint);
    //
    // path.quadraticBezierTo(center.dx, center.dy, endPoint.dx, endPoint.dy);
    // path.lineTo(size.width, 0);
    //
    // path.close();
 */