import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

// Variables globales
late Box boxSorteo;
bool eliminarTodos = false;
ThemeData tema = ThemeData.light();
int cuentaRegresiva = 3;
int numeroGanadores = 1;
bool nombresDuplicados = false;