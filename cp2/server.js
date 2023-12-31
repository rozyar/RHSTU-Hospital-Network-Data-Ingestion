const readline = require("readline");
const express = require("express");
const oracledb = require("oracledb");
const app = express();

const config = {
  user: "rm551832",
  password: "030703",
  connectString: "oracle.fiap.com.br:1521/orcl",
  batchErrors: true,
};

//1- Criar uma conexão com o banco de dados e executar tarefas com uma unica conexão
let pool;

async function createPool() {
  if (!pool) {
    pool = await oracledb.createPool(config);
  }
}

async function createConnection() {
  if (!pool) {
    throw new Error(
      "O pool de conexões não foi criado. Chame createPool antes de criar uma conexão."
    );
  }

  const connection = await pool.getConnection();
  return connection;
}

async function createConnectionAndExecute() {
  await createPool();
  let connection;

  try {
    connection = await createConnection();
    await insertEstado(connection);
    await insertCidade(connection);
    await insertBairro(connection);
    await insertLogradouro(connection);
    await insertPacient(1000000, batchSize, 20, connection);
  } catch (err) {
    console.erro2("Erro na execução segue o erro " + err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.log(`Erro ao fechar a conexão, segue o erro: ${err.message}}`);
      }
    }
  }
}

//2-Ferramentas para inserções de dados aleatorios

//criar nomes aleatorios
function getRandomFullName() {
  const nomesJson = require("./nomes.json");
  const names = nomesJson[0]?.nome;
  const surnames = nomesJson[0]?.sobrenome;

  const randomName = names[Math.floor(Math.random() * names.length)];
  const randomSurname = surnames[Math.floor(Math.random() * surnames.length)];

  return `${randomName} ${randomSurname}`;
}

//GERAR CPF ALEATORIO
function getRandomCPF() {
  const randomDigit = () => Math.floor(Math.random() * 10);

  // Gere os 9 primeiros dígitos do CPF
  const cpfDigits = Array.from({ length: 9 }, randomDigit);

  // Calcule o primeiro dígito verificador
  const firstVerifierDigit =
    cpfDigits.reduce((acc, digit, index) => acc + digit * (10 - index), 0) % 11;
  cpfDigits.push(firstVerifierDigit < 2 ? 0 : 11 - firstVerifierDigit);

  // Calcule o segundo dígito verificador
  const secondVerifierDigit =
    cpfDigits.reduce((acc, digit, index) => acc + digit * (11 - index), 0) % 11;
  cpfDigits.push(secondVerifierDigit < 2 ? 0 : 11 - secondVerifierDigit);

  // Converta os dígitos em uma sequência numérica (sem pontos e traços)
  const cpfNumber = parseInt(cpfDigits.join(""));

  return cpfNumber;
}

// console.log(typeof getRandomCPF())

//GERAR DATA DE NASCIMENTO ALEATORIA
function getRandomBirthDate() {
  const startYear = 1950;
  const lastYear = 2005;

  //gerar ano
  const randomYear =
    startYear + Math.floor(Math.random() * (lastYear - startYear + 1));

  //gerar mes
  const randomMonth = Math.floor(Math.random() * 12);

  //gerar dia
  const randomDay = Math.floor(Math.random() * 31) + 1;
  const birthDate = new Date(randomYear, randomMonth, randomDay);

  return birthDate;
}

//GERAR UM GENERO ALEATÓRIO
function getRandomGender() {
  const genders = ["M", "F", "I"];
  let randomGender = Math.floor(Math.random() * genders.length);

  return genders[randomGender];
}

//GERAR UM NIVEL DE ESCOLARIDADE ALEATORIA
function getRandomEducationalLevel() {
  const niveisEscolaridade = [
    "Ensino Fundamental",
    "Ensino Médio",
    "Ensino Técnico",
    "Ensino Superior",
    "Pós-Graduação",
    "Educação Online e à Distância",
    "Educação Profissional",
    "Educação de Adultos",
  ];

  let nivelEscolar = Math.floor(Math.random() * niveisEscolaridade.length);

  return niveisEscolaridade[nivelEscolar];
}

