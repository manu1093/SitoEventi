--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: giorno; Type: DOMAIN; Schema: public; Owner: userlab54
--

CREATE DOMAIN giorno AS character varying(10)
	CONSTRAINT giorno_check CHECK (((VALUE)::text = ANY ((ARRAY['lunedì'::character varying, 'martedì'::character varying, 'mercoledì'::character varying, 'giovedì'::character varying, 'venerdì'::character varying, 'sabato'::character varying, 'domenica'::character varying])::text[])));


ALTER DOMAIN public.giorno OWNER TO userlab54;

--
-- Name: sect_type; Type: DOMAIN; Schema: public; Owner: userlab54
--

CREATE DOMAIN sect_type AS text
	CONSTRAINT sect_type_check CHECK ((((VALUE = 'posti numerati'::text) OR (VALUE = 'posti non numerati'::text)) OR (VALUE = 'posti in piedi'::text)));


ALTER DOMAIN public.sect_type OWNER TO userlab54;

--
-- Name: ti_type; Type: DOMAIN; Schema: public; Owner: userlab54
--

CREATE DOMAIN ti_type AS text
	CONSTRAINT ti_type_check CHECK ((((((((VALUE = 'opera'::text) OR (VALUE = 'concerto classico'::text)) OR (VALUE = 'concerto pop o rock'::text)) OR (VALUE = 'prosa'::text)) OR (VALUE = 'partita di pallavolo'::text)) OR (VALUE = 'partita di pallacanestro'::text)) OR (VALUE = 'altro evento sportivo'::text)));


ALTER DOMAIN public.ti_type OWNER TO userlab54;

--
-- Name: tipo_utente; Type: DOMAIN; Schema: public; Owner: userlab54
--

CREATE DOMAIN tipo_utente AS text
	CONSTRAINT tipo_utente_check CHECK ((((VALUE = 'amministratore'::text) OR (VALUE = 'cliente'::text)) OR (VALUE = 'impiegato'::text)));


ALTER DOMAIN public.tipo_utente OWNER TO userlab54;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acquisto; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE acquisto (
    id integer NOT NULL,
    data_ac date,
    quantita smallint DEFAULT 1,
    utente character varying(20),
    id_oggetto character varying(30),
    ora_ac character varying(30)
);


ALTER TABLE public.acquisto OWNER TO userlab54;

--
-- Name: acquisto_id_seq; Type: SEQUENCE; Schema: public; Owner: userlab54
--

CREATE SEQUENCE acquisto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acquisto_id_seq OWNER TO userlab54;

--
-- Name: acquisto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userlab54
--

ALTER SEQUENCE acquisto_id_seq OWNED BY acquisto.id;


--
-- Name: artista; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE artista (
    cf character varying(25) NOT NULL,
    nome character varying(14) NOT NULL,
    cognome character varying(14) NOT NULL
);


ALTER TABLE public.artista OWNER TO userlab54;

--
-- Name: azione; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE azione (
    nome character varying(10) NOT NULL,
    link character varying(70),
    messaggio character varying(70),
    immagine character varying(100)
);


ALTER TABLE public.azione OWNER TO userlab54;

--
-- Name: biglietto; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE biglietto (
    codice character varying(10) NOT NULL,
    data_emissione date NOT NULL,
    evento character varying(10) NOT NULL,
    settore numeric NOT NULL,
    numero_posto numeric,
    data_evento date DEFAULT '2015-09-08'::date NOT NULL
);


ALTER TABLE public.biglietto OWNER TO userlab54;

--
-- Name: carrello; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE carrello (
    id integer NOT NULL,
    quantita numeric DEFAULT 1,
    utente character varying(20),
    id_oggetto character varying(30)
);


ALTER TABLE public.carrello OWNER TO userlab54;

--
-- Name: carrello_id_seq; Type: SEQUENCE; Schema: public; Owner: userlab54
--

CREATE SEQUENCE carrello_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carrello_id_seq OWNER TO userlab54;

--
-- Name: carrello_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userlab54
--

ALTER SEQUENCE carrello_id_seq OWNED BY carrello.id;


--
-- Name: categoria; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE categoria (
    nome character varying(30) NOT NULL,
    descrizione character varying(150)
);


ALTER TABLE public.categoria OWNER TO userlab54;

--
-- Name: evento; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE evento (
    codice character varying(10) NOT NULL,
    nome character varying(40) NOT NULL,
    ora_inizio time without time zone NOT NULL,
    durata time without time zone NOT NULL,
    data_evento date NOT NULL,
    tipologia ti_type NOT NULL,
    descrizione character varying(100),
    inizio_periodo date,
    fine_periodo date,
    risultato character varying(5),
    squadra1 character varying(10),
    squadra2 character varying(10)
);


ALTER TABLE public.evento OWNER TO userlab54;

--
-- Name: login; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE login (
    nickname character varying(50) NOT NULL,
    data_log character varying(50) NOT NULL,
    ora_log character varying(50) NOT NULL
);


ALTER TABLE public.login OWNER TO userlab54;

--
-- Name: mostra; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE mostra (
    titolo character varying(30) NOT NULL,
    museo character varying(30) NOT NULL,
    citta character varying(20) NOT NULL,
    inizioesposizione date NOT NULL,
    fineesposizione date,
    prezzointero numeric(5,2),
    prezzoridotto numeric(5,2) DEFAULT 5::numeric
);


ALTER TABLE public.mostra OWNER TO userlab54;

--
-- Name: museo; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE museo (
    nome character varying(30) DEFAULT 'museo veronese'::character varying NOT NULL,
    citta character varying(20) DEFAULT 'Verona'::character varying NOT NULL,
    indirizzo character varying(40),
    numerotelefono character varying(15),
    giornochiusura giorno NOT NULL,
    prezzoadulti numeric(5,2) DEFAULT 10::numeric NOT NULL,
    prezzoridotto numeric(5,2) NOT NULL,
    sitointernet character varying(30),
    CONSTRAINT museo_check CHECK ((prezzoridotto < prezzoadulti))
);


ALTER TABLE public.museo OWNER TO userlab54;

