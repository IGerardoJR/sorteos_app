// main.dart: Archivo principal de ejecucion.
// Paquetes de la libreria o externos.
import 'dart:math';
import 'package:app_sorteos/generated/l10n.dart';
import 'package:app_sorteos/pages/post_sorteo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

// Vistas.
import 'package:app_sorteos/pages/settings_page.dart';
import 'package:app_sorteos/pages/about_page.dart';
import 'package:app_sorteos/pages/anteriores_page.dart';
import 'package:app_sorteos/pages/editar_participante_page.dart';

// Modelos.
import 'package:app_sorteos/models/boxes.dart';
import 'package:app_sorteos/models/Archivo.dart';
import 'package:app_sorteos/models/Sorteo.dart';
// Providers
import 'package:provider/provider.dart';
import 'package:app_sorteos/provider/main_provider.dart';
import 'package:app_sorteos/provider/participantes_provider.dart';

void main(List<String> args) async {
  // Por defecto cargamos el idiioma en ES solo para evitar un error a la hora de cargar la app, en el initState lo podremos cambiar.
  S.load(Locale('es'));
  // Se inicializa la db
  await Hive.initFlutter();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Hive.registerAdapter(SorteoAdapter());
  // indicamos la caja en donde se guardaran los datos.
  boxSorteo = await Hive.openBox<Sorteo>('sorteoBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => ParticipanteProvider()),
      ],
      child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/ganador': (context) => PostPage(),
            '/editar': (context) => EditarPage(),
          },
          home: MyApp()),
    ),
  );
}

TextEditingController textEditingController = TextEditingController();