//GERAR UM ESTADO CIVIL ALEATORIO
function getRandomMaritalStatuses() {
  const estadosCivis = [
    "Solteiro(a)",
    "Casado(a)",
    "Divorciado(a)",
    "Viúvo(a)",
    "União Estável",
  ];

  let estadoCivil = Math.floor(Math.random() * estadosCivis.length);
  return estadosCivis[estadoCivil];
}

//GERAR UM GRUPO SANGUINEO ALEATORIO
function getRandomBloodType() {
  const gruposSanguineos = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  const tipoSangue = Math.floor(Math.random() * gruposSanguineos.length);
  const grupoSanguineoAleatorio = gruposSanguineos[tipoSangue];

  return grupoSanguineoAleatorio;
}

//GERA UMA ALTURA ALEATORIA
function getRandomHeight() {
  const baseHeight = 1.2;
  const maximumHeight = 2.4;

  let randomHeight = baseHeight + Math.random() * (maximumHeight - baseHeight);
  let roundedHeight = randomHeight.toFixed(2);
  let heightAsFloat = parseFloat(roundedHeight);

  return heightAsFloat;
}

//GERAR UM PESO ALEATORIO
function calculateWeight(height, imc) {
  // O IMC é calculado como peso (em quilogramas) dividido pela altura (em metros) ao quadrado.
  // Para encontrar o peso, podemos reorganizar a fórmula: peso = IMC * altura^2.
  const weight = imc * height * height;

  return weight;
}

function getRandomWeight(height) {
  const imcMedio = 25;
  const weight = calculateWeight(height, imcMedio);
  const variation = (Math.random() - 0.5) * 0.2;
  const weightWithVariation = weight * (1 + variation);
  const roundedWeight = weightWithVariation.toFixed(1);
  const weightAsFloat = parseFloat(roundedWeight);

  return weightAsFloat;
}

// console.log(typeof getRandomHeight())

//GERA UMA DATA DE CADASTRO PELO DATA DO INSERT
function getSignUpDate() {
  const today = new Date();
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, "0");
  const day = String(today.getDate()).padStart(2, "0");
  const formattedDate = `${year}-${month}-${day}`;
  return new Date(formattedDate);
}

//GERA UMA DATA ATUAL
function getCurrentDate() {
  const today = new Date();
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, "0");
  const day = String(today.getDate()).padStart(2, "0");
  return new Date(`${year}-${month}-${day}`);
}

//GERA UM USUARIO ALEATORIO
function getRandomUsername(fullName) {
  const parts = fullName.split(" ");
  const firstName = parts[0];
  const lastName = parts[1];

  // Gere um nome de usuário aleatório com base em partes do nome e sobrenome
  const randomNumbers = Math.floor(Math.random() * 100);
  const username = `${firstName}${lastName}${randomNumbers}`;

  return username;
}

//RETORNAR UM ESTADO
function getState() {
  let estadosJson = require("./enderecos/estados.json");
  const estados = estadosJson.data;
  let data = getCurrentDate().toISOString().split("T")[0];

  if (estados) {
    const todosOsEstados = estados.map((estado) => ({
      id: estado.Id,
      sigla: estado.Uf,
      nome: estado.Nome,
      dt_cadastro: data,
      nm_usuario: "rm551832",
    }));

    return todosOsEstados;
  } else {
    console.log("Dados de estados não encontrados no arquivo JSON.");
    return []; // Retorna um array vazio se os dados de estados não forem encontrados.
  }
}


