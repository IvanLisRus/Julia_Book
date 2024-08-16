--
-- Файл сгенерирован с помощью SQLiteStudio v3.0.7 в Пн май 30 12:04:31 2016
--
-- Использованная кодировка текста: windows-1251
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Таблица: quotes
CREATE TABLE quotes ( id integer NOT NULL, cid integer NOT NULL, author varchar(100), quoname varchar(250) NOT NULL, PRIMARY KEY(id) )
INSERT INTO quotes (id, cid, author, quoname) VALUES (1, 1, 'Поль Валери', 'Никогда не судите о человеке по его друзьям. У Иуды они были безупречны.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (2, 2, 'Ноэли Альтито', 'Кратчайшее расстояние между двумя точками находится на реконструкции.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (3, 1, 'Жюль Ренар', 'Если бы строили дом счастья, самую большую комнату пришлось бы отвести под зал ожидания.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (4, 2, 'Принцип Шоу ', 'Создайте систему, которой сможет воспользоваться даже дурак, и только дурак захочет ею пользоваться.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (5, 3, 'Адольф Гитлер', 'Массы людей скорее поверят в большую ложь, нежели в маленькую.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (6, 2, 'Фрэнк Заппа', 'Два элемента, которые наиболее часто встречаются во Вселенной, - водород и глупость.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (7, 4, 'Закон Хеллера', 'Первый миф относительно управления состоит в том, что оно существует.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (8, 5, NULL, 'Существуют два способа написания безошибочных программ.  И только третий работает.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (9, 2, 'Кредо Фингла', 'Наука - истинна. Не верьте фактам.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (10, 4, NULL, 'Сегодня - это завтрашний день, о котором вы беспокоились вчера.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (11, 5, NULL, 'Если за ошибку в расчёте отвечает больше одного человека, виноватых не найти.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (12, 1, 'Оскар Уайльд', 'Единственный способ избавиться от искушения - это поддаться ему.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (13, 1, 'Денис Иванович Фонвизин', 'У кого чаще всех Господь на языке, у того чёрт на сердце.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (14, 3, 'Альберт Эйнштейн', 'Я не знаю каким оружием человек будет вести третью мировую войну, но четвертая будет с палкой и камнем.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (15, 4, 'Закон Ван Роя', 'Любовь с первого взгляда - это величайшее трудосберегающее изобретение, которое мир когда-либо видел.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (16, 1, 'Ирвин Уэлш', 'Говорят, что правда освобождает, но это, по-моему, эгоистичная чушь. Того, кто откровенничает, она, может, и освобождает, а тем, кто слушает, практически всегда приходится страдать.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (17, 5, NULL, 'Старые программисты никогда не умирают.  Они просто переходят по оператору ветвления на новый адрес.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (18, 5, 'Стив Джобс', 'Невозможно создать хороший продукт, основываясь на опросах людей или пользуясь фокус-группами. Люди сами не знают чего они хотят, пока им это не покажешь.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (19, 1, 'Марк Твен', 'Быть хорошим - это так изнашивает человека!');
INSERT INTO quotes (id, cid, author, quoname) VALUES (20, 5, NULL, 'В любой иерархической системе каждый служащий стремиться достичь своего уровня некомпетентности.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (21, 6, 'Фрэнсис Бэкон', 'Ковыляющий по прямой дороге опередит бегущего, который сбился с пути.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (22, 4, 'Эвелин Холл', 'Я не согласен ни с одним словом, которое вы говорите, но готов умереть за ваше право это говорить.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (23, 1, 'Мэрилин Монро', 'Карьера - чудесная вещь, но она никого не может согреть в холодную ночь.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (24, 1, 'Оскар Уайльд', 'Любовь к себе - это начало романа, который длится всю жизнь.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (25, 1, 'Оскар Уайльд', 'Все мы погрязли в болоте, но некоторые из нас смотрят на звезды.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (26, 4, 'Михаил Николаевич Задорнов', 'Иногда движение вперед является результатом пинка сзади.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (27, 1, 'Льюис Кэрролл', 'Подумать только, что из-за какой-то вещи можно так уменьшиться, что превратиться в ничто.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (28, 1, 'Льюис Кэрролл', 'Думай о смысле, а слова придут сами.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (29, 1, 'Льюис Кэрролл', 'Знаешь, одна из самых серьезных потерь в битве - это потеря головы.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (30, 4, 'Александр Дюма (отец)', 'Все обобщения опасны, включая это.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (31, 2, 'Альберт Эйнштейн', 'Настоящий признак интеллекта - не знания, а воображение.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (32, 6, 'Аристофан', 'Нельзя научить краба ходить прямо.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (33, 6, 'Сократ', 'Истинное знание - в признании, что ничего не знаешь (я знаю то, что ничего не знаю).');
INSERT INTO quotes (id, cid, author, quoname) VALUES (34, 6, 'Эврипид', 'Кого бог хочет погубить, того он прежде всего лишает разума.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (35, 6, 'Конфуций', 'Выберите себе работу по душе, и вам не придётся работать ни одного дня в своей жизни.');
INSERT INTO quotes (id, cid, author, quoname) VALUES (36, 2, 'Томас Хаксли', 'Великая трагедия науки - уродливый факт способен погубить прекрасную гипотезу.');

-- Таблица: categories
CREATE TABLE categories ( id integer NOT NULL, catname varchar(40) NOT NULL, PRIMARY KEY(id) )
INSERT INTO categories (id, catname) VALUES (1, 'Литература и театр');
INSERT INTO categories (id, catname) VALUES (2, 'Естественная наука');
INSERT INTO categories (id, catname) VALUES (3, 'Политика');
INSERT INTO categories (id, catname) VALUES (4, 'Житейская мудрость');
INSERT INTO categories (id, catname) VALUES (5, 'Информатика');
INSERT INTO categories (id, catname) VALUES (6, 'Классика');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
