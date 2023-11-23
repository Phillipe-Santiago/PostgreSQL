INSERT INTO Categoria (descricao)
VALUES 
  ('Ficção Científica'),
  ('Romance'),
  ('Fantasia'),
  ('Mistério'),
  ('Aventura'),
  ('Não Ficção'),
  ('História'),
  ('Biografia'),
  ('Autoajuda'),
  ('Tecnologia');

INSERT INTO Livro (id_categoria, titulo, autor, ISBN, ano_publicacao) VALUES
  (1, 'Duna', 'Frank Herbert', '9780441172719', 1965),
  (2, 'Cem Anos de Solidão', 'Gabriel García Márquez', '9780061120091', 1967),
  (3, 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', '9780747532696', 1997),
  (4, 'O Assassinato de Roger Ackroyd', 'Agatha Christie', '9780008196300', 1926),
  (5, 'A Ilha do Tesouro', 'Robert Louis Stevenson', '9780192123110', 1883),
  (6, 'Uma Breve História da Humanidade', 'Yuval Noah Harari', '9788535923853', 2011),
  (7, 'Sapiens: De Animais a Deuses', 'Yuval Noah Harari', '9788535931759', 2014),
  (8, 'Elon Musk: Tesla, SpaceX e a Busca por um Futuro Fantástico', 'Ashlee Vance', '9788582366607', 2015),
  (9, 'A Cabana', 'William P. Young', '9788598455072', 2007),
  (10, '1984', 'George Orwell', '9780452284234', 1949),
  (1, 'Neuromancer', 'William Gibson', '9780441569562', 1984),
  (2, 'A Menina que Roubava Livros', 'Markus Zusak', '9788532519463', 2005),
  (3, 'O Hobbit', 'J.R.R. Tolkien', '9788535914256', 1937),
  (4, 'O Caso dos Dez Negrinhos', 'Agatha Christie', '9788501018757', 1939),
  (5, 'Viagem ao Centro da Terra', 'Júlio Verne', '9788535911125', 1864),
  (6, 'Cosmos', 'Carl Sagan', '9788535902245', 1980),
  (7, 'O Diário de Anne Frank', 'Anne Frank', '9788532269316', 1947),
  (8, 'Outliers: Fora de Série', 'Malcolm Gladwell', '9788522009232', 2008),
  (9, 'Mindset: A Nova Psicologia do Sucesso', 'Carol S. Dweck', '9788532530001', 2006),
  (10, 'O Alquimista', 'Paulo Coelho', '9788532501716', 1988);