--
-- Name: opera; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE opera (
    nome character varying(30) NOT NULL,
    cognomeautore character varying(20) NOT NULL,
    nomeautore character varying(10) NOT NULL,
    museo character varying(30),
    citta character varying(20),
    epoca character varying(20),
    anno numeric
);


ALTER TABLE public.opera OWNER TO userlab54;

--
-- Name: orario; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE orario (
    progressivo numeric NOT NULL,
    museo character varying(30) NOT NULL,
    citta character varying(20) NOT NULL,
    giorno character varying(10) NOT NULL,
    orarioapertura time without time zone DEFAULT '09:00:00'::time without time zone,
    orariochiusura time without time zone DEFAULT '19:00:00'::time without time zone
);


ALTER TABLE public.orario OWNER TO userlab54;

--
-- Name: partecipanti; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE partecipanti (
    id integer NOT NULL,
    evento character varying(10) NOT NULL,
    artista character varying(25) NOT NULL
);


ALTER TABLE public.partecipanti OWNER TO userlab54;

--
-- Name: partecipanti_id_seq; Type: SEQUENCE; Schema: public; Owner: userlab54
--

CREATE SEQUENCE partecipanti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partecipanti_id_seq OWNER TO userlab54;

--
-- Name: partecipanti_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: userlab54
--

ALTER SEQUENCE partecipanti_id_seq OWNED BY partecipanti.id;


--
-- Name: prodotto; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE prodotto (
    codice character varying(200) NOT NULL,
    nome character varying(100) NOT NULL,
    pezzi smallint DEFAULT 0,
    url_immagine character varying(1500) DEFAULT 'http://www.univr.it/image/logo-univr.png'::character varying,
    prezzo real DEFAULT 0,
    punti smallint DEFAULT 0,
    categoria character varying(30),
    prezzo_premio smallint,
    descrizione character varying(1500)
);


ALTER TABLE public.prodotto OWNER TO userlab54;

--
-- Name: settore; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE settore (
    numero numeric NOT NULL,
    evento character varying(10) NOT NULL,
    nome character varying(8) NOT NULL,
    tipo sect_type NOT NULL,
    capienza numeric NOT NULL,
    prezzo real DEFAULT 0 NOT NULL
);


ALTER TABLE public.settore OWNER TO userlab54;

--
-- Name: utente; Type: TABLE; Schema: public; Owner: userlab54; Tablespace: 
--

CREATE TABLE utente (
    nickname character varying(20) NOT NULL,
    pass character varying(15) NOT NULL,
    via character varying(100),
    numero character varying(5),
    citta character varying(10),
    carta_credito character varying(20),
    scadenza_carta character varying(10),
    pin character varying(4),
    punti smallint DEFAULT 0,
    attivo boolean DEFAULT true NOT NULL,
    tipo tipo_utente NOT NULL,
    categoria_preferita character varying(30) DEFAULT 'telefonia'::character varying
);


