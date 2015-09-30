create domain sect_type as text
check (value='posti numerati' or value='posti non numerati' or value='posti in piedi');

create domain ti_type as text
check (value='opera' or value='concerto classico' or value='concerto pop o rock' or value='prosa' or value='partita di pallavolo' or value='partita di pallacanestro' or value='altro evento sportivo');

create table evento(
codice varchar(10) primary key,
nome varchar(40) not null,
ora_inizio time not null,
durata time not null,
data_evento date not null,
tipologia ti_type not null,
descrizione varchar(100),
inizio_periodo date,
fine_periodo date,
risultato varchar(5),
squadra1 varchar(10),
squadra2 varchar(10),
CHECK ((inizio_periodo = null AND fine_periodo = null ) OR (data_evento<=fine_periodo AND data_evento >= inizio_periodo))
);

create table artista(
CF varchar(25) primary key,
nome varchar(14) not null,
cognome varchar(14) not null
);

create table partecipanti(
id serial primary key,
evento varchar(10) not null references evento(codice),
artista varchar(25) not null references artista(CF)
);

create table settore(
numero numeric,
evento varchar(10) references evento(codice),
nome   varchar(8) not null,
tipo sect_type not null,
capienza numeric not null,
prezzo real not null default 0,
primary key(numero,evento)
);

create table biglietto(
codice varchar(10) primary key,
data_emissione date not null ,
prezzo real not null ,
evento varchar(10) not null references evento(codice),
settore numeric not null,
numero_posto numeric,
foreign key (settore,evento) references settore(numero,evento)
);
