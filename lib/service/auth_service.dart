import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _firebaseAuth = FirebaseAuth.instance;

  Future signAnonymous() async{
    try {
      final result = await _firebaseAuth.signInAnonymously();
      return result!.user;
    }
    catch(e){
      print("Anon Error $e");
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }
    catch(e){
      print("Giriş Hatası: $e");
      return null;
    }
  }

  Future createUserWithEmailAndPassword(String email,String password) async{
    try{
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }
    catch(e){
      print("Kayıt Hatası: $e");
      return null;
    }
  }
}