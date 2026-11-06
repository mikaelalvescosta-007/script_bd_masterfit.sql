 CREATE TABLE usuario(
  id_usuario SERIAL PRIMARY KEY,
  nome varchar(100)not null,
  email varchar(100)not null,
  senha_hash varchar(255)not null,
  data_nascimento date not null,
  tipo_perfil varchar(255)not null,
  fcm_toke varchar(255),
  data_cadastro timestamp
  );

  SELECT * FROM usuario;

  INSERT INTO usuario (nome, email, senha_hash, data_nascimento, tipo_perfil) VALUES ('mikael', 'mikael.alves.costa@escola.pr.gov.br', 'hash_senha_123', '2000-01-01', 'cliente');

  drop table pedido;

  CREATE TABLE pedido(
  id_pedido SERIAL PRIMARY KEY,
  id_cliente int not null,
  id_endereco_entrega int not null,
  id_cupom int,
  status_pedido varchar(255) not null,
  valor_subtotal decimal(10,2) not null,
  valor_desconto decimal(10,2),
  valor_total decimal(10,2),
  data_pedido timestamp,
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_pedido_endereco FOREIGN KEY (id_endereco_entrega) REFERENCES id_endereco(id_endereco),
  CONSTRAINT fk_pedido_cupom FOREIGN KEY (id_cupom) REFERENCES cupom_desconto(id_cupom)
  );

  SELECT * FROM pedido;

  CREATE TABLE item_pedido(
  id_item_pedido SERIAL PRIMARY KEY,
  id_pedido int not null,
  id_suplemento int not null,
  quantidade int not null,
  preco_unitario decimal (10,2) not null,
  CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  CONSTRAINT fk_item_suplemento FOREIGN KEY (id_suplemento) REFERENCES suplemento(id_suplemento)
  );


  SELECT * FROM item_pedido;


  INSERT INTO pedido (id_cliente, id_endereco_entrega, status_pedido, valor_subtotal, valor_total) VALUES (1, 1, 'Pendente', 100.00, 100.00);


  CREATE TABLE suplemento_favorito(
  id_favorito SERIAL PRIMARY KEY,
  id_usuario int not null,
  id_suplemento int not null,
  data_adicao timestamp,
  CONSTRAINT fk_favorito_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_favorito_suplemento FOREIGN KEY (id_suplemento) REFERENCES suplemento(id_suplemento)
  );

  CREATE TABLE id_endereco(
  id_endereco SERIAL PRIMARY KEY,
  id_usuario int not null,
  cep varchar (8) not null,
  logradouro varchar (150) not null,
  numero varchar (20),
  bairro varchar (100) not null,
  cidade varchar (100) not null,
  estado varchar(2) not null,
  eh_principal boolean,
  CONSTRAINT fk_endereco_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
  );


  SELECT * FROM id_endereco;


  CREATE TABLE cupom_desconto(
  id_cupom SERIAL PRIMARY KEY,
  codigo_cupom varchar(30) not null,
  porcentual_desconto decimal(5,2),
  valor_desconto_fixo decimal(10,2),
  data_validade timestamp not null
  );

  CREATE TABLE diario_alimentar(
  id_registro SERIAL PRIMARY KEY,
  id_usuario int not null,
  id_alimento int not null,
  categoria_refeicao varchar(255) not null,
  quantidad_gramas decimal(8,2) not null,
  calorias_calculadas decimal(8,2) not null,
  data_registro date not null,
  data_sincronizacao timestamp,
  CONSTRAINT fk_diario_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_diario_alimento FOREIGN KEY (id_alimento) REFERENCES alimentos(id_alimentos)
  );


  CREATE TABLE suplemento(
  id_suplemento SERIAL PRIMARY KEY,
  nome varchar(150),
  descricao text,
  peso_kg varchar(30),
  preco_unitario decimal(10,2),
  quantidade_estoque int,
  url_imagem varchar(255),
  ativo boolean
  );

  create table notificacao_push (
  id_notificacao_push SERIAL PRIMARY KEY,
  fk_usuario int not null,
  titulo varchar(100) not null,
  mensagem text not null,
  tipo_notificacao varchar(100) not null,
  data_agendamento timestamp not null,
  enviada boolean null,
  data_envio timestamp null,
  constraint fk_usuario foreign key (fk_usuario) references usuario(id_usuario)
  );

drop table notificacao_push

CREATE TABLE alimentos(
 id_alimentos SERIAL PRIMARY KEY,
 nome varchar(120),
 porcao_padrao_gramas decimal(8,2),
 calorias_base decimal(8,2),
 proteinas_g decimal (6,2)
);
