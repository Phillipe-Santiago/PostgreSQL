create view LivrosCategoria as
select livro.titulo, categoria.descricao 
from livro
join categoria on categoria.id_categoria = livro.id_categoria