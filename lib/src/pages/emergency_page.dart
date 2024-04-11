import 'package:animate_do/animate_do.dart';
import 'package:disenos_app/src/widgets/boton_gordo.dart';
import 'package:disenos_app/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2);
}

final items = <ItemBoton>[
  ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident', Color(0xff6989F5),
      const Color(0xff906EF5)),
  ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency', const Color(0xff66A9F2),
      Color(0xff536CF6)),
  ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
      Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemBoton(FontAwesomeIcons.biking, 'Awards', const Color(0xff317183),
      Color(0xff46997D)),
  ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident', Color(0xff6989F5),
      const Color(0xff906EF5)),
  ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency', const Color(0xff66A9F2),
      Color(0xff536CF6)),
  ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
      Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemBoton(FontAwesomeIcons.biking, 'Awards', const Color(0xff317183),
      Color(0xff46997D)),
  ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident', Color(0xff6989F5),
      const Color(0xff906EF5)),
  ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2),
      Color(0xff536CF6)),
  ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
      Color(0xffF2D572), const Color(0xffE06AA3)),
  ItemBoton(FontAwesomeIcons.biking, 'Awards', const Color(0xff317183),
      Color(0xff46997D)),
];

// ignore: must_be_immutable
class EmergencyPage extends StatelessWidget {
  List<Widget> itemMap = items
      .map((item) => FadeInLeft(
            duration: const Duration(milliseconds: 250),
            child: BotonGordo(
              onPress: () {},
              icon: item.icon,
              texto: item.texto,
              color1: item.color1,
              color2: item.color2,
            ),
          ))
      .toList();

  EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 80,
                ),
                ...itemMap,
              ],
            ),
          ),
          const Encabezado(),
        ],
      ),
    );
  }
}

class Encabezado extends StatelessWidget {
  const Encabezado({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IconHeader(
          icon: FontAwesomeIcons.plus,
          titulo: 'Asistencia Médica',
          subTitulo: 'Haz Solicitado',
          color1: Color(0xff526BF6),
          color2: Color(0xff67ACF2),
        ),
        Positioned(
            right: 0,
            top: 40,
            child: RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              child: const FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
