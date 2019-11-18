--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: commentaries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commentaries (
    id bigint NOT NULL,
    event_id bigint,
    description text,
    commentary_time text,
    team_id bigint,
    player_id bigint,
    fixture_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: commentaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commentaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commentaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commentaries_id_seq OWNED BY public.commentaries.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: fixture_squads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fixture_squads (
    id bigint NOT NULL,
    player_id bigint,
    playing boolean DEFAULT true,
    fixture_id bigint,
    team_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fixture_squads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fixture_squads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fixture_squads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fixture_squads_id_seq OWNED BY public.fixture_squads.id;


--
-- Name: fixtures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fixtures (
    id bigint NOT NULL,
    home_team_id integer,
    away_team_id integer,
    league_id integer,
    center_referee_id integer,
    right_side_referee_id integer,
    left_side_referee_id integer,
    season_id integer,
    match_day timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fixtures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fixtures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fixtures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fixtures_id_seq OWNED BY public.fixtures.id;


--
-- Name: leagues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leagues (
    id bigint NOT NULL,
    title text,
    season text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: leagues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leagues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leagues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leagues_id_seq OWNED BY public.leagues.id;


--
-- Name: leagues_sponsors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leagues_sponsors (
    id bigint NOT NULL,
    league_id integer,
    sponsor_id integer,
    duration integer,
    budget_amount double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: leagues_sponsors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leagues_sponsors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leagues_sponsors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leagues_sponsors_id_seq OWNED BY public.leagues_sponsors.id;


--
-- Name: leagues_teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leagues_teams (
    id bigint NOT NULL,
    team_id integer,
    league_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: leagues_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leagues_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leagues_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leagues_teams_id_seq OWNED BY public.leagues_teams.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    first_name character varying,
    second_name character varying,
    last_name character varying,
    nick_name character varying,
    id_number text,
    dob date,
    phone_number text,
    team_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.results (
    id bigint NOT NULL,
    fixture_id bigint,
    home_goals integer,
    away_goals integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: seasons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seasons (
    id bigint NOT NULL,
    name character varying,
    description text,
    duration integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seasons_id_seq OWNED BY public.seasons.id;


--
-- Name: sponsors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sponsors (
    id bigint NOT NULL,
    name text,
    description text,
    contacts text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sponsors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sponsors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sponsors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sponsors_id_seq OWNED BY public.sponsors.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying,
    description text,
    location text,
    nickname text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transfers (
    id bigint NOT NULL,
    from_team_id integer,
    to_team_id integer,
    player_id integer,
    transfer_comment text,
    transfer_budget double precision,
    contract_time text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying,
    email character varying,
    role_id integer,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: commentaries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries ALTER COLUMN id SET DEFAULT nextval('public.commentaries_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: fixture_squads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixture_squads ALTER COLUMN id SET DEFAULT nextval('public.fixture_squads_id_seq'::regclass);


--
-- Name: fixtures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures ALTER COLUMN id SET DEFAULT nextval('public.fixtures_id_seq'::regclass);


--
-- Name: leagues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues ALTER COLUMN id SET DEFAULT nextval('public.leagues_id_seq'::regclass);


--
-- Name: leagues_sponsors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_sponsors ALTER COLUMN id SET DEFAULT nextval('public.leagues_sponsors_id_seq'::regclass);


--
-- Name: leagues_teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_teams ALTER COLUMN id SET DEFAULT nextval('public.leagues_teams_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: seasons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons ALTER COLUMN id SET DEFAULT nextval('public.seasons_id_seq'::regclass);


--
-- Name: sponsors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsors ALTER COLUMN id SET DEFAULT nextval('public.sponsors_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: transfers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2019-08-22 11:09:30.574132	2019-08-22 11:09:30.574132
\.


--
-- Data for Name: commentaries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.commentaries (id, event_id, description, commentary_time, team_id, player_id, fixture_id, created_at, updated_at) FROM stdin;
2	1	own goal	7	10	1	1	2019-08-22 12:43:30.392878	2019-08-22 12:43:30.392878
3	1	goooal	19	10	1	1	2019-08-22 12:44:33.37423	2019-08-22 12:44:33.37423
4	1	goooal	28	10	1	1	2019-08-22 12:44:38.094731	2019-08-22 12:44:38.094731
5	1	goooal	42	10	1	1	2019-08-22 12:44:57.862277	2019-08-22 12:44:57.862277
6	1	goooal	64	14	16	1	2019-08-22 12:46:36.27492	2019-08-22 12:46:36.27492
9	4	Assist	28	10	28	1	2019-08-22 12:48:06.405325	2019-08-22 12:48:06.405325
10	4	Assist	42	10	28	1	2019-08-22 12:48:13.363665	2019-08-22 12:48:13.363665
7	4	Assist	64	14	28	1	2019-08-22 12:47:14.638346	2019-08-22 12:47:14.638346
8	4	Assist	19	10	28	1	2019-08-22 12:47:42.864785	2019-08-22 12:47:42.864785
11	1	Goooal	25	11	28	2	2019-08-22 12:51:07.215852	2019-08-22 12:51:07.215852
12	1	Goooal	51	11	28	2	2019-08-22 12:51:23.91772	2019-08-22 12:51:23.91772
13	1	Goooal	75	11	28	2	2019-08-22 12:51:34.758869	2019-08-22 12:51:34.758869
14	1	Goooal	86	11	28	2	2019-08-22 12:51:43.751879	2019-08-22 12:51:43.751879
15	1	Goooal	91	11	28	2	2019-08-22 12:52:12.159294	2019-08-22 12:52:12.159294
16	4	Assist	25	11	23	2	2019-08-22 12:52:51.24218	2019-08-22 12:52:51.24218
17	4	Assist	51	11	23	2	2019-08-22 12:52:59.9098	2019-08-22 12:52:59.9098
18	4	Assist	75	11	23	2	2019-08-22 12:53:09.174058	2019-08-22 12:53:09.174058
19	4	Assist	91	11	23	2	2019-08-22 12:53:14.035244	2019-08-22 12:53:14.035244
20	2	Yellow	76	8	31	3	2019-08-22 12:56:59.54718	2019-08-22 12:56:59.54718
21	3	Red	76	8	31	3	2019-08-22 12:57:13.379545	2019-08-22 12:57:13.379545
22	2	Yellow	38	7	21	3	2019-08-22 12:57:35.6292	2019-08-22 12:57:35.6292
23	1	Gooal	63	5	21	4	2019-08-22 13:00:19.217707	2019-08-22 13:00:19.217707
24	1	Gooal	70	5	21	4	2019-08-22 13:00:24.151252	2019-08-22 13:00:24.151252
25	1	Gooal	75	5	21	4	2019-08-22 13:00:50.014712	2019-08-22 13:00:50.014712
26	4	Assist	63	5	21	4	2019-08-22 13:01:09.018147	2019-08-22 13:01:09.018147
27	4	Assist	70	5	21	4	2019-08-22 13:01:18.166388	2019-08-22 13:01:18.166388
28	1	Own Goal	28	4	21	5	2019-08-22 13:02:50.317307	2019-08-22 13:02:50.317307
29	1	Goal	65	4	21	5	2019-08-22 13:02:59.811999	2019-08-22 13:02:59.811999
30	1	Goal	77	4	21	5	2019-08-22 13:03:05.912803	2019-08-22 13:03:05.912803
31	4	Assist	65	4	21	5	2019-08-22 13:03:26.715287	2019-08-22 13:03:26.715287
32	4	Assist	77	4	21	5	2019-08-22 13:03:32.780954	2019-08-22 13:03:32.780954
33	1	Gooal	62	3	21	6	2019-08-22 13:06:14.6735	2019-08-22 13:06:14.6735
34	1	Gooal	88	15	21	6	2019-08-22 13:07:06.224268	2019-08-22 13:07:06.224268
35	1	Gooal	73	17	21	7	2019-08-22 13:08:01.580793	2019-08-22 13:08:01.580793
36	1	Gooal	86	17	21	7	2019-08-22 13:08:10.169293	2019-08-22 13:08:10.169293
37	1	Gooal	90	17	21	7	2019-08-22 13:08:24.369464	2019-08-22 13:08:24.369464
38	4	Assist	73	17	21	7	2019-08-22 13:09:37.484111	2019-08-22 13:09:37.484111
39	4	Assist	90	17	21	7	2019-08-22 13:09:45.720955	2019-08-22 13:09:45.720955
40	1	Gooal	9	2	21	7	2019-08-22 13:10:04.670491	2019-08-22 13:10:04.670491
41	4	Assist	9	2	21	7	2019-08-22 13:10:46.477315	2019-08-22 13:10:46.477315
42	2	Yellow	31	9	21	8	2019-08-22 13:12:13.323013	2019-08-22 13:12:13.323013
43	2	Yellow	60	20	21	8	2019-08-22 13:13:08.777377	2019-08-22 13:13:08.777377
44	1	Gooal	58	1	21	9	2019-08-22 13:14:28.711364	2019-08-22 13:14:28.711364
45	1	Gooal	18	12	21	10	2019-08-22 13:15:43.625357	2019-08-22 13:15:43.625357
46	1	Gooal	67	12	21	10	2019-08-22 13:16:12.27565	2019-08-22 13:16:12.27565
47	1	Gooal	65	12	21	10	2019-08-22 13:16:25.133138	2019-08-22 13:16:25.133138
48	1	Gooal	81	12	21	10	2019-08-22 13:16:42.39873	2019-08-22 13:16:42.39873
49	4	Assist	65	12	21	10	2019-08-22 13:17:18.589937	2019-08-22 13:17:18.589937
50	4	Assist	67	12	21	10	2019-08-22 13:17:29.477106	2019-08-22 13:17:29.477106
51	4	Assist	81	12	21	10	2019-08-22 13:17:35.76195	2019-08-22 13:17:35.76195
52	1	Goooal	7	6	21	11	2019-09-05 09:24:03.07572	2019-09-05 09:24:03.07572
53	2	Yellow card	37	6	23	11	2019-09-05 09:29:56.701966	2019-09-05 09:29:56.701966
54	1	Gooooal	67	9	24	11	2019-09-05 09:32:18.397027	2019-09-05 09:32:18.397027
55	2	is shown the yellow card for a bad foul.	36	16	50	12	2019-09-08 09:55:28.272948	2019-09-08 09:55:28.272948
56	1	Goal! Southampton 0, Liverpool 1. Sadio Mané (Liverpool) right footed shot from the left side of the box to the top right corner. Assisted by James Milner.	45	10	54	12	2019-09-08 09:59:52.522302	2019-09-08 09:59:52.522302
57	4	Assist by James Milner.	45	10	55	12	2019-09-08 10:01:57.979212	2019-09-08 10:01:57.979212
58	1	Goal! Southampton 0, Liverpool 2. Roberto Firmino (Liverpool) right footed shot from the centre of the box to the bottom left corner. Assisted by Sadio Mané.	71	10	55	12	2019-09-08 10:03:42.974729	2019-09-08 10:03:42.974729
59	4	Assist	71	10	56	12	2019-09-08 10:04:20.133035	2019-09-08 10:04:20.133035
60	2	Trent Alexander-Arnold (Liverpool) is shown the yellow card for a bad foul.	79	10	56	12	2019-09-08 10:05:11.377401	2019-09-08 10:05:11.377401
61	1	Goal! Southampton 1, Liverpool 2. Danny Ings (Southampton) right footed shot from the centre of the box to the centre of the goal.	83	16	62	12	2019-09-08 10:07:19.525797	2019-09-08 10:07:19.525797
62	2	Moussa Djenepo (Southampton) is shown the yellow card for a bad foul.	84	16	66	12	2019-09-08 10:08:22.924756	2019-09-08 10:08:22.924756
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events (id, name, description, created_at, updated_at) FROM stdin;
1	Goal	Nobis sed vel. Quo quaerat ipsum. Reprehenderit debitis architecto.	2019-08-22 12:28:11.225115	2019-08-22 12:28:11.225115
2	Yellow	Placeat optio officiis. Nobis sit quia. Illum eos hic.	2019-08-22 12:28:11.234239	2019-08-22 12:28:11.234239
3	Red	Pariatur in in. Voluptas dolor sit. Ea veniam rerum.	2019-08-22 12:28:11.24296	2019-08-22 12:28:11.24296
4	Assist	Vel et eos. Quod quisquam veritatis. Veniam aut ad.	2019-08-22 12:28:11.245576	2019-08-22 12:28:11.245576
5	Corner	Veritatis saepe ad. Iste ut rerum. Odit dolorem reprehenderit.	2019-08-22 12:28:11.248133	2019-08-22 12:28:11.248133
6	Penalty	Ea omnis eum. Labore ipsum reiciendis. Quod voluptas dolore.	2019-08-22 12:28:11.250632	2019-08-22 12:28:11.250632
7	Injury	Occaecati saepe harum. Consequuntur sit repellendus. Soluta et dolore.	2019-08-22 12:28:11.252812	2019-08-22 12:28:11.252812
\.


--
-- Data for Name: fixture_squads; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fixture_squads (id, player_id, playing, fixture_id, team_id, created_at, updated_at) FROM stdin;
1	136	t	1	10	2019-09-11 12:55:08.372666	2019-09-11 12:55:08.372666
2	137	t	1	10	2019-09-11 12:55:08.388701	2019-09-11 12:55:08.388701
3	138	t	1	10	2019-09-11 12:55:08.392467	2019-09-11 12:55:08.392467
4	139	t	1	10	2019-09-11 12:55:08.413817	2019-09-11 12:55:08.413817
5	140	t	1	10	2019-09-11 12:55:08.41909	2019-09-11 12:55:08.41909
6	141	t	1	10	2019-09-11 12:55:08.422714	2019-09-11 12:55:08.422714
7	142	t	1	10	2019-09-11 12:55:08.425602	2019-09-11 12:55:08.425602
8	143	t	1	10	2019-09-11 12:55:08.428172	2019-09-11 12:55:08.428172
9	144	t	1	10	2019-09-11 12:55:08.430766	2019-09-11 12:55:08.430766
10	145	t	1	10	2019-09-11 12:55:08.433946	2019-09-11 12:55:08.433946
11	146	t	1	10	2019-09-11 12:55:08.43708	2019-09-11 12:55:08.43708
12	147	t	1	10	2019-09-11 12:55:08.439777	2019-09-11 12:55:08.439777
13	148	t	1	10	2019-09-11 12:55:08.442339	2019-09-11 12:55:08.442339
14	196	t	1	14	2019-09-11 12:57:33.109581	2019-09-11 12:57:33.109581
15	197	t	1	14	2019-09-11 12:57:33.119346	2019-09-11 12:57:33.119346
16	198	t	1	14	2019-09-11 12:57:33.16572	2019-09-11 12:57:33.16572
17	199	t	1	14	2019-09-11 12:57:33.176791	2019-09-11 12:57:33.176791
18	200	t	1	14	2019-09-11 12:57:33.182441	2019-09-11 12:57:33.182441
19	201	t	1	14	2019-09-11 12:57:33.19909	2019-09-11 12:57:33.19909
20	202	t	1	14	2019-09-11 12:57:33.203519	2019-09-11 12:57:33.203519
21	203	t	1	14	2019-09-11 12:57:33.207885	2019-09-11 12:57:33.207885
22	204	t	1	14	2019-09-11 12:57:33.210785	2019-09-11 12:57:33.210785
23	205	t	1	14	2019-09-11 12:57:33.213483	2019-09-11 12:57:33.213483
24	206	t	1	14	2019-09-11 12:57:33.216494	2019-09-11 12:57:33.216494
25	207	t	1	14	2019-09-11 12:57:33.222692	2019-09-11 12:57:33.222692
26	208	t	1	14	2019-09-11 12:57:33.225514	2019-09-11 12:57:33.225514
27	209	t	1	14	2019-09-11 12:57:33.250954	2019-09-11 12:57:33.250954
\.


--
-- Data for Name: fixtures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fixtures (id, home_team_id, away_team_id, league_id, center_referee_id, right_side_referee_id, left_side_referee_id, season_id, match_day, created_at, updated_at) FROM stdin;
2	19	11	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.207927	2019-08-22 12:38:34.207927
4	5	16	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.232743	2019-08-22 12:38:34.232743
5	18	4	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.244094	2019-08-22 12:38:34.244094
6	3	15	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.250343	2019-08-22 12:38:34.250343
7	17	2	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.261783	2019-08-22 12:38:34.261783
8	9	20	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.267645	2019-08-22 12:38:34.267645
9	13	1	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.285919	2019-08-22 12:38:34.285919
10	12	6	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-08-22 12:38:34.297536	2019-08-22 12:38:34.297536
11	6	9	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-09-05 09:21:18.78003	2019-09-05 09:21:18.78003
12	16	10	3	\N	\N	\N	1	2019-08-22 00:00:00	2019-09-08 09:49:58.817981	2019-09-08 09:49:58.817981
1	10	14	3	2	3	4	1	2019-08-23 00:00:00	2019-08-22 12:38:34.196049	2019-08-22 12:38:34.196049
3	7	8	3	\N	\N	\N	1	2019-08-23 00:00:00	2019-08-22 12:38:34.215226	2019-08-22 12:38:34.215226
13	14	13	3	3	2	4	1	2019-08-23 14:30:00	2019-09-08 10:10:20.463899	2019-09-08 10:10:20.463899
\.


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.leagues (id, title, season, created_at, updated_at) FROM stdin;
1	Asian Cup	Stephenie	2019-08-22 12:28:11.0784	2019-08-22 12:28:11.0784
2	Major League Soccer	Reuben	2019-08-22 12:28:11.087364	2019-08-22 12:28:11.087364
3	Barclays Premier League	Asia	2019-08-22 12:28:11.094483	2019-08-22 12:28:11.094483
4	Copa America	Carolann	2019-08-22 12:28:11.096801	2019-08-22 12:28:11.096801
5	Coppa Italia	Michaele	2019-08-22 12:28:11.099217	2019-08-22 12:28:11.099217
6	FA Cup	Maudie	2019-08-22 12:28:11.101124	2019-08-22 12:28:11.101124
\.


--
-- Data for Name: leagues_sponsors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.leagues_sponsors (id, league_id, sponsor_id, duration, budget_amount, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: leagues_teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.leagues_teams (id, team_id, league_id, created_at, updated_at) FROM stdin;
1	1	3	2019-08-22 12:28:51.846394	2019-08-22 12:28:51.846394
2	2	3	2019-08-22 12:28:51.855153	2019-08-22 12:28:51.855153
3	3	3	2019-08-22 12:28:51.87253	2019-08-22 12:28:51.87253
4	4	3	2019-08-22 12:28:51.881024	2019-08-22 12:28:51.881024
5	5	3	2019-08-22 12:28:51.885704	2019-08-22 12:28:51.885704
6	6	3	2019-08-22 12:28:51.894289	2019-08-22 12:28:51.894289
7	7	3	2019-08-22 12:28:51.898888	2019-08-22 12:28:51.898888
8	8	3	2019-08-22 12:28:51.904907	2019-08-22 12:28:51.904907
9	9	3	2019-08-22 12:28:51.912768	2019-08-22 12:28:51.912768
10	10	3	2019-08-22 12:28:51.917935	2019-08-22 12:28:51.917935
11	11	3	2019-08-22 12:28:51.937871	2019-08-22 12:28:51.937871
12	12	3	2019-08-22 12:28:51.946135	2019-08-22 12:28:51.946135
13	13	3	2019-08-22 12:28:51.950645	2019-08-22 12:28:51.950645
14	14	3	2019-08-22 12:28:51.956018	2019-08-22 12:28:51.956018
15	15	3	2019-08-22 12:28:51.963632	2019-08-22 12:28:51.963632
16	16	3	2019-08-22 12:28:51.968103	2019-08-22 12:28:51.968103
17	17	3	2019-08-22 12:28:51.975049	2019-08-22 12:28:51.975049
18	18	3	2019-08-22 12:28:51.980349	2019-08-22 12:28:51.980349
19	19	3	2019-08-22 12:28:51.996872	2019-08-22 12:28:51.996872
20	20	3	2019-08-22 12:28:52.010246	2019-08-22 12:28:52.010246
21	20	3	2019-09-10 17:42:18.084771	2019-09-10 17:42:18.084771
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.players (id, first_name, second_name, last_name, nick_name, id_number, dob, phone_number, team_id, created_at, updated_at) FROM stdin;
1	Lecia	Dione	Windler	Alvaro Morata	50698763-R	1998-01-14	263.157.1846	1	2019-08-22 12:28:10.048683	2019-08-22 12:28:10.048683
2	Adolph	Chiquita	Simonis	Gareth Bale	89506190-B	1996-12-30	159-966-5290	1	2019-08-22 12:28:10.058645	2019-08-22 12:28:10.058645
3	Dustin	Stefanie	Toy	Gianluigi Buffon	38424008-R	2000-05-05	(300) 022-1910	1	2019-08-22 12:28:10.073144	2019-08-22 12:28:10.073144
4	Cristina	Hettie	Lemke	Manuel Neuer	36574337-J	1984-03-02	968.888.3446	1	2019-08-22 12:28:10.077243	2019-08-22 12:28:10.077243
5	Carolyne	Hyon	Green	Sergio Aguero	47168892-D	1985-05-10	994-291-6713	1	2019-08-22 12:28:10.080809	2019-08-22 12:28:10.080809
6	Catharine	Sonny	Jerde	Edinson Cavani	73103055-Q	1982-05-11	1-432-189-5168	1	2019-08-22 12:28:10.084088	2019-08-22 12:28:10.084088
7	Kristofer	Donita	Carroll	Antoine Griezmann	69068910-W	1999-10-15	(642) 659-5608	1	2019-08-22 12:28:10.087583	2019-08-22 12:28:10.087583
8	Kareem	Franklin	Crist	Cesc Fabregas	35117027-Y	1992-03-05	515.355.0567	1	2019-08-22 12:28:10.090519	2019-08-22 12:28:10.090519
9	Cristin	Thanh	Barton	Gianluigi Buffon	29325412-K	1997-07-17	(765) 695-7439	1	2019-08-22 12:28:10.095193	2019-08-22 12:28:10.095193
10	Leonie	Vesta	Spinka	Mario Mandzukic	80418755-Z	1994-10-27	1-737-284-5306	1	2019-08-22 12:28:10.101222	2019-08-22 12:28:10.101222
11	Isreal	Bobby	Grady	Manuel Neuer	99862305-P	1998-08-13	116-421-6546	1	2019-08-22 12:28:10.104696	2019-08-22 12:28:10.104696
12	Eusebio	Letha	Smith	Mesut Ozil	85744106-Z	1985-06-25	1-970-615-2322	1	2019-08-22 12:28:10.107814	2019-08-22 12:28:10.107814
13	Amiee	Francesco	King	Cristiano Ronaldo	55607708-X	1983-08-07	1-459-705-4741	1	2019-08-22 12:28:10.11106	2019-08-22 12:28:10.11106
14	Eldon	Alonzo	Wiegand	Mesut Ozil	55693417-K	1992-05-21	102.869.1088	1	2019-08-22 12:28:10.114228	2019-08-22 12:28:10.114228
15	Willard	Mandi	White	Mario Mandzukic	40027222-T	1997-09-12	(725) 088-5687	1	2019-08-22 12:28:10.117308	2019-08-22 12:28:10.117308
16	Luanne	Donte	Bergnaum	Gerard Pique	30428545-M	1989-07-14	518-848-5573	2	2019-08-22 12:28:10.120591	2019-08-22 12:28:10.120591
17	India	Lilia	Halvorson	Franck Ribery	48436491-D	2000-05-22	(821) 971-6290	2	2019-08-22 12:28:10.123807	2019-08-22 12:28:10.123807
18	Tana	Sudie	Blick	Sergio Ramos	13353127-V	1994-06-24	482-987-4058	2	2019-08-22 12:28:10.126774	2019-08-22 12:28:10.126774
19	Janita	Izola	Kerluke	Alvaro Morata	19345839-X	1994-01-27	(248) 796-8696	2	2019-08-22 12:28:10.13007	2019-08-22 12:28:10.13007
20	Sophia	Cecila	Huel	Robert Lewandoski	78103084-Y	1990-10-08	(431) 576-0707	2	2019-08-22 12:28:10.133338	2019-08-22 12:28:10.133338
21	Reginald	Chelsea	Corkery	Eden Hazard	41639331-Q	1991-10-03	181.353.4435	2	2019-08-22 12:28:10.13657	2019-08-22 12:28:10.13657
22	Terrell	Ruth	Mills	Cristiano Ronaldo	65334885-G	1998-08-11	612.636.7623	2	2019-08-22 12:28:10.139584	2019-08-22 12:28:10.139584
23	Trudi	Trudy	McClure	Lionel Messi	77333299-P	1994-01-12	(836) 423-2046	2	2019-08-22 12:28:10.142869	2019-08-22 12:28:10.142869
24	Anika	Rachal	Hettinger	Franck Ribery	35146806-T	1986-09-25	(783) 369-5314	2	2019-08-22 12:28:10.146172	2019-08-22 12:28:10.146172
25	Ronnie	Maryellen	Haley	Mohammed Salah	35211620-T	1998-09-20	583-896-1469	2	2019-08-22 12:28:10.149207	2019-08-22 12:28:10.149207
26	Greg	Kristyn	Leannon	Mesut Ozil	76812585-Z	1998-04-10	1-447-155-0536	2	2019-08-22 12:28:10.152239	2019-08-22 12:28:10.152239
27	Marlin	Tinisha	Farrell	Mesut Ozil	62996877-S	1995-05-26	101.133.6022	2	2019-08-22 12:28:10.155412	2019-08-22 12:28:10.155412
28	Marline	Arlena	Sipes	Willian	26798844-A	1999-10-16	226-156-0855	2	2019-08-22 12:28:10.158354	2019-08-22 12:28:10.158354
29	Aleisha	Kimbra	Rice	Franck Ribery	85009957-W	1988-12-14	1-572-587-4264	2	2019-08-22 12:28:10.161744	2019-08-22 12:28:10.161744
30	Vanita	Angeles	Hilll	Manuel Neuer	60469452-Z	1994-11-27	(250) 939-4069	2	2019-08-22 12:28:10.165171	2019-08-22 12:28:10.165171
31	Curtis	Lavern	Leuschke	Robert Lewandoski	91125897-N	1988-06-24	672-591-3224	3	2019-08-22 12:28:10.168293	2019-08-22 12:28:10.168293
32	Micaela	Tambra	Hirthe	Gareth Bale	24207950-J	1996-09-21	(138) 290-1633	3	2019-08-22 12:28:10.171324	2019-08-22 12:28:10.171324
33	Trent	Kip	Ferry	Manuel Neuer	10196879-J	1987-03-02	494.448.4612	3	2019-08-22 12:28:10.174619	2019-08-22 12:28:10.174619
34	Traci	Deanna	Medhurst	Franck Ribery	57119252-V	1987-10-10	293.523.1567	3	2019-08-22 12:28:10.177873	2019-08-22 12:28:10.177873
35	Princess	Cinthia	Gusikowski	Zlatan Ibrahimovic	73043363-D	1992-04-19	1-136-199-4568	3	2019-08-22 12:28:10.180986	2019-08-22 12:28:10.180986
36	Kermit	Lachelle	Murphy	Gareth Bale	48848526-E	1993-03-10	1-131-930-0181	3	2019-08-22 12:28:10.184119	2019-08-22 12:28:10.184119
37	Timothy	Sanda	Ledner	Andres Iniesta	37576637-L	1988-08-19	1-314-037-8706	3	2019-08-22 12:28:10.187419	2019-08-22 12:28:10.187419
38	Bennett	Cristopher	Schaden	Juan Mata	29513808-R	1982-01-19	1-932-441-3943	3	2019-08-22 12:28:10.190314	2019-08-22 12:28:10.190314
39	Royal	Lakiesha	Schimmel	Robert Lewandoski	78138864-K	1983-12-04	(329) 088-2435	3	2019-08-22 12:28:10.193475	2019-08-22 12:28:10.193475
40	Marcus	Zack	Johnston	Gareth Bale	99382136-X	1997-03-06	370.803.4662	3	2019-08-22 12:28:10.196933	2019-08-22 12:28:10.196933
41	Bennett	Fredricka	Cartwright	Sergio Ramos	39178309-V	1996-10-14	(967) 335-0809	3	2019-08-22 12:28:10.200456	2019-08-22 12:28:10.200456
42	Lourie	Tomasa	Haley	Manuel Neuer	83396665-E	1984-03-09	(274) 566-8335	3	2019-08-22 12:28:10.203656	2019-08-22 12:28:10.203656
43	Lianne	Brenna	Reynolds	Willian	18024104-Q	1985-03-03	455.191.8866	3	2019-08-22 12:28:10.206661	2019-08-22 12:28:10.206661
44	Stevie	Charles	Weber	Andres Iniesta	94060736-M	1999-08-25	628.781.0964	3	2019-08-22 12:28:10.209808	2019-08-22 12:28:10.209808
45	Willette	Miles	Mueller	Franck Ribery	96411349-H	1992-03-26	624.401.7420	3	2019-08-22 12:28:10.213001	2019-08-22 12:28:10.213001
46	Peter	Gale	Wuckert	Juan Mata	23488376-V	1994-05-26	462-296-6206	4	2019-08-22 12:28:10.216312	2019-08-22 12:28:10.216312
47	Dee	Chana	Gerhold	Willian	92198549-J	1991-02-17	879.224.7995	4	2019-08-22 12:28:10.219259	2019-08-22 12:28:10.219259
48	Andreas	Hilary	Stokes	Alvaro Morata	55047408-J	1985-02-01	660.397.4499	4	2019-08-22 12:28:10.222518	2019-08-22 12:28:10.222518
49	Laurence	Milagro	Toy	Antoine Griezmann	33892980-L	1995-06-24	1-552-688-0953	4	2019-08-22 12:28:10.225731	2019-08-22 12:28:10.225731
50	Rocky	Hector	Larson	Mohammed Salah	44319753-H	1991-09-09	331-413-8840	4	2019-08-22 12:28:10.228924	2019-08-22 12:28:10.228924
51	Marni	Ardith	Parker	Eden Hazard	66599491-R	1990-07-08	1-470-429-7704	4	2019-08-22 12:28:10.231894	2019-08-22 12:28:10.231894
52	Daina	Marnie	Langosh	Franck Ribery	40452252-J	1985-11-03	802.786.3186	4	2019-08-22 12:28:10.235028	2019-08-22 12:28:10.235028
53	Burt	Beverly	Conroy	Harry Kane	54167477-Q	1990-01-30	(904) 013-0719	4	2019-08-22 12:28:10.238463	2019-08-22 12:28:10.238463
54	Alise	Alvera	Tremblay	Manuel Neuer	49624154-K	1997-11-26	843-251-5937	4	2019-08-22 12:28:10.241816	2019-08-22 12:28:10.241816
55	Jonas	Anabel	Aufderhar	David De Gea	99698527-J	1985-12-06	(664) 366-2045	4	2019-08-22 12:28:10.245786	2019-08-22 12:28:10.245786
56	Carroll	Sina	Shields	Manuel Neuer	77371492-K	1997-03-12	779.138.7069	4	2019-08-22 12:28:10.258293	2019-08-22 12:28:10.258293
57	Ronnie	Lamonica	Schaden	Neymar	72147366-T	1981-09-26	380-227-0811	4	2019-08-22 12:28:10.268685	2019-08-22 12:28:10.268685
58	Jefferson	Doreen	Hansen	Roberto Firmino	19595061-G	1982-04-10	(107) 320-3153	4	2019-08-22 12:28:10.277464	2019-08-22 12:28:10.277464
59	Thomasina	Luz	Pagac	Manuel Neuer	59527829-B	1992-06-17	543-265-3503	4	2019-08-22 12:28:10.280806	2019-08-22 12:28:10.280806
60	Carl	Keturah	Grant	Zlatan Ibrahimovic	96977839-H	1993-03-22	(421) 305-8800	4	2019-08-22 12:28:10.284266	2019-08-22 12:28:10.284266
61	Elfreda	Cordie	Weber	Eden Hazard	92534164-N	1981-10-28	470.409.8911	5	2019-08-22 12:28:10.287615	2019-08-22 12:28:10.287615
62	Milagros	Ira	Spinka	Gianluigi Buffon	85818694-J	1988-12-20	1-499-140-5609	5	2019-08-22 12:28:10.290681	2019-08-22 12:28:10.290681
63	Nathanial	Josefina	Lubowitz	Eden Hazard	19528412-D	1997-09-15	1-350-518-9542	5	2019-08-22 12:28:10.29364	2019-08-22 12:28:10.29364
64	Magan	Shalonda	Weimann	Mesut Ozil	98591869-T	1993-10-04	(548) 412-7759	5	2019-08-22 12:28:10.297152	2019-08-22 12:28:10.297152
65	Gregory	Guy	Goyette	Zlatan Ibrahimovic	34095394-X	1993-03-26	488-494-2848	5	2019-08-22 12:28:10.300678	2019-08-22 12:28:10.300678
66	Arielle	Silas	Kuhic	Robert Lewandoski	38955948-C	1993-08-04	566.935.3811	5	2019-08-22 12:28:10.304255	2019-08-22 12:28:10.304255
67	Gregoria	Albertina	Heathcote	Alvaro Morata	83054899-J	1991-08-26	456-997-2692	5	2019-08-22 12:28:10.307819	2019-08-22 12:28:10.307819
68	Buford	Johnie	Aufderhar	Andres Iniesta	64101347-W	1999-02-15	(967) 298-4712	5	2019-08-22 12:28:10.310989	2019-08-22 12:28:10.310989
69	Mariela	Tu	Williamson	Eden Hazard	37951341-F	1997-09-17	(841) 994-7010	5	2019-08-22 12:28:10.314288	2019-08-22 12:28:10.314288
70	Alida	Pamella	Swaniawski	Willian	99034963-E	1986-11-09	(333) 970-7436	5	2019-08-22 12:28:10.317347	2019-08-22 12:28:10.317347
71	Janene	Mellisa	O'Kon	Juan Mata	40843054-E	1988-02-29	267.900.4191	5	2019-08-22 12:28:10.320437	2019-08-22 12:28:10.320437
72	Dusty	Beatrice	Grady	Paul Pogba	43076584-E	1996-04-12	1-651-661-4586	5	2019-08-22 12:28:10.32395	2019-08-22 12:28:10.32395
73	Christy	Betty	Hills	Arjen Robben	52215288-K	1995-01-25	(874) 134-4483	5	2019-08-22 12:28:10.327282	2019-08-22 12:28:10.327282
74	Lorrie	Lorilee	Bahringer	Antoine Griezmann	79950628-Y	1987-09-26	(339) 877-5584	5	2019-08-22 12:28:10.330219	2019-08-22 12:28:10.330219
75	Rayna	Princess	Torp	Sergio Aguero	51961508-T	1999-06-10	1-207-908-9352	5	2019-08-22 12:28:10.33356	2019-08-22 12:28:10.33356
76	Delmar	Sau	Feest	Sergio Aguero	43591271-S	1981-12-24	613.144.4164	6	2019-08-22 12:28:10.336784	2019-08-22 12:28:10.336784
77	Rebeca	Carolyn	Kshlerin	Antoine Griezmann	73124234-N	1984-05-06	962-655-0371	6	2019-08-22 12:28:10.339794	2019-08-22 12:28:10.339794
78	Sergio	Whitney	Hessel	Andres Iniesta	99324105-P	1984-05-24	514-084-0243	6	2019-08-22 12:28:10.343072	2019-08-22 12:28:10.343072
79	Kirstie	Emogene	Beer	Willian	50147245-T	1985-09-21	543.530.5351	6	2019-08-22 12:28:10.346068	2019-08-22 12:28:10.346068
80	Rafael	Susannah	Pfannerstill	Robert Lewandoski	70740751-L	1988-09-01	912-779-9739	6	2019-08-22 12:28:10.349117	2019-08-22 12:28:10.349117
81	Charissa	Tenisha	Wehner	Cristiano Ronaldo	74102565-S	1993-04-01	1-715-701-2332	6	2019-08-22 12:28:10.352225	2019-08-22 12:28:10.352225
82	Ollie	Song	Hilll	Edinson Cavani	73870507-G	1991-03-29	(888) 070-9867	6	2019-08-22 12:28:10.355427	2019-08-22 12:28:10.355427
83	Israel	Andria	Grant	Willian	18422055-K	1986-07-28	887.790.7971	6	2019-08-22 12:28:10.358755	2019-08-22 12:28:10.358755
84	Cortez	Soledad	Kuhic	Antoine Griezmann	12841698-Q	1996-04-28	1-998-710-0574	6	2019-08-22 12:28:10.361819	2019-08-22 12:28:10.361819
85	Branden	Alisha	Little	Cristiano Ronaldo	89770767-L	1983-11-30	730.013.0043	6	2019-08-22 12:28:10.365067	2019-08-22 12:28:10.365067
86	Shaquana	Robby	Sipes	Cristiano Ronaldo	66334185-T	1983-06-19	1-551-441-4359	6	2019-08-22 12:28:10.368109	2019-08-22 12:28:10.368109
87	Pamula	Lesley	Emmerich	Gareth Bale	75503204-T	1988-05-09	1-654-339-1221	6	2019-08-22 12:28:10.37159	2019-08-22 12:28:10.37159
88	Mona	Jesusa	Morissette	Andres Iniesta	41270043-Q	1984-07-27	(154) 597-9044	6	2019-08-22 12:28:10.375107	2019-08-22 12:28:10.375107
89	Alease	Toni	Adams	Gerard Pique	68183947-X	1997-09-21	(304) 845-7420	6	2019-08-22 12:28:10.378419	2019-08-22 12:28:10.378419
90	Jonas	Del	Runolfsson	Robert Lewandoski	67430000-A	1993-09-21	189.373.5135	6	2019-08-22 12:28:10.381724	2019-08-22 12:28:10.381724
91	Viva	Giselle	Lubowitz	Juan Mata	97022147-M	1987-07-09	1-511-356-8648	7	2019-08-22 12:28:10.384748	2019-08-22 12:28:10.384748
92	Odelia	Shirley	Deckow	Roberto Firmino	43162734-Z	1988-06-11	(548) 257-0846	7	2019-08-22 12:28:10.387908	2019-08-22 12:28:10.387908
93	Kris	Cleveland	Mante	Mohammed Salah	47697422-E	1994-03-10	718.178.1060	7	2019-08-22 12:28:10.391298	2019-08-22 12:28:10.391298
94	Jana	Tommy	Pfannerstill	Juan Mata	26605187-Y	1993-10-25	734-677-1176	7	2019-08-22 12:28:10.394416	2019-08-22 12:28:10.394416
95	Brianna	Anamaria	Smith	Eden Hazard	54936307-W	1985-11-01	1-881-470-0036	7	2019-08-22 12:28:10.397514	2019-08-22 12:28:10.397514
96	Tiffani	Kyoko	Hartmann	Mesut Ozil	33113115-S	1995-09-02	120.000.0917	7	2019-08-22 12:28:10.400749	2019-08-22 12:28:10.400749
97	Wayne	Kirstie	Hartmann	Arjen Robben	35960101-S	1994-06-26	1-920-545-7605	7	2019-08-22 12:28:10.404191	2019-08-22 12:28:10.404191
98	Edyth	Alex	Mertz	Cesc Fabregas	72632371-G	1984-01-31	713.641.0981	7	2019-08-22 12:28:10.407793	2019-08-22 12:28:10.407793
99	Boyd	Beata	Bosco	Neymar	85518410-V	1990-03-05	(402) 376-8653	7	2019-08-22 12:28:10.410965	2019-08-22 12:28:10.410965
100	Delisa	Aleta	Barrows	Harry Kane	95014060-W	1982-05-11	530.446.4213	7	2019-08-22 12:28:10.414517	2019-08-22 12:28:10.414517
101	Tracie	Kaylene	Bruen	Mohammed Salah	10069517-W	1997-11-04	1-365-031-0629	7	2019-08-22 12:28:10.422371	2019-08-22 12:28:10.422371
102	Trevor	Eliseo	Heaney	Marco Reus	43680535-Q	1984-12-02	(299) 917-8267	7	2019-08-22 12:28:10.425737	2019-08-22 12:28:10.425737
103	Ardell	Derrick	Reichert	Mesut Ozil	90579964-F	1988-04-21	342.647.2343	7	2019-08-22 12:28:10.429062	2019-08-22 12:28:10.429062
104	Isidro	Carrol	Stehr	Sergio Ramos	30677664-B	1995-05-25	1-101-735-3510	7	2019-08-22 12:28:10.432204	2019-08-22 12:28:10.432204
105	Jeanette	Christel	Schiller	David De Gea	30229493-H	1990-07-10	303.869.1244	7	2019-08-22 12:28:10.435593	2019-08-22 12:28:10.435593
106	Travis	Conception	Koch	Lionel Messi	46649388-Y	1995-11-28	1-321-857-9889	8	2019-08-22 12:28:10.438979	2019-08-22 12:28:10.438979
107	Ambrose	Jacquelyn	Auer	Antoine Griezmann	73899630-D	1997-03-17	147.815.7882	8	2019-08-22 12:28:10.442314	2019-08-22 12:28:10.442314
108	Annett	Jefferson	Ritchie	Robert Lewandoski	57348376-S	1999-10-13	(273) 117-9987	8	2019-08-22 12:28:10.445638	2019-08-22 12:28:10.445638
109	Nicholas	Veda	Johnston	Marco Reus	36580960-N	1987-08-05	(929) 356-4142	8	2019-08-22 12:28:10.448731	2019-08-22 12:28:10.448731
110	Nicolle	Austin	Kuhlman	Manuel Neuer	71053679-D	1987-08-28	724.663.8734	8	2019-08-22 12:28:10.451696	2019-08-22 12:28:10.451696
111	Tyrell	Joaquina	Sanford	Mesut Ozil	51564290-S	1986-07-17	1-407-074-0349	8	2019-08-22 12:28:10.45476	2019-08-22 12:28:10.45476
112	Tatum	Nicole	Zieme	David De Gea	69383725-Q	1991-02-04	1-282-612-6328	8	2019-08-22 12:28:10.457807	2019-08-22 12:28:10.457807
113	Jerrell	Margert	Greenfelder	Franck Ribery	91252358-L	1985-10-06	1-212-288-4333	8	2019-08-22 12:28:10.460967	2019-08-22 12:28:10.460967
114	Mark	Erich	Adams	Franck Ribery	70618846-Z	1981-12-13	231.730.5330	8	2019-08-22 12:28:10.464271	2019-08-22 12:28:10.464271
115	Filomena	Tamesha	Wisozk	Harry Kane	95551589-K	1994-08-21	451.265.6354	8	2019-08-22 12:28:10.467433	2019-08-22 12:28:10.467433
116	Noreen	Aurora	Hodkiewicz	Delle Alli	55303136-G	1998-06-03	(573) 666-4722	8	2019-08-22 12:28:10.470341	2019-08-22 12:28:10.470341
117	Hilario	Sparkle	Kuvalis	Sergio Aguero	97957166-M	1989-04-19	(432) 367-6022	8	2019-08-22 12:28:10.473473	2019-08-22 12:28:10.473473
118	Thresa	Lorina	Wiza	Cristiano Ronaldo	55034670-V	1985-11-29	304.160.1975	8	2019-08-22 12:28:10.47667	2019-08-22 12:28:10.47667
119	Sharron	Jason	Heller	Franck Ribery	24751066-F	2000-04-20	774.776.7082	8	2019-08-22 12:28:10.47976	2019-08-22 12:28:10.47976
120	Xochitl	Janett	Legros	Alvaro Morata	39349153-V	1991-01-09	568.912.7737	8	2019-08-22 12:28:10.482797	2019-08-22 12:28:10.482797
121	Althea	Rosia	Ullrich	Roberto Firmino	27694217-D	1989-07-19	126.948.4626	9	2019-08-22 12:28:10.486121	2019-08-22 12:28:10.486121
122	Edgardo	Celia	Ankunding	Gianluigi Buffon	19080372-D	1989-10-05	1-521-689-6849	9	2019-08-22 12:28:10.489159	2019-08-22 12:28:10.489159
123	Drew	Russell	Brakus	Mohammed Salah	86096616-A	1994-04-21	(597) 094-7716	9	2019-08-22 12:28:10.492284	2019-08-22 12:28:10.492284
124	Jacinto	Maryjo	Watsica	Mario Mandzukic	63339787-H	1995-09-28	1-350-723-1879	9	2019-08-22 12:28:10.495699	2019-08-22 12:28:10.495699
125	Mac	Alisha	Gusikowski	Manuel Neuer	91007531-G	1981-12-29	(222) 019-8345	9	2019-08-22 12:28:10.499104	2019-08-22 12:28:10.499104
126	Omer	Lynna	Bernhard	Edinson Cavani	25895573-B	1994-06-20	(631) 715-8588	9	2019-08-22 12:28:10.502212	2019-08-22 12:28:10.502212
127	Tambra	Tiara	Parker	Manuel Neuer	20043159-Q	1990-04-20	174-388-6487	9	2019-08-22 12:28:10.505265	2019-08-22 12:28:10.505265
128	Homer	Toby	Emard	Andres Iniesta	16412563-Q	1998-06-06	107.736.0628	9	2019-08-22 12:28:10.508584	2019-08-22 12:28:10.508584
129	Donnette	Maryalice	Collier	Willian	57902972-N	1988-07-24	716-334-6714	9	2019-08-22 12:28:10.512075	2019-08-22 12:28:10.512075
130	Ellis	Ivory	Kuvalis	Manuel Neuer	27051167-Q	1988-09-19	678.446.0758	9	2019-08-22 12:28:10.515077	2019-08-22 12:28:10.515077
131	Karissa	Genaro	Schuppe	Gareth Bale	28207299-F	1987-02-21	652.401.8564	9	2019-08-22 12:28:10.518138	2019-08-22 12:28:10.518138
132	Randy	Regenia	Dickinson	Antoine Griezmann	92600415-T	1981-09-16	1-798-592-3329	9	2019-08-22 12:28:10.521411	2019-08-22 12:28:10.521411
133	Michael	Robbin	Kautzer	Alvaro Morata	15693080-L	1994-02-03	269.147.3178	9	2019-08-22 12:28:10.52448	2019-08-22 12:28:10.52448
134	Claude	Victor	Larson	Sergio Aguero	37338017-R	1985-08-10	(518) 221-4545	9	2019-08-22 12:28:10.527904	2019-08-22 12:28:10.527904
135	Neomi	Kayce	Kuvalis	Manuel Neuer	77466357-B	1991-11-15	574.032.2934	9	2019-08-22 12:28:10.534369	2019-08-22 12:28:10.534369
136	Mason	Reva	Wiegand	Alvaro Morata	43858491-K	1985-01-16	490.094.1741	10	2019-08-22 12:28:10.537691	2019-08-22 12:28:10.537691
137	Brendan	Verlene	Towne	Lionel Messi	68066230-F	1984-11-15	(173) 891-8037	10	2019-08-22 12:28:10.540941	2019-08-22 12:28:10.540941
138	Arlena	Beatrice	Wehner	Zlatan Ibrahimovic	87710691-F	1995-12-04	1-224-009-0899	10	2019-08-22 12:28:10.544194	2019-08-22 12:28:10.544194
139	Stuart	Hung	Lueilwitz	Robert Lewandoski	95853056-G	1988-02-01	1-391-329-7254	10	2019-08-22 12:28:10.547489	2019-08-22 12:28:10.547489
140	Jefferey	Franklin	Hills	Neymar	41702361-A	1997-09-08	679.239.1403	10	2019-08-22 12:28:10.550729	2019-08-22 12:28:10.550729
141	Edmundo	Theresia	Wehner	Willian	14261710-P	1987-01-24	1-684-282-4656	10	2019-08-22 12:28:10.553917	2019-08-22 12:28:10.553917
142	Amos	Madeline	Murray	Arjen Robben	43197330-H	1988-02-23	446-902-0951	10	2019-08-22 12:28:10.55722	2019-08-22 12:28:10.55722
143	Lianne	Luvenia	Dooley	Eden Hazard	21435405-A	1993-06-10	444.365.9417	10	2019-08-22 12:28:10.560128	2019-08-22 12:28:10.560128
144	Jacquelyn	Deeanna	Herman	Gianluigi Buffon	28905955-S	2000-02-16	546.506.0713	10	2019-08-22 12:28:10.56315	2019-08-22 12:28:10.56315
145	Jarrett	Ernesto	Breitenberg	Juan Mata	22851563-M	1984-12-07	1-159-591-5406	10	2019-08-22 12:28:10.566374	2019-08-22 12:28:10.566374
146	Merle	Neta	Williamson	Roberto Firmino	83167237-L	1988-06-01	(138) 269-9269	10	2019-08-22 12:28:10.569437	2019-08-22 12:28:10.569437
147	Zona	Refugia	Conn	Marco Reus	26798839-K	1997-05-14	(407) 763-6548	10	2019-08-22 12:28:10.572576	2019-08-22 12:28:10.572576
148	Kayleen	Daryl	Simonis	Sergio Aguero	17680569-D	1992-02-05	993-797-2018	10	2019-08-22 12:28:10.575516	2019-08-22 12:28:10.575516
149	Deandre	Ralph	Block	Paul Pogba	47134207-P	1987-01-16	875-179-5724	10	2019-08-22 12:28:10.578903	2019-08-22 12:28:10.578903
150	Faustino	Nathanial	Mitchell	David De Gea	82199007-C	1987-10-03	(319) 373-3245	10	2019-08-22 12:28:10.582216	2019-08-22 12:28:10.582216
151	Florencia	Howard	Raynor	Andres Iniesta	36486083-X	1998-07-01	(566) 649-5858	11	2019-08-22 12:28:10.585309	2019-08-22 12:28:10.585309
152	Vera	Meridith	Brown	Harry Kane	58768054-H	1998-05-22	605.540.3735	11	2019-08-22 12:28:10.588585	2019-08-22 12:28:10.588585
153	Mimi	Blake	Breitenberg	Gerard Pique	48325002-R	1999-03-11	1-723-240-2696	11	2019-08-22 12:28:10.591831	2019-08-22 12:28:10.591831
154	Gregory	Jacinda	Little	Franck Ribery	93780590-E	1986-10-27	(562) 253-0009	11	2019-08-22 12:28:10.594943	2019-08-22 12:28:10.594943
155	Stanford	Colton	Erdman	Roberto Firmino	58480973-T	1996-05-30	1-341-805-6233	11	2019-08-22 12:28:10.59782	2019-08-22 12:28:10.59782
156	Dara	Jaleesa	Turner	Harry Kane	28019420-S	1988-04-12	1-686-372-2293	11	2019-08-22 12:28:10.601196	2019-08-22 12:28:10.601196
157	Carlota	Chun	Swaniawski	Mario Mandzukic	27131271-B	1990-06-13	1-234-915-1640	11	2019-08-22 12:28:10.604406	2019-08-22 12:28:10.604406
158	Cammy	Beula	Armstrong	Juan Mata	55378597-W	1997-08-20	(826) 993-6714	11	2019-08-22 12:28:10.607675	2019-08-22 12:28:10.607675
159	Myrtle	Annett	Bechtelar	Mario Mandzukic	15273582-H	1997-06-11	1-872-146-2387	11	2019-08-22 12:28:10.610807	2019-08-22 12:28:10.610807
160	Larry	Renata	Klocko	Cesc Fabregas	72225643-P	1984-11-16	337-566-5689	11	2019-08-22 12:28:10.613989	2019-08-22 12:28:10.613989
161	Emmett	Jann	Sauer	Cristiano Ronaldo	79407151-L	1995-12-26	1-917-321-3389	11	2019-08-22 12:28:10.617181	2019-08-22 12:28:10.617181
162	Kermit	Donald	Ferry	Neymar	23466079-F	1990-01-01	851.241.6711	11	2019-08-22 12:28:10.620455	2019-08-22 12:28:10.620455
163	Tyron	Eunice	Barrows	Harry Kane	94954229-V	1983-05-06	437-356-8830	11	2019-08-22 12:28:10.623458	2019-08-22 12:28:10.623458
164	Davis	Marita	Schuppe	Manuel Neuer	51195844-Y	1991-03-14	1-359-300-6247	11	2019-08-22 12:28:10.626466	2019-08-22 12:28:10.626466
165	Torri	Jennell	Schuster	Gareth Bale	79789143-G	1987-06-21	400-625-6274	11	2019-08-22 12:28:10.629523	2019-08-22 12:28:10.629523
166	Malissa	Tom	Sporer	Sergio Aguero	43727693-R	1985-11-14	1-293-703-6057	12	2019-08-22 12:28:10.632515	2019-08-22 12:28:10.632515
167	Mitsuko	Aleida	Reilly	David De Gea	45070176-C	1995-08-13	918-532-9311	12	2019-08-22 12:28:10.635846	2019-08-22 12:28:10.635846
168	Herman	Hung	Murphy	Arjen Robben	18821988-F	2000-01-15	(899) 372-8436	12	2019-08-22 12:28:10.639198	2019-08-22 12:28:10.639198
169	Brittanie	Todd	Gibson	Mesut Ozil	84602796-X	1994-09-10	1-789-794-8772	12	2019-08-22 12:28:10.642616	2019-08-22 12:28:10.642616
170	Clotilde	Tomoko	Hegmann	Mario Mandzukic	13006135-A	1997-11-08	(541) 004-7361	12	2019-08-22 12:28:10.645919	2019-08-22 12:28:10.645919
171	Bryan	Tinisha	Ryan	Antoine Griezmann	69484250-P	1987-08-14	1-150-290-0987	12	2019-08-22 12:28:10.649093	2019-08-22 12:28:10.649093
172	Ginger	Yuki	Blick	Roberto Firmino	49214689-W	1995-07-30	(409) 447-5650	12	2019-08-22 12:28:10.65223	2019-08-22 12:28:10.65223
173	Barabara	Rosette	Bayer	Paul Pogba	77170321-P	1988-09-08	668-832-9617	12	2019-08-22 12:28:10.655283	2019-08-22 12:28:10.655283
174	Marcelo	Dean	Crooks	Cesc Fabregas	60048180-X	1999-02-23	(421) 127-2347	12	2019-08-22 12:28:10.658743	2019-08-22 12:28:10.658743
175	Ozzie	Alton	Roob	Marco Reus	44007704-X	1988-10-30	203-903-7326	12	2019-08-22 12:28:10.66228	2019-08-22 12:28:10.66228
176	Cedrick	Vivienne	Erdman	Manuel Neuer	64655555-W	1992-08-12	917-903-7756	12	2019-08-22 12:28:10.665611	2019-08-22 12:28:10.665611
177	Celestina	Lynne	Pacocha	Juan Mata	42104699-W	1991-04-20	(382) 686-9548	12	2019-08-22 12:28:10.6688	2019-08-22 12:28:10.6688
178	Shemeka	Mirtha	Ullrich	Sergio Aguero	80724339-C	1983-03-20	727.291.5565	12	2019-08-22 12:28:10.672085	2019-08-22 12:28:10.672085
179	Nadia	Christian	Becker	Cesc Fabregas	15634235-P	1999-04-29	1-246-427-3737	12	2019-08-22 12:28:10.675257	2019-08-22 12:28:10.675257
180	Erich	Liane	McLaughlin	Gareth Bale	62306852-J	1984-08-26	622.904.0123	12	2019-08-22 12:28:10.678588	2019-08-22 12:28:10.678588
181	Kimiko	Coretta	Walter	Marco Reus	32301395-B	1992-03-07	511-394-6546	13	2019-08-22 12:28:10.682054	2019-08-22 12:28:10.682054
182	Karoline	Nikita	Bergnaum	Roberto Firmino	40496967-Q	1981-12-13	(523) 447-8414	13	2019-08-22 12:28:10.68558	2019-08-22 12:28:10.68558
183	Patti	Kimbra	Rutherford	Paul Pogba	39527407-K	1996-03-23	1-415-841-6897	13	2019-08-22 12:28:10.688578	2019-08-22 12:28:10.688578
184	Delila	Wanetta	Dach	Gerard Pique	41330532-S	1984-09-19	(547) 865-9655	13	2019-08-22 12:28:10.691446	2019-08-22 12:28:10.691446
185	Erin	Willy	Baumbach	Gareth Bale	86483025-N	1986-10-23	522-683-9635	13	2019-08-22 12:28:10.694411	2019-08-22 12:28:10.694411
186	Catherin	Drew	Bogisich	Sergio Aguero	36094183-F	1990-01-15	1-145-866-3192	13	2019-08-22 12:28:10.69791	2019-08-22 12:28:10.69791
187	Bianca	Myrl	Champlin	Mesut Ozil	34807056-Y	1996-11-17	736-347-3909	13	2019-08-22 12:28:10.701215	2019-08-22 12:28:10.701215
188	Iesha	Sebastian	Lakin	David De Gea	15015206-R	1996-03-19	1-695-816-0729	13	2019-08-22 12:28:10.704434	2019-08-22 12:28:10.704434
189	Curt	Stefania	Vandervort	Harry Kane	15832443-W	1987-01-31	1-178-662-0185	13	2019-08-22 12:28:10.70781	2019-08-22 12:28:10.70781
190	Twanda	Ozie	Stoltenberg	Eden Hazard	92410982-H	1984-02-17	1-871-230-8605	13	2019-08-22 12:28:10.711193	2019-08-22 12:28:10.711193
191	Selene	Janyce	Schulist	Manuel Neuer	64066963-A	1981-09-04	(767) 812-7078	13	2019-08-22 12:28:10.714447	2019-08-22 12:28:10.714447
192	Lorri	Nelida	Langworth	Zlatan Ibrahimovic	89370332-Z	1998-05-13	1-317-964-8479	13	2019-08-22 12:28:10.717571	2019-08-22 12:28:10.717571
193	Keturah	Jim	Ward	Edinson Cavani	75087300-M	1988-04-24	801-910-8287	13	2019-08-22 12:28:10.720577	2019-08-22 12:28:10.720577
194	Steven	Suzan	Crooks	Mario Mandzukic	40984046-R	1990-09-28	1-501-452-5127	13	2019-08-22 12:28:10.723727	2019-08-22 12:28:10.723727
195	Rudy	Kerry	Steuber	Neymar	16377931-E	1993-06-23	(843) 595-5323	13	2019-08-22 12:28:10.72706	2019-08-22 12:28:10.72706
196	Loan	Antonetta	Lesch	Mario Mandzukic	89072330-T	1998-08-30	179-136-3485	14	2019-08-22 12:28:10.730166	2019-08-22 12:28:10.730166
197	Whitney	Pamela	Bartell	Juan Mata	98851444-C	1995-04-07	1-867-788-6418	14	2019-08-22 12:28:10.733558	2019-08-22 12:28:10.733558
198	Malcom	Elmo	Gutmann	Manuel Neuer	23913819-Y	1988-05-31	(768) 963-4215	14	2019-08-22 12:28:10.736656	2019-08-22 12:28:10.736656
199	Danielle	Daria	Homenick	Mesut Ozil	45944791-Z	1984-06-21	(945) 484-9587	14	2019-08-22 12:28:10.739823	2019-08-22 12:28:10.739823
200	Lucila	Dorene	Lebsack	Cristiano Ronaldo	27829453-M	1995-12-04	986-093-1346	14	2019-08-22 12:28:10.743069	2019-08-22 12:28:10.743069
201	Max	Anisa	Rogahn	Paul Pogba	50433280-F	1999-04-26	472-183-8996	14	2019-08-22 12:28:10.74612	2019-08-22 12:28:10.74612
202	Maureen	Asha	McLaughlin	Paul Pogba	27741801-Y	1996-03-23	296.590.7362	14	2019-08-22 12:28:10.749489	2019-08-22 12:28:10.749489
203	Darnell	Daniella	Leffler	Juan Mata	38628864-L	1996-01-02	489.763.7878	14	2019-08-22 12:28:10.752543	2019-08-22 12:28:10.752543
204	Jack	Jarod	Russel	Cristiano Ronaldo	66767937-H	1998-06-23	(492) 074-1854	14	2019-08-22 12:28:10.755569	2019-08-22 12:28:10.755569
205	Carley	Ramon	McClure	Willian	93673060-V	1998-10-16	667-839-0036	14	2019-08-22 12:28:10.758728	2019-08-22 12:28:10.758728
206	Rhett	Dennis	Gusikowski	Roberto Firmino	69725649-E	1987-05-09	246.112.9429	14	2019-08-22 12:28:10.762051	2019-08-22 12:28:10.762051
207	Stacy	Makeda	Robel	Eden Hazard	60032613-Z	1994-05-09	444.694.1748	14	2019-08-22 12:28:10.765213	2019-08-22 12:28:10.765213
208	Jamaal	Noma	Maggio	Antoine Griezmann	10377917-H	1990-07-07	361-706-5892	14	2019-08-22 12:28:10.768319	2019-08-22 12:28:10.768319
209	Charmain	Corinne	Stracke	Zlatan Ibrahimovic	45323156-T	1989-11-09	979-970-6288	14	2019-08-22 12:28:10.771373	2019-08-22 12:28:10.771373
210	Ervin	Royce	Ratke	Andres Iniesta	77937539-S	1993-01-18	487.414.5359	14	2019-08-22 12:28:10.774764	2019-08-22 12:28:10.774764
211	Alexandria	Vern	Walsh	Sergio Aguero	45369189-X	1999-01-14	741-641-3232	15	2019-08-22 12:28:10.778165	2019-08-22 12:28:10.778165
212	Desirae	Sau	Brakus	Franck Ribery	59276573-F	1999-07-30	916-976-3671	15	2019-08-22 12:28:10.781358	2019-08-22 12:28:10.781358
213	Andria	Adriana	White	Eden Hazard	24206807-C	1982-02-19	1-612-774-1788	15	2019-08-22 12:28:10.784608	2019-08-22 12:28:10.784608
214	Paige	Benny	Bergstrom	Arjen Robben	74870546-A	1982-08-24	(995) 958-2910	15	2019-08-22 12:28:10.787672	2019-08-22 12:28:10.787672
215	Tawna	Ilda	Hermann	Willian	39271802-S	1982-08-13	459-844-4926	15	2019-08-22 12:28:10.790907	2019-08-22 12:28:10.790907
216	Jules	Thurman	Walter	Delle Alli	66199484-X	1985-11-09	627.272.4370	15	2019-08-22 12:28:10.794117	2019-08-22 12:28:10.794117
217	Porter	Derek	Cummings	Manuel Neuer	90553039-S	1999-05-15	(359) 412-0900	15	2019-08-22 12:28:10.797211	2019-08-22 12:28:10.797211
218	Chas	Renee	Mueller	Cristiano Ronaldo	92938530-S	1984-07-05	1-145-083-6699	15	2019-08-22 12:28:10.800299	2019-08-22 12:28:10.800299
219	Jule	Dewey	Olson	Delle Alli	62409966-H	1989-10-13	(875) 857-9598	15	2019-08-22 12:28:10.803487	2019-08-22 12:28:10.803487
220	Bridgette	Ula	Parker	Manuel Neuer	12269161-H	1983-09-06	561.980.2774	15	2019-08-22 12:28:10.806647	2019-08-22 12:28:10.806647
221	Shelia	Alene	Davis	Andres Iniesta	11327903-N	1988-08-31	428-308-3811	15	2019-08-22 12:28:10.809682	2019-08-22 12:28:10.809682
222	Maryetta	Jacalyn	Orn	Edinson Cavani	90515883-G	1994-06-04	(844) 205-6672	15	2019-08-22 12:28:10.812857	2019-08-22 12:28:10.812857
223	Melany	Marina	Bogan	Arjen Robben	58766877-Z	1996-11-23	1-178-486-3647	15	2019-08-22 12:28:10.816012	2019-08-22 12:28:10.816012
224	Sharita	Emilee	Schroeder	Zlatan Ibrahimovic	35162001-S	1998-09-05	(918) 663-9920	15	2019-08-22 12:28:10.819053	2019-08-22 12:28:10.819053
225	Lionel	Katharyn	Hilll	Antoine Griezmann	57823545-G	1997-10-15	1-507-605-4202	15	2019-08-22 12:28:10.822323	2019-08-22 12:28:10.822323
226	Malik	Garnett	White	Willian	83066038-C	1990-12-12	519.297.7046	16	2019-08-22 12:28:10.825372	2019-08-22 12:28:10.825372
227	Efrain	Tessie	Nicolas	Delle Alli	91792697-L	1986-03-05	227-625-6922	16	2019-08-22 12:28:10.829162	2019-08-22 12:28:10.829162
228	Vance	Walker	Kessler	Mario Mandzukic	36572292-S	1990-11-26	1-183-599-8573	16	2019-08-22 12:28:10.832684	2019-08-22 12:28:10.832684
229	Lanora	Therese	Rippin	Manuel Neuer	82909436-W	1995-08-12	(701) 325-5646	16	2019-08-22 12:28:10.837443	2019-08-22 12:28:10.837443
230	Erik	Terina	Muller	Delle Alli	15848838-K	1982-03-29	1-147-092-6833	16	2019-08-22 12:28:10.840655	2019-08-22 12:28:10.840655
231	Vance	Antonietta	Luettgen	David De Gea	53370204-S	1992-09-07	297-988-8331	16	2019-08-22 12:28:10.843886	2019-08-22 12:28:10.843886
232	Arletta	Jestine	Schulist	Manuel Neuer	52637660-K	1988-02-06	(352) 876-6649	16	2019-08-22 12:28:10.847272	2019-08-22 12:28:10.847272
233	Markus	Sigrid	Corkery	Neymar	84816014-H	1994-12-26	842-610-8289	16	2019-08-22 12:28:10.850363	2019-08-22 12:28:10.850363
234	Donny	Martin	Zieme	Gareth Bale	75454167-E	1986-06-19	1-126-063-0208	16	2019-08-22 12:28:10.853538	2019-08-22 12:28:10.853538
235	Korey	Coralie	Fritsch	Manuel Neuer	98821669-F	1987-09-04	1-483-079-9934	16	2019-08-22 12:28:10.856556	2019-08-22 12:28:10.856556
236	Clemente	Stevie	Kemmer	Franck Ribery	77584193-H	1988-12-10	1-485-048-2186	16	2019-08-22 12:28:10.859781	2019-08-22 12:28:10.859781
237	Alejandro	Randy	Littel	Arjen Robben	93738150-V	1997-01-07	407-877-5775	16	2019-08-22 12:28:10.863449	2019-08-22 12:28:10.863449
238	Porter	Lilliam	Parisian	Lionel Messi	88898390-D	1997-02-16	1-871-327-4318	16	2019-08-22 12:28:10.866795	2019-08-22 12:28:10.866795
239	Shaquana	Karyl	Klocko	Mohammed Salah	82245885-R	1991-08-12	799.268.6001	16	2019-08-22 12:28:10.86998	2019-08-22 12:28:10.86998
240	Chris	Keely	Gerlach	Gianluigi Buffon	72445877-V	1996-10-23	(155) 313-7958	16	2019-08-22 12:28:10.873222	2019-08-22 12:28:10.873222
241	Bennett	Ronda	McDermott	Zlatan Ibrahimovic	80943010-F	1983-09-10	994.807.4098	17	2019-08-22 12:28:10.876083	2019-08-22 12:28:10.876083
242	Markita	Chiquita	Bins	Juan Mata	57757134-V	1986-11-26	1-517-521-9116	17	2019-08-22 12:28:10.879179	2019-08-22 12:28:10.879179
243	Lady	Angel	Ortiz	Marco Reus	51961519-B	1997-12-29	1-372-676-4069	17	2019-08-22 12:28:10.882362	2019-08-22 12:28:10.882362
244	Leana	Debrah	Schuppe	Edinson Cavani	58825072-L	2000-06-30	(168) 583-3477	17	2019-08-22 12:28:10.88539	2019-08-22 12:28:10.88539
245	Dillon	Freddie	Homenick	Lionel Messi	66227419-T	1996-05-24	415.003.0070	17	2019-08-22 12:28:10.88869	2019-08-22 12:28:10.88869
246	Nestor	Mariano	Runolfsdottir	Marco Reus	56248257-D	1996-07-20	219.282.8363	17	2019-08-22 12:28:10.891881	2019-08-22 12:28:10.891881
247	Tasia	Blanche	Rath	Lionel Messi	61510853-K	1998-07-31	1-873-497-5389	17	2019-08-22 12:28:10.895097	2019-08-22 12:28:10.895097
248	Scotty	Colton	Rippin	Arjen Robben	97333181-X	1987-07-28	666-287-1836	17	2019-08-22 12:28:10.898041	2019-08-22 12:28:10.898041
249	Bennie	Sheree	Quitzon	Arjen Robben	13659099-C	1982-09-12	335-939-6576	17	2019-08-22 12:28:10.901173	2019-08-22 12:28:10.901173
250	Ariel	Glynda	Beier	Harry Kane	22480530-P	1982-07-25	209-244-0706	17	2019-08-22 12:28:10.904626	2019-08-22 12:28:10.904626
251	Verona	Tyron	Lindgren	Gianluigi Buffon	15992553-D	1996-09-26	316-541-1660	17	2019-08-22 12:28:10.908224	2019-08-22 12:28:10.908224
252	Ashley	Winter	Halvorson	Harry Kane	67544244-Y	1991-08-11	1-500-303-7090	17	2019-08-22 12:28:10.911528	2019-08-22 12:28:10.911528
253	Monnie	Peggy	Ferry	Paul Pogba	15284721-W	1995-11-06	166-275-4315	17	2019-08-22 12:28:10.914787	2019-08-22 12:28:10.914787
254	Kathlyn	Emilio	Zemlak	Manuel Neuer	31700905-M	1991-01-22	(790) 293-8209	17	2019-08-22 12:28:10.917782	2019-08-22 12:28:10.917782
255	Hank	Ruthanne	Schneider	Zlatan Ibrahimovic	16672589-G	1997-10-03	(308) 424-6406	17	2019-08-22 12:28:10.92075	2019-08-22 12:28:10.92075
256	Damien	Domonique	Kerluke	Franck Ribery	56225840-V	1982-11-11	1-322-761-2977	18	2019-08-22 12:28:10.923871	2019-08-22 12:28:10.923871
257	Wilbert	Letty	Boehm	Lionel Messi	33297470-W	1990-08-17	859.373.2880	18	2019-08-22 12:28:10.926998	2019-08-22 12:28:10.926998
258	Yvone	Nicol	Leffler	Arjen Robben	84320052-M	1999-01-21	217-963-8832	18	2019-08-22 12:28:10.930279	2019-08-22 12:28:10.930279
259	Daryl	Jesse	Bartoletti	Manuel Neuer	56982409-R	2000-08-12	1-124-338-9226	18	2019-08-22 12:28:10.933519	2019-08-22 12:28:10.933519
260	Myrtie	Kareen	Bauch	Zlatan Ibrahimovic	29911279-D	1981-12-30	185.078.9069	18	2019-08-22 12:28:10.936998	2019-08-22 12:28:10.936998
261	Frederic	Dalton	Bashirian	Manuel Neuer	69474894-J	1997-10-02	922.817.3989	18	2019-08-22 12:28:10.940644	2019-08-22 12:28:10.940644
262	Paris	Dustin	Stracke	Sergio Aguero	53497090-X	1988-06-20	893-975-5224	18	2019-08-22 12:28:10.943731	2019-08-22 12:28:10.943731
263	Rossie	Eula	Stamm	Edinson Cavani	24032933-A	1991-04-19	1-587-423-1404	18	2019-08-22 12:28:10.947034	2019-08-22 12:28:10.947034
264	Hipolito	Winter	Mann	Andres Iniesta	12479970-D	1987-02-03	374-688-3161	18	2019-08-22 12:28:10.950297	2019-08-22 12:28:10.950297
265	Armando	Janeen	O'Connell	Delle Alli	26812432-K	1985-11-12	1-880-690-6213	18	2019-08-22 12:28:10.953337	2019-08-22 12:28:10.953337
266	Gladys	Genevive	Boehm	Roberto Firmino	33547391-M	1997-05-17	(194) 608-5903	18	2019-08-22 12:28:10.956379	2019-08-22 12:28:10.956379
267	Chloe	Merideth	Christiansen	David De Gea	62540739-J	1995-09-27	1-862-399-9411	18	2019-08-22 12:28:10.959794	2019-08-22 12:28:10.959794
268	Elfriede	Hanna	Stark	Gerard Pique	22328783-S	1987-09-08	330-830-8084	18	2019-08-22 12:28:10.963062	2019-08-22 12:28:10.963062
269	Melodi	Setsuko	Goyette	Zlatan Ibrahimovic	14546050-E	1991-03-18	(499) 529-0083	18	2019-08-22 12:28:10.966079	2019-08-22 12:28:10.966079
270	Gerard	Tomas	Cassin	Sergio Ramos	46964966-R	1983-04-27	1-755-733-8449	18	2019-08-22 12:28:10.969305	2019-08-22 12:28:10.969305
271	Jaunita	Emmett	Strosin	Mesut Ozil	65536778-A	1988-01-21	(314) 169-2269	19	2019-08-22 12:28:10.97254	2019-08-22 12:28:10.97254
272	Vada	Debra	Orn	Mario Mandzukic	43166735-J	1994-07-04	271.393.7268	19	2019-08-22 12:28:10.975721	2019-08-22 12:28:10.975721
273	Bernard	Benjamin	Leffler	Lionel Messi	28589826-K	1999-03-25	408-156-3767	19	2019-08-22 12:28:10.979012	2019-08-22 12:28:10.979012
274	Phillip	Odell	Macejkovic	Andres Iniesta	58117518-Z	1994-01-22	1-161-940-7294	19	2019-08-22 12:28:10.982164	2019-08-22 12:28:10.982164
275	Merri	Allen	Jones	David De Gea	53542715-A	1998-09-04	748-805-2106	19	2019-08-22 12:28:10.985448	2019-08-22 12:28:10.985448
276	Anglea	Catrice	Fritsch	Andres Iniesta	69853992-W	1996-06-09	(795) 345-2102	19	2019-08-22 12:28:10.988325	2019-08-22 12:28:10.988325
277	Maybelle	Adriana	Wiegand	Sergio Aguero	91353056-T	1989-02-21	393-933-9638	19	2019-08-22 12:28:10.991538	2019-08-22 12:28:10.991538
278	Wade	Branden	Lehner	Zlatan Ibrahimovic	93659891-G	1989-12-11	990-222-2852	19	2019-08-22 12:28:10.994761	2019-08-22 12:28:10.994761
279	Lucie	Lesli	Runolfsson	Marco Reus	50030467-Q	1995-12-03	1-500-204-6730	19	2019-08-22 12:28:10.998009	2019-08-22 12:28:10.998009
280	Alita	Mendy	West	Mohammed Salah	76938811-Q	1983-11-06	(154) 424-4385	19	2019-08-22 12:28:11.001142	2019-08-22 12:28:11.001142
281	Lanny	Stormy	Ledner	Manuel Neuer	69658471-G	1984-06-02	(708) 407-5709	19	2019-08-22 12:28:11.004406	2019-08-22 12:28:11.004406
282	Sadye	Fletcher	Hane	Cesc Fabregas	91066091-Y	1992-11-22	(108) 073-4104	19	2019-08-22 12:28:11.007567	2019-08-22 12:28:11.007567
283	Lester	Mitchell	Harvey	Mesut Ozil	83630316-Q	1998-05-30	1-537-024-0072	19	2019-08-22 12:28:11.010702	2019-08-22 12:28:11.010702
284	Chantelle	Hollis	Harvey	Sergio Ramos	96529182-E	1990-10-30	253-735-3574	19	2019-08-22 12:28:11.013877	2019-08-22 12:28:11.013877
285	Daron	Major	Rohan	Mario Mandzukic	21149020-Z	1989-10-01	(388) 876-0860	19	2019-08-22 12:28:11.017203	2019-08-22 12:28:11.017203
286	Emmanuel	Diann	Kozey	Eden Hazard	91407731-G	1991-11-27	1-374-898-5703	20	2019-08-22 12:28:11.020463	2019-08-22 12:28:11.020463
287	Odell	Rosario	Dietrich	Cristiano Ronaldo	91116064-T	1997-04-26	1-198-084-1394	20	2019-08-22 12:28:11.02359	2019-08-22 12:28:11.02359
288	Gordon	Elly	Bayer	Sergio Ramos	14178980-D	1991-09-05	(879) 472-6106	20	2019-08-22 12:28:11.026637	2019-08-22 12:28:11.026637
289	Griselda	Maye	Graham	Paul Pogba	72114761-D	1989-05-11	723-716-5615	20	2019-08-22 12:28:11.030047	2019-08-22 12:28:11.030047
290	Magnolia	Lino	Wisozk	Delle Alli	77587527-V	1984-02-09	634.825.6586	20	2019-08-22 12:28:11.033102	2019-08-22 12:28:11.033102
291	Del	Shaunte	Von	Roberto Firmino	77289044-M	1998-08-26	1-329-159-4008	20	2019-08-22 12:28:11.036159	2019-08-22 12:28:11.036159
292	Luke	Shaniqua	Kshlerin	Manuel Neuer	49140180-J	1989-12-31	387.350.0972	20	2019-08-22 12:28:11.039256	2019-08-22 12:28:11.039256
293	Scottie	Tanya	Frami	Edinson Cavani	60439097-L	1984-04-08	1-329-110-4343	20	2019-08-22 12:28:11.042826	2019-08-22 12:28:11.042826
294	Garrett	Charity	Emmerich	Robert Lewandoski	56554674-C	1995-06-18	1-208-446-7660	20	2019-08-22 12:28:11.046263	2019-08-22 12:28:11.046263
295	Arden	Shaunda	Kuvalis	Lionel Messi	15153171-N	1983-08-26	(300) 664-1688	20	2019-08-22 12:28:11.049467	2019-08-22 12:28:11.049467
296	Saturnina	Jeannetta	Raynor	Alvaro Morata	34115410-Q	2000-05-15	(698) 843-5544	20	2019-08-22 12:28:11.052576	2019-08-22 12:28:11.052576
297	Marcos	Oren	Okuneva	Gianluigi Buffon	42773754-X	1989-04-21	(976) 703-7037	20	2019-08-22 12:28:11.055836	2019-08-22 12:28:11.055836
298	Antone	Alvaro	Schimmel	Robert Lewandoski	48889758-S	1996-10-05	1-670-862-4169	20	2019-08-22 12:28:11.058907	2019-08-22 12:28:11.058907
299	Brandie	Kristie	Auer	Lionel Messi	34005432-R	1982-03-02	833.263.4114	20	2019-08-22 12:28:11.06195	2019-08-22 12:28:11.06195
300	Betsey	Blake	McGlynn	Gianluigi Buffon	11650247-B	1991-05-04	(593) 467-9424	20	2019-08-22 12:28:11.065155	2019-08-22 12:28:11.065155
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.results (id, fixture_id, home_goals, away_goals, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, description, created_at, updated_at) FROM stdin;
1	Admin	Ullam quis sunt. Deleniti est molestias. Voluptates harum tempora.	2019-08-22 12:28:11.111894	2019-08-22 12:28:11.111894
2	Referee	A dolorem quia. Natus nobis possimus. Deleniti sint recusandae.	2019-08-22 12:28:11.121348	2019-08-22 12:28:11.121348
3	Official	Velit hic exercitationem. Architecto et dolorum. Cumque sint dicta.	2019-08-22 12:28:11.15654	2019-08-22 12:28:11.15654
4	Coach	Veritatis aliquam rerum. Possimus et reiciendis. Totam dolores eveniet.	2019-08-22 12:28:11.159586	2019-08-22 12:28:11.159586
5	Sponsor	Rem voluptatem expedita. Quis ea voluptate. Possimus ut fugiat.	2019-08-22 12:28:11.162448	2019-08-22 12:28:11.162448
6	Player	Eum nesciunt odit. Nihil est reiciendis. Sunt eveniet corrupti.	2019-08-22 12:28:11.164836	2019-08-22 12:28:11.164836
7	User	Quia qui vero. Blanditiis esse dolorem. Quo eum aspernatur.	2019-08-22 12:28:11.16701	2019-08-22 12:28:11.16701
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schema_migrations (version) FROM stdin;
20180722141005
20180722141505
20180722142405
20180722145805
20180730125200
20180730125241
20180730154032
20180731091201
20180731145259
20180801100901
20180801100903
20180801122308
20180924115542
20180924152014
20180924191525
20180924191551
20180924201746
20180927170652
20181020194250
20190422163811
20190521150813
20190523111107
20190523125632
20190523135124
20190611111625
20190611120449
20190807125619
20190910120228
20190910131527
\.


--
-- Data for Name: seasons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.seasons (id, name, description, duration, created_at, updated_at) FROM stdin;
1	2015/2016	Iure consequuntur hic. Id sunt libero. Et aut consectetur.	1	2019-08-22 12:28:11.264448	2019-08-22 12:28:11.264448
2	2016/2017	Est enim sunt. Velit consequuntur quisquam. Excepturi ea vero.	1	2019-08-22 12:28:11.274222	2019-08-22 12:28:11.274222
3	2017/2018	Eos quae quia. Qui recusandae non. Suscipit sed fugit.	1	2019-08-22 12:28:11.283611	2019-08-22 12:28:11.283611
4	2018/2019	Natus pariatur et. Nam quos aspernatur. Ut inventore quasi.	1	2019-08-22 12:28:11.286722	2019-08-22 12:28:11.286722
\.


--
-- Data for Name: sponsors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sponsors (id, name, description, contacts, created_at, updated_at) FROM stdin;
1	ALLIED BANK PHILIPPINES (UK) PLC	Expedita commodi rerum. Voluptas molestiae sed. Sed soluta veniam.	http://strosinbrown.biz/jan	2019-08-22 12:28:11.178154	2019-08-22 12:28:11.178154
2	ABC INTERNATIONAL BANK PLC	Sed necessitatibus pariatur. Ipsa at deleniti. Consequatur exercitationem est.	http://ko.org/berry_lind	2019-08-22 12:28:11.187872	2019-08-22 12:28:11.187872
3	ABN AMRO CORPORATE FINANCE LIMITED	Vitae reiciendis aperiam. Est recusandae unde. Sit dolorem consectetur.	http://hilpert.com/foster	2019-08-22 12:28:11.196508	2019-08-22 12:28:11.196508
4	UBS CLEARING AND EXECUTION SERVICES LIMITED	Similique ut in. Ea eligendi illo. Vel ipsum alias.	http://mosciskimcdermott.io/emery.windler	2019-08-22 12:28:11.199562	2019-08-22 12:28:11.199562
5	AAC CAPITAL PARTNERS LIMITED	Eius eligendi modi. Eveniet repellendus quia. Voluptas magni quos.	http://larson.org/sammie	2019-08-22 12:28:11.202306	2019-08-22 12:28:11.202306
6	UBS CLEARING AND EXECUTION SERVICES LIMITED	Animi accusantium in. Sit provident possimus. Voluptas et magnam.	http://ziemanntrantow.net/damion_sawayn	2019-08-22 12:28:11.20493	2019-08-22 12:28:11.20493
7	OTKRITIE SECURITIES LIMITED	Minus et sapiente. Eligendi voluptas et. Vitae perferendis quos.	http://hilll.net/maryjo	2019-08-22 12:28:11.207348	2019-08-22 12:28:11.207348
8	SANTANDER UK PLC	Saepe pariatur delectus. Enim quis sed. Saepe hic libero.	http://beier.com/lorene	2019-08-22 12:28:11.20975	2019-08-22 12:28:11.20975
9	PGMS (GLASGOW) LIMITED	Aliquam velit explicabo. Praesentium corrupti maiores. Libero temporibus omnis.	http://gislasonohara.co/errol.kuhic	2019-08-22 12:28:11.212408	2019-08-22 12:28:11.212408
10	AAC CAPITAL PARTNERS LIMITED	Quod ea similique. Quo consectetur quis. Rem omnis et.	http://zboncak.com/darrell.reilly	2019-08-22 12:28:11.214887	2019-08-22 12:28:11.214887
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.teams (id, name, description, location, nickname, created_at, updated_at) FROM stdin;
1	Arsenal	Dolorem voluptatum quos cumque.	Port Claudemouth	Radagast	2019-08-22 12:28:09.970173	2019-08-22 12:28:09.970173
2	Aston Villa	Tenetur omnis non laudantium.	Hirtheborough	Dwalin	2019-08-22 12:28:09.979237	2019-08-22 12:28:09.979237
3	Bournemouth	Nesciunt illum pariatur recusandae.	West Ferminfurt	Dain	2019-08-22 12:28:09.981778	2019-08-22 12:28:09.981778
4	Brighton & Hove Albion	Esse itaque placeat incidunt.	Jeremouth	Belladonna Took	2019-08-22 12:28:09.984105	2019-08-22 12:28:09.984105
5	Burnley	Odio aut accusantium qui.	Sebastianstad	Elrond	2019-08-22 12:28:09.986327	2019-08-22 12:28:09.986327
6	Chelsea	Dolor eos rerum quia.	Raynorhaven	Bilbo Baggins	2019-08-22 12:28:09.988572	2019-08-22 12:28:09.988572
7	Crystal Palace	Temporibus asperiores repudiandae nisi.	Dickbury	Beorn	2019-08-22 12:28:09.990845	2019-08-22 12:28:09.990845
8	Everton	Voluptas voluptates porro commodi.	New Wilburn	Carc	2019-08-22 12:28:09.993091	2019-08-22 12:28:09.993091
9	Leicester City	Qui fuga doloremque sit.	Jenkinsland	Carc	2019-08-22 12:28:09.9953	2019-08-22 12:28:09.9953
10	Liverpool	Quas et est aut.	Brittanytown	Bofur	2019-08-22 12:28:09.997777	2019-08-22 12:28:09.997777
11	Manchester City	Est est ipsam possimus.	New Briana	Bofur	2019-08-22 12:28:10.000139	2019-08-22 12:28:10.000139
12	Manchester United	Iure harum nesciunt enim.	Katyport	Fili	2019-08-22 12:28:10.002502	2019-08-22 12:28:10.002502
13	Newcastle United	Quibusdam eligendi amet eum.	Dawnaside	Nori	2019-08-22 12:28:10.004697	2019-08-22 12:28:10.004697
14	Norwich City	Facilis autem nulla harum.	Greenfelderside	Bard the Bowman	2019-08-22 12:28:10.006967	2019-08-22 12:28:10.006967
15	Sheffield United	Id inventore facilis non.	Maggiomouth	Bombur	2019-08-22 12:28:10.009043	2019-08-22 12:28:10.009043
16	Southampton	Quia fugiat dolores iste.	North Cheryl	Bert	2019-08-22 12:28:10.011479	2019-08-22 12:28:10.011479
17	Tottenham Hotspur	Sint magnam aliquam voluptate.	New Thomasinaville	Roac	2019-08-22 12:28:10.013878	2019-08-22 12:28:10.013878
18	Watford	Sequi ullam ut a.	Lake Clarinda	The Great Goblin	2019-08-22 12:28:10.016119	2019-08-22 12:28:10.016119
19	West Ham United	A labore quae ut.	Lake Deandrea	The Necromancer	2019-08-22 12:28:10.018403	2019-08-22 12:28:10.018403
20	Wolverhampton Wanderers	Optio error eum corrupti.	Kesslerton	Bert	2019-08-22 12:28:10.020533	2019-08-22 12:28:10.020533
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transfers (id, from_team_id, to_team_id, player_id, transfer_comment, transfer_budget, contract_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, email, role_id, password_digest, created_at, updated_at) FROM stdin;
1	jimmy	jimmy@gmail.com	1	$2a$10$A5MBGlFY.LhUMaW/9daz6.4xnweFu7HiRdfNv.QlJDwji.tr4rR.q	2019-08-22 12:28:11.35793	2019-08-22 12:28:11.35793
2	Martin Atikinson	ati@gmail.com	2	$2a$10$ItSBsUnmMoi5GSAq5/xvbuPcSQciHzP3ktzkJGZXvtGpRVWeKREYC	2019-09-09 10:04:24.953826	2019-09-09 10:04:24.953826
3	Anthony Taylor	taylor@gmail.com	2	$2a$10$aALBSZEN2m0jWlgRk9kzyegzhGkviqLOdJHELxZpuejKozjkszYZS	2019-09-09 10:05:21.259736	2019-09-09 10:05:21.259736
4	Jonathan Moss	moss@gmail.com	2	$2a$10$G6CI0nStlBbs.rwNl8PxOuodi0Pc2zH67siNZUVRGgcsPV2CvHOui	2019-09-09 10:05:57.041744	2019-09-09 10:05:57.041744
5	Mike Dean	dean@gmail.com	2	$2a$10$PRiIVSauS1l7BVX.aMmNwuSwm4BzLTlXB7xIXlaMhMV7a0IrCw0tC	2019-09-09 10:06:17.319113	2019-09-09 10:06:17.319113
6	James Kariuki	jun@gmail.com	2	$2a$10$/ny9pD8kh7KlFHReD18KKOKn9jn1JFL8evPPEU2yHlmjP1c/cFZ3G	2019-09-10 20:47:33.88448	2019-09-10 20:47:33.88448
\.


--
-- Name: commentaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commentaries_id_seq', 64, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_id_seq', 7, true);


--
-- Name: fixture_squads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fixture_squads_id_seq', 27, true);


--
-- Name: fixtures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fixtures_id_seq', 19, true);


--
-- Name: leagues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leagues_id_seq', 6, true);


--
-- Name: leagues_sponsors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leagues_sponsors_id_seq', 1, false);


--
-- Name: leagues_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leagues_teams_id_seq', 21, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.players_id_seq', 300, true);


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.results_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 7, true);


--
-- Name: seasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.seasons_id_seq', 4, true);


--
-- Name: sponsors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sponsors_id_seq', 10, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.teams_id_seq', 20, true);


--
-- Name: transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transfers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: commentaries commentaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries
    ADD CONSTRAINT commentaries_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: fixture_squads fixture_squads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixture_squads
    ADD CONSTRAINT fixture_squads_pkey PRIMARY KEY (id);


--
-- Name: fixtures fixtures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fixtures_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: leagues_sponsors leagues_sponsors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_sponsors
    ADD CONSTRAINT leagues_sponsors_pkey PRIMARY KEY (id);


--
-- Name: leagues_teams leagues_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_teams
    ADD CONSTRAINT leagues_teams_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seasons seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: sponsors sponsors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsors
    ADD CONSTRAINT sponsors_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_commentaries_on_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commentaries_on_event_id ON public.commentaries USING btree (event_id);


--
-- Name: index_commentaries_on_fixture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commentaries_on_fixture_id ON public.commentaries USING btree (fixture_id);


--
-- Name: index_commentaries_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commentaries_on_player_id ON public.commentaries USING btree (player_id);


--
-- Name: index_commentaries_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commentaries_on_team_id ON public.commentaries USING btree (team_id);


--
-- Name: index_fixture_squads_on_fixture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fixture_squads_on_fixture_id ON public.fixture_squads USING btree (fixture_id);


--
-- Name: index_fixture_squads_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fixture_squads_on_player_id ON public.fixture_squads USING btree (player_id);


--
-- Name: index_fixture_squads_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fixture_squads_on_team_id ON public.fixture_squads USING btree (team_id);


--
-- Name: index_results_on_fixture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_results_on_fixture_id ON public.results USING btree (fixture_id);


--
-- Name: fixtures fk_rails_140b10c8ba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_140b10c8ba FOREIGN KEY (season_id) REFERENCES public.seasons(id);


--
-- Name: fixture_squads fk_rails_16cefb6258; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixture_squads
    ADD CONSTRAINT fk_rails_16cefb6258 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: results fk_rails_24208fad15; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_rails_24208fad15 FOREIGN KEY (fixture_id) REFERENCES public.fixtures(id);


--
-- Name: transfers fk_rails_3699955956; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT fk_rails_3699955956 FOREIGN KEY (to_team_id) REFERENCES public.teams(id);


--
-- Name: transfers fk_rails_3af9e3976e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT fk_rails_3af9e3976e FOREIGN KEY (from_team_id) REFERENCES public.teams(id);


--
-- Name: transfers fk_rails_49c4cbb8c0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT fk_rails_49c4cbb8c0 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: fixtures fk_rails_557484c769; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_557484c769 FOREIGN KEY (right_side_referee_id) REFERENCES public.users(id);


--
-- Name: fixture_squads fk_rails_5966f7c664; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixture_squads
    ADD CONSTRAINT fk_rails_5966f7c664 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: users fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: commentaries fk_rails_6638a29340; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries
    ADD CONSTRAINT fk_rails_6638a29340 FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- Name: fixtures fk_rails_75266f13a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_75266f13a2 FOREIGN KEY (home_team_id) REFERENCES public.teams(id);


--
-- Name: fixtures fk_rails_7f9adb1311; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_7f9adb1311 FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: players fk_rails_8880a915a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT fk_rails_8880a915a5 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: fixtures fk_rails_9bf2b1d5a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_9bf2b1d5a2 FOREIGN KEY (center_referee_id) REFERENCES public.users(id);


--
-- Name: leagues_sponsors fk_rails_a39a9b3b5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_sponsors
    ADD CONSTRAINT fk_rails_a39a9b3b5f FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: fixture_squads fk_rails_adc6d15dbe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixture_squads
    ADD CONSTRAINT fk_rails_adc6d15dbe FOREIGN KEY (fixture_id) REFERENCES public.fixtures(id);


--
-- Name: leagues_sponsors fk_rails_c41d7d4b3e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_sponsors
    ADD CONSTRAINT fk_rails_c41d7d4b3e FOREIGN KEY (sponsor_id) REFERENCES public.sponsors(id);


--
-- Name: leagues_teams fk_rails_cd2c93e047; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_teams
    ADD CONSTRAINT fk_rails_cd2c93e047 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: commentaries fk_rails_d385f138d7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries
    ADD CONSTRAINT fk_rails_d385f138d7 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: fixtures fk_rails_d3dc788f4b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_d3dc788f4b FOREIGN KEY (left_side_referee_id) REFERENCES public.users(id);


--
-- Name: commentaries fk_rails_e6f5edc593; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries
    ADD CONSTRAINT fk_rails_e6f5edc593 FOREIGN KEY (fixture_id) REFERENCES public.fixtures(id);


--
-- Name: leagues_teams fk_rails_eddd142228; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leagues_teams
    ADD CONSTRAINT fk_rails_eddd142228 FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: commentaries fk_rails_ee78df2441; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commentaries
    ADD CONSTRAINT fk_rails_ee78df2441 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: fixtures fk_rails_fce055dec7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fixtures
    ADD CONSTRAINT fk_rails_fce055dec7 FOREIGN KEY (away_team_id) REFERENCES public.teams(id);


--
-- PostgreSQL database dump complete
--

