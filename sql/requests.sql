USE Salon;

INSERT INTO logins(login, password) VALUES('admin', '7ADC785BE4A31EFF6783871FF63E18F1');

INSERT INTO statuses(status_id, text) VALUES (1, 'Заказ создан');
INSERT INTO statuses(status_id, text) VALUES (2, 'Заказ обработан сотрудником');
INSERT INTO statuses(status_id, text) VALUES (3, 'Заказ отменен клиентом');
INSERT INTO statuses(status_id, text) VALUES (4, 'Заказ отменен сотрудником');

GO

/*# Какие функции необходимо реализовать:*/

/*## ВЫВОД*/

/*### ОДНОТАБЛИЧНЫЕ Представления*/

/*- [x] Вывод всех музыкальных записей (таблица **records**);*/

CREATE VIEW showAllRecords AS 
	SELECT record_id AS 'Артикул', title AS 'Название', author AS 'Автор', price AS 'Цена', count AS 'Количество' 
	FROM records;

GO

SELECT * FROM showAllRecords;

GO

/*- [x] Вывод всех заказов (таблица **orders**);*/

CREATE VIEW showAllOrders AS 
	SELECT order_id AS 'Номер заказа', client_id AS 'Номер клиента', employee_id AS 'Номер сотрудника', text AS 'Статус заказа',
		amount AS 'Сумма заказа', order_datetime AS 'Дата и время заказа'
	FROM orders, statuses
	WHERE orders.status_id = statuses.status_id;

GO

SELECT * FROM showAllOrders;

GO

/*- [x] Вывод всех клиентов (таблица **clients**);*/

CREATE VIEW showAllClients AS 
	SELECT client_id AS 'Номер клиента', first_name AS 'Имя', last_name AS 'Фамилия', email AS 'Электронная почта',
		address AS 'Адрес', dob AS 'Дата рождения', phone AS 'Номер телефона'
	FROM clients;

GO

SELECT * FROM showAllClients;

GO

/*- [x] Вывод всех отзывов (таблица **reviews**);*/

CREATE VIEW showAllReviews AS 
	SELECT review_id AS 'Номер отзыва', reviews.record_id AS 'Артикул', title AS 'Название записи',
		client_id AS 'Номер клиента', text AS 'Текст рекомендации'
	FROM reviews, records
	WHERE reviews.record_id = records.record_id;

GO

SELECT * FROM showAllReviews;

GO

/*- [x] Вывод всех рекомендаций (таблица **recommendations**);*/

CREATE VIEW showAllRecommendations AS 
	SELECT recommendation_id AS 'Номер рекомендации', employee_id AS 'Номер сотрудника', client_id AS 'Номер клиента',
		text AS 'Текст рекомендации', recommendation_datetime AS 'Дата и время рекомендации'
	FROM recommendations;

GO

SELECT * FROM showAllRecommendations;

GO

/*- [x] Вывод всех сотрудников (таблица **employees**);*/

CREATE VIEW showAllEmployees AS 
	SELECT employee_id AS 'Номер сотрудника', first_name AS 'Имя', last_name AS 'Фамилия',
		salary AS 'Зарплата'
	FROM employees;

GO

SELECT * FROM showAllEmployees;

GO

/*- [x] Вывод всех статусов (таблица **statuses**);*/

CREATE VIEW showAllStatuses AS 
	SELECT text AS 'Текст статуса'
	FROM statuses;

GO

SELECT * FROM showAllStatuses;

GO


/*### ОДНОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Вывод всех заказов конкретного клиента (email) (таблица **orders**);*/

CREATE PROCEDURE showOrdersByClientEmail(@email AS NVARCHAR(50)) AS
	SELECT order_id AS 'Номер заказа', client_id AS 'Номер клиента', employee_id AS 'Номер сотрудника',
		text AS 'Статус заказа', amount AS 'Сумма заказа', order_datetime AS 'Дата и время заказа'
	FROM orders, statuses
	WHERE orders.client_id = (SELECT client_id FROM clients WHERE clients.email = @email)
		AND orders.status_id = statuses.status_id;

