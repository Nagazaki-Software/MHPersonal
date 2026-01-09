import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime getFirstOfMonth() {
  // returns the first of the month
  return DateTime(DateTime.now().year, DateTime.now().month, 1);
}

double returnDoubleBased(String observacao) {
  // return double based on how many strings this observacao has
  int count = observacao.split(' ').length;
  if (count <= 5) {
    return 1.0;
  } else if (count <= 10) {
    return 2.0;
  } else {
    return 3.0;
  }
}

String? abrirWhatsapp(String? number) {
  if (number != null) {
    final String phoneNumber = number;
    final String url = 'https://api.whatsapp.com/send?phone=55$phoneNumber';
    return url;
  }
}

dynamic convertToJSONCopy(String prompt) {
  // take the prompt and return a JSON with form [{"role": "user", "content": prompt}]
  return json.decode('{"role": "user", "content": "$prompt"}');
}

dynamic formatMessages(List<MessageStruct> messages) {
  // Initialize a list to hold the formatted messages
  List<Map<String, dynamic>> formattedMessages = [];

  // Add the rest of the messages to the list, mapping 'author' to 'role' field and 'message' to 'content' field
  formattedMessages.addAll(messages.map((message) {
    return {
      'role': message.role,
      'parts': [
        {
          'text': message.text,
        }
      ],
    };
  }).toList());

  return formattedMessages;
}

String allFormat(String text) {
  // format texts unpointed
  // Split the text into sentences
  List<String> sentences = text.split('. ');

  // Capitalize the first letter of each sentence
  List<String> formattedSentences = sentences.map((sentence) {
    if (sentence.isNotEmpty) {
      return sentence[0].toUpperCase() + sentence.substring(1);
    } else {
      return sentence;
    }
  }).toList();

  // Join the sentences back together with a space
  String formattedText = formattedSentences.join('. ');

  return formattedText;
}

double? countStrings(String? strings) {
  // count strings return double
  if (strings != null) {
    // Split the input string into individual words
    List<String> words = strings.split(' ');

    // Count the number of words in the input string
    int count = words.length;

    // Return a double value based on the number of words
    if (count <= 15) {
      return 60;
    } else if (count <= 30) {
      return 130;
    } else if (count <= 50) {
      return 190;
    } else if (count <= 70) {
      return 280;
    } else if (count <= 90) {
      return 380;
    } else if (count <= 120) {
      return 480;
    } else if (count <= 150) {
      return 560;
    } else if (count <= 180) {
      return 650;
    } else if (count <= 200) {
      return 750;
    } else if (count <= 230) {
      return 800;
    }
  }

  return null;
}

dynamic saveChatHistory(
  dynamic chatHistory,
  dynamic newChat,
) {
  // If chatHistory isn't a list, make it a list and then add newChat
  if (chatHistory is List) {
    chatHistory.add(newChat);
    return chatHistory;
  } else {
    return [newChat];
  }
}

dynamic convertToJSON(String prompt) {
  // converta prompt em json
  try {
    dynamic json = jsonDecode(prompt);
    return json;
  } catch (e) {
    print('Error converting to JSON: $e');
    return null;
  }
}

DateTime date() {
  // return before monthy in date time
  return DateTime.now().add(Duration(days: 90));
}

List<String> treinosForEmagrecimento(double resposta) {
  // se resposta for igual a 1 return list
  if (resposta == 1) {
    return [
      'Supino reto articulado',
      'Supino Inclinado com barra (comum)',
      'Crucifixo (Em pé no crossover) (Polia alta)',
      'Rosca direta na polia baixa (Barra W)',
      'Rosca 45° (banco inclinado) (Unilateral)',
      'Encolhimento de ombros pela frente (Com Halteres)',
    ];
  } else if (resposta == 2) {
    return [
      'Supino reto com barra',
      'Supino inclinado com halteres',
      'Remada unilateral com halter',
      'Rosca direta com barra',
      'Leg press 45',
      'Rosca martelo alternado',
    ];
  } else if (resposta == 3) {
    return [
      'Barra fixa (Pegada neutra)',
      'Desenvolvimento (com Halteress) (Unilateral) (Em pé) (Pegada pronada)',
      'Remada unilateral com halter',
      'Tríceps mergulho (Nas paralelas)',
      'Leg press 45',
      'Rosca martelo alternado',
    ];
  } else {
    return [];
  }
}

String jsonToString(dynamic json) {
  // convert json to string
  return jsonEncode(json);
}

DateTime? diaDoVenciamentoCopy(int diaDoVencimento) {
  // retorne o proximo vencimento
  DateTime now = DateTime.now();
  int currentDay = now.day;
  int currentMonth = now.month;
  int currentYear = now.year;

  if (currentDay < diaDoVencimento) {
    return DateTime(currentYear, currentMonth, diaDoVencimento);
  } else {
    if (currentMonth == 12) {
      return DateTime(currentYear + 1, 1, diaDoVencimento);
    } else {
      return DateTime(currentYear, currentMonth + 1, diaDoVencimento);
    }
  }
}