class MyApp extends StatefulWidget {
  MyApp({Key? key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState({Key? key});

  var objSettings = new SettingsPageState();

  double? _deviceWidth, _deviceHeight;
  Archivo archivo = Archivo();
  String? _nuevoParticipante;

  late int _selectedIndex = 0;
  bool _mostrarErrorText = false;

  bool _activarErrorTextAnadirParticipante = false;

  // Manejo de campos vacios
  Color _colorContenedorBorder = Colors.grey.shade700;
  bool? _visibleLabel = false;

  late List<dynamic> _gradiente;

  final List<Widget> _listaWidgets = [
    const Text(
      'No implementation for this page',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    AnterioresPage(),
    SettingsPage(),
    AboutPage()
  ];

  void cambiarPagina(int indice) {
    setState(() {
      _selectedIndex = indice;
    });
  }

  void cambiarAnimada() {
    Navigator.pushNamed(context, '/ganador');
    validarEliminarTodos();
  }

  void validarEliminarTodos() {
    if (context.read<ParticipanteProvider>().eliminarPostSorteo == true) {
      setState(() {
        listaParticipantes = [];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  Future<void> cargarDatos() async {
    // Creamos instancia de sharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Cargamos cada una de las opciones
    setState(() {
      // General
      eliminarTodos = prefs.getBool('key_elitodos') ?? true;
      activarAnimacion = prefs.getBool('key_animaciones') ?? true;
      indiceListaConteo = prefs.getInt('key_conteoreg') ?? listaConteo.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    _gradiente = context.watch<MainProvider>().gradiente;
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    // Cargamos el idioma mediante el indice del enum el cual esta alojado en el provider.
    S.load((context.watch<MainProvider>().indiceEnumIdioma == 0)
        ? Locale('es')
        : Locale('en'));
    List<String> _titulosSuperior = [
      S.current.home,
      S.current.nav_history,
      S.current.nav_settings,
      S.current.nav_about
    ];
    // Cargamos los datos pertinentes para saber si eliminar o no a los participantes post sorteo.
    context.read<ParticipanteProvider>().cargarDatos();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        setState(() {
          (kIsWeb == false)
              ? showDialog(
                  context: context,
                  builder: (context) => _alertSalirAplicacion())
              : null;
        });
      },
      child: MaterialApp(
        // locale:
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Builder(
                builder: (context) => (_deviceHeight! >= 350)
                    ? IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )
                    : const SizedBox()),
            title: Text('${_titulosSuperior[_selectedIndex]}',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Manrope', fontSize: 18)),
            backgroundColor: context.watch<MainProvider>().colorGlobal,
            centerTitle: false,
          ),
          body: (_selectedIndex == 0)
              ? (_deviceHeight! >= 350)
                  ? _menuPrincipal()
                  : _mensajeAlturaInsuficiente()
              : (_deviceHeight! >= 350)
                  ? _listaWidgets[_selectedIndex]
                  : _mensajeAlturaInsuficiente(),
          drawer: Drawer(
            shape: ShapeBorder.lerp(null, null, 15.0),
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            semanticLabel: 'Drawer',
            // surfaceTintColor: Colors.yellow,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text(
                    S.current.drawer_title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cerdaville'),
                  ),
                  decoration: BoxDecoration(
                      color: context.watch<MainProvider>().colorGlobal),
                ),
                Builder(builder: (context) {
                  return ListTile(
                    leading: Icon(
                      Icons.menu,
                      color: (_selectedIndex == 0)
                          ? context.read<MainProvider>().colorGlobal
                          : Colors.black,
                    ),
                    selected: (_selectedIndex == 0) ? true : false,
                    onTap: () {
                      setState(() {
                        cambiarPagina(0);
                        Navigator.pop(context);
                      });
                    },
                    selectedColor: context.read<MainProvider>().colorGlobal,
                    title: Text(S.current.home),
                  );
                }),
                Builder(builder: (context) {
                  return ListTile(
                    leading: Icon(
                      Icons.history,
                      color: (_selectedIndex == 1)
                          ? context.read<MainProvider>().colorGlobal
                          : Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        cambiarPagina(1);
                        Navigator.pop(context);
                      });
                    },
                    selected: (_selectedIndex == 1) ? true : false,
                    selectedColor: context.read<MainProvider>().colorGlobal,
                    title: Text(S.current.nav_history),
                  );
                }),
                Builder(builder: (context) {
                  return ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: (_selectedIndex == 2)
                          ? context.read<MainProvider>().colorGlobal
                          : Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        cambiarPagina(2);
                        Navigator.pop(context);
                      });
                    },
                    selected: (_selectedIndex == 2) ? true : false,
                    selectedColor: context.read<MainProvider>().colorGlobal,
                    title: Text(S.current.nav_settings),
                  );
                }),
                Builder(builder: (context) {
                  return ListTile(
                    leading: Icon(
                      Icons.message,
                      color: (_selectedIndex == 3)
                          ? context.read<MainProvider>().colorGlobal
                          : Colors.black,
                    ),
                    selected: (_selectedIndex == 3) ? true : false,
                    onTap: () {
                      setState(() {
                        cambiarPagina(3);
                        Navigator.pop(context);
                      });
                    },
                    selectedColor: context.read<MainProvider>().colorGlobal,
                    title: Text(S.current.nav_about),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuPrincipal() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: _deviceHeight! * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tituloSorteo(),
                Center(child: Text(S.current.main_ltspart)),
                // child:Text(S.current.main_ltspart),
                _visibleLabel!
                    ? Text(
                        S.current.main_emptycontainer,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      )
                    : SizedBox(),
                _contenedorListaParticipantes(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: (_deviceWidth! > 400)
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _btnRealizarSorteo(context),
                      Padding(padding: const EdgeInsets.only(bottom: 10)),
                      _btnAgregarParticipantes(),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _btnRealizarSorteo(context),
                      Padding(padding: const EdgeInsets.only(bottom: 10)),
                      _btnAgregarParticipantes(),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  // btnAgregarParticipantes
  Widget _btnAgregarParticipantes() {
    return SizedBox(
      height: _deviceHeight! * 0.06,
      width: 205,
      child: ElevatedButton(
          onPressed: () => {
                showModalBottomSheet(
                    showDragHandle: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        width: _deviceWidth! * 0.95,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                child: Text(S.current.main_modal_titlelabel,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Manrope',
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              Text(
                                S.current.main_modal_subtext_one,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(S.current.main_modal_subtext_two),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) =>
                                                  _alertAnadirUnParticipante(
                                                      setState),
                                            );
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_add_alt_1_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          S.current.main_modal_btnmanual,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                                builder: (context, setState) =>
                                                    (kIsWeb)
                                                        ? _alertNoDisponibleWeb()
                                                        : _alertAnadirArchivo(
                                                            archivo, setState));
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.upload_file,
                                            color: Colors.white),
                                        Text(
                                          S.current.main_modal_btnsubir,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      );
                    }),
              },
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.white),
              Text(S.current.main_btnadd,
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.read<MainProvider>().colorGlobal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )),
    );
  }

//  Esta validacion se hace para el titulo y para los participantes(Solo modo manual, ya que el modo archivo esta validado de otra forma).
  bool _validarCaracteres(String cadenaValidar) {
    List<int> _caracteresNoValidos = [];
    _generadorElementos(_caracteresNoValidos, 33, 47);
    _generadorElementos(_caracteresNoValidos, 58, 64);
    _generadorElementos(_caracteresNoValidos, 91, 95);
    _generadorElementos(_caracteresNoValidos, 165, 255);

    for (int i = 0; i < cadenaValidar.length; i++) {
      if (_buscarElemento(
          _caracteresNoValidos, cadenaValidar[i].codeUnitAt(0))) {
        return true;
      }
    }
    return false;
  }

  bool _buscarElemento(lista, elemento) {
    int inicio = 0;
    int fin = lista.length - 1;
    while (inicio <= fin) {
      int medio = ((inicio + fin) / 2).floor();
      if (lista[medio] == elemento) {
        return true;
      }
      if (lista[medio] < elemento) {
        inicio = medio + 1;
      } else {
        fin = medio - 1;
      }
    }
    return false;
  }

  void _generadorElementos(List<dynamic> lista, int inicio, int fin) {
    for (int i = inicio; i <= fin; i++) {
      lista.add(i);
    }
  }

  Widget _tituloSorteo() {
    return SizedBox(
        width: _deviceWidth! * 0.80,
        child: TextField(
            controller: textEditingController,
            onChanged: (_) {
              setState(() {
                vTituloSorteo = _;
                if (vTituloSorteo.isEmpty ||
                    _validarCaracteres(vTituloSorteo)) {
                  _mostrarErrorText = true;
                } else {
                  _mostrarErrorText = false;
                }
              });
            },
            onSubmitted: (_nuevoValor) => {vTituloSorteo = _nuevoValor},
            obscureText: false,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.read<MainProvider>().colorGlobal.shade900),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.read<MainProvider>().colorGlobal),
                ),
                errorText:
                    (_mostrarErrorText || _validarCaracteres(vTituloSorteo))
                        ? S.current.main_errortext_textfield
                        : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: S.current.main_hintitle)));
  }

  Widget _contenedorListaParticipantes() {
    return Container(
      height: _deviceHeight! * 0.40,
      width: _deviceWidth! * 0.80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _colorContenedorBorder)),
      child: Padding(
        padding: EdgeInsets.only(
            left: _deviceWidth! * 0.015, top: _deviceHeight! * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListView(
                    children: [Text('${listaParticipantes.join(', ')}')])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${listaParticipantes.length}',
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {
                              setState(() {
                                // Se redirije al usuario a la pagina de editar_participante.
                                Navigator.pushNamed(context, '/editar');
                              }),
                              // Cargamos los datos preconfigurados al entrar en el modo de edicion.
                              context.read<ParticipanteProvider>().cargarDatos()
                            },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        enableFeedback: true,
                        onPressed: () => {
                              setState(() {
                                // Vaciamos la lista general
                                listaParticipantes = [];
                              })
                            },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void calcularGanador() {
    Random ran = Random();
    // Tendra como rango maximo hasta la longitud maxima del arreglo en donde estan almacenado los participantes
    //                          1 - capacidad actual del arreglo
    try {
      int? indice = ran.nextInt(listaParticipantes.length);
      ganadorSorteo = listaParticipantes[indice];
      setState(() {
        visibleFloatingAnteriores = true;
        _colorContenedorBorder = Colors.grey;
        _visibleLabel = false;
      });
    } catch (e) {
      setState(() {
        if (listaParticipantes.isEmpty) {
          _colorContenedorBorder = Colors.red;
          _visibleLabel = true;
        }
      });
    }
  }

  Widget _mensajeAlturaInsuficiente() {
    return Center(
        child: Text(
      S.current.displaymessage,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ));
  }

  Widget _btnRealizarSorteo(dynamic context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: _deviceHeight! * 0.06,
          child: Opacity(
            opacity: (textEditingController.text.isNotEmpty &&
                    listaParticipantes.isNotEmpty &&
                    _validarCaracteres(vTituloSorteo) == false &&
                    textEditingController.text.toString().codeUnitAt(0) != 32)
                ? 1.0
                : 0.65,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [..._gradiente]),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () => {
                  calcularGanador(),
                  if (listaParticipantes.isNotEmpty &&
                      textEditingController.text.isNotEmpty &&
                      _validarCaracteres(vTituloSorteo) == false &&
                      textEditingController.text.toString().codeUnitAt(0) != 32)
                    {
                      boxSorteo.put(
                          'key_${textEditingController.text}_${ganadorSorteo}',
                          Sorteo.conDatos(
                              tituloSorteo: textEditingController.text,
                              cantParticipantes: listaParticipantes.length,
                              ganadorSorteo: ganadorSorteo)),
                      activarAnimacion
                          ? cambiarAnimada()
                          : showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _alertDialogSinAnimacion(),
                            ),
                      validarEliminarTodos()
                    }
                  else
                    {
                      setState(() {
                        textEditingController.text.isEmpty ||
                                textEditingController.text
                                        .toString()
                                        .codeUnitAt(0) ==
                                    32
                            ? _mostrarErrorText = true
                            : _mostrarErrorText = false;
                      })
                    }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                        (textEditingController.text.isNotEmpty &&
                                listaParticipantes.isNotEmpty)
                            ? Icons.play_circle
                            : Icons.play_disabled,
                        color: Colors.white),
                    Text(
                      S.current.main_btndraw,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

// Añade los participantes de tu sorteo desde un archivo
  Widget _alertAnadirArchivo(Archivo archivo, state) {
    String _nombreArchivoSeleccionado =
        archivo.getNombreArchivo() ?? S.current.main_modal_archivo_defaultempty;
    return AlertDialog(
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        children: [
          Icon(Icons.file_upload),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(S.current.main_modal_archivo_title,
              style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
      content: SizedBox(
        height: _deviceHeight! * 0.30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              S.current.main_modal_archivo_subtextone,
              style: TextStyle(fontFamily: 'Barlow'),
            ),

            Text(
              S.current.main_modal_archivo_subtextwo,
              style: TextStyle(fontFamily: 'Barlow'),
            ),
            Text(
              "${_nombreArchivoSeleccionado}",
              style:
                  TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.bold),
            ),
            // "${_nombreArchivoSeleccionado.substring(1, _nombreArchivoSeleccionado.length - 1)}"),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.read<MainProvider>().colorGlobal,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                onPressed: () => {
                      archivo.abrirArchivo().then((nombreArchivo) {
                        _nombreArchivoSeleccionado = nombreArchivo;
                      }).onError((error, stackTrace) {
                        _nombreArchivoSeleccionado =
                            'Error al cargar el archivo';
                      }).whenComplete(() {
                        // Actualizamos la ui una vez este seleccionado el archivo.
                        state(() => {});
                      }),
                    },
                child: Text(
                  S.current.main_modal_archivo_btntext,
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {
            Navigator.pop(context),
            setState(() {
              if (listaParticipantes.isNotEmpty) {
                _visibleLabel = false;
                _colorContenedorBorder = Colors.grey;
              }
            })
          },
          child: Text(
            S.current.exit,
            style: TextStyle(color: context.read<MainProvider>().colorGlobal),
          ),
        )
      ],
    );
  }

  Widget _alertSalirAplicacion() {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black,
      title: Row(
        children: [
          Icon(Icons.exit_to_app, color: Colors.black),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            S.current.exit_title,
            style: TextStyle(
                fontFamily: 'Manrope',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ],
      ),
      content: Text(
        S.current.exit_content,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: Text(
            S.current.exit,
            style: TextStyle(
                color: context.read<MainProvider>().colorGlobal.shade900),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.current.cancel,
            style: TextStyle(
                color: context.read<MainProvider>().colorGlobal.shade900),
          ),
        )
      ],
    );
  }

  Widget _alertAnadirUnParticipante(state) {
    return AlertDialog(
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.black,
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            S.current.main_modal_manual_title,
            style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.main_modal_manual_content,
            style: TextStyle(fontFamily: 'Manrope'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextField(
              onChanged: (_) {
                state(() {
                  _nuevoParticipante = _;
                  if (_nuevoParticipante!.isEmpty ||
                      _validarCaracteres(_nuevoParticipante!)) {
                    _activarErrorTextAnadirParticipante = true;
                  } else {
                    _activarErrorTextAnadirParticipante = false;
                  }
                });
              },
              decoration: InputDecoration(
                errorText: (_activarErrorTextAnadirParticipante)
                    ? S.current.main_errortext_textfield
                    : null,
                enabled: true,
                labelText: S.current.main_modal_manual_hintext,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => {
            setState(() {
              // Caso en el que todo este bien
              // true | false
              if (_nuevoParticipante!.isNotEmpty &&
                  _validarCaracteres(_nuevoParticipante!) == false &&
                  _nuevoParticipante.toString().codeUnitAt(0) != 32) {
                listaParticipantes.add(_nuevoParticipante!);
                _activarErrorTextAnadirParticipante = false;
                Navigator.pop(context);
                // Limipamos el nombre guardado en cache
                _nuevoParticipante = '';
              } else if (_validarCaracteres(_nuevoParticipante!) ||
                  _nuevoParticipante!.isEmpty ||
                  _nuevoParticipante.toString().codeUnitAt(0) == 32) {
                state(() {
                  _activarErrorTextAnadirParticipante = true;
                });
              }
              if (listaParticipantes.isNotEmpty) {
                _colorContenedorBorder = Colors.grey;
                _visibleLabel = false;
              } else {
                _colorContenedorBorder = Colors.red;
                _visibleLabel = true;
              }
            })
          },
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                S.current.add,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () => {
                  // Se devuelve a inicio y no agrega a la lista el participante
                  Navigator.pop(context),
                  setState(() {
                    _activarErrorTextAnadirParticipante = false;
                  })
                },
            child: Text(
              S.current.cancel,
              style: TextStyle(
                  color: context.read<MainProvider>().colorGlobal.shade900),
            ))
      ],
    );
  }

  Widget _alertNoDisponibleWeb() {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(S.current.na_information),
        ],
      ),
      content: Text(S.current.na_text),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.current.ok,
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: context.read<MainProvider>().colorGlobal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              shadowColor: Colors.black),
        ),
      ],
    );
  }

  Widget _alertDialogSinAnimacion() {
    return AlertDialog(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            S.current.draw_result_title,
            style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.noanimated_content(vTituloSorteo),
            style: TextStyle(
                fontFamily: 'Barlow',
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Padding(
            padding: EdgeInsets.only(top: _deviceHeight! * 0.03),
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: context.read<MainProvider>().colorGlobal,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '$ganadorSorteo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => {
            setState(() {
              boxSorteo.put(
                  'key_${textEditingController.text}_${ganadorSorteo}',
                  Sorteo.conDatos(
                      tituloSorteo: textEditingController.text,
                      cantParticipantes: listaParticipantes.length,
                      ganadorSorteo: ganadorSorteo));
              validarEliminarTodos();
            }),
            Navigator.pop(context),
          },
          child: Text(
            S.current.ok,
            style: TextStyle(
                color: context.read<MainProvider>().colorGlobal.shade900),
          ),
        )
      ],
    );
  }
}
