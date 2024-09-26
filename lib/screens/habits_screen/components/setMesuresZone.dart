import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class setMesuresDataZone extends StatefulWidget {
  bool enable;
  List<Map<String, dynamic>> allTextFields;
  setMesuresDataZone(
      {Key? key, required this.allTextFields, required this.enable})
      : super(key: key);

  @override
  State<setMesuresDataZone> createState() => _setMesuresDataZoneState();
}

class _setMesuresDataZoneState extends State<setMesuresDataZone> {
  bool _expanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: 4),
        margin: EdgeInsets.all(10),
        color: Colors.white,
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 2000),
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  leading: Icon(Icons.menu_rounded, color: Colors.black),
                  title: Text(
                    'Prise de Mesures',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                );
              },
              body: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 25.0),
                child: Wrap(
                  spacing: 5,
                  children: List.generate(widget.allTextFields.length, (index) {
                    Map<String, dynamic> entree = widget.allTextFields[index];
                    return Container(
                      width: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              entree['name'],
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: ThemeColors.greyDeep,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              key: widget.key,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              controller: entree['controller'],
                              decoration:
                                  const InputDecoration(hintText: "Valeur..."),
                              enabled: widget.enable,
                            ),
                          ]),
                    );
                  }),
                ),
              ),
              isExpanded: _expanded,
              canTapOnHeader: true,
            ),
          ],
          dividerColor: Colors.grey,
          expansionCallback: (panelIndex, isExpanded) {
            _expanded = !_expanded;
            setState(() {});
          },
        ),
      ),
    ]);
  }
}
