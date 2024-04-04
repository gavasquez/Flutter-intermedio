import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimiario;
  final double grosorSecundario;
  const RadialProgress(
      {super.key,
      required this.porcentaje,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.green,
      this.grosorSecundario = 4.0,
      this.grosorPrimiario = 10.0});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //* Cada vez que se redibuja el wigdet se realiza la animación
    controller.forward(from: 0.0);
    // ignore: unused_local_variable
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
              porcentaje: (widget.porcentaje - diferenciaAnimar) +
                  (diferenciaAnimar * controller.value),
              colorPrimary: widget.colorPrimario,
              colorSecundario: widget.colorSecundario,
              grosorSecundario: widget.grosorSecundario,
              grosorPrimario: widget.grosorPrimiario,
            ),
          ),
        );
      },
    );
    //return Container(
    //  padding: const EdgeInsets.all(10),
    //  width: double.infinity,
    //  height: double.infinity,
    //  child: CustomPaint(
    //    painter: _MiRadialProgress(porcentaje: widget.porcentaje),
    //  ),
    //);
  }
}

class _MiRadialProgress extends CustomPainter {
  final double porcentaje;
  final Color colorPrimary;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  _MiRadialProgress(
      {required this.porcentaje,
      required this.colorPrimary,
      required this.colorSecundario,
      required this.grosorSecundario,
      required this.grosorPrimario});
  @override
  void paint(Canvas canvas, Size size) {
    final Rect react = Rect.fromCircle(center: const Offset(0, 0), radius: 180);

    const Gradient gradiente = LinearGradient(
        colors: [Color(0xffC012FF), Color(0xff6D05E8), Colors.red]);

    // Circulo completado
    final paint = Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.5, size.height / 2);
    final radio = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = grosorPrimario
      //..color = colorPrimary
      ..shader = gradiente.createShader(react)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Parte que debera ir llenando
    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
