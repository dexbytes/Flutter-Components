import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputKeyboardType { email, phone, text, password, number, multiLine }

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {this.controllerT,
      this.maxLines = 1, //set maximum lines in text field
      this.maxCharLength = 50, // set maximum characters in text field
      this.inputHeight = 45, // set the height of a text field
      this.borderRadius = 0.5, // set border radius of text field
      this.hintText =
          'Enter some text...', // set place holder text in text field
      this.labelText = '', // set the label text in text field
      this.errorText = 'Please enter text', // set error text
      this.errorStyle, // set error text color
      this.enabledBorderColor, // set enabled border color of a text field
      this.focusedBorderColor, // set focused border color of a text field
      this.backgroundColor, // set background border color of a text field
      this.inputKeyboardType = InputKeyboardType
          .text, // set keyboard type of a text field // 1 = emailAddress, 2 = phone and 3 = text
      this.labelStyle, // set text color of a text field
      this.textStyle, // set text color of a text field
      this.hintStyle, // set text color of a text field
      this.capitalization =
          3, // set capitalization in a text field 1 = words, 2 = sentences
      @required this.onTextChange, // set the onChange function call back
      @required this.onEndEditing, // set the onSubmitted function call back
      this.showError = false,
      this.autoFocus = false,
      this.focusNode,
      this.placeHolderEdgeInsets,
      this.focusedBorderWidth,
      this.enabledBorderWidth,
      this.inputFieldSuffixIcon,
      this.cursorColor = Colors.black12,
      this.inputFieldPrefixIcon,
      this.prefixSuffixIconSiz,
      this.placeHolderTextWidget,
      this.onTapCallBack,
      this.isTextFieldEnabled = true,
      this.readOnly = false,
      this.showCounterText = false,
      this.textAlignment,
      this.contentPadding,
      this.obscureText,
      this.textInputAction});

  final bool showError;
  final bool autoFocus;
  final bool obscureText;
  final bool showCounterText;
  final double inputHeight;
  final double borderRadius;
  final int maxLines;
  final int maxCharLength;
  final int capitalization;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final String hintText;
  final String labelText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color backgroundColor;
  final Color cursorColor;
  final TextStyle labelStyle;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final String errorText;
  final TextStyle errorStyle;
  final InputKeyboardType inputKeyboardType;
  final EdgeInsets placeHolderEdgeInsets;
  final ValueChanged onTextChange;
  final ValueChanged onEndEditing;
  final FocusNode focusNode;
  final TextEditingController controllerT;
  final inputFieldSuffixIcon;
  final inputFieldPrefixIcon;
  final Size prefixSuffixIconSiz;
  final Widget placeHolderTextWidget;
  final GestureTapCallback onTapCallBack;
  final bool isTextFieldEnabled;
  final bool readOnly;
  final TextAlign textAlignment;
  final contentPadding;
  final TextInputAction textInputAction;

  TextStyle timeStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null ? texColor : Colors.black12,
        fontSize: fontSize != null ? fontSize : 11,
        fontFamily: fontFamily != null ? fontFamily : null,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: placeHolderEdgeInsets == null
                ? (placeHolderTextWidget != null
                    ? EdgeInsets.fromLTRB(0, 0, 0, 5)
                    : EdgeInsets.fromLTRB(0, 0, 0, 0))
                : placeHolderEdgeInsets,
            child: placeHolderTextWidget,
          ),
          GestureDetector(
            onTap: onTapCallBack,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: inputHeight,
              color: Colors.transparent,
              child: Center(
                child: IgnorePointer(
                  ignoring: !isTextFieldEnabled,
                  child: TextField(
                    readOnly: readOnly,
                    autofocus: autoFocus ?? false,
                    maxLines: maxLines,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(maxCharLength),
                    ],
                    textInputAction: maxLines > 1
                        ? TextInputAction.newline
                        : textInputAction == null
                            ? TextInputAction.done
                            : TextInputAction.next,
                    textAlign:
                        textAlignment == null ? TextAlign.left : textAlignment,
                    controller: controllerT,
                    focusNode: focusNode,
                    enabled: isTextFieldEnabled,
                    onChanged: (maxCharLength != null)
                        ? (value) {
                            if (value != null &&
                                value.length <= maxCharLength) {
                              //oldVal = value;
                              onTextChange(value);
                            } else {
                              controllerT.text =
                                  value.substring(0, maxCharLength);
                            }
                          }
                        : onTextChange,
                    cursorColor: cursorColor,
                    onSubmitted: (maxCharLength != null)
                        ? (value) {
                            if (value != null &&
                                value.length <= maxCharLength) {
                              //oldVal = value;
                              onEndEditing(value);
                            } else {
                              controllerT.text =
                                  value.substring(0, maxCharLength);
                            }
                          }
                        : onEndEditing,
                    style: textStyle,
                    obscureText: obscureText ??
                        inputKeyboardType == InputKeyboardType.password,
                    buildCounter: (
                      BuildContext context, {
                      int currentLength,
                      int maxLength,
                      bool isFocused,
                    }) =>
                        showCounterText
                            ? Text(
                                '$currentLength/$maxCharLength',
                                style: timeStyle(),
                                semanticsLabel: 'character count',
                              )
                            : null,
                    textCapitalization: capitalization == 1
                        ? TextCapitalization.words
                        : capitalization == 2
                            ? TextCapitalization.none
                            : capitalization == 5
                                ? TextCapitalization.characters
                                : TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding:
                          contentPadding ?? EdgeInsets.fromLTRB(10, 5, 5, 10),
                      suffixIcon: inputFieldSuffixIcon,
                      prefixIcon: inputFieldPrefixIcon,
                      hintText: hintText,
                      hintStyle: hintStyle != null
                          ? hintStyle
                          : TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              backgroundColor: Colors.transparent),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius),
                        ),
                        borderSide: BorderSide(
                          color: enabledBorderColor != null
                              ? enabledBorderColor
                              : Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          color: enabledBorderColor != null
                              ? enabledBorderColor
                              : Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      labelText: labelText.length > 0 ? labelText : null,
                      labelStyle: labelStyle != null
                          ? labelStyle
                          : TextStyle(
                              color: Colors.black,
                              backgroundColor: Colors.transparent),
                      errorText: showError
                          ? (errorText != null)
                              ? errorText.trim()
                              : errorText
                          : null,
                      errorStyle: errorStyle != null
                          ? errorStyle
                          : TextStyle(color: Colors.red),
                      fillColor: backgroundColor != null
                          ? backgroundColor
                          : Colors.transparent,
                      filled: true,
                      focusColor: Colors.blue,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius),
                        ),
                        borderSide: BorderSide(
                          color: enabledBorderColor != null
                              ? enabledBorderColor
                              : Colors.grey,
                          width: enabledBorderWidth ?? 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius),
                        ),
                        borderSide: BorderSide(
                          color: focusedBorderColor != null
                              ? focusedBorderColor
                              : Colors.grey,
                          width: focusedBorderWidth ?? 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    keyboardType: inputKeyboardType == InputKeyboardType.email
                        ? TextInputType.emailAddress
                        : inputKeyboardType == InputKeyboardType.phone
                            ? TextInputType.phone
                            : inputKeyboardType == InputKeyboardType.text
                                ? TextInputType.text
                                : inputKeyboardType == InputKeyboardType.number
                                    ? TextInputType.number
                                    : inputKeyboardType ==
                                            InputKeyboardType.multiLine
                                        ? TextInputType.multiline
                                        : TextInputType.text,
                    maxLength:
                        maxLines > 1 ? maxCharLength ?? 800 : maxCharLength,
                    maxLengthEnforced: true,
                    /*style: TextStyle(
                      height: inputHeight,
                    ),*/
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
