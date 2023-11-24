/* -------------------------------------------------------------------------------------
 * FUNÇÃO PARA CHECAR DISPONIBILIDADE DE UM LIVRO
 * 
 * RETURNS 
 *     TRUE - EM CASO DO STATUS DO LIVRO ESTAR COMO 'disponivel'
 *     FALSE - EM CASO DO STATUS DO LIVRO ESTAR COMO 'emprestado' OU 'manutencao'
 * -------------------------------------------------------------------------------------
 * */

CREATE or replace FUNCTION CheckDisponibilidadeLivro(livro_id INTEGER) RETURNS BOOLEAN AS 
$$
DECLARE
    livro_status VARCHAR(50);
    disponivel BOOLEAN;
BEGIN
    -- Obter o status do livro da tabela StatusLivro
    SELECT status
    INTO livro_status
    FROM StatusLivro
    WHERE id_livro = livro_id;

    -- Verificar o status e definir a disponibilidade
    disponivel := CASE
        WHEN livro_status = 'disponivel' THEN TRUE
        WHEN livro_status = 'emprestado' THEN FALSE
        WHEN livro_status = 'manutencao' THEN FALSE
        ELSE NULL -- Retornar NULL para outros valores de status
    END;

    -- Retornar a disponibilidade
    RETURN disponivel;
END;
$$ LANGUAGE plpgsql;

/* -------------------------------------------------------------------------------------
 * PROCEDURE QUE REGISTRA O EMPRESTIMO DE UM LIVRO
 * 
 * 1 - CHECA SUA DISPONIBILIDADE.
 * 2 - CASO ESTEJA DISPONIVEL REALIZA UM INSERT NA TABELA EMPRESTIMO PASSANDO
 * 	   O ID DO LIVRO, O ID DO USUARIO, O TIPO DE TRANSAÇÃO ('Emprestimo' OU 'Devolucao')
 *     E A DATA DO DIA UTILIZANDO CURRENT_DATE.
 * 3 - ATUALIZA A TABELA STATUS DO LIVRO COM A INFROMACAO DE STATUS = 'emprestado' 
 * 	   UTILIZANDO O ID DO LIVRO.
 * ------------------------------------------------------------------------------------- 
 * */

CREATE or replace PROCEDURE RegistrarEmprestimo(livro_id INTEGER, usuario_id INTEGER)
AS $$
DECLARE
	livro_disponivel BOOLEAN;
	data_hoje DATE;
BEGIN
	livro_disponivel := CheckDisponibilidadeLivro(livro_id);
	data_hoje := CURRENT_DATE;

	--Condição criada para se um livro estiver disponível, troca para 'Emprestimo'
	IF livro_disponivel THEN
		INSERT INTO Emprestimo (id_livro, id_usuario, transacao, data_transacao)
		VALUES (livro_id, usuario_id, 'Emprestimo', data_hoje);
		
		--Implementar update no statuslivro
		update statuslivro set status = 'emprestado' where id_livro = livro_id;
	
	end if;
end
$$ LANGUAGE plpgsql;

/* -------------------------------------------------------------------------------------
 * PROCEDURE QUE REGISTRA A DEVOLUCAO DE UM LIVRO
 * 
 * 1 - REALIZA UM INSERT NA TABELA EMPRESTIMO PASSANDO O ID DO LIVRO, O ID DO USUARIO, 
 * 	   O TIPO DE TRANSAÇÃO ('Emprestimo' OU 'Devolucao') E A DATA DO DIA UTILIZANDO 
 * 	   CURRENT_DATE.
 * 2 - ATUALIZA A TABELA STATUS DO LIVRO COM A INFROMACAO DE STATUS = 'emprestado' 
 * 	   UTILIZANDO O ID DO LIVRO.
 * -------------------------------------------------------------------------------------
 * */

create or replace procedure RegistrarDevolucao(livro_id INTEGER, usuario_id INTEGER)
as $$
declare
	data_hoje DATE;
begin
	data_hoje := CURRENT_DATE;

	--
	insert into emprestimo (id_livro, id_usuario, transacao, data_transacao)
	values (livro_id, usuario_id, 'Devolucao', data_hoje);

	update statuslivro set status = 'disponivel' where id_livro = livro_id;
end
$$ language plpgsql;

create or replace function LogTransacoes()
returns trigger
as $$
begin
	insert into LogEmprestimoDevolucao (id_emprestimo, id_livro, data_devolucao)
	values (new.id_emprestimo, new.id_livro, now());

	return new;
end;
$$ language plpgsql;

--Trigger responsavel por atualizar o log quando for inserido valores na tabela emprestimo

create trigger LogEmprestimoDevolucao
after insert 
on Emprestimo
for each row
execute procedure LogTransacoes();

--Chamadas das procedures
SELECT CheckDisponibilidadeLivro(1); --Retorna false pois o livre esta emprestado
SELECT CheckDisponibilidadeLivro(2); --Retorna true pois o livre esta disponivel
SELECT CheckDisponibilidadeLivro(3); --Retorna false pois o livre esta em manutencao

select * from usuario;


call RegistrarEmprestimo(2, 1);
call registrardevolucao(2, 1);
