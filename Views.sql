-- View criada para agrupar livros por suas categorias. 
create or replace view LivrosCategoria as
select livro.titulo, categoria.descricao 
from livro
join categoria on categoria.id_categoria = livro.id_categoria


-- View criada para mostrar todos os empréstimos atuais com detalhes dos usuários e livros. 
create or replace view VisaoEmprestimosAtivos as
select
    E.id_emprestimo,
    U.nome as nome_usuario,
    U.endereco as endereco_usuario,
    U.contato as contato_usuario,
    L.titulo as titulo_livro,
    L.autor as autor_livro,
    E.transacao,
    E.data_transacao
from Emprestimo E
join Usuario U on E.id_usuario = U.id_usuario
join Livro L on E.id_livro = L.id_livro
where E.transacao = 'Emprestimo';

-- View criada para mostrar o histórico de empréstimos de cada usuário. 
create or replace view  HistoricoEmprestimosPorUsuario as 
select 
    U.id_usuario,
    U.nome as  nome_usuario,
    U.endereco as  endereco_usuario,
    U.contato as  contato_usuario,
    E.id_emprestimo,
    L.titulo as  titulo_livro,
    L.autor as  autor_livro,
    E.transacao,
    E.data_transacao
from Usuario U
join Emprestimo E on U.id_usuario = E.id_usuario
left join Livro L on E.id_livro = L.id_livro
order by U.id_usuario, E.data_transacao desc;