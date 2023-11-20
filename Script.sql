
//Script de criação da tabela de livro
CREATE TABLE Livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    ano_publicacao INTEGER NOT NULL
);

//Script de criação da tabela de usuario
create table Usuario(
	id_usuario SERIAL primary key,
	nome VARCHAR(255) not null,
	endereco VARCHAR(255) not null,
	contato VARCHAR(20) not NULL
);

//Script de criação da tabela de emprestimo
create table emprestimo(
	id_emprestimo SERIAL primary key,
	id_livro INTEGER REFERENCES Livro(id_livro) ON DELETE CASCADE,
    id_usuario INTEGER REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    data_emprestimo DATE NOT NULL,
    data_devolucao_esperada DATE NOT NULL,
    data_devolucao DATE,
    multa DECIMAL(10, 2) DEFAULT 0.00	
)
//Script de criação da tabela de Funcionario
create table Funcionario(
	id_funcionario SERIAL primary key,
	nome VARCHAR(255) not null,
	funcao VARCHAR(50)
);
