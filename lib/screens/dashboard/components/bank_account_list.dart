import 'package:admin/models/BankAccount.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class BankAccountList extends StatelessWidget {
  const BankAccountList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Accounts",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 530,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn2(
                  label: Text("Organization"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Bank"),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text("IBAN"),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text("Currency"),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text("Swift Code"),
                  size: ColumnSize.S,
                ),
              ],
              rows: List.generate(
                bankAccounts.length,
                (index) => bankAccountDataRow(bankAccounts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow bankAccountDataRow(BankAccount bankAccount) {
  String hideAddress(String address) {
    return address.substring(0, 6) + '...' + address.substring(address.length - 4, address.length);
  }

  return DataRow(
    cells: [
      DataCell(
        Container(
          padding: EdgeInsets.all(defaultPadding * 0.6),
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            color: bankAccount.organizationColor.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              bankAccount.organizationName.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      DataCell(
        Container(
              padding: EdgeInsets.all(defaultPadding * 0.6),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                bankAccount.bankName.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
      ),
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(bankAccount.iban),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.copy))
          ],
        ),
      ),
      DataCell(
        Text(bankAccount.currency.toString()),
      ),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 100),
          child: Text(
            bankAccount.swiftCode.toString(),
          ),
        ),
      ),
    ],
  );
}