GO

EXEC showOrdersByClientEmail 'pupkin@gmail.com';

EXEC showOrdersByClientEmail 'ivanov@mail.ru';

GO

/*- [x] Вывод всех заказов конкретного клиента (id клиента) (таблица **orders**);*/

CREATE PROCEDURE showOrdersByClientId(@client_id AS int) AS
	SELECT order_id AS 'Номер заказа', client_id AS 'Номер клиента', employee_id AS 'Номер сотрудника',
		text AS 'Статус заказа', amount AS 'Сумма заказа', order_datetime AS 'Дата и время заказа'
	FROM orders, statuses
	WHERE orders.client_id = @client_id
		AND orders.status_id = statuses.status_id;

GO

EXEC showOrdersByClientId 1;

EXEC showOrdersByClientId 2;

GO

/*- [x] Вывод отзывов к конкретной музыкальной записи (id музыкальной записи) (таблица **reviews**);*/

CREATE PROCEDURE showReviewsOfRecord(@record_id AS int) AS
	SELECT review_id AS 'Номер отзыва', reviews.record_id AS 'Артикул', title AS 'Название',
		author AS 'Автор', text AS 'Текст рекомендации'
	FROM reviews, records
	WHERE reviews.record_id = @record_id AND records.record_id = @record_id;

GO

EXEC showReviewsOfRecord 2;

GO

/*### МНОГОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Вывод конкретного заказа (id заказа) (таблицы **orders**, **orders_records**);*/

CREATE PROCEDURE showOrderById(@order_id AS int) AS
	SELECT orders.order_id AS 'Номер заказа', orders.client_id AS 'Номер клиента', orders.employee_id AS 'Номер сотрудника',
	statuses.text AS 'Статус заказа', orders.amount AS 'Сумма заказа', orders.order_datetime AS 'Дата и время заказа',
	orders_records.record_id AS 'Артикул', title AS 'Название', author AS 'Автор', orders_records.count AS 'Количество'
	FROM orders
		JOIN orders_records ON orders_records.order_id = orders.order_id
		JOIN statuses ON orders.status_id = statuses.status_id
		JOIN records ON records.record_id = orders_records.record_id
		WHERE orders.order_id = @order_id;

GO

EXEC showOrderById 2;

GO

/*- [x] Вывод всех рекомендаций конкретному клиенту (id клиента) (таблицы **recommendations**, **recommendations_records**);*/

CREATE PROCEDURE showRecommendationsOfClient(@client_id AS int) AS
	SELECT text AS 'Текст рекомендации', recommendations_records.record_id AS 'Артикул',
		title AS 'Название', author AS 'Автор', employee_id FROM recommendations
		JOIN recommendations_records ON recommendations_records.recommendation_id = recommendations.recommendation_id
		JOIN records ON records.record_id = recommendations_records.record_id
		WHERE recommendations.client_id = @client_id
		ORDER BY recommendations.recommendation_id;

GO

EXEC showRecommendationsOfClient 1;

GO

/*****/

/*## ДОБАВЛЕНИЕ*/

/*### ОДНОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Добавление музыкальной записи (title, author, price, count) (таблица **records**);*/

CREATE PROCEDURE addRecord(@title AS NVARCHAR(50), @author AS NVARCHAR(50), @price AS money, @count AS int) AS
	INSERT INTO records(title, author, price, count) VALUES (@title, @author, @price, @count);

GO

EXEC addRecord 'Smoke on the water', 'Deep Purpule', 100.0, 300;
EXEC addRecord 'Бесполезно', 'Валентин Стрыкало', 90.0, 50;
EXEC addRecord '25 к 10', 'Аквариум', 70.22, 30;
EXEC addRecord 'Hey you', 'Pink Floyd', 101.2, 10;

GO

/*- [x] Добавление рекомендации (id сотрудника, id клиента, text) (таблица **recommendations**);*/

