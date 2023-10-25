const readline = require('readline');
const express = require("express");
const oracledb = require("oracledb");
const app = express();

const config = {
  user: "rm551832",
  password: "030703",
  connectString: "oracle.fiap.com.br:1521/orcl",
  batchErrors: true
};

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

console.log(typeof getRandomCPF())

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

console.log(typeof getRandomHeight())

//GERA UMA DATA DE CADASTRO PELO DATA DO INSERT
function getSignUpDate() {
  const today = new Date();
  const year = today.getFullYear();
  const month = String(today.getMonth() + 1).padStart(2, "0");
  const day = String(today.getDate()).padStart(2, "0");
  const formattedDate = `${year}-${month}-${day}`;
  return new Date(formattedDate)
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

//GERAR UM EMAIL ALEATORIO


//inserção de funcionários
async function insertPacient(amount, batchSize, maxRetries) {
  const pool = await oracledb.createPool(config);

  try {
    const connection = await pool.getConnection();
    const sql = `INSERT INTO T_RHSTU_PACIENTE (ID_PACIENTE, NM_PACIENTE, NR_CPF, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_ESCOLARIDADE, DS_ESTADO_CIVIL, NM_GRUPO_SANGUINEO, NR_ALTURA, NR_PESO, DT_CADASTRO, NM_USUARIO) VALUES (:id, :name, :cpf, TO_DATE(:dt_nasc, 'YYYY-MM-DD'), :gender, :educational, :maritage, :blood_type, :height, :weight, TO_DATE(:dt_cadastro, 'YYYY-MM-DD'), :username)`;
    
    const progressInterval = setInterval(() => {
      console.log(`Progresso: ${progress.toFixed(2)}%`);
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

        birthDate = birthDate.toISOString().split('T')[0];
        dtCadastro = dtCadastro.toISOString().split('T')[0];

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
        await connection.executeMany(sql, binds, { autoCommit: true, batchErrors: true });
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

    console.log("Inserções Completas xD");
    clearInterval(progressInterval);

  } catch (err) {
    console.error(err);
  } finally {
    if (pool) {
      try {
        await pool.close(30); // Feche o pool com um limite de tempo de 20 segundos
      } catch (err) {
        console.error("Erro ao fechar o pool de conexão:", err);
      }
    }
  }
}


//inserção de endereços

//Deletar Tables (Paciente exemplo)
async function deleteAllFromTable() {
  let connection;

  return new Promise(async (resolve, reject) => {
    try {
      connection = await oracledb.getConnection(config);

      const sql = "DELETE FROM T_RHSTU_PACIENTE";

      await connection.execute(sql, [], { autoCommit: true });

      console.log("Todos os registros da tabela foram excluídos com sucesso.");
      resolve(); // Resolvendo a promessa para indicar que a operação foi concluída com sucesso
    } catch (err) {
      console.error("Erro ao excluir registros da tabela:", err);
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


app.listen(3000, () => console.log("Servidor rodando na porta 3000"));


const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Função para perguntar ao usuário se deseja inserir funcionários
async function askUserForAction() {
  rl.question('Escolha uma opção:\n1. Inserir funcionários\n2. Deletar todos os registros e inserir funcionários\n', async (answer) => {
    if (answer.toLowerCase() === '1') {
      await insertPacient(1000000, batchSize, 20);
      console.log('Inserção de funcionários concluída.');
    } else if (answer.toLowerCase() === '2') {
      await deleteAllFromTable();
      console.log('Deleção de registros');
    } else {
      console.log('Opção inválida. Operação cancelada.');
    }
    rl.close();
  });
}

const batchSize = 1000; // Defina o tamanho do lote aqui

//estudar java-rs

// deleteAllFromTable()
askUserForAction()

