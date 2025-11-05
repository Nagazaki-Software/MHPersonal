import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/filtro_exercicio_admin_widget.dart';
import '/components/headerweb_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'create_rotina_de_treino_copy_model.dart';
export 'create_rotina_de_treino_copy_model.dart';

class CreateRotinaDeTreinoCopyWidget extends StatefulWidget {
  const CreateRotinaDeTreinoCopyWidget({
    super.key,
    required this.users,
    required this.treino,
    required this.tre,
  });

  final DocumentReference? users;
  final DocumentReference? treino;
  final List<String>? tre;

  static String routeName = 'CreateRotinaDeTreinoCopy';
  static String routePath = 'createRotinaDeTreinoCopy';

  @override
  State<CreateRotinaDeTreinoCopyWidget> createState() =>
      _CreateRotinaDeTreinoCopyWidgetState();
}

class _CreateRotinaDeTreinoCopyWidgetState
    extends State<CreateRotinaDeTreinoCopyWidget> {
  late CreateRotinaDeTreinoCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateRotinaDeTreinoCopyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'CreateRotinaDeTreinoCopy'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CREATE_ROTINA_DE_TREINO_COPY_CreateRotin');
      logFirebaseEvent('CreateRotinaDeTreinoCopy_firestore_query');
      _model.treinors = await queryTreinorsRecordOnce(
        queryBuilder: (treinorsRecord) => treinorsRecord
            .whereIn('treinosNoLIst', _model.treinosSelecionados)
            .where(
              'uidDoUsuario',
              isEqualTo: null,
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('CreateRotinaDeTreinoCopy_firestore_query');
      _model.treinorsList = await queryTreinorsRecordOnce(
        queryBuilder: (treinorsRecord) => treinorsRecord
            .whereIn('treinosNoLIst', _model.treinosSelecionados)
            .where(
              'uidDoUsuario',
              isEqualTo: null,
            ),
      );
    });

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget!.users!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingFour(
                  color: FlutterFlowTheme.of(context).customColor3,
                  size: 50.0,
                ),
              ),
            ),
          );
        }

        final createRotinaDeTreinoCopyUsersRecord = snapshot.data!;

        return Title(
            title: 'CreateRotinaDeTreinoCopy',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                appBar: responsiveVisibility(
                  context: context,
                  desktop: false,
                )
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(110.0),
                        child: AppBar(
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          automaticallyImplyLeading: false,
                          title: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'v9cs0cet' /* Adicione um exercício */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'q0ws9q6r' /* Adicione um exercício para est... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.outfit(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'CREATE_ROTINA_DE_TREINO_COPY_Row_pqylbhd');
                                    logFirebaseEvent('Row_navigate_to');
                                    if (Navigator.of(context).canPop()) {
                                      context.pop();
                                    }
                                    context.pushNamed(
                                      CreateTreinoCopyWidget.routeName,
                                      queryParameters: {
                                        'users': serializeParam(
                                          widget!.users,
                                          ParamType.DocumentReference,
                                        ),
                                        'createTreinos': serializeParam(
                                          widget!.treino,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 350),
                                        ),
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 20.0,
                                        borderWidth: 1.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.add,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'veonnf4q' /* Adicione seu exercício para es... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 12.0, 8.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 0.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 22.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'CREATE_ROTINA_DE_TREINO_COPY_close_round');
                                  logFirebaseEvent('IconButton_navigate_back');
                                  context.safePop();
                                },
                              ),
                            ),
                          ],
                          centerTitle: false,
                          toolbarHeight: 110.0,
                          elevation: 0.0,
                        ),
                      )
                    : null,
                body: SafeArea(
                  top: true,
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Stack(
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          desktop: false,
                        ))
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: StreamBuilder<CreateTreinosRecord>(
                                  stream: CreateTreinosRecord.getDocument(
                                      widget!.treino!),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: SpinKitFadingFour(
                                            color: FlutterFlowTheme.of(context)
                                                .customColor3,
                                            size: 50.0,
                                          ),
                                        ),
                                      );
                                    }

                                    final scrollingColumnCreateTreinosRecord =
                                        snapshot.data!;

                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 0.0,
                                                                4.0, 0.0),
                                                    child: Container(
                                                      width: 300.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .textController1,
                                                        focusNode: _model
                                                            .textFieldFocusNode1,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                          '_model.textController1',
                                                          Duration(
                                                              milliseconds:
                                                                  100),
                                                          () async {
                                                            logFirebaseEvent(
                                                                'CREATE_ROTINA_DE_TREINO_COPY_TextField_k');
                                                            logFirebaseEvent(
                                                                'TextField_simple_search');
                                                            safeSetState(() {
                                                              _model.simpleSearchResults1 =
                                                                  TextSearch(
                                                                _model
                                                                    .treinorsList!
                                                                    .map(
                                                                      (record) =>
                                                                          TextSearchItem.fromTerms(
                                                                              record,
                                                                              [
                                                                            record.treinosNoLIst!,
                                                                            record.colecao!
                                                                          ]),
                                                                    )
                                                                    .toList(),
                                                              )
                                                                      .search(_model
                                                                          .textController1
                                                                          .text)
                                                                      .map((r) =>
                                                                          r.object)
                                                                      .toList();
                                                              ;
                                                            });
                                                            logFirebaseEvent(
                                                                'TextField_update_app_state');
                                                            FFAppState()
                                                                    .searchBoolean =
                                                                true;
                                                            FFAppState()
                                                                    .fullListShow =
                                                                false;
                                                            safeSetState(() {});
                                                          },
                                                        ),
                                                        autofocus: false,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          hintText:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                            'vho2dl2v' /* Procure o treino ou coleção... */,
                                                          ),
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          suffixIcon: _model
                                                                  .textController1!
                                                                  .text
                                                                  .isNotEmpty
                                                              ? InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    _model
                                                                        .textController1
                                                                        ?.clear();
                                                                    logFirebaseEvent(
                                                                        'CREATE_ROTINA_DE_TREINO_COPY_TextField_k');
                                                                    logFirebaseEvent(
                                                                        'TextField_simple_search');
                                                                    safeSetState(
                                                                        () {
                                                                      _model.simpleSearchResults1 =
                                                                          TextSearch(
                                                                        _model
                                                                            .treinorsList!
                                                                            .map(
                                                                              (record) => TextSearchItem.fromTerms(record, [
                                                                                record.treinosNoLIst!,
                                                                                record.colecao!
                                                                              ]),
                                                                            )
                                                                            .toList(),
                                                                      ).search(_model.textController1.text).map((r) => r.object).toList();
                                                                      ;
                                                                    });
                                                                    logFirebaseEvent(
                                                                        'TextField_update_app_state');
                                                                    FFAppState()
                                                                            .searchBoolean =
                                                                        true;
                                                                    FFAppState()
                                                                            .fullListShow =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons.clear,
                                                                    size: 22,
                                                                  ),
                                                                )
                                                              : null,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        validator: _model
                                                            .textController1Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 14.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      logFirebaseEvent(
                                                          'CREATE_ROTINA_DE_TREINO_COPY_Icon_1z7px8');
                                                      logFirebaseEvent(
                                                          'Icon_bottom_sheet');
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  FiltroExercicioAdminWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Icon(
                                                      Icons.filter_alt,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (FFAppState().searchBoolean)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 770.0,
                                                ),
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Builder(
                                                        builder: (context) {
                                                          final treinois = _model
                                                              .simpleSearchResults1
                                                              .map((e) => e)
                                                              .toList();

                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: List.generate(
                                                                  treinois
                                                                      .length,
                                                                  (treinoisIndex) {
                                                                final treinoisItem =
                                                                    treinois[
                                                                        treinoisIndex];
                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Theme(
                                                                    data:
                                                                        ThemeData(
                                                                      checkboxTheme:
                                                                          CheckboxThemeData(
                                                                        visualDensity:
                                                                            VisualDensity.compact,
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                      ),
                                                                      unselectedWidgetColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryText,
                                                                    ),
                                                                    child:
                                                                        CheckboxListTile(
                                                                      value: _model
                                                                              .checkboxListTileValueMap1[treinoisItem] ??=
                                                                          false,
                                                                      onChanged:
                                                                          (newValue) async {
                                                                        safeSetState(() =>
                                                                            _model.checkboxListTileValueMap1[treinoisItem] =
                                                                                newValue!);
                                                                        if (newValue!) {
                                                                          logFirebaseEvent(
                                                                              'CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                          logFirebaseEvent(
                                                                              'CheckboxListTile_update_page_state');
                                                                          _model
                                                                              .addToTreinosSelecionados(treinoisItem.treinosNoLIst);
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                      },
                                                                      title:
                                                                          Text(
                                                                        treinoisItem
                                                                            .treinosNoLIst,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                            ),
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        treinoisItem
                                                                            .colecao,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      tileColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                      activeColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      checkColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .info,
                                                                      dense:
                                                                          false,
                                                                      controlAffinity:
                                                                          ListTileControlAffinity
                                                                              .trailing,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(
                                                                  SizedBox(
                                                                      height:
                                                                          8.0)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 12.0))
                                                        .addToEnd(SizedBox(
                                                            height: 32.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if ((FFAppState().filtroAdmin !=
                                                  'Todos') &&
                                              (FFAppState().filterVideoFoto ==
                                                  'Sem vídeo'))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 770.0,
                                                ),
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      StreamBuilder<
                                                          List<TreinorsRecord>>(
                                                        stream: queryTreinorsRecord(
                                                          queryBuilder:
                                                              (treinorsRecord) =>
                                                                  treinorsRecord
                                                                      .where(
                                                                        'treinosNoLIst',
                                                                        isEqualTo:
                                                                            FFAppState().filtroAdmin,
                                                                      )
                                                                      .where(
                                                                        'videoUrl',
                                                                        isEqualTo:
                                                                            null,
                                                                      ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingFour(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .customColor3,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<TreinorsRecord>
                                                              columnTreinorsRecordList =
                                                              snapshot.data!;

                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: List.generate(
                                                                  columnTreinorsRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnTreinorsRecord =
                                                                    columnTreinorsRecordList[
                                                                        columnIndex];
                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Theme(
                                                                    data:
                                                                        ThemeData(
                                                                      checkboxTheme:
                                                                          CheckboxThemeData(
                                                                        visualDensity:
                                                                            VisualDensity.compact,
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                      ),
                                                                      unselectedWidgetColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryText,
                                                                    ),
                                                                    child:
                                                                        CheckboxListTile(
                                                                      value: _model
                                                                              .checkboxListTileValueMap2[columnTreinorsRecord] ??=
                                                                          false,
                                                                      onChanged:
                                                                          (newValue) async {
                                                                        safeSetState(() =>
                                                                            _model.checkboxListTileValueMap2[columnTreinorsRecord] =
                                                                                newValue!);
                                                                        if (newValue!) {
                                                                          logFirebaseEvent(
                                                                              'CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                          logFirebaseEvent(
                                                                              'CheckboxListTile_update_page_state');
                                                                          _model
                                                                              .addToTreinosSelecionados(columnTreinorsRecord.treinosNoLIst);
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                      },
                                                                      title:
                                                                          Text(
                                                                        columnTreinorsRecord
                                                                            .treinosNoLIst,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                            ),
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        columnTreinorsRecord
                                                                            .colecao,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      tileColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                      activeColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      checkColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .info,
                                                                      dense:
                                                                          false,
                                                                      controlAffinity:
                                                                          ListTileControlAffinity
                                                                              .trailing,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(
                                                                  SizedBox(
                                                                      height:
                                                                          8.0)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 12.0))
                                                        .addToEnd(SizedBox(
                                                            height: 32.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (FFAppState().fullListShow)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 770.0,
                                                ),
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 12.0,
                                                          16.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      StreamBuilder<
                                                          List<TreinorsRecord>>(
                                                        stream:
                                                            queryTreinorsRecord(),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    SpinKitFadingFour(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .customColor3,
                                                                  size: 50.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<TreinorsRecord>
                                                              columnTreinorsRecordList =
                                                              snapshot.data!;

                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: List.generate(
                                                                  columnTreinorsRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnTreinorsRecord =
                                                                    columnTreinorsRecordList[
                                                                        columnIndex];
                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Theme(
                                                                    data:
                                                                        ThemeData(
                                                                      checkboxTheme:
                                                                          CheckboxThemeData(
                                                                        visualDensity:
                                                                            VisualDensity.compact,
                                                                        materialTapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                      ),
                                                                      unselectedWidgetColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryText,
                                                                    ),
                                                                    child:
                                                                        CheckboxListTile(
                                                                      value: _model
                                                                              .checkboxListTileValueMap3[columnTreinorsRecord] ??=
                                                                          false,
                                                                      onChanged:
                                                                          (newValue) async {
                                                                        safeSetState(() =>
                                                                            _model.checkboxListTileValueMap3[columnTreinorsRecord] =
                                                                                newValue!);
                                                                        if (newValue!) {
                                                                          logFirebaseEvent(
                                                                              'CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                          logFirebaseEvent(
                                                                              'CheckboxListTile_update_page_state');
                                                                          _model
                                                                              .addToTreinosSelecionados(columnTreinorsRecord.treinosNoLIst);
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                      },
                                                                      title:
                                                                          Text(
                                                                        columnTreinorsRecord
                                                                            .treinosNoLIst,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                            ),
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        columnTreinorsRecord
                                                                            .colecao,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      tileColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                      activeColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      checkColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .info,
                                                                      dense:
                                                                          false,
                                                                      controlAffinity:
                                                                          ListTileControlAffinity
                                                                              .trailing,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(
                                                                  SizedBox(
                                                                      height:
                                                                          8.0)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 12.0))
                                                        .addToEnd(SizedBox(
                                                            height: 32.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 770.0,
                                ),
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 12.0, 16.0, 12.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CREATE_ROTINA_DE_TREINO_COPY_SALVAR_BTN_');
                                          if (FFAppState().fullListShow ==
                                              true) {
                                            logFirebaseEvent(
                                                'Button_backend_call');

                                            await widget!.treino!.update({
                                              ...createCreateTreinosRecordData(
                                                uidTreinos: widget!.treino?.id,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'treino': _model
                                                      .checkboxListTileCheckedItems3
                                                      .map((e) =>
                                                          e.treinosNoLIst)
                                                      .toList(),
                                                },
                                              ),
                                            });
                                            logFirebaseEvent(
                                                'Button_navigate_back');
                                            context.safePop();
                                          } else if (FFAppState()
                                              .searchBoolean) {
                                            logFirebaseEvent(
                                                'Button_backend_call');

                                            await widget!.treino!.update({
                                              ...createCreateTreinosRecordData(
                                                uidTreinos: widget!.treino?.id,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'treino': _model
                                                      .checkboxListTileCheckedItems1
                                                      .map((e) =>
                                                          e.treinosNoLIst)
                                                      .toList(),
                                                },
                                              ),
                                            });
                                            logFirebaseEvent(
                                                'Button_navigate_back');
                                            context.safePop();
                                            logFirebaseEvent(
                                                'Button_validate_form');
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                          } else {
                                            logFirebaseEvent(
                                                'Button_backend_call');

                                            await widget!.treino!.update({
                                              ...mapToFirestore(
                                                {
                                                  'treino': _model
                                                      .checkboxListTileCheckedItems3
                                                      .map((e) =>
                                                          e.treinosNoLIst)
                                                      .toList(),
                                                },
                                              ),
                                            });
                                            logFirebaseEvent(
                                                'Button_navigate_back');
                                            context.safePop();
                                            logFirebaseEvent(
                                                'Button_validate_form');
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                          }

                                          logFirebaseEvent(
                                              'Button_backend_call');

                                          await _model.treinors!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'Adicionados':
                                                    FieldValue.increment(1),
                                              },
                                            ),
                                          });
                                          logFirebaseEvent(
                                              'Button_trigger_push_notification');
                                          triggerPushNotification(
                                            notificationTitle:
                                                'Seu personal adicionou novos treinos!',
                                            notificationText:
                                                'Entre para verificar seu treino.',
                                            notificationSound: 'default',
                                            userRefs: [widget!.users!],
                                            initialPageName:
                                                'iniciarTreinoAluno',
                                            parameterData: {
                                              'createTreinos': widget!.treino,
                                            },
                                          );
                                          logFirebaseEvent(
                                              'Button_backend_call');

                                          await NotificacaoRecord.collection
                                              .doc()
                                              .set(createNotificacaoRecordData(
                                                titulo:
                                                    'Seu personal adicionou novos treinos!',
                                                descricao:
                                                    'Entre para verificar seu treino.',
                                                data: getCurrentTimestamp,
                                                para: widget!.users?.id,
                                                tipo: 'Treinos',
                                                treino: widget!.treino,
                                              ));
                                        },
                                        text:
                                            FFLocalizations.of(context).getText(
                                          'bmuw8xgv' /* Salvar */,
                                        ),
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 48.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                        ))
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          250.0, 90.0, 250.0, 0.0),
                                      child: StreamBuilder<CreateTreinosRecord>(
                                        stream:
                                            CreateTreinosRecord.getDocument(
                                                widget!.treino!),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: SpinKitFadingFour(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }

                                          final scrollingColumnCreateTreinosRecord =
                                              snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'igx10bsq' /* Adicione um exercício de nosso... */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                            fontSize: 30.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      15.0,
                                                                      0.0,
                                                                      4.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: 150.0,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .textController2,
                                                              focusNode: _model
                                                                  .textFieldFocusNode2,
                                                              onChanged: (_) =>
                                                                  EasyDebounce
                                                                      .debounce(
                                                                '_model.textController2',
                                                                Duration(
                                                                    milliseconds:
                                                                        100),
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'CREATE_ROTINA_DE_TREINO_COPY_TextField_6');
                                                                  logFirebaseEvent(
                                                                      'TextField_simple_search');
                                                                  safeSetState(
                                                                      () {
                                                                    _model.simpleSearchResults2 =
                                                                        TextSearch(
                                                                      _model
                                                                          .treinorsList!
                                                                          .map(
                                                                            (record) =>
                                                                                TextSearchItem.fromTerms(record, [
                                                                              record.treinosNoLIst!,
                                                                              record.colecao!
                                                                            ]),
                                                                          )
                                                                          .toList(),
                                                                    )
                                                                            .search(_model
                                                                                .textController2.text)
                                                                            .map((r) =>
                                                                                r.object)
                                                                            .toList();
                                                                    ;
                                                                  });
                                                                  logFirebaseEvent(
                                                                      'TextField_update_app_state');
                                                                  FFAppState()
                                                                          .searchBoolean =
                                                                      true;
                                                                  FFAppState()
                                                                          .fullListShow =
                                                                      false;
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                              ),
                                                              autofocus: false,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                hintText:
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                  'u8b8yic5' /* Procure o treino ou coleção... */,
                                                                ),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                filled: true,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                hoverColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                suffixIcon: _model
                                                                        .textController2!
                                                                        .text
                                                                        .isNotEmpty
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          _model
                                                                              .textController2
                                                                              ?.clear();
                                                                          logFirebaseEvent(
                                                                              'CREATE_ROTINA_DE_TREINO_COPY_TextField_6');
                                                                          logFirebaseEvent(
                                                                              'TextField_simple_search');
                                                                          safeSetState(
                                                                              () {
                                                                            _model.simpleSearchResults2 =
                                                                                TextSearch(
                                                                              _model.treinorsList!
                                                                                  .map(
                                                                                    (record) => TextSearchItem.fromTerms(record, [
                                                                                      record.treinosNoLIst!,
                                                                                      record.colecao!
                                                                                    ]),
                                                                                  )
                                                                                  .toList(),
                                                                            ).search(_model.textController2.text).map((r) => r.object).toList();
                                                                            ;
                                                                          });
                                                                          logFirebaseEvent(
                                                                              'TextField_update_app_state');
                                                                          FFAppState().searchBoolean =
                                                                              true;
                                                                          FFAppState().fullListShow =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .clear,
                                                                          size:
                                                                              22,
                                                                        ),
                                                                      )
                                                                    : null,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                              cursorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              validator: _model
                                                                  .textController2Validator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    14.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'CREATE_ROTINA_DE_TREINO_COPY_Icon_nyuhwv');
                                                            logFirebaseEvent(
                                                                'Icon_bottom_sheet');
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        FiltroExercicioAdminWidget(),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                          child: Icon(
                                                            Icons.filter_alt,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (FFAppState().searchBoolean)
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 770.0,
                                                      ),
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    12.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final treinois = _model
                                                                    .simpleSearchResults2
                                                                    .map((e) =>
                                                                        e)
                                                                    .toList();

                                                                return SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        treinois
                                                                            .length,
                                                                        (treinoisIndex) {
                                                                      final treinoisItem =
                                                                          treinois[
                                                                              treinoisIndex];
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            Theme(
                                                                          data:
                                                                              ThemeData(
                                                                            checkboxTheme:
                                                                                CheckboxThemeData(
                                                                              visualDensity: VisualDensity.compact,
                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                            ),
                                                                            unselectedWidgetColor:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          ),
                                                                          child:
                                                                              CheckboxListTile(
                                                                            value: _model.checkboxListTileValueMap4[treinoisItem] ??=
                                                                                false,
                                                                            onChanged:
                                                                                (newValue) async {
                                                                              safeSetState(() => _model.checkboxListTileValueMap4[treinoisItem] = newValue!);
                                                                              if (newValue!) {
                                                                                logFirebaseEvent('CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                                logFirebaseEvent('CheckboxListTile_update_page_state');
                                                                                _model.addToTreinosSelecionados(treinoisItem.treinosNoLIst);
                                                                                safeSetState(() {});
                                                                              }
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              treinoisItem.treinosNoLIst,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.outfit(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            subtitle:
                                                                                Text(
                                                                              treinoisItem.colecao,
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            tileColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            activeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            checkColor:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            dense:
                                                                                false,
                                                                            controlAffinity:
                                                                                ListTileControlAffinity.trailing,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 12.0))
                                                              .addToEnd(SizedBox(
                                                                  height:
                                                                      32.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if ((FFAppState().filtroAdmin !=
                                                        'Todos') &&
                                                    (FFAppState()
                                                            .filterVideoFoto ==
                                                        'Sem vídeo'))
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 770.0,
                                                      ),
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    12.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            StreamBuilder<
                                                                List<
                                                                    TreinorsRecord>>(
                                                              stream:
                                                                  queryTreinorsRecord(
                                                                    queryBuilder: (treinorsRecord) =>
                                                                        treinorsRecord
                                                                            .where(
                                                                              'treinosNoLIst',
                                                                              isEqualTo:
                                                                                  FFAppState().filtroAdmin,
                                                                            )
                                                                            .where(
                                                                              'videoUrl',
                                                                              isEqualTo:
                                                                                null,
                                                                              ),
                                                                    ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitFadingFour(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .customColor3,
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<TreinorsRecord>
                                                                    columnTreinorsRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        columnTreinorsRecordList
                                                                            .length,
                                                                        (columnIndex) {
                                                                      final columnTreinorsRecord =
                                                                          columnTreinorsRecordList[
                                                                              columnIndex];
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            Theme(
                                                                          data:
                                                                              ThemeData(
                                                                            checkboxTheme:
                                                                                CheckboxThemeData(
                                                                              visualDensity: VisualDensity.compact,
                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                            ),
                                                                            unselectedWidgetColor:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          ),
                                                                          child:
                                                                              CheckboxListTile(
                                                                            value: _model.checkboxListTileValueMap5[columnTreinorsRecord] ??=
                                                                                false,
                                                                            onChanged:
                                                                                (newValue) async {
                                                                              safeSetState(() => _model.checkboxListTileValueMap5[columnTreinorsRecord] = newValue!);
                                                                              if (newValue!) {
                                                                                logFirebaseEvent('CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                                logFirebaseEvent('CheckboxListTile_update_page_state');
                                                                                _model.addToTreinosSelecionados(columnTreinorsRecord.treinosNoLIst);
                                                                                safeSetState(() {});
                                                                              }
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              columnTreinorsRecord.treinosNoLIst,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.outfit(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            subtitle:
                                                                                Text(
                                                                              columnTreinorsRecord.colecao,
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            tileColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            activeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            checkColor:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            dense:
                                                                                false,
                                                                            controlAffinity:
                                                                                ListTileControlAffinity.trailing,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 12.0))
                                                              .addToEnd(SizedBox(
                                                                  height:
                                                                      32.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (FFAppState().fullListShow)
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 770.0,
                                                      ),
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    12.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            StreamBuilder<
                                                                List<
                                                                    TreinorsRecord>>(
                                                              stream:
                                                                  queryTreinorsRecord(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          SpinKitFadingFour(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .customColor3,
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<TreinorsRecord>
                                                                    columnTreinorsRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        columnTreinorsRecordList
                                                                            .length,
                                                                        (columnIndex) {
                                                                      final columnTreinorsRecord =
                                                                          columnTreinorsRecordList[
                                                                              columnIndex];
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            Theme(
                                                                          data:
                                                                              ThemeData(
                                                                            checkboxTheme:
                                                                                CheckboxThemeData(
                                                                              visualDensity: VisualDensity.compact,
                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                            ),
                                                                            unselectedWidgetColor:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          ),
                                                                          child:
                                                                              CheckboxListTile(
                                                                            value: _model.checkboxListTileValueMap6[columnTreinorsRecord] ??=
                                                                                false,
                                                                            onChanged:
                                                                                (newValue) async {
                                                                              safeSetState(() => _model.checkboxListTileValueMap6[columnTreinorsRecord] = newValue!);
                                                                              if (newValue!) {
                                                                                logFirebaseEvent('CREATE_ROTINA_DE_TREINO_COPY_CheckboxLis');
                                                                                logFirebaseEvent('CheckboxListTile_update_page_state');
                                                                                _model.addToTreinosSelecionados(columnTreinorsRecord.treinosNoLIst);
                                                                                safeSetState(() {});
                                                                              }
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              columnTreinorsRecord.treinosNoLIst,
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    font: GoogleFonts.outfit(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                    ),
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            subtitle:
                                                                                Text(
                                                                              columnTreinorsRecord.colecao,
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            tileColor:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            activeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            checkColor:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            dense:
                                                                                false,
                                                                            controlAffinity:
                                                                                ListTileControlAffinity.trailing,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).divide(SizedBox(
                                                                        height:
                                                                            8.0)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  height: 12.0))
                                                              .addToEnd(SizedBox(
                                                                  height:
                                                                      32.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.2,
                                                  constraints: BoxConstraints(
                                                    maxWidth: 770.0,
                                                  ),
                                                  decoration: BoxDecoration(),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    12.0,
                                                                    16.0,
                                                                    12.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'CREATE_ROTINA_DE_TREINO_COPY_SALVAR_BTN_');
                                                            if (FFAppState()
                                                                    .fullListShow ==
                                                                true) {
                                                              logFirebaseEvent(
                                                                  'Button_backend_call');

                                                              await widget!
                                                                  .treino!
                                                                  .update({
                                                                ...createCreateTreinosRecordData(
                                                                  uidTreinos:
                                                                      widget!
                                                                          .treino
                                                                          ?.id,
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'treino': _model
                                                                        .checkboxListTileCheckedItems6
                                                                        .map((e) =>
                                                                            e.treinosNoLIst)
                                                                        .toList(),
                                                                  },
                                                                ),
                                                              });
                                                              logFirebaseEvent(
                                                                  'Button_navigate_back');
                                                              context.safePop();
                                                            } else if (FFAppState()
                                                                .searchBoolean) {
                                                              logFirebaseEvent(
                                                                  'Button_backend_call');

                                                              await widget!
                                                                  .treino!
                                                                  .update({
                                                                ...createCreateTreinosRecordData(
                                                                  uidTreinos:
                                                                      widget!
                                                                          .treino
                                                                          ?.id,
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'treino': _model
                                                                        .checkboxListTileCheckedItems4
                                                                        .map((e) =>
                                                                            e.treinosNoLIst)
                                                                        .toList(),
                                                                  },
                                                                ),
                                                              });
                                                              logFirebaseEvent(
                                                                  'Button_navigate_back');
                                                              context.safePop();
                                                              logFirebaseEvent(
                                                                  'Button_validate_form');
                                                              if (_model.formKey
                                                                          .currentState ==
                                                                      null ||
                                                                  !_model
                                                                      .formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                return;
                                                              }
                                                            } else {
                                                              logFirebaseEvent(
                                                                  'Button_backend_call');

                                                              await widget!
                                                                  .treino!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'treino': _model
                                                                        .checkboxListTileCheckedItems6
                                                                        .map((e) =>
                                                                            e.treinosNoLIst)
                                                                        .toList(),
                                                                  },
                                                                ),
                                                              });
                                                              logFirebaseEvent(
                                                                  'Button_navigate_back');
                                                              context.safePop();
                                                              logFirebaseEvent(
                                                                  'Button_validate_form');
                                                              if (_model.formKey
                                                                          .currentState ==
                                                                      null ||
                                                                  !_model
                                                                      .formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                return;
                                                              }
                                                            }

                                                            logFirebaseEvent(
                                                                'Button_backend_call');

                                                            await _model
                                                                .treinors!
                                                                .reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'Adicionados':
                                                                      FieldValue
                                                                          .increment(
                                                                              1),
                                                                },
                                                              ),
                                                            });
                                                            logFirebaseEvent(
                                                                'Button_trigger_push_notification');
                                                            triggerPushNotification(
                                                              notificationTitle:
                                                                  'Seu personal adicionou novos treinos!',
                                                              notificationText:
                                                                  'Entre para verificar seu treino.',
                                                              notificationSound:
                                                                  'default',
                                                              userRefs: [
                                                                widget!.users!
                                                              ],
                                                              initialPageName:
                                                                  'iniciarTreinoAluno',
                                                              parameterData: {
                                                                'createTreinos':
                                                                    widget!
                                                                        .treino,
                                                              },
                                                            );
                                                            logFirebaseEvent(
                                                                'Button_backend_call');

                                                            await NotificacaoRecord
                                                                .collection
                                                                .doc()
                                                                .set(
                                                                    createNotificacaoRecordData(
                                                                  titulo:
                                                                      'Seu personal adicionou novos treinos!',
                                                                  descricao:
                                                                      'Entre para verificar seu treino.',
                                                                  data:
                                                                      getCurrentTimestamp,
                                                                  para: widget!
                                                                      .users
                                                                      ?.id,
                                                                  tipo:
                                                                      'Treinos',
                                                                  treino: widget!
                                                                      .treino,
                                                                ));
                                                          },
                                                          text: FFLocalizations
                                                                  .of(context)
                                                              .getText(
                                                            'ycnxqqdz' /* Salvar */,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 48.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        0.0,
                                                                        24.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .figtree(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 3.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.headerwebModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: HeaderwebWidget(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