CREATE PROCEDURE addRecommendation(@employee_id AS int, @client_id AS int, @text as NTEXT) AS
	INSERT INTO recommendations(employee_id, client_id, text, recommendation_datetime) VALUES
	(@employee_id, @client_id, @text, GETDATE());

GO

EXEC addRecommendation 1, 1, 'Очень рекомендую послушать!';

EXEC addRecommendation 2, 2, 'Ненавижу свою работу...';

GO

/*- [x] Добавление музыкальной записи в рекомендацию (id рекомендации, id добавляемой музыкальной записи) (таблица **recommendations_records**);*/

CREATE PROCEDURE addRecordToRecommendation(@recommendation_id AS int, @record_id AS int) AS
	INSERT INTO recommendations_records(recommendation_id, record_id) VALUES
	(@recommendation_id, @record_id);

GO

EXEC addRecordToRecommendation 1, 1;
EXEC addRecordToRecommendation 1, 2;
EXEC addRecordToRecommendation 1, 3;

EXEC addRecordToRecommendation 2, 1;

GO

/*- [x] Добавление отзыва (id музыкальной записи, text) (таблица **reviews**);*/

CREATE PROCEDURE addReview(@record_id AS int, @client_id AS int, @text AS NTEXT) AS
	INSERT INTO reviews(record_id, client_id, text) VALUES (@record_id, @client_id, @text);

GO

EXEC addReview 2, 1, 'Теперь это моя любимая песня!';
EXEC addReview 1, 2, 'Рок - отстой!';

GO

/*- [x] Добавление заказа (id клиента) (таблица **orders**);*/

CREATE PROCEDURE addOrder(@client_id AS int) AS
	INSERT INTO orders(client_id, status_id, amount, order_datetime) VALUES
	(@client_id, 1, 0, GETDATE());

GO

EXEC addOrder 1;
EXEC addOrder 2;
EXEC addOrder 1;

GO

/*### МНОГОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Добавление сотрудника (first_name, last_name, salary, login, password) (таблицы **logins**, **employees**);*/

CREATE PROCEDURE addEmployee(@first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50),
	@salary AS money, @login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			INSERT INTO logins(login, password) VALUES(@login, @password)

			DECLARE @login_id int = @@IDENTITY;

			INSERT INTO employees(first_name, last_name, salary, login_id) VALUES
				(@first_name, @last_name, @salary, @login_id)

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

EXEC addEmployee 'Хороший', 'Продавец', 30000.00, 'good_prod', 'A970E5EF63B96E6387605932F290AF7D';

EXEC addEmployee 'Плохой', 'Продавец', 14999.99, 'bad_prod', 'C25E6F53264D6DACB6504E7637909DE3';

GO

/*- [x] Добавление музыкальной записи в заказ (id заказа, id музыкальной записи, count) (таблицы **orders**, **orders_records**, **records**);*/

CREATE PROCEDURE addRecordToOrder(@order_id AS int, @record_id AS int, @count AS int) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			DECLARE @record_count int = (SELECT records.count FROM records WHERE records.record_id = @record_id);
			DECLARE @record_price money = (SELECT records.price FROM records WHERE records.record_id = @record_id);
			DECLARE @order_amount money = (SELECT orders.amount FROM orders WHERE orders.order_id = @order_id);
			DECLARE @order_status int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

			IF (@order_status != 1)
			BEGIN
				THROW 50000, 'Невозможно добавить записи в завершенный заказ', 1;
			END

			IF (@count > @record_count)
			BEGIN
				THROW 50000, 'Недостаточно музыкальных записей на складе', 1;
			END

			UPDATE records
			SET
				records.count = @record_count - @count
			WHERE
				records.record_id = @record_id

			UPDATE orders
			SET
				orders.amount = @order_amount + (@record_price * @count)
			WHERE
				orders.order_id = @order_id;

			IF (EXISTS (SELECT * FROM orders_records WHERE orders_records.order_id = @order_id AND orders_records.record_id = @record_id))
			BEGIN
				DECLARE @orders_records_count money = (SELECT orders_records.count FROM orders_records
					WHERE orders_records.order_id = @order_id AND orders_records.record_id = @record_id);
				UPDATE orders_records
				SET
					orders_records.count = @orders_records_count + @count
				WHERE
					orders_records.order_id = @order_id AND orders_records.record_id = @record_id;
			END
			ELSE
			BEGIN
				INSERT INTO orders_records(order_id, record_id, count) VALUES (@order_id, @record_id, @count)
			END
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