double formulaGuedes1994TresDobras(
  double? dobraTricipital,
  double? dobraSuprallica,
  double? dobraSubescapilar,
  String homemOuMulher,
  double? dobraCoxa,
  double? dobraAbdominal,
) {
  // Verifica se algum valor é nulo e atribui 0
  dobraTricipital ??= 0;
  dobraSuprallica ??= 0;
  dobraSubescapilar ??= 0;
  dobraCoxa ??= 0;
  dobraAbdominal ??= 0;

  // Calculando a soma das dobras cutâneas
  final somaDobrasHomem = dobraTricipital + dobraSuprallica + dobraAbdominal;
  final somaDobrasMulher = dobraCoxa + dobraSuprallica + dobraSubescapilar;

  // Fórmula para densidade corporal para homens
  final densidadeHomem = 1.17136 - 0.06706 * math.log(somaDobrasHomem);

  // Fórmula para densidade corporal para mulheres
  final densidadeMulher = 1.16650 - 0.07063 * math.log(somaDobrasMulher);

  // Cálculo do percentual de gordura com base na densidade
  if (homemOuMulher == "Masculino") {
    // Fórmula para calcular o percentual de gordura em homens
    return ((4.95 / densidadeHomem) - 4.50) * 100;
  } else if (homemOuMulher == "Feminino") {
    // Fórmula para calcular o percentual de gordura em mulheres
    return ((4.95 / densidadeMulher) - 4.50) * 100;
  } else {
    throw ArgumentError(
        "O parâmetro 'Gênero' deve ser 'Masculino' ou 'Feminino'");
  }
}

bool reloadAssistente() {
  // apos 2 dias retorne false
  DateTime now = DateTime.now();
  DateTime twoDaysLater = now.add(Duration(days: 2));
  if (now.isAfter(twoDaysLater)) {
    return false;
  } else {
    return true;
  }
}

double massaMagraMassaGorda(
  bool homemOuMulher,
  double pesoTotal,
  double porcentualDeGordura,
) {
  // Calculando a Massa Gorda
  double massaGorda = pesoTotal * (porcentualDeGordura / 100);

  // Calculando a Massa Magra
  double massaMagra = pesoTotal - massaGorda;

  // Retornando a massa magra e a massa gorda (como exemplo, retornaremos a massa magra)
  return massaMagra; // Retorna a massa magra, mas você pode ajustar para retornar a massa gorda ou ambos
}

List<double> formulaFalker1968quatrodobras(
  double dobraTricipital,
  double dobraSuprallica,
  double dobraAbdominal,
  double dobraCoxa,
  double? pesoCorporal,
) {
  final lista = <double>[];

  // Calculando a soma das dobras
  final somaDobras =
      dobraTricipital + dobraSuprallica + dobraAbdominal + dobraCoxa;

  // Fórmula para calcular a gordura corporal para homens (Falker 1968)
  final gordura = somaDobras * 0.153 + 5.783;

  // Cálculo da massa de gordura (fat mass)
  final pesoGordo = gordura * pesoCorporal! / 100;

  // Cálculo da massa magra (lean body mass)
  final massaMagra = pesoCorporal - pesoGordo;

  // Adicionando os resultados na lista
  lista.add(gordura); // Percentual de gordura
  lista.add(pesoGordo); // Massa de gordura (kg)
  lista.add(massaMagra); // Massa magra (kg)

  return lista;
}

List<String> convertListInString(List<String> treinos) {
  List<String> result = [];

  // Verifica cada item da lista de treinos
  for (int i = 0; i < treinos.length; i++) {
    result.add(
        treinos[i]); // Adiciona os itens diferentes de 'treino' na lista result
  }

  return result; // Retorna a lista de treinos diferentes
}

double fomulasPollock1968(
  double dobraTriceps,
  double dobraSuprallica,
  double dobraAbdominal,
  double dobraSubescapular,
  bool homemOuMulher,
) {
  // Calculando a soma das dobras
  final somaDobras =
      dobraTriceps + dobraSuprallica + dobraAbdominal + dobraSubescapular;

  // Fórmula para homens (Pollock 1968)
  final gorduraHomem =
      0.29288 * somaDobras - 0.0005 * (somaDobras * somaDobras) + 0.15845;

  // Fórmula para mulheres (Pollock 1968)
  final gorduraMulher =
      0.29669 * somaDobras - 0.00043 * (somaDobras * somaDobras) + 0.02963;

  // Verificando o sexo e retornando o valor apropriado
  if (homemOuMulher) {
    return gorduraHomem; // Retorna o cálculo para homens
  } else {
    return gorduraMulher; // Retorna o cálculo para mulheres
  }
}

