create table Movie(mID int, title text, year int, director text); 
create table Reviewer(rID int, name text); 
create table Rating(rID int, mID int, stars int, ratingDate date);

1) Некоторые оценки не имеют даты. Найти имена всех экспертов, 
имеющих оценки без даты, отсортировать по алфавиту.
select name
from Reviewer
left join Rating
on Reviewer.rID = Rating.rID
where Rating.ratingDate is null
order by name;

2) Найти имена всех экспертов, которые поставили три или более оценок, 
сортировка по алфавиту.
select Reviewer.name
from Reviewer
left join Rating on Rating.rID=Reviewer.rID
group by Reviewer.name
having count(name) >=3;

3) Выберите всех экспертов и названия фильмов в едином списке в алфавитном порядке
select name from Reviewer
union select title from Movie
order by name;

4) Найти имена всех экспертов, кто оценил "Gone with the Wind", отсортировать по алфавиту.
select distinct Reviewer.name
from Reviewer
left join Rating on Rating.rID = Reviewer.rID
left join Movie on Movie.mID = Rating.mID
where Movie.title = "Gone with the Wind"
order by Reviewer.name;

5) Найти названия всех фильмов которые не имеют рейтинга, отсортировать по алфавиту.
select distinct Movie.title
from Movie
left join Rating on Rating.mID = Movie.mID
where Rating.stars is null
order by title;

6) Выберите названия всех фильмов, по алфавиту, которым не поставил оценку 'Chris Jackson'.
select distinct Movie.title
from Movie
left join Rating on Rating.mID = Movie.mID
left join Reviewer on Rating.rID = Reviewer.rID
where Reviewer.name != 'Chris Jackson'
НЕВЕРНО!

7) Для каждого фильма, выбрать название и "разброс оценок", 
то есть, разницу между самой высокой и самой низкой оценками для этого фильма. 
Сортировать по "разбросу оценок" от высшего к низшему, и по названию фильма.
select Movie.title, (MAX(Rating.stars) - MIN(Rating.stars)) as delta
from Movie
left join Rating on Movie.mID=Rating.mID
group by Movie.title
order by delta desc, Movie.title;

8) Для каждой оценки, где эксперт тот же человек что и режиссер, 
выбрать имя, название фильма и оценку, отсортировать по имени, названию фильма и оценке
select Reviewer.name, Movie.title, Rating.stars
from Movie
left join Rating on Movie.mID = Rating.mID
left join Reviewer on Reviewer.rID = Rating.rID
where Reviewer.name = Movie.director
order by Reviewer.name, Movie.title, Rating.stars;
можно еще добавить сортировку

9) Некоторые режиссеры сняли более чем один фильм. Для всех таких режиссеров,
выбрать названия всех фильмов режиссера, его имя. Сортировка по имени режиссера. 
Пример: Titanic,Avatar | James Cameron

10) Для всех случаев когда один эксперт оценивал фильм дважды и указал лучший рейтинг второй раз, 
выведите имя эксперта и название фильма, отсортировав по имени, затем по названию фильма.
select Reviewer.name, Movie.title
from Rating
left join Reviewer on Reviewer.rID = Rating.rID
left join Movie on Movie.mID = Rating.mID
group by Reviewer.name
having (count(name)=2)&(MAX(Rating.rID))
order by Reviewer.name, Movie.title;
можно еще добавить сортировку

11) Напишите запрос возвращающий информацию о рейтингах в более читаемом формате: 
имя эксперта, название фильма, оценка и дата оценки. 
Отсортируйте данные по имени эксперта, затем названию фильма и наконец оценка
select Reviewer.name, Movie.title, Rating.stars, Rating.ratingDate
from Rating
left join Reviewer on Reviewer.riD=Rating.rID
left join Movie on Movie.mID = Rating.mID
order by Reviewer.name, Movie.title, Rating.stars;

12) Найти разницу между средней оценкой фильмов выпущенных до 1980 года, 
а средней оценкой фильмов выпущенных после 1980 года. 
(Убедитесь, что для расчета используете среднюю оценку для каждого фильма. 
Не просто среднюю оценку фильмов до и после 1980 года.)
SELECT AVG(rate2) - AVG(rate1) rate 
FROM 
(
	SELECT AVG(stars) rate1 
	FROM Rating r 
	LEFT JOIN Movie m ON m.mID = r.mID 
	WHERE m.year >= 1980 
	GROUP BY m.title
) t1 
JOIN ( 
	SELECT AVG(stars) rate2 
	FROM Rating r 
	LEFT JOIN Movie m 
	ON m.mID = r.mID 
	WHERE m.year < 1980 
	GROUP BY m.title
) t2;

13) Для всех пар экспертов, если оба оценили один и тот же фильм, выбрать имена обоих. 
Устранить дубликаты, проверить отсутствие пар самих с собой и включать каждую пару только 1 раз. 
Выбрать имена в паре в алфавитном порядке.

14) Выбрать список названий фильмов и средний рейтинг, от самого низкого до самого высокого. 
Если два или более фильмов имеют одинаковый средний балл, перечислить их в алфавитном порядке

15) Найти названия всех фильмов снятых 'Steven Spielberg', отсортировать по алфавиту. 
select title
from Movie
where director = 'Steven Spielberg'

16) Для каждого фильма, который имеет по крайней мере одну оценку, 
найти наибольшее количество звезд, которые фильм получил. 
Выбрать название фильма и количество звезд. Сортировать по названию фильма.
select Movie.title, MAX(Rating.stars)
from Movie
left join Rating on Movie.mID=Rating.mID
where Rating.stars is not null
group by Movie.title
order by Movie.title;

17) Найти года в которых были фильмы с рейтингом 4 или 5, и отсортировать по возрастанию.
select Movie.year 
from Movie 
left join Rating on Movie.mID = Rating.mID 
where Rating.stars=4 or Rating.stars=5 
group by Movie.year 
order by Movie.year;

18) Для каждого фильма, выбрать название и "разброс оценок", 
то есть, разницу между самой высокой и самой низкой оценками для этого фильма. 
Сортировать по "разбросу оценок" от высшего к низшему, и по названию фильма.
SELECT m.title, (MAX(r.stars) - MIN(r.stars)) AS delta_stars 
FROM Movie m INNER JOIN Rating r 
ON m.mID = r.mID 
GROUP BY m.title 
ORDER BY delta_stars DESC, m.title;

19) Некоторые режиссеры сняли более чем один фильм. Для всех таких режиссеров,
выбрать названия всех фильмов режиссера, его имя. Сортировка по имени режиссера. 
Пример: Titanic,Avatar | James Cameron
SELECT GROUP_CONCAT(m.title SEPARATOR ','), m.director 
FROM Movie m 
WHERE m.director IS NOT NULL 
GROUP BY m.director 
HAVING COUNT(m.director) > 1 
ORDER BY m.director


20) Выберите названия всех фильмов, по алфавиту, которым не поставил оценку 'Chris Jackson'.
SELECT m.title 
FROM Movie m 
WHERE m.mID NOT IN (SELECT r.mID FROM Rating r 
	JOIN Reviewer rev ON r.rID=rev.rID 
	WHERE rev.name="Chris Jackson") 
ORDER BY m.title;