//RETORNAR UM DDD
function getDDD(uf){
  const dddsPorEstado = {
    "AC": ["68"],
    "AL": ["82"],
    "AM": ["92", "97"],
    "AP": ["96"],
    "BA": ["71", "73", "74", "75", "77"],
    "CE": ["85", "88"],
    "DF": ["61"],
    "ES": ["27", "28"],
    "GO": ["62", "64"],
    "MA": ["98", "99"],
    "MG": ["31", "32", "33", "34", "35", "37", "38"],
    "MS": ["67"],
    "MT": ["65", "66"],
    "PA": ["91", "93", "94"],
    "PB": ["83"],
    "PE": ["81", "87"],
    "PI": ["86", "89"],
    "PR": ["41", "42", "43", "44", "45", "46"],
    "RJ": ["21", "22", "24"],
    "RN": ["84"],
    "RO": ["69"],
    "RR": ["95"],
    "RS": ["51", "53", "54", "55"],
    "SC": ["47", "48", "49"],
    "SE": ["79"],
    "SP": ["11", "12", "13", "14", "15", "16", "17", "18", "19"],
    "TO": ["63"]
  }
  const ddds = dddsPorEstado[uf]
  return ddds ? parseInt(ddds[0]) : console.log("DDD não encontrado")
}

//RETORNAR CIDADES
function getCities(){
  let estadosJson = require("./enderecos/estados.json");
  const estados = estadosJson.data;
  let data = getCurrentDate().toISOString().split("T")[0]
  
  if (!estados || estados.length === 0) {
    console.log("Dados de estados não encontrados no arquivo JSON.");
  }

  const todasAsCidades = [];

  let cidadeId = 1;

  estados.forEach((estado) => {
    const estadoId = estado.Id;
    if (estado.Cidades && estado.Cidades.length > 0) {
      estado.Cidades.forEach((cidade) => {
        todasAsCidades.push({
          id_cidade: cidadeId,
          id_estado: estadoId,
          nome: cidade.Nome,
          cd_ibge: cidade.Codigo,
          nr_ddd: getDDD(cidade.Uf),
          dt_cadastro: data,
          nm_usuario: "rm551832",
        });
        cidadeId++; // Incrementa o ID da cidade
      });
    }
  });
  return todasAsCidades;
}

function generateRandomBairro(city, cityId) {
  // Gere um nome aleatório para a zona do bairro
  const zonasPermitidas = ['CENTRO', 'ZONA LESTE', 'ZONA NORTE', 'ZONA OESTE', 'ZONA SUL'];
  const zonaBairro = zonasPermitidas[Math.floor(Math.random() * zonasPermitidas.length)];

  // Crie os dois bairros com informações aleatórias
  const bairro1 = {
    id_bairro: cityId * 2 - 1, // ID ímpar para o primeiro bairro
    id_cidade: cityId,
    nm_bairro: city.nome,
    nm_zona_bairro: zonaBairro,
    dt_cadastro: getCurrentDate().toISOString().split("T")[0],
    nm_usuario: "rm551832",
  };

  const bairro2 = {
    id_bairro: cityId * 2, // ID par para o segundo bairro
    id_cidade: cityId,
    nm_bairro: city.nome,
    nm_zona_bairro: zonaBairro,
    dt_cadastro: getCurrentDate().toISOString().split("T")[0],
    nm_usuario: "rm551832",
  };

  return [bairro1, bairro2];
}

function generateBairrosForCities() {
  const cities = getCities(); // Certifique-se de que a função getCities esteja definida.
  const allBairros = [];

  cities.forEach((city, index) => {
    const bairros = generateRandomBairro(city, index + 1);
    allBairros.push(...bairros);
  });

  // Retorne a lista completa de bairros
  return allBairros;
}