EXEC addRecordToOrder 1, 1, 1000;

EXEC addREcordToOrder 2, 1, 5;
EXEC addREcordToOrder 2, 2, 5;
EXEC addREcordToOrder 2, 3, 5;


EXEC addREcordToOrder 3, 1, 2;
EXEC addREcordToOrder 3, 2, 2;
EXEC addREcordToOrder 3, 3, 2;

GO

/*- [x] Добавление клиента (first_name, last_name, email, login, password, address, dob, phone) (таблицы **clients**, **logins**);*/

CREATE PROCEDURE addClient(@first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50), @email AS NVARCHAR(50), @login AS NVARCHAR(50),
	@password AS NVARCHAR(50), @address AS NVARCHAR(50), @dob AS date, @phone AS NCHAR(11)) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			INSERT INTO logins(login, password) VALUES(@login, @password)

			DECLARE @login_id int = @@IDENTITY;

			INSERT INTO clients(first_name, last_name, email, address, login_id, dob, phone) VALUES
				(@first_name, @last_name, @email, @address, @login_id, @dob, @phone)
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

EXEC addClient 'Вася', 'Пупкин', 'pupkin@gmail.com', 'pupkin', 'B25BDC597954A89BD11B907004890A1D', 'Адрес Пупкина', '2000-10-20', 79876543210;

EXEC addClient 'Иван', 'Иваноv', 'ivanov@mail.ru', 'ivanov', '828693DFD5EB38CEA6BEFAC467E0BB88', 'Адрес Иванова', '2000-10-21', 70123456789;

GO

/*****/

/*## ИЗМЕНЕНИЕ*/

/*### ОДНОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Изменение данных музыкальной записи (id музыкальной записи, title, author, price, count) (таблица **records**);*/

CREATE PROCEDURE updateRecord(@record_id AS int, @title AS NVARCHAR(50), @author AS NVARCHAR(50), @price AS MONEY, @count AS int) AS
	UPDATE records
	SET
		records.title = @title,
		records.author = @author,
		records.price = @price,
		records.count = @count
	WHERE
		records.record_id = @record_id;

GO

EXEC updateRecord 1, 'Smoke on the water', 'Deep Purpule', 100.0, 100;
EXEC updateRecord 2, 'Бесполезно', 'Валентин Стрыкало', 90.0, 200;
EXEC updateRecord 3, '25 к 10', 'Аквариум', 70.22, 300;
EXEC updateRecord 4, 'Hey you', 'Pink Floyd', 101.2, 300;

GO

/*- [x] Изменение данных авторизации администратора (login, password) (таблица **logins**);*/

