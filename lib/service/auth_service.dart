import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final firebaseAuth = FirebaseAuth.instance;

  Future signAnonymous() async{
    try {
      final result = await firebaseAuth.signInAnonymously();
      return result!.user;
    }
    catch(e){
      print("Anon Error $e");
      return null;
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          res = "Kullanici Bulunamadi";
          break;
        case "wrong-password":
          res = "Hatali Sifre";
          break;
        case "user-disabled":
          res = "Kullanici Pasif";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    catch(e){
      res = e.toString();
    }
    return res;
  }



  Future<String?> createUserWithEmailAndPassword(String email,String password) async{
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
     res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future forgotPassword(String email) async{
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print("mail kutunuzu kontrol edin");
    }
    catch(e){
      print("şifremi unuttum hata: $e");
      return null;
    }
  }
}