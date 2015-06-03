--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.categories OWNER TO profh;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO profh;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: coaches; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE coaches (
    id integer NOT NULL,
    user_id integer,
    organization_id integer,
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(255),
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.coaches OWNER TO profh;

--
-- Name: coaches_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE coaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coaches_id_seq OWNER TO profh;

--
-- Name: coaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE coaches_id_seq OWNED BY coaches.id;


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE divisions (
    id integer NOT NULL,
    name character varying(255),
    start_grade integer,
    end_grade integer,
    active boolean DEFAULT true
);


ALTER TABLE public.divisions OWNER TO profh;

--
-- Name: divisions_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE divisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.divisions_id_seq OWNER TO profh;

--
-- Name: divisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE divisions_id_seq OWNED BY divisions.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    start_date date,
    end_date date,
    start_time time without time zone,
    num_rounds integer,
    organization_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.events OWNER TO profh;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO profh;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: indiv_standings; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE indiv_standings (
    id integer NOT NULL,
    "position" integer,
    student_id integer,
    team_id integer,
    division_id integer,
    total_points integer,
    lowest_score integer,
    adjusted_points integer,
    accuracy double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.indiv_standings OWNER TO profh;

--
-- Name: indiv_standings_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE indiv_standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indiv_standings_id_seq OWNER TO profh;

--
-- Name: indiv_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE indiv_standings_id_seq OWNED BY indiv_standings.id;


--
-- Name: organization_students; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE organization_students (
    id integer NOT NULL,
    organization_id integer,
    student_id integer,
    start_date date,
    end_date date
);


ALTER TABLE public.organization_students OWNER TO profh;

--
-- Name: organization_students_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE organization_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_students_id_seq OWNER TO profh;

--
-- Name: organization_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE organization_students_id_seq OWNED BY organization_students.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying(255),
    short_name character varying(255),
    street_1 character varying(255),
    street_2 character varying(255),
    city character varying(255),
    state character varying(255),
    zip character varying(255),
    latitude numeric,
    longitude numeric,
    active boolean DEFAULT true,
    primary_contact_id integer
);


ALTER TABLE public.organizations OWNER TO profh;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO profh;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: quiz_teams; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE quiz_teams (
    id integer NOT NULL,
    quiz_id integer,
    team_id integer,
    "position" integer,
    raw_score integer,
    points integer,
    failed_challenges integer DEFAULT 0
);


ALTER TABLE public.quiz_teams OWNER TO profh;

--
-- Name: quiz_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE quiz_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_teams_id_seq OWNER TO profh;

--
-- Name: quiz_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE quiz_teams_id_seq OWNED BY quiz_teams.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE quizzes (
    id integer NOT NULL,
    division_id integer,
    event_id integer,
    room_num character varying(255),
    round_num integer,
    active boolean DEFAULT true,
    category_id integer
);


ALTER TABLE public.quizzes OWNER TO profh;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quizzes_id_seq OWNER TO profh;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE quizzes_id_seq OWNED BY quizzes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO profh;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE settings (
    id integer NOT NULL,
    roster_lock_date date,
    drop_lowest_score boolean,
    roster_lock_toggle boolean,
    auto_promote_students boolean,
    area_name character varying(255),
    admin_name character varying(255),
    admin_email character varying(255),
    intro text
);


ALTER TABLE public.settings OWNER TO profh;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO profh;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- Name: student_quizzes; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE student_quizzes (
    id integer NOT NULL,
    student_id integer,
    quiz_id integer,
    num_correct integer,
    num_attempts integer,
    num_fouls integer,
    score integer
);


ALTER TABLE public.student_quizzes OWNER TO profh;

--
-- Name: student_quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE student_quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_quizzes_id_seq OWNER TO profh;

--
-- Name: student_quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE student_quizzes_id_seq OWNED BY student_quizzes.id;


--
-- Name: student_teams; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE student_teams (
    id integer NOT NULL,
    student_id integer,
    team_id integer,
    is_captain boolean DEFAULT false,
    present boolean DEFAULT true,
    start_date date,
    end_date date,
    seat integer
);


ALTER TABLE public.student_teams OWNER TO profh;

--
-- Name: student_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE student_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_teams_id_seq OWNER TO profh;

--
-- Name: student_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE student_teams_id_seq OWNED BY student_teams.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    grade integer,
    active boolean DEFAULT true
);


ALTER TABLE public.students OWNER TO profh;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO profh;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: team_coaches; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE team_coaches (
    id integer NOT NULL,
    team_id integer,
    coach_id integer,
    start_date date,
    end_date date
);


ALTER TABLE public.team_coaches OWNER TO profh;

--
-- Name: team_coaches_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE team_coaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_coaches_id_seq OWNER TO profh;

--
-- Name: team_coaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE team_coaches_id_seq OWNED BY team_coaches.id;


--
-- Name: team_standings; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE team_standings (
    id integer NOT NULL,
    "position" integer,
    team_id integer,
    division_id character varying(255),
    total_points integer,
    accuracy double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.team_standings OWNER TO profh;

--
-- Name: team_standings_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE team_standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_standings_id_seq OWNER TO profh;

--
-- Name: team_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE team_standings_id_seq OWNED BY team_standings.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    division_id integer,
    organization_id integer,
    name character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.teams OWNER TO profh;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO profh;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: profh; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    role character varying(255),
    password_digest character varying(255),
    active boolean DEFAULT true,
    active_after timestamp without time zone,
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    token_type character varying(255)
);


ALTER TABLE public.users OWNER TO profh;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: profh
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO profh;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: profh
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY coaches ALTER COLUMN id SET DEFAULT nextval('coaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY divisions ALTER COLUMN id SET DEFAULT nextval('divisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY indiv_standings ALTER COLUMN id SET DEFAULT nextval('indiv_standings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY organization_students ALTER COLUMN id SET DEFAULT nextval('organization_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY quiz_teams ALTER COLUMN id SET DEFAULT nextval('quiz_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY quizzes ALTER COLUMN id SET DEFAULT nextval('quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY student_quizzes ALTER COLUMN id SET DEFAULT nextval('student_quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY student_teams ALTER COLUMN id SET DEFAULT nextval('student_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY team_coaches ALTER COLUMN id SET DEFAULT nextval('team_coaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY team_standings ALTER COLUMN id SET DEFAULT nextval('team_standings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: profh
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY categories (id, name) FROM stdin;
1	Prelims
2	Championship
3	Consolation
4	XYZ Quiz
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('categories_id_seq', 4, true);


--
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY coaches (id, user_id, organization_id, first_name, last_name, phone, active, created_at, updated_at) FROM stdin;
1	4	1	Tiara	Bartoletti	9209419683	t	2015-06-03 15:36:23.09837	2015-06-03 15:36:23.09837
2	5	1	Shayne	Conroy	9302324849	t	2015-06-03 15:36:23.183853	2015-06-03 15:36:23.183853
3	6	1	Gerda	Smith	2900502344	t	2015-06-03 15:36:23.262082	2015-06-03 15:36:23.262082
4	7	4	Orin	Nienow	7574524120	t	2015-06-03 15:36:23.340316	2015-06-03 15:36:23.340316
5	8	4	Wilfredo	Cronin	8556312198	t	2015-06-03 15:36:23.422883	2015-06-03 15:36:23.422883
6	9	4	Shayne	Schultz	7351749474	t	2015-06-03 15:36:23.501745	2015-06-03 15:36:23.501745
7	10	7	Orland	Kutch	4680872774	t	2015-06-03 15:36:23.585074	2015-06-03 15:36:23.585074
8	11	7	Nicholaus	Ferry	6645824201	t	2015-06-03 15:36:23.664994	2015-06-03 15:36:23.664994
9	12	10	Justen	Cummerata	7775729171	t	2015-06-03 15:36:23.745859	2015-06-03 15:36:23.745859
10	13	3	Trycia	Jerde	0424966650	t	2015-06-03 15:36:23.826541	2015-06-03 15:36:23.826541
11	14	3	Faye	Rohan	3910432987	t	2015-06-03 15:36:23.905846	2015-06-03 15:36:23.905846
12	15	3	Berta	Hahn	3853233183	t	2015-06-03 15:36:23.985028	2015-06-03 15:36:23.985028
13	16	3	Micah	Von	6211811502	t	2015-06-03 15:36:24.07537	2015-06-03 15:36:24.07537
14	17	16	Heidi	Larkin	1669009929	t	2015-06-03 15:36:24.159227	2015-06-03 15:36:24.159227
15	18	16	Bridgette	Vandervort	8801743120	t	2015-06-03 15:36:24.240929	2015-06-03 15:36:24.240929
16	19	17	Joan	Nader	0051393874	t	2015-06-03 15:36:24.322297	2015-06-03 15:36:24.322297
17	20	17	Sharon	Reynolds	8517162910	t	2015-06-03 15:36:24.405433	2015-06-03 15:36:24.405433
18	21	17	Naomie	Barton	7112257493	t	2015-06-03 15:36:24.484774	2015-06-03 15:36:24.484774
19	22	13	Gunner	Mante	2449737542	t	2015-06-03 15:36:24.570415	2015-06-03 15:36:24.570415
20	23	13	Sherwood	Maggio	9216726562	t	2015-06-03 15:36:24.652539	2015-06-03 15:36:24.652539
21	24	13	Walker	Boehm	2747950845	t	2015-06-03 15:36:24.733025	2015-06-03 15:36:24.733025
22	25	6	Jessika	Barton	0570247447	t	2015-06-03 15:36:24.811912	2015-06-03 15:36:24.811912
23	26	6	Lilla	Shanahan	7273004730	t	2015-06-03 15:36:24.891917	2015-06-03 15:36:24.891917
24	27	6	Rowena	Rath	4349363957	t	2015-06-03 15:36:24.972565	2015-06-03 15:36:24.972565
25	28	15	Ken	Treutel	3165344039	t	2015-06-03 15:36:25.051626	2015-06-03 15:36:25.051626
26	29	15	Otilia	Gottlieb	7048101131	t	2015-06-03 15:36:25.138628	2015-06-03 15:36:25.138628
27	30	5	Norberto	Watsica	1224610070	t	2015-06-03 15:36:25.223052	2015-06-03 15:36:25.223052
28	31	11	Antonette	O'Conner	0762112973	t	2015-06-03 15:36:25.306618	2015-06-03 15:36:25.306618
29	32	11	Jackie	Streich	7253953083	t	2015-06-03 15:36:25.387078	2015-06-03 15:36:25.387078
30	33	11	Maegan	Thiel	1417686698	t	2015-06-03 15:36:25.468304	2015-06-03 15:36:25.468304
31	34	2	Daron	Leuschke	4513195955	t	2015-06-03 15:36:25.550961	2015-06-03 15:36:25.550961
32	35	2	Giuseppe	Roberts	4900145414	t	2015-06-03 15:36:25.631108	2015-06-03 15:36:25.631108
33	36	2	Kristin	O'Keefe	2256099740	t	2015-06-03 15:36:25.715549	2015-06-03 15:36:25.715549
34	37	2	Dulce	Herman	3115325049	t	2015-06-03 15:36:25.794722	2015-06-03 15:36:25.794722
35	38	8	Dorcas	Beatty	7430203240	t	2015-06-03 15:36:25.881524	2015-06-03 15:36:25.881524
\.


--
-- Name: coaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('coaches_id_seq', 35, true);


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY divisions (id, name, start_grade, end_grade, active) FROM stdin;
1	juniors	3	6	t
2	seniors	7	12	t
3	seniorb	7	12	t
\.


--
-- Name: divisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('divisions_id_seq', 3, true);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY events (id, start_date, end_date, start_time, num_rounds, organization_id, created_at, updated_at) FROM stdin;
1	2014-10-04	2014-10-04	13:00:00	6	4	2015-06-03 15:36:22.503697	2015-06-03 15:36:22.517824
2	2014-11-01	2014-11-01	13:00:00	6	1	2015-06-03 15:36:22.527677	2015-06-03 15:36:22.540294
3	2014-12-06	2014-12-06	13:00:00	6	8	2015-06-03 15:36:22.549558	2015-06-03 15:36:22.561937
4	2015-01-03	2015-01-03	13:00:00	6	1	2015-06-03 15:36:22.571268	2015-06-03 15:36:22.583659
5	2015-02-07	2015-02-07	13:00:00	6	1	2015-06-03 15:36:22.593396	2015-06-03 15:36:22.606237
6	2015-03-07	2015-03-07	13:00:00	6	5	2015-06-03 15:36:22.615637	2015-06-03 15:36:22.628021
7	2015-04-11	2015-04-11	13:00:00	6	3	2015-06-03 15:36:22.637513	2015-06-03 15:36:22.65001
8	2015-06-27	2015-06-27	13:00:00	6	1	2015-06-03 15:36:22.659416	2015-06-03 15:36:22.659416
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('events_id_seq', 8, true);


--
-- Data for Name: indiv_standings; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY indiv_standings (id, "position", student_id, team_id, division_id, total_points, lowest_score, adjusted_points, accuracy, created_at, updated_at) FROM stdin;
\.


--
-- Name: indiv_standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('indiv_standings_id_seq', 1, false);


--
-- Data for Name: organization_students; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY organization_students (id, organization_id, student_id, start_date, end_date) FROM stdin;
\.


--
-- Name: organization_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('organization_students_id_seq', 1, false);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY organizations (id, name, short_name, street_1, street_2, city, state, zip, latitude, longitude, active, primary_contact_id) FROM stdin;
9	Sculton Alliance Church	Sculton	1033 Scullton Rd	\N	Rockwood	PA	15557	39.9477035	-79.313205	f	\N
12	Glenshaw Alliance Church	Glenshaw	3601 Mount Royal Blvd	\N	Glenshaw	PA	15116	40.5504141	-79.9715803	f	\N
14	Urban Impact Foundation	UIF	801 Union Avenue	\N	Pittsburgh	PA	15212	40.453995	-80.0031248	f	\N
1	Allegheny Center Alliance Church	ACAC	250 E Ohio Street	\N	Piitsburgh	PA	15212	40.4533665	-80.0030653	t	1
4	Broadway Alliance Church	Broadway	1000 Broadway Street	\N	East Mc Keesport	PA	15035	40.383786	-79.810438	t	4
7	Cherry Tree Alliance Church	Cherry Tree	640 Cherry Tree Lane	\N	Uniontown	PA	15401	39.9015907	-79.7551046	t	7
10	Chicora Alliance Church	Chicora	310 E Slippery Rock St	\N	Chicora	PA	16025	40.9464336	-79.7391402	t	9
3	Dorseyville Alliance Church	Dorseyville	3703 Saxonburg Blvd	\N	Indiana Twp	PA	15238	40.575015	-79.892385	t	10
16	Elkins Alliance	Elkins	PO Box 2904	\N	Elkins	WV	26241	38.9139309	-79.7848422	t	14
17	First Alliance (New Castle)	New Castle	111 Mission Meade Street	\N	New Castle	PA	16105	41.0321736	-80.3577379	t	16
13	Greensburg Alliance Church	Greensburg	4428 Route 136	\N	Greensburg	PA	15601	40.2838005	-79.5907678	t	19
6	Indiana Alliance Church	Indiana	2510 Warren Road	\N	Indiana	PA	15701	40.6098642	-79.1910152	t	22
15	McKeesport Alliance Church	McKeesport	938 Summitt Street	\N	Mckeesport	PA	15132	40.353107	-79.829035	t	25
5	Murrysville Alliance Church	MAC	4130 Old William Penn Highway	\N	Murrysville	PA	15668	40.4287738	-79.6889323	t	27
11	Norwin Alliance Church	Norwin	10585 Farview Drive	\N	Irwin	PA	15642	40.3081559	-79.722742	t	28
2	Somerset Alliance Church	Somerset	708 Stoystown Road	\N	Somerset	PA	15501	40.020516	-79.059012	t	31
8	Washington Alliance Church	Washington	246 Sanitarium Road	\N	Washington	PA	15301	40.1512977	-80.2162031	t	35
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('organizations_id_seq', 17, true);


--
-- Data for Name: quiz_teams; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY quiz_teams (id, quiz_id, team_id, "position", raw_score, points, failed_challenges) FROM stdin;
3336	1158	38	3	110	11	0
3	1	16	3	130	13	0
4	2	37	1	150	15	0
5	2	72	2	110	11	0
6	2	23	3	260	26	0
8	3	17	2	190	19	0
9	3	35	3	90	9	0
10	4	24	1	190	19	0
11	4	50	2	130	13	0
13	5	3	1	220	22	0
14	5	6	2	90	9	0
15	5	4	3	110	11	0
16	6	64	1	170	17	0
18	6	76	3	190	19	0
19	7	5	1	110	11	0
20	7	59	2	240	24	0
21	7	22	3	220	22	0
23	8	60	2	200	20	0
24	8	1	3	180	18	0
25	9	2	1	110	11	0
26	9	36	2	180	18	0
28	10	30	1	90	9	0
29	10	79	2	220	22	0
30	10	73	3	190	19	0
31	11	7	1	220	22	0
33	11	55	3	130	13	0
34	12	15	1	90	9	0
35	12	28	2	150	15	0
36	12	72	3	110	11	0
38	13	24	2	240	24	0
39	13	73	3	150	15	0
40	14	36	1	80	8	0
41	14	29	2	250	25	0
43	15	1	1	170	17	0
44	15	79	2	100	10	0
45	15	64	3	210	21	0
46	16	16	1	100	10	0
48	16	50	3	220	22	0
49	17	22	1	180	18	0
50	17	60	2	20	2	0
51	17	65	3	140	14	0
53	18	37	2	50	5	0
54	18	45	3	170	17	0
55	19	41	1	220	22	0
56	19	23	2	170	17	0
58	20	66	1	180	18	0
59	20	30	2	140	14	0
60	20	76	3	220	22	0
61	21	71	1	110	11	0
63	21	7	3	110	11	0
64	22	5	1	120	12	0
65	22	35	2	150	15	0
66	22	2	3	140	14	0
68	23	17	2	60	6	0
69	23	15	3	130	13	0
70	24	1	1	150	15	0
71	24	16	2	160	16	0
73	25	73	1	210	21	0
74	25	65	2	180	18	0
75	25	55	3	160	16	0
76	26	23	1	150	15	0
78	26	50	3	170	17	0
79	27	7	1	60	6	0
80	27	3	2	170	17	0
81	27	2	3	130	13	0
83	28	59	2	90	9	0
84	28	45	3	200	20	0
85	29	79	1	230	23	0
86	29	6	2	110	11	0
88	30	29	1	170	17	0
89	30	35	2	260	26	0
90	30	8	3	210	21	0
91	31	37	1	150	15	0
93	31	66	3	240	24	0
94	32	36	1	190	19	0
95	32	72	2	120	12	0
96	32	30	3	60	6	0
98	33	64	2	110	11	0
99	33	28	3	250	25	0
100	34	60	1	80	8	0
101	34	17	2	140	14	0
103	35	7	1	150	15	0
104	35	28	2	180	18	0
105	35	60	3	180	18	0
106	36	71	1	130	13	0
108	36	5	3	200	20	0
109	37	1	1	120	12	0
110	37	17	2	180	18	0
111	37	3	3	120	12	0
113	38	59	2	160	16	0
114	38	4	3	60	6	0
115	39	15	1	140	14	0
116	39	6	2	140	14	0
118	40	64	1	130	13	0
119	40	30	2	160	16	0
120	40	36	3	100	10	0
121	41	22	1	120	12	0
123	41	79	3	150	15	0
124	42	8	1	160	16	0
125	42	55	2	80	8	0
126	42	37	3	110	11	0
128	43	24	2	140	14	0
129	43	65	3	50	5	0
130	44	35	1	260	26	0
131	44	72	2	90	9	0
133	45	45	1	180	18	0
134	45	50	2	200	20	0
135	45	2	3	200	20	0
136	46	73	1	140	14	0
138	46	30	3	70	7	0
139	47	72	1	180	18	0
140	47	5	2	70	7	0
141	47	41	3	200	20	0
143	48	55	2	210	21	0
144	48	17	3	120	12	0
145	49	4	1	110	11	0
146	49	28	2	110	11	0
148	50	6	1	130	13	0
149	50	23	2	290	29	0
150	50	37	3	160	16	0
151	51	7	1	100	10	0
153	51	71	3	210	21	0
154	52	3	1	90	9	0
155	52	24	2	180	18	0
156	52	66	3	110	11	0
160	54	35	1	180	18	0
161	54	2	2	170	17	0
162	54	59	3	240	24	0
163	55	76	1	220	22	0
165	55	8	3	170	17	0
166	56	65	1	190	19	0
167	56	73	2	130	13	0
168	56	22	3	130	13	0
170	57	64	2	160	16	0
171	57	17	3	80	8	0
172	58	60	1	110	11	0
173	58	1	2	230	23	0
175	59	71	1	290	29	0
176	59	22	2	100	10	0
177	59	73	3	250	25	0
178	60	28	1	90	9	0
180	60	45	3	170	17	0
181	61	15	1	180	18	0
182	61	6	2	70	7	0
183	61	35	3	170	17	0
185	62	7	2	130	13	0
186	62	29	3	220	22	0
187	63	2	1	90	9	0
188	63	8	2	170	17	0
190	64	36	1	170	17	0
191	64	50	2	190	19	0
192	64	37	3	100	10	0
193	65	55	1	170	17	0
195	65	66	3	180	18	0
196	66	41	1	120	12	0
197	66	79	2	170	17	0
198	66	4	3	210	21	0
200	67	30	2	140	14	0
201	67	72	3	160	16	0
202	68	5	1	130	13	0
203	68	3	2	220	22	0
205	73	12	1	90	9	0
206	73	19	2	130	13	0
207	73	46	3	280	28	0
208	74	32	1	150	15	0
210	74	67	3	160	16	0
211	75	53	1	140	14	0
212	75	33	2	110	11	0
213	75	48	3	60	6	0
215	76	68	2	150	15	0
216	76	51	3	160	16	0
217	77	74	1	160	16	0
218	77	77	2	140	14	0
220	78	47	1	130	13	0
221	78	10	2	160	16	0
222	78	43	3	100	10	0
223	79	13	1	90	9	0
225	79	52	3	220	22	0
226	80	56	1	140	14	0
227	80	9	2	110	11	0
228	80	31	3	130	13	0
230	81	25	2	170	17	0
231	81	61	3	170	17	0
232	82	42	1	110	11	0
233	82	39	2	30	3	0
235	83	62	1	80	8	0
236	83	53	2	90	9	0
237	83	32	3	110	11	0
238	84	26	1	210	21	0
240	84	61	3	130	13	0
241	85	47	1	160	16	0
242	85	10	2	110	11	0
243	85	67	3	140	14	0
245	86	31	2	60	6	0
246	86	11	3	-10	-1	0
247	87	52	1	220	22	0
248	87	56	2	130	13	0
250	88	9	1	120	12	0
251	88	80	2	100	10	0
252	88	43	3	30	3	0
253	89	18	1	90	9	0
255	89	19	3	150	15	0
256	90	48	1	80	8	0
257	90	68	2	170	17	0
258	90	12	3	40	4	0
260	91	57	2	150	15	0
261	91	25	3	20	2	0
262	92	33	1	150	15	0
263	92	51	2	120	12	0
265	93	74	1	60	6	0
266	93	39	2	110	11	0
267	93	51	3	90	9	0
268	94	39	1	120	12	0
270	94	48	3	130	13	0
271	95	77	1	90	9	0
272	95	56	2	150	15	0
273	95	38	3	150	15	0
275	96	12	2	110	11	0
276	96	42	3	110	11	0
277	97	67	1	220	22	0
278	97	19	2	90	9	0
280	98	53	1	110	11	0
281	98	9	2	130	13	0
282	98	47	3	40	4	0
283	99	13	1	110	11	0
285	99	68	3	80	8	0
286	100	26	1	120	12	0
287	100	33	2	90	9	0
288	100	25	3	220	22	0
290	101	52	2	30	3	0
291	101	57	3	130	13	0
292	102	61	1	160	16	0
293	102	10	2	230	23	0
295	103	32	1	100	10	0
296	103	62	2	100	10	0
297	103	74	3	90	9	0
298	104	26	1	160	16	0
300	104	19	3	160	16	0
301	105	31	1	160	16	0
302	105	77	2	100	10	0
303	105	62	3	200	20	0
305	106	38	2	80	8	0
306	106	42	3	120	12	0
307	107	13	1	130	13	0
308	107	10	2	80	8	0
310	108	48	1	100	10	0
311	108	18	2	130	13	0
312	108	56	3	170	17	0
313	109	61	1	50	5	0
426	147	58	3	\N	\N	0
317	110	67	2	210	21	0
318	110	46	3	130	13	0
319	111	57	1	80	8	0
320	111	74	2	80	8	0
322	112	43	1	140	14	0
323	112	80	2	170	17	0
324	112	33	3	60	6	0
325	113	51	1	170	17	0
327	113	9	3	200	20	0
328	114	11	1	50	5	0
329	114	47	2	70	7	0
330	114	25	3	150	15	0
332	115	67	2	130	13	0
333	115	33	3	90	9	0
334	116	32	1	130	13	0
335	116	56	2	90	9	0
337	117	77	1	90	9	0
338	117	57	2	140	14	0
339	117	13	3	140	14	0
340	118	48	1	130	13	0
342	118	53	3	150	15	0
343	119	26	1	70	7	0
344	119	52	2	110	11	0
345	119	39	3	80	8	0
347	120	51	2	110	11	0
348	120	31	3	70	7	0
349	121	46	1	170	17	0
350	121	11	2	10	1	0
352	122	9	1	120	12	0
353	122	12	2	160	16	0
354	122	19	3	160	16	0
355	123	10	1	190	19	0
357	123	43	3	70	7	0
358	124	62	1	70	7	0
359	124	74	2	130	13	0
360	124	67	3	230	23	0
362	125	62	2	170	17	0
363	125	52	3	100	10	0
364	126	47	1	130	13	0
365	126	31	2	200	20	0
367	127	25	1	150	15	0
368	127	38	2	140	14	0
369	127	43	3	100	10	0
370	128	53	1	40	4	0
372	128	33	3	70	7	0
373	129	26	1	120	12	0
374	129	48	2	200	20	0
375	129	11	3	130	13	0
377	130	68	2	80	8	0
378	130	80	3	190	19	0
379	131	61	1	70	7	0
380	131	19	2	110	11	0
382	132	51	1	70	7	0
383	132	57	2	100	10	0
384	132	74	3	110	11	0
385	133	13	1	190	19	0
387	133	39	3	120	12	0
388	134	56	1	130	13	0
389	134	12	2	210	21	0
390	134	10	3	200	20	0
392	136	40	2	60	6	0
393	136	75	3	180	18	0
394	137	49	1	250	25	0
395	137	54	2	120	12	0
397	138	20	1	160	16	0
398	138	63	2	140	14	0
399	138	70	3	140	14	0
401	139	27	2	160	16	0
402	139	44	3	140	14	0
403	140	69	1	160	16	0
404	140	14	2	120	12	0
405	140	58	3	170	17	0
407	141	82	2	250	25	0
408	141	49	3	120	12	0
409	142	20	1	90	9	0
410	142	44	2	100	10	0
412	143	40	1	30	3	0
413	143	34	2	250	25	0
414	143	21	3	60	6	0
415	144	78	1	110	11	0
417	144	54	3	130	13	0
418	145	14	1	170	17	0
419	145	82	2	300	30	0
420	145	63	3	220	22	0
422	146	75	2	150	15	0
423	146	69	3	100	10	0
427	148	44	1	150	15	0
425	147	49	2	110	11	0
428	148	75	2	190	19	0
429	148	69	3	160	16	0
430	149	82	1	240	24	0
431	149	78	2	100	10	0
433	150	27	1	200	20	0
434	150	21	2	140	14	0
435	150	70	3	170	17	0
436	151	63	1	210	21	0
438	151	54	3	130	13	0
439	152	14	1	80	8	0
440	152	20	2	60	6	0
441	152	40	3	120	12	0
443	153	81	2	70	7	0
444	153	27	3	170	17	0
445	154	70	1	200	20	0
446	154	69	2	140	14	0
448	155	21	1	80	8	0
449	155	34	2	320	32	0
450	155	54	3	160	16	0
451	156	82	1	70	7	0
453	156	63	3	140	14	0
454	157	14	1	120	12	0
455	157	58	2	120	12	0
456	157	75	3	100	10	0
458	158	40	2	40	4	0
459	158	63	3	90	9	0
460	159	78	1	150	15	0
461	159	58	2	70	7	0
463	160	69	1	80	8	0
464	160	54	2	100	10	0
465	160	81	3	190	19	0
466	161	75	1	120	12	0
468	161	14	3	220	22	0
469	162	27	1	330	33	0
470	162	82	2	170	17	0
471	162	20	3	50	5	0
3348	1163	82	3	160	16	0
474	163	49	3	110	11	0
475	164	40	1	140	14	0
476	164	78	2	160	16	0
477	164	70	3	130	13	0
479	165	81	2	160	16	0
480	165	54	3	60	6	0
481	166	82	1	190	19	0
482	166	40	2	40	4	0
484	167	63	1	130	13	0
485	167	20	2	210	21	0
486	167	69	3	240	24	0
487	168	44	1	120	12	0
489	168	75	3	90	9	0
490	169	49	1	100	10	0
491	169	21	2	170	17	0
492	169	34	3	230	23	0
494	172	64	2	170	17	0
495	172	3	3	190	19	0
496	173	7	1	150	15	0
497	173	6	2	220	22	0
499	174	30	1	230	23	0
500	174	73	2	310	31	0
501	174	65	3	180	18	0
502	175	37	1	160	16	0
504	175	55	3	110	11	0
505	176	15	1	130	13	0
506	176	79	2	70	7	0
507	176	5	3	150	15	0
509	177	76	2	130	13	0
510	177	35	3	190	19	0
511	178	50	1	150	15	0
512	178	1	2	160	16	0
514	179	29	1	100	10	0
515	179	71	2	80	8	0
516	179	66	3	200	20	0
517	180	4	1	10	1	0
519	180	22	3	200	20	0
520	181	72	1	100	10	0
521	181	23	2	100	10	0
522	181	45	3	100	10	0
524	182	17	2	40	4	0
525	182	8	3	230	23	0
526	183	28	1	130	13	0
527	183	6	2	180	18	0
529	184	65	1	200	20	0
530	184	41	2	80	8	0
531	184	50	3	150	15	0
532	185	79	1	140	14	0
534	185	24	3	230	23	0
535	186	55	1	120	12	0
536	186	17	2	150	15	0
537	186	3	3	130	13	0
539	187	66	2	280	28	0
540	187	1	3	80	8	0
541	188	16	1	180	18	0
542	188	59	2	100	10	0
544	189	2	1	100	10	0
545	189	4	2	240	24	0
546	189	35	3	150	15	0
547	190	64	1	200	20	0
549	190	45	3	80	8	0
550	191	36	1	140	14	0
551	191	60	2	160	16	0
552	191	22	3	120	12	0
554	192	73	2	170	17	0
555	192	76	3	160	16	0
556	193	5	1	160	16	0
557	193	7	2	160	16	0
559	194	37	1	120	12	0
560	194	8	2	180	18	0
561	194	71	3	160	16	0
562	195	41	1	130	13	0
564	195	29	3	310	31	0
565	196	8	1	200	20	0
566	196	1	2	110	11	0
567	196	37	3	230	23	0
569	197	17	2	170	17	0
570	197	72	3	80	8	0
571	198	30	1	70	7	0
572	198	2	2	220	22	0
574	199	7	1	140	14	0
575	199	65	2	100	10	0
576	199	55	3	90	9	0
577	200	23	1	200	20	0
579	200	16	3	160	16	0
580	201	66	1	180	18	0
581	201	79	2	140	14	0
582	201	64	3	170	17	0
584	202	4	2	130	13	0
585	202	15	3	100	10	0
586	203	6	1	120	12	0
587	203	50	2	150	15	0
589	204	76	1	130	13	0
590	204	60	2	90	9	0
591	204	22	3	150	15	0
592	205	45	1	220	22	0
594	205	5	3	90	9	0
595	206	45	1	180	18	0
596	206	24	2	150	15	0
597	206	71	3	150	15	0
599	207	29	2	160	16	0
600	207	76	3	230	23	0
601	208	8	1	190	19	0
602	208	17	2	130	13	0
604	209	64	1	210	21	0
605	209	55	2	270	27	0
606	209	41	3	70	7	0
607	210	60	1	160	16	0
609	210	15	3	110	11	0
610	211	66	1	160	16	0
611	211	3	2	260	26	0
612	211	28	3	170	17	0
614	212	22	2	160	16	0
615	212	79	3	90	9	0
616	213	73	1	160	16	0
617	213	30	2	130	13	0
619	214	35	1	100	10	0
620	214	50	2	280	28	0
621	214	23	3	150	15	0
622	215	16	1	70	7	0
624	215	7	3	60	6	0
625	216	59	1	270	27	0
626	216	2	2	140	14	0
627	216	65	3	80	8	0
631	218	29	1	170	17	0
632	218	59	2	110	11	0
633	218	1	3	110	11	0
634	219	22	1	140	14	0
636	219	4	3	160	16	0
637	220	7	1	250	25	0
638	220	73	2	290	29	0
639	220	36	3	200	20	0
641	221	71	2	190	19	0
642	221	60	3	60	6	0
643	222	3	1	300	30	0
644	222	30	2	150	15	0
646	223	66	1	240	24	0
647	223	17	2	50	5	0
648	223	76	3	130	13	0
649	224	50	1	150	15	0
651	224	15	3	90	9	0
652	225	28	1	210	21	0
653	225	72	2	80	8	0
654	225	2	3	120	12	0
656	226	5	2	50	5	0
657	226	37	3	100	10	0
658	227	79	1	80	8	0
659	227	16	2	170	17	0
661	228	8	1	120	12	0
662	228	55	2	180	18	0
663	228	3	3	140	14	0
664	229	60	1	170	17	0
666	229	76	3	210	21	0
667	230	41	1	140	14	0
668	230	15	2	100	10	0
669	230	5	3	100	10	0
671	231	16	2	100	10	0
672	231	4	3	260	26	0
673	232	23	1	150	15	0
674	232	17	2	140	14	0
676	233	79	1	280	28	0
677	233	55	2	130	13	0
678	233	30	3	150	15	0
679	234	73	1	90	9	0
681	234	36	3	150	15	0
682	235	71	1	190	19	0
683	235	72	2	180	18	0
684	235	7	3	230	23	0
686	236	22	2	190	19	0
687	236	8	3	180	18	0
688	237	66	1	200	20	0
689	237	50	2	40	4	0
691	238	2	1	160	16	0
692	238	29	2	240	24	0
693	238	1	3	100	10	0
694	239	65	1	100	10	0
696	239	64	3	130	13	0
697	244	12	1	70	7	0
698	244	9	2	90	9	0
699	244	13	3	60	6	0
701	245	68	2	50	5	0
702	245	11	3	110	11	0
703	246	19	1	70	7	0
704	246	39	2	170	17	0
706	247	47	1	130	13	0
707	247	48	2	100	10	0
708	247	56	3	110	11	0
709	248	46	1	80	8	0
711	248	18	3	80	8	0
712	249	53	1	90	9	0
713	249	61	2	160	16	0
714	249	32	3	110	11	0
716	250	33	2	140	14	0
717	250	43	3	110	11	0
718	251	67	1	40	4	0
719	251	31	2	140	14	0
721	252	25	1	130	13	0
722	252	62	2	150	15	0
723	252	42	3	60	6	0
724	253	51	1	70	7	0
726	253	57	3	140	14	0
727	254	77	1	160	16	0
728	254	68	2	150	15	0
729	254	67	3	90	9	0
731	255	33	2	120	12	0
732	255	13	3	60	6	0
733	256	48	1	140	14	0
734	256	46	2	30	3	0
736	257	43	1	70	7	0
737	257	57	2	70	7	0
738	257	12	3	100	10	0
739	258	51	1	100	10	0
741	258	10	3	140	14	0
742	259	74	1	110	11	0
743	259	80	2	30	3	0
744	259	52	3	200	20	0
746	260	47	2	80	8	0
747	260	19	3	110	11	0
748	261	56	1	80	8	0
749	261	32	2	80	8	0
751	262	26	1	150	15	0
752	262	77	2	220	22	0
753	262	11	3	0	0	0
754	263	38	1	160	16	0
756	263	61	3	120	12	0
757	264	42	1	90	9	0
758	264	18	2	110	11	0
759	264	51	3	100	10	0
761	265	47	2	60	6	0
762	265	10	3	110	11	0
763	266	31	1	160	16	0
764	266	42	2	120	12	0
766	267	12	1	100	10	0
767	267	26	2	130	13	0
768	267	39	3	150	15	0
769	268	68	1	80	8	0
771	268	53	3	40	4	0
772	269	19	1	120	12	0
773	269	67	2	260	26	0
774	269	11	3	80	8	0
776	270	57	2	100	10	0
777	270	32	3	120	12	0
778	271	13	1	170	17	0
779	271	74	2	100	10	0
781	272	77	1	180	18	0
782	272	18	2	90	9	0
783	272	62	3	180	18	0
784	273	48	1	110	11	0
900	312	81	3	\N	\N	0
788	274	9	2	120	12	0
789	274	38	3	110	11	0
790	275	47	1	140	14	0
791	275	46	2	60	6	0
793	276	9	1	170	17	0
794	276	43	2	120	12	0
795	276	53	3	70	7	0
796	277	10	1	140	14	0
798	277	61	3	130	13	0
799	278	52	1	140	14	0
800	278	56	2	90	9	0
801	278	31	3	130	13	0
803	279	18	2	100	10	0
804	279	68	3	130	13	0
805	280	62	1	80	8	0
806	280	32	2	170	17	0
808	281	74	1	50	5	0
809	281	57	2	70	7	0
810	281	19	3	240	24	0
811	282	39	1	100	10	0
813	282	51	3	50	5	0
814	283	67	1	100	10	0
815	283	11	2	30	3	0
816	283	26	3	110	11	0
818	284	12	2	120	12	0
819	284	13	3	80	8	0
820	285	42	1	70	7	0
821	285	10	2	210	21	0
823	286	51	1	160	16	0
824	286	77	2	230	23	0
825	286	46	3	100	10	0
826	287	47	1	100	10	0
828	287	52	3	180	18	0
829	288	56	1	80	8	0
830	288	11	2	90	9	0
831	288	74	3	150	15	0
833	289	38	2	140	14	0
834	289	61	3	120	12	0
835	290	25	1	150	15	0
836	290	67	2	230	23	0
838	291	62	1	60	6	0
839	291	48	2	120	12	0
840	291	31	3	180	18	0
841	292	39	1	40	4	0
843	292	33	3	170	17	0
844	293	43	1	70	7	0
845	293	18	2	80	8	0
846	293	26	3	120	12	0
848	294	53	2	130	13	0
849	294	68	3	-10	-1	0
850	295	13	1	180	18	0
851	295	9	2	140	14	0
853	296	19	1	130	13	0
854	296	48	2	150	15	0
855	296	53	3	20	2	0
856	297	13	1	100	10	0
858	297	77	3	180	18	0
859	298	52	1	130	13	0
860	298	31	2	70	7	0
861	298	11	3	20	2	0
863	299	9	2	30	3	0
864	299	43	3	110	11	0
865	300	57	1	60	6	0
866	300	68	2	210	21	0
868	301	25	1	160	16	0
869	301	10	2	170	17	0
870	301	56	3	200	20	0
871	302	47	1	110	11	0
873	302	67	3	130	13	0
874	303	74	1	100	10	0
875	303	46	2	140	14	0
876	303	38	3	140	14	0
878	304	80	2	150	15	0
879	304	32	3	200	20	0
880	305	51	1	150	15	0
881	305	62	2	170	17	0
883	307	78	1	200	20	0
884	307	14	2	190	19	0
885	307	21	3	170	17	0
886	308	40	1	120	12	0
888	308	20	3	150	15	0
889	309	34	1	60	6	0
890	309	44	2	100	10	0
891	309	63	3	170	17	0
893	310	54	2	210	21	0
894	310	58	3	150	15	0
895	311	82	1	240	24	0
896	311	27	2	190	19	0
898	312	81	1	30	3	0
899	312	70	2	100	10	0
901	313	14	1	150	15	0
902	313	27	2	80	8	0
904	314	44	1	70	7	0
905	314	20	2	90	9	0
906	314	54	3	70	7	0
907	315	40	1	120	12	0
909	315	34	3	120	12	0
910	316	69	1	160	16	0
911	316	70	2	100	10	0
912	316	49	3	160	16	0
914	317	21	2	100	10	0
915	317	63	3	210	21	0
916	318	58	1	190	19	0
917	318	20	2	220	22	0
919	319	21	1	60	6	0
920	319	44	2	180	18	0
921	319	69	3	70	7	0
922	320	34	1	190	19	0
924	320	27	3	300	30	0
925	321	82	1	250	25	0
926	321	75	2	100	10	0
927	321	40	3	150	15	0
929	322	78	2	210	21	0
930	322	49	3	140	14	0
931	323	54	1	210	21	0
932	323	63	2	100	10	0
934	324	40	1	180	18	0
935	324	54	2	80	8	0
936	324	34	3	200	20	0
937	325	70	1	130	13	0
939	325	78	3	230	23	0
940	326	21	1	80	8	0
941	326	44	2	170	17	0
942	326	82	3	170	17	0
969	335	78	3	\N	\N	0
945	327	27	3	110	11	0
946	328	58	1	220	22	0
947	328	49	2	70	7	0
948	328	81	3	200	20	0
950	329	20	2	120	12	0
951	329	58	3	140	14	0
952	330	14	1	110	11	0
953	330	27	2	180	18	0
955	331	70	1	140	14	0
956	331	82	2	180	18	0
957	331	54	3	210	21	0
958	332	21	1	110	11	0
960	332	20	3	110	11	0
961	333	40	1	140	14	0
962	333	34	2	70	7	0
963	333	75	3	50	5	0
965	334	44	2	90	9	0
966	334	63	3	80	8	0
970	336	58	1	150	15	0
968	335	70	2	150	15	0
971	336	34	2	130	13	0
972	336	54	3	130	13	0
973	337	63	1	270	27	0
974	337	49	2	90	9	0
976	338	40	1	190	19	0
977	338	69	2	130	13	0
978	338	27	3	130	13	0
979	339	14	1	150	15	0
981	339	44	3	140	14	0
982	340	20	1	30	3	0
983	340	75	2	50	5	0
984	340	82	3	230	23	0
986	343	29	2	160	16	0
987	343	28	3	170	17	0
988	344	79	1	170	17	0
989	344	36	2	220	22	0
991	345	23	1	300	30	0
992	345	60	2	130	13	0
993	345	45	3	160	16	0
994	346	2	1	110	11	0
996	346	22	3	190	19	0
997	347	3	1	170	17	0
998	347	6	2	100	10	0
999	347	59	3	190	19	0
1001	348	64	2	160	16	0
1002	348	4	3	10	1	0
1003	349	55	1	220	22	0
1004	349	50	2	200	20	0
1006	350	37	1	140	14	0
1007	350	15	2	150	15	0
1008	350	8	3	260	26	0
1009	351	30	1	140	14	0
1011	351	1	3	180	18	0
1012	352	7	1	140	14	0
1013	352	66	2	170	17	0
1014	352	71	3	210	21	0
1016	353	35	2	130	13	0
1017	353	76	3	110	11	0
1018	354	72	1	240	24	0
1019	354	16	2	300	30	0
1021	355	24	1	180	18	0
1022	355	37	2	30	3	0
1023	355	23	3	100	10	0
1024	356	79	1	70	7	0
1026	356	30	3	130	13	0
1027	357	41	1	160	16	0
1028	357	55	2	130	13	0
1029	357	50	3	190	19	0
1031	358	66	2	270	27	0
1032	358	35	3	180	18	0
1033	359	28	1	230	23	0
1034	359	3	2	260	26	0
1036	360	4	1	150	15	0
1037	360	60	2	140	14	0
1038	360	22	3	230	23	0
1039	361	45	1	150	15	0
1041	361	36	3	280	28	0
1042	362	15	1	170	17	0
1043	362	71	2	60	6	0
1044	362	29	3	120	12	0
1046	363	76	2	230	23	0
1047	363	5	3	160	16	0
1048	364	1	1	150	15	0
1049	364	59	2	200	20	0
1051	365	17	1	150	15	0
1052	365	65	2	240	24	0
1053	365	36	3	200	20	0
1054	366	41	1	90	9	0
1056	366	5	3	60	6	0
1057	367	73	1	150	15	0
1058	367	59	2	230	23	0
1059	367	29	3	150	15	0
1061	368	7	2	150	15	0
1062	368	66	3	130	13	0
1063	369	8	1	120	12	0
1064	369	2	2	130	13	0
1066	370	50	1	110	11	0
1067	370	17	2	80	8	0
1068	370	45	3	220	22	0
1069	371	22	1	180	18	0
1071	371	24	3	240	24	0
1072	372	79	1	230	23	0
1073	372	16	2	30	3	0
1074	372	23	3	260	26	0
1076	373	3	2	90	9	0
1077	373	60	3	120	12	0
1078	374	71	1	100	10	0
1079	374	28	2	60	6	0
1081	375	15	1	120	12	0
1082	375	6	2	180	18	0
1083	375	64	3	210	21	0
1084	376	76	1	120	12	0
1086	376	72	3	190	19	0
1087	377	55	1	150	15	0
1088	377	35	2	150	15	0
1089	377	22	3	220	22	0
1091	378	15	2	80	8	0
1092	378	1	3	260	26	0
1093	379	17	1	130	13	0
1094	379	71	2	150	15	0
1096	380	50	1	220	22	0
1097	380	5	2	60	6	0
1098	380	2	3	170	17	0
1099	381	30	1	100	10	0
3353	1165	40	2	90	9	0
1102	382	36	1	70	7	0
1103	382	41	2	250	25	0
1104	382	73	3	230	23	0
1105	383	29	1	200	20	0
1107	383	28	3	190	19	0
1108	384	66	1	240	24	0
1109	384	72	2	120	12	0
1110	384	24	3	190	19	0
1112	385	6	2	130	13	0
1113	385	16	3	200	20	0
1114	386	79	1	90	9	0
1115	386	37	2	170	17	0
1117	387	76	1	140	14	0
1118	387	64	2	110	11	0
1119	387	23	3	140	14	0
1120	388	3	1	130	13	0
1122	388	1	3	220	22	0
1123	389	35	1	70	7	0
1124	389	3	2	230	23	0
1125	389	64	3	190	19	0
1127	390	2	2	160	16	0
1128	390	36	3	200	20	0
1129	391	24	1	70	7	0
1130	391	72	2	130	13	0
1132	392	37	1	110	11	0
1133	392	60	2	120	12	0
1134	392	79	3	200	20	0
1135	393	5	1	90	9	0
1137	393	29	3	180	18	0
1138	394	16	1	330	33	0
1139	394	73	2	170	17	0
1140	394	71	3	210	21	0
1142	395	50	2	200	20	0
1143	395	6	3	170	17	0
1144	396	7	1	90	9	0
1145	396	23	2	-20	-2	0
1147	397	76	1	130	13	0
1148	397	28	2	50	5	0
1149	397	17	3	180	18	0
1150	398	4	1	240	24	0
1152	398	45	3	130	13	0
1153	399	55	1	250	25	0
1154	399	15	2	160	16	0
1155	399	2	3	120	12	0
1157	400	3	2	130	13	0
1158	400	23	3	180	18	0
1159	401	29	1	100	10	0
1160	401	22	2	200	20	0
1162	402	64	1	180	18	0
1163	402	15	2	120	12	0
1164	402	1	3	120	12	0
1165	403	79	1	230	23	0
1167	403	8	3	120	12	0
1168	404	60	1	180	18	0
1169	404	6	2	110	11	0
1170	404	73	3	260	26	0
1172	405	50	2	150	15	0
1173	405	71	3	120	12	0
1174	406	4	1	160	16	0
1175	406	7	2	200	20	0
1177	407	76	1	120	12	0
1178	407	72	2	190	19	0
1179	407	37	3	190	19	0
1180	408	28	1	90	9	0
1182	408	17	3	120	12	0
1183	409	65	1	120	12	0
1184	409	24	2	150	15	0
1185	409	41	3	60	6	0
1187	410	35	2	210	21	0
1188	410	36	3	100	10	0
1189	415	47	1	60	6	0
1190	415	67	2	160	16	0
1192	416	80	1	110	11	0
1193	416	68	2	110	11	0
1194	416	11	3	60	6	0
1195	417	62	1	100	10	0
1197	417	25	3	130	13	0
1198	418	31	1	100	10	0
1199	418	32	2	120	12	0
1200	418	19	3	130	13	0
1202	419	46	2	60	6	0
1203	419	38	3	50	5	0
1204	420	53	1	170	17	0
1205	420	18	2	90	9	0
1207	421	61	1	90	9	0
1208	421	51	2	70	7	0
1209	421	33	3	50	5	0
1210	422	39	1	150	15	0
1212	422	48	3	130	13	0
1213	423	43	1	150	15	0
1214	423	12	2	120	12	0
1215	423	42	3	200	20	0
1217	424	57	2	60	6	0
1218	424	9	3	160	16	0
1219	425	56	1	40	4	0
1220	425	12	2	130	13	0
1222	426	51	1	40	4	0
1223	426	47	2	120	12	0
1224	426	26	3	40	4	0
1225	427	42	1	130	13	0
1227	427	10	3	240	24	0
1228	428	25	1	160	16	0
1229	428	53	2	60	6	0
1230	428	74	3	140	14	0
1232	429	31	2	150	15	0
1233	429	19	3	190	19	0
1234	430	56	1	60	6	0
1235	430	13	2	150	15	0
1237	431	46	1	170	17	0
1238	431	67	2	140	14	0
1239	431	9	3	180	18	0
1240	432	43	1	110	11	0
1242	432	61	3	210	21	0
1243	433	57	1	120	12	0
1244	433	80	2	160	16	0
1245	433	33	3	120	12	0
1247	434	11	2	70	7	0
1248	434	38	3	120	12	0
1249	435	32	1	110	11	0
1250	435	18	2	70	7	0
1252	436	62	1	30	3	0
1253	436	51	2	90	9	0
1254	436	52	3	180	18	0
1255	437	39	1	30	3	0
1259	438	68	2	130	13	0
1260	438	46	3	190	19	0
1261	439	10	1	200	20	0
1262	439	57	2	80	8	0
1264	440	77	1	110	11	0
1265	440	31	2	140	14	0
1266	440	80	3	130	13	0
1267	441	19	1	90	9	0
1269	441	38	3	90	9	0
1270	442	48	1	210	21	0
1271	442	33	2	60	6	0
1272	442	47	3	70	7	0
1274	443	74	2	90	9	0
1275	443	61	3	110	11	0
1276	444	67	1	170	17	0
1277	444	42	2	20	2	0
1279	445	43	1	180	18	0
1280	445	13	2	300	30	0
1281	445	25	3	220	22	0
1282	446	53	1	150	15	0
1284	446	74	3	160	16	0
1285	447	61	1	140	14	0
1286	447	10	2	130	13	0
1287	447	33	3	100	10	0
1289	448	47	2	20	2	0
1290	448	11	3	20	2	0
1291	449	48	1	90	9	0
1292	449	26	2	160	16	0
1294	450	39	1	120	12	0
1295	450	80	2	250	25	0
1296	450	42	3	80	8	0
1297	451	62	1	130	13	0
1299	451	57	3	100	10	0
1300	452	13	1	30	3	0
1301	452	51	2	80	8	0
1302	452	9	3	180	18	0
1304	453	56	2	130	13	0
1305	453	25	3	80	8	0
1306	454	12	1	110	11	0
1307	454	19	2	10	1	0
1309	455	46	1	220	22	0
1310	455	68	2	160	16	0
1311	455	31	3	30	3	0
1312	456	67	1	200	20	0
1314	456	57	3	110	11	0
1315	457	19	1	140	14	0
1316	457	13	2	250	25	0
1317	457	53	3	130	13	0
1319	458	56	2	60	6	0
1320	458	51	3	50	5	0
1321	459	25	1	100	10	0
1322	459	26	2	110	11	0
1324	460	9	1	60	6	0
1325	460	39	2	160	16	0
1326	460	43	3	170	17	0
1327	461	33	1	160	16	0
1329	461	62	3	200	20	0
1330	462	77	1	110	11	0
1331	462	42	2	120	12	0
1332	462	46	3	270	27	0
1334	463	48	2	100	10	0
1335	463	38	3	210	21	0
1336	464	32	1	40	4	0
1337	464	12	2	100	10	0
1339	465	10	1	120	12	0
1340	465	80	2	70	7	0
1341	465	52	3	210	21	0
1342	466	67	1	290	29	0
1344	466	52	3	210	21	0
1345	467	61	1	220	22	0
1346	467	11	2	110	11	0
1347	467	31	3	160	16	0
1349	468	25	2	110	11	0
1350	468	77	3	100	10	0
1351	469	32	1	170	17	0
1352	469	62	2	150	15	0
1354	470	39	1	150	15	0
1355	470	47	2	70	7	0
1356	470	26	3	140	14	0
1357	471	56	1	90	9	0
1359	471	33	3	170	17	0
1360	472	19	1	170	17	0
1361	472	12	2	140	14	0
1362	472	80	3	120	12	0
1364	473	74	2	70	7	0
1365	473	67	3	170	17	0
1366	474	43	1	140	14	0
1367	474	13	2	150	15	0
1369	475	57	1	110	11	0
1370	475	51	2	80	8	0
1371	475	53	3	50	5	0
1372	476	48	1	80	8	0
1374	476	9	3	50	5	0
1375	478	81	1	100	10	0
1376	478	27	2	130	13	0
1377	478	40	3	120	12	0
1379	479	54	2	230	23	0
1380	479	44	3	90	9	0
1381	480	75	1	10	1	0
1382	480	58	2	180	18	0
1384	481	63	1	140	14	0
1385	481	70	2	140	14	0
1386	481	20	3	100	10	0
1387	482	69	1	150	15	0
1389	482	34	3	170	17	0
1390	483	49	1	90	9	0
1391	483	82	2	180	18	0
1392	483	27	3	190	19	0
1394	484	69	2	70	7	0
1395	484	14	3	150	15	0
1396	485	44	1	80	8	0
1397	485	81	2	120	12	0
1399	486	21	1	140	14	0
1400	486	40	2	190	19	0
1401	486	75	3	210	21	0
1402	487	34	1	100	10	0
1404	487	58	3	170	17	0
1405	488	54	1	150	15	0
1406	488	49	2	80	8	0
1407	488	70	3	50	5	0
1409	489	58	2	90	9	0
1410	489	70	3	220	22	0
1411	490	82	1	220	22	0
1412	490	14	2	90	9	0
3358	1167	14	1	130	13	0
1416	491	44	3	230	23	0
1417	492	40	1	60	6	0
1418	492	54	2	170	17	0
1419	492	69	3	230	23	0
1421	493	81	2	150	15	0
1422	493	78	3	140	14	0
1423	494	49	1	120	12	0
1424	494	20	2	140	14	0
1426	495	70	1	80	8	0
1427	495	21	2	100	10	0
1428	495	54	3	130	13	0
1429	496	81	1	120	12	0
1431	496	49	3	230	23	0
1432	497	78	1	220	22	0
1433	497	75	2	150	15	0
1434	497	34	3	130	13	0
1436	498	82	2	90	9	0
1437	498	27	3	50	5	0
1438	499	44	1	110	11	0
1439	499	63	2	170	17	0
1441	500	58	1	210	21	0
1442	500	69	2	240	24	0
1443	500	40	3	190	19	0
1444	501	54	1	140	14	0
1446	501	82	3	320	32	0
1447	502	75	1	110	11	0
1448	502	20	2	90	9	0
1449	502	44	3	150	15	0
1451	503	27	2	230	23	0
1452	503	63	3	160	16	0
1453	504	58	1	90	9	0
1454	504	34	2	220	22	0
1456	505	21	1	200	20	0
1457	505	69	2	240	24	0
1458	505	14	3	180	18	0
1459	506	78	1	80	8	0
1461	506	27	3	230	23	0
1462	507	44	1	140	14	0
1463	507	75	2	90	9	0
1464	507	21	3	50	5	0
1466	508	81	2	120	12	0
1467	508	82	3	110	11	0
1468	509	69	1	230	23	0
1469	509	14	2	150	15	0
1471	510	70	1	190	19	0
1472	510	20	2	150	15	0
1473	510	78	3	210	21	0
1474	511	40	1	110	11	0
1476	511	54	3	200	20	0
1477	514	3	1	220	22	0
1478	514	5	2	100	10	0
1479	514	2	3	130	13	0
1481	515	64	2	120	12	0
1482	515	29	3	120	12	0
1483	516	60	1	220	22	0
1484	516	30	2	120	12	0
1486	517	16	1	180	18	0
1487	517	50	2	150	15	0
1488	517	24	3	140	14	0
1489	518	35	1	340	34	0
1491	518	28	3	220	22	0
1492	519	1	1	160	16	0
1493	519	66	2	220	22	0
1494	519	79	3	140	14	0
1496	520	73	2	270	27	0
1497	520	4	3	170	17	0
1498	521	45	1	150	15	0
1499	521	59	2	240	24	0
1501	522	65	1	90	9	0
1502	522	7	2	150	15	0
1503	522	36	3	80	8	0
1504	523	15	1	140	14	0
1506	523	23	3	200	20	0
1507	524	6	1	140	14	0
1508	524	41	2	130	13	0
1509	524	17	3	130	13	0
1511	525	1	2	80	8	0
1512	525	2	3	70	7	0
1513	526	15	1	220	22	0
1514	526	8	2	270	27	0
1516	527	35	1	170	17	0
1517	527	6	2	210	21	0
1518	527	16	3	160	16	0
1519	528	41	1	120	12	0
1521	528	45	3	160	16	0
1522	529	72	1	180	18	0
1523	529	30	2	80	8	0
1524	529	60	3	140	14	0
1526	530	36	2	160	16	0
1527	530	29	3	90	9	0
1528	531	23	1	180	18	0
1529	531	22	2	60	6	0
1531	532	76	1	190	19	0
1532	532	7	2	100	10	0
1533	532	24	3	100	10	0
1534	533	79	1	170	17	0
1536	533	59	3	210	21	0
1537	534	65	1	60	6	0
1538	534	50	2	60	6	0
1539	534	17	3	200	20	0
1541	535	37	2	50	5	0
1542	535	66	3	230	23	0
1543	536	64	1	140	14	0
1544	536	28	2	160	16	0
1546	537	60	1	90	9	0
1547	537	41	2	180	18	0
1548	537	3	3	190	19	0
1549	538	22	1	80	8	0
1551	538	15	3	100	10	0
1552	539	71	1	170	17	0
1553	539	37	2	130	13	0
1554	539	73	3	320	32	0
1556	540	76	2	180	18	0
1557	540	28	3	170	17	0
1558	541	29	1	150	15	0
1559	541	66	2	150	15	0
1561	542	17	1	100	10	0
1562	542	59	2	220	22	0
1563	542	36	3	200	20	0
1564	543	16	1	120	12	0
1566	543	4	3	250	25	0
1567	544	1	1	190	19	0
1568	544	50	2	200	20	0
1569	544	8	3	180	18	0
1573	546	2	1	100	10	0
1574	546	64	2	220	22	0
1575	546	65	3	140	14	0
1576	547	72	1	70	7	0
1578	547	35	3	90	9	0
1579	548	4	1	190	19	0
1580	548	16	2	220	22	0
1581	548	37	3	170	17	0
1583	549	1	2	180	18	0
1584	549	30	3	150	15	0
1585	550	71	1	160	16	0
1586	550	22	2	200	20	0
1588	551	45	1	260	26	0
1589	551	60	2	180	18	0
1590	551	29	3	200	20	0
1591	552	66	1	220	22	0
1593	552	2	3	120	12	0
1594	553	76	1	210	21	0
1595	553	7	2	180	18	0
1596	553	5	3	90	9	0
1598	554	72	2	90	9	0
1599	554	28	3	50	5	0
1600	555	55	1	100	10	0
1601	555	50	2	230	23	0
1603	556	35	1	160	16	0
1604	556	59	2	110	11	0
1605	556	3	3	120	12	0
1606	557	36	1	120	12	0
1608	557	15	3	130	13	0
1609	558	6	1	110	11	0
1610	558	17	2	190	19	0
1611	558	64	3	180	18	0
1613	559	79	2	70	7	0
1614	559	37	3	80	8	0
1615	560	71	1	240	24	0
1616	560	2	2	130	13	0
1618	561	50	1	160	16	0
1619	561	17	2	250	25	0
1620	561	41	3	80	8	0
1621	562	28	1	110	11	0
1623	562	24	3	90	9	0
1624	563	8	1	250	25	0
1625	563	22	2	150	15	0
1626	563	5	3	100	10	0
1628	564	30	2	150	15	0
1629	564	4	3	220	22	0
1630	565	3	1	230	23	0
1631	565	65	2	230	23	0
1633	566	59	1	80	8	0
1634	566	55	2	210	21	0
1635	566	64	3	140	14	0
1636	567	60	1	200	20	0
1638	567	35	3	140	14	0
1639	568	66	1	240	24	0
1640	568	15	2	120	12	0
1641	568	72	3	230	23	0
1643	569	1	2	180	18	0
1644	569	23	3	190	19	0
1645	570	36	1	140	14	0
1646	570	73	2	180	18	0
1648	571	60	1	220	22	0
1649	571	72	2	290	29	0
1650	571	24	3	160	16	0
1651	572	35	1	210	21	0
1653	572	2	3	280	28	0
1654	573	36	1	60	6	0
1655	573	4	2	160	16	0
1656	573	73	3	150	15	0
1658	574	17	2	130	13	0
1659	574	59	3	200	20	0
1660	575	16	1	70	7	0
1661	575	15	2	110	11	0
1663	576	30	1	100	10	0
1664	576	22	2	150	15	0
1665	576	5	3	80	8	0
1666	577	45	1	100	10	0
1668	577	41	3	60	6	0
1669	578	55	1	80	8	0
1670	578	3	2	80	8	0
1671	578	7	3	330	33	0
1673	579	66	2	220	22	0
1674	579	6	3	230	23	0
1675	580	23	1	150	15	0
1676	580	50	2	130	13	0
1678	581	79	1	200	20	0
1679	581	1	2	110	11	0
1680	581	71	3	120	12	0
1681	586	53	1	170	17	0
1683	586	31	3	100	10	0
1684	587	19	1	130	13	0
1685	587	9	2	100	10	0
1686	587	33	3	150	15	0
1688	588	11	2	0	0	0
1689	588	61	3	50	5	0
1690	589	48	1	120	12	0
1691	589	74	2	50	5	0
1693	590	68	1	90	9	0
1694	590	12	2	180	18	0
1695	590	42	3	110	11	0
1696	591	52	1	180	18	0
1698	591	10	3	100	10	0
1699	592	38	1	80	8	0
1700	592	67	2	250	25	0
1701	592	39	3	180	18	0
1703	593	25	2	140	14	0
1704	593	32	3	170	17	0
1705	594	47	1	120	12	0
1706	594	56	2	120	12	0
1708	595	57	1	100	10	0
1709	595	77	2	140	14	0
1710	595	13	3	190	19	0
1711	596	18	1	100	10	0
1713	596	46	3	130	13	0
1714	597	32	1	60	6	0
1715	597	74	2	160	16	0
1716	597	43	3	250	25	0
1718	598	26	2	100	10	0
1719	598	52	3	80	8	0
1720	599	25	1	140	14	0
1721	599	11	2	40	4	0
1723	600	62	1	110	11	0
1724	600	31	2	170	17	0
1725	600	80	3	150	15	0
1726	601	68	1	110	11	0
3363	1168	81	3	190	19	0
1884	654	21	3	\N	\N	0
1730	602	67	2	160	16	0
1731	602	39	3	0	0	0
1732	603	53	1	80	8	0
1733	603	19	2	110	11	0
1735	604	18	1	130	13	0
1736	604	77	2	110	11	0
1737	604	13	3	140	14	0
1738	605	57	1	70	7	0
1740	605	38	3	120	12	0
1741	606	10	1	130	13	0
1742	606	48	2	130	13	0
1743	606	74	3	200	20	0
1745	607	33	2	70	7	0
1746	607	77	3	150	15	0
1747	608	56	1	90	9	0
1748	608	51	2	130	13	0
1750	609	25	1	40	4	0
1751	609	18	2	110	11	0
1752	609	46	3	170	17	0
1753	610	48	1	70	7	0
1755	610	43	3	50	5	0
1756	611	9	1	150	15	0
1757	611	53	2	170	17	0
1758	611	26	3	140	14	0
1760	612	67	2	110	11	0
1761	612	61	3	120	12	0
1762	613	11	1	110	11	0
1763	613	47	2	30	3	0
1765	614	52	1	140	14	0
1766	614	39	2	160	16	0
1767	614	62	3	70	7	0
1768	615	13	1	60	6	0
1770	615	42	3	90	9	0
1771	616	38	1	90	9	0
1772	616	31	2	170	17	0
1773	616	12	3	60	6	0
1775	617	10	2	270	27	0
1776	617	39	3	190	19	0
1777	618	43	1	150	15	0
1778	618	9	2	60	6	0
1780	619	53	1	40	4	0
1781	619	26	2	70	7	0
1782	619	13	3	90	9	0
1783	620	25	1	190	19	0
1785	620	52	3	140	14	0
1786	621	18	1	100	10	0
1787	621	57	2	40	4	0
1788	621	31	3	110	11	0
1790	622	12	2	110	11	0
1791	622	32	3	100	10	0
1792	623	48	1	240	24	0
1793	623	19	2	50	5	0
1795	624	77	1	80	8	0
1796	624	61	2	190	19	0
1797	624	51	3	40	4	0
1798	625	67	1	90	9	0
1800	625	47	3	80	8	0
1801	626	42	1	150	15	0
1802	626	46	2	110	11	0
1803	626	80	3	200	20	0
1805	627	26	2	170	17	0
1806	627	32	3	60	6	0
1807	628	18	1	100	10	0
1808	628	61	2	130	13	0
1810	629	80	1	170	17	0
1811	629	51	2	60	6	0
1812	629	57	3	50	5	0
1813	630	74	1	150	15	0
1815	630	68	3	70	7	0
1816	631	11	1	100	10	0
1817	631	56	2	190	19	0
1818	631	31	3	120	12	0
1820	632	47	2	150	15	0
1821	632	13	3	120	12	0
1822	633	42	1	100	10	0
1823	633	19	2	130	13	0
1825	634	25	1	180	18	0
1826	634	77	2	130	13	0
1827	634	38	3	190	19	0
1828	635	46	1	230	23	0
1830	635	53	3	110	11	0
1831	636	9	1	200	20	0
1832	636	33	2	130	13	0
1833	636	10	3	200	20	0
1835	637	39	2	80	8	0
1836	637	51	3	130	13	0
1837	638	18	1	50	5	0
1838	638	25	2	50	5	0
1840	639	62	1	70	7	0
1841	639	43	2	60	6	0
1842	639	31	3	180	18	0
1843	640	39	1	150	15	0
1845	640	46	3	70	7	0
1846	641	61	1	140	14	0
1847	641	77	2	140	14	0
1848	641	57	3	120	12	0
1850	642	53	2	60	6	0
1851	642	48	3	110	11	0
1852	643	38	1	150	15	0
1853	643	80	2	100	10	0
1855	644	52	1	100	10	0
1856	644	68	2	140	14	0
1857	644	47	3	110	11	0
1858	645	9	1	60	6	0
1860	645	67	3	220	22	0
1861	646	10	1	50	5	0
1862	646	74	2	70	7	0
1863	646	33	3	140	14	0
1865	647	12	2	160	16	0
1866	647	32	3	180	18	0
1867	649	81	1	60	6	0
1868	649	20	2	160	16	0
1870	650	75	1	230	23	0
1871	650	49	2	190	19	0
1872	650	14	3	200	20	0
1873	651	27	1	130	13	0
1875	651	44	3	110	11	0
1876	652	34	1	100	10	0
1877	652	69	2	120	12	0
1878	652	82	3	130	13	0
1880	653	63	2	180	18	0
1881	653	40	3	230	23	0
1883	654	54	2	160	16	0
1887	655	78	3	60	6	0
1888	656	75	1	240	24	0
1889	656	20	2	130	13	0
1890	656	81	3	140	14	0
1892	657	82	2	160	16	0
1893	657	54	3	170	17	0
1894	658	27	1	200	20	0
1895	658	63	2	160	16	0
1897	659	40	1	70	7	0
1898	659	58	2	130	13	0
1899	659	49	3	160	16	0
1900	660	34	1	180	18	0
1902	660	54	3	130	13	0
1903	661	69	1	130	13	0
1904	661	82	2	190	19	0
1905	661	27	3	210	21	0
1907	662	70	2	210	21	0
1908	662	81	3	80	8	0
1909	663	14	1	80	8	0
1910	663	63	2	160	16	0
1912	664	75	1	80	8	0
1913	664	78	2	200	20	0
1914	664	58	3	120	12	0
1915	665	40	1	120	12	0
1917	665	49	3	160	16	0
1918	666	63	1	160	16	0
1919	666	82	2	190	19	0
1920	666	58	3	170	17	0
1922	667	78	2	40	4	0
1923	667	70	3	230	23	0
1924	668	20	1	90	9	0
1925	668	40	2	180	18	0
1927	669	69	1	150	15	0
1928	669	49	2	180	18	0
1929	669	44	3	20	2	0
1930	670	27	1	110	11	0
1932	670	21	3	90	9	0
1933	671	54	1	190	19	0
1934	671	81	2	150	15	0
1935	671	75	3	100	10	0
1937	672	69	2	140	14	0
1938	672	44	3	170	17	0
1939	673	34	1	180	18	0
1940	673	21	2	70	7	0
1942	674	63	1	190	19	0
1943	674	20	2	190	19	0
1944	674	78	3	90	9	0
1945	675	70	1	180	18	0
1947	675	14	3	130	13	0
1948	676	58	1	160	16	0
1949	676	49	2	100	10	0
1950	676	81	3	100	10	0
1952	677	14	2	90	9	0
1953	677	63	3	190	19	0
1954	678	81	1	150	15	0
1955	678	69	2	260	26	0
1957	679	58	1	110	11	0
1958	679	49	2	60	6	0
1959	679	54	3	130	13	0
1960	680	21	1	80	8	0
1962	680	82	3	140	14	0
1963	681	27	1	200	20	0
1964	681	20	2	100	10	0
1965	681	70	3	170	17	0
1967	682	34	2	170	17	0
1968	682	44	3	130	13	0
1969	685	76	1	160	16	0
1970	685	24	2	180	18	0
1972	686	16	1	120	12	0
1973	686	17	2	110	11	0
1974	686	29	3	170	17	0
1975	687	3	1	290	29	0
1977	687	2	3	90	9	0
1978	688	5	1	210	21	0
1979	688	73	2	110	11	0
1980	688	22	3	150	15	0
1982	689	79	2	280	28	0
1983	689	23	3	180	18	0
1984	690	7	1	260	26	0
1985	690	59	2	120	12	0
1987	691	4	1	100	10	0
1988	691	65	2	190	19	0
1989	691	45	3	140	14	0
1990	692	37	1	130	13	0
1992	692	60	3	60	6	0
1993	693	1	1	130	13	0
1994	693	28	2	110	11	0
1995	693	30	3	130	13	0
1997	694	36	2	210	21	0
1998	694	50	3	250	25	0
1999	695	15	1	170	17	0
2000	695	55	2	120	12	0
2002	696	66	1	160	16	0
2003	696	72	2	130	13	0
2004	696	29	3	150	15	0
2005	697	2	1	230	23	0
2007	697	35	3	140	14	0
2008	698	22	1	190	19	0
2009	698	50	2	100	10	0
2010	698	4	3	190	19	0
2012	699	16	2	120	12	0
2013	699	8	3	150	15	0
2014	700	66	1	140	14	0
2015	700	15	2	170	17	0
2017	701	76	1	160	16	0
2018	701	7	2	230	23	0
2019	701	28	3	130	13	0
2020	702	79	1	170	17	0
2022	702	36	3	160	16	0
2023	703	6	1	160	16	0
2024	703	41	2	100	10	0
2025	703	64	3	180	18	0
2027	704	73	2	180	18	0
2028	704	3	3	240	24	0
2029	705	23	1	120	12	0
2030	705	30	2	30	3	0
2033	706	60	2	200	20	0
2034	706	17	3	220	22	0
2035	707	65	1	170	17	0
2036	707	71	2	210	21	0
2037	707	79	3	140	14	0
2038	708	4	1	170	17	0
2039	708	16	2	130	13	0
2040	708	65	3	170	17	0
3368	1170	58	2	120	12	0
2044	710	66	1	140	14	0
2045	710	23	2	140	14	0
2046	710	15	3	120	12	0
2047	711	71	1	170	17	0
2049	711	8	3	220	22	0
2050	712	30	1	170	17	0
2051	712	76	2	120	12	0
2052	712	22	3	120	12	0
2054	713	29	2	100	10	0
2055	713	60	3	130	13	0
2056	714	41	1	110	11	0
2057	714	55	2	150	15	0
2059	715	28	1	90	9	0
2060	715	73	2	220	22	0
2061	715	36	3	190	19	0
2062	716	45	1	270	27	0
2064	716	24	3	150	15	0
2065	717	59	1	100	10	0
2066	717	3	2	130	13	0
2067	717	35	3	250	25	0
2069	718	72	2	160	16	0
2070	718	1	3	180	18	0
2071	719	28	1	140	14	0
2072	719	60	2	220	22	0
2074	720	8	1	150	15	0
2075	720	55	2	200	20	0
2076	720	17	3	70	7	0
2077	721	6	1	170	17	0
2079	721	71	3	230	23	0
2080	722	37	1	130	13	0
2081	722	24	2	150	15	0
2082	722	22	3	80	8	0
2084	723	35	2	140	14	0
2085	723	79	3	120	12	0
2086	724	2	1	220	22	0
2087	724	73	2	140	14	0
2089	725	64	1	110	11	0
2090	725	16	2	140	14	0
2091	725	30	3	240	24	0
2092	726	3	1	250	25	0
2094	726	45	3	180	18	0
2095	727	59	1	150	15	0
2096	727	65	2	50	5	0
2097	727	29	3	90	9	0
2099	728	41	2	40	4	0
2100	728	15	3	150	15	0
2101	729	4	1	190	19	0
2102	729	7	2	170	17	0
2104	730	36	1	190	19	0
2105	730	15	2	160	16	0
2106	730	59	3	120	12	0
2107	731	22	1	200	20	0
2109	731	1	3	110	11	0
2110	732	72	1	220	22	0
2111	732	76	2	110	11	0
2112	732	36	3	80	8	0
2114	733	8	2	250	25	0
2115	733	6	3	190	19	0
2116	734	29	1	220	22	0
2117	734	16	2	170	17	0
2119	735	45	1	160	16	0
2120	735	37	2	200	20	0
2121	735	65	3	250	25	0
2122	736	73	1	260	26	0
2124	736	17	3	150	15	0
2125	737	64	1	130	13	0
2126	737	55	2	130	13	0
2127	737	79	3	120	12	0
2129	738	3	2	270	27	0
2130	738	4	3	180	18	0
2131	739	60	1	110	11	0
2132	739	23	2	260	26	0
2134	740	66	1	0	0	0
2135	740	24	2	100	10	0
2136	740	28	3	180	18	0
2137	741	7	1	300	30	0
2139	741	5	3	130	13	0
2140	742	37	1	190	19	0
2141	742	45	2	260	26	0
2142	742	16	3	170	17	0
2144	743	7	2	100	10	0
2145	743	23	3	130	13	0
2146	744	28	1	100	10	0
2147	744	55	2	190	19	0
2149	745	59	1	230	23	0
2150	745	73	2	230	23	0
2151	745	66	3	220	22	0
2152	746	79	1	130	13	0
2154	746	72	3	100	10	0
2155	747	6	1	80	8	0
2156	747	65	2	160	16	0
2157	747	50	3	130	13	0
2159	748	22	2	260	26	0
2160	748	2	3	140	14	0
2161	749	29	1	170	17	0
2162	749	41	2	90	9	0
2164	750	30	1	40	4	0
2165	750	24	2	270	27	0
2166	750	35	3	170	17	0
2167	751	3	1	140	14	0
2169	751	15	3	130	13	0
2170	752	8	1	160	16	0
2171	752	1	2	160	16	0
2172	752	71	3	190	19	0
2174	757	51	2	80	8	0
2175	757	62	3	200	20	0
2176	758	19	1	110	11	0
2177	758	32	2	160	16	0
2179	759	12	1	110	11	0
2180	759	57	2	90	9	0
2181	759	42	3	60	6	0
2182	760	61	1	120	12	0
2184	760	52	3	170	17	0
2185	761	46	1	260	26	0
2186	761	13	2	180	18	0
2187	761	74	3	120	12	0
2189	762	43	2	160	16	0
2190	762	11	3	90	9	0
2191	763	10	1	280	28	0
2192	763	26	2	150	15	0
2194	764	56	1	160	16	0
2195	764	9	2	40	4	0
2196	764	25	3	170	17	0
2197	765	18	1	100	10	0
2201	766	80	2	120	12	0
2202	766	39	3	130	13	0
2203	767	53	1	110	11	0
2204	767	32	2	100	10	0
2206	768	13	1	170	17	0
2207	768	38	2	100	10	0
2208	768	53	3	120	12	0
2209	769	52	1	180	18	0
2211	769	25	3	170	17	0
2212	770	57	1	120	12	0
2213	770	42	2	170	17	0
2214	770	9	3	110	11	0
2216	771	31	2	160	16	0
2217	771	26	3	170	17	0
2218	772	33	1	180	18	0
2219	772	62	2	130	13	0
2221	773	77	1	110	11	0
2222	773	10	2	220	22	0
2223	773	46	3	100	10	0
2224	774	47	1	120	12	0
2226	774	67	3	130	13	0
2227	775	68	1	200	20	0
2228	775	18	2	140	14	0
2229	775	19	3	200	20	0
2231	776	11	2	80	8	0
2232	776	80	3	230	23	0
2233	777	12	1	150	15	0
2234	777	39	2	110	11	0
2236	778	61	1	90	9	0
2237	778	67	2	180	18	0
2238	778	38	3	110	11	0
2239	779	42	1	60	6	0
2241	779	18	3	110	11	0
2242	780	62	1	190	19	0
2243	780	47	2	130	13	0
2244	780	80	3	210	21	0
2246	781	9	2	200	20	0
2247	781	12	3	40	4	0
2248	782	68	1	210	21	0
2249	782	31	2	240	24	0
2251	783	39	1	60	6	0
2252	783	13	2	90	9	0
2253	783	48	3	150	15	0
2254	784	56	1	160	16	0
2256	784	53	3	110	11	0
2257	785	33	1	160	16	0
2258	785	74	2	90	9	0
2259	785	51	3	180	18	0
2261	786	10	2	100	10	0
2262	786	43	3	190	19	0
2263	787	26	1	140	14	0
2264	787	32	2	120	12	0
2266	788	9	1	120	12	0
2267	788	43	2	110	11	0
2268	788	56	3	70	7	0
2269	789	74	1	170	17	0
2271	789	39	3	170	17	0
2272	790	52	1	100	10	0
2273	790	42	2	60	6	0
2274	790	57	3	120	12	0
2276	791	26	2	170	17	0
2277	791	80	3	120	12	0
2278	792	12	1	60	6	0
2279	792	53	2	210	21	0
2281	793	51	1	120	12	0
2282	793	62	2	220	22	0
2283	793	18	3	50	5	0
2284	794	32	1	190	19	0
2286	794	68	3	130	13	0
2287	795	77	1	110	11	0
2288	795	13	2	110	11	0
2289	795	67	3	240	24	0
2291	796	47	2	30	3	0
2292	796	25	3	140	14	0
2293	797	61	1	30	3	0
2294	797	46	2	60	6	0
2296	798	38	1	210	21	0
2297	798	33	2	70	7	0
2298	798	61	3	110	11	0
2299	799	26	1	120	12	0
2301	799	18	3	70	7	0
2302	800	38	1	170	17	0
2303	800	48	2	240	24	0
2304	800	77	3	60	6	0
2306	801	43	2	130	13	0
2307	801	74	3	70	7	0
2308	802	51	1	10	1	0
2309	802	39	2	100	10	0
2311	803	11	1	80	8	0
2312	803	32	2	220	22	0
2313	803	25	3	160	16	0
2314	804	19	1	80	8	0
2316	804	46	3	180	18	0
2317	805	68	1	160	16	0
2318	805	57	2	40	4	0
2319	805	9	3	100	10	0
2321	806	42	2	110	11	0
2322	806	80	3	90	9	0
2323	807	62	1	190	19	0
2324	807	31	2	80	8	0
2326	808	56	1	90	9	0
2327	808	10	2	180	18	0
2328	808	42	3	90	9	0
2329	809	43	1	50	5	0
2331	809	46	3	50	5	0
2332	810	11	1	80	8	0
2333	810	18	2	90	9	0
2334	810	51	3	110	11	0
2336	811	74	2	150	15	0
2337	811	53	3	160	16	0
2338	812	31	1	90	9	0
2339	812	77	2	160	16	0
2341	813	56	1	110	11	0
2342	813	13	2	120	12	0
2343	813	12	3	130	13	0
2344	814	39	1	150	15	0
2346	814	33	3	120	12	0
2347	815	26	1	190	19	0
2348	815	9	2	120	12	0
2349	815	10	3	140	14	0
2351	816	80	2	160	16	0
2352	816	32	3	50	5	0
2353	817	25	1	80	8	0
2354	817	68	2	120	12	0
3373	1172	14	1	120	12	0
2358	818	47	3	130	13	0
2359	820	21	1	50	5	0
2360	820	34	2	60	6	0
2361	820	78	3	150	15	0
2363	821	27	2	90	9	0
2364	821	82	3	250	25	0
2365	822	14	1	150	15	0
2366	822	69	2	110	11	0
2368	823	49	1	170	17	0
2369	823	20	2	50	5	0
2370	823	63	3	140	14	0
2371	824	58	1	100	10	0
2373	824	44	3	90	9	0
2374	825	54	1	180	18	0
2375	825	75	2	180	18	0
2376	825	21	3	100	10	0
2378	826	14	2	120	12	0
2379	826	69	3	130	13	0
2380	827	27	1	110	11	0
2381	827	81	2	190	19	0
2383	828	54	1	300	30	0
2384	828	78	2	100	10	0
2385	828	49	3	150	15	0
2386	829	58	1	140	14	0
2388	829	20	3	110	11	0
2389	830	82	1	150	15	0
2390	830	63	2	30	3	0
2391	830	34	3	170	17	0
2393	831	44	2	150	15	0
2394	831	34	3	40	4	0
2395	832	49	1	70	7	0
2396	832	20	2	210	21	0
2398	833	21	1	70	7	0
2399	833	40	2	190	19	0
2400	833	58	3	130	13	0
2401	834	69	1	170	17	0
2403	834	78	3	150	15	0
2404	835	54	1	180	18	0
2405	835	70	2	120	12	0
2406	835	75	3	160	16	0
2408	836	27	2	190	19	0
2409	836	14	3	170	17	0
2410	837	14	1	140	14	0
2411	837	69	2	180	18	0
2413	838	20	1	20	2	0
2414	838	75	2	80	8	0
2415	838	49	3	200	20	0
2416	839	78	1	160	16	0
2418	839	82	3	80	8	0
2419	840	63	1	110	11	0
2420	840	34	2	190	19	0
2421	840	81	3	90	9	0
2423	841	54	2	230	23	0
2424	841	27	3	200	20	0
2425	842	70	1	320	32	0
2426	842	58	2	150	15	0
2428	843	58	1	160	16	0
2429	843	75	2	270	27	0
2430	843	82	3	130	13	0
2431	844	70	1	190	19	0
2433	844	69	3	90	9	0
2434	845	54	1	180	18	0
2435	845	78	2	160	16	0
2436	845	40	3	110	11	0
2438	846	20	2	150	15	0
2439	846	44	3	160	16	0
2440	847	49	1	160	16	0
2441	847	34	2	140	14	0
2443	848	63	1	130	13	0
2444	848	58	2	150	15	0
2445	848	14	3	190	19	0
2446	849	44	1	170	17	0
2448	849	20	3	150	15	0
2449	850	34	1	90	9	0
2450	850	75	2	200	20	0
2451	850	49	3	250	25	0
2453	851	40	2	80	8	0
2454	851	78	3	130	13	0
2455	852	27	1	100	10	0
2456	852	54	2	90	9	0
2458	853	63	1	120	12	0
2459	853	21	2	140	14	0
2460	853	69	3	140	14	0
2461	856	28	1	170	17	0
2463	856	1	3	180	18	0
2464	857	76	1	250	25	0
2465	857	2	2	60	6	0
2466	857	4	3	160	16	0
2468	858	29	2	210	21	0
2469	858	5	3	120	12	0
2470	859	3	1	130	13	0
2471	859	16	2	200	20	0
2473	860	55	1	120	12	0
2474	860	72	2	220	22	0
2475	860	41	3	130	13	0
2476	861	37	1	30	3	0
2478	861	59	3	130	13	0
2479	862	17	1	120	12	0
2480	862	65	2	70	7	0
2481	862	8	3	140	14	0
2483	863	50	2	110	11	0
2484	863	60	3	50	5	0
2485	864	15	1	80	8	0
2486	864	66	2	170	17	0
2488	865	23	1	70	7	0
2489	865	6	2	210	21	0
2490	865	24	3	170	17	0
2491	866	71	1	230	23	0
2493	866	45	3	170	17	0
2494	867	7	1	240	24	0
2495	867	29	2	190	19	0
2496	867	24	3	170	17	0
2498	868	60	2	70	7	0
2499	868	5	3	180	18	0
2500	869	4	1	170	17	0
2501	869	15	2	170	17	0
2503	870	45	1	70	7	0
2504	870	8	2	280	28	0
2505	870	55	3	270	27	0
2506	871	36	1	140	14	0
2508	871	79	3	200	20	0
2509	872	7	1	180	18	0
2510	872	16	2	280	28	0
2511	872	73	3	190	19	0
2515	874	30	1	180	18	0
2516	874	65	2	260	26	0
2517	874	23	3	140	14	0
2518	875	66	1	190	19	0
2520	875	6	3	180	18	0
2521	876	28	1	200	20	0
2522	876	22	2	100	10	0
2523	876	17	3	110	11	0
2525	877	72	2	250	25	0
2526	877	59	3	150	15	0
2527	878	71	1	150	15	0
2528	878	76	2	190	19	0
2530	879	41	1	170	17	0
2531	879	17	2	130	13	0
2532	879	2	3	240	24	0
2533	880	66	1	240	24	0
2535	880	30	3	70	7	0
2536	881	73	1	120	12	0
2537	881	64	2	120	12	0
2538	881	22	3	100	10	0
2540	882	71	2	200	20	0
2541	882	5	3	30	3	0
2542	883	8	1	190	19	0
2543	883	79	2	230	23	0
2545	884	4	1	140	14	0
2546	884	23	2	90	9	0
2547	884	60	3	170	17	0
2548	885	65	1	250	25	0
2550	885	29	3	190	19	0
2551	886	15	1	100	10	0
2552	886	1	2	210	21	0
2553	886	24	3	100	10	0
2555	887	36	2	130	13	0
2556	887	28	3	200	20	0
2557	888	7	1	220	22	0
2558	888	59	2	100	10	0
2560	889	35	1	150	15	0
2561	889	72	2	150	15	0
2562	889	45	3	100	10	0
2563	890	29	1	160	16	0
2565	890	60	3	170	17	0
2566	891	73	1	220	22	0
2567	891	37	2	190	19	0
2568	891	7	3	80	8	0
2570	892	76	2	180	18	0
2571	892	1	3	50	5	0
2572	893	50	1	210	21	0
2573	893	23	2	180	18	0
2575	894	72	1	120	12	0
2576	894	41	2	20	2	0
2577	894	17	3	130	13	0
2578	895	3	1	150	15	0
2580	895	24	3	160	16	0
2581	896	71	1	120	12	0
2582	896	16	2	80	8	0
2583	896	79	3	160	16	0
2585	897	6	2	90	9	0
2586	897	65	3	190	19	0
2587	898	28	1	120	12	0
2588	898	45	2	200	20	0
2590	899	64	1	190	19	0
2591	899	55	2	290	29	0
2592	899	5	3	140	14	0
2593	900	30	1	190	19	0
2595	900	15	3	90	9	0
2596	901	22	1	140	14	0
2597	901	37	2	100	10	0
2598	901	35	3	120	12	0
2600	902	36	2	190	19	0
2601	902	24	3	200	20	0
2602	903	8	1	150	15	0
2603	903	5	2	150	15	0
2605	904	23	1	230	23	0
2606	904	22	2	240	24	0
2607	904	45	3	140	14	0
2608	905	3	1	240	24	0
2610	905	66	3	150	15	0
2611	906	7	1	160	16	0
2612	906	71	2	20	2	0
2613	906	30	3	120	12	0
2615	907	28	2	160	16	0
2616	907	73	3	110	11	0
2617	908	17	1	120	12	0
2618	908	15	2	120	12	0
2620	909	29	1	220	22	0
2621	909	76	2	140	14	0
2622	909	2	3	140	14	0
2623	910	64	1	80	8	0
2625	910	72	3	160	16	0
2626	911	59	1	110	11	0
2627	911	79	2	100	10	0
2628	911	1	3	120	12	0
2630	912	6	2	190	19	0
2631	912	64	3	70	7	0
2632	913	5	1	120	12	0
2633	913	71	2	240	24	0
2635	914	7	1	260	26	0
2636	914	72	2	170	17	0
2637	914	60	3	100	10	0
2638	915	16	1	150	15	0
2640	915	76	3	150	15	0
2641	916	28	1	80	8	0
2642	916	6	2	170	17	0
2643	916	30	3	130	13	0
2645	917	45	2	150	15	0
2646	917	1	3	200	20	0
2647	918	50	1	270	27	0
2648	918	3	2	160	16	0
2650	919	17	1	160	16	0
2651	919	73	2	130	13	0
2652	919	15	3	120	12	0
2653	920	29	1	190	19	0
2655	920	65	3	230	23	0
2656	921	41	1	180	18	0
2657	921	24	2	200	20	0
2658	921	22	3	120	12	0
2660	922	23	2	180	18	0
2661	922	55	3	100	10	0
2662	923	4	1	170	17	0
2663	923	66	2	50	5	0
2665	928	18	1	30	3	0
2666	928	48	2	100	10	0
2667	928	47	3	70	7	0
2668	929	53	1	190	19	0
2789	969	9	2	\N	\N	0
2672	930	43	2	50	5	0
2673	930	31	3	90	9	0
2674	931	10	1	180	18	0
2675	931	9	2	160	16	0
2677	932	11	1	80	8	0
2678	932	56	2	70	7	0
2679	932	80	3	150	15	0
2680	933	32	1	190	19	0
2682	933	57	3	100	10	0
2683	934	68	1	70	7	0
2684	934	25	2	70	7	0
2685	934	33	3	80	8	0
2687	935	61	2	40	4	0
2688	935	38	3	220	22	0
2689	936	19	1	150	15	0
2690	936	67	2	130	13	0
2692	937	42	1	160	16	0
2693	937	74	2	150	15	0
2694	937	77	3	130	13	0
2695	938	13	1	80	8	0
2697	938	26	3	180	18	0
2698	939	11	1	110	11	0
2699	939	10	2	150	15	0
2700	939	18	3	120	12	0
2702	940	61	2	160	16	0
2703	940	51	3	70	7	0
2704	941	33	1	140	14	0
2705	941	46	2	270	27	0
2707	942	43	1	200	20	0
2708	942	67	2	170	17	0
2709	942	47	3	80	8	0
2710	943	31	1	60	6	0
2712	943	62	3	0	0	0
2713	944	56	1	60	6	0
2714	944	39	2	170	17	0
2715	944	38	3	120	12	0
2717	945	9	2	90	9	0
2718	945	32	3	110	11	0
2719	946	52	1	110	11	0
2720	946	77	2	60	6	0
2722	947	48	1	60	6	0
2723	947	25	2	160	16	0
2724	947	74	3	90	9	0
2725	948	13	1	180	18	0
2727	948	56	3	200	20	0
2728	949	68	1	180	18	0
2729	949	77	2	150	15	0
2730	949	18	3	40	4	0
2732	950	48	2	140	14	0
2733	950	10	3	230	23	0
2734	951	80	1	10	1	0
2735	951	13	2	180	18	0
2737	952	42	1	150	15	0
2738	952	31	2	200	20	0
2739	952	25	3	70	7	0
2740	953	46	1	90	9	0
2742	953	57	3	80	8	0
2743	954	67	1	250	25	0
2744	954	19	2	120	12	0
2745	954	11	3	50	5	0
2747	955	26	2	190	19	0
2748	955	38	3	120	12	0
2749	956	74	1	80	8	0
2750	956	53	2	130	13	0
2752	957	62	1	110	11	0
2753	957	39	2	80	8	0
2754	957	33	3	230	23	0
2755	958	9	1	40	4	0
2757	958	52	3	210	21	0
2758	959	42	1	90	9	0
2759	959	10	2	120	12	0
2760	959	57	3	140	14	0
2762	960	43	2	220	22	0
2763	960	77	3	190	19	0
2764	961	12	1	200	20	0
2765	961	62	2	140	14	0
2767	962	38	1	130	13	0
2768	962	31	2	150	15	0
2769	962	47	3	90	9	0
2770	963	46	1	200	20	0
2772	963	53	3	190	19	0
2773	964	80	1	120	12	0
2774	964	51	2	160	16	0
2775	964	19	3	80	8	0
2777	965	74	2	130	13	0
2778	965	33	3	130	13	0
2779	966	26	1	170	17	0
2780	966	48	2	200	20	0
2782	967	56	1	100	10	0
2783	967	68	2	140	14	0
2784	967	25	3	160	16	0
2785	968	39	1	120	12	0
2787	968	67	3	80	8	0
2788	969	9	1	90	9	0
2790	969	18	3	70	7	0
2791	970	68	1	70	7	0
2793	970	38	3	80	8	0
2794	971	48	1	140	14	0
2795	971	26	2	110	11	0
2796	971	39	3	50	5	0
2798	972	47	2	70	7	0
2799	972	51	3	60	6	0
2800	973	42	1	160	16	0
2801	973	62	2	120	12	0
2803	974	46	1	200	20	0
2804	974	53	2	110	11	0
2805	974	12	3	150	15	0
2806	975	74	1	140	14	0
2808	975	77	3	120	12	0
2809	976	43	1	190	19	0
2810	976	56	2	110	11	0
2811	976	25	3	120	12	0
2813	977	57	2	120	12	0
2814	977	80	3	90	9	0
2815	978	31	1	140	14	0
2816	978	19	2	190	19	0
2818	979	67	1	150	15	0
2819	979	13	2	170	17	0
2820	979	11	3	80	8	0
2821	980	33	1	250	25	0
2823	980	51	3	90	9	0
2824	981	12	1	120	12	0
2825	981	67	2	170	17	0
2826	981	39	3	60	6	0
2885	1002	49	2	\N	\N	0
2829	982	31	3	120	12	0
2830	983	32	1	190	19	0
2831	983	74	2	70	7	0
2832	983	25	3	90	9	0
2834	984	42	2	80	8	0
2835	984	61	3	130	13	0
2836	985	68	1	130	13	0
2837	985	57	2	180	18	0
2839	986	46	1	180	18	0
2840	986	80	2	140	14	0
2841	986	48	3	130	13	0
2842	987	13	1	90	9	0
2844	987	10	3	160	16	0
2845	988	19	1	70	7	0
2846	988	38	2	100	10	0
2847	988	18	3	120	12	0
2849	989	26	2	110	11	0
2850	989	53	3	110	11	0
2851	991	58	1	210	21	0
2852	991	54	2	60	6	0
2854	992	40	1	170	17	0
2855	992	75	2	50	5	0
2856	992	27	3	150	15	0
2857	993	63	1	90	9	0
2859	993	21	3	150	15	0
2860	994	14	1	30	3	0
2861	994	70	2	170	17	0
2862	994	44	3	190	19	0
2864	995	49	2	130	13	0
2865	995	20	3	150	15	0
2866	996	81	1	120	12	0
2867	996	78	2	100	10	0
2869	997	14	1	130	13	0
2870	997	63	2	160	16	0
2871	997	20	3	100	10	0
2872	998	58	1	180	18	0
2874	998	34	3	170	17	0
2875	999	75	1	110	11	0
2876	999	27	2	140	14	0
2877	999	44	3	60	6	0
2879	1000	78	2	140	14	0
2880	1000	69	3	210	21	0
2881	1001	81	1	110	11	0
2882	1001	82	2	210	21	0
2884	1002	49	1	160	16	0
2886	1002	34	3	290	29	0
2887	1003	70	1	250	25	0
2888	1003	81	2	140	14	0
2890	1004	21	1	160	16	0
2891	1004	69	2	270	27	0
2892	1004	40	3	170	17	0
2893	1005	58	1	70	7	0
2895	1005	78	3	110	11	0
2896	1006	63	1	150	15	0
2897	1006	54	2	220	22	0
2898	1006	27	3	140	14	0
2900	1007	82	2	90	9	0
2901	1007	44	3	200	20	0
2902	1008	70	1	80	8	0
2903	1008	40	2	100	10	0
2905	1009	20	1	220	22	0
2906	1009	58	2	140	14	0
2907	1009	63	3	140	14	0
2908	1010	69	1	100	10	0
2910	1010	78	3	100	10	0
2911	1011	81	1	160	16	0
2912	1011	54	2	180	18	0
2913	1011	82	3	240	24	0
2915	1012	21	2	110	11	0
2916	1012	49	3	150	15	0
2917	1013	14	1	180	18	0
2918	1013	44	2	80	8	0
2920	1014	70	1	200	20	0
2921	1014	63	2	110	11	0
2922	1014	69	3	80	8	0
2923	1015	20	1	120	12	0
2925	1015	49	3	130	13	0
2926	1016	21	1	150	15	0
2927	1016	54	2	230	23	0
2928	1016	78	3	170	17	0
2930	1017	58	2	190	19	0
2931	1017	75	3	10	1	0
2932	1018	40	1	220	22	0
2933	1018	27	2	160	16	0
2935	1019	44	1	120	12	0
2936	1019	34	2	160	16	0
2937	1019	78	3	130	13	0
2938	1020	70	1	140	14	0
2940	1020	44	3	210	21	0
2941	1021	63	1	180	18	0
2942	1021	54	2	130	13	0
2943	1021	58	3	130	13	0
2945	1022	49	2	90	9	0
2946	1022	21	3	140	14	0
2947	1023	14	1	130	13	0
2948	1023	27	2	140	14	0
2950	1024	82	1	210	21	0
2951	1024	81	2	130	13	0
2952	1024	69	3	200	20	0
2953	1027	17	1	110	11	0
2955	1027	4	3	140	14	0
2956	1028	1	1	220	22	0
2957	1028	64	2	230	23	0
2958	1028	15	3	50	5	0
2960	1029	7	2	100	10	0
2961	1029	8	3	270	27	0
2962	1030	30	1	60	6	0
2963	1030	50	2	270	27	0
2965	1031	2	1	140	14	0
2966	1031	35	2	180	18	0
2967	1031	66	3	240	24	0
2968	1032	36	1	210	21	0
2970	1032	65	3	130	13	0
2971	1033	28	1	240	24	0
2972	1033	41	2	180	18	0
2973	1033	76	3	120	12	0
2975	1034	16	2	200	20	0
2976	1034	37	3	250	25	0
2977	1035	3	1	200	20	0
2978	1035	45	2	220	22	0
2980	1036	60	1	110	11	0
2981	1036	29	2	120	12	0
2982	1036	71	3	100	10	0
2983	1037	22	1	160	16	0
3378	1173	82	3	240	24	0
2986	1038	23	1	100	10	0
2987	1038	22	2	160	16	0
2988	1038	73	3	130	13	0
2989	1039	5	1	70	7	0
2991	1039	55	3	140	14	0
2992	1040	65	1	110	11	0
2993	1040	23	2	140	14	0
2994	1040	4	3	100	10	0
2996	1041	6	2	130	13	0
2997	1041	37	3	110	11	0
2998	1042	60	1	130	13	0
2999	1042	66	2	280	28	0
3001	1043	8	1	120	12	0
3002	1043	29	2	120	12	0
3003	1043	64	3	20	2	0
3004	1044	1	1	130	13	0
3006	1044	30	3	160	16	0
3007	1045	72	1	190	19	0
3008	1045	3	2	170	17	0
3009	1045	45	3	200	20	0
3011	1046	36	2	40	4	0
3012	1046	28	3	180	18	0
3013	1047	59	1	120	12	0
3014	1047	76	2	190	19	0
3016	1048	2	1	90	9	0
3017	1048	41	2	140	14	0
3018	1048	79	3	160	16	0
3019	1049	24	1	140	14	0
3021	1049	16	3	90	9	0
3022	1050	28	1	170	17	0
3023	1050	35	2	160	16	0
3024	1050	22	3	120	12	0
3026	1051	7	2	190	19	0
3027	1051	3	3	240	24	0
3028	1052	24	1	150	15	0
3029	1052	66	2	170	17	0
3031	1053	30	1	90	9	0
3032	1053	6	2	170	17	0
3033	1053	65	3	70	7	0
3034	1054	50	1	140	14	0
3036	1054	41	3	220	22	0
3037	1055	71	1	160	16	0
3038	1055	29	2	260	26	0
3039	1055	8	3	160	16	0
3041	1056	36	2	160	16	0
3042	1056	76	3	240	24	0
3043	1057	5	1	150	15	0
3044	1057	15	2	180	18	0
3046	1058	45	1	230	23	0
3047	1058	64	2	180	18	0
3048	1058	55	3	190	19	0
3049	1059	37	1	150	15	0
3051	1059	79	3	90	9	0
3052	1060	23	1	180	18	0
3053	1060	17	2	130	13	0
3054	1060	60	3	100	10	0
3056	1061	73	2	150	15	0
3057	1061	5	3	140	14	0
3058	1062	37	1	150	15	0
3059	1062	17	2	90	9	0
3061	1063	79	1	210	21	0
3062	1063	65	2	190	19	0
3063	1063	66	3	110	11	0
3064	1064	4	1	100	10	0
3066	1064	64	3	170	17	0
3067	1065	72	1	110	11	0
3068	1065	22	2	150	15	0
3069	1065	2	3	90	9	0
3071	1066	41	2	170	17	0
3072	1066	23	3	60	6	0
3073	1067	50	1	90	9	0
3074	1067	55	2	190	19	0
3076	1068	6	1	70	7	0
3077	1068	36	2	210	21	0
3078	1068	7	3	190	19	0
3079	1069	30	1	180	18	0
3081	1069	59	3	130	13	0
3082	1070	8	1	50	5	0
3083	1070	60	2	200	20	0
3084	1070	3	3	240	24	0
3086	1071	71	2	140	14	0
3087	1071	16	3	80	8	0
3088	1072	76	1	50	5	0
3089	1072	60	2	50	5	0
3091	1073	79	1	100	10	0
3092	1073	23	2	150	15	0
3093	1073	36	3	60	6	0
3094	1074	30	1	80	8	0
3096	1074	15	3	80	8	0
3097	1075	41	1	70	7	0
3098	1075	64	2	200	20	0
3099	1075	3	3	190	19	0
3101	1076	45	2	170	17	0
3102	1076	28	3	160	16	0
3103	1077	55	1	110	11	0
3104	1077	73	2	260	26	0
3106	1078	72	1	100	10	0
3107	1078	50	2	240	24	0
3108	1078	6	3	210	21	0
3109	1079	35	1	110	11	0
3111	1079	7	3	150	15	0
3112	1080	5	1	120	12	0
3113	1080	59	2	280	28	0
3114	1080	8	3	240	24	0
3116	1081	66	2	100	10	0
3117	1081	1	3	50	5	0
3118	1082	71	1	120	12	0
3119	1082	22	2	180	18	0
3121	1083	76	1	70	7	0
3122	1083	29	2	190	19	0
3123	1083	23	3	180	18	0
3124	1084	29	1	230	23	0
3126	1084	66	3	160	16	0
3127	1085	16	1	150	15	0
3128	1085	72	2	260	26	0
3129	1085	65	3	200	20	0
3131	1086	73	2	140	14	0
3132	1086	37	3	60	6	0
3133	1087	3	1	320	32	0
3134	1087	24	2	210	21	0
3136	1088	15	1	140	14	0
3137	1088	30	2	160	16	0
3138	1088	1	3	190	19	0
3139	1089	59	1	80	8	0
3143	1090	22	2	280	28	0
3144	1090	7	3	220	22	0
3145	1091	60	1	170	17	0
3146	1091	2	2	150	15	0
3148	1092	35	1	110	11	0
3149	1092	41	2	120	12	0
3150	1092	64	3	230	23	0
3151	1093	71	1	190	19	0
3153	1093	36	3	170	17	0
3154	1094	17	1	70	7	0
3155	1094	4	2	90	9	0
3156	1094	8	3	140	14	0
3158	1099	9	2	40	4	0
3159	1099	56	3	100	10	0
3160	1100	18	1	120	12	0
3161	1100	52	2	120	12	0
3163	1101	32	1	80	8	0
3164	1101	25	2	60	6	0
3165	1101	61	3	140	14	0
3166	1102	10	1	150	15	0
3168	1102	67	3	0	0	0
3169	1103	39	1	30	3	0
3170	1103	11	2	100	10	0
3171	1103	19	3	170	17	0
3173	1104	74	2	120	12	0
3174	1104	62	3	140	14	0
3175	1105	57	1	50	5	0
3176	1105	51	2	20	2	0
3178	1106	53	1	120	12	0
3179	1106	12	2	190	19	0
3180	1106	77	3	70	7	0
3181	1107	31	1	190	19	0
3183	1107	46	3	130	13	0
3184	1108	38	1	140	14	0
3185	1108	80	2	170	17	0
3186	1108	26	3	190	19	0
3188	1109	43	2	180	18	0
3189	1109	47	3	160	16	0
3190	1110	11	1	20	2	0
3191	1110	25	2	100	10	0
3193	1111	77	1	220	22	0
3194	1111	80	2	160	16	0
3195	1111	68	3	80	8	0
3196	1112	42	1	100	10	0
3198	1112	52	3	250	25	0
3199	1113	19	1	100	10	0
3200	1113	18	2	100	10	0
3201	1113	38	3	150	15	0
3203	1114	57	2	90	9	0
3204	1114	61	3	110	11	0
3205	1115	67	1	100	10	0
3206	1115	12	2	90	9	0
3208	1116	56	1	40	4	0
3209	1116	48	2	130	13	0
3210	1116	53	3	80	8	0
3211	1117	10	1	200	20	0
3213	1117	9	3	160	16	0
3214	1118	74	1	180	18	0
3215	1118	26	2	140	14	0
3216	1118	13	3	250	25	0
3218	1119	51	2	170	17	0
3219	1119	11	3	110	11	0
3220	1120	46	1	140	14	0
3221	1120	18	2	140	14	0
3223	1121	13	1	140	14	0
3224	1121	53	2	100	10	0
3225	1121	74	3	50	5	0
3226	1122	57	1	140	14	0
3228	1122	33	3	180	18	0
3229	1123	43	1	150	15	0
3230	1123	56	2	120	12	0
3231	1123	68	3	100	10	0
3233	1124	10	2	170	17	0
3234	1124	25	3	100	10	0
3235	1125	77	1	170	17	0
3236	1125	48	2	160	16	0
3238	1126	19	1	160	16	0
3239	1126	31	2	140	14	0
3240	1126	9	3	130	13	0
3241	1127	67	1	70	7	0
3243	1127	39	3	30	3	0
3244	1128	80	1	100	10	0
3245	1128	62	2	20	2	0
3246	1128	42	3	150	15	0
3248	1129	32	2	260	26	0
3249	1129	12	3	20	2	0
3250	1130	67	1	70	7	0
3251	1130	47	2	70	7	0
3253	1131	10	1	160	16	0
3254	1131	26	2	140	14	0
3255	1131	74	3	50	5	0
3256	1132	33	1	180	18	0
3258	1132	18	3	140	14	0
3259	1133	56	1	120	12	0
3260	1133	38	2	230	23	0
3261	1133	19	3	90	9	0
3263	1134	25	2	130	13	0
3264	1134	48	3	110	11	0
3265	1135	68	1	190	19	0
3266	1135	31	2	60	6	0
3268	1136	62	1	210	21	0
3269	1136	52	2	140	14	0
3270	1136	9	3	100	10	0
3271	1137	77	1	160	16	0
3273	1137	46	3	110	11	0
3274	1138	53	1	60	6	0
3275	1138	13	2	140	14	0
3276	1138	51	3	120	12	0
3278	1139	39	2	140	14	0
3279	1139	80	3	210	21	0
3280	1140	12	1	50	5	0
3281	1140	13	2	170	17	0
3283	1141	12	1	160	16	0
3284	1141	10	2	130	13	0
3285	1141	67	3	80	8	0
3286	1142	43	1	160	16	0
3288	1142	26	3	120	12	0
3289	1143	9	1	80	8	0
3290	1143	46	2	130	13	0
3291	1143	19	3	180	18	0
3293	1144	11	2	70	7	0
3294	1144	18	3	70	7	0
3295	1145	77	1	170	17	0
3296	1145	42	2	40	4	0
3383	1175	70	2	120	12	0
3337	1159	47	1	130	13	0
3338	1159	46	2	300	30	0
3339	1159	11	3	120	12	0
3340	1160	61	1	140	14	0
3341	1160	32	2	90	9	0
3342	1160	13	3	170	17	0
3343	1162	54	1	160	16	0
3428	1190	78	2	\N	\N	0
1	1	65	1	270	27	0
2	1	41	2	110	11	0
7	3	66	1	260	26	0
12	4	29	3	200	20	0
17	6	71	2	260	26	0
22	8	45	1	180	18	0
27	9	8	3	170	17	0
3344	1162	70	2	210	21	0
3345	1162	49	3	100	10	0
3298	1146	68	1	110	11	0
3299	1146	61	2	70	7	0
3301	1147	56	1	150	15	0
3302	1147	57	2	30	3	0
3303	1147	25	3	150	15	0
3304	1148	51	1	150	15	0
3306	1148	47	3	120	12	0
3307	1149	80	1	260	26	0
3308	1149	39	2	10	1	0
3309	1149	33	3	90	9	0
3311	1150	32	2	100	10	0
3312	1150	25	3	130	13	0
3313	1151	52	1	160	16	0
3314	1151	77	2	190	19	0
3316	1152	33	1	130	13	0
3317	1152	9	2	120	12	0
3318	1152	39	3	50	5	0
3319	1153	51	1	90	9	0
3321	1153	62	3	150	15	0
3322	1154	18	1	50	5	0
3323	1154	57	2	150	15	0
3324	1154	68	3	150	15	0
3326	1155	48	2	190	19	0
3327	1155	10	3	160	16	0
3328	1156	53	1	100	10	0
3329	1156	74	2	20	2	0
3331	1157	19	1	120	12	0
3332	1157	42	2	160	16	0
3333	1157	31	3	120	12	0
3334	1158	80	1	110	11	0
3346	1163	78	1	240	24	0
3347	1163	20	2	120	12	0
3349	1164	75	1	60	6	0
3350	1164	27	2	160	16	0
3351	1164	63	3	190	19	0
3352	1165	44	1	120	12	0
3354	1165	34	3	250	25	0
3355	1166	81	1	160	16	0
3356	1166	58	2	80	8	0
3357	1166	21	3	60	6	0
3359	1167	69	2	160	16	0
3360	1167	34	3	150	15	0
3361	1168	21	1	60	6	0
3362	1168	63	2	180	18	0
3364	1169	82	1	110	11	0
3365	1169	69	2	230	23	0
3366	1169	40	3	140	14	0
3367	1170	20	1	100	10	0
3369	1170	75	3	140	14	0
3370	1171	27	1	120	12	0
3371	1171	49	2	180	18	0
3372	1171	70	3	280	28	0
3374	1172	78	2	100	10	0
3375	1172	44	3	170	17	0
3376	1173	54	1	190	19	0
3377	1173	27	2	140	14	0
3379	1174	21	1	90	9	0
3380	1174	49	2	260	26	0
3381	1174	78	3	140	14	0
3382	1175	63	1	170	17	0
3385	1176	14	1	50	5	0
3386	1176	34	2	110	11	0
3387	1176	54	3	220	22	0
3389	1177	69	2	210	21	0
3390	1177	75	3	120	12	0
3391	1178	20	1	80	8	0
3392	1178	40	2	120	12	0
3394	1179	27	1	180	18	0
3395	1179	58	2	160	16	0
3396	1179	14	3	100	10	0
3397	1180	40	1	140	14	0
3399	1180	54	3	120	12	0
3400	1181	21	1	130	13	0
3401	1181	75	2	100	10	0
3402	1181	49	3	140	14	0
3404	1182	20	2	120	12	0
3405	1182	63	3	80	8	0
3406	1183	81	1	30	3	0
3407	1183	82	2	220	22	0
3409	1184	34	1	110	11	0
3410	1184	44	2	110	11	0
3411	1184	81	3	110	11	0
3412	1185	69	1	160	16	0
3414	1185	27	3	150	15	0
3415	1186	34	1	40	4	0
3416	1186	14	2	140	14	0
3417	1186	21	3	230	23	0
3419	1187	40	2	150	15	0
3420	1187	54	3	220	22	0
3421	1188	82	1	130	13	0
3422	1188	20	2	10	1	0
3424	1189	63	1	30	3	0
3425	1189	44	2	110	11	0
3426	1189	49	3	150	15	0
3429	1190	81	3	120	12	0
3430	1191	27	1	240	24	0
3431	1191	49	2	250	25	0
3432	1191	69	3	50	5	0
3433	1192	21	1	180	18	0
3435	1192	82	3	180	18	0
3436	1193	20	1	90	9	0
3437	1193	70	2	90	9	0
3438	1193	34	3	220	22	0
3440	1194	63	2	150	15	0
3441	1194	54	3	190	19	0
3442	1195	44	1	180	18	0
3443	1195	14	2	120	12	0
32	11	28	2	110	11	0
37	13	6	1	170	17	0
42	14	15	3	140	14	0
47	16	3	2	180	18	0
52	18	59	1	210	21	0
57	19	8	3	250	25	0
62	21	55	2	150	15	0
67	23	4	1	90	9	0
72	24	76	3	120	12	0
77	26	71	2	230	23	0
82	28	5	1	110	11	0
87	29	22	3	160	16	0
92	31	41	2	100	10	0
97	33	24	1	80	8	0
102	34	4	3	170	17	0
107	36	66	2	120	12	0
112	38	16	1	180	18	0
117	39	41	3	90	9	0
122	41	29	2	190	19	0
127	43	23	1	90	9	0
132	44	76	3	230	23	0
137	46	16	2	180	18	0
142	48	15	1	170	17	0
147	49	1	3	150	15	0
152	51	29	2	210	21	0
157	53	79	1	170	17	0
158	53	36	2	250	25	0
159	53	45	3	170	17	0
164	55	60	2	110	11	0
169	57	50	1	210	21	0
174	58	24	3	190	19	0
179	60	65	2	130	13	0
184	62	16	1	180	18	0
189	63	59	3	130	13	0
194	65	64	2	220	22	0
199	67	23	1	170	17	0
204	68	76	3	150	15	0
209	74	11	2	90	9	0
214	76	26	1	50	5	0
219	77	80	3	170	17	0
224	79	57	2	160	16	0
229	81	18	1	30	3	0
234	82	38	3	120	12	0
239	84	77	2	70	7	0
244	86	62	1	160	16	0
249	87	42	3	120	12	0
254	89	13	2	140	14	0
259	91	46	1	160	16	0
264	92	38	3	210	21	0
269	94	31	2	220	22	0
274	96	43	1	100	10	0
279	97	18	3	70	7	0
284	99	46	2	90	9	0
289	101	11	1	90	9	0
294	102	80	3	70	7	0
299	104	47	2	140	14	0
304	106	52	1	250	25	0
309	107	25	3	120	12	0
314	109	12	2	40	4	0
315	109	32	3	190	19	0
316	110	53	1	60	6	0
321	111	39	3	120	12	0
326	113	68	2	120	12	0
331	115	42	1	30	3	0
336	116	38	3	140	14	0
341	118	61	2	110	11	0
346	120	18	1	110	11	0
351	121	68	3	160	16	0
356	123	80	2	90	9	0
361	125	42	1	60	6	0
366	126	46	3	120	12	0
371	128	32	2	160	16	0
376	130	18	1	120	12	0
381	131	9	3	100	10	0
386	133	77	2	160	16	0
391	136	81	1	160	16	0
396	137	34	3	160	16	0
400	139	78	1	100	10	0
406	141	21	1	120	12	0
411	142	70	3	100	10	0
416	144	27	2	140	14	0
421	146	81	1	140	14	0
424	147	58	1	140	14	0
432	149	34	3	190	19	0
437	151	81	2	200	20	0
442	153	78	1	120	12	0
447	154	20	3	260	26	0
452	156	49	2	170	17	0
457	158	44	1	60	6	0
462	159	21	3	90	9	0
467	161	70	2	150	15	0
472	163	34	1	260	26	0
473	163	44	2	110	11	0
478	165	27	1	240	24	0
483	166	14	3	40	4	0
488	168	58	2	60	6	0
493	172	2	1	160	16	0
498	173	59	3	130	13	0
503	175	60	2	130	13	0
508	177	24	1	210	21	0
513	178	36	3	120	12	0
518	180	16	2	170	17	0
523	182	41	1	190	19	0
528	183	15	3	220	22	0
533	185	28	2	100	10	0
538	187	71	1	180	18	0
543	188	23	3	250	25	0
548	190	29	2	220	22	0
553	192	72	1	100	10	0
558	193	30	3	140	14	0
563	195	73	2	220	22	0
568	197	59	1	130	13	0
573	198	3	3	320	32	0
578	200	36	2	180	18	0
583	202	24	1	190	19	0
588	203	28	3	130	13	0
593	205	35	2	120	12	0
598	207	6	1	80	8	0
603	208	37	3	160	16	0
608	210	4	2	210	21	0
613	212	1	1	160	16	0
618	213	36	3	80	8	0
623	215	72	2	70	7	0
628	217	5	1	150	15	0
629	217	65	2	160	16	0
630	217	45	3	130	13	0
635	219	6	2	10	1	0
640	221	41	1	160	16	0
645	222	64	3	110	11	0
650	224	35	2	180	18	0
655	226	23	1	140	14	0
660	227	24	3	170	17	0
665	229	24	2	70	7	0
670	231	45	1	130	13	0
675	232	59	3	360	36	0
680	234	37	2	120	12	0
685	236	28	1	140	14	0
690	237	35	3	190	19	0
695	239	6	2	130	13	0
700	245	80	1	200	20	0
705	246	38	3	60	6	0
710	248	52	2	190	19	0
715	250	10	1	260	26	0
720	251	26	3	180	18	0
725	253	74	2	210	21	0
730	255	25	1	180	18	0
735	256	53	3	160	16	0
740	258	62	2	140	14	0
745	260	39	1	110	11	0
750	261	31	3	130	13	0
755	263	9	2	170	17	0
760	265	46	1	140	14	0
765	266	43	3	110	11	0
770	268	56	2	100	10	0
775	270	80	1	100	10	0
780	271	33	3	160	16	0
785	273	61	2	100	10	0
786	273	52	3	200	20	0
787	274	25	1	150	15	0
792	275	80	3	190	19	0
797	277	38	2	150	15	0
802	279	77	1	140	14	0
807	280	48	3	160	16	0
812	282	25	2	100	10	0
817	284	33	1	230	23	0
822	285	19	3	80	8	0
827	287	32	2	30	3	0
832	289	80	1	120	12	0
837	290	57	3	120	12	0
842	292	42	2	100	10	0
847	294	12	1	150	15	0
852	295	61	3	150	15	0
857	297	26	2	210	21	0
862	299	18	1	110	11	0
867	300	12	3	140	14	0
872	302	33	2	120	12	0
877	304	39	1	90	9	0
882	305	42	3	120	12	0
887	308	75	2	130	13	0
892	310	49	1	260	26	0
897	311	69	3	130	13	0
903	313	78	3	150	15	0
908	315	82	2	100	10	0
913	317	75	1	140	14	0
918	318	70	3	160	16	0
923	320	58	2	100	10	0
928	322	14	1	160	16	0
933	323	81	3	170	17	0
938	325	14	2	150	15	0
943	327	63	1	110	11	0
944	327	75	2	120	12	0
949	329	69	1	250	25	0
954	330	81	3	130	13	0
959	332	49	2	270	27	0
964	334	69	1	120	12	0
967	335	78	1	210	21	0
975	337	21	3	160	16	0
980	339	81	2	50	5	0
985	343	5	1	80	8	0
990	344	73	3	140	14	0
995	346	24	2	110	11	0
1000	348	65	1	270	27	0
1005	349	41	3	110	11	0
1010	351	17	2	140	14	0
1015	353	16	1	170	17	0
1020	354	8	3	190	19	0
1025	356	2	2	80	8	0
1030	358	64	1	110	11	0
1035	359	72	3	170	17	0
1040	361	73	2	180	18	0
1045	363	7	1	160	16	0
1050	364	6	3	70	7	0
1055	366	65	2	120	12	0
1060	368	30	1	30	3	0
1065	369	4	3	240	24	0
1070	371	55	2	180	18	0
1075	373	1	1	170	17	0
1080	374	37	3	160	16	0
1085	376	35	2	130	13	0
1090	378	45	1	160	16	0
1095	379	60	3	190	19	0
1100	381	59	2	180	18	0
1101	381	65	3	180	18	0
1106	383	8	2	210	21	0
1111	385	4	1	180	18	0
1116	386	7	3	120	12	0
1121	388	8	2	140	14	0
1126	390	66	1	180	18	0
1131	391	65	3	150	15	0
1136	393	22	2	170	17	0
1141	395	30	1	200	20	0
1146	396	59	3	150	15	0
1151	398	41	2	120	12	0
1156	400	66	1	150	15	0
1161	401	30	3	190	19	0
1166	403	59	2	340	34	0
1171	405	16	1	120	12	0
1176	406	45	3	160	16	0
1181	408	5	2	100	10	0
1186	410	55	1	170	17	0
1191	415	52	3	150	15	0
1196	417	13	2	180	18	0
1201	419	77	1	90	9	0
1206	420	26	3	160	16	0
1211	422	74	2	110	11	0
1216	424	10	1	230	23	0
1221	425	68	3	200	20	0
1226	427	48	2	150	15	0
1231	429	62	1	100	10	0
1236	430	77	3	150	15	0
1241	432	39	2	100	10	0
1246	434	52	1	250	25	0
1251	435	9	3	160	16	0
1256	437	32	2	110	11	0
1257	437	53	3	190	19	0
1258	438	18	1	160	16	0
1263	439	56	3	90	9	0
1268	441	12	2	150	15	0
1273	443	11	1	110	11	0
1278	444	26	3	120	12	0
1283	446	38	2	200	20	0
1288	448	77	1	140	14	0
1293	449	52	3	160	16	0
1298	451	18	2	130	13	0
1303	453	32	1	130	13	0
1308	454	43	3	170	17	0
1313	456	61	2	130	13	0
1318	458	11	1	100	10	0
1323	459	68	3	190	19	0
1328	461	47	2	50	5	0
1333	463	18	1	90	9	0
1338	464	31	3	170	17	0
1343	466	74	2	100	10	0
1348	468	18	1	100	10	0
1353	469	68	3	120	12	0
1358	471	38	2	180	18	0
1363	473	46	1	200	20	0
1368	474	42	3	120	12	0
1373	476	10	2	140	14	0
1378	479	14	1	140	14	0
1383	480	78	3	60	6	0
1388	482	21	2	180	18	0
1393	484	82	1	170	17	0
1398	485	20	3	80	8	0
1403	487	78	2	130	13	0
1408	489	63	1	150	15	0
1413	490	75	3	100	10	0
1414	491	21	1	140	14	0
1415	491	27	2	10	1	0
1420	493	63	1	170	17	0
1425	494	34	3	110	11	0
1430	496	40	2	120	12	0
1435	498	20	1	100	10	0
1440	499	14	3	140	14	0
1445	501	81	2	120	12	0
1450	503	49	1	250	25	0
1455	504	70	3	160	16	0
1460	506	58	2	80	8	0
1465	508	49	1	170	17	0
1470	509	63	3	120	12	0
1475	511	34	2	230	23	0
1480	515	37	1	150	15	0
1485	516	76	3	90	9	0
1490	518	72	2	230	23	0
1495	520	8	1	190	19	0
1500	521	22	3	200	20	0
1505	523	55	2	190	19	0
1510	525	71	1	160	16	0
1515	526	71	3	170	17	0
1520	528	73	2	170	17	0
1525	530	4	1	270	27	0
1530	531	55	3	210	21	0
1535	533	3	2	150	15	0
1540	535	5	1	100	10	0
1545	536	30	3	130	13	0
1550	538	79	2	150	15	0
1555	540	7	1	160	16	0
1560	541	45	3	190	19	0
1565	543	23	2	130	13	0
1570	545	24	1	240	24	0
1571	545	55	2	160	16	0
1572	545	6	3	110	11	0
1577	547	5	2	120	12	0
1582	549	41	1	160	16	0
1587	550	73	3	100	10	0
1592	552	8	2	130	13	0
1597	554	24	1	130	13	0
1602	555	23	3	180	18	0
1607	557	79	2	150	15	0
1612	559	65	1	170	17	0
1617	560	7	3	220	22	0
1622	562	16	2	170	17	0
1627	564	76	1	130	13	0
1632	565	45	3	150	15	0
1637	567	29	2	120	12	0
1642	569	6	1	130	13	0
1647	570	8	3	240	24	0
1652	572	37	2	180	18	0
1657	574	65	1	180	18	0
1662	575	28	3	110	11	0
1667	577	64	2	180	18	0
1672	579	29	1	140	14	0
1677	580	76	3	250	25	0
1682	586	80	2	200	20	0
1687	588	43	1	80	8	0
1692	589	26	3	150	15	0
1697	591	46	2	230	23	0
1702	593	62	1	70	7	0
1707	594	51	3	60	6	0
1712	596	51	2	100	10	0
1717	598	42	1	150	15	0
1722	599	9	3	70	7	0
1727	601	47	2	110	11	0
1728	601	56	3	110	11	0
1729	602	12	1	110	11	0
1734	603	61	3	40	4	0
1739	605	33	2	100	10	0
1744	607	57	1	20	2	0
1749	608	68	3	40	4	0
1754	610	32	2	80	8	0
1759	612	19	1	230	23	0
1764	613	10	3	130	13	0
1769	615	80	2	140	14	0
1774	617	56	1	110	11	0
1779	618	11	3	80	8	0
1784	620	68	2	100	10	0
1789	622	33	1	180	18	0
1794	623	38	3	120	12	0
1799	625	74	2	190	19	0
1804	627	62	1	80	8	0
1809	628	43	3	100	10	0
1814	630	48	2	130	13	0
1819	632	52	1	160	16	0
1824	633	67	3	160	16	0
1829	635	62	2	140	14	0
1834	637	12	1	110	11	0
1839	638	11	3	80	8	0
1844	640	42	2	100	10	0
1849	642	26	1	110	11	0
1854	643	13	3	70	7	0
1859	645	19	2	100	10	0
1864	647	56	1	150	15	0
1869	649	58	3	170	17	0
1874	651	78	2	130	13	0
1879	653	70	1	140	14	0
1882	654	21	1	70	7	0
1885	655	70	1	190	19	0
1886	655	44	2	50	5	0
1891	657	69	1	90	9	0
1896	658	14	3	120	12	0
1901	660	44	2	40	4	0
1906	662	21	1	100	10	0
1911	663	20	3	130	13	0
1916	665	34	2	110	11	0
1921	667	34	1	250	25	0
1926	668	75	3	110	11	0
1931	670	14	2	140	14	0
1936	672	27	1	80	8	0
1941	673	82	3	90	9	0
1946	675	40	2	180	18	0
1951	677	54	1	160	16	0
1956	678	78	3	80	8	0
1961	680	75	2	110	11	0
1966	682	40	1	110	11	0
1971	685	35	3	70	7	0
1976	687	41	2	120	12	0
1981	689	72	1	110	11	0
1986	690	71	3	150	15	0
1991	692	8	2	120	12	0
1996	694	64	1	180	18	0
2001	695	6	3	160	16	0
2006	697	37	2	100	10	0
2011	699	1	1	90	9	0
2016	700	24	3	200	20	0
2021	702	5	2	220	22	0
2026	704	55	1	240	24	0
2031	705	45	3	240	24	0
2032	706	59	1	120	12	0
2041	709	50	1	90	9	0
2042	709	6	2	190	19	0
2043	709	37	3	110	11	0
2048	711	2	2	170	17	0
2053	713	17	1	130	13	0
2058	714	5	3	60	6	0
2063	716	7	2	280	28	0
2068	718	64	1	120	12	0
2073	719	66	3	180	18	0
2078	721	5	2	170	17	0
2083	723	23	1	140	14	0
2088	724	1	3	50	5	0
2093	726	50	2	200	20	0
2098	728	72	1	130	13	0
2103	729	76	3	210	21	0
2108	731	2	2	140	14	0
2113	733	30	1	190	19	0
2118	734	35	3	0	0	0
2123	736	71	2	180	18	0
2128	738	50	1	180	18	0
2133	739	5	3	150	15	0
2138	741	41	2	200	20	0
2143	743	4	1	160	16	0
2148	744	76	3	140	14	0
2153	746	64	2	110	11	0
2158	748	60	1	100	10	0
2163	749	36	3	140	14	0
2168	751	17	2	140	14	0
2173	757	67	1	130	13	0
2178	758	77	3	50	5	0
2183	760	47	2	150	15	0
2188	762	31	1	130	13	0
2193	763	33	3	50	5	0
2198	765	68	2	170	17	0
2199	765	48	3	190	19	0
2200	766	38	1	130	13	0
2205	767	74	3	170	17	0
2210	769	61	2	110	11	0
2215	771	51	1	30	3	0
2220	772	48	3	180	18	0
2225	774	56	2	60	6	0
2230	776	43	1	190	19	0
2235	777	11	3	110	11	0
2240	779	77	2	120	12	0
2245	781	52	1	220	22	0
2250	782	57	3	140	14	0
2255	784	19	2	130	13	0
2260	786	46	1	290	29	0
2265	787	25	3	60	6	0
2270	789	11	2	60	6	0
2275	791	33	1	190	19	0
2280	792	19	3	40	4	0
2285	794	31	2	90	9	0
2290	796	48	1	80	8	0
2295	797	10	3	90	9	0
2300	799	13	2	110	11	0
2305	801	47	1	70	7	0
2310	802	52	3	90	9	0
2315	804	67	2	-20	-2	0
2320	806	12	1	120	12	0
2325	807	53	3	120	12	0
2330	809	48	2	60	6	0
2335	811	61	1	70	7	0
2340	812	67	3	250	25	0
2345	814	62	2	150	15	0
2350	816	57	1	130	13	0
2355	817	19	3	190	19	0
2356	818	52	1	200	20	0
2357	818	38	2	90	9	0
2362	821	81	1	60	6	0
2367	822	70	3	220	22	0
2372	824	40	2	180	18	0
2377	826	70	1	120	12	0
2382	827	75	3	140	14	0
2387	829	44	2	120	12	0
2392	831	40	1	130	13	0
2397	832	82	3	180	18	0
2402	834	63	2	120	12	0
2407	836	81	1	140	14	0
2412	837	44	3	100	10	0
2417	839	40	2	90	9	0
2422	841	21	1	150	15	0
2427	842	21	3	50	5	0
2432	844	81	2	180	18	0
2437	846	14	1	110	11	0
2442	847	27	3	120	12	0
2447	849	82	2	80	8	0
2452	851	81	1	160	16	0
2457	852	70	3	80	8	0
2462	856	64	2	160	16	0
2467	858	30	1	90	9	0
2472	859	35	3	50	5	0
2477	861	79	2	150	15	0
2482	863	36	1	130	13	0
2487	864	22	3	20	2	0
2492	866	73	2	130	13	0
2497	868	37	1	80	8	0
2502	869	64	3	170	17	0
2507	871	50	2	270	27	0
2512	873	2	1	180	18	0
2513	873	41	2	80	8	0
2514	873	1	3	170	17	0
2519	875	3	2	220	22	0
2524	877	35	1	180	18	0
2529	878	6	3	190	19	0
2534	880	50	2	140	14	0
2539	882	16	1	260	26	0
2544	883	76	3	200	20	0
2549	885	3	2	250	25	0
2554	887	55	1	190	19	0
2559	888	37	3	140	14	0
2564	890	8	2	180	18	0
2569	892	35	1	120	12	0
2574	893	59	3	170	17	0
2579	895	4	2	180	18	0
2584	897	2	1	280	28	0
2589	898	36	3	120	12	0
2594	900	66	2	120	12	0
2599	902	55	1	150	15	0
2604	903	4	3	180	18	0
2609	905	60	2	130	13	0
2614	907	50	1	130	13	0
2619	908	16	3	160	16	0
2624	910	41	2	80	8	0
2629	912	65	1	140	14	0
2634	913	37	3	80	8	0
2639	915	79	2	260	26	0
2644	917	8	1	200	20	0
2649	918	59	3	170	17	0
2654	920	2	2	160	16	0
2659	922	36	1	130	13	0
2664	923	35	3	220	22	0
2669	929	62	2	150	15	0
2670	929	39	3	130	13	0
2671	930	52	1	190	19	0
2676	931	26	3	90	9	0
2681	933	51	2	90	9	0
2686	935	12	1	170	17	0
2691	936	46	3	270	27	0
2696	938	80	2	140	14	0
2701	940	42	1	90	9	0
2706	941	53	3	130	13	0
2711	943	57	2	70	7	0
2716	945	19	1	70	7	0
2721	946	12	3	110	11	0
2726	948	68	2	170	17	0
2731	950	32	1	180	18	0
2736	951	61	3	70	7	0
2741	953	12	2	150	15	0
2746	955	47	1	110	11	0
2751	956	51	3	40	4	0
2756	958	43	2	70	7	0
2761	960	61	1	90	9	0
2766	961	11	3	100	10	0
2771	963	18	2	40	4	0
2776	965	32	1	180	18	0
2781	966	13	3	50	5	0
2786	968	52	2	180	18	0
2792	970	52	2	170	17	0
2797	972	32	1	160	16	0
2802	973	61	3	60	6	0
2807	975	10	2	90	9	0
2812	977	33	1	140	14	0
2817	978	11	3	30	3	0
2822	980	62	2	110	11	0
2827	982	77	1	140	14	0
2828	982	52	2	160	16	0
2833	984	43	1	140	14	0
2838	985	56	3	80	8	0
2843	987	9	2	80	8	0
2848	989	47	1	180	18	0
2853	991	82	3	70	7	0
2858	993	69	2	110	11	0
2863	995	34	1	110	11	0
2868	996	40	3	100	10	0
2873	998	70	2	140	14	0
2878	1000	21	1	80	8	0
2883	1001	54	3	130	13	0
2889	1003	14	3	130	13	0
2894	1005	20	2	140	14	0
2899	1007	75	1	90	9	0
2904	1008	75	3	190	19	0
2909	1010	27	2	150	15	0
2914	1012	34	1	180	18	0
2919	1013	34	3	140	14	0
2924	1015	82	2	140	14	0
2929	1017	14	1	70	7	0
2934	1018	81	3	70	7	0
2939	1020	75	2	90	9	0
2944	1022	40	1	150	15	0
2949	1023	20	3	190	19	0
2954	1027	24	2	30	3	0
2959	1029	79	1	110	11	0
2964	1030	73	3	200	20	0
2969	1032	6	2	90	9	0
2974	1034	59	1	180	18	0
2979	1035	72	3	190	19	0
2984	1037	5	2	90	9	0
2985	1037	55	3	130	13	0
2990	1039	71	2	140	14	0
2995	1041	15	1	180	18	0
3000	1042	16	3	190	19	0
3005	1044	7	2	120	12	0
3010	1046	17	1	130	13	0
3015	1047	50	3	160	16	0
3020	1049	35	2	120	12	0
3025	1051	2	1	270	27	0
3030	1052	1	3	190	19	0
3035	1054	59	2	160	16	0
3040	1056	4	1	220	22	0
3045	1057	72	3	170	17	0
3050	1059	73	2	280	28	0
3055	1061	24	1	100	10	0
3060	1062	28	3	150	15	0
3065	1064	29	2	50	5	0
3070	1066	15	1	170	17	0
3075	1067	35	3	160	16	0
3080	1069	45	2	210	21	0
3085	1071	1	1	210	21	0
3090	1072	65	3	130	13	0
3095	1074	2	2	170	17	0
3100	1076	24	1	150	15	0
3105	1077	4	3	140	14	0
3110	1079	17	2	100	10	0
3115	1081	37	1	50	5	0
3120	1082	16	3	210	21	0
3125	1084	55	2	160	16	0
3130	1086	76	1	140	14	0
3135	1087	45	3	250	25	0
3140	1089	79	2	230	23	0
3141	1089	50	3	220	22	0
3142	1090	28	1	80	8	0
3147	1091	6	3	80	8	0
3152	1093	5	2	160	16	0
3157	1099	43	1	220	22	0
3162	1100	13	3	110	11	0
3167	1102	48	2	180	18	0
3172	1104	68	1	80	8	0
3177	1105	33	3	150	15	0
3182	1107	47	2	100	10	0
3187	1109	42	1	60	6	0
3192	1110	46	3	250	25	0
3197	1112	33	2	200	20	0
3202	1114	62	1	120	12	0
3207	1115	31	3	200	20	0
3212	1117	32	2	120	12	0
3217	1119	39	1	160	16	0
3222	1120	47	3	60	6	0
3227	1122	61	2	80	8	0
3232	1124	51	1	100	10	0
3237	1125	52	3	220	22	0
3242	1127	38	2	130	13	0
3247	1129	26	1	120	12	0
3252	1130	32	3	130	13	0
3257	1132	43	2	100	10	0
3262	1134	57	1	90	9	0
3267	1135	61	3	120	12	0
3272	1137	11	2	110	11	0
3277	1139	42	1	100	10	0
3282	1140	38	3	130	13	0
3287	1142	74	2	160	16	0
3292	1144	53	1	90	9	0
3297	1145	62	3	160	16	0
3300	1146	31	3	180	18	0
3305	1148	52	2	150	15	0
3310	1150	48	1	200	20	0
3315	1151	67	3	110	11	0
3320	1153	43	2	150	15	0
3325	1155	56	1	80	8	0
3330	1156	26	3	130	13	0
3335	1158	12	2	170	17	0
3384	1175	58	3	90	9	0
3388	1177	44	1	160	16	0
3393	1178	81	3	60	6	0
3398	1180	78	2	100	10	0
3403	1182	70	1	80	8	0
3408	1183	69	3	170	17	0
3413	1185	75	2	190	19	0
3418	1187	70	1	180	18	0
3423	1188	58	3	140	14	0
3427	1190	78	1	160	16	0
3434	1192	58	2	130	13	0
3439	1194	75	1	90	9	0
3444	1195	40	3	140	14	0
\.


--
-- Name: quiz_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('quiz_teams_id_seq', 3444, true);


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY quizzes (id, division_id, event_id, room_num, round_num, active, category_id) FROM stdin;
1	1	1	1	1	t	1
2	1	1	2	1	t	1
3	1	1	3	1	t	1
4	1	1	4	1	t	1
5	1	1	5	1	t	1
6	1	1	6	1	t	1
7	1	1	1	2	t	1
8	1	1	2	2	t	1
9	1	1	3	2	t	1
10	1	1	4	2	t	1
11	1	1	5	2	t	1
12	1	1	6	2	t	1
13	1	1	1	3	t	1
14	1	1	2	3	t	1
15	1	1	3	3	t	1
16	1	1	4	3	t	1
17	1	1	5	3	t	1
18	1	1	6	3	t	1
19	1	1	1	4	t	1
20	1	1	2	4	t	1
21	1	1	3	4	t	1
22	1	1	4	4	t	1
23	1	1	5	4	t	1
24	1	1	6	4	t	1
25	1	1	1	5	t	1
26	1	1	2	5	t	1
27	1	1	3	5	t	1
28	1	1	4	5	t	1
29	1	1	5	5	t	1
30	1	1	6	5	t	1
31	1	1	1	6	t	1
32	1	1	2	6	t	1
33	1	1	3	6	t	1
34	1	1	4	6	t	1
35	1	1	5	6	t	1
36	1	1	6	6	t	1
37	1	1	1	7	t	1
38	1	1	2	7	t	1
39	1	1	3	7	t	1
40	1	1	4	7	t	1
41	1	1	5	7	t	1
42	1	1	6	7	t	1
43	1	1	1	8	t	1
44	1	1	2	8	t	1
45	1	1	3	8	t	1
46	1	1	4	8	t	1
47	1	1	5	8	t	1
48	1	1	6	8	t	1
49	1	1	1	9	t	1
50	1	1	2	9	t	1
51	1	1	3	9	t	1
52	1	1	4	9	t	1
53	1	1	5	9	t	1
54	1	1	6	9	t	1
55	1	1	1	10	t	1
56	1	1	2	10	t	1
57	1	1	3	10	t	1
58	1	1	4	10	t	1
59	1	1	5	10	t	1
60	1	1	6	10	t	1
61	1	1	1	11	t	1
62	1	1	2	11	t	1
63	1	1	3	11	t	1
64	1	1	4	11	t	1
65	1	1	5	11	t	1
66	1	1	6	11	t	1
67	1	1	1	12	t	1
68	1	1	2	12	t	1
73	2	1	1	1	t	1
74	2	1	2	1	t	1
75	2	1	3	1	t	1
76	2	1	4	1	t	1
77	2	1	5	1	t	1
78	2	1	6	1	t	1
79	2	1	7	1	t	1
80	2	1	1	2	t	1
81	2	1	2	2	t	1
82	2	1	3	2	t	1
83	2	1	4	2	t	1
84	2	1	5	2	t	1
85	2	1	6	2	t	1
86	2	1	7	2	t	1
87	2	1	1	3	t	1
88	2	1	2	3	t	1
89	2	1	3	3	t	1
90	2	1	4	3	t	1
91	2	1	5	3	t	1
92	2	1	6	3	t	1
93	2	1	7	3	t	1
94	2	1	1	4	t	1
95	2	1	2	4	t	1
96	2	1	3	4	t	1
97	2	1	4	4	t	1
98	2	1	5	4	t	1
99	2	1	6	4	t	1
100	2	1	7	4	t	1
101	2	1	1	5	t	1
102	2	1	2	5	t	1
103	2	1	3	5	t	1
104	2	1	4	5	t	1
105	2	1	5	5	t	1
106	2	1	6	5	t	1
107	2	1	7	5	t	1
108	2	1	1	6	t	1
109	2	1	2	6	t	1
110	2	1	3	6	t	1
111	2	1	4	6	t	1
112	2	1	5	6	t	1
113	2	1	6	6	t	1
114	2	1	7	6	t	1
115	2	1	1	7	t	1
116	2	1	2	7	t	1
117	2	1	3	7	t	1
118	2	1	4	7	t	1
119	2	1	5	7	t	1
120	2	1	6	7	t	1
121	2	1	7	7	t	1
122	2	1	1	8	t	1
123	2	1	2	8	t	1
124	2	1	3	8	t	1
125	2	1	4	8	t	1
126	2	1	5	8	t	1
127	2	1	6	8	t	1
128	2	1	7	8	t	1
129	2	1	1	9	t	1
130	2	1	2	9	t	1
131	2	1	3	9	t	1
132	2	1	4	9	t	1
133	2	1	5	9	t	1
134	2	1	6	9	t	1
136	3	1	1	1	t	1
137	3	1	2	1	t	1
138	3	1	3	1	t	1
139	3	1	4	1	t	1
140	3	1	1	2	t	1
141	3	1	2	2	t	1
142	3	1	3	2	t	1
143	3	1	4	2	t	1
144	3	1	1	3	t	1
145	3	1	2	3	t	1
146	3	1	3	3	t	1
147	3	1	4	3	t	1
148	3	1	1	4	t	1
149	3	1	2	4	t	1
150	3	1	3	4	t	1
151	3	1	4	4	t	1
152	3	1	1	5	t	1
153	3	1	2	5	t	1
154	3	1	3	5	t	1
155	3	1	4	5	t	1
156	3	1	1	6	t	1
157	3	1	2	6	t	1
158	3	1	3	6	t	1
159	3	1	4	6	t	1
160	3	1	1	7	t	1
161	3	1	2	7	t	1
162	3	1	3	7	t	1
163	3	1	4	7	t	1
164	3	1	1	8	t	1
165	3	1	2	8	t	1
166	3	1	3	8	t	1
167	3	1	4	8	t	1
168	3	1	1	9	t	1
169	3	1	2	9	t	1
172	1	2	1	1	t	1
173	1	2	2	1	t	1
174	1	2	3	1	t	1
175	1	2	4	1	t	1
176	1	2	5	1	t	1
177	1	2	6	1	t	1
178	1	2	1	2	t	1
179	1	2	2	2	t	1
180	1	2	3	2	t	1
181	1	2	4	2	t	1
182	1	2	5	2	t	1
183	1	2	6	2	t	1
184	1	2	1	3	t	1
185	1	2	2	3	t	1
186	1	2	3	3	t	1
187	1	2	4	3	t	1
188	1	2	5	3	t	1
189	1	2	6	3	t	1
190	1	2	1	4	t	1
191	1	2	2	4	t	1
192	1	2	3	4	t	1
193	1	2	4	4	t	1
194	1	2	5	4	t	1
195	1	2	6	4	t	1
196	1	2	1	5	t	1
197	1	2	2	5	t	1
198	1	2	3	5	t	1
199	1	2	4	5	t	1
200	1	2	5	5	t	1
201	1	2	6	5	t	1
202	1	2	1	6	t	1
203	1	2	2	6	t	1
204	1	2	3	6	t	1
205	1	2	4	6	t	1
206	1	2	5	6	t	1
207	1	2	6	6	t	1
208	1	2	1	7	t	1
209	1	2	2	7	t	1
210	1	2	3	7	t	1
211	1	2	4	7	t	1
212	1	2	5	7	t	1
213	1	2	6	7	t	1
214	1	2	1	8	t	1
215	1	2	2	8	t	1
216	1	2	3	8	t	1
217	1	2	4	8	t	1
218	1	2	5	8	t	1
219	1	2	6	8	t	1
220	1	2	1	9	t	1
221	1	2	2	9	t	1
222	1	2	3	9	t	1
223	1	2	4	9	t	1
224	1	2	5	9	t	1
225	1	2	6	9	t	1
226	1	2	1	10	t	1
227	1	2	2	10	t	1
228	1	2	3	10	t	1
229	1	2	4	10	t	1
230	1	2	5	10	t	1
231	1	2	6	10	t	1
232	1	2	1	11	t	1
233	1	2	2	11	t	1
234	1	2	3	11	t	1
235	1	2	4	11	t	1
236	1	2	5	11	t	1
237	1	2	6	11	t	1
238	1	2	1	12	t	1
239	1	2	2	12	t	1
244	2	2	1	1	t	1
245	2	2	2	1	t	1
246	2	2	3	1	t	1
247	2	2	4	1	t	1
248	2	2	5	1	t	1
249	2	2	6	1	t	1
250	2	2	7	1	t	1
251	2	2	1	2	t	1
252	2	2	2	2	t	1
253	2	2	3	2	t	1
254	2	2	4	2	t	1
255	2	2	5	2	t	1
256	2	2	6	2	t	1
257	2	2	7	2	t	1
258	2	2	1	3	t	1
259	2	2	2	3	t	1
260	2	2	3	3	t	1
261	2	2	4	3	t	1
262	2	2	5	3	t	1
263	2	2	6	3	t	1
264	2	2	7	3	t	1
265	2	2	1	4	t	1
266	2	2	2	4	t	1
267	2	2	3	4	t	1
268	2	2	4	4	t	1
269	2	2	5	4	t	1
270	2	2	6	4	t	1
271	2	2	7	4	t	1
272	2	2	1	5	t	1
273	2	2	2	5	t	1
274	2	2	3	5	t	1
275	2	2	4	5	t	1
276	2	2	5	5	t	1
277	2	2	6	5	t	1
278	2	2	7	5	t	1
279	2	2	1	6	t	1
280	2	2	2	6	t	1
281	2	2	3	6	t	1
282	2	2	4	6	t	1
283	2	2	5	6	t	1
284	2	2	6	6	t	1
285	2	2	7	6	t	1
286	2	2	1	7	t	1
287	2	2	2	7	t	1
288	2	2	3	7	t	1
289	2	2	4	7	t	1
290	2	2	5	7	t	1
291	2	2	6	7	t	1
292	2	2	7	7	t	1
293	2	2	1	8	t	1
294	2	2	2	8	t	1
295	2	2	3	8	t	1
296	2	2	4	8	t	1
297	2	2	5	8	t	1
298	2	2	6	8	t	1
299	2	2	7	8	t	1
300	2	2	1	9	t	1
301	2	2	2	9	t	1
302	2	2	3	9	t	1
303	2	2	4	9	t	1
304	2	2	5	9	t	1
305	2	2	6	9	t	1
307	3	2	1	1	t	1
308	3	2	2	1	t	1
309	3	2	3	1	t	1
310	3	2	4	1	t	1
311	3	2	1	2	t	1
312	3	2	2	2	t	1
313	3	2	3	2	t	1
314	3	2	4	2	t	1
315	3	2	1	3	t	1
316	3	2	2	3	t	1
317	3	2	3	3	t	1
318	3	2	4	3	t	1
319	3	2	1	4	t	1
320	3	2	2	4	t	1
321	3	2	3	4	t	1
322	3	2	4	4	t	1
323	3	2	1	5	t	1
324	3	2	2	5	t	1
325	3	2	3	5	t	1
326	3	2	4	5	t	1
327	3	2	1	6	t	1
328	3	2	2	6	t	1
329	3	2	3	6	t	1
330	3	2	4	6	t	1
331	3	2	1	7	t	1
332	3	2	2	7	t	1
333	3	2	3	7	t	1
334	3	2	4	7	t	1
335	3	2	1	8	t	1
336	3	2	2	8	t	1
337	3	2	3	8	t	1
338	3	2	4	8	t	1
339	3	2	1	9	t	1
340	3	2	2	9	t	1
343	1	3	1	1	t	1
344	1	3	2	1	t	1
345	1	3	3	1	t	1
346	1	3	4	1	t	1
347	1	3	5	1	t	1
348	1	3	6	1	t	1
349	1	3	1	2	t	1
350	1	3	2	2	t	1
351	1	3	3	2	t	1
352	1	3	4	2	t	1
353	1	3	5	2	t	1
354	1	3	6	2	t	1
355	1	3	1	3	t	1
356	1	3	2	3	t	1
357	1	3	3	3	t	1
358	1	3	4	3	t	1
359	1	3	5	3	t	1
360	1	3	6	3	t	1
361	1	3	1	4	t	1
362	1	3	2	4	t	1
363	1	3	3	4	t	1
364	1	3	4	4	t	1
365	1	3	5	4	t	1
366	1	3	6	4	t	1
367	1	3	1	5	t	1
368	1	3	2	5	t	1
369	1	3	3	5	t	1
370	1	3	4	5	t	1
371	1	3	5	5	t	1
372	1	3	6	5	t	1
373	1	3	1	6	t	1
374	1	3	2	6	t	1
375	1	3	3	6	t	1
376	1	3	4	6	t	1
377	1	3	5	6	t	1
378	1	3	6	6	t	1
379	1	3	1	7	t	1
380	1	3	2	7	t	1
381	1	3	3	7	t	1
382	1	3	4	7	t	1
383	1	3	5	7	t	1
384	1	3	6	7	t	1
385	1	3	1	8	t	1
386	1	3	2	8	t	1
387	1	3	3	8	t	1
388	1	3	4	8	t	1
389	1	3	5	8	t	1
390	1	3	6	8	t	1
391	1	3	1	9	t	1
392	1	3	2	9	t	1
393	1	3	3	9	t	1
394	1	3	4	9	t	1
395	1	3	5	9	t	1
396	1	3	6	9	t	1
397	1	3	1	10	t	1
398	1	3	2	10	t	1
399	1	3	3	10	t	1
400	1	3	4	10	t	1
401	1	3	5	10	t	1
402	1	3	6	10	t	1
403	1	3	1	11	t	1
404	1	3	2	11	t	1
405	1	3	3	11	t	1
406	1	3	4	11	t	1
407	1	3	5	11	t	1
408	1	3	6	11	t	1
409	1	3	1	12	t	1
410	1	3	2	12	t	1
415	2	3	1	1	t	1
416	2	3	2	1	t	1
417	2	3	3	1	t	1
418	2	3	4	1	t	1
419	2	3	5	1	t	1
420	2	3	6	1	t	1
421	2	3	7	1	t	1
422	2	3	1	2	t	1
423	2	3	2	2	t	1
424	2	3	3	2	t	1
425	2	3	4	2	t	1
426	2	3	5	2	t	1
427	2	3	6	2	t	1
428	2	3	7	2	t	1
429	2	3	1	3	t	1
430	2	3	2	3	t	1
431	2	3	3	3	t	1
432	2	3	4	3	t	1
433	2	3	5	3	t	1
434	2	3	6	3	t	1
435	2	3	7	3	t	1
436	2	3	1	4	t	1
437	2	3	2	4	t	1
438	2	3	3	4	t	1
439	2	3	4	4	t	1
440	2	3	5	4	t	1
441	2	3	6	4	t	1
442	2	3	7	4	t	1
443	2	3	1	5	t	1
444	2	3	2	5	t	1
445	2	3	3	5	t	1
446	2	3	4	5	t	1
447	2	3	5	5	t	1
448	2	3	6	5	t	1
449	2	3	7	5	t	1
450	2	3	1	6	t	1
451	2	3	2	6	t	1
452	2	3	3	6	t	1
453	2	3	4	6	t	1
454	2	3	5	6	t	1
455	2	3	6	6	t	1
456	2	3	7	6	t	1
457	2	3	1	7	t	1
458	2	3	2	7	t	1
459	2	3	3	7	t	1
460	2	3	4	7	t	1
461	2	3	5	7	t	1
462	2	3	6	7	t	1
463	2	3	7	7	t	1
464	2	3	1	8	t	1
465	2	3	2	8	t	1
466	2	3	3	8	t	1
467	2	3	4	8	t	1
468	2	3	5	8	t	1
469	2	3	6	8	t	1
470	2	3	7	8	t	1
471	2	3	1	9	t	1
472	2	3	2	9	t	1
473	2	3	3	9	t	1
474	2	3	4	9	t	1
475	2	3	5	9	t	1
476	2	3	6	9	t	1
478	3	3	1	1	t	1
479	3	3	2	1	t	1
480	3	3	3	1	t	1
481	3	3	4	1	t	1
482	3	3	1	2	t	1
483	3	3	2	2	t	1
484	3	3	3	2	t	1
485	3	3	4	2	t	1
486	3	3	1	3	t	1
487	3	3	2	3	t	1
488	3	3	3	3	t	1
489	3	3	4	3	t	1
490	3	3	1	4	t	1
491	3	3	2	4	t	1
492	3	3	3	4	t	1
493	3	3	4	4	t	1
494	3	3	1	5	t	1
495	3	3	2	5	t	1
496	3	3	3	5	t	1
497	3	3	4	5	t	1
498	3	3	1	6	t	1
499	3	3	2	6	t	1
500	3	3	3	6	t	1
501	3	3	4	6	t	1
502	3	3	1	7	t	1
503	3	3	2	7	t	1
504	3	3	3	7	t	1
505	3	3	4	7	t	1
506	3	3	1	8	t	1
507	3	3	2	8	t	1
508	3	3	3	8	t	1
509	3	3	4	8	t	1
510	3	3	1	9	t	1
511	3	3	2	9	t	1
514	1	4	1	1	t	1
515	1	4	2	1	t	1
516	1	4	3	1	t	1
517	1	4	4	1	t	1
518	1	4	5	1	t	1
519	1	4	6	1	t	1
520	1	4	1	2	t	1
521	1	4	2	2	t	1
522	1	4	3	2	t	1
523	1	4	4	2	t	1
524	1	4	5	2	t	1
525	1	4	6	2	t	1
526	1	4	1	3	t	1
527	1	4	2	3	t	1
528	1	4	3	3	t	1
529	1	4	4	3	t	1
530	1	4	5	3	t	1
531	1	4	6	3	t	1
532	1	4	1	4	t	1
533	1	4	2	4	t	1
534	1	4	3	4	t	1
535	1	4	4	4	t	1
536	1	4	5	4	t	1
537	1	4	6	4	t	1
538	1	4	1	5	t	1
539	1	4	2	5	t	1
540	1	4	3	5	t	1
541	1	4	4	5	t	1
542	1	4	5	5	t	1
543	1	4	6	5	t	1
544	1	4	1	6	t	1
545	1	4	2	6	t	1
546	1	4	3	6	t	1
547	1	4	4	6	t	1
548	1	4	5	6	t	1
549	1	4	6	6	t	1
550	1	4	1	7	t	1
551	1	4	2	7	t	1
552	1	4	3	7	t	1
553	1	4	4	7	t	1
554	1	4	5	7	t	1
555	1	4	6	7	t	1
556	1	4	1	8	t	1
557	1	4	2	8	t	1
558	1	4	3	8	t	1
559	1	4	4	8	t	1
560	1	4	5	8	t	1
561	1	4	6	8	t	1
562	1	4	1	9	t	1
563	1	4	2	9	t	1
564	1	4	3	9	t	1
565	1	4	4	9	t	1
566	1	4	5	9	t	1
567	1	4	6	9	t	1
568	1	4	1	10	t	1
569	1	4	2	10	t	1
570	1	4	3	10	t	1
571	1	4	4	10	t	1
572	1	4	5	10	t	1
573	1	4	6	10	t	1
574	1	4	1	11	t	1
575	1	4	2	11	t	1
576	1	4	3	11	t	1
577	1	4	4	11	t	1
578	1	4	5	11	t	1
579	1	4	6	11	t	1
580	1	4	1	12	t	1
581	1	4	2	12	t	1
586	2	4	1	1	t	1
587	2	4	2	1	t	1
588	2	4	3	1	t	1
589	2	4	4	1	t	1
590	2	4	5	1	t	1
591	2	4	6	1	t	1
592	2	4	7	1	t	1
593	2	4	1	2	t	1
594	2	4	2	2	t	1
595	2	4	3	2	t	1
596	2	4	4	2	t	1
597	2	4	5	2	t	1
598	2	4	6	2	t	1
599	2	4	7	2	t	1
600	2	4	1	3	t	1
601	2	4	2	3	t	1
602	2	4	3	3	t	1
603	2	4	4	3	t	1
604	2	4	5	3	t	1
605	2	4	6	3	t	1
606	2	4	7	3	t	1
607	2	4	1	4	t	1
608	2	4	2	4	t	1
609	2	4	3	4	t	1
610	2	4	4	4	t	1
611	2	4	5	4	t	1
612	2	4	6	4	t	1
613	2	4	7	4	t	1
614	2	4	1	5	t	1
615	2	4	2	5	t	1
616	2	4	3	5	t	1
617	2	4	4	5	t	1
618	2	4	5	5	t	1
619	2	4	6	5	t	1
620	2	4	7	5	t	1
621	2	4	1	6	t	1
622	2	4	2	6	t	1
623	2	4	3	6	t	1
624	2	4	4	6	t	1
625	2	4	5	6	t	1
626	2	4	6	6	t	1
627	2	4	7	6	t	1
628	2	4	1	7	t	1
629	2	4	2	7	t	1
630	2	4	3	7	t	1
631	2	4	4	7	t	1
632	2	4	5	7	t	1
633	2	4	6	7	t	1
634	2	4	7	7	t	1
635	2	4	1	8	t	1
636	2	4	2	8	t	1
637	2	4	3	8	t	1
638	2	4	4	8	t	1
639	2	4	5	8	t	1
640	2	4	6	8	t	1
641	2	4	7	8	t	1
642	2	4	1	9	t	1
643	2	4	2	9	t	1
644	2	4	3	9	t	1
645	2	4	4	9	t	1
646	2	4	5	9	t	1
647	2	4	6	9	t	1
649	3	4	1	1	t	1
650	3	4	2	1	t	1
651	3	4	3	1	t	1
652	3	4	4	1	t	1
653	3	4	1	2	t	1
654	3	4	2	2	t	1
655	3	4	3	2	t	1
656	3	4	4	2	t	1
657	3	4	1	3	t	1
658	3	4	2	3	t	1
659	3	4	3	3	t	1
660	3	4	4	3	t	1
661	3	4	1	4	t	1
662	3	4	2	4	t	1
663	3	4	3	4	t	1
664	3	4	4	4	t	1
665	3	4	1	5	t	1
666	3	4	2	5	t	1
667	3	4	3	5	t	1
668	3	4	4	5	t	1
669	3	4	1	6	t	1
670	3	4	2	6	t	1
671	3	4	3	6	t	1
672	3	4	4	6	t	1
673	3	4	1	7	t	1
674	3	4	2	7	t	1
675	3	4	3	7	t	1
676	3	4	4	7	t	1
677	3	4	1	8	t	1
678	3	4	2	8	t	1
679	3	4	3	8	t	1
680	3	4	4	8	t	1
681	3	4	1	9	t	1
682	3	4	2	9	t	1
685	1	5	1	1	t	1
686	1	5	2	1	t	1
687	1	5	3	1	t	1
688	1	5	4	1	t	1
689	1	5	5	1	t	1
690	1	5	6	1	t	1
691	1	5	1	2	t	1
692	1	5	2	2	t	1
693	1	5	3	2	t	1
694	1	5	4	2	t	1
695	1	5	5	2	t	1
696	1	5	6	2	t	1
697	1	5	1	3	t	1
698	1	5	2	3	t	1
699	1	5	3	3	t	1
700	1	5	4	3	t	1
701	1	5	5	3	t	1
702	1	5	6	3	t	1
703	1	5	1	4	t	1
704	1	5	2	4	t	1
705	1	5	3	4	t	1
706	1	5	4	4	t	1
707	1	5	5	4	t	1
708	1	5	6	4	t	1
709	1	5	1	5	t	1
710	1	5	2	5	t	1
711	1	5	3	5	t	1
712	1	5	4	5	t	1
713	1	5	5	5	t	1
714	1	5	6	5	t	1
715	1	5	1	6	t	1
716	1	5	2	6	t	1
717	1	5	3	6	t	1
718	1	5	4	6	t	1
719	1	5	5	6	t	1
720	1	5	6	6	t	1
721	1	5	1	7	t	1
722	1	5	2	7	t	1
723	1	5	3	7	t	1
724	1	5	4	7	t	1
725	1	5	5	7	t	1
726	1	5	6	7	t	1
727	1	5	1	8	t	1
728	1	5	2	8	t	1
729	1	5	3	8	t	1
730	1	5	4	8	t	1
731	1	5	5	8	t	1
732	1	5	6	8	t	1
733	1	5	1	9	t	1
734	1	5	2	9	t	1
735	1	5	3	9	t	1
736	1	5	4	9	t	1
737	1	5	5	9	t	1
738	1	5	6	9	t	1
739	1	5	1	10	t	1
740	1	5	2	10	t	1
741	1	5	3	10	t	1
742	1	5	4	10	t	1
743	1	5	5	10	t	1
744	1	5	6	10	t	1
745	1	5	1	11	t	1
746	1	5	2	11	t	1
747	1	5	3	11	t	1
748	1	5	4	11	t	1
749	1	5	5	11	t	1
750	1	5	6	11	t	1
751	1	5	1	12	t	1
752	1	5	2	12	t	1
757	2	5	1	1	t	1
758	2	5	2	1	t	1
759	2	5	3	1	t	1
760	2	5	4	1	t	1
761	2	5	5	1	t	1
762	2	5	6	1	t	1
763	2	5	7	1	t	1
764	2	5	1	2	t	1
765	2	5	2	2	t	1
766	2	5	3	2	t	1
767	2	5	4	2	t	1
768	2	5	5	2	t	1
769	2	5	6	2	t	1
770	2	5	7	2	t	1
771	2	5	1	3	t	1
772	2	5	2	3	t	1
773	2	5	3	3	t	1
774	2	5	4	3	t	1
775	2	5	5	3	t	1
776	2	5	6	3	t	1
777	2	5	7	3	t	1
778	2	5	1	4	t	1
779	2	5	2	4	t	1
780	2	5	3	4	t	1
781	2	5	4	4	t	1
782	2	5	5	4	t	1
783	2	5	6	4	t	1
784	2	5	7	4	t	1
785	2	5	1	5	t	1
786	2	5	2	5	t	1
787	2	5	3	5	t	1
788	2	5	4	5	t	1
789	2	5	5	5	t	1
790	2	5	6	5	t	1
791	2	5	7	5	t	1
792	2	5	1	6	t	1
793	2	5	2	6	t	1
794	2	5	3	6	t	1
795	2	5	4	6	t	1
796	2	5	5	6	t	1
797	2	5	6	6	t	1
798	2	5	7	6	t	1
799	2	5	1	7	t	1
800	2	5	2	7	t	1
801	2	5	3	7	t	1
802	2	5	4	7	t	1
803	2	5	5	7	t	1
804	2	5	6	7	t	1
805	2	5	7	7	t	1
806	2	5	1	8	t	1
807	2	5	2	8	t	1
808	2	5	3	8	t	1
809	2	5	4	8	t	1
810	2	5	5	8	t	1
811	2	5	6	8	t	1
812	2	5	7	8	t	1
813	2	5	1	9	t	1
814	2	5	2	9	t	1
815	2	5	3	9	t	1
816	2	5	4	9	t	1
817	2	5	5	9	t	1
818	2	5	6	9	t	1
820	3	5	1	1	t	1
821	3	5	2	1	t	1
822	3	5	3	1	t	1
823	3	5	4	1	t	1
824	3	5	1	2	t	1
825	3	5	2	2	t	1
826	3	5	3	2	t	1
827	3	5	4	2	t	1
828	3	5	1	3	t	1
829	3	5	2	3	t	1
830	3	5	3	3	t	1
831	3	5	4	3	t	1
832	3	5	1	4	t	1
833	3	5	2	4	t	1
834	3	5	3	4	t	1
835	3	5	4	4	t	1
836	3	5	1	5	t	1
837	3	5	2	5	t	1
838	3	5	3	5	t	1
839	3	5	4	5	t	1
840	3	5	1	6	t	1
841	3	5	2	6	t	1
842	3	5	3	6	t	1
843	3	5	4	6	t	1
844	3	5	1	7	t	1
845	3	5	2	7	t	1
846	3	5	3	7	t	1
847	3	5	4	7	t	1
848	3	5	1	8	t	1
849	3	5	2	8	t	1
850	3	5	3	8	t	1
851	3	5	4	8	t	1
852	3	5	1	9	t	1
853	3	5	2	9	t	1
856	1	6	1	1	t	1
857	1	6	2	1	t	1
858	1	6	3	1	t	1
859	1	6	4	1	t	1
860	1	6	5	1	t	1
861	1	6	6	1	t	1
862	1	6	1	2	t	1
863	1	6	2	2	t	1
864	1	6	3	2	t	1
865	1	6	4	2	t	1
866	1	6	5	2	t	1
867	1	6	6	2	t	1
868	1	6	1	3	t	1
869	1	6	2	3	t	1
870	1	6	3	3	t	1
871	1	6	4	3	t	1
872	1	6	5	3	t	1
873	1	6	6	3	t	1
874	1	6	1	4	t	1
875	1	6	2	4	t	1
876	1	6	3	4	t	1
877	1	6	4	4	t	1
878	1	6	5	4	t	1
879	1	6	6	4	t	1
880	1	6	1	5	t	1
881	1	6	2	5	t	1
882	1	6	3	5	t	1
883	1	6	4	5	t	1
884	1	6	5	5	t	1
885	1	6	6	5	t	1
886	1	6	1	6	t	1
887	1	6	2	6	t	1
888	1	6	3	6	t	1
889	1	6	4	6	t	1
890	1	6	5	6	t	1
891	1	6	6	6	t	1
892	1	6	1	7	t	1
893	1	6	2	7	t	1
894	1	6	3	7	t	1
895	1	6	4	7	t	1
896	1	6	5	7	t	1
897	1	6	6	7	t	1
898	1	6	1	8	t	1
899	1	6	2	8	t	1
900	1	6	3	8	t	1
901	1	6	4	8	t	1
902	1	6	5	8	t	1
903	1	6	6	8	t	1
904	1	6	1	9	t	1
905	1	6	2	9	t	1
906	1	6	3	9	t	1
907	1	6	4	9	t	1
908	1	6	5	9	t	1
909	1	6	6	9	t	1
910	1	6	1	10	t	1
911	1	6	2	10	t	1
912	1	6	3	10	t	1
913	1	6	4	10	t	1
914	1	6	5	10	t	1
915	1	6	6	10	t	1
916	1	6	1	11	t	1
917	1	6	2	11	t	1
918	1	6	3	11	t	1
919	1	6	4	11	t	1
920	1	6	5	11	t	1
921	1	6	6	11	t	1
922	1	6	1	12	t	1
923	1	6	2	12	t	1
928	2	6	1	1	t	1
929	2	6	2	1	t	1
930	2	6	3	1	t	1
931	2	6	4	1	t	1
932	2	6	5	1	t	1
933	2	6	6	1	t	1
934	2	6	7	1	t	1
935	2	6	1	2	t	1
936	2	6	2	2	t	1
937	2	6	3	2	t	1
938	2	6	4	2	t	1
939	2	6	5	2	t	1
940	2	6	6	2	t	1
941	2	6	7	2	t	1
942	2	6	1	3	t	1
943	2	6	2	3	t	1
944	2	6	3	3	t	1
945	2	6	4	3	t	1
946	2	6	5	3	t	1
947	2	6	6	3	t	1
948	2	6	7	3	t	1
949	2	6	1	4	t	1
950	2	6	2	4	t	1
951	2	6	3	4	t	1
952	2	6	4	4	t	1
953	2	6	5	4	t	1
954	2	6	6	4	t	1
955	2	6	7	4	t	1
956	2	6	1	5	t	1
957	2	6	2	5	t	1
958	2	6	3	5	t	1
959	2	6	4	5	t	1
960	2	6	5	5	t	1
961	2	6	6	5	t	1
962	2	6	7	5	t	1
963	2	6	1	6	t	1
964	2	6	2	6	t	1
965	2	6	3	6	t	1
966	2	6	4	6	t	1
967	2	6	5	6	t	1
968	2	6	6	6	t	1
969	2	6	7	6	t	1
970	2	6	1	7	t	1
971	2	6	2	7	t	1
972	2	6	3	7	t	1
973	2	6	4	7	t	1
974	2	6	5	7	t	1
975	2	6	6	7	t	1
976	2	6	7	7	t	1
977	2	6	1	8	t	1
978	2	6	2	8	t	1
979	2	6	3	8	t	1
980	2	6	4	8	t	1
981	2	6	5	8	t	1
982	2	6	6	8	t	1
983	2	6	7	8	t	1
984	2	6	1	9	t	1
985	2	6	2	9	t	1
986	2	6	3	9	t	1
987	2	6	4	9	t	1
988	2	6	5	9	t	1
989	2	6	6	9	t	1
991	3	6	1	1	t	1
992	3	6	2	1	t	1
993	3	6	3	1	t	1
994	3	6	4	1	t	1
995	3	6	1	2	t	1
996	3	6	2	2	t	1
997	3	6	3	2	t	1
998	3	6	4	2	t	1
999	3	6	1	3	t	1
1000	3	6	2	3	t	1
1001	3	6	3	3	t	1
1002	3	6	4	3	t	1
1003	3	6	1	4	t	1
1004	3	6	2	4	t	1
1005	3	6	3	4	t	1
1006	3	6	4	4	t	1
1007	3	6	1	5	t	1
1008	3	6	2	5	t	1
1009	3	6	3	5	t	1
1010	3	6	4	5	t	1
1011	3	6	1	6	t	1
1012	3	6	2	6	t	1
1013	3	6	3	6	t	1
1014	3	6	4	6	t	1
1015	3	6	1	7	t	1
1016	3	6	2	7	t	1
1017	3	6	3	7	t	1
1018	3	6	4	7	t	1
1019	3	6	1	8	t	1
1020	3	6	2	8	t	1
1021	3	6	3	8	t	1
1022	3	6	4	8	t	1
1023	3	6	1	9	t	1
1024	3	6	2	9	t	1
1027	1	7	1	1	t	1
1028	1	7	2	1	t	1
1029	1	7	3	1	t	1
1030	1	7	4	1	t	1
1031	1	7	5	1	t	1
1032	1	7	6	1	t	1
1033	1	7	1	2	t	1
1034	1	7	2	2	t	1
1035	1	7	3	2	t	1
1036	1	7	4	2	t	1
1037	1	7	5	2	t	1
1038	1	7	6	2	t	1
1039	1	7	1	3	t	1
1040	1	7	2	3	t	1
1041	1	7	3	3	t	1
1042	1	7	4	3	t	1
1043	1	7	5	3	t	1
1044	1	7	6	3	t	1
1045	1	7	1	4	t	1
1046	1	7	2	4	t	1
1047	1	7	3	4	t	1
1048	1	7	4	4	t	1
1049	1	7	5	4	t	1
1050	1	7	6	4	t	1
1051	1	7	1	5	t	1
1052	1	7	2	5	t	1
1053	1	7	3	5	t	1
1054	1	7	4	5	t	1
1055	1	7	5	5	t	1
1056	1	7	6	5	t	1
1057	1	7	1	6	t	1
1058	1	7	2	6	t	1
1059	1	7	3	6	t	1
1060	1	7	4	6	t	1
1061	1	7	5	6	t	1
1062	1	7	6	6	t	1
1063	1	7	1	7	t	1
1064	1	7	2	7	t	1
1065	1	7	3	7	t	1
1066	1	7	4	7	t	1
1067	1	7	5	7	t	1
1068	1	7	6	7	t	1
1069	1	7	1	8	t	1
1070	1	7	2	8	t	1
1071	1	7	3	8	t	1
1072	1	7	4	8	t	1
1073	1	7	5	8	t	1
1074	1	7	6	8	t	1
1075	1	7	1	9	t	1
1076	1	7	2	9	t	1
1077	1	7	3	9	t	1
1078	1	7	4	9	t	1
1079	1	7	5	9	t	1
1080	1	7	6	9	t	1
1081	1	7	1	10	t	1
1082	1	7	2	10	t	1
1083	1	7	3	10	t	1
1084	1	7	4	10	t	1
1085	1	7	5	10	t	1
1086	1	7	6	10	t	1
1087	1	7	1	11	t	1
1088	1	7	2	11	t	1
1089	1	7	3	11	t	1
1090	1	7	4	11	t	1
1091	1	7	5	11	t	1
1092	1	7	6	11	t	1
1093	1	7	1	12	t	1
1094	1	7	2	12	t	1
1099	2	7	1	1	t	1
1100	2	7	2	1	t	1
1101	2	7	3	1	t	1
1102	2	7	4	1	t	1
1103	2	7	5	1	t	1
1104	2	7	6	1	t	1
1105	2	7	7	1	t	1
1106	2	7	1	2	t	1
1107	2	7	2	2	t	1
1108	2	7	3	2	t	1
1109	2	7	4	2	t	1
1110	2	7	5	2	t	1
1111	2	7	6	2	t	1
1112	2	7	7	2	t	1
1113	2	7	1	3	t	1
1114	2	7	2	3	t	1
1115	2	7	3	3	t	1
1116	2	7	4	3	t	1
1117	2	7	5	3	t	1
1118	2	7	6	3	t	1
1119	2	7	7	3	t	1
1120	2	7	1	4	t	1
1121	2	7	2	4	t	1
1122	2	7	3	4	t	1
1123	2	7	4	4	t	1
1124	2	7	5	4	t	1
1125	2	7	6	4	t	1
1126	2	7	7	4	t	1
1127	2	7	1	5	t	1
1128	2	7	2	5	t	1
1129	2	7	3	5	t	1
1130	2	7	4	5	t	1
1131	2	7	5	5	t	1
1132	2	7	6	5	t	1
1133	2	7	7	5	t	1
1134	2	7	1	6	t	1
1135	2	7	2	6	t	1
1136	2	7	3	6	t	1
1137	2	7	4	6	t	1
1138	2	7	5	6	t	1
1139	2	7	6	6	t	1
1140	2	7	7	6	t	1
1141	2	7	1	7	t	1
1142	2	7	2	7	t	1
1143	2	7	3	7	t	1
1144	2	7	4	7	t	1
1145	2	7	5	7	t	1
1146	2	7	6	7	t	1
1147	2	7	7	7	t	1
1148	2	7	1	8	t	1
1149	2	7	2	8	t	1
1150	2	7	3	8	t	1
1151	2	7	4	8	t	1
1152	2	7	5	8	t	1
1153	2	7	6	8	t	1
1154	2	7	7	8	t	1
1155	2	7	1	9	t	1
1156	2	7	2	9	t	1
1157	2	7	3	9	t	1
1158	2	7	4	9	t	1
1159	2	7	5	9	t	1
1160	2	7	6	9	t	1
1162	3	7	1	1	t	1
1163	3	7	2	1	t	1
1164	3	7	3	1	t	1
1165	3	7	4	1	t	1
1166	3	7	1	2	t	1
1167	3	7	2	2	t	1
1168	3	7	3	2	t	1
1169	3	7	4	2	t	1
1170	3	7	1	3	t	1
1171	3	7	2	3	t	1
1172	3	7	3	3	t	1
1173	3	7	4	3	t	1
1174	3	7	1	4	t	1
1175	3	7	2	4	t	1
1176	3	7	3	4	t	1
1177	3	7	4	4	t	1
1178	3	7	1	5	t	1
1179	3	7	2	5	t	1
1180	3	7	3	5	t	1
1181	3	7	4	5	t	1
1182	3	7	1	6	t	1
1183	3	7	2	6	t	1
1184	3	7	3	6	t	1
1185	3	7	4	6	t	1
1186	3	7	1	7	t	1
1187	3	7	2	7	t	1
1188	3	7	3	7	t	1
1189	3	7	4	7	t	1
1190	3	7	1	8	t	1
1191	3	7	2	8	t	1
1192	3	7	3	8	t	1
1193	3	7	4	8	t	1
1194	3	7	1	9	t	1
1195	3	7	2	9	t	1
\.


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('quizzes_id_seq', 1197, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY schema_migrations (version) FROM stdin;
20150216224226
20150216224833
20150216225013
20150216225121
20150216225146
20150216225350
20150216225735
20150216225808
20150216225937
20150222220733
20150222220931
20150222221107
20150222221526
20150222222555
20150222232837
20150223052634
20150223055000
20150330222533
20150523144848
20150526143746
20150526163602
20150526164201
20150603152303
20150603152538
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY settings (id, roster_lock_date, drop_lowest_score, roster_lock_toggle, auto_promote_students, area_name, admin_name, admin_email, intro) FROM stdin;
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('settings_id_seq', 1, false);


--
-- Data for Name: student_quizzes; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY student_quizzes (id, student_id, quiz_id, num_correct, num_attempts, num_fouls, score) FROM stdin;
1	91	1	4	4	\N	90
2	92	1	3	3	\N	60
3	93	1	3	3	\N	60
4	94	1	2	2	\N	40
5	76	1	3	4	\N	60
6	77	1	0	0	\N	0
7	78	1	1	1	\N	20
8	35	1	4	4	\N	90
9	36	1	0	1	\N	0
10	37	1	1	2	\N	20
11	38	1	0	1	\N	0
12	73	2	4	4	\N	90
13	74	2	0	0	\N	0
14	75	2	2	4	\N	30
15	114	2	3	6	\N	40
16	115	2	2	3	\N	40
17	116	2	1	1	\N	20
18	117	2	0	0	\N	0
19	46	2	4	4	\N	90
20	47	2	2	2	\N	40
21	48	2	2	3	\N	40
22	49	2	3	3	\N	60
23	95	3	4	4	\N	90
24	96	3	1	1	\N	20
25	97	3	4	6	\N	70
26	98	3	2	2	\N	40
27	39	3	4	4	\N	90
28	40	3	3	3	\N	60
29	41	3	0	0	\N	0
30	64	3	2	2	\N	40
31	65	3	1	3	\N	10
32	66	3	1	2	\N	20
33	67	3	0	1	\N	0
34	68	3	1	1	\N	20
35	50	4	4	4	\N	90
36	51	4	0	1	\N	0
37	52	4	2	2	\N	40
38	53	4	2	2	\N	40
39	79	4	4	5	\N	80
40	80	4	0	0	\N	0
41	81	4	2	2	\N	40
42	82	4	0	2	\N	-10
43	57	4	3	4	\N	60
44	58	4	2	3	\N	40
45	59	4	0	0	\N	0
46	60	4	3	3	\N	60
47	8	5	3	4	\N	60
48	9	5	2	2	\N	40
49	10	5	3	3	\N	60
50	11	5	1	1	\N	20
51	12	5	2	2	\N	40
52	20	5	1	2	\N	20
53	21	5	1	1	\N	20
54	22	5	1	1	\N	20
55	13	5	4	5	\N	80
56	14	5	1	1	\N	20
57	15	5	0	1	\N	0
58	16	5	0	0	\N	0
59	87	6	4	5	\N	80
60	88	6	1	1	\N	20
61	89	6	3	5	\N	50
62	90	6	0	0	\N	0
63	110	6	4	4	\N	90
64	111	6	1	1	\N	20
65	112	6	2	2	\N	40
66	113	6	4	4	\N	90
67	123	6	4	4	\N	90
68	124	6	2	3	\N	40
69	125	6	1	1	\N	20
70	126	6	0	0	\N	0
71	17	7	4	5	\N	80
72	18	7	0	1	\N	0
73	19	7	0	1	\N	0
74	99	7	4	5	\N	80
75	100	7	2	2	\N	40
76	101	7	1	1	\N	20
77	102	7	4	4	\N	90
78	42	7	4	5	\N	80
79	43	7	2	2	\N	40
80	44	7	1	1	\N	20
81	45	7	2	2	\N	40
82	106	8	4	4	\N	90
83	107	8	2	2	\N	40
84	108	8	2	3	\N	40
85	109	8	0	0	\N	0
86	103	8	4	5	\N	80
87	104	8	2	2	\N	40
88	105	8	2	3	\N	40
89	1	8	4	6	\N	70
90	2	8	3	3	\N	60
91	3	8	1	3	\N	10
92	4	8	1	1	\N	20
93	5	9	1	1	\N	20
94	6	9	1	3	\N	10
95	7	9	4	6	\N	70
96	69	9	4	5	\N	80
97	70	9	3	3	\N	60
98	71	9	2	2	\N	40
99	72	9	0	0	\N	0
100	27	9	4	6	\N	70
101	28	9	0	2	\N	-10
102	29	9	4	4	\N	90
103	30	9	1	1	\N	20
104	31	9	0	2	\N	-10
105	61	10	2	3	\N	40
106	62	10	0	0	\N	0
107	63	10	1	1	\N	20
108	127	10	3	3	\N	60
109	128	10	1	2	\N	20
110	129	10	4	4	\N	90
111	130	10	0	1	\N	0
112	118	10	3	5	\N	50
113	119	10	1	1	\N	20
114	120	10	2	2	\N	40
115	121	10	4	6	\N	70
116	122	10	1	3	\N	10
117	23	11	3	4	\N	60
118	24	11	0	0	\N	0
119	25	11	1	2	\N	20
120	26	11	4	4	\N	90
121	54	11	3	6	\N	40
122	55	11	1	1	\N	20
123	56	11	1	1	\N	20
124	83	11	4	4	\N	90
125	84	11	0	0	\N	0
126	85	11	0	0	\N	0
127	86	11	1	2	\N	20
128	32	12	3	6	\N	40
129	33	12	1	1	\N	20
130	34	12	1	2	\N	20
131	54	12	2	4	\N	30
132	55	12	2	3	\N	40
133	56	12	2	2	\N	40
134	114	12	3	4	\N	60
135	115	12	2	2	\N	40
136	116	12	0	0	\N	0
137	117	12	0	1	\N	0
138	20	13	4	4	\N	90
139	21	13	2	2	\N	40
140	22	13	0	0	\N	0
141	50	13	4	5	\N	80
142	51	13	4	6	\N	70
143	52	13	1	3	\N	10
144	53	13	2	3	\N	40
145	118	13	3	3	\N	60
146	119	13	0	2	\N	-10
147	120	13	2	2	\N	40
148	121	13	1	1	\N	20
149	122	13	1	1	\N	20
150	69	14	2	4	\N	30
151	70	14	0	0	\N	0
152	71	14	0	0	\N	0
153	72	14	0	0	\N	0
154	57	14	3	4	\N	60
155	58	14	0	0	\N	0
156	59	14	3	4	\N	60
157	60	14	4	4	\N	90
158	32	14	4	6	\N	70
159	33	14	0	2	\N	-10
160	34	14	3	4	\N	60
161	1	15	4	4	\N	90
162	2	15	2	3	\N	40
163	3	15	1	2	\N	20
164	4	15	0	1	\N	0
165	127	15	1	3	\N	10
166	128	15	3	3	\N	60
167	129	15	0	0	\N	0
168	130	15	1	1	\N	20
169	87	15	3	6	\N	40
170	88	15	3	4	\N	60
171	89	15	4	4	\N	90
172	90	15	1	3	\N	10
173	35	16	4	5	\N	80
174	36	16	1	1	\N	20
175	37	16	0	2	\N	-10
176	38	16	0	0	\N	0
177	8	16	4	5	\N	80
178	9	16	0	1	\N	0
179	10	16	0	0	\N	0
180	11	16	1	3	\N	10
181	12	16	3	4	\N	60
182	79	16	4	4	\N	90
183	80	16	2	2	\N	40
184	81	16	1	2	\N	20
185	82	16	1	1	\N	20
186	42	17	4	5	\N	80
187	43	17	2	4	\N	30
188	44	17	0	1	\N	0
189	45	17	1	1	\N	20
190	103	17	0	0	\N	0
191	104	17	0	1	\N	0
192	105	17	0	1	\N	0
193	91	17	1	1	\N	20
194	92	17	3	3	\N	60
195	93	17	2	2	\N	40
196	94	17	0	0	\N	0
197	99	18	3	4	\N	60
198	100	18	4	4	\N	90
199	101	18	1	1	\N	20
200	102	18	0	0	\N	0
201	73	18	0	0	\N	0
202	74	18	2	4	\N	30
203	75	18	0	2	\N	-10
204	106	18	1	3	\N	10
205	107	18	4	5	\N	80
206	108	18	3	4	\N	60
207	109	18	0	0	\N	0
208	76	19	3	4	\N	60
209	77	19	2	2	\N	40
210	78	19	4	4	\N	90
211	46	19	3	4	\N	60
212	47	19	2	2	\N	40
213	48	19	1	2	\N	20
214	49	19	0	0	\N	0
215	27	19	4	4	\N	90
216	28	19	2	4	\N	30
217	29	19	0	1	\N	0
218	30	19	2	3	\N	40
219	31	19	3	5	\N	50
220	95	20	4	5	\N	80
221	96	20	3	3	\N	60
222	97	20	0	0	\N	0
223	98	20	2	2	\N	40
224	61	20	4	4	\N	90
225	62	20	0	0	\N	0
226	63	20	1	2	\N	20
227	123	20	4	6	\N	70
228	124	20	2	2	\N	40
229	125	20	2	2	\N	40
230	126	20	2	4	\N	30
231	110	21	2	3	\N	40
232	111	21	0	0	\N	0
233	112	21	0	0	\N	0
234	113	21	3	4	\N	60
235	83	21	4	5	\N	80
236	84	21	1	1	\N	20
237	85	21	1	2	\N	20
238	86	21	2	4	\N	30
239	23	21	0	0	\N	0
240	24	21	3	3	\N	60
241	25	21	1	1	\N	20
242	26	21	0	0	\N	0
243	17	22	3	5	\N	50
244	18	22	1	1	\N	20
245	19	22	0	0	\N	0
246	64	22	4	6	\N	70
247	65	22	0	0	\N	0
248	66	22	1	1	\N	20
249	67	22	0	0	\N	0
250	68	22	1	1	\N	20
251	5	22	4	5	\N	80
252	6	22	1	1	\N	20
253	7	22	0	0	\N	0
254	13	23	1	2	\N	20
255	14	23	1	2	\N	20
256	15	23	1	1	\N	20
257	16	23	1	3	\N	10
258	39	23	0	1	\N	0
259	40	23	3	3	\N	60
260	41	23	0	0	\N	0
261	32	23	4	6	\N	70
262	33	23	2	2	\N	40
263	34	23	0	0	\N	0
264	1	24	3	4	\N	60
265	2	24	2	3	\N	40
266	3	24	0	0	\N	0
267	4	24	0	1	\N	0
268	35	24	4	4	\N	90
269	36	24	0	0	\N	0
270	37	24	1	1	\N	20
271	38	24	2	3	\N	40
272	123	24	2	3	\N	40
273	124	24	0	0	\N	0
274	125	24	1	3	\N	10
275	126	24	2	2	\N	40
276	118	25	3	4	\N	60
277	119	25	3	3	\N	60
278	120	25	1	2	\N	20
279	121	25	2	3	\N	40
280	122	25	0	2	\N	-10
281	91	25	4	5	\N	80
282	92	25	1	1	\N	20
283	93	25	2	4	\N	30
284	94	25	2	3	\N	40
285	83	25	4	5	\N	80
286	84	25	2	3	\N	40
287	85	25	0	1	\N	0
288	86	25	0	0	\N	0
289	46	26	1	1	\N	20
290	47	26	0	1	\N	0
291	48	26	1	2	\N	20
292	49	26	4	4	\N	90
293	110	26	3	5	\N	50
294	111	26	0	1	\N	0
295	112	26	4	6	\N	70
296	113	26	4	4	\N	90
297	79	26	1	1	\N	20
298	80	26	4	4	\N	90
299	81	26	1	2	\N	20
300	82	26	0	0	\N	0
301	23	27	3	3	\N	60
302	24	27	0	0	\N	0
303	25	27	0	2	\N	-10
304	26	27	0	2	\N	-10
305	8	27	1	2	\N	20
306	9	27	4	4	\N	90
307	10	27	2	4	\N	30
308	11	27	0	2	\N	-10
309	12	27	1	1	\N	20
310	5	27	2	4	\N	30
311	6	27	2	4	\N	30
312	7	27	3	3	\N	60
313	17	28	2	4	\N	30
314	18	28	1	2	\N	20
315	19	28	3	3	\N	60
316	99	28	0	1	\N	0
317	100	28	0	1	\N	0
318	101	28	1	1	\N	20
319	102	28	2	3	\N	40
320	106	28	4	4	\N	90
321	107	28	1	1	\N	20
322	108	28	0	2	\N	-10
323	109	28	3	3	\N	60
324	127	29	4	5	\N	80
325	128	29	2	3	\N	40
326	129	29	1	1	\N	20
327	130	29	3	4	\N	60
328	20	29	1	2	\N	20
329	21	29	3	5	\N	50
330	22	29	0	0	\N	0
331	42	29	4	4	\N	90
332	43	29	1	1	\N	20
333	44	29	1	3	\N	10
334	45	29	2	2	\N	40
335	57	30	4	5	\N	80
336	58	30	1	1	\N	20
337	59	30	1	1	\N	20
338	60	30	3	5	\N	50
339	64	30	1	3	\N	10
340	65	30	0	0	\N	0
341	66	30	4	5	\N	80
342	67	30	4	4	\N	90
343	68	30	2	2	\N	40
344	27	30	3	3	\N	60
345	28	30	1	2	\N	20
346	29	30	2	3	\N	40
347	30	30	0	1	\N	0
348	31	30	3	5	\N	50
349	73	31	4	4	\N	90
350	74	31	1	1	\N	20
351	75	31	0	0	\N	0
352	76	31	3	6	\N	40
353	77	31	0	0	\N	0
354	78	31	2	2	\N	40
355	95	31	3	4	\N	60
356	96	31	0	0	\N	0
357	97	31	3	3	\N	60
358	98	31	4	4	\N	90
359	69	32	4	5	\N	80
360	70	32	0	2	\N	-10
361	71	32	4	4	\N	90
362	72	32	0	0	\N	0
363	114	32	3	4	\N	60
364	115	32	0	2	\N	-10
365	116	32	1	1	\N	20
366	117	32	2	2	\N	40
367	61	32	1	3	\N	10
368	62	32	1	3	\N	10
369	63	32	1	2	\N	20
370	50	33	3	5	\N	50
371	51	33	1	2	\N	20
372	52	33	0	2	\N	-10
373	53	33	0	0	\N	0
374	87	33	3	4	\N	60
375	88	33	1	1	\N	20
376	89	33	1	2	\N	20
377	90	33	0	0	\N	0
378	54	33	4	4	\N	90
379	55	33	4	4	\N	90
380	56	33	1	2	\N	20
381	103	34	3	5	\N	50
382	104	34	2	2	\N	40
383	105	34	0	2	\N	-10
384	39	34	3	5	\N	50
385	40	34	1	1	\N	20
386	41	34	1	1	\N	20
387	13	34	4	5	\N	80
388	14	34	0	0	\N	0
389	15	34	0	0	\N	0
390	16	34	3	4	\N	60
391	23	35	3	3	\N	60
392	24	35	1	2	\N	20
393	25	35	2	2	\N	40
394	26	35	0	0	\N	0
395	54	35	4	4	\N	90
396	55	35	2	3	\N	40
397	56	35	2	4	\N	30
398	103	35	2	4	\N	30
399	104	35	2	3	\N	40
400	105	35	4	4	\N	90
401	110	36	4	5	\N	80
402	111	36	0	0	\N	0
403	112	36	1	1	\N	20
404	113	36	0	0	\N	0
405	95	36	4	5	\N	80
406	96	36	0	0	\N	0
407	97	36	0	0	\N	0
408	98	36	1	1	\N	20
409	17	36	4	5	\N	80
410	18	36	4	4	\N	90
411	19	36	0	0	\N	0
412	1	37	3	5	\N	50
413	2	37	0	0	\N	0
414	3	37	0	0	\N	0
415	4	37	1	1	\N	20
416	39	37	3	4	\N	60
417	40	37	0	2	\N	-10
418	41	37	4	5	\N	80
419	8	37	4	6	\N	70
420	9	37	0	0	\N	0
421	10	37	2	2	\N	40
422	11	37	0	0	\N	0
423	12	37	0	0	\N	0
424	35	38	3	4	\N	60
425	36	38	1	2	\N	20
426	37	38	4	4	\N	90
427	38	38	0	0	\N	0
428	99	38	4	5	\N	80
429	100	38	0	0	\N	0
430	101	38	2	3	\N	40
431	102	38	1	1	\N	20
432	13	38	0	2	\N	-10
433	14	38	0	0	\N	0
434	15	38	0	0	\N	0
435	16	38	2	2	\N	40
436	32	39	4	4	\N	90
437	33	39	0	0	\N	0
438	34	39	1	1	\N	20
439	20	39	4	4	\N	90
440	21	39	2	4	\N	30
441	22	39	0	1	\N	0
442	76	39	1	3	\N	10
443	77	39	1	1	\N	20
444	78	39	3	3	\N	60
445	87	40	3	5	\N	50
446	88	40	3	3	\N	60
447	89	40	0	0	\N	0
448	90	40	0	0	\N	0
449	61	40	3	4	\N	60
450	62	40	1	3	\N	10
451	63	40	3	3	\N	60
452	69	40	3	4	\N	60
453	70	40	0	1	\N	0
454	71	40	1	1	\N	20
455	72	40	0	1	\N	0
456	42	41	2	4	\N	30
457	43	41	1	3	\N	10
458	44	41	2	2	\N	40
459	45	41	0	0	\N	0
460	57	41	4	5	\N	80
461	58	41	2	2	\N	40
462	59	41	1	3	\N	10
463	60	41	3	5	\N	50
464	127	41	4	5	\N	80
465	128	41	0	0	\N	0
466	129	41	1	1	\N	20
467	130	41	1	2	\N	20
468	27	42	3	5	\N	50
469	28	42	0	0	\N	0
470	29	42	0	0	\N	0
471	30	42	4	6	\N	70
472	31	42	0	0	\N	0
473	83	42	3	4	\N	60
474	84	42	0	2	\N	-10
475	85	42	0	1	\N	0
476	86	42	1	2	\N	20
477	73	42	3	5	\N	50
478	74	42	0	0	\N	0
479	75	42	2	2	\N	40
480	46	43	2	3	\N	40
481	47	43	1	1	\N	20
482	48	43	0	0	\N	0
483	49	43	0	0	\N	0
484	50	43	3	4	\N	60
485	51	43	2	3	\N	40
486	52	43	1	3	\N	10
487	53	43	1	1	\N	20
488	91	43	0	3	\N	-20
489	92	43	1	1	\N	20
490	93	43	0	1	\N	0
491	94	43	0	0	\N	0
492	64	44	2	2	\N	40
493	65	44	1	1	\N	20
494	66	44	4	4	\N	90
495	67	44	2	4	\N	30
496	68	44	2	3	\N	40
497	114	44	3	3	\N	60
498	115	44	0	0	\N	0
499	116	44	0	2	\N	-10
500	117	44	0	1	\N	0
501	123	44	2	3	\N	40
502	124	44	1	1	\N	20
503	125	44	3	3	\N	60
504	126	44	4	4	\N	90
505	106	45	4	6	\N	70
506	107	45	0	0	\N	0
507	108	45	2	2	\N	40
508	109	45	2	2	\N	40
509	79	45	4	4	\N	90
510	80	45	2	2	\N	40
511	81	45	2	2	\N	40
512	82	45	0	1	\N	0
513	5	45	3	5	\N	50
514	6	45	2	3	\N	40
515	7	45	4	5	\N	80
516	118	46	0	1	\N	0
517	119	46	2	3	\N	40
518	120	46	0	1	\N	0
519	121	46	2	2	\N	40
520	122	46	1	2	\N	20
521	35	46	3	3	\N	60
522	36	46	1	2	\N	20
523	37	46	1	1	\N	20
524	38	46	2	2	\N	40
525	61	46	1	1	\N	20
526	62	46	1	1	\N	20
527	63	46	1	3	\N	10
528	114	47	4	5	\N	80
529	115	47	3	3	\N	60
530	116	47	0	0	\N	0
531	117	47	2	2	\N	40
532	17	47	1	2	\N	20
533	18	47	0	1	\N	0
534	19	47	2	3	\N	40
535	76	47	3	4	\N	60
536	77	47	1	2	\N	20
537	78	47	4	5	\N	80
538	32	48	4	5	\N	80
539	33	48	0	2	\N	-10
540	34	48	3	3	\N	60
541	83	48	4	4	\N	90
542	84	48	1	1	\N	20
543	85	48	1	1	\N	20
544	86	48	3	3	\N	60
545	39	48	3	6	\N	40
546	40	48	2	2	\N	40
547	41	48	1	3	\N	10
548	13	49	1	1	\N	20
549	14	49	1	1	\N	20
550	15	49	0	0	\N	0
551	16	49	2	3	\N	40
552	54	49	1	1	\N	20
553	55	49	2	2	\N	40
554	56	49	1	1	\N	20
555	1	49	4	5	\N	80
556	2	49	1	3	\N	10
557	3	49	1	1	\N	20
558	4	49	0	0	\N	0
559	20	50	3	5	\N	50
560	21	50	3	3	\N	60
561	22	50	1	1	\N	20
562	46	50	4	4	\N	90
563	47	50	4	4	\N	90
564	48	50	4	4	\N	90
565	49	50	0	0	\N	0
566	73	50	3	3	\N	60
567	74	50	3	3	\N	60
568	75	50	1	1	\N	20
569	23	51	0	1	\N	0
570	24	51	0	0	\N	0
571	25	51	3	4	\N	60
572	26	51	1	1	\N	20
573	57	51	4	6	\N	70
574	58	51	1	1	\N	20
575	59	51	3	3	\N	60
576	60	51	2	2	\N	40
577	110	51	0	1	\N	0
578	111	51	2	4	\N	30
579	112	51	3	5	\N	50
580	113	51	4	4	\N	90
581	8	52	1	2	\N	20
582	9	52	2	3	\N	40
583	10	52	0	0	\N	0
584	11	52	0	0	\N	0
585	12	52	0	0	\N	0
586	50	52	4	5	\N	80
587	51	52	1	1	\N	20
588	52	52	0	0	\N	0
589	53	52	4	5	\N	80
590	95	52	4	6	\N	70
591	96	52	2	3	\N	40
592	97	52	0	0	\N	0
593	98	52	0	1	\N	0
594	127	53	2	4	\N	30
595	128	53	3	3	\N	60
596	129	53	3	3	\N	60
597	130	53	0	0	\N	0
598	69	53	2	3	\N	40
599	70	53	4	4	\N	90
600	71	53	3	3	\N	60
601	72	53	1	2	\N	20
602	106	53	4	4	\N	90
603	107	53	0	0	\N	0
604	108	53	3	4	\N	60
605	109	53	0	1	\N	0
606	64	54	4	5	\N	80
607	65	54	0	0	\N	0
608	66	54	2	3	\N	40
609	67	54	1	2	\N	20
610	68	54	1	1	\N	20
611	5	54	4	5	\N	80
612	6	54	1	1	\N	20
613	7	54	1	1	\N	20
614	99	54	3	5	\N	50
615	100	54	3	3	\N	60
616	101	54	1	1	\N	20
617	102	54	4	4	\N	90
618	123	55	4	4	\N	90
619	124	55	3	4	\N	60
620	125	55	1	1	\N	20
621	126	55	1	1	\N	20
622	103	55	1	3	\N	10
623	104	55	0	0	\N	0
624	105	55	3	3	\N	60
625	27	55	3	5	\N	50
626	28	55	0	2	\N	-10
627	29	55	3	3	\N	60
628	30	55	1	1	\N	20
629	31	55	1	1	\N	20
630	91	56	3	4	\N	60
631	92	56	0	0	\N	0
632	93	56	4	4	\N	90
633	94	56	0	2	\N	-10
634	118	56	3	6	\N	40
635	119	56	1	1	\N	20
636	120	56	0	0	\N	0
637	121	56	1	1	\N	20
638	122	56	1	2	\N	20
639	42	56	0	1	\N	0
640	43	56	1	1	\N	20
641	44	56	3	3	\N	60
642	45	56	1	1	\N	20
643	79	57	4	4	\N	90
644	80	57	1	2	\N	20
645	81	57	2	2	\N	40
646	82	57	2	2	\N	40
647	87	57	4	5	\N	80
648	88	57	2	2	\N	40
649	89	57	0	1	\N	0
650	90	57	2	3	\N	40
651	39	57	3	5	\N	50
652	40	57	1	2	\N	20
653	41	57	0	2	\N	-10
654	103	58	1	2	\N	20
655	104	58	4	6	\N	70
656	105	58	0	0	\N	0
657	1	58	4	4	\N	90
658	2	58	4	4	\N	90
659	3	58	1	2	\N	20
660	4	58	1	3	\N	10
661	50	58	4	5	\N	80
662	51	58	1	1	\N	20
663	52	58	1	3	\N	10
664	53	58	3	4	\N	60
665	110	59	4	6	\N	70
666	111	59	3	4	\N	60
667	112	59	4	4	\N	90
668	113	59	3	3	\N	60
669	42	59	2	4	\N	30
670	43	59	1	2	\N	20
671	44	59	1	1	\N	20
672	45	59	1	3	\N	10
673	118	59	4	5	\N	80
674	119	59	0	1	\N	0
675	120	59	2	2	\N	40
676	121	59	3	3	\N	60
677	122	59	2	2	\N	40
678	54	60	4	6	\N	70
679	55	60	0	0	\N	0
680	56	60	0	0	\N	0
681	91	60	3	4	\N	60
682	92	60	0	0	\N	0
683	93	60	1	2	\N	20
684	94	60	1	1	\N	20
685	106	60	2	3	\N	40
686	107	60	1	2	\N	20
687	108	60	2	3	\N	40
688	109	60	2	2	\N	40
689	32	61	2	3	\N	40
690	33	61	4	6	\N	70
691	34	61	2	2	\N	40
692	20	61	3	6	\N	40
693	21	61	1	1	\N	20
694	22	61	0	0	\N	0
695	64	61	3	3	\N	60
696	65	61	0	0	\N	0
697	66	61	4	4	\N	90
698	67	61	0	2	\N	-10
699	68	61	0	1	\N	0
700	35	62	4	6	\N	70
701	36	62	0	1	\N	0
702	37	62	2	2	\N	40
703	38	62	2	2	\N	40
704	23	62	0	0	\N	0
705	24	62	0	1	\N	0
706	25	62	0	0	\N	0
707	26	62	4	4	\N	90
708	57	62	4	5	\N	80
709	58	62	1	2	\N	20
710	59	62	1	1	\N	20
711	60	62	3	3	\N	60
712	5	63	3	5	\N	50
713	6	63	0	0	\N	0
714	7	63	0	0	\N	0
715	27	63	3	5	\N	50
716	28	63	1	1	\N	20
717	29	63	1	1	\N	20
718	30	63	3	3	\N	60
719	31	63	0	0	\N	0
720	99	63	0	1	\N	0
721	100	63	1	1	\N	20
722	101	63	1	1	\N	20
723	102	63	4	5	\N	80
724	69	64	4	5	\N	80
725	70	64	2	2	\N	40
726	71	64	1	2	\N	20
727	72	64	1	1	\N	20
728	79	64	2	3	\N	40
729	80	64	3	3	\N	60
730	81	64	2	4	\N	30
731	82	64	2	2	\N	40
732	73	64	2	3	\N	40
733	74	64	0	0	\N	0
734	75	64	1	1	\N	20
735	83	65	3	4	\N	60
736	84	65	3	3	\N	60
737	85	65	0	0	\N	0
738	86	65	1	1	\N	20
739	87	65	4	5	\N	80
740	88	65	2	3	\N	40
741	89	65	2	2	\N	40
742	90	65	2	2	\N	40
743	95	65	3	4	\N	60
744	96	65	2	2	\N	40
745	97	65	1	3	\N	10
746	98	65	1	2	\N	20
747	76	66	0	3	\N	-20
748	77	66	2	4	\N	30
749	78	66	4	5	\N	80
750	127	66	4	5	\N	80
751	128	66	0	2	\N	-10
752	129	66	4	4	\N	90
753	130	66	0	2	\N	-10
754	13	66	4	5	\N	80
755	14	66	1	1	\N	20
756	15	66	3	3	\N	60
757	16	66	1	1	\N	20
758	46	67	3	3	\N	60
759	47	67	1	1	\N	20
760	48	67	2	3	\N	40
761	49	67	1	1	\N	20
762	61	67	4	5	\N	80
763	62	67	1	2	\N	20
764	63	67	1	3	\N	10
765	114	67	4	5	\N	80
766	115	67	1	1	\N	20
767	116	67	1	1	\N	20
768	117	67	1	2	\N	20
769	17	68	3	4	\N	60
770	18	68	1	1	\N	20
771	19	68	1	2	\N	20
772	8	68	4	4	\N	90
773	9	68	1	1	\N	20
774	10	68	1	1	\N	20
775	11	68	1	3	\N	10
776	12	68	2	2	\N	40
777	123	68	3	4	\N	60
778	124	68	3	3	\N	60
779	125	68	1	1	\N	20
780	126	68	0	2	\N	-10
781	139	73	3	4	\N	60
782	140	73	0	0	\N	0
783	146	73	3	6	\N	40
784	147	73	1	2	\N	20
785	148	73	2	3	\N	40
786	198	73	4	4	\N	90
787	199	73	0	0	\N	0
788	200	73	4	4	\N	90
789	201	73	3	3	\N	60
790	158	74	4	4	\N	90
791	159	74	1	3	\N	10
792	160	74	1	2	\N	20
793	138	74	3	3	\N	60
794	186	74	4	5	\N	80
795	187	74	1	2	\N	20
796	188	74	1	3	\N	10
797	189	74	1	1	\N	20
798	180	75	3	4	\N	60
799	181	75	2	2	\N	40
800	161	75	3	5	\N	50
801	162	75	1	1	\N	20
802	163	75	2	2	\N	40
803	204	75	0	1	\N	0
804	205	75	0	0	\N	0
805	206	75	1	1	\N	20
806	152	76	1	3	\N	10
807	153	76	1	1	\N	20
808	154	76	1	2	\N	20
809	190	76	3	3	\N	60
810	191	76	2	2	\N	40
811	192	76	2	2	\N	40
812	174	76	4	4	\N	90
813	175	76	2	2	\N	40
814	207	77	4	4	\N	90
815	208	77	2	3	\N	40
816	209	77	4	4	\N	90
817	210	77	2	2	\N	40
818	211	77	0	0	\N	0
819	212	77	3	5	\N	50
820	213	77	4	4	\N	90
821	214	77	0	1	\N	0
822	202	78	3	5	\N	50
823	203	78	3	4	\N	60
824	134	78	2	3	\N	40
825	135	78	4	4	\N	90
826	136	78	0	0	\N	0
827	137	78	1	3	\N	10
828	171	78	4	5	\N	80
829	172	78	0	1	\N	0
830	173	78	0	0	\N	0
831	141	79	4	5	\N	80
832	142	79	0	0	\N	0
833	143	79	0	0	\N	0
834	184	79	4	4	\N	90
835	185	79	1	2	\N	20
836	176	79	3	4	\N	60
837	177	79	1	1	\N	20
838	178	79	1	1	\N	20
839	179	79	4	4	\N	90
840	182	80	2	3	\N	40
841	183	80	4	4	\N	90
842	131	80	3	4	\N	60
843	132	80	0	2	\N	-10
844	133	80	2	2	\N	40
845	155	80	3	3	\N	60
846	156	80	2	2	\N	40
847	157	80	1	1	\N	20
848	144	81	0	1	\N	0
849	145	81	0	0	\N	0
850	149	81	0	0	\N	0
851	150	81	2	2	\N	40
852	151	81	4	4	\N	90
853	193	81	4	4	\N	90
854	194	81	3	3	\N	60
855	169	82	3	4	\N	60
856	170	82	1	1	\N	20
857	167	82	0	0	\N	0
858	168	82	0	1	\N	0
859	164	82	3	5	\N	50
860	165	82	2	2	\N	40
861	166	82	1	1	\N	20
862	195	83	1	2	\N	20
863	196	83	0	0	\N	0
864	197	83	2	4	\N	30
865	180	83	3	5	\N	50
866	181	83	1	1	\N	20
867	158	83	3	4	\N	60
868	159	83	1	1	\N	20
869	160	83	1	1	\N	20
870	152	84	4	5	\N	80
871	153	84	4	4	\N	90
872	154	84	0	0	\N	0
873	209	84	1	1	\N	20
874	210	84	1	1	\N	20
875	211	84	1	2	\N	20
876	193	84	4	5	\N	80
877	194	84	1	1	\N	20
878	202	85	3	4	\N	60
879	203	85	3	3	\N	60
880	134	85	3	3	\N	60
881	135	85	2	2	\N	40
882	136	85	0	0	\N	0
883	137	85	0	0	\N	0
884	186	85	1	2	\N	20
885	187	85	1	1	\N	20
886	188	85	0	1	\N	0
887	189	85	4	4	\N	90
888	195	86	3	4	\N	60
889	196	86	0	1	\N	0
890	197	86	4	4	\N	90
891	155	86	1	2	\N	20
892	156	86	1	1	\N	20
893	157	86	0	0	\N	0
894	138	86	0	2	\N	-10
895	176	87	4	6	\N	70
896	177	87	0	0	\N	0
897	178	87	4	4	\N	90
898	179	87	3	4	\N	60
899	182	87	4	4	\N	90
900	183	87	1	2	\N	20
901	169	87	4	4	\N	90
902	170	87	1	3	\N	10
903	131	88	4	4	\N	90
904	132	88	0	1	\N	0
905	133	88	0	1	\N	0
906	212	88	3	3	\N	60
907	213	88	0	0	\N	0
908	214	88	0	2	\N	-10
909	171	88	0	0	\N	0
910	172	88	1	3	\N	10
911	173	88	0	0	\N	0
912	144	89	3	3	\N	60
913	145	89	0	0	\N	0
914	141	89	4	4	\N	90
915	142	89	2	4	\N	30
916	143	89	0	0	\N	0
917	146	89	1	2	\N	20
918	147	89	3	4	\N	60
919	148	89	2	2	\N	40
920	204	90	2	5	\N	20
921	205	90	1	2	\N	20
922	206	90	0	0	\N	0
923	190	90	3	6	\N	40
924	191	90	4	4	\N	90
925	192	90	1	1	\N	20
926	139	90	2	4	\N	30
927	140	90	0	0	\N	0
928	198	91	3	3	\N	60
929	199	91	1	1	\N	20
930	200	91	1	1	\N	20
931	201	91	1	1	\N	20
932	184	91	4	4	\N	90
933	185	91	2	2	\N	40
934	149	91	0	2	\N	-10
935	150	91	1	1	\N	20
936	151	91	0	1	\N	0
937	161	92	0	1	\N	0
938	162	92	4	4	\N	90
939	163	92	1	1	\N	20
940	174	92	1	1	\N	20
941	175	92	4	4	\N	90
942	164	92	4	5	\N	80
943	165	92	2	2	\N	40
944	166	92	3	4	\N	60
945	207	93	3	5	\N	50
946	208	93	0	0	\N	0
947	167	93	4	5	\N	80
948	168	93	0	0	\N	0
949	174	93	3	3	\N	60
950	175	93	1	1	\N	20
951	167	94	3	4	\N	60
952	168	94	1	3	\N	10
953	155	94	4	6	\N	70
954	156	94	3	4	\N	60
955	157	94	3	3	\N	60
956	204	94	4	5	\N	80
957	205	94	0	0	\N	0
958	206	94	2	3	\N	40
959	209	95	3	3	\N	60
960	210	95	1	1	\N	20
961	211	95	1	3	\N	10
962	182	95	4	4	\N	90
963	183	95	2	2	\N	40
964	164	95	2	2	\N	40
965	165	95	4	4	\N	90
966	166	95	0	1	\N	0
967	171	96	3	4	\N	60
968	172	96	1	1	\N	20
969	173	96	0	0	\N	0
970	139	96	4	4	\N	90
971	140	96	0	2	\N	-10
972	169	96	4	4	\N	90
973	170	96	0	0	\N	0
974	186	97	3	4	\N	60
975	187	97	3	5	\N	50
976	188	97	2	2	\N	40
977	189	97	2	2	\N	40
978	146	97	3	6	\N	40
979	147	97	0	1	\N	0
980	148	97	1	3	\N	10
981	144	97	2	2	\N	40
982	145	97	1	1	\N	20
983	180	98	4	5	\N	80
984	181	98	1	1	\N	20
985	131	98	3	4	\N	60
986	132	98	2	2	\N	40
987	133	98	0	0	\N	0
988	202	98	1	2	\N	20
989	203	98	1	1	\N	20
990	141	99	4	6	\N	70
991	142	99	1	1	\N	20
992	143	99	1	3	\N	10
993	198	99	4	5	\N	80
994	199	99	0	1	\N	0
995	200	99	0	0	\N	0
996	201	99	0	2	\N	-10
997	190	99	3	3	\N	60
998	191	99	1	2	\N	20
999	192	99	0	1	\N	0
1000	152	100	4	5	\N	80
1001	153	100	0	0	\N	0
1002	154	100	2	3	\N	40
1003	161	100	3	5	\N	50
1004	162	100	2	3	\N	40
1005	163	100	0	0	\N	0
1006	149	100	4	4	\N	90
1007	150	100	4	4	\N	90
1008	151	100	1	2	\N	20
1009	138	101	3	4	\N	60
1010	176	101	1	4	\N	0
1011	177	101	0	2	\N	-10
1012	178	101	0	2	\N	-10
1013	179	101	2	2	\N	40
1014	184	101	4	4	\N	90
1015	185	101	1	2	\N	20
1016	193	102	4	4	\N	90
1017	194	102	3	3	\N	60
1018	134	102	4	4	\N	90
1019	135	102	3	5	\N	50
1020	136	102	2	4	\N	30
1021	137	102	2	2	\N	40
1022	212	102	3	3	\N	60
1023	213	102	0	0	\N	0
1024	214	102	0	1	\N	0
1025	158	103	4	5	\N	80
1026	159	103	1	3	\N	10
1027	160	103	0	0	\N	0
1028	195	103	3	4	\N	60
1029	196	103	1	2	\N	20
1030	197	103	1	3	\N	10
1031	207	103	3	4	\N	60
1032	208	103	0	0	\N	0
1033	152	104	4	4	\N	90
1034	153	104	2	2	\N	40
1035	154	104	0	0	\N	0
1036	202	104	4	5	\N	80
1037	203	104	3	3	\N	60
1038	146	104	4	6	\N	70
1039	147	104	1	3	\N	10
1040	148	104	3	3	\N	60
1041	155	105	2	3	\N	40
1042	156	105	2	2	\N	40
1043	157	105	2	3	\N	40
1044	209	105	3	3	\N	60
1045	210	105	2	2	\N	40
1046	211	105	0	2	\N	-10
1047	195	105	4	6	\N	70
1048	196	105	1	2	\N	20
1049	197	105	3	3	\N	60
1050	176	106	4	4	\N	90
1051	177	106	1	2	\N	20
1052	178	106	3	4	\N	60
1053	179	106	3	3	\N	60
1054	164	106	4	6	\N	70
1055	165	106	0	1	\N	0
1056	166	106	0	1	\N	0
1057	169	106	3	5	\N	50
1058	170	106	3	3	\N	60
1059	141	107	4	6	\N	70
1060	142	107	1	1	\N	20
1061	143	107	2	2	\N	40
1062	134	107	0	1	\N	0
1063	135	107	1	3	\N	10
1064	136	107	1	1	\N	20
1065	137	107	0	0	\N	0
1066	149	107	4	5	\N	80
1067	150	107	0	0	\N	0
1068	151	107	1	1	\N	20
1069	204	108	3	6	\N	40
1070	205	108	1	2	\N	20
1071	206	108	0	0	\N	0
1072	144	108	4	4	\N	90
1073	145	108	0	2	\N	-10
1074	182	108	4	4	\N	90
1075	183	108	2	3	\N	40
1076	193	109	3	6	\N	40
1077	194	109	0	0	\N	0
1078	139	109	1	4	\N	0
1079	140	109	0	1	\N	0
1080	158	109	4	4	\N	90
1081	159	109	3	3	\N	60
1082	160	109	1	1	\N	20
1083	180	110	1	2	\N	20
1084	181	110	1	1	\N	20
1085	186	110	4	5	\N	80
1086	187	110	0	1	\N	0
1087	188	110	3	3	\N	60
1088	189	110	3	4	\N	60
1089	198	110	0	0	\N	0
1090	199	110	2	2	\N	40
1091	200	110	1	2	\N	20
1092	201	110	3	5	\N	50
1093	184	111	3	4	\N	60
1094	185	111	0	0	\N	0
1095	207	111	3	3	\N	60
1096	208	111	1	2	\N	20
1097	167	111	4	4	\N	90
1098	168	111	1	1	\N	20
1099	171	112	1	2	\N	20
1100	172	112	4	4	\N	90
1101	173	112	1	3	\N	10
1102	212	112	3	4	\N	60
1103	213	112	1	1	\N	20
1104	214	112	2	2	\N	40
1105	161	112	0	0	\N	0
1106	162	112	0	0	\N	0
1107	163	112	2	2	\N	40
1108	174	113	4	6	\N	70
1109	175	113	3	3	\N	60
1110	190	113	2	2	\N	40
1111	191	113	3	3	\N	60
1112	192	113	0	0	\N	0
1113	131	113	4	5	\N	80
1114	132	113	2	2	\N	40
1115	133	113	3	3	\N	60
1116	138	114	3	5	\N	50
1117	202	114	0	1	\N	0
1118	203	114	2	2	\N	40
1119	149	114	4	5	\N	80
1120	150	114	1	1	\N	20
1121	151	114	1	1	\N	20
1122	169	115	0	1	\N	0
1123	170	115	1	1	\N	20
1124	186	115	4	4	\N	90
1125	187	115	1	2	\N	20
1126	188	115	0	2	\N	-10
1127	189	115	0	1	\N	0
1128	161	115	0	1	\N	0
1129	162	115	0	0	\N	0
1130	163	115	3	4	\N	60
1131	158	116	4	4	\N	90
1132	159	116	1	1	\N	20
1133	160	116	0	0	\N	0
1134	182	116	3	6	\N	40
1135	183	116	1	1	\N	20
1136	164	116	3	5	\N	50
1137	165	116	4	6	\N	70
1138	166	116	0	0	\N	0
1139	209	117	2	2	\N	40
1140	210	117	1	2	\N	20
1141	211	117	0	1	\N	0
1142	184	117	4	4	\N	90
1143	185	117	1	2	\N	20
1144	141	117	3	4	\N	60
1145	142	117	0	0	\N	0
1146	143	117	2	3	\N	40
1147	204	118	4	6	\N	70
1148	205	118	0	2	\N	-10
1149	206	118	2	2	\N	40
1150	193	118	4	5	\N	80
1151	194	118	1	1	\N	20
1152	180	118	4	5	\N	80
1153	181	118	1	1	\N	20
1154	152	119	3	3	\N	60
1155	153	119	0	0	\N	0
1156	154	119	0	2	\N	-10
1157	176	119	2	4	\N	30
1158	177	119	0	0	\N	0
1159	178	119	1	1	\N	20
1160	179	119	1	2	\N	20
1161	167	119	2	2	\N	40
1162	168	119	1	2	\N	20
1163	144	120	3	4	\N	60
1164	145	120	1	1	\N	20
1165	174	120	3	6	\N	40
1166	175	120	2	2	\N	40
1167	155	120	3	4	\N	60
1168	156	120	0	0	\N	0
1169	157	120	0	1	\N	0
1170	198	121	4	5	\N	80
1171	199	121	0	1	\N	0
1172	200	121	0	1	\N	0
1173	201	121	3	4	\N	60
1174	138	121	1	4	\N	0
1175	190	121	2	4	\N	30
1176	191	121	3	4	\N	60
1177	192	121	2	3	\N	40
1178	131	122	3	3	\N	60
1179	132	122	2	2	\N	40
1180	133	122	0	0	\N	0
1181	139	122	3	3	\N	60
1182	140	122	4	4	\N	90
1183	146	122	3	3	\N	60
1184	147	122	3	3	\N	60
1185	148	122	2	4	\N	30
1186	134	123	0	1	\N	0
1187	135	123	4	4	\N	90
1188	136	123	1	1	\N	20
1189	137	123	2	2	\N	40
1190	212	123	3	6	\N	40
1191	213	123	0	0	\N	0
1192	214	123	2	2	\N	40
1193	171	123	3	4	\N	60
1194	172	123	0	0	\N	0
1195	173	123	0	2	\N	-10
1196	195	124	2	3	\N	40
1197	196	124	1	1	\N	20
1198	197	124	0	0	\N	0
1199	207	124	3	5	\N	50
1200	208	124	2	2	\N	40
1201	186	124	3	3	\N	60
1202	187	124	0	2	\N	-10
1203	188	124	4	4	\N	90
1204	189	124	4	6	\N	70
1205	169	125	3	5	\N	50
1206	170	125	0	0	\N	0
1207	195	125	4	5	\N	80
1208	196	125	2	3	\N	40
1209	197	125	1	2	\N	20
1210	176	125	1	2	\N	20
1211	177	125	1	1	\N	20
1212	178	125	1	1	\N	20
1213	179	125	2	4	\N	30
1214	202	126	3	4	\N	60
1215	203	126	3	3	\N	60
1216	155	126	4	4	\N	90
1217	156	126	1	1	\N	20
1218	157	126	4	6	\N	70
1219	198	126	4	4	\N	90
1220	199	126	1	3	\N	10
1221	200	126	0	0	\N	0
1222	201	126	1	3	\N	10
1223	149	127	4	5	\N	80
1224	150	127	0	2	\N	-10
1225	151	127	3	3	\N	60
1226	164	127	4	6	\N	70
1227	165	127	3	5	\N	50
1228	166	127	0	0	\N	0
1229	171	127	3	4	\N	60
1230	172	127	1	1	\N	20
1231	173	127	1	1	\N	20
1232	180	128	1	2	\N	20
1233	181	128	0	0	\N	0
1234	158	128	2	2	\N	40
1235	159	128	3	3	\N	60
1236	160	128	1	1	\N	20
1237	161	128	0	0	\N	0
1238	162	128	2	2	\N	40
1239	163	128	1	1	\N	20
1240	152	129	4	5	\N	80
1241	153	129	0	0	\N	0
1242	154	129	0	1	\N	0
1243	204	129	4	6	\N	70
1244	205	129	4	4	\N	90
1245	206	129	1	3	\N	10
1246	138	129	4	5	\N	80
1247	144	130	4	5	\N	80
1248	145	130	2	2	\N	40
1249	190	130	1	1	\N	20
1250	191	130	1	1	\N	20
1251	192	130	0	0	\N	0
1252	212	130	3	4	\N	60
1253	213	130	1	1	\N	20
1254	214	130	4	5	\N	80
1255	193	131	0	1	\N	0
1256	194	131	1	1	\N	20
1257	146	131	3	5	\N	50
1258	147	131	2	2	\N	40
1259	148	131	0	1	\N	0
1260	131	131	0	1	\N	0
1261	132	131	4	5	\N	80
1262	133	131	1	1	\N	20
1263	174	132	2	3	\N	40
1264	175	132	1	2	\N	20
1265	184	132	3	6	\N	40
1266	185	132	1	3	\N	10
1267	207	132	1	2	\N	20
1268	208	132	3	5	\N	50
1269	141	133	4	4	\N	90
1270	142	133	3	3	\N	60
1271	143	133	2	4	\N	30
1272	209	133	3	4	\N	60
1273	210	133	4	5	\N	80
1274	211	133	1	2	\N	20
1275	167	133	4	5	\N	80
1276	168	133	0	0	\N	0
1277	182	134	4	5	\N	80
1278	183	134	0	0	\N	0
1279	139	134	4	5	\N	80
1280	140	134	4	4	\N	90
1281	134	134	3	3	\N	60
1282	135	134	4	4	\N	90
1283	136	134	1	1	\N	20
1284	137	134	0	0	\N	0
1285	266	136	3	4	\N	60
1286	267	136	0	0	\N	0
1287	268	136	3	3	\N	60
1288	232	136	3	5	\N	50
1289	233	136	0	2	\N	-10
1290	234	136	0	0	\N	0
1291	260	136	4	5	\N	80
1292	261	136	3	3	\N	60
1293	262	136	2	2	\N	40
1294	256	137	4	4	\N	90
1295	257	137	1	1	\N	20
1296	258	137	4	4	\N	90
1297	259	137	2	2	\N	40
1298	238	137	3	5	\N	50
1299	239	137	1	3	\N	10
1300	240	137	1	1	\N	20
1301	241	137	1	2	\N	20
1302	228	137	3	4	\N	60
1303	229	137	2	3	\N	40
1304	230	137	1	2	\N	20
1305	231	137	0	0	\N	0
1306	218	138	4	5	\N	80
1307	219	138	4	5	\N	80
1308	220	138	0	1	\N	0
1309	253	138	2	3	\N	40
1310	254	138	1	1	\N	20
1311	255	138	2	3	\N	40
1312	249	138	4	4	\N	90
1313	250	138	0	0	\N	0
1314	251	138	0	0	\N	0
1315	252	138	0	0	\N	0
1316	263	139	4	5	\N	80
1317	264	139	0	2	\N	-10
1318	265	139	1	1	\N	20
1319	224	139	4	5	\N	80
1320	225	139	3	5	\N	50
1321	226	139	0	1	\N	0
1322	227	139	1	1	\N	20
1323	235	139	4	5	\N	80
1324	236	139	0	0	\N	0
1325	237	139	2	3	\N	40
1326	245	140	1	3	\N	10
1327	246	140	2	2	\N	40
1328	247	140	2	3	\N	40
1329	248	140	2	2	\N	40
1330	215	140	3	3	\N	60
1331	216	140	3	3	\N	60
1332	217	140	0	0	\N	0
1333	242	140	3	4	\N	60
1334	243	140	3	3	\N	60
1335	244	140	2	3	\N	40
1336	221	141	4	5	\N	80
1337	222	141	0	0	\N	0
1338	223	141	0	0	\N	0
1339	269	141	4	5	\N	80
1340	270	141	3	3	\N	60
1341	271	141	1	1	\N	20
1342	272	141	4	6	\N	70
1343	256	141	3	6	\N	40
1344	257	141	0	0	\N	0
1345	258	141	3	3	\N	60
1346	259	141	1	3	\N	10
1347	218	142	3	4	\N	60
1348	219	142	0	1	\N	0
1349	220	142	1	1	\N	20
1350	235	142	2	2	\N	40
1351	236	142	0	0	\N	0
1352	237	142	1	1	\N	20
1353	249	142	3	6	\N	40
1354	250	142	0	0	\N	0
1355	251	142	1	3	\N	10
1356	252	142	2	2	\N	40
1357	232	143	1	3	\N	10
1358	233	143	0	1	\N	0
1359	234	143	0	0	\N	0
1360	228	143	3	4	\N	60
1361	229	143	4	4	\N	90
1362	230	143	3	3	\N	60
1363	231	143	1	2	\N	20
1364	221	143	2	4	\N	30
1365	222	143	1	1	\N	20
1366	223	143	0	0	\N	0
1367	263	144	3	3	\N	60
1368	264	144	0	0	\N	0
1369	265	144	2	2	\N	40
1370	224	144	4	5	\N	80
1371	225	144	0	1	\N	0
1372	226	144	0	0	\N	0
1373	227	144	2	2	\N	40
1374	238	144	4	6	\N	70
1375	239	144	0	0	\N	0
1376	240	144	2	2	\N	40
1377	241	144	0	0	\N	0
1378	215	145	4	4	\N	90
1379	216	145	1	1	\N	20
1380	217	145	3	3	\N	60
1381	269	145	4	4	\N	90
1382	270	145	1	1	\N	20
1383	271	145	4	4	\N	90
1384	272	145	4	4	\N	90
1385	253	145	4	4	\N	90
1386	254	145	1	1	\N	20
1387	255	145	4	5	\N	80
1388	266	146	3	5	\N	50
1389	267	146	1	2	\N	20
1390	268	146	3	3	\N	60
1391	260	146	4	6	\N	70
1392	261	146	2	2	\N	40
1393	262	146	1	1	\N	20
1394	245	146	3	4	\N	60
1395	246	146	0	0	\N	0
1396	247	146	0	0	\N	0
1397	248	146	1	1	\N	20
1398	242	147	3	4	\N	60
1399	243	147	1	2	\N	20
1400	244	147	4	4	\N	90
1401	256	147	3	5	\N	50
1402	257	147	1	1	\N	20
1403	258	147	0	2	\N	-10
1404	259	147	1	1	\N	20
1405	242	147	4	5	\N	80
1406	243	147	2	2	\N	40
1407	244	147	0	0	\N	0
1408	235	148	4	4	\N	90
1409	236	148	3	4	\N	60
1410	237	148	0	1	\N	0
1411	260	148	3	6	\N	40
1412	261	148	4	4	\N	90
1413	262	148	1	1	\N	20
1414	245	148	4	6	\N	70
1415	246	148	1	1	\N	20
1416	247	148	2	2	\N	40
1417	248	148	1	1	\N	20
1418	269	149	4	5	\N	80
1419	270	149	3	3	\N	60
1420	271	149	1	1	\N	20
1421	272	149	2	2	\N	40
1422	263	149	4	5	\N	80
1423	264	149	0	0	\N	0
1424	265	149	0	0	\N	0
1425	228	149	4	4	\N	90
1426	229	149	1	3	\N	10
1427	230	149	2	2	\N	40
1428	231	149	0	0	\N	0
1429	224	150	4	5	\N	80
1430	225	150	1	3	\N	10
1431	226	150	0	0	\N	0
1432	227	150	3	4	\N	60
1433	221	150	3	6	\N	40
1434	222	150	2	2	\N	40
1435	223	150	2	2	\N	40
1436	249	150	4	4	\N	90
1437	250	150	1	2	\N	20
1438	251	150	3	3	\N	60
1439	252	150	0	1	\N	0
1440	253	151	3	3	\N	60
1441	254	151	2	3	\N	40
1442	255	151	3	4	\N	60
1443	266	151	4	4	\N	90
1444	267	151	4	4	\N	90
1445	268	151	1	1	\N	20
1446	238	151	2	5	\N	20
1447	239	151	0	1	\N	0
1448	240	151	2	3	\N	40
1449	241	151	2	2	\N	40
1450	215	152	1	3	\N	10
1451	216	152	1	1	\N	20
1452	217	152	1	1	\N	20
1453	218	152	3	5	\N	50
1454	219	152	0	0	\N	0
1455	220	152	0	2	\N	-10
1456	232	152	4	5	\N	80
1457	233	152	0	1	\N	0
1458	234	152	2	2	\N	40
1459	263	153	3	4	\N	60
1460	264	153	2	4	\N	30
1461	265	153	0	0	\N	0
1462	266	153	3	4	\N	60
1463	267	153	0	2	\N	-10
1464	268	153	0	0	\N	0
1465	224	153	3	3	\N	60
1466	225	153	1	1	\N	20
1467	226	153	1	2	\N	20
1468	227	153	3	5	\N	50
1469	249	154	4	5	\N	80
1470	250	154	1	1	\N	20
1471	251	154	2	3	\N	40
1472	252	154	1	1	\N	20
1473	245	154	2	4	\N	30
1474	246	154	2	2	\N	40
1475	247	154	1	1	\N	20
1476	248	154	1	1	\N	20
1477	218	154	4	4	\N	90
1478	219	154	3	3	\N	60
1479	220	154	3	3	\N	60
1480	221	155	1	2	\N	20
1481	222	155	2	2	\N	40
1482	223	155	0	1	\N	0
1483	228	155	4	5	\N	80
1484	229	155	4	4	\N	90
1485	230	155	3	3	\N	60
1486	231	155	3	3	\N	60
1487	238	155	3	4	\N	60
1488	239	155	2	3	\N	40
1489	240	155	1	2	\N	20
1490	241	155	2	2	\N	40
1491	269	156	1	3	\N	10
1492	270	156	1	1	\N	20
1493	271	156	1	1	\N	20
1494	272	156	0	1	\N	0
1495	256	156	3	4	\N	60
1496	257	156	1	1	\N	20
1497	258	156	2	2	\N	40
1498	259	156	1	1	\N	20
1499	253	156	3	4	\N	60
1500	254	156	2	2	\N	40
1501	255	156	1	1	\N	20
1502	215	157	2	2	\N	40
1503	216	157	2	2	\N	40
1504	217	157	0	0	\N	0
1505	242	157	3	4	\N	60
1506	243	157	2	2	\N	40
1507	244	157	0	0	\N	0
1508	260	157	4	5	\N	80
1509	261	157	0	0	\N	0
1510	262	157	0	1	\N	0
1511	235	158	1	3	\N	10
1512	236	158	2	2	\N	40
1513	237	158	0	0	\N	0
1514	232	158	1	2	\N	20
1515	233	158	1	3	\N	10
1516	234	158	0	0	\N	0
1517	253	158	4	4	\N	90
1518	254	158	0	0	\N	0
1519	255	158	0	2	\N	-10
1520	263	159	3	5	\N	50
1521	264	159	1	2	\N	20
1522	265	159	2	2	\N	40
1523	242	159	2	5	\N	20
1524	243	159	1	1	\N	20
1525	244	159	0	0	\N	0
1526	221	159	3	6	\N	40
1527	222	159	0	0	\N	0
1528	223	159	0	1	\N	0
1529	245	160	1	2	\N	20
1530	246	160	0	0	\N	0
1531	247	160	1	1	\N	20
1532	248	160	1	1	\N	20
1533	238	160	0	1	\N	0
1534	239	160	2	4	\N	30
1535	240	160	1	2	\N	20
1536	241	160	0	0	\N	0
1537	266	160	4	5	\N	80
1538	267	160	3	3	\N	60
1539	268	160	2	2	\N	40
1540	260	161	3	4	\N	60
1541	261	161	1	1	\N	20
1542	262	161	1	1	\N	20
1543	249	161	3	3	\N	60
1544	250	161	1	2	\N	20
1545	251	161	2	2	\N	40
1546	252	161	0	0	\N	0
1547	215	161	4	4	\N	90
1548	216	161	4	4	\N	90
1549	217	161	2	3	\N	40
1550	224	162	4	5	\N	80
1551	225	162	4	4	\N	90
1552	226	162	2	2	\N	40
1553	227	162	4	5	\N	80
1554	269	162	3	5	\N	50
1555	270	162	0	0	\N	0
1556	271	162	1	1	\N	20
1557	272	162	3	3	\N	60
1558	218	162	1	3	\N	10
1559	219	162	0	0	\N	0
1560	220	162	2	2	\N	40
1561	228	163	3	4	\N	60
1562	229	163	2	2	\N	40
1563	230	163	3	3	\N	60
1564	231	163	4	5	\N	80
1565	235	163	3	3	\N	60
1566	236	163	0	1	\N	0
1567	237	163	2	2	\N	40
1568	256	163	2	3	\N	40
1569	257	163	0	0	\N	0
1570	258	163	2	2	\N	40
1571	259	163	1	2	\N	20
1572	232	164	4	4	\N	90
1573	233	164	0	0	\N	0
1574	234	164	2	2	\N	40
1575	263	164	3	4	\N	60
1576	264	164	1	2	\N	20
1577	265	164	3	3	\N	60
1578	249	164	3	6	\N	40
1579	250	164	1	1	\N	20
1580	251	164	0	0	\N	0
1581	252	164	3	5	\N	50
1582	224	165	4	5	\N	80
1583	225	165	1	1	\N	20
1584	226	165	0	0	\N	0
1585	227	165	4	4	\N	90
1586	266	165	4	4	\N	90
1587	267	165	1	2	\N	20
1588	268	165	2	2	\N	40
1589	238	165	0	2	\N	-10
1590	239	165	0	0	\N	0
1591	240	165	0	0	\N	0
1592	241	165	3	3	\N	60
1593	269	166	3	5	\N	50
1594	270	166	2	2	\N	40
1595	271	166	3	3	\N	60
1596	272	166	1	1	\N	20
1597	232	166	0	0	\N	0
1598	233	166	1	3	\N	10
1599	234	166	1	1	\N	20
1600	215	166	1	2	\N	20
1601	216	166	0	0	\N	0
1602	217	166	0	0	\N	0
1603	253	167	4	5	\N	80
1604	254	167	2	4	\N	30
1605	255	167	0	0	\N	0
1606	218	167	3	4	\N	60
1607	219	167	4	4	\N	90
1608	220	167	1	1	\N	20
1609	245	167	4	5	\N	80
1610	246	167	0	0	\N	0
1611	247	167	3	3	\N	60
1612	248	167	4	4	\N	90
1613	235	168	4	5	\N	80
1614	236	168	0	1	\N	0
1615	237	168	1	1	\N	20
1616	242	168	0	2	\N	-10
1617	243	168	0	0	\N	0
1618	244	168	2	2	\N	40
1619	260	168	3	5	\N	50
1620	261	168	0	0	\N	0
1621	262	168	0	0	\N	0
1622	256	169	4	5	\N	80
1623	257	169	0	0	\N	0
1624	258	169	1	1	\N	20
1625	259	169	0	0	\N	0
1626	221	169	4	4	\N	90
1627	222	169	0	0	\N	0
1628	223	169	2	2	\N	40
1629	228	169	2	5	\N	20
1630	229	169	4	4	\N	90
1631	230	169	4	4	\N	90
1632	231	169	0	0	\N	0
1633	5	172	3	4	\N	60
1634	6	172	3	5	\N	50
1635	7	172	0	1	\N	0
1636	87	172	1	4	\N	0
1637	88	172	4	4	\N	90
1638	89	172	2	2	\N	40
1639	90	172	1	2	\N	20
1640	8	172	0	1	\N	0
1641	9	172	4	4	\N	90
1642	10	172	1	1	\N	20
1643	11	172	1	1	\N	20
1644	12	172	1	2	\N	20
1645	23	173	4	4	\N	90
1646	24	173	1	1	\N	20
1647	25	173	0	0	\N	0
1648	26	173	1	1	\N	20
1649	20	173	4	4	\N	90
1650	21	173	1	2	\N	20
1651	22	173	3	3	\N	60
1652	99	173	1	2	\N	20
1653	100	173	2	2	\N	40
1654	101	173	3	3	\N	60
1655	102	173	0	2	\N	-10
1656	61	174	4	5	\N	80
1657	62	174	1	2	\N	20
1658	63	174	4	4	\N	90
1659	118	174	4	4	\N	90
1660	119	174	2	3	\N	40
1661	120	174	4	5	\N	80
1662	121	174	2	3	\N	40
1663	122	174	2	2	\N	40
1664	91	174	3	3	\N	60
1665	92	174	3	4	\N	60
1666	93	174	3	4	\N	60
1667	94	174	0	0	\N	0
1668	73	175	4	5	\N	80
1669	74	175	2	3	\N	40
1670	75	175	0	1	\N	0
1671	103	175	3	4	\N	60
1672	104	175	1	2	\N	20
1673	105	175	1	2	\N	20
1674	83	175	3	4	\N	60
1675	84	175	0	2	\N	-10
1676	85	175	2	3	\N	40
1677	86	175	0	1	\N	0
1678	32	176	4	5	\N	80
1679	33	176	1	1	\N	20
1680	34	176	1	3	\N	10
1681	127	176	0	2	\N	-10
1682	128	176	1	1	\N	20
1683	129	176	0	0	\N	0
1684	130	176	1	2	\N	20
1685	17	176	3	4	\N	60
1686	18	176	0	0	\N	0
1687	19	176	3	5	\N	50
1688	50	177	3	3	\N	60
1689	51	177	2	2	\N	40
1690	52	177	2	2	\N	40
1691	53	177	2	2	\N	40
1692	123	177	3	4	\N	60
1693	124	177	1	1	\N	20
1694	125	177	1	1	\N	20
1695	126	177	1	2	\N	20
1696	64	177	3	4	\N	60
1697	65	177	0	0	\N	0
1698	66	177	1	2	\N	20
1699	67	177	1	2	\N	20
1700	68	177	3	3	\N	60
1701	79	178	4	4	\N	90
1702	80	178	0	1	\N	0
1703	81	178	0	0	\N	0
1704	82	178	2	2	\N	40
1705	1	178	3	4	\N	60
1706	2	178	2	2	\N	40
1707	3	178	0	0	\N	0
1708	4	178	2	2	\N	40
1709	69	178	4	5	\N	80
1710	70	178	0	0	\N	0
1711	71	178	1	2	\N	20
1712	72	178	1	3	\N	10
1713	57	179	4	6	\N	70
1714	58	179	0	0	\N	0
1715	59	179	0	1	\N	0
1716	60	179	1	1	\N	20
1717	110	179	2	3	\N	40
1718	111	179	0	0	\N	0
1719	112	179	0	0	\N	0
1720	113	179	1	2	\N	20
1721	95	179	3	4	\N	60
1722	96	179	2	2	\N	40
1723	97	179	0	0	\N	0
1724	98	179	4	5	\N	80
1725	13	180	0	1	\N	0
1726	14	180	0	1	\N	0
1727	15	180	0	1	\N	0
1728	16	180	0	0	\N	0
1729	35	180	4	4	\N	90
1730	36	180	0	0	\N	0
1731	37	180	0	0	\N	0
1732	38	180	2	4	\N	30
1733	42	180	3	4	\N	60
1734	43	180	1	1	\N	20
1735	44	180	4	4	\N	90
1736	45	180	0	0	\N	0
1737	114	181	0	0	\N	0
1738	115	181	0	1	\N	0
1739	116	181	4	5	\N	80
1740	117	181	0	0	\N	0
1741	46	181	3	3	\N	60
1742	47	181	0	1	\N	0
1743	48	181	1	1	\N	20
1744	49	181	1	2	\N	20
1745	106	181	3	3	\N	60
1746	107	181	1	1	\N	20
1747	108	181	0	0	\N	0
1748	109	181	0	1	\N	0
1749	76	182	4	5	\N	80
1750	77	182	2	2	\N	40
1751	78	182	2	2	\N	40
1752	39	182	2	5	\N	20
1753	40	182	0	2	\N	-10
1754	41	182	0	1	\N	0
1755	27	182	4	4	\N	90
1756	28	182	1	1	\N	20
1757	29	182	2	2	\N	40
1758	30	182	2	2	\N	40
1759	31	182	0	0	\N	0
1760	54	183	3	5	\N	50
1761	55	183	3	5	\N	50
1762	56	183	0	0	\N	0
1763	20	183	3	3	\N	60
1764	21	183	1	1	\N	20
1765	22	183	3	4	\N	60
1766	32	183	4	4	\N	90
1767	33	183	3	4	\N	60
1768	34	183	3	4	\N	60
1769	91	184	3	3	\N	60
1770	92	184	3	4	\N	60
1771	93	184	3	3	\N	60
1772	94	184	1	3	\N	10
1773	76	184	0	0	\N	0
1774	77	184	2	2	\N	40
1775	78	184	0	0	\N	0
1776	79	184	4	5	\N	80
1777	80	184	0	0	\N	0
1778	81	184	2	4	\N	30
1779	82	184	1	1	\N	20
1780	127	185	3	3	\N	60
1781	128	185	1	1	\N	20
1782	129	185	1	1	\N	20
1783	130	185	1	1	\N	20
1784	54	185	4	5	\N	80
1785	55	185	1	1	\N	20
1786	56	185	0	1	\N	0
1787	50	185	4	4	\N	90
1788	51	185	1	2	\N	20
1789	52	185	4	4	\N	90
1790	53	185	1	1	\N	20
1791	83	186	4	5	\N	80
1792	84	186	2	2	\N	40
1793	85	186	0	0	\N	0
1794	86	186	0	0	\N	0
1795	39	186	4	5	\N	80
1796	40	186	1	2	\N	20
1797	41	186	1	1	\N	20
1798	8	186	2	2	\N	40
1799	9	186	0	1	\N	0
1800	10	186	2	2	\N	40
1801	11	186	0	0	\N	0
1802	12	186	2	2	\N	40
1803	110	187	4	4	\N	90
1804	111	187	0	1	\N	0
1805	112	187	0	0	\N	0
1806	113	187	4	5	\N	80
1807	95	187	3	3	\N	60
1808	96	187	4	4	\N	90
1809	97	187	2	2	\N	40
1810	98	187	3	4	\N	60
1811	1	187	0	2	\N	-10
1812	2	187	4	4	\N	90
1813	3	187	0	0	\N	0
1814	4	187	0	0	\N	0
1815	35	188	3	4	\N	60
1816	36	188	1	1	\N	20
1817	37	188	3	5	\N	50
1818	38	188	1	1	\N	20
1819	99	188	4	4	\N	90
1820	100	188	0	0	\N	0
1821	101	188	0	1	\N	0
1822	102	188	0	1	\N	0
1823	46	188	2	2	\N	40
1824	47	188	2	2	\N	40
1825	48	188	4	4	\N	90
1826	49	188	2	2	\N	40
1827	5	189	0	2	\N	-10
1828	6	189	1	3	\N	10
1829	7	189	3	4	\N	60
1830	13	189	2	3	\N	40
1831	14	189	4	5	\N	80
1832	15	189	1	1	\N	20
1833	16	189	3	3	\N	60
1834	64	189	2	2	\N	40
1835	65	189	0	1	\N	0
1836	66	189	1	1	\N	20
1837	67	189	2	2	\N	40
1838	68	189	1	1	\N	20
1839	87	190	2	2	\N	40
1840	88	190	3	4	\N	60
1841	89	190	1	1	\N	20
1842	90	190	2	3	\N	40
1843	57	190	4	4	\N	90
1844	58	190	0	1	\N	0
1845	59	190	3	4	\N	60
1846	60	190	2	2	\N	40
1847	106	190	2	3	\N	40
1848	107	190	1	1	\N	20
1849	108	190	0	0	\N	0
1850	109	190	1	1	\N	20
1851	69	191	4	5	\N	80
1852	70	191	0	1	\N	0
1853	71	191	0	2	\N	-10
1854	72	191	3	5	\N	50
1855	103	191	3	3	\N	60
1856	104	191	1	1	\N	20
1857	105	191	3	3	\N	60
1858	42	191	1	3	\N	10
1859	43	191	2	2	\N	40
1860	44	191	2	2	\N	40
1861	45	191	1	1	\N	20
1862	114	192	1	3	\N	10
1863	115	192	1	3	\N	10
1864	116	192	1	1	\N	20
1865	117	192	1	2	\N	20
1866	118	192	4	4	\N	90
1867	119	192	0	2	\N	-10
1868	120	192	1	1	\N	20
1869	121	192	2	2	\N	40
1870	122	192	1	1	\N	20
1871	123	192	4	5	\N	80
1872	124	192	1	1	\N	20
1873	125	192	2	2	\N	40
1874	126	192	0	0	\N	0
1875	17	193	3	3	\N	60
1876	18	193	1	1	\N	20
1877	19	193	2	2	\N	40
1878	23	193	4	5	\N	80
1879	24	193	2	2	\N	40
1880	25	193	0	1	\N	0
1881	26	193	1	2	\N	20
1882	61	193	4	5	\N	80
1883	62	193	0	0	\N	0
1884	63	193	1	1	\N	20
1885	73	194	3	6	\N	40
1886	74	194	1	1	\N	20
1887	75	194	1	1	\N	20
1888	27	194	3	3	\N	60
1889	28	194	2	2	\N	40
1890	29	194	0	0	\N	0
1891	30	194	3	5	\N	50
1892	31	194	0	0	\N	0
1893	110	194	3	3	\N	60
1894	111	194	1	1	\N	20
1895	112	194	2	3	\N	40
1896	113	194	0	0	\N	0
1897	76	195	1	2	\N	20
1898	77	195	3	3	\N	60
1899	78	195	1	1	\N	20
1900	118	195	3	5	\N	50
1901	119	195	4	5	\N	80
1902	120	195	0	1	\N	0
1903	121	195	2	2	\N	40
1904	122	195	2	3	\N	40
1905	57	195	4	5	\N	80
1906	58	195	4	4	\N	90
1907	59	195	3	3	\N	60
1908	60	195	3	3	\N	60
1909	27	196	1	1	\N	20
1910	28	196	4	4	\N	90
1911	29	196	4	6	\N	70
1912	30	196	0	0	\N	0
1913	31	196	0	0	\N	0
1914	1	196	3	4	\N	60
1915	2	196	2	4	\N	30
1916	3	196	0	2	\N	-10
1917	4	196	0	0	\N	0
1918	73	196	4	4	\N	90
1919	74	196	2	4	\N	30
1920	75	196	4	5	\N	80
1921	99	197	3	5	\N	50
1922	100	197	0	1	\N	0
1923	101	197	0	2	\N	-10
1924	102	197	2	2	\N	40
1925	39	197	2	5	\N	20
1926	40	197	3	3	\N	60
1927	41	197	3	3	\N	60
1928	114	197	0	0	\N	0
1929	115	197	2	2	\N	40
1930	116	197	1	1	\N	20
1931	117	197	0	0	\N	0
1932	61	198	2	4	\N	30
1933	62	198	0	0	\N	0
1934	63	198	0	1	\N	0
1935	5	198	4	5	\N	80
1936	6	198	3	4	\N	60
1937	7	198	2	2	\N	40
1938	8	198	4	5	\N	80
1939	9	198	2	2	\N	40
1940	10	198	4	6	\N	70
1941	11	198	0	0	\N	0
1942	12	198	4	4	\N	90
1943	23	199	4	4	\N	90
1944	24	199	0	2	\N	-10
1945	25	199	0	1	\N	0
1946	26	199	2	3	\N	40
1947	91	199	0	2	\N	-10
1948	92	199	4	4	\N	90
1949	93	199	0	0	\N	0
1950	94	199	0	1	\N	0
1951	83	199	2	4	\N	30
1952	84	199	0	1	\N	0
1953	85	199	0	0	\N	0
1954	86	199	1	1	\N	20
1955	46	200	1	2	\N	20
1956	47	200	4	5	\N	80
1957	48	200	2	2	\N	40
1958	49	200	1	1	\N	20
1959	69	200	0	1	\N	0
1960	70	200	3	3	\N	60
1961	71	200	1	1	\N	20
1962	72	200	3	5	\N	50
1963	35	200	4	4	\N	90
1964	36	200	0	1	\N	0
1965	37	200	3	3	\N	60
1966	38	200	0	1	\N	0
1967	95	201	4	4	\N	90
1968	96	201	3	3	\N	60
1969	97	201	1	1	\N	20
1970	98	201	0	2	\N	-10
1971	127	201	0	1	\N	0
1972	128	201	4	5	\N	80
1973	129	201	0	1	\N	0
1974	130	201	2	2	\N	40
1975	87	201	3	5	\N	50
1976	88	201	1	1	\N	20
1977	89	201	1	1	\N	20
1978	90	201	2	2	\N	40
1979	50	202	4	5	\N	80
1980	51	202	2	2	\N	40
1981	52	202	1	1	\N	20
1982	53	202	2	2	\N	40
1983	13	202	4	5	\N	80
1984	14	202	0	0	\N	0
1985	15	202	0	0	\N	0
1986	16	202	1	2	\N	20
1987	32	202	2	3	\N	40
1988	33	202	0	0	\N	0
1989	34	202	2	3	\N	40
1990	20	203	2	3	\N	40
1991	21	203	0	0	\N	0
1992	22	203	3	3	\N	60
1993	79	203	4	6	\N	70
1994	80	203	1	1	\N	20
1995	81	203	1	2	\N	20
1996	82	203	1	1	\N	20
1997	54	203	4	5	\N	80
1998	55	203	0	0	\N	0
1999	56	203	1	2	\N	20
2000	123	204	3	3	\N	60
2001	124	204	2	2	\N	40
2002	125	204	0	0	\N	0
2003	126	204	1	1	\N	20
2004	103	204	2	5	\N	20
2005	104	204	0	0	\N	0
2006	105	204	3	5	\N	50
2007	42	204	3	3	\N	60
2008	43	204	1	1	\N	20
2009	44	204	2	2	\N	40
2010	45	204	0	2	\N	-10
2011	106	205	4	4	\N	90
2012	107	205	0	0	\N	0
2013	108	205	2	3	\N	40
2014	109	205	4	5	\N	80
2015	64	205	1	2	\N	20
2016	65	205	2	2	\N	40
2017	66	205	2	2	\N	40
2018	67	205	0	0	\N	0
2019	68	205	0	2	\N	-10
2020	17	205	4	5	\N	80
2021	18	205	0	0	\N	0
2022	19	205	0	0	\N	0
2023	106	206	3	6	\N	40
2024	107	206	0	0	\N	0
2025	108	206	2	3	\N	40
2026	109	206	4	4	\N	90
2027	50	206	3	5	\N	50
2028	51	206	1	1	\N	20
2029	52	206	1	1	\N	20
2030	53	206	1	2	\N	20
2031	110	206	3	4	\N	60
2032	111	206	3	3	\N	60
2033	112	206	1	1	\N	20
2034	113	206	0	0	\N	0
2035	20	207	0	1	\N	0
2036	21	207	1	1	\N	20
2037	22	207	1	3	\N	10
2038	57	207	3	3	\N	60
2039	58	207	1	1	\N	20
2040	59	207	3	3	\N	60
2041	60	207	0	1	\N	0
2042	123	207	3	4	\N	60
2043	124	207	2	2	\N	40
2044	125	207	4	6	\N	70
2045	126	207	3	3	\N	60
2046	27	208	4	5	\N	80
2047	28	208	1	3	\N	10
2048	29	208	3	3	\N	60
2049	30	208	1	2	\N	20
2050	31	208	0	0	\N	0
2051	39	208	3	4	\N	60
2052	40	208	3	3	\N	60
2053	41	208	0	0	\N	0
2054	73	208	4	6	\N	70
2055	74	208	2	2	\N	40
2056	75	208	2	4	\N	30
2057	87	209	4	4	\N	90
2058	88	209	2	2	\N	40
2059	89	209	1	2	\N	20
2060	90	209	3	5	\N	50
2061	83	209	3	5	\N	50
2062	84	209	1	1	\N	20
2063	85	209	4	5	\N	80
2064	86	209	4	4	\N	90
2065	76	209	3	3	\N	60
2066	77	209	0	0	\N	0
2067	78	209	0	1	\N	0
2068	103	210	3	4	\N	60
2069	104	210	3	3	\N	60
2070	105	210	1	1	\N	20
2071	13	210	4	5	\N	80
2072	14	210	0	2	\N	-10
2073	15	210	4	4	\N	90
2074	16	210	1	1	\N	20
2075	32	210	3	3	\N	60
2076	33	210	0	0	\N	0
2077	34	210	0	0	\N	0
2078	95	211	4	6	\N	70
2079	96	211	1	2	\N	20
2080	97	211	0	0	\N	0
2081	98	211	1	2	\N	20
2082	8	211	4	5	\N	80
2083	9	211	1	3	\N	10
2084	10	211	4	4	\N	90
2085	11	211	2	4	\N	30
2086	12	211	2	4	\N	30
2087	54	211	3	5	\N	50
2088	55	211	0	1	\N	0
2089	56	211	4	4	\N	90
2090	1	212	3	6	\N	40
2091	2	212	4	4	\N	90
2092	3	212	0	0	\N	0
2093	4	212	0	0	\N	0
2094	42	212	3	4	\N	60
2095	43	212	2	2	\N	40
2096	44	212	1	1	\N	20
2097	45	212	1	1	\N	20
2098	127	212	1	2	\N	20
2099	128	212	0	0	\N	0
2100	129	212	0	0	\N	0
2101	130	212	1	2	\N	20
2102	118	213	4	6	\N	70
2103	119	213	4	5	\N	80
2104	120	213	0	0	\N	0
2105	121	213	0	2	\N	-10
2106	122	213	0	0	\N	0
2107	61	213	1	3	\N	10
2108	62	213	1	1	\N	20
2109	63	213	4	4	\N	90
2110	69	213	0	2	\N	-10
2111	70	213	2	2	\N	40
2112	71	213	1	1	\N	20
2113	72	213	1	3	\N	10
2114	64	214	3	5	\N	50
2115	65	214	0	1	\N	0
2116	66	214	0	1	\N	0
2117	67	214	2	2	\N	40
2118	68	214	0	1	\N	0
2119	79	214	4	4	\N	90
2120	80	214	4	4	\N	90
2121	81	214	1	1	\N	20
2122	82	214	2	3	\N	40
2123	46	214	4	5	\N	80
2124	47	214	1	1	\N	20
2125	48	214	1	3	\N	10
2126	49	214	0	0	\N	0
2127	35	215	0	3	\N	-20
2128	36	215	1	3	\N	10
2129	37	215	1	2	\N	20
2130	38	215	2	4	\N	30
2131	114	215	0	2	\N	-10
2132	115	215	1	2	\N	20
2133	116	215	0	0	\N	0
2134	117	215	1	1	\N	20
2135	23	215	1	4	\N	0
2136	24	215	0	0	\N	0
2137	25	215	1	2	\N	20
2138	26	215	2	4	\N	30
2139	99	216	3	3	\N	60
2140	100	216	1	1	\N	20
2141	101	216	4	5	\N	80
2142	102	216	4	4	\N	90
2143	5	216	2	4	\N	30
2144	6	216	3	3	\N	60
2145	7	216	0	0	\N	0
2146	91	216	1	1	\N	20
2147	92	216	0	1	\N	0
2148	93	216	2	3	\N	40
2149	94	216	0	2	\N	-10
2150	17	217	3	4	\N	60
2151	18	217	0	0	\N	0
2152	19	217	4	4	\N	90
2153	91	217	3	3	\N	60
2154	92	217	0	0	\N	0
2155	93	217	1	1	\N	20
2156	94	217	2	2	\N	40
2157	106	217	3	4	\N	60
2158	107	217	2	2	\N	40
2159	108	217	0	2	\N	-10
2160	109	217	1	1	\N	20
2161	57	218	4	4	\N	90
2162	58	218	0	0	\N	0
2163	59	218	2	2	\N	40
2164	60	218	1	1	\N	20
2165	99	218	2	2	\N	40
2166	100	218	1	1	\N	20
2167	101	218	2	2	\N	40
2168	102	218	0	0	\N	0
2169	1	218	0	2	\N	-10
2170	2	218	3	4	\N	60
2171	3	218	2	2	\N	40
2172	4	218	0	0	\N	0
2173	42	219	2	2	\N	40
2174	43	219	2	2	\N	40
2175	44	219	2	3	\N	40
2176	45	219	0	0	\N	0
2177	20	219	0	3	\N	-20
2178	21	219	1	1	\N	20
2179	22	219	0	1	\N	0
2180	13	219	4	5	\N	80
2181	14	219	1	1	\N	20
2182	15	219	1	1	\N	20
2183	16	219	0	0	\N	0
2184	23	220	3	4	\N	60
2185	24	220	3	3	\N	60
2186	25	220	4	4	\N	90
2187	26	220	1	1	\N	20
2188	118	220	4	5	\N	80
2189	119	220	3	4	\N	60
2190	120	220	2	3	\N	40
2191	121	220	3	3	\N	60
2192	122	220	0	0	\N	0
2193	69	220	3	4	\N	60
2194	70	220	4	4	\N	90
2195	71	220	1	1	\N	20
2196	72	220	1	1	\N	20
2197	76	221	4	6	\N	70
2198	77	221	1	1	\N	20
2199	78	221	2	3	\N	40
2200	110	221	0	1	\N	0
2201	111	221	2	2	\N	40
2202	112	221	4	5	\N	80
2203	113	221	2	3	\N	40
2204	103	221	1	3	\N	10
2205	104	221	1	1	\N	20
2206	105	221	1	1	\N	20
2207	8	222	3	3	\N	60
2208	9	222	1	1	\N	20
2209	10	222	4	4	\N	90
2210	11	222	4	5	\N	80
2211	12	222	1	3	\N	10
2212	61	222	4	5	\N	80
2213	62	222	0	0	\N	0
2214	63	222	1	1	\N	20
2215	87	222	3	4	\N	60
2216	88	222	2	2	\N	40
2217	89	222	0	0	\N	0
2218	90	222	0	0	\N	0
2219	95	223	3	4	\N	60
2220	96	223	3	3	\N	60
2221	97	223	4	4	\N	90
2222	98	223	1	3	\N	10
2223	39	223	0	2	\N	-10
2224	40	223	0	0	\N	0
2225	41	223	2	3	\N	40
2226	123	223	4	5	\N	80
2227	124	223	0	0	\N	0
2228	125	223	2	3	\N	40
2229	126	223	0	0	\N	0
2230	79	224	3	5	\N	50
2231	80	224	1	1	\N	20
2232	81	224	2	2	\N	40
2233	82	224	0	0	\N	0
2234	64	224	1	3	\N	10
2235	65	224	2	2	\N	40
2236	66	224	1	2	\N	20
2237	67	224	2	2	\N	40
2238	68	224	2	2	\N	40
2239	32	224	0	0	\N	0
2240	33	224	0	1	\N	0
2241	34	224	2	2	\N	40
2242	54	225	4	4	\N	90
2243	55	225	0	0	\N	0
2244	56	225	4	4	\N	90
2245	114	225	2	4	\N	30
2246	115	225	0	0	\N	0
2247	116	225	1	1	\N	20
2248	117	225	1	3	\N	10
2249	5	225	4	5	\N	80
2250	6	225	1	3	\N	10
2251	7	225	1	1	\N	20
2252	46	226	1	2	\N	20
2253	47	226	1	2	\N	20
2254	48	226	4	6	\N	70
2255	49	226	0	1	\N	0
2256	17	226	0	3	\N	-20
2257	18	226	1	1	\N	20
2258	19	226	0	0	\N	0
2259	73	226	4	5	\N	80
2260	74	226	0	1	\N	0
2261	75	226	0	0	\N	0
2262	127	227	1	3	\N	10
2263	128	227	1	1	\N	20
2264	129	227	0	0	\N	0
2265	130	227	1	1	\N	20
2266	35	227	4	5	\N	80
2267	36	227	0	0	\N	0
2268	37	227	1	1	\N	20
2269	38	227	3	4	\N	60
2270	50	227	3	5	\N	50
2271	51	227	1	1	\N	20
2272	52	227	4	6	\N	70
2273	53	227	1	1	\N	20
2274	27	228	2	3	\N	40
2275	28	228	2	2	\N	40
2276	29	228	0	0	\N	0
2277	30	228	1	3	\N	10
2278	31	228	0	0	\N	0
2279	83	228	4	4	\N	90
2280	84	228	1	1	\N	20
2281	85	228	1	1	\N	20
2282	86	228	1	1	\N	20
2283	8	228	2	4	\N	30
2284	9	228	1	1	\N	20
2285	10	228	0	1	\N	0
2286	11	228	2	2	\N	40
2287	12	228	1	1	\N	20
2288	103	229	3	5	\N	50
2289	104	229	0	0	\N	0
2290	105	229	4	5	\N	80
2291	50	229	1	2	\N	20
2292	51	229	0	2	\N	-10
2293	52	229	1	1	\N	20
2294	53	229	2	2	\N	40
2295	123	229	4	4	\N	90
2296	124	229	1	1	\N	20
2297	125	229	4	6	\N	70
2298	126	229	1	1	\N	20
2299	76	230	4	4	\N	90
2300	77	230	1	2	\N	20
2301	78	230	1	1	\N	20
2302	32	230	2	4	\N	30
2303	33	230	1	2	\N	20
2304	34	230	1	3	\N	10
2305	17	230	4	5	\N	80
2306	18	230	1	1	\N	20
2307	19	230	0	0	\N	0
2308	106	231	3	4	\N	60
2309	107	231	0	0	\N	0
2310	108	231	1	2	\N	20
2311	109	231	0	1	\N	0
2312	35	231	4	6	\N	70
2313	36	231	0	1	\N	0
2314	37	231	0	1	\N	0
2315	38	231	1	1	\N	20
2316	13	231	4	4	\N	90
2317	14	231	2	2	\N	40
2318	15	231	3	3	\N	60
2319	16	231	2	2	\N	40
2320	46	232	3	4	\N	60
2321	47	232	2	2	\N	40
2322	48	232	1	1	\N	20
2323	49	232	0	0	\N	0
2324	39	232	3	4	\N	60
2325	40	232	4	5	\N	80
2326	41	232	0	0	\N	0
2327	99	232	4	4	\N	90
2328	100	232	4	4	\N	90
2329	101	232	4	4	\N	90
2330	102	232	2	2	\N	40
2331	127	233	4	4	\N	90
2332	128	233	3	3	\N	60
2333	129	233	2	2	\N	40
2334	130	233	4	4	\N	90
2335	83	233	2	2	\N	40
2336	84	233	1	1	\N	20
2337	85	233	0	0	\N	0
2338	86	233	2	2	\N	40
2339	61	233	3	3	\N	60
2340	62	233	1	2	\N	20
2341	63	233	3	4	\N	60
2342	118	234	1	2	\N	20
2343	119	234	0	2	\N	-10
2344	120	234	1	2	\N	20
2345	121	234	1	1	\N	20
2346	122	234	1	1	\N	20
2347	73	234	4	4	\N	90
2348	74	234	0	1	\N	0
2349	75	234	0	2	\N	-10
2350	69	234	4	5	\N	80
2351	70	234	1	1	\N	20
2352	71	234	0	0	\N	0
2353	72	234	2	4	\N	30
2354	110	235	4	6	\N	70
2355	111	235	1	1	\N	20
2356	112	235	2	4	\N	30
2357	113	235	1	1	\N	20
2358	114	235	3	3	\N	60
2359	115	235	3	3	\N	60
2360	116	235	0	0	\N	0
2361	117	235	2	2	\N	40
2362	23	235	2	2	\N	40
2363	24	235	1	3	\N	10
2364	25	235	2	2	\N	40
2365	26	235	4	4	\N	90
2366	54	236	1	2	\N	20
2367	55	236	4	4	\N	90
2368	56	236	0	0	\N	0
2369	42	236	1	1	\N	20
2370	43	236	1	2	\N	20
2371	44	236	3	5	\N	50
2372	45	236	4	5	\N	80
2373	27	236	0	0	\N	0
2374	28	236	0	0	\N	0
2375	29	236	4	5	\N	80
2376	30	236	3	4	\N	60
2377	31	236	1	2	\N	20
2378	95	237	3	6	\N	40
2379	96	237	2	2	\N	40
2380	97	237	4	4	\N	90
2381	98	237	0	0	\N	0
2382	79	237	0	0	\N	0
2383	80	237	1	1	\N	20
2384	81	237	0	0	\N	0
2385	82	237	0	0	\N	0
2386	64	237	3	6	\N	40
2387	65	237	1	1	\N	20
2388	66	237	1	1	\N	20
2389	67	237	1	2	\N	20
2390	68	237	3	3	\N	60
2391	5	238	3	4	\N	60
2392	6	238	1	1	\N	20
2393	7	238	2	4	\N	30
2394	57	238	4	5	\N	80
2395	58	238	4	4	\N	90
2396	59	238	2	4	\N	30
2397	60	238	2	3	\N	40
2398	1	238	0	1	\N	0
2399	2	238	0	1	\N	0
2400	3	238	3	4	\N	60
2401	4	238	0	0	\N	0
2402	91	239	3	4	\N	60
2403	92	239	1	1	\N	20
2404	93	239	0	1	\N	0
2405	94	239	0	0	\N	0
2406	20	239	4	4	\N	90
2407	21	239	0	0	\N	0
2408	22	239	2	2	\N	40
2409	87	239	3	4	\N	60
2410	88	239	0	0	\N	0
2411	89	239	2	2	\N	40
2412	90	239	1	2	\N	20
2413	139	244	3	3	\N	60
2414	140	244	0	0	\N	0
2415	131	244	3	6	\N	40
2416	132	244	0	1	\N	0
2417	133	244	0	1	\N	0
2418	141	244	0	1	\N	0
2419	142	244	0	2	\N	-10
2420	143	244	2	2	\N	40
2421	212	245	4	6	\N	70
2422	213	245	4	4	\N	90
2423	214	245	1	1	\N	20
2424	190	245	3	6	\N	40
2425	191	245	0	1	\N	0
2426	192	245	0	1	\N	0
2427	138	245	4	5	\N	80
2428	146	246	1	1	\N	20
2429	147	246	2	2	\N	40
2430	148	246	0	0	\N	0
2431	167	246	4	5	\N	80
2432	168	246	4	6	\N	70
2433	164	246	1	1	\N	20
2434	165	246	1	1	\N	20
2435	166	246	1	3	\N	10
2436	202	247	4	5	\N	80
2437	203	247	1	1	\N	20
2438	204	247	2	3	\N	40
2439	205	247	1	3	\N	10
2440	206	247	2	4	\N	30
2441	182	247	4	5	\N	80
2442	183	247	0	1	\N	0
2443	198	248	2	2	\N	40
2444	199	248	0	1	\N	0
2445	200	248	1	1	\N	20
2446	201	248	0	0	\N	0
2447	176	248	4	4	\N	90
2448	177	248	0	0	\N	0
2449	178	248	1	1	\N	20
2450	179	248	3	3	\N	60
2451	144	248	3	3	\N	60
2452	145	248	1	1	\N	20
2453	180	249	3	3	\N	60
2454	181	249	1	1	\N	20
2455	193	249	3	3	\N	60
2456	194	249	4	5	\N	80
2457	158	249	4	5	\N	80
2458	159	249	2	2	\N	40
2459	160	249	0	2	\N	-10
2460	134	250	4	6	\N	70
2461	135	250	4	4	\N	90
2462	136	250	1	1	\N	20
2463	137	250	3	4	\N	60
2464	161	250	3	4	\N	60
2465	162	250	1	2	\N	20
2466	163	250	2	2	\N	40
2467	171	250	3	4	\N	60
2468	172	250	0	0	\N	0
2469	173	250	2	2	\N	40
2470	186	251	1	3	\N	10
2471	187	251	0	2	\N	-10
2472	188	251	0	0	\N	0
2473	189	251	1	2	\N	20
2474	155	251	0	1	\N	0
2475	156	251	4	5	\N	80
2476	157	251	1	1	\N	20
2477	152	251	4	5	\N	80
2478	153	251	2	4	\N	30
2479	154	251	2	3	\N	40
2480	149	252	4	6	\N	70
2481	150	252	1	2	\N	20
2482	151	252	1	1	\N	20
2483	195	252	2	4	\N	30
2484	196	252	2	2	\N	40
2485	197	252	2	2	\N	40
2486	169	252	3	3	\N	60
2487	170	252	0	2	\N	-10
2488	174	253	3	5	\N	50
2489	175	253	1	1	\N	20
2490	207	253	4	4	\N	90
2491	208	253	4	5	\N	80
2492	184	253	4	4	\N	90
2493	185	253	2	2	\N	40
2494	209	254	4	5	\N	80
2495	210	254	1	3	\N	10
2496	211	254	2	2	\N	40
2497	190	254	4	4	\N	90
2498	191	254	1	1	\N	20
2499	192	254	0	0	\N	0
2500	186	254	3	4	\N	60
2501	187	254	0	1	\N	0
2502	188	254	0	0	\N	0
2503	189	254	0	2	\N	-10
2504	149	255	1	2	\N	20
2505	150	255	3	3	\N	60
2506	151	255	4	6	\N	70
2507	161	255	3	5	\N	50
2508	162	255	2	2	\N	40
2509	163	255	0	2	\N	-10
2510	141	255	0	0	\N	0
2511	142	255	1	2	\N	20
2512	143	255	1	1	\N	20
2513	204	256	4	4	\N	90
2514	205	256	1	3	\N	10
2515	206	256	0	1	\N	0
2516	198	256	0	2	\N	-10
2517	199	256	0	0	\N	0
2518	200	256	0	1	\N	0
2519	201	256	1	2	\N	20
2520	180	256	4	6	\N	70
2521	181	256	2	2	\N	40
2522	171	257	2	3	\N	40
2523	172	257	0	1	\N	0
2524	173	257	1	3	\N	10
2525	184	257	4	6	\N	70
2526	185	257	0	0	\N	0
2527	139	257	3	3	\N	60
2528	140	257	2	2	\N	40
2529	174	258	4	6	\N	70
2530	175	258	1	2	\N	20
2531	195	258	4	4	\N	90
2532	196	258	0	0	\N	0
2533	197	258	2	4	\N	30
2534	134	258	4	5	\N	80
2535	135	258	1	3	\N	10
2536	136	258	0	0	\N	0
2537	137	258	2	4	\N	30
2538	207	259	0	1	\N	0
2539	208	259	3	4	\N	60
2540	212	259	2	5	\N	20
2541	213	259	0	0	\N	0
2542	214	259	0	0	\N	0
2543	176	259	1	2	\N	20
2544	177	259	4	4	\N	90
2545	178	259	0	0	\N	0
2546	179	259	4	4	\N	90
2547	167	260	4	5	\N	80
2548	168	260	1	1	\N	20
2549	202	260	3	6	\N	40
2550	203	260	2	3	\N	40
2551	146	260	3	4	\N	60
2552	147	260	1	3	\N	10
2553	148	260	1	1	\N	20
2554	182	261	2	5	\N	20
2555	183	261	1	2	\N	20
2556	158	261	3	6	\N	40
2557	159	261	0	0	\N	0
2558	160	261	1	2	\N	20
2559	155	261	3	4	\N	60
2560	156	261	1	2	\N	20
2561	157	261	2	4	\N	30
2562	152	262	4	4	\N	90
2563	153	262	1	1	\N	20
2564	154	262	2	3	\N	40
2565	209	262	4	4	\N	90
2566	210	262	4	4	\N	90
2567	211	262	1	1	\N	20
2568	138	262	0	2	\N	-10
2569	164	263	4	4	\N	90
2570	165	263	0	1	\N	0
2571	166	263	1	2	\N	20
2572	131	263	4	4	\N	90
2573	132	263	1	1	\N	20
2574	133	263	1	2	\N	20
2575	193	263	4	4	\N	90
2576	194	263	0	2	\N	-10
2577	169	264	4	4	\N	90
2578	170	264	0	0	\N	0
2579	144	264	4	5	\N	80
2580	145	264	1	3	\N	10
2581	174	264	4	4	\N	90
2582	175	264	0	1	\N	0
2583	198	265	4	5	\N	80
2584	199	265	1	1	\N	20
2585	200	265	1	1	\N	20
2586	201	265	0	0	\N	0
2587	202	265	0	2	\N	-10
2588	203	265	3	3	\N	60
2589	134	265	0	0	\N	0
2590	135	265	2	2	\N	40
2591	136	265	2	3	\N	40
2592	137	265	0	0	\N	0
2593	155	266	4	5	\N	80
2594	156	266	0	1	\N	0
2595	157	266	3	3	\N	60
2596	169	266	4	4	\N	90
2597	170	266	1	1	\N	20
2598	171	266	3	4	\N	60
2599	172	266	0	0	\N	0
2600	173	266	1	2	\N	20
2601	139	267	2	3	\N	40
2602	140	267	2	2	\N	40
2603	152	267	3	5	\N	50
2604	153	267	1	3	\N	10
2605	154	267	2	2	\N	40
2606	167	267	4	4	\N	90
2607	168	267	2	2	\N	40
2608	190	268	3	5	\N	50
2609	191	268	1	1	\N	20
2610	192	268	0	2	\N	-10
2611	182	268	2	5	\N	20
2612	183	268	3	3	\N	60
2613	180	268	1	4	\N	0
2614	181	268	1	1	\N	20
2615	146	269	4	5	\N	80
2616	147	269	1	3	\N	10
2617	148	269	1	2	\N	20
2618	186	269	4	5	\N	80
2619	187	269	2	4	\N	30
2620	188	269	1	1	\N	20
2621	189	269	4	4	\N	90
2622	138	269	3	3	\N	60
2623	212	270	3	5	\N	50
2624	213	270	1	1	\N	20
2625	214	270	1	2	\N	20
2626	184	270	4	6	\N	70
2627	185	270	0	0	\N	0
2628	158	270	0	2	\N	-10
2629	159	270	4	5	\N	80
2630	160	270	2	3	\N	40
2631	141	271	4	5	\N	80
2632	142	271	2	2	\N	40
2633	143	271	1	2	\N	20
2634	207	271	4	5	\N	80
2635	208	271	1	1	\N	20
2636	161	271	2	3	\N	40
2637	162	271	4	5	\N	80
2638	163	271	0	1	\N	0
2639	209	272	4	4	\N	90
2640	210	272	1	1	\N	20
2641	211	272	2	4	\N	30
2642	144	272	4	5	\N	80
2643	145	272	0	0	\N	0
2644	195	272	4	6	\N	70
2645	196	272	1	2	\N	20
2646	197	272	2	3	\N	40
2647	204	273	3	5	\N	50
2648	205	273	2	2	\N	40
2649	206	273	0	0	\N	0
2650	193	273	3	3	\N	60
2651	194	273	1	1	\N	20
2652	176	273	4	4	\N	90
2653	177	273	0	0	\N	0
2654	178	273	0	1	\N	0
2655	179	273	4	4	\N	90
2656	149	274	4	4	\N	90
2657	150	274	1	1	\N	20
2658	151	274	1	2	\N	20
2659	131	274	3	3	\N	60
2660	132	274	1	2	\N	20
2661	133	274	0	2	\N	-10
2662	164	274	3	3	\N	60
2663	165	274	0	1	\N	0
2664	166	274	1	1	\N	20
2665	202	275	2	2	\N	40
2666	203	275	3	4	\N	60
2667	198	275	3	5	\N	50
2668	199	275	0	0	\N	0
2669	200	275	1	2	\N	20
2670	201	275	0	2	\N	-10
2671	212	275	4	4	\N	90
2672	213	275	4	6	\N	70
2673	214	275	0	2	\N	-10
2674	131	276	4	4	\N	90
2675	132	276	2	2	\N	40
2676	133	276	2	2	\N	40
2677	171	276	3	5	\N	50
2678	172	276	0	2	\N	-10
2679	173	276	3	4	\N	60
2680	180	276	2	2	\N	40
2681	181	276	1	1	\N	20
2682	134	277	4	5	\N	80
2683	135	277	0	1	\N	0
2684	136	277	1	1	\N	20
2685	137	277	1	1	\N	20
2686	164	277	3	3	\N	60
2687	165	277	2	3	\N	40
2688	166	277	2	2	\N	40
2689	193	277	4	4	\N	90
2690	194	277	0	0	\N	0
2691	176	278	0	0	\N	0
2692	177	278	2	3	\N	40
2693	178	278	0	0	\N	0
2694	179	278	3	4	\N	60
2695	182	278	4	6	\N	70
2696	183	278	0	0	\N	0
2697	155	278	4	5	\N	80
2698	156	278	0	0	\N	0
2699	157	278	1	1	\N	20
2700	209	279	3	4	\N	60
2701	210	279	1	3	\N	10
2702	211	279	2	2	\N	40
2703	144	279	4	4	\N	90
2704	145	279	0	0	\N	0
2705	190	279	2	2	\N	40
2706	191	279	1	1	\N	20
2707	192	279	1	1	\N	20
2708	195	280	0	1	\N	0
2709	196	280	0	0	\N	0
2710	197	280	3	3	\N	60
2711	158	280	4	5	\N	80
2712	159	280	3	3	\N	60
2713	160	280	0	2	\N	-10
2714	204	280	0	1	\N	0
2715	205	280	4	5	\N	80
2716	206	280	2	2	\N	40
2717	207	281	2	4	\N	30
2718	208	281	0	0	\N	0
2719	184	281	1	1	\N	20
2720	185	281	0	0	\N	0
2721	146	281	4	5	\N	80
2722	147	281	2	4	\N	30
2723	148	281	4	4	\N	90
2724	167	282	4	5	\N	80
2725	168	282	0	2	\N	-10
2726	149	282	1	2	\N	20
2727	150	282	1	1	\N	20
2728	151	282	2	2	\N	40
2729	174	282	1	2	\N	20
2730	175	282	1	2	\N	20
2731	186	283	1	2	\N	20
2732	187	283	1	1	\N	20
2733	188	283	1	1	\N	20
2734	189	283	2	4	\N	30
2735	138	283	0	0	\N	0
2736	152	283	0	1	\N	0
2737	153	283	3	4	\N	60
2738	154	283	2	3	\N	40
2739	161	284	3	5	\N	50
2740	162	284	4	4	\N	90
2741	163	284	2	3	\N	40
2742	139	284	4	4	\N	90
2743	140	284	0	0	\N	0
2744	141	284	1	1	\N	20
2745	142	284	1	1	\N	20
2746	143	284	1	2	\N	20
2747	169	285	4	6	\N	70
2748	170	285	0	0	\N	0
2749	134	285	3	5	\N	50
2750	135	285	3	4	\N	60
2751	136	285	2	3	\N	40
2752	137	285	1	1	\N	20
2753	146	285	3	5	\N	50
2754	147	285	1	3	\N	10
2755	148	285	0	0	\N	0
2756	174	286	4	4	\N	90
2757	175	286	2	2	\N	40
2758	209	286	4	4	\N	90
2759	210	286	0	1	\N	0
2760	211	286	4	4	\N	90
2761	198	286	3	4	\N	60
2762	199	286	0	0	\N	0
2763	200	286	1	3	\N	10
2764	201	286	0	0	\N	0
2765	202	287	3	4	\N	60
2766	203	287	0	1	\N	0
2767	158	287	0	1	\N	0
2768	159	287	1	1	\N	20
2769	160	287	0	0	\N	0
2770	176	287	4	4	\N	90
2771	177	287	2	2	\N	40
2772	178	287	1	2	\N	20
2773	179	287	0	0	\N	0
2774	182	288	4	6	\N	70
2775	183	288	0	2	\N	-10
2776	138	288	4	5	\N	80
2777	207	288	4	5	\N	80
2778	208	288	1	2	\N	20
2779	212	289	3	3	\N	60
2780	213	289	0	0	\N	0
2781	214	289	1	1	\N	20
2782	164	289	4	5	\N	80
2783	165	289	1	1	\N	20
2784	166	289	2	2	\N	40
2785	193	289	4	4	\N	90
2786	194	289	1	1	\N	20
2787	149	290	4	5	\N	80
2788	150	290	3	3	\N	60
2789	151	290	0	0	\N	0
2790	186	290	4	4	\N	90
2791	187	290	1	3	\N	10
2792	188	290	1	2	\N	20
2793	189	290	4	4	\N	90
2794	184	290	3	5	\N	50
2795	185	290	1	1	\N	20
2796	195	291	3	5	\N	50
2797	196	291	0	2	\N	-10
2798	197	291	0	0	\N	0
2799	204	291	4	5	\N	80
2800	205	291	0	0	\N	0
2801	206	291	1	2	\N	20
2802	155	291	4	4	\N	90
2803	156	291	0	0	\N	0
2804	157	291	3	5	\N	50
2805	167	292	0	2	\N	-10
2806	168	292	2	2	\N	40
2807	169	292	4	4	\N	90
2808	170	292	0	1	\N	0
2809	161	292	2	2	\N	40
2810	162	292	1	1	\N	20
2811	163	292	4	4	\N	90
2812	171	293	3	6	\N	40
2813	172	293	0	0	\N	0
2814	173	293	0	1	\N	0
2815	144	293	1	1	\N	20
2816	145	293	3	5	\N	50
2817	152	293	3	4	\N	60
2818	153	293	2	2	\N	40
2819	154	293	1	3	\N	10
2820	139	294	4	5	\N	80
2821	140	294	2	3	\N	40
2822	180	294	1	4	\N	0
2823	181	294	4	4	\N	90
2824	190	294	0	3	\N	-20
2825	191	294	1	1	\N	20
2826	192	294	0	2	\N	-10
2827	141	295	4	4	\N	90
2828	142	295	2	2	\N	40
2829	143	295	2	3	\N	40
2830	131	295	4	4	\N	90
2831	132	295	0	0	\N	0
2832	133	295	1	1	\N	20
2833	193	295	4	6	\N	70
2834	194	295	3	4	\N	60
2835	146	296	4	4	\N	90
2836	147	296	1	1	\N	20
2837	148	296	0	0	\N	0
2838	204	296	4	6	\N	70
2839	205	296	2	2	\N	40
2840	206	296	1	2	\N	20
2841	180	296	1	1	\N	20
2842	181	296	0	1	\N	0
2843	141	297	4	4	\N	90
2844	142	297	0	0	\N	0
2845	143	297	0	1	\N	0
2846	152	297	4	4	\N	90
2847	153	297	0	0	\N	0
2848	154	297	4	4	\N	90
2849	209	297	3	3	\N	60
2850	210	297	3	4	\N	60
2851	211	297	2	4	\N	30
2852	176	298	1	3	\N	10
2853	177	298	1	1	\N	20
2854	178	298	2	3	\N	40
2855	179	298	1	2	\N	20
2856	155	298	0	1	\N	0
2857	156	298	2	3	\N	40
2858	157	298	1	2	\N	20
2859	138	298	0	2	\N	-10
2860	144	299	4	4	\N	90
2861	145	299	0	0	\N	0
2862	131	299	1	4	\N	0
2863	132	299	1	2	\N	20
2864	133	299	0	1	\N	0
2865	171	299	1	3	\N	10
2866	172	299	2	3	\N	40
2867	173	299	1	2	\N	20
2868	184	300	1	3	\N	10
2869	185	300	2	4	\N	30
2870	190	300	4	4	\N	90
2871	191	300	2	2	\N	40
2872	192	300	3	3	\N	60
2873	139	300	4	4	\N	90
2874	140	300	2	4	\N	30
2875	149	301	0	0	\N	0
2876	150	301	2	3	\N	40
2877	151	301	4	4	\N	90
2878	134	301	2	4	\N	30
2879	135	301	0	0	\N	0
2880	136	301	1	3	\N	10
2881	137	301	4	4	\N	90
2882	182	301	4	5	\N	80
2883	183	301	4	4	\N	90
2884	202	302	4	5	\N	80
2885	203	302	1	1	\N	20
2886	161	302	2	4	\N	30
2887	162	302	3	5	\N	50
2888	163	302	0	0	\N	0
2889	186	302	2	2	\N	40
2890	187	302	0	0	\N	0
2891	188	302	1	1	\N	20
2892	189	302	3	4	\N	60
2893	207	303	3	4	\N	60
2894	208	303	0	1	\N	0
2895	198	303	4	4	\N	90
2896	199	303	1	2	\N	20
2897	200	303	0	1	\N	0
2898	201	303	1	1	\N	20
2899	164	303	3	5	\N	50
2900	165	303	2	2	\N	40
2901	166	303	2	4	\N	30
2902	167	304	4	5	\N	80
2903	168	304	0	0	\N	0
2904	212	304	4	6	\N	70
2905	213	304	2	3	\N	40
2906	214	304	1	1	\N	20
2907	158	304	4	5	\N	80
2908	159	304	2	2	\N	40
2909	160	304	3	3	\N	60
2910	174	305	4	4	\N	90
2911	175	305	2	4	\N	30
2912	195	305	3	3	\N	60
2913	196	305	3	4	\N	60
2914	197	305	2	3	\N	40
2915	169	305	4	5	\N	80
2916	170	305	0	0	\N	0
2917	263	307	3	4	\N	60
2918	264	307	4	4	\N	90
2919	265	307	2	2	\N	40
2920	215	307	3	4	\N	60
2921	216	307	2	2	\N	40
2922	217	307	2	3	\N	40
2923	221	307	4	5	\N	80
2924	222	307	2	2	\N	40
2925	223	307	0	0	\N	0
2926	232	308	2	5	\N	20
2927	233	308	2	2	\N	40
2928	234	308	1	1	\N	20
2929	260	308	4	4	\N	90
2930	261	308	0	0	\N	0
2931	262	308	2	2	\N	40
2932	218	308	4	5	\N	80
2933	219	308	0	0	\N	0
2934	220	308	2	3	\N	40
2935	228	309	3	3	\N	60
2936	229	309	0	0	\N	0
2937	230	309	0	0	\N	0
2938	231	309	0	0	\N	0
2939	235	309	2	3	\N	40
2940	236	309	1	2	\N	20
2941	237	309	1	2	\N	20
2942	253	309	0	1	\N	0
2943	254	309	4	4	\N	90
2944	255	309	2	3	\N	40
2945	256	310	4	5	\N	80
2946	257	310	4	4	\N	90
2947	258	310	2	2	\N	40
2948	259	310	0	0	\N	0
2949	238	310	3	4	\N	60
2950	239	310	2	4	\N	30
2951	240	310	1	2	\N	20
2952	241	310	4	5	\N	80
2953	242	310	3	3	\N	60
2954	243	310	1	1	\N	20
2955	244	310	2	3	\N	40
2956	269	311	4	4	\N	90
2957	270	311	1	1	\N	20
2958	271	311	4	4	\N	90
2959	272	311	1	1	\N	20
2960	224	311	4	4	\N	90
2961	225	311	1	1	\N	20
2962	226	311	3	3	\N	60
2963	227	311	0	0	\N	0
2964	245	311	3	5	\N	50
2965	246	311	3	5	\N	50
2966	247	311	0	2	\N	-10
2967	248	311	1	1	\N	20
2968	266	312	3	3	\N	60
2969	267	312	2	3	\N	40
2970	268	312	2	3	\N	40
2971	249	312	1	3	\N	10
2972	250	312	1	1	\N	20
2973	251	312	0	1	\N	0
2974	252	312	2	2	\N	40
2975	266	312	0	2	\N	-10
2976	267	312	1	2	\N	20
2977	268	312	0	1	\N	0
2978	215	313	4	5	\N	80
2979	216	313	2	2	\N	40
2980	217	313	0	1	\N	0
2981	224	313	0	1	\N	0
2982	225	313	0	2	\N	-10
2983	226	313	3	3	\N	60
2984	227	313	1	1	\N	20
2985	263	313	4	4	\N	90
2986	264	313	1	1	\N	20
2987	265	313	1	1	\N	20
2988	235	314	2	5	\N	20
2989	236	314	1	1	\N	20
2990	237	314	1	1	\N	20
2991	218	314	1	3	\N	10
2992	219	314	2	2	\N	40
2993	220	314	1	1	\N	20
2994	238	314	0	3	\N	-20
2995	239	314	0	0	\N	0
2996	240	314	2	3	\N	40
2997	241	314	2	2	\N	40
2998	232	315	3	3	\N	60
2999	233	315	0	0	\N	0
3000	234	315	3	4	\N	60
3001	269	315	3	4	\N	60
3002	270	315	1	1	\N	20
3003	271	315	0	1	\N	0
3004	272	315	0	0	\N	0
3005	228	315	2	2	\N	40
3006	229	315	1	3	\N	10
3007	230	315	2	2	\N	40
3008	231	315	1	2	\N	20
3009	245	316	3	3	\N	60
3010	246	316	0	0	\N	0
3011	247	316	2	2	\N	40
3012	248	316	1	2	\N	20
3013	249	316	2	5	\N	20
3014	250	316	0	0	\N	0
3015	251	316	2	2	\N	40
3016	252	316	0	0	\N	0
3017	256	316	0	2	\N	-10
3018	257	316	2	2	\N	40
3019	258	316	0	0	\N	0
3020	259	316	4	5	\N	80
3021	260	317	3	4	\N	60
3022	261	317	2	3	\N	40
3023	262	317	2	2	\N	40
3024	221	317	2	3	\N	40
3025	222	317	2	3	\N	40
3026	223	317	1	3	\N	10
3027	253	317	4	5	\N	80
3028	254	317	4	5	\N	80
3029	255	317	1	2	\N	20
3030	242	318	4	4	\N	90
3031	243	318	1	1	\N	20
3032	244	318	2	2	\N	40
3033	218	318	3	3	\N	60
3034	219	318	2	2	\N	40
3035	220	318	4	4	\N	90
3036	249	318	4	5	\N	80
3037	250	318	0	1	\N	0
3038	251	318	1	1	\N	20
3039	252	318	1	2	\N	20
3040	221	319	0	3	\N	-20
3041	222	319	2	4	\N	30
3042	223	319	1	2	\N	20
3043	235	319	0	2	\N	-10
3044	236	319	4	6	\N	70
3045	237	319	4	4	\N	90
3046	245	319	0	0	\N	0
3047	246	319	0	0	\N	0
3048	247	319	0	1	\N	0
3049	248	319	3	5	\N	50
3050	228	320	2	5	\N	20
3051	229	320	1	2	\N	20
3052	230	320	4	4	\N	90
3053	231	320	1	2	\N	20
3054	242	320	2	5	\N	20
3055	243	320	0	2	\N	-10
3056	244	320	4	5	\N	80
3057	224	320	4	4	\N	90
3058	225	320	3	4	\N	60
3059	226	320	2	2	\N	40
3060	227	320	4	4	\N	90
3061	269	321	4	4	\N	90
3062	270	321	1	1	\N	20
3063	271	321	2	2	\N	40
3064	272	321	4	6	\N	70
3065	260	321	2	5	\N	20
3066	261	321	1	1	\N	20
3067	262	321	2	2	\N	40
3068	232	321	4	5	\N	80
3069	233	321	2	4	\N	30
3070	234	321	1	1	\N	20
3071	215	322	1	4	\N	0
3072	216	322	1	1	\N	20
3073	217	322	4	4	\N	90
3074	263	322	3	4	\N	60
3075	264	322	4	4	\N	90
3076	265	322	2	2	\N	40
3077	256	322	4	5	\N	80
3078	257	322	1	3	\N	10
3079	258	322	0	0	\N	0
3080	259	322	1	2	\N	20
3081	238	323	4	4	\N	90
3082	239	323	2	3	\N	40
3083	240	323	2	2	\N	40
3084	241	323	0	1	\N	0
3085	253	323	0	2	\N	-10
3086	254	323	3	3	\N	60
3087	255	323	1	1	\N	20
3088	266	323	4	4	\N	90
3089	267	323	0	1	\N	0
3090	268	323	2	2	\N	40
3091	232	324	3	4	\N	60
3092	233	324	4	4	\N	90
3093	234	324	0	0	\N	0
3094	238	324	0	2	\N	-10
3095	239	324	1	1	\N	20
3096	240	324	1	2	\N	20
3097	241	324	1	1	\N	20
3098	228	324	4	5	\N	80
3099	229	324	3	3	\N	60
3100	230	324	0	0	\N	0
3101	231	324	2	2	\N	40
3102	249	325	3	4	\N	60
3103	250	325	2	2	\N	40
3104	251	325	1	3	\N	10
3105	252	325	0	0	\N	0
3106	215	325	2	5	\N	20
3107	216	325	2	2	\N	40
3108	217	325	2	2	\N	40
3109	263	325	4	4	\N	90
3110	264	325	2	4	\N	30
3111	265	325	4	4	\N	90
3112	221	326	1	4	\N	0
3113	222	326	0	1	\N	0
3114	223	326	2	3	\N	40
3115	235	326	1	2	\N	20
3116	236	326	3	4	\N	60
3117	237	326	4	4	\N	90
3118	269	326	4	4	\N	90
3119	270	326	2	2	\N	40
3120	271	326	0	0	\N	0
3121	272	326	0	0	\N	0
3122	253	327	4	4	\N	90
3123	254	327	0	0	\N	0
3124	255	327	1	3	\N	10
3125	260	327	4	5	\N	80
3126	261	327	1	1	\N	20
3127	262	327	0	2	\N	-10
3128	224	327	3	5	\N	50
3129	225	327	0	0	\N	0
3130	226	327	2	2	\N	40
3131	227	327	0	0	\N	0
3132	242	328	4	4	\N	90
3133	243	328	3	3	\N	60
3134	244	328	1	1	\N	20
3135	256	328	1	2	\N	20
3136	257	328	0	2	\N	-10
3137	258	328	0	0	\N	0
3138	259	328	2	3	\N	40
3139	266	328	4	4	\N	90
3140	267	328	4	4	\N	90
3141	268	328	1	1	\N	20
3142	245	329	3	6	\N	40
3143	246	329	1	1	\N	20
3144	247	329	4	4	\N	90
3145	248	329	4	4	\N	90
3146	218	329	2	3	\N	40
3147	219	329	2	3	\N	40
3148	220	329	0	0	\N	0
3149	242	329	3	5	\N	50
3150	243	329	1	3	\N	10
3151	244	329	3	3	\N	60
3152	215	330	3	6	\N	40
3153	216	330	0	0	\N	0
3154	217	330	2	2	\N	40
3155	224	330	4	4	\N	90
3156	225	330	1	1	\N	20
3157	226	330	0	0	\N	0
3158	227	330	4	6	\N	70
3159	266	330	3	4	\N	60
3160	267	330	2	4	\N	30
3161	268	330	1	2	\N	20
3162	249	331	3	6	\N	40
3163	250	331	2	2	\N	40
3164	251	331	2	3	\N	40
3165	252	331	1	1	\N	20
3166	269	331	3	3	\N	60
3167	270	331	0	1	\N	0
3168	271	331	2	3	\N	40
3169	272	331	2	3	\N	40
3170	238	331	3	4	\N	60
3171	239	331	0	0	\N	0
3172	240	331	1	1	\N	20
3173	241	331	4	5	\N	80
3174	221	332	3	5	\N	50
3175	222	332	1	1	\N	20
3176	223	332	0	0	\N	0
3177	256	332	0	0	\N	0
3178	257	332	4	4	\N	90
3179	258	332	4	4	\N	90
3180	259	332	3	3	\N	60
3181	218	332	3	5	\N	50
3182	219	332	2	2	\N	40
3183	220	332	0	0	\N	0
3184	232	333	1	2	\N	20
3185	233	333	4	5	\N	80
3186	234	333	1	1	\N	20
3187	228	333	0	0	\N	0
3188	229	333	1	1	\N	20
3189	230	333	1	2	\N	20
3190	231	333	1	1	\N	20
3191	260	333	0	2	\N	-10
3192	261	333	0	0	\N	0
3193	262	333	2	2	\N	40
3194	245	334	3	3	\N	60
3195	246	334	2	2	\N	40
3196	247	334	1	2	\N	20
3197	248	334	0	0	\N	0
3198	235	334	2	4	\N	30
3199	236	334	1	3	\N	10
3200	237	334	2	2	\N	40
3201	253	334	1	3	\N	10
3202	254	334	0	1	\N	0
3203	255	334	2	3	\N	40
3204	263	335	3	3	\N	60
3205	264	335	1	1	\N	20
3206	265	335	0	0	\N	0
3207	249	335	3	5	\N	50
3208	250	335	3	4	\N	60
3209	251	335	1	1	\N	20
3210	252	335	0	0	\N	0
3211	263	335	3	3	\N	60
3212	264	335	4	4	\N	90
3213	265	335	1	1	\N	20
3214	242	336	4	5	\N	80
3215	243	336	1	1	\N	20
3216	244	336	1	3	\N	10
3217	228	336	4	5	\N	80
3218	229	336	0	0	\N	0
3219	230	336	1	2	\N	20
3220	231	336	0	1	\N	0
3221	238	336	2	4	\N	30
3222	239	336	2	2	\N	40
3223	240	336	1	1	\N	20
3224	241	336	1	3	\N	10
3225	253	337	4	5	\N	80
3226	254	337	4	5	\N	80
3227	255	337	4	5	\N	80
3228	256	337	2	2	\N	40
3229	257	337	2	4	\N	30
3230	258	337	0	0	\N	0
3231	259	337	0	0	\N	0
3232	221	337	3	5	\N	50
3233	222	337	0	0	\N	0
3234	223	337	4	4	\N	90
3235	232	338	4	6	\N	70
3236	233	338	1	1	\N	20
3237	234	338	3	4	\N	60
3238	245	338	3	4	\N	60
3239	246	338	2	4	\N	30
3240	247	338	0	2	\N	-10
3241	248	338	0	1	\N	0
3242	224	338	4	5	\N	80
3243	225	338	0	2	\N	-10
3244	226	338	1	2	\N	20
3245	227	338	1	1	\N	20
3246	215	339	4	4	\N	90
3247	216	339	0	0	\N	0
3248	217	339	1	1	\N	20
3249	266	339	3	6	\N	40
3250	267	339	0	1	\N	0
3251	268	339	0	2	\N	-10
3252	235	339	1	2	\N	20
3253	236	339	1	2	\N	20
3254	237	339	4	4	\N	90
3255	218	340	1	1	\N	20
3256	219	340	0	0	\N	0
3257	220	340	0	2	\N	-10
3258	260	340	3	5	\N	50
3259	261	340	0	0	\N	0
3260	262	340	0	2	\N	-10
3261	269	340	4	5	\N	80
3262	270	340	2	2	\N	40
3263	271	340	2	2	\N	40
3264	272	340	1	1	\N	20
3265	17	343	2	3	\N	40
3266	18	343	0	1	\N	0
3267	19	343	1	1	\N	20
3268	57	343	3	4	\N	60
3269	58	343	2	2	\N	40
3270	59	343	0	0	\N	0
3271	60	343	1	1	\N	20
3272	54	343	4	5	\N	80
3273	55	343	3	3	\N	60
3274	56	343	1	1	\N	20
3275	127	344	1	1	\N	20
3276	128	344	1	1	\N	20
3277	129	344	2	3	\N	40
3278	130	344	2	2	\N	40
3279	69	344	2	2	\N	40
3280	70	344	3	3	\N	60
3281	71	344	2	2	\N	40
3282	72	344	2	3	\N	40
3283	118	344	2	4	\N	30
3284	119	344	1	1	\N	20
3285	120	344	0	2	\N	-10
3286	121	344	2	2	\N	40
3287	122	344	2	2	\N	40
3288	46	345	3	5	\N	50
3289	47	345	4	4	\N	90
3290	48	345	3	3	\N	60
3291	49	345	4	4	\N	90
3292	103	345	4	4	\N	90
3293	104	345	0	0	\N	0
3294	105	345	0	1	\N	0
3295	106	345	4	5	\N	80
3296	107	345	1	1	\N	20
3297	108	345	0	1	\N	0
3298	109	345	1	2	\N	20
3299	5	346	3	5	\N	50
3300	6	346	1	3	\N	10
3301	7	346	2	3	\N	40
3302	50	346	3	6	\N	40
3303	51	346	1	1	\N	20
3304	52	346	1	1	\N	20
3305	53	346	0	0	\N	0
3306	42	346	3	5	\N	50
3307	43	346	1	1	\N	20
3308	44	346	2	3	\N	40
3309	45	346	3	3	\N	60
3310	8	347	4	6	\N	70
3311	9	347	1	1	\N	20
3312	10	347	1	1	\N	20
3313	11	347	1	1	\N	20
3314	12	347	1	1	\N	20
3315	20	347	4	5	\N	80
3316	21	347	0	0	\N	0
3317	22	347	0	0	\N	0
3318	99	347	4	4	\N	90
3319	100	347	2	3	\N	40
3320	101	347	1	1	\N	20
3321	102	347	1	2	\N	20
3322	91	348	3	6	\N	40
3323	92	348	4	4	\N	90
3324	93	348	2	2	\N	40
3325	94	348	4	4	\N	90
3326	87	348	1	1	\N	20
3327	88	348	2	3	\N	40
3328	89	348	1	1	\N	20
3329	90	348	2	4	\N	30
3330	13	348	0	0	\N	0
3331	14	348	0	2	\N	-10
3332	15	348	0	1	\N	0
3333	16	348	0	0	\N	0
3334	83	349	3	5	\N	50
3335	84	349	0	1	\N	0
3336	85	349	4	6	\N	70
3337	86	349	3	3	\N	60
3338	79	349	4	4	\N	90
3339	80	349	2	2	\N	40
3340	81	349	3	3	\N	60
3341	82	349	0	1	\N	0
3342	76	349	2	2	\N	40
3343	77	349	1	2	\N	20
3344	78	349	2	3	\N	40
3345	73	350	3	5	\N	50
3346	74	350	0	0	\N	0
3347	75	350	3	4	\N	60
3348	32	350	4	5	\N	80
3349	33	350	1	3	\N	10
3350	34	350	2	3	\N	40
3351	27	350	4	5	\N	80
3352	28	350	4	4	\N	90
3353	29	350	0	0	\N	0
3354	30	350	2	2	\N	40
3355	31	350	1	3	\N	10
3356	61	351	1	4	\N	0
3357	62	351	4	4	\N	90
3358	63	351	2	2	\N	40
3359	39	351	4	6	\N	70
3360	40	351	2	2	\N	40
3361	41	351	0	0	\N	0
3362	1	351	3	3	\N	60
3363	2	351	4	4	\N	90
3364	3	351	0	2	\N	-10
3365	4	351	1	1	\N	20
3366	23	352	3	3	\N	60
3367	24	352	2	3	\N	40
3368	25	352	0	2	\N	-10
3369	26	352	0	1	\N	0
3370	95	352	4	5	\N	80
3371	96	352	2	2	\N	40
3372	97	352	1	1	\N	20
3373	98	352	0	0	\N	0
3374	110	352	4	5	\N	80
3375	111	352	1	1	\N	20
3376	112	352	2	2	\N	40
3377	113	352	1	1	\N	20
3378	35	353	2	4	\N	30
3379	36	353	2	3	\N	40
3380	37	353	3	5	\N	50
3381	38	353	1	2	\N	20
3382	64	353	3	4	\N	60
3383	65	353	1	1	\N	20
3384	66	353	1	1	\N	20
3385	67	353	0	0	\N	0
3386	68	353	1	1	\N	20
3387	123	353	3	5	\N	50
3388	124	353	2	2	\N	40
3389	125	353	0	0	\N	0
3390	126	353	0	1	\N	0
3391	114	354	3	4	\N	60
3392	115	354	0	0	\N	0
3393	116	354	2	2	\N	40
3394	117	354	4	4	\N	90
3395	35	354	4	5	\N	80
3396	36	354	4	4	\N	90
3397	37	354	0	1	\N	0
3398	38	354	4	4	\N	90
3399	27	354	3	4	\N	60
3400	28	354	1	2	\N	20
3401	29	354	2	3	\N	40
3402	30	354	2	3	\N	40
3403	31	354	0	0	\N	0
3404	50	355	2	3	\N	40
3405	51	355	4	4	\N	90
3406	52	355	1	1	\N	20
3407	53	355	0	1	\N	0
3408	73	355	0	1	\N	0
3409	74	355	2	2	\N	40
3410	75	355	0	2	\N	-10
3411	46	355	0	1	\N	0
3412	47	355	1	1	\N	20
3413	48	355	3	5	\N	50
3414	49	355	1	1	\N	20
3415	127	356	0	2	\N	-10
3416	128	356	2	4	\N	30
3417	129	356	1	1	\N	20
3418	130	356	1	1	\N	20
3419	5	356	3	3	\N	60
3420	6	356	0	0	\N	0
3421	7	356	0	2	\N	-10
3422	61	356	3	6	\N	40
3423	62	356	1	1	\N	20
3424	63	356	3	3	\N	60
3425	76	357	3	6	\N	40
3426	77	357	1	1	\N	20
3427	78	357	4	4	\N	90
3428	83	357	3	3	\N	60
3429	84	357	0	1	\N	0
3430	85	357	3	5	\N	50
3431	86	357	0	2	\N	-10
3432	79	357	4	4	\N	90
3433	80	357	1	1	\N	20
3434	81	357	1	2	\N	20
3435	82	357	1	2	\N	20
3436	87	358	3	3	\N	60
3437	88	358	0	0	\N	0
3438	89	358	1	1	\N	20
3439	90	358	1	1	\N	20
3440	95	358	3	4	\N	60
3441	96	358	2	3	\N	40
3442	97	358	2	2	\N	40
3443	98	358	4	4	\N	90
3444	64	358	4	5	\N	80
3445	65	358	0	0	\N	0
3446	66	358	1	2	\N	20
3447	67	358	2	3	\N	40
3448	68	358	0	0	\N	0
3449	54	359	4	4	\N	90
3450	55	359	0	0	\N	0
3451	56	359	4	4	\N	90
3452	8	359	4	4	\N	90
3453	9	359	0	0	\N	0
3454	10	359	1	2	\N	20
3455	11	359	2	3	\N	40
3456	12	359	3	3	\N	60
3457	114	359	1	2	\N	20
3458	115	359	2	3	\N	40
3459	116	359	2	2	\N	40
3460	117	359	2	2	\N	40
3461	13	360	3	4	\N	60
3462	14	360	1	1	\N	20
3463	15	360	1	1	\N	20
3464	16	360	1	3	\N	10
3465	103	360	2	2	\N	40
3466	104	360	2	3	\N	40
3467	105	360	1	1	\N	20
3468	42	360	4	4	\N	90
3469	43	360	3	3	\N	60
3470	44	360	1	2	\N	20
3471	45	360	2	4	\N	30
3472	106	361	3	4	\N	60
3473	107	361	2	2	\N	40
3474	108	361	2	2	\N	40
3475	109	361	0	0	\N	0
3476	118	361	2	5	\N	20
3477	119	361	4	5	\N	80
3478	120	361	0	1	\N	0
3479	121	361	2	2	\N	40
3480	122	361	1	2	\N	20
3481	69	361	4	5	\N	80
3482	70	361	2	3	\N	40
3483	71	361	4	5	\N	80
3484	72	361	3	3	\N	60
3485	32	362	3	4	\N	60
3486	33	362	1	3	\N	10
3487	34	362	4	4	\N	90
3488	110	362	0	1	\N	0
3489	111	362	1	1	\N	20
3490	112	362	0	0	\N	0
3491	113	362	0	0	\N	0
3492	57	362	4	5	\N	80
3493	58	362	0	1	\N	0
3494	59	362	0	0	\N	0
3495	60	362	1	2	\N	20
3496	23	363	4	4	\N	90
3497	24	363	0	0	\N	0
3498	25	363	0	0	\N	0
3499	26	363	1	1	\N	20
3500	123	363	0	2	\N	-10
3501	124	363	4	4	\N	90
3502	125	363	4	4	\N	90
3503	126	363	2	3	\N	40
3504	17	363	4	5	\N	80
3505	18	363	2	2	\N	40
3506	19	363	1	2	\N	20
3507	1	364	1	2	\N	20
3508	2	364	0	0	\N	0
3509	3	364	3	3	\N	60
3510	4	364	1	2	\N	20
3511	99	364	4	5	\N	80
3512	100	364	2	3	\N	40
3513	101	364	0	0	\N	0
3514	102	364	3	3	\N	60
3515	20	364	3	6	\N	40
3516	21	364	1	1	\N	20
3517	22	364	0	1	\N	0
3518	39	365	2	5	\N	20
3519	40	365	4	4	\N	90
3520	41	365	0	0	\N	0
3521	91	365	4	6	\N	70
3522	92	365	2	3	\N	40
3523	93	365	4	4	\N	90
3524	94	365	0	0	\N	0
3525	69	365	3	4	\N	60
3526	70	365	3	5	\N	50
3527	71	365	0	0	\N	0
3528	72	365	4	6	\N	70
3529	76	366	3	4	\N	60
3530	77	366	0	0	\N	0
3531	78	366	1	1	\N	20
3532	91	366	3	4	\N	60
3533	92	366	1	1	\N	20
3534	93	366	1	1	\N	20
3535	94	366	0	0	\N	0
3536	17	366	2	2	\N	40
3537	18	366	1	1	\N	20
3538	19	366	0	2	\N	-10
3539	118	367	3	3	\N	60
3540	119	367	2	2	\N	40
3541	120	367	1	2	\N	20
3542	121	367	0	1	\N	0
3543	122	367	0	1	\N	0
3544	99	367	1	1	\N	20
3545	100	367	4	4	\N	90
3546	101	367	4	5	\N	80
3547	102	367	1	1	\N	20
3548	57	367	2	3	\N	40
3549	58	367	2	3	\N	40
3550	59	367	2	2	\N	40
3551	60	367	0	0	\N	0
3552	61	368	1	4	\N	0
3553	62	368	0	0	\N	0
3554	63	368	1	1	\N	20
3555	23	368	4	4	\N	90
3556	24	368	1	1	\N	20
3557	25	368	0	0	\N	0
3558	26	368	1	1	\N	20
3559	95	368	1	1	\N	20
3560	96	368	4	6	\N	70
3561	97	368	0	1	\N	0
3562	98	368	0	0	\N	0
3563	27	369	3	3	\N	60
3564	28	369	0	0	\N	0
3565	29	369	0	0	\N	0
3566	30	369	2	3	\N	40
3567	31	369	0	0	\N	0
3568	5	369	4	5	\N	80
3569	6	369	0	0	\N	0
3570	7	369	2	2	\N	40
3571	13	369	3	5	\N	50
3572	14	369	3	3	\N	60
3573	15	369	2	2	\N	40
3574	16	369	3	3	\N	60
3575	79	370	3	4	\N	60
3576	80	370	1	2	\N	20
3577	81	370	0	0	\N	0
3578	82	370	0	1	\N	0
3579	39	370	0	0	\N	0
3580	40	370	3	3	\N	60
3581	41	370	0	0	\N	0
3582	106	370	4	5	\N	80
3583	107	370	3	3	\N	60
3584	108	370	1	2	\N	20
3585	109	370	2	2	\N	40
3586	42	371	2	3	\N	40
3587	43	371	2	2	\N	40
3588	44	371	1	1	\N	20
3589	45	371	2	3	\N	40
3590	83	371	3	4	\N	60
3591	84	371	0	0	\N	0
3592	85	371	4	5	\N	80
3593	86	371	0	0	\N	0
3594	50	371	4	4	\N	90
3595	51	371	1	1	\N	20
3596	52	371	4	4	\N	90
3597	53	371	1	1	\N	20
3598	127	372	3	4	\N	60
3599	128	372	0	0	\N	0
3600	129	372	2	3	\N	40
3601	130	372	4	5	\N	80
3602	35	372	1	3	\N	10
3603	36	372	0	1	\N	0
3604	37	372	0	0	\N	0
3605	38	372	0	0	\N	0
3606	46	372	4	6	\N	70
3607	47	372	3	3	\N	60
3608	48	372	1	1	\N	20
3609	49	372	3	3	\N	60
3610	1	373	4	4	\N	90
3611	2	373	1	2	\N	20
3612	3	373	2	2	\N	40
3613	4	373	0	1	\N	0
3614	8	373	0	0	\N	0
3615	9	373	2	3	\N	40
3616	10	373	1	1	\N	20
3617	11	373	1	1	\N	20
3618	12	373	0	1	\N	0
3619	103	373	3	5	\N	50
3620	104	373	1	1	\N	20
3621	105	373	2	4	\N	30
3622	110	374	3	5	\N	50
3623	111	374	1	1	\N	20
3624	112	374	0	0	\N	0
3625	113	374	1	2	\N	20
3626	54	374	0	2	\N	-10
3627	55	374	1	3	\N	10
3628	56	374	3	3	\N	60
3629	73	374	4	4	\N	90
3630	74	374	2	2	\N	40
3631	75	374	1	1	\N	20
3632	32	375	3	3	\N	60
3633	33	375	3	5	\N	50
3634	34	375	0	2	\N	-10
3635	20	375	1	2	\N	20
3636	21	375	4	5	\N	80
3637	22	375	3	3	\N	60
3638	87	375	3	6	\N	40
3639	88	375	0	2	\N	-10
3640	89	375	4	5	\N	80
3641	90	375	3	3	\N	60
3642	123	376	1	3	\N	10
3643	124	376	2	3	\N	40
3644	125	376	1	2	\N	20
3645	126	376	1	2	\N	20
3646	64	376	0	0	\N	0
3647	65	376	1	1	\N	20
3648	66	376	1	1	\N	20
3649	67	376	2	2	\N	40
3650	68	376	1	2	\N	20
3651	114	376	4	6	\N	70
3652	115	376	1	1	\N	20
3653	116	376	0	0	\N	0
3654	117	376	4	6	\N	70
3655	83	377	3	4	\N	60
3656	84	377	2	2	\N	40
3657	85	377	2	3	\N	40
3658	86	377	0	0	\N	0
3659	64	377	3	4	\N	60
3660	65	377	0	0	\N	0
3661	66	377	2	2	\N	40
3662	67	377	2	2	\N	40
3663	68	377	0	0	\N	0
3664	42	377	3	4	\N	60
3665	43	377	2	2	\N	40
3666	44	377	3	4	\N	60
3667	45	377	3	5	\N	50
3668	106	378	4	5	\N	80
3669	107	378	1	1	\N	20
3670	108	378	1	1	\N	20
3671	109	378	1	2	\N	20
3672	32	378	4	5	\N	80
3673	33	378	0	0	\N	0
3674	34	378	0	0	\N	0
3675	1	378	4	5	\N	80
3676	2	378	4	4	\N	90
3677	3	378	2	2	\N	40
3678	4	378	1	2	\N	20
3679	39	379	3	3	\N	60
3680	40	379	1	1	\N	20
3681	41	379	1	1	\N	20
3682	110	379	1	2	\N	20
3683	111	379	1	1	\N	20
3684	112	379	2	3	\N	40
3685	113	379	2	2	\N	40
3686	103	379	4	4	\N	90
3687	104	379	2	2	\N	40
3688	105	379	2	3	\N	40
3689	79	380	4	6	\N	70
3690	80	380	4	5	\N	80
3691	81	380	0	0	\N	0
3692	82	380	3	4	\N	60
3693	17	380	0	1	\N	0
3694	18	380	1	1	\N	20
3695	19	380	1	3	\N	10
3696	5	380	4	4	\N	90
3697	6	380	2	2	\N	40
3698	7	380	1	1	\N	20
3699	61	381	4	6	\N	70
3700	62	381	2	2	\N	40
3701	63	381	0	2	\N	-10
3702	99	381	3	4	\N	60
3703	100	381	0	0	\N	0
3704	101	381	3	3	\N	60
3705	102	381	3	3	\N	60
3706	91	381	3	6	\N	40
3707	92	381	4	4	\N	90
3708	93	381	1	1	\N	20
3709	94	381	1	1	\N	20
3710	69	382	3	4	\N	60
3711	70	382	0	2	\N	-10
3712	71	382	1	1	\N	20
3713	72	382	0	1	\N	0
3714	76	382	4	4	\N	90
3715	77	382	4	4	\N	90
3716	78	382	2	3	\N	40
3717	118	382	4	4	\N	90
3718	119	382	1	1	\N	20
3719	120	382	1	2	\N	20
3720	121	382	3	3	\N	60
3721	122	382	0	0	\N	0
3722	57	383	4	4	\N	90
3723	58	383	1	1	\N	20
3724	59	383	2	2	\N	40
3725	60	383	1	2	\N	20
3726	27	383	4	5	\N	80
3727	28	383	1	1	\N	20
3728	29	383	0	0	\N	0
3729	30	383	1	3	\N	10
3730	31	383	4	5	\N	80
3731	54	383	4	5	\N	80
3732	55	383	1	1	\N	20
3733	56	383	2	3	\N	40
3734	95	384	3	4	\N	60
3735	96	384	4	4	\N	90
3736	97	384	2	2	\N	40
3737	98	384	1	1	\N	20
3738	114	384	3	3	\N	60
3739	115	384	1	2	\N	20
3740	116	384	1	1	\N	20
3741	117	384	0	0	\N	0
3742	50	384	3	4	\N	60
3743	51	384	0	0	\N	0
3744	52	384	3	3	\N	60
3745	53	384	2	3	\N	40
3746	13	385	4	4	\N	90
3747	14	385	1	1	\N	20
3748	15	385	1	2	\N	20
3749	16	385	2	2	\N	40
3750	20	385	1	3	\N	10
3751	21	385	1	1	\N	20
3752	22	385	4	5	\N	80
3753	35	385	3	4	\N	60
3754	36	385	1	2	\N	20
3755	37	385	3	3	\N	60
3756	38	385	1	1	\N	20
3757	127	386	2	5	\N	20
3758	128	386	0	1	\N	0
3759	129	386	1	2	\N	20
3760	130	386	2	3	\N	40
3761	73	386	4	4	\N	90
3762	74	386	1	1	\N	20
3763	75	386	1	1	\N	20
3764	23	386	3	4	\N	60
3765	24	386	1	1	\N	20
3766	25	386	0	0	\N	0
3767	26	386	0	0	\N	0
3768	123	387	4	5	\N	80
3769	124	387	1	1	\N	20
3770	125	387	0	0	\N	0
3771	126	387	0	1	\N	0
3772	87	387	2	4	\N	30
3773	88	387	3	5	\N	50
3774	89	387	0	1	\N	0
3775	90	387	0	1	\N	0
3776	46	387	3	6	\N	40
3777	47	387	0	1	\N	0
3778	48	387	4	4	\N	90
3779	49	387	0	1	\N	0
3780	8	388	4	5	\N	80
3781	9	388	1	1	\N	20
3782	10	388	1	2	\N	20
3783	11	388	0	0	\N	0
3784	12	388	0	2	\N	-10
3785	27	388	3	3	\N	60
3786	28	388	1	1	\N	20
3787	29	388	2	3	\N	40
3788	30	388	0	1	\N	0
3789	31	388	0	0	\N	0
3790	1	388	4	5	\N	80
3791	2	388	2	2	\N	40
3792	3	388	0	1	\N	0
3793	4	388	3	4	\N	60
3794	64	389	0	2	\N	-10
3795	65	389	2	2	\N	40
3796	66	389	0	0	\N	0
3797	67	389	0	2	\N	-10
3798	68	389	2	2	\N	40
3799	8	389	4	4	\N	90
3800	9	389	2	3	\N	40
3801	10	389	3	3	\N	60
3802	11	389	0	1	\N	0
3803	12	389	0	2	\N	-10
3804	87	389	4	4	\N	90
3805	88	389	2	2	\N	40
3806	89	389	1	1	\N	20
3807	90	389	1	1	\N	20
3808	95	390	4	6	\N	70
3809	96	390	1	1	\N	20
3810	97	390	2	4	\N	30
3811	98	390	1	1	\N	20
3812	5	390	4	4	\N	90
3813	6	390	2	3	\N	40
3814	7	390	0	0	\N	0
3815	69	390	3	5	\N	50
3816	70	390	1	1	\N	20
3817	71	390	4	4	\N	90
3818	72	390	0	0	\N	0
3819	50	391	0	2	\N	-10
3820	51	391	0	0	\N	0
3821	52	391	1	2	\N	20
3822	53	391	2	4	\N	30
3823	114	391	1	2	\N	20
3824	115	391	0	1	\N	0
3825	116	391	1	1	\N	20
3826	117	391	3	3	\N	60
3827	91	391	4	4	\N	90
3828	92	391	2	3	\N	40
3829	93	391	1	1	\N	20
3830	94	391	0	1	\N	0
3831	73	392	3	5	\N	50
3832	74	392	3	4	\N	60
3833	75	392	0	0	\N	0
3834	103	392	0	1	\N	0
3835	104	392	1	3	\N	10
3836	105	392	3	3	\N	60
3837	127	392	4	4	\N	90
3838	128	392	1	2	\N	20
3839	129	392	2	2	\N	40
3840	130	392	1	1	\N	20
3841	17	393	2	4	\N	30
3842	18	393	1	1	\N	20
3843	19	393	1	1	\N	20
3844	42	393	4	5	\N	80
3845	43	393	1	3	\N	10
3846	44	393	1	1	\N	20
3847	45	393	1	1	\N	20
3848	57	393	3	4	\N	60
3849	58	393	4	5	\N	80
3850	59	393	0	0	\N	0
3851	60	393	0	0	\N	0
3852	35	394	3	5	\N	50
3853	36	394	4	4	\N	90
3854	37	394	4	4	\N	90
3855	38	394	4	4	\N	90
3856	118	394	3	4	\N	60
3857	119	394	1	1	\N	20
3858	120	394	0	1	\N	0
3859	121	394	3	3	\N	60
3860	122	394	1	2	\N	20
3861	110	394	4	5	\N	80
3862	111	394	2	2	\N	40
3863	112	394	2	2	\N	40
3864	113	394	2	2	\N	40
3865	61	395	3	3	\N	60
3866	62	395	4	4	\N	90
3867	63	395	0	0	\N	0
3868	79	395	4	4	\N	90
3869	80	395	3	3	\N	60
3870	81	395	1	1	\N	20
3871	82	395	0	1	\N	0
3872	20	395	4	5	\N	80
3873	21	395	1	1	\N	20
3874	22	395	3	3	\N	60
3875	23	396	2	4	\N	30
3876	24	396	1	1	\N	20
3877	25	396	0	0	\N	0
3878	26	396	1	1	\N	20
3879	46	396	0	2	\N	-10
3880	47	396	0	0	\N	0
3881	48	396	0	1	\N	0
3882	49	396	0	2	\N	-10
3883	99	396	3	6	\N	40
3884	100	396	2	2	\N	40
3885	101	396	1	1	\N	20
3886	102	396	2	3	\N	40
3887	123	397	4	6	\N	70
3888	124	397	0	0	\N	0
3889	125	397	1	2	\N	20
3890	126	397	1	1	\N	20
3891	54	397	2	3	\N	40
3892	55	397	0	0	\N	0
3893	56	397	0	1	\N	0
3894	39	397	4	4	\N	90
3895	40	397	2	2	\N	40
3896	41	397	1	1	\N	20
3897	13	398	4	5	\N	80
3898	14	398	0	0	\N	0
3899	15	398	4	5	\N	80
3900	16	398	2	3	\N	40
3901	76	398	2	3	\N	40
3902	77	398	1	1	\N	20
3903	78	398	1	1	\N	20
3904	106	398	4	5	\N	80
3905	107	398	0	1	\N	0
3906	108	398	1	2	\N	20
3907	109	398	1	3	\N	10
3908	83	399	4	4	\N	90
3909	84	399	2	3	\N	40
3910	85	399	2	2	\N	40
3911	86	399	2	2	\N	40
3912	32	399	4	5	\N	80
3913	33	399	1	1	\N	20
3914	34	399	1	2	\N	20
3915	5	399	4	5	\N	80
3916	6	399	1	2	\N	20
3917	7	399	0	0	\N	0
3918	95	400	3	6	\N	40
3919	96	400	2	3	\N	40
3920	97	400	1	1	\N	20
3921	98	400	2	4	\N	30
3922	8	400	0	0	\N	0
3923	9	400	3	3	\N	60
3924	10	400	0	0	\N	0
3925	11	400	0	1	\N	0
3926	12	400	1	1	\N	20
3927	46	400	3	4	\N	60
3928	47	400	1	2	\N	20
3929	48	400	3	3	\N	60
3930	49	400	1	1	\N	20
3931	57	401	2	5	\N	20
3932	58	401	2	2	\N	40
3933	59	401	1	1	\N	20
3934	60	401	0	2	\N	-10
3935	42	401	2	2	\N	40
3936	43	401	4	4	\N	90
3937	44	401	0	0	\N	0
3938	45	401	2	2	\N	40
3939	61	401	3	3	\N	60
3940	62	401	1	1	\N	20
3941	63	401	4	4	\N	90
3942	87	402	1	3	\N	10
3943	88	402	2	2	\N	40
3944	89	402	3	3	\N	60
3945	90	402	2	2	\N	40
3946	32	402	4	5	\N	80
3947	33	402	0	0	\N	0
3948	34	402	1	2	\N	20
3949	1	402	3	4	\N	60
3950	2	402	2	2	\N	40
3951	3	402	0	0	\N	0
3952	4	402	1	3	\N	10
3953	127	403	3	3	\N	60
3954	128	403	2	3	\N	40
3955	129	403	4	4	\N	90
3956	130	403	0	0	\N	0
3957	99	403	4	4	\N	90
3958	100	403	4	4	\N	90
3959	101	403	4	4	\N	90
3960	102	403	2	2	\N	40
3961	27	403	4	5	\N	80
3962	28	403	0	0	\N	0
3963	29	403	0	2	\N	-10
3964	30	403	0	1	\N	0
3965	31	403	1	2	\N	20
3966	103	404	4	6	\N	70
3967	104	404	1	1	\N	20
3968	105	404	2	3	\N	40
3969	20	404	4	6	\N	70
3970	21	404	1	2	\N	20
3971	22	404	0	0	\N	0
3972	118	404	4	4	\N	90
3973	119	404	0	0	\N	0
3974	120	404	4	4	\N	90
3975	121	404	1	2	\N	20
3976	122	404	1	1	\N	20
3977	35	405	4	5	\N	80
3978	36	405	0	1	\N	0
3979	37	405	0	1	\N	0
3980	38	405	0	0	\N	0
3981	79	405	3	3	\N	60
3982	80	405	1	1	\N	20
3983	81	405	1	1	\N	20
3984	82	405	0	1	\N	0
3985	110	405	1	4	\N	0
3986	111	405	3	3	\N	60
3987	112	405	1	3	\N	10
3988	113	405	0	1	\N	0
3989	13	406	4	6	\N	70
3990	14	406	2	2	\N	40
3991	15	406	0	0	\N	0
3992	16	406	1	2	\N	20
3993	23	406	4	4	\N	90
3994	24	406	1	2	\N	20
3995	25	406	2	3	\N	40
3996	26	406	2	2	\N	40
3997	106	406	4	4	\N	90
3998	107	406	1	1	\N	20
3999	108	406	1	1	\N	20
4000	109	406	0	0	\N	0
4001	123	407	3	4	\N	60
4002	124	407	0	0	\N	0
4003	125	407	0	0	\N	0
4004	126	407	2	2	\N	40
4005	114	407	4	4	\N	90
4006	115	407	2	4	\N	30
4007	116	407	3	3	\N	60
4008	117	407	0	0	\N	0
4009	73	407	4	5	\N	80
4010	74	407	1	3	\N	10
4011	75	407	4	5	\N	80
4012	54	408	1	1	\N	20
4013	55	408	1	1	\N	20
4014	56	408	0	0	\N	0
4015	17	408	3	3	\N	60
4016	18	408	0	1	\N	0
4017	19	408	0	0	\N	0
4018	39	408	2	4	\N	30
4019	40	408	0	1	\N	0
4020	41	408	2	2	\N	40
4021	91	409	1	2	\N	20
4022	92	409	1	2	\N	20
4023	93	409	1	2	\N	20
4024	94	409	1	1	\N	20
4025	50	409	4	5	\N	80
4026	51	409	1	1	\N	20
4027	52	409	0	0	\N	0
4028	53	409	1	1	\N	20
4029	76	409	3	3	\N	60
4030	77	409	0	0	\N	0
4031	78	409	0	0	\N	0
4032	83	410	4	6	\N	70
4033	84	410	2	4	\N	30
4034	85	410	2	2	\N	40
4035	86	410	1	2	\N	20
4036	64	410	4	5	\N	80
4037	65	410	0	1	\N	0
4038	66	410	2	2	\N	40
4039	67	410	3	3	\N	60
4040	68	410	0	0	\N	0
4041	69	410	4	4	\N	90
4042	70	410	0	0	\N	0
4043	71	410	0	1	\N	0
4044	72	410	0	0	\N	0
4045	202	415	0	1	\N	0
4046	203	415	2	2	\N	40
4047	186	415	1	2	\N	20
4048	187	415	0	1	\N	0
4049	188	415	2	2	\N	40
4050	189	415	4	6	\N	70
4051	176	415	2	3	\N	40
4052	177	415	3	3	\N	60
4053	178	415	1	3	\N	10
4054	179	415	1	2	\N	20
4055	212	416	3	4	\N	60
4056	213	416	1	3	\N	10
4057	214	416	1	2	\N	20
4058	190	416	4	5	\N	80
4059	191	416	1	1	\N	20
4060	192	416	0	0	\N	0
4061	138	416	3	4	\N	60
4062	195	417	1	1	\N	20
4063	196	417	1	2	\N	20
4064	197	417	2	3	\N	40
4065	141	417	3	5	\N	50
4066	142	417	2	2	\N	40
4067	143	417	4	5	\N	80
4068	149	417	2	2	\N	40
4069	150	417	1	1	\N	20
4070	151	417	2	3	\N	40
4071	155	418	3	4	\N	60
4072	156	418	0	0	\N	0
4073	157	418	2	3	\N	40
4074	158	418	2	5	\N	20
4075	159	418	4	5	\N	80
4076	160	418	0	2	\N	-10
4077	146	418	3	4	\N	60
4078	147	418	2	2	\N	40
4079	148	418	1	1	\N	20
4080	209	419	1	1	\N	20
4081	210	419	2	2	\N	40
4082	211	419	1	1	\N	20
4083	198	419	3	6	\N	40
4084	199	419	0	1	\N	0
4085	200	419	0	0	\N	0
4086	201	419	0	1	\N	0
4087	164	419	1	3	\N	10
4088	165	419	1	2	\N	20
4089	166	419	0	0	\N	0
4090	180	420	4	4	\N	90
4091	181	420	2	2	\N	40
4092	144	420	2	2	\N	40
4093	145	420	0	1	\N	0
4094	152	420	1	1	\N	20
4095	153	420	4	4	\N	90
4096	154	420	0	0	\N	0
4097	193	421	2	4	\N	30
4098	194	421	2	3	\N	40
4099	174	421	2	3	\N	40
4100	175	421	0	1	\N	0
4101	161	421	0	1	\N	0
4102	162	421	2	2	\N	40
4103	163	421	0	0	\N	0
4104	167	422	3	4	\N	60
4105	168	422	2	2	\N	40
4106	207	422	4	4	\N	90
4107	208	422	1	3	\N	10
4108	204	422	4	5	\N	80
4109	205	422	1	1	\N	20
4110	206	422	0	0	\N	0
4111	171	423	4	5	\N	80
4112	172	423	0	0	\N	0
4113	173	423	2	4	\N	30
4114	139	423	3	5	\N	50
4115	140	423	2	3	\N	40
4116	169	423	4	6	\N	70
4117	170	423	4	4	\N	90
4118	134	424	4	5	\N	80
4119	135	424	4	4	\N	90
4120	136	424	3	5	\N	50
4121	137	424	0	1	\N	0
4122	184	424	2	2	\N	40
4123	185	424	0	1	\N	0
4124	131	424	4	5	\N	80
4125	132	424	2	2	\N	40
4126	133	424	1	1	\N	20
4127	182	425	2	5	\N	20
4128	183	425	0	1	\N	0
4129	139	425	1	2	\N	20
4130	140	425	4	4	\N	90
4131	190	425	4	4	\N	90
4132	191	425	1	3	\N	10
4133	192	425	4	6	\N	70
4134	174	426	1	2	\N	20
4135	175	426	1	3	\N	10
4136	202	426	4	4	\N	90
4137	203	426	0	0	\N	0
4138	152	426	0	1	\N	0
4139	153	426	1	1	\N	20
4140	154	426	0	0	\N	0
4141	169	427	4	6	\N	70
4142	170	427	1	1	\N	20
4143	204	427	1	2	\N	20
4144	205	427	4	4	\N	90
4145	206	427	2	2	\N	40
4146	134	427	4	5	\N	80
4147	135	427	3	4	\N	60
4148	136	427	2	4	\N	30
4149	137	427	1	1	\N	20
4150	149	428	4	5	\N	80
4151	150	428	3	3	\N	60
4152	151	428	0	0	\N	0
4153	180	428	3	4	\N	60
4154	181	428	0	0	\N	0
4155	207	428	4	4	\N	90
4156	208	428	2	3	\N	40
4157	195	429	3	6	\N	40
4158	196	429	1	1	\N	20
4159	197	429	1	2	\N	20
4160	155	429	4	4	\N	90
4161	156	429	0	0	\N	0
4162	157	429	2	2	\N	40
4163	146	429	4	4	\N	90
4164	147	429	1	1	\N	20
4165	148	429	4	6	\N	70
4166	182	430	1	3	\N	10
4167	183	430	1	1	\N	20
4168	141	430	4	4	\N	90
4169	142	430	1	1	\N	20
4170	143	430	0	0	\N	0
4171	209	430	3	4	\N	60
4172	210	430	1	1	\N	20
4173	211	430	3	3	\N	60
4174	198	431	1	2	\N	20
4175	199	431	2	2	\N	40
4176	200	431	1	1	\N	20
4177	201	431	4	5	\N	80
4178	186	431	0	0	\N	0
4179	187	431	1	2	\N	20
4180	188	431	4	5	\N	80
4181	189	431	0	0	\N	0
4182	131	431	4	5	\N	80
4183	132	431	0	0	\N	0
4184	133	431	3	3	\N	60
4185	171	432	3	6	\N	40
4186	172	432	1	1	\N	20
4187	173	432	2	4	\N	30
4188	167	432	4	4	\N	90
4189	168	432	0	0	\N	0
4190	193	432	4	5	\N	80
4191	194	432	4	4	\N	90
4192	184	433	4	5	\N	80
4193	185	433	0	0	\N	0
4194	212	433	4	5	\N	80
4195	213	433	3	4	\N	60
4196	214	433	0	0	\N	0
4197	161	433	3	3	\N	60
4198	162	433	2	2	\N	40
4199	163	433	0	0	\N	0
4200	176	434	4	4	\N	90
4201	177	434	2	2	\N	40
4202	178	434	4	5	\N	80
4203	179	434	1	1	\N	20
4204	138	434	2	3	\N	40
4205	164	434	3	4	\N	60
4206	165	434	0	2	\N	-10
4207	166	434	3	3	\N	60
4208	158	435	0	2	\N	-10
4209	159	435	1	1	\N	20
4210	160	435	4	4	\N	90
4211	144	435	0	0	\N	0
4212	145	435	2	2	\N	40
4213	131	435	4	5	\N	80
4214	132	435	2	3	\N	40
4215	133	435	0	0	\N	0
4216	195	436	0	2	\N	-10
4217	196	436	0	0	\N	0
4218	197	436	2	4	\N	30
4219	174	436	4	5	\N	80
4220	175	436	0	2	\N	-10
4221	176	436	3	3	\N	60
4222	177	436	1	2	\N	20
4223	178	436	0	0	\N	0
4224	179	436	4	4	\N	90
4225	167	437	0	2	\N	-10
4226	168	437	1	1	\N	20
4227	158	437	4	5	\N	80
4228	159	437	0	0	\N	0
4229	160	437	1	2	\N	20
4230	180	437	4	5	\N	80
4231	181	437	4	4	\N	90
4232	144	438	3	4	\N	60
4233	145	438	3	3	\N	60
4234	190	438	4	6	\N	70
4235	191	438	1	1	\N	20
4236	192	438	1	1	\N	20
4237	198	438	4	6	\N	70
4238	199	438	0	0	\N	0
4239	200	438	2	2	\N	40
4240	201	438	2	2	\N	40
4241	134	439	4	4	\N	90
4242	135	439	4	6	\N	70
4243	136	439	1	1	\N	20
4244	137	439	0	1	\N	0
4245	184	439	3	5	\N	50
4246	185	439	0	0	\N	0
4247	182	439	3	4	\N	60
4248	183	439	1	2	\N	20
4249	209	440	2	4	\N	30
4250	210	440	2	4	\N	30
4251	211	440	1	1	\N	20
4252	155	440	4	4	\N	90
4253	156	440	1	2	\N	20
4254	157	440	0	0	\N	0
4255	212	440	3	6	\N	40
4256	213	440	0	0	\N	0
4257	214	440	3	4	\N	60
4258	146	441	3	5	\N	50
4259	147	441	0	0	\N	0
4260	148	441	1	1	\N	20
4261	139	441	4	4	\N	90
4262	140	441	3	5	\N	50
4263	164	441	4	6	\N	70
4264	165	441	1	2	\N	20
4265	166	441	0	0	\N	0
4266	204	442	4	5	\N	80
4267	205	442	3	3	\N	60
4268	206	442	2	2	\N	40
4269	161	442	0	3	\N	-20
4270	162	442	0	1	\N	0
4271	163	442	3	3	\N	60
4272	202	442	2	2	\N	40
4273	203	442	0	0	\N	0
4274	138	443	3	4	\N	60
4275	207	443	1	2	\N	20
4276	208	443	2	2	\N	40
4277	193	443	3	3	\N	60
4278	194	443	1	2	\N	20
4279	186	444	2	3	\N	40
4280	187	444	1	1	\N	20
4281	188	444	1	1	\N	20
4282	189	444	3	3	\N	60
4283	169	444	0	0	\N	0
4284	170	444	0	0	\N	0
4285	152	444	2	4	\N	30
4286	153	444	2	3	\N	40
4287	154	444	1	1	\N	20
4288	171	445	3	4	\N	60
4289	172	445	4	4	\N	90
4290	173	445	0	0	\N	0
4291	141	445	4	4	\N	90
4292	142	445	4	4	\N	90
4293	143	445	4	5	\N	80
4294	149	445	4	6	\N	70
4295	150	445	1	3	\N	10
4296	151	445	4	4	\N	90
4297	180	446	4	4	\N	90
4298	181	446	2	2	\N	40
4299	164	446	4	5	\N	80
4300	165	446	2	3	\N	40
4301	166	446	2	3	\N	40
4302	207	446	3	4	\N	60
4303	208	446	4	4	\N	90
4304	193	447	2	3	\N	40
4305	194	447	4	4	\N	90
4306	134	447	4	5	\N	80
4307	135	447	1	1	\N	20
4308	136	447	0	0	\N	0
4309	137	447	0	2	\N	-10
4310	161	447	2	4	\N	30
4311	162	447	1	3	\N	10
4312	163	447	1	2	\N	20
4313	209	448	4	5	\N	80
4314	210	448	3	5	\N	50
4315	211	448	0	0	\N	0
4316	202	448	0	3	\N	-20
4317	203	448	0	0	\N	0
4318	138	448	1	3	\N	10
4319	204	449	1	1	\N	20
4320	205	449	2	4	\N	30
4321	206	449	0	0	\N	0
4322	152	449	2	3	\N	40
4323	153	449	3	3	\N	60
4324	154	449	1	1	\N	20
4325	176	449	4	5	\N	80
4326	177	449	0	1	\N	0
4327	178	449	2	2	\N	40
4328	179	449	0	1	\N	0
4329	167	450	4	5	\N	80
4330	168	450	1	2	\N	20
4331	212	450	4	4	\N	90
4332	213	450	4	5	\N	80
4333	214	450	2	2	\N	40
4334	169	450	3	4	\N	60
4335	170	450	1	3	\N	10
4336	195	451	1	1	\N	20
4337	196	451	4	4	\N	90
4338	197	451	0	0	\N	0
4339	144	451	4	4	\N	90
4340	145	451	1	3	\N	10
4341	184	451	0	1	\N	0
4342	185	451	4	4	\N	90
4343	141	452	0	1	\N	0
4344	142	452	1	3	\N	10
4345	143	452	0	1	\N	0
4346	174	452	2	4	\N	30
4347	175	452	1	1	\N	20
4348	131	452	4	4	\N	90
4349	132	452	2	2	\N	40
4350	133	452	2	2	\N	40
4351	158	453	4	6	\N	70
4352	159	453	1	1	\N	20
4353	160	453	2	3	\N	40
4354	182	453	4	4	\N	90
4355	183	453	1	1	\N	20
4356	149	453	1	1	\N	20
4357	150	453	1	1	\N	20
4358	151	453	2	3	\N	40
4359	139	454	1	3	\N	10
4360	140	454	3	4	\N	60
4361	146	454	0	3	\N	-20
4362	147	454	1	1	\N	20
4363	148	454	0	0	\N	0
4364	171	454	4	5	\N	80
4365	172	454	2	3	\N	40
4366	173	454	2	2	\N	40
4367	198	455	4	5	\N	80
4368	199	455	1	2	\N	20
4369	200	455	2	2	\N	40
4370	201	455	2	3	\N	40
4371	190	455	4	4	\N	90
4372	191	455	0	0	\N	0
4373	192	455	2	2	\N	40
4374	155	455	1	3	\N	10
4375	156	455	0	0	\N	0
4376	157	455	0	0	\N	0
4377	186	456	2	4	\N	30
4378	187	456	2	3	\N	40
4379	188	456	4	4	\N	90
4380	189	456	0	1	\N	0
4381	193	456	4	4	\N	90
4382	194	456	1	1	\N	20
4383	184	456	4	4	\N	90
4384	185	456	1	1	\N	20
4385	146	457	4	4	\N	90
4386	147	457	0	0	\N	0
4387	148	457	1	1	\N	20
4388	141	457	4	4	\N	90
4389	142	457	2	2	\N	40
4390	143	457	4	6	\N	70
4391	180	457	3	3	\N	60
4392	181	457	3	3	\N	60
4393	138	458	4	5	\N	80
4394	182	458	3	5	\N	50
4395	183	458	0	0	\N	0
4396	174	458	3	5	\N	50
4397	175	458	0	2	\N	-10
4398	149	459	3	4	\N	60
4399	150	459	0	1	\N	0
4400	151	459	1	2	\N	20
4401	152	459	3	4	\N	60
4402	153	459	0	2	\N	-10
4403	154	459	2	2	\N	40
4404	190	459	3	4	\N	60
4405	191	459	3	3	\N	60
4406	192	459	4	6	\N	70
4407	131	460	2	5	\N	20
4408	132	460	0	1	\N	0
4409	133	460	1	1	\N	20
4410	167	460	4	4	\N	90
4411	168	460	1	2	\N	20
4412	171	460	3	4	\N	60
4413	172	460	4	4	\N	90
4414	173	460	1	2	\N	20
4415	161	461	4	5	\N	80
4416	162	461	1	1	\N	20
4417	163	461	2	2	\N	40
4418	202	461	0	1	\N	0
4419	203	461	1	1	\N	20
4420	195	461	4	5	\N	80
4421	196	461	1	1	\N	20
4422	197	461	3	4	\N	60
4423	209	462	0	0	\N	0
4424	210	462	2	3	\N	40
4425	211	462	2	2	\N	40
4426	169	462	4	5	\N	80
4427	170	462	1	1	\N	20
4428	198	462	3	4	\N	60
4429	199	462	4	4	\N	90
4430	200	462	2	2	\N	40
4431	201	462	3	3	\N	60
4432	144	463	3	6	\N	40
4433	145	463	2	2	\N	40
4434	204	463	4	4	\N	90
4435	205	463	1	1	\N	20
4436	206	463	0	2	\N	-10
4437	164	463	4	4	\N	90
4438	165	463	1	1	\N	20
4439	166	463	4	4	\N	90
4440	158	464	0	0	\N	0
4441	159	464	1	2	\N	20
4442	160	464	0	1	\N	0
4443	139	464	3	4	\N	60
4444	140	464	1	1	\N	20
4445	155	464	4	6	\N	70
4446	156	464	2	2	\N	40
4447	157	464	2	3	\N	40
4448	134	465	4	4	\N	90
4449	135	465	0	1	\N	0
4450	136	465	1	3	\N	10
4451	137	465	0	0	\N	0
4452	212	465	0	1	\N	0
4453	213	465	0	0	\N	0
4454	214	465	2	2	\N	40
4455	176	465	4	4	\N	90
4456	177	465	1	1	\N	20
4457	178	465	1	1	\N	20
4458	179	465	2	2	\N	40
4459	186	466	4	4	\N	90
4460	187	466	4	4	\N	90
4461	188	466	2	4	\N	30
4462	189	466	4	6	\N	70
4463	207	466	3	6	\N	40
4464	208	466	1	1	\N	20
4465	176	466	2	2	\N	40
4466	177	466	3	4	\N	60
4467	178	466	1	1	\N	20
4468	179	466	4	6	\N	70
4469	193	467	4	5	\N	80
4470	194	467	4	4	\N	90
4471	138	467	4	5	\N	80
4472	155	467	2	4	\N	30
4473	156	467	4	4	\N	90
4474	157	467	1	1	\N	20
4475	144	468	4	4	\N	90
4476	145	468	0	0	\N	0
4477	149	468	4	5	\N	80
4478	150	468	1	1	\N	20
4479	151	468	0	0	\N	0
4480	209	468	3	5	\N	50
4481	210	468	1	1	\N	20
4482	211	468	0	0	\N	0
4483	158	469	4	6	\N	70
4484	159	469	2	2	\N	40
4485	160	469	1	1	\N	20
4486	195	469	4	4	\N	90
4487	196	469	1	1	\N	20
4488	197	469	1	1	\N	20
4489	190	469	2	2	\N	40
4490	191	469	1	1	\N	20
4491	192	469	1	2	\N	20
4492	167	470	3	4	\N	60
4493	168	470	4	4	\N	90
4494	202	470	2	4	\N	30
4495	203	470	1	2	\N	20
4496	152	470	4	4	\N	90
4497	153	470	1	1	\N	20
4498	154	470	0	0	\N	0
4499	182	471	3	3	\N	60
4500	183	471	1	1	\N	20
4501	164	471	4	5	\N	80
4502	165	471	2	2	\N	40
4503	166	471	3	3	\N	60
4504	161	471	4	5	\N	80
4505	162	471	2	2	\N	40
4506	163	471	1	1	\N	20
4507	146	472	3	4	\N	60
4508	147	472	2	4	\N	30
4509	148	472	2	2	\N	40
4510	139	472	4	6	\N	70
4511	140	472	2	2	\N	40
4512	212	472	3	5	\N	50
4513	213	472	3	5	\N	50
4514	214	472	0	0	\N	0
4515	198	473	3	5	\N	50
4516	199	473	4	4	\N	90
4517	200	473	0	0	\N	0
4518	201	473	2	3	\N	40
4519	207	473	3	3	\N	60
4520	208	473	0	1	\N	0
4521	186	473	4	5	\N	80
4522	187	473	1	2	\N	20
4523	188	473	2	4	\N	30
4524	189	473	1	1	\N	20
4525	171	474	4	4	\N	90
4526	172	474	2	2	\N	40
4527	173	474	0	1	\N	0
4528	141	474	4	4	\N	90
4529	142	474	0	0	\N	0
4530	143	474	2	2	\N	40
4531	169	474	4	5	\N	80
4532	170	474	1	3	\N	10
4533	184	475	3	4	\N	60
4534	185	475	2	2	\N	40
4535	174	475	2	5	\N	20
4536	175	475	2	3	\N	40
4537	180	475	2	2	\N	40
4538	181	475	0	2	\N	-10
4539	204	476	2	2	\N	40
4540	205	476	0	0	\N	0
4541	206	476	1	1	\N	20
4542	134	476	3	5	\N	50
4543	135	476	3	5	\N	50
4544	136	476	0	1	\N	0
4545	137	476	1	1	\N	20
4546	131	476	0	1	\N	0
4547	132	476	1	1	\N	20
4548	133	476	1	1	\N	20
4549	266	478	3	6	\N	40
4550	267	478	2	3	\N	40
4551	268	478	0	0	\N	0
4552	224	478	2	2	\N	40
4553	225	478	0	0	\N	0
4554	226	478	3	5	\N	50
4555	227	478	1	3	\N	10
4556	232	478	4	5	\N	80
4557	233	478	0	0	\N	0
4558	234	478	0	0	\N	0
4559	215	479	3	4	\N	60
4560	216	479	2	2	\N	40
4561	217	479	0	1	\N	0
4562	238	479	3	6	\N	40
4563	239	479	2	3	\N	40
4564	240	479	4	4	\N	90
4565	241	479	2	2	\N	40
4566	235	479	1	3	\N	10
4567	236	479	1	1	\N	20
4568	237	479	1	1	\N	20
4569	260	480	1	4	\N	0
4570	261	480	0	1	\N	0
4571	262	480	0	0	\N	0
4572	242	480	2	3	\N	40
4573	243	480	2	2	\N	40
4574	244	480	3	3	\N	60
4575	263	480	2	5	\N	20
4576	264	480	1	3	\N	10
4577	265	480	0	2	\N	-10
4578	253	481	3	4	\N	60
4579	254	481	1	1	\N	20
4580	255	481	1	1	\N	20
4581	249	481	3	4	\N	60
4582	250	481	2	2	\N	40
4583	251	481	0	2	\N	-10
4584	252	481	2	2	\N	40
4585	218	481	1	3	\N	10
4586	219	481	0	0	\N	0
4587	220	481	4	4	\N	90
4588	245	482	4	5	\N	80
4589	246	482	1	3	\N	10
4590	247	482	3	5	\N	50
4591	248	482	1	3	\N	10
4592	221	482	3	3	\N	60
4593	222	482	4	4	\N	90
4594	223	482	0	2	\N	-10
4595	228	482	3	3	\N	60
4596	229	482	2	3	\N	40
4597	230	482	2	2	\N	40
4598	231	482	0	0	\N	0
4599	256	483	0	1	\N	0
4600	257	483	0	1	\N	0
4601	258	483	3	3	\N	60
4602	259	483	1	1	\N	20
4603	269	483	0	1	\N	0
4604	270	483	4	5	\N	80
4605	271	483	4	6	\N	70
4606	272	483	1	1	\N	20
4607	224	483	4	6	\N	70
4608	225	483	0	1	\N	0
4609	226	483	4	6	\N	70
4610	227	483	1	1	\N	20
4611	269	484	4	6	\N	70
4612	270	484	3	3	\N	60
4613	271	484	1	1	\N	20
4614	272	484	1	1	\N	20
4615	245	484	2	3	\N	40
4616	246	484	0	0	\N	0
4617	247	484	1	2	\N	20
4618	248	484	0	0	\N	0
4619	215	484	3	6	\N	40
4620	216	484	3	3	\N	60
4621	217	484	1	1	\N	20
4622	235	485	3	3	\N	60
4623	236	485	1	2	\N	20
4624	237	485	0	0	\N	0
4625	266	485	4	6	\N	70
4626	267	485	2	2	\N	40
4627	268	485	0	1	\N	0
4628	218	485	0	0	\N	0
4629	219	485	1	1	\N	20
4630	220	485	2	3	\N	40
4631	221	486	2	2	\N	40
4632	222	486	1	2	\N	20
4633	223	486	3	4	\N	60
4634	232	486	4	4	\N	90
4635	233	486	0	0	\N	0
4636	234	486	4	4	\N	90
4637	260	486	4	4	\N	90
4638	261	486	3	3	\N	60
4639	262	486	3	3	\N	60
4640	228	487	3	3	\N	60
4641	229	487	1	1	\N	20
4642	230	487	0	0	\N	0
4643	231	487	0	2	\N	-10
4644	263	487	4	5	\N	80
4645	264	487	1	1	\N	20
4646	265	487	1	3	\N	10
4647	242	487	4	4	\N	90
4648	243	487	1	1	\N	20
4649	244	487	1	1	\N	20
4650	238	488	1	2	\N	20
4651	239	488	4	4	\N	90
4652	240	488	1	2	\N	20
4653	241	488	1	3	\N	10
4654	256	488	3	4	\N	60
4655	257	488	0	0	\N	0
4656	258	488	0	0	\N	0
4657	259	488	0	0	\N	0
4658	249	488	3	5	\N	50
4659	250	488	0	2	\N	-10
4660	251	488	0	1	\N	0
4661	252	488	0	0	\N	0
4662	253	489	4	4	\N	90
4663	254	489	0	0	\N	0
4664	255	489	3	3	\N	60
4665	242	489	1	2	\N	20
4666	243	489	1	2	\N	20
4667	244	489	1	1	\N	20
4668	249	489	4	5	\N	80
4669	250	489	4	4	\N	90
4670	251	489	0	0	\N	0
4671	252	489	1	1	\N	20
4672	269	490	3	4	\N	60
4673	270	490	0	0	\N	0
4674	271	490	4	4	\N	90
4675	272	490	1	1	\N	20
4676	215	490	2	3	\N	40
4677	216	490	2	2	\N	40
4678	217	490	0	0	\N	0
4679	260	490	1	1	\N	20
4680	261	490	2	3	\N	40
4681	262	490	1	1	\N	20
4682	221	491	2	5	\N	20
4683	222	491	4	6	\N	70
4684	223	491	1	2	\N	20
4685	224	491	0	1	\N	0
4686	225	491	0	0	\N	0
4687	226	491	1	1	\N	20
4688	227	491	0	2	\N	-10
4689	235	491	4	6	\N	70
4690	236	491	4	5	\N	80
4691	237	491	2	2	\N	40
4692	232	492	0	2	\N	-10
4693	233	492	1	1	\N	20
4694	234	492	1	1	\N	20
4695	238	492	4	5	\N	80
4696	239	492	2	2	\N	40
4697	240	492	1	1	\N	20
4698	241	492	0	0	\N	0
4699	245	492	1	1	\N	20
4700	246	492	4	4	\N	90
4701	247	492	2	3	\N	40
4702	248	492	2	2	\N	40
4703	253	493	4	6	\N	70
4704	254	493	1	1	\N	20
4705	255	493	3	3	\N	60
4706	266	493	4	4	\N	90
4707	267	493	3	5	\N	50
4708	268	493	0	0	\N	0
4709	263	493	4	5	\N	80
4710	264	493	2	4	\N	30
4711	265	493	1	1	\N	20
4712	256	494	1	4	\N	0
4713	257	494	3	3	\N	60
4714	258	494	2	2	\N	40
4715	259	494	0	1	\N	0
4716	218	494	4	4	\N	90
4717	219	494	1	1	\N	20
4718	220	494	2	4	\N	30
4719	228	494	4	6	\N	70
4720	229	494	0	1	\N	0
4721	230	494	2	2	\N	40
4722	231	494	0	0	\N	0
4723	249	495	0	1	\N	0
4724	250	495	3	4	\N	60
4725	251	495	0	2	\N	-10
4726	252	495	0	0	\N	0
4727	221	495	3	3	\N	60
4728	222	495	1	2	\N	20
4729	223	495	0	1	\N	0
4730	238	495	4	6	\N	70
4731	239	495	1	3	\N	10
4732	240	495	1	1	\N	20
4733	241	495	1	3	\N	10
4734	266	496	3	5	\N	50
4735	267	496	1	1	\N	20
4736	268	496	0	0	\N	0
4737	232	496	4	5	\N	80
4738	233	496	0	0	\N	0
4739	234	496	0	0	\N	0
4740	256	496	4	5	\N	80
4741	257	496	1	1	\N	20
4742	258	496	2	3	\N	40
4743	259	496	3	3	\N	60
4744	263	497	4	4	\N	90
4745	264	497	4	4	\N	90
4746	265	497	0	0	\N	0
4747	260	497	4	4	\N	90
4748	261	497	1	1	\N	20
4749	262	497	0	1	\N	0
4750	228	497	0	1	\N	0
4751	229	497	1	1	\N	20
4752	230	497	1	1	\N	20
4753	231	497	3	3	\N	60
4754	218	498	2	2	\N	40
4755	219	498	2	2	\N	40
4756	220	498	0	1	\N	0
4757	269	498	2	5	\N	20
4758	270	498	1	1	\N	20
4759	271	498	1	3	\N	10
4760	272	498	0	0	\N	0
4761	224	498	1	3	\N	10
4762	225	498	0	1	\N	0
4763	226	498	1	2	\N	20
4764	227	498	0	1	\N	0
4765	235	499	3	4	\N	60
4766	236	499	1	1	\N	20
4767	237	499	1	2	\N	20
4768	253	499	4	5	\N	80
4769	254	499	2	2	\N	40
4770	255	499	2	3	\N	40
4771	215	499	3	4	\N	60
4772	216	499	0	1	\N	0
4773	217	499	2	2	\N	40
4774	242	500	4	5	\N	80
4775	243	500	0	0	\N	0
4776	244	500	4	4	\N	90
4777	245	500	3	6	\N	40
4778	246	500	1	1	\N	20
4779	247	500	4	4	\N	90
4780	248	500	4	4	\N	90
4781	232	500	4	4	\N	90
4782	233	500	1	1	\N	20
4783	234	500	3	3	\N	60
4784	238	501	0	1	\N	0
4785	239	501	2	2	\N	40
4786	240	501	3	3	\N	60
4787	241	501	1	2	\N	20
4788	266	501	4	5	\N	80
4789	267	501	0	0	\N	0
4790	268	501	1	3	\N	10
4791	269	501	4	5	\N	80
4792	270	501	4	4	\N	90
4793	271	501	2	2	\N	40
4794	272	501	4	4	\N	90
4795	260	502	4	6	\N	70
4796	261	502	0	0	\N	0
4797	262	502	1	1	\N	20
4798	218	502	0	1	\N	0
4799	219	502	0	1	\N	0
4800	220	502	3	3	\N	60
4801	235	502	4	4	\N	90
4802	236	502	2	2	\N	40
4803	237	502	1	1	\N	20
4804	256	503	4	4	\N	90
4805	257	503	4	6	\N	70
4806	258	503	1	1	\N	20
4807	259	503	1	2	\N	20
4808	224	503	4	5	\N	80
4809	225	503	3	3	\N	60
4810	226	503	3	5	\N	50
4811	227	503	1	1	\N	20
4812	253	503	4	5	\N	80
4813	254	503	1	3	\N	10
4814	255	503	2	3	\N	40
4815	242	504	3	5	\N	50
4816	243	504	0	0	\N	0
4817	244	504	1	1	\N	20
4818	228	504	4	4	\N	90
4819	229	504	4	4	\N	90
4820	230	504	0	0	\N	0
4821	231	504	1	2	\N	20
4822	249	504	4	5	\N	80
4823	250	504	0	0	\N	0
4824	251	504	1	1	\N	20
4825	252	504	1	2	\N	20
4826	221	505	3	6	\N	40
4827	222	505	4	5	\N	80
4828	223	505	4	6	\N	70
4829	245	505	3	4	\N	60
4830	246	505	1	1	\N	20
4831	247	505	3	3	\N	60
4832	248	505	3	4	\N	60
4833	215	505	0	2	\N	-10
4834	216	505	3	3	\N	60
4835	217	505	4	5	\N	80
4836	263	506	3	6	\N	40
4837	264	506	1	3	\N	10
4838	265	506	1	1	\N	20
4839	242	506	3	4	\N	60
4840	243	506	0	1	\N	0
4841	244	506	0	1	\N	0
4842	224	506	4	4	\N	90
4843	225	506	1	1	\N	20
4844	226	506	3	3	\N	60
4845	227	506	2	3	\N	40
4846	235	507	3	3	\N	60
4847	236	507	2	2	\N	40
4848	237	507	0	0	\N	0
4849	260	507	3	6	\N	40
4850	261	507	0	0	\N	0
4851	262	507	1	1	\N	20
4852	221	507	3	5	\N	50
4853	222	507	0	0	\N	0
4854	223	507	0	1	\N	0
4855	256	508	3	4	\N	60
4856	257	508	2	3	\N	40
4857	258	508	0	1	\N	0
4858	259	508	2	4	\N	30
4859	266	508	3	4	\N	60
4860	267	508	1	2	\N	20
4861	268	508	0	1	\N	0
4862	269	508	1	1	\N	20
4863	270	508	3	3	\N	60
4864	271	508	0	1	\N	0
4865	272	508	0	0	\N	0
4866	245	509	4	5	\N	80
4867	246	509	2	3	\N	40
4868	247	509	4	5	\N	80
4869	248	509	0	1	\N	0
4870	215	509	4	5	\N	80
4871	216	509	2	4	\N	30
4872	217	509	1	1	\N	20
4873	253	509	3	5	\N	50
4874	254	509	2	2	\N	40
4875	255	509	1	1	\N	20
4876	249	510	4	5	\N	80
4877	250	510	3	3	\N	60
4878	251	510	1	1	\N	20
4879	252	510	0	2	\N	-10
4880	218	510	4	4	\N	90
4881	219	510	0	0	\N	0
4882	220	510	2	3	\N	40
4883	263	510	4	5	\N	80
4884	264	510	1	1	\N	20
4885	265	510	4	4	\N	90
4886	232	511	2	3	\N	40
4887	233	511	0	1	\N	0
4888	234	511	1	1	\N	20
4889	228	511	3	5	\N	50
4890	229	511	1	1	\N	20
4891	230	511	4	4	\N	90
4892	231	511	3	3	\N	60
4893	238	511	3	5	\N	50
4894	239	511	1	1	\N	20
4895	240	511	4	5	\N	80
4896	241	511	1	3	\N	10
4897	8	514	4	5	\N	80
4898	9	514	2	2	\N	40
4899	10	514	3	4	\N	60
4900	11	514	0	0	\N	0
4901	12	514	1	2	\N	20
4902	17	514	4	5	\N	80
4903	18	514	0	0	\N	0
4904	19	514	0	0	\N	0
4905	5	514	3	3	\N	60
4906	6	514	1	2	\N	20
4907	7	514	1	1	\N	20
4908	73	515	3	3	\N	60
4909	74	515	2	3	\N	40
4910	75	515	1	1	\N	20
4911	87	515	1	2	\N	20
4912	88	515	3	3	\N	60
4913	89	515	1	1	\N	20
4914	90	515	0	0	\N	0
4915	57	515	2	2	\N	40
4916	58	515	1	1	\N	20
4917	59	515	2	4	\N	30
4918	60	515	0	1	\N	0
4919	103	516	4	5	\N	80
4920	104	516	4	5	\N	80
4921	105	516	1	1	\N	20
4922	61	516	3	5	\N	50
4923	62	516	1	2	\N	20
4924	63	516	2	2	\N	40
4925	123	516	3	3	\N	60
4926	124	516	0	1	\N	0
4927	125	516	0	2	\N	-10
4928	126	516	1	1	\N	20
4929	35	517	1	3	\N	10
4930	36	517	4	4	\N	90
4931	37	517	1	3	\N	10
4932	38	517	3	5	\N	50
4933	79	517	3	5	\N	50
4934	80	517	0	0	\N	0
4935	81	517	1	1	\N	20
4936	82	517	2	2	\N	40
4937	50	517	3	4	\N	60
4938	51	517	1	2	\N	20
4939	52	517	3	3	\N	60
4940	53	517	0	0	\N	0
4941	64	518	4	4	\N	90
4942	65	518	1	1	\N	20
4943	66	518	2	2	\N	40
4944	67	518	3	3	\N	60
4945	68	518	4	5	\N	80
4946	114	518	3	4	\N	60
4947	115	518	2	2	\N	40
4948	116	518	0	0	\N	0
4949	117	518	4	4	\N	90
4950	54	518	4	5	\N	80
4951	55	518	2	2	\N	40
4952	56	518	3	4	\N	60
4953	1	519	2	2	\N	40
4954	2	519	2	2	\N	40
4955	3	519	1	2	\N	20
4956	4	519	2	2	\N	40
4957	95	519	1	1	\N	20
4958	96	519	3	3	\N	60
4959	97	519	2	2	\N	40
4960	98	519	3	3	\N	60
4961	127	519	2	2	\N	40
4962	128	519	4	4	\N	90
4963	129	519	1	1	\N	20
4964	130	519	0	2	\N	-10
4965	27	520	0	1	\N	0
4966	28	520	2	3	\N	40
4967	29	520	2	2	\N	40
4968	30	520	0	0	\N	0
4969	31	520	4	4	\N	90
4970	118	520	3	5	\N	50
4971	119	520	4	4	\N	90
4972	120	520	2	3	\N	40
4973	121	520	2	3	\N	40
4974	122	520	2	4	\N	30
4975	13	520	4	5	\N	80
4976	14	520	1	1	\N	20
4977	15	520	1	1	\N	20
4978	16	520	2	3	\N	40
4979	106	521	0	2	\N	-10
4980	107	521	1	3	\N	10
4981	108	521	4	4	\N	90
4982	109	521	2	3	\N	40
4983	99	521	3	3	\N	60
4984	100	521	4	5	\N	80
4985	101	521	0	0	\N	0
4986	102	521	3	4	\N	60
4987	42	521	4	4	\N	90
4988	43	521	2	3	\N	40
4989	44	521	3	3	\N	60
4990	45	521	0	0	\N	0
4991	91	522	4	5	\N	80
4992	92	522	0	2	\N	-10
4993	93	522	0	2	\N	-10
4994	94	522	0	0	\N	0
4995	23	522	1	2	\N	20
4996	24	522	4	5	\N	80
4997	25	522	2	2	\N	40
4998	26	522	0	0	\N	0
4999	69	522	1	1	\N	20
5000	70	522	0	1	\N	0
5001	71	522	1	2	\N	20
5002	72	522	2	2	\N	40
5003	32	523	4	6	\N	70
5004	33	523	2	2	\N	40
5005	34	523	1	1	\N	20
5006	83	523	2	2	\N	40
5007	84	523	3	3	\N	60
5008	85	523	1	2	\N	20
5009	86	523	1	1	\N	20
5010	46	523	4	5	\N	80
5011	47	523	2	3	\N	40
5012	48	523	3	3	\N	60
5013	49	523	0	0	\N	0
5014	20	524	3	3	\N	60
5015	21	524	1	3	\N	10
5016	22	524	2	2	\N	40
5017	76	524	4	5	\N	80
5018	77	524	0	0	\N	0
5019	78	524	0	1	\N	0
5020	39	524	1	4	\N	0
5021	40	524	4	4	\N	90
5022	41	524	1	1	\N	20
5023	110	525	3	4	\N	60
5024	111	525	0	1	\N	0
5025	112	525	3	3	\N	60
5026	113	525	1	1	\N	20
5027	1	525	3	6	\N	40
5028	2	525	0	1	\N	0
5029	3	525	0	0	\N	0
5030	4	525	1	1	\N	20
5031	5	525	3	5	\N	50
5032	6	525	1	3	\N	10
5033	7	525	0	0	\N	0
5034	32	526	4	4	\N	90
5035	33	526	1	2	\N	20
5036	34	526	4	4	\N	90
5037	27	526	4	4	\N	90
5038	28	526	1	2	\N	20
5039	29	526	3	3	\N	60
5040	30	526	0	1	\N	0
5041	31	526	3	5	\N	50
5042	110	526	4	4	\N	90
5043	111	526	0	2	\N	-10
5044	112	526	1	3	\N	10
5045	113	526	3	4	\N	60
5046	64	527	4	4	\N	90
5047	65	527	2	2	\N	40
5048	66	527	0	0	\N	0
5049	67	527	0	0	\N	0
5050	68	527	2	3	\N	40
5051	20	527	4	5	\N	80
5052	21	527	4	5	\N	80
5053	22	527	1	1	\N	20
5054	35	527	4	5	\N	80
5055	36	527	0	0	\N	0
5056	37	527	3	3	\N	60
5057	38	527	0	0	\N	0
5058	76	528	3	5	\N	50
5059	77	528	1	3	\N	10
5060	78	528	1	1	\N	20
5061	118	528	1	4	\N	0
5062	119	528	1	1	\N	20
5063	120	528	4	4	\N	90
5064	121	528	1	1	\N	20
5065	122	528	2	4	\N	30
5066	106	528	4	5	\N	80
5067	107	528	0	0	\N	0
5068	108	528	1	1	\N	20
5069	109	528	2	2	\N	40
5070	114	529	3	5	\N	50
5071	115	529	3	3	\N	60
5072	116	529	0	0	\N	0
5073	117	529	3	4	\N	60
5074	61	529	3	3	\N	60
5075	62	529	0	0	\N	0
5076	63	529	0	0	\N	0
5077	103	529	2	3	\N	40
5078	104	529	0	1	\N	0
5079	105	529	4	4	\N	90
5080	13	530	3	3	\N	60
5081	14	530	1	1	\N	20
5082	15	530	4	4	\N	90
5083	16	530	3	4	\N	60
5084	69	530	3	4	\N	60
5085	70	530	2	2	\N	40
5086	71	530	0	0	\N	0
5087	72	530	2	3	\N	40
5088	57	530	1	3	\N	10
5089	58	530	2	3	\N	40
5090	59	530	1	1	\N	20
5091	60	530	0	1	\N	0
5092	46	531	3	4	\N	60
5093	47	531	3	3	\N	60
5094	48	531	1	1	\N	20
5095	49	531	1	1	\N	20
5096	42	531	0	0	\N	0
5097	43	531	0	0	\N	0
5098	44	531	2	3	\N	40
5099	45	531	0	0	\N	0
5100	83	531	4	4	\N	90
5101	84	531	0	1	\N	0
5102	85	531	4	5	\N	80
5103	86	531	0	1	\N	0
5104	123	532	4	5	\N	80
5105	124	532	4	6	\N	70
5106	125	532	1	1	\N	20
5107	126	532	1	1	\N	20
5108	23	532	4	5	\N	80
5109	24	532	0	0	\N	0
5110	25	532	0	0	\N	0
5111	26	532	0	0	\N	0
5112	50	532	1	1	\N	20
5113	51	532	1	1	\N	20
5114	52	532	0	1	\N	0
5115	53	532	2	2	\N	40
5116	127	533	4	5	\N	80
5117	128	533	1	1	\N	20
5118	129	533	0	0	\N	0
5119	130	533	3	3	\N	60
5120	8	533	3	5	\N	50
5121	9	533	2	2	\N	40
5122	10	533	0	0	\N	0
5123	11	533	0	1	\N	0
5124	12	533	1	1	\N	20
5125	99	533	3	3	\N	60
5126	100	533	3	5	\N	50
5127	101	533	0	0	\N	0
5128	102	533	3	3	\N	60
5129	91	534	1	4	\N	0
5130	92	534	2	4	\N	30
5131	93	534	1	1	\N	20
5132	94	534	0	0	\N	0
5133	79	534	3	5	\N	50
5134	80	534	0	0	\N	0
5135	81	534	0	1	\N	0
5136	82	534	0	0	\N	0
5137	39	534	1	2	\N	20
5138	40	534	4	5	\N	80
5139	41	534	3	3	\N	60
5140	17	535	3	4	\N	60
5141	18	535	0	0	\N	0
5142	19	535	0	0	\N	0
5143	73	535	1	4	\N	0
5144	74	535	1	3	\N	10
5145	75	535	0	0	\N	0
5146	95	535	4	4	\N	90
5147	96	535	0	1	\N	0
5148	97	535	4	4	\N	90
5149	98	535	2	2	\N	40
5150	87	536	4	5	\N	80
5151	88	536	2	2	\N	40
5152	89	536	0	1	\N	0
5153	90	536	0	0	\N	0
5154	54	536	4	4	\N	90
5155	55	536	2	2	\N	40
5156	56	536	1	1	\N	20
5157	61	536	4	5	\N	80
5158	62	536	3	5	\N	50
5159	63	536	0	0	\N	0
5160	103	537	2	5	\N	20
5161	104	537	0	0	\N	0
5162	105	537	3	3	\N	60
5163	76	537	4	5	\N	80
5164	77	537	1	1	\N	20
5165	78	537	2	3	\N	40
5166	8	537	3	4	\N	60
5167	9	537	2	3	\N	40
5168	10	537	1	1	\N	20
5169	11	537	1	2	\N	20
5170	12	537	1	1	\N	20
5171	42	538	2	3	\N	40
5172	43	538	0	2	\N	-10
5173	44	538	1	1	\N	20
5174	45	538	0	0	\N	0
5175	127	538	3	3	\N	60
5176	128	538	3	3	\N	60
5177	129	538	0	0	\N	0
5178	130	538	1	3	\N	10
5179	32	538	2	3	\N	40
5180	33	538	0	0	\N	0
5181	34	538	1	1	\N	20
5182	110	539	4	5	\N	80
5183	111	539	0	2	\N	-10
5184	112	539	2	2	\N	40
5185	113	539	1	1	\N	20
5186	73	539	3	5	\N	50
5187	74	539	1	1	\N	20
5188	75	539	2	2	\N	40
5189	118	539	3	4	\N	60
5190	119	539	4	4	\N	90
5191	120	539	4	4	\N	90
5192	121	539	3	3	\N	60
5193	122	539	1	1	\N	20
5194	23	540	4	5	\N	80
5195	24	540	3	3	\N	60
5196	25	540	0	0	\N	0
5197	26	540	0	1	\N	0
5198	123	540	2	2	\N	40
5199	124	540	4	5	\N	80
5200	125	540	2	2	\N	40
5201	126	540	0	1	\N	0
5202	54	540	4	4	\N	90
5203	55	540	0	2	\N	-10
5204	56	540	2	2	\N	40
5205	57	541	3	6	\N	40
5206	58	541	2	2	\N	40
5207	59	541	0	0	\N	0
5208	60	541	1	2	\N	20
5209	95	541	4	4	\N	90
5210	96	541	0	1	\N	0
5211	97	541	1	1	\N	20
5212	98	541	1	2	\N	20
5213	106	541	1	3	\N	10
5214	107	541	4	4	\N	90
5215	108	541	3	4	\N	60
5216	109	541	1	1	\N	20
5217	39	542	3	6	\N	40
5218	40	542	0	0	\N	0
5219	41	542	1	1	\N	20
5220	99	542	3	4	\N	60
5221	100	542	0	0	\N	0
5222	101	542	3	4	\N	60
5223	102	542	4	5	\N	80
5224	69	542	4	4	\N	90
5225	70	542	0	1	\N	0
5226	71	542	1	1	\N	20
5227	72	542	4	5	\N	80
5228	35	543	3	6	\N	40
5229	36	543	0	1	\N	0
5230	37	543	0	0	\N	0
5231	38	543	2	2	\N	40
5232	46	543	4	5	\N	80
5233	47	543	0	0	\N	0
5234	48	543	1	1	\N	20
5235	49	543	1	2	\N	20
5236	13	543	4	5	\N	80
5237	14	543	3	3	\N	60
5238	15	543	2	3	\N	40
5239	16	543	1	1	\N	20
5240	1	544	3	5	\N	50
5241	2	544	2	2	\N	40
5242	3	544	2	2	\N	40
5243	4	544	1	1	\N	20
5244	79	544	4	4	\N	90
5245	80	544	2	2	\N	40
5246	81	544	0	0	\N	0
5247	82	544	2	2	\N	40
5248	27	544	3	5	\N	50
5249	28	544	0	0	\N	0
5250	29	544	1	1	\N	20
5251	30	544	4	5	\N	80
5252	31	544	0	0	\N	0
5253	50	545	4	5	\N	80
5254	51	545	1	1	\N	20
5255	52	545	4	4	\N	90
5256	53	545	1	1	\N	20
5257	83	545	1	1	\N	20
5258	84	545	2	2	\N	40
5259	85	545	4	4	\N	90
5260	86	545	0	0	\N	0
5261	20	545	2	3	\N	40
5262	21	545	3	3	\N	60
5263	22	545	1	3	\N	10
5264	5	546	2	2	\N	40
5265	6	546	1	2	\N	20
5266	7	546	1	1	\N	20
5267	87	546	3	5	\N	50
5268	88	546	0	2	\N	-10
5269	89	546	3	4	\N	60
5270	90	546	4	5	\N	80
5271	91	546	4	4	\N	90
5272	92	546	0	2	\N	-10
5273	93	546	1	1	\N	20
5274	94	546	0	0	\N	0
5275	114	547	3	6	\N	40
5276	115	547	0	1	\N	0
5277	116	547	1	1	\N	20
5278	117	547	0	0	\N	0
5279	17	547	1	3	\N	10
5280	18	547	2	4	\N	30
5281	19	547	3	3	\N	60
5282	64	547	0	1	\N	0
5283	65	547	2	4	\N	30
5284	66	547	1	1	\N	20
5285	67	547	0	1	\N	0
5286	68	547	1	1	\N	20
5287	13	548	4	4	\N	90
5288	14	548	0	0	\N	0
5289	15	548	4	6	\N	70
5290	16	548	1	3	\N	10
5291	35	548	4	4	\N	90
5292	36	548	4	4	\N	90
5293	37	548	1	2	\N	20
5294	38	548	0	0	\N	0
5295	73	548	2	2	\N	40
5296	74	548	3	3	\N	60
5297	75	548	1	1	\N	20
5298	76	549	2	2	\N	40
5299	77	549	1	2	\N	20
5300	78	549	4	6	\N	70
5301	1	549	3	5	\N	50
5302	2	549	3	3	\N	60
5303	3	549	1	3	\N	10
5304	4	549	1	1	\N	20
5305	61	549	2	3	\N	40
5306	62	549	1	1	\N	20
5307	63	549	4	5	\N	80
5308	110	550	4	6	\N	70
5309	111	550	1	2	\N	20
5310	112	550	0	1	\N	0
5311	113	550	2	2	\N	40
5312	42	550	4	4	\N	90
5313	43	550	4	5	\N	80
5314	44	550	1	2	\N	20
5315	45	550	0	0	\N	0
5316	118	550	0	2	\N	-10
5317	119	550	1	2	\N	20
5318	120	550	0	0	\N	0
5319	121	550	1	2	\N	20
5320	122	550	2	2	\N	40
5321	106	551	4	5	\N	80
5322	107	551	4	4	\N	90
5323	108	551	2	3	\N	40
5324	109	551	0	0	\N	0
5325	103	551	4	4	\N	90
5326	104	551	3	5	\N	50
5327	105	551	0	2	\N	-10
5328	57	551	4	4	\N	90
5329	58	551	1	1	\N	20
5330	59	551	3	5	\N	50
5331	60	551	1	1	\N	20
5332	95	552	4	5	\N	80
5333	96	552	1	1	\N	20
5334	97	552	1	1	\N	20
5335	98	552	4	5	\N	80
5336	27	552	3	5	\N	50
5337	28	552	2	2	\N	40
5338	29	552	1	2	\N	20
5339	30	552	1	1	\N	20
5340	31	552	0	0	\N	0
5341	5	552	4	4	\N	90
5342	6	552	1	3	\N	10
5343	7	552	1	1	\N	20
5344	123	553	4	4	\N	90
5345	124	553	2	4	\N	30
5346	125	553	0	0	\N	0
5347	126	553	4	4	\N	90
5348	23	553	4	6	\N	70
5349	24	553	1	1	\N	20
5350	25	553	2	2	\N	40
5351	26	553	2	2	\N	40
5352	17	553	4	6	\N	70
5353	18	553	0	1	\N	0
5354	19	553	0	0	\N	0
5355	50	554	4	5	\N	80
5356	51	554	2	2	\N	40
5357	52	554	0	0	\N	0
5358	53	554	0	0	\N	0
5359	114	554	1	2	\N	20
5360	115	554	1	1	\N	20
5361	116	554	1	3	\N	10
5362	117	554	0	1	\N	0
5363	54	554	2	3	\N	40
5364	55	554	1	3	\N	10
5365	56	554	0	1	\N	0
5366	83	555	2	3	\N	40
5367	84	555	1	1	\N	20
5368	85	555	0	0	\N	0
5369	86	555	1	1	\N	20
5370	79	555	4	4	\N	90
5371	80	555	0	2	\N	-10
5372	81	555	4	4	\N	90
5373	82	555	2	2	\N	40
5374	46	555	3	4	\N	60
5375	47	555	2	3	\N	40
5376	48	555	1	1	\N	20
5377	49	555	1	2	\N	20
5378	64	556	3	6	\N	40
5379	65	556	2	2	\N	40
5380	66	556	0	0	\N	0
5381	67	556	0	2	\N	-10
5382	68	556	2	2	\N	40
5383	99	556	2	2	\N	40
5384	100	556	1	2	\N	20
5385	101	556	0	0	\N	0
5386	102	556	2	4	\N	30
5387	8	556	0	0	\N	0
5388	9	556	3	3	\N	60
5389	10	556	1	2	\N	20
5390	11	556	0	0	\N	0
5391	12	556	0	0	\N	0
5392	69	557	3	4	\N	60
5393	70	557	0	0	\N	0
5394	71	557	1	1	\N	20
5395	72	557	1	2	\N	20
5396	127	557	1	3	\N	10
5397	128	557	2	2	\N	40
5398	129	557	4	6	\N	70
5399	130	557	0	0	\N	0
5400	32	557	3	4	\N	60
5401	33	557	0	0	\N	0
5402	34	557	2	3	\N	40
5403	20	558	4	6	\N	70
5404	21	558	0	0	\N	0
5405	22	558	1	2	\N	20
5406	39	558	4	4	\N	90
5407	40	558	0	0	\N	0
5408	41	558	4	4	\N	90
5409	87	558	4	4	\N	90
5410	88	558	2	2	\N	40
5411	89	558	0	0	\N	0
5412	90	558	0	0	\N	0
5413	91	559	4	6	\N	70
5414	92	559	3	3	\N	60
5415	93	559	0	1	\N	0
5416	94	559	2	2	\N	40
5417	127	559	0	2	\N	-10
5418	128	559	0	0	\N	0
5419	129	559	2	2	\N	40
5420	130	559	2	2	\N	40
5421	73	559	2	3	\N	40
5422	74	559	0	1	\N	0
5423	75	559	1	1	\N	20
5424	110	560	3	4	\N	60
5425	111	560	4	5	\N	80
5426	112	560	0	1	\N	0
5427	113	560	3	3	\N	60
5428	5	560	3	3	\N	60
5429	6	560	0	0	\N	0
5430	7	560	1	1	\N	20
5431	23	560	4	5	\N	80
5432	24	560	4	5	\N	80
5433	25	560	0	0	\N	0
5434	26	560	1	1	\N	20
5435	79	561	4	4	\N	90
5436	80	561	0	0	\N	0
5437	81	561	0	1	\N	0
5438	82	561	2	2	\N	40
5439	39	561	3	5	\N	50
5440	40	561	4	4	\N	90
5441	41	561	4	4	\N	90
5442	76	561	3	3	\N	60
5443	77	561	1	2	\N	20
5444	78	561	0	0	\N	0
5445	54	562	3	5	\N	50
5446	55	562	1	2	\N	20
5447	56	562	1	1	\N	20
5448	35	562	4	5	\N	80
5449	36	562	1	3	\N	10
5450	37	562	1	1	\N	20
5451	38	562	2	2	\N	40
5452	50	562	1	3	\N	10
5453	51	562	1	1	\N	20
5454	52	562	2	4	\N	30
5455	53	562	1	2	\N	20
5456	27	563	3	6	\N	40
5457	28	563	4	6	\N	70
5458	29	563	1	1	\N	20
5459	30	563	1	1	\N	20
5460	31	563	4	4	\N	90
5461	42	563	1	2	\N	20
5462	43	563	2	2	\N	40
5463	44	563	0	0	\N	0
5464	45	563	4	4	\N	90
5465	17	563	3	4	\N	60
5466	18	563	0	0	\N	0
5467	19	563	0	0	\N	0
5468	123	564	2	3	\N	40
5469	124	564	4	6	\N	70
5470	125	564	0	0	\N	0
5471	126	564	1	1	\N	20
5472	61	564	4	4	\N	90
5473	62	564	1	1	\N	20
5474	63	564	1	1	\N	20
5475	13	564	4	5	\N	80
5476	14	564	2	3	\N	40
5477	15	564	2	2	\N	40
5478	16	564	1	2	\N	20
5479	8	565	4	5	\N	80
5480	9	565	2	3	\N	40
5481	10	565	3	3	\N	60
5482	11	565	0	0	\N	0
5483	12	565	1	2	\N	20
5484	91	565	4	4	\N	90
5485	92	565	4	5	\N	80
5486	93	565	1	1	\N	20
5487	94	565	1	3	\N	10
5488	106	565	4	5	\N	80
5489	107	565	2	4	\N	30
5490	108	565	0	2	\N	-10
5491	109	565	2	2	\N	40
5492	99	566	0	1	\N	0
5493	100	566	1	1	\N	20
5494	101	566	1	1	\N	20
5495	102	566	1	2	\N	20
5496	83	566	1	3	\N	10
5497	84	566	1	1	\N	20
5498	85	566	4	4	\N	90
5499	86	566	4	4	\N	90
5500	87	566	3	4	\N	60
5501	88	566	0	1	\N	0
5502	89	566	2	2	\N	40
5503	90	566	2	3	\N	40
5504	103	567	4	5	\N	80
5505	104	567	4	4	\N	90
5506	105	567	0	0	\N	0
5507	57	567	4	5	\N	80
5508	58	567	0	0	\N	0
5509	59	567	0	0	\N	0
5510	60	567	0	0	\N	0
5511	64	567	3	3	\N	60
5512	65	567	1	1	\N	20
5513	66	567	0	0	\N	0
5514	67	567	3	4	\N	60
5515	68	567	0	0	\N	0
5516	95	568	3	4	\N	60
5517	96	568	1	1	\N	20
5518	97	568	3	3	\N	60
5519	98	568	4	6	\N	70
5520	32	568	3	3	\N	60
5521	33	568	1	1	\N	20
5522	34	568	0	0	\N	0
5523	114	568	4	4	\N	90
5524	115	568	4	4	\N	90
5525	116	568	1	2	\N	20
5526	117	568	1	1	\N	20
5527	20	569	3	5	\N	50
5528	21	569	0	1	\N	0
5529	22	569	4	6	\N	70
5530	1	569	3	5	\N	50
5531	2	569	4	5	\N	80
5532	3	569	1	1	\N	20
5533	4	569	0	1	\N	0
5534	46	569	4	4	\N	90
5535	47	569	3	4	\N	60
5536	48	569	0	0	\N	0
5537	49	569	0	0	\N	0
5538	69	570	3	4	\N	60
5539	70	570	2	3	\N	40
5540	71	570	1	1	\N	20
5541	72	570	0	1	\N	0
5542	118	570	4	5	\N	80
5543	119	570	1	3	\N	10
5544	120	570	1	1	\N	20
5545	121	570	0	0	\N	0
5546	122	570	2	4	\N	30
5547	27	570	4	5	\N	80
5548	28	570	1	1	\N	20
5549	29	570	3	3	\N	60
5550	30	570	3	3	\N	60
5551	31	570	0	0	\N	0
5552	103	571	4	4	\N	90
5553	104	571	1	1	\N	20
5554	105	571	3	3	\N	60
5555	114	571	4	5	\N	80
5556	115	571	2	3	\N	40
5557	116	571	2	2	\N	40
5558	117	571	4	4	\N	90
5559	50	571	4	6	\N	70
5560	51	571	1	1	\N	20
5561	52	571	3	3	\N	60
5562	53	571	0	0	\N	0
5563	64	572	4	4	\N	90
5564	65	572	0	0	\N	0
5565	66	572	4	5	\N	80
5566	67	572	2	3	\N	40
5567	68	572	0	1	\N	0
5568	73	572	4	5	\N	80
5569	74	572	1	2	\N	20
5570	75	572	2	3	\N	40
5571	5	572	4	4	\N	90
5572	6	572	4	4	\N	90
5573	7	572	4	5	\N	80
5574	69	573	0	1	\N	0
5575	70	573	1	1	\N	20
5576	71	573	1	1	\N	20
5577	72	573	0	0	\N	0
5578	13	573	2	4	\N	30
5579	14	573	2	2	\N	40
5580	15	573	3	3	\N	60
5581	16	573	0	0	\N	0
5582	118	573	0	2	\N	-10
5583	119	573	2	4	\N	30
5584	120	573	2	3	\N	40
5585	121	573	0	0	\N	0
5586	122	573	2	2	\N	40
5587	91	574	3	4	\N	60
5588	92	574	2	4	\N	30
5589	93	574	1	1	\N	20
5590	94	574	1	2	\N	20
5591	39	574	4	5	\N	80
5592	40	574	1	3	\N	10
5593	41	574	1	1	\N	20
5594	99	574	4	4	\N	90
5595	100	574	1	1	\N	20
5596	101	574	1	2	\N	20
5597	102	574	2	2	\N	40
5598	35	575	0	1	\N	0
5599	36	575	2	4	\N	30
5600	37	575	2	2	\N	40
5601	38	575	0	0	\N	0
5602	32	575	0	2	\N	-10
5603	33	575	0	0	\N	0
5604	34	575	4	4	\N	90
5605	54	575	1	2	\N	20
5606	55	575	1	2	\N	20
5607	56	575	2	2	\N	40
5608	61	576	2	2	\N	40
5609	62	576	1	1	\N	20
5610	63	576	1	1	\N	20
5611	42	576	3	4	\N	60
5612	43	576	1	2	\N	20
5613	44	576	2	3	\N	40
5614	45	576	1	2	\N	20
5615	17	576	4	6	\N	70
5616	18	576	0	0	\N	0
5617	19	576	0	1	\N	0
5618	106	577	2	2	\N	40
5619	107	577	1	2	\N	20
5620	108	577	1	1	\N	20
5621	109	577	0	0	\N	0
5622	87	577	2	2	\N	40
5623	88	577	4	4	\N	90
5624	89	577	0	0	\N	0
5625	90	577	1	1	\N	20
5626	76	577	1	2	\N	20
5627	77	577	0	0	\N	0
5628	78	577	0	1	\N	0
5629	83	578	3	5	\N	50
5630	84	578	0	0	\N	0
5631	85	578	0	0	\N	0
5632	86	578	0	1	\N	0
5633	8	578	1	3	\N	10
5634	9	578	1	1	\N	20
5635	10	578	0	0	\N	0
5636	11	578	1	2	\N	20
5637	12	578	0	0	\N	0
5638	23	578	4	5	\N	80
5639	24	578	4	4	\N	90
5640	25	578	3	3	\N	60
5641	26	578	4	4	\N	90
5642	57	579	1	1	\N	20
5643	58	579	3	3	\N	60
5644	59	579	1	1	\N	20
5645	60	579	0	0	\N	0
5646	95	579	4	4	\N	90
5647	96	579	3	3	\N	60
5648	97	579	2	2	\N	40
5649	98	579	1	1	\N	20
5650	20	579	4	4	\N	90
5651	21	579	2	2	\N	40
5652	22	579	4	4	\N	90
5653	46	580	3	4	\N	60
5654	47	580	0	0	\N	0
5655	48	580	2	2	\N	40
5656	49	580	1	3	\N	10
5657	79	580	1	2	\N	20
5658	80	580	0	0	\N	0
5659	81	580	0	1	\N	0
5660	82	580	4	4	\N	90
5661	123	580	0	2	\N	-10
5662	124	580	4	4	\N	90
5663	125	580	4	4	\N	90
5664	126	580	2	2	\N	40
5665	127	581	3	6	\N	40
5666	128	581	4	4	\N	90
5667	129	581	1	1	\N	20
5668	130	581	2	2	\N	40
5669	1	581	3	6	\N	40
5670	2	581	2	2	\N	40
5671	3	581	0	2	\N	-10
5672	4	581	0	1	\N	0
5673	110	581	2	3	\N	40
5674	111	581	1	2	\N	20
5675	112	581	0	1	\N	0
5676	113	581	1	2	\N	20
5677	180	586	4	5	\N	80
5678	181	586	2	2	\N	40
5679	212	586	4	4	\N	90
5680	213	586	4	6	\N	70
5681	214	586	1	3	\N	10
5682	155	586	4	5	\N	80
5683	156	586	0	2	\N	-10
5684	157	586	1	2	\N	20
5685	146	587	4	4	\N	90
5686	147	587	1	3	\N	10
5687	148	587	0	1	\N	0
5688	131	587	1	2	\N	20
5689	132	587	0	0	\N	0
5690	133	587	3	3	\N	60
5691	161	587	4	6	\N	70
5692	162	587	0	2	\N	-10
5693	163	587	4	6	\N	70
5694	171	588	3	3	\N	60
5695	172	588	0	1	\N	0
5696	173	588	0	0	\N	0
5697	138	588	0	1	\N	0
5698	193	588	3	6	\N	40
5699	194	588	0	0	\N	0
5700	204	589	2	2	\N	40
5701	205	589	1	1	\N	20
5702	206	589	1	1	\N	20
5703	207	589	1	1	\N	20
5704	208	589	0	0	\N	0
5705	152	589	3	4	\N	60
5706	153	589	2	4	\N	30
5707	154	589	1	2	\N	20
5708	190	590	3	6	\N	40
5709	191	590	0	0	\N	0
5710	192	590	2	2	\N	40
5711	139	590	4	4	\N	90
5712	140	590	2	2	\N	40
5713	169	590	4	6	\N	70
5714	170	590	1	1	\N	20
5715	176	591	4	5	\N	80
5716	177	591	2	2	\N	40
5717	178	591	0	0	\N	0
5718	179	591	2	3	\N	40
5719	198	591	4	4	\N	90
5720	199	591	0	1	\N	0
5721	200	591	4	4	\N	90
5722	201	591	1	1	\N	20
5723	134	591	1	3	\N	10
5724	135	591	1	1	\N	20
5725	136	591	0	1	\N	0
5726	137	591	1	1	\N	20
5727	164	592	4	5	\N	80
5728	165	592	0	0	\N	0
5729	166	592	0	0	\N	0
5730	186	592	3	4	\N	60
5731	187	592	4	6	\N	70
5732	188	592	4	4	\N	90
5733	189	592	1	2	\N	20
5734	167	592	4	5	\N	80
5735	168	592	3	5	\N	50
5736	195	593	3	6	\N	40
5737	196	593	0	0	\N	0
5738	197	593	0	0	\N	0
5739	149	593	2	5	\N	20
5740	150	593	4	5	\N	80
5741	151	593	0	0	\N	0
5742	158	593	3	3	\N	60
5743	159	593	4	4	\N	90
5744	160	593	0	0	\N	0
5745	202	594	3	3	\N	60
5746	203	594	1	3	\N	10
5747	182	594	0	1	\N	0
5748	183	594	4	4	\N	90
5749	174	594	3	4	\N	60
5750	175	594	0	0	\N	0
5751	184	595	3	4	\N	60
5752	185	595	0	1	\N	0
5753	209	595	3	3	\N	60
5754	210	595	2	4	\N	30
5755	211	595	2	2	\N	40
5756	141	595	4	4	\N	90
5757	142	595	1	1	\N	20
5758	143	595	4	5	\N	80
5759	144	596	4	6	\N	70
5760	145	596	0	1	\N	0
5761	174	596	1	4	\N	0
5762	175	596	3	3	\N	60
5763	198	596	0	1	\N	0
5764	199	596	2	3	\N	40
5765	200	596	2	3	\N	40
5766	201	596	1	1	\N	20
5767	158	597	2	4	\N	30
5768	159	597	1	1	\N	20
5769	160	597	0	1	\N	0
5770	207	597	4	4	\N	90
5771	208	597	2	3	\N	40
5772	171	597	4	4	\N	90
5773	172	597	2	2	\N	40
5774	173	597	4	4	\N	90
5775	169	598	2	2	\N	40
5776	170	598	4	5	\N	80
5777	152	598	4	6	\N	70
5778	153	598	0	0	\N	0
5779	154	598	1	1	\N	20
5780	176	598	1	4	\N	0
5781	177	598	0	0	\N	0
5782	178	598	2	2	\N	40
5783	179	598	1	2	\N	20
5784	149	599	3	4	\N	60
5785	150	599	3	4	\N	60
5786	151	599	1	3	\N	10
5787	138	599	1	3	\N	10
5788	131	599	3	6	\N	40
5789	132	599	0	2	\N	-10
5790	133	599	1	1	\N	20
5791	195	600	2	3	\N	40
5792	196	600	0	0	\N	0
5793	197	600	1	1	\N	20
5794	155	600	3	3	\N	60
5795	156	600	1	1	\N	20
5796	157	600	3	3	\N	60
5797	212	600	4	5	\N	80
5798	213	600	1	1	\N	20
5799	214	600	1	3	\N	10
5800	190	601	3	4	\N	60
5801	191	601	1	1	\N	20
5802	192	601	1	1	\N	20
5803	202	601	4	5	\N	80
5804	203	601	0	0	\N	0
5805	182	601	4	5	\N	80
5806	183	601	1	2	\N	20
5807	139	602	4	5	\N	80
5808	140	602	0	1	\N	0
5809	186	602	3	4	\N	60
5810	187	602	1	3	\N	10
5811	188	602	2	3	\N	40
5812	189	602	1	1	\N	20
5813	167	602	0	1	\N	0
5814	168	602	0	1	\N	0
5815	180	603	0	2	\N	-10
5816	181	603	3	5	\N	50
5817	146	603	4	5	\N	80
5818	147	603	0	0	\N	0
5819	148	603	1	1	\N	20
5820	193	603	0	1	\N	0
5821	194	603	1	2	\N	20
5822	144	604	3	3	\N	60
5823	145	604	2	3	\N	40
5824	209	604	0	0	\N	0
5825	210	604	0	0	\N	0
5826	211	604	4	5	\N	80
5827	141	604	3	3	\N	60
5828	142	604	0	1	\N	0
5829	143	604	2	2	\N	40
5830	184	605	3	6	\N	40
5831	185	605	0	0	\N	0
5832	161	605	3	6	\N	40
5833	162	605	0	1	\N	0
5834	163	605	2	2	\N	40
5835	164	605	4	4	\N	90
5836	165	605	0	2	\N	-10
5837	166	605	1	1	\N	20
5838	134	606	2	5	\N	20
5839	135	606	1	2	\N	20
5840	136	606	0	0	\N	0
5841	137	606	3	3	\N	60
5842	204	606	4	5	\N	80
5843	205	606	1	2	\N	20
5844	206	606	0	1	\N	0
5845	207	606	4	5	\N	80
5846	208	606	4	4	\N	90
5847	184	607	0	2	\N	-10
5848	185	607	1	1	\N	20
5849	161	607	2	5	\N	20
5850	162	607	0	1	\N	0
5851	163	607	2	3	\N	40
5852	209	607	0	2	\N	-10
5853	210	607	3	4	\N	60
5854	211	607	4	4	\N	90
5855	182	608	2	2	\N	40
5856	183	608	0	0	\N	0
5857	174	608	4	6	\N	70
5858	175	608	3	5	\N	50
5859	190	608	0	3	\N	-20
5860	191	608	2	2	\N	40
5861	192	608	0	2	\N	-10
5862	149	609	0	2	\N	-10
5863	150	609	0	1	\N	0
5864	151	609	2	2	\N	40
5865	144	609	4	4	\N	90
5866	145	609	0	0	\N	0
5867	198	609	3	3	\N	60
5868	199	609	3	5	\N	50
5869	200	609	0	1	\N	0
5870	201	609	2	2	\N	40
5871	204	610	0	2	\N	-10
5872	205	610	0	0	\N	0
5873	206	610	2	2	\N	40
5874	158	610	0	1	\N	0
5875	159	610	4	4	\N	90
5876	160	610	0	2	\N	-10
5877	171	610	0	2	\N	-10
5878	172	610	1	1	\N	20
5879	173	610	1	2	\N	20
5880	131	611	2	2	\N	40
5881	132	611	4	4	\N	90
5882	133	611	0	0	\N	0
5883	180	611	4	4	\N	90
5884	181	611	2	2	\N	40
5885	152	611	4	4	\N	90
5886	153	611	1	1	\N	20
5887	154	611	1	1	\N	20
5888	146	612	3	3	\N	60
5889	147	612	4	6	\N	70
5890	148	612	3	4	\N	60
5891	186	612	3	4	\N	60
5892	187	612	1	1	\N	20
5893	188	612	1	3	\N	10
5894	189	612	1	1	\N	20
5895	193	612	4	5	\N	80
5896	194	612	2	2	\N	40
5897	138	613	4	6	\N	70
5898	202	613	0	1	\N	0
5899	203	613	1	2	\N	20
5900	134	613	2	2	\N	40
5901	135	613	0	0	\N	0
5902	136	613	1	1	\N	20
5903	137	613	2	2	\N	40
5904	176	614	3	5	\N	50
5905	177	614	1	2	\N	20
5906	178	614	1	1	\N	20
5907	179	614	0	0	\N	0
5908	167	614	4	4	\N	90
5909	168	614	1	1	\N	20
5910	195	614	0	3	\N	-20
5911	196	614	2	3	\N	40
5912	197	614	1	2	\N	20
5913	141	615	0	3	\N	-20
5914	142	615	4	6	\N	70
5915	143	615	0	1	\N	0
5916	212	615	3	4	\N	60
5917	213	615	1	1	\N	20
5918	214	615	2	2	\N	40
5919	169	615	4	4	\N	90
5920	170	615	0	2	\N	-10
5921	164	616	3	5	\N	50
5922	165	616	0	0	\N	0
5923	166	616	0	0	\N	0
5924	155	616	3	4	\N	60
5925	156	616	3	4	\N	60
5926	157	616	2	2	\N	40
5927	139	616	3	5	\N	50
5928	140	616	0	0	\N	0
5929	182	617	3	3	\N	60
5930	183	617	0	1	\N	0
5931	134	617	2	4	\N	30
5932	135	617	4	4	\N	90
5933	136	617	4	4	\N	90
5934	137	617	1	1	\N	20
5935	167	617	3	5	\N	50
5936	168	617	4	4	\N	90
5937	171	618	4	6	\N	70
5938	172	618	2	2	\N	40
5939	173	618	0	0	\N	0
5940	131	618	3	6	\N	40
5941	132	618	0	0	\N	0
5942	133	618	0	1	\N	0
5943	138	618	3	3	\N	60
5944	180	619	1	3	\N	10
5945	181	619	1	1	\N	20
5946	152	619	3	6	\N	40
5947	153	619	1	1	\N	20
5948	154	619	0	0	\N	0
5949	141	619	3	3	\N	60
5950	142	619	1	1	\N	20
5951	143	619	0	1	\N	0
5952	149	620	4	4	\N	90
5953	150	620	2	2	\N	40
5954	151	620	1	1	\N	20
5955	190	620	3	4	\N	60
5956	191	620	0	1	\N	0
5957	192	620	2	2	\N	40
5958	176	620	1	2	\N	20
5959	177	620	0	1	\N	0
5960	178	620	1	1	\N	20
5961	179	620	4	5	\N	80
5962	144	621	4	5	\N	80
5963	145	621	0	0	\N	0
5964	184	621	0	3	\N	-20
5965	185	621	1	1	\N	20
5966	155	621	4	5	\N	80
5967	156	621	0	1	\N	0
5968	157	621	0	0	\N	0
5969	161	622	3	3	\N	60
5970	162	622	0	0	\N	0
5971	163	622	4	4	\N	90
5972	139	622	4	4	\N	90
5973	140	622	1	3	\N	10
5974	158	622	2	3	\N	40
5975	159	622	2	2	\N	40
5976	160	622	1	3	\N	10
5977	204	623	4	4	\N	90
5978	205	623	2	2	\N	40
5979	206	623	4	4	\N	90
5980	146	623	1	1	\N	20
5981	147	623	1	3	\N	10
5982	148	623	0	1	\N	0
5983	164	623	2	3	\N	40
5984	165	623	0	0	\N	0
5985	166	623	2	2	\N	40
5986	209	624	0	0	\N	0
5987	210	624	2	3	\N	40
5988	211	624	0	0	\N	0
5989	193	624	4	5	\N	80
5990	194	624	4	4	\N	90
5991	174	624	0	1	\N	0
5992	175	624	1	1	\N	20
5993	186	625	2	3	\N	40
5994	187	625	0	0	\N	0
5995	188	625	0	0	\N	0
5996	189	625	2	2	\N	40
5997	207	625	3	4	\N	60
5998	208	625	4	4	\N	90
5999	202	625	1	2	\N	20
6000	203	625	2	2	\N	40
6001	169	626	4	5	\N	80
6002	170	626	3	3	\N	60
6003	198	626	0	0	\N	0
6004	199	626	1	2	\N	20
6005	200	626	2	2	\N	40
6006	201	626	1	2	\N	20
6007	212	626	4	5	\N	80
6008	213	626	2	2	\N	40
6009	214	626	2	2	\N	40
6010	195	627	0	1	\N	0
6011	196	627	2	3	\N	40
6012	197	627	2	2	\N	40
6013	152	627	4	5	\N	80
6014	153	627	1	1	\N	20
6015	154	627	2	4	\N	30
6016	158	627	3	3	\N	60
6017	159	627	0	0	\N	0
6018	160	627	0	2	\N	-10
6019	144	628	3	5	\N	50
6020	145	628	2	4	\N	30
6021	193	628	4	4	\N	90
6022	194	628	2	2	\N	40
6023	171	628	3	5	\N	50
6024	172	628	0	2	\N	-10
6025	173	628	1	1	\N	20
6026	212	629	4	5	\N	80
6027	213	629	4	6	\N	70
6028	214	629	1	2	\N	20
6029	174	629	1	2	\N	20
6030	175	629	2	2	\N	40
6031	184	629	2	4	\N	30
6032	185	629	0	0	\N	0
6033	207	630	4	4	\N	90
6034	208	630	2	2	\N	40
6035	204	630	4	5	\N	80
6036	205	630	1	2	\N	20
6037	206	630	1	2	\N	20
6038	190	630	1	2	\N	20
6039	191	630	2	2	\N	40
6040	192	630	0	0	\N	0
6041	138	631	3	4	\N	60
6042	182	631	4	6	\N	70
6043	183	631	4	5	\N	80
6044	155	631	4	4	\N	90
6045	156	631	0	2	\N	-10
6046	157	631	0	0	\N	0
6047	176	632	3	3	\N	60
6048	177	632	2	3	\N	40
6049	178	632	1	1	\N	20
6050	179	632	1	2	\N	20
6051	202	632	4	5	\N	80
6052	203	632	1	1	\N	20
6053	141	632	4	5	\N	80
6054	142	632	0	1	\N	0
6055	143	632	0	0	\N	0
6056	169	633	4	5	\N	80
6057	170	633	0	0	\N	0
6058	146	633	2	3	\N	40
6059	147	633	2	2	\N	40
6060	148	633	1	1	\N	20
6061	186	633	2	3	\N	40
6062	187	633	1	1	\N	20
6063	188	633	2	2	\N	40
6064	189	633	2	3	\N	40
6065	149	634	4	6	\N	70
6066	150	634	0	0	\N	0
6067	151	634	3	3	\N	60
6068	209	634	3	5	\N	50
6069	210	634	1	2	\N	20
6070	211	634	1	1	\N	20
6071	164	634	4	4	\N	90
6072	165	634	1	2	\N	20
6073	166	634	2	3	\N	40
6074	198	635	4	5	\N	80
6075	199	635	2	2	\N	40
6076	200	635	3	3	\N	60
6077	201	635	2	2	\N	40
6078	195	635	4	5	\N	80
6079	196	635	1	1	\N	20
6080	197	635	1	1	\N	20
6081	180	635	4	5	\N	80
6082	181	635	0	1	\N	0
6083	131	636	4	4	\N	90
6084	132	636	2	2	\N	40
6085	133	636	2	2	\N	40
6086	161	636	3	4	\N	60
6087	162	636	1	1	\N	20
6088	163	636	1	3	\N	10
6089	134	636	3	4	\N	60
6090	135	636	1	2	\N	20
6091	136	636	4	5	\N	80
6092	137	636	0	0	\N	0
6093	139	637	1	2	\N	20
6094	140	637	3	4	\N	60
6095	167	637	3	6	\N	40
6096	168	637	1	3	\N	10
6097	174	637	4	4	\N	90
6098	175	637	0	1	\N	0
6099	144	638	0	1	\N	0
6100	145	638	0	1	\N	0
6101	149	638	0	2	\N	-10
6102	150	638	1	1	\N	20
6103	151	638	2	2	\N	40
6104	138	638	3	3	\N	60
6105	195	639	3	6	\N	40
6106	196	639	0	0	\N	0
6107	197	639	1	2	\N	20
6108	171	639	1	1	\N	20
6109	172	639	1	1	\N	20
6110	173	639	0	0	\N	0
6111	155	639	4	4	\N	90
6112	156	639	1	1	\N	20
6113	157	639	3	3	\N	60
6114	167	640	4	5	\N	80
6115	168	640	2	3	\N	40
6116	169	640	1	2	\N	20
6117	170	640	4	5	\N	80
6118	198	640	1	4	\N	0
6119	199	640	0	1	\N	0
6120	200	640	1	1	\N	20
6121	201	640	1	2	\N	20
6122	193	641	3	5	\N	50
6123	194	641	2	2	\N	40
6124	209	641	2	4	\N	30
6125	210	641	3	5	\N	50
6126	211	641	1	2	\N	20
6127	184	641	4	5	\N	80
6128	185	641	2	4	\N	30
6129	152	642	3	6	\N	40
6130	153	642	1	3	\N	10
6131	154	642	1	1	\N	20
6132	180	642	2	4	\N	30
6133	181	642	0	0	\N	0
6134	204	642	3	6	\N	40
6135	205	642	3	3	\N	60
6136	206	642	0	0	\N	0
6137	164	643	1	3	\N	10
6138	165	643	4	4	\N	90
6139	166	643	1	1	\N	20
6140	212	643	0	1	\N	0
6141	213	643	0	0	\N	0
6142	214	643	4	4	\N	90
6143	141	643	1	3	\N	10
6144	142	643	1	1	\N	20
6145	143	643	1	1	\N	20
6146	176	644	1	1	\N	20
6147	177	644	0	2	\N	-10
6148	178	644	0	0	\N	0
6149	179	644	4	4	\N	90
6150	190	644	3	4	\N	60
6151	191	644	1	2	\N	20
6152	192	644	2	2	\N	40
6153	202	644	3	5	\N	50
6154	203	644	2	3	\N	40
6155	131	645	0	1	\N	0
6156	132	645	2	3	\N	40
6157	133	645	0	0	\N	0
6158	146	645	1	2	\N	20
6159	147	645	2	4	\N	30
6160	148	645	0	1	\N	0
6161	186	645	4	4	\N	90
6162	187	645	1	1	\N	20
6163	188	645	0	0	\N	0
6164	189	645	4	4	\N	90
6165	134	646	0	0	\N	0
6166	135	646	1	3	\N	10
6167	136	646	0	0	\N	0
6168	137	646	0	0	\N	0
6169	207	646	2	3	\N	40
6170	208	646	0	0	\N	0
6171	161	646	4	5	\N	80
6172	162	646	1	2	\N	20
6173	163	646	0	0	\N	0
6174	182	647	4	4	\N	90
6175	183	647	3	3	\N	60
6176	139	647	4	4	\N	90
6177	140	647	3	3	\N	60
6178	158	647	4	5	\N	80
6179	159	647	2	3	\N	40
6180	160	647	1	3	\N	10
6181	266	649	1	4	\N	0
6182	267	649	2	2	\N	40
6183	268	649	0	1	\N	0
6184	218	649	4	5	\N	80
6185	219	649	4	6	\N	70
6186	220	649	0	0	\N	0
6187	242	649	3	3	\N	60
6188	243	649	3	3	\N	60
6189	244	649	1	2	\N	20
6190	260	650	4	4	\N	90
6191	261	650	0	1	\N	0
6192	262	650	4	4	\N	90
6193	256	650	3	5	\N	50
6194	257	650	1	1	\N	20
6195	258	650	3	4	\N	60
6196	259	650	1	1	\N	20
6197	215	650	4	4	\N	90
6198	216	650	0	0	\N	0
6199	217	650	4	5	\N	80
6200	224	651	2	3	\N	40
6201	225	651	0	0	\N	0
6202	226	651	3	5	\N	50
6203	227	651	1	2	\N	20
6204	263	651	4	5	\N	80
6205	264	651	0	1	\N	0
6206	265	651	0	0	\N	0
6207	235	651	2	5	\N	20
6208	236	651	2	2	\N	40
6209	237	651	2	3	\N	40
6210	228	652	3	6	\N	40
6211	229	652	1	2	\N	20
6212	230	652	2	2	\N	40
6213	231	652	0	0	\N	0
6214	245	652	1	2	\N	20
6215	246	652	2	2	\N	40
6216	247	652	0	1	\N	0
6217	248	652	1	1	\N	20
6218	269	652	0	1	\N	0
6219	270	652	1	2	\N	20
6220	271	652	3	4	\N	60
6221	272	652	1	1	\N	20
6222	249	653	4	4	\N	90
6223	250	653	2	2	\N	40
6224	251	653	0	1	\N	0
6225	252	653	0	2	\N	-10
6226	253	653	4	5	\N	80
6227	254	653	2	2	\N	40
6228	255	653	1	1	\N	20
6229	232	653	4	5	\N	80
6230	233	653	2	3	\N	40
6231	234	653	4	5	\N	80
6232	221	654	3	5	\N	50
6233	222	654	1	1	\N	20
6234	223	654	0	0	\N	0
6235	238	654	2	3	\N	40
6236	239	654	2	2	\N	40
6237	240	654	1	1	\N	20
6238	241	654	1	2	\N	20
6239	221	654	0	3	\N	-20
6240	222	654	2	2	\N	40
6241	223	654	1	2	\N	20
6242	249	655	4	4	\N	90
6243	250	655	1	1	\N	20
6244	251	655	0	1	\N	0
6245	252	655	2	2	\N	40
6246	235	655	0	0	\N	0
6247	236	655	1	1	\N	20
6248	237	655	1	2	\N	20
6249	263	655	2	3	\N	40
6250	264	655	1	2	\N	20
6251	265	655	0	0	\N	0
6252	260	656	3	3	\N	60
6253	261	656	4	4	\N	90
6254	262	656	3	3	\N	60
6255	218	656	3	4	\N	60
6256	219	656	2	2	\N	40
6257	220	656	1	3	\N	10
6258	266	656	4	5	\N	80
6259	267	656	2	3	\N	40
6260	268	656	0	1	\N	0
6261	245	657	2	2	\N	40
6262	246	657	0	1	\N	0
6263	247	657	0	0	\N	0
6264	248	657	1	1	\N	20
6265	269	657	3	4	\N	60
6266	270	657	0	0	\N	0
6267	271	657	3	3	\N	60
6268	272	657	1	2	\N	20
6269	238	657	4	5	\N	80
6270	239	657	2	4	\N	30
6271	240	657	3	5	\N	50
6272	241	657	0	0	\N	0
6273	224	658	4	5	\N	80
6274	225	658	0	0	\N	0
6275	226	658	1	1	\N	20
6276	227	658	4	6	\N	70
6277	253	658	4	5	\N	80
6278	254	658	2	2	\N	40
6279	255	658	0	1	\N	0
6280	215	658	3	4	\N	60
6281	216	658	2	3	\N	40
6282	217	658	0	0	\N	0
6283	232	659	1	2	\N	20
6284	233	659	2	2	\N	40
6285	234	659	0	1	\N	0
6286	242	659	3	4	\N	60
6287	243	659	0	0	\N	0
6288	244	659	3	3	\N	60
6289	256	659	4	6	\N	70
6290	257	659	2	2	\N	40
6291	258	659	2	3	\N	40
6292	259	659	0	0	\N	0
6293	228	660	4	4	\N	90
6294	229	660	2	3	\N	40
6295	230	660	0	1	\N	0
6296	231	660	2	4	\N	30
6297	235	660	0	1	\N	0
6298	236	660	1	1	\N	20
6299	237	660	0	0	\N	0
6300	238	660	3	3	\N	60
6301	239	660	0	0	\N	0
6302	240	660	0	0	\N	0
6303	241	660	2	2	\N	40
6304	245	661	2	5	\N	20
6305	246	661	1	2	\N	20
6306	247	661	0	1	\N	0
6307	248	661	4	5	\N	80
6308	269	661	4	5	\N	80
6309	270	661	0	0	\N	0
6310	271	661	0	0	\N	0
6311	272	661	4	4	\N	90
6312	224	661	3	4	\N	60
6313	225	661	3	4	\N	60
6314	226	661	1	1	\N	20
6315	227	661	2	2	\N	40
6316	221	662	0	1	\N	0
6317	222	662	2	2	\N	40
6318	223	662	1	1	\N	20
6319	249	662	3	4	\N	60
6320	250	662	0	0	\N	0
6321	251	662	2	4	\N	30
6322	252	662	4	4	\N	90
6323	266	662	1	1	\N	20
6324	267	662	0	0	\N	0
6325	268	662	2	2	\N	40
6326	215	663	3	4	\N	60
6327	216	663	0	0	\N	0
6328	217	663	0	1	\N	0
6329	253	663	3	3	\N	60
6330	254	663	1	1	\N	20
6331	255	663	2	2	\N	40
6332	218	663	3	4	\N	60
6333	219	663	0	0	\N	0
6334	220	663	2	2	\N	40
6335	260	664	1	2	\N	20
6336	261	664	0	0	\N	0
6337	262	664	1	1	\N	20
6338	263	664	4	4	\N	90
6339	264	664	2	2	\N	40
6340	265	664	2	3	\N	40
6341	242	664	2	2	\N	40
6342	243	664	0	1	\N	0
6343	244	664	2	2	\N	40
6344	232	665	4	6	\N	70
6345	233	665	1	2	\N	20
6346	234	665	0	1	\N	0
6347	228	665	1	2	\N	20
6348	229	665	1	2	\N	20
6349	230	665	1	2	\N	20
6350	231	665	2	2	\N	40
6351	256	665	1	3	\N	10
6352	257	665	0	2	\N	-10
6353	258	665	4	4	\N	90
6354	259	665	3	3	\N	60
6355	253	666	4	4	\N	90
6356	254	666	0	0	\N	0
6357	255	666	1	1	\N	20
6358	269	666	4	5	\N	80
6359	270	666	0	0	\N	0
6360	271	666	2	2	\N	40
6361	272	666	2	2	\N	40
6362	242	666	2	4	\N	30
6363	243	666	4	4	\N	90
6364	244	666	2	2	\N	40
6365	228	667	4	4	\N	90
6366	229	667	2	2	\N	40
6367	230	667	1	1	\N	20
6368	231	667	4	5	\N	80
6369	263	667	1	1	\N	20
6370	264	667	0	0	\N	0
6371	265	667	0	0	\N	0
6372	249	667	3	3	\N	60
6373	250	667	2	2	\N	40
6374	251	667	4	4	\N	90
6375	252	667	0	1	\N	0
6376	218	668	3	4	\N	60
6377	219	668	1	1	\N	20
6378	220	668	0	1	\N	0
6379	232	668	3	4	\N	60
6380	233	668	3	4	\N	60
6381	234	668	1	2	\N	20
6382	260	668	1	3	\N	10
6383	261	668	2	3	\N	40
6384	262	668	1	1	\N	20
6385	245	669	3	5	\N	50
6386	246	669	1	1	\N	20
6387	247	669	1	1	\N	20
6388	248	669	1	2	\N	20
6389	256	669	4	5	\N	80
6390	257	669	1	1	\N	20
6391	258	669	2	3	\N	40
6392	259	669	1	1	\N	20
6393	235	669	1	4	\N	0
6394	236	669	0	0	\N	0
6395	237	669	0	0	\N	0
6396	224	670	1	2	\N	20
6397	225	670	0	2	\N	-10
6398	226	670	4	4	\N	90
6399	227	670	0	1	\N	0
6400	215	670	3	3	\N	60
6401	216	670	0	0	\N	0
6402	217	670	3	3	\N	60
6403	221	670	3	4	\N	60
6404	222	670	1	1	\N	20
6405	223	670	0	0	\N	0
6406	238	671	3	6	\N	40
6407	239	671	3	4	\N	60
6408	240	671	1	1	\N	20
6409	241	671	3	5	\N	50
6410	266	671	2	4	\N	30
6411	267	671	2	2	\N	40
6412	268	671	3	3	\N	60
6413	260	671	2	2	\N	40
6414	261	671	1	1	\N	20
6415	262	671	1	1	\N	20
6416	224	672	4	4	\N	90
6417	225	672	0	2	\N	-10
6418	226	672	0	1	\N	0
6419	227	672	0	0	\N	0
6420	245	672	4	4	\N	90
6421	246	672	0	0	\N	0
6422	247	672	0	1	\N	0
6423	248	672	0	0	\N	0
6424	235	672	1	2	\N	20
6425	236	672	2	3	\N	40
6426	237	672	4	6	\N	70
6427	228	673	4	5	\N	80
6428	229	673	2	2	\N	40
6429	230	673	0	0	\N	0
6430	231	673	1	1	\N	20
6431	221	673	1	1	\N	20
6432	222	673	0	0	\N	0
6433	223	673	1	2	\N	20
6434	269	673	2	2	\N	40
6435	270	673	1	1	\N	20
6436	271	673	0	1	\N	0
6437	272	673	1	1	\N	20
6438	253	674	3	4	\N	60
6439	254	674	1	1	\N	20
6440	255	674	3	3	\N	60
6441	218	674	3	6	\N	40
6442	219	674	1	1	\N	20
6443	220	674	4	4	\N	90
6444	263	674	3	6	\N	40
6445	264	674	1	3	\N	10
6446	265	674	1	3	\N	10
6447	249	675	3	4	\N	60
6448	250	675	2	3	\N	40
6449	251	675	3	3	\N	60
6450	252	675	0	0	\N	0
6451	232	675	3	5	\N	50
6452	233	675	0	0	\N	0
6453	234	675	4	5	\N	80
6454	215	675	3	5	\N	50
6455	216	675	1	1	\N	20
6456	217	675	3	3	\N	60
6457	242	676	2	3	\N	40
6458	243	676	3	3	\N	60
6459	244	676	1	1	\N	20
6460	256	676	3	5	\N	50
6461	257	676	0	0	\N	0
6462	258	676	1	1	\N	20
6463	259	676	1	1	\N	20
6464	266	676	1	2	\N	20
6465	267	676	4	6	\N	70
6466	268	676	0	2	\N	-10
6467	238	677	4	5	\N	80
6468	239	677	2	2	\N	40
6469	240	677	0	2	\N	-10
6470	241	677	2	3	\N	40
6471	215	677	0	0	\N	0
6472	216	677	2	2	\N	40
6473	217	677	1	2	\N	20
6474	253	677	4	5	\N	80
6475	254	677	0	0	\N	0
6476	255	677	4	4	\N	90
6477	266	678	4	4	\N	90
6478	267	678	2	2	\N	40
6479	268	678	0	0	\N	0
6480	245	678	3	4	\N	60
6481	246	678	4	5	\N	80
6482	247	678	4	5	\N	80
6483	248	678	0	0	\N	0
6484	263	678	1	3	\N	10
6485	264	678	1	1	\N	20
6486	265	678	1	1	\N	20
6487	242	679	2	4	\N	30
6488	243	679	0	2	\N	-10
6489	244	679	4	5	\N	80
6490	256	679	3	5	\N	50
6491	257	679	0	1	\N	0
6492	258	679	1	3	\N	10
6493	259	679	0	0	\N	0
6494	238	679	4	5	\N	80
6495	239	679	0	0	\N	0
6496	240	679	1	1	\N	20
6497	241	679	0	0	\N	0
6498	221	680	1	1	\N	20
6499	222	680	0	0	\N	0
6500	223	680	1	1	\N	20
6501	260	680	2	3	\N	40
6502	261	680	1	2	\N	20
6503	262	680	1	2	\N	20
6504	269	680	2	3	\N	40
6505	270	680	1	1	\N	20
6506	271	680	0	0	\N	0
6507	272	680	3	3	\N	60
6508	224	681	3	5	\N	50
6509	225	681	2	3	\N	40
6510	226	681	4	6	\N	70
6511	227	681	1	1	\N	20
6512	218	681	2	2	\N	40
6513	219	681	1	2	\N	20
6514	220	681	1	1	\N	20
6515	249	681	4	4	\N	90
6516	250	681	1	1	\N	20
6517	251	681	1	1	\N	20
6518	252	681	1	1	\N	20
6519	232	682	3	4	\N	60
6520	233	682	0	0	\N	0
6521	234	682	1	1	\N	20
6522	228	682	3	4	\N	60
6523	229	682	0	2	\N	-10
6524	230	682	4	5	\N	80
6525	231	682	0	1	\N	0
6526	235	682	0	0	\N	0
6527	236	682	1	1	\N	20
6528	237	682	4	5	\N	80
6529	123	685	4	6	\N	70
6530	124	685	1	1	\N	20
6531	125	685	1	3	\N	10
6532	126	685	2	3	\N	40
6533	50	685	3	3	\N	60
6534	51	685	2	2	\N	40
6535	52	685	2	2	\N	40
6536	53	685	1	1	\N	20
6537	64	685	1	1	\N	20
6538	65	685	0	2	\N	-10
6539	66	685	3	5	\N	50
6540	67	685	0	2	\N	-10
6541	68	685	1	1	\N	20
6542	35	686	1	2	\N	20
6543	36	686	2	3	\N	40
6544	37	686	3	3	\N	60
6545	38	686	0	1	\N	0
6546	39	686	4	5	\N	80
6547	40	686	0	0	\N	0
6548	41	686	0	0	\N	0
6549	57	686	3	5	\N	50
6550	58	686	1	1	\N	20
6551	59	686	4	5	\N	80
6552	60	686	0	0	\N	0
6553	8	687	4	4	\N	90
6554	9	687	3	5	\N	50
6555	10	687	1	1	\N	20
6556	11	687	4	4	\N	90
6557	12	687	2	2	\N	40
6558	76	687	2	4	\N	30
6559	77	687	1	1	\N	20
6560	78	687	1	1	\N	20
6561	5	687	3	6	\N	40
6562	6	687	0	0	\N	0
6563	7	687	1	1	\N	20
6564	17	688	3	5	\N	50
6565	18	688	4	5	\N	80
6566	19	688	2	2	\N	40
6567	118	688	3	3	\N	60
6568	119	688	0	0	\N	0
6569	120	688	1	2	\N	20
6570	121	688	0	1	\N	0
6571	122	688	1	3	\N	10
6572	42	688	3	6	\N	40
6573	43	688	2	4	\N	30
6574	44	688	3	3	\N	60
6575	45	688	0	0	\N	0
6576	114	689	0	0	\N	0
6577	115	689	1	1	\N	20
6578	116	689	0	0	\N	0
6579	117	689	2	3	\N	40
6580	127	689	3	4	\N	60
6581	128	689	4	5	\N	80
6582	129	689	2	2	\N	40
6583	130	689	4	5	\N	80
6584	46	689	3	3	\N	60
6585	47	689	2	2	\N	40
6586	48	689	0	0	\N	0
6587	49	689	2	2	\N	40
6588	23	690	4	4	\N	90
6589	24	690	3	3	\N	60
6590	25	690	0	2	\N	-10
6591	26	690	4	4	\N	90
6592	99	690	0	2	\N	-10
6593	100	690	2	2	\N	40
6594	101	690	1	1	\N	20
6595	102	690	3	4	\N	60
6596	110	690	4	6	\N	70
6597	111	690	1	1	\N	20
6598	112	690	1	1	\N	20
6599	113	690	1	1	\N	20
6600	13	691	1	3	\N	10
6601	14	691	2	2	\N	40
6602	15	691	1	1	\N	20
6603	16	691	1	2	\N	20
6604	91	691	4	5	\N	80
6605	92	691	2	2	\N	40
6606	93	691	1	2	\N	20
6607	94	691	1	1	\N	20
6608	106	691	4	4	\N	90
6609	107	691	0	2	\N	-10
6610	108	691	1	1	\N	20
6611	109	691	1	1	\N	20
6612	73	692	4	5	\N	80
6613	74	692	1	3	\N	10
6614	75	692	0	0	\N	0
6615	27	692	1	3	\N	10
6616	28	692	2	2	\N	40
6617	29	692	2	3	\N	40
6618	30	692	0	1	\N	0
6619	31	692	0	1	\N	0
6620	103	692	1	1	\N	20
6621	104	692	1	1	\N	20
6622	105	692	0	2	\N	-10
6623	1	693	4	6	\N	70
6624	2	693	1	1	\N	20
6625	3	693	1	1	\N	20
6626	4	693	0	0	\N	0
6627	54	693	4	4	\N	90
6628	55	693	0	0	\N	0
6629	56	693	0	0	\N	0
6630	61	693	4	5	\N	80
6631	62	693	2	2	\N	40
6632	63	693	0	2	\N	-10
6633	87	694	2	4	\N	30
6634	88	694	4	5	\N	80
6635	89	694	0	2	\N	-10
6636	90	694	3	3	\N	60
6637	69	694	4	5	\N	80
6638	70	694	4	4	\N	90
6639	71	694	0	1	\N	0
6640	72	694	1	1	\N	20
6641	79	694	4	5	\N	80
6642	80	694	1	1	\N	20
6643	81	694	4	4	\N	90
6644	82	694	2	2	\N	40
6645	32	695	4	5	\N	80
6646	33	695	0	2	\N	-10
6647	34	695	4	4	\N	90
6648	83	695	4	5	\N	80
6649	84	695	0	1	\N	0
6650	85	695	1	2	\N	20
6651	86	695	0	2	\N	-10
6652	20	695	4	5	\N	80
6653	21	695	1	1	\N	20
6654	22	695	1	1	\N	20
6655	95	696	3	3	\N	60
6656	96	696	0	0	\N	0
6657	97	696	4	5	\N	80
6658	98	696	0	0	\N	0
6659	114	696	1	2	\N	20
6660	115	696	1	1	\N	20
6661	116	696	2	2	\N	40
6662	117	696	1	3	\N	10
6663	57	696	2	2	\N	40
6664	58	696	2	4	\N	30
6665	59	696	1	1	\N	20
6666	60	696	1	1	\N	20
6667	5	697	4	4	\N	90
6668	6	697	2	2	\N	40
6669	7	697	4	5	\N	80
6670	73	697	3	4	\N	60
6671	74	697	0	0	\N	0
6672	75	697	0	0	\N	0
6673	64	697	0	1	\N	0
6674	65	697	2	2	\N	40
6675	66	697	1	1	\N	20
6676	67	697	1	2	\N	20
6677	68	697	2	2	\N	40
6678	42	698	1	3	\N	10
6679	43	698	1	2	\N	20
6680	44	698	2	3	\N	40
6681	45	698	4	5	\N	80
6682	79	698	1	1	\N	20
6683	80	698	0	0	\N	0
6684	81	698	1	2	\N	20
6685	82	698	1	1	\N	20
6686	13	698	4	4	\N	90
6687	14	698	4	4	\N	90
6688	15	698	0	0	\N	0
6689	16	698	0	1	\N	0
6690	1	699	3	5	\N	50
6691	2	699	0	0	\N	0
6692	3	699	0	0	\N	0
6693	4	699	1	3	\N	10
6694	35	699	3	3	\N	60
6695	36	699	1	2	\N	20
6696	37	699	1	1	\N	20
6697	38	699	1	3	\N	10
6698	27	699	3	3	\N	60
6699	28	699	1	1	\N	20
6700	29	699	1	1	\N	20
6701	30	699	2	2	\N	40
6702	31	699	0	0	\N	0
6703	95	700	4	4	\N	90
6704	96	700	0	0	\N	0
6705	97	700	0	1	\N	0
6706	98	700	1	1	\N	20
6707	32	700	3	3	\N	60
6708	33	700	3	3	\N	60
6709	34	700	2	2	\N	40
6710	50	700	4	4	\N	90
6711	51	700	3	4	\N	60
6712	52	700	1	1	\N	20
6713	53	700	0	2	\N	-10
6714	123	701	4	5	\N	80
6715	124	701	2	3	\N	40
6716	125	701	0	1	\N	0
6717	126	701	0	2	\N	-10
6718	23	701	3	4	\N	60
6719	24	701	1	1	\N	20
6720	25	701	2	3	\N	40
6721	26	701	4	6	\N	70
6722	54	701	1	1	\N	20
6723	55	701	2	2	\N	40
6724	56	701	2	3	\N	40
6725	127	702	1	4	\N	0
6726	128	702	1	1	\N	20
6727	129	702	4	5	\N	80
6728	130	702	1	1	\N	20
6729	17	702	3	6	\N	40
6730	18	702	4	6	\N	70
6731	19	702	4	4	\N	90
6732	69	702	1	1	\N	20
6733	70	702	1	1	\N	20
6734	71	702	2	2	\N	40
6735	72	702	3	3	\N	60
6736	20	703	3	3	\N	60
6737	21	703	3	5	\N	50
6738	22	703	1	1	\N	20
6739	76	703	3	5	\N	50
6740	77	703	1	1	\N	20
6741	78	703	1	1	\N	20
6742	87	703	3	3	\N	60
6743	88	703	2	2	\N	40
6744	89	703	2	2	\N	40
6745	90	703	0	0	\N	0
6746	83	704	4	5	\N	80
6747	84	704	0	0	\N	0
6748	85	704	3	5	\N	50
6749	86	704	4	4	\N	90
6750	118	704	3	5	\N	50
6751	119	704	2	2	\N	40
6752	120	704	2	4	\N	30
6753	121	704	0	1	\N	0
6754	122	704	3	3	\N	60
6755	8	704	1	1	\N	20
6756	9	704	2	2	\N	40
6757	10	704	3	3	\N	60
6758	11	704	4	5	\N	80
6759	12	704	0	0	\N	0
6760	46	705	1	1	\N	20
6761	47	705	1	2	\N	20
6762	48	705	1	1	\N	20
6763	49	705	1	1	\N	20
6764	61	705	1	4	\N	0
6765	62	705	0	0	\N	0
6766	63	705	1	1	\N	20
6767	106	705	4	5	\N	80
6768	107	705	2	2	\N	40
6769	108	705	1	3	\N	10
6770	109	705	4	4	\N	90
6771	99	706	1	2	\N	20
6772	100	706	2	2	\N	40
6773	101	706	0	1	\N	0
6774	102	706	2	3	\N	40
6775	103	706	3	3	\N	60
6776	104	706	4	5	\N	80
6777	105	706	1	1	\N	20
6778	39	706	4	4	\N	90
6779	40	706	1	2	\N	20
6780	41	706	3	4	\N	60
6781	91	707	4	4	\N	90
6782	92	707	2	2	\N	40
6783	93	707	0	0	\N	0
6784	94	707	1	2	\N	20
6785	110	707	3	4	\N	60
6786	111	707	2	3	\N	40
6787	112	707	2	3	\N	40
6788	113	707	3	5	\N	50
6789	127	707	0	2	\N	-10
6790	128	707	4	6	\N	70
6791	129	707	0	0	\N	0
6792	130	707	4	5	\N	80
6793	13	708	4	5	\N	80
6794	14	708	0	0	\N	0
6795	15	708	2	2	\N	40
6796	16	708	2	2	\N	40
6797	35	708	1	3	\N	10
6798	36	708	0	1	\N	0
6799	37	708	1	1	\N	20
6800	38	708	4	4	\N	90
6801	91	708	0	1	\N	0
6802	92	708	2	2	\N	40
6803	93	708	4	4	\N	90
6804	94	708	1	1	\N	20
6805	79	709	4	6	\N	70
6806	80	709	1	1	\N	20
6807	81	709	0	1	\N	0
6808	82	709	0	0	\N	0
6809	20	709	4	4	\N	90
6810	21	709	4	5	\N	80
6811	22	709	0	1	\N	0
6812	73	709	1	2	\N	20
6813	74	709	1	1	\N	20
6814	75	709	1	1	\N	20
6815	95	710	3	4	\N	60
6816	96	710	3	3	\N	60
6817	97	710	1	1	\N	20
6818	98	710	0	2	\N	-10
6819	46	710	3	3	\N	60
6820	47	710	2	3	\N	40
6821	48	710	0	0	\N	0
6822	49	710	0	0	\N	0
6823	32	710	4	6	\N	70
6824	33	710	2	4	\N	30
6825	34	710	0	1	\N	0
6826	110	711	4	6	\N	70
6827	111	711	2	2	\N	40
6828	112	711	1	1	\N	20
6829	113	711	0	0	\N	0
6830	5	711	3	5	\N	50
6831	6	711	1	1	\N	20
6832	7	711	3	3	\N	60
6833	27	711	4	5	\N	80
6834	28	711	0	1	\N	0
6835	29	711	0	1	\N	0
6836	30	711	3	3	\N	60
6837	31	711	2	3	\N	40
6838	61	712	3	4	\N	60
6839	62	712	2	2	\N	40
6840	63	712	1	1	\N	20
6841	123	712	2	3	\N	40
6842	124	712	0	0	\N	0
6843	125	712	1	1	\N	20
6844	126	712	2	2	\N	40
6845	42	712	3	6	\N	40
6846	43	712	2	3	\N	40
6847	44	712	0	1	\N	0
6848	45	712	0	0	\N	0
6849	39	713	1	2	\N	20
6850	40	713	3	3	\N	60
6851	41	713	1	2	\N	20
6852	57	713	3	3	\N	60
6853	58	713	0	0	\N	0
6854	59	713	0	0	\N	0
6855	60	713	1	1	\N	20
6856	103	713	4	4	\N	90
6857	104	713	0	2	\N	-10
6858	105	713	0	0	\N	0
6859	76	714	4	5	\N	80
6860	77	714	1	2	\N	20
6861	78	714	0	2	\N	-10
6862	83	714	0	1	\N	0
6863	84	714	0	0	\N	0
6864	85	714	4	4	\N	90
6865	86	714	1	2	\N	20
6866	17	714	2	4	\N	30
6867	18	714	1	1	\N	20
6868	19	714	0	2	\N	-10
6869	54	715	1	3	\N	10
6870	55	715	1	3	\N	10
6871	56	715	1	1	\N	20
6872	118	715	4	4	\N	90
6873	119	715	3	4	\N	60
6874	120	715	1	1	\N	20
6875	121	715	1	1	\N	20
6876	122	715	0	1	\N	0
6877	69	715	3	4	\N	60
6878	70	715	3	3	\N	60
6879	71	715	1	3	\N	10
6880	72	715	1	3	\N	10
6881	106	716	4	4	\N	90
6882	107	716	3	3	\N	60
6883	108	716	3	3	\N	60
6884	109	716	2	2	\N	40
6885	23	716	4	4	\N	90
6886	24	716	4	4	\N	90
6887	25	716	2	4	\N	30
6888	26	716	2	2	\N	40
6889	50	716	4	5	\N	80
6890	51	716	2	2	\N	40
6891	52	716	0	1	\N	0
6892	53	716	1	1	\N	20
6893	99	717	0	1	\N	0
6894	100	717	1	1	\N	20
6895	101	717	1	3	\N	10
6896	102	717	3	3	\N	60
6897	8	717	4	6	\N	70
6898	9	717	0	0	\N	0
6899	10	717	0	0	\N	0
6900	11	717	3	3	\N	60
6901	12	717	0	1	\N	0
6902	64	717	3	3	\N	60
6903	65	717	1	1	\N	20
6904	66	717	2	3	\N	40
6905	67	717	3	3	\N	60
6906	68	717	2	2	\N	40
6907	87	718	2	4	\N	30
6908	88	718	1	2	\N	20
6909	89	718	0	1	\N	0
6910	90	718	2	3	\N	40
6911	114	718	3	3	\N	60
6912	115	718	3	3	\N	60
6913	116	718	1	1	\N	20
6914	117	718	1	1	\N	20
6915	1	718	4	4	\N	90
6916	2	718	1	2	\N	20
6917	3	718	1	1	\N	20
6918	4	718	0	0	\N	0
6919	54	719	3	3	\N	60
6920	55	719	2	2	\N	40
6921	56	719	0	0	\N	0
6922	103	719	3	4	\N	60
6923	104	719	1	2	\N	20
6924	105	719	4	4	\N	90
6925	95	719	1	3	\N	10
6926	96	719	0	1	\N	0
6927	97	719	4	4	\N	90
6928	98	719	2	2	\N	40
6929	27	720	1	3	\N	10
6930	28	720	2	2	\N	40
6931	29	720	1	1	\N	20
6932	30	720	3	3	\N	60
6933	31	720	1	1	\N	20
6934	83	720	4	4	\N	90
6935	84	720	0	0	\N	0
6936	85	720	4	4	\N	90
6937	86	720	0	0	\N	0
6938	39	720	2	3	\N	40
6939	40	720	0	0	\N	0
6940	41	720	0	0	\N	0
6941	20	721	4	6	\N	70
6942	21	721	1	2	\N	20
6943	22	721	2	2	\N	40
6944	17	721	4	4	\N	90
6945	18	721	1	3	\N	10
6946	19	721	1	1	\N	20
6947	110	721	4	6	\N	70
6948	111	721	1	1	\N	20
6949	112	721	2	2	\N	40
6950	113	721	4	5	\N	80
6951	73	722	4	5	\N	80
6952	74	722	0	0	\N	0
6953	75	722	1	3	\N	10
6954	50	722	3	6	\N	40
6955	51	722	3	3	\N	60
6956	52	722	1	2	\N	20
6957	53	722	0	0	\N	0
6958	42	722	3	6	\N	40
6959	43	722	0	0	\N	0
6960	44	722	1	1	\N	20
6961	45	722	1	3	\N	10
6962	46	723	4	4	\N	90
6963	47	723	1	1	\N	20
6964	48	723	1	1	\N	20
6965	49	723	0	0	\N	0
6966	64	723	0	1	\N	0
6967	65	723	1	2	\N	20
6968	66	723	4	5	\N	80
6969	67	723	1	1	\N	20
6970	68	723	0	0	\N	0
6971	127	723	4	5	\N	80
6972	128	723	1	1	\N	20
6973	129	723	1	1	\N	20
6974	130	723	0	0	\N	0
6975	5	724	3	4	\N	60
6976	6	724	2	3	\N	40
6977	7	724	4	4	\N	90
6978	118	724	4	5	\N	80
6979	119	724	0	0	\N	0
6980	120	724	1	1	\N	20
6981	121	724	0	2	\N	-10
6982	122	724	0	0	\N	0
6983	1	724	0	1	\N	0
6984	2	724	0	2	\N	-10
6985	3	724	1	2	\N	20
6986	4	724	0	0	\N	0
6987	87	725	4	5	\N	80
6988	88	725	0	2	\N	-10
6989	89	725	1	1	\N	20
6990	90	725	0	2	\N	-10
6991	35	725	3	6	\N	40
6992	36	725	1	1	\N	20
6993	37	725	1	2	\N	20
6994	38	725	2	4	\N	30
6995	61	725	4	5	\N	80
6996	62	725	2	3	\N	40
6997	63	725	4	5	\N	80
6998	8	726	4	4	\N	90
6999	9	726	4	5	\N	80
7000	10	726	0	0	\N	0
7001	11	726	3	3	\N	60
7002	12	726	1	3	\N	10
7003	79	726	4	6	\N	70
7004	80	726	1	2	\N	20
7005	81	726	2	3	\N	40
7006	82	726	3	4	\N	60
7007	106	726	4	5	\N	80
7008	107	726	2	2	\N	40
7009	108	726	0	2	\N	-10
7010	109	726	2	2	\N	40
7011	99	727	4	4	\N	90
7012	100	727	0	2	\N	-10
7013	101	727	0	0	\N	0
7014	102	727	2	2	\N	40
7015	91	727	1	1	\N	20
7016	92	727	1	2	\N	20
7017	93	727	0	0	\N	0
7018	94	727	0	0	\N	0
7019	57	727	3	3	\N	60
7020	58	727	1	3	\N	10
7021	59	727	1	2	\N	20
7022	60	727	0	0	\N	0
7023	114	728	0	1	\N	0
7024	115	728	1	1	\N	20
7025	116	728	1	1	\N	20
7026	117	728	4	4	\N	90
7027	76	728	0	0	\N	0
7028	77	728	1	1	\N	20
7029	78	728	0	0	\N	0
7030	32	728	3	5	\N	50
7031	33	728	2	4	\N	30
7032	34	728	1	1	\N	20
7033	13	729	1	1	\N	20
7034	14	729	2	2	\N	40
7035	15	729	4	4	\N	90
7036	16	729	1	1	\N	20
7037	23	729	4	5	\N	80
7038	24	729	1	1	\N	20
7039	25	729	1	1	\N	20
7040	26	729	2	3	\N	40
7041	123	729	3	5	\N	50
7042	124	729	3	3	\N	60
7043	125	729	2	2	\N	40
7044	126	729	1	1	\N	20
7045	69	730	4	4	\N	90
7046	70	730	2	3	\N	40
7047	71	730	1	3	\N	10
7048	72	730	1	1	\N	20
7049	32	730	3	5	\N	50
7050	33	730	2	2	\N	40
7051	34	730	2	2	\N	40
7052	99	730	3	3	\N	60
7053	100	730	2	4	\N	30
7054	101	730	1	1	\N	20
7055	102	730	0	0	\N	0
7056	42	731	0	0	\N	0
7057	43	731	4	6	\N	70
7058	44	731	4	4	\N	90
7059	45	731	1	1	\N	20
7060	5	731	4	5	\N	80
7061	6	731	3	4	\N	60
7062	7	731	0	2	\N	-10
7063	1	731	2	3	\N	40
7064	2	731	0	0	\N	0
7065	3	731	2	3	\N	40
7066	4	731	0	0	\N	0
7067	114	732	4	4	\N	90
7068	115	732	2	4	\N	30
7069	116	732	3	3	\N	60
7070	117	732	0	0	\N	0
7071	123	732	4	4	\N	90
7072	124	732	0	0	\N	0
7073	125	732	1	3	\N	10
7074	126	732	0	0	\N	0
7075	69	732	0	1	\N	0
7076	70	732	3	3	\N	60
7077	71	732	0	0	\N	0
7078	72	732	0	1	\N	0
7079	61	733	4	5	\N	80
7080	62	733	1	3	\N	10
7081	63	733	3	4	\N	60
7082	27	733	2	3	\N	40
7083	28	733	4	5	\N	80
7084	29	733	1	1	\N	20
7085	30	733	2	4	\N	30
7086	31	733	2	2	\N	40
7087	20	733	4	4	\N	90
7088	21	733	0	1	\N	0
7089	22	733	4	4	\N	90
7090	57	734	4	5	\N	80
7091	58	734	1	1	\N	20
7092	59	734	3	3	\N	60
7093	60	734	2	2	\N	40
7094	35	734	3	4	\N	60
7095	36	734	3	3	\N	60
7096	37	734	0	1	\N	0
7097	38	734	1	1	\N	20
7098	64	734	0	2	\N	-10
7099	65	734	0	2	\N	-10
7100	66	734	1	3	\N	10
7101	67	734	0	0	\N	0
7102	68	734	0	0	\N	0
7103	106	735	4	5	\N	80
7104	107	735	1	1	\N	20
7105	108	735	1	1	\N	20
7106	109	735	1	1	\N	20
7107	73	735	3	6	\N	40
7108	74	735	2	2	\N	40
7109	75	735	4	4	\N	90
7110	91	735	4	6	\N	70
7111	92	735	4	4	\N	90
7112	93	735	2	2	\N	40
7113	94	735	1	2	\N	20
7114	118	736	1	2	\N	20
7115	119	736	1	2	\N	20
7116	120	736	4	6	\N	70
7117	121	736	2	2	\N	40
7118	122	736	4	4	\N	90
7119	110	736	3	3	\N	60
7120	111	736	1	3	\N	10
7121	112	736	1	2	\N	20
7122	113	736	2	2	\N	40
7123	39	736	4	4	\N	90
7124	40	736	1	1	\N	20
7125	41	736	1	1	\N	20
7126	87	737	1	1	\N	20
7127	88	737	3	5	\N	50
7128	89	737	2	2	\N	40
7129	90	737	0	0	\N	0
7130	83	737	3	4	\N	60
7131	84	737	0	2	\N	-10
7132	85	737	2	2	\N	40
7133	86	737	1	3	\N	10
7134	127	737	3	5	\N	50
7135	128	737	0	0	\N	0
7136	129	737	1	1	\N	20
7137	130	737	2	2	\N	40
7138	79	738	1	4	\N	0
7139	80	738	2	2	\N	40
7140	81	738	4	4	\N	90
7141	82	738	1	1	\N	20
7142	8	738	3	3	\N	60
7143	9	738	4	4	\N	90
7144	10	738	2	2	\N	40
7145	11	738	2	2	\N	40
7146	12	738	1	1	\N	20
7147	13	738	4	4	\N	90
7148	14	738	1	1	\N	20
7149	15	738	1	2	\N	20
7150	16	738	0	0	\N	0
7151	103	739	4	6	\N	70
7152	104	739	0	0	\N	0
7153	105	739	2	3	\N	40
7154	46	739	4	4	\N	90
7155	47	739	1	1	\N	20
7156	48	739	2	2	\N	40
7157	49	739	3	4	\N	60
7158	17	739	4	4	\N	90
7159	18	739	2	3	\N	40
7160	19	739	0	0	\N	0
7161	95	740	0	3	\N	-20
7162	96	740	1	1	\N	20
7163	97	740	0	1	\N	0
7164	98	740	0	0	\N	0
7165	50	740	4	5	\N	80
7166	51	740	0	2	\N	-10
7167	52	740	0	1	\N	0
7168	53	740	0	0	\N	0
7169	54	740	4	4	\N	90
7170	55	740	0	1	\N	0
7171	56	740	4	4	\N	90
7172	23	741	4	4	\N	90
7173	24	741	4	5	\N	80
7174	25	741	4	4	\N	90
7175	26	741	1	1	\N	20
7176	76	741	3	4	\N	60
7177	77	741	4	4	\N	90
7178	78	741	0	0	\N	0
7179	17	741	3	6	\N	40
7180	18	741	4	5	\N	80
7181	19	741	0	1	\N	0
7182	73	742	4	4	\N	90
7183	74	742	1	1	\N	20
7184	75	742	3	3	\N	60
7185	106	742	4	4	\N	90
7186	107	742	2	4	\N	30
7187	108	742	2	2	\N	40
7188	109	742	3	4	\N	60
7189	35	742	3	6	\N	40
7190	36	742	2	2	\N	40
7191	37	742	3	3	\N	60
7192	38	742	1	1	\N	20
7193	13	743	3	4	\N	60
7194	14	743	0	0	\N	0
7195	15	743	2	3	\N	40
7196	16	743	2	3	\N	40
7197	23	743	3	4	\N	60
7198	24	743	1	1	\N	20
7199	25	743	0	2	\N	-10
7200	26	743	1	2	\N	20
7201	46	743	3	3	\N	60
7202	47	743	0	2	\N	-10
7203	48	743	2	2	\N	40
7204	49	743	0	0	\N	0
7205	54	744	3	4	\N	60
7206	55	744	1	1	\N	20
7207	56	744	0	1	\N	0
7208	83	744	3	5	\N	50
7209	84	744	2	2	\N	40
7210	85	744	2	3	\N	40
7211	86	744	1	2	\N	20
7212	123	744	3	3	\N	60
7213	124	744	0	1	\N	0
7214	125	744	2	2	\N	40
7215	126	744	1	1	\N	20
7216	99	745	4	4	\N	90
7217	100	745	2	3	\N	40
7218	101	745	3	4	\N	60
7219	102	745	0	1	\N	0
7220	118	745	2	3	\N	40
7221	119	745	1	1	\N	20
7222	120	745	2	4	\N	30
7223	121	745	3	3	\N	60
7224	122	745	3	4	\N	60
7225	95	745	4	4	\N	90
7226	96	745	3	3	\N	60
7227	97	745	0	1	\N	0
7228	98	745	2	2	\N	40
7229	127	746	3	4	\N	60
7230	128	746	0	0	\N	0
7231	129	746	2	2	\N	40
7232	130	746	1	2	\N	20
7233	87	746	0	2	\N	-10
7234	88	746	0	0	\N	0
7235	89	746	1	1	\N	20
7236	90	746	4	5	\N	80
7237	114	746	2	3	\N	40
7238	115	746	1	3	\N	10
7239	116	746	2	2	\N	40
7240	117	746	0	0	\N	0
7241	20	747	2	4	\N	30
7242	21	747	0	0	\N	0
7243	22	747	1	1	\N	20
7244	91	747	2	4	\N	30
7245	92	747	3	4	\N	60
7246	93	747	1	1	\N	20
7247	94	747	1	1	\N	20
7248	79	747	2	2	\N	40
7249	80	747	0	1	\N	0
7250	81	747	3	3	\N	60
7251	82	747	0	2	\N	-10
7252	103	748	2	3	\N	40
7253	104	748	0	0	\N	0
7254	105	748	1	1	\N	20
7255	42	748	4	4	\N	90
7256	43	748	3	4	\N	60
7257	44	748	1	1	\N	20
7258	45	748	3	3	\N	60
7259	5	748	3	5	\N	50
7260	6	748	3	5	\N	50
7261	7	748	0	2	\N	-10
7262	57	749	3	4	\N	60
7263	58	749	0	1	\N	0
7264	59	749	3	3	\N	60
7265	60	749	2	2	\N	40
7266	76	749	1	1	\N	20
7267	77	749	2	3	\N	40
7268	78	749	1	1	\N	20
7269	69	749	4	6	\N	70
7270	70	749	0	1	\N	0
7271	71	749	2	4	\N	30
7272	72	749	0	0	\N	0
7273	61	750	1	1	\N	20
7274	62	750	0	0	\N	0
7275	63	750	0	0	\N	0
7276	50	750	4	4	\N	90
7277	51	750	3	5	\N	50
7278	52	750	3	3	\N	60
7279	53	750	2	2	\N	40
7280	64	750	4	6	\N	70
7281	65	750	0	0	\N	0
7282	66	750	1	1	\N	20
7283	67	750	3	3	\N	60
7284	68	750	1	2	\N	20
7285	8	751	4	5	\N	80
7286	9	751	1	1	\N	20
7287	10	751	0	0	\N	0
7288	11	751	2	2	\N	40
7289	12	751	0	0	\N	0
7290	39	751	3	4	\N	60
7291	40	751	3	4	\N	60
7292	41	751	0	1	\N	0
7293	32	751	3	6	\N	40
7294	33	751	2	2	\N	40
7295	34	751	1	1	\N	20
7296	27	752	3	3	\N	60
7297	28	752	0	0	\N	0
7298	29	752	3	3	\N	60
7299	30	752	1	1	\N	20
7300	31	752	0	1	\N	0
7301	1	752	0	1	\N	0
7302	2	752	3	4	\N	60
7303	3	752	2	3	\N	40
7304	4	752	1	1	\N	20
7305	110	752	3	4	\N	60
7306	111	752	0	0	\N	0
7307	112	752	2	3	\N	40
7308	113	752	3	3	\N	60
7309	186	757	3	5	\N	50
7310	187	757	1	2	\N	20
7311	188	757	0	1	\N	0
7312	189	757	2	3	\N	40
7313	174	757	3	3	\N	60
7314	175	757	0	2	\N	-10
7315	195	757	3	3	\N	60
7316	196	757	2	4	\N	30
7317	197	757	4	4	\N	90
7318	146	758	3	6	\N	40
7319	147	758	1	3	\N	10
7320	148	758	3	3	\N	60
7321	158	758	4	4	\N	90
7322	159	758	1	1	\N	20
7323	160	758	2	3	\N	40
7324	209	758	1	3	\N	10
7325	210	758	0	0	\N	0
7326	211	758	1	2	\N	20
7327	139	759	2	2	\N	40
7328	140	759	1	1	\N	20
7329	184	759	3	5	\N	50
7330	185	759	1	1	\N	20
7331	169	759	2	3	\N	40
7332	170	759	0	0	\N	0
7333	193	760	4	5	\N	80
7334	194	760	1	2	\N	20
7335	202	760	3	6	\N	40
7336	203	760	4	4	\N	90
7337	176	760	4	4	\N	90
7338	177	760	1	3	\N	10
7339	178	760	2	2	\N	40
7340	179	760	0	0	\N	0
7341	198	761	4	5	\N	80
7342	199	761	0	0	\N	0
7343	200	761	4	5	\N	80
7344	201	761	4	4	\N	90
7345	141	761	4	6	\N	70
7346	142	761	2	2	\N	40
7347	143	761	2	2	\N	40
7348	207	761	4	6	\N	70
7349	208	761	1	2	\N	20
7350	155	762	4	5	\N	80
7351	156	762	0	0	\N	0
7352	157	762	0	1	\N	0
7353	171	762	3	4	\N	60
7354	172	762	3	4	\N	60
7355	173	762	1	1	\N	20
7356	138	762	3	4	\N	60
7357	134	763	3	4	\N	60
7358	135	763	4	6	\N	70
7359	136	763	3	3	\N	60
7360	137	763	3	5	\N	50
7361	152	763	0	0	\N	0
7362	153	763	4	5	\N	80
7363	154	763	2	4	\N	30
7364	161	763	0	2	\N	-10
7365	162	763	1	1	\N	20
7366	163	763	1	1	\N	20
7367	182	764	4	4	\N	90
7368	183	764	1	1	\N	20
7369	131	764	1	2	\N	20
7370	132	764	0	0	\N	0
7371	133	764	0	0	\N	0
7372	149	764	4	4	\N	90
7373	150	764	2	3	\N	40
7374	151	764	1	1	\N	20
7375	144	765	3	3	\N	60
7376	145	765	1	2	\N	20
7377	190	765	4	6	\N	70
7378	191	765	3	4	\N	60
7379	192	765	1	1	\N	20
7380	204	765	4	4	\N	90
7381	205	765	2	2	\N	40
7382	206	765	2	2	\N	40
7383	164	766	0	1	\N	0
7384	165	766	4	4	\N	90
7385	166	766	1	1	\N	20
7386	212	766	3	4	\N	60
7387	213	766	2	4	\N	30
7388	214	766	0	2	\N	-10
7389	167	766	4	4	\N	90
7390	168	766	2	2	\N	40
7391	180	767	4	4	\N	90
7392	181	767	0	0	\N	0
7393	158	767	3	5	\N	50
7394	159	767	1	1	\N	20
7395	160	767	1	3	\N	10
7396	207	767	4	4	\N	90
7397	208	767	4	5	\N	80
7398	141	768	4	4	\N	90
7399	142	768	1	1	\N	20
7400	143	768	3	3	\N	60
7401	164	768	2	3	\N	40
7402	165	768	0	0	\N	0
7403	166	768	1	1	\N	20
7404	180	768	4	4	\N	90
7405	181	768	0	0	\N	0
7406	176	769	4	4	\N	90
7407	177	769	1	2	\N	20
7408	178	769	2	3	\N	40
7409	179	769	0	0	\N	0
7410	193	769	4	5	\N	80
7411	194	769	2	4	\N	30
7412	149	769	3	3	\N	60
7413	150	769	1	3	\N	10
7414	151	769	3	3	\N	60
7415	184	770	4	5	\N	80
7416	185	770	1	2	\N	20
7417	169	770	3	3	\N	60
7418	170	770	3	3	\N	60
7419	131	770	4	6	\N	70
7420	132	770	0	1	\N	0
7421	133	770	0	0	\N	0
7422	174	771	0	2	\N	-10
7423	175	771	1	2	\N	20
7424	155	771	2	4	\N	30
7425	156	771	1	1	\N	20
7426	157	771	4	4	\N	90
7427	152	771	1	3	\N	10
7428	153	771	2	3	\N	40
7429	154	771	4	4	\N	90
7430	161	772	4	6	\N	70
7431	162	772	2	2	\N	40
7432	163	772	1	2	\N	20
7433	195	772	4	5	\N	80
7434	196	772	1	1	\N	20
7435	197	772	0	0	\N	0
7436	204	772	4	4	\N	90
7437	205	772	2	2	\N	40
7438	206	772	2	2	\N	40
7439	209	773	4	4	\N	90
7440	210	773	0	1	\N	0
7441	211	773	1	1	\N	20
7442	134	773	4	5	\N	80
7443	135	773	4	4	\N	90
7444	136	773	2	2	\N	40
7445	137	773	0	2	\N	-10
7446	198	773	0	2	\N	-10
7447	199	773	1	3	\N	10
7448	200	773	0	0	\N	0
7449	201	773	4	4	\N	90
7450	202	774	3	3	\N	60
7451	203	774	2	3	\N	40
7452	182	774	2	4	\N	30
7453	183	774	1	3	\N	10
7454	186	774	3	4	\N	60
7455	187	774	0	0	\N	0
7456	188	774	2	3	\N	40
7457	189	774	1	3	\N	10
7458	190	775	4	4	\N	90
7459	191	775	3	3	\N	60
7460	192	775	1	2	\N	20
7461	144	775	3	3	\N	60
7462	145	775	2	4	\N	30
7463	146	775	4	5	\N	80
7464	147	775	4	4	\N	90
7465	148	775	1	1	\N	20
7466	171	776	4	4	\N	90
7467	172	776	1	1	\N	20
7468	173	776	3	4	\N	60
7469	138	776	3	4	\N	60
7470	212	776	4	4	\N	90
7471	213	776	4	5	\N	80
7472	214	776	2	2	\N	40
7473	139	777	4	4	\N	90
7474	140	777	2	3	\N	40
7475	167	777	3	3	\N	60
7476	168	777	2	3	\N	40
7477	138	777	3	4	\N	60
7478	193	778	3	4	\N	60
7479	194	778	0	0	\N	0
7480	186	778	4	4	\N	90
7481	187	778	0	0	\N	0
7482	188	778	0	0	\N	0
7483	189	778	3	3	\N	60
7484	164	778	4	6	\N	70
7485	165	778	0	0	\N	0
7486	166	778	0	0	\N	0
7487	169	779	0	1	\N	0
7488	170	779	2	3	\N	40
7489	209	779	4	5	\N	80
7490	210	779	1	3	\N	10
7491	211	779	0	1	\N	0
7492	144	779	3	4	\N	60
7493	145	779	0	0	\N	0
7494	195	780	4	5	\N	80
7495	196	780	3	3	\N	60
7496	197	780	2	2	\N	40
7497	202	780	2	3	\N	40
7498	203	780	3	3	\N	60
7499	212	780	3	3	\N	60
7500	213	780	4	5	\N	80
7501	214	780	2	3	\N	40
7502	176	781	4	4	\N	90
7503	177	781	4	6	\N	70
7504	178	781	0	2	\N	-10
7505	179	781	2	2	\N	40
7506	131	781	4	5	\N	80
7507	132	781	2	3	\N	40
7508	133	781	3	3	\N	60
7509	139	781	0	2	\N	-10
7510	140	781	0	0	\N	0
7511	190	782	4	6	\N	70
7512	191	782	3	3	\N	60
7513	192	782	3	3	\N	60
7514	155	782	4	5	\N	80
7515	156	782	2	2	\N	40
7516	157	782	4	5	\N	80
7517	184	782	4	4	\N	90
7518	185	782	2	4	\N	30
7519	167	783	1	3	\N	10
7520	168	783	0	0	\N	0
7521	141	783	4	6	\N	70
7522	142	783	0	0	\N	0
7523	143	783	0	0	\N	0
7524	204	783	3	4	\N	60
7525	205	783	1	2	\N	20
7526	206	783	2	2	\N	40
7527	182	784	3	4	\N	60
7528	183	784	4	4	\N	90
7529	146	784	3	5	\N	50
7530	147	784	2	2	\N	40
7531	148	784	0	0	\N	0
7532	180	784	3	5	\N	50
7533	181	784	1	1	\N	20
7534	161	785	3	3	\N	60
7535	162	785	2	4	\N	30
7536	163	785	3	4	\N	60
7537	207	785	3	3	\N	60
7538	208	785	1	2	\N	20
7539	174	785	4	4	\N	90
7540	175	785	3	3	\N	60
7541	198	786	4	4	\N	90
7542	199	786	3	3	\N	60
7543	200	786	4	6	\N	70
7544	201	786	1	2	\N	20
7545	134	786	3	5	\N	50
7546	135	786	2	2	\N	40
7547	136	786	0	1	\N	0
7548	137	786	0	0	\N	0
7549	171	786	3	5	\N	50
7550	172	786	1	1	\N	20
7551	173	786	4	4	\N	90
7552	152	787	3	4	\N	60
7553	153	787	1	1	\N	20
7554	154	787	2	4	\N	30
7555	158	787	3	3	\N	60
7556	159	787	1	3	\N	10
7557	160	787	0	0	\N	0
7558	149	787	2	2	\N	40
7559	150	787	0	0	\N	0
7560	151	787	0	0	\N	0
7561	131	788	4	5	\N	80
7562	132	788	0	0	\N	0
7563	133	788	1	1	\N	20
7564	171	788	4	4	\N	90
7565	172	788	1	1	\N	20
7566	173	788	0	2	\N	-10
7567	182	788	2	4	\N	30
7568	183	788	1	1	\N	20
7569	207	789	3	5	\N	50
7570	208	789	4	4	\N	90
7571	138	789	1	2	\N	20
7572	167	789	4	4	\N	90
7573	168	789	3	3	\N	60
7574	176	790	4	6	\N	70
7575	177	790	1	3	\N	10
7576	178	790	1	1	\N	20
7577	179	790	0	0	\N	0
7578	169	790	3	4	\N	60
7579	170	790	0	2	\N	-10
7580	184	790	4	4	\N	90
7581	185	790	2	4	\N	30
7582	161	791	4	6	\N	70
7583	162	791	1	1	\N	20
7584	163	791	4	5	\N	80
7585	152	791	4	4	\N	90
7586	153	791	0	0	\N	0
7587	154	791	3	3	\N	60
7588	212	791	4	5	\N	80
7589	213	791	0	0	\N	0
7590	214	791	1	1	\N	20
7591	139	792	1	3	\N	10
7592	140	792	0	0	\N	0
7593	180	792	4	5	\N	80
7594	181	792	4	5	\N	80
7595	146	792	0	2	\N	-10
7596	147	792	2	2	\N	40
7597	148	792	0	2	\N	-10
7598	174	793	4	5	\N	80
7599	175	793	1	1	\N	20
7600	195	793	3	6	\N	40
7601	196	793	3	4	\N	60
7602	197	793	4	4	\N	90
7603	144	793	3	5	\N	50
7604	145	793	0	0	\N	0
7605	158	794	4	5	\N	80
7606	159	794	1	1	\N	20
7607	160	794	3	4	\N	60
7608	155	794	3	6	\N	40
7609	156	794	0	0	\N	0
7610	157	794	1	1	\N	20
7611	190	794	4	6	\N	70
7612	191	794	2	2	\N	40
7613	192	794	0	1	\N	0
7614	209	795	4	4	\N	90
7615	210	795	1	3	\N	10
7616	211	795	0	2	\N	-10
7617	141	795	1	3	\N	10
7618	142	795	1	1	\N	20
7619	143	795	3	3	\N	60
7620	186	795	4	4	\N	90
7621	187	795	3	3	\N	60
7622	188	795	0	1	\N	0
7623	189	795	4	6	\N	70
7624	204	796	3	4	\N	60
7625	205	796	0	2	\N	-10
7626	206	796	0	0	\N	0
7627	202	796	1	4	\N	0
7628	203	796	1	1	\N	20
7629	149	796	4	5	\N	80
7630	150	796	1	1	\N	20
7631	151	796	0	0	\N	0
7632	193	797	0	2	\N	-10
7633	194	797	0	0	\N	0
7634	198	797	1	1	\N	20
7635	199	797	0	1	\N	0
7636	200	797	0	0	\N	0
7637	201	797	1	1	\N	20
7638	134	797	2	4	\N	30
7639	135	797	0	0	\N	0
7640	136	797	1	3	\N	10
7641	137	797	2	3	\N	40
7642	164	798	4	4	\N	90
7643	165	798	3	3	\N	60
7644	166	798	1	3	\N	10
7645	161	798	1	3	\N	10
7646	162	798	0	0	\N	0
7647	163	798	2	3	\N	40
7648	193	798	0	1	\N	0
7649	194	798	4	4	\N	90
7650	152	799	3	4	\N	60
7651	153	799	2	2	\N	40
7652	154	799	0	0	\N	0
7653	141	799	3	6	\N	40
7654	142	799	1	1	\N	20
7655	143	799	1	2	\N	20
7656	144	799	1	1	\N	20
7657	145	799	2	2	\N	40
7658	164	800	1	2	\N	20
7659	165	800	3	4	\N	60
7660	166	800	2	2	\N	40
7661	204	800	4	5	\N	80
7662	205	800	4	6	\N	70
7663	206	800	3	4	\N	60
7664	209	800	2	3	\N	40
7665	210	800	0	2	\N	-10
7666	211	800	0	0	\N	0
7667	202	801	4	5	\N	80
7668	203	801	0	2	\N	-10
7669	171	801	3	3	\N	60
7670	172	801	0	0	\N	0
7671	173	801	2	3	\N	40
7672	207	801	2	4	\N	30
7673	208	801	0	1	\N	0
7674	174	802	0	3	\N	-20
7675	175	802	1	1	\N	20
7676	167	802	4	5	\N	80
7677	168	802	0	2	\N	-10
7678	176	802	3	4	\N	60
7679	177	802	0	0	\N	0
7680	178	802	1	1	\N	20
7681	179	802	1	3	\N	10
7682	138	803	2	3	\N	40
7683	158	803	4	4	\N	90
7684	159	803	2	2	\N	40
7685	160	803	2	3	\N	40
7686	149	803	0	0	\N	0
7687	150	803	2	2	\N	40
7688	151	803	4	6	\N	70
7689	146	804	0	0	\N	0
7690	147	804	2	2	\N	40
7691	148	804	2	4	\N	30
7692	186	804	0	2	\N	-10
7693	187	804	0	2	\N	-10
7694	188	804	0	0	\N	0
7695	189	804	0	0	\N	0
7696	198	804	4	5	\N	80
7697	199	804	1	3	\N	10
7698	200	804	1	2	\N	20
7699	201	804	3	4	\N	60
7700	190	805	3	3	\N	60
7701	191	805	3	4	\N	60
7702	192	805	0	0	\N	0
7703	184	805	0	0	\N	0
7704	185	805	0	1	\N	0
7705	131	805	1	2	\N	20
7706	132	805	2	3	\N	40
7707	133	805	1	2	\N	20
7708	139	806	3	4	\N	60
7709	140	806	1	1	\N	20
7710	169	806	3	4	\N	60
7711	170	806	2	2	\N	40
7712	212	806	3	4	\N	60
7713	213	806	0	0	\N	0
7714	214	806	1	2	\N	20
7715	195	807	4	5	\N	80
7716	196	807	2	2	\N	40
7717	197	807	1	1	\N	20
7718	155	807	2	3	\N	40
7719	156	807	1	3	\N	10
7720	157	807	1	1	\N	20
7721	180	807	3	4	\N	60
7722	181	807	2	2	\N	40
7723	182	808	0	2	\N	-10
7724	183	808	4	4	\N	90
7725	134	808	4	4	\N	90
7726	135	808	1	3	\N	10
7727	136	808	1	1	\N	20
7728	137	808	1	1	\N	20
7729	169	808	3	5	\N	50
7730	170	808	0	2	\N	-10
7731	171	809	1	2	\N	20
7732	172	809	1	3	\N	10
7733	173	809	0	0	\N	0
7734	204	809	1	2	\N	20
7735	205	809	1	1	\N	20
7736	206	809	1	1	\N	20
7737	198	809	1	4	\N	0
7738	199	809	0	0	\N	0
7739	200	809	1	1	\N	20
7740	201	809	0	1	\N	0
7741	138	810	3	3	\N	60
7742	144	810	4	5	\N	80
7743	145	810	0	2	\N	-10
7744	174	810	3	4	\N	60
7745	175	810	2	4	\N	30
7746	193	811	3	4	\N	60
7747	194	811	0	2	\N	-10
7748	207	811	1	2	\N	20
7749	208	811	4	4	\N	90
7750	180	811	4	4	\N	90
7751	181	811	3	4	\N	60
7752	155	812	1	2	\N	20
7753	156	812	2	2	\N	40
7754	157	812	1	1	\N	20
7755	209	812	4	4	\N	90
7756	210	812	2	3	\N	40
7757	211	812	1	1	\N	20
7758	186	812	3	5	\N	50
7759	187	812	3	3	\N	60
7760	188	812	4	4	\N	90
7761	189	812	1	1	\N	20
7762	182	813	2	4	\N	30
7763	183	813	3	3	\N	60
7764	141	813	3	4	\N	60
7765	142	813	1	1	\N	20
7766	143	813	0	0	\N	0
7767	139	813	4	4	\N	90
7768	140	813	2	2	\N	40
7769	167	814	4	4	\N	90
7770	168	814	1	1	\N	20
7771	195	814	3	4	\N	60
7772	196	814	0	0	\N	0
7773	197	814	2	2	\N	40
7774	161	814	2	4	\N	30
7775	162	814	0	0	\N	0
7776	163	814	2	2	\N	40
7777	152	815	4	5	\N	80
7778	153	815	4	5	\N	80
7779	154	815	1	3	\N	10
7780	131	815	4	6	\N	70
7781	132	815	1	1	\N	20
7782	133	815	1	1	\N	20
7783	134	815	1	2	\N	20
7784	135	815	2	3	\N	40
7785	136	815	1	1	\N	20
7786	137	815	3	4	\N	60
7787	184	816	3	5	\N	50
7788	185	816	2	4	\N	30
7789	212	816	4	4	\N	90
7790	213	816	1	2	\N	20
7791	214	816	2	2	\N	40
7792	158	816	0	1	\N	0
7793	159	816	1	2	\N	20
7794	160	816	1	2	\N	20
7795	149	817	4	5	\N	80
7796	150	817	0	1	\N	0
7797	151	817	0	1	\N	0
7798	190	817	3	4	\N	60
7799	191	817	1	1	\N	20
7800	192	817	2	4	\N	30
7801	146	817	4	5	\N	80
7802	147	817	4	4	\N	90
7803	148	817	0	0	\N	0
7804	176	818	4	5	\N	80
7805	177	818	3	3	\N	60
7806	178	818	1	1	\N	20
7807	179	818	1	1	\N	20
7808	164	818	2	2	\N	40
7809	165	818	2	3	\N	40
7810	166	818	0	0	\N	0
7811	202	818	3	6	\N	40
7812	203	818	2	2	\N	40
7813	221	820	0	3	\N	-20
7814	222	820	0	1	\N	0
7815	223	820	1	2	\N	20
7816	228	820	0	0	\N	0
7817	229	820	0	0	\N	0
7818	230	820	0	0	\N	0
7819	231	820	1	2	\N	20
7820	263	820	3	5	\N	50
7821	264	820	0	0	\N	0
7822	265	820	3	4	\N	60
7823	266	821	1	2	\N	20
7824	267	821	1	2	\N	20
7825	268	821	0	1	\N	0
7826	224	821	2	5	\N	20
7827	225	821	1	2	\N	20
7828	226	821	0	0	\N	0
7829	227	821	1	1	\N	20
7830	269	821	3	4	\N	60
7831	270	821	3	3	\N	60
7832	271	821	1	2	\N	20
7833	272	821	4	4	\N	90
7834	215	822	4	4	\N	90
7835	216	822	2	2	\N	40
7836	217	822	0	0	\N	0
7837	245	822	2	4	\N	30
7838	246	822	2	2	\N	40
7839	247	822	0	0	\N	0
7840	248	822	1	2	\N	20
7841	249	822	4	5	\N	80
7842	250	822	2	2	\N	40
7843	251	822	0	0	\N	0
7844	252	822	3	3	\N	60
7845	256	823	3	5	\N	50
7846	257	823	3	4	\N	60
7847	258	823	0	0	\N	0
7848	259	823	1	2	\N	20
7849	218	823	0	2	\N	-10
7850	219	823	1	1	\N	20
7851	220	823	1	1	\N	20
7852	253	823	3	4	\N	60
7853	254	823	1	2	\N	20
7854	255	823	2	2	\N	40
7855	242	824	3	5	\N	50
7856	243	824	1	1	\N	20
7857	244	824	1	1	\N	20
7858	232	824	4	5	\N	80
7859	233	824	4	5	\N	80
7860	234	824	0	0	\N	0
7861	235	824	0	1	\N	0
7862	236	824	2	2	\N	40
7863	237	824	2	2	\N	40
7864	238	825	3	3	\N	60
7865	239	825	2	2	\N	40
7866	240	825	3	3	\N	60
7867	241	825	0	0	\N	0
7868	260	825	4	5	\N	80
7869	261	825	2	2	\N	40
7870	262	825	1	2	\N	20
7871	221	825	3	4	\N	60
7872	222	825	2	2	\N	40
7873	223	825	0	0	\N	0
7874	249	826	3	3	\N	60
7875	250	826	2	3	\N	40
7876	251	826	1	3	\N	10
7877	252	826	0	1	\N	0
7878	215	826	4	5	\N	80
7879	216	826	0	1	\N	0
7880	217	826	1	1	\N	20
7881	245	826	3	4	\N	60
7882	246	826	1	1	\N	20
7883	247	826	1	1	\N	20
7884	248	826	1	1	\N	20
7885	224	827	3	3	\N	60
7886	225	827	1	1	\N	20
7887	226	827	0	0	\N	0
7888	227	827	2	4	\N	30
7889	266	827	2	2	\N	40
7890	267	827	1	1	\N	20
7891	268	827	4	4	\N	90
7892	260	827	2	2	\N	40
7893	261	827	4	4	\N	90
7894	262	827	0	0	\N	0
7895	238	828	3	6	\N	40
7896	239	828	4	4	\N	90
7897	240	828	4	4	\N	90
7898	241	828	3	4	\N	60
7899	263	828	3	5	\N	50
7900	264	828	0	0	\N	0
7901	265	828	1	1	\N	20
7902	256	828	3	6	\N	40
7903	257	828	1	2	\N	20
7904	258	828	0	2	\N	-10
7905	259	828	4	4	\N	90
7906	242	829	4	5	\N	80
7907	243	829	1	2	\N	20
7908	244	829	1	1	\N	20
7909	235	829	4	5	\N	80
7910	236	829	0	0	\N	0
7911	237	829	1	2	\N	20
7912	218	829	3	4	\N	60
7913	219	829	1	2	\N	20
7914	220	829	0	0	\N	0
7915	269	830	3	6	\N	40
7916	270	830	4	6	\N	70
7917	271	830	2	2	\N	40
7918	272	830	0	0	\N	0
7919	253	830	0	3	\N	-20
7920	254	830	2	3	\N	40
7921	255	830	0	2	\N	-10
7922	228	830	3	5	\N	50
7923	229	830	0	0	\N	0
7924	230	830	1	1	\N	20
7925	231	830	4	5	\N	80
7926	232	831	4	5	\N	80
7927	233	831	1	1	\N	20
7928	234	831	0	2	\N	-10
7929	235	831	3	4	\N	60
7930	236	831	2	4	\N	30
7931	237	831	1	1	\N	20
7932	228	831	0	1	\N	0
7933	229	831	1	2	\N	20
7934	230	831	0	0	\N	0
7935	231	831	0	1	\N	0
7936	256	832	1	1	\N	20
7937	257	832	1	1	\N	20
7938	258	832	1	1	\N	20
7939	259	832	0	1	\N	0
7940	218	832	4	4	\N	90
7941	219	832	4	4	\N	90
7942	220	832	1	1	\N	20
7943	269	832	4	5	\N	80
7944	270	832	1	1	\N	20
7945	271	832	0	1	\N	0
7946	272	832	2	2	\N	40
7947	221	833	3	3	\N	60
7948	222	833	0	0	\N	0
7949	223	833	0	1	\N	0
7950	232	833	4	5	\N	80
7951	233	833	1	1	\N	20
7952	234	833	3	4	\N	60
7953	242	833	3	4	\N	60
7954	243	833	1	3	\N	10
7955	244	833	1	2	\N	20
7956	245	834	2	3	\N	40
7957	246	834	3	4	\N	60
7958	247	834	2	2	\N	40
7959	248	834	1	2	\N	20
7960	253	834	3	3	\N	60
7961	254	834	1	3	\N	10
7962	255	834	2	2	\N	40
7963	263	834	4	6	\N	70
7964	264	834	0	0	\N	0
7965	265	834	2	2	\N	40
7966	238	835	3	5	\N	50
7967	239	835	2	2	\N	40
7968	240	835	3	3	\N	60
7969	241	835	0	1	\N	0
7970	249	835	3	3	\N	60
7971	250	835	0	1	\N	0
7972	251	835	0	0	\N	0
7973	252	835	1	1	\N	20
7974	260	835	3	4	\N	60
7975	261	835	4	4	\N	90
7976	262	835	0	2	\N	-10
7977	266	836	2	3	\N	40
7978	267	836	4	4	\N	90
7979	268	836	0	2	\N	-10
7980	224	836	1	2	\N	20
7981	225	836	3	3	\N	60
7982	226	836	1	3	\N	10
7983	227	836	3	3	\N	60
7984	215	836	4	4	\N	90
7985	216	836	1	1	\N	20
7986	217	836	2	2	\N	40
7987	215	837	4	5	\N	80
7988	216	837	1	1	\N	20
7989	217	837	1	2	\N	20
7990	245	837	4	4	\N	90
7991	246	837	1	1	\N	20
7992	247	837	2	2	\N	40
7993	248	837	1	1	\N	20
7994	235	837	3	4	\N	60
7995	236	837	0	1	\N	0
7996	237	837	0	1	\N	0
7997	218	838	0	0	\N	0
7998	219	838	0	1	\N	0
7999	220	838	0	1	\N	0
8000	260	838	3	4	\N	60
8001	261	838	0	0	\N	0
8002	262	838	0	1	\N	0
8003	256	838	3	3	\N	60
8004	257	838	3	3	\N	60
8005	258	838	1	1	\N	20
8006	259	838	3	5	\N	50
8007	263	839	0	1	\N	0
8008	264	839	1	1	\N	20
8009	265	839	4	4	\N	90
8010	232	839	1	3	\N	10
8011	233	839	2	2	\N	40
8012	234	839	1	2	\N	20
8013	269	839	0	1	\N	0
8014	270	839	1	1	\N	20
8015	271	839	1	2	\N	20
8016	272	839	0	1	\N	0
8017	253	840	0	1	\N	0
8018	254	840	1	1	\N	20
8019	255	840	3	3	\N	60
8020	228	840	4	5	\N	80
8021	229	840	1	1	\N	20
8022	230	840	3	3	\N	60
8023	231	840	1	2	\N	20
8024	266	840	2	4	\N	30
8025	267	840	1	3	\N	10
8026	268	840	1	2	\N	20
8027	221	841	4	6	\N	70
8028	222	841	0	0	\N	0
8029	223	841	2	2	\N	40
8030	238	841	2	3	\N	40
8031	239	841	2	2	\N	40
8032	240	841	3	3	\N	60
8033	241	841	2	2	\N	40
8034	224	841	2	2	\N	40
8035	225	841	4	4	\N	90
8036	226	841	2	2	\N	40
8037	227	841	0	2	\N	-10
8038	249	842	4	4	\N	90
8039	250	842	4	5	\N	80
8040	251	842	2	4	\N	30
8041	252	842	4	4	\N	90
8042	242	842	4	5	\N	80
8043	243	842	2	4	\N	30
8044	244	842	0	0	\N	0
8045	221	842	0	2	\N	-10
8046	222	842	0	1	\N	0
8047	223	842	2	2	\N	40
8048	242	843	3	4	\N	60
8049	243	843	0	1	\N	0
8050	244	843	3	3	\N	60
8051	260	843	4	4	\N	90
8052	261	843	4	4	\N	90
8053	262	843	4	5	\N	80
8054	269	843	4	4	\N	90
8055	270	843	0	0	\N	0
8056	271	843	1	1	\N	20
8057	272	843	1	3	\N	10
8058	249	844	3	5	\N	50
8059	250	844	3	4	\N	60
8060	251	844	2	2	\N	40
8061	252	844	1	1	\N	20
8062	266	844	4	4	\N	90
8063	267	844	1	1	\N	20
8064	268	844	1	1	\N	20
8065	245	844	3	3	\N	60
8066	246	844	0	1	\N	0
8067	247	844	0	0	\N	0
8068	248	844	1	2	\N	20
8069	238	845	1	2	\N	20
8070	239	845	3	3	\N	60
8071	240	845	1	2	\N	20
8072	241	845	2	2	\N	40
8073	263	845	4	5	\N	80
8074	264	845	1	1	\N	20
8075	265	845	1	1	\N	20
8076	232	845	2	3	\N	40
8077	233	845	0	0	\N	0
8078	234	845	3	4	\N	60
8079	215	846	4	5	\N	80
8080	216	846	1	1	\N	20
8081	217	846	0	0	\N	0
8082	218	846	4	4	\N	90
8083	219	846	2	2	\N	40
8084	220	846	0	1	\N	0
8085	235	846	4	5	\N	80
8086	236	846	1	1	\N	20
8087	237	846	2	2	\N	40
8088	256	847	3	5	\N	50
8089	257	847	3	3	\N	60
8090	258	847	1	1	\N	20
8091	259	847	0	0	\N	0
8092	228	847	4	5	\N	80
8093	229	847	2	2	\N	40
8094	230	847	0	1	\N	0
8095	231	847	0	0	\N	0
8096	224	847	4	6	\N	70
8097	225	847	1	3	\N	10
8098	226	847	0	0	\N	0
8099	227	847	0	0	\N	0
8100	253	848	4	5	\N	80
8101	254	848	0	0	\N	0
8102	255	848	2	3	\N	40
8103	242	848	4	4	\N	90
8104	243	848	0	0	\N	0
8105	244	848	2	2	\N	40
8106	215	848	3	5	\N	50
8107	216	848	3	3	\N	60
8108	217	848	2	2	\N	40
8109	235	849	4	6	\N	70
8110	236	849	1	1	\N	20
8111	237	849	3	3	\N	60
8112	269	849	0	2	\N	-10
8113	270	849	1	1	\N	20
8114	271	849	1	1	\N	20
8115	272	849	2	3	\N	40
8116	218	849	3	3	\N	60
8117	219	849	1	1	\N	20
8118	220	849	1	1	\N	20
8119	228	850	2	3	\N	40
8120	229	850	1	2	\N	20
8121	230	850	1	3	\N	10
8122	231	850	1	3	\N	10
8123	260	850	4	5	\N	80
8124	261	850	4	4	\N	90
8125	262	850	1	1	\N	20
8126	256	850	4	4	\N	90
8127	257	850	1	3	\N	10
8128	258	850	3	3	\N	60
8129	259	850	2	2	\N	40
8130	266	851	3	5	\N	50
8131	267	851	2	3	\N	40
8132	268	851	3	3	\N	60
8133	232	851	2	3	\N	40
8134	233	851	0	0	\N	0
8135	234	851	1	1	\N	20
8136	263	851	1	3	\N	10
8137	264	851	1	1	\N	20
8138	265	851	4	4	\N	90
8139	224	852	3	4	\N	60
8140	225	852	0	0	\N	0
8141	226	852	0	0	\N	0
8142	227	852	0	2	\N	-10
8143	238	852	2	2	\N	40
8144	239	852	2	4	\N	30
8145	240	852	0	1	\N	0
8146	241	852	1	1	\N	20
8147	249	852	1	4	\N	0
8148	250	852	1	1	\N	20
8149	251	852	1	2	\N	20
8150	252	852	1	1	\N	20
8151	253	853	0	2	\N	-10
8152	254	853	2	2	\N	40
8153	255	853	3	3	\N	60
8154	221	853	3	3	\N	60
8155	222	853	0	2	\N	-10
8156	223	853	2	2	\N	40
8157	245	853	4	6	\N	70
8158	246	853	1	2	\N	20
8159	247	853	1	2	\N	20
8160	248	853	1	1	\N	20
8161	54	856	4	4	\N	90
8162	55	856	3	4	\N	60
8163	56	856	0	1	\N	0
8164	87	856	1	2	\N	20
8165	88	856	3	3	\N	60
8166	89	856	1	3	\N	10
8167	90	856	2	3	\N	40
8168	1	856	4	6	\N	70
8169	2	856	0	0	\N	0
8170	3	856	2	2	\N	40
8171	4	856	3	3	\N	60
8172	123	857	4	4	\N	90
8173	124	857	4	4	\N	90
8174	125	857	1	1	\N	20
8175	126	857	0	0	\N	0
8176	5	857	3	6	\N	40
8177	6	857	0	1	\N	0
8178	7	857	0	0	\N	0
8179	13	857	3	4	\N	60
8180	14	857	0	2	\N	-10
8181	15	857	2	2	\N	40
8182	16	857	1	1	\N	20
8183	61	858	3	5	\N	50
8184	62	858	0	1	\N	0
8185	63	858	1	1	\N	20
8186	57	858	4	4	\N	90
8187	58	858	0	2	\N	-10
8188	59	858	1	3	\N	10
8189	60	858	4	4	\N	90
8190	17	858	3	4	\N	60
8191	18	858	0	0	\N	0
8192	19	858	1	2	\N	20
8193	8	859	2	5	\N	20
8194	9	859	0	0	\N	0
8195	10	859	2	3	\N	40
8196	11	859	0	0	\N	0
8197	12	859	2	4	\N	30
8198	35	859	4	5	\N	80
8199	36	859	4	5	\N	80
8200	37	859	0	0	\N	0
8201	38	859	0	0	\N	0
8202	64	859	2	5	\N	20
8203	65	859	1	1	\N	20
8204	66	859	0	0	\N	0
8205	67	859	0	0	\N	0
8206	68	859	0	0	\N	0
8207	83	860	2	2	\N	40
8208	84	860	3	4	\N	60
8209	85	860	0	0	\N	0
8210	86	860	0	0	\N	0
8211	114	860	3	4	\N	60
8212	115	860	2	3	\N	40
8213	116	860	1	1	\N	20
8214	117	860	3	3	\N	60
8215	76	860	4	4	\N	90
8216	77	860	0	2	\N	-10
8217	78	860	1	1	\N	20
8218	73	861	2	2	\N	40
8219	74	861	0	2	\N	-10
8220	75	861	0	0	\N	0
8221	127	861	0	1	\N	0
8222	128	861	0	0	\N	0
8223	129	861	1	1	\N	20
8224	130	861	4	4	\N	90
8225	99	861	0	3	\N	-20
8226	100	861	2	2	\N	40
8227	101	861	4	5	\N	80
8228	102	861	1	1	\N	20
8229	39	862	1	1	\N	20
8230	40	862	1	1	\N	20
8231	41	862	2	3	\N	40
8232	91	862	0	0	\N	0
8233	92	862	1	1	\N	20
8234	93	862	2	2	\N	40
8235	94	862	0	0	\N	0
8236	27	862	4	4	\N	90
8237	28	862	0	1	\N	0
8238	29	862	2	2	\N	40
8239	30	862	0	0	\N	0
8240	31	862	0	0	\N	0
8241	69	863	3	4	\N	60
8242	70	863	1	1	\N	20
8243	71	863	3	4	\N	60
8244	72	863	0	2	\N	-10
8245	79	863	2	5	\N	20
8246	80	863	2	2	\N	40
8247	81	863	0	0	\N	0
8248	82	863	1	1	\N	20
8249	103	863	0	2	\N	-10
8250	104	863	1	1	\N	20
8251	105	863	0	0	\N	0
8252	32	864	3	3	\N	60
8253	33	864	0	1	\N	0
8254	34	864	0	0	\N	0
8255	95	864	4	4	\N	90
8256	96	864	4	5	\N	80
8257	97	864	0	0	\N	0
8258	98	864	0	0	\N	0
8259	42	864	1	2	\N	20
8260	43	864	0	2	\N	-10
8261	44	864	0	1	\N	0
8262	45	864	0	2	\N	-10
8263	46	865	0	2	\N	-10
8264	47	865	3	5	\N	50
8265	48	865	0	0	\N	0
8266	49	865	0	1	\N	0
8267	20	865	4	5	\N	80
8268	21	865	1	1	\N	20
8269	22	865	4	5	\N	80
8270	50	865	3	4	\N	60
8271	51	865	3	5	\N	50
8272	52	865	0	1	\N	0
8273	53	865	2	3	\N	40
8274	110	866	4	6	\N	70
8275	111	866	2	2	\N	40
8276	112	866	1	1	\N	20
8277	113	866	4	4	\N	90
8278	118	866	3	4	\N	60
8279	119	866	0	1	\N	0
8280	120	866	1	1	\N	20
8281	121	866	1	1	\N	20
8282	122	866	0	0	\N	0
8283	106	866	4	4	\N	90
8284	107	866	1	2	\N	20
8285	108	866	0	2	\N	-10
8286	109	866	3	3	\N	60
8287	23	867	3	4	\N	60
8288	24	867	3	5	\N	50
8289	25	867	4	5	\N	80
8290	26	867	1	1	\N	20
8291	57	867	4	5	\N	80
8292	58	867	2	2	\N	40
8293	59	867	0	2	\N	-10
8294	60	867	2	2	\N	40
8295	50	867	3	3	\N	60
8296	51	867	0	1	\N	0
8297	52	867	2	4	\N	30
8298	53	867	2	2	\N	40
8299	73	868	1	3	\N	10
8300	74	868	0	1	\N	0
8301	75	868	1	1	\N	20
8302	103	868	3	5	\N	50
8303	104	868	0	0	\N	0
8304	105	868	0	1	\N	0
8305	17	868	4	4	\N	90
8306	18	868	2	2	\N	40
8307	19	868	1	1	\N	20
8308	13	869	4	6	\N	70
8309	14	869	1	2	\N	20
8310	15	869	1	2	\N	20
8311	16	869	2	3	\N	40
8312	32	869	3	5	\N	50
8313	33	869	4	5	\N	80
8314	34	869	1	3	\N	10
8315	87	869	3	4	\N	60
8316	88	869	1	2	\N	20
8317	89	869	1	1	\N	20
8318	90	869	1	1	\N	20
8319	106	870	2	4	\N	30
8320	107	870	1	1	\N	20
8321	108	870	0	1	\N	0
8322	109	870	0	2	\N	-10
8323	27	870	4	4	\N	90
8324	28	870	2	4	\N	30
8325	29	870	1	1	\N	20
8326	30	870	4	6	\N	70
8327	31	870	2	2	\N	40
8328	83	870	4	5	\N	80
8329	84	870	4	4	\N	90
8330	85	870	1	1	\N	20
8331	86	870	2	2	\N	40
8332	69	871	4	5	\N	80
8333	70	871	0	1	\N	0
8334	71	871	2	3	\N	40
8335	72	871	1	2	\N	20
8336	79	871	4	5	\N	80
8337	80	871	4	4	\N	90
8338	81	871	4	6	\N	70
8339	82	871	0	1	\N	0
8340	127	871	4	4	\N	90
8341	128	871	1	1	\N	20
8342	129	871	0	0	\N	0
8343	130	871	2	2	\N	40
8344	23	872	4	4	\N	90
8345	24	872	3	4	\N	60
8346	25	872	0	1	\N	0
8347	26	872	1	2	\N	20
8348	35	872	4	6	\N	70
8349	36	872	2	3	\N	40
8350	37	872	4	4	\N	90
8351	38	872	3	3	\N	60
8352	118	872	4	4	\N	90
8353	119	872	0	1	\N	0
8354	120	872	1	1	\N	20
8355	121	872	0	0	\N	0
8356	122	872	3	4	\N	60
8357	5	873	4	5	\N	80
8358	6	873	3	4	\N	60
8359	7	873	1	1	\N	20
8360	76	873	2	2	\N	40
8361	77	873	1	3	\N	10
8362	78	873	1	1	\N	20
8363	1	873	3	5	\N	50
8364	2	873	1	1	\N	20
8365	3	873	1	2	\N	20
8366	4	873	3	3	\N	60
8367	61	874	2	2	\N	40
8368	62	874	1	3	\N	10
8369	63	874	4	5	\N	80
8370	91	874	3	4	\N	60
8371	92	874	1	3	\N	10
8372	93	874	4	4	\N	90
8373	94	874	3	3	\N	60
8374	46	874	2	3	\N	40
8375	47	874	1	2	\N	20
8376	48	874	1	1	\N	20
8377	49	874	2	4	\N	30
8378	95	875	2	4	\N	30
8379	96	875	2	4	\N	30
8380	97	875	1	1	\N	20
8381	98	875	4	4	\N	90
8382	8	875	4	5	\N	80
8383	9	875	1	2	\N	20
8384	10	875	3	4	\N	60
8385	11	875	0	0	\N	0
8386	12	875	3	5	\N	50
8387	20	875	3	6	\N	40
8388	21	875	4	6	\N	70
8389	22	875	3	3	\N	60
8390	54	876	2	2	\N	40
8391	55	876	1	2	\N	20
8392	56	876	4	4	\N	90
8393	42	876	2	3	\N	40
8394	43	876	1	1	\N	20
8395	44	876	0	1	\N	0
8396	45	876	1	1	\N	20
8397	39	876	3	3	\N	60
8398	40	876	1	1	\N	20
8399	41	876	0	0	\N	0
8400	64	877	3	5	\N	50
8401	65	877	0	0	\N	0
8402	66	877	4	4	\N	90
8403	67	877	1	1	\N	20
8404	68	877	0	0	\N	0
8405	114	877	4	4	\N	90
8406	115	877	3	3	\N	60
8407	116	877	1	3	\N	10
8408	117	877	3	4	\N	60
8409	99	877	3	6	\N	40
8410	100	877	1	3	\N	10
8411	101	877	2	2	\N	40
8412	102	877	1	1	\N	20
8413	110	878	4	6	\N	70
8414	111	878	0	0	\N	0
8415	112	878	1	3	\N	10
8416	113	878	3	4	\N	60
8417	123	878	4	4	\N	90
8418	124	878	0	0	\N	0
8419	125	878	0	1	\N	0
8420	126	878	4	4	\N	90
8421	20	878	4	5	\N	80
8422	21	878	1	3	\N	10
8423	22	878	3	3	\N	60
8424	76	879	2	4	\N	30
8425	77	879	3	4	\N	60
8426	78	879	3	4	\N	60
8427	39	879	4	5	\N	80
8428	40	879	1	3	\N	10
8429	41	879	2	2	\N	40
8430	5	879	4	4	\N	90
8431	6	879	2	2	\N	40
8432	7	879	4	4	\N	90
8433	95	880	4	4	\N	90
8434	96	880	1	1	\N	20
8435	97	880	0	0	\N	0
8436	98	880	4	5	\N	80
8437	79	880	4	5	\N	80
8438	80	880	0	0	\N	0
8439	81	880	0	1	\N	0
8440	82	880	3	3	\N	60
8441	61	880	2	2	\N	40
8442	62	880	0	0	\N	0
8443	63	880	0	0	\N	0
8444	118	881	4	4	\N	90
8445	119	881	0	2	\N	-10
8446	120	881	0	1	\N	0
8447	121	881	2	3	\N	40
8448	122	881	0	1	\N	0
8449	87	881	1	1	\N	20
8450	88	881	1	1	\N	20
8451	89	881	2	2	\N	40
8452	90	881	0	0	\N	0
8453	42	881	3	5	\N	50
8454	43	881	1	1	\N	20
8455	44	881	1	1	\N	20
8456	45	881	0	0	\N	0
8457	35	882	3	3	\N	60
8458	36	882	3	4	\N	60
8459	37	882	1	1	\N	20
8460	38	882	4	4	\N	90
8461	110	882	4	5	\N	80
8462	111	882	4	5	\N	80
8463	112	882	0	0	\N	0
8464	113	882	0	0	\N	0
8465	17	882	0	2	\N	-10
8466	18	882	0	0	\N	0
8467	19	882	1	1	\N	20
8468	27	883	3	4	\N	60
8469	28	883	2	4	\N	30
8470	29	883	2	3	\N	40
8471	30	883	1	2	\N	20
8472	31	883	0	1	\N	0
8473	127	883	3	3	\N	60
8474	128	883	2	4	\N	30
8475	129	883	1	1	\N	20
8476	130	883	4	4	\N	90
8477	123	883	3	4	\N	60
8478	124	883	4	4	\N	90
8479	125	883	0	1	\N	0
8480	126	883	1	1	\N	20
8481	13	884	3	6	\N	40
8482	14	884	0	0	\N	0
8483	15	884	1	1	\N	20
8484	16	884	3	3	\N	60
8485	46	884	1	2	\N	20
8486	47	884	2	3	\N	40
8487	48	884	0	1	\N	0
8488	49	884	1	2	\N	20
8489	103	884	4	4	\N	90
8490	104	884	1	1	\N	20
8491	105	884	1	1	\N	20
8492	91	885	4	4	\N	90
8493	92	885	1	1	\N	20
8494	93	885	3	3	\N	60
8495	94	885	3	4	\N	60
8496	8	885	3	3	\N	60
8497	9	885	4	5	\N	80
8498	10	885	0	1	\N	0
8499	11	885	3	3	\N	60
8500	12	885	2	2	\N	40
8501	57	885	3	3	\N	60
8502	58	885	2	2	\N	40
8503	59	885	0	0	\N	0
8504	60	885	3	3	\N	60
8505	32	886	4	5	\N	80
8506	33	886	0	0	\N	0
8507	34	886	0	1	\N	0
8508	1	886	3	4	\N	60
8509	2	886	3	3	\N	60
8510	3	886	1	2	\N	20
8511	4	886	2	4	\N	30
8512	50	886	4	5	\N	80
8513	51	886	1	1	\N	20
8514	52	886	0	0	\N	0
8515	53	886	0	2	\N	-10
8516	83	887	4	6	\N	70
8517	84	887	2	2	\N	40
8518	85	887	1	1	\N	20
8519	86	887	1	2	\N	20
8520	69	887	4	4	\N	90
8521	70	887	1	1	\N	20
8522	71	887	0	0	\N	0
8523	72	887	0	0	\N	0
8524	54	887	3	5	\N	50
8525	55	887	4	4	\N	90
8526	56	887	3	3	\N	60
8527	23	888	4	5	\N	80
8528	24	888	1	1	\N	20
8529	25	888	3	3	\N	60
8530	26	888	2	2	\N	40
8531	99	888	3	5	\N	50
8532	100	888	1	1	\N	20
8533	101	888	0	0	\N	0
8534	102	888	1	2	\N	20
8535	73	888	3	6	\N	40
8536	74	888	0	0	\N	0
8537	75	888	3	4	\N	60
8538	64	889	2	3	\N	40
8539	65	889	2	2	\N	40
8540	66	889	1	1	\N	20
8541	67	889	1	3	\N	10
8542	68	889	1	1	\N	20
8543	114	889	4	5	\N	80
8544	115	889	0	1	\N	0
8545	116	889	2	2	\N	40
8546	117	889	0	2	\N	-10
8547	106	889	2	3	\N	40
8548	107	889	0	2	\N	-10
8549	108	889	3	3	\N	60
8550	109	889	0	2	\N	-10
8551	57	890	4	4	\N	90
8552	58	890	2	2	\N	40
8553	59	890	0	1	\N	0
8554	60	890	1	1	\N	20
8555	27	890	0	2	\N	-10
8556	28	890	1	2	\N	20
8557	29	890	1	2	\N	20
8558	30	890	1	1	\N	20
8559	31	890	4	4	\N	90
8560	103	890	2	4	\N	30
8561	104	890	2	2	\N	40
8562	105	890	4	5	\N	80
8563	118	891	3	4	\N	60
8564	119	891	1	2	\N	20
8565	120	891	0	0	\N	0
8566	121	891	3	4	\N	60
8567	122	891	3	4	\N	60
8568	73	891	4	4	\N	90
8569	74	891	1	2	\N	20
8570	75	891	3	3	\N	60
8571	23	891	0	1	\N	0
8572	24	891	3	3	\N	60
8573	25	891	0	0	\N	0
8574	26	891	0	1	\N	0
8575	64	892	1	2	\N	20
8576	65	892	1	1	\N	20
8577	66	892	2	4	\N	30
8578	67	892	1	2	\N	20
8579	68	892	0	0	\N	0
8580	123	892	4	4	\N	90
8581	124	892	0	0	\N	0
8582	125	892	2	4	\N	30
8583	126	892	2	2	\N	40
8584	1	892	1	1	\N	20
8585	2	892	0	1	\N	0
8586	3	892	0	0	\N	0
8587	4	892	0	0	\N	0
8588	79	893	3	4	\N	60
8589	80	893	4	4	\N	90
8590	81	893	1	2	\N	20
8591	82	893	1	2	\N	20
8592	46	893	2	3	\N	40
8593	47	893	1	3	\N	10
8594	48	893	1	2	\N	20
8595	49	893	4	4	\N	90
8596	99	893	4	4	\N	90
8597	100	893	0	1	\N	0
8598	101	893	1	1	\N	20
8599	102	893	3	3	\N	60
8600	114	894	4	5	\N	80
8601	115	894	1	1	\N	20
8602	116	894	0	0	\N	0
8603	117	894	1	3	\N	10
8604	76	894	0	1	\N	0
8605	77	894	0	2	\N	-10
8606	78	894	0	0	\N	0
8607	39	894	4	4	\N	90
8608	40	894	1	1	\N	20
8609	41	894	0	1	\N	0
8610	8	895	1	3	\N	10
8611	9	895	2	3	\N	40
8612	10	895	1	1	\N	20
8613	11	895	2	3	\N	40
8614	12	895	2	3	\N	40
8615	13	895	4	4	\N	90
8616	14	895	1	1	\N	20
8617	15	895	0	0	\N	0
8618	16	895	2	2	\N	40
8619	50	895	4	5	\N	80
8620	51	895	3	3	\N	60
8621	52	895	1	1	\N	20
8622	53	895	0	2	\N	-10
8623	110	896	0	2	\N	-10
8624	111	896	1	2	\N	20
8625	112	896	0	0	\N	0
8626	113	896	4	4	\N	90
8627	35	896	1	3	\N	10
8628	36	896	1	2	\N	20
8629	37	896	1	1	\N	20
8630	38	896	1	3	\N	10
8631	127	896	1	4	\N	0
8632	128	896	3	3	\N	60
8633	129	896	0	0	\N	0
8634	130	896	4	5	\N	80
8635	5	897	4	5	\N	80
8636	6	897	4	4	\N	90
8637	7	897	4	4	\N	90
8638	20	897	2	4	\N	30
8639	21	897	0	1	\N	0
8640	22	897	2	2	\N	40
8641	91	897	4	5	\N	80
8642	92	897	1	2	\N	20
8643	93	897	0	0	\N	0
8644	94	897	2	2	\N	40
8645	54	898	4	6	\N	70
8646	55	898	0	0	\N	0
8647	56	898	1	1	\N	20
8648	106	898	3	6	\N	40
8649	107	898	2	3	\N	40
8650	108	898	3	4	\N	60
8651	109	898	2	2	\N	40
8652	69	898	2	2	\N	40
8653	70	898	3	5	\N	50
8654	71	898	1	2	\N	20
8655	72	898	0	1	\N	0
8656	87	899	1	2	\N	20
8657	88	899	1	1	\N	20
8658	89	899	1	2	\N	20
8659	90	899	4	4	\N	90
8660	83	899	3	3	\N	60
8661	84	899	4	4	\N	90
8662	85	899	2	4	\N	30
8663	86	899	3	3	\N	60
8664	17	899	4	5	\N	80
8665	18	899	1	2	\N	20
8666	19	899	1	2	\N	20
8667	61	900	3	3	\N	60
8668	62	900	2	2	\N	40
8669	63	900	3	3	\N	60
8670	95	900	3	3	\N	60
8671	96	900	1	1	\N	20
8672	97	900	1	1	\N	20
8673	98	900	1	3	\N	10
8674	32	900	3	4	\N	60
8675	33	900	0	0	\N	0
8676	34	900	1	1	\N	20
8677	42	901	0	2	\N	-10
8678	43	901	3	5	\N	50
8679	44	901	2	4	\N	30
8680	45	901	1	1	\N	20
8681	73	901	3	4	\N	60
8682	74	901	1	1	\N	20
8683	75	901	0	1	\N	0
8684	64	901	3	4	\N	60
8685	65	901	2	2	\N	40
8686	66	901	0	1	\N	0
8687	67	901	0	0	\N	0
8688	68	901	0	1	\N	0
8689	83	902	3	4	\N	60
8690	84	902	2	3	\N	40
8691	85	902	1	1	\N	20
8692	86	902	1	1	\N	20
8693	69	902	4	4	\N	90
8694	70	902	1	2	\N	20
8695	71	902	0	1	\N	0
8696	72	902	2	2	\N	40
8697	50	902	4	4	\N	90
8698	51	902	1	2	\N	20
8699	52	902	2	2	\N	40
8700	53	902	1	3	\N	10
8701	27	903	4	5	\N	80
8702	28	903	2	3	\N	40
8703	29	903	0	0	\N	0
8704	30	903	1	2	\N	20
8705	31	903	0	2	\N	-10
8706	17	903	2	2	\N	40
8707	18	903	2	2	\N	40
8708	19	903	1	2	\N	20
8709	13	903	4	4	\N	90
8710	14	903	1	1	\N	20
8711	15	903	0	0	\N	0
8712	16	903	2	3	\N	40
8713	46	904	3	6	\N	40
8714	47	904	3	3	\N	60
8715	48	904	4	5	\N	80
8716	49	904	0	0	\N	0
8717	42	904	4	5	\N	80
8718	43	904	4	6	\N	70
8719	44	904	3	3	\N	60
8720	45	904	1	1	\N	20
8721	106	904	4	5	\N	80
8722	107	904	2	3	\N	40
8723	108	904	0	2	\N	-10
8724	109	904	1	2	\N	20
8725	8	905	4	4	\N	90
8726	9	905	0	0	\N	0
8727	10	905	3	3	\N	60
8728	11	905	1	1	\N	20
8729	12	905	2	3	\N	40
8730	103	905	3	3	\N	60
8731	104	905	1	1	\N	20
8732	105	905	1	1	\N	20
8733	95	905	1	2	\N	20
8734	96	905	2	3	\N	40
8735	97	905	0	0	\N	0
8736	98	905	4	4	\N	90
8737	23	906	1	1	\N	20
8738	24	906	2	2	\N	40
8739	25	906	2	3	\N	40
8740	26	906	1	1	\N	20
8741	110	906	1	4	\N	0
8742	111	906	0	0	\N	0
8743	112	906	0	0	\N	0
8744	113	906	1	1	\N	20
8745	61	906	2	3	\N	40
8746	62	906	2	2	\N	40
8747	63	906	1	2	\N	20
8748	79	907	3	4	\N	60
8749	80	907	2	3	\N	40
8750	81	907	1	2	\N	20
8751	82	907	0	1	\N	0
8752	54	907	3	3	\N	60
8753	55	907	3	4	\N	60
8754	56	907	1	2	\N	20
8755	118	907	3	4	\N	60
8756	119	907	0	0	\N	0
8757	120	907	2	2	\N	40
8758	121	907	0	0	\N	0
8759	122	907	0	2	\N	-10
8760	39	908	4	6	\N	70
8761	40	908	0	0	\N	0
8762	41	908	1	1	\N	20
8763	32	908	2	3	\N	40
8764	33	908	2	2	\N	40
8765	34	908	0	1	\N	0
8766	35	908	2	3	\N	40
8767	36	908	1	1	\N	20
8768	37	908	3	4	\N	60
8769	38	908	1	1	\N	20
8770	57	909	4	5	\N	80
8771	58	909	3	3	\N	60
8772	59	909	4	5	\N	80
8773	60	909	0	0	\N	0
8774	123	909	4	5	\N	80
8775	124	909	0	0	\N	0
8776	125	909	0	0	\N	0
8777	126	909	2	3	\N	40
8778	5	909	4	5	\N	80
8779	6	909	0	0	\N	0
8780	7	909	2	2	\N	40
8781	87	910	1	3	\N	10
8782	88	910	1	1	\N	20
8783	89	910	1	1	\N	20
8784	90	910	1	1	\N	20
8785	76	910	1	1	\N	20
8786	77	910	1	3	\N	10
8787	78	910	2	4	\N	30
8788	114	910	1	2	\N	20
8789	115	910	3	3	\N	60
8790	116	910	2	3	\N	40
8791	117	910	1	2	\N	20
8792	99	911	2	4	\N	30
8793	100	911	0	1	\N	0
8794	101	911	1	2	\N	20
8795	102	911	1	1	\N	20
8796	127	911	2	4	\N	30
8797	128	911	0	0	\N	0
8798	129	911	2	3	\N	40
8799	130	911	0	0	\N	0
8800	1	911	2	4	\N	30
8801	2	911	1	1	\N	20
8802	3	911	0	0	\N	0
8803	4	911	2	3	\N	40
8804	91	912	3	4	\N	60
8805	92	912	0	0	\N	0
8806	93	912	2	2	\N	40
8807	94	912	0	0	\N	0
8808	20	912	4	4	\N	90
8809	21	912	1	1	\N	20
8810	22	912	3	3	\N	60
8811	87	912	1	4	\N	0
8812	88	912	2	3	\N	40
8813	89	912	1	1	\N	20
8814	90	912	0	2	\N	-10
8815	17	913	4	5	\N	80
8816	18	913	1	3	\N	10
8817	19	913	1	1	\N	20
8818	110	913	4	4	\N	90
8819	111	913	4	4	\N	90
8820	112	913	2	3	\N	40
8821	113	913	0	2	\N	-10
8822	73	913	3	5	\N	50
8823	74	913	0	2	\N	-10
8824	75	913	1	2	\N	20
8825	23	914	4	4	\N	90
8826	24	914	0	0	\N	0
8827	25	914	4	5	\N	80
8828	26	914	4	5	\N	80
8829	114	914	2	3	\N	40
8830	115	914	3	3	\N	60
8831	116	914	2	2	\N	40
8832	117	914	1	3	\N	10
8833	103	914	2	3	\N	40
8834	104	914	1	1	\N	20
8835	105	914	1	2	\N	20
8836	35	915	4	6	\N	70
8837	36	915	1	1	\N	20
8838	37	915	2	4	\N	30
8839	38	915	0	1	\N	0
8840	127	915	4	4	\N	90
8841	128	915	4	4	\N	90
8842	129	915	1	1	\N	20
8843	130	915	1	2	\N	20
8844	123	915	0	1	\N	0
8845	124	915	4	5	\N	80
8846	125	915	2	2	\N	40
8847	126	915	1	2	\N	20
8848	54	916	1	1	\N	20
8849	55	916	1	2	\N	20
8850	56	916	2	3	\N	40
8851	20	916	3	4	\N	60
8852	21	916	2	2	\N	40
8853	22	916	2	3	\N	40
8854	61	916	4	4	\N	90
8855	62	916	0	0	\N	0
8856	63	916	2	3	\N	40
8857	27	917	3	4	\N	60
8858	28	917	3	3	\N	60
8859	29	917	0	0	\N	0
8860	30	917	2	3	\N	40
8861	31	917	0	0	\N	0
8862	106	917	4	5	\N	80
8863	107	917	0	0	\N	0
8864	108	917	2	2	\N	40
8865	109	917	0	0	\N	0
8866	1	917	4	5	\N	80
8867	2	917	3	3	\N	60
8868	3	917	2	2	\N	40
8869	4	917	0	1	\N	0
8870	79	918	4	4	\N	90
8871	80	918	4	5	\N	80
8872	81	918	2	2	\N	40
8873	82	918	2	2	\N	40
8874	8	918	0	1	\N	0
8875	9	918	0	0	\N	0
8876	10	918	0	0	\N	0
8877	11	918	2	4	\N	30
8878	12	918	4	4	\N	90
8879	99	918	4	4	\N	90
8880	100	918	0	0	\N	0
8881	101	918	3	4	\N	60
8882	102	918	0	0	\N	0
8883	39	919	4	4	\N	90
8884	40	919	1	1	\N	20
8885	41	919	2	3	\N	40
8886	118	919	4	4	\N	90
8887	119	919	0	1	\N	0
8888	120	919	0	1	\N	0
8889	121	919	1	1	\N	20
8890	122	919	1	3	\N	10
8891	32	919	4	5	\N	80
8892	33	919	1	2	\N	20
8893	34	919	0	0	\N	0
8894	57	920	4	4	\N	90
8895	58	920	1	1	\N	20
8896	59	920	2	2	\N	40
8897	60	920	0	0	\N	0
8898	5	920	4	4	\N	90
8899	6	920	0	0	\N	0
8900	7	920	2	3	\N	40
8901	91	920	4	6	\N	70
8902	92	920	2	3	\N	40
8903	93	920	1	2	\N	20
8904	94	920	4	4	\N	90
8905	76	921	3	6	\N	40
8906	77	921	3	3	\N	60
8907	78	921	2	2	\N	40
8908	50	921	4	4	\N	90
8909	51	921	2	2	\N	40
8910	52	921	1	1	\N	20
8911	53	921	0	0	\N	0
8912	42	921	0	1	\N	0
8913	43	921	1	2	\N	20
8914	44	921	4	6	\N	70
8915	45	921	0	0	\N	0
8916	69	922	3	4	\N	60
8917	70	922	1	1	\N	20
8918	71	922	1	1	\N	20
8919	72	922	0	1	\N	0
8920	46	922	4	6	\N	70
8921	47	922	2	2	\N	40
8922	48	922	1	2	\N	20
8923	49	922	1	1	\N	20
8924	83	922	1	1	\N	20
8925	84	922	2	3	\N	40
8926	85	922	0	0	\N	0
8927	86	922	1	1	\N	20
8928	13	923	4	4	\N	90
8929	14	923	0	0	\N	0
8930	15	923	0	1	\N	0
8931	16	923	2	4	\N	30
8932	95	923	0	1	\N	0
8933	96	923	1	2	\N	20
8934	97	923	1	3	\N	10
8935	98	923	0	0	\N	0
8936	64	923	2	3	\N	40
8937	65	923	4	4	\N	90
8938	66	923	1	1	\N	20
8939	67	923	1	1	\N	20
8940	68	923	0	0	\N	0
8941	144	928	0	1	\N	0
8942	145	928	0	0	\N	0
8943	204	928	3	4	\N	60
8944	205	928	0	0	\N	0
8945	206	928	2	4	\N	30
8946	202	928	3	6	\N	40
8947	203	928	1	1	\N	20
8948	180	929	4	5	\N	80
8949	181	929	3	4	\N	60
8950	195	929	4	4	\N	90
8951	196	929	1	2	\N	20
8952	197	929	0	0	\N	0
8953	167	929	3	4	\N	60
8954	168	929	2	2	\N	40
8955	176	930	4	4	\N	90
8956	177	930	1	1	\N	20
8957	178	930	1	2	\N	20
8958	179	930	3	5	\N	50
8959	171	930	0	0	\N	0
8960	172	930	0	0	\N	0
8961	173	930	1	1	\N	20
8962	155	930	4	4	\N	90
8963	156	930	0	0	\N	0
8964	157	930	0	0	\N	0
8965	134	931	4	5	\N	80
8966	135	931	1	2	\N	20
8967	136	931	2	2	\N	40
8968	137	931	1	1	\N	20
8969	131	931	3	4	\N	60
8970	132	931	1	1	\N	20
8971	133	931	2	3	\N	40
8972	152	931	1	1	\N	20
8973	153	931	2	2	\N	40
8974	154	931	1	1	\N	20
8975	138	932	2	2	\N	40
8976	182	932	3	3	\N	60
8977	183	932	1	3	\N	10
8978	212	932	2	3	\N	40
8979	213	932	1	1	\N	20
8980	214	932	3	3	\N	60
8981	158	933	3	4	\N	60
8982	159	933	2	2	\N	40
8983	160	933	2	3	\N	40
8984	174	933	3	5	\N	50
8985	175	933	0	0	\N	0
8986	184	933	3	4	\N	60
8987	185	933	1	2	\N	20
8988	190	934	3	4	\N	60
8989	191	934	0	0	\N	0
8990	192	934	0	1	\N	0
8991	149	934	1	2	\N	20
8992	150	934	2	2	\N	40
8993	151	934	0	0	\N	0
8994	161	934	1	1	\N	20
8995	162	934	2	2	\N	40
8996	163	934	0	2	\N	-10
8997	139	935	4	4	\N	90
8998	140	935	2	2	\N	40
8999	193	935	0	2	\N	-10
9000	194	935	2	2	\N	40
9001	164	935	4	4	\N	90
9002	165	935	2	3	\N	40
9003	166	935	2	2	\N	40
9004	146	936	0	1	\N	0
9005	147	936	2	2	\N	40
9006	148	936	3	3	\N	60
9007	186	936	3	4	\N	60
9008	187	936	2	3	\N	40
9009	188	936	0	0	\N	0
9010	189	936	1	2	\N	20
9011	198	936	3	4	\N	60
9012	199	936	1	1	\N	20
9013	200	936	3	3	\N	60
9014	201	936	4	4	\N	90
9015	169	937	4	4	\N	90
9016	170	937	3	5	\N	50
9017	207	937	4	4	\N	90
9018	208	937	1	1	\N	20
9019	209	937	1	3	\N	10
9020	210	937	3	4	\N	60
9021	211	937	3	4	\N	60
9022	141	938	0	0	\N	0
9023	142	938	2	2	\N	40
9024	143	938	1	1	\N	20
9025	212	938	3	4	\N	60
9026	213	938	0	0	\N	0
9027	214	938	2	2	\N	40
9028	152	938	4	4	\N	90
9029	153	938	3	3	\N	60
9030	154	938	1	3	\N	10
9031	138	939	4	4	\N	90
9032	134	939	4	4	\N	90
9033	135	939	0	0	\N	0
9034	136	939	1	3	\N	10
9035	137	939	1	1	\N	20
9036	144	939	4	5	\N	80
9037	145	939	0	0	\N	0
9038	169	940	3	5	\N	50
9039	170	940	1	1	\N	20
9040	193	940	4	5	\N	80
9041	194	940	3	3	\N	60
9042	174	940	3	6	\N	40
9043	175	940	1	2	\N	20
9044	161	941	3	6	\N	40
9045	162	941	1	1	\N	20
9046	163	941	2	2	\N	40
9047	198	941	3	5	\N	50
9048	199	941	4	4	\N	90
9049	200	941	3	3	\N	60
9050	201	941	2	4	\N	30
9051	180	941	4	4	\N	90
9052	181	941	0	0	\N	0
9053	171	942	4	4	\N	90
9054	172	942	4	4	\N	90
9055	173	942	0	2	\N	-10
9056	186	942	3	4	\N	60
9057	187	942	0	0	\N	0
9058	188	942	2	3	\N	40
9059	189	942	1	2	\N	20
9060	202	942	3	4	\N	60
9061	203	942	0	1	\N	0
9062	155	943	0	2	\N	-10
9063	156	943	0	0	\N	0
9064	157	943	1	1	\N	20
9065	184	943	2	3	\N	40
9066	185	943	1	3	\N	10
9067	195	943	0	2	\N	-10
9068	196	943	0	0	\N	0
9069	197	943	0	2	\N	-10
9070	182	944	3	4	\N	60
9071	183	944	0	0	\N	0
9072	167	944	4	4	\N	90
9073	168	944	3	4	\N	60
9074	164	944	4	5	\N	80
9075	165	944	1	1	\N	20
9076	166	944	0	1	\N	0
9077	146	945	3	4	\N	60
9078	147	945	0	0	\N	0
9079	148	945	0	0	\N	0
9080	131	945	4	6	\N	70
9081	132	945	1	1	\N	20
9082	133	945	0	0	\N	0
9083	158	945	4	5	\N	80
9084	159	945	0	0	\N	0
9085	160	945	0	0	\N	0
9086	176	946	1	1	\N	20
9087	177	946	0	1	\N	0
9088	178	946	2	3	\N	40
9089	179	946	1	1	\N	20
9090	209	946	0	2	\N	-10
9091	210	946	2	3	\N	40
9092	211	946	1	1	\N	20
9093	139	946	3	5	\N	50
9094	140	946	2	4	\N	30
9095	204	947	0	1	\N	0
9096	205	947	2	3	\N	40
9097	206	947	1	1	\N	20
9098	149	947	4	4	\N	90
9099	150	947	2	4	\N	30
9100	151	947	2	3	\N	40
9101	207	947	1	2	\N	20
9102	208	947	3	4	\N	60
9103	141	948	4	4	\N	90
9104	142	948	1	1	\N	20
9105	143	948	3	3	\N	60
9106	190	948	4	4	\N	90
9107	191	948	2	3	\N	40
9108	192	948	0	0	\N	0
9109	182	948	4	4	\N	90
9110	183	948	3	3	\N	60
9111	190	949	3	3	\N	60
9112	191	949	4	4	\N	90
9113	192	949	1	1	\N	20
9114	209	949	3	4	\N	60
9115	210	949	2	2	\N	40
9116	211	949	0	0	\N	0
9117	144	949	0	3	\N	-20
9118	145	949	2	3	\N	40
9119	158	950	3	4	\N	60
9120	159	950	3	3	\N	60
9121	160	950	2	2	\N	40
9122	204	950	3	3	\N	60
9123	205	950	3	3	\N	60
9124	206	950	1	3	\N	10
9125	134	950	4	4	\N	90
9126	135	950	0	0	\N	0
9127	136	950	4	4	\N	90
9128	137	950	1	1	\N	20
9129	212	951	0	0	\N	0
9130	213	951	0	0	\N	0
9131	214	951	0	0	\N	0
9132	141	951	4	6	\N	70
9133	142	951	1	2	\N	20
9134	143	951	3	3	\N	60
9135	193	951	3	4	\N	60
9136	194	951	0	0	\N	0
9137	169	952	2	3	\N	40
9138	170	952	4	4	\N	90
9139	155	952	3	5	\N	50
9140	156	952	3	3	\N	60
9141	157	952	2	3	\N	40
9142	149	952	0	1	\N	0
9143	150	952	0	0	\N	0
9144	151	952	2	2	\N	40
9145	198	953	2	5	\N	20
9146	199	953	0	0	\N	0
9147	200	953	3	3	\N	60
9148	201	953	0	1	\N	0
9149	139	953	4	5	\N	80
9150	140	953	1	1	\N	20
9151	184	953	2	3	\N	40
9152	185	953	1	1	\N	20
9153	186	954	3	5	\N	50
9154	187	954	4	4	\N	90
9155	188	954	2	3	\N	40
9156	189	954	2	4	\N	30
9157	146	954	4	4	\N	90
9158	147	954	0	0	\N	0
9159	148	954	1	3	\N	10
9160	138	954	0	1	\N	0
9161	202	955	4	6	\N	70
9162	203	955	0	0	\N	0
9163	152	955	3	4	\N	60
9164	153	955	0	0	\N	0
9165	154	955	4	4	\N	90
9166	164	955	0	2	\N	-10
9167	165	955	4	4	\N	90
9168	166	955	1	3	\N	10
9169	207	956	3	4	\N	60
9170	208	956	0	0	\N	0
9171	180	956	3	5	\N	50
9172	181	956	3	3	\N	60
9173	174	956	0	3	\N	-20
9174	175	956	1	2	\N	20
9175	195	957	1	3	\N	10
9176	196	957	0	1	\N	0
9177	197	957	3	3	\N	60
9178	167	957	3	3	\N	60
9179	168	957	0	0	\N	0
9180	161	957	2	3	\N	40
9181	162	957	4	4	\N	90
9182	163	957	3	4	\N	60
9183	131	958	1	2	\N	20
9184	132	958	0	2	\N	-10
9185	133	958	0	1	\N	0
9186	171	958	0	3	\N	-20
9187	172	958	0	0	\N	0
9188	173	958	3	3	\N	60
9189	176	958	4	4	\N	90
9190	177	958	2	3	\N	40
9191	178	958	1	1	\N	20
9192	179	958	1	1	\N	20
9193	169	959	1	4	\N	0
9194	170	959	3	3	\N	60
9195	134	959	3	3	\N	60
9196	135	959	0	0	\N	0
9197	136	959	1	2	\N	20
9198	137	959	1	1	\N	20
9199	184	959	4	6	\N	70
9200	185	959	2	2	\N	40
9201	193	960	4	6	\N	70
9202	194	960	0	2	\N	-10
9203	171	960	3	3	\N	60
9204	172	960	4	4	\N	90
9205	173	960	3	4	\N	60
9206	209	960	3	3	\N	60
9207	210	960	2	2	\N	40
9208	211	960	3	3	\N	60
9209	139	961	4	4	\N	90
9210	140	961	4	4	\N	90
9211	195	961	2	2	\N	40
9212	196	961	3	5	\N	50
9213	197	961	1	1	\N	20
9214	138	961	4	5	\N	80
9215	164	962	0	1	\N	0
9216	165	962	2	3	\N	40
9217	166	962	3	3	\N	60
9218	155	962	3	5	\N	50
9219	156	962	3	3	\N	60
9220	157	962	0	0	\N	0
9221	202	962	3	4	\N	60
9222	203	962	1	1	\N	20
9223	198	963	4	4	\N	90
9224	199	963	1	1	\N	20
9225	200	963	0	1	\N	0
9226	201	963	4	5	\N	80
9227	144	963	0	1	\N	0
9228	145	963	0	0	\N	0
9229	180	963	4	4	\N	90
9230	181	963	3	3	\N	60
9231	212	964	3	4	\N	60
9232	213	964	0	1	\N	0
9233	214	964	1	1	\N	20
9234	174	964	4	4	\N	90
9235	175	964	1	2	\N	20
9236	146	964	0	0	\N	0
9237	147	964	2	3	\N	40
9238	148	964	0	0	\N	0
9239	158	965	3	4	\N	60
9240	159	965	2	2	\N	40
9241	160	965	2	2	\N	40
9242	207	965	1	2	\N	20
9243	208	965	4	5	\N	80
9244	161	965	2	4	\N	30
9245	162	965	3	4	\N	60
9246	163	965	1	2	\N	20
9247	152	966	4	5	\N	80
9248	153	966	3	3	\N	60
9249	154	966	2	4	\N	30
9250	204	966	3	4	\N	60
9251	205	966	2	3	\N	40
9252	206	966	4	4	\N	90
9253	141	966	0	2	\N	-10
9254	142	966	1	1	\N	20
9255	143	966	2	2	\N	40
9256	182	967	4	5	\N	80
9257	183	967	0	0	\N	0
9258	190	967	3	5	\N	50
9259	191	967	3	3	\N	60
9260	192	967	1	2	\N	20
9261	149	967	4	5	\N	80
9262	150	967	2	2	\N	40
9263	151	967	1	1	\N	20
9264	167	968	2	3	\N	40
9265	168	968	2	2	\N	40
9266	176	968	4	5	\N	80
9267	177	968	4	6	\N	70
9268	178	968	1	2	\N	20
9269	179	968	0	0	\N	0
9270	186	968	0	0	\N	0
9271	187	968	0	0	\N	0
9272	188	968	3	3	\N	60
9273	189	968	0	0	\N	0
9274	131	969	4	4	\N	90
9275	132	969	0	1	\N	0
9276	133	969	3	4	\N	60
9277	131	969	2	3	\N	40
9278	132	969	1	1	\N	20
9279	133	969	0	0	\N	0
9280	144	969	3	4	\N	60
9281	145	969	0	0	\N	0
9282	190	970	3	4	\N	60
9283	191	970	0	2	\N	-10
9284	192	970	0	0	\N	0
9285	176	970	4	6	\N	70
9286	177	970	2	2	\N	40
9287	178	970	0	0	\N	0
9288	179	970	2	2	\N	40
9289	164	970	4	4	\N	90
9290	165	970	0	2	\N	-10
9291	166	970	0	0	\N	0
9292	204	971	4	4	\N	90
9293	205	971	1	2	\N	20
9294	206	971	1	1	\N	20
9295	152	971	4	6	\N	70
9296	153	971	1	1	\N	20
9297	154	971	1	1	\N	20
9298	167	971	0	1	\N	0
9299	168	971	1	3	\N	10
9300	158	972	4	4	\N	90
9301	159	972	1	1	\N	20
9302	160	972	1	2	\N	20
9303	202	972	3	3	\N	60
9304	203	972	0	1	\N	0
9305	174	972	1	2	\N	20
9306	175	972	1	1	\N	20
9307	169	973	4	4	\N	90
9308	170	973	1	2	\N	20
9309	195	973	3	3	\N	60
9310	196	973	1	1	\N	20
9311	197	973	1	1	\N	20
9312	193	973	3	3	\N	60
9313	194	973	0	0	\N	0
9314	198	974	1	1	\N	20
9315	199	974	1	1	\N	20
9316	200	974	3	5	\N	50
9317	201	974	4	4	\N	90
9318	180	974	4	5	\N	80
9319	181	974	1	2	\N	20
9320	139	974	3	6	\N	40
9321	140	974	3	3	\N	60
9322	207	975	4	4	\N	90
9323	208	975	1	1	\N	20
9324	134	975	3	6	\N	40
9325	135	975	1	2	\N	20
9326	136	975	0	0	\N	0
9327	137	975	0	0	\N	0
9328	209	975	2	4	\N	30
9329	210	975	1	2	\N	20
9330	211	975	2	4	\N	30
9331	171	976	4	5	\N	80
9332	172	976	1	1	\N	20
9333	173	976	3	3	\N	60
9334	182	976	3	4	\N	60
9335	183	976	1	1	\N	20
9336	149	976	4	4	\N	90
9337	150	976	1	3	\N	10
9338	151	976	0	0	\N	0
9339	161	977	4	4	\N	90
9340	162	977	1	1	\N	20
9341	163	977	1	2	\N	20
9342	184	977	4	4	\N	90
9343	185	977	0	2	\N	-10
9344	212	977	3	6	\N	40
9345	213	977	1	1	\N	20
9346	214	977	0	1	\N	0
9347	155	978	4	5	\N	80
9348	156	978	1	2	\N	20
9349	157	978	2	2	\N	40
9350	146	978	3	3	\N	60
9351	147	978	3	3	\N	60
9352	148	978	2	2	\N	40
9353	138	978	0	1	\N	0
9354	186	979	3	5	\N	50
9355	187	979	2	2	\N	40
9356	188	979	1	1	\N	20
9357	189	979	1	1	\N	20
9358	141	979	4	5	\N	80
9359	142	979	3	4	\N	60
9360	143	979	0	2	\N	-10
9361	138	979	4	5	\N	80
9362	161	980	4	5	\N	80
9363	162	980	2	3	\N	40
9364	163	980	4	5	\N	80
9365	195	980	4	5	\N	80
9366	196	980	0	1	\N	0
9367	197	980	1	2	\N	20
9368	174	980	4	4	\N	90
9369	175	980	0	1	\N	0
9370	139	981	4	6	\N	70
9371	140	981	2	2	\N	40
9372	186	981	3	3	\N	60
9373	187	981	4	5	\N	80
9374	188	981	0	2	\N	-10
9375	189	981	0	2	\N	-10
9376	167	981	0	0	\N	0
9377	168	981	2	4	\N	30
9378	209	982	4	6	\N	70
9379	210	982	0	0	\N	0
9380	211	982	1	1	\N	20
9381	176	982	4	4	\N	90
9382	177	982	0	2	\N	-10
9383	178	982	1	1	\N	20
9384	179	982	1	1	\N	20
9385	155	982	2	4	\N	30
9386	156	982	0	0	\N	0
9387	157	982	4	4	\N	90
9388	158	983	3	5	\N	50
9389	159	983	0	0	\N	0
9390	160	983	4	4	\N	90
9391	207	983	3	4	\N	60
9392	208	983	0	2	\N	-10
9393	149	983	1	3	\N	10
9394	150	983	2	3	\N	40
9395	151	983	1	1	\N	20
9396	171	984	4	5	\N	80
9397	172	984	0	1	\N	0
9398	173	984	2	2	\N	40
9399	169	984	3	4	\N	60
9400	170	984	0	0	\N	0
9401	193	984	4	5	\N	80
9402	194	984	2	2	\N	40
9403	190	985	3	5	\N	50
9404	191	985	1	1	\N	20
9405	192	985	2	2	\N	40
9406	184	985	4	5	\N	80
9407	185	985	4	5	\N	80
9408	182	985	3	3	\N	60
9409	183	985	0	0	\N	0
9410	198	986	4	5	\N	80
9411	199	986	2	4	\N	30
9412	200	986	0	2	\N	-10
9413	201	986	2	2	\N	40
9414	212	986	4	4	\N	90
9415	213	986	1	1	\N	20
9416	214	986	1	1	\N	20
9417	204	986	3	6	\N	40
9418	205	986	2	3	\N	40
9419	206	986	1	2	\N	20
9420	141	987	4	5	\N	80
9421	142	987	0	0	\N	0
9422	143	987	0	0	\N	0
9423	131	987	0	2	\N	-10
9424	132	987	2	2	\N	40
9425	133	987	0	0	\N	0
9426	134	987	3	3	\N	60
9427	135	987	2	2	\N	40
9428	136	987	0	0	\N	0
9429	137	987	2	2	\N	40
9430	146	988	2	4	\N	30
9431	147	988	1	2	\N	20
9432	148	988	0	1	\N	0
9433	164	988	2	3	\N	40
9434	165	988	2	2	\N	40
9435	166	988	0	2	\N	-10
9436	144	988	4	6	\N	70
9437	145	988	2	2	\N	40
9438	202	989	4	5	\N	80
9439	203	989	3	3	\N	60
9440	152	989	3	3	\N	60
9441	153	989	0	0	\N	0
9442	154	989	0	0	\N	0
9443	180	989	1	1	\N	20
9444	181	989	4	4	\N	90
9445	242	991	4	4	\N	90
9446	243	991	0	1	\N	0
9447	244	991	4	4	\N	90
9448	238	991	0	2	\N	-10
9449	239	991	0	0	\N	0
9450	240	991	2	2	\N	40
9451	241	991	0	2	\N	-10
9452	269	991	0	2	\N	-10
9453	270	991	0	0	\N	0
9454	271	991	2	3	\N	40
9455	272	991	0	0	\N	0
9456	232	992	3	4	\N	60
9457	233	992	2	2	\N	40
9458	234	992	1	1	\N	20
9459	260	992	0	1	\N	0
9460	261	992	1	1	\N	20
9461	262	992	0	0	\N	0
9462	224	992	2	2	\N	40
9463	225	992	1	3	\N	10
9464	226	992	1	2	\N	20
9465	227	992	3	4	\N	60
9466	253	993	3	4	\N	60
9467	254	993	0	0	\N	0
9468	255	993	1	2	\N	20
9469	245	993	4	5	\N	80
9470	246	993	0	0	\N	0
9471	247	993	0	0	\N	0
9472	248	993	0	0	\N	0
9473	221	993	4	5	\N	80
9474	222	993	1	3	\N	10
9475	223	993	1	3	\N	10
9476	215	994	0	1	\N	0
9477	216	994	0	0	\N	0
9478	217	994	0	0	\N	0
9479	249	994	4	4	\N	90
9480	250	994	0	1	\N	0
9481	251	994	1	3	\N	10
9482	252	994	2	4	\N	30
9483	235	994	4	5	\N	80
9484	236	994	3	3	\N	60
9485	237	994	0	0	\N	0
9486	228	995	3	3	\N	60
9487	229	995	0	0	\N	0
9488	230	995	0	0	\N	0
9489	231	995	0	0	\N	0
9490	256	995	4	5	\N	80
9491	257	995	2	2	\N	40
9492	258	995	0	2	\N	-10
9493	259	995	0	1	\N	0
9494	218	995	4	4	\N	90
9495	219	995	1	2	\N	20
9496	220	995	0	1	\N	0
9497	266	996	4	4	\N	90
9498	267	996	0	1	\N	0
9499	268	996	1	1	\N	20
9500	263	996	1	4	\N	0
9501	264	996	4	5	\N	80
9502	265	996	0	0	\N	0
9503	232	996	1	2	\N	20
9504	233	996	0	0	\N	0
9505	234	996	4	6	\N	70
9506	215	997	4	6	\N	70
9507	216	997	0	0	\N	0
9508	217	997	1	2	\N	20
9509	253	997	3	3	\N	60
9510	254	997	3	3	\N	60
9511	255	997	0	1	\N	0
9512	218	997	2	3	\N	40
9513	219	997	0	0	\N	0
9514	220	997	2	2	\N	40
9515	242	998	3	5	\N	50
9516	243	998	4	6	\N	70
9517	244	998	1	1	\N	20
9518	249	998	3	4	\N	60
9519	250	998	3	3	\N	60
9520	251	998	0	0	\N	0
9521	252	998	0	0	\N	0
9522	228	998	4	4	\N	90
9523	229	998	0	0	\N	0
9524	230	998	2	2	\N	40
9525	231	998	1	2	\N	20
9526	260	999	4	5	\N	80
9527	261	999	2	4	\N	30
9528	262	999	0	0	\N	0
9529	224	999	4	4	\N	90
9530	225	999	0	2	\N	-10
9531	226	999	0	1	\N	0
9532	227	999	1	2	\N	20
9533	235	999	0	3	\N	-20
9534	236	999	0	0	\N	0
9535	237	999	2	2	\N	40
9536	221	1000	2	5	\N	20
9537	222	1000	1	1	\N	20
9538	223	1000	1	2	\N	20
9539	263	1000	4	5	\N	80
9540	264	1000	1	2	\N	20
9541	265	1000	0	1	\N	0
9542	245	1000	3	3	\N	60
9543	246	1000	3	5	\N	50
9544	247	1000	2	3	\N	40
9545	248	1000	2	2	\N	40
9546	266	1001	3	3	\N	60
9547	267	1001	0	0	\N	0
9548	268	1001	2	3	\N	40
9549	269	1001	3	4	\N	60
9550	270	1001	1	1	\N	20
9551	271	1001	1	2	\N	20
9552	272	1001	3	3	\N	60
9553	238	1001	3	4	\N	60
9554	239	1001	0	1	\N	0
9555	240	1001	2	2	\N	40
9556	241	1001	1	2	\N	20
9557	256	1002	3	5	\N	50
9558	257	1002	2	4	\N	30
9559	258	1002	2	3	\N	40
9560	259	1002	2	2	\N	40
9561	256	1002	1	1	\N	20
9562	257	1002	3	3	\N	60
9563	258	1002	2	2	\N	40
9564	259	1002	0	0	\N	0
9565	228	1002	3	4	\N	60
9566	229	1002	4	4	\N	90
9567	230	1002	2	2	\N	40
9568	231	1002	4	4	\N	90
9569	249	1003	3	3	\N	60
9570	250	1003	1	2	\N	20
9571	251	1003	4	4	\N	90
9572	252	1003	2	2	\N	40
9573	266	1003	3	5	\N	50
9574	267	1003	2	2	\N	40
9575	268	1003	2	2	\N	40
9576	215	1003	1	3	\N	10
9577	216	1003	0	0	\N	0
9578	217	1003	4	4	\N	90
9579	221	1004	4	4	\N	90
9580	222	1004	2	4	\N	30
9581	223	1004	1	1	\N	20
9582	245	1004	4	5	\N	80
9583	246	1004	0	1	\N	0
9584	247	1004	4	4	\N	90
9585	248	1004	4	4	\N	90
9586	232	1004	3	3	\N	60
9587	233	1004	0	1	\N	0
9588	234	1004	3	3	\N	60
9589	242	1005	3	5	\N	50
9590	243	1005	1	2	\N	20
9591	244	1005	0	1	\N	0
9592	218	1005	4	5	\N	80
9593	219	1005	2	2	\N	40
9594	220	1005	0	0	\N	0
9595	263	1005	1	1	\N	20
9596	264	1005	2	2	\N	40
9597	265	1005	1	3	\N	10
9598	253	1006	4	4	\N	90
9599	254	1006	2	2	\N	40
9600	255	1006	0	0	\N	0
9601	238	1006	2	2	\N	40
9602	239	1006	0	0	\N	0
9603	240	1006	4	4	\N	90
9604	241	1006	4	4	\N	90
9605	224	1006	3	3	\N	60
9606	225	1006	1	1	\N	20
9607	226	1006	0	0	\N	0
9608	227	1006	1	1	\N	20
9609	260	1007	3	4	\N	60
9610	261	1007	1	1	\N	20
9611	262	1007	0	1	\N	0
9612	269	1007	3	5	\N	50
9613	270	1007	1	1	\N	20
9614	271	1007	0	0	\N	0
9615	272	1007	0	2	\N	-10
9616	235	1007	4	5	\N	80
9617	236	1007	3	4	\N	60
9618	237	1007	2	4	\N	30
9619	249	1008	0	1	\N	0
9620	250	1008	1	2	\N	20
9621	251	1008	1	1	\N	20
9622	252	1008	0	2	\N	-10
9623	232	1008	3	6	\N	40
9624	233	1008	1	1	\N	20
9625	234	1008	2	4	\N	30
9626	260	1008	3	3	\N	60
9627	261	1008	1	2	\N	20
9628	262	1008	4	4	\N	90
9629	218	1009	4	5	\N	80
9630	219	1009	3	3	\N	60
9631	220	1009	4	5	\N	80
9632	242	1009	3	6	\N	40
9633	243	1009	1	1	\N	20
9634	244	1009	2	3	\N	40
9635	253	1009	4	6	\N	70
9636	254	1009	1	1	\N	20
9637	255	1009	2	2	\N	40
9638	245	1010	1	4	\N	0
9639	246	1010	0	0	\N	0
9640	247	1010	4	5	\N	80
9641	248	1010	0	0	\N	0
9642	224	1010	3	3	\N	60
9643	225	1010	2	3	\N	40
9644	226	1010	1	1	\N	20
9645	227	1010	2	4	\N	30
9646	263	1010	3	6	\N	40
9647	264	1010	0	1	\N	0
9648	265	1010	2	2	\N	40
9649	266	1011	4	5	\N	80
9650	267	1011	1	1	\N	20
9651	268	1011	1	2	\N	20
9652	238	1011	3	5	\N	50
9653	239	1011	0	0	\N	0
9654	240	1011	1	2	\N	20
9655	241	1011	3	4	\N	60
9656	269	1011	3	3	\N	60
9657	270	1011	4	4	\N	90
9658	271	1011	2	2	\N	40
9659	272	1011	1	2	\N	20
9660	228	1012	3	5	\N	50
9661	229	1012	0	0	\N	0
9662	230	1012	4	4	\N	90
9663	231	1012	1	2	\N	20
9664	221	1012	3	5	\N	50
9665	222	1012	1	1	\N	20
9666	223	1012	1	1	\N	20
9667	256	1012	4	5	\N	80
9668	257	1012	2	2	\N	40
9669	258	1012	0	0	\N	0
9670	259	1012	1	1	\N	20
9671	215	1013	4	4	\N	90
9672	216	1013	0	0	\N	0
9673	217	1013	3	3	\N	60
9674	235	1013	3	4	\N	60
9675	236	1013	1	2	\N	20
9676	237	1013	0	0	\N	0
9677	228	1013	2	2	\N	40
9678	229	1013	1	2	\N	20
9679	230	1013	2	2	\N	40
9680	231	1013	1	2	\N	20
9681	249	1014	4	5	\N	80
9682	250	1014	4	4	\N	90
9683	251	1014	1	1	\N	20
9684	252	1014	0	1	\N	0
9685	253	1014	2	5	\N	20
9686	254	1014	2	3	\N	40
9687	255	1014	1	1	\N	20
9688	245	1014	1	3	\N	10
9689	246	1014	1	1	\N	20
9690	247	1014	0	0	\N	0
9691	248	1014	1	2	\N	20
9692	218	1015	4	5	\N	80
9693	219	1015	1	2	\N	20
9694	220	1015	0	0	\N	0
9695	269	1015	2	3	\N	40
9696	270	1015	3	3	\N	60
9697	271	1015	1	1	\N	20
9698	272	1015	0	0	\N	0
9699	256	1015	2	3	\N	40
9700	257	1015	2	3	\N	40
9701	258	1015	0	0	\N	0
9702	259	1015	2	2	\N	40
9703	221	1016	3	5	\N	50
9704	222	1016	3	4	\N	60
9705	223	1016	1	2	\N	20
9706	238	1016	4	4	\N	90
9707	239	1016	2	2	\N	40
9708	240	1016	1	1	\N	20
9709	241	1016	3	3	\N	60
9710	263	1016	3	5	\N	50
9711	264	1016	3	3	\N	60
9712	265	1016	1	1	\N	20
9713	215	1017	1	2	\N	20
9714	216	1017	0	0	\N	0
9715	217	1017	2	2	\N	40
9716	242	1017	0	1	\N	0
9717	243	1017	4	4	\N	90
9718	244	1017	3	3	\N	60
9719	260	1017	1	3	\N	10
9720	261	1017	0	0	\N	0
9721	262	1017	0	2	\N	-10
9722	232	1018	4	5	\N	80
9723	233	1018	0	0	\N	0
9724	234	1018	4	4	\N	90
9725	224	1018	4	5	\N	80
9726	225	1018	0	0	\N	0
9727	226	1018	1	3	\N	10
9728	227	1018	2	2	\N	40
9729	266	1018	0	2	\N	-10
9730	267	1018	1	3	\N	10
9731	268	1018	2	3	\N	40
9732	235	1019	4	4	\N	90
9733	236	1019	1	1	\N	20
9734	237	1019	0	1	\N	0
9735	228	1019	3	5	\N	50
9736	229	1019	3	3	\N	60
9737	230	1019	2	3	\N	40
9738	231	1019	0	2	\N	-10
9739	263	1019	3	4	\N	60
9740	264	1019	2	2	\N	40
9741	265	1019	0	1	\N	0
9742	249	1020	1	3	\N	10
9743	250	1020	3	3	\N	60
9744	251	1020	1	1	\N	20
9745	252	1020	1	3	\N	10
9746	260	1020	0	1	\N	0
9747	261	1020	1	1	\N	20
9748	262	1020	4	6	\N	70
9749	235	1020	3	4	\N	60
9750	236	1020	2	4	\N	30
9751	237	1020	4	5	\N	80
9752	253	1021	3	4	\N	60
9753	254	1021	1	1	\N	20
9754	255	1021	4	4	\N	90
9755	238	1021	3	5	\N	50
9756	239	1021	1	1	\N	20
9757	240	1021	1	1	\N	20
9758	241	1021	1	2	\N	20
9759	242	1021	3	4	\N	60
9760	243	1021	2	2	\N	40
9761	244	1021	1	2	\N	20
9762	232	1022	4	5	\N	80
9763	233	1022	0	0	\N	0
9764	234	1022	1	1	\N	20
9765	256	1022	2	4	\N	30
9766	257	1022	0	1	\N	0
9767	258	1022	2	2	\N	40
9768	259	1022	1	1	\N	20
9769	221	1022	0	2	\N	-10
9770	222	1022	4	5	\N	80
9771	223	1022	2	3	\N	40
9772	215	1023	4	5	\N	80
9773	216	1023	1	2	\N	20
9774	217	1023	0	1	\N	0
9775	224	1023	4	5	\N	80
9776	225	1023	2	2	\N	40
9777	226	1023	1	3	\N	10
9778	227	1023	0	1	\N	0
9779	218	1023	4	6	\N	70
9780	219	1023	3	3	\N	60
9781	220	1023	2	3	\N	40
9782	269	1024	1	2	\N	20
9783	270	1024	4	4	\N	90
9784	271	1024	2	3	\N	40
9785	272	1024	2	2	\N	40
9786	266	1024	4	5	\N	80
9787	267	1024	1	2	\N	20
9788	268	1024	1	1	\N	20
9789	245	1024	3	4	\N	60
9790	246	1024	1	1	\N	20
9791	247	1024	2	3	\N	40
9792	248	1024	4	5	\N	80
9793	39	1027	3	3	\N	60
9794	40	1027	1	1	\N	20
9795	41	1027	1	1	\N	20
9796	50	1027	0	2	\N	-10
9797	51	1027	0	1	\N	0
9798	52	1027	1	1	\N	20
9799	53	1027	0	0	\N	0
9800	13	1027	2	3	\N	40
9801	14	1027	1	1	\N	20
9802	15	1027	0	1	\N	0
9803	16	1027	2	2	\N	40
9804	1	1028	4	6	\N	70
9805	2	1028	1	1	\N	20
9806	3	1028	0	1	\N	0
9807	4	1028	4	4	\N	90
9808	87	1028	4	4	\N	90
9809	88	1028	3	5	\N	50
9810	89	1028	0	1	\N	0
9811	90	1028	2	2	\N	40
9812	32	1028	2	5	\N	20
9813	33	1028	0	1	\N	0
9814	34	1028	1	3	\N	10
9815	127	1029	3	5	\N	50
9816	128	1029	1	3	\N	10
9817	129	1029	1	1	\N	20
9818	130	1029	1	1	\N	20
9819	23	1029	1	2	\N	20
9820	24	1029	1	1	\N	20
9821	25	1029	0	0	\N	0
9822	26	1029	1	1	\N	20
9823	27	1029	4	4	\N	90
9824	28	1029	1	3	\N	10
9825	29	1029	4	4	\N	90
9826	30	1029	2	2	\N	40
9827	31	1029	1	2	\N	20
9828	61	1030	1	2	\N	20
9829	62	1030	0	2	\N	-10
9830	63	1030	2	2	\N	40
9831	79	1030	3	4	\N	60
9832	80	1030	3	4	\N	60
9833	81	1030	1	1	\N	20
9834	82	1030	4	4	\N	90
9835	118	1030	0	1	\N	0
9836	119	1030	4	4	\N	90
9837	120	1030	1	1	\N	20
9838	121	1030	2	3	\N	40
9839	122	1030	2	2	\N	40
9840	5	1031	4	5	\N	80
9841	6	1031	0	1	\N	0
9842	7	1031	1	1	\N	20
9843	64	1031	4	4	\N	90
9844	65	1031	1	2	\N	20
9845	66	1031	0	0	\N	0
9846	67	1031	0	0	\N	0
9847	68	1031	1	1	\N	20
9848	95	1031	4	5	\N	80
9849	96	1031	2	4	\N	30
9850	97	1031	1	1	\N	20
9851	98	1031	4	4	\N	90
9852	69	1032	4	5	\N	80
9853	70	1032	0	0	\N	0
9854	71	1032	3	5	\N	50
9855	72	1032	2	3	\N	40
9856	20	1032	3	5	\N	50
9857	21	1032	0	1	\N	0
9858	22	1032	0	0	\N	0
9859	91	1032	4	5	\N	80
9860	92	1032	0	0	\N	0
9861	93	1032	3	5	\N	50
9862	94	1032	0	0	\N	0
9863	54	1033	4	4	\N	90
9864	55	1033	2	2	\N	40
9865	56	1033	4	4	\N	90
9866	76	1033	3	4	\N	60
9867	77	1033	0	1	\N	0
9868	78	1033	4	5	\N	80
9869	123	1033	1	2	\N	20
9870	124	1033	1	1	\N	20
9871	125	1033	3	4	\N	60
9872	126	1033	0	0	\N	0
9873	99	1034	4	4	\N	90
9874	100	1034	0	0	\N	0
9875	101	1034	1	3	\N	10
9876	102	1034	3	3	\N	60
9877	35	1034	3	4	\N	60
9878	36	1034	0	0	\N	0
9879	37	1034	1	1	\N	20
9880	38	1034	4	5	\N	80
9881	73	1034	3	3	\N	60
9882	74	1034	3	3	\N	60
9883	75	1034	4	4	\N	90
9884	8	1035	2	5	\N	20
9885	9	1035	1	1	\N	20
9886	10	1035	1	1	\N	20
9887	11	1035	4	4	\N	90
9888	12	1035	2	2	\N	40
9889	106	1035	3	3	\N	60
9890	107	1035	3	3	\N	60
9891	108	1035	1	1	\N	20
9892	109	1035	4	5	\N	80
9893	114	1035	3	6	\N	40
9894	115	1035	2	3	\N	40
9895	116	1035	2	2	\N	40
9896	117	1035	1	1	\N	20
9897	103	1036	4	4	\N	90
9898	104	1036	0	1	\N	0
9899	105	1036	0	0	\N	0
9900	57	1036	0	1	\N	0
9901	58	1036	1	1	\N	20
9902	59	1036	3	3	\N	60
9903	60	1036	0	0	\N	0
9904	110	1036	1	1	\N	20
9905	111	1036	0	0	\N	0
9906	112	1036	2	2	\N	40
9907	113	1036	0	0	\N	0
9908	42	1037	2	5	\N	20
9909	43	1037	1	1	\N	20
9910	44	1037	2	3	\N	40
9911	45	1037	3	3	\N	60
9912	17	1037	0	0	\N	0
9913	18	1037	1	1	\N	20
9914	19	1037	3	3	\N	60
9915	83	1037	4	5	\N	80
9916	84	1037	0	0	\N	0
9917	85	1037	2	3	\N	40
9918	86	1037	0	0	\N	0
9919	46	1038	1	4	\N	0
9920	47	1038	0	0	\N	0
9921	48	1038	0	1	\N	0
9922	49	1038	3	3	\N	60
9923	42	1038	3	4	\N	60
9924	43	1038	0	1	\N	0
9925	44	1038	2	2	\N	40
9926	45	1038	2	2	\N	40
9927	118	1038	2	4	\N	30
9928	119	1038	2	3	\N	40
9929	120	1038	2	2	\N	40
9930	121	1038	1	1	\N	20
9931	122	1038	0	2	\N	-10
9932	17	1039	0	0	\N	0
9933	18	1039	3	3	\N	60
9934	19	1039	1	3	\N	10
9935	110	1039	4	4	\N	90
9936	111	1039	1	3	\N	10
9937	112	1039	1	1	\N	20
9938	113	1039	0	0	\N	0
9939	83	1039	3	5	\N	50
9940	84	1039	1	2	\N	20
9941	85	1039	3	3	\N	60
9942	86	1039	0	1	\N	0
9943	91	1040	4	5	\N	80
9944	92	1040	0	2	\N	-10
9945	93	1040	1	2	\N	20
9946	94	1040	0	0	\N	0
9947	46	1040	0	2	\N	-10
9948	47	1040	1	1	\N	20
9949	48	1040	3	3	\N	60
9950	49	1040	3	3	\N	60
9951	13	1040	2	3	\N	40
9952	14	1040	0	0	\N	0
9953	15	1040	0	0	\N	0
9954	16	1040	3	3	\N	60
9955	32	1041	3	3	\N	60
9956	33	1041	2	2	\N	40
9957	34	1041	3	5	\N	50
9958	20	1041	4	6	\N	70
9959	21	1041	0	1	\N	0
9960	22	1041	1	2	\N	20
9961	73	1041	3	5	\N	50
9962	74	1041	1	1	\N	20
9963	75	1041	1	1	\N	20
9964	103	1042	3	5	\N	50
9965	104	1042	2	3	\N	40
9966	105	1042	2	2	\N	40
9967	95	1042	4	5	\N	80
9968	96	1042	4	4	\N	90
9969	97	1042	4	6	\N	70
9970	98	1042	1	1	\N	20
9971	35	1042	4	4	\N	90
9972	36	1042	1	2	\N	20
9973	37	1042	1	2	\N	20
9974	38	1042	2	2	\N	40
9975	27	1043	1	2	\N	20
9976	28	1043	3	3	\N	60
9977	29	1043	0	1	\N	0
9978	30	1043	0	0	\N	0
9979	31	1043	1	2	\N	20
9980	57	1043	3	3	\N	60
9981	58	1043	0	0	\N	0
9982	59	1043	2	2	\N	40
9983	60	1043	1	1	\N	20
9984	87	1043	1	1	\N	20
9985	88	1043	0	0	\N	0
9986	89	1043	0	0	\N	0
9987	90	1043	0	1	\N	0
9988	1	1044	4	5	\N	80
9989	2	1044	1	1	\N	20
9990	3	1044	1	1	\N	20
9991	4	1044	0	0	\N	0
9992	23	1044	3	6	\N	40
9993	24	1044	1	1	\N	20
9994	25	1044	1	1	\N	20
9995	26	1044	0	1	\N	0
9996	61	1044	3	4	\N	60
9997	62	1044	1	1	\N	20
9998	63	1044	3	3	\N	60
9999	114	1045	4	6	\N	70
10000	115	1045	4	4	\N	90
10001	116	1045	0	2	\N	-10
10002	117	1045	1	1	\N	20
10003	8	1045	4	5	\N	80
10004	9	1045	1	1	\N	20
10005	10	1045	0	0	\N	0
10006	11	1045	2	2	\N	40
10007	12	1045	1	1	\N	20
10008	106	1045	4	4	\N	90
10009	107	1045	2	4	\N	30
10010	108	1045	1	1	\N	20
10011	109	1045	1	2	\N	20
10012	39	1046	4	4	\N	90
10013	40	1046	1	1	\N	20
10014	41	1046	0	0	\N	0
10015	69	1046	0	3	\N	-20
10016	70	1046	0	0	\N	0
10017	71	1046	1	2	\N	20
10018	72	1046	1	1	\N	20
10019	54	1046	4	4	\N	90
10020	55	1046	3	5	\N	50
10021	56	1046	1	1	\N	20
10022	99	1047	3	5	\N	50
10023	100	1047	1	2	\N	20
10024	101	1047	1	2	\N	20
10025	102	1047	0	2	\N	-10
10026	123	1047	0	2	\N	-10
10027	124	1047	4	4	\N	90
10028	125	1047	2	2	\N	40
10029	126	1047	1	1	\N	20
10030	79	1047	4	5	\N	80
10031	80	1047	0	1	\N	0
10032	81	1047	2	2	\N	40
10033	82	1047	1	1	\N	20
10034	5	1048	3	5	\N	50
10035	6	1048	0	0	\N	0
10036	7	1048	0	1	\N	0
10037	76	1048	3	4	\N	60
10038	77	1048	2	2	\N	40
10039	78	1048	1	1	\N	20
10040	127	1048	4	4	\N	90
10041	128	1048	2	2	\N	40
10042	129	1048	0	1	\N	0
10043	130	1048	0	0	\N	0
10044	50	1049	2	2	\N	40
10045	51	1049	2	2	\N	40
10046	52	1049	0	0	\N	0
10047	53	1049	1	2	\N	20
10048	64	1049	0	2	\N	-10
10049	65	1049	1	1	\N	20
10050	66	1049	2	2	\N	40
10051	67	1049	0	0	\N	0
10052	68	1049	1	1	\N	20
10053	35	1049	4	6	\N	70
10054	36	1049	1	2	\N	20
10055	37	1049	0	1	\N	0
10056	38	1049	0	1	\N	0
10057	54	1050	3	4	\N	60
10058	55	1050	3	3	\N	60
10059	56	1050	0	0	\N	0
10060	64	1050	1	4	\N	0
10061	65	1050	0	0	\N	0
10062	66	1050	2	3	\N	40
10063	67	1050	0	2	\N	-10
10064	68	1050	4	4	\N	90
10065	42	1050	4	4	\N	90
10066	43	1050	1	1	\N	20
10067	44	1050	0	0	\N	0
10068	45	1050	0	2	\N	-10
10069	5	1051	4	6	\N	70
10070	6	1051	3	3	\N	60
10071	7	1051	4	4	\N	90
10072	23	1051	4	5	\N	80
10073	24	1051	0	0	\N	0
10074	25	1051	3	3	\N	60
10075	26	1051	1	1	\N	20
10076	8	1051	3	3	\N	60
10077	9	1051	3	3	\N	60
10078	10	1051	3	4	\N	60
10079	11	1051	0	0	\N	0
10080	12	1051	1	1	\N	20
10081	50	1052	3	4	\N	60
10082	51	1052	1	2	\N	20
10083	52	1052	1	1	\N	20
10084	53	1052	1	2	\N	20
10085	95	1052	4	6	\N	70
10086	96	1052	3	3	\N	60
10087	97	1052	1	2	\N	20
10088	98	1052	0	2	\N	-10
10089	1	1052	4	5	\N	80
10090	2	1052	1	1	\N	20
10091	3	1052	3	3	\N	60
10092	4	1052	0	2	\N	-10
10093	61	1053	4	6	\N	70
10094	62	1053	1	1	\N	20
10095	63	1053	0	2	\N	-10
10096	20	1053	4	4	\N	90
10097	21	1053	1	2	\N	20
10098	22	1053	3	3	\N	60
10099	91	1053	0	2	\N	-10
10100	92	1053	1	1	\N	20
10101	93	1053	0	1	\N	0
10102	94	1053	1	1	\N	20
10103	79	1054	4	5	\N	80
10104	80	1054	0	1	\N	0
10105	81	1054	1	2	\N	20
10106	82	1054	1	1	\N	20
10107	99	1054	1	2	\N	20
10108	100	1054	2	2	\N	40
10109	101	1054	4	4	\N	90
10110	102	1054	0	0	\N	0
10111	76	1054	2	3	\N	40
10112	77	1054	4	5	\N	80
10113	78	1054	4	5	\N	80
10114	110	1055	4	5	\N	80
10115	111	1055	3	3	\N	60
10116	112	1055	1	3	\N	10
10117	113	1055	0	1	\N	0
10118	57	1055	4	4	\N	90
10119	58	1055	1	1	\N	20
10120	59	1055	4	4	\N	90
10121	60	1055	1	1	\N	20
10122	27	1055	2	5	\N	20
10123	28	1055	3	3	\N	60
10124	29	1055	1	1	\N	20
10125	30	1055	1	1	\N	20
10126	31	1055	1	2	\N	20
10127	13	1056	4	5	\N	80
10128	14	1056	0	0	\N	0
10129	15	1056	2	2	\N	40
10130	16	1056	3	5	\N	50
10131	69	1056	4	5	\N	80
10132	70	1056	1	1	\N	20
10133	71	1056	2	4	\N	30
10134	72	1056	0	0	\N	0
10135	123	1056	4	4	\N	90
10136	124	1056	4	6	\N	70
10137	125	1056	0	2	\N	-10
10138	126	1056	4	4	\N	90
10139	17	1057	4	5	\N	80
10140	18	1057	0	1	\N	0
10141	19	1057	2	2	\N	40
10142	32	1057	4	4	\N	90
10143	33	1057	1	2	\N	20
10144	34	1057	3	3	\N	60
10145	114	1057	4	5	\N	80
10146	115	1057	2	2	\N	40
10147	116	1057	1	1	\N	20
10148	117	1057	0	0	\N	0
10149	106	1058	4	4	\N	90
10150	107	1058	1	1	\N	20
10151	108	1058	4	4	\N	90
10152	109	1058	1	2	\N	20
10153	87	1058	2	3	\N	40
10154	88	1058	2	2	\N	40
10155	89	1058	1	1	\N	20
10156	90	1058	2	2	\N	40
10157	83	1058	4	4	\N	90
10158	84	1058	1	1	\N	20
10159	85	1058	1	2	\N	20
10160	86	1058	2	2	\N	40
10161	73	1059	1	2	\N	20
10162	74	1059	4	4	\N	90
10163	75	1059	1	2	\N	20
10164	118	1059	2	4	\N	30
10165	119	1059	1	1	\N	20
10166	120	1059	3	3	\N	60
10167	121	1059	3	3	\N	60
10168	122	1059	4	4	\N	90
10169	127	1059	0	2	\N	-10
10170	128	1059	1	2	\N	20
10171	129	1059	2	3	\N	40
10172	130	1059	1	2	\N	20
10173	46	1060	4	5	\N	80
10174	47	1060	0	0	\N	0
10175	48	1060	1	1	\N	20
10176	49	1060	2	2	\N	40
10177	39	1060	3	5	\N	50
10178	40	1060	2	4	\N	30
10179	41	1060	2	2	\N	40
10180	103	1060	3	6	\N	40
10181	104	1060	0	2	\N	-10
10182	105	1060	3	5	\N	50
10183	50	1061	3	4	\N	60
10184	51	1061	0	0	\N	0
10185	52	1061	0	0	\N	0
10186	53	1061	1	1	\N	20
10187	118	1061	1	4	\N	0
10188	119	1061	2	3	\N	40
10189	120	1061	0	0	\N	0
10190	121	1061	3	3	\N	60
10191	122	1061	1	2	\N	20
10192	17	1061	2	2	\N	40
10193	18	1061	1	1	\N	20
10194	19	1061	3	3	\N	60
10195	73	1062	4	5	\N	80
10196	74	1062	1	1	\N	20
10197	75	1062	2	2	\N	40
10198	39	1062	3	3	\N	60
10199	40	1062	0	1	\N	0
10200	41	1062	0	0	\N	0
10201	54	1062	4	4	\N	90
10202	55	1062	0	1	\N	0
10203	56	1062	2	4	\N	30
10204	127	1063	2	4	\N	30
10205	128	1063	1	1	\N	20
10206	129	1063	1	1	\N	20
10207	130	1063	4	4	\N	90
10208	91	1063	2	4	\N	30
10209	92	1063	1	1	\N	20
10210	93	1063	3	3	\N	60
10211	94	1063	3	3	\N	60
10212	95	1063	2	3	\N	40
10213	96	1063	0	1	\N	0
10214	97	1063	0	0	\N	0
10215	98	1063	1	1	\N	20
10216	13	1064	2	3	\N	40
10217	14	1064	1	3	\N	10
10218	15	1064	0	2	\N	-10
10219	16	1064	1	2	\N	20
10220	57	1064	1	4	\N	0
10221	58	1064	2	4	\N	30
10222	59	1064	0	1	\N	0
10223	60	1064	0	1	\N	0
10224	87	1064	1	2	\N	20
10225	88	1064	0	2	\N	-10
10226	89	1064	4	5	\N	80
10227	90	1064	3	3	\N	60
10228	114	1065	3	4	\N	60
10229	115	1065	1	1	\N	20
10230	116	1065	0	0	\N	0
10231	117	1065	0	1	\N	0
10232	42	1065	4	4	\N	90
10233	43	1065	1	1	\N	20
10234	44	1065	0	0	\N	0
10235	45	1065	0	0	\N	0
10236	5	1065	3	5	\N	50
10237	6	1065	0	0	\N	0
10238	7	1065	0	0	\N	0
10239	32	1066	4	5	\N	80
10240	33	1066	1	1	\N	20
10241	34	1066	2	2	\N	40
10242	76	1066	3	4	\N	60
10243	77	1066	2	3	\N	40
10244	78	1066	3	3	\N	60
10245	46	1066	3	6	\N	40
10246	47	1066	0	2	\N	-10
10247	48	1066	0	0	\N	0
10248	49	1066	1	3	\N	10
10249	79	1067	0	1	\N	0
10250	80	1067	1	1	\N	20
10251	81	1067	1	1	\N	20
10252	82	1067	1	1	\N	20
10253	83	1067	3	4	\N	60
10254	84	1067	1	3	\N	10
10255	85	1067	4	4	\N	90
10256	86	1067	0	0	\N	0
10257	64	1067	3	5	\N	50
10258	65	1067	2	2	\N	40
10259	66	1067	2	2	\N	40
10260	67	1067	0	0	\N	0
10261	68	1067	1	2	\N	20
10262	20	1068	0	2	\N	-10
10263	21	1068	0	0	\N	0
10264	22	1068	2	2	\N	40
10265	69	1068	3	4	\N	60
10266	70	1068	0	1	\N	0
10267	71	1068	4	4	\N	90
10268	72	1068	1	2	\N	20
10269	23	1068	4	4	\N	90
10270	24	1068	3	3	\N	60
10271	25	1068	0	0	\N	0
10272	26	1068	2	2	\N	40
10273	61	1069	4	4	\N	90
10274	62	1069	2	3	\N	40
10275	63	1069	2	2	\N	40
10276	106	1069	2	4	\N	30
10277	107	1069	1	2	\N	20
10278	108	1069	4	4	\N	90
10279	109	1069	1	1	\N	20
10280	99	1069	4	4	\N	90
10281	100	1069	1	1	\N	20
10282	101	1069	0	0	\N	0
10283	102	1069	0	1	\N	0
10284	27	1070	0	3	\N	-20
10285	28	1070	1	1	\N	20
10286	29	1070	0	0	\N	0
10287	30	1070	1	1	\N	20
10288	31	1070	1	3	\N	10
10289	103	1070	4	4	\N	90
10290	104	1070	1	1	\N	20
10291	105	1070	3	3	\N	60
10292	8	1070	3	4	\N	60
10293	9	1070	2	2	\N	40
10294	10	1070	0	0	\N	0
10295	11	1070	2	2	\N	40
10296	12	1070	3	4	\N	60
10297	1	1071	4	4	\N	90
10298	2	1071	0	1	\N	0
10299	3	1071	3	4	\N	60
10300	4	1071	3	5	\N	50
10301	110	1071	4	5	\N	80
10302	111	1071	0	2	\N	-10
10303	112	1071	1	1	\N	20
10304	113	1071	1	1	\N	20
10305	35	1071	4	5	\N	80
10306	36	1071	0	0	\N	0
10307	37	1071	0	1	\N	0
10308	38	1071	0	0	\N	0
10309	123	1072	0	3	\N	-20
10310	124	1072	0	1	\N	0
10311	125	1072	2	2	\N	40
10312	126	1072	1	1	\N	20
10313	103	1072	1	2	\N	20
10314	104	1072	1	3	\N	10
10315	105	1072	1	1	\N	20
10316	91	1072	0	2	\N	-10
10317	92	1072	1	3	\N	10
10318	93	1072	2	3	\N	40
10319	94	1072	2	2	\N	40
10320	127	1073	0	0	\N	0
10321	128	1073	1	1	\N	20
10322	129	1073	3	3	\N	60
10323	130	1073	0	2	\N	-10
10324	46	1073	1	1	\N	20
10325	47	1073	1	3	\N	10
10326	48	1073	1	1	\N	20
10327	49	1073	3	3	\N	60
10328	69	1073	0	2	\N	-10
10329	70	1073	0	0	\N	0
10330	71	1073	0	1	\N	0
10331	72	1073	1	1	\N	20
10332	61	1074	1	2	\N	20
10333	62	1074	2	2	\N	40
10334	63	1074	0	0	\N	0
10335	5	1074	3	4	\N	60
10336	6	1074	2	3	\N	40
10337	7	1074	2	2	\N	40
10338	32	1074	1	1	\N	20
10339	33	1074	0	0	\N	0
10340	34	1074	2	3	\N	40
10341	76	1075	1	2	\N	20
10342	77	1075	2	2	\N	40
10343	78	1075	0	0	\N	0
10344	87	1075	4	4	\N	90
10345	88	1075	3	3	\N	60
10346	89	1075	0	1	\N	0
10347	90	1075	0	0	\N	0
10348	8	1075	1	3	\N	10
10349	9	1075	2	3	\N	40
10350	10	1075	3	3	\N	60
10351	11	1075	1	1	\N	20
10352	12	1075	2	3	\N	40
10353	50	1076	4	4	\N	90
10354	51	1076	2	2	\N	40
10355	52	1076	0	0	\N	0
10356	53	1076	0	0	\N	0
10357	106	1076	0	0	\N	0
10358	107	1076	3	3	\N	60
10359	108	1076	1	1	\N	20
10360	109	1076	3	3	\N	60
10361	54	1076	4	6	\N	70
10362	55	1076	1	1	\N	20
10363	56	1076	2	4	\N	30
10364	83	1077	2	3	\N	40
10365	84	1077	1	2	\N	20
10366	85	1077	1	1	\N	20
10367	86	1077	1	1	\N	20
10368	118	1077	4	5	\N	80
10369	119	1077	2	3	\N	40
10370	120	1077	4	4	\N	90
10371	121	1077	1	2	\N	20
10372	122	1077	0	0	\N	0
10373	13	1077	1	3	\N	10
10374	14	1077	3	3	\N	60
10375	15	1077	2	2	\N	40
10376	16	1077	0	2	\N	-10
10377	114	1078	3	4	\N	60
10378	115	1078	0	1	\N	0
10379	116	1078	0	0	\N	0
10380	117	1078	2	3	\N	40
10381	79	1078	4	4	\N	90
10382	80	1078	2	4	\N	30
10383	81	1078	4	5	\N	80
10384	82	1078	1	3	\N	10
10385	20	1078	4	4	\N	90
10386	21	1078	1	3	\N	10
10387	22	1078	3	3	\N	60
10388	64	1079	1	3	\N	10
10389	65	1079	0	2	\N	-10
10390	66	1079	0	0	\N	0
10391	67	1079	1	1	\N	20
10392	68	1079	4	5	\N	80
10393	39	1079	3	5	\N	50
10394	40	1079	0	0	\N	0
10395	41	1079	0	1	\N	0
10396	23	1079	4	5	\N	80
10397	24	1079	1	1	\N	20
10398	25	1079	2	2	\N	40
10399	26	1079	0	2	\N	-10
10400	17	1080	2	2	\N	40
10401	18	1080	1	1	\N	20
10402	19	1080	1	1	\N	20
10403	99	1080	3	5	\N	50
10404	100	1080	4	4	\N	90
10405	101	1080	4	4	\N	90
10406	102	1080	0	1	\N	0
10407	27	1080	3	6	\N	40
10408	28	1080	2	3	\N	40
10409	29	1080	3	3	\N	60
10410	30	1080	1	3	\N	10
10411	31	1080	4	5	\N	80
10412	73	1081	0	1	\N	0
10413	74	1081	2	2	\N	40
10414	75	1081	0	2	\N	-10
10415	95	1081	3	5	\N	50
10416	96	1081	0	2	\N	-10
10417	97	1081	2	2	\N	40
10418	98	1081	0	0	\N	0
10419	1	1081	0	3	\N	-20
10420	2	1081	0	0	\N	0
10421	3	1081	0	1	\N	0
10422	4	1081	2	4	\N	30
10423	110	1082	3	3	\N	60
10424	111	1082	2	4	\N	30
10425	112	1082	1	1	\N	20
10426	113	1082	0	2	\N	-10
10427	42	1082	3	6	\N	40
10428	43	1082	2	2	\N	40
10429	44	1082	2	4	\N	30
10430	45	1082	2	3	\N	40
10431	35	1082	4	4	\N	90
10432	36	1082	4	5	\N	80
10433	37	1082	2	3	\N	40
10434	38	1082	0	0	\N	0
10435	123	1083	0	0	\N	0
10436	124	1083	3	3	\N	60
10437	125	1083	0	2	\N	-10
10438	126	1083	1	1	\N	20
10439	57	1083	3	4	\N	60
10440	58	1083	4	4	\N	90
10441	59	1083	0	1	\N	0
10442	60	1083	0	1	\N	0
10443	46	1083	2	3	\N	40
10444	47	1083	1	1	\N	20
10445	48	1083	4	4	\N	90
10446	49	1083	1	2	\N	20
10447	57	1084	4	4	\N	90
10448	58	1084	1	1	\N	20
10449	59	1084	0	1	\N	0
10450	60	1084	4	4	\N	90
10451	83	1084	0	1	\N	0
10452	84	1084	4	4	\N	90
10453	85	1084	1	1	\N	20
10454	86	1084	2	2	\N	40
10455	95	1084	4	5	\N	80
10456	96	1084	0	1	\N	0
10457	97	1084	0	1	\N	0
10458	98	1084	3	3	\N	60
10459	35	1085	3	5	\N	50
10460	36	1085	1	1	\N	20
10461	37	1085	2	3	\N	40
10462	38	1085	1	1	\N	20
10463	114	1085	4	5	\N	80
10464	115	1085	4	4	\N	90
10465	116	1085	0	2	\N	-10
10466	117	1085	4	5	\N	80
10467	91	1085	3	3	\N	60
10468	92	1085	1	1	\N	20
10469	93	1085	1	1	\N	20
10470	94	1085	3	3	\N	60
10471	123	1086	0	0	\N	0
10472	124	1086	4	4	\N	90
10473	125	1086	0	0	\N	0
10474	126	1086	1	2	\N	20
10475	118	1086	2	5	\N	20
10476	119	1086	1	1	\N	20
10477	120	1086	0	0	\N	0
10478	121	1086	2	2	\N	40
10479	122	1086	1	1	\N	20
10480	73	1086	1	2	\N	20
10481	74	1086	0	0	\N	0
10482	75	1086	2	2	\N	40
10483	8	1087	4	4	\N	90
10484	9	1087	3	3	\N	60
10485	10	1087	4	4	\N	90
10486	11	1087	2	2	\N	40
10487	12	1087	1	3	\N	10
10488	50	1087	4	5	\N	80
10489	51	1087	2	2	\N	40
10490	52	1087	3	3	\N	60
10491	53	1087	0	0	\N	0
10492	106	1087	4	4	\N	90
10493	107	1087	3	4	\N	60
10494	108	1087	2	2	\N	40
10495	109	1087	2	2	\N	40
10496	32	1088	4	4	\N	90
10497	33	1088	0	0	\N	0
10498	34	1088	2	3	\N	40
10499	61	1088	4	5	\N	80
10500	62	1088	3	4	\N	60
10501	63	1088	1	2	\N	20
10502	1	1088	3	3	\N	60
10503	2	1088	2	4	\N	30
10504	3	1088	2	2	\N	40
10505	4	1088	2	2	\N	40
10506	99	1089	1	1	\N	20
10507	100	1089	1	1	\N	20
10508	101	1089	0	0	\N	0
10509	102	1089	0	1	\N	0
10510	127	1089	4	4	\N	90
10511	128	1089	0	2	\N	-10
10512	129	1089	2	2	\N	40
10513	130	1089	4	5	\N	80
10514	79	1089	4	6	\N	70
10515	80	1089	3	4	\N	60
10516	81	1089	3	3	\N	60
10517	82	1089	0	0	\N	0
10518	54	1090	1	2	\N	20
10519	55	1090	1	3	\N	10
10520	56	1090	2	2	\N	40
10521	42	1090	1	1	\N	20
10522	43	1090	2	2	\N	40
10523	44	1090	4	4	\N	90
10524	45	1090	4	4	\N	90
10525	23	1090	4	4	\N	90
10526	24	1090	0	0	\N	0
10527	25	1090	4	4	\N	90
10528	26	1090	0	0	\N	0
10529	103	1091	4	4	\N	90
10530	104	1091	1	2	\N	20
10531	105	1091	1	3	\N	10
10532	5	1091	4	6	\N	70
10533	6	1091	2	3	\N	40
10534	7	1091	1	1	\N	20
10535	20	1091	3	4	\N	60
10536	21	1091	0	1	\N	0
10537	22	1091	0	1	\N	0
10538	64	1092	1	2	\N	20
10539	65	1092	2	2	\N	40
10540	66	1092	0	0	\N	0
10541	67	1092	1	1	\N	20
10542	68	1092	1	2	\N	20
10543	76	1092	3	5	\N	50
10544	77	1092	1	2	\N	20
10545	78	1092	1	1	\N	20
10546	87	1092	3	6	\N	40
10547	88	1092	4	6	\N	70
10548	89	1092	4	4	\N	90
10549	90	1092	0	0	\N	0
10550	110	1093	3	3	\N	60
10551	111	1093	2	2	\N	40
10552	112	1093	4	6	\N	70
10553	113	1093	1	2	\N	20
10554	17	1093	4	4	\N	90
10555	18	1093	3	3	\N	60
10556	19	1093	0	2	\N	-10
10557	69	1093	4	6	\N	70
10558	70	1093	3	3	\N	60
10559	71	1093	1	3	\N	10
10560	72	1093	1	1	\N	20
10561	39	1094	1	3	\N	10
10562	40	1094	1	1	\N	20
10563	41	1094	1	2	\N	20
10564	13	1094	2	2	\N	40
10565	14	1094	1	2	\N	20
10566	15	1094	1	3	\N	10
10567	16	1094	0	0	\N	0
10568	27	1094	0	2	\N	-10
10569	28	1094	1	1	\N	20
10570	29	1094	1	1	\N	20
10571	30	1094	4	4	\N	90
10572	31	1094	0	0	\N	0
10573	171	1099	4	4	\N	90
10574	172	1099	1	2	\N	20
10575	173	1099	3	3	\N	60
10576	131	1099	1	1	\N	20
10577	132	1099	1	2	\N	20
10578	133	1099	0	0	\N	0
10579	182	1099	3	4	\N	60
10580	183	1099	1	1	\N	20
10581	144	1100	4	6	\N	70
10582	145	1100	2	2	\N	40
10583	176	1100	4	5	\N	80
10584	177	1100	1	3	\N	10
10585	178	1100	0	0	\N	0
10586	179	1100	1	1	\N	20
10587	141	1100	4	6	\N	70
10588	142	1100	2	2	\N	40
10589	143	1100	0	2	\N	-10
10590	158	1101	2	4	\N	30
10591	159	1101	0	0	\N	0
10592	160	1101	2	4	\N	30
10593	149	1101	0	1	\N	0
10594	150	1101	1	1	\N	20
10595	151	1101	1	1	\N	20
10596	193	1101	4	5	\N	80
10597	194	1101	1	1	\N	20
10598	134	1102	3	4	\N	60
10599	135	1102	0	0	\N	0
10600	136	1102	0	0	\N	0
10601	137	1102	4	4	\N	90
10602	204	1102	1	2	\N	20
10603	205	1102	2	3	\N	40
10604	206	1102	4	4	\N	90
10605	186	1102	0	0	\N	0
10606	187	1102	0	1	\N	0
10607	188	1102	0	1	\N	0
10608	189	1102	0	2	\N	-10
10609	167	1103	1	4	\N	0
10610	168	1103	0	1	\N	0
10611	138	1103	4	5	\N	80
10612	146	1103	3	3	\N	60
10613	147	1103	0	0	\N	0
10614	148	1103	4	6	\N	70
10615	190	1104	0	2	\N	-10
10616	191	1104	3	3	\N	60
10617	192	1104	0	0	\N	0
10618	207	1104	4	4	\N	90
10619	208	1104	1	3	\N	10
10620	195	1104	4	5	\N	80
10621	196	1104	1	1	\N	20
10622	197	1104	1	1	\N	20
10623	184	1105	0	1	\N	0
10624	185	1105	2	3	\N	40
10625	174	1105	0	1	\N	0
10626	175	1105	0	1	\N	0
10627	161	1105	4	4	\N	90
10628	162	1105	1	2	\N	20
10629	163	1105	1	1	\N	20
10630	180	1106	4	4	\N	90
10631	181	1106	1	1	\N	20
10632	139	1106	4	4	\N	90
10633	140	1106	3	3	\N	60
10634	209	1106	4	5	\N	80
10635	210	1106	0	2	\N	-10
10636	211	1106	0	1	\N	0
10637	155	1107	4	6	\N	70
10638	156	1107	4	4	\N	90
10639	157	1107	0	0	\N	0
10640	202	1107	0	1	\N	0
10641	203	1107	4	5	\N	80
10642	198	1107	1	2	\N	20
10643	199	1107	2	2	\N	40
10644	200	1107	1	1	\N	20
10645	201	1107	2	2	\N	40
10646	164	1108	3	4	\N	60
10647	165	1108	1	3	\N	10
10648	166	1108	2	3	\N	40
10649	212	1108	3	4	\N	60
10650	213	1108	2	3	\N	40
10651	214	1108	3	3	\N	60
10652	152	1108	1	3	\N	10
10653	153	1108	4	4	\N	90
10654	154	1108	3	4	\N	60
10655	169	1109	2	3	\N	40
10656	170	1109	1	2	\N	20
10657	171	1109	4	5	\N	80
10658	172	1109	2	2	\N	40
10659	173	1109	2	2	\N	40
10660	202	1109	4	4	\N	90
10661	203	1109	3	3	\N	60
10662	138	1110	1	4	\N	0
10663	149	1110	4	5	\N	80
10664	150	1110	0	0	\N	0
10665	151	1110	0	1	\N	0
10666	198	1110	4	4	\N	90
10667	199	1110	1	1	\N	20
10668	200	1110	1	1	\N	20
10669	201	1110	4	4	\N	90
10670	209	1111	3	4	\N	60
10671	210	1111	2	3	\N	40
10672	211	1111	4	4	\N	90
10673	212	1111	4	5	\N	80
10674	213	1111	3	4	\N	60
10675	214	1111	1	2	\N	20
10676	190	1111	3	5	\N	50
10677	191	1111	1	3	\N	10
10678	192	1111	0	1	\N	0
10679	169	1112	4	4	\N	90
10680	170	1112	0	0	\N	0
10681	161	1112	4	5	\N	80
10682	162	1112	4	4	\N	90
10683	163	1112	1	1	\N	20
10684	176	1112	2	2	\N	40
10685	177	1112	4	4	\N	90
10686	178	1112	0	0	\N	0
10687	179	1112	4	4	\N	90
10688	146	1113	1	4	\N	0
10689	147	1113	2	2	\N	40
10690	148	1113	2	3	\N	40
10691	144	1113	4	5	\N	80
10692	145	1113	0	0	\N	0
10693	164	1113	3	4	\N	60
10694	165	1113	3	3	\N	60
10695	166	1113	0	0	\N	0
10696	195	1114	4	5	\N	80
10697	196	1114	0	0	\N	0
10698	197	1114	1	1	\N	20
10699	184	1114	2	5	\N	20
10700	185	1114	3	4	\N	60
10701	193	1114	4	5	\N	80
10702	194	1114	1	3	\N	10
10703	186	1115	0	1	\N	0
10704	187	1115	0	0	\N	0
10705	188	1115	2	2	\N	40
10706	189	1115	1	1	\N	20
10707	139	1115	4	6	\N	70
10708	140	1115	1	1	\N	20
10709	155	1115	3	5	\N	50
10710	156	1115	1	3	\N	10
10711	157	1115	4	4	\N	90
10712	182	1116	0	1	\N	0
10713	183	1116	0	0	\N	0
10714	204	1116	3	6	\N	40
10715	205	1116	3	3	\N	60
10716	206	1116	0	1	\N	0
10717	180	1116	1	2	\N	20
10718	181	1116	1	2	\N	20
10719	134	1117	4	6	\N	70
10720	135	1117	2	2	\N	40
10721	136	1117	2	2	\N	40
10722	137	1117	0	1	\N	0
10723	158	1117	4	5	\N	80
10724	159	1117	1	1	\N	20
10725	160	1117	1	2	\N	20
10726	131	1117	3	5	\N	50
10727	132	1117	3	5	\N	50
10728	133	1117	2	3	\N	40
10729	207	1118	4	5	\N	80
10730	208	1118	3	3	\N	60
10731	152	1118	4	6	\N	70
10732	153	1118	0	1	\N	0
10733	154	1118	1	1	\N	20
10734	141	1118	3	4	\N	60
10735	142	1118	3	5	\N	50
10736	143	1118	4	4	\N	90
10737	167	1119	4	4	\N	90
10738	168	1119	1	1	\N	20
10739	174	1119	4	5	\N	80
10740	175	1119	2	2	\N	40
10741	138	1119	4	5	\N	80
10742	198	1120	4	5	\N	80
10743	199	1120	0	0	\N	0
10744	200	1120	0	0	\N	0
10745	201	1120	3	3	\N	60
10746	144	1120	4	5	\N	80
10747	145	1120	3	3	\N	60
10748	202	1120	3	5	\N	50
10749	203	1120	0	2	\N	-10
10750	141	1121	3	4	\N	60
10751	142	1121	0	1	\N	0
10752	143	1121	3	3	\N	60
10753	180	1121	4	4	\N	90
10754	181	1121	1	3	\N	10
10755	207	1121	3	3	\N	60
10756	208	1121	0	2	\N	-10
10757	184	1122	1	1	\N	20
10758	185	1122	4	4	\N	90
10759	193	1122	3	4	\N	60
10760	194	1122	0	0	\N	0
10761	161	1122	2	2	\N	40
10762	162	1122	3	3	\N	60
10763	163	1122	3	4	\N	60
10764	171	1123	1	1	\N	20
10765	172	1123	1	1	\N	20
10766	173	1123	4	6	\N	70
10767	182	1123	4	5	\N	80
10768	183	1123	1	2	\N	20
10769	190	1123	4	4	\N	90
10770	191	1123	0	0	\N	0
10771	192	1123	0	0	\N	0
10772	174	1124	3	5	\N	50
10773	175	1124	1	3	\N	10
10774	134	1124	3	6	\N	40
10775	135	1124	1	1	\N	20
10776	136	1124	1	1	\N	20
10777	137	1124	2	3	\N	40
10778	149	1124	3	4	\N	60
10779	150	1124	2	3	\N	40
10780	151	1124	0	1	\N	0
10781	209	1125	4	5	\N	80
10782	210	1125	1	1	\N	20
10783	211	1125	2	2	\N	40
10784	204	1125	3	3	\N	60
10785	205	1125	1	2	\N	20
10786	206	1125	2	2	\N	40
10787	176	1125	4	5	\N	80
10788	177	1125	1	1	\N	20
10789	178	1125	3	4	\N	60
10790	179	1125	2	3	\N	40
10791	146	1126	0	3	\N	-20
10792	147	1126	2	3	\N	40
10793	148	1126	4	4	\N	90
10794	155	1126	4	4	\N	90
10795	156	1126	0	0	\N	0
10796	157	1126	1	1	\N	20
10797	131	1126	4	4	\N	90
10798	132	1126	2	4	\N	30
10799	133	1126	0	2	\N	-10
10800	186	1127	0	0	\N	0
10801	187	1127	0	2	\N	-10
10802	188	1127	1	1	\N	20
10803	189	1127	2	2	\N	40
10804	164	1127	4	5	\N	80
10805	165	1127	0	1	\N	0
10806	166	1127	0	0	\N	0
10807	167	1127	0	0	\N	0
10808	168	1127	1	3	\N	10
10809	212	1128	1	1	\N	20
10810	213	1128	4	6	\N	70
10811	214	1128	0	0	\N	0
10812	195	1128	0	1	\N	0
10813	196	1128	1	3	\N	10
10814	197	1128	0	0	\N	0
10815	169	1128	3	3	\N	60
10816	170	1128	2	3	\N	40
10817	152	1129	4	4	\N	90
10818	153	1129	0	1	\N	0
10819	154	1129	1	3	\N	10
10820	158	1129	4	5	\N	80
10821	159	1129	4	4	\N	90
10822	160	1129	4	6	\N	70
10823	139	1129	0	1	\N	0
10824	140	1129	0	1	\N	0
10825	186	1130	1	2	\N	20
10826	187	1130	0	2	\N	-10
10827	188	1130	2	2	\N	40
10828	189	1130	0	1	\N	0
10829	202	1130	3	4	\N	60
10830	203	1130	0	0	\N	0
10831	158	1130	3	4	\N	60
10832	159	1130	1	1	\N	20
10833	160	1130	0	0	\N	0
10834	134	1131	4	4	\N	90
10835	135	1131	1	1	\N	20
10836	136	1131	0	1	\N	0
10837	137	1131	1	1	\N	20
10838	152	1131	4	4	\N	90
10839	153	1131	1	1	\N	20
10840	154	1131	0	0	\N	0
10841	207	1131	3	5	\N	50
10842	208	1131	0	2	\N	-10
10843	161	1132	4	4	\N	90
10844	162	1132	1	1	\N	20
10845	163	1132	3	3	\N	60
10846	171	1132	1	3	\N	10
10847	172	1132	2	3	\N	40
10848	173	1132	1	1	\N	20
10849	144	1132	3	5	\N	50
10850	145	1132	3	3	\N	60
10851	182	1133	4	5	\N	80
10852	183	1133	1	2	\N	20
10853	164	1133	3	4	\N	60
10854	165	1133	4	6	\N	70
10855	166	1133	3	3	\N	60
10856	146	1133	4	5	\N	80
10857	147	1133	0	2	\N	-10
10858	148	1133	1	2	\N	20
10859	184	1134	0	1	\N	0
10860	185	1134	2	3	\N	40
10861	149	1134	3	3	\N	60
10862	150	1134	1	1	\N	20
10863	151	1134	0	0	\N	0
10864	204	1134	3	3	\N	60
10865	205	1134	1	1	\N	20
10866	206	1134	1	1	\N	20
10867	190	1135	3	3	\N	60
10868	191	1135	3	3	\N	60
10869	192	1135	2	2	\N	40
10870	155	1135	1	1	\N	20
10871	156	1135	0	1	\N	0
10872	157	1135	1	1	\N	20
10873	193	1135	4	5	\N	80
10874	194	1135	0	1	\N	0
10875	195	1136	4	4	\N	90
10876	196	1136	3	3	\N	60
10877	197	1136	1	2	\N	20
10878	176	1136	3	4	\N	60
10879	177	1136	0	0	\N	0
10880	178	1136	1	1	\N	20
10881	179	1136	1	1	\N	20
10882	131	1136	3	3	\N	60
10883	132	1136	1	1	\N	20
10884	133	1136	0	0	\N	0
10885	209	1137	2	3	\N	40
10886	210	1137	4	4	\N	90
10887	211	1137	0	0	\N	0
10888	138	1137	3	4	\N	60
10889	198	1137	3	4	\N	60
10890	199	1137	0	0	\N	0
10891	200	1137	0	1	\N	0
10892	201	1137	0	0	\N	0
10893	180	1138	1	2	\N	20
10894	181	1138	1	2	\N	20
10895	141	1138	2	3	\N	40
10896	142	1138	2	3	\N	40
10897	143	1138	1	1	\N	20
10898	174	1138	4	4	\N	90
10899	175	1138	0	0	\N	0
10900	169	1139	3	5	\N	50
10901	170	1139	1	1	\N	20
10902	167	1139	4	4	\N	90
10903	168	1139	1	1	\N	20
10904	212	1139	4	5	\N	80
10905	213	1139	2	3	\N	40
10906	214	1139	2	2	\N	40
10907	139	1140	1	1	\N	20
10908	140	1140	1	3	\N	10
10909	141	1140	2	2	\N	40
10910	142	1140	3	3	\N	60
10911	143	1140	1	1	\N	20
10912	164	1140	3	4	\N	60
10913	165	1140	0	0	\N	0
10914	166	1140	3	3	\N	60
10915	139	1141	4	5	\N	80
10916	140	1141	3	3	\N	60
10917	134	1141	2	2	\N	40
10918	135	1141	0	1	\N	0
10919	136	1141	1	1	\N	20
10920	137	1141	2	2	\N	40
10921	186	1141	1	1	\N	20
10922	187	1141	0	0	\N	0
10923	188	1141	1	3	\N	10
10924	189	1141	1	2	\N	20
10925	171	1142	3	4	\N	60
10926	172	1142	3	3	\N	60
10927	173	1142	1	2	\N	20
10928	207	1142	3	4	\N	60
10929	208	1142	4	4	\N	90
10930	152	1142	4	5	\N	80
10931	153	1142	0	0	\N	0
10932	154	1142	0	0	\N	0
10933	131	1143	2	3	\N	40
10934	132	1143	0	0	\N	0
10935	133	1143	0	1	\N	0
10936	198	1143	1	3	\N	10
10937	199	1143	2	3	\N	40
10938	200	1143	2	2	\N	40
10939	201	1143	1	2	\N	20
10940	146	1143	4	4	\N	90
10941	147	1143	2	2	\N	40
10942	148	1143	2	4	\N	30
10943	180	1144	3	5	\N	50
10944	181	1144	0	0	\N	0
10945	138	1144	3	6	\N	40
10946	144	1144	3	5	\N	50
10947	145	1144	0	0	\N	0
10948	209	1145	3	3	\N	60
10949	210	1145	4	4	\N	90
10950	211	1145	0	1	\N	0
10951	169	1145	0	2	\N	-10
10952	170	1145	1	1	\N	20
10953	195	1145	3	5	\N	50
10954	196	1145	3	3	\N	60
10955	197	1145	2	3	\N	40
10956	190	1146	2	4	\N	30
10957	191	1146	0	0	\N	0
10958	192	1146	2	3	\N	40
10959	193	1146	2	3	\N	40
10960	194	1146	0	0	\N	0
10961	155	1146	4	5	\N	80
10962	156	1146	0	0	\N	0
10963	157	1146	3	4	\N	60
10964	182	1147	3	3	\N	60
10965	183	1147	2	2	\N	40
10966	184	1147	0	0	\N	0
10967	185	1147	0	0	\N	0
10968	149	1147	1	1	\N	20
10969	150	1147	2	4	\N	30
10970	151	1147	3	4	\N	60
10971	174	1148	4	5	\N	80
10972	175	1148	2	2	\N	40
10973	176	1148	4	4	\N	90
10974	177	1148	1	3	\N	10
10975	178	1148	3	4	\N	60
10976	179	1148	0	2	\N	-10
10977	202	1148	3	4	\N	60
10978	203	1148	2	2	\N	40
10979	212	1149	4	4	\N	90
10980	213	1149	4	4	\N	90
10981	214	1149	2	2	\N	40
10982	167	1149	0	1	\N	0
10983	168	1149	0	2	\N	-10
10984	161	1149	1	2	\N	20
10985	162	1149	0	2	\N	-10
10986	163	1149	2	3	\N	40
10987	204	1150	3	5	\N	50
10988	205	1150	4	4	\N	90
10989	206	1150	1	1	\N	20
10990	158	1150	4	4	\N	90
10991	159	1150	0	1	\N	0
10992	160	1150	0	0	\N	0
10993	149	1150	0	1	\N	0
10994	150	1150	2	3	\N	40
10995	151	1150	3	3	\N	60
10996	176	1151	2	4	\N	30
10997	177	1151	2	2	\N	40
10998	178	1151	3	3	\N	60
10999	179	1151	0	1	\N	0
11000	209	1151	4	4	\N	90
11001	210	1151	2	2	\N	40
11002	211	1151	2	2	\N	40
11003	186	1151	0	1	\N	0
11004	187	1151	0	0	\N	0
11005	188	1151	1	2	\N	20
11006	189	1151	3	3	\N	60
11007	161	1152	3	6	\N	40
11008	162	1152	1	1	\N	20
11009	163	1152	1	2	\N	20
11010	131	1152	3	4	\N	60
11011	132	1152	0	1	\N	0
11012	133	1152	1	1	\N	20
11013	167	1152	0	0	\N	0
11014	168	1152	2	2	\N	40
11015	174	1153	3	4	\N	60
11016	175	1153	1	3	\N	10
11017	171	1153	4	6	\N	70
11018	172	1153	1	1	\N	20
11019	173	1153	1	1	\N	20
11020	195	1153	3	5	\N	50
11021	196	1153	3	4	\N	60
11022	197	1153	1	3	\N	10
11023	144	1154	2	5	\N	20
11024	145	1154	1	1	\N	20
11025	184	1154	3	3	\N	60
11026	185	1154	4	4	\N	90
11027	190	1154	3	4	\N	60
11028	191	1154	0	0	\N	0
11029	192	1154	4	5	\N	80
11030	182	1155	3	5	\N	50
11031	183	1155	0	0	\N	0
11032	204	1155	4	5	\N	80
11033	205	1155	2	2	\N	40
11034	206	1155	2	3	\N	40
11035	134	1155	3	5	\N	50
11036	135	1155	1	1	\N	20
11037	136	1155	2	4	\N	30
11038	137	1155	2	3	\N	40
11039	180	1156	3	4	\N	60
11040	181	1156	0	0	\N	0
11041	207	1156	1	3	\N	10
11042	208	1156	0	0	\N	0
11043	152	1156	1	1	\N	20
11044	153	1156	1	1	\N	20
11045	154	1156	3	4	\N	60
11046	146	1157	4	4	\N	90
11047	147	1157	1	1	\N	20
11048	148	1157	0	0	\N	0
11049	169	1157	4	4	\N	90
11050	170	1157	1	1	\N	20
11051	155	1157	3	5	\N	50
11052	156	1157	0	1	\N	0
11053	157	1157	2	2	\N	40
11054	212	1158	4	5	\N	80
11055	213	1158	0	0	\N	0
11056	214	1158	0	2	\N	-10
11057	139	1158	4	4	\N	90
11058	140	1158	2	2	\N	40
11059	164	1158	2	2	\N	40
11060	165	1158	2	2	\N	40
11061	166	1158	1	1	\N	20
11062	202	1159	3	3	\N	60
11063	203	1159	1	2	\N	20
11064	198	1159	3	3	\N	60
11065	199	1159	4	4	\N	90
11066	200	1159	2	3	\N	40
11067	201	1159	3	3	\N	60
11068	138	1159	4	4	\N	90
11069	193	1160	3	3	\N	60
11070	194	1160	3	3	\N	60
11071	158	1160	3	3	\N	60
11072	159	1160	0	0	\N	0
11073	160	1160	1	1	\N	20
11074	141	1160	4	5	\N	80
11075	142	1160	0	0	\N	0
11076	143	1160	3	5	\N	50
11077	238	1162	4	5	\N	80
11078	239	1162	1	1	\N	20
11079	240	1162	1	1	\N	20
11080	241	1162	2	3	\N	40
11081	249	1162	4	5	\N	80
11082	250	1162	0	0	\N	0
11083	251	1162	4	4	\N	90
11084	252	1162	1	1	\N	20
11085	256	1162	3	4	\N	60
11086	257	1162	0	0	\N	0
11087	258	1162	0	2	\N	-10
11088	259	1162	2	2	\N	40
11089	263	1163	4	4	\N	90
11090	264	1163	2	2	\N	40
11091	265	1163	3	3	\N	60
11092	218	1163	0	1	\N	0
11093	219	1163	2	2	\N	40
11094	220	1163	2	2	\N	40
11095	269	1163	4	5	\N	80
11096	270	1163	1	1	\N	20
11097	271	1163	1	1	\N	20
11098	272	1163	2	2	\N	40
11099	260	1164	3	5	\N	50
11100	261	1164	0	1	\N	0
11101	262	1164	1	3	\N	10
11102	224	1164	4	5	\N	80
11103	225	1164	0	0	\N	0
11104	226	1164	1	1	\N	20
11105	227	1164	1	1	\N	20
11106	253	1164	4	6	\N	70
11107	254	1164	1	1	\N	20
11108	255	1164	3	3	\N	60
11109	235	1165	2	3	\N	40
11110	236	1165	0	1	\N	0
11111	237	1165	2	2	\N	40
11112	232	1165	2	4	\N	30
11113	233	1165	1	1	\N	20
11114	234	1165	1	1	\N	20
11115	228	1165	4	4	\N	90
11116	229	1165	2	2	\N	40
11117	230	1165	1	1	\N	20
11118	231	1165	3	3	\N	60
11119	266	1166	4	5	\N	80
11120	267	1166	0	0	\N	0
11121	268	1166	2	3	\N	40
11122	242	1166	1	3	\N	10
11123	243	1166	1	3	\N	10
11124	244	1166	2	2	\N	40
11125	221	1166	3	6	\N	40
11126	222	1166	0	0	\N	0
11127	223	1166	0	0	\N	0
11128	215	1167	3	3	\N	60
11129	216	1167	3	3	\N	60
11130	217	1167	0	0	\N	0
11131	245	1167	4	5	\N	80
11132	246	1167	2	2	\N	40
11133	247	1167	1	2	\N	20
11134	248	1167	0	0	\N	0
11135	228	1167	0	2	\N	-10
11136	229	1167	1	1	\N	20
11137	230	1167	2	2	\N	40
11138	231	1167	3	4	\N	60
11139	221	1168	2	2	\N	40
11140	222	1168	1	2	\N	20
11141	223	1168	0	0	\N	0
11142	253	1168	4	4	\N	90
11143	254	1168	2	2	\N	40
11144	255	1168	2	4	\N	30
11145	266	1168	3	4	\N	60
11146	267	1168	0	1	\N	0
11147	268	1168	4	4	\N	90
11148	269	1169	1	3	\N	10
11149	270	1169	1	1	\N	20
11150	271	1169	3	3	\N	60
11151	272	1169	0	0	\N	0
11152	245	1169	3	3	\N	60
11153	246	1169	3	3	\N	60
11154	247	1169	4	5	\N	80
11155	248	1169	0	0	\N	0
11156	232	1169	4	5	\N	80
11157	233	1169	2	2	\N	40
11158	234	1169	0	0	\N	0
11159	218	1170	2	3	\N	40
11160	219	1170	1	1	\N	20
11161	220	1170	0	0	\N	0
11162	242	1170	1	3	\N	10
11163	243	1170	1	1	\N	20
11164	244	1170	4	6	\N	70
11165	260	1170	4	4	\N	90
11166	261	1170	1	1	\N	20
11167	262	1170	1	1	\N	20
11168	224	1171	3	6	\N	40
11169	225	1171	1	3	\N	10
11170	226	1171	2	2	\N	40
11171	227	1171	1	1	\N	20
11172	256	1171	4	4	\N	90
11173	257	1171	3	3	\N	60
11174	258	1171	1	1	\N	20
11175	259	1171	0	1	\N	0
11176	249	1171	3	3	\N	60
11177	250	1171	2	2	\N	40
11178	251	1171	4	5	\N	80
11179	252	1171	4	5	\N	80
11180	215	1172	3	5	\N	50
11181	216	1172	1	1	\N	20
11182	217	1172	2	2	\N	40
11183	263	1172	0	0	\N	0
11184	264	1172	0	1	\N	0
11185	265	1172	4	4	\N	90
11186	235	1172	4	6	\N	70
11187	236	1172	2	2	\N	40
11188	237	1172	1	3	\N	10
11189	238	1173	1	3	\N	10
11190	239	1173	4	4	\N	90
11191	240	1173	1	1	\N	20
11192	241	1173	3	4	\N	60
11193	224	1173	2	2	\N	40
11194	225	1173	0	0	\N	0
11195	226	1173	4	4	\N	90
11196	227	1173	0	2	\N	-10
11197	269	1173	3	4	\N	60
11198	270	1173	3	5	\N	50
11199	271	1173	0	0	\N	0
11200	272	1173	4	4	\N	90
11201	221	1174	4	6	\N	70
11202	222	1174	0	1	\N	0
11203	223	1174	1	1	\N	20
11204	256	1174	4	5	\N	80
11205	257	1174	2	2	\N	40
11206	258	1174	4	4	\N	90
11207	259	1174	1	1	\N	20
11208	263	1174	3	4	\N	60
11209	264	1174	1	1	\N	20
11210	265	1174	1	1	\N	20
11211	253	1175	4	6	\N	70
11212	254	1175	2	4	\N	30
11213	255	1175	3	3	\N	60
11214	249	1175	4	4	\N	90
11215	250	1175	0	0	\N	0
11216	251	1175	1	1	\N	20
11217	252	1175	0	1	\N	0
11218	242	1175	3	6	\N	40
11219	243	1175	1	2	\N	20
11220	244	1175	1	3	\N	10
11221	215	1176	2	2	\N	40
11222	216	1176	0	2	\N	-10
11223	217	1176	0	0	\N	0
11224	228	1176	4	5	\N	80
11225	229	1176	0	1	\N	0
11226	230	1176	0	0	\N	0
11227	231	1176	1	1	\N	20
11228	238	1176	4	4	\N	90
11229	239	1176	2	2	\N	40
11230	240	1176	2	2	\N	40
11231	241	1176	2	4	\N	30
11232	235	1177	4	4	\N	90
11233	236	1177	1	1	\N	20
11234	237	1177	3	5	\N	50
11235	245	1177	3	3	\N	60
11236	246	1177	1	1	\N	20
11237	247	1177	3	3	\N	60
11238	248	1177	3	3	\N	60
11239	260	1177	2	3	\N	40
11240	261	1177	2	2	\N	40
11241	262	1177	0	0	\N	0
11242	218	1178	2	3	\N	40
11243	219	1178	1	1	\N	20
11244	220	1178	0	2	\N	-10
11245	232	1178	1	3	\N	10
11246	233	1178	1	2	\N	20
11247	234	1178	4	5	\N	80
11248	266	1178	3	5	\N	50
11249	267	1178	0	0	\N	0
11250	268	1178	1	3	\N	10
11251	224	1179	3	4	\N	60
11252	225	1179	1	1	\N	20
11253	226	1179	2	2	\N	40
11254	227	1179	2	2	\N	40
11255	242	1179	1	3	\N	10
11256	243	1179	1	2	\N	20
11257	244	1179	4	4	\N	90
11258	215	1179	4	5	\N	80
11259	216	1179	1	1	\N	20
11260	217	1179	0	0	\N	0
11261	232	1180	4	5	\N	80
11262	233	1180	1	1	\N	20
11263	234	1180	0	0	\N	0
11264	263	1180	2	4	\N	30
11265	264	1180	0	0	\N	0
11266	265	1180	2	2	\N	40
11267	238	1180	3	5	\N	50
11268	239	1180	0	0	\N	0
11269	240	1180	0	0	\N	0
11270	241	1180	1	1	\N	20
11271	221	1181	0	0	\N	0
11272	222	1181	4	4	\N	90
11273	223	1181	1	1	\N	20
11274	260	1181	3	6	\N	40
11275	261	1181	0	2	\N	-10
11276	262	1181	2	2	\N	40
11277	256	1181	3	6	\N	40
11278	257	1181	3	3	\N	60
11279	258	1181	1	2	\N	20
11280	259	1181	1	1	\N	20
11281	249	1182	1	3	\N	10
11282	250	1182	0	0	\N	0
11283	251	1182	2	2	\N	40
11284	252	1182	1	1	\N	20
11285	218	1182	0	1	\N	0
11286	219	1182	2	2	\N	40
11287	220	1182	2	2	\N	40
11288	253	1182	1	2	\N	20
11289	254	1182	0	0	\N	0
11290	255	1182	2	2	\N	40
11291	266	1183	0	0	\N	0
11292	267	1183	0	0	\N	0
11293	268	1183	0	2	\N	-10
11294	269	1183	4	4	\N	90
11295	270	1183	1	1	\N	20
11296	271	1183	2	2	\N	40
11297	272	1183	2	2	\N	40
11298	245	1183	4	5	\N	80
11299	246	1183	0	0	\N	0
11300	247	1183	1	1	\N	20
11301	248	1183	3	4	\N	60
11302	228	1184	1	3	\N	10
11303	229	1184	1	2	\N	20
11304	230	1184	2	2	\N	40
11305	231	1184	0	0	\N	0
11306	235	1184	4	4	\N	90
11307	236	1184	0	2	\N	-10
11308	237	1184	0	0	\N	0
11309	266	1184	4	6	\N	70
11310	267	1184	2	3	\N	40
11311	268	1184	0	0	\N	0
11312	245	1185	3	3	\N	60
11313	246	1185	1	1	\N	20
11314	247	1185	2	3	\N	40
11315	248	1185	0	0	\N	0
11316	260	1185	4	5	\N	80
11317	261	1185	0	1	\N	0
11318	262	1185	4	6	\N	70
11319	224	1185	3	3	\N	60
11320	225	1185	3	3	\N	60
11321	226	1185	1	1	\N	20
11322	227	1185	0	0	\N	0
11323	228	1186	0	2	\N	-10
11324	229	1186	0	0	\N	0
11325	230	1186	0	0	\N	0
11326	231	1186	0	0	\N	0
11327	215	1186	3	3	\N	60
11328	216	1186	1	1	\N	20
11329	217	1186	1	1	\N	20
11330	221	1186	4	4	\N	90
11331	222	1186	4	6	\N	70
11332	223	1186	2	2	\N	40
11333	249	1187	3	6	\N	40
11334	250	1187	0	0	\N	0
11335	251	1187	1	1	\N	20
11336	252	1187	4	5	\N	80
11337	232	1187	4	4	\N	90
11338	233	1187	2	4	\N	30
11339	234	1187	1	1	\N	20
11340	238	1187	4	6	\N	70
11341	239	1187	4	4	\N	90
11342	240	1187	0	1	\N	0
11343	241	1187	2	3	\N	40
11344	269	1188	4	5	\N	80
11345	270	1188	0	0	\N	0
11346	271	1188	1	3	\N	10
11347	272	1188	1	1	\N	20
11348	218	1188	1	4	\N	0
11349	219	1188	0	2	\N	-10
11350	220	1188	0	0	\N	0
11351	242	1188	1	1	\N	20
11352	243	1188	3	4	\N	60
11353	244	1188	1	1	\N	20
11354	253	1189	1	2	\N	20
11355	254	1189	0	1	\N	0
11356	255	1189	0	0	\N	0
11357	235	1189	2	4	\N	30
11358	236	1189	0	2	\N	-10
11359	237	1189	3	5	\N	50
11360	256	1189	3	4	\N	60
11361	257	1189	2	3	\N	40
11362	258	1189	0	0	\N	0
11363	259	1189	1	3	\N	10
11364	263	1190	2	5	\N	20
11365	264	1190	0	1	\N	0
11366	265	1190	0	1	\N	0
11367	263	1190	1	3	\N	10
11368	264	1190	3	3	\N	60
11369	265	1190	2	3	\N	40
11370	266	1190	4	4	\N	90
11371	267	1190	1	3	\N	10
11372	268	1190	0	2	\N	-10
11373	224	1191	4	4	\N	90
11374	225	1191	2	2	\N	40
11375	226	1191	2	2	\N	40
11376	227	1191	3	5	\N	50
11377	256	1191	2	4	\N	30
11378	257	1191	0	0	\N	0
11379	258	1191	4	4	\N	90
11380	259	1191	4	4	\N	90
11381	245	1191	2	4	\N	30
11382	246	1191	0	0	\N	0
11383	247	1191	1	1	\N	20
11384	248	1191	0	1	\N	0
11385	221	1192	4	4	\N	90
11386	222	1192	2	2	\N	40
11387	223	1192	2	3	\N	40
11388	242	1192	0	2	\N	-10
11389	243	1192	4	4	\N	90
11390	244	1192	1	2	\N	20
11391	269	1192	2	2	\N	40
11392	270	1192	3	3	\N	60
11393	271	1192	2	2	\N	40
11394	272	1192	0	1	\N	0
11395	218	1193	2	3	\N	40
11396	219	1193	1	1	\N	20
11397	220	1193	1	2	\N	20
11398	249	1193	2	4	\N	30
11399	250	1193	2	3	\N	40
11400	251	1193	0	0	\N	0
11401	252	1193	1	2	\N	20
11402	228	1193	1	2	\N	20
11403	229	1193	4	5	\N	80
11404	230	1193	1	1	\N	20
11405	231	1193	4	5	\N	80
11406	260	1194	2	3	\N	40
11407	261	1194	1	3	\N	10
11408	262	1194	1	2	\N	20
11409	253	1194	4	5	\N	80
11410	254	1194	1	1	\N	20
11411	255	1194	1	1	\N	20
11412	238	1194	4	5	\N	80
11413	239	1194	0	1	\N	0
11414	240	1194	2	3	\N	40
11415	241	1194	2	3	\N	40
11416	235	1195	3	5	\N	50
11417	236	1195	4	4	\N	90
11418	237	1195	1	1	\N	20
11419	215	1195	3	3	\N	60
11420	216	1195	1	1	\N	20
11421	217	1195	0	2	\N	-10
11422	232	1195	3	6	\N	40
11423	233	1195	3	4	\N	60
11424	234	1195	0	1	\N	0
\.


--
-- Name: student_quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('student_quizzes_id_seq', 11424, true);


--
-- Data for Name: student_teams; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY student_teams (id, student_id, team_id, is_captain, present, start_date, end_date, seat) FROM stdin;
1	1	1	t	t	2014-09-01	\N	1
2	2	1	f	t	2014-09-01	\N	2
3	3	1	f	t	2014-09-01	\N	3
4	4	1	f	t	2014-09-01	\N	4
5	5	2	t	t	2014-09-01	\N	5
6	6	2	f	t	2014-09-01	\N	6
7	7	2	f	t	2014-09-01	\N	7
8	8	3	t	t	2014-09-01	\N	8
9	9	3	f	t	2014-09-01	\N	9
10	10	3	f	t	2014-09-01	\N	10
11	11	3	f	t	2014-09-01	\N	11
12	12	3	f	t	2014-09-01	\N	12
13	13	4	t	t	2014-09-01	\N	13
14	14	4	f	t	2014-09-01	\N	14
15	15	4	f	t	2014-09-01	\N	15
16	16	4	f	t	2014-09-01	\N	16
17	17	5	t	t	2014-09-01	\N	17
18	18	5	f	t	2014-09-01	\N	18
19	19	5	f	t	2014-09-01	\N	19
20	20	6	t	t	2014-09-01	\N	20
21	21	6	f	t	2014-09-01	\N	21
22	22	6	f	t	2014-09-01	\N	22
23	23	7	t	t	2014-09-01	\N	23
24	24	7	f	t	2014-09-01	\N	24
25	25	7	f	t	2014-09-01	\N	25
26	26	7	f	t	2014-09-01	\N	26
27	27	8	t	t	2014-09-01	\N	27
28	28	8	f	t	2014-09-01	\N	28
29	29	8	f	t	2014-09-01	\N	29
30	30	8	f	t	2014-09-01	\N	30
31	31	8	f	t	2014-09-01	\N	31
32	32	15	t	t	2014-09-01	\N	32
33	33	15	f	t	2014-09-01	\N	33
34	34	15	f	t	2014-09-01	\N	34
35	35	16	t	t	2014-09-01	\N	35
36	36	16	f	t	2014-09-01	\N	36
37	37	16	f	t	2014-09-01	\N	37
38	38	16	f	t	2014-09-01	\N	38
39	39	17	t	t	2014-09-01	\N	39
40	40	17	f	t	2014-09-01	\N	40
41	41	17	f	t	2014-09-01	\N	41
42	42	22	t	t	2014-09-01	\N	42
43	43	22	f	t	2014-09-01	\N	43
44	44	22	f	t	2014-09-01	\N	44
45	45	22	f	t	2014-09-01	\N	45
46	46	23	t	t	2014-09-01	\N	46
47	47	23	f	t	2014-09-01	\N	47
48	48	23	f	t	2014-09-01	\N	48
49	49	23	f	t	2014-09-01	\N	49
50	50	24	t	t	2014-09-01	\N	50
51	51	24	f	t	2014-09-01	\N	51
52	52	24	f	t	2014-09-01	\N	52
53	53	24	f	t	2014-09-01	\N	53
54	54	28	t	t	2014-09-01	\N	54
55	55	28	f	t	2014-09-01	\N	55
56	56	28	f	t	2014-09-01	\N	56
57	57	29	t	t	2014-09-01	\N	57
58	58	29	f	t	2014-09-01	\N	58
59	59	29	f	t	2014-09-01	\N	59
60	60	29	f	t	2014-09-01	\N	60
61	61	30	t	t	2014-09-01	\N	61
62	62	30	f	t	2014-09-01	\N	62
63	63	30	f	t	2014-09-01	\N	63
64	64	35	t	t	2014-09-01	\N	64
65	65	35	f	t	2014-09-01	\N	65
66	66	35	f	t	2014-09-01	\N	66
67	67	35	f	t	2014-09-01	\N	67
68	68	35	f	t	2014-09-01	\N	68
69	69	36	t	t	2014-09-01	\N	69
70	70	36	f	t	2014-09-01	\N	70
71	71	36	f	t	2014-09-01	\N	71
72	72	36	f	t	2014-09-01	\N	72
73	73	37	t	t	2014-09-01	\N	73
74	74	37	f	t	2014-09-01	\N	74
75	75	37	f	t	2014-09-01	\N	75
76	76	41	t	t	2014-09-01	\N	76
77	77	41	f	t	2014-09-01	\N	77
78	78	41	f	t	2014-09-01	\N	78
79	79	50	t	t	2014-09-01	\N	79
80	80	50	f	t	2014-09-01	\N	80
81	81	50	f	t	2014-09-01	\N	81
82	82	50	f	t	2014-09-01	\N	82
83	83	55	t	t	2014-09-01	\N	83
84	84	55	f	t	2014-09-01	\N	84
85	85	55	f	t	2014-09-01	\N	85
86	86	55	f	t	2014-09-01	\N	86
87	87	64	t	t	2014-09-01	\N	87
88	88	64	f	t	2014-09-01	\N	88
89	89	64	f	t	2014-09-01	\N	89
90	90	64	f	t	2014-09-01	\N	90
91	91	65	t	t	2014-09-01	\N	91
92	92	65	f	t	2014-09-01	\N	92
93	93	65	f	t	2014-09-01	\N	93
94	94	65	f	t	2014-09-01	\N	94
95	95	66	t	t	2014-09-01	\N	95
96	96	66	f	t	2014-09-01	\N	96
97	97	66	f	t	2014-09-01	\N	97
98	98	66	f	t	2014-09-01	\N	98
99	99	59	t	t	2014-09-01	\N	99
100	100	59	f	t	2014-09-01	\N	100
101	101	59	f	t	2014-09-01	\N	101
102	102	59	f	t	2014-09-01	\N	102
103	103	60	t	t	2014-09-01	\N	103
104	104	60	f	t	2014-09-01	\N	104
105	105	60	f	t	2014-09-01	\N	105
106	106	45	t	t	2014-09-01	\N	106
107	107	45	f	t	2014-09-01	\N	107
108	108	45	f	t	2014-09-01	\N	108
109	109	45	f	t	2014-09-01	\N	109
110	110	71	t	t	2014-09-01	\N	110
111	111	71	f	t	2014-09-01	\N	111
112	112	71	f	t	2014-09-01	\N	112
113	113	71	f	t	2014-09-01	\N	113
114	114	72	t	t	2014-09-01	\N	114
115	115	72	f	t	2014-09-01	\N	115
116	116	72	f	t	2014-09-01	\N	116
117	117	72	f	t	2014-09-01	\N	117
118	118	73	t	t	2014-09-01	\N	118
119	119	73	f	t	2014-09-01	\N	119
120	120	73	f	t	2014-09-01	\N	120
121	121	73	f	t	2014-09-01	\N	121
122	122	73	f	t	2014-09-01	\N	122
123	123	76	t	t	2014-09-01	\N	123
124	124	76	f	t	2014-09-01	\N	124
125	125	76	f	t	2014-09-01	\N	125
126	126	76	f	t	2014-09-01	\N	126
127	127	79	t	t	2014-09-01	\N	127
128	128	79	f	t	2014-09-01	\N	128
129	129	79	f	t	2014-09-01	\N	129
130	130	79	f	t	2014-09-01	\N	130
131	131	9	t	t	2014-09-01	\N	1
132	132	9	f	t	2014-09-01	\N	2
133	133	9	f	t	2014-09-01	\N	3
134	134	10	t	t	2014-09-01	\N	4
135	135	10	f	t	2014-09-01	\N	5
136	136	10	f	t	2014-09-01	\N	6
137	137	10	f	t	2014-09-01	\N	7
138	138	11	t	t	2014-09-01	\N	8
139	139	12	t	t	2014-09-01	\N	9
140	140	12	f	t	2014-09-01	\N	10
141	141	13	t	t	2014-09-01	\N	11
142	142	13	f	t	2014-09-01	\N	12
143	143	13	f	t	2014-09-01	\N	13
144	144	18	t	t	2014-09-01	\N	14
145	145	18	f	t	2014-09-01	\N	15
146	146	19	t	t	2014-09-01	\N	16
147	147	19	f	t	2014-09-01	\N	17
148	148	19	f	t	2014-09-01	\N	18
149	149	25	t	t	2014-09-01	\N	19
150	150	25	f	t	2014-09-01	\N	20
151	151	25	f	t	2014-09-01	\N	21
152	152	26	t	t	2014-09-01	\N	22
153	153	26	f	t	2014-09-01	\N	23
154	154	26	f	t	2014-09-01	\N	24
155	155	31	t	t	2014-09-01	\N	25
156	156	31	f	t	2014-09-01	\N	26
157	157	31	f	t	2014-09-01	\N	27
158	158	32	t	t	2014-09-01	\N	28
159	159	32	f	t	2014-09-01	\N	29
160	160	32	f	t	2014-09-01	\N	30
161	161	33	t	t	2014-09-01	\N	31
162	162	33	f	t	2014-09-01	\N	32
163	163	33	f	t	2014-09-01	\N	33
164	164	38	t	t	2014-09-01	\N	34
165	165	38	f	t	2014-09-01	\N	35
166	166	38	f	t	2014-09-01	\N	36
167	167	39	t	t	2014-09-01	\N	37
168	168	39	f	t	2014-09-01	\N	38
169	169	42	t	t	2014-09-01	\N	39
170	170	42	f	t	2014-09-01	\N	40
171	171	43	t	t	2014-09-01	\N	41
172	172	43	f	t	2014-09-01	\N	42
173	173	43	f	t	2014-09-01	\N	43
174	174	51	t	t	2014-09-01	\N	44
175	175	51	f	t	2014-09-01	\N	45
176	176	52	t	t	2014-09-01	\N	46
177	177	52	f	t	2014-09-01	\N	47
178	178	52	f	t	2014-09-01	\N	48
179	179	52	f	t	2014-09-01	\N	49
180	180	53	t	t	2014-09-01	\N	50
181	181	53	f	t	2014-09-01	\N	51
182	182	56	t	t	2014-09-01	\N	52
183	183	56	f	t	2014-09-01	\N	53
184	184	57	t	t	2014-09-01	\N	54
185	185	57	f	t	2014-09-01	\N	55
186	186	67	t	t	2014-09-01	\N	56
187	187	67	f	t	2014-09-01	\N	57
188	188	67	f	t	2014-09-01	\N	58
189	189	67	f	t	2014-09-01	\N	59
190	190	68	t	t	2014-09-01	\N	60
191	191	68	f	t	2014-09-01	\N	61
192	192	68	f	t	2014-09-01	\N	62
193	193	61	t	t	2014-09-01	\N	63
194	194	61	f	t	2014-09-01	\N	64
195	195	62	t	t	2014-09-01	\N	65
196	196	62	f	t	2014-09-01	\N	66
197	197	62	f	t	2014-09-01	\N	67
198	198	46	t	t	2014-09-01	\N	68
199	199	46	f	t	2014-09-01	\N	69
200	200	46	f	t	2014-09-01	\N	70
201	201	46	f	t	2014-09-01	\N	71
202	202	47	t	t	2014-09-01	\N	72
203	203	47	f	t	2014-09-01	\N	73
204	204	48	t	t	2014-09-01	\N	74
205	205	48	f	t	2014-09-01	\N	75
206	206	48	f	t	2014-09-01	\N	76
207	207	74	t	t	2014-09-01	\N	77
208	208	74	f	t	2014-09-01	\N	78
209	209	77	t	t	2014-09-01	\N	79
210	210	77	f	t	2014-09-01	\N	80
211	211	77	f	t	2014-09-01	\N	81
212	212	80	t	t	2014-09-01	\N	82
213	213	80	f	t	2014-09-01	\N	83
214	214	80	f	t	2014-09-01	\N	84
215	215	14	t	t	2014-09-01	\N	1
216	216	14	f	t	2014-09-01	\N	2
217	217	14	f	t	2014-09-01	\N	3
218	218	20	t	t	2014-09-01	\N	4
219	219	20	f	t	2014-09-01	\N	5
220	220	20	f	t	2014-09-01	\N	6
221	221	21	t	t	2014-09-01	\N	7
222	222	21	f	t	2014-09-01	\N	8
223	223	21	f	t	2014-09-01	\N	9
224	224	27	t	t	2014-09-01	\N	10
225	225	27	f	t	2014-09-01	\N	11
226	226	27	f	t	2014-09-01	\N	12
227	227	27	f	t	2014-09-01	\N	13
228	228	34	t	t	2014-09-01	\N	14
229	229	34	f	t	2014-09-01	\N	15
230	230	34	f	t	2014-09-01	\N	16
231	231	34	f	t	2014-09-01	\N	17
232	232	40	t	t	2014-09-01	\N	18
233	233	40	f	t	2014-09-01	\N	19
234	234	40	f	t	2014-09-01	\N	20
235	235	44	t	t	2014-09-01	\N	21
236	236	44	f	t	2014-09-01	\N	22
237	237	44	f	t	2014-09-01	\N	23
238	238	54	t	t	2014-09-01	\N	24
239	239	54	f	t	2014-09-01	\N	25
240	240	54	f	t	2014-09-01	\N	26
241	241	54	f	t	2014-09-01	\N	27
242	242	58	t	t	2014-09-01	\N	28
243	243	58	f	t	2014-09-01	\N	29
244	244	58	f	t	2014-09-01	\N	30
245	245	69	t	t	2014-09-01	\N	31
246	246	69	f	t	2014-09-01	\N	32
247	247	69	f	t	2014-09-01	\N	33
248	248	69	f	t	2014-09-01	\N	34
249	249	70	t	t	2014-09-01	\N	35
250	250	70	f	t	2014-09-01	\N	36
251	251	70	f	t	2014-09-01	\N	37
252	252	70	f	t	2014-09-01	\N	38
253	253	63	t	t	2014-09-01	\N	39
254	254	63	f	t	2014-09-01	\N	40
255	255	63	f	t	2014-09-01	\N	41
256	256	49	t	t	2014-09-01	\N	42
257	257	49	f	t	2014-09-01	\N	43
258	258	49	f	t	2014-09-01	\N	44
259	259	49	f	t	2014-09-01	\N	45
260	260	75	t	t	2014-09-01	\N	46
261	261	75	f	t	2014-09-01	\N	47
262	262	75	f	t	2014-09-01	\N	48
263	263	78	t	t	2014-09-01	\N	49
264	264	78	f	t	2014-09-01	\N	50
265	265	78	f	t	2014-09-01	\N	51
266	266	81	t	t	2014-09-01	\N	52
267	267	81	f	t	2014-09-01	\N	53
268	268	81	f	t	2014-09-01	\N	54
269	269	82	t	t	2014-09-01	\N	55
270	270	82	f	t	2014-09-01	\N	56
271	271	82	f	t	2014-09-01	\N	57
272	272	82	f	t	2014-09-01	\N	58
\.


--
-- Name: student_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('student_teams_id_seq', 272, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY students (id, first_name, last_name, grade, active) FROM stdin;
1	Bethel	Stracke	3	t
2	Savanah	Bernhard	3	t
3	Mabel	Hoeger	6	t
4	Jeanette	Waters	5	t
5	Jacynthe	Krajcik	4	t
6	Macy	Upton	3	t
7	Caden	Bayer	3	t
8	Tracey	Greenholt	5	t
9	Wava	Altenwerth	4	t
10	Montana	Price	6	t
11	Lexie	Marquardt	5	t
12	Rowan	Haag	6	t
13	Arne	Koss	5	t
14	Alta	Schneider	5	t
15	Aurore	Nader	4	t
16	Austyn	Spencer	3	t
17	Delfina	Hyatt	4	t
18	Lue	Barton	6	t
19	Dion	Tremblay	4	t
20	Mikel	Nienow	3	t
21	Makenzie	Heidenreich	6	t
22	Aubree	Stamm	3	t
23	Dallin	Larson	3	t
24	Flavio	Bauch	3	t
25	Dayton	Schmitt	3	t
26	Frieda	Vandervort	3	t
27	Ada	Bergstrom	5	t
28	Edwin	Gerlach	3	t
29	Nia	Ward	3	t
30	Baron	Conn	3	t
31	Evangeline	D'Amore	3	t
32	Hassie	Champlin	6	t
33	Amya	Witting	6	t
34	Horacio	Jacobson	5	t
35	Amira	Orn	6	t
36	Ezra	Russel	4	t
37	Aliyah	Steuber	3	t
38	Aditya	Schneider	3	t
39	Kenneth	Olson	5	t
40	Iva	Little	6	t
41	Astrid	Tromp	3	t
42	Vada	Stroman	4	t
43	Annabell	Harris	4	t
44	Gino	Quitzon	4	t
45	Lori	Lubowitz	6	t
46	Reta	Kuhn	4	t
47	Ryley	Skiles	3	t
48	Lilliana	Murphy	3	t
49	Ewell	Ernser	5	t
50	Brendon	Corwin	6	t
51	Darwin	Maggio	3	t
52	Amanda	Mertz	5	t
53	Elody	Kassulke	3	t
54	Vicenta	Feeney	3	t
55	Nannie	Dibbert	3	t
56	Darryl	Wunsch	5	t
57	Willa	Schmeler	4	t
58	Keshaun	Daniel	6	t
59	Sonya	Mitchell	4	t
60	Janie	Weissnat	3	t
61	Arely	Sipes	4	t
62	Billie	Durgan	6	t
63	Bertrand	Auer	5	t
64	Orie	Dach	5	t
65	Antonia	Runolfsson	6	t
66	Marcus	Mayer	4	t
67	Kavon	Runolfsdottir	5	t
68	Caesar	Orn	6	t
69	Faye	Casper	6	t
70	Ruth	Flatley	5	t
71	Ludie	Spencer	6	t
72	Kellen	Lang	5	t
73	Ronaldo	O'Kon	5	t
74	Kayla	Leuschke	5	t
75	Dedric	Runolfsson	4	t
76	Riley	Waelchi	3	t
77	Dexter	Emmerich	5	t
78	Electa	Hodkiewicz	6	t
79	Kareem	Haley	5	t
80	Sven	Jacobson	5	t
81	Danny	Walter	4	t
82	Rusty	Schmidt	3	t
83	Larry	Vandervort	4	t
84	Kellie	Casper	4	t
85	Bonita	Sawayn	5	t
86	Skye	Bogisich	3	t
87	Nathaniel	Waelchi	4	t
88	Margaret	Anderson	4	t
89	Barney	Schneider	5	t
90	Lea	Champlin	5	t
91	Buddy	VonRueden	6	t
92	Alec	Farrell	3	t
93	Don	Mante	3	t
94	Brittany	Swift	3	t
95	Sadie	Ankunding	5	t
96	Carole	Klocko	3	t
97	Keshawn	Waters	4	t
98	Demario	Watsica	6	t
99	Annamae	Mueller	4	t
100	Alessandra	Von	3	t
101	Karelle	Oberbrunner	3	t
102	Lauriane	Miller	5	t
103	Brody	Considine	4	t
104	Elaina	Dicki	6	t
105	Catalina	Hills	5	t
106	Carole	Windler	4	t
107	Leon	Jast	5	t
108	Fletcher	Deckow	5	t
109	Verlie	O'Reilly	6	t
110	Arianna	Hessel	6	t
111	Aurore	Brekke	4	t
112	Heaven	Kiehn	3	t
113	Jana	Gibson	3	t
114	Lafayette	Schaefer	3	t
115	Myrna	Mayert	5	t
116	Ryann	Hirthe	3	t
117	Nyasia	Heidenreich	5	t
118	Elvera	Botsford	5	t
119	Joanny	Grady	4	t
120	Beaulah	Treutel	6	t
121	Amaya	Bechtelar	5	t
122	Katherine	Nader	4	t
123	Carol	Luettgen	6	t
124	Tina	Haley	4	t
125	Anissa	Mosciski	4	t
126	Eldon	Schoen	6	t
127	Haley	Mante	4	t
128	Earlene	Vandervort	5	t
129	Beth	Mohr	6	t
130	Matilde	Crist	4	t
131	Demarcus	Pagac	9	t
132	Stefan	Lockman	12	t
133	Trystan	Huel	10	t
134	Harold	Stoltenberg	9	t
135	Fletcher	Bins	9	t
136	Eino	Champlin	10	t
137	Cullen	Ernser	12	t
138	Uriel	Kuhn	10	t
139	Donny	Herzog	9	t
140	Melody	Farrell	11	t
141	Maggie	Strosin	8	t
142	Dominique	Legros	11	t
143	Bryce	Ferry	12	t
144	Effie	Adams	10	t
145	Kyleigh	Orn	10	t
146	Glennie	Boyer	12	t
147	Aaliyah	Keebler	8	t
148	Cora	Gutmann	7	t
149	Sarina	Wiegand	10	t
150	Brayan	Conroy	9	t
151	Clare	Grady	11	t
152	Rosalind	Stark	8	t
153	Chanelle	Schmidt	9	t
154	Hollis	Schmitt	8	t
155	Flo	Corkery	11	t
156	Emmanuel	Hyatt	9	t
157	Clemmie	Feeney	7	t
158	Juliet	Johnson	10	t
159	Nicholaus	Hackett	8	t
160	Hugh	Bogan	7	t
161	Camden	Miller	7	t
162	Chauncey	Swift	8	t
163	Miles	MacGyver	10	t
164	Brisa	Grady	10	t
165	Aleen	Huels	9	t
166	Tamara	Corkery	12	t
167	Gabe	Thompson	11	t
168	Hazel	Bins	12	t
169	Lempi	Kunze	8	t
170	Raheem	Yundt	8	t
171	Eladio	Lueilwitz	11	t
172	Chad	Stark	10	t
173	Chanel	Purdy	7	t
174	Troy	Steuber	11	t
175	Isobel	Collier	9	t
176	Mark	Connelly	10	t
177	Donato	Barton	12	t
178	Adah	Skiles	12	t
179	Ryan	Veum	11	t
180	Therese	Frami	9	t
181	Shannon	Kirlin	12	t
182	Lamont	Yundt	9	t
183	Brittany	Collier	12	t
184	Lauriane	Blanda	10	t
185	Mavis	Mann	7	t
186	Gavin	Hills	9	t
187	Stacy	Farrell	9	t
188	Alexzander	Skiles	9	t
189	Lori	Weissnat	9	t
190	Alaina	Dooley	9	t
191	Gerard	Bergnaum	7	t
192	Sterling	Nikolaus	8	t
193	Earl	Stiedemann	12	t
194	Hellen	Carroll	11	t
195	Liza	Orn	8	t
196	Joel	Jenkins	11	t
197	Concepcion	Volkman	7	t
198	Faustino	Breitenberg	10	t
199	Faye	Raynor	11	t
200	Gay	Schneider	12	t
201	Maud	Daniel	11	t
202	Kadin	Quitzon	10	t
203	Cierra	Bechtelar	7	t
204	Meghan	Luettgen	10	t
205	Wilmer	Schaefer	9	t
206	Carolyne	Jacobi	12	t
207	Fidel	Keeling	10	t
208	Karen	Schultz	12	t
209	Agnes	Herzog	9	t
210	Elyssa	Durgan	9	t
211	Cristal	Witting	11	t
212	Leone	Romaguera	11	t
213	Bud	Eichmann	12	t
214	Dudley	Pagac	10	t
215	Taryn	Paucek	10	t
216	Yasmine	Murazik	8	t
217	Petra	Thompson	11	t
218	Doug	Hills	7	t
219	German	Kemmer	7	t
220	Maida	Johnson	12	t
221	Danyka	Powlowski	11	t
222	Sally	Fisher	9	t
223	Tracey	Koelpin	12	t
224	Keaton	Reinger	12	t
225	Violette	Goyette	10	t
226	Grace	Bins	9	t
227	Garret	Purdy	12	t
228	Alene	Littel	7	t
229	Barney	Mills	10	t
230	Emily	Fahey	9	t
231	Wilhelmine	Ziemann	12	t
232	Gretchen	Mitchell	12	t
233	Itzel	Kuvalis	12	t
234	Elvera	Veum	12	t
235	Ceasar	Beatty	10	t
236	Buford	Hagenes	10	t
237	Geo	O'Keefe	10	t
238	Randy	Gibson	10	t
239	Aron	Haley	9	t
240	Kailyn	Donnelly	10	t
241	Amaya	Rolfson	8	t
242	Noemi	Krajcik	12	t
243	Alayna	Sporer	9	t
244	Rachel	Murazik	11	t
245	Alan	Nicolas	7	t
246	Casper	Blanda	12	t
247	Carolanne	Little	7	t
248	Mina	Koepp	7	t
249	Jazmin	Kautzer	8	t
250	Greg	Hills	11	t
251	Elsie	Mills	10	t
252	Flossie	Von	9	t
253	Kaci	Predovic	7	t
254	Julianne	Feest	9	t
255	Prudence	Tromp	10	t
256	Hailee	Hand	12	t
257	Arvilla	Monahan	7	t
258	Percival	Fisher	10	t
259	Sierra	O'Connell	11	t
260	Julie	Romaguera	11	t
261	Rosalia	Pollich	9	t
262	Abelardo	Will	7	t
263	Chasity	DuBuque	11	t
264	Lou	Becker	12	t
265	Santa	Grady	7	t
266	Gregg	Rohan	12	t
267	Treva	Rolfson	12	t
268	Vivianne	Nicolas	9	t
269	Francisca	Bergnaum	8	t
270	Garrick	Abbott	10	t
271	Odessa	Cruickshank	9	t
272	Brady	Farrell	11	t
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('students_id_seq', 272, true);


--
-- Data for Name: team_coaches; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY team_coaches (id, team_id, coach_id, start_date, end_date) FROM stdin;
\.


--
-- Name: team_coaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('team_coaches_id_seq', 1, false);


--
-- Data for Name: team_standings; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY team_standings (id, "position", team_id, division_id, total_points, accuracy, created_at, updated_at) FROM stdin;
\.


--
-- Name: team_standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('team_standings_id_seq', 1, false);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY teams (id, division_id, organization_id, name, active) FROM stdin;
1	1	1	ACAC 1	t
2	1	1	ACAC 2	t
3	1	1	ACAC 3	t
4	1	1	ACAC 4	t
5	1	1	ACAC 5	t
6	1	1	ACAC 6	t
7	1	1	ACAC 7	t
8	1	1	ACAC 8	t
9	2	1	ACAC 1	t
10	2	1	ACAC 2	t
11	2	1	ACAC 3	t
12	2	1	ACAC 4	t
13	2	1	ACAC 5	t
14	3	1	ACAC 1	t
15	1	4	Broadway 1	t
16	1	4	Broadway 2	t
17	1	4	Broadway 3	t
18	2	4	Broadway 1	t
19	2	4	Broadway 2	t
20	3	4	Broadway 1	t
21	3	4	Broadway 2	t
22	1	7	Cherry Tree 1	t
23	1	7	Cherry Tree 2	t
24	1	7	Cherry Tree 3	t
25	2	7	Cherry Tree 1	t
26	2	7	Cherry Tree 2	t
27	3	7	Cherry Tree 1	t
28	1	10	Chicora 1	t
29	1	10	Chicora 2	t
30	1	10	Chicora 3	t
31	2	10	Chicora 1	t
32	2	10	Chicora 2	t
33	2	10	Chicora 3	t
34	3	10	Chicora 1	t
35	1	3	Dorseyville 1	t
36	1	3	Dorseyville 2	t
37	1	3	Dorseyville 3	t
38	2	3	Dorseyville 1	t
39	2	3	Dorseyville 2	t
40	3	3	Dorseyville 1	t
41	1	16	Elkins 1	t
42	2	16	Elkins 1	t
43	2	16	Elkins 2	t
44	3	16	Elkins 1	t
45	1	17	New Castle 1	t
46	2	17	New Castle 1	t
47	2	17	New Castle 2	t
48	2	17	New Castle 3	t
49	3	17	New Castle 1	t
50	1	13	Greensburg 1	t
51	2	13	Greensburg 1	t
52	2	13	Greensburg 2	t
53	2	13	Greensburg 3	t
54	3	13	Greensburg 1	t
55	1	6	Indiana 1	t
56	2	6	Indiana 1	t
57	2	6	Indiana 2	t
58	3	6	Indiana 1	t
59	1	15	McKeesport 1	t
60	1	15	McKeesport 2	t
61	2	15	McKeesport 1	t
62	2	15	McKeesport 2	t
63	3	15	McKeesport 1	t
64	1	5	MAC 1	t
65	1	5	MAC 2	t
66	1	5	MAC 3	t
67	2	5	MAC 1	t
68	2	5	MAC 2	t
69	3	5	MAC 1	t
70	3	5	MAC 2	t
71	1	11	Norwin 1	t
72	1	11	Norwin 2	t
73	1	11	Norwin 3	t
74	2	11	Norwin 1	t
75	3	11	Norwin 1	t
76	1	2	Somerset 1	t
77	2	2	Somerset 1	t
78	3	2	Somerset 1	t
79	1	8	Washington 1	t
80	2	8	Washington 1	t
81	3	8	Washington 1	t
82	3	8	Washington 2	t
\.


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('teams_id_seq', 82, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: profh
--

COPY users (id, username, email, role, password_digest, active, active_after, password_reset_token, password_reset_sent_at, token_type) FROM stdin;
1	chesstiger91	\N	admin	$2a$10$nafRWU3Hq/7BuBWDadYFmuUuwa.bPZH1uKHQgvG93PMQ5YrMPcKSa	t	2015-06-03 15:36:01.679719	\N	\N	\N
2	profh	profh@cmu.edu	admin	$2a$10$rzbkkDbNuziEbCumcH9nZOaonsBW8qx7MxBx6VNdziqgvnJN/wHde	t	2015-06-03 15:36:02.548506	\N	\N	\N
3	tmreay	tmreay@example.com	area_admin	$2a$10$YujJ5ukFf3wUBBHima4kYeHJCtLtoSbnnb3xTBRfwcSKv3s9KtCre	t	2015-06-03 15:36:02.638723	\N	\N	\N
4	tbartoletti58	tbartoletti58@example.com	coach	$2a$10$BV4mOZwbDGIhb3lracyW1uvvPsZ03y/.j.2PoXnKs1PHef17PnEsO	t	2015-06-03 15:36:02.485271	\N	\N	\N
5	sconroy53	sconroy53@example.com	coach	$2a$10$19pQKLqaD8oS3BvqomJjCe1KqOwwIHzW.hyhS9Q.8.r08aO3MS86.	t	2015-06-03 15:36:02.485271	\N	\N	\N
6	gsmith33	gsmith33@example.com	coach	$2a$10$bmK5D2gxmgJ.RbbsuAYUWegMAXvR8VHmWh4BKj1VfGrn86bNHgM9.	t	2015-06-03 15:36:02.485271	\N	\N	\N
7	onienow31	onienow31@example.com	coach	$2a$10$HIL35AkR1elLCJCrGpP63e3Kop1IrHLFMlf.8NbnteBwSEvVgVX2m	t	2015-06-03 15:36:02.485271	\N	\N	\N
8	wcronin41	wcronin41@example.com	coach	$2a$10$s39n/OcsmSDZe0nE3pMC.uzSwtEvEQtyDcbeVpTS3mxXypc2u.I1q	t	2015-06-03 15:36:02.485271	\N	\N	\N
9	sschultz93	sschultz93@example.com	coach	$2a$10$c.CBfIHc7WXpUpIOM8Synu7y8punB1y0Tpa1ABTYpOeBJln4rBANC	t	2015-06-03 15:36:02.485271	\N	\N	\N
10	okutch43	okutch43@example.com	coach	$2a$10$5MvsibqrC3p5eXf6CxU4l.0G52LMesZGWdluE7QARPrdEmoG8Ggg2	t	2015-06-03 15:36:02.485271	\N	\N	\N
11	nferry53	nferry53@example.com	coach	$2a$10$Nsic5CluO43X6OnjyvczK.lXY/Y1TxoWiYIImYpbOHu.6qrrnijTK	t	2015-06-03 15:36:02.485271	\N	\N	\N
12	jcummerata63	jcummerata63@example.com	coach	$2a$10$9JhfUyAVTo.Mp0.c.VZDn.3Eai.iMzq1h3/XG9C7IUkFDtsEOPHBy	t	2015-06-03 15:36:02.485271	\N	\N	\N
13	tjerde63	tjerde63@example.com	coach	$2a$10$mjKHUbwTi3bgfAGl1T34IOk7.LqSCfYr.ZxU8D5KWwiZ8LkAOX3/C	t	2015-06-03 15:36:02.485271	\N	\N	\N
14	frohan54	frohan54@example.com	coach	$2a$10$3Y2UIqYuN7kwFcvftOPxV.wrfxeEOYDQxxQQhBkSR1Py2QO1pxTwW	t	2015-06-03 15:36:02.485271	\N	\N	\N
15	bhahn86	bhahn86@example.com	coach	$2a$10$rd.a4uXgi13YH1qs4ARdLes/R5oRSqL6XVmhul9P5rJXqzTTy6EX2	t	2015-06-03 15:36:02.485271	\N	\N	\N
16	mvon37	mvon37@example.com	coach	$2a$10$D1kJUSoyK0BbypAKksS8oeoNidfYSCMT8x8zFkOMnYdmVhWfuwUIS	t	2015-06-03 15:36:02.485271	\N	\N	\N
17	hlarkin75	hlarkin75@example.com	coach	$2a$10$K1ZKd8JdMnknS51/drPZTud.z5CIfvhSih6p0a95cIdvkKBS7DlCK	t	2015-06-03 15:36:02.485271	\N	\N	\N
18	bvandervort11	bvandervort11@example.com	coach	$2a$10$Kh6VGp2CqUGHcUHjTjTfX.KLBYjJwjJ.IzE2WPSwMLgOlnTKr/Fxm	t	2015-06-03 15:36:02.485271	\N	\N	\N
19	jnader86	jnader86@example.com	coach	$2a$10$Wf7UAJzcLeCsXVqqjyAJ8.buQX0LxPUPjnSPB7Iigk2DSnZEQvtyC	t	2015-06-03 15:36:02.485271	\N	\N	\N
20	sreynolds80	sreynolds80@example.com	coach	$2a$10$/R6J2.l8y5.4oOIn7KqNk.Kt8QhdljGbznL1aipm/LFe2S83aunoa	t	2015-06-03 15:36:02.485271	\N	\N	\N
21	nbarton2	nbarton2@example.com	coach	$2a$10$6zpuojE9Kcr4TIY3SXKLjuG1azDm3xhF29bB6pAoTyB3PFk.bQeNm	t	2015-06-03 15:36:02.485271	\N	\N	\N
22	gmante18	gmante18@example.com	coach	$2a$10$C09BuTLgJoF3ijGd6N0Is.YD.YG7LyKG0qMXnPHgNWS/ouIANZzaC	t	2015-06-03 15:36:02.485271	\N	\N	\N
23	smaggio23	smaggio23@example.com	coach	$2a$10$NGbuBsyl/BUruwVD5t/D8O97YTT0/O/7NWAZKcC7xQLjISH768X0W	t	2015-06-03 15:36:02.485271	\N	\N	\N
24	wboehm45	wboehm45@example.com	coach	$2a$10$bpTmIJjNMqrRJp02m8P0GuDX.oTn1SRuUDe/NtGtpwP/1D.WCOwCa	t	2015-06-03 15:36:02.485271	\N	\N	\N
25	jbarton77	jbarton77@example.com	coach	$2a$10$9QpTWCpUJZ1CfiQs0Uf1wOtWJM2ckY/JtN5VQwFsUSidi/vmmuYHi	t	2015-06-03 15:36:02.485271	\N	\N	\N
26	lshanahan2	lshanahan2@example.com	coach	$2a$10$eG7OMDYe3OJZ013N27YdteUU7FBWZW/YzwJIEaHOG4NqzIoSON1Cq	t	2015-06-03 15:36:02.485271	\N	\N	\N
27	rrath62	rrath62@example.com	coach	$2a$10$Ony5KAdhMlSa5jPy/eZdpuozeDAsNLMzjfyRX3H7DtYmXkBbukns2	t	2015-06-03 15:36:02.485271	\N	\N	\N
28	ktreutel43	ktreutel43@example.com	coach	$2a$10$h2RN810R1rbuA7QJsluQIexm0abwKeoDyncL6T2ZoCnKJe0XdxuZO	t	2015-06-03 15:36:02.485271	\N	\N	\N
29	ogottlieb93	ogottlieb93@example.com	coach	$2a$10$cpFo4mCd4Ej08F2C6RnIFekxVTNaX9PyEKRRiopGVHycfy4dX2c8m	t	2015-06-03 15:36:02.485271	\N	\N	\N
30	nwatsica33	nwatsica33@example.com	coach	$2a$10$LBGr5tyFTu1KavhYT2Eky.gbHwn.vwMJ2M/hcaSoSbWe8YqQgmjTa	t	2015-06-03 15:36:02.485271	\N	\N	\N
31	ao'conner13	ao'conner13@example.com	coach	$2a$10$5Yu0J14iHJ0mkx9h05RgOeJMfoc1yPQ6gFf2HzLSVMEMlraZxkenC	t	2015-06-03 15:36:02.485271	\N	\N	\N
32	jstreich71	jstreich71@example.com	coach	$2a$10$dFolW1Rrg93SFYUuwQ3iQuZH/ZOdeUJV37R0wq78hnNvJdUSR/BqG	t	2015-06-03 15:36:02.485271	\N	\N	\N
33	mthiel14	mthiel14@example.com	coach	$2a$10$xWAPLqqUugvSeYsbMOFdGuW6sN6b/TQjdq90iM7gupZBt1f7qRPyG	t	2015-06-03 15:36:02.485271	\N	\N	\N
34	dleuschke58	dleuschke58@example.com	coach	$2a$10$leQBRsCDHsF0FJvAGi/UnO2v2R.mTy.ZnlwCelTg8eE1kgs6fXc8K	t	2015-06-03 15:36:02.485271	\N	\N	\N
35	groberts47	groberts47@example.com	coach	$2a$10$Lwz83tJoJdMi6nWwoDsIO.88THSRAbwLoT.0ivEmzTrGxa2BJBPiW	t	2015-06-03 15:36:02.485271	\N	\N	\N
36	ko'keefe59	ko'keefe59@example.com	coach	$2a$10$i9Vjxn2tVxD0MF8RgNfj0.zsBULeh1CaqujgIg4pF4D2tBazQd.v2	t	2015-06-03 15:36:02.485271	\N	\N	\N
37	dherman49	dherman49@example.com	coach	$2a$10$.s/RIzz.0TvnMcn89TNGXeBsVSlkDAAy6VsyvFS/1RdiP9iRmfajq	t	2015-06-03 15:36:02.485271	\N	\N	\N
38	dbeatty83	dbeatty83@example.com	coach	$2a$10$MNVgJCzFrI8TvYXqmPogM.msrChlyxOAu1Afg0y8aVY.zaHEE3hYG	t	2015-06-03 15:36:02.485271	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: profh
--

SELECT pg_catalog.setval('users_id_seq', 38, true);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (id);


--
-- Name: divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: indiv_standings_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY indiv_standings
    ADD CONSTRAINT indiv_standings_pkey PRIMARY KEY (id);


--
-- Name: organization_students_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY organization_students
    ADD CONSTRAINT organization_students_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: quiz_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY quiz_teams
    ADD CONSTRAINT quiz_teams_pkey PRIMARY KEY (id);


--
-- Name: quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: student_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY student_quizzes
    ADD CONSTRAINT student_quizzes_pkey PRIMARY KEY (id);


--
-- Name: student_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY student_teams
    ADD CONSTRAINT student_teams_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: team_coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY team_coaches
    ADD CONSTRAINT team_coaches_pkey PRIMARY KEY (id);


--
-- Name: team_standings_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY team_standings
    ADD CONSTRAINT team_standings_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: profh; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: profh; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: profh
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM profh;
GRANT ALL ON SCHEMA public TO profh;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

