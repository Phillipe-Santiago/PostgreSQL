--Tabela que armazena informações dos Livros
CREATE TABLE Livro (
    id_livro SERIAL not NULL,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    ano_publicacao INTEGER NOT null,
    
    constraint pk_Livro_id_livro primary key (id_livro),
    constraint un_Livro_ISBN unique(ISBN)
);

--Inserindo uma série de livros para serem utilizados como exemplo
INSERT INTO Livro (titulo, autor, ISBN, ano_publicacao)
VALUES
    ('Dom Casmurro', 'Machado de Assis', '9788538100894', 1899),
    ('Cem Anos de Solidão', 'Gabriel García Márquez', '9788535901459', 1967),
    ('1984', 'George Orwell', '9780451524935', 1949),
    ('A Arte da Guerra', 'Sun Tzu', '9788563560151', -500),
    ('O Hobbit', 'J.R.R. Tolkien', '9788533619491', 1937),
    ('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', '9788576570697', 1943),
    ('O Senhor dos Anéis', 'J.R.R. Tolkien', '9780544003415', 1954),
    ('A Revolução dos Bichos', 'George Orwell', '9788525403485', 1945),
    ('A Metamorfose', 'Franz Kafka', '9788571105165', 1915),
    ('A Odisséia', 'Homero', '9788573262276', -800);

   
--Tabela que armazena informações dos Usuarios
CREATE TABLE Usuario(
	id_usuario SERIAL not null,
	nome VARCHAR(255) not null,
	endereco VARCHAR(255) not null,
	contato VARCHAR(20) not null,
	
	constraint pk_Usuario_id_usuario primary key (id_usuario)
);

--Tabela que armazena informações dos Emprestimos
create table Emprestimo(
	id_emprestimo SERIAL not null,
	id_livro INTEGER not null,
    id_usuario INTEGER not null,
    data_emprestimo DATE NOT NULL,
    data_devolucao_esperada DATE NOT NULL,
    
    constraint pk_Emprestimo_id_emprestimo primary key (id_emprestimo),
    constraint fk_Emprestimo_id_livro foreign key(id_livro) references Livro(id_livro),
    constraint fk_Emprestimo_id_usuario foreign key(id_usuario) references Usuario(id_usuario)
);

--Tabela que armazena informações dos Funcionarios
create table Funcionario(
	id_funcionario SERIAL not null,
	nome VARCHAR(255) not null,
	funcao VARCHAR(50),
	
	constraint pk_Funcionario_id_funcionario primary key (id_funcionario)
);

--Tabela que armazena informações das Categorias
CREATE TABLE Categoria (
    id_categoria SERIAL not null,
    descricao VARCHAR(100) NOT null,
    
    constraint pk_Categoria_id_categoria primary key (id_categoria)
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

--Modificando status do livro de id 1 para emprestado para ser utilizado pela procedure criada
UPDATE StatusLivro SET status = 'emprestado' WHERE id_livro = 1;

--Adicionando mais 2 status de livros para serem utilizados pela procedure criada
INSERT INTO StatusLivro (status, id_livro)
values
	('disponivel', 2),
	('manutencao', 3);


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




