

insert into evento values(
'as123432',
'opera traviata di Verdi',
'20:00',
'3:00',
'20/08/2015',
'opera',
'opera lirica',
'20/08/2015',
'25/08/2015',
null,
null,
null
);

insert into evento values(
'pp129438',
'partita pallavolo vigasio arbizzano',
'15:30',
'1:30',
'13/08/2015',
'partita di pallavolo',
null,
null,
null,
null,
'arbizzano',
'vigasio'
);

insert into artista values('123','Alberto','Rogati');
insert into artista values('asdf','Marco','Bolognesi');
insert into artista values('asdfgf','Massimo','Cancellieri');

insert into partecipanti(evento,artista) values('as123432','123');
insert into partecipanti(evento,artista) values('as123432','asdf');
insert into partecipanti(evento,artista) values('as123432','asdfgf');

insert into settore values (
1,
'as123432',
'galleria',
'posti in piedi',
300);

insert into settore values(
2,
'as123432',
'lodi',
'posti numerati',
50);

insert into settore values(
3,
'as123432',
'milano',
'posti non numerati',
100);

insert into settore values (
1,
'pp129438',
'galleria',
'posti in piedi',
300);

insert into settore values(
2,
'pp129438',
'lodi',
'posti numerati',
50);

insert into settore values(
3,
'pp129438',
'milano',
'posti non numerati',
100);

insert into biglietto values(
'sdfgfd23',
'11/08/2015',
'30.50',
'as123432',
3,
null);

insert into biglietto values(
'asdwer23',
'12/08/2015',
'30.50',
'as123432',
3,
null);

insert into biglietto values(
'aaasdf23',
'11/08/2015',
'0',
'pp129438',
'3',
null);
