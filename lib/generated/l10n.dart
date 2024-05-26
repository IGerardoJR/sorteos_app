// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the 'LABELS GENERALES' key

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get exit {
    return Intl.message(
      'Close',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get EXIT_DIALOG {
    return Intl.message(
      '',
      name: 'EXIT_DIALOG',
      desc: '',
      args: [],
    );
  }

  /// `Close App`
  String get exit_title {
    return Intl.message(
      'Close App',
      name: 'exit_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to close this app?`
  String get exit_content {
    return Intl.message(
      'Do you want to close this app?',
      name: 'exit_content',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get BARRA_NAVEGACION_TITULOS {
    return Intl.message(
      '',
      name: 'BARRA_NAVEGACION_TITULOS',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get nav_main {
    return Intl.message(
      'Main',
      name: 'nav_main',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get nav_history {
    return Intl.message(
      'History',
      name: 'nav_history',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get nav_settings {
    return Intl.message(
      'Settings',
      name: 'nav_settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get nav_about {
    return Intl.message(
      'About',
      name: 'nav_about',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get DRAWER_MENU {
    return Intl.message(
      '',
      name: 'DRAWER_MENU',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get drawer_title {
    return Intl.message(
      'Menu',
      name: 'drawer_title',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PAGINA_AJUSTES {
    return Intl.message(
      '',
      name: 'PAGINA_AJUSTES',
      desc: '',
      args: [],
    );
  }

  /// `Countdown`
  String get countdown {
    return Intl.message(
      'Countdown',
      name: 'countdown',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Delete all participants after draw`
  String get deleteAfter {
    return Intl.message(
      'Delete all participants after draw',
      name: 'deleteAfter',
      desc: '',
      args: [],
    );
  }

  /// `Enable draw animations`
  String get activateAnimations {
    return Intl.message(
      'Enable draw animations',
      name: 'activateAnimations',
      desc: '',
      args: [],
    );
  }

  /// `Allow duplicated names`
  String get duplicatedNames {
    return Intl.message(
      'Allow duplicated names',
      name: 'duplicatedNames',
      desc: '',
      args: [],
    );
  }

  /// `Edit participant`
  String get editparticipant {
    return Intl.message(
      'Edit participant',
      name: 'editparticipant',
      desc: '',
      args: [],
    );
  }

  /// `Show deletion dialog`
  String get showDeleteDialog {
    return Intl.message(
      'Show deletion dialog',
      name: 'showDeleteDialog',
      desc: '',
      args: [],
    );
  }

  /// `Maximum cells in a row on mosaic mode `
  String get maxCells {
    return Intl.message(
      'Maximum cells in a row on mosaic mode ',
      name: 'maxCells',
      desc: '',
      args: [],
    );
  }

  /// `Personalization`
  String get personalization {
    return Intl.message(
      'Personalization',
      name: 'personalization',
      desc: '',
      args: [],
    );
  }

  /// `Theme color`
  String get themeApp {
    return Intl.message(
      'Theme color',
      name: 'themeApp',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get language {
    return Intl.message(
      'Select language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Enable dark mode`
  String get thememode {
    return Intl.message(
      'Enable dark mode',
      name: 'thememode',
      desc: '',
      args: [],
    );
  }

  /// `Choice a color`
  String get modalchoicecolor {
    return Intl.message(
      'Choice a color',
      name: 'modalchoicecolor',
      desc: '',
      args: [],
    );
  }

  /// `Choice one of the following colors:`
  String get choicecolor {
    return Intl.message(
      'Choice one of the following colors:',
      name: 'choicecolor',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PAGINA_ACERCADE {
    return Intl.message(
      '',
      name: 'PAGINA_ACERCADE',
      desc: '',
      args: [],
    );
  }

  /// `Developed by`
  String get developedby {
    return Intl.message(
      'Developed by',
      name: 'developedby',
      desc: '',
      args: [],
    );
  }

  /// `(Software Engineer)`
  String get career {
    return Intl.message(
      '(Software Engineer)',
      name: 'career',
      desc: '',
      args: [],
    );
  }

  /// `Let's make real your ideas!`
  String get letsmakereal {
    return Intl.message(
      'Let\'s make real your ideas!',
      name: 'letsmakereal',
      desc: '',
      args: [],
    );
  }

  /// `My social networks`
  String get contact {
    return Intl.message(
      'My social networks',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PAGINA_RESULTADOSANTERIORES {
    return Intl.message(
      '',
      name: 'PAGINA_RESULTADOSANTERIORES',
      desc: '',
      args: [],
    );
  }

  /// `Winner: {name}`
  String pastwinner(Object name) {
    return Intl.message(
      'Winner: $name',
      name: 'pastwinner',
      desc: '',
      args: [name],
    );
  }

  /// `Number of participants: `
  String get amount {
    return Intl.message(
      'Number of participants: ',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Make your first draw!`
  String get firstdraw {
    return Intl.message(
      'Make your first draw!',
      name: 'firstdraw',
      desc: '',
      args: [],
    );
  }

  /// `Date: {month} {day}, {year} at {hora}:{minuto} hours`
  String datetimedraw(
      Object month, Object day, Object year, Object hora, Object minuto) {
    return Intl.message(
      'Date: $month $day, $year at $hora:$minuto hours',
      name: 'datetimedraw',
      desc: '',
      args: [month, day, year, hora, minuto],
    );
  }

  /// `Delete all`
  String get historydelall {
    return Intl.message(
      'Delete all',
      name: 'historydelall',
      desc: '',
      args: [],
    );
  }

  /// `This action will delete all draw records. Do you want to continue?`
  String get history_warningmessage {
    return Intl.message(
      'This action will delete all draw records. Do you want to continue?',
      name: 'history_warningmessage',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get TRADUCCION_MESES {
    return Intl.message(
      '',
      name: 'TRADUCCION_MESES',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `Febraury`
  String get febraury {
    return Intl.message(
      'Febraury',
      name: 'febraury',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PRINCIPAL {
    return Intl.message(
      '',
      name: 'PRINCIPAL',
      desc: '',
      args: [],
    );
  }

  /// `Draw title`
  String get main_hintitle {
    return Intl.message(
      'Draw title',
      name: 'main_hintitle',
      desc: '',
      args: [],
    );
  }

  /// `List of participants`
  String get main_ltspart {
    return Intl.message(
      'List of participants',
      name: 'main_ltspart',
      desc: '',
      args: [],
    );
  }

  /// `Make the draw!`
  String get main_btndraw {
    return Intl.message(
      'Make the draw!',
      name: 'main_btndraw',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get main_btnadd {
    return Intl.message(
      'Add',
      name: 'main_btnadd',
      desc: '',
      args: [],
    );
  }

  /// `The title is empty or its not valid`
  String get main_errortext_textfield {
    return Intl.message(
      'The title is empty or its not valid',
      name: 'main_errortext_textfield',
      desc: '',
      args: [],
    );
  }

  /// `Add at least 1 participant`
  String get main_emptycontainer {
    return Intl.message(
      'Add at least 1 participant',
      name: 'main_emptycontainer',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PRINCIPAL_MODALVIEW {
    return Intl.message(
      '',
      name: 'PRINCIPAL_MODALVIEW',
      desc: '',
      args: [],
    );
  }

  /// `Add new participant`
  String get main_modal_titlelabel {
    return Intl.message(
      'Add new participant',
      name: 'main_modal_titlelabel',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to add the participants?`
  String get main_modal_subtext_one {
    return Intl.message(
      'How would you like to add the participants?',
      name: 'main_modal_subtext_one',
      desc: '',
      args: [],
    );
  }

  /// `You can add the participants adding them manually or you can upload a text file`
  String get main_modal_subtext_two {
    return Intl.message(
      'You can add the participants adding them manually or you can upload a text file',
      name: 'main_modal_subtext_two',
      desc: '',
      args: [],
    );
  }

  /// `Manually`
  String get main_modal_btnmanual {
    return Intl.message(
      'Manually',
      name: 'main_modal_btnmanual',
      desc: '',
      args: [],
    );
  }

  /// `Upload file`
  String get main_modal_btnsubir {
    return Intl.message(
      'Upload file',
      name: 'main_modal_btnsubir',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PRINCIPAL_MODALVIEW_MANUAL {
    return Intl.message(
      '',
      name: 'PRINCIPAL_MODALVIEW_MANUAL',
      desc: '',
      args: [],
    );
  }

  /// `Add new participant`
  String get main_modal_manual_title {
    return Intl.message(
      'Add new participant',
      name: 'main_modal_manual_title',
      desc: '',
      args: [],
    );
  }

  /// `In the next field write the of new participant:`
  String get main_modal_manual_content {
    return Intl.message(
      'In the next field write the of new participant:',
      name: 'main_modal_manual_content',
      desc: '',
      args: [],
    );
  }

  /// `Name goes here`
  String get main_modal_manual_hintext {
    return Intl.message(
      'Name goes here',
      name: 'main_modal_manual_hintext',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get main_modal_manual_action {
    return Intl.message(
      'Add',
      name: 'main_modal_manual_action',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PRINCIPAL_MODALVIEW_ARCHIVO {
    return Intl.message(
      '',
      name: 'PRINCIPAL_MODALVIEW_ARCHIVO',
      desc: '',
      args: [],
    );
  }

  /// `Upload a file`
  String get main_modal_archivo_title {
    return Intl.message(
      'Upload a file',
      name: 'main_modal_archivo_title',
      desc: '',
      args: [],
    );
  }

  /// `You can import the participant's list from a file`
  String get main_modal_archivo_subtextone {
    return Intl.message(
      'You can import the participant\'s list from a file',
      name: 'main_modal_archivo_subtextone',
      desc: '',
      args: [],
    );
  }

  /// `The file extension allowed is .txt `
  String get main_modal_archivo_subtextwo {
    return Intl.message(
      'The file extension allowed is .txt ',
      name: 'main_modal_archivo_subtextwo',
      desc: '',
      args: [],
    );
  }

  /// `No file selected`
  String get main_modal_archivo_defaultempty {
    return Intl.message(
      'No file selected',
      name: 'main_modal_archivo_defaultempty',
      desc: '',
      args: [],
    );
  }

  /// `Select a file`
  String get main_modal_archivo_btntext {
    return Intl.message(
      'Select a file',
      name: 'main_modal_archivo_btntext',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get PRINCIPAL_ALERT_NODISPONIBLE {
    return Intl.message(
      '',
      name: 'PRINCIPAL_ALERT_NODISPONIBLE',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get na_information {
    return Intl.message(
      'Information',
      name: 'na_information',
      desc: '',
      args: [],
    );
  }

  /// `This feature is not available on web version.`
  String get na_text {
    return Intl.message(
      'This feature is not available on web version.',
      name: 'na_text',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get EDITAR_PARTICIPANTE {
    return Intl.message(
      '',
      name: 'EDITAR_PARTICIPANTE',
      desc: '',
      args: [],
    );
  }

  /// `Edit participant`
  String get edit_bartitle {
    return Intl.message(
      'Edit participant',
      name: 'edit_bartitle',
      desc: '',
      args: [],
    );
  }

  /// `You haven't added any participant yet`
  String get edit_empty {
    return Intl.message(
      'You haven\'t added any participant yet',
      name: 'edit_empty',
      desc: '',
      args: [],
    );
  }

  /// `Search by name`
  String get edit_filter {
    return Intl.message(
      'Search by name',
      name: 'edit_filter',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit_alert_update_title {
    return Intl.message(
      'Edit',
      name: 'edit_alert_update_title',
      desc: '',
      args: [],
    );
  }

  /// `In this section you can edit the participant you've choosen`
  String get edit_alert_update_content {
    return Intl.message(
      'In this section you can edit the participant you\'ve choosen',
      name: 'edit_alert_update_content',
      desc: '',
      args: [],
    );
  }

  /// `Current name:`
  String get edit_alert_update_currentnamelabel {
    return Intl.message(
      'Current name:',
      name: 'edit_alert_update_currentnamelabel',
      desc: '',
      args: [],
    );
  }

  /// `New name:`
  String get edit_alert_update_newnamelabel {
    return Intl.message(
      'New name:',
      name: 'edit_alert_update_newnamelabel',
      desc: '',
      args: [],
    );
  }

  /// `New name`
  String get edit_alert_update_textfield_hint {
    return Intl.message(
      'New name',
      name: 'edit_alert_update_textfield_hint',
      desc: '',
      args: [],
    );
  }

  /// `Delete participant`
  String get edit_alert_delete_title {
    return Intl.message(
      'Delete participant',
      name: 'edit_alert_delete_title',
      desc: '',
      args: [],
    );
  }

  /// `If you have added by a mistake a participant in this section you can delete it.This confirmation dialog can be disabled in the settings`
  String get edit_alert_delete_content {
    return Intl.message(
      'If you have added by a mistake a participant in this section you can delete it.This confirmation dialog can be disabled in the settings',
      name: 'edit_alert_delete_content',
      desc: '',
      args: [],
    );
  }

  /// `The seletec participant to be deleted is:`
  String get edit_alert_delete_additional_label {
    return Intl.message(
      'The seletec participant to be deleted is:',
      name: 'edit_alert_delete_additional_label',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to continue?`
  String get edit_alert_delete_continue {
    return Intl.message(
      'Do you want to continue?',
      name: 'edit_alert_delete_continue',
      desc: '',
      args: [],
    );
  }

  /// `Do not show this dialog again`
  String get edit_alert_delete_checktext {
    return Intl.message(
      'Do not show this dialog again',
      name: 'edit_alert_delete_checktext',
      desc: '',
      args: [],
    );
  }

  /// `   Name`
  String get edit_table_name {
    return Intl.message(
      '   Name',
      name: 'edit_table_name',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get edit_table_modify {
    return Intl.message(
      'Modify',
      name: 'edit_table_modify',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get edit_table_delete {
    return Intl.message(
      'Delete',
      name: 'edit_table_delete',
      desc: '',
      args: [],
    );
  }

  /// `Action to be taken`
  String get edit_segmented_label {
    return Intl.message(
      'Action to be taken',
      name: 'edit_segmented_label',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}