int contarList(List<String> treinoList) {
  // conte quantas strings tem em treinoList
  return treinoList.length;
}

List<String> checkSeTreinosEIgualATreino(
  List<String> treinos,
  String treino,
) {
  // verifique se treino existe em treinos se existir retorne treinos sem o treino
  if (treinos.contains(treino)) {
    treinos.remove(treino);
  }
  return treinos;
}

int existemMes(
  DocumentReference users,
  DateTime dataDeCriacaoDaconta,
) {
  // verifique quantos usuarios criaram conta este mes e retorne
  int count = 0;
  users.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        DateTime creationDate = DateTime.parse(value['creationDate']);
        if (creationDate.month == dataDeCriacaoDaconta.month &&
            creationDate.year == dataDeCriacaoDaconta.year) {
          count++;
        }
      });
    }
  });
  return count;
}

double crescimentoEsseMes(int usuarios) {
  // porcentagem de usuario esse mes current date time
  // Get current date and time
  DateTime now = DateTime.now();

  // Get the current month
  int currentMonth = now.month;

  // Assuming the number of users is constant throughout the month
  // Calculate the percentage of users for the current month
  double percentage = (usuarios / currentMonth) * 100;

  return percentage;
}

double? porcentagemMesPassado(List<double>? calculo) {
  // calcule as ultimas duas listas
  if (calculo == null || calculo.length < 2) {
    return null;
  }

  double total = calculo.fold(0, (prev, element) => prev + element);
  double mesPassado = calculo[calculo.length - 1];
  double mesAnterior = calculo[calculo.length - 2];

  double porcentagem = ((mesPassado - mesAnterior) / mesAnterior) * 100;

  return porcentagem;
}

double? mediaDeCarga(List<SeriesRepeticoesRecord> seriesRep) {
  // busque a lista cargasList em seriesRep e faça a media de todos e retorne-o
  if (seriesRep.isEmpty) {
    return null;
  }

  double totalCarga = 0;
  int totalCargas = 0;

  for (var series in seriesRep) {
    for (var carga in series.cargasList) {
      totalCarga += carga as double;
      totalCargas++;
    }
  }

  if (totalCargas == 0) {
    return null;
  }

  return totalCarga / totalCargas;
}

double? quantosFaltamAte(
  double peso,
  double proposta,
) {
  // calcule quantos peso faltam até a proposta
  return proposta - peso;
}

int? mediadeKg(List<int>? cargas) {
  // faça uma média de cargas
  if (cargas == null || cargas.isEmpty) {
    return null;
  }

  int sum = 0;
  for (int carga in cargas) {
    sum += carga;
  }

  return sum ~/ cargas.length;
}

double formulaPetrovisk1995(
  double? dobraTricipital,
  double? dobraSuprallica,
  double? dobraSubescapilar,
  String homemOuMulher,
  double dobraPanturrilhaMedial,
  int? idade,
  double? estatura,
  double? massaCorporal,
) {
  // Verifica se algum valor é nulo e atribui 0
  dobraTricipital ??= 0;
  dobraSuprallica ??= 0;
  dobraSubescapilar ??= 0;
  idade ??= 0;
  estatura ??= 0;
  massaCorporal ??= 0;

  // Calculando a soma das dobras
  final somaDasDobras = dobraTricipital +
      dobraSuprallica +
      dobraSubescapilar +
      dobraPanturrilhaMedial;

  // Fórmula para densidade corporal para homens
  final homensAdultos = 1.10726863 -
      ((0.00081201 * somaDasDobras) + 0.00000212 * (somaDasDobras * 2)) -
      (0.00041761 * idade);

  // Fórmula para densidade corporal para mulheres
  final mulheresAdultas = 1.003465850 -
      (0.00063129 * somaDasDobras) +
      0.00000187 * (somaDasDobras * 2) -
      0.00031165 * (idade) * 0.048890 * (massaCorporal) +
      (0.0051345 * estatura);

  // Cálculo do percentual de gordura com base na densidade
  if (homemOuMulher == "Masculino") {
    // Fórmula para calcular o percentual de gordura em homens
    return ((4.95 / homensAdultos) - 4.50) * 100;
  } else if (homemOuMulher == "Feminino") {
    // Fórmula para calcular o percentual de gordura em mulheres
    return ((4.95 / mulheresAdultas) - 4.50) * 100;
  } else {
    throw ArgumentError(
        "O parâmetro 'Gênero' deve ser 'Masculino' ou 'Feminino'");
  }
}

int? somatoriaDeValores(List<int>? cargas) {
  // faça a somatoria de todos os inteiros
  if (cargas == null || cargas.isEmpty) {
    return null;
  }

  int sum = 0;
  for (int carga in cargas) {
    sum += carga;
  }

  return sum;
}

