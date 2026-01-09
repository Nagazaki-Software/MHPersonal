import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "birthday" field.
  String? _birthday;
  String get birthday => _birthday ?? '';
  bool hasBirthday() => _birthday != null;

  // "professorAccount" field.
  bool? _professorAccount;
  bool get professorAccount => _professorAccount ?? false;
  bool hasProfessorAccount() => _professorAccount != null;

  // "codigoPersonal" field.
  int? _codigoPersonal;
  int get codigoPersonal => _codigoPersonal ?? 0;
  bool hasCodigoPersonal() => _codigoPersonal != null;

  // "personalAccount" field.
  DocumentReference? _personalAccount;
  DocumentReference? get personalAccount => _personalAccount;
  bool hasPersonalAccount() => _personalAccount != null;

  // "userInList" field.
  List<DocumentReference>? _userInList;
  List<DocumentReference> get userInList => _userInList ?? const [];
  bool hasUserInList() => _userInList != null;

  // "rotinaDeTreinosInList" field.
  List<DocumentReference>? _rotinaDeTreinosInList;
  List<DocumentReference> get rotinaDeTreinosInList =>
      _rotinaDeTreinosInList ?? const [];
  bool hasRotinaDeTreinosInList() => _rotinaDeTreinosInList != null;

  // "nameDoSeuPersonal" field.
  String? _nameDoSeuPersonal;
  String get nameDoSeuPersonal => _nameDoSeuPersonal ?? '';
  bool hasNameDoSeuPersonal() => _nameDoSeuPersonal != null;

  // "genero" field.
  String? _genero;
  String get genero => _genero ?? '';
  bool hasGenero() => _genero != null;

  // "treinos" field.
  List<String>? _treinos;
  List<String> get treinos => _treinos ?? const [];
  bool hasTreinos() => _treinos != null;

  // "diaDoTermino" field.
  DateTime? _diaDoTermino;
  DateTime? get diaDoTermino => _diaDoTermino;
  bool hasDiaDoTermino() => _diaDoTermino != null;

  // "admin" field.
  bool? _admin;
  bool get admin => _admin ?? false;
  bool hasAdmin() => _admin != null;

  // "acessoSuspenso" field.
  bool? _acessoSuspenso;
  bool get acessoSuspenso => _acessoSuspenso ?? false;
  bool hasAcessoSuspenso() => _acessoSuspenso != null;

  // "tipoDeGerenciamento" field.
  String? _tipoDeGerenciamento;
  String get tipoDeGerenciamento => _tipoDeGerenciamento ?? '';
  bool hasTipoDeGerenciamento() => _tipoDeGerenciamento != null;

  // "assinatura" field.
  bool? _assinatura;
  bool get assinatura => _assinatura ?? false;
  bool hasAssinatura() => _assinatura != null;

  // "valorPago" field.
  double? _valorPago;
  double get valorPago => _valorPago ?? 0.0;
  bool hasValorPago() => _valorPago != null;

  // "planoChatGPT" field.
  bool? _planoChatGPT;
  bool get planoChatGPT => _planoChatGPT ?? false;
  bool hasPlanoChatGPT() => _planoChatGPT != null;

  // "cpfCnpj" field.
  String? _cpfCnpj;
  String get cpfCnpj => _cpfCnpj ?? '';
  bool hasCpfCnpj() => _cpfCnpj != null;

  // "customer" field.
  String? _customer;
  String get customer => _customer ?? '';
  bool hasCustomer() => _customer != null;

  // "tipoDeAssinatura" field.
  String? _tipoDeAssinatura;
  String get tipoDeAssinatura => _tipoDeAssinatura ?? '';
  bool hasTipoDeAssinatura() => _tipoDeAssinatura != null;

  // "rotinaDeTreino" field.
  List<String>? _rotinaDeTreino;
  List<String> get rotinaDeTreino => _rotinaDeTreino ?? const [];
  bool hasRotinaDeTreino() => _rotinaDeTreino != null;

  // "recomendacaoChatGPT" field.
  bool? _recomendacaoChatGPT;
  bool get recomendacaoChatGPT => _recomendacaoChatGPT ?? false;
  bool hasRecomendacaoChatGPT() => _recomendacaoChatGPT != null;

  // "createTreinosRef" field.
  DocumentReference? _createTreinosRef;
  DocumentReference? get createTreinosRef => _createTreinosRef;
  bool hasCreateTreinosRef() => _createTreinosRef != null;

  // "objetivoNoApp" field.
  String? _objetivoNoApp;
  String get objetivoNoApp => _objetivoNoApp ?? '';
  bool hasObjetivoNoApp() => _objetivoNoApp != null;

  // "expericencia" field.
  String? _expericencia;
  String get expericencia => _expericencia ?? '';
  bool hasExpericencia() => _expericencia != null;

  // "equipamento" field.
  String? _equipamento;
  String get equipamento => _equipamento ?? '';
  bool hasEquipamento() => _equipamento != null;

  // "tempoPorSessao" field.
  String? _tempoPorSessao;
  String get tempoPorSessao => _tempoPorSessao ?? '';
  bool hasTempoPorSessao() => _tempoPorSessao != null;

  // "horario" field.
  String? _horario;
  String get horario => _horario ?? '';
  bool hasHorario() => _horario != null;

  // "diasDeTreino" field.
  String? _diasDeTreino;
  String get diasDeTreino => _diasDeTreino ?? '';
  bool hasDiasDeTreino() => _diasDeTreino != null;

  // "limitacao" field.
  String? _limitacao;
  String get limitacao => _limitacao ?? '';
  bool hasLimitacao() => _limitacao != null;

  // "peso" field.
  String? _peso;
  String get peso => _peso ?? '';
  bool hasPeso() => _peso != null;

  // "altura" field.
  String? _altura;
  String get altura => _altura ?? '';
  bool hasAltura() => _altura != null;

  // "nivelDeAtividade" field.
  String? _nivelDeAtividade;
  String get nivelDeAtividade => _nivelDeAtividade ?? '';
  bool hasNivelDeAtividade() => _nivelDeAtividade != null;

  // "alunoDesde" field.
  DateTime? _alunoDesde;
  DateTime? get alunoDesde => _alunoDesde;
  bool hasAlunoDesde() => _alunoDesde != null;

  // "metodoDePagamento" field.
  String? _metodoDePagamento;
  String get metodoDePagamento => _metodoDePagamento ?? '';
  bool hasMetodoDePagamento() => _metodoDePagamento != null;

  // "chavePixDoPersonal" field.
  String? _chavePixDoPersonal;
  String get chavePixDoPersonal => _chavePixDoPersonal ?? '';
  bool hasChavePixDoPersonal() => _chavePixDoPersonal != null;

  // "desde" field.
  DateTime? _desde;
  DateTime? get desde => _desde;
  bool hasDesde() => _desde != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "satisfacaocomoapp" field.
  double? _satisfacaocomoapp;
  double get satisfacaocomoapp => _satisfacaocomoapp ?? 0.0;
  bool hasSatisfacaocomoapp() => _satisfacaocomoapp != null;

  // "suprallicas" field.
  List<double>? _suprallicas;
  List<double> get suprallicas => _suprallicas ?? const [];
  bool hasSuprallicas() => _suprallicas != null;

  // "subescapilar" field.
  List<double>? _subescapilar;
  List<double> get subescapilar => _subescapilar ?? const [];
  bool hasSubescapilar() => _subescapilar != null;

  // "alunos" field.
  List<DocumentReference>? _alunos;
  List<DocumentReference> get alunos => _alunos ?? const [];
  bool hasAlunos() => _alunos != null;

  // "subscribeId" field.
  String? _subscribeId;
  String get subscribeId => _subscribeId ?? '';
  bool hasSubscribeId() => _subscribeId != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "servicos" field.
  List<MHVitrineStruct>? _servicos;
  List<MHVitrineStruct> get servicos => _servicos ?? const [];
  bool hasServicos() => _servicos != null;

  // "horarioAtendimento" field.
  HorarioStruct? _horarioAtendimento;
  HorarioStruct get horarioAtendimento =>
      _horarioAtendimento ?? HorarioStruct();
  bool hasHorarioAtendimento() => _horarioAtendimento != null;

  // "stripeAtivo" field.
  bool? _stripeAtivo;
  bool get stripeAtivo => _stripeAtivo ?? false;
  bool hasStripeAtivo() => _stripeAtivo != null;

  // "stripeAccountId" field.
  String? _stripeAccountId;
  String get stripeAccountId => _stripeAccountId ?? '';
  bool hasStripeAccountId() => _stripeAccountId != null;

  // "avaliacoesPersonal" field.
  List<AvaliacaesPersonalStruct>? _avaliacoesPersonal;
  List<AvaliacaesPersonalStruct> get avaliacoesPersonal =>
      _avaliacoesPersonal ?? const [];
  bool hasAvaliacoesPersonal() => _avaliacoesPersonal != null;

  // "agendamento" field.
  List<AgendamentoMHStruct>? _agendamento;
  List<AgendamentoMHStruct> get agendamento => _agendamento ?? const [];
  bool hasAgendamento() => _agendamento != null;

  // "codigodospersonaisagendado" field.
  List<int>? _codigodospersonaisagendado;
  List<int> get codigodospersonaisagendado =>
      _codigodospersonaisagendado ?? const [];
  bool hasCodigodospersonaisagendado() => _codigodospersonaisagendado != null;

  // "especializacao" field.
  List<String>? _especializacao;
  List<String> get especializacao => _especializacao ?? const [];
  bool hasEspecializacao() => _especializacao != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _title = snapshotData['title'] as String?;
    _birthday = snapshotData['birthday'] as String?;
    _professorAccount = snapshotData['professorAccount'] as bool?;
    _codigoPersonal = castToType<int>(snapshotData['codigoPersonal']);
    _personalAccount = snapshotData['personalAccount'] as DocumentReference?;
    _userInList = getDataList(snapshotData['userInList']);
    _rotinaDeTreinosInList = getDataList(snapshotData['rotinaDeTreinosInList']);
    _nameDoSeuPersonal = snapshotData['nameDoSeuPersonal'] as String?;
    _genero = snapshotData['genero'] as String?;
    _treinos = getDataList(snapshotData['treinos']);
    _diaDoTermino = snapshotData['diaDoTermino'] as DateTime?;
    _admin = snapshotData['admin'] as bool?;
    _acessoSuspenso = snapshotData['acessoSuspenso'] as bool?;
    _tipoDeGerenciamento = snapshotData['tipoDeGerenciamento'] as String?;
    _assinatura = snapshotData['assinatura'] as bool?;
    _valorPago = castToType<double>(snapshotData['valorPago']);
    _planoChatGPT = snapshotData['planoChatGPT'] as bool?;
    _cpfCnpj = snapshotData['cpfCnpj'] as String?;
    _customer = snapshotData['customer'] as String?;
    _tipoDeAssinatura = snapshotData['tipoDeAssinatura'] as String?;
    _rotinaDeTreino = getDataList(snapshotData['rotinaDeTreino']);
    _recomendacaoChatGPT = snapshotData['recomendacaoChatGPT'] as bool?;
    _createTreinosRef = snapshotData['createTreinosRef'] as DocumentReference?;
    _objetivoNoApp = snapshotData['objetivoNoApp'] as String?;
    _expericencia = snapshotData['expericencia'] as String?;
    _equipamento = snapshotData['equipamento'] as String?;
    _tempoPorSessao = snapshotData['tempoPorSessao'] as String?;
    _horario = snapshotData['horario'] as String?;
    _diasDeTreino = snapshotData['diasDeTreino'] as String?;
    _limitacao = snapshotData['limitacao'] as String?;
    _peso = snapshotData['peso'] as String?;
    _altura = snapshotData['altura'] as String?;
    _nivelDeAtividade = snapshotData['nivelDeAtividade'] as String?;
    _alunoDesde = snapshotData['alunoDesde'] as DateTime?;
    _metodoDePagamento = snapshotData['metodoDePagamento'] as String?;
    _chavePixDoPersonal = snapshotData['chavePixDoPersonal'] as String?;
    _desde = snapshotData['desde'] as DateTime?;
    _password = snapshotData['password'] as String?;
    _satisfacaocomoapp = castToType<double>(snapshotData['satisfacaocomoapp']);
    _suprallicas = getDataList(snapshotData['suprallicas']);
    _subescapilar = getDataList(snapshotData['subescapilar']);
    _alunos = getDataList(snapshotData['alunos']);
    _subscribeId = snapshotData['subscribeId'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _servicos = getStructList(
      snapshotData['servicos'],
      MHVitrineStruct.fromMap,
    );
    _horarioAtendimento = snapshotData['horarioAtendimento'] is HorarioStruct
        ? snapshotData['horarioAtendimento']
        : HorarioStruct.maybeFromMap(snapshotData['horarioAtendimento']);
    _stripeAtivo = snapshotData['stripeAtivo'] as bool?;
    _stripeAccountId = snapshotData['stripeAccountId'] as String?;
    _avaliacoesPersonal = getStructList(
      snapshotData['avaliacoesPersonal'],
      AvaliacaesPersonalStruct.fromMap,
    );
    _agendamento = getStructList(
      snapshotData['agendamento'],
      AgendamentoMHStruct.fromMap,
    );
    _codigodospersonaisagendado =
        getDataList(snapshotData['codigodospersonaisagendado']);
    _especializacao = getDataList(snapshotData['especializacao']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(
          snapshot.data() is Map<String, dynamic>
              ? snapshot.data() as Map<String, dynamic>
              : <String, dynamic>{},
        ),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? title,
  String? birthday,
  bool? professorAccount,
  int? codigoPersonal,
  DocumentReference? personalAccount,
  String? nameDoSeuPersonal,
  String? genero,
  DateTime? diaDoTermino,
  bool? admin,
  bool? acessoSuspenso,
  String? tipoDeGerenciamento,
  bool? assinatura,
  double? valorPago,
  bool? planoChatGPT,
  String? cpfCnpj,
  String? customer,
  String? tipoDeAssinatura,
  bool? recomendacaoChatGPT,
  DocumentReference? createTreinosRef,
  String? objetivoNoApp,
  String? expericencia,
  String? equipamento,
  String? tempoPorSessao,
  String? horario,
  String? diasDeTreino,
  String? limitacao,
  String? peso,
  String? altura,
  String? nivelDeAtividade,
  DateTime? alunoDesde,
  String? metodoDePagamento,
  String? chavePixDoPersonal,
  DateTime? desde,
  String? password,
  double? satisfacaocomoapp,
  String? subscribeId,
  LatLng? location,
  HorarioStruct? horarioAtendimento,
  bool? stripeAtivo,
  String? stripeAccountId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'title': title,
      'birthday': birthday,
      'professorAccount': professorAccount,
      'codigoPersonal': codigoPersonal,
      'personalAccount': personalAccount,
      'nameDoSeuPersonal': nameDoSeuPersonal,
      'genero': genero,
      'diaDoTermino': diaDoTermino,
      'admin': admin,
      'acessoSuspenso': acessoSuspenso,
      'tipoDeGerenciamento': tipoDeGerenciamento,
      'assinatura': assinatura,
      'valorPago': valorPago,
      'planoChatGPT': planoChatGPT,
      'cpfCnpj': cpfCnpj,
      'customer': customer,
      'tipoDeAssinatura': tipoDeAssinatura,
      'recomendacaoChatGPT': recomendacaoChatGPT,
      'createTreinosRef': createTreinosRef,
      'objetivoNoApp': objetivoNoApp,
      'expericencia': expericencia,
      'equipamento': equipamento,
      'tempoPorSessao': tempoPorSessao,
      'horario': horario,
      'diasDeTreino': diasDeTreino,
      'limitacao': limitacao,
      'peso': peso,
      'altura': altura,
      'nivelDeAtividade': nivelDeAtividade,
      'alunoDesde': alunoDesde,
      'metodoDePagamento': metodoDePagamento,
      'chavePixDoPersonal': chavePixDoPersonal,
      'desde': desde,
      'password': password,
      'satisfacaocomoapp': satisfacaocomoapp,
      'subscribeId': subscribeId,
      'location': location,
      'horarioAtendimento': HorarioStruct().toMap(),
      'stripeAtivo': stripeAtivo,
      'stripeAccountId': stripeAccountId,
    }.withoutNulls,
  );

  // Handle nested data for "horarioAtendimento" field.
  addHorarioStructData(firestoreData, horarioAtendimento, 'horarioAtendimento');

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.title == e2?.title &&
        e1?.birthday == e2?.birthday &&
        e1?.professorAccount == e2?.professorAccount &&
        e1?.codigoPersonal == e2?.codigoPersonal &&
        e1?.personalAccount == e2?.personalAccount &&
        listEquality.equals(e1?.userInList, e2?.userInList) &&
        listEquality.equals(
            e1?.rotinaDeTreinosInList, e2?.rotinaDeTreinosInList) &&
        e1?.nameDoSeuPersonal == e2?.nameDoSeuPersonal &&
        e1?.genero == e2?.genero &&
        listEquality.equals(e1?.treinos, e2?.treinos) &&
        e1?.diaDoTermino == e2?.diaDoTermino &&
        e1?.admin == e2?.admin &&
        e1?.acessoSuspenso == e2?.acessoSuspenso &&
        e1?.tipoDeGerenciamento == e2?.tipoDeGerenciamento &&
        e1?.assinatura == e2?.assinatura &&
        e1?.valorPago == e2?.valorPago &&
        e1?.planoChatGPT == e2?.planoChatGPT &&
        e1?.cpfCnpj == e2?.cpfCnpj &&
        e1?.customer == e2?.customer &&
        e1?.tipoDeAssinatura == e2?.tipoDeAssinatura &&
        listEquality.equals(e1?.rotinaDeTreino, e2?.rotinaDeTreino) &&
        e1?.recomendacaoChatGPT == e2?.recomendacaoChatGPT &&
        e1?.createTreinosRef == e2?.createTreinosRef &&
        e1?.objetivoNoApp == e2?.objetivoNoApp &&
        e1?.expericencia == e2?.expericencia &&
        e1?.equipamento == e2?.equipamento &&
        e1?.tempoPorSessao == e2?.tempoPorSessao &&
        e1?.horario == e2?.horario &&
        e1?.diasDeTreino == e2?.diasDeTreino &&
        e1?.limitacao == e2?.limitacao &&
        e1?.peso == e2?.peso &&
        e1?.altura == e2?.altura &&
        e1?.nivelDeAtividade == e2?.nivelDeAtividade &&
        e1?.alunoDesde == e2?.alunoDesde &&
        e1?.metodoDePagamento == e2?.metodoDePagamento &&
        e1?.chavePixDoPersonal == e2?.chavePixDoPersonal &&
        e1?.desde == e2?.desde &&
        e1?.password == e2?.password &&
        e1?.satisfacaocomoapp == e2?.satisfacaocomoapp &&
        listEquality.equals(e1?.suprallicas, e2?.suprallicas) &&
        listEquality.equals(e1?.subescapilar, e2?.subescapilar) &&
        listEquality.equals(e1?.alunos, e2?.alunos) &&
        e1?.subscribeId == e2?.subscribeId &&
        e1?.location == e2?.location &&
        listEquality.equals(e1?.servicos, e2?.servicos) &&
        e1?.horarioAtendimento == e2?.horarioAtendimento &&
        e1?.stripeAtivo == e2?.stripeAtivo &&
        e1?.stripeAccountId == e2?.stripeAccountId &&
        listEquality.equals(e1?.avaliacoesPersonal, e2?.avaliacoesPersonal) &&
        listEquality.equals(e1?.agendamento, e2?.agendamento) &&
        listEquality.equals(
            e1?.codigodospersonaisagendado, e2?.codigodospersonaisagendado) &&
        listEquality.equals(e1?.especializacao, e2?.especializacao);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.title,
        e?.birthday,
        e?.professorAccount,
        e?.codigoPersonal,
        e?.personalAccount,
        e?.userInList,
        e?.rotinaDeTreinosInList,
        e?.nameDoSeuPersonal,
        e?.genero,
        e?.treinos,
        e?.diaDoTermino,
        e?.admin,
        e?.acessoSuspenso,
        e?.tipoDeGerenciamento,
        e?.assinatura,
        e?.valorPago,
        e?.planoChatGPT,
        e?.cpfCnpj,
        e?.customer,
        e?.tipoDeAssinatura,
        e?.rotinaDeTreino,
        e?.recomendacaoChatGPT,
        e?.createTreinosRef,
        e?.objetivoNoApp,
        e?.expericencia,
        e?.equipamento,
        e?.tempoPorSessao,
        e?.horario,
        e?.diasDeTreino,
        e?.limitacao,
        e?.peso,
        e?.altura,
        e?.nivelDeAtividade,
        e?.alunoDesde,
        e?.metodoDePagamento,
        e?.chavePixDoPersonal,
        e?.desde,
        e?.password,
        e?.satisfacaocomoapp,
        e?.suprallicas,
        e?.subescapilar,
        e?.alunos,
        e?.subscribeId,
        e?.location,
        e?.servicos,
        e?.horarioAtendimento,
        e?.stripeAtivo,
        e?.stripeAccountId,
        e?.avaliacoesPersonal,
        e?.agendamento,
        e?.codigodospersonaisagendado,
        e?.especializacao
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
