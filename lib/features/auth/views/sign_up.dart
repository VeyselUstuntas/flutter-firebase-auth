import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_kullanimi/common/colors.dart';
import 'package:firebase_kullanimi/service/auth_service.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sign_up.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AspectRatio(aspectRatio: 1/0.9,
            child: Form(
              key: formKey,
              child: Container(
                decoration: const BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Align(alignment: Alignment.centerLeft,child: Padding(
                      padding: EdgeInsets.only(left: 15.0,bottom: 15,top: 20),
                      child: Text("Sign Up",style: TextStyle(fontSize: 24,color: Colors.white,),),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0,left: 15.0,bottom: 20),
                      child: TextFormField(
                        controller: tfEmail ,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Bilgileri Eksiksiz Doldurun";
                          }
                          else{

                          }
                        },
                        onSaved: (newValue) {
                          tfEmail.text = newValue!;
                        },
                        decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: loginTextFieldHintColor),
                            filled: true,
                            fillColor: loginTextFieldFillColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: loginTextFieldBorderColor,width: 10))
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0,left: 15.0,bottom: 20),
                      child: TextFormField(
                        controller: tfPassword,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Bilgileri Eksiksiz Doldurun";
                          }
                          else{}
                        },
                        onSaved: (newValue) {
                          tfPassword.text = newValue!;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: loginTextFieldBorderColor,width: 10)),
                            hintText: "Password",
                            hintStyle: TextStyle(color: loginTextFieldHintColor),
                            filled: true,
                            fillColor: loginTextFieldFillColor
                        ),),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 17,
                      child: Padding(
                        padding: const EdgeInsets.only(right:15, left:15),
                        child: MaterialButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();
                                try{
                                  final userResult = await auth.createUserWithEmailAndPassword(tfEmail.text, tfPassword.text);
                                  if(userResult == "success"){
                                    print(userResult);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kayıt Tamamlandı Giriş Ekranına Yönlendiriliyorsunuz")));
                                    Navigator.pop(context);
                                  }
                                  else{
                                    print(userResult);
                                  }
                                  formKey.currentState!.reset();

                                }
                                catch(e){
                                  print(e.toString());
                                }
                              }
                            },
                            color: loginButtonColor,
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                            child: Text("Sign Up",style: TextStyle(fontSize: 16, color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