double formula7DobrasSubcutanea(
  double? dobraTricipital,
  double? dobraSuprallica,
  double? dobraSubescapilar,
  String homemOuMulher,
  double? dobraCoxa,
  double? dobraAbdominal,
  double? dobraPeitoral,
  double dobraAxilarMedia,
  int? idade,
) {
// Verifica se algum valor é nulo e atribui 0
  dobraTricipital ??= 0;
  dobraSuprallica ??= 0;
  dobraSubescapilar ??= 0;
  dobraCoxa ??= 0;
  dobraAbdominal ??= 0;
  dobraPeitoral ??= 0;
  idade ??= 0;

  // Calculando a soma das dobras
  final somaDasDobras = dobraTricipital +
      dobraSuprallica +
      dobraSubescapilar +
      dobraCoxa +
      dobraAbdominal +
      dobraPeitoral +
      dobraAxilarMedia;

  // Fórmula para densidade corporal para homens
  final homensAdultos = 1.112 -
      ((0.00043499 * somaDasDobras) + 0.00000055 * (somaDasDobras * 2)) -
      (0.00028826 * idade);

  // Fórmula para densidade corporal para mulheres
  final mulheresAdultas = 1.0970 -
      ((0.00046971 * somaDasDobras) + 0.00000056 * (somaDasDobras * 2)) -
      (0.00012828 * idade);

  // Cálculo do percentual de gordura com base na densidade
  if (homemOuMulher == "Masculino") {
    // Fórmula para calcular o percentual de gordura em homens
    return (((4.95 / homensAdultos) - 4.50) * 100) * 0.90;
  } else if (homemOuMulher == "Feminino") {
    // Fórmula para calcular o percentual de gordura em mulheres
    return ((4.95 / mulheresAdultas) - 4.50) * 100 * 0.85;
  } else {
    throw ArgumentError(
        "O parâmetro 'Gênero' deve ser 'Masculino' ou 'Feminino'");
  }
}

List<String> diaDoMES() {
  // retorne os dias dos meses
  List<String> diasDoMes = [];
  for (int i = 1; i <= 31; i++) {
    diasDoMes.add(i.toString());
  }
  return diasDoMes;
}

int formateStringToInt(String text) {
  // formate text em integer
  try {
    return int.parse(text);
  } catch (e) {
    return 0;
  }
}

List<DateTime>? diaDoVenciamento(
  int diaDoVencimento,
  int repetir,
) {
  // Todo mês, começando no mes atual retorne baseado em repetir o diaDoVencimento com o date time
  List<DateTime> dates = [];
  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;

  for (int i = 0; i < repetir; i++) {
    int month = currentMonth + i;
    int year = currentYear;

    if (month > 12) {
      month = month % 12;
      year++;
    }

    DateTime date = DateTime(year, month, diaDoVencimento);
    dates.add(date);
  }

  return dates;
}

String verifiqueSeHTTP(List<String>? imgForHttps) {
  // Verifique se imgForHttps não é nulo
  if (imgForHttps != null) {
    // Defina as extensões válidas de imagem
    List<String> validExtensions = ['.jpg', '.png'];

    for (String img in imgForHttps) {
      // Verifique se a URL começa com https e termina com uma das extensões válidas
      if (img.startsWith('https') &&
          validExtensions.any((ext) => img.toLowerCase().endsWith(ext))) {
        return img;
      }
    }

    // Caso não encontre nenhuma URL com https e extensão válida, verifique URLs com http
    return imgForHttps.firstWhere(
      (img) =>
          img.startsWith('http') &&
          validExtensions.any((ext) => img.toLowerCase().endsWith(ext)),
      orElse: () => '',
    );
  }
  return '';
}

List<String> formatStringEmList(String single) {
  // Formate para tudo depois da virgula em list e retire caracteres como ([]) no final de cada se houver
  List<String> formattedList = single.split(',').map((item) {
    String formattedItem = item.trim();
    if (formattedItem.endsWith(']')) {
      formattedItem = formattedItem.substring(0, formattedItem.length - 1);
    }
    if (formattedItem.startsWith('[')) {
      formattedItem = formattedItem.substring(1);
    }
    return formattedItem;
  }).toList();

  return formattedList;
}

String formatelistaparasingle(List<String> lista) {
  // formate a lista para solo
  return lista.join(', ');
}

List<TreinorsRecord> verifiquesestrinretorndoc(
  List<String> treinos,
  List<TreinorsRecord> treinorsMapTreinosNoLIst,
) {
  if (treinos.length == treinorsMapTreinosNoLIst.length) {
    return treinorsMapTreinosNoLIst;
  } else {
    return [];
  }
}

