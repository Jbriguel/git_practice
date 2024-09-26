import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/RecentFile.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: ThemeColors.white),
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              dataTextStyle: TextStyle(color: ThemeColors.white),
              columns: [
                DataColumn(
                  label: Text(
                    "File Name",
                    style: TextStyle(color: ThemeColors.white),
                  ),
                ),
                DataColumn(
                  onSort: (columnIndex, ascending) {},
                  label: Text(
                    "Date",
                    style: TextStyle(color: ThemeColors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Size",
                    style: TextStyle(color: ThemeColors.white),
                  ),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
              // color: ThemeColors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                fileInfo.title!,
                style: TextStyle(color: ThemeColors.white),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
