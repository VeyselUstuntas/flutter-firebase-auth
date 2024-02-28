
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_kullanimi/common/colors.dart';
import 'package:firebase_kullanimi/features/auth/views/sign_up.dart';
import 'package:firebase_kullanimi/features/home.dart';
import 'package:firebase_kullanimi/service/auth_service.dart';
import 'package:firebase_kullanimi/utils/cutom_text_button.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var authService = AuthService();
  late bool degisken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.firebaseAuth.authStateChanges().listen((User? user) {
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
       print(user.uid);
      }
    });
  }

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
                image: AssetImage("assets/images/sign_in.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          AspectRatio(aspectRatio: 1/1.1,
            child: Form(key:formKey ,
              child: Container(
                decoration:const BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft,child: Padding(
                        padding: EdgeInsets.only(left: 15.0,bottom: 15,top: 20),
                        child: Text("Sign In",style: TextStyle(fontSize: 24,color: Colors.white,),),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0,bottom: 20),
                        child: TextFormField(
                          controller: tfEmail ,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Email Bilgisi Boş Bırakılamaz.";
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
                              return "Şifre Bilgisi Boş Bıraklılamaz";
                            }
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
                                  final result = await authService.signIn(tfEmail.text, tfPassword.text);
                                  if (result == "success") {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => Home()),
                                            (route) => false);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Hata"),
                                            content: Text(result!),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text("Geri Don"))
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                              color: loginButtonColor,
                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                              child: Text("Sign In",style: TextStyle(fontSize: 16, color: Colors.white),)),
                        ),
                      ),
                      Container(
                        child: InkWell(
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();

                              }
                                
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left:17,top: 20,bottom: 20),
                              child: Align(alignment: Alignment.centerLeft,child: Text("Forgot Password?", style: TextStyle(color: loginForgotPassColor,fontSize: 14),)),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t haven’t an account ?",style: TextStyle(color: loginForgotPassColor),),
                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                                
                          }, child: Text("Sign Up"))
                                
                      ],),
                      CustomTextButton(
                          onPressed: () async {
                            var anonymous = await authService.signAnonymous();
                            if(anonymous != null){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                            }
                            else{
                              print("Hata ile karşılaşıldı");
                            }

                          },
                          buttonText: "Misafir Girişi",
                          textColor: Colors.green,)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