bool isTrainingPrompt(String prompt) {
  // Lista de pedidos de treino
  List<String> trainingOrders = [
    'Treino para emagrecer',
    'Treino para ganhar músculo',
    'Treino para engordar',
    'Treino para engordar 2x por semana',
    'Treino para ficar saudável',
    'Treino para hipertrofia',
    'Treino para resistência muscular',
    'Treino para aumentar a força no peito',
    'Treino para pernas e glúteos',
    'Treino para definição muscular',
    'Treino para aumentar a massa muscular',
    'Treino para condicionamento físico',
    'Treino para força no levantamento terra',
    'Treino para aumentar o volume do peito',
    'Treino para treinar costas e bíceps',
    'Treino para aumentar o tamanho do bíceps',
    'Treino para treinar tríceps',
    'Treino para emagrecimento rápido',
    'Treino para ganho de força',
    'Treino funcional para emagrecimento',
    'Treino para iniciantes',
    'Treino para avançados',
    'Treino para melhorar a flexibilidade',
    'Treino para melhorar o condicionamento',
    'Treino para tonificação muscular',
    'Treino para redução de gordura abdominal',
    'Treino para resistência cardiovascular',
    'Treino para força no agachamento',
    'Treino para força no supino',
    'Treino para aumentar a força nos ombros',
    'Treino para fortalecimento do core',
    'Treino de alta intensidade para emagrecimento',
    'Treino de musculação para glúteos',
    'Treino de musculação para coxas',
    'Treino para aumentar a resistência no cardio',
    'Treino para aumentar a resistência no treino de musculação',
    'Treino de musculação para o corpo todo',
    'Treino para melhorar a postura',
    'Treino de musculação para o corpo superior',
    'Treino de musculação para o corpo inferior',
    'Treino para ganhar força no tríceps',
    'Treino para melhorar a resistência muscular',
    'Treino para emagrecimento focado em cardio',
    'Treino para fortalecer a parte superior das costas',
    'Treino de flexões e abdominais',
    'Treino para melhorar a coordenação motora',
    'Treino para hipertrofia nas pernas',
    'Treino para ganho de massa muscular no quadríceps',
    'Treino para definição nas coxas',
    'Treino para definição no abdômen',
    'Treino para definir o corpo todo',
    'Treino para força no levantamento olímpico',
    'Treino para resistência muscular nas pernas',
    'Treino para resistência no cardio',
    'Treino para resistência e força no peito',
    'Treino para fortalecer os ombros',
    'Treino para aumentar a flexibilidade das pernas',
    'Treino para força no agachamento com barra',
    'Treino para perda de gordura e definição',
    'Treino para aumentar a força no cardio',
    'Treino para emagrecimento com HIIT',
    'Treino para aumento de massa muscular no peito',
    'Treino para resistência nos glúteos',
    'Treino para hipertrofia de tríceps',
    'Treino para hipertrofia de bíceps',
    'Treino para hipertrofia no core',
    'Treino de resistência para as costas',
    'Treino para ganhar força no supino reto',
    'Treino para emagrecer com foco em pernas',
    'Treino para fortalecer a parte inferior do corpo',
    'Treino para definição de glúteos',
    'Treino para definição de abdômen',
    'Treino para aumentar o volume muscular',
    'Treino para tonificar os músculos',
    'Treino de musculação para iniciantes',
    'Treino de musculação para intermediários',
    'Treino para tonificação dos músculos',
    'Treino para ganho de força no core',
    'Treino para emagrecer com foco no cardio',
    'Treino para resistência de força no peito',
    'Treino para hipertrofia no peito',
    'Treino para melhorar a performance no levantamento de peso',
    'Treino para aumentar a resistência no supino',
    'Treino para ganhar massa muscular nas pernas',
    'Treino para tonificação das coxas',
    'Treino para emagrecimento com musculação',
    'Treino para aumento de massa muscular nas costas',
    'Treino para definição muscular nas pernas',
    'Treino para força nos ombros com pesos',
    'Treino para hipertrofia nas coxas',
    'Treino para resistência muscular nos ombros',
    'Treino para resistência e força nas pernas',
    'Treino para emagrecimento com foco nas coxas',
    'Treino de musculação para a região central do corpo',
    'Treino para emagrecer com foco nas costas',
    'Treino para ganhar força nos quadris',
    'Treino para emagrecer com foco no treino de força',
    'Treino para resistência e força nas coxas',
    'Treino para força nas costas e bíceps',
    'Treino para hipertrofia nas pernas e glúteos',
    'Treino para definição muscular nas costas',
    'Treino para tonificação e resistência nas pernas',
    'Treino para hipertrofia do core',
    'Treino para fortalecimento de quadríceps',
    'Treino para hipertrofia de glúteos e coxas',
    'Treino para emagrecer com caminhada',
    'Treino para ganhar resistência nas pernas',
    'Treino para fortalecimento de costas',
    'Treino para ganhar massa muscular com flexões',
    'Treino para tonificação de abdômen',
    'Treino para emagrecimento com corrida',
    'Treino para aumentar a resistência muscular com pesos',
    'Treino para hipertrofia de peito e tríceps',
    'Treino para aumentar a força no cardio com pesos',
    'Treino para aumento de massa muscular com agachamento',
    'Treino para resistência muscular em glúteos',
    'Treino para hipertrofia nos bíceps e costas',
    'Treino para resistência e definição muscular no peito',
    'Treino para resistência e força nos ombros',
    'Treino para aumento de massa muscular com treinamento funcional',
    'Treino para resistência muscular nas costas',
    'Treino para tonificação dos braços',
    'Treino para aumentar a flexibilidade nas pernas',
    'Treino para fortalecimento muscular com pesos',
    'Treino para emagrecimento com corrida e musculação',
    'Treino para resistência muscular nos ombros',
    'Treino para tonificação e resistência no peito',
    'Treino para emagrecimento com HIIT e musculação',
    'Treino para resistência e força nas coxas e glúteos',
    'Treino para hipertrofia e resistência nos ombros',
    'Treino para fortalecimento do quadril',
    'Treino para tonificação dos músculos das costas',
    'Treino para resistência muscular nas pernas e glúteos',
    'Treino para emagrecimento com musculação focado nas coxas',
    'Treino para hipertrofia de músculos abdominais',
    'Treino para ganho de força no levantamento de peso',
    'Treino para aumentar a resistência no supino',
    'Treino para emagrecimento com foco no core',
    'Treino para hipertrofia no quadríceps',
    'Treino para emagrecimento com HIIT para as pernas',
    'Treino para tonificação dos músculos das coxas',
    'Treino para aumento de força e resistência no cardio',
    'Treino para emagrecimento com treino funcional',
    'Treino para hipertrofia no supino com barra',
    'Treino para resistência muscular com kettlebells',
    'Treino para ganho de resistência nas coxas',
    'Treino para emagrecimento com treino intervalado',
    'Treino para hipertrofia nas pernas com pesos',
    'Treino para definição muscular nos braços',
    'Treino para resistência nos tríceps',
    'Treino para tonificação e resistência abdominal',
    'Treino para aumento de massa muscular com agachamentos',
    'Treino para tonificação muscular com circuitos',
    'Treino para emagrecimento com foco no treino de força',
    'Treino para resistência e definição no quadril',
    'Treino para aumento de massa muscular no peito',
    'Treino para hipertrofia nas costas e ombros',
    'Treino para resistência e força com flexões',
    'Treino para hipertrofia de peitoral',
    'Treino para emagrecer com caminhada e abdominais',
    'Treino para resistência muscular com pesos e kettlebells',
    'Treino para tonificação dos músculos abdominais',
    'Treino para resistência nos ombros com pesos',
    'Treino para hipertrofia nas pernas com halteres',
    'Treino para emagrecimento com HIIT para resistência',
    'Treino para resistência muscular nas pernas e quadríceps',
    'Treino para hipertrofia abdominal e glúteos',
    'Treino para emagrecimento com treino de musculação funcional',
    'Treino para aumento de resistência no treinamento de força',
    'Treino para resistência e tonificação de quadríceps',
    'Treino para tonificação e resistência abdominal com treino funcional',
    'Treino para hipertrofia de músculos glúteos',
    'Treino para emagrecimento com treino de força total',
    'Treino para resistência e definição do core',
    'Treino para hipertrofia nas pernas e abdômen',
    'Treino para tonificação e aumento de força no abdômen',
    'Treino para emagrecimento com corrida e musculação',
    'Treino para resistência muscular com treino funcional',
    'Treino para aumento de resistência nas coxas',
    'Treino para hipertrofia de peito e costas',
    'Treino para emagrecimento com treino de força'
  ];

  // Converte a entrada para minúsculas
  String lowerPrompt = prompt.toLowerCase();

  // Verifica se a entrada é um pedido da lista, ignorando maiúsculas/minúsculas
  return trainingOrders.any((order) => order.toLowerCase() == lowerPrompt);
}