CREATE PROCEDURE updateAdmin(@login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
	UPDATE logins
	SET
		logins.login = @login,
		logins.password = @password
	WHERE logins.login_id = 1;

GO

EXEC updateAdmin 'admin', '7ADC785BE4A31EFF6783871FF63E18F1';

GO

/*- [x] Изменение текста рекомендации (id рекомендации, text) (таблица **recommendations**);*/

CREATE PROCEDURE updateRecommendationText(@recommendation_id AS int, @text AS NTEXT) AS
	UPDATE recommendations
	SET
		recommendations.text = @text
	WHERE
		recommendations.recommendation_id = @recommendation_id;

GO

EXEC updateRecommendationText 2, 'Ненавижу свою работу!';

GO

/*- [x] Изменение статуса заказа (id заказа, id статуса) (таблица **orders**);*/

CREATE PROCEDURE updateStatusByClient(@order_id AS int, @status_id AS int) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			DECLARE @current_status_id int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

			IF (@current_status_id = '3' OR @current_status_id = '4')
			BEGIN
				THROW 50000, 'Заказ был отменен, его статус не изменить', 1;
			END

			IF (@current_status_id = '2')
			BEGIN
				THROW 50000, 'Заказ был обработан, его статус не изменить', 1;
			END

			IF (@status_id = '1')
			BEGIN
				THROW 50000, 'Статус созданного заказа невозможно изменить вручную', 1;
			END

			IF (@status_id = '3' OR @status_id = '4')
			BEGIN
				DECLARE @cursor CURSOR;
				DECLARE @record_id int;

				SET @cursor = CURSOR FOR SELECT orders_records.record_id FROM orders_records WHERE orders_records.order_id = @order_id;

				OPEN @cursor
				FETCH NEXT FROM @cursor INTO @record_id;

				WHILE @@FETCH_STATUS = 0
				BEGIN
					DECLARE @current_count int = (SELECT records.count FROM records WHERE records.record_id = @record_id);

					UPDATE records
					SET
						records.count = @current_count +
						(SELECT orders_records.count FROM orders_records WHERE orders_records.order_id = @order_id AND orders_records.record_id = @record_id)
					WHERE
						records.record_id = @record_id;

					FETCH NEXT FROM @cursor INTO @record_id
				END;

				CLOSE @cursor;
				DEALLOCATE @cursor;
			END

			UPDATE orders
			SET
				orders.status_id = @status_id
			WHERE
				orders.order_id = @order_id;
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

CREATE PROCEDURE updateStatusByEmployee(@order_id AS int, @status_id AS int, @employee_id AS int) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			DECLARE @current_status_id int = (SELECT orders.status_id FROM orders WHERE orders.order_id = @order_id);

			IF (@current_status_id = '3' OR @current_status_id = '4')
			BEGIN
				THROW 50000, 'Заказ был отменен, его статус не изменить', 1;
			END

			IF (@current_status_id = '2')
			BEGIN
				THROW 50000, 'Заказ был обработан, его статус не изменить', 1;
			END

			IF (@status_id = '1')
			BEGIN
				THROW 50000, 'Статус созданного заказа невозможно изменить вручную', 1;
			END

			IF (@status_id = '3' OR @status_id = '4')
			BEGIN
				DECLARE @cursor CURSOR;
				DECLARE @record_id int;

				SET @cursor = CURSOR FOR SELECT orders_records.record_id FROM orders_records WHERE orders_records.order_id = @order_id;

				OPEN @cursor
				FETCH NEXT FROM @cursor INTO @record_id;

				WHILE @@FETCH_STATUS = 0
				BEGIN
					DECLARE @current_count int = (SELECT records.count FROM records WHERE records.record_id = @record_id);

					UPDATE records
					SET
						records.count = @current_count +
						(SELECT orders_records.count FROM orders_records WHERE orders_records.order_id = @order_id AND orders_records.record_id = @record_id)
					WHERE
						records.record_id = @record_id;

					FETCH NEXT FROM @cursor INTO @record_id
				END;

				CLOSE @cursor;
				DEALLOCATE @cursor;
			END

			UPDATE orders
			SET
				orders.status_id = @status_id,
				orders.employee_id = @employee_id
			WHERE
				orders.order_id = @order_id;
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO


EXEC updateStatusByEmployee 1, 2, 1;
EXEC updateStatusByEmployee 2, 4, 2;
EXEC updateStatusByClient 3, 3;

GO

/*### МНОГОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Изменение данных сотрудника (id сотрудника, first_name, last_name, salary, login, password) (таблицы **logins**, **employees**);*/

CREATE PROCEDURE updateEmployee(@employee_id AS int, @first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50),
	@salary AS money, @login AS NVARCHAR(50), @password AS NVARCHAR(50)) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			DECLARE @login_id int = (SELECT employees.login_id FROM employees WHERE employees.employee_id = @employee_id);

			UPDATE logins
			SET
				logins.login = @login,
				logins.password = @password
			WHERE
				logins.login_id = @login_id;


			UPDATE employees
			SET
				employees.first_name = @first_name,
				employees.last_name = @last_name,
				employees.salary = @salary
			WHERE
				employees.employee_id = @employee_id;
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

