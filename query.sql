-- два запроса на выборку для связанных таблиц с условиями и сортировкой;
-- Выборка всех договоров, стоимость которых больше 500000

SELECT customer_full_name, contract_id, contract_price FROM contracts
INNER JOIN customer USING (customer_id)
WHERE contract_price > 500000
ORDER BY customer_full_name, contract_id;

-- Выборка данных о студентах с датой договоров:
SELECT student_full_name, contract_date_begin, contract_date_end
FROM student
INNER JOIN contracts USING (student_id);

-- два запроса с группировкой и групповыми функциями;
-- Подсчет количества заключенных договоров для заказчиков и общую сумму договоров

SELECT customer_full_name, COUNT(contract_id), SUM(contract_price) FROM contracts
INNER JOIN customer USING (customer_id)
GROUP BY customer_full_name;

-- Средняя цена договора для каждого заказчика
SELECT c2.customer_full_name, AVG(c.contract_price) AS avg_contract_price
FROM contracts c
INNER JOIN public.customer c2 USING(customer_id)
GROUP BY c2.customer_full_name
ORDER BY 1;


-- два запроса со вложенными запросами или табличными выражениями;
-- Выбрать студентов, у которых сумма договоров превышает среднюю сумму догворов:

SELECT student_full_name
FROM student
INNER JOIN contracts USING(student_id)
WHERE contract_price > (SELECT AVG(contract_price) FROM contracts);

-- Договоры с максимальной суммой у каждого студента
SELECT student_full_name, contract_price
FROM student s
INNER JOIN contracts c USING(student_id)
WHERE c.contract_price = (SELECT MAX(contract_price) FROM contracts WHERE student_id = s.student_id);


-- два запроса корректировки данных (обновление, добавление, удаление и пр)
INSERT INTO users (full_name, user_login, user_password)
VALUES ('Новый Пользователь', 'new_user', 'new_password');
INSERT INTO users_user_role (user_id, user_role_id)
VALUES (currval('users_user_id_seq'), 1);
