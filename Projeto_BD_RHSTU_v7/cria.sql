-- Gerado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   em:        2023-09-25 15:16:52 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE t_rhstu_bairro (
    id_bairro       NUMBER(8) NOT NULL,
    id_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45) NOT NULL,
    nm_zona_bairro  VARCHAR2(20) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT uk_t_pkd_bairro_zona CHECK ( nm_zona_bairro IN (
        'CENTRO',
        'ZONA LESTE',
        'ZONA NORTE',
        'ZONA OESTE',
        'ZONA SUL'
    ) );

COMMENT ON COLUMN t_rhstu_bairro.id_bairro IS
    'Esta coluna ir� receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.id_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio e ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.nm_bairro IS
    'Esta coluna ir� receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

COMMENT ON COLUMN t_rhstu_bairro.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_bairro.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_bairro ADD CONSTRAINT pk_rhstu_bairro PRIMARY KEY ( id_bairro );

CREATE TABLE t_rhstu_cidade (
    id_cidade    NUMBER(8) NOT NULL,
    id_estado    NUMBER(2) NOT NULL,
    nm_cidade    VARCHAR2(60) NOT NULL,
    cd_ibge      NUMBER(8) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_cidade.id_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio e ser� preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN t_rhstu_cidade.id_estado IS
    'Esta coluna ir� receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_cidade.nm_cidade IS
    'Esta coluna ir� receber o nome do Cidade pertencente ao Estado Brasileiro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_cidade.cd_ibge IS
    'Esta coluna ir� receber o c�digo do IBGE que fornece informa��es para gera��o da NFe.';

COMMENT ON COLUMN t_rhstu_cidade.nr_ddd IS
    'ESSE ATRIBUTO RECEBER� DADOS DO NUMERO DO DDD, SENDO OBRIGAT�RIO';

COMMENT ON COLUMN t_rhstu_cidade.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_cidade.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_cidade ADD CONSTRAINT pk_rhstu_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE t_rhstu_consulta (
    id_unid_hospital  NUMBER(9) NOT NULL,
    id_consulta       NUMBER(10) NOT NULL,
    id_paciente       NUMBER(9) NOT NULL,
    id_func           NUMBER(10) NOT NULL,
    dt_hr_consulta    DATE NOT NULL,
    nr_consultorio    NUMBER(5) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_consulta.id_unid_hospital IS
    'Esse atributo ir� receber a chave prim�ria da Unidade Hospitalar. Esse n�mero � sequencia e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta.id_consulta IS
    'ESSE ATRIBUTO RECEBER� DADOS DO ID DA CONSULTA, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta.id_func IS
    'Esse atributo ir� receber a chave prim�ria do m�dico. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta.dt_hr_consulta IS
    'ESSE ATRIBUTO RECEBER� DADOS SOBRE A DATA E HORA DA CONSULTA, SENDO OBRIGAT�RIO';

COMMENT ON COLUMN t_rhstu_consulta.nr_consultorio IS
    'ESSE ATRIBUTO RECEBER� DADOS SOBRE O NUMERO DO CONSULT�RIO EM QUE A CONSULTA SER� FEITA, SENDO OBRIGAT�RIO';

COMMENT ON COLUMN t_rhstu_consulta.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_consulta.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_consulta ADD CONSTRAINT pk_rhstu_consulta PRIMARY KEY ( id_consulta,
                                                                            id_unid_hospital );

CREATE TABLE t_rhstu_consulta_forma_pagto (
    id_consulta_forma_pagto  NUMBER(10) NOT NULL,
    id_unid_hospital         NUMBER(9) NOT NULL,
    id_consulta              NUMBER(10) NOT NULL,
    id_paciente_ps           NUMBER(10) NOT NULL,
    id_forma_pagto           NUMBER(9) NOT NULL,
    dt_pagto_consulta        DATE,
    st_pagto_consulta        CHAR(1) NOT NULL,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT uk_rhstu_status_pagto_paci CHECK ( st_pagto_consulta IN (
        'A',
        'C',
        'P'
    ) );

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_consulta_forma_pagto IS
    'ESSE ATRIBUTO RECEBER� DADOS SOBRE O ID DA CONSULTA DA FORMA DE PAGAMENTO, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_unid_hospital IS
    'Esse atributo ir� receber a chave prim�ria da Unidade Hospitalar. Esse n�mero � sequencia e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_consulta IS
    'ESSE ATRIBUTO RECEBER� DADOS DO ID DA CONSULTA, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_paciente_ps IS
    'Esse atributo ir� receber a chave prim�ria do plano de sa�de do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.id_forma_pagto IS
    'Esse atributo ir� receber a chave prim�ria da forma de pagamento. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.dt_pagto_consulta IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE PAGAMENTO DA CONSULTA, SENDO OPCIONAL';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.st_pagto_consulta IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O STATUS DO PAGAMENTO DA CONSULTA, SENDO OBRIGAT�RIO';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_consulta_forma_pagto.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_consulta_forma_pagto ADD CONSTRAINT pk_rhstu_consulta_forma_pagto PRIMARY KEY ( id_consulta_forma_pagto );

CREATE TABLE t_rhstu_contato_paciente (
    id_paciente      NUMBER(9) NOT NULL,
    id_contato       NUMBER(9) NOT NULL,
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_contato       VARCHAR2(40) NOT NULL,
    nr_ddi           NUMBER(3),
    nr_ddd           NUMBER(3),
    nr_telefone      NUMBER(10),
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_contato_paciente.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_contato IS
    'Esse atributo ir� receber a chave prim�ria do contato do paciente. Esse n�mero � sequencial e inicia sempre com 1 a partir do id do paciente e � gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_tipo_contato IS
    'Esse atributo ir� receber a chave prim�ria do tipo do contato. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_contato IS
    'Este atributo ir� receber o nome do contato do paciente. Seu conteudo � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddi IS
    'Este atributo ir� receber o n�mero do DDI do telefone do contato do paciente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddd IS
    'Este atributo ir� receber o n�mero do DDD  do telefone do contato do paciente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_telefone IS
    'Este atributo ir� receber o n�mero do telefone do contato do paciente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_contato_paciente ADD CONSTRAINT pk_rhstu_contato_emerg_pac PRIMARY KEY ( id_contato,
                                                                                             id_paciente );

CREATE TABLE t_rhstu_email_paciente (
    id_email     NUMBER(9) NOT NULL,
    id_paciente  NUMBER(9) NOT NULL,
    ds_email     VARCHAR2(100) NOT NULL,
    tp_email     VARCHAR2(20) NOT NULL,
    st_email     CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT uk_rhstu_paciente_st_email CHECK ( st_email IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_email_paciente.id_email IS
    'Esse atributo ir� receber a chave prim�ria do email do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.ds_email IS
    'Esse atributo ir� receber o email do paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_email_paciente.tp_email IS
    'Esse atributo ir� receber o tipo email do paciente.  Seu conte�do � obrigat�rio e deve possuir os seguintes valores: Pessoal ou Profissional.';

COMMENT ON COLUMN t_rhstu_email_paciente.st_email IS
    'Esse atributo ir� receber o status do email do paciente.  Seu conte�do � obrigat�rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_email_paciente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_email_paciente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_email_paciente ADD CONSTRAINT pk_rhstu_email_paciente PRIMARY KEY ( id_email );

CREATE TABLE t_rhstu_endereco_paciente (
    id_endereco            NUMBER(9) NOT NULL,
    id_paciente            NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_endereco IS
    'Esse atributo ir� receber a chave prim�ria do endereco do paciente. Esse n�mero � sequencia e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_logradouro IS
    'Esta coluna ir� receber o codigo interno para garantir o lograouro, que esta localizado no� cadastro dos� Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nr_logradouro IS
    'Esse atributo ir� receber o n�mero do logradouro do endereco do paciente.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_complemento_numero IS
    'Esse atributo ir� receber o complemeneto  do logradouro do endereco do paciente caso ele exista. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_ponto_referencia IS
    'Esse atributo ir� receber o ponto de refer�ncia  do logradouro do endereco do paciente.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_inicio IS
    'Esse atributo ir� receber a data inicio do paciente associado ao endere�o (logradouro). Seu conte�do � obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_fim IS
    'Esse atributo ir� receber a data fim do paciente associado ao endere�o (logradouro), ou seja, ele n�o reside mais nesse endere�o.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_endereco_paciente ADD CONSTRAINT pk_rhstu_endereco_paciente PRIMARY KEY ( id_endereco );

CREATE TABLE t_rhstu_endereco_unidhosp (
    id_end_unidhosp        NUMBER(9) NOT NULL,
    id_unid_hospital       NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE,
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.id_end_unidhosp IS
    'Esse atributo ir� receber a chave prim�ria do endereco da Unidade Hospitalar. Esse n�mero � sequencia e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.nr_logradouro IS
    'Esse atributo ir� receber o n�mero do logradouro do endereco da Unidade Hospitalar.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.ds_complemento_numero IS
    'Esse atributo ir� receber o complemeneto  do logradouro do endereco da Unidade hospitalar  caso ele exista. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.ds_ponto_referencia IS
    'Esse atributo ir� receber o ponto de refer�ncia  do logradouro do endereco da Unidade Hospitalar.  Seu conte�do � opcional.
';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_inicio IS
    'Esse atributo ir� receber a data inicio da Unidade Hospitalar  associado ao endere�o (logradouro). Seu conte�do � obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_fim IS
    'Esse atributo ir� receber a data fim da Unidade Hospitalar associado ao endere�o (logradouro), ou seja, ele n�o reside mais nesse endere�o.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_endereco_unidhosp.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_endereco_unidhosp ADD CONSTRAINT pk_rhstu_endereco_pacientev1 PRIMARY KEY ( id_end_unidhosp );

CREATE TABLE t_rhstu_estado (
    id_estado    NUMBER(2) NOT NULL,
    sg_estado    CHAR(2) NOT NULL,
    nm_estado    VARCHAR2(30) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_estado.id_estado IS
    'Esta coluna ir� receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_estado.nm_estado IS
    'Esta coluna ir� receber o nome do estado. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_estado.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_estado.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_estado ADD CONSTRAINT pk_rhstu_estado PRIMARY KEY ( id_estado );

CREATE TABLE t_rhstu_forma_pagamento (
    id_forma_pagto  NUMBER(9) NOT NULL,
    nm_forma_pagto  VARCHAR2(60) NOT NULL,
    ds_forma_pagto  VARCHAR2(500),
    st_forma_pagto  CHAR(1) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_forma_pagamento
    ADD CONSTRAINT uk_rhstu_status_pagto CHECK ( st_forma_pagto IN (
        'A',
        'C',
        'P'
    ) );

COMMENT ON COLUMN t_rhstu_forma_pagamento.id_forma_pagto IS
    'Esse atributo ir� receber a chave prim�ria da forma de pagamento. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.nm_forma_pagto IS
    'Esse atributo ir� receber o nome da forma de pagamento. Seu conte�do � obrigat�rio';

COMMENT ON COLUMN t_rhstu_forma_pagamento.ds_forma_pagto IS
    'Esse atributo ir� receber a descri��o da forma de pagamento. Seu conte�do n�o � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.st_forma_pagto IS
    'Esse atributo ir� receber o status da forma de pagamento. Seu conte�do � obrigat�rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_forma_pagamento.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_forma_pagamento.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_forma_pagamento ADD CONSTRAINT pk_rhstu_forma_pagto PRIMARY KEY ( id_forma_pagto );

CREATE TABLE t_rhstu_funcionario (
    id_func        NUMBER(10) NOT NULL,
    id_superior    NUMBER(10),
    nm_func        VARCHAR2(90) NOT NULL,
    ds_cargo       VARCHAR2(77) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    vl_salario     NUMBER(10, 2),
    nr_rg          VARCHAR2(12) NOT NULL,
    nr_cpf         NUMBER(12) NOT NULL,
    st_func        VARCHAR2(50) DEFAULT 'A' NOT NULL,
    dt_cadastro    DATE NOT NULL,
    nm_usuario     VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_funcionario
    ADD CHECK ( st_func IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_funcionario.id_func IS
    'Esse atributo ir� receber a chave prim�ria do funcionario. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_funcionario.id_superior IS
    'Esse atributo ir� receber a chave prim�ria do SUPERIOR DO funcionario (GESTOR). Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_funcionario.nm_func IS
    'Esse atributo ir� receber o nome completo do funcionario.� Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_funcionario.ds_cargo IS
    'Este atributo deve receber a  descri��o do cargo do funcion�rio.';

COMMENT ON COLUMN t_rhstu_funcionario.dt_nascimento IS
    'esse atributo receber� informa��es sobre a data de cadastro do funcionario, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_funcionario.vl_salario IS
    'esse atributo receber� informa��es sobre o valor do salario  do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.nr_rg IS
    'esse atributo receber� informa��es sobre o NUMERO DO RG do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.nr_cpf IS
    'esse atributo receber� informa��es sobre o NUMERO DO CPF  do funcionario, sendo obrigatorio';

COMMENT ON COLUMN t_rhstu_funcionario.st_func IS
    'ESSE ATRIBUTO RECEBER� CONTEUDO SOBRE O STATUS DO FUNCIONARIO, PODENDO SER (A)tivo e (I)nativo.';

COMMENT ON COLUMN t_rhstu_funcionario.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_funcionario.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_funcionario ADD CONSTRAINT pk_rhstu_func PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_logradouro (
    id_logradouro  NUMBER(10) NOT NULL,
    id_bairro      NUMBER(8) NOT NULL,
    nm_logradouro  VARCHAR2(100) NOT NULL,
    nr_cep         NUMBER(8) NOT NULL,
    dt_cadastro    DATE NOT NULL,
    nm_usuario     VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_logradouro.id_logradouro IS
    'Esta coluna ir� receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.id_bairro IS
    'Esta coluna ir� receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do lograoduro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_logradouro.nr_cep IS
    'Esta coluna ir� receber o n�mero do CEP do lograoduro. O padr�o de armazenmento �  num�rico  e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_logradouro.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_logradouro.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_logradouro ADD CONSTRAINT pk_rhstu_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE t_rhstu_medicamento (
    id_medicamento            NUMBER(9) NOT NULL,
    nm_medicamento            VARCHAR2(50) NOT NULL,
    ds_detalhada_medicamento  VARCHAR2(4000),
    nr_codigo_barras          NUMBER NOT NULL,
    dt_cadastro               DATE NOT NULL,
    nm_usuario                VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_medicamento.id_medicamento IS
    'ESSE ATRIBUTO RECEBER� O ID DO MEDICAMENTO, SENDO GERADO SEQUENCIALMENTE';

COMMENT ON COLUMN t_rhstu_medicamento.nm_medicamento IS
    'ESSE ATRIBUTO RECEBER� DADOS SOBRE O NOME DO MEDICAMENTO, SENDO OBRIGAT�RIO NA TABELA';

COMMENT ON COLUMN t_rhstu_medicamento.ds_detalhada_medicamento IS
    'Esse atributo ir� receber a descri��o detalhada do medicamento. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_medicamento.nr_codigo_barras IS
    'Esse atributo ir� receber o n�mero do c�digo de barras do medicamento, seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_medicamento.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_medicamento.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_medicamento ADD CONSTRAINT pk_rhstu_medicamento PRIMARY KEY ( id_medicamento );

CREATE TABLE t_rhstu_medico (
    id_func           NUMBER(10) NOT NULL,
    nr_crm            NUMBER(10) NOT NULL,
    ds_especialidade  VARCHAR2(50) NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_medico.nr_crm IS
    'Esse atributo ir� receber o n�mero do CRM do m�dico. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_medico.ds_especialidade IS
    'Esse atributo ir� receber a especialidade do m�dico. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_medico.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_medico.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_medico ADD CONSTRAINT pk_rhstu_medico PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_motorista (
    id_func           NUMBER(10) NOT NULL,
    nr_cnh            NUMBER(14) NOT NULL,
    nm_categoria_cnh  VARCHAR2(70) NOT NULL,
    dt_validade_cnh   DATE NOT NULL,
    dt_cadastro       DATE NOT NULL,
    nm_usuario        VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_motorista.nr_cnh IS
    'Esse atributo ir� receber o n�mero da CNH  do motorista. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_validade_cnh IS
    'Esse atributo ir� receber a especialidade do m�dico. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_motorista.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_motorista.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_motorista ADD CONSTRAINT pk_rhstu_motorista PRIMARY KEY ( id_func );

CREATE TABLE t_rhstu_paciente (
    id_paciente         NUMBER(9) NOT NULL,
    nm_paciente         VARCHAR2(80) NOT NULL,
    nr_cpf              NUMBER(12) NOT NULL,
    nm_rg               VARCHAR2(15),
    dt_nascimento       DATE NOT NULL,
    fl_sexo_biologico   CHAR(1) NOT NULL,
    ds_escolaridade     VARCHAR2(40) NOT NULL,
    ds_estado_civil     VARCHAR2(25) NOT NULL,
    nm_grupo_sanguineo  VARCHAR2(6) NOT NULL,
    nr_altura           NUMBER(3, 2) DEFAULT 0.1 NOT NULL,
    nr_peso             NUMBER(4, 1) NOT NULL,
    dt_cadastro         DATE NOT NULL,
    nm_usuario          VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_sexobio CHECK ( fl_sexo_biologico IN (
        'F',
        'I',
        'M'
    ) );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_altura_paciente CHECK ( nr_altura BETWEEN 0.1 AND 2.99 );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_peso CHECK ( nr_peso BETWEEN 1 AND 800 );

COMMENT ON COLUMN t_rhstu_paciente.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_paciente IS
    'Esse atributo ir� receber o nome completo do  paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.nr_cpf IS
    'Esse atributo ir� receber o n�mero do  CPF paciente.  Seu conte�do � obrigat�rio e ser� validado de acordo com regras de neg�cio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_rg IS
    'Esse atributo ir� receber o n�mero do  RG  paciente.  Seu conte�do � obrigat�rio e ser� validado de acordo com regras de neg�cio.';

COMMENT ON COLUMN t_rhstu_paciente.dt_nascimento IS
    'Esse atributo ir� receber a data de nascimento do  paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.fl_sexo_biologico IS
    'Esse atributo ir� receber a flag do sexo biol�gico de nascimento do Paciente. Os valores poss�veis s�o (F)emea  ou (M)acho ou (I)ntersexual. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.ds_escolaridade IS
    'Esse atributo ir� receber a Escolaridade do  paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.ds_estado_civil IS
    'Esse atributo ir� receber o Estado Civil  do  paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_grupo_sanguineo IS
    'Esse atributo ir� receber o grupo sanguineo do  paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente.nr_altura IS
    'Esse atributo ir� receber a altura do  paciente.  Seu conte�do � obrigat�rio e o limite de altura deve ficar entre 0.1 e 2.99.';

COMMENT ON COLUMN t_rhstu_paciente.nr_peso IS
    'Esse atributo ir� receber o peso  do  paciente.  Seu conte�do � obrigat�rio. A faixa de valores permitidos est� entre 1 e 800kg.';

COMMENT ON COLUMN t_rhstu_paciente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_paciente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT pk_rhstu_paciente PRIMARY KEY ( id_paciente );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_cpf_paciente UNIQUE ( nr_cpf );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_rg_paciente UNIQUE ( nm_rg );

CREATE TABLE t_rhstu_paciente_plano_saude (
    id_paciente_ps  NUMBER(10) NOT NULL,
    id_paciente     NUMBER(9) NOT NULL,
    id_plano_saude  NUMBER(5) NOT NULL,
    nr_carteira_ps  NUMBER(15),
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente_ps IS
    'Esse atributo ir� receber a chave prim�ria do plano de sa�de do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_plano_saude IS
    'Esse atributo ir� receber a chave prim�ria do plano de sa�de. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nr_carteira_ps IS
    'ESSE ATRIBUTO RECEBER� O NUMERO DA CARTEIRA DE CADA PACIENTE DO PLANO DE SA�DE';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_inicio IS
    'Esse atributo ir� receber a data de in�cio para atendimento do plano de sa�de do cliente aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_fim IS
    'Esse atributo ir� receber a data de encerramento do plano de sa�de aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_paciente_plano_saude ADD CONSTRAINT pk_rhstu_pac_plano_saude PRIMARY KEY ( id_paciente_ps );

CREATE TABLE t_rhstu_plano_saude (
    id_plano_saude           NUMBER(5) NOT NULL,
    ds_razao_social          VARCHAR2(70) NOT NULL,
    nm_fantasia_plano_saude  VARCHAR2(80),
    ds_plano_saude           VARCHAR2(100) NOT NULL,
    nr_cnpj                  NUMBER(14) NOT NULL,
    nm_contato               VARCHAR2(30),
    ds_telefone              VARCHAR2(30),
    dt_inicio                DATE NOT NULL,
    dt_fim                   DATE,
    dt_cadastro              DATE NOT NULL,
    nm_usuario               VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_plano_saude.id_plano_saude IS
    'Esse atributo ir� receber a chave prim�ria do plano de sa�de. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_razao_social IS
    'Esse atributo ir� receber Raz�o Social do plano de sa�de aceito na RHSTU. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_fantasia_plano_saude IS
    'Esse atributo ir� receber o nome Fantasia do plano de sa�de aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_plano_saude IS
    'Esse atributo ir� receber a descri��o do  plano de sa�de aceito na RHSTU. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nr_cnpj IS
    'Esse atributo ir� receber o numero do CNPJ do plano de sa�de aceito na RHSTU. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_contato IS
    'Esse atributo ir� receber o nome  do contato dentro do plano de sa�de aceito na RHSTU. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_telefone IS
    'Esse atributo ir� receber os dados do telefone para contato no plano de sa�de aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_inicio IS
    'Esse atributo ir� receber a data de in�cio para atendimento do plano de sa�de aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_fim IS
    'Esse atributo ir� receber a data de encerramento do plano de sa�de aceito na RHSTU. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_plano_saude ADD CONSTRAINT pk_rhstu_plano_saude PRIMARY KEY ( id_plano_saude );

CREATE TABLE t_rhstu_prescricao_medica (
    id_prescricao_medica  NUMBER(10) NOT NULL,
    id_unid_hospital      NUMBER(9) NOT NULL,
    id_consulta           NUMBER(10) NOT NULL,
    id_medicamento        NUMBER(9) NOT NULL,
    ds_posologia          VARCHAR2(150) NOT NULL,
    ds_via                VARCHAR2(40) NOT NULL,
    ds_observacao_uso     VARCHAR2(100),
    qt_medicamento        NUMBER(10, 4),
    nm_usuario            VARCHAR2(30) NOT NULL,
    dt_cadastro           DATE NOT NULL
);

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_prescricao_medica IS
    'Esse atributo ir� receber a chave prim�ria da prescri��o m�dica. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_unid_hospital IS
    'Esse atributo ir� receber a chave prim�ria da unidade hospitalar. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio. Trata-se de uma chave prim�ria herdada da tabela consulta.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_consulta IS
    'Esse atributo ir� receber o n�mero da consulta do paciente.  Seu conte�do � obrigat�rio e ser� validado de acordo com regras de neg�cio. Trata-se de uma chave prim�ria herdada da tabela consulta. ';

COMMENT ON COLUMN t_rhstu_prescricao_medica.id_medicamento IS
    'Esse atributo ir� receber a chave prim�ria do medicamento. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_posologia IS
    'Esse atributo ir� receber a descri��o da posologia. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_via IS
    'Esse atributo ir� receber a descri��o das vias de administra��o de medicamentos. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.ds_observacao_uso IS
    'Esse atributo receber� a descri��o das observa��es de uso. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_prescricao_medica.qt_medicamento IS
    'Este atributo receber� as especifica��es da quantidade de medicamento. Seu conte�do � opcional';

COMMENT ON COLUMN t_rhstu_prescricao_medica.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

COMMENT ON COLUMN t_rhstu_prescricao_medica.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

ALTER TABLE t_rhstu_prescricao_medica ADD CONSTRAINT pk_rhstu_prescricao_medica PRIMARY KEY ( id_prescricao_medica );

CREATE TABLE t_rhstu_telefone_paciente (
    id_paciente  NUMBER(9) NOT NULL,
    id_telefone  NUMBER(9) NOT NULL,
    nr_ddi       NUMBER(3) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    nr_telefone  NUMBER(10) NOT NULL,
    tp_telefone  VARCHAR2(20) DEFAULT 'CELULAR' NOT NULL,
    st_telefone  CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rhstu_telefone_paciente
    ADD CHECK ( tp_telefone IN (
        'CELULAR',
        'COMERCIAL',
        'CONTATO OU RECADO',
        'RESIDENCIAL'
    ) );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT ck_rhstu_st_tel_pac CHECK ( st_telefone IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_paciente IS
    'Esse atributo ir� receber a chave prim�ria do paciente. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_telefone IS
    'Esse atributo ir� receber a chave prim�ria do telefone do paciente. Esse n�mero � sequencial iniciando com 1 a partir do id do paciente e �  gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddi IS
    'Este atributo ir� receber o n�mero do DDI do telefone do  paciente. Seu conteudo � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddd IS
    'Esse atributo ir� receber o n�mero do DDD do telefone paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_telefone IS
    'Esse atributo ir� receber o n�mero do telefone do  DDD do telefone paciente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.tp_telefone IS
    'Esse atributo ir� receber o tipo do  telefone  do telefone paciente.  Seu conte�do � obrigat�rio e os valores possiveis s�o: Comercial, Residencial, Recado e Celular';

COMMENT ON COLUMN t_rhstu_telefone_paciente.st_telefone IS
    'Esse atributo ir� receber o status do telefone do paciente.  Seu conte�do � obrigat�rio e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_telefone_paciente ADD CONSTRAINT pk_rhstu_telefone_paciente PRIMARY KEY ( id_telefone,
                                                                                              id_paciente );

CREATE TABLE t_rhstu_tipo_contato (
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_tipo_contato  VARCHAR2(80) NOT NULL,
    dt_inicio        DATE NOT NULL,
    dt_fim           DATE,
    dt_cadastro      DATE NOT NULL,
    nm_usuario       VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_tipo_contato.id_tipo_contato IS
    'Esse atributo ir� receber a chave prim�ria do tipo do contato. Esse n�mero � sequencial e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_tipo_contato IS
    'Este atributo ir�  receber o nome  do tipo de contato (M�e, Pai, Prima(o), Irm�(o), Amiga(o), Colega de trabalho) entre outros. Seu conteudo � obrigat�rio.
';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_inicio IS
    'Este atributo ir�  receber a data de in�cio de validade do tipo do contato. Seu conteudo � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_fim IS
    'Este atributo ir�  receber a data de t�rmino  de validade do tipo do contato. Seu conteudo � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_tipo_contato ADD CONSTRAINT pk_rhstu_tipo_contato PRIMARY KEY ( id_tipo_contato );

CREATE TABLE t_rhstu_unid_hospitalar (
    id_unid_hospital           NUMBER(9) NOT NULL,
    nm_unid_hospitalar         VARCHAR2(80) NOT NULL,
    nm_razao_social_unid_hosp  VARCHAR2(80) NOT NULL,
    dt_fundacao                DATE,
    nr_logradouro              NUMBER(7),
    ds_complemento_numero      VARCHAR2(30),
    ds_ponto_referencia        VARCHAR2(50),
    dt_inicio                  DATE NOT NULL,
    dt_termino                 DATE,
    dt_cadastro                DATE NOT NULL,
    nm_usuario                 VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_unid_hospitalar.id_unid_hospital IS
    'Esse atributo ir� receber a chave prim�ria da Unidade Hospitalar. Esse n�mero � sequencia e gerado automaticamente pelo sistema. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_unid_hospitalar IS
    'Esse atributo ir� receber o nome da unidade hospitalar. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_razao_social_unid_hosp IS
    'Esse atributo ir� receber a raz�o social da unidade hospitalar. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_fundacao IS
    'Esse atributo ir� receber a data de funda��o da unidade hospitalar. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nr_logradouro IS
    'Esse atributo ir� receber o n�mero do logradouro do endereco da Unidade Hospitalar.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_complemento_numero IS
    'Esse atributo ir� receber o complemeneto  do logradouro do endereco da Unidade Hospitalar caso ele exista. Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_ponto_referencia IS
    'Esse atributo ir� receber o ponto de refer�ncia� do logradouro do endereco da unidade hospitalar.� Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_inicio IS
    'Esse atributo ir� receber a data inicio do endere�o da Unidade Hospitalar associado ao endere�o (logradouro). Seu conte�do � obrigatorio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_termino IS
    'Esse atributo ir� receber a data t�rmino  do endere�o da Unidade Hospitalar associado ao endere�o (logradouro). Seu conte�do � opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_rhstu_unid_hospitalar ADD CONSTRAINT pk_rhstu_uni_hosp_end PRIMARY KEY ( id_unid_hospital );

ALTER TABLE t_rhstu_logradouro
    ADD CONSTRAINT fk_rhstu_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_rhstu_bairro ( id_bairro );

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT fk_rhstu_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_rhstu_cidade ( id_cidade );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_consulta_forma_pagto FOREIGN KEY ( id_consulta,
                                                               id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_consulta_presc_medica FOREIGN KEY ( id_consulta,
                                                                id_unid_hospital )
        REFERENCES t_rhstu_consulta ( id_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_cidade
    ADD CONSTRAINT fk_rhstu_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_rhstu_estado ( id_estado );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_forma_pagto_consult FOREIGN KEY ( id_forma_pagto )
        REFERENCES t_rhstu_forma_pagamento ( id_forma_pagto );

ALTER TABLE t_rhstu_medico
    ADD CONSTRAINT fk_rhstu_func_medico FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_motorista
    ADD CONSTRAINT fk_rhstu_func_motorista FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_funcionario
    ADD CONSTRAINT fk_rhstu_func_superior FOREIGN KEY ( id_superior )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_logr_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_logr_unidhosp_end FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_med_consulta FOREIGN KEY ( id_func )
        REFERENCES t_rhstu_funcionario ( id_func );

ALTER TABLE t_rhstu_prescricao_medica
    ADD CONSTRAINT fk_rhstu_medicamento_pm FOREIGN KEY ( id_medicamento )
        REFERENCES t_rhstu_medicamento ( id_medicamento );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_pac_consulta FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_pac_cont FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_rhstu_pac_plano_pagto FOREIGN KEY ( id_paciente_ps )
        REFERENCES t_rhstu_paciente_plano_saude ( id_paciente_ps );

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT fk_rhstu_paciente_email FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_paciente_endereco FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_paciente_plano FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT fk_rhstu_paciente_telefone FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_plano_saude_pac FOREIGN KEY ( id_plano_saude )
        REFERENCES t_rhstu_plano_saude ( id_plano_saude );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_tipo_contato FOREIGN KEY ( id_tipo_contato )
        REFERENCES t_rhstu_tipo_contato ( id_tipo_contato );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_unid_hosp_consulta FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

ALTER TABLE t_rhstu_endereco_unidhosp
    ADD CONSTRAINT fk_rhstu_unidhosp_end FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

CREATE OR REPLACE TRIGGER arc_trg_general_t_rhstu_medico BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_medico
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_trg_gene_t_rhstu_motorista BEFORE
    INSERT OR UPDATE OF id_func ON t_rhstu_motorista
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.id_func
    INTO d
    FROM
        t_rhstu_funcionario a
    WHERE
        a.id_func = :new.id_func;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             0
-- ALTER TABLE                             58
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
