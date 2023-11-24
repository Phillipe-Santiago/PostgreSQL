--Tabela que armazena informações das Categorias
CREATE TABLE Categoria (
    id_categoria SERIAL not null,
    descricao VARCHAR(100) NOT null,
    
    constraint pk_Categoria_id_categoria primary key (id_categoria)
);

--Tabela que armazena informações dos Usuarios
CREATE TABLE Usuario(
	id_usuario SERIAL not null,
	nome VARCHAR(255) not null,
	endereco VARCHAR(255) not null,
	contato VARCHAR(20) not null,
	
	constraint pk_Usuario_id_usuario primary key (id_usuario)
);

--Tabela que armazena informações dos Funcionarios
create table Funcionario(
	id_funcionario SERIAL not null,
	nome VARCHAR(255) not null,
	funcao VARCHAR(50),
	
	constraint pk_Funcionario_id_funcionario primary key (id_funcionario)
);

--Tabela que armazena informações dos Livros
CREATE TABLE Livro (
    id_livro SERIAL not NULL,
    id_categoria INTEGER not null,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    ano_publicacao INTEGER NOT null,
    
    constraint pk_Livro_id_livro primary key (id_livro),
    constraint fk_Livro_id_categoria foreign key(id_categoria) references Categoria(id_categoria),
    constraint un_Livro_ISBN unique(ISBN)
);

--Tabela que armazena informações dos Emprestimos
create table Emprestimo (
	id_emprestimo SERIAL not null,
	id_livro INTEGER not null,
    id_usuario INTEGER not null,
    transacao varchar(32) not null,
    data_transacao DATE NOT null,
    --data_devolucao_esperada DATE NOT NULL,
    
    constraint pk_Emprestimo_id_emprestimo primary key (id_emprestimo),
    constraint fk_Emprestimo_id_livro foreign key(id_livro) references Livro(id_livro),
    constraint fk_Emprestimo_id_usuario foreign key(id_usuario) references Usuario(id_usuario),
    constraint chk_Emprestimo_transacao CHECK (transacao IN ('Emprestimo', 'Devolucao'))
);

-------------------------------
-- Status do Livro
-------------------------------

CREATE TABLE StatusLivro (
    status VARCHAR(50) NOT null,
    id_livro INTEGER not null,
    
    constraint fk_StatusLivro_id_livro foreign key(id_livro) references Livro(id_livro),
    constraint chk_StatusLivro_status CHECK (status IN ('disponivel', 'emprestado', 'manutencao'))
);

-------------------------------
-- Log das Devoluções
-------------------------------

CREATE TABLE LogEmprestimoDevolucao (
    id_log SERIAL not null,
    id_emprestimo INTEGER not null,
    id_livro INTEGER not null,
    data_devolucao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    
    constraint pk_LogEmprestimoDevolucao_id_log primary key (id_log),
    constraint fk_LogEmprestimoDevolucao_id_emprestimo foreign key(id_emprestimo) references Emprestimo(id_emprestimo),
    constraint fk_LogEmprestimoDevolucao_id_livro foreign key(id_livro) references Livro(id_livro)

    
);
