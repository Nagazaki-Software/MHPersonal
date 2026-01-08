import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _chatHistory = prefs.getStringList('ff_chatHistory') ?? _chatHistory;
    });
    _safeInit(() {
      _recomendacoes =
          prefs.getStringList('ff_recomendacoes') ?? _recomendacoes;
    });
    _safeInit(() {
      _perguntaslist =
          prefs.getStringList('ff_perguntaslist') ?? _perguntaslist;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_treinoInJson')) {
        try {
          _treinoInJson = jsonDecode(prefs.getString('ff_treinoInJson') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _diadotesdegratis = prefs.containsKey('ff_diadotesdegratis')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_diadotesdegratis')!)
          : _diadotesdegratis;
    });
    _safeInit(() {
      _deeplinkroute = prefs.getString('ff_deeplinkroute') ?? _deeplinkroute;
    });
    _safeInit(() {
      _entrounoappdia = prefs
              .getStringList('ff_entrounoappdia')
              ?.map((x) => DateTime.fromMillisecondsSinceEpoch(int.parse(x)))
              .toList() ??
          _entrounoappdia;
    });
    _safeInit(() {
      _appLanguage = prefs.getString('ff_appLanguage') ?? _appLanguage;
    });
    _safeInit(() {
      _listSeriesRep = prefs
              .getStringList('ff_listSeriesRep')
              ?.map((path) => path.ref)
              .toList() ??
          _listSeriesRep;
    });
    _safeInit(() {
      _seriesData = prefs
              .getStringList('ff_seriesData')
              ?.map((x) {
                try {
                  return SeriesRepStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _seriesData;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _searchBoolean = false;
  bool get searchBoolean => _searchBoolean;
  set searchBoolean(bool value) {
    _searchBoolean = value;
  }

  bool _fullListShow = true;
  bool get fullListShow => _fullListShow;
  set fullListShow(bool value) {
    _fullListShow = value;
  }

  bool _assinar = false;
  bool get assinar => _assinar;
  set assinar(bool value) {
    _assinar = value;
  }

  List<MessageStruct> _chat = [];
  List<MessageStruct> get chat => _chat;
  set chat(List<MessageStruct> value) {
    _chat = value;
  }

  void addToChat(MessageStruct value) {
    chat.add(value);
  }

  void removeFromChat(MessageStruct value) {
    chat.remove(value);
  }

  void removeAtIndexFromChat(int index) {
    chat.removeAt(index);
  }

  void updateChatAtIndex(
    int index,
    MessageStruct Function(MessageStruct) updateFn,
  ) {
    chat[index] = updateFn(_chat[index]);
  }

  void insertAtIndexInChat(int index, MessageStruct value) {
    chat.insert(index, value);
  }

  String _prompt = '';
  String get prompt => _prompt;
  set prompt(String value) {
    _prompt = value;
  }

  DocumentStrutureStruct _documentStruct = DocumentStrutureStruct();
  DocumentStrutureStruct get documentStruct => _documentStruct;
  set documentStruct(DocumentStrutureStruct value) {
    _documentStruct = value;
  }

  void updateDocumentStructStruct(Function(DocumentStrutureStruct) updateFn) {
    updateFn(_documentStruct);
  }

  String _downloadUrl = '';
  String get downloadUrl => _downloadUrl;
  set downloadUrl(String value) {
    _downloadUrl = value;
  }

  bool _proximaEtapa = false;
  bool get proximaEtapa => _proximaEtapa;
  set proximaEtapa(bool value) {
    _proximaEtapa = value;
  }

  bool _creditCard = false;
  bool get creditCard => _creditCard;
  set creditCard(bool value) {
    _creditCard = value;
  }

  String _messagemChatGpt = '';
  String get messagemChatGpt => _messagemChatGpt;
  set messagemChatGpt(String value) {
    _messagemChatGpt = value;
  }

  String _errorTxtChatGPT = '';
  String get errorTxtChatGPT => _errorTxtChatGPT;
  set errorTxtChatGPT(String value) {
    _errorTxtChatGPT = value;
  }

  bool _messageChatGpt = false;
  bool get messageChatGpt => _messageChatGpt;
  set messageChatGpt(bool value) {
    _messageChatGpt = value;
  }

  bool _errorChatGPT = false;
  bool get errorChatGPT => _errorChatGPT;
  set errorChatGPT(bool value) {
    _errorChatGPT = value;
  }

  List<String> _chatHistory = [];
  List<String> get chatHistory => _chatHistory;
  set chatHistory(List<String> value) {
    _chatHistory = value;
    prefs.setStringList('ff_chatHistory', value);
  }

  void addToChatHistory(String value) {
    chatHistory.add(value);
    prefs.setStringList('ff_chatHistory', _chatHistory);
  }

  void removeFromChatHistory(String value) {
    chatHistory.remove(value);
    prefs.setStringList('ff_chatHistory', _chatHistory);
  }

  void removeAtIndexFromChatHistory(int index) {
    chatHistory.removeAt(index);
    prefs.setStringList('ff_chatHistory', _chatHistory);
  }

  void updateChatHistoryAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    chatHistory[index] = updateFn(_chatHistory[index]);
    prefs.setStringList('ff_chatHistory', _chatHistory);
  }

  void insertAtIndexInChatHistory(int index, String value) {
    chatHistory.insert(index, value);
    prefs.setStringList('ff_chatHistory', _chatHistory);
  }

  String _chatResposta = '';
  String get chatResposta => _chatResposta;
  set chatResposta(String value) {
    _chatResposta = value;
  }

  dynamic _chatHistories;
  dynamic get chatHistories => _chatHistories;
  set chatHistories(dynamic value) {
    _chatHistories = value;
  }

  bool _exercicioFinalizado = false;
  bool get exercicioFinalizado => _exercicioFinalizado;
  set exercicioFinalizado(bool value) {
    _exercicioFinalizado = value;
  }

  List<int> _maisUmaPergunta = [];
  List<int> get maisUmaPergunta => _maisUmaPergunta;
  set maisUmaPergunta(List<int> value) {
    _maisUmaPergunta = value;
  }

  void addToMaisUmaPergunta(int value) {
    maisUmaPergunta.add(value);
  }

  void removeFromMaisUmaPergunta(int value) {
    maisUmaPergunta.remove(value);
  }

  void removeAtIndexFromMaisUmaPergunta(int index) {
    maisUmaPergunta.removeAt(index);
  }

  void updateMaisUmaPerguntaAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    maisUmaPergunta[index] = updateFn(_maisUmaPergunta[index]);
  }

  void insertAtIndexInMaisUmaPergunta(int index, int value) {
    maisUmaPergunta.insert(index, value);
  }

  bool _isNotification = false;
  bool get isNotification => _isNotification;
  set isNotification(bool value) {
    _isNotification = value;
  }

  String _versaoDoApp = '8.8.197714:108';
  String get versaoDoApp => _versaoDoApp;
  set versaoDoApp(String value) {
    _versaoDoApp = value;
  }

  int _codigoPersonal = 0;
  int get codigoPersonal => _codigoPersonal;
  set codigoPersonal(int value) {
    _codigoPersonal = value;
  }

  EvolucaoDeCargaStruct _CargasDataType = EvolucaoDeCargaStruct();
  EvolucaoDeCargaStruct get CargasDataType => _CargasDataType;
  set CargasDataType(EvolucaoDeCargaStruct value) {
    _CargasDataType = value;
  }

  void updateCargasDataTypeStruct(Function(EvolucaoDeCargaStruct) updateFn) {
    updateFn(_CargasDataType);
  }

  String _metodoDePagamento = '';
  String get metodoDePagamento => _metodoDePagamento;
  set metodoDePagamento(String value) {
    _metodoDePagamento = value;
  }

  MessageStruct _chatSingle = MessageStruct();
  MessageStruct get chatSingle => _chatSingle;
  set chatSingle(MessageStruct value) {
    _chatSingle = value;
  }

  void updateChatSingleStruct(Function(MessageStruct) updateFn) {
    updateFn(_chatSingle);
  }

  List<String> _recomendacoes = [
    'Elevação frontal alternado (Diagonal na polia baixa (Unilateral))',
    'Afundo (No smith) (Alternado)',
    'Infra com joelhos flexionados (Com joelhos extendidos'
  ];
  List<String> get recomendacoes => _recomendacoes;
  set recomendacoes(List<String> value) {
    _recomendacoes = value;
    prefs.setStringList('ff_recomendacoes', value);
  }

  void addToRecomendacoes(String value) {
    recomendacoes.add(value);
    prefs.setStringList('ff_recomendacoes', _recomendacoes);
  }

  void removeFromRecomendacoes(String value) {
    recomendacoes.remove(value);
    prefs.setStringList('ff_recomendacoes', _recomendacoes);
  }

  void removeAtIndexFromRecomendacoes(int index) {
    recomendacoes.removeAt(index);
    prefs.setStringList('ff_recomendacoes', _recomendacoes);
  }

  void updateRecomendacoesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    recomendacoes[index] = updateFn(_recomendacoes[index]);
    prefs.setStringList('ff_recomendacoes', _recomendacoes);
  }

  void insertAtIndexInRecomendacoes(int index, String value) {
    recomendacoes.insert(index, value);
    prefs.setStringList('ff_recomendacoes', _recomendacoes);
  }

  String _msgDoUsuario = '';
  String get msgDoUsuario => _msgDoUsuario;
  set msgDoUsuario(String value) {
    _msgDoUsuario = value;
  }

  String _pergunta = '';
  String get pergunta => _pergunta;
  set pergunta(String value) {
    _pergunta = value;
  }

  List<String> _perguntaslist = [];
  List<String> get perguntaslist => _perguntaslist;
  set perguntaslist(List<String> value) {
    _perguntaslist = value;
    prefs.setStringList('ff_perguntaslist', value);
  }

  void addToPerguntaslist(String value) {
    perguntaslist.add(value);
    prefs.setStringList('ff_perguntaslist', _perguntaslist);
  }

  void removeFromPerguntaslist(String value) {
    perguntaslist.remove(value);
    prefs.setStringList('ff_perguntaslist', _perguntaslist);
  }

  void removeAtIndexFromPerguntaslist(int index) {
    perguntaslist.removeAt(index);
    prefs.setStringList('ff_perguntaslist', _perguntaslist);
  }

  void updatePerguntaslistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    perguntaslist[index] = updateFn(_perguntaslist[index]);
    prefs.setStringList('ff_perguntaslist', _perguntaslist);
  }

  void insertAtIndexInPerguntaslist(int index, String value) {
    perguntaslist.insert(index, value);
    prefs.setStringList('ff_perguntaslist', _perguntaslist);
  }

  dynamic _treinoInJson;
  dynamic get treinoInJson => _treinoInJson;
  set treinoInJson(dynamic value) {
    _treinoInJson = value;
    prefs.setString('ff_treinoInJson', jsonEncode(value));
  }

  String _mhassisyentenavegacao = '';
  String get mhassisyentenavegacao => _mhassisyentenavegacao;
  set mhassisyentenavegacao(String value) {
    _mhassisyentenavegacao = value;
  }

  DateTime? _diadotesdegratis;
  DateTime? get diadotesdegratis => _diadotesdegratis;
  set diadotesdegratis(DateTime? value) {
    _diadotesdegratis = value;
    value != null
        ? prefs.setInt('ff_diadotesdegratis', value.millisecondsSinceEpoch)
        : prefs.remove('ff_diadotesdegratis');
  }

  String _deeplinkroute = '';
  String get deeplinkroute => _deeplinkroute;
  set deeplinkroute(String value) {
    _deeplinkroute = value;
    prefs.setString('ff_deeplinkroute', value);
  }

  List<DateTime> _entrounoappdia = [];
  List<DateTime> get entrounoappdia => _entrounoappdia;
  set entrounoappdia(List<DateTime> value) {
    _entrounoappdia = value;
    prefs.setStringList('ff_entrounoappdia',
        value.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void addToEntrounoappdia(DateTime value) {
    entrounoappdia.add(value);
    prefs.setStringList(
        'ff_entrounoappdia',
        _entrounoappdia
            .map((x) => x.millisecondsSinceEpoch.toString())
            .toList());
  }

  void removeFromEntrounoappdia(DateTime value) {
    entrounoappdia.remove(value);
    prefs.setStringList(
        'ff_entrounoappdia',
        _entrounoappdia
            .map((x) => x.millisecondsSinceEpoch.toString())
            .toList());
  }

  void removeAtIndexFromEntrounoappdia(int index) {
    entrounoappdia.removeAt(index);
    prefs.setStringList(
        'ff_entrounoappdia',
        _entrounoappdia
            .map((x) => x.millisecondsSinceEpoch.toString())
            .toList());
  }

  void updateEntrounoappdiaAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    entrounoappdia[index] = updateFn(_entrounoappdia[index]);
    prefs.setStringList(
        'ff_entrounoappdia',
        _entrounoappdia
            .map((x) => x.millisecondsSinceEpoch.toString())
            .toList());
  }

  void insertAtIndexInEntrounoappdia(int index, DateTime value) {
    entrounoappdia.insert(index, value);
    prefs.setStringList(
        'ff_entrounoappdia',
        _entrounoappdia
            .map((x) => x.millisecondsSinceEpoch.toString())
            .toList());
  }

  List<String> _treinoconcluidohoje = [];
  List<String> get treinoconcluidohoje => _treinoconcluidohoje;
  set treinoconcluidohoje(List<String> value) {
    _treinoconcluidohoje = value;
  }

  void addToTreinoconcluidohoje(String value) {
    treinoconcluidohoje.add(value);
  }

  void removeFromTreinoconcluidohoje(String value) {
    treinoconcluidohoje.remove(value);
  }

  void removeAtIndexFromTreinoconcluidohoje(int index) {
    treinoconcluidohoje.removeAt(index);
  }

  void updateTreinoconcluidohojeAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    treinoconcluidohoje[index] = updateFn(_treinoconcluidohoje[index]);
  }

  void insertAtIndexInTreinoconcluidohoje(int index, String value) {
    treinoconcluidohoje.insert(index, value);
  }

  int _oldIndex = 0;
  int get oldIndex => _oldIndex;
  set oldIndex(int value) {
    _oldIndex = value;
  }

  int _newIndex = 0;
  int get newIndex => _newIndex;
  set newIndex(int value) {
    _newIndex = value;
  }

  List<String> _reorderList = ['Hello World', 'Hello World'];
  List<String> get reorderList => _reorderList;
  set reorderList(List<String> value) {
    _reorderList = value;
  }

  void addToReorderList(String value) {
    reorderList.add(value);
  }

  void removeFromReorderList(String value) {
    reorderList.remove(value);
  }

  void removeAtIndexFromReorderList(int index) {
    reorderList.removeAt(index);
  }

  void updateReorderListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    reorderList[index] = updateFn(_reorderList[index]);
  }

  void insertAtIndexInReorderList(int index, String value) {
    reorderList.insert(index, value);
  }

  List<String> _seriesRep = [];
  List<String> get seriesRep => _seriesRep;
  set seriesRep(List<String> value) {
    _seriesRep = value;
  }

  void addToSeriesRep(String value) {
    seriesRep.add(value);
  }

  void removeFromSeriesRep(String value) {
    seriesRep.remove(value);
  }

  void removeAtIndexFromSeriesRep(int index) {
    seriesRep.removeAt(index);
  }

  void updateSeriesRepAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    seriesRep[index] = updateFn(_seriesRep[index]);
  }

  void insertAtIndexInSeriesRep(int index, String value) {
    seriesRep.insert(index, value);
  }

  List<String> _intervalo = [];
  List<String> get intervalo => _intervalo;
  set intervalo(List<String> value) {
    _intervalo = value;
  }

  void addToIntervalo(String value) {
    intervalo.add(value);
  }

  void removeFromIntervalo(String value) {
    intervalo.remove(value);
  }

  void removeAtIndexFromIntervalo(int index) {
    intervalo.removeAt(index);
  }

  void updateIntervaloAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    intervalo[index] = updateFn(_intervalo[index]);
  }

  void insertAtIndexInIntervalo(int index, String value) {
    intervalo.insert(index, value);
  }

  List<String> _velocidades = [];
  List<String> get velocidades => _velocidades;
  set velocidades(List<String> value) {
    _velocidades = value;
  }

  void addToVelocidades(String value) {
    velocidades.add(value);
  }

  void removeFromVelocidades(String value) {
    velocidades.remove(value);
  }

  void removeAtIndexFromVelocidades(int index) {
    velocidades.removeAt(index);
  }

  void updateVelocidadesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    velocidades[index] = updateFn(_velocidades[index]);
  }

  void insertAtIndexInVelocidades(int index, String value) {
    velocidades.insert(index, value);
  }

  String _appLanguage = '';
  String get appLanguage => _appLanguage;
  set appLanguage(String value) {
    _appLanguage = value;
    prefs.setString('ff_appLanguage', value);
  }

  String _filtroAdmin = '';
  String get filtroAdmin => _filtroAdmin;
  set filtroAdmin(String value) {
    _filtroAdmin = value;
  }

  String _filterVideoFoto = '';
  String get filterVideoFoto => _filterVideoFoto;
  set filterVideoFoto(String value) {
    _filterVideoFoto = value;
  }

  List<DocumentReference> _listSeriesRep = [];
  List<DocumentReference> get listSeriesRep => _listSeriesRep;
  set listSeriesRep(List<DocumentReference> value) {
    _listSeriesRep = value;
    prefs.setStringList('ff_listSeriesRep', value.map((x) => x.path).toList());
  }

  void addToListSeriesRep(DocumentReference value) {
    listSeriesRep.add(value);
    prefs.setStringList(
        'ff_listSeriesRep', _listSeriesRep.map((x) => x.path).toList());
  }

  void removeFromListSeriesRep(DocumentReference value) {
    listSeriesRep.remove(value);
    prefs.setStringList(
        'ff_listSeriesRep', _listSeriesRep.map((x) => x.path).toList());
  }

  void removeAtIndexFromListSeriesRep(int index) {
    listSeriesRep.removeAt(index);
    prefs.setStringList(
        'ff_listSeriesRep', _listSeriesRep.map((x) => x.path).toList());
  }

  void updateListSeriesRepAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    listSeriesRep[index] = updateFn(_listSeriesRep[index]);
    prefs.setStringList(
        'ff_listSeriesRep', _listSeriesRep.map((x) => x.path).toList());
  }

  void insertAtIndexInListSeriesRep(int index, DocumentReference value) {
    listSeriesRep.insert(index, value);
    prefs.setStringList(
        'ff_listSeriesRep', _listSeriesRep.map((x) => x.path).toList());
  }

  List<SeriesRepStruct> _seriesData = [];
  List<SeriesRepStruct> get seriesData => _seriesData;
  set seriesData(List<SeriesRepStruct> value) {
    _seriesData = value;
    prefs.setStringList(
        'ff_seriesData', value.map((x) => x.serialize()).toList());
  }

  void addToSeriesData(SeriesRepStruct value) {
    seriesData.add(value);
    prefs.setStringList(
        'ff_seriesData', _seriesData.map((x) => x.serialize()).toList());
  }

  void removeFromSeriesData(SeriesRepStruct value) {
    seriesData.remove(value);
    prefs.setStringList(
        'ff_seriesData', _seriesData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSeriesData(int index) {
    seriesData.removeAt(index);
    prefs.setStringList(
        'ff_seriesData', _seriesData.map((x) => x.serialize()).toList());
  }

  void updateSeriesDataAtIndex(
    int index,
    SeriesRepStruct Function(SeriesRepStruct) updateFn,
  ) {
    seriesData[index] = updateFn(_seriesData[index]);
    prefs.setStringList(
        'ff_seriesData', _seriesData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSeriesData(int index, SeriesRepStruct value) {
    seriesData.insert(index, value);
    prefs.setStringList(
        'ff_seriesData', _seriesData.map((x) => x.serialize()).toList());
  }

  bool _nullTextfieldValue = false;
  bool get nullTextfieldValue => _nullTextfieldValue;
  set nullTextfieldValue(bool value) {
    _nullTextfieldValue = value;
  }

  DateTime? _comecaemdarotina;
  DateTime? get comecaemdarotina => _comecaemdarotina;
  set comecaemdarotina(DateTime? value) {
    _comecaemdarotina = value;
  }

  List<DocumentReference> _conversasAtivas = [];
  List<DocumentReference> get conversasAtivas => _conversasAtivas;
  set conversasAtivas(List<DocumentReference> value) {
    _conversasAtivas = value;
  }

  void addToConversasAtivas(DocumentReference value) {
    conversasAtivas.add(value);
  }

  void removeFromConversasAtivas(DocumentReference value) {
    conversasAtivas.remove(value);
  }

  void removeAtIndexFromConversasAtivas(int index) {
    conversasAtivas.removeAt(index);
  }

  void updateConversasAtivasAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    conversasAtivas[index] = updateFn(_conversasAtivas[index]);
  }

  void insertAtIndexInConversasAtivas(int index, DocumentReference value) {
    conversasAtivas.insert(index, value);
  }

  List<String> _listadeespecificacoes = [];
  List<String> get listadeespecificacoes => _listadeespecificacoes;
  set listadeespecificacoes(List<String> value) {
    _listadeespecificacoes = value;
  }

  void addToListadeespecificacoes(String value) {
    listadeespecificacoes.add(value);
  }

  void removeFromListadeespecificacoes(String value) {
    listadeespecificacoes.remove(value);
  }

  void removeAtIndexFromListadeespecificacoes(int index) {
    listadeespecificacoes.removeAt(index);
  }

  void updateListadeespecificacoesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listadeespecificacoes[index] = updateFn(_listadeespecificacoes[index]);
  }

  void insertAtIndexInListadeespecificacoes(int index, String value) {
    listadeespecificacoes.insert(index, value);
  }

  final _allRotinaManager = StreamRequestManager<CreateTreinosRecord>();
  Stream<CreateTreinosRecord> allRotina({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<CreateTreinosRecord> Function() requestFn,
  }) =>
      _allRotinaManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAllRotinaCache() => _allRotinaManager.clear();
  void clearAllRotinaCacheKey(String? uniqueKey) =>
      _allRotinaManager.clearRequest(uniqueKey);

  final _cacheExercicioAlunoManager =
      StreamRequestManager<List<TreinorsRecord>>(50);
  Stream<List<TreinorsRecord>> cacheExercicioAluno({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TreinorsRecord>> Function() requestFn,
  }) =>
      _cacheExercicioAlunoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCacheExercicioAlunoCache() => _cacheExercicioAlunoManager.clear();
  void clearCacheExercicioAlunoCacheKey(String? uniqueKey) =>
      _cacheExercicioAlunoManager.clearRequest(uniqueKey);

  final _cacheAllTreinosManager = FutureRequestManager<List<TreinorsRecord>>();
  Future<List<TreinorsRecord>> cacheAllTreinos({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TreinorsRecord>> Function() requestFn,
  }) =>
      _cacheAllTreinosManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCacheAllTreinosCache() => _cacheAllTreinosManager.clear();
  void clearCacheAllTreinosCacheKey(String? uniqueKey) =>
      _cacheAllTreinosManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