List<TreinorsRecord> verifiquesestrinretorndocCopy(
  List<String> treinos,
  List<TreinorsRecord> treinorsMapTreinosNoLIst,
) {
  if (treinos.length == treinorsMapTreinosNoLIst.length) {
    return treinorsMapTreinosNoLIst;
  } else {
    return [];
  }
}

dynamic formatStringToJson(String treino) {
  // formate treino para json, exclua tudo que não seja em json, ou tudo antes e depois do {}
  // Find the start and end index of the JSON object
  int startIndex = treino.indexOf('{');
  int endIndex = treino.lastIndexOf('}');

  // Extract the JSON object from the string
  String jsonStr = treino.substring(startIndex, endIndex + 1);

  // Parse the JSON string to a dynamic object
  dynamic jsonData = json.decode(jsonStr);

  return jsonData;
}

String convertaStringEmImg(String? url) {
  // Formate url em imagePath
  if (url == null || url.isEmpty) {
    return '';
  }

  if (url.startsWith('http') || url.startsWith('https')) {
    return url;
  } else {
    return 'https://example.com/$url';
  }
}

List<String> adicioneMaisNaLista(
  String? add,
  String? add1,
  String? add2,
  String? add3,
  String? add4,
  String? add5,
  String? add6,
  String? add7,
) {
  // adicione mais na lista
  List<String> lista = [];

  if (add != null) {
    lista.add(add);
  }
  if (add1 != null) {
    lista.add(add1);
  }
  if (add2 != null) {
    lista.add(add2);
  }
  if (add3 != null) {
    lista.add(add3);
  }
  if (add4 != null) {
    lista.add(add4);
  }
  if (add5 != null) {
    lista.add(add5);
  }
  if (add6 != null) {
    lista.add(add6);
  }
  if (add7 != null) {
    lista.add(add7);
  }

  return lista;
}

