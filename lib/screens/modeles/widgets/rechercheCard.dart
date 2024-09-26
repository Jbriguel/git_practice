import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RechercheBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Function onClear;
  RechercheBar({super.key, required this.onClear, required this.onChanged});
  @override
  State<RechercheBar> createState() => _RechercheBarState();
}

class _RechercheBarState extends State<RechercheBar> {
  final TextEditingController Ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      color: Colors.white.withOpacity(0.8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextFormField(
              controller: Ctrl,
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "rechercher...",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade200),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  iconSize: 20.0,
                  color: ThemeColors.redOrange,
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  iconSize: 20.0,
                  color: ThemeColors.redOrange,
                  onPressed: () {
                    setState(() {
                      Ctrl.text = "";
                      widget.onClear();
                    });
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
