import 'package:hive/hive.dart';

// Variables globales
late Box boxSorteo;
List<String> listaParticipantes = List.empty(growable: true);

// Checkbox
bool eliminarTodos = true;
bool activarAnimacion = true;
bool nombresDuplicados = true;
int indiceListaConteo = listaConteo.first;
List<int> listaConteo = [5, 7, 10, 15, 30, 3];
bool visibleFloatingAnteriores = (boxSorteo.isNotEmpty) ? true : false;
String? ganadorSorteo;
String vTituloSorteo = '';
double? opacidadCuentaRegresiva = 1.0;
