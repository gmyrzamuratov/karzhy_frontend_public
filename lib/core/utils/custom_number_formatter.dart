import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'functions.dart';

class CustomNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate

    late TextSelection newSelection;
    final TextSelection currentSelection = newValue.selection;

    int direction = newValue.text.length > oldValue.text.length? 1 : newValue.text.length < oldValue.text.length ? -1 : 0;

    String truncated = newValue.text;

    // if deleted " " we must delete symbol before " "
    if(direction==-1) {
      if(oldValue.text.substring(currentSelection.baseOffset,currentSelection.baseOffset+1)==" ") {
        truncated = truncated.substring(0, currentSelection.baseOffset-1) + truncated.substring(currentSelection.baseOffset, truncated.length);
      }
    }

    // if added "." or "," in middle
    bool itWasForbidSymbol = false;
    if(direction == 1) {
      String newSymbol = truncated.substring(currentSelection.start-1, currentSelection.start);
      if(newSymbol=="," || newSymbol==".") {
        truncated = truncated.substring(0, currentSelection.start-1) + truncated.substring(currentSelection.start, truncated.length);
        newSelection = new TextSelection.fromPosition(
            new TextPosition(offset: truncated.length - 2));
        itWasForbidSymbol = true;
      }
    }

    // if deleting symbol is "," then cancel deletion
    if(direction == -1) {
      String symbol = oldValue.text.substring(currentSelection.start, currentSelection.start+1);
      if(symbol==",") {
        truncated = oldValue.text;
      }
    }
    truncated = truncated.replaceAll(" ", "");
    truncated = truncated.replaceAll(",", ".");

    // For initial value
    if(oldValue.text=="0,00") {
      truncated = truncated.replaceAll("0.", ".");
    }

    if(direction==1) {
      if(truncated.indexOf(".")>0){
        if((truncated.length-1-truncated.indexOf("."))>2) {
          truncated = truncated.substring(0, truncated.indexOf(".")+3);
        }
      }
    }

    if(direction == 1
        && truncated.indexOf(".") !=1
        && truncated.indexOf(".")%3 == 1
        && !itWasForbidSymbol
    ) { // for triads
      newSelection = new TextSelection.fromPosition(
          new TextPosition(offset: currentSelection.baseOffset + 1));
    } else if(direction == -1
        && truncated.indexOf(".") !=1
        && truncated.indexOf(".")%3 == 0
        && (currentSelection.baseOffset < oldValue.text.indexOf(",")) // position of cursor not after .
    ) { // for triads
      newSelection = new TextSelection.fromPosition(
          new TextPosition(offset: currentSelection.baseOffset - 1));
    } else if(itWasForbidSymbol) {
    } else {
      newSelection = currentSelection;
    }

    print("FORMATTEDSUM=" + truncated);
    double amount = double.parse(truncated);
    print("SELECTION POSITION=" + newSelection.baseOffset.toString());

    truncated = Functions().getFormattedNumber(amount);
    //print("TRUNCATEDSUM=" + truncated);

    if(newSelection.baseOffset > truncated.length) {
      newSelection = new TextSelection.fromPosition(
          new TextPosition(offset: truncated.length));
    }

    return TextEditingValue(
        text: truncated,
        selection: newSelection
    );
  }
}