function generateRandomLogradouro(bairro, bairroId) {
  if (!generateRandomLogradouro.logradouroIdCounter) {
    generateRandomLogradouro.logradouroIdCounter = 1; // Inicialize o contador se ainda não estiver definido
  }

  // Gere um nome aleatório para o logradouro (Av ou Rua + nome do bairro)
  const tipoLogradouro = Math.random() < 0.5 ? "Av" : "Rua";
  const nomeLogradouro = `${tipoLogradouro} ${bairro.nm_bairro}`;

  // Gere um CEP aleatório no formato "99999-999"
  let nr_cep = Math.floor(Math.random() * 90000) + 10000;
  nr_cep += (Math.floor(Math.random() * 900));

  // Use o contador de IDs de logradouro e, em seguida, incremente-o
  const logradouro = {
    id_logradouro: generateRandomLogradouro.logradouroIdCounter,
    id_bairro: bairroId, // Corrigido para usar bairroId
    nm_logradouro: nomeLogradouro,
    nr_cep: nr_cep,
    dt_cadastro: getCurrentDate().toISOString().split("T")[0],
    nm_usuario: "rm551832",
  };

  generateRandomLogradouro.logradouroIdCounter++; // Incremente o contador para o próximo ID de logradouro

  return logradouro;
}

function generateLogradourosForBairros() {
  let allLogradouros = [];
  let bairros = generateBairrosForCities();

  bairros.forEach((bairro, index) => {
    const logradouro1 = generateRandomLogradouro(bairro, bairro.id_bairro);
    allLogradouros.push(logradouro1);

    // Incrementar o id_bairro manualmente para o segundo logradouro
    const logradouro2 = generateRandomLogradouro(bairro, bairro.id_bairro + 1);
    allLogradouros.push(logradouro2);
  });

  // Retorne a lista completa de logradouros
  return allLogradouros;
}

//Inserir endereços nas tabelas
async function insertLogradouro(connect) {
  let logradouroData = generateLogradourosForBairros();
  try {
    const connection = connect;
    const sql = `INSERT INTO T_RHSTU_LOGRADOURO (ID_LOGRADOURO, ID_BAIRRO, NM_LOGRADOURO, NR_CEP, DT_CADASTRO, NM_USUARIO) VALUES (:id_logradouro, :id_bairro, :nm_logradouro, :nr_cep, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)`;

    for (const logradouro of logradouroData) {
      try {
        await connection.execute(sql, logradouro, {
          autoCommit: true,
        });
        console.log(`Logradouro inserido: ${logradouro.id_logradouro}`);
      } catch (err) {
        console.error();
      }
    }
    console.log("Inserções de logradouros concluídas.");
  } catch (err) {
    console.error(err);
  }
}

async function insertBairro(connect) {
  let bairroData = generateBairrosForCities();
  try {
    const connection = connect;
    const sql = `INSERT INTO T_RHSTU_BAIRRO (ID_BAIRRO, ID_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO, DT_CADASTRO, NM_USUARIO) VALUES (:id_bairro, :id_cidade, :nm_bairro, :nm_zona_bairro, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)`;

    for (const bairro of bairroData) {
      try {
        await connection.execute(sql, bairro, {
          autoCommit: true,
        });
        console.log(`Bairro inserido: ${bairro.id_bairro}`);
      } catch (err) {
        console.error(`Erro ao inserir bairro: ${err.message}`);
      }
    }
    console.log("Inserções de bairros concluídas.");
  } catch (err) {
    console.error(err);
  }
}

async function insertCidade(connect) {
  let cidadeData = getCities();
  try {
    const connection = connect;
    const sql = `INSERT INTO T_RHSTU_CIDADE (ID_CIDADE, ID_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD, DT_CADASTRO, NM_USUARIO) VALUES (:id_cidade, :id_estado, :nome, :cd_ibge, :nr_ddd, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)`;

    for (const cidade of cidadeData) {
      try {
        await connection.execute(sql, cidade, {
          autoCommit: true,
        });
        console.log(`Cidade inserida: ${cidade.id_cidade}`);
      } catch (err) {
        console.error(`Erro ao inserir cidade: ${err.message}`);
      }
    }
    console.log("Inserções de cidades concluídas.");
  } catch (err) {
    console.error(err);
  }
}

