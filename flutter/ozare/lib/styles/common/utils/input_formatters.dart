import 'package:flutter/services.dart';

class InputFormatters {
  static final spaceNotAllowed =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));
}

// class DOBTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String newText = newValue.text;
//     int selectionEnd = newValue.selection.end;

//     if (newText.length > 10) {
//       newText = oldValue.text;
//       selectionEnd = oldValue.selection.end;
//     }

//     if (newText.length == 2 || newText.length == 5) {
//       newText =
//           "${newText.substring(0, newText.length - 1)}/${newText.substring(newText.length - 1)}";
//       selectionEnd += 1;
//     }

//     if (newText.length < 10) {
//       newText = newText.replaceAll("/", "");
//       selectionEnd -= newText.length - oldValue.text.length;
//     }

//     return TextEditingValue(
//       text: newText,
//       selection: TextSelection.collapsed(offset: selectionEnd),
//     );
//   }
// }
