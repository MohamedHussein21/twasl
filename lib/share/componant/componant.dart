import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/color.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color1
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: color1
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,style:const TextStyle(color: Colors.redAccent),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );


void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );


enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}



AppBar buildAppBar(BuildContext context ,{Widget? leading,List<Widget>? actions,String? title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title:  Text(title!),
    centerTitle: true,
    leading: leading,
    actions: actions ,
  );
}

Widget buildContainer(BuildContext context,{Widget? child}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(45),
          topLeft: Radius.circular(45),
        ),
        color: Colors.white),
    child: child,
  );
}

Widget buildProfileInfo(BuildContext context,
    { String? text, Widget? iconLeading,String? info}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text!,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            info!,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 20,
      ),
      iconLeading!
    ],
  );
}