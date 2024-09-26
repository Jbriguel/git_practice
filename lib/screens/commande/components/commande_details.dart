import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CommandeDetailsZone extends StatefulWidget {
  bool enable;
  DateTime dateTime;
  final Function SelectDate;
  TextEditingController commandeNote;
  TextEditingController priceCtrl;
  TextEditingController advanceCtrl;
  CommandeDetailsZone({
    Key? key,
    required this.enable,
    required this.dateTime,
    required this.SelectDate,
    required this.commandeNote,
    required this.priceCtrl,
    required this.advanceCtrl,
  }) : super(key: key);
  @override
  State<CommandeDetailsZone> createState() => _CommandeDetailsZoneState();
}

class _CommandeDetailsZoneState extends State<CommandeDetailsZone> {
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
                leading: Icon(LineAwesomeIcons.info_circle_solid,
                    color: ThemeColors.greyDeep),
                title: Text(
                  'Commande Détails',
                  style: TextStyle(
                      color: ThemeColors.greyDeep,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Date de Remise de la commande',
                style: TextStyle(
                    fontSize: 12.0,
                    color: ThemeColors.greyDeep,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child:
                    /*   CustomElevatedButton(
                      text: 'Choisir Date',
                      iconData: Icons.image,
                      onPressed: () => widget.enable ? widget.SelectDate() : {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child:*/
                    CustomTextFormField(
                  enable: widget.enable,
                  hintText:
                      '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
                  textInputAction: TextInputAction.next,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      iconSize: 24,
                      onPressed: () => widget.enable ? widget.SelectDate() : {},
                      icon: const Icon(
                        Icons.calendar_month,
                        color: ThemeColors.redOrange,
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: ThemeColors.white.withOpacity(0.7)),
                    ),
                  ),
                
                ),
                // ),
              ),

              //############################################
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Text(
                            'Prix',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: ThemeColors.greyDeep,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CustomTextFormField(
                            enable: widget.enable,
                            controller: widget.priceCtrl,
                            hintText: '00',
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            textColor: ThemeColors.greyDeep,
                            fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                            filled: true,
                            suffix: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Fcfa',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color:
                                          ThemeColors.greyDeep.withOpacity(0.6),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Text(
                            'Advance',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: ThemeColors.greyDeep,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomTextFormField(
                            enable: widget.enable,
                            controller: widget.advanceCtrl,
                            hintText: '00',
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            textColor: ThemeColors.greyDeep,
                            fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                            filled: true,
                            suffix: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Fcfa',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color:
                                          ThemeColors.greyDeep.withOpacity(0.6),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //############################################
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Center(
                  child: Text(
                    'Note Supplémentaire',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: ThemeColors.greyDeep,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  enable: widget.enable,
                  hintText: 'Ajouter une note...',
                  textInputAction: TextInputAction.next,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  controller: widget.commandeNote,
                  maxLines: 4,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ]),
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
