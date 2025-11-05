import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/agendamento_concluido_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stripe_connect_payment_model.dart';
export 'stripe_connect_payment_model.dart';

class StripeConnectPaymentWidget extends StatefulWidget {
  const StripeConnectPaymentWidget({
    super.key,
    required this.stripeAccountConnected,
    required this.valor,
    required this.users,
    required this.hora,
    required this.data,
    required this.service,
    required this.indexService,
  });

  final String? stripeAccountConnected;
  final double? valor;
  final DocumentReference? users;
  final String? hora;
  final DateTime? data;
  final List<MHVitrineStruct>? service;
  final int? indexService;

  @override
  State<StripeConnectPaymentWidget> createState() =>
      _StripeConnectPaymentWidgetState();
}

class _StripeConnectPaymentWidgetState
    extends State<StripeConnectPaymentWidget> {
  late StripeConnectPaymentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StripeConnectPaymentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Opacity(
          opacity: 0.0,
          child: AuthUserStreamWidget(
            builder: (context) => StreamBuilder<List<PersonalAccountRecord>>(
              stream: queryPersonalAccountRecord(
                parent: widget!.users,
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
                List<PersonalAccountRecord>
                    stripePaymentWidgetPersonalAccountRecordList =
                    snapshot.data!;
                final stripePaymentWidgetPersonalAccountRecord =
                    stripePaymentWidgetPersonalAccountRecordList.isNotEmpty
                        ? stripePaymentWidgetPersonalAccountRecordList.first
                        : null;

                return Container(
                  width: double.infinity,
                  height: 100.0,
                  child: custom_widgets.StripePaymentWidget(
                    width: double.infinity,
                    height: 100.0,
                    emailDoCliente: currentUserEmail,
                    customerName: currentUserDisplayName,
                    amount: widget!.valor!,
                    clienteStripeId: widget!.stripeAccountConnected!,
                    description: 'MH Agenda Fit',
                    onPaymentSuccess: (status, paymentId) async {
                      logFirebaseEvent(
                          'STRIPE_CONNECT_PAYMENT_Container_fwvmhcy');
                      logFirebaseEvent(
                          'StripePaymentWidget_update_component_sta');
                      _model.status = status;
                      safeSetState(() {});
                      if (status == 'success') {
                        logFirebaseEvent(
                            'StripePaymentWidget_trigger_push_notific');
                        triggerPushNotification(
                          notificationTitle:
                              '${currentUserDisplayName} comprou seu serviço!',
                          notificationText:
                              'Entre para adicionar um treino para seu novo aluno.',
                          notificationSound: 'default',
                          userRefs: [widget!.users!],
                          initialPageName: 'treinosProAluno',
                          parameterData: {
                            'cliente': currentUserReference,
                          },
                        );
                        logFirebaseEvent('StripePaymentWidget_backend_call');

                        await currentUserReference!.update({
                          ...mapToFirestore(
                            {
                              'codigodospersonaisagendado':
                                  FieldValue.arrayUnion([
                                stripePaymentWidgetPersonalAccountRecord
                                    ?.codigoPersonal
                              ]),
                            },
                          ),
                        });
                        logFirebaseEvent('StripePaymentWidget_backend_call');

                        await widget!.users!.update({
                          ...mapToFirestore(
                            {
                              'agendamento': FieldValue.arrayUnion([
                                getAgendamentoMHFirestoreData(
                                  updateAgendamentoMHStruct(
                                    AgendamentoMHStruct(
                                      user: currentUserReference,
                                      service: widget!.service
                                          ?.elementAtOrNull(valueOrDefault<int>(
                                        widget!.indexService,
                                        0,
                                      )),
                                      dia: widget!.data,
                                      hora: widget!.hora,
                                    ),
                                    clearUnsetFields: false,
                                  ),
                                  true,
                                )
                              ]),
                            },
                          ),
                        });
                        logFirebaseEvent('StripePaymentWidget_bottom_sheet');
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: AgendamentoConcluidoWidget(),
                            );
                          },
                        ).then((value) => safeSetState(() {}));

                        logFirebaseEvent('StripePaymentWidget_bottom_sheet');
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Icon(
                        Icons.security_rounded,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'i894p2d6' /* Pagamento Seguro */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '9g9u9805' /* MH Personal Trainer */,
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
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
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
                  ].divide(SizedBox(width: 12.0)),
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: FlutterFlowTheme.of(context).customColor3,
                          size: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'b0iqprnv' /* Criptografia SSL de 256 bits */,
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
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: FlutterFlowTheme.of(context).customColor3,
                          size: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'm9qjj5ro' /* Dados protegidos conforme LGPD */,
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
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: FlutterFlowTheme.of(context).customColor3,
                          size: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'x0i0npgq' /* Transações monitoradas 24/7 */,
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
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: FlutterFlowTheme.of(context).customColor3,
                          size: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'opw97u42' /* Certificação PCI DSS Level 1 */,
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
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.ccVisa,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    FaIcon(
                      FontAwesomeIcons.ccMastercard,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    FaIcon(
                      FontAwesomeIcons.ccStripe,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    FaIcon(
                      FontAwesomeIcons.ccAmazonPay,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    FaIcon(
                      FontAwesomeIcons.ccApplePay,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    FaIcon(
                      FontAwesomeIcons.ccAmex,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ],
    );
  }
}