List<String> formatlistparamodolist(List<String>? list) {
  // retire caracteres especiais
  List<String> formattedList = [];
  if (list != null) {
    for (String item in list) {
      String formattedItem = item.replaceAll(RegExp(r'[^\w\s]+'), '');
      formattedList.add(formattedItem);
    }
  }
  return formattedList;
}

bool cada4dias(DateTime diadeHoje) {
  // salve o dia de hoje e retorne true a cada 4 dias
  DateTime now = DateTime.now();
  Duration difference = diadeHoje.difference(now);
  if (difference.inDays % 4 == 0) {
    return true;
  } else {
    return false;
  }
}

int testede7dias(DateTime diaDoTeste) {
  // retorne os dias que se passaram desde o diadoteste
  DateTime now = DateTime.now();
  Duration difference = now.difference(diaDoTeste);
  int daysPassed = difference.inDays;
  return daysPassed;
}

bool verifiqueseideigualid(
  String id,
  List<String> idlist,
) {
  // verifique se id existe na idlist
  return idlist.contains(id);
}

List<String> retornetodasasstringbaseadonaqtd(String quantidade) {
  // replique com treinos 1,2,3 baseado na quantidade
  int qtd = int.parse(quantidade);
  List<String> strings = [];
  for (int i = 1; i <= qtd; i++) {
    strings.add("Treino $i");
  }
  return strings;
}

double frequenciasemanal(List<DateTime> ativityapp) {
  // verifique a frequencia media por semana
  if (ativityapp.isEmpty) {
    return 0.0;
  }
  if (ativityapp.length == 1) {
    return 1.0;
  }
  // Sort the list of activity dates
  ativityapp.sort();

  // Calculate the total number of days between the first and last activity date
  int totalDays = ativityapp.last.difference(ativityapp.first).inDays;

  // Calculate the total number of weeks
  int totalWeeks = (totalDays / 7).ceil();
  if (totalWeeks <= 0) {
    return ativityapp.length.toDouble();
  }

  // Calculate the average frequency per week
  double averageFrequency = ativityapp.length / totalWeeks;

  return averageFrequency;
}

bool cadahoramostre(DateTime currentTime) {
  // retorne true a cada 4 horas baseado no currentTime
  DateTime now = DateTime.now();
  Duration difference = now.difference(currentTime);
  if (difference.inHours % 4 == 0) {
    return true;
  } else {
    return false;
  }
}

DateTime daquiTalDias(String dias) {
  // retorne o datetime baseado no dia atual e quantos dias falta
  int diasInt = int.parse(dias);
  return DateTime.now().add(Duration(days: diasInt));
}

List<String> retireUmTreino(
  String treino,
  List<String> treinos,
) {
  // retorne o treinos list sem o treino single
// Remove the specified treino from the list if it exists
  treinos.remove(treino);
  return treinos;
}

double stringToDouble(String numberString) {
  // convert string to double
  return double.tryParse(numberString) ??
      0.0; // Convert string to double, return 0.0 if parsing fails
}

List<UsersRecord> buscarPorRegiao(
  LatLng localizacaoDoUsuario,
  double localizacaoMaxima,
  List<UsersRecord> users,
) {
  List<UsersRecord> placesList = [];
  List<double> listKm = [];
  double lat1 = localizacaoDoUsuario.latitude;
  double lon1 = localizacaoDoUsuario.longitude;
  // This iterates through the single documents "places" in the List
  for (UsersRecord produto in users) {
    if (produto.location != null) {
      double lat2 = produto.location!.latitude;
      double lon2 = produto.location!.longitude;
      // Rest of the  calculation logic remains unchanged
      // Ensure to keep the rest of the code intact
      var c = math.cos;
      var p = 0.017453292519943295;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      // This is getting us the distance
      var d = (12742 * math.asin(math.sqrt(a)));
      String inString = d.toStringAsFixed(2); // '2.35'
      double inDouble = double.parse(inString);
      listKm.add(inDouble);
      // Sort the documents that will be returned by distance
      listKm.sort();
      int listKmIndex = listKm.indexWhere((dist) => dist == inDouble);
      // Check if the document we are currently processing is no farther away from userGeo than we defined as max.
      if (inDouble <= localizacaoMaxima) {
        // If its within our radius, add it to the list of places documents that will be returned
        placesList.insert(listKmIndex, produto);
      }
    }
  }

  return placesList;
}

