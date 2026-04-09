import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/splash_screen/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController controller = Get.put(SplashScreenController());

  static const Color _bg = Color(0xFF6B35E8);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: _bg,
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOut,
            opacity: controller.opacity.value,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOut,
              scale: controller.scale.value,
              child: SizedBox(
                width: 100.w,
                height: 100.w,
                child: CustomPaint(
                  painter: _AlliesLogoPainter(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AlliesLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final double w = size.width;
    final double h = size.height;

    //
    final double arcCx = w * 0.50;   // centre-x of the full circle
    final double arcCy = h * 0.40;   // centre-y (slightly above mid)
    final double arcR  = w * 0.42;   // radius

    final Path arc = Path();
    // Start at top of the flat (left) edge
    arc.moveTo(arcCx, arcCy - arcR);
    // Clockwise semicircle covering the right half
    arc.arcTo(
      Rect.fromCircle(center: Offset(arcCx, arcCy), radius: arcR),
      -math.pi / 2,   // start angle: 12 o'clock
      math.pi,        // sweep:        180° clockwise → 6 o'clock
      false,
    );
    // Close straight back up the left (flat) edge
    arc.close();
    canvas.drawPath(arc, p);

    // ── 2. Bottom-left block with concave inner corner ───────────────────────
    //
    //  A rounded rectangle anchored bottom-left.
    //  The top-right corner is cut away with a quarter-circle notch
    //  so it wraps around the flat edge of the arc above.
    //
    final double bx  = w * 0.08;   // block left edge
    final double by  = h * 0.40;   // block top edge  (same y as arc centre)
    final double bx2 = w * 0.50;   // block right edge (meets arc flat edge)
    final double by2 = h * 0.92;   // block bottom edge
    final double r   = w * 0.12;   // outer corner radius
    final double notchR = w * 0.13; // concave notch radius (inner corner)

    final Path block = Path();

    // Top-left rounded corner
    block.moveTo(bx + r, by);
    // Top edge → towards concave notch (stop before top-right)
    block.lineTo(bx2 - notchR, by);
    // Concave quarter-circle notch (top-right, curves inward)
    block.arcToPoint(
      Offset(bx2, by + notchR),
      radius: Radius.circular(notchR),
      clockwise: false, // concave = counter-clockwise
    );
    // Right edge down
    block.lineTo(bx2, by2 - r);
    // Bottom-right rounded corner
    block.arcToPoint(
      Offset(bx2 - r, by2),
      radius: Radius.circular(r),
      clockwise: true,
    );
    // Bottom edge left
    block.lineTo(bx + r, by2);
    // Bottom-left rounded corner
    block.arcToPoint(
      Offset(bx, by2 - r),
      radius: Radius.circular(r),
      clockwise: true,
    );
    // Left edge up
    block.lineTo(bx, by + r);
    // Top-left rounded corner
    block.arcToPoint(
      Offset(bx + r, by),
      radius: Radius.circular(r),
      clockwise: true,
    );
    block.close();

    canvas.drawPath(block, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}