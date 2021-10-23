import 'package:flutter/material.dart';
import 'package:tests_unitarios_rocket/models/user.dart';

import 'history_item_widget.dart';

class HistoryListWidget extends StatelessWidget {
  HistoryListWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          user.history.length > 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Histórico',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 16,
            width: double.infinity,
          ),
          Expanded(
              child: user.history.length > 0
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                        );
                      },
                      itemCount: user.history.length,
                      itemBuilder: (_, index) {
                        return HistoryItemWidget(
                          history: user.history[index],
                          index: index,
                        );
                      },
                    )
                  : Text(
                      'Nenhuma operação recente.',
                      key: Key('HistoryEmpty'),
                    )),
        ],
      ),
    );
  }
}
