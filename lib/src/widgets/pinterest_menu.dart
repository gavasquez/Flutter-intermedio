import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final void Function()? onPressed;
  final IconData iconData;

  PinterestButton({required this.onPressed, required this.iconData});
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;

  PinterestMenu(
      {super.key,
      this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _MenuModel(),
        child: AnimatedOpacity(
            opacity: (mostrar) ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: Builder(builder: (context) {
              Provider.of<_MenuModel>(context, listen: false).backgroundColor =
                  backgroundColor;

              Provider.of<_MenuModel>(context, listen: false).activeColor =
                  activeColor;

              Provider.of<_MenuModel>(context, listen: false).inactiveColor =
                  inactiveColor;

              return _PinterestMenuBackground(child: _MenuItems(items));
            })));
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;
  const _PinterestMenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                //offset: Offset(10, 10),
                blurRadius: 10,
                spreadRadius: -5)
          ]),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems(this.menuItems);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length,
          (index) => _PinterestMenuButton(index, menuItems[index])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;
  const _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
        item.onPressed!();
      },
      behavior: HitTestBehavior.translucent,
      child: Icon(
        item.iconData,
        size: (itemSeleccionado == index) ? 30 : 25,
        color: (itemSeleccionado == index)
            ? menuModel.activeColor
            : menuModel.inactiveColor,
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;
  int get itemSeleccionado => _itemSeleccionado;
  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
