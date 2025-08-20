import 'package:flutter/material.dart';

class Utility {
  static String emailAddressText = "Email Address";
  static String fullNameText = "Full Name";
  static String passwordText = "Password";
  static String confirmPassText = "Confirm Password";
  static String registerText = "Register";
  static String newAccountText = "New Account";
  static String signUpText = "Sign Up";
  static String signInText = "Sign In";
  static String welcomeText = "Welcome Back";
  static String dontHaveAccText = "Welcome Back";
  static String crtAccText = "Create Account";
  static String urAccText = "Sign in to your account";
  static String newAccText =  "Register a new account";
  static String fillDetailText =  "Fill in the details to get started";

  static customTextField(name, icon, input, hint, controller, formValidator,
      {isPassword = false, suffixIcon,maxLine = 1, mixLine = 1, enable = true}) {
    return TextFormField(
      keyboardType: input,
      enabled: enable,
      obscureText: isPassword,
      controller: controller,
      validator: formValidator,
      decoration: InputDecoration(
        fillColor: Colors.black54,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Colors.deepPurple)),

        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            name,
            maxLines: maxLine,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  static customButton(name, onPressed, color) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22), // <-- Radius
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 13),
        child: Text(
          name,
          style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ElevatedButton.icon(
  // onPressed: () {  ref.read(counterProvider.notifier).increment();},
  // icon: const Icon(Icons.add,color: Colors.white,),
  // label: const Text("Increment",style: TextStyle(color: Colors.white),),
  // style: ElevatedButton.styleFrom(
  // backgroundColor: Colors.green,
  // ),
  // ),
    static customTrackButton(name,icon, color,onPressed) {
    return ElevatedButton.icon(

      onPressed: onPressed,icon: Icon(icon,color: Colors.white,),
      label:  Text(name,style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(
      backgroundColor: color,
      )
    );

  }


}