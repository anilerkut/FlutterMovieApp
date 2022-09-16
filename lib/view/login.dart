import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intern_movie_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

enum FormStatus { logIn, register }

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FormStatus _formStatus = FormStatus.logIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              //login ekranındaki logo
              flex: 4,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/logopopcorn.png")),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "GoldenPopcorn",
                        style: TextStyle(fontFamily: "Changa", fontSize: 40),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //logo ile formu ayıran boşluk
            Expanded(
              //form için ayrılan alan
              flex: 9,
              child: _formStatus == FormStatus.logIn
                  ? _logInForm(context)
                  : registerForm(context),
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _logInForm(BuildContext context) {
    final _logInFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return SingleChildScrollView(
      child: Form(
        key: _logInFormKey,
        child: Column(
          children: [
            Padding(
              //User email input kısmı
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value != null) {
                    if (!EmailValidator.validate(value)) {
                      return "Enter Valid Email";
                    } else {
                      return null;
                    }
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Enter Your Email",
                  labelText: "Email",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              //User password input kısmı
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: new BorderSide(color: Colors.teal)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              //login butonu ve üye değil misiniz butonu
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  //Login butonu
                  onPressed: () async {
                    if (_logInFormKey.currentState.validate() == true &&
                        _logInFormKey.currentState.validate() != null) {
                      final user = await Provider.of<AuthService>(context,
                              listen: false)
                          .signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                    }                
                  }, //login işlemleri burada
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontFamily: "Changa", fontSize: 17),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                  ),
                ),
                TextButton(
                  // Üye değil misiniz butonu?
                  onPressed: () {
                    _formStatus = FormStatus.register;
                    setState(() {});
                  },
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
            Padding(
              // divider çizgisi
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: Colors.grey,
                thickness: 0.6,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              //Google sign in butonu
              padding: const EdgeInsets.all(10.0),
              child: SignInButton(
                buttonType: ButtonType.google,
                buttonSize: ButtonSize.large,
                onPressed: () async {
                  final user =
                      await Provider.of<AuthService>(context, listen: false)
                          .signInWithGoogle();
                },
              ),
            ),
            Padding(
              //Facebook sign in butonu
              padding: const EdgeInsets.all(10.0),
              child: SignInButton(
                buttonType: ButtonType.facebook,
                buttonSize: ButtonSize.large,
                onPressed: () async {
                  final user =
                      await Provider.of<AuthService>(context, listen: false)
                          .signInWithFacebook();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget registerForm(BuildContext context) {
    final _registerFormKey = GlobalKey<FormState>();
    TextEditingController _registerEmailController = TextEditingController();
    TextEditingController _FirstpasswordController = TextEditingController();
    TextEditingController _SecondpasswordController = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: _registerFormKey,
        child: Column(
          children: [
            Text(
              '-Join The Best Movie Platform-',
              style: TextStyle(fontSize: 23, fontFamily: "Changa"),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                //Email kısmı
                controller: _registerEmailController,
                validator: (value) {
                  if (value != null) {
                    if (!EmailValidator.validate(value)) {
                      return "Enter Valid Email";
                    } else {
                      return null;
                    }
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                //password kısmı
                controller: _FirstpasswordController,
                validator: (value) {
                  if (value != null) {
                    if (value.length < 6)
                      return "Password must be longer than 6 characters";
                    else
                      return null;
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Enter Password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                //password eşleştrime kısmı
                controller: _SecondpasswordController,
                validator: (value) {
                  if (value != _FirstpasswordController.text) {
                    return "Passwords do not match!";
                  } else
                    return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password Again",
                  labelText: "Password Again",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              //Kayıt olma butonu
              onPressed: () async {
                if (_registerFormKey.currentState.validate() == true) {
                  final user = await Provider.of<AuthService>(
                    context,
                    listen: false,
                  ) //auth servisindeki createUser fonksiyonu sayesinde controllerdaki textleri göndererek user oluşturuldu
                      .createUserWithEmailAndPassword(
                          _registerEmailController.text,
                          _FirstpasswordController.text);
                  setState(() {
                    _formStatus = FormStatus.logIn;
                  });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Text(
                  'REGISTER',
                  style: TextStyle(fontFamily: "Changa", fontSize: 17),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // <-- Radius
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _formStatus = FormStatus.logIn;
                setState(() {});
              },
              child: Text(
                "Already Member?",
                style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
