import 'package:flutter/material.dart';
import 'package:trello/export.dart';
import 'package:trello/values/query.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var logi = TextEditingController();
  var pass = TextEditingController();
  bool obsr = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://picsum.photos/200/300'))),
        child: SafeArea(
            child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.40,
            child: Card(
                elevation: 5,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text(
                        "Tizimga kirish",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: logi,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Parol',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        obscureText: obsr,
                        controller: pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsr = !obsr;
                                  });
                                },
                                icon: obsr
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            prefixIcon: const Icon(Icons.security),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        child: const Text('Kirish'),
                        onPressed: () async {
                          await Login(
                              logi.text.toString(), pass.text.toString());
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Home()),
                              ModalRoute.withName('/'));
                        },
                      )
                    ],
                  ),
                )),
          ),
        )));
  }
}
