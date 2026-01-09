import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/components/addtreino_widget.dart';
import '/components/reomendadopelomh_copy_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'detalhesdotreino_widget.dart' show DetalhesdotreinoWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetalhesdotreinoModel extends FlutterFlowModel<DetalhesdotreinoWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in detalhesdotreino widget.
  TreinorsRecord? treinortreino;
  // Stores action output result for [OpenRouter - Generate Text] action in detalhesdotreino widget.
  String? apiResult8j7;
  // Model for reomendadopelomhCopy component.
  late ReomendadopelomhCopyModel reomendadopelomhCopyModel;

  @override
  void initState(BuildContext context) {
    reomendadopelomhCopyModel =
        createModel(context, () => ReomendadopelomhCopyModel());
  }

  @override
  void dispose() {
    reomendadopelomhCopyModel.dispose();
  }
}
