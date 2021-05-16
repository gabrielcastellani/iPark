import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  CardTextField(
      {this.title,
      this.hint,
      this.textInputType,
      this.inputFormatters,
      this.validator,
      this.maxLength,
      this.textAlign = TextAlign.start,
      this.focusNode,
      this.onSubmitted,
      this.onSaved,
      this.initialValue,
      this.bold = false});

  final String title;
  final String hint;
  final bool bold;
  final int maxLength;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      validator: validator,
      onSaved: onSaved,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (title != null)
                Row(
                  children: <Widget>[
                    label(),
                    if (state.hasError)
                      const Text(
                        '   Inválido',
                        style: TextStyle(color: Colors.red, fontSize: 9),
                      )
                  ],
                ),
              input(state),
            ],
          ),
        );
      },
    );
  }

  Widget label() {
    return Text(
      title,
      style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
    );
  }

  Widget input(state) {
    return TextFormField(
      style: TextStyle(
        color: title == null && state.hasError ? Colors.red : Colors.white,
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: title == null && state.hasError
                ? Colors.red.withAlpha(200)
                : Colors.white.withAlpha(100)),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 2),
        counterText: '',
      ),
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      textAlign: textAlign,
      onChanged: (text) {
        state.didChange(text);
      },
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      initialValue: initialValue,
    );
  }
}
