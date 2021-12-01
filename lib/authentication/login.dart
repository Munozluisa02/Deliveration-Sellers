import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveration_sellers/global/global.dart';
import 'package:deliveration_sellers/main_screens/home_screen.dart';
import 'package:deliveration_sellers/widgets/custom_text_field.dart';
import 'package:deliveration_sellers/widgets/error_dialog.dart';
import 'package:deliveration_sellers/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      //login
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Please fill all the info");
          }
      );
    }
  }

  loginNow() async{
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(message: "Checking credentials");
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: error.message.toString()
            );
          }
      );
    });
    if(currentUser != null){
      readDataAndSetDataLocally(currentUser!).then((value){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      });
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance.collection("sellers")
        .doc(currentUser.uid)
        .get().then((snapshot) async{
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
          await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                //TODO implement home image
                "images",
                height: 270
              ),
            ),
          ),
          Form(
            key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObscure: true,
                  ),
                ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              formValidation();
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

