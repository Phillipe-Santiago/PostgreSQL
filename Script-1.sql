CREATE FUNCTION CheckDisponibilidadeLivro(livro_id INTEGER) RETURNS BOOLEAN AS 
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


--Chamadas das procedures
SELECT CheckDisponibilidadeLivro(1); --Retorna false pois o livre esta emprestado
SELECT CheckDisponibilidadeLivro(2); --Retorna true pois o livre esta disponivel
SELECT CheckDisponibilidadeLivro(3); --Retorna false pois o livre esta em manutencao

/*
CREATE PROCEDURE RegistrarEmprestimo(
    IN p_usuario_id INTEGER,
    IN p_livro_id INTEGER,
    OUT p_emprestimo_id INTEGER,
    OUT p_sucesso BOOLEAN
)
LANGUAGE plpgsql
AS $$
DECLARE
    livro_disponivel BOOLEAN;
BEGIN
    -- Verificar a disponibilidade do livro usando a função CheckDisponibilidadeLivro
	livro_disponivel = 'select CheckDisponibilidadeLivro('||p_livro_id||')'INTO livro_disponivel;

    IF livro_disponivel THEN
        -- Inserir novo empréstimo
        INSERT INTO Emprestimo (id_livro, id_usuario, data_emprestimo, data_devolucao_esperada)
        VALUES (p_livro_id, p_usuario_id, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days')
        RETURNING id_emprestimo INTO p_emprestimo_id;

        -- Atualizar o status do livro para 'emprestado'
        UPDATE StatusLivro
        SET status = 'emprestado'
        WHERE id_livro = p_livro_id;

        -- Definir sucesso como TRUE
        p_sucesso := TRUE;
    ELSE
        -- Definir sucesso como FALSE se o livro não estiver disponível
        p_sucesso := FALSE;
    END IF;
END;
$$;

select RegistrarEmprestimo(1, 3, p_emprestimo_id, p_sucesso);
*/
