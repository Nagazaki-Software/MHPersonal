import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'treinos_populares_chat_g_p_t_copy_model.dart';
export 'treinos_populares_chat_g_p_t_copy_model.dart';

class TreinosPopularesChatGPTCopyWidget extends StatefulWidget {
  const TreinosPopularesChatGPTCopyWidget({super.key});

  @override
  State<TreinosPopularesChatGPTCopyWidget> createState() =>
      _TreinosPopularesChatGPTCopyWidgetState();
}

class _TreinosPopularesChatGPTCopyWidgetState
    extends State<TreinosPopularesChatGPTCopyWidget> {
  late TreinosPopularesChatGPTCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TreinosPopularesChatGPTCopyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('TREINOS_POPULARES_CHAT_G_P_T_COPY_treino');
      logFirebaseEvent('treinosPopularesChatGPTCopy_firestore_qu');
      _model.queryTreinors = await queryTreinorsRecordOnce();
      if (valueOrDefault(currentUserDocument?.objetivoNoApp, '') != null &&
          valueOrDefault(currentUserDocument?.objetivoNoApp, '') != '') {
        if (functions.cada4dias(getCurrentTimestamp)) {
          logFirebaseEvent('treinosPopularesChatGPTCopy_openrouter');
          await openrouterGenerateText(
            context,
            'Retorne somente 6 os exericicos exclusivamente desta lista  \" ${functions.formatelistaparasingle(_model.queryTreinors!.map((e) => e.treinosNoLIst).toList().toList())}\" baseando os melhores treinos para \" ${valueOrDefault(currentUserDocument?.objetivoNoApp, '')}\" (RETORNE SÓ O CONTEÚDO DA LISTA  E RETORNE A PALAVRA IGUAL A DA LISTA E COM VIRGULA NO FINAL DE CADA)',
          ).then((generatedText) {
            safeSetState(() => _model.apiResult9eo = generatedText);
          });

          logFirebaseEvent('treinosPopularesChatGPTCopy_update_app_s');
          FFAppState().recomendacoes = functions
              .formatStringEmList(_model.apiResult9eo!)
              .toList()
              .cast<String>();
          FFAppState().update(() {});
        } else if (!(_model.queryTreinors != null &&
            (_model.queryTreinors)!.isNotEmpty)) {
          logFirebaseEvent('treinosPopularesChatGPTCopy_openrouter');
          await openrouterGenerateText(
            context,
            'Retorne somente 6 os exericicos exclusivamente desta lista  \" ${functions.formatelistaparasingle(_model.queryTreinors!.map((e) => e.treinosNoLIst).toList().toList())}\" baseando os melhores treinos para \" ${valueOrDefault(currentUserDocument?.objetivoNoApp, '')}\" (RETORNE SÓ O CONTEÚDO DA LISTA  E RETORNE A PALAVRA IGUAL A DA LISTA E COM VIRGULA NO FINAL DE CADA)',
          ).then((generatedText) {
            safeSetState(() => _model.apiResult9eo2 = generatedText);
          });

          logFirebaseEvent('treinosPopularesChatGPTCopy_update_app_s');
          FFAppState().recomendacoes = functions
              .formatStringEmList(_model.apiResult9eo2!)
              .toList()
              .cast<String>();
          FFAppState().update(() {});
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<TreinorsRecord>>(
      stream: queryTreinorsRecord(
        queryBuilder: (treinorsRecord) =>
            treinorsRecord.whereIn('treinosNoLIst', FFAppState().recomendacoes),
        limit: 6,
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
        List<TreinorsRecord> listViewTreinorsRecordList = snapshot.data!;

        return ListView.separated(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listViewTreinorsRecordList.length,
          separatorBuilder: (_, __) => SizedBox(width: 16.0),
          itemBuilder: (context, listViewIndex) {
            final listViewTreinorsRecord =
                listViewTreinorsRecordList[listViewIndex];
            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('TREINOS_POPULARES_CHAT_G_P_T_COPY_Contai');
                logFirebaseEvent('Container_navigate_to');
                if (Navigator.of(context).canPop()) {
                  context.pop();
                }
                context.pushNamed(
                  DetalhesdotreinoWidget.routeName,
                  queryParameters: {
                    'treinors': serializeParam(
                      listViewTreinorsRecord.reference,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
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
                shape: const CircleBorder(),
                child: Container(
                  width: 240.0,
                  height: 240.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.dumbbell,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 50.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    listViewTreinorsRecord.treinosNoLIst,
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 16.0,
                                      ),
                                      Text(
                                        '${listViewTreinorsRecord.colecao} • ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