double apartirde(List<MHVitrineStruct> value) {
  // coloque o menor valor de dataType.valor
  if (value.isEmpty)
    return double.infinity; // Return infinity if the list is empty
  return value
      .map((v) => v.valor)
      .reduce(math.min); // Return the minimum value of valor
}

List<String> estados() {
  // estados do brasil tipo: MG, SP, RJ...
  return [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
}

List<String> routingBanks() {
  // retorne todos os routing numbers dos bancos do brasil q o stripe aceita e os nomes respectivos (001 - Banco do Brasil, 237 - Brasdeco, 260 - Nubank, etc)
  return [
    '110 - Teste',
    '001 - Banco do Brasil',
    '003 - Banco da Amazônia',
    '004 - Banco do Nordeste',
    '007 - Banco Nacional de Desenvolvimento Econômico e Social (BNDES)',
    '021 - Banco do Estado do Rio Grande do Sul',
    '022 - Banco do Estado de Santa Catarina',
    '023 - Banco do Estado de Minas Gerais',
    '024 - Banco do Estado do Paraná',
    '025 - Banco do Estado de São Paulo',
    '027 - Banco do Estado do Espírito Santo',
    '029 - Banco do Estado do Mato Grosso do Sul',
    '033 - Banco Santander',
    '036 - Banco Bradesco',
    '237 - Bradesco',
    '260 - Nubank',
    '341 - Itaú Unibanco',
    '399 - HSBC',
    '422 - Banco Safra',
    '453 - Banco Rural',
    '655 - Banco Votorantim',
    '707 - Banco Inter',
    '748 - Banco Cooperativo do Brasil (Bancoob)',
    '756 - Banco Cooperativo Sicredi',
    '765 - Banco do Brasil S.A.',
    '777 - Banco Original',
  ];
}

String deixeisomenteosnumeros(String texto) {
  // tire as letras e deixe somente numeros
  return texto.replaceAll(RegExp(r'[^0-9]'), '');
}

List<String> retorenHorariosDisponiveis(
  List<AgendamentoMHStruct> agendaemnto,
  HorarioStruct? horario,
  DateTime? diaEscolhido,
) {
  // retorne os horarios a cada 1 hora e meia baseado no diaEscolhido, nos agendamnto.dia e nas informacoes do data Type horario(inicioSegSex, terminioSegSex, inicioSab, terminioSab, inicioDom, terminioDom) todos sao date time
  if (horario == null || diaEscolhido == null) return [];

  List<String> horariosDisponiveis = [];
  DateTime inicio;
  DateTime termino;

  // Define the start and end times based on the chosen day
  if (diaEscolhido.weekday >= 1 && diaEscolhido.weekday <= 5) {
    // Monday to Friday
    inicio = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.inicioSegSex!.hour, horario.inicioSegSex!.minute);
    termino = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.terminioSegSex!.hour, horario.terminioSegSex!.minute);
  } else if (diaEscolhido.weekday == 6) {
    // Saturday
    inicio = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.inicioSab!.hour, horario.inicioSab!.minute);
    termino = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.terminioSab!.hour, horario.terminioSab!.minute);
  } else {
    // Sunday
    inicio = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.inicioDom!.hour, horario.inicioDom!.minute);
    termino = DateTime(diaEscolhido.year, diaEscolhido.month, diaEscolhido.day,
        horario.terminioDom!.hour, horario.terminioDom!.minute);
  }

  // Generate available time slots every 1.5 hours
  for (DateTime time = inicio;
      time.isBefore(termino);
      time = time.add(Duration(hours: 1, minutes: 30))) {
    // Check if the time slot is already booked
    bool isBooked = agendaemnto.any((agendamento) {
      return time.isAfter(agendamento.dia!) && time.isBefore(agendamento.dia!);
    });

    if (!isBooked) {
      horariosDisponiveis.add(DateFormat('HH:mm').format(time));
    }
  }

  return horariosDisponiveis;
}

double menorvalordasessao(List<MHVitrineStruct> service) {
  // retorne o menor valor de service.valor (double)
  if (service.isEmpty)
    return double.infinity; // Return infinity if the list is empty
  return service
      .map((s) => s.valor)
      .reduce((a, b) => a < b ? a : b); // Find the minimum value
}

double consertarValorStripe(double value) {
  // valor no stripe esta vindo 2899 e esta aparecendo R$ 28.990,00
  return value / 100; // Divide the value by 100 to correct the format
}
