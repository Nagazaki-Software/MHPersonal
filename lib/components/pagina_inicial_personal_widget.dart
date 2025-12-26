import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/baxei_o_appp_widget.dart';
import '/components/codigodeafiliacao_widget.dart';
import '/components/naoexistealuno_widget.dart';
import '/components/upgrade_to_premium_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/personal/card_acoes/card_acoes_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'pagina_inicial_personal_model.dart';
export 'pagina_inicial_personal_model.dart';

class PaginaInicialPersonalWidget extends StatefulWidget {
  const PaginaInicialPersonalWidget({
    super.key,
    this.parameter3,
    this.parameter4,
    this.parameter6,
    this.parameter7,
  });

  final String? parameter3;
  final String? parameter4;
  final DocumentReference? parameter6;
  final DocumentReference? parameter7;

  @override
  State<PaginaInicialPersonalWidget> createState() =>
      _PaginaInicialPersonalWidgetState();
}

class _PaginaInicialPersonalWidgetState
    extends State<PaginaInicialPersonalWidget> with TickerProviderStateMixin {
  late PaginaInicialPersonalModel _model;

  var hasTextTriggered = false;
  var hasRowTriggered = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaginaInicialPersonalModel());

    animationsMap.addAll({
      'textOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
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
      'rowOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
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
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PersonalAccountRecord>>(
      stream: queryPersonalAccountRecord(
        parent: currentUserReference,
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitFadingFour(
                color: FlutterFlowTheme.of(context).customColor3,
                size: 50.0,
              ),
            ),
          );
        }
        List<PersonalAccountRecord> columnPersonalAccountRecordList =
            snapshot.data!;
        final columnPersonalAccountRecord =
            columnPersonalAccountRecordList.isNotEmpty
                ? columnPersonalAccountRecordList.first
                : null;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder<int>(
                future: queryUsersRecordCount(
                  queryBuilder: (usersRecord) => usersRecord.where(
                    'codigoPersonal',
                    isEqualTo: columnPersonalAccountRecord?.codigoPersonal,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: SpinKitFadingFour(
                          color: FlutterFlowTheme.of(context).customColor3,
                          size: 50.0,
                        ),
                      ),
                    );
                  }
                  int containerCount = snapshot.data!;

                  return Container(
                    width: double.infinity,
                    height: 280.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    'Olá, ${valueOrDefault<String>(columnPersonalAccountRecord?.displayName, 'personal')} seu código de personal é ${valueOrDefault<String>(columnPersonalAccountRecord?.codigoPersonal?.toString(), '')}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 20.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GradientText(
                                              valueOrDefault<String>(
                                                widget.parameter4,
                                                '',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                              colors: [
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                FlutterFlowTheme.of(context)
                                                    .secondary
                                              ],
                                              gradientDirection:
                                                  GradientDirection.rtl,
                                              gradientType: GradientType.linear,
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'PAGINA_INICIAL_PERSONAL_Container_518cwp');
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed(
                                            ConfiguracoesPersonalTrainnerWidget
                                                .routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 350),
                                              ),
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Container(
                                              width: 200.0,
                                              height: 200.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                currentUserPhoto,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                          if (containerCount.toString() != null &&
                              containerCount.toString() != '')
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 160.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x6F002A5D),
                                    Color(0x28002A5D),
                                    Color(0x11002A5D)
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                  begin: AlignmentDirectional(0.59, -1.0),
                                  end: AlignmentDirectional(-0.59, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '1ndyduja' /* Total de Alunos */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
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
                                            Text(
                                              valueOrDefault<String>(
                                                containerCount.toString(),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .displaySmall
                                                  .override(
                                                    font: GoogleFonts.outfit(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .displaySmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .displaySmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        if (valueOrDefault<bool>(
                                            currentUserDocument?.stripeAtivo,
                                            false))
                                          Flexible(
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  FutureBuilder<
                                                      ApiCallResponse>(
                                                future: BancodedadosGroup
                                                    .saldoConnectedCall
                                                    .call(
                                                  connectedAccountId:
                                                      valueOrDefault(
                                                          currentUserDocument
                                                              ?.stripeAccountId,
                                                          ''),
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
                                                  final columnSaldoConnectedResponse =
                                                      snapshot.data!;
                                                  final availableCents =
                                                      BancodedadosGroup
                                                          .saldoConnectedCall
                                                          .avaliable(
                                                            columnSaldoConnectedResponse
                                                                .jsonBody,
                                                          ) ??
                                                          0;
                                                  final pendingCents =
                                                      BancodedadosGroup
                                                          .saldoConnectedCall
                                                          .pending(
                                                            columnSaldoConnectedResponse
                                                                .jsonBody,
                                                          ) ??
                                                          0;

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
                                                          'PAGINA_INICIAL_PERSONAL_Column_7pwrc3tb_');
                                                      logFirebaseEvent(
                                                          'Column_navigate_to');

                                                      context.pushNamed(
                                                          ServicePageWidget
                                                              .routeName);
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'v4v6dx3p' /* Saldo no MH Agenda Fit */,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
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
                                                            Icon(
                                                              Icons.settings,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 16.0,
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                         Text(
                                                          formatNumber(
                                                            functions.consertarValorStripe(
                                                              availableCents
                                                                  .toDouble(),
                                                            ),
                                                            formatType:
                                                                FormatType
                                                                    .decimal,
                                                            decimalType:
                                                                DecimalType
                                                                    .commaDecimal,
                                                            currency: 'R\$ ',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                         Text(
                                                          'Pendente: ${formatNumber(
                                                            functions.consertarValorStripe(
                                                              pendingCents
                                                                  .toDouble(),
                                                            ),
                                                            formatType:
                                                                FormatType
                                                                    .decimal,
                                                            decimalType:
                                                                DecimalType
                                                                    .commaDecimal,
                                                            currency: 'R\$ ',
                                                          )}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .outfit(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        if (!valueOrDefault<bool>(
                                                currentUserDocument
                                                    ?.stripeAtivo,
                                                false) &&
                                            (valueOrDefault(
                                                        currentUserDocument
                                                            ?.stripeAccountId,
                                                        '') ==
                                                    null ||
                                                valueOrDefault(
                                                        currentUserDocument
                                                            ?.stripeAccountId,
                                                        '') ==
                                                    ''))
                                          AuthUserStreamWidget(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'PAGINA_INICIAL_PERSONAL_Column_mgy38ef2_');
                                                logFirebaseEvent(
                                                    'Column_navigate_to');

                                                context.pushNamed(
                                                    AdesaomhfitWidget
                                                        .routeName);
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '2aif3ti9' /* Conheça o
MH Agenda Fit */
                                                      ,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'emsgky8h' /* Alcance mais clientes */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FutureBuilder<int>(
                                              future: queryUsersRecordCount(
                                                queryBuilder: (usersRecord) =>
                                                    usersRecord
                                                        .where(
                                                          'codigoPersonal',
                                                          isEqualTo:
                                                              columnPersonalAccountRecord
                                                                  ?.codigoPersonal,
                                                        )
                                                        .where(
                                                          'acessoSuspenso',
                                                          isEqualTo: false,
                                                        ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitFadingFour(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .customColor3,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                int textCount = snapshot.data!;

                                                return Text(
                                                  valueOrDefault<String>(
                                                    textCount.toString(),
                                                    '0',
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
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
                                                );
                                              },
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'u5mvjaq1' /*  alunos ativos */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
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
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FutureBuilder<int>(
                                              future: queryUsersRecordCount(
                                                queryBuilder: (usersRecord) =>
                                                    usersRecord.where(
                                                  'codigoPersonal',
                                                  isEqualTo:
                                                      columnPersonalAccountRecord
                                                          ?.codigoPersonal,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitFadingFour(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .customColor3,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                int textCount = snapshot.data!;

                                                return Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      functions
                                                          .crescimentoEsseMes(
                                                              textCount),
                                                      formatType:
                                                          FormatType.percent,
                                                    ),
                                                    '0',
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
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
                                                );
                                              },
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'vwk89b1r' /*  este mês */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'PAGINA_INICIAL_PERSONAL_Container_mxbno4');
                            logFirebaseEvent('Container_navigate_to');

                            context.pushNamed(
                                DetalhesdaassintauraWidget.routeName);
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.monetization_on,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'awfkkzvf' /* Minha
Assinatura */
                                        ,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'PAGINA_INICIAL_PERSONAL_Container_o4qfw9');
                            logFirebaseEvent('Container_navigate_to');
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              AbaDeFeedbackWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 350),
                                ),
                              },
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.feedback,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'p4p03w7p' /* Feedback */,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'PAGINA_INICIAL_PERSONAL_Container_y273lw');
                            logFirebaseEvent('Container_navigate_to');
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              NotificacoesWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 350),
                                ),
                              },
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.circle_notifications_sharp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 28.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'cdzcfp2x' /* Notificações */,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                    if (isWeb)
                      wrapWithModel(
                        model: _model.baxeiOApppModel,
                        updateCallback: () => safeSetState(() {}),
                        child: BaxeiOApppWidget(),
                      ),
                    if (columnPersonalAccountRecord != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.codigodeafiliacaoModel,
                              updateCallback: () => safeSetState(() {}),
                              child: CodigodeafiliacaoWidget(
                                codigoDoPersonal: columnPersonalAccountRecord!
                                    .codigoPersonal
                                    .toString(),
                                referencePersonal:
                                    columnPersonalAccountRecord!.reference,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (!valueOrDefault<bool>(
                        currentUserDocument?.assinatura, false))
                      AuthUserStreamWidget(
                        builder: (context) => wrapWithModel(
                          model: _model.upgradeToPremiumModel,
                          updateCallback: () => safeSetState(() {}),
                          child: UpgradeToPremiumWidget(),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'xnugsln3' /* Alunos 
Recentes */
                                        ,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
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
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          logFirebaseEvent(
                                              'PAGINA_INICIAL_PERSONAL_Text_o7wdewy3_ON');
                                          logFirebaseEvent('Text_navigate_to');

                                          context.pushNamed(
                                            GerenciamentodealunosWidget
                                                .routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 350),
                                              ),
                                            },
                                          );
                                        },
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'l9o4lbaw' /* Gerenciar alunos */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .customColor3,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ).animateOnActionTrigger(
                                          animationsMap[
                                              'textOnActionTriggerAnimation']!,
                                          hasBeenTriggered: hasTextTriggered),
                                    ),
                                  ],
                                ),
                                StreamBuilder<List<UsersRecord>>(
                                  stream: queryUsersRecord(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.where(Filter.or(
                                      Filter(
                                        'codigoPersonal',
                                        isEqualTo: columnPersonalAccountRecord
                                            ?.codigoPersonal,
                                      ),
                                      Filter(
                                        'codigodospersonaisagendado',
                                        arrayContains:
                                            columnPersonalAccountRecord
                                                ?.codigoPersonal,
                                      ),
                                    )),
                                    limit: 4,
                                  ),
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
                                    List<UsersRecord> listViewUsersRecordList =
                                        snapshot.data!;
                                    if (listViewUsersRecordList.isEmpty) {
                                      return NaoexistealunoWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: listViewUsersRecordList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 16.0),
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewUsersRecord =
                                            listViewUsersRecordList[
                                                listViewIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'PAGINA_INICIAL_PERSONAL_Row_r1lr1p1r_ON_');
                                            logFirebaseEvent(
                                                'Row_bottom_sheet');
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: CardAcoesWidget(
                                                    cliente: listViewUsersRecord
                                                        .reference,
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, -1.0),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    18.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
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
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewUsersRecord
                                                                        .photoUrl,
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/m-fit-fitness-app-tih3xk/assets/yqf4ecz3voz8/Logotipo_delicado_monograma_feminino_bege_e_branco_(1).png',
                                                                  ),
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
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
                                                                    listViewUsersRecord
                                                                        .displayName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '4o6aj7y0' /* Iniciou:  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        listViewUsersRecord.createdTime !=
                                                                                null
                                                                            ? dateTimeFormat(
                                                                                "d/M/y",
                                                                                listViewUsersRecord.createdTime!,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              )
                                                                            : 'Sem data',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 16.0)),
                                                        ),
                                                      ),
                                                      if (listViewUsersRecord
                                                          .codigodospersonaisagendado
                                                          .contains(
                                                              columnPersonalAccountRecord
                                                                  ?.codigoPersonal))
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, -1.0),
                                                          child: GradientText(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'vmoooedn' /* MH Agenda Fit */,
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
                                                            colors: [
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                              Color(0xFF044EA7)
                                                            ],
                                                            gradientDirection:
                                                                GradientDirection
                                                                    .ltr,
                                                            gradientType:
                                                                GradientType
                                                                    .linear,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (listViewUsersRecord
                                                          .tipoDeGerenciamento !=
                                                      null &&
                                                  listViewUsersRecord
                                                          .tipoDeGerenciamento !=
                                                      '')
                                                Flexible(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  8.0,
                                                                  4.0,
                                                                  8.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          listViewUsersRecord
                                                              .tipoDeGerenciamento,
                                                          'Sem gerenciamento',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: Color(
                                                                      0xFF70C7F9),
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
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ).animateOnActionTrigger(
                                            animationsMap[
                                                'rowOnActionTriggerAnimation']!,
                                            hasBeenTriggered: hasRowTriggered);
                                      },
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
