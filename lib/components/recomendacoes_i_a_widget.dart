import '/auth/firebase_auth/auth_util.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recomendacoes_i_a_model.dart';
export 'recomendacoes_i_a_model.dart';

/// recomendacoes por frase para mandar para ia de treinos
class RecomendacoesIAWidget extends StatefulWidget {
  const RecomendacoesIAWidget({super.key});

  @override
  State<RecomendacoesIAWidget> createState() => _RecomendacoesIAWidgetState();
}

class _RecomendacoesIAWidgetState extends State<RecomendacoesIAWidget> {
  late RecomendacoesIAModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecomendacoesIAModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('RECOMENDACOES_I_A_recomendacoesIA_ON_INI');
      logFirebaseEvent('recomendacoesIA_openrouter');
      await openrouterGenerateText(
        context,
        'Faça somente uma lista com virgula no final de cada pergunta menos na ultima e com 4 perguntas na lista para a IA para quem quer \"${valueOrDefault(currentUserDocument?.objetivoNoApp, '')}\" (Mande sem nenhum numero de lista, a pergunta é para a inteligencia artificial questões sobre quem quer \"${valueOrDefault(currentUserDocument?.objetivoNoApp, '')}\" para o usuario.',
      ).then((generatedText) {
        safeSetState(() => _model.aiText = generatedText);
      });

      logFirebaseEvent('recomendacoesIA_update_app_state');
      FFAppState().perguntaslist = functions
          .formatStringEmList(_model.aiText!)
          .toList()
          .cast<String>();
      FFAppState().update(() {});
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'wqpw818p' /* Recomendações do */,
                ),
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.outfit(
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'w1pzmn9f' /* MH Assistente */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/y_(6).png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                final perguntas = FFAppState().perguntaslist.toList();

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: perguntas.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.0),
                  itemBuilder: (context, perguntasIndex) {
                    final perguntasItem = perguntas[perguntasIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'RECOMENDACOES_I_A_Container_fgsovvz8_ON_');
                        logFirebaseEvent('Container_update_app_state');
                        FFAppState().pergunta = perguntasItem;
                        FFAppState().addToChat(MessageStruct(
                          text: perguntasItem,
                          role: 'user',
                          data: getCurrentTimestamp,
                        ));
                        FFAppState().update(() {});
                        logFirebaseEvent('Container_openrouter');
                        await openrouterGenerateText(
                          context,
                          '(finja ser o MH Assistente o assistente do aluno para academia, fitness e saude)responda essa pergunta do aluno \"${perguntasItem}\"',
                        ).then((generatedText) {
                          safeSetState(
                              () => _model.aiResponse = generatedText);
                        });

                        logFirebaseEvent('Container_update_app_state');
                        FFAppState().addToChat(MessageStruct(
                          text: _model.aiResponse,
                          role: 'system',
                          data: getCurrentTimestamp,
                        ));
                        FFAppState().update(() {});

                        safeSetState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  perguntasItem,
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ].divide(SizedBox(height: 3.0)),
        ),
      ),
    );
  }
}
