import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nenhumtreinodisponivel_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'meus_treinos_widget.dart' show MeusTreinosWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MeusTreinosModel extends FlutterFlowModel<MeusTreinosWidget> {
  ///  Local state fields for this page.

  int? treinosRandow = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in meusTreinos widget.
  AvaliacoesFisicasRecord? queryAVFisica;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
