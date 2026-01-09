import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/components/headerweb_widget.dart';
import '/components/naoexisteavaliacoesposturais_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'todasasavaliacoesposturais_personal_widget.dart'
    show TodasasavaliacoesposturaisPersonalWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodasasavaliacoesposturaisPersonalModel
    extends FlutterFlowModel<TodasasavaliacoesposturaisPersonalWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [OpenRouter - Generate Text] action in todasasavaliacoesposturaisPersonal widget.
  String? avPostural;
  // Model for headerweb component.
  late HeaderwebModel headerwebModel;

  @override
  void initState(BuildContext context) {
    headerwebModel = createModel(context, () => HeaderwebModel());
  }

  @override
  void dispose() {
    headerwebModel.dispose();
  }
}
