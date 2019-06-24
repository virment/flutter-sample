import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Auth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String username = 'Your Name';
 
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    setState(() {
      username = user.displayName;
    });
    return user;
  }

  Future<void> _handleSignOut() async {
    _auth.signOut();
    setState(() {
      username = 'Your name';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$username',
              style: Theme.of(context).textTheme.display1,
            ),
           
           StreamBuilder(
              stream: _auth.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MaterialButton(
                    onPressed: () => _handleSignOut(),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Signout'),
                  );
                } else {
                  return MaterialButton(
                    onPressed: () => _handleSignIn()
                          .then((FirebaseUser user) => setState(() {
                            username = user.displayName;
                            print(username);
                          }))
                          .catchError((e) => print(e)),
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text('Login with Google'),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}

