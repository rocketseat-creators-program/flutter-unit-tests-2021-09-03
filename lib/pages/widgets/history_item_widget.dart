import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tests_unitarios_rocket/models/history.dart';
import 'package:tests_unitarios_rocket/models/operation.dart';

class HistoryItemWidget extends StatelessWidget {
  HistoryItemWidget({Key? key, required this.history, required this.index})
      : super(key: key);
  final History history;
  final int index;

  final DateFormat _dateFormatter = DateFormat('d/M/y');

  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'pt_br', symbol: 'R\$');
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('HistoryItem${index.toString()}'),
      contentPadding: EdgeInsets.symmetric(horizontal: 32),
      onTap: () {},
      title: Text(
        history.description,
        key: Key('HistoryTitle${index.toString()}'),
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      trailing: Text(
        _dateFormatter.format(history.dateTime),
        key: Key('HistoryDate${index.toString()}'),
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.grey[600]),
      ),
      subtitle: Text(
        '${_formatter.format((history.value))}',
        key: Key('HistorySubtitle${index.toString()}'),
      ),
      leading: Container(
        height: 32,
        width: 32,
        decoration:
            BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
        child: history.type == OperationType.deposit
            ? Icon(
                Icons.add,
                key: Key('IconDeposit${index.toString()}'),
                color: Colors.black,
                size: 18,
              )
            : Icon(
                Icons.remove,
                key: Key('IconWithdraw${index.toString()}'),
                color: Colors.black,
                size: 18,
              ),
      ),
    );
  }
}
