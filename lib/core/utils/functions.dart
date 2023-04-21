import 'package:intl/intl.dart';

class Functions {

  String getFormattedNumber(double amount) {

    var f = NumberFormat('0.00');
    f.currencyName = 'тг';
    String strAmount = f.format(amount);
    strAmount = strAmount.replaceAll('.', ',');

    bool triada = false;
    int index = 0;
    for(int i = strAmount.length; i>0; i--) {
      if(triada == false) {
        if(strAmount[i-1] == ',') {
          triada = true;
        }
      } else {
        if(index == 3) {
          strAmount = strAmount.substring(0, i) + " " + strAmount.substring(i);
          index = 0;
        }
        index += 1;
      }

    }

    return strAmount;
  }

}