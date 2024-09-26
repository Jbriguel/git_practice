import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/screens/clients/addClient/form/addCLient_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ContactAndDeatils extends StatefulWidget {
  bool enable;
  final TextEditingController nomFullCtrl;
  final TextEditingController adresseCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;

  ContactAndDeatils({
    Key? key,
    required this.enable,
    required this.nomFullCtrl,
    required this.adresseCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
  }) : super(key: key);

  @override
  State<ContactAndDeatils> createState() => _ContactAndDeatilsState();
}

class _ContactAndDeatilsState extends State<ContactAndDeatils> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white10, width: 2),
      ),
      child: ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 2000),
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return const ListTile(
                leading: Icon(Icons.person, color: ThemeColors.greyDeep),
                title: Text(
                  'Informations du clients',
                  style: TextStyle(
                      color: ThemeColors.greyDeep,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddClientForm(
                // enable: true,
                nomFullCtrl: widget.nomFullCtrl,
                adresseCtrl: widget.adresseCtrl,
                phoneCtrl: widget.phoneCtrl,
                emailCtrl: widget.emailCtrl,
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
    );
  }
}
