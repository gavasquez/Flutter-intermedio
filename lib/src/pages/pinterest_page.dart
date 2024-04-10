import 'package:disenos_app/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _MostrarMenuModel(),
        child: Stack(
          children: [
            const PinterestGrid(),
            _PinterestMenuLocation(width: width),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final mostrarMenu = Provider.of<_MostrarMenuModel>(context).mostrarMenu;
    final List<PinterestButton> items = [
      PinterestButton(onPressed: () {}, iconData: Icons.pie_chart),
      PinterestButton(onPressed: () {}, iconData: Icons.search),
      PinterestButton(onPressed: () {}, iconData: Icons.notifications),
      PinterestButton(onPressed: () {}, iconData: Icons.supervised_user_circle)
    ];

    return Positioned(
        bottom: 30,
        child: SizedBox(
          width: width,
          child: Align(
            alignment: Alignment.center,
            child: PinterestMenu(
              items: items,
              mostrar: mostrarMenu,
            ),
          ),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({super.key});

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final controller = ScrollController();
  double scrollAnterior = 0;
  final List<int> items = List.generate(200, (index) => index);

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 150) {
        Provider.of<_MostrarMenuModel>(context, listen: false).mostrarMenu =
            false;
      } else {
        Provider.of<_MostrarMenuModel>(context, listen: false).mostrarMenu =
            true;
      }

      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemBuilder: (BuildContext context, int index) =>
          _PinterestItem(index: index),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 3),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MostrarMenuModel with ChangeNotifier {
  bool _mostrarMenu = true;
  bool get mostrarMenu => _mostrarMenu;
  set mostrarMenu(bool valor) {
    _mostrarMenu = valor;
    notifyListeners();
  }
}
