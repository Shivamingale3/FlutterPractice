import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController inputController;
  final String inputType;
  final bool isPassword;
  const InputWidget(
      {super.key,
      required this.inputController,
      required this.inputType,
      required this.isPassword});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  // Remove late initialization since we can access widget properties directly
  bool _passwordVisible = false;

  IconData _getIconForInputType() {
    switch (widget.inputType.toLowerCase()) {
      case 'email':
        return Icons.email;
      case 'phone':
        return Icons.phone;
      case 'password':
        return Icons.lock;
      case 'name':
        return Icons.person;
      default:
        return Icons.edit;
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.inputType.toLowerCase()) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  String _getHintText() {
    return 'Enter your ${widget.inputType.toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ],
      ),
      child: TextField(
        controller: widget.inputController,
        onChanged: (value) {
          print(value);
        },
        obscureText: widget.isPassword && !_passwordVisible,
        keyboardType: _getKeyboardType(),
        style: TextStyle(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            _getIconForInputType(),
            color: Colors.white,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  color: Colors.white,
                )
              : null,
          filled: true,
          fillColor: Colors.black,
          hintText: _getHintText(),
          hintStyle: TextStyle(color: Colors.white.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