ALTER TABLE public.utente OWNER TO userlab54;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY acquisto ALTER COLUMN id SET DEFAULT nextval('acquisto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY carrello ALTER COLUMN id SET DEFAULT nextval('carrello_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY partecipanti ALTER COLUMN id SET DEFAULT nextval('partecipanti_id_seq'::regclass);


--
-- Data for Name: acquisto; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY acquisto (id, data_ac, quantita, utente, id_oggetto, ora_ac) FROM stdin;
10	2015-08-26	1	franco89	ah58965	22:47
11	2015-08-26	1	franco89	es345467	22:52
12	2015-08-26	1	franco89	dr56783	22:52
13	2015-08-26	1	franco89	fr43654	22:52
14	2015-08-26	1	gaetano78	es345467	22:55
15	2015-08-26	2	gaetano78	sgh6789	22:55
16	2015-09-04	1	franco89	es345467	15:45
17	2015-09-07	2	franco	ag595145	05:59
18	2015-09-07	1	franco	ag595145	06:00
19	2015-09-08	1	ciccio	ag349512	16:41
20	2015-09-08	1	ciccio	ar67890	16:41
21	2015-09-08	1	ciccio	rt43267	16:43
22	2015-09-08	1	ciccio	tr45764	16:54
23	2015-09-08	1	ciccio	tr45764	16:54
24	2015-09-08	1	ciccio	fr43654	16:54
25	2015-09-13	5	gaetano78	ag349512	17:06
26	2015-09-13	1	franco89	re45674	17:06
27	2015-09-13	1	franco89	ar67890	17:06
28	2015-09-13	2	franco89	ag595145	17:06
29	2015-09-13	1	franco89	ah58965	17:07
30	2015-09-14	1	ciccio	es345467	17:56
\.


--
-- Name: acquisto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: userlab54
--

SELECT pg_catalog.setval('acquisto_id_seq', 30, true);


--
-- Data for Name: artista; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY artista (cf, nome, cognome) FROM stdin;
123	Alberto	Rogati
asdf	Marco	Bolognesi
asdfgf	Massimo	Cancellieri
\.


--
-- Data for Name: azione; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY azione (nome, link, messaggio, immagine) FROM stdin;
anticaerb	http://www.anticaerboristeria.it/vademecum/it/it/home.html	Approfitta delle occasioni 	http://www.anticaerboristeria.it/content/dam/vademecum/it/_global/antica-erboristeria_logo.png
euronics	www.euronics.it	vieni a vedere le nostre offerte	http://www.unicef.it/gallery/aziende/euronics.gif
\.


--
-- Data for Name: biglietto; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY biglietto (codice, data_emissione, evento, settore, numero_posto, data_evento) FROM stdin;
aaasdfds23	2015-08-11	pp129438	3	\N	2015-08-13
4rckgxdc	2015-09-20	pp129438	1	\N	2015-08-13
6i8mjn2g	2015-09-25	pp129438	2	1	2015-08-13
63iqilbi	2015-09-25	pp129438	2	4	2015-08-13
otd80mqd	2015-09-25	pp129438	3	\N	2015-09-08
pl8qe2am	2015-09-26	pp129438	2	3	2015-09-08
qifh3yha	2015-09-26	as123432	1	\N	2015-09-08
74ggdukq	2015-09-26	as123432	1	\N	2015-09-08
6gemab8m	2015-09-26	as123432	1	\N	2015-09-08
ytx7hm0o	2015-09-26	as123435	5	1	2015-09-08
5axiu4cr	2015-09-26	as123432	1	\N	2015-09-08
eb2p2pae	2015-09-26	as123432	1	\N	2015-09-08
oiqgr3s9	2015-09-26	as123442	2	187	2015-09-08
inaqxbsj	2015-09-26	as123442	5	\N	2015-09-08
55bcwd76	2015-09-26	as123442	2	1	2015-09-08
egqmfslu	2015-09-27	as123443	5	\N	2015-09-08
tcfeby86	2015-09-27	as123443	4	1	2015-09-08
pmnrf0ke	2015-09-20	pp129438	2	2	2015-08-13
1io85e03	2015-09-26	as123432	1	\N	2015-09-08
3wt1jw2m	2015-09-26	as123432	2	15	2015-09-08
qqouv5gh	2015-09-26	as123432	2	38	2015-09-08
568f2x6e	2015-09-26	as123432	1	\N	2015-09-08
yt9ktri2	2015-09-26	as123433	5	1	2015-09-08
fh7l1gv8	2015-09-26	as123433	5	3	2015-09-08
sdfgfd23	2015-08-11	as123432	3	\N	2015-08-20
asdwer23	2015-08-12	as123432	3	\N	2015-08-20
o8p76yy2	2015-08-12	as123432	3	\N	2015-08-20
yfu79f18	2015-08-12	as123432	3	\N	2015-08-20
bpiqk8rc	2015-08-12	as123432	3	\N	2015-08-20
x5lhmgqq	2015-08-12	as123432	3	\N	2015-08-20
4mbwndof	2015-08-12	as123432	3	\N	2015-08-20
jbi2e5ot	2015-08-12	as123432	3	\N	2015-08-20
85ls98fq	2015-08-12	as123432	3	\N	2015-08-20
i3wl72l0	2015-08-12	as123432	3	\N	2015-08-20
jlqx6of2	2015-08-12	as123432	3	\N	2015-08-20
alfbrt6l	2015-08-12	as123432	3	\N	2015-08-20
u186ydac	2015-08-12	as123432	3	\N	2015-08-20
4inaf539	2015-08-12	as123432	3	\N	2015-08-20
93qkcspm	2015-08-12	as123432	3	\N	2015-08-20
8ih2g56h	2015-08-12	as123432	3	\N	2015-08-20
x34uqoxq	2015-08-12	as123432	3	\N	2015-08-20
2u202rxh	2015-08-12	as123432	3	\N	2015-08-20
9f1ulrq2	2015-08-12	as123432	3	\N	2015-08-20
iwa24dd4	2015-08-12	as123432	3	\N	2015-08-20
0xxivsp2	2015-08-12	as123432	3	\N	2015-08-20
bi71h0yw	2015-08-12	as123432	3	\N	2015-08-20
aujx87es	2015-08-12	as123432	3	\N	2015-08-20
gdni7jsf	2015-08-12	as123432	3	\N	2015-08-20
dj7vakkc	2015-08-12	as123432	3	\N	2015-08-20
omua5ycm	2015-08-12	as123432	3	\N	2015-08-20
6wdhr6g2	2015-08-12	as123432	3	\N	2015-08-20
02h8jrxi	2015-08-12	as123432	3	\N	2015-08-20
soucs3rt	2015-08-12	as123432	3	\N	2015-08-20
ejcs3g3r	2015-08-12	as123432	3	\N	2015-08-20
j6pnpb79	2015-08-12	as123432	3	\N	2015-08-20
e7syuyhs	2015-08-12	as123432	3	\N	2015-08-20
50ix9rco	2015-08-12	as123432	3	\N	2015-08-20
xxpwrnqo	2015-08-12	as123432	3	\N	2015-08-20
ic0vcy54	2015-08-12	as123432	3	\N	2015-08-20
2i2xvn2g	2015-08-12	as123432	3	\N	2015-08-20
f2vh5t12	2015-08-12	as123432	3	\N	2015-08-20
yv6774bf	2015-08-12	as123432	3	\N	2015-08-20
xhiesv4e	2015-08-12	as123432	3	\N	2015-08-20
r8nrexcu	2015-08-12	as123432	3	\N	2015-08-20
utbw6vh1	2015-08-12	as123432	3	\N	2015-08-20
qgsd3yii	2015-08-12	as123432	3	\N	2015-08-20
nj5mkueg	2015-08-12	as123432	3	\N	2015-08-20
50sis3gn	2015-08-12	as123432	3	\N	2015-08-20
k7n1j2lb	2015-08-12	as123432	3	\N	2015-08-20
k7eemh9y	2015-08-12	as123432	3	\N	2015-08-20
64ax5xfq	2015-08-12	as123432	3	\N	2015-08-20
4ah2p0is	2015-08-12	as123432	3	\N	2015-08-20
5weeuv8q	2015-08-12	as123432	3	\N	2015-08-20
nht77n9h	2015-08-12	as123432	3	\N	2015-08-20
gg4tqngh	2015-08-12	as123432	3	\N	2015-08-20
5yxm04fv	2015-08-12	as123432	3	\N	2015-08-20
pt3g3x1c	2015-08-12	as123432	3	\N	2015-08-20
4494de50	2015-08-12	as123432	3	\N	2015-08-20
1r42lik0	2015-08-12	as123432	3	\N	2015-08-20
371rxj0v	2015-08-12	as123432	3	\N	2015-08-20
25txsfme	2015-08-12	as123432	3	\N	2015-08-20
8ix2gkkg	2015-08-12	as123432	3	\N	2015-08-20
fot89w0q	2015-08-12	as123432	3	\N	2015-08-20
sb5alcbw	2015-08-12	as123432	3	\N	2015-08-20
a29jp612	2015-08-12	as123432	3	\N	2015-08-20
2o5ntmnq	2015-08-12	as123432	3	\N	2015-08-20
m2qm92p4	2015-08-12	as123432	3	\N	2015-08-20
qe7qn8ag	2015-08-12	as123432	3	\N	2015-08-20
dumten9t	2015-08-12	as123432	3	\N	2015-08-20
5scpv9s0	2015-08-12	as123432	3	\N	2015-08-20
4xo71e21	2015-08-12	as123432	3	\N	2015-08-20
tn1w9din	2015-08-12	as123432	3	\N	2015-08-20
5q6fdk8m	2015-08-12	as123432	3	\N	2015-08-20
owk04dk1	2015-08-12	as123432	3	\N	2015-08-20
rw8rw2s7	2015-08-12	as123432	3	\N	2015-08-20
rfvpaib0	2015-08-12	as123432	3	\N	2015-08-20
pipd9h01	2015-08-12	as123432	3	\N	2015-08-20
mt74bew6	2015-08-12	as123432	3	\N	2015-08-20
cmfppojd	2015-08-12	as123432	3	\N	2015-08-20
a47aoe56	2015-08-12	as123432	3	\N	2015-08-20
o1kqcm1h	2015-08-12	as123432	3	\N	2015-08-20
gesrcpn9	2015-08-12	as123432	3	\N	2015-08-20
3etn8i4q	2015-08-12	as123432	3	\N	2015-08-20
vjpbb856	2015-08-12	as123432	3	\N	2015-08-20
27loe9wa	2015-08-12	as123432	3	\N	2015-08-20
pvdbqf6t	2015-08-12	as123432	3	\N	2015-08-20
ieri4kb2	2015-08-12	as123432	3	\N	2015-08-20
rmrnqown	2015-08-12	as123432	3	\N	2015-08-20
60ohjxab	2015-08-12	as123432	3	\N	2015-08-20
8ppawbel	2015-08-12	as123432	3	\N	2015-08-20
jwqq2e5f	2015-08-12	as123432	3	\N	2015-08-20
y4u5kyqo	2015-08-12	as123432	3	\N	2015-08-20
v26xnbxa	2015-08-12	as123432	3	\N	2015-08-20
eh6mi20d	2015-08-12	as123432	3	\N	2015-08-20
upay8osr	2015-08-12	as123432	3	\N	2015-08-20
tneqr6sh	2015-08-12	as123432	3	\N	2015-08-20
32y5sv85	2015-08-12	as123432	3	\N	2015-08-20
l3kntstu	2015-08-12	as123432	3	\N	2015-08-20
hyunqefb	2015-08-12	as123432	3	\N	2015-08-20
i8ssivtl	2015-08-12	as123432	3	\N	2015-08-20
fvgaxdpv	2015-08-12	as123432	3	\N	2015-08-20
349nqrn1	2015-08-12	as123432	3	\N	2015-08-20
o859q2rg	2015-08-12	as123432	3	\N	2015-08-20
5lvqw0wa	2015-08-12	as123432	3	\N	2015-08-20
ecpm8m0o	2015-09-17	as123432	1	\N	2015-08-20
f9cn5mq2	2015-09-25	as123432	1	\N	2015-08-20
vfal4r1n	2015-08-12	as123432	2	0	2015-08-20
yjn021xv	2015-08-12	as123432	2	1	2015-08-20
q1vlde9x	2015-08-12	as123432	2	2	2015-08-20
llsgp7mr	2015-08-12	as123432	2	3	2015-08-20
42dvn3ux	2015-08-12	as123432	2	4	2015-08-20
fowl06du	2015-08-12	as123432	2	5	2015-08-20
c6g4fuib	2015-08-12	as123432	2	6	2015-08-20
6w3cetk2	2015-08-12	as123432	2	7	2015-08-20
6eg1vu3v	2015-08-12	as123432	2	8	2015-08-20
9rs7q4c4	2015-08-12	as123432	2	9	2015-08-20
2gbisqse	2015-08-12	as123432	2	10	2015-08-20
oyhx7wju	2015-08-12	as123432	2	11	2015-08-20
71vmuin4	2015-08-12	as123432	2	12	2015-08-20
qdgnpiqw	2015-08-12	as123432	2	13	2015-08-20
iijwfhkc	2015-08-12	as123432	2	14	2015-08-20
xnobfppj	2015-08-12	as123432	2	16	2015-08-20
ftbhpvqt	2015-08-12	as123432	2	17	2015-08-20
y8y2livg	2015-08-12	as123432	2	18	2015-08-20
8m9khiw8	2015-08-12	as123432	2	19	2015-08-20
o00sacc2	2015-08-12	as123432	2	20	2015-08-20
kg860wr4	2015-08-12	as123432	2	21	2015-08-20
63ukpyqn	2015-08-12	as123432	2	22	2015-08-20
nf9frx0e	2015-08-12	as123432	2	23	2015-08-20
yh97d2xt	2015-08-12	as123432	2	24	2015-08-20
6uuk8iw9	2015-08-12	as123432	2	25	2015-08-20
7x7ql2d6	2015-08-12	as123432	2	26	2015-08-20
2h70etf4	2015-08-12	as123432	2	27	2015-08-20
vbq7b02t	2015-08-12	as123432	2	28	2015-08-20
cb8sjtpj	2015-08-12	as123432	2	29	2015-08-20
chpytqnm	2015-08-12	as123432	2	30	2015-08-20
8hlcl955	2015-08-12	as123432	2	31	2015-08-20
omnqvjwc	2015-09-20	as123432	1	\N	2015-08-20
huoswuxy	2015-08-12	as123432	2	32	2015-08-20
shkfrly5	2015-08-12	as123432	2	33	2015-08-20
fw662296	2015-08-12	as123432	2	34	2015-08-20
mekcuyd4	2015-08-12	as123432	2	35	2015-08-20
vqnc18pr	2015-08-12	as123432	2	36	2015-08-20
2q0qosxc	2015-08-12	as123432	2	37	2015-08-20
xn5sd5v5	2015-08-12	as123432	2	39	2015-08-20
n1e7c8wj	2015-08-12	as123432	2	40	2015-08-20
omeebqp6	2015-08-12	as123432	2	41	2015-08-20
w17linmw	2015-08-12	as123432	2	42	2015-08-20
tsu0tum5	2015-08-12	as123432	2	43	2015-08-20
eslbiqpl	2015-08-12	as123432	2	44	2015-08-20
ot0dqt0p	2015-08-12	as123432	2	45	2015-08-20
5it6nqkt	2015-08-12	as123432	2	46	2015-08-20
1fg5ber7	2015-08-12	as123432	2	47	2015-08-20
eq4823lu	2015-08-12	as123432	2	48	2015-08-20
tnyslibv	2015-08-12	as123432	2	49	2015-08-20
h5yyufx6	2015-09-26	as123432	1	\N	2015-09-08
42ej7e26	2015-09-26	as123433	5	4	2015-09-08
\.


--
-- Data for Name: carrello; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY carrello (id, quantita, utente, id_oggetto) FROM stdin;
\.


--
-- Name: carrello_id_seq; Type: SEQUENCE SET; Schema: public; Owner: userlab54
--

SELECT pg_catalog.setval('carrello_id_seq', 67, true);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY categoria (nome, descrizione) FROM stdin;
computer portatili	Visita la nostra sezione "computer portatili", dedicata agli amanti dei pc portatili e fisis, comprese periferiche che li riguardano
telefonia	Visita la nostra categoria "telefonia", dedicata agli amanti della telefonia, alla ricerca dell'ultimo modello disponibile
videogiochi e console	Visita la nostra sezione "videogiochi e console", dedicata agli appassionati gamers di giochi di ruolo e console
elettrodomestici	visita la nostra sezione riguardante elettrodomestici: dalla cura del corpo al bricolage.
azione	
\.


--
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY evento (codice, nome, ora_inizio, durata, data_evento, tipologia, descrizione, inizio_periodo, fine_periodo, risultato, squadra1, squadra2) FROM stdin;
as123432	opera traviata di Verdi	20:00:00	03:00:00	2015-08-20	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
pp129438	partita pallavolo vigasio arbizzano	15:30:00	01:30:00	2015-08-13	partita di pallavolo	\N	\N	\N	\N	arbizzano	vigasio
ar345365	partita pallavolo lugo alba	16:00:00	01:00:00	2015-09-25	partita di pallavolo	\N	\N	\N	\N	lugo	alba
as123433	opera traviata di Verdi	20:00:00	03:00:00	2015-08-21	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
as123434	opera traviata di Verdi	20:00:00	03:00:00	2015-08-22	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
as123435	opera traviata di Verdi	20:00:00	03:00:00	2015-08-23	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
as123436	opera traviata di Verdi	20:00:00	03:00:00	2015-08-24	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
as123437	opera traviata di Verdi	20:00:00	03:00:00	2015-08-25	opera	opera lirica	2015-08-20	2015-08-25	\N	\N	\N
as123438	opera Nabucco	20:00:00	03:00:00	2015-09-25	opera	opera lirica	2015-09-25	2015-09-25	\N	\N	\N
pp129439	partita pallacanestro vigasio arbizzano	15:30:00	01:30:00	2015-09-29	partita di pallacanestro	\N	\N	\N	\N	arbizzano	vigasio
pp129440	partita calcio Milan Inter	15:30:00	01:30:00	2015-09-30	altro evento sportivo	\N	\N	\N	\N	Milan	Inter
as123441	concerto Mozart per pianoforte	20:00:00	03:00:00	2015-09-29	concerto classico	concerto pianoforte	2015-09-29	2015-09-29	\N	\N	\N
as123442	concerto Queen	20:00:00	03:00:00	2015-09-26	concerto pop o rock	concerto Queen	2015-09-26	2015-09-27	\N	\N	\N
as123443	concerto Queen	20:00:00	03:00:00	2015-09-27	concerto pop o rock	concerto Queen	2015-09-26	2015-09-27	\N	\N	\N
as123444	prosa Manzoni	20:00:00	03:00:00	2015-08-20	prosa	recita I promessi Sposi	2015-08-20	2015-08-20	\N	\N	\N
as123445	prosa Manzoni	20:00:00	03:00:00	2015-09-29	prosa	recita I promessi Sposi	2015-09-29	2015-09-29	\N	\N	\N
\.


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY login (nickname, data_log, ora_log) FROM stdin;
franco89	2015-08-27	11:34:21
franco89	2015-08-27	11:26:26
franco89	2015-08-26	01:43:38
franco89	2015-08-26	01:20:50
franco89	2015-08-26	01:19:53
franco89	2015-08-26	01:18:28
gaetano78	2015-08-26	01:19:08
franco89	2015-08-27	13:33:46
ciccio	2015-08-27	13:36:24
franco89	2015-08-27	13:37:51
ciccio	2015-08-27	13:39:07
franco89	2015-09-04	15:41:25
franco89	2015-09-04	16:23:23
franco89	2015-09-04	16:28:49
franco89	2015-09-04	16:31:43
franco89	2015-09-04	16:31:54
franco89	2015-09-04	16:34:44
franco89	2015-09-04	16:34:54
franco89	2015-09-04	16:43:42
franco89	2015-09-05	11:26:22
franco89	2015-09-05	11:26:39
franco89	2015-09-05	11:33:33
franco89	2015-09-05	13:36:36
	2015-09-05	17:51:25
	2015-09-05	17:51:27
franco89	2015-09-05	17:55:19
ciccio	2015-09-07	11:08:20
ciccio	2015-09-07	11:14:02
ciccio	2015-09-07	11:15:11
ciccio	2015-09-07	11:17:12
ciccio	2015-09-07	11:40:46
ciccio	2015-09-07	11:49:27
ciccio	2015-09-07	11:56:19
ciccio	2015-09-07	12:01:21
ciccio	2015-09-07	12:02:20
ciccio	2015-09-07	12:03:11
ciccio	2015-09-07	12:11:18
ciccio	2015-09-07	12:13:35
ciccio	2015-09-07	12:16:59
ciccio	2015-09-07	12:19:22
ciccio	2015-09-07	12:20:20
ciccio	2015-09-07	12:23:05
ciccio	2015-09-07	12:28:10
franco	2015-09-07	06:05:16
franco	2015-09-07	06:27:08
franco	2015-09-07	06:34:19
franco	2015-09-07	06:36:41
franco	2015-09-07	06:37:22
franco	2015-09-07	06:41:54
franco	2015-09-07	16:07:27
franco	2015-09-07	16:13:21
franco	2015-09-07	16:21:31
franco	2015-09-07	16:23:17
ciccio	2015-09-07	16:25:42
franco	2015-09-07	16:32:11
franco	2015-09-07	16:33:54
ciccio	2015-09-07	16:36:12
ciccio	2015-09-07	16:40:27
franco	2015-09-07	16:44:09
ciccio	2015-09-08	05:39:18
ciccio	2015-09-08	15:28:32
ciccio	2015-09-08	15:36:25
ciccio	2015-09-08	15:39:49
ciccio	2015-09-08	16:00:42
ciccio	2015-09-08	16:15:38
ciccio	2015-09-08	16:17:37
ciccio	2015-09-08	16:18:07
ciccio	2015-09-08	16:19:12
ciccio	2015-09-08	16:20:01
ciccio	2015-09-08	16:20:42
ciccio	2015-09-08	16:22:42
ciccio	2015-09-08	16:36:37
ciccio	2015-09-08	16:43:46
ciccio	2015-09-08	16:54:18
ciccio	2015-09-08	17:02:44
ciccio	2015-09-09	09:10:01
ciccio	2015-09-09	09:14:13
franco89	2015-09-09	09:43:53
ciccio	2015-09-09	09:58:37
franco89	2015-09-11	21:04:34
franco89	2015-09-13	12:08:11
franco89	2015-09-13	12:24:28
franco89	2015-09-13	12:24:43
franco89	2015-09-13	15:21:24
ciccio	2015-09-13	15:42:48
ciccio	2015-09-13	15:49:25
ciccio	2015-09-13	15:53:34
ciccio	2015-09-13	15:56:05
ciccio	2015-09-13	15:56:34
ciccio	2015-09-13	16:02:28
ciccio	2015-09-13	16:08:10
ciccio	2015-09-13	16:08:30
ciccio	2015-09-13	16:18:27
ciccio	2015-09-13	16:19:03
ciccio	2015-09-13	16:21:11
franco89	2015-09-13	17:06:21
franco89	2015-09-13	18:24:10
ciccio	2015-09-14	10:52:31
ciccio	2015-09-14	17:56:01
ciccio	2015-09-15	21:51:29
\.


--
-- Data for Name: mostra; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY mostra (titolo, museo, citta, inizioesposizione, fineesposizione, prezzointero, prezzoridotto) FROM stdin;
Tante belle cose	Scienze e tecnica	Vicenza	2011-03-10	2012-05-04	11.50	7.50
Le lampade	Scienze e tecnica	Treviso	2009-06-08	2009-06-09	16.50	10.50
\.


--
-- Data for Name: museo; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY museo (nome, citta, indirizzo, numerotelefono, giornochiusura, prezzoadulti, prezzoridotto, sitointernet) FROM stdin;
Castelvecchio	Verona	Corso Castelvecchio	045 594734	lunedì	10.00	8.00	www.castelvecchio.it
Scienze e tecnica	Vicenza	Parco della vittoria	02 57489632	mercoledì	12.00	7.00	www.scitecvi.it
Mart	Venezia	Vicolo Stretto	0445 657495	giovedì	13.50	8.50	www.mart.it
Arena	Verona	piazza Bra	045 8003204	martedì	11.00	4.00	www.arena.it
Scienze e tecnica	Treviso	Largo Colombo	069 4587365	venerdì	15.00	5.00	www.scitectr.it
\.


--
-- Data for Name: opera; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY opera (nome, cognomeautore, nomeautore, museo, citta, epoca, anno) FROM stdin;
L'urlo	Edvard	Munch	Mart	Venezia	Risorgimento	1700
I girasoli	Van Gogh	Vincent	Castelvecchio	Verona	Rinascimento	1600
La statua	Mario	Rossi	Scienze e tecnica	Treviso	Moderna	1900
\.


--
-- Data for Name: orario; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY orario (progressivo, museo, citta, giorno, orarioapertura, orariochiusura) FROM stdin;
1	Arena	Verona	Domenica	10:00:00	11:00:00
\.


--
-- Data for Name: partecipanti; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY partecipanti (id, evento, artista) FROM stdin;
1	as123432	123
2	as123432	asdf
3	as123432	asdfgf
4	as123445	123
5	as123445	asdf
\.


--
-- Name: partecipanti_id_seq; Type: SEQUENCE SET; Schema: public; Owner: userlab54
--

SELECT pg_catalog.setval('partecipanti_id_seq', 5, true);


--
-- Data for Name: prodotto; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY prodotto (codice, nome, pezzi, url_immagine, prezzo, punti, categoria, prezzo_premio, descrizione) FROM stdin;
rt43267	Samsung Galaxy S5 Mini 16gb ITA Black	344	http:	256	365	computer portatili	2435	Samsung G800 Galaxy S5 Mini Smartphone, 16 GB, Nero [Italia]
sgh6789	girrmi tostapane	41	http://ecx.images-amazon.com/images/I/41ZxGFvxY-L._SX425_.jpg	43	45	elettrodomestici	200	Tostapane da 800W con 6 livelli di cottura ciorpo in acciaio inox funzione riscaldamento e scongelamento con spegnimento automatico pinze estraibili e cassetto raccogli briciole
tr45764	gameboy pocket	197	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Wikipedia_gameboygroup.jpg/220px-Wikipedia_gameboygroup.jpg	32	15	computer portatili	300	Grazie all'arrivo del Nintendo DS e del Wii, il 2007 risulta un anno molto florido dal punto di vista commerciale.[24] Le vendite delle console nel biennio 2006-07, unite al buon andamento nel settore dei videogiochi, consente alla societÃ  di rivedere al rialzo le previsioni di guadagno alla luce del record finanziario.
fr43654	Samsung i9195 Galaxy S4 Mini	319	http://img.trovaprezzi.it/products/7/samsung_i9195_galaxy_s4_mini.jpg	312	132	computer portatili	2300	SAMSUNG 13012885 Samsung Galaxy S4 Mini, colore Black (Vodafone) Display Super Amoled 4.3, Android, CPU
ar67890	xbox360	298	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Xbox-Console-Set.png/250px-Xbox-Console-Set.png	320	100	computer portatili	3000	L'Xbox &egrave; una console per videogiochi prodotta dalla Microsoft. Appartenente alla sesta generazione, e&grave; stata messa in vendita il 15 novembre 2001 nel Nord America, il 22 febbraio 2002 in Giappone e il 14 marzo in Europa e Australia. Rappresenta il primo tentativo di entrare nel mercato delle console da parte della Microsoft, dopo aver collaborato con SEGA nel convertire Windows CE per la console Sega Dreamcast.
df45678	Bosch PSB 650 RE Trapano Battente	199	http://ecx.images-amazon.com/images/I/51k80TK9-JL._SX355_.jpg	83	32	elettrodomestici	100	Il trapano battente PSB 650 RE della serie Compact Universal Ã¨ un utensile universale ed estremamente versatile, ideale per ogni lavoro di foratura. Ha un'ergonomia ottimale ed un peso di soli 1,8 Kg. Ha una potenza di 650 Watt, il mandrino autoserrante monobussola con Press & Lock per poter cambiare lâaccessorio senza attrezzi, e&grave; reversibile (consente quindi la rotazione destrorsa e sinistrorsa), dispone della regolazione elettronica Bosch, del rivestimento Softgrip e del commutatore per foratura con e senza percussione.
ag349512	notebook samsung R522	52	http://www.notebookcheck.it/fileadmin/_processed_/csm_DSC0029723_Kopie_9345261a6b.jpg	100	50	computer portatili	0	notebook samsung R522
re45674	Samsung Galaxy S6	42	http://img.trovaprezzi.it/products/7/samsung_galaxy_s6_32gb.jpg	519	100	telefonia	3000	Samsung G925 Galaxy S6 EDGE 4G NFC 32GB gold EU
sf45678	playstation 2	500	https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/PlayStation_2_comparison.png/200px-PlayStation_2_comparison.png	220	40	videogiochi e console	2000	La PlayStation 2, seguendo le orme della precedente PlayStation, e&grave; dunque gia&grave;  forte del successo della console precedente
ag595145	notebook acer aspire 5745G	4	http://i.computer-bild.de/imgs/3/0/4/4/8/1/8/Acer-Aspire-5745G-434G64BN-745x559-87101fb7e69feba3.jpg	100	50	computer portatili	0	notebook acer aspire 5745G intel
ah58965	samsung galaxy S2	9	http://www.fusionserv.com/wp-content/uploads/2013/12/Samsung-Galaxy-S2-asdofasj1.jpg	150	100	telefonia	0	samsung galaxy S2 dualcore
dr56783	Rowenta CV7320 - Phon Pro2300	19	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCaE-CBJKlHVq_M1eoOM_MwdWU-rCf0p9qfeALs4mgqp9GAmKeQv7srqg	45	12	elettrodomestici	135	Asciugacapelli 2300W altissima potenza. Funzione Ionic. Tecnologia Ceramica. Diffusore professionale. Regolazione 6 posizioni. Aria fredda 
es345467	sony playstation 3	82	http://media.engadget.com/img/product/14/bca/playstation-3-slim-nj2-800.jpg	120	80	videogiochi e console	1000	sony playstation 3
\.


--
-- Data for Name: settore; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY settore (numero, evento, nome, tipo, capienza, prezzo) FROM stdin;
1	as123432	galleria	posti in piedi	300	10
2	as123432	lodi	posti numerati	50	30
3	as123432	milano	posti non numerati	100	20
2	pp129438	lodi	posti numerati	50	2
3	pp129438	milano	posti non numerati	100	2
1	pp129438	galleria	posti in piedi	300	2
4	as123432	lodi	posti numerati	50	30
4	pp129438	galleria	posti in piedi	300	2
6	pp129438	galleria	posti numerati	300	2
5	as123432	galleria	posti numerati	300	10
4	as123433	galleria	posti in piedi	300	10
5	as123433	galleria	posti numerati	300	10
5	as123434	galleria	posti numerati	300	10
4	as123434	galleria	posti in piedi	300	10
5	as123435	lodi	posti numerati	300	10
5	as123436	milano	posti in piedi	300	10
5	as123437	galleria	posti numerati	300	10
6	as123438	galleria	posti numerati	300	10
1	pp129439	galleria	posti numerati	300	15
1	pp129440	galleria	posti numerati	300	15
2	pp129440	lodi	posti in piedi	300	20
2	pp129439	lodi	posti in piedi	300	20
5	as123441	milano	posti in piedi	300	10
6	as123441	milano	posti numerati	300	10
5	as123442	milano	posti in piedi	300	10
2	as123442	milano	posti numerati	300	10
5	as123443	galleria	posti in piedi	300	10
5	as123444	galleria	posti in piedi	300	10
4	as123443	milano	posti numerati	300	10
4	as123444	milano	posti numerati	300	10
3	as123445	galleria	posti in piedi	300	10
4	as123445	milano	posti numerati	300	40
\.


--
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: userlab54
--

COPY utente (nickname, pass, via, numero, citta, carta_credito, scadenza_carta, pin, punti, attivo, tipo, categoria_preferita) FROM stdin;
lav01	lelle	\N	\N	\N	\N	\N	\N	0	t	impiegato	telefonia
admin	admin	\N	\N	\N	\N	\N	\N	0	t	amministratore	telefonia
ciccino	pasticcino	\N	\N	\N	\N	\N	\N	0	t	impiegato	telefonia
ciccione	pasticcione	\N	\N	\N	\N	\N	\N	0	t	amministratore	telefonia
cyanogen	mod	\N	\N	\N	\N	\N	\N	0	t	impiegato	telefonia
imp	imp	\N	\N	\N	\N	\N	\N	0	t	impiegato	telefonia
marcello30	reflextonda	viale accademia	25	Milano	5226541791322566	0	931	90	t	cliente	computer portatili
franco	combi	tyytjyu	2	weofn	8883445839	17/34	123	60	t	cliente	computer portatili
gaetano78	helloworld	vicolo corto	12	Milano	8569512544526558	0	951	900	t	cliente	videogiochi e console
franco89	ciaociao	corso magellano	5	Roma	5987412563558456	0	589	679	t	cliente	telefonia
ciccio	pasticcio	salieri	43	Verona	33242424243	1234555	4321	847	t	cliente	computer portatili
\.


--
-- Name: acquisto_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY acquisto
    ADD CONSTRAINT acquisto_pkey PRIMARY KEY (id);


--
-- Name: artista_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY artista
    ADD CONSTRAINT artista_pkey PRIMARY KEY (cf);


--
-- Name: azione_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY azione
    ADD CONSTRAINT azione_pkey PRIMARY KEY (nome);


--
-- Name: biglietto_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY biglietto
    ADD CONSTRAINT biglietto_pkey PRIMARY KEY (codice);


--
-- Name: carrello_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY carrello
    ADD CONSTRAINT carrello_pkey PRIMARY KEY (id);


--
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (nome);


--
-- Name: evento_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (codice);


--
-- Name: login_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_pkey PRIMARY KEY (nickname, data_log, ora_log);


--
-- Name: mostra_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY mostra
    ADD CONSTRAINT mostra_pkey PRIMARY KEY (titolo, museo, citta, inizioesposizione);


--
-- Name: museo_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY museo
    ADD CONSTRAINT museo_pkey PRIMARY KEY (nome, citta);


--
-- Name: opera_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY opera
    ADD CONSTRAINT opera_pkey PRIMARY KEY (nome, cognomeautore, nomeautore);


--
-- Name: orario_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY orario
    ADD CONSTRAINT orario_pkey PRIMARY KEY (progressivo, museo, citta);


--
-- Name: partecipanti_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY partecipanti
    ADD CONSTRAINT partecipanti_pkey PRIMARY KEY (id);


--
-- Name: prodotto_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY prodotto
    ADD CONSTRAINT prodotto_pkey PRIMARY KEY (codice);


--
-- Name: settore_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY settore
    ADD CONSTRAINT settore_pkey PRIMARY KEY (numero, evento);


--
-- Name: utente_pkey; Type: CONSTRAINT; Schema: public; Owner: userlab54; Tablespace: 
--

ALTER TABLE ONLY utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (nickname);


--
-- Name: acquisto_id_oggetto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY acquisto
    ADD CONSTRAINT acquisto_id_oggetto_fkey FOREIGN KEY (id_oggetto) REFERENCES prodotto(codice);


--
-- Name: acquisto_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY acquisto
    ADD CONSTRAINT acquisto_utente_fkey FOREIGN KEY (utente) REFERENCES utente(nickname);


--
-- Name: biglietto_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY biglietto
    ADD CONSTRAINT biglietto_evento_fkey FOREIGN KEY (evento) REFERENCES evento(codice);


--
-- Name: biglietto_settore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY biglietto
    ADD CONSTRAINT biglietto_settore_fkey FOREIGN KEY (settore, evento) REFERENCES settore(numero, evento);


--
-- Name: carrello_id_oggetto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY carrello
    ADD CONSTRAINT carrello_id_oggetto_fkey FOREIGN KEY (id_oggetto) REFERENCES prodotto(codice);


--
-- Name: carrello_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY carrello
    ADD CONSTRAINT carrello_utente_fkey FOREIGN KEY (utente) REFERENCES utente(nickname);


--
-- Name: mostra_museo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY mostra
    ADD CONSTRAINT mostra_museo_fkey FOREIGN KEY (museo, citta) REFERENCES museo(nome, citta) ON UPDATE SET DEFAULT ON DELETE SET DEFAULT;


--
-- Name: opera_museo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY opera
    ADD CONSTRAINT opera_museo_fkey FOREIGN KEY (museo, citta) REFERENCES museo(nome, citta) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orario_museo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY orario
    ADD CONSTRAINT orario_museo_fkey FOREIGN KEY (museo, citta) REFERENCES museo(nome, citta) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: partecipanti_artista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY partecipanti
    ADD CONSTRAINT partecipanti_artista_fkey FOREIGN KEY (artista) REFERENCES artista(cf);


--
-- Name: partecipanti_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY partecipanti
    ADD CONSTRAINT partecipanti_evento_fkey FOREIGN KEY (evento) REFERENCES evento(codice);


--
-- Name: prodotto_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY prodotto
    ADD CONSTRAINT prodotto_categoria_fkey FOREIGN KEY (categoria) REFERENCES categoria(nome);


--
-- Name: settore_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY settore
    ADD CONSTRAINT settore_evento_fkey FOREIGN KEY (evento) REFERENCES evento(codice);


--
-- Name: utente_categoria_preferita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: userlab54
--

ALTER TABLE ONLY utente
    ADD CONSTRAINT utente_categoria_preferita_fkey FOREIGN KEY (categoria_preferita) REFERENCES categoria(nome);


--
-- Name: giorno; Type: ACL; Schema: public; Owner: userlab54
--

REVOKE ALL ON TYPE giorno FROM PUBLIC;
REVOKE ALL ON TYPE giorno FROM userlab54;
GRANT ALL ON TYPE giorno TO PUBLIC;


--
-- Name: sect_type; Type: ACL; Schema: public; Owner: userlab54
--

REVOKE ALL ON TYPE sect_type FROM PUBLIC;
REVOKE ALL ON TYPE sect_type FROM userlab54;
GRANT ALL ON TYPE sect_type TO PUBLIC;


--
-- Name: ti_type; Type: ACL; Schema: public; Owner: userlab54
--

REVOKE ALL ON TYPE ti_type FROM PUBLIC;
REVOKE ALL ON TYPE ti_type FROM userlab54;
GRANT ALL ON TYPE ti_type TO PUBLIC;


--
-- Name: tipo_utente; Type: ACL; Schema: public; Owner: userlab54
--

REVOKE ALL ON TYPE tipo_utente FROM PUBLIC;
REVOKE ALL ON TYPE tipo_utente FROM userlab54;
GRANT ALL ON TYPE tipo_utente TO PUBLIC;


--
-- PostgreSQL database dump complete
--

