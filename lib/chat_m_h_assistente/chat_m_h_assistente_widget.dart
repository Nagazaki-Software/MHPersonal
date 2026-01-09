import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/components/perfil_do_mh_assistente_widget.dart';
import '/components/recomendacoes_i_a_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'chat_m_h_assistente_model.dart';
export 'chat_m_h_assistente_model.dart';

/// chat com outra pessoa
class ChatMHAssistenteWidget extends StatefulWidget {
  const ChatMHAssistenteWidget({super.key});

  static String routeName = 'chatMHAssistente';
  static String routePath = 'chatMHAssistente';

  @override
  State<ChatMHAssistenteWidget> createState() => _ChatMHAssistenteWidgetState();
}

class _ChatMHAssistenteWidgetState extends State<ChatMHAssistenteWidget>
    with TickerProviderStateMixin {
  late ChatMHAssistenteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMHAssistenteModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'chatMHAssistente'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHAT_M_H_ASSISTENTE_chatMHAssistente_ON_');
      logFirebaseEvent('chatMHAssistente_firestore_query');
      _model.queryTreinors = await queryTreinorsRecordOnce();
      logFirebaseEvent('chatMHAssistente_firestore_query');
      _model.queryCreatetREINOS = await queryCreateTreinosRecordOnce(
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      logFirebaseEvent('chatMHAssistente_openrouter');
      await openrouterGenerateText(
        context,
        '**Finja ser o MH Personal Trainer, você está conversando com ${currentUserDisplayName}, você começa a conversa.',
      ).then((generatedText) {
        safeSetState(() => _model.primeiraCV = generatedText);
      });

      logFirebaseEvent('chatMHAssistente_update_app_state');
      FFAppState().addToChat(MessageStruct(
        text: _model.primeiraCV,
        role: 'system',
        data: getCurrentTimestamp,
      ));
      safeSetState(() {});
      if ((String var1) {
        return var1 == "system" || var1 == "user";
      }(FFAppState().chat.lastOrNull!.role)) {
        logFirebaseEvent('chatMHAssistente_scroll_to');
        await _model.columnController?.animateTo(
          _model.columnController!.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.31,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.linear,
            delay: 360.0.ms,
            duration: 860.0.ms,
            color: Color(0xBA7909AD),
            angle: 2.443,
          ),
        ],
      ),
    });

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

    return Title(
        title: 'chatMHAssistente',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 2.0,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'CHAT_M_H_ASSISTENTE_Row_1k97ppou_ON_TAP');
                              logFirebaseEvent('Row_bottom_sheet');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: PerfilDoMhAssistenteWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'CHAT_M_H_ASSISTENTE_arrow_back_ICN_ON_TA');
                                        logFirebaseEvent(
                                            'IconButton_navigate_back');
                                        context.safePop();
                                      },
                                    ),
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        child: Image.asset(
                                          'assets/images/y_(6).png',
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'efmo9zvy' /* MH Assistente */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                        GradientText(
                                          FFLocalizations.of(context).getText(
                                            '3jsif7k3' /* Versão 1.12.214 */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                font: GoogleFonts.outfit(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                          colors: [
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            FlutterFlowTheme.of(context).primary
                                          ],
                                          gradientDirection:
                                              GradientDirection.ltr,
                                          gradientType: GradientType.linear,
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  buttonSize: 40.0,
                                  fillColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 16.0),
                      child: Builder(
                        builder: (context) {
                          final chat = FFAppState().chat.toList();

                          return SingleChildScrollView(
                            primary: false,
                            controller: _model.columnController,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(chat.length, (chatIndex) {
                                final chatItem = chat[chatIndex];
                                return Builder(
                                  builder: (context) {
                                    if ((String var1) {
                                      return var1 == "user";
                                    }(chatItem.role)) {
                                      return Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.7,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(12.0),
                                              topRight: Radius.circular(12.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 12.0, 12.0, 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      chatItem.text,
                                                      'Erro em sua mensagem, verifique sua conexão.',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 1.0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                      "relative",
                                                      chatItem.data!,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation1']!),
                                      );
                                    } else if ((chatItem.uidtreino != null &&
                                            chatItem.uidtreino != '') &&
                                        (chatItem.role == 'system')) {
                                      return Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 15.0, 0.0, 0.0),
                                              child: StreamBuilder<
                                                  List<CreateTreinosRecord>>(
                                                stream:
                                                    queryCreateTreinosRecord(
                                                  parent: currentUserReference,
                                                  queryBuilder:
                                                      (createTreinosRecord) =>
                                                          createTreinosRecord
                                                              .where(
                                                    'uidTreinos',
                                                    isEqualTo:
                                                        chatItem.uidtreino,
                                                  ),
                                                  singleRecord: true,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            SpinKitFadingFour(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .customColor3,
                                                          size: 50.0,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<CreateTreinosRecord>
                                                      containerCreateTreinosRecordList =
                                                      snapshot.data!;
                                                  final containerCreateTreinosRecord =
                                                      containerCreateTreinosRecordList
                                                              .isNotEmpty
                                                          ? containerCreateTreinosRecordList
                                                              .first
                                                          : null;

                                                  return InkWell(
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
                                                          'CHAT_M_H_ASSISTENTE_Container_h575b4md_O');
                                                      logFirebaseEvent(
                                                          'Container_navigate_to');

                                                      context.pushNamed(
                                                        IniciarTreinoAlunoWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'createTreinos':
                                                              serializeParam(
                                                            containerCreateTreinosRecord
                                                                ?.reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 220.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFF025686),
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  1.0, 0.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  -1.0, 0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .receipt,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
                                                            ),
                                                            Flexible(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerCreateTreinosRecord
                                                                          ?.nomeDoTreino,
                                                                      'Error',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle:
                                                                              FontStyle.italic,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerCreateTreinosRecord
                                                                          ?.obsInstrucao,
                                                                      'Error',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 60.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          child: Image.asset(
                                                            'assets/images/y_(6).png',
                                                            width: 50.0,
                                                            height: 50.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'bo87syyd' /* Treino feito pelo */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .outfit(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFFB7BDC2),
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'vpkpt80m' /* MH Assistente */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .outfit(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.7,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12.0),
                                                    bottomRight:
                                                        Radius.circular(0.0),
                                                    topLeft:
                                                        Radius.circular(12.0),
                                                    topRight:
                                                        Radius.circular(12.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0,
                                                          12.0, 12.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            chatItem.text,
                                                            'Bip-Bop, algo está errada com minha programação.',
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
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, 1.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            "relative",
                                                            chatItem.data!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .readexPro(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'containerOnPageLoadAnimation2']!),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                );
                              }).divide(SizedBox(height: 16.0)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if ((FFAppState().pergunta == null ||
                        FFAppState().pergunta == '') &&
                    responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.recomendacoesIAModel,
                          updateCallback: () => safeSetState(() {}),
                          child: RecomendacoesIAWidget(),
                        ),
                      ),
                    ],
                  ),
                Align(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                      ))
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 20.0,
                              height: 20.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/y_(6).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'ixaknnxf' /* MH Assisntente está digitando.... */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation']!),
                            ),
                          ],
                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation']!),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                                  _model.textFieldFocusNode,
                                              onFieldSubmitted: (_) async {
                                                logFirebaseEvent(
                                                    'CHAT_M_H_ASSISTENTE_TextField_o183of5b_O');
                                                logFirebaseEvent(
                                                    'TextField_update_app_state');
                                                FFAppState()
                                                    .addToChat(MessageStruct(
                                                  text: _model
                                                      .textController.text,
                                                  role: 'user',
                                                  data: getCurrentTimestamp,
                                                ));
                                                FFAppState().msgDoUsuario =
                                                    _model.textController.text;
                                                FFAppState().update(() {});
                                                logFirebaseEvent(
                                                    'TextField_clear_text_fields_pin_codes');
                                                safeSetState(() {
                                                  _model.textController
                                                      ?.clear();
                                                });
                                                logFirebaseEvent(
                                                    'TextField_backend_call');
                                                _model.chatGPT =
                                                    await BancodedadosGroup
                                                        .openrouterConversaPlanoCall
                                                        .call(
                                                  userId: currentUserUid,
                                                  mensagem: _model
                                                      .textController.text,
                                                );

                                                if (BancodedadosGroup
                                                            .openrouterConversaPlanoCall
                                                            .resposta(
                                                          (_model.chatGPT
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) !=
                                                        null &&
                                                    BancodedadosGroup
                                                            .openrouterConversaPlanoCall
                                                            .resposta(
                                                          (_model.chatGPT
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) !=
                                                        '') {
                                                  logFirebaseEvent(
                                                      'TextField_update_app_state');
                                                  FFAppState()
                                                      .addToChat(MessageStruct(
                                                    text: BancodedadosGroup
                                                        .openrouterConversaPlanoCall
                                                        .resposta(
                                                      (_model.chatGPT
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    role: 'system',
                                                    data: getCurrentTimestamp,
                                                  ));
                                                  FFAppState().update(() {});
                                                } else if (BancodedadosGroup
                                                            .openrouterConversaPlanoCall
                                                            .nomedarotina(
                                                          (_model.chatGPT
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) !=
                                                        null &&
                                                    BancodedadosGroup
                                                            .openrouterConversaPlanoCall
                                                            .nomedarotina(
                                                          (_model.chatGPT
                                                                  ?.jsonBody ??
                                                              ''),
                                                        ) !=
                                                        '') {
                                                  logFirebaseEvent(
                                                      'TextField_update_app_state');
                                                  FFAppState()
                                                      .addToChat(MessageStruct(
                                                    role: 'system',
                                                    data: getCurrentTimestamp,
                                                    uidtreino: BancodedadosGroup
                                                        .openrouterConversaPlanoCall
                                                        .uidtreino(
                                                      (_model.chatGPT
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                  ));
                                                  FFAppState().update(() {});
                                                }

                                                logFirebaseEvent(
                                                    'TextField_scroll_to');
                                                await _model.columnController
                                                    ?.animateTo(
                                                  _model.columnController!
                                                      .position.maxScrollExtent,
                                                  duration: Duration(
                                                      milliseconds: 350),
                                                  curve: Curves.ease,
                                                );

                                                safeSetState(() {});
                                              },
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'eaeqef5i' /* Digite uma mensagem... */,
                                                ),
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              minLines: 1,
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    if (FFAppState().mhassisyentenavegacao ==
                                        'Pediu um treino')
                                      Container(
                                        width: 48.0,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF8938FF),
                                              FlutterFlowTheme.of(context)
                                                  .secondary
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation3']!),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'CHAT_M_H_ASSISTENTE_Icon_hk5gh8oc_ON_TAP');
                                          logFirebaseEvent(
                                              'Icon_update_app_state');
                                          FFAppState().addToChat(MessageStruct(
                                            text: _model.textController.text,
                                            role: 'user',
                                            data: getCurrentTimestamp,
                                          ));
                                          FFAppState().msgDoUsuario =
                                              _model.textController.text;
                                          FFAppState().update(() {});
                                          logFirebaseEvent(
                                              'Icon_clear_text_fields_pin_codes');
                                          safeSetState(() {
                                            _model.textController?.clear();
                                          });
                                          logFirebaseEvent('Icon_backend_call');
                                          _model.chatGPTCopy =
                                              await BancodedadosGroup
                                                  .openrouterConversaPlanoCall
                                                  .call(
                                            userId: currentUserUid,
                                            mensagem:
                                                _model.textController.text,
                                          );

                                          if (BancodedadosGroup
                                                      .openrouterConversaPlanoCall
                                                      .resposta(
                                                    (_model.chatGPTCopy
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) !=
                                                  null &&
                                              BancodedadosGroup
                                                      .openrouterConversaPlanoCall
                                                      .resposta(
                                                    (_model.chatGPTCopy
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) !=
                                                  '') {
                                            logFirebaseEvent(
                                                'Icon_update_app_state');
                                            FFAppState()
                                                .addToChat(MessageStruct(
                                              text: BancodedadosGroup
                                                  .openrouterConversaPlanoCall
                                                  .resposta(
                                                (_model.chatGPTCopy?.jsonBody ??
                                                    ''),
                                              ),
                                              role: 'system',
                                              data: getCurrentTimestamp,
                                            ));
                                            FFAppState().update(() {});
                                          } else if (BancodedadosGroup
                                                      .openrouterConversaPlanoCall
                                                      .nomedarotina(
                                                    (_model.chatGPTCopy
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) !=
                                                  null &&
                                              BancodedadosGroup
                                                      .openrouterConversaPlanoCall
                                                      .nomedarotina(
                                                    (_model.chatGPTCopy
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) !=
                                                  '') {
                                            logFirebaseEvent(
                                                'Icon_update_app_state');
                                            FFAppState()
                                                .addToChat(MessageStruct(
                                              role: 'system',
                                              data: getCurrentTimestamp,
                                              uidtreino: BancodedadosGroup
                                                  .openrouterConversaPlanoCall
                                                  .uidtreino(
                                                (_model.chatGPTCopy?.jsonBody ??
                                                    ''),
                                              ),
                                            ));
                                            FFAppState().update(() {});
                                          }

                                          logFirebaseEvent('Icon_scroll_to');
                                          await _model.columnController
                                              ?.animateTo(
                                            _model.columnController!.position
                                                .maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 350),
                                            curve: Curves.ease,
                                          );

                                          safeSetState(() {});
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.dumbbell,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
