import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class formulario extends StatefulWidget {
  @override
  _formularioRegistroState createState() => _formularioRegistroState();
}

class _formularioRegistroState extends State<formulario> {
  final formKey = new GlobalKey<FormState>();

  final _controllerUsuario = TextEditingController();
  final _controllerContrasena = TextEditingController();
  final _controllerCorreo = TextEditingController();

  String _usuario;
  String _contrasena;
  String _email;

  String nombre = '';
  String contrasena = '';
  String correo = '';

  String nombreGuardado = '';
  String correoGuardado = '';

  @override
  Widget build(BuildContext context) {
    setState(() {
      obtenerPreferencias();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[600],
        centerTitle: true,
        title: Text('Creat your account', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Container(
                width: 100,
                height: 100
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.black,
                              ),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                validator: (valor) => valor.length < 3
                                    ? 'El nombre no es vible'
                                    : null,
                                controller: _controllerUsuario,
                                onSaved: (valor) => _usuario = valor,
                                decoration:
                                InputDecoration(labelText: 'Usuario'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.lock,
                                  size: 30, color: Colors.black),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerContrasena,
                                validator: (valor) => valor.length < 3
                                    ? 'La contraseña no es viable'
                                    : null,
                                onSaved: (valor) => _contrasena = valor,
                                decoration:
                                InputDecoration(labelText: 'Contraseña'),
                                obscureText: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.mail,
                                  size: 30, color: Colors.black),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerCorreo,
                                validator: (valor) => !valor.contains('@')
                                    ? 'Ingresa un email no es viable'
                                    : null,
                                onSaved: (valor) => _email = valor,
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Radio(value: null, groupValue: null, onChanged: null),
                          RichText(
                            text: TextSpan(
                                text: ' ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: '',
                                      style: TextStyle(
                                          color: Colors.amberAccent[600],
                                          fontWeight: FontWeight.bold))
                                ]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              final form = formKey.currentState;
                              if (form.validate()) {
                                setState(() {
                                  nombre = _controllerUsuario.text;
                                  correo = _controllerCorreo.text;
                                  guardarPreferencias();
                                });
                                pushPage();
                              }
                            },
                            color: Colors.amberAccent[600],
                            child: Text(
                              'Check in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
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

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('_sesion')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent[600],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Welcome',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Datos ingresados:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$nombreGuardado'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$correoGuardado'),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Sign off'),
                            content: Text(
                                '¿Seguro que desea cerrar la sesión?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('YES'),
                                onPressed: () {
                                  Navigator.of(context).pop('YES');
                                },
                              ),
                              FlatButton(
                                child: Text('NO'),
                                onPressed: () {
                                  Navigator.of(context).pop('NO');
                                },
                              )
                            ],
                          ),
                        ).then((result) {
                          if (result == 'YES') {
                            cerrarSesion();
                          }
                        });
                      },
                      color: Colors.amberAccent[600],
                      child: Text(
                        'Sign off',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    }
  }

  void pushPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[600],
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Welcome',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Datos ingresados:',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(nombre),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(correo),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Sign off'),
                          content:
                          Text('¿Seguro que desea cerrar sesión'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('YES'),
                              onPressed: () {
                                Navigator.of(context).pop('YES');
                              },
                            ),
                            FlatButton(
                              child: Text('NO'),
                              onPressed: () {
                                Navigator.of(context).pop('NO');
                              },
                            )
                          ],
                        ),
                      ).then((result) {
                        if (result == 'YES') {
                          cerrarSesion();
                        }
                      });
                    },
                    color: Colors.amberAccent,
                    child: Text(
                      'Sign off',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  Future<void> guardarPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    datos.setString('nombre', _controllerUsuario.text);
    datos.setString('correo', _controllerCorreo.text);
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    setState(() {
      nombreGuardado = datos.get('nombre') ?? nombre;
      correoGuardado = datos.get('correo') ?? correo;
    });
  }

  Future<void> cerrarSesion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', false);
    setState(() {
      nombreGuardado = '';
      correoGuardado = '';
    });
    Navigator.pop(context);
  }
}