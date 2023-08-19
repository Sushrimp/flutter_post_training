import 'package:flutter/material.dart';
import 'package:flutter_qualif/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  void resetError(){
    setState(() {
      usernameError = passwordError = null;
    });
  }

  void handleLogin(){
    resetError();
    bool usernameValid = false;
    bool passwordValid = false;
    String username = usernameController.text;
    String password = passwordController.text;

    if(username.isEmpty){
      usernameError = "Username cannot be empty";
    }
    else if(username.length > 20){
      usernameError = "Username cannot be more than 20 characters";
    }
    else if(RegExp(r'[0-9]').hasMatch(username)){
      usernameError = "Username must not contain numbers";
    }
    else {
      usernameValid = true;
    }

    if(password.isEmpty){
      passwordError = "Password cannot be empty";
    }
    else if(!RegExp(r'[a-zA-Z]').hasMatch(password) || !RegExp(r'[0-9]').hasMatch(password)){
      passwordError = "Password must be alphanumeric";
    }
    else {
      passwordValid = true;
    }

    if(!usernameValid || !passwordValid) { return; }
    else {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return MainPage(username : username);
      },), ((route) => false));
    }
  }

// --------------------------------------------------------------------------------------------------------------
// ------------------------------------------------ App ---------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Image.asset("assets/logo.png", height: 50,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30,10,30,10),
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text("Login", style: TextStyle(color: Colors.white, fontSize: 25,),),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "Username",
                  hintStyle: const TextStyle(color: Colors.white),
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Change border color when focused
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Initial border color
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorText: usernameError,
                )
              ), //Username
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  hintStyle: const TextStyle(color: Colors.white),
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorText: passwordError,
                )
              ), //Password
              Center(
                child: OutlinedButton(
                  onPressed: handleLogin,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ), 
                  child: const Text("Login", style: TextStyle(color: Colors.white,),),
                  ),
              ) //Login Button
            ],
          ),
        )
      ),
    );
  }
}