async function insertEstado(connect) {
  let estadoData = getState();
  try {
    const connection = connect;
    const sql = `INSERT INTO T_RHSTU_ESTADO (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO) VALUES (:id, :sigla, :nome, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :nm_usuario)`;

    for (const estado of estadoData) {
      try {
        await connection.execute(sql, estado, {
          autoCommit: true,
        });
        console.log(`Estado inserido: ${(estado.length / estado.id) * 100}`);
      } catch (err) {
        console.error(`Erro ao inserir estado: ${err.message}`);
      }
    }
    console.log("Inserções de estados concluídas.");
  } catch (err) {
    console.error(err);
  }
}

//GERAR UM EMAIL ALEATORIO

//Criar conexão para outras funções usarem a mesma e evitar de abrir varias conexões e executar as funções de forma assincrona
// async function createConnection() {
//   const pool = await pool.createPool(config);

//   try {
//     const connection = await pool.getConnection();
//     //await insertAdresses(connection);
//   }catch(err) {
//     console.log(err);
//   }finally {
//     pool.close(50);
//   }
// }

//inserção de funcionários
async function insertPacient(amount, batchSize, maxRetries, connect) {
  try {
    const connection = connect;
    const sql = `INSERT INTO T_RHSTU_PACIENTE (ID_PACIENTE, NM_PACIENTE, NR_CPF, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_ESCOLARIDADE, DS_ESTADO_CIVIL, NM_GRUPO_SANGUINEO, NR_ALTURA, NR_PESO, DT_CADASTRO, NM_USUARIO) VALUES (:id, :name, :cpf, TO_DATE(:dt_nasc, 'YYYY-MM-DD'), :gender, :educational, :maritage, :blood_type, :height, :weight, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :username)`;

    
    let lastProgressBar = ''
    const progressInterval = setInterval(() => {
      const greenProgressBar = `\x1b[32m${Array(Math.floor(progress / 10)).fill('#').join('')}\x1b[0m`; // Barra de progresso verde
      const progressText = `Progresso: ${progress.toFixed(2)}% [${greenProgressBar}]`;
      const progressBarWidth = lastProgressBar.length - progressText.length;
    
      let lineToWrite = '\r' + progressText; // Inicializa com o texto de progresso
    
      if (progressBarWidth > 0) {
        lineToWrite += ' '.repeat(progressBarWidth); // Adiciona espaços em branco para limpar a linha antiga
      }
    
      process.stdout.write(lineToWrite); // Escreve a linha completa
    
      lastProgressBar = progressText;
    
      if (progress === 100) {
        clearInterval(progressInterval);
        console.log('Concluído!');
      }
    }, 1000);

    let progress = 0;
    let successfulInserts = 0;
    let currentId = 1;

    for (let i = 0; i < amount; i += batchSize) {
      const binds = [];

      for (let j = 0; j < batchSize; j++) {
        let nome = getRandomFullName();
        let cpf = getRandomCPF();
        let birthDate = getRandomBirthDate();
        let randomGender = getRandomGender();
        let educationalLevel = getRandomEducationalLevel();
        let estadoCivil = getRandomMaritalStatuses();
        let tipoSangue = getRandomBloodType();
        let altura = getRandomHeight();
        let peso = getRandomWeight(altura);
        let dtCadastro = getSignUpDate();
        let usuario = getRandomUsername(nome);

        birthDate = birthDate.toISOString().split("T")[0];
        dtCadastro = dtCadastro.toISOString().split("T")[0];

        binds.push({
          id: currentId,
          name: nome,
          cpf: cpf,
          dt_nasc: birthDate,
          gender: randomGender,
          educational: educationalLevel,
          maritage: estadoCivil,
          blood_type: tipoSangue,
          height: altura,
          weight: peso,
          dt_cadastro: dtCadastro,
          username: usuario,
        });
        currentId++;
      }

      // console.log("Valores do array bind:");
      // for (const bindItem of binds) {
      // console.log(bindItem);
      // }

      try {
        await connection.executeMany(sql, binds, {
          autoCommit: true,
          batchErrors: true,
        });
        successfulInserts += binds.length;
        progress = (successfulInserts / amount) * 100;
      } catch (err) {
        console.error(`Erro ao inserir lote: ${err.message}`);
        if (retry < maxRetries) {
          console.log(`Tentando novamente (${retry + 1} de ${maxRetries})...`);
          await new Promise((resolve) => setTimeout(resolve, 2000));
        } else {
          console.error(`Falhou após ${maxRetries} tentativas. Desistindo.`);
          clearInterval(progressInterval);
          return;
        }
      }
    }

    console.log("\nInserções Completas xD");
    clearInterval(progressInterval);
  } catch (err) {
    console.error(err);
  }
}

