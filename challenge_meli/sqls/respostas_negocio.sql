
-- Início da resposta do primeiro enunciado
SELECT c.*
FROM Customer as c
INNER JOIN CustomerCustomertype as cct on c.id = cct.customer_id
INNER JOIN CustomerType ct ON cct.customer_type_id = ct.id
INNER JOIN Item i ON c.item_id = i.id
INNER JOIN Orders o on i.id = o.item_id

WHERE
    DATE_PART('month', c.date_of_birth) = DATE_PART('month', CURRENT_DATE)
    AND DATE_PART('day', c.date_of_birth) = DATE_PART('day', CURRENT_DATE)
    AND DATE_PART('year', o.purchase_date) = 2020
    AND DATE_PART('month', o.purchase_date) = 1
GROUP BY c.id
HAVING COUNT(o.id) > 1500;

-- Fim da resposta do primeiro enunciado

-- Início da resposta do segundo enunciado
SELECT
    DATE_TRUNC('month', o.purchase_date) AS month,
    EXTRACT(YEAR FROM o.purchase_date) AS year,
    c.first_name,
    COUNT(DISTINCT o.id) AS sales_quantity,
    COUNT(DISTINCT o.item_id) AS products_sold,
    SUM(o.quantity * i.price) AS total_sold
FROM
    CustomerCustomertype cct
JOIN
    Customer c ON cct.customer_id = c.id
JOIN
    Item i ON c.item_id = i.id
JOIN 
    Orders o ON i.id = o.item_id
JOIN ItemCategory ic ON i.id = ic.item_id

JOIN
    Category cat ON ic.category_id = cat.id
WHERE
    cat.id in (1,2,3)
    AND EXTRACT(YEAR FROM o.purchase_date) = 2020
GROUP BY
    DATE_TRUNC('month', o.purchase_date),
    EXTRACT(YEAR FROM o.purchase_date),
    c.id,
    c.first_name
ORDER BY
    DATE_TRUNC('month', o.purchase_date),
    SUM(o.quantity * i.price) DESC
LIMIT 5;

-- Fim da resposta do segundo enunciado


-- Início da resposta do terceiro enunciado

CREATE OR REPLACE FUNCTION item_status_change_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status <> NEW.status THEN
        -- Atualiza o Item pro novo status e seta o end_date para o dia corrente, para identificar
        -- que foi desativado
        UPDATE Item SET status_id = NEW.status_id, end_date = current_date WHERE id = NEW.id;
        
        -- Insere um novo registro na Tabela de ItemDaily, para histórico
        INSERT INTO ItemDaily (item_id, price, status_id)
        VALUES (NEW.id, NEW.price, NEW.status_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER item_status_changing
    BEFORE UPDATE ON Item
    FOR EACH ROW
    WHEN (OLD.status_id IS DISTINCT FROM NEW.status_id)
    EXECUTE FUNCTION item_status_change_trigger();


-- Fim da resposta do terceiro enunciado


airflow users create --role Admin --username lipesilva \
--firstname luis \
--lastname barros \
--email silvaluis_@outlook.com \
--password 1155995511Ff%