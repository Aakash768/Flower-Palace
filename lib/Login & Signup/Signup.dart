import 'dart:convert';

import 'package:flower/Login%20&%20Signup/model/user.dart';
import '../api_conn/api_connection.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  Future<String?> validateUserEmail() async {
    try {
      print("Sending email for validation: ${emailController.text.trim()}");
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );
      print("Received response: ${res.body}");

      if (res.statusCode == 200) {
        try {
          var resBody = jsonDecode(res.body);
          if (resBody['emailFound'] == true) {
            return "Email is already in use"; // Email is already in use
          } else {
            return null; // Email is valid
          }
        } catch (e) {
          // Handle the case where the response is not valid JSON
          print("Invalid JSON response: ${res.body}");
          return "Invalid JSON response: ${res.body}";
        }
      } else {
        // Handle non-200 status codes (e.g., show an error message)
        print("HTTP Error: ${res.statusCode}");
        print("Content-Type: ${res.headers['content-type']}");
        return "HTTP Error: ${res.statusCode}";
      }
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      print("Error: $e");
      return "Network error: $e";
    }
  }




  Future<void> registerAndSaveUserRecord() async {
    User userModel = User(
      users_id: 1,
      user_name: usernameController.text.trim(),
      user_email: emailController.text.trim(),
      user_password: passwordController.text.trim(),
    );


    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success'] == true) {
          Fluttertoast.showToast(msg: "Signup Successful");
        } else {
          // You might want to display a more specific error message here
          Fluttertoast.showToast(msg: "Error Occurred");
        }
      } else {
        // Handle non-200 status codes (e.g., show an error message)
        Fluttertoast.showToast(msg: "HTTP Error: ${res.statusCode}");
      }
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight, // Remove the extra colon here
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: Image.asset('assets/images/login.jpg'), // Add a semicolon here
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: usernameController,
                                    validator: (val) =>
                                    val == "" ? "Please fill in the Field" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.houseboat_rounded,
                                      ),
                                      hintText: "Username",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) =>
                                    val == "" ? "Please fill in the Email Field" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                      ),
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: !isObsecure.value,
                                    validator: (val) =>
                                    val == "" ? "Please fill in the Password Field" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                      ),
                                      suffixIcon: Obx(
                                              () => GestureDetector(
                                            onTap:(){
                                              isObsecure.value = !isObsecure.value;

                                            },
                                            child: Icon(
                                              isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                          )

                                      ),
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(height: 20),



                          Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  String? validationMessage = await validateUserEmail();
                                  if (validationMessage == null) {
                                    await registerAndSaveUserRecord();
                                    Fluttertoast.showToast(msg: "Registered successfully");
                                  } else {
                                    Fluttertoast.showToast(msg: validationMessage);
                                  }
                                }
                              },



                          borderRadius: BorderRadius.circular(100),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 50,
                                          vertical: 28,
                                        ),
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(LoginScreen());

                                  },
                                  child: Text("Login Here", style: TextStyle(color: Colors.purpleAccent),),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }






}