//inserção de endereços

//Deletar Tables (Paciente exemplo)
async function deleteAllFromTable(tableName) {
  let connection;

  return new Promise(async (resolve, reject) => {
    try {
      connection = await oracledb.getConnection(config);

      const sql = `TRUNCATE TABLE ${tableName}`;

      await connection.execute(sql, [], { autoCommit: true });

      console.log(`Todos os registros da tabela ${tableName} foram excluídos com sucesso.`);
      resolve(); // Resolvendo a promessa para indicar que a operação foi concluída com sucesso
    } catch (err) {
      console.error(`Erro ao excluir registros da tabela ${tableName}:`, err);
      reject(err); // Rejeitando a promessa em caso de erro
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.error("Erro ao fechar a conexão:", err);
          reject(err); // Rejeitando a promessa em caso de erro no fechamento da conexão
        }
      }
    }
  });
}

async function deleteRecordsIndividually() {
  let connection;

  try {
    connection = await oracledb.getConnection(config);

    // Comece excluindo os registros de T_RHSTU_LOGRADOURO
    console.log("Excluindo registros de T_RHSTU_LOGRADOURO...");
    await connection.execute("DELETE FROM T_RHSTU_LOGRADOURO", [], { autoCommit: true });
    console.log("Registros de T_RHSTU_LOGRADOURO excluídos com sucesso.");

    // Em seguida, exclua os registros de T_RHSTU_BAIRRO
    console.log("Excluindo registros de T_RHSTU_BAIRRO...");
    await connection.execute("DELETE FROM T_RHSTU_BAIRRO", [], { autoCommit: true });
    console.log("Registros de T_RHSTU_BAIRRO excluídos com sucesso.");

    // Depois, exclua os registros de T_RHSTU_CIDADE
    console.log("Excluindo registros de T_RHSTU_CIDADE...");
    await connection.execute("DELETE FROM T_RHSTU_CIDADE", [], { autoCommit: true });
    console.log("Registros de T_RHSTU_CIDADE excluídos com sucesso.");

    // Finalmente, exclua os registros de T_RHSTU_ESTADO
    console.log("Excluindo registros de T_RHSTU_ESTADO...");
    await connection.execute("DELETE FROM T_RHSTU_ESTADO", [], { autoCommit: true });
    console.log("Registros de T_RHSTU_ESTADO excluídos com sucesso.");
  } catch (err) {
    console.error("Erro ao excluir registros individualmente:", err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error("Erro ao fechar a conexão:", err);
      }
    }
  }
}

app.listen(3000, () => console.log("Servidor rodando na porta 3000"));

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

// Função para perguntar ao usuário se deseja inserir funcionários
async function askUserForAction() {
  rl.question(
    "Escolha uma opção:\n1. Inserir funcionários\n2. Deletar todos os registros\n",
    async (answer) => {
      if (answer.toLowerCase() === "1") {
        await createConnectionAndExecute();
        console.log("Inserções concluída.");
      } else if (answer.toLowerCase() === "2") {
        await deleteAllFromTable("T_RHSTU_PACIENTE");
        await deleteRecordsIndividually();
        console.log("Deleção de registros");
      } else {
        console.log("Opção inválida. Operação cancelada.");
      }
      rl.close();
    }
  );
}

const batchSize = 1000; // Defina o tamanho do lote aqui

//estudar java-rs

// deleteAllFromTable()
// getState()
askUserForAction()
// console.log(getCities().length)
// console.log(generateBairrosForCities().length)
// console.log(generateLogradourosForBairros().length)