EXEC updateEmployee 2, 'Плохой', 'Продавец', 15000.0, 'bad_prod', 'C25E6F53264D6DACB6504E7637909DE3';
EXEC updateEmployee 2, 'Плохой', 'Продавец', 15000.0, 'good_prod', 'C25E6F53264D6DACB6504E7637909DE3';

GO

/*- [x] Изменение данных клиента (id клиента, first_name, last_name, email, login, password, address, dob, phone) (таблицы **clients**, **logins**);*/

CREATE PROCEDURE updateClient(@client_id AS int, @first_name AS NVARCHAR(50), @last_name AS NVARCHAR(50), @email AS NVARCHAR(50), @login AS NVARCHAR(50),
	@password AS NVARCHAR(50), @address AS NVARCHAR(50), @dob AS date, @phone AS NCHAR(11)) AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION;

			DECLARE @login_id int = (SELECT clients.login_id FROM clients WHERE clients.client_id = @client_id);

			UPDATE logins
			SET
				logins.login = @login,
				logins.password = @password
			WHERE
				logins.login_id = @login_id;

			UPDATE clients
			SET
				clients.first_name = @first_name,
				clients.last_name = @last_name,
				clients.email = @email,
				clients.address = @address,
				clients.dob = @dob,
				clients.phone = @phone
			WHERE
				clients.client_id = @client_id;
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW
		END CATCH
	END;

GO

EXEC updateClient 1, 'Василий', 'Пупкин', 'pupkin@gmail.com', 'pupkin', 'B25BDC597954A89BD11B907004890A1D', 'Адрес Пупкина', '2000-10-20', 79876543210;
EXEC updateClient 1, 'Василий', 'Пупкин', 'pupkin@gmail.com', 'ivanov', 'B25BDC597954A89BD11B907004890A1D', 'Адрес Пупкина', '2000-10-20', 79876543210;

GO

/*****/

/*## УДАЛЕНИЕ*/

/*### ОДНОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Удаление отзыва (id отзыва) (таблица **reviews**);*/

CREATE PROCEDURE removeReview(@review_id AS int) AS
	DELETE FROM reviews WHERE review_id = @review_id;

GO

EXEC removeReview 3;

GO

/*- [x] Удаление музыкальной записи (id музыкальной записи) (таблица **records**);*/

CREATE PROCEDURE removeRecord(@record_id AS INT) AS
	UPDATE records
	SET
		records.count = 0
	WHERE
		records.record_id = @record_id;

GO

EXEC removeRecord 1;

GO

/*- [x] Удаление музыкальной записи из рекомендации (id рекомендации, id удаляемой музыкальной записи (таблица **recommendations_records**);*/

CREATE PROCEDURE removeRecordFromRecommendation(@recommendation_id AS int, @record_id AS int) AS
	DELETE FROM recommendations_records WHERE
	recommendations_records.recommendation_id = @recommendation_id AND recommendations_records.record_id = @record_id;

GO

EXEC removeRecordFromRecommendation 1, 2;

GO

/*### МНОГОТАБЛИЧНЫЕ Хранимые процедуры*/

/*- [x] Удаление рекомендации (id рекомендации) (таблицы **recommendations**, **recommendations_records**);*/

CREATE PROCEDURE removeRecommendation(@recommendation_id AS int) AS
	DELETE FROM recommendations_records WHERE recommendations_records.recommendation_id = @recommendation_id
	DELETE FROM recommendations WHERE recommendations.recommendation_id = @recommendation_id;

GO

EXEC removeRecommendation 2;

GO
