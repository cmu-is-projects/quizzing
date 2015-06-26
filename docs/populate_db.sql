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


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


SET search_path = public, pg_catalog;

--
-- Name: pg_search_dmetaphone(text); Type: FUNCTION; Schema: public; Owner: quizzing
--

CREATE FUNCTION pg_search_dmetaphone(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
$_$;


ALTER FUNCTION public.pg_search_dmetaphone(text) OWNER TO quizzing;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.categories OWNER TO quizzing;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO quizzing;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: coaches; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.coaches OWNER TO quizzing;

--
-- Name: coaches_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE coaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coaches_id_seq OWNER TO quizzing;

--
-- Name: coaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE coaches_id_seq OWNED BY coaches.id;


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE divisions (
    id integer NOT NULL,
    name character varying(255),
    start_grade integer,
    end_grade integer,
    active boolean DEFAULT true
);


ALTER TABLE public.divisions OWNER TO quizzing;

--
-- Name: divisions_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE divisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.divisions_id_seq OWNER TO quizzing;

--
-- Name: divisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE divisions_id_seq OWNED BY divisions.id;


--
-- Name: event_summaries; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE event_summaries (
    id integer NOT NULL,
    event_id integer,
    division_id integer,
    avg_student_points double precision,
    avg_team_points double precision,
    max_student_points integer,
    max_team_points integer,
    max_student_id integer,
    max_team_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.event_summaries OWNER TO quizzing;

--
-- Name: event_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE event_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_summaries_id_seq OWNER TO quizzing;

--
-- Name: event_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE event_summaries_id_seq OWNED BY event_summaries.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.events OWNER TO quizzing;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO quizzing;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: indiv_standings; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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
    updated_at timestamp without time zone,
    organization_id integer
);


ALTER TABLE public.indiv_standings OWNER TO quizzing;

--
-- Name: indiv_standings_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE indiv_standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.indiv_standings_id_seq OWNER TO quizzing;

--
-- Name: indiv_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE indiv_standings_id_seq OWNED BY indiv_standings.id;


--
-- Name: organization_students; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE organization_students (
    id integer NOT NULL,
    organization_id integer,
    student_id integer,
    start_date date,
    end_date date
);


ALTER TABLE public.organization_students OWNER TO quizzing;

--
-- Name: organization_students_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE organization_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organization_students_id_seq OWNER TO quizzing;

--
-- Name: organization_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE organization_students_id_seq OWNED BY organization_students.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.organizations OWNER TO quizzing;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organizations_id_seq OWNER TO quizzing;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.pg_search_documents OWNER TO quizzing;

--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pg_search_documents_id_seq OWNER TO quizzing;

--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: quiz_teams; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE quiz_teams (
    id integer NOT NULL,
    quiz_id integer,
    team_id integer,
    "position" integer,
    raw_score integer,
    points integer,
    failed_challenges integer DEFAULT 0,
    place integer
);


ALTER TABLE public.quiz_teams OWNER TO quizzing;

--
-- Name: quiz_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE quiz_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_teams_id_seq OWNER TO quizzing;

--
-- Name: quiz_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE quiz_teams_id_seq OWNED BY quiz_teams.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.quizzes OWNER TO quizzing;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quizzes_id_seq OWNER TO quizzing;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE quizzes_id_seq OWNED BY quizzes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO quizzing;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.settings OWNER TO quizzing;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO quizzing;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- Name: student_quizzes; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.student_quizzes OWNER TO quizzing;

--
-- Name: student_quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE student_quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_quizzes_id_seq OWNER TO quizzing;

--
-- Name: student_quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE student_quizzes_id_seq OWNED BY student_quizzes.id;


--
-- Name: student_teams; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.student_teams OWNER TO quizzing;

--
-- Name: student_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE student_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_teams_id_seq OWNER TO quizzing;

--
-- Name: student_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE student_teams_id_seq OWNED BY student_teams.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    grade integer,
    active boolean DEFAULT true
);


ALTER TABLE public.students OWNER TO quizzing;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO quizzing;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: team_coaches; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE team_coaches (
    id integer NOT NULL,
    team_id integer,
    coach_id integer,
    start_date date,
    end_date date
);


ALTER TABLE public.team_coaches OWNER TO quizzing;

--
-- Name: team_coaches_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE team_coaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_coaches_id_seq OWNER TO quizzing;

--
-- Name: team_coaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE team_coaches_id_seq OWNED BY team_coaches.id;


--
-- Name: team_standings; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.team_standings OWNER TO quizzing;

--
-- Name: team_standings_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE team_standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_standings_id_seq OWNER TO quizzing;

--
-- Name: team_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE team_standings_id_seq OWNED BY team_standings.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    division_id integer,
    organization_id integer,
    name character varying(255),
    active boolean DEFAULT true
);


ALTER TABLE public.teams OWNER TO quizzing;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO quizzing;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: quizzing; Tablespace: 
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


ALTER TABLE public.users OWNER TO quizzing;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: quizzing
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO quizzing;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quizzing
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY coaches ALTER COLUMN id SET DEFAULT nextval('coaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY divisions ALTER COLUMN id SET DEFAULT nextval('divisions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY event_summaries ALTER COLUMN id SET DEFAULT nextval('event_summaries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY indiv_standings ALTER COLUMN id SET DEFAULT nextval('indiv_standings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY organization_students ALTER COLUMN id SET DEFAULT nextval('organization_students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY quiz_teams ALTER COLUMN id SET DEFAULT nextval('quiz_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY quizzes ALTER COLUMN id SET DEFAULT nextval('quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY student_quizzes ALTER COLUMN id SET DEFAULT nextval('student_quizzes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY student_teams ALTER COLUMN id SET DEFAULT nextval('student_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY team_coaches ALTER COLUMN id SET DEFAULT nextval('team_coaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY team_standings ALTER COLUMN id SET DEFAULT nextval('team_standings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: quizzing
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY categories (id, name) FROM stdin;
1	Prelims
2	Championship
3	Consolation
4	XYZ Quiz
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('categories_id_seq', 4, true);


--
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY coaches (id, user_id, organization_id, first_name, last_name, phone, active, created_at, updated_at) FROM stdin;
1	4	1	Tim	Daigle	3070186736	t	2015-06-03 16:29:21.957919	2015-06-03 16:29:21.957919
2	5	1	Khalil	Fay	3139782989	t	2015-06-03 16:29:22.354165	2015-06-03 16:29:22.354165
3	6	1	Simone	Moore	0452113885	t	2015-06-03 16:29:22.436956	2015-06-03 16:29:22.436956
4	7	1	Wilfrid	Bednar	0988774639	t	2015-06-03 16:29:22.518173	2015-06-03 16:29:22.518173
5	8	4	Keyshawn	Murazik	6505129827	t	2015-06-03 16:29:22.597016	2015-06-03 16:29:22.597016
6	9	4	Gwen	Considine	5489685580	t	2015-06-03 16:29:22.679504	2015-06-03 16:29:22.679504
7	10	7	Braxton	Gislason	9067839731	t	2015-06-03 16:29:22.761845	2015-06-03 16:29:22.761845
8	11	7	Darrick	Rippin	4410037924	t	2015-06-03 16:29:22.844988	2015-06-03 16:29:22.844988
9	12	10	Jacky	Runte	6923996446	t	2015-06-03 16:29:22.927461	2015-06-03 16:29:22.927461
10	13	10	Dayana	Gaylord	8832591537	t	2015-06-03 16:29:23.00734	2015-06-03 16:29:23.00734
11	14	10	Jennyfer	Osinski	0331489229	t	2015-06-03 16:29:23.087984	2015-06-03 16:29:23.087984
12	15	3	Darby	Buckridge	3013900278	t	2015-06-03 16:29:23.16996	2015-06-03 16:29:23.16996
13	16	3	Waylon	Hickle	7109969567	t	2015-06-03 16:29:23.259357	2015-06-03 16:29:23.259357
14	17	3	Ramona	Spinka	5119661565	t	2015-06-03 16:29:23.338228	2015-06-03 16:29:23.338228
15	18	16	Francesca	Beatty	9105421215	t	2015-06-03 16:29:23.425148	2015-06-03 16:29:23.425148
16	19	17	Jailyn	Barton	0981305361	t	2015-06-03 16:29:23.509593	2015-06-03 16:29:23.509593
17	20	17	Rene	Rempel	8757682143	t	2015-06-03 16:29:23.58869	2015-06-03 16:29:23.58869
18	21	17	Katheryn	Bradtke	9891752646	t	2015-06-03 16:29:23.669458	2015-06-03 16:29:23.669458
19	22	13	Lamar	Abernathy	7310934937	t	2015-06-03 16:29:23.752368	2015-06-03 16:29:23.752368
20	23	6	Glenna	Waters	4710789035	t	2015-06-03 16:29:23.834013	2015-06-03 16:29:23.834013
21	24	6	Haven	Lubowitz	6822729648	t	2015-06-03 16:29:23.915013	2015-06-03 16:29:23.915013
22	25	6	Adolph	Cremin	3218893963	t	2015-06-03 16:29:23.996073	2015-06-03 16:29:23.996073
23	26	6	Loyal	Kutch	3595915495	t	2015-06-03 16:29:24.076055	2015-06-03 16:29:24.076055
24	27	15	Amelie	Labadie	6028793948	t	2015-06-03 16:29:24.157159	2015-06-03 16:29:24.157159
25	28	15	Marco	Schowalter	1289356524	t	2015-06-03 16:29:24.238552	2015-06-03 16:29:24.238552
26	29	15	Callie	Wehner	7096512362	t	2015-06-03 16:29:24.324292	2015-06-03 16:29:24.324292
27	30	15	Elisabeth	Wiegand	6335974725	t	2015-06-03 16:29:24.405672	2015-06-03 16:29:24.405672
28	31	5	Ottis	Stehr	2958916630	t	2015-06-03 16:29:24.487047	2015-06-03 16:29:24.487047
29	32	11	Hettie	Erdman	5513055768	t	2015-06-03 16:29:24.569828	2015-06-03 16:29:24.569828
30	33	2	Webster	Grant	5836878447	t	2015-06-03 16:29:24.652538	2015-06-03 16:29:24.652538
31	34	2	Isom	Stiedemann	4375989351	t	2015-06-03 16:29:24.734297	2015-06-03 16:29:24.734297
32	35	2	Dylan	Feest	6829562749	t	2015-06-03 16:29:24.817918	2015-06-03 16:29:24.817918
33	36	2	Leanne	Wilderman	7367237085	t	2015-06-03 16:29:24.896796	2015-06-03 16:29:24.896796
34	37	8	Tania	Bartoletti	2426148265	t	2015-06-03 16:29:24.978912	2015-06-03 16:29:24.978912
35	38	8	Toby	Sawayn	8541182485	t	2015-06-03 16:29:25.058541	2015-06-03 16:29:25.058541
\.


--
-- Name: coaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('coaches_id_seq', 35, true);


--
-- Data for Name: divisions; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY divisions (id, name, start_grade, end_grade, active) FROM stdin;
1	juniors	3	6	t
2	seniors	7	12	t
3	seniorb	7	12	t
\.


--
-- Name: divisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('divisions_id_seq', 3, true);


--
-- Data for Name: event_summaries; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY event_summaries (id, event_id, division_id, avg_student_points, avg_team_points, max_student_points, max_team_points, max_student_id, max_team_id, created_at, updated_at) FROM stdin;
22	1	1	214	91	480	122	\N	\N	2015-06-09 00:04:18.800705	2015-06-09 00:04:18.800705
23	1	2	219	74	470	111	\N	\N	2015-06-09 00:04:22.921942	2015-06-09 00:04:22.921942
24	1	3	210	87	420	116	\N	\N	2015-06-09 00:04:27.072868	2015-06-09 00:04:27.072868
25	2	1	207	87	470	120	\N	\N	2015-06-09 00:04:31.393923	2015-06-09 00:04:31.393923
26	2	2	244	80	470	124	\N	\N	2015-06-09 00:04:35.546821	2015-06-09 00:04:35.546821
27	2	3	219	91	430	120	\N	\N	2015-06-09 00:04:39.75196	2015-06-09 00:04:39.75196
28	3	1	211	90	470	129	\N	\N	2015-06-09 00:04:44.090215	2015-06-09 00:04:44.090215
29	3	2	218	73	480	111	\N	\N	2015-06-09 00:04:48.188923	2015-06-09 00:04:48.188923
30	3	3	207	86	500	104	\N	\N	2015-06-09 00:04:52.421207	2015-06-09 00:04:52.421207
31	4	1	201	88	500	133	\N	\N	2015-06-09 00:04:56.641638	2015-06-09 00:04:56.641638
32	4	2	219	72	460	117	\N	\N	2015-06-09 00:05:00.85694	2015-06-09 00:05:00.85694
33	4	3	207	86	500	111	\N	\N	2015-06-09 00:05:05.150445	2015-06-09 00:05:05.150445
34	5	1	203	86	480	120	\N	\N	2015-06-09 00:05:09.303115	2015-06-09 00:05:09.303115
35	5	2	222	74	440	113	\N	\N	2015-06-09 00:05:13.462629	2015-06-09 00:05:13.462629
36	5	3	206	85	450	119	\N	\N	2015-06-09 00:05:17.599534	2015-06-09 00:05:17.599534
37	6	1	190	82	460	114	\N	\N	2015-06-09 00:05:21.929416	2015-06-09 00:05:21.929416
38	6	2	215	74	460	114	\N	\N	2015-06-09 00:05:26.076149	2015-06-09 00:05:26.076149
39	6	3	202	84	460	119	\N	\N	2015-06-09 00:05:30.218233	2015-06-09 00:05:30.218233
40	7	1	214	91	430	128	\N	\N	2015-06-09 00:05:34.361296	2015-06-09 00:05:34.361296
41	7	2	218	72	490	113	\N	\N	2015-06-09 00:05:38.693005	2015-06-09 00:05:38.693005
42	7	3	209	87	490	131	\N	\N	2015-06-09 00:05:42.867989	2015-06-09 00:05:42.867989
\.


--
-- Name: event_summaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('event_summaries_id_seq', 42, true);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY events (id, start_date, end_date, start_time, num_rounds, organization_id, created_at, updated_at) FROM stdin;
1	2014-10-04	2014-10-04	13:00:00	6	13	2015-06-03 16:29:21.68321	2015-06-03 16:29:21.698449
2	2014-11-01	2014-11-01	13:00:00	6	3	2015-06-03 16:29:21.707049	2015-06-03 16:29:21.719021
3	2014-12-06	2014-12-06	13:00:00	6	16	2015-06-03 16:29:21.728436	2015-06-03 16:29:21.740899
4	2015-01-03	2015-01-03	13:00:00	6	13	2015-06-03 16:29:21.749908	2015-06-03 16:29:21.762115
5	2015-02-07	2015-02-07	13:00:00	6	10	2015-06-03 16:29:21.771017	2015-06-03 16:29:21.783709
6	2015-03-07	2015-03-07	13:00:00	6	8	2015-06-03 16:29:21.793284	2015-06-03 16:29:21.805585
7	2015-04-11	2015-04-11	13:00:00	6	10	2015-06-03 16:29:21.814472	2015-06-03 16:29:21.827548
8	2015-06-27	2015-06-27	13:00:00	6	11	2015-06-03 16:29:21.836937	2015-06-03 16:29:21.836937
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('events_id_seq', 8, true);


--
-- Data for Name: indiv_standings; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY indiv_standings (id, "position", student_id, team_id, division_id, total_points, lowest_score, adjusted_points, accuracy, created_at, updated_at, organization_id) FROM stdin;
2	2	86	46	1	2610	240	2370	0.756000000000000005	2015-06-03 16:47:06.028362	2015-06-10 19:36:45.462972	17
4	4	48	32	1	2460	220	2240	0.756000000000000005	2015-06-03 16:47:06.067332	2015-06-10 19:36:45.528775	3
5	5	76	62	1	2400	190	2210	0.755000000000000004	2015-06-03 16:47:06.10343	2015-06-10 19:36:45.541822	15
6	6	89	71	1	2480	270	2210	0.753000000000000003	2015-06-03 16:47:06.125599	2015-06-10 19:36:45.580682	11
7	7	25	8	1	2480	290	2190	0.764000000000000012	2015-06-03 16:47:06.146779	2015-06-10 19:36:45.595353	1
8	8	1	1	1	2400	210	2190	0.744999999999999996	2015-06-03 16:47:06.168463	2015-06-10 19:36:45.60783	1
9	9	8	3	1	2410	240	2170	0.758000000000000007	2015-06-03 16:47:06.193128	2015-06-10 19:36:45.653351	1
10	10	100	78	1	2340	180	2160	0.758000000000000007	2015-06-03 16:47:06.212046	2015-06-10 19:36:45.666245	8
12	12	62	51	1	2370	230	2140	0.72799999999999998	2015-06-03 16:47:06.256477	2015-06-10 19:36:45.731132	13
13	13	37	25	1	2370	240	2130	0.736999999999999988	2015-06-03 16:47:06.279502	2015-06-10 19:36:45.745629	10
15	15	69	67	1	2300	220	2080	0.725999999999999979	2015-06-03 16:47:06.32193	2015-06-10 19:36:45.800388	5
16	16	19	6	1	2290	240	2050	0.723999999999999977	2015-06-03 16:47:06.346048	2015-06-10 19:36:45.814764	1
17	17	42	26	1	2220	200	2020	0.734999999999999987	2015-06-03 16:47:06.366464	2015-06-10 19:36:45.828155	10
18	18	4	2	1	2180	160	2020	0.753000000000000003	2015-06-03 16:47:06.388696	2015-06-10 19:36:45.86913	1
19	19	92	74	1	2230	220	2010	0.697999999999999954	2015-06-03 16:47:06.411015	2015-06-10 19:36:45.88246	2
20	20	65	56	1	2200	220	1980	0.706999999999999962	2015-06-03 16:47:06.432295	2015-06-10 19:36:45.893959	6
21	21	22	7	1	2260	300	1960	0.743999999999999995	2015-06-03 16:47:06.450782	2015-06-10 19:36:45.938746	1
22	22	80	44	1	2170	220	1950	0.692999999999999949	2015-06-03 16:47:06.469503	2015-06-10 19:36:45.958583	17
23	23	83	45	1	2140	230	1910	0.685000000000000053	2015-06-03 16:47:06.487944	2015-06-10 19:36:45.970545	17
24	24	28	16	1	2110	250	1860	0.723999999999999977	2015-06-03 16:47:06.506445	2015-06-10 19:36:46.020293	4
25	25	58	50	1	2080	230	1850	0.724999999999999978	2015-06-03 16:47:06.524671	2015-06-10 19:36:46.032257	13
27	27	45	31	1	1990	190	1800	0.697999999999999954	2015-06-03 16:47:06.564802	2015-06-10 19:36:46.083238	3
28	28	15	5	1	1850	100	1750	0.685000000000000053	2015-06-03 16:47:06.583239	2015-06-10 19:36:46.097642	1
29	29	51	37	1	1710	10	1700	0.64800000000000002	2015-06-03 16:47:06.601152	2015-06-10 19:36:46.110127	16
30	30	20	6	1	1580	150	1430	0.876000000000000001	2015-06-03 16:47:06.620747	2015-06-10 19:36:46.171203	1
31	31	93	74	1	1490	80	1410	0.811000000000000054	2015-06-03 16:47:06.640655	2015-06-10 19:36:46.183495	2
32	32	87	46	1	1450	80	1370	0.758000000000000007	2015-06-03 16:47:06.658008	2015-06-10 19:36:46.194949	17
33	33	24	7	1	1440	90	1350	0.815999999999999948	2015-06-03 16:47:06.676383	2015-06-10 19:36:46.24787	1
35	35	31	16	1	1380	110	1270	0.812000000000000055	2015-06-03 16:47:06.713616	2015-06-10 19:36:46.273889	4
36	36	101	78	1	1350	80	1270	0.75	2015-06-03 16:47:06.733974	2015-06-10 19:36:46.31659	8
37	37	47	31	1	1300	70	1230	0.741999999999999993	2015-06-03 16:47:06.752506	2015-06-10 19:36:46.329503	3
38	38	84	45	1	1250	50	1200	0.706999999999999962	2015-06-03 16:47:06.771867	2015-06-10 19:36:46.340923	17
39	39	73	68	1	1280	80	1200	0.793000000000000038	2015-06-03 16:47:06.791744	2015-06-10 19:36:46.380732	5
40	40	9	3	1	1270	80	1190	0.746999999999999997	2015-06-03 16:47:06.918468	2015-06-10 19:36:46.394455	1
41	41	5	2	1	1290	100	1190	0.810000000000000053	2015-06-03 16:47:06.936819	2015-06-10 19:36:46.406192	1
43	43	66	56	1	1160	0	1160	0.739999999999999991	2015-06-03 16:47:06.973821	2015-06-10 19:36:46.468578	6
44	44	56	38	1	1210	70	1140	0.691999999999999948	2015-06-03 16:47:06.9946	2015-06-10 19:36:46.480111	16
45	45	16	5	1	1230	100	1130	0.815999999999999948	2015-06-03 16:47:07.012746	2015-06-10 19:36:46.533277	1
46	46	95	74	1	1240	110	1130	0.821999999999999953	2015-06-03 16:47:07.032264	2015-06-10 19:36:46.552849	2
47	47	6	2	1	1240	110	1130	0.740999999999999992	2015-06-03 16:47:07.051632	2015-06-10 19:36:46.564467	1
48	48	81	44	1	1220	90	1130	0.732999999999999985	2015-06-03 16:47:07.070545	2015-06-10 19:36:46.601396	17
50	50	46	31	1	1180	70	1110	0.646000000000000019	2015-06-03 16:47:07.110651	2015-06-10 19:36:46.625161	3
51	51	70	67	1	1120	10	1110	0.739999999999999991	2015-06-03 16:47:07.129652	2015-06-10 19:36:46.670467	5
52	52	82	44	1	1150	50	1100	0.75	2015-06-03 16:47:07.147485	2015-06-10 19:36:46.682578	17
53	53	98	77	1	1210	110	1100	0.79500000000000004	2015-06-03 16:47:07.164193	2015-06-10 19:36:46.694007	8
54	54	102	78	1	1210	110	1100	0.746999999999999997	2015-06-03 16:47:07.183178	2015-06-10 19:36:46.706191	8
55	55	60	50	1	1140	40	1100	0.708999999999999964	2015-06-03 16:47:07.202294	2015-06-10 19:36:46.764187	13
56	56	91	71	1	1170	80	1090	0.759000000000000008	2015-06-03 16:47:07.219605	2015-06-10 19:36:46.775821	11
58	58	103	78	1	1160	90	1070	0.77300000000000002	2015-06-03 16:47:07.25844	2015-06-10 19:36:46.837845	8
59	59	35	21	1	1140	90	1050	0.719999999999999973	2015-06-03 16:47:07.27574	2015-06-10 19:36:46.850645	7
60	60	64	51	1	1070	20	1050	0.687999999999999945	2015-06-03 16:47:07.360016	2015-06-10 19:36:46.862196	13
61	61	61	50	1	1110	70	1040	0.739999999999999991	2015-06-03 16:47:07.378165	2015-06-10 19:36:46.903043	13
62	62	11	3	1	1140	100	1040	0.72799999999999998	2015-06-03 16:47:07.397607	2015-06-10 19:36:46.916082	1
63	63	14	4	1	1090	60	1030	0.817999999999999949	2015-06-03 16:47:07.415067	2015-06-10 19:36:46.928308	1
64	64	18	5	1	1130	100	1030	0.823999999999999955	2015-06-03 16:47:07.433085	2015-06-10 19:36:46.971899	1
66	66	53	37	1	1120	90	1030	0.652000000000000024	2015-06-03 16:47:07.469428	2015-06-10 19:36:46.996431	16
67	67	55	38	1	1090	60	1030	0.663000000000000034	2015-06-03 16:47:07.488767	2015-06-10 19:36:47.048737	16
68	68	43	26	1	1090	70	1020	0.742999999999999994	2015-06-03 16:47:07.506664	2015-06-10 19:36:47.064186	10
69	69	10	3	1	1120	100	1020	0.737999999999999989	2015-06-03 16:47:07.524133	2015-06-10 19:36:47.079005	1
70	70	39	25	1	1050	30	1020	0.691999999999999948	2015-06-03 16:47:07.541716	2015-06-10 19:36:47.13636	10
71	71	3	1	1	1110	90	1020	0.767000000000000015	2015-06-03 16:47:07.561316	2015-06-10 19:36:47.150498	1
73	73	97	77	1	1070	70	1000	0.699999999999999956	2015-06-03 16:47:07.597984	2015-06-10 19:36:47.211767	8
74	74	88	46	1	1110	110	1000	0.686000000000000054	2015-06-03 16:47:07.615937	2015-06-10 19:36:47.224453	17
75	75	23	7	1	1040	50	990	0.745999999999999996	2015-06-03 16:47:07.634068	2015-06-10 19:36:47.236854	1
76	76	49	32	1	1050	60	990	0.708999999999999964	2015-06-03 16:47:07.653735	2015-06-10 19:36:47.286499	3
77	77	71	67	1	1050	60	990	0.75	2015-06-03 16:47:07.673209	2015-06-10 19:36:47.299606	5
78	78	34	21	1	1100	110	990	0.72699999999999998	2015-06-03 16:47:07.69009	2015-06-10 19:36:47.311022	7
79	79	41	25	1	1080	90	990	0.72699999999999998	2015-06-03 16:47:07.708121	2015-06-10 19:36:47.352463	10
81	81	17	5	1	1040	70	970	0.729999999999999982	2015-06-03 16:47:07.805252	2015-06-10 19:36:47.377544	1
82	82	36	21	1	1050	80	970	0.690999999999999948	2015-06-03 16:47:07.823482	2015-06-10 19:36:47.417172	7
83	83	52	37	1	1030	60	970	0.675000000000000044	2015-06-03 16:47:07.841426	2015-06-10 19:36:47.43167	16
84	84	13	4	1	1090	130	960	0.703999999999999959	2015-06-03 16:47:07.862046	2015-06-10 19:36:47.444263	1
85	85	2	1	1	1030	70	960	0.710999999999999965	2015-06-03 16:47:07.88074	2015-06-10 19:36:47.493151	1
86	86	67	56	1	1010	60	950	0.758000000000000007	2015-06-03 16:47:07.901868	2015-06-10 19:36:47.505816	6
87	87	75	68	1	980	60	920	0.688999999999999946	2015-06-03 16:47:07.920459	2015-06-10 19:36:47.517184	5
89	89	85	45	1	990	80	910	0.781000000000000028	2015-06-03 16:47:07.960087	2015-06-10 19:36:47.58065	17
90	90	44	26	1	1000	90	910	0.769000000000000017	2015-06-03 16:47:07.976622	2015-06-10 19:36:47.592411	10
91	91	79	62	1	1020	110	910	0.702999999999999958	2015-06-03 16:47:07.996508	2015-06-10 19:36:47.604747	15
92	92	74	68	1	980	80	900	0.745999999999999996	2015-06-03 16:47:08.015407	2015-06-10 19:36:47.641593	5
93	93	26	8	1	930	50	880	0.835999999999999965	2015-06-03 16:47:08.031891	2015-06-10 19:36:47.659158	1
94	94	63	51	1	930	60	870	0.628000000000000003	2015-06-03 16:47:08.050378	2015-06-10 19:36:47.70398	13
96	96	59	50	1	940	80	860	0.787000000000000033	2015-06-03 16:47:08.088006	2015-06-10 19:36:47.728963	13
97	97	7	2	1	930	80	850	0.733999999999999986	2015-06-03 16:47:08.108051	2015-06-10 19:36:47.740421	1
99	99	99	77	1	880	40	840	0.676000000000000045	2015-06-03 16:47:08.147415	2015-06-10 19:36:47.808655	8
101	101	94	74	1	830	60	770	0.667000000000000037	2015-06-03 16:47:08.244967	2015-06-10 19:36:47.869455	2
102	102	68	56	1	760	10	750	0.631000000000000005	2015-06-03 16:47:08.263378	2015-06-10 19:36:47.883108	6
103	103	77	62	1	780	40	740	0.667000000000000037	2015-06-03 16:47:08.282106	2015-06-10 19:36:47.894679	15
104	1	169	63	2	2780	320	2460	0.799000000000000044	2015-06-03 16:47:40.495516	2015-06-10 19:36:47.936456	15
105	2	149	52	2	2650	200	2450	0.766000000000000014	2015-06-03 16:47:40.514532	2015-06-10 19:36:47.951104	13
106	3	184	75	2	2500	190	2310	0.776000000000000023	2015-06-03 16:47:40.532012	2015-06-10 19:36:47.962593	2
107	4	172	64	2	2470	180	2290	0.770000000000000018	2015-06-03 16:47:40.552002	2015-06-10 19:36:48.009477	15
109	6	111	12	2	2420	180	2240	0.734999999999999987	2015-06-03 16:47:40.658696	2015-06-10 19:36:48.03434	1
110	7	167	69	2	2430	260	2170	0.755000000000000004	2015-06-03 16:47:40.680481	2015-06-10 19:36:48.084022	5
111	8	143	39	2	2410	260	2150	0.719999999999999973	2015-06-03 16:47:40.699099	2015-06-10 19:36:48.101492	16
112	9	185	79	2	2450	320	2130	0.745999999999999996	2015-06-03 16:47:40.717064	2015-06-10 19:36:48.114887	8
113	10	128	27	2	2390	270	2120	0.716999999999999971	2015-06-03 16:47:40.736223	2015-06-10 19:36:48.154595	10
114	11	176	65	2	2420	310	2110	0.72699999999999998	2015-06-03 16:47:40.754086	2015-06-10 19:36:48.167247	15
115	12	138	33	2	2400	290	2110	0.717999999999999972	2015-06-03 16:47:40.771172	2015-06-10 19:36:48.178734	3
117	14	146	40	2	2330	240	2090	0.76100000000000001	2015-06-03 16:47:40.808146	2015-06-10 19:36:48.259025	16
118	15	153	53	2	2280	200	2080	0.746999999999999997	2015-06-03 16:47:40.827684	2015-06-10 19:36:48.270749	13
119	16	125	23	2	2200	120	2080	0.709999999999999964	2015-06-03 16:47:40.850088	2015-06-10 19:36:48.322966	7
120	17	104	9	2	2300	230	2070	0.746999999999999997	2015-06-03 16:47:40.868678	2015-06-10 19:36:48.336765	1
121	18	158	57	2	2250	200	2050	0.716999999999999971	2015-06-03 16:47:40.886713	2015-06-10 19:36:48.348315	6
122	19	114	13	2	2270	230	2040	0.744999999999999996	2015-06-03 16:47:40.905001	2015-06-10 19:36:48.387344	1
124	21	147	41	2	2250	230	2020	0.730999999999999983	2015-06-03 16:47:40.94091	2015-06-10 19:36:48.412519	16
125	22	141	34	2	2260	250	2010	0.72699999999999998	2015-06-03 16:47:40.959095	2015-06-10 19:36:48.452386	3
126	23	105	10	2	2190	240	1950	0.758000000000000007	2015-06-03 16:47:40.976971	2015-06-10 19:36:48.467475	1
127	24	107	11	2	2160	230	1930	0.717999999999999972	2015-06-03 16:47:40.995591	2015-06-10 19:36:48.479651	1
128	25	180	47	2	2130	250	1880	0.690999999999999948	2015-06-03 16:47:41.014277	2015-06-10 19:36:48.524959	17
129	26	117	17	2	2120	240	1880	0.712999999999999967	2015-06-03 16:47:41.098724	2015-06-10 19:36:48.538536	4
130	27	134	29	2	1890	20	1870	0.711999999999999966	2015-06-03 16:47:41.118178	2015-06-10 19:36:48.549875	10
132	29	155	54	2	1930	160	1770	0.725999999999999979	2015-06-03 16:47:41.157405	2015-06-10 19:36:48.610378	13
133	30	123	22	2	1920	170	1750	0.703999999999999959	2015-06-03 16:47:41.176494	2015-06-10 19:36:48.623743	7
134	31	161	58	2	1970	230	1740	0.700999999999999956	2015-06-03 16:47:41.195856	2015-06-10 19:36:48.635512	6
135	32	160	57	2	1510	160	1350	0.765000000000000013	2015-06-03 16:47:41.215657	2015-06-10 19:36:48.676983	6
136	33	183	72	2	1380	90	1290	0.813999999999999946	2015-06-03 16:47:41.232611	2015-06-10 19:36:48.69069	11
137	34	136	29	2	1350	70	1280	0.775000000000000022	2015-06-03 16:47:41.249726	2015-06-10 19:36:48.702189	10
138	35	124	22	2	1350	80	1270	0.791000000000000036	2015-06-03 16:47:41.268071	2015-06-10 19:36:48.746489	7
140	37	142	34	2	1330	80	1250	0.741999999999999993	2015-06-03 16:47:41.30399	2015-06-10 19:36:48.778483	3
141	38	126	23	2	1290	70	1220	0.697999999999999954	2015-06-03 16:47:41.324704	2015-06-10 19:36:48.832692	7
142	39	178	65	2	1290	70	1220	0.793000000000000038	2015-06-03 16:47:41.34276	2015-06-10 19:36:48.844698	15
143	40	140	33	2	1270	70	1200	0.741999999999999993	2015-06-03 16:47:41.362298	2015-06-10 19:36:48.856066	3
144	41	156	54	2	1360	160	1200	0.744999999999999996	2015-06-03 16:47:41.379523	2015-06-10 19:36:48.908659	13
145	42	181	47	2	1310	120	1190	0.877000000000000002	2015-06-03 16:47:41.397889	2015-06-10 19:36:48.92271	17
147	44	118	17	2	1240	60	1180	0.673000000000000043	2015-06-03 16:47:41.433938	2015-06-10 19:36:48.97418	4
148	45	166	59	2	1250	80	1170	0.729999999999999982	2015-06-03 16:47:41.451367	2015-06-10 19:36:48.987413	6
149	46	120	18	2	1240	80	1160	0.723999999999999977	2015-06-03 16:47:41.536311	2015-06-10 19:36:48.999498	4
150	47	159	57	2	1260	120	1140	0.759000000000000008	2015-06-03 16:47:41.555099	2015-06-10 19:36:49.047261	6
151	48	186	79	2	1220	90	1130	0.702999999999999958	2015-06-03 16:47:41.575245	2015-06-10 19:36:49.061821	8
152	49	115	13	2	1130	30	1100	0.682000000000000051	2015-06-03 16:47:41.594893	2015-06-10 19:36:49.074731	1
153	50	145	39	2	1140	50	1090	0.724999999999999978	2015-06-03 16:47:41.614482	2015-06-10 19:36:49.141809	16
155	52	131	28	2	1090	10	1080	0.687999999999999945	2015-06-03 16:47:41.652628	2015-06-10 19:36:49.166468	10
156	53	112	12	2	1170	90	1080	0.705999999999999961	2015-06-03 16:47:41.67317	2015-06-10 19:36:49.209709	1
157	54	168	69	2	1140	70	1070	0.730999999999999983	2015-06-03 16:47:41.690721	2015-06-10 19:36:49.224144	5
158	55	133	28	2	1120	50	1070	0.792000000000000037	2015-06-03 16:47:41.711873	2015-06-10 19:36:49.235858	10
159	56	110	11	2	1150	90	1060	0.710999999999999965	2015-06-03 16:47:41.731584	2015-06-10 19:36:49.282439	1
160	57	121	18	2	1170	110	1060	0.781000000000000028	2015-06-03 16:47:41.748919	2015-06-10 19:36:49.29542	4
161	58	150	52	2	1060	10	1050	0.671000000000000041	2015-06-03 16:47:41.768323	2015-06-10 19:36:49.307155	13
163	60	144	39	2	1100	60	1040	0.746999999999999997	2015-06-03 16:47:41.805097	2015-06-10 19:36:49.376007	16
164	61	165	59	2	1150	120	1030	0.763000000000000012	2015-06-03 16:47:41.82417	2015-06-10 19:36:49.387608	6
165	62	187	79	2	1150	120	1030	0.766000000000000014	2015-06-03 16:47:41.841522	2015-06-10 19:36:49.425552	8
166	63	116	13	2	1140	120	1020	0.776000000000000023	2015-06-03 16:47:41.860407	2015-06-10 19:36:49.438434	1
167	64	163	58	2	1100	80	1020	0.746999999999999997	2015-06-03 16:47:41.880838	2015-06-10 19:36:49.449898	6
168	65	129	27	2	1110	90	1020	0.712999999999999967	2015-06-03 16:47:41.898183	2015-06-10 19:36:49.492785	10
170	67	113	12	2	1000	0	1000	0.742999999999999994	2015-06-03 16:47:42.001247	2015-06-10 19:36:49.51807	1
171	68	175	64	2	1000	0	1000	0.698999999999999955	2015-06-03 16:47:42.019033	2015-06-10 19:36:49.564221	15
172	69	106	10	2	1050	50	1000	0.75	2015-06-03 16:47:42.038223	2015-06-10 19:36:49.576876	1
173	70	173	64	2	1040	50	990	0.706999999999999962	2015-06-03 16:47:42.056636	2015-06-10 19:36:49.588652	15
174	71	152	52	2	1040	60	980	0.765000000000000013	2015-06-03 16:47:42.075646	2015-06-10 19:36:49.642777	13
175	72	127	23	2	970	10	960	0.692999999999999949	2015-06-03 16:47:42.095145	2015-06-10 19:36:49.656859	7
176	73	170	63	2	1040	80	960	0.725999999999999979	2015-06-03 16:47:42.112288	2015-06-10 19:36:49.668482	15
178	75	162	58	2	1020	80	940	0.71599999999999997	2015-06-03 16:47:42.147926	2015-06-10 19:36:49.72271	6
179	76	174	64	2	1010	70	940	0.675000000000000044	2015-06-03 16:47:42.167912	2015-06-10 19:36:49.734253	15
180	77	109	11	2	1030	90	940	0.810000000000000053	2015-06-03 16:47:42.186408	2015-06-10 19:36:49.776844	1
181	78	135	29	2	960	30	930	0.754000000000000004	2015-06-03 16:47:42.203867	2015-06-10 19:36:49.789827	10
182	79	108	11	2	940	80	860	0.649000000000000021	2015-06-03 16:47:42.221326	2015-06-10 19:36:49.802022	1
183	80	171	63	2	900	40	860	0.711999999999999966	2015-06-03 16:47:42.240371	2015-06-10 19:36:49.813737	15
184	81	151	52	2	910	60	850	0.671000000000000041	2015-06-03 16:47:42.257372	2015-06-10 19:36:49.851153	13
186	83	122	18	2	840	60	780	0.617999999999999994	2015-06-03 16:47:42.296358	2015-06-10 19:36:49.881788	4
187	84	139	33	2	850	70	780	0.643000000000000016	2015-06-03 16:47:42.313351	2015-06-10 19:36:49.934218	3
188	1	217	43	3	2430	170	2260	0.76100000000000001	2015-06-03 16:48:14.772079	2015-06-10 19:36:49.948444	16
189	2	198	20	3	2520	290	2230	0.780000000000000027	2015-06-03 16:48:14.796476	2015-06-10 19:36:49.961041	4
190	3	188	14	3	2360	210	2150	0.804000000000000048	2015-06-03 16:48:14.813797	2015-06-10 19:36:50.003679	1
191	4	229	61	3	2410	260	2150	0.748999999999999999	2015-06-03 16:48:14.832622	2015-06-10 19:36:50.015931	6
193	6	210	36	3	2340	250	2090	0.75	2015-06-03 16:48:14.8681	2015-06-10 19:36:50.06862	3
194	7	191	15	3	2300	230	2070	0.719999999999999973	2015-06-03 16:48:14.890369	2015-06-10 19:36:50.083331	1
1	1	33	21	1	2640	250	2390	0.815999999999999948	2015-06-03 16:47:05.999778	2015-06-10 19:36:45.442012	7
3	3	72	68	1	2510	240	2270	0.778000000000000025	2015-06-03 16:47:06.047593	2015-06-10 19:36:45.513867	5
11	11	96	77	1	2460	310	2150	0.705999999999999961	2015-06-03 16:47:06.235949	2015-06-10 19:36:45.678755	8
14	14	12	4	1	2220	130	2090	0.771000000000000019	2015-06-03 16:47:06.301099	2015-06-10 19:36:45.758127	1
26	26	54	38	1	2000	180	1820	0.686000000000000054	2015-06-03 16:47:06.546922	2015-06-10 19:36:46.043747	16
34	34	21	6	1	1440	120	1320	0.823999999999999955	2015-06-03 16:47:06.695843	2015-06-10 19:36:46.261929	1
42	42	40	25	1	1310	120	1190	0.822999999999999954	2015-06-03 16:47:06.955596	2015-06-10 19:36:46.454593	10
49	49	30	16	1	1200	80	1120	0.746999999999999997	2015-06-03 16:47:07.09255	2015-06-10 19:36:46.613464	4
57	57	38	25	1	1200	120	1080	0.823999999999999955	2015-06-03 16:47:07.241034	2015-06-10 19:36:46.78735	10
65	65	29	16	1	1110	80	1030	0.674000000000000044	2015-06-03 16:47:07.45151	2015-06-10 19:36:46.984466	4
72	72	78	62	1	1060	50	1010	0.713999999999999968	2015-06-03 16:47:07.579199	2015-06-10 19:36:47.164425	15
80	80	57	38	1	1070	90	980	0.717999999999999972	2015-06-03 16:47:07.786341	2015-06-10 19:36:47.366217	16
88	88	27	8	1	920	0	920	0.690999999999999948	2015-06-03 16:47:07.941124	2015-06-10 19:36:47.566082	1
95	95	90	71	1	970	100	870	0.634000000000000008	2015-06-03 16:47:08.070076	2015-06-10 19:36:47.717627	11
98	98	50	32	1	900	60	840	0.662000000000000033	2015-06-03 16:47:08.126109	2015-06-10 19:36:47.7964	3
100	100	32	16	1	900	100	800	0.754000000000000004	2015-06-03 16:47:08.225682	2015-06-10 19:36:47.819944	4
108	5	182	72	2	2500	250	2250	0.724999999999999978	2015-06-03 16:47:40.570012	2015-06-10 19:36:48.022769	11
116	13	119	18	2	2330	240	2090	0.746999999999999997	2015-06-03 16:47:40.789579	2015-06-10 19:36:48.239956	4
123	20	130	28	2	2320	290	2030	0.73899999999999999	2015-06-03 16:47:40.921674	2015-06-10 19:36:48.400736	10
131	28	164	59	2	1980	180	1800	0.673000000000000043	2015-06-03 16:47:41.136662	2015-06-10 19:36:48.561314	6
139	36	177	65	2	1390	140	1250	0.741999999999999993	2015-06-03 16:47:41.2851	2015-06-10 19:36:48.759815	15
146	43	132	28	2	1260	80	1180	0.706999999999999962	2015-06-03 16:47:41.416588	2015-06-10 19:36:48.934808	10
154	51	179	65	2	1180	100	1080	0.753000000000000003	2015-06-03 16:47:41.632928	2015-06-10 19:36:49.154959	15
162	59	157	54	2	1130	80	1050	0.823999999999999955	2015-06-03 16:47:41.786175	2015-06-10 19:36:49.357992	13
169	66	137	29	2	1080	70	1010	0.786000000000000032	2015-06-03 16:47:41.983542	2015-06-10 19:36:49.50627	10
177	74	148	41	2	1020	80	940	0.710999999999999965	2015-06-03 16:47:42.13034	2015-06-10 19:36:49.709011	16
185	82	154	53	2	830	10	820	0.657000000000000028	2015-06-03 16:47:42.27718	2015-06-10 19:36:49.86945	13
192	5	194	19	3	2380	240	2140	0.768000000000000016	2015-06-03 16:48:14.850333	2015-06-10 19:36:50.027524	4
195	8	207	35	3	2220	190	2030	0.771000000000000019	2015-06-03 16:48:14.907347	2015-06-10 19:36:50.096963	3
196	9	233	70	3	2260	250	2010	0.701999999999999957	2015-06-03 16:48:14.925176	2015-06-10 19:36:50.147622	5
197	10	201	24	3	2150	170	1980	0.680000000000000049	2015-06-03 16:48:15.007496	2015-06-10 19:36:50.1616	7
198	11	254	80	3	2250	270	1980	0.701999999999999957	2015-06-03 16:48:15.024424	2015-06-10 19:36:50.172914	8
199	12	250	76	3	2100	150	1950	0.742999999999999994	2015-06-03 16:48:15.043646	2015-06-10 19:36:50.213336	2
200	13	204	30	3	2130	200	1930	0.721999999999999975	2015-06-03 16:48:15.061937	2015-06-10 19:36:50.22756	10
201	14	225	60	3	2170	260	1910	0.723999999999999977	2015-06-03 16:48:15.081511	2015-06-10 19:36:50.238897	6
202	15	236	66	3	2060	160	1900	0.732999999999999985	2015-06-03 16:48:15.100205	2015-06-10 19:36:50.278687	15
203	16	213	42	3	2020	160	1860	0.686000000000000054	2015-06-03 16:48:15.119808	2015-06-10 19:36:50.291685	16
204	17	221	55	3	2040	200	1840	0.710999999999999965	2015-06-03 16:48:15.138523	2015-06-10 19:36:50.303589	13
205	18	247	73	3	1960	180	1780	0.688999999999999946	2015-06-03 16:48:15.156594	2015-06-10 19:36:50.353047	11
206	19	240	48	3	1930	160	1770	0.667000000000000037	2015-06-03 16:48:15.174915	2015-06-10 19:36:50.36746	17
207	20	244	49	3	1960	220	1740	0.706999999999999962	2015-06-03 16:48:15.192125	2015-06-10 19:36:50.384456	17
208	21	195	19	3	1640	160	1480	0.769000000000000017	2015-06-03 16:48:15.209521	2015-06-10 19:36:50.432142	4
209	22	208	35	3	1490	160	1330	0.838999999999999968	2015-06-03 16:48:15.228921	2015-06-10 19:36:50.444981	3
210	23	243	48	3	1430	120	1310	0.789000000000000035	2015-06-03 16:48:15.246261	2015-06-10 19:36:50.456468	17
211	24	228	60	3	1330	40	1290	0.822999999999999954	2015-06-03 16:48:15.26459	2015-06-10 19:36:50.49528	6
212	25	196	19	3	1410	120	1290	0.739999999999999991	2015-06-03 16:48:15.283672	2015-06-10 19:36:50.508621	4
213	26	199	20	3	1440	150	1290	0.785000000000000031	2015-06-03 16:48:15.300997	2015-06-10 19:36:50.520615	4
214	27	245	49	3	1390	100	1290	0.764000000000000012	2015-06-03 16:48:15.320632	2015-06-10 19:36:50.569214	17
215	28	193	15	3	1300	30	1270	0.79500000000000004	2015-06-03 16:48:15.339254	2015-06-10 19:36:50.581955	1
216	29	219	43	3	1320	70	1250	0.767000000000000015	2015-06-03 16:48:15.357444	2015-06-10 19:36:50.59345	16
217	30	231	61	3	1280	60	1220	0.771000000000000019	2015-06-03 16:48:15.447028	2015-06-10 19:36:50.65117	6
218	31	216	42	3	1330	110	1220	0.756000000000000005	2015-06-03 16:48:15.465013	2015-06-10 19:36:50.663957	16
219	32	256	80	3	1290	80	1210	0.70499999999999996	2015-06-03 16:48:15.483848	2015-06-10 19:36:50.676237	8
221	34	200	20	3	1300	100	1200	0.759000000000000008	2015-06-03 16:48:15.519454	2015-06-10 19:36:50.742385	4
222	35	249	73	3	1260	60	1200	0.826999999999999957	2015-06-03 16:48:15.537346	2015-06-10 19:36:50.753832	11
223	36	206	30	3	1290	110	1180	0.712999999999999967	2015-06-03 16:48:15.554413	2015-06-10 19:36:50.792521	10
224	37	251	76	3	1240	70	1170	0.746999999999999997	2015-06-03 16:48:15.574183	2015-06-10 19:36:50.806501	2
225	38	212	36	3	1250	80	1170	0.72699999999999998	2015-06-03 16:48:15.591518	2015-06-10 19:36:50.818466	3
226	39	218	43	3	1290	120	1170	0.762000000000000011	2015-06-03 16:48:15.609531	2015-06-10 19:36:50.830948	16
227	40	220	43	3	1260	100	1160	0.73899999999999999	2015-06-03 16:48:15.62968	2015-06-10 19:36:50.878536	16
229	42	224	55	3	1180	50	1130	0.72799999999999998	2015-06-03 16:48:15.665363	2015-06-10 19:36:50.908481	13
230	43	255	80	3	1170	50	1120	0.725999999999999979	2015-06-03 16:48:15.684448	2015-06-10 19:36:50.95035	8
231	44	252	76	3	1210	90	1120	0.696999999999999953	2015-06-03 16:48:15.704304	2015-06-10 19:36:50.962615	2
232	45	232	61	3	1190	70	1120	0.737999999999999989	2015-06-03 16:48:15.723435	2015-06-10 19:36:50.974041	6
233	46	235	70	3	1210	90	1120	0.737999999999999989	2015-06-03 16:48:15.740947	2015-06-10 19:36:51.017	5
234	47	237	66	3	1190	70	1120	0.720999999999999974	2015-06-03 16:48:15.758805	2015-06-10 19:36:51.031088	15
236	49	234	70	3	1180	100	1080	0.743999999999999995	2015-06-03 16:48:15.795593	2015-06-10 19:36:51.084947	5
237	50	227	60	3	1150	70	1080	0.731999999999999984	2015-06-03 16:48:15.874885	2015-06-10 19:36:51.098384	6
238	51	203	24	3	1110	40	1070	0.781000000000000028	2015-06-03 16:48:15.892598	2015-06-10 19:36:51.111182	7
239	52	189	14	3	1150	100	1050	0.756000000000000005	2015-06-03 16:48:15.910312	2015-06-10 19:36:51.168393	1
240	53	239	66	3	1140	100	1040	0.743999999999999995	2015-06-03 16:48:15.927986	2015-06-10 19:36:51.18115	15
241	54	246	49	3	1080	70	1010	0.703999999999999959	2015-06-03 16:48:15.946219	2015-06-10 19:36:51.193514	17
242	55	211	36	3	1090	110	980	0.736999999999999988	2015-06-03 16:48:15.9636	2015-06-10 19:36:51.248385	3
244	57	214	42	3	1030	60	970	0.735999999999999988	2015-06-03 16:48:16.00192	2015-06-10 19:36:51.273204	16
245	58	205	30	3	1050	100	950	0.632000000000000006	2015-06-03 16:48:16.021103	2015-06-10 19:36:51.313847	10
246	59	197	19	3	1020	110	910	0.719999999999999973	2015-06-03 16:48:16.039668	2015-06-10 19:36:51.327293	4
247	60	223	55	3	970	70	900	0.75	2015-06-03 16:48:16.057769	2015-06-10 19:36:51.340066	13
248	61	226	60	3	920	40	880	0.754000000000000004	2015-06-03 16:48:16.075037	2015-06-10 19:36:51.387124	6
249	62	202	24	3	940	80	860	0.762000000000000011	2015-06-03 16:48:16.095201	2015-06-10 19:36:51.400821	7
250	63	238	66	3	920	60	860	0.641000000000000014	2015-06-03 16:48:16.11172	2015-06-10 19:36:51.412621	15
252	65	248	73	3	900	80	820	0.633000000000000007	2015-06-03 16:48:16.150166	2015-06-10 19:36:51.481632	11
253	66	209	35	3	860	40	820	0.754000000000000004	2015-06-03 16:48:16.166935	2015-06-10 19:36:51.493747	3
254	67	253	76	3	840	60	780	0.764000000000000012	2015-06-03 16:48:16.184953	2015-06-10 19:36:51.534667	2
255	68	241	48	3	770	70	700	0.651000000000000023	2015-06-03 16:48:16.204698	2015-06-10 19:36:51.548446	17
256	69	242	48	3	610	20	590	0.653000000000000025	2015-06-03 16:48:16.222984	2015-06-10 19:36:51.559879	17
220	33	222	55	3	1310	100	1210	0.718999999999999972	2015-06-03 16:48:15.502148	2015-06-10 19:36:50.726482	13
228	41	215	42	3	1200	60	1140	0.763000000000000012	2015-06-03 16:48:15.646902	2015-06-10 19:36:50.890508	16
235	48	192	15	3	1180	90	1090	0.756000000000000005	2015-06-03 16:48:15.778845	2015-06-10 19:36:51.042723	1
243	56	190	14	3	1040	60	980	0.822999999999999954	2015-06-03 16:48:15.981858	2015-06-10 19:36:51.261833	1
251	64	230	61	3	920	80	840	0.68100000000000005	2015-06-03 16:48:16.129631	2015-06-10 19:36:51.466559	6
\.


--
-- Name: indiv_standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('indiv_standings_id_seq', 256, true);


--
-- Data for Name: organization_students; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY organization_students (id, organization_id, student_id, start_date, end_date) FROM stdin;
1	1	1	2014-06-09	\N
2	1	2	2014-06-09	\N
3	1	3	2014-06-09	\N
4	1	4	2014-06-09	\N
5	1	5	2014-06-09	\N
6	1	6	2014-06-09	\N
7	1	7	2014-06-09	\N
8	1	8	2014-06-09	\N
9	1	9	2014-06-09	\N
10	1	10	2014-06-09	\N
11	1	11	2014-06-09	\N
12	1	12	2014-06-09	\N
13	1	13	2014-06-09	\N
14	1	14	2014-06-09	\N
15	1	15	2014-06-09	\N
16	1	16	2014-06-09	\N
17	1	17	2014-06-09	\N
18	1	18	2014-06-09	\N
19	1	19	2014-06-09	\N
20	1	20	2014-06-09	\N
21	1	21	2014-06-09	\N
22	1	22	2014-06-09	\N
23	1	23	2014-06-09	\N
24	1	24	2014-06-09	\N
25	1	25	2014-06-09	\N
26	1	26	2014-06-09	\N
27	1	27	2014-06-09	\N
28	4	28	2014-06-09	\N
29	4	29	2014-06-09	\N
30	4	30	2014-06-09	\N
31	4	31	2014-06-09	\N
32	4	32	2014-06-09	\N
33	7	33	2014-06-09	\N
34	7	34	2014-06-09	\N
35	7	35	2014-06-09	\N
36	7	36	2014-06-09	\N
37	10	37	2014-06-09	\N
38	10	38	2014-06-09	\N
39	10	39	2014-06-09	\N
40	10	40	2014-06-09	\N
41	10	41	2014-06-09	\N
42	10	42	2014-06-09	\N
43	10	43	2014-06-09	\N
44	10	44	2014-06-09	\N
45	3	45	2014-06-09	\N
46	3	46	2014-06-09	\N
47	3	47	2014-06-09	\N
48	3	48	2014-06-09	\N
49	3	49	2014-06-09	\N
50	3	50	2014-06-09	\N
51	16	51	2014-06-09	\N
52	16	52	2014-06-09	\N
53	16	53	2014-06-09	\N
54	16	54	2014-06-09	\N
55	16	55	2014-06-09	\N
56	16	56	2014-06-09	\N
57	16	57	2014-06-09	\N
58	13	58	2014-06-09	\N
59	13	59	2014-06-09	\N
60	13	60	2014-06-09	\N
61	13	61	2014-06-09	\N
62	13	62	2014-06-09	\N
63	13	63	2014-06-09	\N
64	13	64	2014-06-09	\N
65	6	65	2014-06-09	\N
66	6	66	2014-06-09	\N
67	6	67	2014-06-09	\N
68	6	68	2014-06-09	\N
69	5	69	2014-06-09	\N
70	5	70	2014-06-09	\N
71	5	71	2014-06-09	\N
72	5	72	2014-06-09	\N
73	5	73	2014-06-09	\N
74	5	74	2014-06-09	\N
75	5	75	2014-06-09	\N
76	15	76	2014-06-09	\N
77	15	77	2014-06-09	\N
78	15	78	2014-06-09	\N
79	15	79	2014-06-09	\N
80	17	80	2014-06-09	\N
81	17	81	2014-06-09	\N
82	17	82	2014-06-09	\N
83	17	83	2014-06-09	\N
84	17	84	2014-06-09	\N
85	17	85	2014-06-09	\N
86	17	86	2014-06-09	\N
87	17	87	2014-06-09	\N
88	17	88	2014-06-09	\N
89	11	89	2014-06-09	\N
90	11	90	2014-06-09	\N
91	11	91	2014-06-09	\N
92	2	92	2014-06-09	\N
93	2	93	2014-06-09	\N
94	2	94	2014-06-09	\N
95	2	95	2014-06-09	\N
96	8	96	2014-06-09	\N
97	8	97	2014-06-09	\N
98	8	98	2014-06-09	\N
99	8	99	2014-06-09	\N
100	8	100	2014-06-09	\N
101	8	101	2014-06-09	\N
102	8	102	2014-06-09	\N
103	8	103	2014-06-09	\N
104	1	104	2014-06-09	\N
105	1	105	2014-06-09	\N
106	1	106	2014-06-09	\N
107	1	107	2014-06-09	\N
108	1	108	2014-06-09	\N
109	1	109	2014-06-09	\N
110	1	110	2014-06-09	\N
111	1	111	2014-06-09	\N
112	1	112	2014-06-09	\N
113	1	113	2014-06-09	\N
114	1	114	2014-06-09	\N
115	1	115	2014-06-09	\N
116	1	116	2014-06-09	\N
117	4	117	2014-06-09	\N
118	4	118	2014-06-09	\N
119	4	119	2014-06-09	\N
120	4	120	2014-06-09	\N
121	4	121	2014-06-09	\N
122	4	122	2014-06-09	\N
123	7	123	2014-06-09	\N
124	7	124	2014-06-09	\N
125	7	125	2014-06-09	\N
126	7	126	2014-06-09	\N
127	7	127	2014-06-09	\N
128	10	128	2014-06-09	\N
129	10	129	2014-06-09	\N
130	10	130	2014-06-09	\N
131	10	131	2014-06-09	\N
132	10	132	2014-06-09	\N
133	10	133	2014-06-09	\N
134	10	134	2014-06-09	\N
135	10	135	2014-06-09	\N
136	10	136	2014-06-09	\N
137	10	137	2014-06-09	\N
138	3	138	2014-06-09	\N
139	3	139	2014-06-09	\N
140	3	140	2014-06-09	\N
141	3	141	2014-06-09	\N
142	3	142	2014-06-09	\N
143	16	143	2014-06-09	\N
144	16	144	2014-06-09	\N
145	16	145	2014-06-09	\N
146	16	146	2014-06-09	\N
147	16	147	2014-06-09	\N
148	16	148	2014-06-09	\N
149	13	149	2014-06-09	\N
150	13	150	2014-06-09	\N
151	13	151	2014-06-09	\N
152	13	152	2014-06-09	\N
153	13	153	2014-06-09	\N
154	13	154	2014-06-09	\N
155	13	155	2014-06-09	\N
156	13	156	2014-06-09	\N
157	13	157	2014-06-09	\N
158	6	158	2014-06-09	\N
159	6	159	2014-06-09	\N
160	6	160	2014-06-09	\N
161	6	161	2014-06-09	\N
162	6	162	2014-06-09	\N
163	6	163	2014-06-09	\N
164	6	164	2014-06-09	\N
165	6	165	2014-06-09	\N
166	6	166	2014-06-09	\N
167	5	167	2014-06-09	\N
168	5	168	2014-06-09	\N
169	15	169	2014-06-09	\N
170	15	170	2014-06-09	\N
171	15	171	2014-06-09	\N
172	15	172	2014-06-09	\N
173	15	173	2014-06-09	\N
174	15	174	2014-06-09	\N
175	15	175	2014-06-09	\N
176	15	176	2014-06-09	\N
177	15	177	2014-06-09	\N
178	15	178	2014-06-09	\N
179	15	179	2014-06-09	\N
180	17	180	2014-06-09	\N
181	17	181	2014-06-09	\N
182	11	182	2014-06-09	\N
183	11	183	2014-06-09	\N
184	2	184	2014-06-09	\N
185	8	185	2014-06-09	\N
186	8	186	2014-06-09	\N
187	8	187	2014-06-09	\N
188	1	188	2014-06-09	\N
189	1	189	2014-06-09	\N
190	1	190	2014-06-09	\N
191	1	191	2014-06-09	\N
192	1	192	2014-06-09	\N
193	1	193	2014-06-09	\N
194	4	194	2014-06-09	\N
195	4	195	2014-06-09	\N
196	4	196	2014-06-09	\N
197	4	197	2014-06-09	\N
198	4	198	2014-06-09	\N
199	4	199	2014-06-09	\N
200	4	200	2014-06-09	\N
201	7	201	2014-06-09	\N
202	7	202	2014-06-09	\N
203	7	203	2014-06-09	\N
204	10	204	2014-06-09	\N
205	10	205	2014-06-09	\N
206	10	206	2014-06-09	\N
207	3	207	2014-06-09	\N
208	3	208	2014-06-09	\N
209	3	209	2014-06-09	\N
210	3	210	2014-06-09	\N
211	3	211	2014-06-09	\N
212	3	212	2014-06-09	\N
213	16	213	2014-06-09	\N
214	16	214	2014-06-09	\N
215	16	215	2014-06-09	\N
216	16	216	2014-06-09	\N
217	16	217	2014-06-09	\N
218	16	218	2014-06-09	\N
219	16	219	2014-06-09	\N
220	16	220	2014-06-09	\N
221	13	221	2014-06-09	\N
222	13	222	2014-06-09	\N
223	13	223	2014-06-09	\N
224	13	224	2014-06-09	\N
225	6	225	2014-06-09	\N
226	6	226	2014-06-09	\N
227	6	227	2014-06-09	\N
228	6	228	2014-06-09	\N
229	6	229	2014-06-09	\N
230	6	230	2014-06-09	\N
231	6	231	2014-06-09	\N
232	6	232	2014-06-09	\N
233	5	233	2014-06-09	\N
234	5	234	2014-06-09	\N
235	5	235	2014-06-09	\N
236	15	236	2014-06-09	\N
237	15	237	2014-06-09	\N
238	15	238	2014-06-09	\N
239	15	239	2014-06-09	\N
240	17	240	2014-06-09	\N
241	17	241	2014-06-09	\N
242	17	242	2014-06-09	\N
243	17	243	2014-06-09	\N
244	17	244	2014-06-09	\N
245	17	245	2014-06-09	\N
246	17	246	2014-06-09	\N
247	11	247	2014-06-09	\N
248	11	248	2014-06-09	\N
249	11	249	2014-06-09	\N
250	2	250	2014-06-09	\N
251	2	251	2014-06-09	\N
252	2	252	2014-06-09	\N
253	2	253	2014-06-09	\N
254	8	254	2014-06-09	\N
255	8	255	2014-06-09	\N
256	8	256	2014-06-09	\N
\.


--
-- Name: organization_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('organization_students_id_seq', 256, true);


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY organizations (id, name, short_name, street_1, street_2, city, state, zip, latitude, longitude, active, primary_contact_id) FROM stdin;
9	Sculton Alliance Church	Sculton	1033 Scullton Rd	\N	Rockwood	PA	15557	39.9477035	-79.313205	f	\N
12	Glenshaw Alliance Church	Glenshaw	3601 Mount Royal Blvd	\N	Glenshaw	PA	15116	40.5504141	-79.9715803	f	\N
14	Urban Impact Foundation	UIF	801 Union Avenue	\N	Pittsburgh	PA	15212	40.453995	-80.0031248	f	\N
1	Allegheny Center Alliance Church	ACAC	250 E Ohio Street	\N	Piitsburgh	PA	15212	40.4533665	-80.0030653	t	1
4	Broadway Alliance Church	Broadway	1000 Broadway Street	\N	East Mc Keesport	PA	15035	40.383786	-79.810438	t	5
7	Cherry Tree Alliance Church	Cherry Tree	640 Cherry Tree Lane	\N	Uniontown	PA	15401	39.9015907	-79.7551046	t	7
10	Chicora Alliance Church	Chicora	310 E Slippery Rock St	\N	Chicora	PA	16025	40.9464336	-79.7391402	t	9
3	Dorseyville Alliance Church	Dorseyville	3703 Saxonburg Blvd	\N	Indiana Twp	PA	15238	40.575015	-79.892385	t	12
16	Elkins Alliance	Elkins	PO Box 2904	\N	Elkins	WV	26241	38.9139309	-79.7848422	t	15
17	First Alliance (New Castle)	New Castle	111 Mission Meade Street	\N	New Castle	PA	16105	41.0321736	-80.3577379	t	16
13	Greensburg Alliance Church	Greensburg	4428 Route 136	\N	Greensburg	PA	15601	40.2838005	-79.5907678	t	19
6	Indiana Alliance Church	Indiana	2510 Warren Road	\N	Indiana	PA	15701	40.6098642	-79.1910152	t	20
15	McKeesport Alliance Church	McKeesport	938 Summitt Street	\N	Mckeesport	PA	15132	40.353107	-79.829035	t	24
5	Murrysville Alliance Church	MAC	4130 Old William Penn Highway	\N	Murrysville	PA	15668	40.4287738	-79.6889323	t	28
11	Norwin Alliance Church	Norwin	10585 Farview Drive	\N	Irwin	PA	15642	40.3081559	-79.722742	t	29
2	Somerset Alliance Church	Somerset	708 Stoystown Road	\N	Somerset	PA	15501	40.020516	-79.059012	t	30
8	Washington Alliance Church	Washington	246 Sanitarium Road	\N	Washington	PA	15301	40.1512977	-80.2162031	t	34
\.


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('organizations_id_seq', 17, true);


--
-- Data for Name: pg_search_documents; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY pg_search_documents (id, content, searchable_id, searchable_type, created_at, updated_at) FROM stdin;
\.


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('pg_search_documents_id_seq', 1, false);


--
-- Data for Name: quiz_teams; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY quiz_teams (id, quiz_id, team_id, "position", raw_score, points, failed_challenges, place) FROM stdin;
4	2	67	1	190	19	0	1
5	2	26	2	110	11	0	2
8	3	68	2	260	26	0	1
9	3	2	3	190	19	0	3
11	4	32	2	230	23	0	1
10	4	7	1	110	11	0	3
15	5	5	3	120	12	0	1
14	5	74	2	80	8	0	2
13	5	6	1	70	7	0	3
18	6	1	3	140	14	0	2
16	6	78	1	100	10	0	3
19	7	71	1	150	15	0	1
20	7	56	2	140	14	0	2
21	7	50	3	100	10	0	3
24	8	62	3	140	14	0	2
23	8	44	2	80	8	0	3
25	9	4	1	140	14	0	3
29	10	46	2	140	14	0	1
28	10	38	1	130	13	0	2
30	10	31	3	110	11	0	3
33	11	77	3	160	16	0	1
31	11	50	1	150	15	0	2
34	12	25	1	200	20	0	1
36	12	3	3	200	20	0	2
35	12	71	2	70	7	0	3
39	13	67	3	180	18	0	1
38	13	37	2	70	7	0	3
40	14	5	1	160	16	0	2
41	14	26	2	130	13	0	3
43	15	46	1	210	21	0	1
44	15	6	2	60	6	0	3
46	16	45	1	190	19	0	1
48	16	21	3	150	15	0	2
49	17	56	1	180	18	0	1
50	17	78	2	180	18	0	2
51	17	1	3	150	15	0	3
54	18	68	3	250	25	0	1
53	18	62	2	170	17	0	2
56	19	16	2	190	19	0	2
55	19	74	1	130	13	0	3
58	20	2	1	210	21	0	1
59	20	71	2	130	13	0	2
60	20	38	3	90	9	0	3
63	21	26	3	150	15	0	2
65	22	2	2	170	17	0	1
64	22	4	1	150	15	0	2
66	22	8	3	110	11	0	3
68	23	5	2	230	23	0	1
69	23	68	3	150	15	0	2
71	24	3	2	220	22	0	1
70	24	62	1	210	21	0	2
73	25	51	1	160	16	0	1
74	25	32	2	120	12	0	2
75	25	16	3	110	11	0	3
76	26	50	1	140	14	0	1
78	26	45	3	110	11	0	3
79	27	31	1	190	19	0	1
80	27	74	2	140	14	0	2
83	28	21	2	180	18	0	1
84	28	37	3	170	17	0	2
85	29	7	1	160	16	0	1
86	29	6	2	150	15	0	2
89	30	25	2	180	18	0	1
88	30	71	1	100	10	0	2
90	30	67	3	100	10	0	3
93	31	2	3	190	19	0	1
91	31	26	1	100	10	0	3
94	32	21	1	170	17	0	1
96	32	50	3	170	17	0	2
95	32	51	2	130	13	0	3
99	33	78	3	240	24	0	1
98	33	44	2	130	13	0	3
101	34	7	2	30	3	0	3
104	35	37	2	220	22	0	1
103	35	38	1	130	13	0	2
105	35	62	3	50	5	0	3
108	36	74	3	220	22	0	1
106	36	77	1	80	8	0	3
109	37	6	1	210	21	0	1
110	37	3	2	210	21	0	2
111	37	31	3	140	14	0	3
113	38	32	2	140	14	0	2
114	38	8	3	80	8	0	3
116	39	1	2	120	12	0	1
115	39	56	1	90	9	0	3
119	40	38	2	240	24	0	1
118	40	45	1	180	18	0	3
123	41	31	3	240	24	0	1
121	41	2	1	130	13	0	2
125	42	32	2	150	15	0	1
126	42	3	3	110	11	0	2
124	42	44	1	70	7	0	3
129	43	16	3	180	18	0	1
128	43	56	2	110	11	0	2
131	44	7	2	200	20	0	2
130	44	77	1	100	10	0	3
133	45	6	1	210	21	0	1
134	45	26	2	160	16	0	2
135	45	4	3	160	16	0	3
136	46	21	1	120	12	0	2
141	47	46	3	180	18	0	1
140	47	78	2	170	17	0	2
139	47	71	1	160	16	0	3
144	48	50	3	160	16	0	1
143	48	1	2	140	14	0	2
145	49	8	1	150	15	0	1
146	49	68	2	150	15	0	2
148	50	7	1	170	17	0	1
149	50	44	2	130	13	0	2
150	50	37	3	120	12	0	3
153	51	25	3	230	23	0	1
151	51	74	1	190	19	0	2
156	52	56	3	170	17	0	1
155	52	8	2	150	15	0	2
161	54	26	2	230	23	0	1
162	54	46	3	170	17	0	2
160	54	50	1	40	4	0	3
163	55	62	1	130	13	0	2
165	55	38	3	70	7	0	3
168	56	4	3	160	16	0	1
167	56	1	2	130	13	0	2
166	56	77	1	100	10	0	3
171	57	16	3	210	21	0	1
170	57	78	2	180	18	0	2
172	58	6	1	200	20	0	1
173	58	32	2	190	19	0	2
176	61	18	2	150	15	0	2
177	61	9	3	70	7	0	3
180	62	63	3	140	14	0	1
178	62	17	1	110	11	0	2
181	63	28	1	130	13	0	2
183	63	41	3	110	11	0	3
185	64	58	2	160	16	0	1
186	64	52	3	70	7	0	3
188	65	33	2	220	22	0	2
187	65	29	1	180	18	0	3
192	66	72	3	70	7	0	1
191	66	65	2	60	6	0	2
190	66	11	1	50	5	0	3
193	67	79	1	190	19	0	1
195	67	27	3	100	10	0	2
196	68	12	1	80	8	0	1
198	68	75	3	60	6	0	2
197	68	10	2	50	5	0	3
200	69	69	2	170	17	0	2
202	70	47	1	210	21	0	1
203	70	22	2	40	4	0	3
205	71	23	1	210	21	0	1
206	71	34	2	100	10	0	2
207	71	47	3	60	6	0	3
208	72	54	1	190	19	0	1
210	72	13	3	140	14	0	2
213	73	57	3	190	19	0	1
211	73	9	1	100	10	0	2
212	73	28	2	100	10	0	3
216	74	11	3	180	18	0	2
215	74	53	2	80	8	0	3
218	75	52	2	200	20	0	1
220	76	63	1	150	15	0	1
221	76	75	2	100	10	0	2
222	76	40	3	70	7	0	3
223	77	69	1	180	18	0	1
225	77	33	3	150	15	0	2
228	78	65	3	200	20	0	1
227	78	58	2	100	10	0	2
226	78	39	1	90	9	0	3
230	79	59	2	210	21	0	1
231	79	64	3	130	13	0	2
233	80	17	2	100	10	0	1
232	80	10	1	90	9	0	2
237	81	58	3	130	13	0	1
236	81	18	2	110	11	0	2
238	82	23	1	130	13	0	1
240	82	59	3	80	8	0	3
242	83	39	2	240	24	0	1
243	83	11	3	170	17	0	2
241	83	40	1	80	8	0	3
245	84	12	2	150	15	0	1
246	84	47	3	110	11	0	3
247	85	75	1	110	11	0	2
248	85	9	2	-10	-1	0	3
251	86	41	2	140	14	0	1
250	86	72	1	120	12	0	2
252	86	27	3	60	6	0	3
253	87	65	1	170	17	0	1
255	87	69	3	100	10	0	3
258	88	52	3	110	11	0	2
256	88	22	1	100	10	0	3
260	89	57	2	180	18	0	1
261	89	33	3	130	13	0	2
262	90	54	1	190	19	0	1
263	90	63	2	130	13	0	2
266	91	79	2	200	20	0	1
267	91	10	3	130	13	0	2
265	91	13	1	90	9	0	3
270	92	40	3	130	13	0	2
268	92	53	1	20	2	0	3
272	93	18	2	80	8	0	1
271	93	34	1	0	0	0	2
273	93	33	3	0	0	0	3
276	94	17	3	90	9	0	3
278	95	9	2	130	13	0	2
277	95	63	1	80	8	0	3
281	96	39	2	140	14	0	1
282	96	27	3	110	11	0	2
280	96	22	1	40	4	0	3
285	97	47	3	130	13	0	1
283	97	75	1	80	8	0	3
286	98	23	1	180	18	0	1
288	98	57	3	180	18	0	2
287	98	69	2	60	6	0	3
291	99	11	3	150	15	0	1
290	99	41	2	60	6	0	3
293	100	54	2	140	14	0	2
296	101	65	2	230	23	0	1
295	101	58	1	150	15	0	2
297	101	72	3	70	7	0	3
298	102	13	1	90	9	0	1
300	102	54	3	60	6	0	2
303	103	57	3	180	18	0	1
302	103	34	2	130	13	0	2
301	103	9	1	60	6	0	3
305	104	28	2	220	22	0	1
306	104	11	3	100	10	0	3
308	105	59	2	150	15	0	1
307	105	47	1	110	11	0	3
312	106	58	3	200	20	0	1
310	106	33	1	170	17	0	2
313	107	65	1	240	24	0	1
317	108	23	2	170	17	0	1
318	108	18	3	90	9	0	3
320	109	52	2	270	27	0	1
319	109	22	1	60	6	0	3
324	110	29	3	170	17	0	1
322	110	27	1	160	16	0	2
323	110	13	2	120	12	0	3
325	111	39	1	250	25	0	1
327	111	79	3	120	12	0	2
329	112	63	2	140	14	0	1
330	112	64	3	90	9	0	2
328	112	69	1	70	7	0	3
332	113	58	2	120	12	0	2
335	114	47	2	160	16	0	1
334	114	13	1	100	10	0	2
338	115	52	2	150	15	0	1
339	115	63	3	150	15	0	2
337	115	75	1	100	10	0	3
342	116	12	3	150	15	0	2
340	116	17	1	80	8	0	3
343	117	28	1	160	16	0	1
344	117	34	2	30	3	0	3
348	118	69	3	200	20	0	1
347	118	29	2	110	11	0	2
350	119	41	2	60	6	0	3
354	120	57	3	180	18	0	1
353	120	79	2	150	15	0	2
352	120	27	1	50	5	0	3
355	121	10	1	140	14	0	1
357	121	18	3	120	12	0	2
358	122	23	1	170	17	0	1
360	122	40	3	70	7	0	2
359	122	54	2	40	4	0	3
362	124	66	2	210	21	0	1
363	124	55	3	130	13	0	2
365	125	61	2	220	22	0	1
364	125	15	1	110	11	0	3
367	126	43	1	190	19	0	1
369	126	70	3	130	13	0	3
372	127	36	3	260	26	0	1
370	127	35	1	110	11	0	3
374	128	73	2	150	15	0	1
373	128	20	1	130	13	0	2
375	128	30	3	80	8	0	3
377	129	60	2	200	20	0	1
378	129	24	3	110	11	0	3
380	130	49	2	240	24	0	1
379	130	48	1	70	7	0	3
384	131	42	3	190	19	0	1
382	131	80	1	180	18	0	2
383	131	55	2	140	14	0	3
385	132	43	1	180	18	0	1
390	133	61	3	230	23	0	1
389	133	30	2	170	17	0	2
388	133	49	1	90	9	0	3
392	134	24	2	150	15	0	1
393	134	70	3	80	8	0	3
395	135	20	2	190	19	0	1
394	135	15	1	170	17	0	2
397	136	76	1	140	14	0	1
398	136	14	2	130	13	0	2
399	136	66	3	120	12	0	3
400	137	48	1	200	20	0	1
402	137	73	3	20	2	0	3
405	138	20	3	240	24	0	1
403	138	19	1	130	13	0	2
408	139	42	3	240	24	0	1
407	139	76	2	90	9	0	3
410	140	24	2	150	15	0	1
409	140	66	1	70	7	0	3
414	141	35	3	160	16	0	1
412	141	43	1	150	15	0	2
413	141	61	2	120	12	0	3
415	142	30	1	190	19	0	1
417	142	60	3	150	15	0	2
419	143	36	2	140	14	0	1
418	143	80	1	100	10	0	2
420	143	48	3	100	10	0	3
422	144	73	2	70	7	0	2
423	144	80	3	50	5	0	3
425	145	15	2	130	13	0	3
427	146	70	1	240	24	0	1
428	146	30	2	190	19	0	2
429	146	36	3	100	10	0	3
430	147	19	1	110	11	0	1
432	147	61	3	90	9	0	2
434	148	66	2	220	22	0	1
435	148	14	3	200	20	0	2
433	148	49	1	80	8	0	3
438	149	35	3	140	14	0	1
437	149	24	2	70	7	0	3
440	150	76	2	180	18	0	1
439	150	43	1	150	15	0	2
443	151	66	2	130	13	0	1
442	151	55	1	90	9	0	3
445	152	19	1	160	16	0	2
447	152	35	3	100	10	0	3
448	153	60	1	220	22	0	1
449	153	73	2	220	22	0	2
450	153	14	3	50	5	0	3
452	154	70	2	210	21	0	1
453	154	42	3	180	18	0	2
455	155	80	2	180	18	0	1
454	155	15	1	70	7	0	3
457	156	49	1	230	23	0	1
458	156	20	2	110	11	0	2
459	156	43	3	10	1	0	3
462	157	24	3	150	15	0	2
464	158	35	2	80	8	0	2
465	158	80	3	70	7	0	3
468	159	42	3	210	21	0	1
466	159	60	1	200	20	0	2
470	160	61	2	180	18	0	1
469	160	55	1	170	17	0	2
471	160	36	3	140	14	0	3
474	161	73	3	100	10	0	3
477	162	19	3	260	26	0	1
476	162	49	2	210	21	0	2
475	162	15	1	90	9	0	3
479	163	76	2	160	16	0	2
480	163	20	3	110	11	0	3
482	164	50	2	130	13	0	2
485	165	21	2	170	17	0	1
484	165	2	1	100	10	0	2
486	165	31	3	90	9	0	3
487	166	26	1	150	15	0	1
489	166	46	3	150	15	0	2
490	167	77	1	140	14	0	1
491	167	32	2	100	10	0	2
492	167	74	3	60	6	0	3
494	168	45	2	190	19	0	1
495	168	44	3	60	6	0	3
497	169	37	2	170	17	0	1
496	169	71	1	70	7	0	3
499	170	62	1	190	19	0	1
500	170	4	2	180	18	0	2
504	171	25	3	210	21	0	1
502	171	16	1	90	9	0	2
506	172	78	2	220	22	0	1
507	172	68	3	190	19	0	2
505	172	8	1	100	10	0	3
509	173	38	2	180	18	0	1
510	173	25	3	170	17	0	2
512	174	21	2	150	15	0	1
511	174	32	1	140	14	0	2
516	175	8	3	210	21	0	1
515	175	71	2	120	12	0	2
514	175	37	1	40	4	0	3
519	176	74	3	200	20	0	2
520	177	16	1	170	17	0	1
521	177	31	2	120	12	0	3
524	178	68	2	140	14	0	2
525	178	1	3	140	14	0	3
526	179	78	1	120	12	0	2
527	179	77	2	50	5	0	3
531	180	7	3	240	24	0	1
530	180	3	2	220	22	0	2
529	180	38	1	180	18	0	3
532	181	50	1	120	12	0	1
534	181	56	3	120	12	0	2
535	182	46	1	200	20	0	1
536	182	2	2	110	11	0	2
537	182	51	3	80	8	0	3
539	183	37	2	120	12	0	2
542	184	46	2	150	15	0	1
541	184	32	1	0	0	0	3
544	185	7	1	220	22	0	1
546	185	51	3	150	15	0	2
545	185	68	2	90	9	0	3
547	186	77	1	150	15	0	1
549	186	2	3	110	11	0	2
552	187	50	3	220	22	0	1
551	187	71	2	190	19	0	2
550	187	4	1	140	14	0	3
555	188	16	3	250	25	0	1
554	188	45	2	110	11	0	3
556	189	67	1	150	15	0	2
557	189	25	2	100	10	0	3
559	190	26	1	160	16	0	2
561	190	5	3	130	13	0	3
562	191	8	1	130	13	0	2
564	191	1	3	110	11	0	3
565	192	74	1	180	18	0	1
567	192	3	3	160	16	0	2
566	192	56	2	140	14	0	3
569	193	77	2	200	20	0	1
570	193	71	3	140	14	0	3
572	194	32	2	210	21	0	1
571	194	74	1	50	5	0	3
574	195	78	1	300	30	0	1
575	195	38	2	160	16	0	2
576	195	26	3	110	11	0	3
579	196	4	3	70	7	0	3
580	197	6	1	240	24	0	1
582	197	62	3	140	14	0	2
581	197	68	2	100	10	0	3
584	198	3	2	110	11	0	2
585	198	67	3	70	7	0	3
586	199	50	1	240	24	0	1
587	199	37	2	70	7	0	3
590	200	1	2	170	17	0	1
591	200	45	3	150	15	0	2
589	200	31	1	140	14	0	3
592	201	16	1	110	11	0	1
594	201	25	3	90	9	0	2
597	202	46	3	260	26	0	1
596	202	7	2	100	10	0	3
599	203	1	2	170	17	0	2
600	203	3	3	150	15	0	3
601	204	31	1	150	15	0	1
602	204	16	2	130	13	0	3
604	205	38	1	130	13	0	1
605	205	74	2	130	13	0	2
606	205	8	3	60	6	0	3
609	206	26	3	250	25	0	1
607	206	50	1	90	9	0	2
612	207	44	3	180	18	0	1
611	207	67	2	150	15	0	2
610	207	5	1	140	14	0	3
614	208	21	2	180	18	0	1
616	209	6	1	150	15	0	2
617	209	62	2	140	14	0	3
619	210	25	1	260	26	0	1
620	210	7	2	230	23	0	2
621	210	78	3	220	22	0	3
624	211	71	3	210	21	0	2
622	211	2	1	70	7	0	3
627	212	78	3	200	20	0	1
626	212	31	2	160	16	0	2
625	212	32	1	130	13	0	3
631	214	37	1	220	22	0	1
633	214	32	3	120	12	0	2
632	214	71	2	100	10	0	3
636	215	25	3	210	21	0	1
639	216	56	3	160	16	0	1
638	216	7	2	120	12	0	2
637	216	8	1	100	10	0	3
641	217	44	2	170	17	0	2
642	217	21	3	140	14	0	3
643	218	62	1	240	24	0	1
644	218	5	2	230	23	0	2
648	219	51	3	130	13	0	1
647	219	3	2	120	12	0	2
646	219	6	1	50	5	0	3
649	220	46	1	240	24	0	1
651	220	1	3	70	7	0	3
652	221	2	1	170	17	0	1
654	221	77	3	140	14	0	2
657	224	64	3	250	25	0	1
656	224	13	2	130	13	0	3
658	225	18	1	110	11	0	2
659	225	69	2	100	10	0	3
661	226	54	1	170	17	0	1
663	226	12	3	160	16	0	2
662	226	58	2	150	15	0	3
664	227	47	1	160	16	0	1
666	227	40	3	100	10	0	2
669	228	59	3	120	12	0	1
668	228	11	2	90	9	0	2
667	228	41	1	80	8	0	3
672	229	52	3	220	22	0	1
671	229	23	2	160	16	0	2
674	230	75	2	0	0	0	3
677	231	65	2	210	21	0	1
678	231	63	3	110	11	0	2
676	231	79	1	60	6	0	3
679	232	17	1	150	15	0	1
681	232	72	3	150	15	0	2
684	233	27	3	200	20	0	1
682	233	10	1	110	11	0	2
683	233	53	2	30	3	0	3
686	234	72	2	160	16	0	1
687	234	10	3	90	9	0	2
688	235	59	1	150	15	0	2
693	236	29	3	190	19	0	1
692	236	13	2	150	15	0	2
694	237	41	1	200	20	0	1
696	237	18	3	130	13	0	3
698	238	34	2	140	14	0	1
697	238	54	1	90	9	0	2
699	238	47	3	60	6	0	3
701	239	58	2	50	5	0	2
702	239	17	3	20	2	0	3
704	240	75	2	100	10	0	2
703	240	39	1	30	3	0	3
707	241	64	2	220	22	0	1
708	241	63	3	180	18	0	2
706	241	57	1	90	9	0	3
709	242	23	1	140	14	0	1
711	242	69	3	50	5	0	3
712	243	12	1	120	12	0	2
714	243	53	3	90	9	0	3
717	244	52	3	260	26	0	1
716	244	9	2	80	8	0	3
718	245	64	1	250	25	0	1
719	245	79	2	170	17	0	2
721	246	63	1	180	18	0	1
722	246	39	2	130	13	0	2
723	246	72	3	130	13	0	3
726	247	29	3	160	16	0	2
724	247	23	1	90	9	0	3
728	248	54	2	200	20	0	1
729	248	58	3	170	17	0	2
727	248	75	1	130	13	0	3
731	249	40	2	110	11	0	2
734	250	11	2	140	14	0	1
733	250	59	1	50	5	0	2
736	251	13	1	210	21	0	1
737	251	28	2	160	16	0	2
738	251	34	3	160	16	0	3
739	252	18	1	190	19	0	1
741	252	27	3	90	9	0	3
742	253	41	1	170	17	0	1
744	253	33	3	150	15	0	2
743	253	9	2	80	8	0	3
746	254	53	2	190	19	0	1
747	254	69	3	140	14	0	2
748	255	65	1	170	17	0	1
751	256	79	1	180	18	0	1
753	256	13	3	150	15	0	2
752	256	75	2	50	5	0	3
754	257	39	1	120	12	0	1
756	257	9	3	70	7	0	3
759	258	18	3	190	19	0	1
757	258	34	1	170	17	0	2
758	258	33	2	60	6	0	3
761	259	63	2	200	20	0	1
762	259	17	3	150	15	0	3
764	260	11	2	220	22	0	1
763	260	64	1	100	10	0	3
766	261	47	1	160	16	0	1
767	261	12	2	110	11	0	2
769	262	58	1	150	15	0	1
771	262	57	3	110	11	0	3
772	263	69	1	120	12	0	1
773	263	22	2	110	11	0	2
774	263	23	3	100	10	0	3
777	264	29	3	90	9	0	1
776	264	40	2	30	3	0	3
778	265	59	1	140	14	0	1
779	265	54	2	100	10	0	3
781	266	63	1	150	15	0	1
783	266	34	3	150	15	0	2
782	266	29	2	110	11	0	3
784	267	39	1	130	13	0	3
788	268	57	2	200	20	0	1
790	269	40	1	110	11	0	2
791	269	13	2	90	9	0	3
794	270	52	2	270	27	0	1
795	270	28	3	220	22	0	2
793	270	17	1	190	19	0	3
798	271	59	3	230	23	0	1
796	271	69	1	160	16	0	3
799	272	33	1	200	20	0	1
800	272	23	2	160	16	0	2
801	272	9	3	20	2	0	3
804	273	65	3	140	14	0	2
803	273	22	2	100	10	0	3
806	274	11	2	190	19	0	1
805	274	64	1	110	11	0	3
810	275	29	3	100	10	0	2
809	275	47	2	40	4	0	3
811	276	33	1	120	12	0	1
813	276	64	3	100	10	0	3
816	277	59	3	170	17	0	1
814	277	79	1	160	16	0	2
815	277	34	2	140	14	0	3
818	278	10	2	150	15	0	1
819	278	12	3	150	15	0	2
820	279	13	1	110	11	0	2
821	279	52	2	90	9	0	3
825	280	57	3	220	22	0	1
824	280	27	2	90	9	0	2
823	280	72	1	70	7	0	3
828	281	23	3	80	8	0	3
830	282	41	2	140	14	0	1
829	282	58	1	120	12	0	2
831	282	65	3	90	9	0	3
833	283	53	2	150	15	0	1
834	283	47	3	120	12	0	3
835	284	22	1	130	13	0	2
836	284	17	2	120	12	0	3
838	285	9	1	90	9	0	1
839	285	75	2	90	9	0	2
840	285	40	3	60	6	0	3
843	287	60	3	170	17	0	1
841	287	76	1	140	14	0	2
846	288	42	3	200	20	0	1
845	288	49	2	130	13	0	3
848	289	19	2	210	21	0	1
849	289	15	3	180	18	0	3
850	290	30	1	110	11	0	2
851	290	20	2	110	11	0	3
853	291	55	1	130	13	0	1
855	291	43	3	110	11	0	2
854	291	80	2	80	8	0	3
856	292	66	1	230	23	0	1
858	292	73	3	150	15	0	2
859	293	70	1	210	21	0	1
860	293	14	2	70	7	0	3
863	294	43	2	270	27	0	1
864	294	60	3	10	1	0	3
865	295	55	1	150	15	0	2
869	296	66	2	210	21	0	1
868	296	15	1	150	15	0	2
870	296	36	3	100	10	0	3
871	297	35	1	190	19	0	1
873	297	70	3	150	15	0	3
875	298	42	2	230	23	0	1
876	298	49	3	160	16	0	2
874	298	19	1	90	9	0	3
879	299	20	3	160	16	0	1
878	299	14	2	10	1	0	3
880	300	24	1	170	17	0	1
881	300	36	2	80	8	0	3
885	301	66	3	170	17	0	1
884	301	14	2	160	16	0	3
888	302	70	3	130	13	0	2
886	302	61	1	90	9	0	3
889	303	76	1	230	23	0	1
890	303	60	2	220	22	0	2
891	303	42	3	210	21	0	3
894	304	15	3	180	18	0	1
893	304	80	2	150	15	0	3
895	305	49	1	160	16	0	2
896	305	19	2	140	14	0	3
900	306	48	3	120	12	0	1
898	306	20	1	100	10	0	2
899	306	24	2	70	7	0	3
901	307	43	1	210	21	0	1
904	308	15	1	200	20	0	1
905	308	73	2	190	19	0	2
906	308	76	3	170	17	0	3
908	309	19	2	250	25	0	1
909	309	60	3	230	23	0	2
911	310	66	2	170	17	0	1
910	310	49	1	100	10	0	2
915	311	80	3	190	19	0	1
914	311	61	2	120	12	0	2
913	311	24	1	80	8	0	3
918	312	14	3	160	16	0	2
916	312	42	1	110	11	0	3
920	313	70	2	100	10	0	1
921	313	35	3	100	10	0	2
924	314	70	3	130	13	0	1
923	314	66	2	60	6	0	3
925	315	36	1	180	18	0	1
926	315	43	2	150	15	0	2
928	316	49	1	160	16	0	1
930	316	60	3	140	14	0	2
929	316	14	2	70	7	0	3
931	317	20	1	230	23	0	1
933	317	80	3	220	22	0	2
936	318	73	3	210	21	0	1
935	318	55	2	160	16	0	2
934	318	19	1	120	12	0	3
939	319	42	3	160	16	0	2
938	319	30	2	70	7	0	3
941	320	35	2	140	14	0	3
945	321	20	3	110	11	0	1
947	322	76	2	150	15	0	1
946	322	24	1	140	14	0	2
948	322	42	3	120	12	0	3
951	323	55	3	250	25	0	1
950	323	14	2	110	11	0	3
953	324	30	2	190	19	0	2
952	324	49	1	150	15	0	3
955	325	19	1	240	24	0	1
956	325	80	2	160	16	0	2
957	325	73	3	130	13	0	3
960	326	61	3	180	18	0	1
958	326	66	1	150	15	0	3
962	327	31	2	140	14	0	2
963	327	32	3	140	14	0	3
965	328	25	2	140	14	0	1
966	328	68	3	140	14	0	2
967	329	5	1	220	22	0	2
968	329	38	2	190	19	0	3
972	330	50	3	180	18	0	1
971	330	46	2	170	17	0	2
970	330	26	1	100	10	0	3
973	331	71	1	210	21	0	1
975	331	51	3	90	9	0	3
978	332	45	3	140	14	0	1
976	332	78	1	120	12	0	2
977	332	44	2	120	12	0	3
981	333	16	3	160	16	0	3
982	334	21	1	230	23	0	1
983	334	77	2	170	17	0	2
985	335	74	1	210	21	0	1
987	335	2	3	130	13	0	2
986	335	7	2	80	8	0	3
990	336	56	3	230	23	0	1
988	336	8	1	110	11	0	3
991	337	4	1	170	17	0	1
993	337	2	3	150	15	0	2
992	337	32	2	90	9	0	3
995	338	51	2	200	20	0	1
996	338	71	3	60	6	0	3
997	339	77	1	320	32	0	1
1000	340	62	1	90	9	0	1
1001	340	8	2	90	9	0	2
1002	340	7	3	80	8	0	3
1003	341	78	1	210	21	0	1
1005	341	1	3	120	12	0	2
1008	342	38	3	240	24	0	1
1006	342	68	1	140	14	0	2
1007	342	3	2	100	10	0	3
1010	343	44	2	190	19	0	2
1011	343	16	3	180	18	0	3
1012	344	21	1	180	18	0	1
1013	344	31	2	80	8	0	3
1015	345	46	1	190	19	0	1
1017	345	67	3	150	15	0	2
1020	346	4	3	180	18	0	1
1018	346	45	1	120	12	0	2
1021	347	7	1	190	19	0	1
1022	347	56	2	60	6	0	2
1023	347	37	3	60	6	0	3
1025	348	32	2	170	17	0	2
1026	348	45	3	120	12	0	3
1028	349	3	2	190	19	0	2
1027	349	31	1	150	15	0	3
1030	350	77	1	230	23	0	1
1032	350	5	3	130	13	0	2
1031	350	67	2	60	6	0	3
1035	351	8	3	90	9	0	2
1038	352	62	3	200	20	0	1
1036	352	44	1	70	7	0	3
1040	353	2	2	150	15	0	1
1041	353	21	3	130	13	0	3
1042	354	51	1	180	18	0	1
1043	354	46	2	150	15	0	3
1046	355	16	2	250	25	0	1
1047	355	74	3	160	16	0	2
1045	355	1	1	90	9	0	3
1048	356	67	1	160	16	0	1
1050	356	8	3	70	7	0	2
1051	357	7	1	170	17	0	1
1052	357	45	2	150	15	0	2
1053	357	6	3	110	11	0	3
1055	358	25	2	320	32	0	1
1057	359	71	1	190	19	0	1
1058	359	77	2	150	15	0	2
1061	360	16	2	310	31	0	1
1060	360	26	1	180	18	0	2
1062	360	51	3	60	6	0	3
1063	361	1	1	180	18	0	1
1065	361	74	3	110	11	0	3
1066	362	3	1	300	30	0	1
1068	362	50	3	170	17	0	2
1067	362	21	2	110	11	0	3
1070	363	56	2	240	24	0	1
1071	363	62	3	160	16	0	2
1073	364	44	2	130	13	0	1
1072	364	2	1	60	6	0	3
1075	365	38	1	90	9	0	2
1076	365	31	2	40	4	0	3
1078	366	45	1	150	15	0	1
1080	366	74	3	140	14	0	2
1083	367	71	3	210	21	0	1
1082	367	7	2	130	13	0	2
1081	367	77	1	120	12	0	3
1086	368	25	3	210	21	0	1
1085	368	67	2	200	20	0	2
1087	369	78	1	210	21	0	1
1088	369	21	2	200	20	0	2
1092	370	1	3	140	14	0	1
1090	370	46	1	100	10	0	2
1091	370	38	2	40	4	0	3
1093	371	51	1	20	2	0	3
1098	372	44	3	300	30	0	1
1097	372	31	2	180	18	0	2
1096	372	8	1	140	14	0	3
1103	374	4	2	180	18	0	1
1102	374	16	1	170	17	0	2
1104	374	5	3	70	7	0	3
1105	375	6	1	220	22	0	1
1107	375	26	3	190	19	0	2
1110	376	32	3	220	22	0	1
1109	376	67	2	100	10	0	2
1108	376	71	1	70	7	0	3
1112	377	45	2	160	16	0	1
1113	377	1	3	160	16	0	2
1114	378	46	1	110	11	0	3
1117	379	62	1	210	21	0	1
1118	379	2	2	150	15	0	2
1119	379	78	3	150	15	0	3
1122	380	6	3	250	25	0	1
1120	380	16	1	150	15	0	2
1124	381	7	2	170	17	0	1
1123	381	3	1	160	16	0	2
1125	381	5	3	50	5	0	3
1127	382	50	2	150	15	0	1
1128	382	68	3	130	13	0	2
1130	383	56	2	300	30	0	1
1129	383	8	1	190	19	0	2
1133	384	25	2	230	23	0	1
1132	384	4	1	130	13	0	3
1135	387	59	1	100	10	0	2
1137	387	17	3	10	1	0	3
1140	388	28	3	290	29	0	1
1138	388	47	1	60	6	0	2
1139	388	27	2	40	4	0	3
1142	389	57	2	110	11	0	1
1143	389	72	3	100	10	0	3
1145	390	11	2	160	16	0	1
1144	390	41	1	120	12	0	2
1148	391	63	2	130	13	0	1
1149	391	18	3	120	12	0	2
1147	391	69	1	100	10	0	3
1150	392	39	1	170	17	0	2
1154	393	23	2	180	18	0	1
1153	393	64	1	100	10	0	2
1155	393	33	3	100	10	0	3
1158	394	34	3	130	13	0	1
1157	394	58	2	70	7	0	3
1159	395	54	1	120	12	0	1
1160	395	9	2	90	9	0	2
1163	396	12	2	200	20	0	1
1164	396	53	3	190	19	0	2
1162	396	52	1	100	10	0	3
1167	397	52	3	160	16	0	2
1165	397	40	1	10	1	0	3
1169	398	64	2	190	19	0	1
1168	398	13	1	140	14	0	2
1172	399	65	2	290	29	0	1
1173	399	53	3	120	12	0	2
1174	400	18	1	90	9	0	2
1175	400	34	2	80	8	0	3
1179	401	79	3	200	20	0	1
1177	401	17	1	110	11	0	2
1178	401	75	2	70	7	0	3
1182	402	22	3	140	14	0	1
1180	402	9	1	80	8	0	3
1184	403	12	2	200	20	0	1
1185	403	33	3	90	9	0	2
1183	403	23	1	80	8	0	3
1187	404	57	2	170	17	0	1
1188	404	59	3	150	15	0	2
1190	405	29	2	70	7	0	3
1192	406	41	1	130	13	0	1
1193	406	54	2	90	9	0	2
1194	406	11	3	70	7	0	3
1195	407	28	1	210	21	0	1
1197	407	52	3	130	13	0	2
1198	408	27	1	190	19	0	1
1200	408	12	3	190	19	0	2
1199	408	13	2	160	16	0	3
1203	409	72	3	150	15	0	1
1202	409	22	2	130	13	0	2
1204	410	47	1	70	7	0	3
1209	411	39	3	110	11	0	1
1207	411	53	1	80	8	0	2
1212	412	28	3	190	19	0	1
1210	412	9	1	30	3	0	3
1213	413	59	1	200	20	0	1
1214	413	65	2	120	12	0	2
1215	413	69	3	80	8	0	3
1217	414	64	2	220	22	0	1
1218	414	63	3	120	12	0	2
1219	415	79	1	170	17	0	1
1220	415	40	2	100	10	0	3
1224	416	18	3	190	19	0	1
1222	416	57	1	180	18	0	2
1223	416	11	2	150	15	0	3
1227	417	17	3	110	11	0	2
1225	417	23	1	80	8	0	3
1229	418	47	2	110	11	0	2
1230	418	29	3	90	9	0	3
1232	419	52	2	150	15	0	1
1233	419	18	3	120	12	0	2
1234	420	65	1	260	26	0	1
1235	420	63	2	90	9	0	3
1239	421	64	3	170	17	0	1
1238	421	12	2	160	16	0	2
1237	421	72	1	150	15	0	3
1240	422	41	1	110	11	0	1
1242	422	13	3	60	6	0	3
1243	423	22	1	160	16	0	1
1244	423	11	2	110	11	0	2
1245	423	79	3	90	9	0	3
1248	424	28	3	60	6	0	3
1249	425	17	1	90	9	0	2
1250	425	27	2	90	9	0	3
1254	426	58	3	170	17	0	1
1253	426	23	2	110	11	0	2
1252	426	9	1	100	10	0	3
1255	427	53	1	60	6	0	3
1259	428	64	2	170	17	0	1
1260	428	10	3	170	17	0	2
1261	429	47	1	220	22	0	1
1262	429	33	2	150	15	0	3
1264	430	12	1	140	14	0	1
1266	430	75	3	110	11	0	2
1265	430	40	2	30	3	0	3
1269	431	22	3	90	9	0	3
1271	432	52	2	150	15	0	1
1270	432	57	1	100	10	0	2
1272	432	53	3	100	10	0	3
1275	433	17	3	110	11	0	1
1274	433	69	2	80	8	0	2
1276	434	18	1	160	16	0	1
1277	434	58	2	20	2	0	3
1279	435	54	1	170	17	0	1
1280	435	63	2	100	10	0	2
1281	435	11	3	60	6	0	3
1282	436	41	1	90	9	0	2
1284	436	39	3	90	9	0	3
1287	437	79	3	140	14	0	1
1285	437	9	1	70	7	0	3
1289	438	27	2	110	11	0	1
1290	438	53	3	80	8	0	2
1292	439	59	2	110	11	0	1
1291	439	69	1	40	4	0	3
1294	440	52	1	200	20	0	1
1296	440	79	3	80	8	0	2
1295	440	47	2	60	6	0	3
1299	441	18	3	280	28	0	1
1297	441	41	1	80	8	0	3
1300	442	10	1	120	12	0	1
1301	442	65	2	110	11	0	2
1302	442	64	3	70	7	0	3
1305	443	34	3	90	9	0	2
1307	444	22	2	110	11	0	2
1306	444	9	1	70	7	0	3
1310	445	75	2	100	10	0	1
1309	445	39	1	80	8	0	2
1311	445	63	3	50	5	0	3
1314	446	33	3	170	17	0	2
1312	446	54	1	160	16	0	3
1316	447	11	2	240	24	0	1
1315	447	17	1	180	18	0	2
1317	447	27	3	50	5	0	3
1319	448	72	2	200	20	0	1
1320	448	12	3	80	8	0	3
1321	450	20	1	170	17	0	1
1322	450	19	2	100	10	0	3
1324	451	14	1	200	20	0	2
1326	451	43	3	120	12	0	3
1327	452	36	1	130	13	0	2
1329	452	55	3	120	12	0	3
1330	453	48	1	190	19	0	1
1331	453	35	2	70	7	0	2
1332	453	73	3	70	7	0	3
1334	454	80	2	100	10	0	1
1335	454	42	3	90	9	0	2
1337	455	49	2	160	16	0	1
1336	455	60	1	100	10	0	3
1340	456	76	2	220	22	0	1
1341	456	36	3	160	16	0	2
1339	456	15	1	150	15	0	3
1342	457	60	1	120	12	0	3
1346	458	24	2	160	16	0	1
1347	458	66	3	130	13	0	2
1345	458	42	1	90	9	0	3
1349	459	70	2	180	18	0	1
1350	459	20	3	170	17	0	2
1352	460	55	2	240	24	0	1
1351	460	76	1	190	19	0	2
1356	461	19	3	210	21	0	1
1355	461	49	2	130	13	0	2
1354	461	48	1	110	11	0	3
1359	462	73	3	230	23	0	1
1357	462	43	1	190	19	0	2
1362	463	42	3	160	16	0	1
1360	463	30	1	20	2	0	3
1364	464	14	2	160	16	0	2
1365	464	24	3	160	16	0	3
1366	465	55	1	260	26	0	1
1367	465	49	2	70	7	0	3
1369	466	80	1	140	14	0	1
1370	466	66	2	130	13	0	2
1371	466	20	3	130	13	0	3
1372	467	36	1	230	23	0	1
1374	467	35	3	100	10	0	3
1376	468	15	2	160	16	0	2
1375	468	48	1	100	10	0	3
1380	469	43	3	230	23	0	1
1379	469	73	2	120	12	0	2
1382	470	14	2	170	17	0	2
1385	471	24	2	180	18	0	1
1384	471	30	1	170	17	0	2
1386	471	55	3	140	14	0	3
1387	472	43	1	130	13	0	2
1389	472	49	3	50	5	0	3
1392	473	70	3	220	22	0	1
1390	473	60	1	150	15	0	2
1391	473	48	2	80	8	0	3
1394	474	35	2	240	24	0	1
1395	474	15	3	220	22	0	2
1396	475	80	1	190	19	0	1
1397	475	42	2	180	18	0	2
1401	476	60	3	160	16	0	1
1400	476	66	2	110	11	0	3
1402	477	49	1	210	21	0	1
1404	477	20	3	80	8	0	3
1407	478	55	3	180	18	0	1
1406	478	70	2	120	12	0	2
1405	478	30	1	110	11	0	3
1409	479	48	2	200	20	0	1
1410	479	42	3	60	6	0	3
1412	480	15	2	140	14	0	2
1411	480	76	1	100	10	0	3
1416	481	61	3	140	14	0	1
1419	482	66	3	260	26	0	1
1417	482	19	1	60	6	0	2
1418	482	14	2	10	1	0	3
1422	483	55	3	100	10	0	3
1423	484	19	1	200	20	0	1
1424	484	49	2	80	8	0	2
1428	485	35	3	150	15	0	1
1427	485	36	2	100	10	0	2
1426	485	70	1	70	7	0	3
1431	486	61	3	150	15	0	1
1429	486	15	1	130	13	0	2
1434	487	20	3	190	19	0	1
1432	487	76	1	110	11	0	2
1433	487	60	2	90	9	0	3
1436	488	73	2	160	16	0	1
1437	488	42	3	140	14	0	2
1439	489	48	2	200	20	0	2
1443	490	51	3	120	12	0	1
1442	490	37	2	110	11	0	2
1441	490	46	1	80	8	0	3
1446	491	74	3	140	14	0	1
1444	491	68	1	80	8	0	3
1448	492	50	2	200	20	0	1
1447	492	1	1	110	11	0	2
1449	492	38	3	60	6	0	3
1451	493	45	2	110	11	0	2
1452	493	56	3	90	9	0	3
1453	494	67	1	170	17	0	1
1454	494	77	2	160	16	0	2
1458	495	78	3	150	15	0	1
1456	495	2	1	100	10	0	2
1459	496	3	1	110	11	0	2
1461	496	21	3	70	7	0	3
1464	497	16	3	270	27	0	1
1463	497	8	2	120	12	0	2
1462	497	32	1	10	1	0	3
1466	498	6	2	120	12	0	2
1467	498	5	3	110	11	0	3
1468	499	44	1	150	15	0	2
1469	499	26	2	30	3	0	3
1471	500	2	1	160	16	0	1
1472	500	8	2	130	13	0	2
1473	500	71	3	130	13	0	3
1476	501	1	3	210	21	0	2
1474	501	77	1	100	10	0	3
1478	502	32	2	130	13	0	2
1477	502	51	1	110	11	0	3
1482	503	7	3	150	15	0	2
1481	503	31	2	110	11	0	3
1484	504	25	2	220	22	0	1
1483	504	46	1	160	16	0	2
1487	505	45	2	140	14	0	1
1488	505	37	3	100	10	0	2
1486	505	44	1	10	1	0	3
1489	506	78	1	180	18	0	1
1491	506	3	3	140	14	0	3
1494	507	68	3	230	23	0	1
1492	507	21	1	180	18	0	2
1493	507	62	2	150	15	0	3
1496	508	50	2	170	17	0	2
1498	509	26	1	140	14	0	1
1499	509	31	2	140	14	0	2
1502	510	25	2	210	21	0	1
1501	510	67	1	150	15	0	2
1503	510	44	3	150	15	0	3
1504	511	26	1	150	15	0	2
1506	511	7	3	150	15	0	3
1507	512	78	1	190	19	0	1
1508	512	46	2	100	10	0	2
1509	512	32	3	40	4	0	3
1511	513	1	2	210	21	0	1
1512	513	68	3	180	18	0	2
1514	514	4	2	180	18	0	1
1516	515	8	1	130	13	0	1
1518	515	56	3	100	10	0	2
1517	515	51	2	80	8	0	3
1521	516	5	3	220	22	0	1
1519	516	74	1	160	16	0	2
1522	517	71	1	110	11	0	1
1523	517	45	2	110	11	0	2
1524	517	21	3	90	9	0	3
1527	518	16	3	250	25	0	1
1526	518	38	2	140	14	0	2
1529	519	45	2	250	25	0	1
1528	519	6	1	170	17	0	2
1531	520	1	1	130	13	0	1
1532	520	46	2	130	13	0	2
1536	521	56	3	180	18	0	1
1534	521	51	1	170	17	0	2
1539	522	21	3	230	23	0	1
1538	522	2	2	210	21	0	2
1537	522	62	1	170	17	0	3
1542	523	26	3	220	22	0	1
1541	523	67	2	140	14	0	3
1544	524	16	2	170	17	0	1
1543	524	50	1	150	15	0	3
1546	525	38	1	260	26	0	1
1547	525	37	2	60	6	0	2
1548	525	8	3	20	2	0	3
1551	526	4	3	110	11	0	3
1553	527	32	2	160	16	0	1
1552	527	71	1	130	13	0	3
1557	528	45	3	160	16	0	2
1556	528	3	2	110	11	0	3
1559	529	2	2	130	13	0	2
1558	529	7	1	70	7	0	3
1562	530	78	2	170	17	0	1
1561	530	77	1	150	15	0	2
1563	530	4	3	130	13	0	3
1564	531	8	1	140	14	0	2
1566	531	1	3	130	13	0	3
1568	532	6	2	130	13	0	1
1569	532	31	3	90	9	0	2
1567	532	56	1	80	8	0	3
1574	534	38	2	210	21	0	1
1573	534	44	1	130	13	0	3
1578	535	21	3	220	22	0	1
1576	535	3	1	140	14	0	2
1579	536	37	1	260	26	0	1
1581	536	25	3	240	24	0	2
1580	536	68	2	230	23	0	3
1583	537	46	2	230	23	0	2
1584	537	51	3	180	18	0	3
1586	538	45	2	130	13	0	1
1585	538	32	1	110	11	0	2
1589	539	1	2	150	15	0	1
1590	539	8	3	130	13	0	2
1588	539	5	1	90	9	0	3
1593	540	51	3	170	17	0	1
1595	541	3	2	210	21	0	1
1594	541	46	1	90	9	0	2
1596	541	31	3	70	7	0	3
1598	542	78	2	140	14	0	1
1599	542	7	3	130	13	0	2
1600	543	16	1	280	28	0	1
1601	543	26	2	60	6	0	3
1603	544	77	1	220	22	0	1
1605	544	67	3	110	11	0	2
1604	544	68	2	50	5	0	3
1606	545	44	1	190	19	0	1
1608	545	21	3	140	14	0	2
1611	546	2	3	240	24	0	1
1609	546	6	1	150	15	0	2
1613	547	71	2	130	13	0	1
1614	547	32	3	70	7	0	3
1616	550	18	2	160	16	0	1
1615	550	10	1	150	15	0	2
1620	551	54	3	160	16	0	1
1619	551	12	2	130	13	0	2
1618	551	39	1	100	10	0	3
1621	552	69	1	160	16	0	2
1623	552	75	3	40	4	0	3
1625	553	41	2	120	12	0	1
1624	553	65	1	100	10	0	2
1626	553	72	3	100	10	0	3
1628	554	64	2	270	27	0	1
1629	554	17	3	130	13	0	2
1630	555	22	1	70	7	0	2
1634	556	57	2	210	21	0	1
1633	556	23	1	170	17	0	2
1635	556	40	3	100	10	0	3
1636	557	13	1	190	19	0	1
1638	557	28	3	120	12	0	2
1640	558	11	2	110	11	0	1
1639	558	9	1	60	6	0	2
1641	558	27	3	50	5	0	3
1644	559	63	3	140	14	0	1
1643	559	52	2	80	8	0	3
1646	560	23	2	170	17	0	1
1645	560	58	1	100	10	0	2
1649	561	79	2	170	17	0	1
1648	561	41	1	140	14	0	3
1653	562	22	3	150	15	0	2
1651	562	53	1	140	14	0	3
1655	563	47	2	150	15	0	1
1654	563	57	1	40	4	0	2
1656	563	33	3	0	0	0	3
1659	564	28	3	200	20	0	1
1658	564	39	2	110	11	0	3
1660	565	34	1	170	17	0	2
1661	565	52	2	100	10	0	3
1663	566	54	1	150	15	0	1
1664	566	17	2	140	14	0	2
1665	566	75	3	60	6	0	3
1668	567	58	3	180	18	0	1
1670	568	27	2	130	13	0	1
1671	568	65	3	110	11	0	2
1669	568	72	1	70	7	0	3
1674	569	63	3	160	16	0	1
1673	569	18	2	90	9	0	2
1676	570	13	2	200	20	0	1
1675	570	40	1	40	4	0	3
1678	571	28	1	160	16	0	1
1679	571	29	2	120	12	0	2
1680	571	27	3	80	8	0	3
1681	572	53	1	130	13	0	1
1683	572	75	3	60	6	0	3
1684	573	13	1	140	14	0	1
1686	573	63	3	130	13	0	2
1689	574	54	3	160	16	0	2
1688	574	40	2	60	6	0	3
1691	575	59	2	140	14	0	2
1690	575	69	1	20	2	0	3
1694	576	11	2	150	15	0	1
1693	576	34	1	110	11	0	2
1695	576	47	3	20	2	0	3
1696	577	9	1	130	13	0	1
1698	577	65	3	100	10	0	2
1701	578	18	3	130	13	0	1
1699	578	12	1	110	11	0	2
1700	578	41	2	50	5	0	3
1703	579	17	2	190	19	0	1
1704	579	57	3	190	19	0	2
1705	580	58	1	130	13	0	3
1708	581	57	1	170	17	0	1
1710	581	41	3	100	10	0	2
1709	581	54	2	70	7	0	3
1713	582	59	3	70	7	0	2
1711	582	69	1	30	3	0	3
1716	583	65	3	130	13	0	1
1714	583	23	1	120	12	0	2
1715	583	53	2	120	12	0	3
1719	584	28	3	140	14	0	1
1718	584	52	2	100	10	0	3
1720	585	64	1	170	17	0	1
1881	639	14	3	\N	\N	0	\N
2037	691	50	3	\N	\N	0	\N
1724	586	13	2	160	16	0	1
1725	586	72	3	90	9	0	2
1723	586	22	1	10	1	0	3
1726	587	79	1	150	15	0	1
1730	588	18	2	200	20	0	1
1731	588	34	3	100	10	0	3
1732	589	12	1	130	13	0	2
1735	590	39	1	180	18	0	1
1737	590	29	3	170	17	0	2
1736	590	9	2	90	9	0	3
1740	591	52	3	190	19	0	1
1738	591	33	1	120	12	0	2
1743	592	59	3	200	20	0	1
1742	592	22	2	140	14	0	2
1741	592	72	1	70	7	0	3
1745	593	39	2	100	10	0	2
1746	593	53	3	80	8	0	3
1747	594	34	1	180	18	0	1
1748	594	10	2	30	3	0	3
1752	595	13	3	160	16	0	1
1750	595	41	1	40	4	0	3
1755	596	23	3	140	14	0	2
1753	596	57	1	110	11	0	3
1756	597	79	1	140	14	0	1
1757	597	12	2	120	12	0	2
1758	597	58	3	60	6	0	3
1760	598	28	2	110	11	0	2
1761	598	11	3	60	6	0	3
1763	599	69	2	170	17	0	1
1762	599	63	1	110	11	0	2
1765	600	65	1	270	27	0	1
1766	600	33	2	130	13	0	2
1767	600	27	3	120	12	0	3
1768	601	29	1	210	21	0	1
1773	602	57	3	140	14	0	1
1771	602	18	1	100	10	0	2
1772	602	41	2	70	7	0	3
1775	603	13	2	110	11	0	1
1776	603	63	3	90	9	0	3
1778	604	58	2	130	13	0	1
1777	604	54	1	100	10	0	2
1780	605	59	1	150	15	0	1
1781	605	27	2	90	9	0	2
1782	605	75	3	20	2	0	3
1783	606	11	1	190	19	0	1
1785	606	72	3	180	18	0	2
1788	607	64	3	160	16	0	1
1787	607	9	2	110	11	0	2
1791	608	34	3	120	12	0	2
1790	608	28	2	110	11	0	3
1792	609	53	1	120	12	0	2
1793	609	40	2	80	8	0	3
1796	610	23	2	130	13	0	1
1797	610	10	3	110	11	0	2
1795	610	69	1	70	7	0	3
1800	611	52	3	150	15	0	1
1798	611	33	1	140	14	0	2
1802	613	19	2	210	21	0	1
1801	613	76	1	190	19	0	2
1803	613	80	3	110	11	0	3
1806	614	73	3	120	12	0	2
1805	614	49	2	90	9	0	3
1808	615	70	2	40	4	0	3
1812	616	55	3	170	17	0	1
1811	616	15	2	110	11	0	2
1810	616	48	1	90	9	0	3
1813	617	66	1	160	16	0	2
1815	617	24	3	110	11	0	3
1818	618	14	3	150	15	0	1
1816	618	61	1	90	9	0	2
1817	618	36	2	40	4	0	3
1820	619	20	2	180	18	0	1
1821	619	14	3	110	11	0	3
1822	620	24	1	200	20	0	2
1823	620	48	2	160	16	0	3
1825	621	15	1	250	25	0	1
1826	621	73	2	130	13	0	3
1830	622	36	3	140	14	0	2
1828	622	30	1	120	12	0	3
1833	623	60	3	180	18	0	1
1831	623	49	1	110	11	0	2
1832	623	42	2	110	11	0	3
1835	624	43	2	220	22	0	1
1836	624	61	3	50	5	0	3
1838	625	76	2	140	14	0	1
1837	625	55	1	80	8	0	3
1840	626	20	1	130	13	0	1
1841	626	76	2	100	10	0	2
1842	626	15	3	70	7	0	3
1843	627	42	1	250	25	0	1
1846	628	35	1	140	14	0	1
1848	628	36	3	130	13	0	2
1847	628	80	2	120	12	0	3
1851	629	55	3	290	29	0	1
1850	629	19	2	180	18	0	2
1853	630	14	2	220	22	0	1
1852	630	24	1	150	15	0	3
1856	631	60	2	150	15	0	1
1857	631	66	3	130	13	0	2
1855	631	20	1	120	12	0	3
1858	632	43	1	190	19	0	1
1860	632	48	3	160	16	0	2
1862	633	60	2	240	24	0	1
1861	633	73	1	130	13	0	2
1866	634	76	3	160	16	0	1
1865	634	24	2	100	10	0	3
1868	635	42	2	180	18	0	2
1867	635	61	1	120	12	0	3
1872	636	49	3	200	20	0	1
1870	636	36	1	160	16	0	2
1871	636	15	2	140	14	0	3
1873	637	55	1	200	20	0	1
1875	637	66	3	140	14	0	3
1877	638	19	2	210	21	0	1
1876	638	30	1	150	15	0	2
1878	638	43	3	130	13	0	3
1880	639	80	2	50	5	0	3
1882	640	61	1	130	13	0	1
1883	640	30	2	70	7	0	3
1887	641	55	3	70	7	0	3
1890	642	76	3	130	13	0	1
1888	642	49	1	80	8	0	2
1889	642	24	2	70	7	0	3
1892	643	66	2	90	9	0	1
1894	644	20	1	190	19	0	1
1895	644	43	2	180	18	0	2
1897	645	48	1	110	11	0	2
1899	645	36	3	10	1	0	3
1902	646	66	3	220	22	0	1
1900	646	35	1	150	15	0	3
1903	647	55	1	170	17	0	1
1904	647	49	2	140	14	0	2
1905	647	14	3	130	13	0	3
1908	648	36	3	140	14	0	1
1907	648	43	2	110	11	0	3
1909	649	80	1	210	21	0	1
1910	649	20	2	90	9	0	3
1914	650	61	3	220	22	0	1
1912	650	30	1	160	16	0	2
1913	650	60	2	90	9	0	3
1917	651	42	3	140	14	0	3
1918	652	15	1	200	20	0	1
1919	652	76	2	190	19	0	2
1920	652	24	3	150	15	0	3
1923	653	16	3	270	27	0	1
1922	653	71	2	140	14	0	3
1925	654	68	2	210	21	0	1
1924	654	2	1	150	15	0	2
1928	655	78	2	170	17	0	1
1927	655	6	1	120	12	0	2
1929	655	26	3	100	10	0	3
1932	656	77	3	210	21	0	1
1930	656	38	1	140	14	0	3
1935	657	45	3	140	14	0	1
1934	657	31	2	80	8	0	3
1938	658	21	3	250	25	0	1
1937	658	1	2	110	11	0	3
1939	659	4	1	190	19	0	1
1940	659	56	2	180	18	0	2
1944	660	50	3	160	16	0	1
1942	660	74	1	90	9	0	2
1943	660	5	2	90	9	0	3
1947	661	32	3	210	21	0	1
1945	661	7	1	190	19	0	2
1949	662	51	2	230	23	0	1
1950	662	62	3	120	12	0	2
1948	662	44	1	80	8	0	3
1953	663	78	3	210	21	0	2
1954	664	51	1	140	14	0	1
1955	664	71	2	80	8	0	3
1957	665	6	1	150	15	0	1
1959	665	77	3	150	15	0	2
1958	665	26	2	100	10	0	3
1960	666	1	1	240	24	0	1
1962	666	45	3	70	7	0	3
1965	667	37	3	170	17	0	1
1964	667	25	2	160	16	0	2
1963	667	4	1	60	6	0	3
1968	668	46	3	110	11	0	1
1967	668	21	2	70	7	0	2
1970	669	56	2	270	27	0	1
1969	669	44	1	130	13	0	3
1974	670	2	3	230	23	0	2
1972	670	68	1	80	8	0	3
1977	671	31	3	140	14	0	2
1975	671	7	1	130	13	0	3
1978	672	5	1	210	21	0	1
1980	672	78	3	140	14	0	2
1979	672	74	2	90	9	0	3
1982	673	8	2	100	10	0	2
1983	673	26	3	-10	-1	0	3
1984	674	51	1	130	13	0	1
1985	674	44	2	120	12	0	2
1988	675	56	2	200	20	0	1
1987	675	16	1	180	18	0	2
1989	675	4	3	80	8	0	3
1992	676	77	3	150	15	0	2
1993	677	3	1	200	20	0	1
1994	677	71	2	120	12	0	2
1995	677	46	3	110	11	0	3
1998	678	62	3	180	18	0	1
1997	678	6	2	140	14	0	2
2000	679	5	2	150	15	0	2
1999	679	38	1	120	12	0	3
2002	680	25	1	260	26	0	1
2004	680	1	3	170	17	0	2
2003	680	31	2	90	9	0	3
2007	681	2	3	220	22	0	1
2005	681	68	1	120	12	0	3
2008	682	46	1	170	17	0	1
2009	682	74	2	110	11	0	3
2013	683	62	3	220	22	0	1
2012	683	8	2	120	12	0	2
2015	684	25	2	190	19	0	1
2014	684	3	1	110	11	0	3
2018	685	16	2	260	26	0	1
2019	685	26	3	200	20	0	2
2017	685	4	1	50	5	0	3
2022	686	44	3	190	19	0	2
2020	686	45	1	140	14	0	3
2023	687	1	1	150	15	0	1
2024	687	71	2	120	12	0	2
2025	687	51	3	80	8	0	3
2028	688	37	3	170	17	0	1
2030	689	6	2	150	15	0	1
2029	689	7	1	110	11	0	3
2032	690	21	1	130	13	0	1
2033	690	32	2	130	13	0	2
2034	690	5	3	120	12	0	3
2035	691	56	1	140	14	0	2
2038	692	77	1	160	16	0	1
2040	692	26	3	120	12	0	2
2039	692	45	2	10	1	0	3
2041	693	21	1	230	23	0	1
2046	694	74	3	150	15	0	1
2045	694	6	2	140	14	0	2
2044	694	56	1	110	11	0	3
2049	695	2	3	190	19	0	1
2052	696	38	3	170	17	0	1
2051	696	31	2	130	13	0	2
2050	696	4	1	120	12	0	3
2055	697	5	3	170	17	0	1
2054	697	62	2	130	13	0	2
2057	698	8	2	150	15	0	1
2056	698	44	1	110	11	0	3
2059	699	25	1	250	25	0	1
2060	699	16	2	130	13	0	2
2061	699	32	3	110	11	0	3
2062	700	78	1	150	15	0	1
2064	700	46	3	120	12	0	2
2065	701	37	1	150	15	0	2
2067	701	1	3	80	8	0	3
2069	702	68	2	100	10	0	2
2072	703	77	2	110	11	0	2
2071	703	45	1	90	9	0	3
2076	704	51	3	160	16	0	1
2074	704	7	1	150	15	0	2
2075	704	26	2	150	15	0	3
2077	705	31	1	170	17	0	1
2079	705	56	3	70	7	0	3
2081	706	44	2	140	14	0	1
2080	706	67	1	90	9	0	2
2082	706	38	3	80	8	0	3
2084	707	62	2	170	17	0	2
2085	707	5	3	120	12	0	3
2087	708	8	2	90	9	0	2
2089	709	16	1	130	13	0	1
2091	709	4	3	80	8	0	2
2090	709	6	2	60	6	0	3
2092	710	78	1	250	25	0	1
2094	710	32	3	170	17	0	2
2097	713	22	3	180	18	0	1
2095	713	23	1	160	16	0	2
2096	713	53	2	90	9	0	3
2099	714	52	2	210	21	0	1
2100	714	27	3	30	3	0	3
2101	715	12	1	130	13	0	1
2102	715	40	2	90	9	0	2
2104	716	79	1	160	16	0	1
2105	716	13	2	140	14	0	2
2107	717	18	1	210	21	0	1
2109	717	10	3	40	4	0	3
2110	718	57	1	230	23	0	1
2112	718	65	3	180	18	0	2
2111	718	72	2	50	5	0	3
2115	719	29	3	190	19	0	1
2114	719	34	2	170	17	0	2
2117	720	41	2	140	14	0	2
2116	720	28	1	120	12	0	3
2121	721	69	3	110	11	0	1
2119	721	39	1	100	10	0	2
2120	721	9	2	100	10	0	3
2124	722	58	3	130	13	0	2
2122	722	75	1	120	12	0	3
2125	723	11	1	180	18	0	2
2126	723	27	2	110	11	0	3
2129	724	28	2	170	17	0	1
2130	724	10	3	60	6	0	3
2131	725	64	1	150	15	0	1
2132	725	41	2	50	5	0	3
2134	726	65	1	140	14	0	1
2135	726	69	2	140	14	0	2
2136	726	79	3	130	13	0	3
2139	727	59	3	140	14	0	2
2137	727	58	1	120	12	0	3
2140	728	47	1	140	14	0	1
2142	728	11	3	140	14	0	2
2141	728	39	2	130	13	0	3
2145	729	33	3	130	13	0	2
2146	730	63	1	130	13	0	2
2147	730	40	2	50	5	0	3
2150	731	34	2	140	14	0	1
2151	731	13	3	130	13	0	2
2149	731	12	1	120	12	0	3
2152	732	57	1	140	14	0	1
2154	732	53	3	90	9	0	2
2156	733	23	2	110	11	0	1
2157	733	17	3	40	4	0	2
2155	733	9	1	10	1	0	3
2160	734	18	3	200	20	0	1
2159	734	47	2	130	13	0	2
2161	735	28	1	290	29	0	1
2166	736	34	3	160	16	0	1
2164	736	63	1	110	11	0	2
2165	736	72	2	60	6	0	3
2167	737	10	1	130	13	0	1
2169	737	59	3	100	10	0	2
2171	738	29	2	190	19	0	1
2170	738	41	1	130	13	0	2
2172	738	65	3	90	9	0	3
2175	739	53	3	160	16	0	1
2174	739	69	2	100	10	0	2
2176	740	12	1	160	16	0	2
2177	740	64	2	150	15	0	3
2180	741	79	2	180	18	0	1
2179	741	9	1	80	8	0	2
2182	742	52	1	160	16	0	1
2184	742	39	3	140	14	0	2
2186	743	58	2	140	14	0	1
2185	743	13	1	130	13	0	2
2187	743	27	3	100	10	0	3
2189	744	23	2	160	16	0	1
2190	744	34	3	120	12	0	2
2192	745	28	2	120	12	0	1
2191	745	75	1	80	8	0	2
2195	746	27	2	140	14	0	1
2196	746	39	3	80	8	0	2
2194	746	59	1	70	7	0	3
2197	747	57	1	70	7	0	3
2201	748	12	2	170	17	0	1
2203	749	18	1	120	12	0	1
2204	749	13	2	20	2	0	3
2207	750	79	2	130	13	0	1
2208	750	10	3	110	11	0	2
2206	750	17	1	90	9	0	3
2211	751	72	3	110	11	0	1
2209	751	22	1	100	10	0	2
2214	752	11	3	210	21	0	1
2212	752	40	1	130	13	0	2
2213	752	58	2	90	9	0	3
2217	753	52	3	120	12	0	1
2216	753	47	2	100	10	0	2
2218	754	53	1	140	14	0	1
2219	754	79	2	90	9	0	2
2223	755	41	3	130	13	0	2
2221	755	52	1	110	11	0	3
2224	756	65	1	280	28	0	1
2226	756	29	3	180	18	0	2
2229	757	59	3	80	8	0	1
2228	757	9	2	70	7	0	2
2227	757	17	1	50	5	0	3
2231	758	12	2	150	15	0	1
2232	758	13	3	50	5	0	3
2234	759	47	2	50	5	0	2
2233	759	75	1	30	3	0	3
2236	760	57	1	90	9	0	3
2361	802	73	3	\N	\N	0	\N
2238	760	10	3	180	18	0	2
2241	761	23	3	180	18	0	1
2239	761	69	1	140	14	0	2
2242	762	54	1	180	18	0	1
2244	762	27	3	60	6	0	3
2246	763	11	2	150	15	0	1
2247	763	64	3	70	7	0	3
2249	764	28	2	260	26	0	1
2248	764	63	1	110	11	0	2
2253	765	64	3	220	22	0	1
2251	765	72	1	200	20	0	2
2252	765	58	2	100	10	0	3
2254	766	47	1	80	8	0	2
2256	766	53	3	40	4	0	3
2258	767	39	2	120	12	0	1
2257	767	54	1	110	11	0	2
2259	767	29	3	100	10	0	3
2261	768	18	2	190	19	0	2
2264	769	65	2	210	21	0	1
2263	769	27	1	130	13	0	2
2268	770	28	3	170	17	0	1
2267	770	75	2	120	12	0	2
2266	770	9	1	100	10	0	3
2271	771	13	3	150	15	0	1
2269	771	69	1	40	4	0	3
2272	772	79	1	150	15	0	1
2273	772	57	2	110	11	0	2
2274	772	41	3	100	10	0	3
2276	773	11	2	120	12	0	2
2277	773	40	3	0	0	0	3
2279	774	23	2	180	18	0	2
2278	774	52	1	160	16	0	3
2282	776	61	2	70	7	0	2
2281	776	48	1	50	5	0	3
2286	777	66	3	160	16	0	1
2284	777	76	1	110	11	0	2
2288	778	15	2	160	16	0	1
2289	778	55	3	160	16	0	2
2287	778	24	1	90	9	0	3
2291	779	20	2	170	17	0	1
2292	779	42	3	110	11	0	2
2294	780	36	2	230	23	0	1
2293	780	73	1	110	11	0	2
2297	781	43	2	260	26	0	1
2296	781	14	1	150	15	0	2
2298	781	70	3	140	14	0	3
2299	782	19	1	180	18	0	2
2302	783	24	1	170	17	0	1
2304	783	48	3	110	11	0	2
2303	783	49	2	100	10	0	3
2307	784	15	3	140	14	0	1
2306	784	76	2	130	13	0	2
2309	785	70	2	130	13	0	1
2308	785	14	1	40	4	0	3
2311	786	19	1	190	19	0	1
2312	786	42	2	180	18	0	2
2313	786	80	3	70	7	0	3
2314	787	66	1	220	22	0	1
2316	787	73	3	190	19	0	2
2317	788	55	1	270	27	0	1
2319	788	20	3	170	17	0	3
2322	789	43	3	220	22	0	1
2321	789	66	2	50	5	0	3
2324	790	55	2	160	16	0	1
2323	790	49	1	130	13	0	3
2327	791	61	2	290	29	0	1
2328	791	19	3	230	23	0	2
2326	791	14	1	200	20	0	3
2329	792	76	1	120	12	0	2
2331	792	20	3	120	12	0	3
2333	793	36	2	150	15	0	1
2334	793	70	3	120	12	0	2
2332	793	73	1	110	11	0	3
2336	794	48	2	160	16	0	2
2338	795	24	1	130	13	0	2
2339	795	30	2	100	10	0	3
2343	796	19	3	250	25	0	1
2342	796	66	2	200	20	0	2
2341	796	70	1	160	16	0	3
2346	797	42	3	220	22	0	1
2344	797	80	1	120	12	0	2
2349	798	20	3	240	24	0	1
2347	798	14	1	130	13	0	2
2348	798	15	2	120	12	0	3
2352	799	49	3	170	17	0	1
2351	799	43	2	160	16	0	2
2354	800	55	2	250	25	0	1
2353	800	76	1	120	12	0	3
2359	802	36	1	80	8	0	3
2360	802	73	2	110	11	0	2
2362	803	42	1	200	20	0	1
2364	803	19	3	150	15	0	2
2365	804	15	1	210	21	0	1
2366	804	80	2	100	10	0	2
2367	804	35	3	20	2	0	3
2369	805	36	2	250	25	0	1
2370	805	43	3	140	14	0	3
2372	806	66	2	130	13	0	2
2371	806	70	1	70	7	0	3
2374	807	48	1	120	12	0	1
2376	807	24	3	80	8	0	2
2375	807	49	2	60	6	0	3
2377	808	55	1	70	7	0	3
2382	809	15	3	130	13	0	1
2380	809	30	1	80	8	0	2
2381	809	35	2	70	7	0	3
2384	810	20	2	130	13	0	2
2385	810	14	3	120	12	0	3
2386	811	43	1	200	20	0	1
2387	811	36	2	40	4	0	3
2391	812	61	3	270	27	0	1
2389	812	24	1	170	17	0	2
2390	812	80	2	130	13	0	3
2394	813	19	3	170	17	0	2
2392	813	48	1	110	11	0	3
2396	814	76	2	160	16	0	1
2395	814	55	1	100	10	0	3
2399	815	73	2	190	19	0	1
2400	815	30	3	120	12	0	2
2401	816	16	1	180	18	0	2
2402	816	46	2	60	6	0	3
2405	817	71	2	200	20	0	1
2404	817	31	1	150	15	0	2
2406	817	32	3	110	11	0	3
2407	818	8	1	110	11	0	2
2410	819	25	1	200	20	0	1
2412	819	38	3	180	18	0	2
2414	820	4	2	130	13	0	1
2415	820	37	3	80	8	0	3
2417	821	77	2	140	14	0	1
2416	821	62	1	70	7	0	3
2420	822	2	2	170	17	0	1
2421	822	50	3	160	16	0	2
2419	822	6	1	60	6	0	3
2422	823	78	1	140	14	0	1
2424	823	26	3	120	12	0	2
2425	824	68	1	200	20	0	1
2426	824	45	2	120	12	0	2
2427	824	67	3	100	10	0	3
2429	825	3	2	170	17	0	1
2430	825	71	3	110	11	0	2
2431	826	51	1	10	1	0	3
2434	827	78	1	190	19	0	1
2435	827	8	2	130	13	0	2
2436	827	68	3	130	13	0	3
2437	828	37	1	200	20	0	2
2439	828	4	3	50	5	0	3
2441	829	56	2	150	15	0	1
2440	829	44	1	130	13	0	2
2442	829	7	3	130	13	0	3
2444	830	74	2	180	18	0	1
2445	830	32	3	160	16	0	2
2447	831	2	2	190	19	0	1
2446	831	26	1	60	6	0	2
2449	832	6	1	190	19	0	1
2451	832	77	3	140	14	0	3
2454	833	21	3	200	20	0	1
2452	833	3	1	60	6	0	3
2457	834	16	3	220	22	0	1
2455	834	38	1	170	17	0	2
2456	834	46	2	140	14	0	3
2459	835	6	2	170	17	0	1
2460	835	3	3	170	17	0	2
2461	836	31	1	170	17	0	1
2462	836	26	2	150	15	0	2
2466	837	8	3	190	19	0	1
2465	837	67	2	110	11	0	2
2464	837	46	1	70	7	0	3
2467	838	62	1	160	16	0	1
2472	839	38	3	190	19	0	1
2471	839	77	2	70	7	0	2
2470	839	51	1	60	6	0	3
2475	840	1	3	110	11	0	2
2474	840	56	2	40	4	0	3
2477	841	78	2	110	11	0	2
2476	841	7	1	80	8	0	3
2479	842	5	1	190	19	0	1
2480	842	25	2	110	11	0	2
2481	842	37	3	70	7	0	3
2484	843	50	3	170	17	0	2
2482	843	32	1	110	11	0	3
2485	844	21	1	220	22	0	1
2487	844	2	3	160	16	0	2
2490	845	44	3	160	16	0	1
2489	845	7	2	140	14	0	2
2492	846	51	2	180	18	0	2
2491	846	8	1	70	7	0	3
2494	847	16	1	190	19	0	1
2496	847	67	3	130	13	0	2
2495	847	45	2	80	8	0	3
2497	848	3	1	250	25	0	1
2499	848	38	3	200	20	0	3
2500	849	78	1	170	17	0	1
2502	849	77	3	160	16	0	2
2501	849	71	2	70	7	0	3
2504	850	37	2	140	14	0	1
2505	850	31	3	130	13	0	2
2506	851	1	1	80	8	0	3
2510	852	26	2	100	10	0	1
2511	852	50	3	70	7	0	2
2509	852	5	1	20	2	0	3
2512	853	56	1	110	11	0	2
2516	854	74	2	160	16	0	1
2517	854	56	3	160	16	0	2
2515	854	6	1	140	14	0	3
2518	855	8	1	120	12	0	2
2520	855	31	3	80	8	0	3
2523	856	2	3	150	15	0	1
2521	856	77	1	120	12	0	2
2522	856	21	2	120	12	0	3
2526	857	68	3	200	20	0	1
2528	858	1	2	150	15	0	2
2527	858	16	1	130	13	0	3
2530	859	38	1	180	18	0	1
2532	859	7	3	150	15	0	2
2531	859	4	2	140	14	0	3
2535	860	78	3	140	14	0	1
2533	860	46	1	130	13	0	2
2536	861	74	1	220	22	0	1
2537	861	5	2	170	17	0	2
2538	861	32	3	100	10	0	3
2541	862	6	3	190	19	0	1
2540	862	51	2	110	11	0	3
2543	863	45	2	170	17	0	1
2542	863	25	1	150	15	0	2
2547	864	32	3	170	17	0	2
2545	864	26	1	30	3	0	3
2548	865	7	1	220	22	0	1
2550	865	68	3	200	20	0	2
2553	866	46	3	180	18	0	1
2552	866	37	2	160	16	0	2
2551	866	78	1	140	14	0	3
2555	867	45	2	80	8	0	2
2556	867	77	3	50	5	0	3
2558	868	62	2	180	18	0	1
2557	868	44	1	170	17	0	2
2561	869	38	2	200	20	0	1
2560	869	50	1	160	16	0	2
2562	869	74	3	160	16	0	3
2565	870	56	3	170	17	0	2
2567	871	8	2	150	15	0	1
2566	871	21	1	90	9	0	2
2568	871	67	3	50	5	0	3
2570	872	6	2	170	17	0	1
2571	872	31	3	110	11	0	3
2572	873	25	1	190	19	0	2
2573	873	3	2	100	10	0	3
2575	876	23	1	180	18	0	1
2576	876	33	2	180	18	0	2
2577	876	54	3	110	11	0	3
2578	877	18	1	120	12	0	2
2582	878	72	2	150	15	0	1
2583	878	41	3	140	14	0	2
2585	879	39	2	260	26	0	1
2586	879	57	3	140	14	0	2
2587	880	52	1	250	25	0	1
2588	880	13	2	140	14	0	2
2592	881	75	3	110	11	0	1
2591	881	22	2	90	9	0	2
2590	881	47	1	80	8	0	3
2595	882	17	3	140	14	0	1
2593	882	9	1	100	10	0	3
2597	883	64	2	250	25	0	1
2598	883	29	3	140	14	0	2
2596	883	63	1	130	13	0	3
2600	884	11	2	200	20	0	1
2601	884	10	3	50	5	0	3
2603	885	59	2	30	3	0	2
2605	886	53	1	140	14	0	1
2607	886	52	3	120	12	0	2
2606	886	47	2	90	9	0	3
2610	887	27	3	110	11	0	1
2608	887	57	1	90	9	0	3
2611	888	13	1	200	20	0	1
2613	888	34	3	100	10	0	2
2612	888	64	2	20	2	0	3
2616	889	33	3	160	16	0	1
2615	889	28	2	80	8	0	2
2618	890	23	2	170	17	0	1
2617	890	12	1	100	10	0	2
2621	891	18	2	220	22	0	1
2622	891	40	3	50	5	0	3
2623	892	72	1	120	12	0	1
2625	892	22	3	90	9	0	3
2627	893	59	2	220	22	0	1
2626	893	29	1	180	18	0	2
2628	893	69	3	110	11	0	3
2630	894	54	2	150	15	0	1
2631	894	10	3	110	11	0	2
2633	895	58	2	200	20	0	1
2632	895	41	1	130	13	0	2
2636	896	65	2	240	24	0	1
2635	896	79	1	210	21	0	2
2638	897	29	1	200	20	0	1
2640	897	53	3	140	14	0	2
2641	898	33	1	240	24	0	1
2642	898	79	2	170	17	0	2
2643	898	65	3	120	12	0	3
2646	899	27	3	150	15	0	1
2645	899	58	2	80	8	0	3
2648	900	72	2	170	17	0	1
2647	900	59	1	-20	-2	0	3
2651	901	17	2	110	11	0	1
2652	901	54	3	110	11	0	2
2650	901	75	1	90	9	0	3
2655	902	34	3	180	18	0	2
2653	902	23	1	-20	-2	0	3
2657	903	11	2	240	24	0	1
2658	903	47	3	110	11	0	2
2660	904	28	2	310	31	0	1
2661	904	18	3	140	14	0	3
2663	905	63	2	100	10	0	2
2662	905	22	1	60	6	0	3
2667	906	13	3	260	26	0	1
2666	906	52	2	210	21	0	2
2665	906	40	1	110	11	0	3
2668	907	58	1	170	17	0	1
2672	908	28	2	230	23	0	1
2673	908	52	3	160	16	0	2
2675	909	64	2	130	13	0	1
2674	909	17	1	120	12	0	2
2677	910	13	1	140	14	0	1
2678	910	79	2	80	8	0	2
2680	911	10	1	110	11	0	2
2682	911	59	3	60	6	0	3
2683	912	27	1	140	14	0	1
2684	912	34	2	70	7	0	2
2685	912	69	3	60	6	0	3
2687	913	23	2	160	16	0	1
2688	913	11	3	110	11	0	2
2689	914	54	1	180	18	0	1
2690	914	40	2	50	5	0	3
2693	915	72	2	120	12	0	1
2692	915	18	1	110	11	0	2
2694	915	75	3	110	11	0	3
2697	916	57	3	210	21	0	1
2695	916	29	1	140	14	0	3
2700	917	41	3	120	12	0	2
2699	917	17	2	110	11	0	3
2703	918	79	3	110	11	0	1
2702	918	75	2	90	9	0	2
2705	919	28	2	180	18	0	1
2704	919	40	1	50	5	0	3
2708	920	18	2	270	27	0	1
2709	920	47	3	130	13	0	2
2707	920	23	1	50	5	0	3
2712	921	39	3	180	18	0	1
2710	921	52	1	140	14	0	2
2713	922	65	1	210	21	0	1
2715	922	72	3	100	10	0	2
2714	922	33	2	80	8	0	3
2717	923	12	2	100	10	0	3
2719	924	54	1	90	9	0	1
2720	924	10	2	50	5	0	2
2722	925	63	1	170	17	0	1
2724	925	29	3	120	12	0	2
2723	925	69	2	90	9	0	3
2725	926	11	1	190	19	0	1
2727	926	13	3	60	6	0	3
2728	927	64	1	120	12	0	1
2729	927	9	2	120	12	0	2
2730	927	57	3	80	8	0	3
2732	928	29	2	120	12	0	1
2733	928	17	3	80	8	0	2
2734	929	18	1	200	20	0	1
2738	930	39	2	160	16	0	1
2739	930	33	3	70	7	0	2
2737	930	69	1	40	4	0	3
2740	931	63	1	120	12	0	1
2742	931	12	3	100	10	0	3
2744	932	52	2	130	13	0	1
2743	932	13	1	90	9	0	2
2745	932	27	3	60	6	0	3
2748	933	64	3	140	14	0	1
2747	933	10	2	130	13	0	3
2749	934	54	1	180	18	0	1
2750	934	47	2	100	10	0	3
2940	998	45	3	\N	\N	0	\N
2753	935	72	2	100	10	0	2
2754	935	22	3	80	8	0	3
2757	936	75	3	90	9	0	2
2755	936	28	1	70	7	0	3
2759	937	41	2	60	6	0	2
2760	937	40	3	60	6	0	3
2763	939	80	3	150	15	0	1
2762	939	48	2	140	14	0	2
2765	940	60	2	220	22	0	2
2764	940	66	1	190	19	0	3
2769	941	43	3	190	19	0	1
2768	941	20	2	110	11	0	2
2767	941	73	1	30	3	0	3
2772	942	55	3	210	21	0	1
2770	942	15	1	100	10	0	3
2773	943	76	1	160	16	0	1
2775	943	30	3	140	14	0	2
2774	943	24	2	130	13	0	3
2778	944	49	3	110	11	0	3
2780	945	70	2	150	15	0	1
2779	945	14	1	120	12	0	3
2784	946	76	3	200	20	0	1
2782	946	20	1	190	19	0	2
2783	946	55	2	160	16	0	3
2787	947	43	3	150	15	0	2
2785	947	48	1	100	10	0	3
2789	948	61	2	200	20	0	1
2790	948	35	3	150	15	0	2
2788	948	14	1	50	5	0	3
2792	949	19	2	130	13	0	1
2793	949	24	3	130	13	0	2
2795	950	60	2	230	23	0	1
2797	951	80	1	220	22	0	1
2798	951	49	2	160	16	0	2
2799	951	42	3	110	11	0	3
2802	952	35	3	150	15	0	1
2800	952	70	1	70	7	0	3
2805	953	76	3	240	24	0	1
2804	953	48	2	180	18	0	2
2803	953	42	1	160	16	0	3
2807	954	73	2	220	22	0	1
2808	954	43	3	150	15	0	3
2810	955	20	2	170	17	0	1
2809	955	66	1	110	11	0	3
2812	956	24	1	210	21	0	1
2814	956	36	3	160	16	0	2
2815	957	19	1	120	12	0	1
2817	957	55	3	120	12	0	2
2818	958	60	1	170	17	0	1
2819	958	80	2	140	14	0	2
2820	958	61	3	60	6	0	3
2823	959	66	3	170	17	0	1
2822	959	61	2	120	12	0	2
2824	960	80	1	130	13	0	2
2825	960	55	2	90	9	0	3
2829	961	73	3	40	4	0	3
2831	962	36	2	230	23	0	1
2830	962	60	1	180	18	0	2
2832	962	19	3	140	14	0	3
2834	963	35	2	140	14	0	2
2836	964	20	1	210	21	0	1
2837	964	15	2	100	10	0	3
2840	965	14	2	170	17	0	1
2841	965	36	3	140	14	0	2
2839	965	30	1	120	12	0	3
2844	966	24	3	180	18	0	1
2842	966	70	1	140	14	0	2
2845	967	15	1	110	11	0	1
2847	967	20	3	110	11	0	2
2846	967	60	2	20	2	0	3
2849	968	55	2	150	15	0	1
2850	968	66	3	140	14	0	2
2852	969	80	2	90	9	0	2
2851	969	73	1	20	2	0	3
2855	970	76	2	220	22	0	2
2854	970	49	1	90	9	0	3
2857	971	42	1	100	10	0	2
2859	971	61	3	100	10	0	3
2861	972	19	2	210	21	0	1
2860	972	30	1	180	18	0	2
2862	972	61	3	140	14	0	3
2864	973	35	2	200	20	0	1
2865	973	70	3	120	12	0	3
2866	974	80	1	200	20	0	1
2867	974	60	2	140	14	0	3
2870	975	48	2	130	13	0	1
2871	975	30	3	90	9	0	2
2869	975	20	1	70	7	0	3
2874	976	66	3	140	14	0	2
2877	977	15	3	160	16	0	1
2876	977	42	2	150	15	0	2
2875	977	36	1	100	10	0	3
2880	978	24	3	110	11	0	2
2879	978	55	2	100	10	0	3
2882	979	25	2	280	28	0	1
2881	979	1	1	90	9	0	2
2885	980	56	2	220	22	0	1
2884	980	26	1	130	13	0	2
2886	980	71	3	120	12	0	3
2887	981	45	1	150	15	0	2
2889	981	77	3	120	12	0	3
2891	982	68	2	220	22	0	1
2890	982	50	1	50	5	0	3
2894	983	67	2	200	20	0	1
2895	983	44	3	170	17	0	3
2896	984	21	1	150	15	0	2
2897	984	3	2	110	11	0	3
2899	985	16	1	90	9	0	1
2900	985	7	2	70	7	0	2
2901	985	32	3	60	6	0	3
2904	986	46	3	160	16	0	1
2902	986	37	1	50	5	0	3
2907	987	2	3	220	22	0	1
2905	987	38	1	200	20	0	2
2906	987	5	2	150	15	0	3
2910	988	46	3	190	19	0	1
2911	989	62	1	220	22	0	1
2912	989	3	2	200	20	0	2
2915	990	37	2	130	13	0	1
2916	990	67	3	130	13	0	2
2914	990	38	1	80	8	0	3
2917	991	56	1	140	14	0	2
2919	991	16	3	140	14	0	3
2920	992	6	1	90	9	0	2
2921	992	78	2	50	5	0	3
3086	1049	12	2	\N	\N	0	\N
3117	1059	79	3	\N	\N	0	\N
2924	993	5	2	190	19	0	1
2925	993	77	3	130	13	0	2
2926	994	8	1	180	18	0	1
2927	994	51	2	160	16	0	3
2929	995	71	1	160	16	0	1
2930	995	44	2	70	7	0	2
2932	996	7	1	140	14	0	1
2934	996	50	3	120	12	0	3
2935	997	74	1	210	21	0	1
2937	997	31	3	160	16	0	2
2936	997	26	2	90	9	0	3
2939	998	25	2	250	25	0	2
2942	999	56	2	150	15	0	1
2943	999	6	3	120	12	0	2
2941	999	31	1	70	7	0	3
2946	1000	62	3	120	12	0	2
2945	1000	1	2	110	11	0	3
2947	1001	44	1	180	18	0	1
2948	1001	74	2	130	13	0	2
2950	1002	4	1	170	17	0	1
2951	1002	32	2	100	10	0	3
2955	1003	21	3	150	15	0	2
2953	1003	8	1	120	12	0	3
2956	1004	68	1	230	23	0	1
2957	1004	50	2	200	20	0	2
2958	1004	26	3	200	20	0	3
2960	1005	67	2	160	16	0	1
2961	1005	51	3	90	9	0	2
2962	1006	2	1	220	22	0	1
2963	1006	77	2	140	14	0	2
2965	1007	78	1	240	24	0	1
2966	1007	5	2	210	21	0	2
2967	1007	46	3	150	15	0	3
2970	1008	78	3	210	21	0	1
2972	1009	51	2	170	17	0	1
2973	1009	7	3	80	8	0	2
2971	1009	1	1	50	5	0	3
2975	1010	77	2	230	23	0	1
2976	1010	25	3	190	19	0	2
2978	1011	6	2	190	19	0	1
2977	1011	32	1	50	5	0	3
2981	1012	5	2	250	25	0	1
2982	1012	31	3	190	19	0	2
2980	1012	38	1	150	15	0	3
2983	1013	68	1	120	12	0	1
2986	1014	67	1	210	21	0	1
2988	1014	4	3	140	14	0	2
2987	1014	37	2	130	13	0	3
2991	1015	16	3	40	4	0	3
2992	1016	74	1	220	22	0	1
2994	1016	21	3	170	17	0	2
2993	1016	8	2	90	9	0	3
2996	1017	3	2	210	21	0	1
2997	1017	6	3	140	14	0	2
2999	1018	74	2	140	14	0	2
2998	1018	45	1	130	13	0	3
3003	1019	5	3	200	20	0	1
3002	1019	51	2	160	16	0	2
3001	1019	62	1	110	11	0	3
3006	1020	44	3	220	22	0	2
3004	1020	32	1	140	14	0	3
3008	1021	78	2	210	21	0	1
3009	1021	38	3	180	18	0	3
3012	1022	3	3	260	26	0	1
3011	1022	71	2	160	16	0	2
3013	1023	8	1	280	28	0	1
3014	1023	37	2	80	8	0	2
3016	1024	50	1	200	20	0	1
3017	1024	68	2	160	16	0	2
3018	1024	67	3	150	15	0	3
3021	1025	21	3	140	14	0	2
3019	1025	16	1	120	12	0	3
3022	1026	77	1	250	25	0	1
3024	1026	26	3	140	14	0	2
3023	1026	46	2	80	8	0	3
3027	1027	74	3	260	26	0	1
3028	1028	4	1	190	19	0	1
3029	1028	8	2	180	18	0	2
3032	1029	71	2	270	27	0	1
3031	1029	62	1	100	10	0	2
3033	1029	45	3	40	4	0	3
3036	1030	77	3	220	22	0	1
3034	1030	7	1	150	15	0	2
3039	1031	31	3	180	18	0	1
3038	1031	50	2	160	16	0	2
3037	1031	5	1	140	14	0	3
3042	1032	16	3	220	22	0	2
3041	1032	67	2	140	14	0	3
3044	1033	3	2	200	20	0	1
3043	1033	32	1	140	14	0	2
3046	1034	21	1	170	17	0	2
3047	1034	44	2	170	17	0	3
3049	1035	78	1	200	20	0	1
3051	1035	38	3	180	18	0	2
3054	1036	26	3	180	18	0	1
3053	1036	1	2	130	13	0	2
3052	1036	56	1	100	10	0	3
3056	1039	69	2	100	10	0	2
3057	1039	58	3	50	5	0	3
3059	1040	13	2	160	16	0	1
3058	1040	9	1	60	6	0	2
3063	1041	63	3	130	13	0	1
3061	1041	72	1	100	10	0	2
3062	1041	59	2	100	10	0	3
3064	1042	57	1	120	12	0	2
3068	1043	22	2	150	15	0	1
3069	1043	18	3	140	14	0	2
3067	1043	75	1	90	9	0	3
3072	1044	28	3	190	19	0	1
3071	1044	47	2	50	5	0	3
3073	1045	23	1	130	13	0	1
3074	1045	39	2	90	9	0	2
3077	1046	29	2	140	14	0	1
3078	1046	53	3	110	11	0	2
3076	1046	79	1	20	2	0	3
3081	1047	65	3	270	27	0	1
3079	1047	10	1	50	5	0	3
3082	1048	17	1	170	17	0	1
3083	1048	34	2	80	8	0	3
3087	1049	52	3	160	16	0	2
3090	1050	59	3	130	13	0	1
3089	1050	18	2	120	12	0	2
3088	1050	75	1	40	4	0	3
3092	1051	28	2	160	16	0	1
3095	1052	27	2	200	20	0	1
3094	1052	41	1	90	9	0	3
3097	1053	33	1	150	15	0	2
3098	1053	10	2	80	8	0	3
3102	1054	11	3	160	16	0	1
3100	1054	47	1	50	5	0	3
3103	1055	69	1	200	20	0	1
3105	1055	23	3	70	7	0	2
3104	1055	22	2	40	4	0	3
3107	1056	58	2	120	12	0	1
3108	1056	13	3	100	10	0	3
3110	1057	53	2	100	10	0	1
3109	1057	17	1	50	5	0	3
3113	1058	40	2	110	11	0	1
3114	1058	57	3	110	11	0	2
3112	1058	72	1	20	2	0	3
3119	1060	63	2	210	21	0	1
3118	1060	22	1	90	9	0	2
3120	1060	72	3	90	9	0	3
3123	1061	40	3	110	11	0	2
3121	1061	65	1	80	8	0	3
3126	1062	27	3	120	12	0	1
3124	1062	75	1	90	9	0	2
3125	1062	13	2	0	0	0	3
3129	1063	69	3	150	15	0	1
3128	1063	47	2	120	12	0	2
3130	1064	23	1	120	12	0	2
3131	1064	58	2	110	11	0	3
3133	1065	18	1	190	19	0	1
3134	1065	17	2	110	11	0	2
3138	1066	10	3	70	7	0	1
3136	1066	53	1	20	2	0	3
3140	1067	64	2	150	15	0	1
3139	1067	34	1	0	0	0	3
3144	1068	52	3	100	10	0	1
3143	1068	57	2	90	9	0	2
3145	1069	12	1	210	21	0	1
3146	1069	28	2	130	13	0	3
3149	1070	29	2	260	26	0	1
3148	1070	53	1	110	11	0	2
3150	1070	40	3	40	4	0	3
3153	1071	75	3	110	11	0	2
3151	1071	13	1	80	8	0	3
3154	1072	79	1	100	10	0	1
3156	1072	59	3	40	4	0	3
3159	1073	52	3	160	16	0	1
3158	1073	17	2	100	10	0	3
3160	1074	18	1	240	24	0	1
3161	1074	9	2	50	5	0	3
3165	1075	28	3	220	22	0	1
3164	1075	57	2	200	20	0	2
3163	1075	54	1	150	15	0	3
3166	1076	11	1	110	11	0	2
3168	1076	23	3	100	10	0	3
3171	1077	65	3	210	21	0	1
3170	1077	33	2	140	14	0	2
3169	1077	47	1	80	8	0	3
3174	1078	58	3	130	13	0	2
3175	1079	63	1	220	22	0	2
3176	1079	10	2	130	13	0	3
3178	1080	34	1	160	16	0	1
3179	1080	23	2	100	10	0	2
3180	1080	54	3	80	8	0	3
3183	1081	57	3	130	13	0	1
3181	1081	75	1	100	10	0	3
3185	1082	12	2	200	20	0	1
3184	1082	65	1	170	17	0	2
3186	1082	34	3	170	17	0	3
3188	1083	11	2	170	17	0	1
3189	1083	52	3	130	13	0	2
3191	1084	64	2	150	15	0	1
3190	1084	33	1	120	12	0	2
3194	1085	22	2	140	14	0	2
3193	1085	27	1	120	12	0	3
3198	1086	41	3	110	11	0	1
3196	1086	10	1	100	10	0	2
3200	1087	13	2	200	20	0	1
3201	1087	47	3	140	14	0	2
3199	1087	29	1	130	13	0	3
3203	1088	58	2	240	24	0	1
3204	1088	72	3	160	16	0	3
3205	1089	53	1	130	13	0	1
3206	1089	39	2	110	11	0	2
3210	1090	65	3	180	18	0	1
3208	1090	18	1	100	10	0	2
3209	1090	17	2	100	10	0	3
3211	1091	17	1	100	10	0	2
3216	1092	53	3	170	17	0	1
3214	1092	41	1	80	8	0	2
3215	1092	72	2	50	5	0	3
3218	1093	69	2	190	19	0	1
3219	1093	52	3	130	13	0	2
3221	1094	13	2	160	16	0	1
3220	1094	54	1	140	14	0	3
3224	1095	59	2	160	16	0	1
3223	1095	33	1	130	13	0	2
3225	1095	9	3	30	3	0	3
3226	1096	57	1	150	15	0	1
3228	1096	39	3	130	13	0	2
3229	1097	34	1	160	16	0	1
3231	1097	10	3	110	11	0	3
3233	1098	47	2	130	13	0	1
3234	1098	23	3	110	11	0	2
3235	1099	29	1	200	20	0	1
3236	1099	40	2	100	10	0	3
3238	1100	18	1	190	19	0	1
3240	1100	64	3	180	18	0	2
3239	1100	27	2	110	11	0	3
3241	1102	20	1	200	20	0	2
3243	1102	35	3	130	13	0	3
3246	1103	48	3	210	21	0	1
3244	1103	15	1	90	9	0	2
3245	1103	30	2	0	0	0	3
3249	1104	70	3	90	9	0	2
3251	1105	61	2	250	25	0	1
3250	1105	24	1	90	9	0	3
3254	1106	49	2	130	13	0	1
3253	1106	43	1	120	12	0	2
3255	1106	42	3	110	11	0	3
3258	1107	55	3	130	13	0	2
3256	1107	66	1	110	11	0	3
3261	1108	49	3	190	19	0	1
3260	1108	60	2	120	12	0	2
3259	1108	76	1	50	5	0	3
3264	1109	43	3	180	18	0	1
3263	1109	24	2	120	12	0	3
2	1	31	2	110	11	0	3
7	3	16	1	210	21	0	2
17	6	21	2	310	31	0	1
22	8	25	1	190	19	0	1
27	9	45	3	190	19	0	2
32	11	38	2	120	12	0	3
37	13	32	1	180	18	0	2
42	14	7	3	190	19	0	1
47	16	8	2	150	15	0	3
52	18	44	1	60	6	0	3
57	19	4	3	250	25	0	1
62	21	77	2	230	23	0	1
67	23	78	1	150	15	0	3
72	24	25	3	140	14	0	3
77	26	1	2	140	14	0	2
82	28	67	1	110	11	0	3
92	31	68	2	130	13	0	2
97	33	5	1	180	18	0	2
102	34	45	3	130	13	0	2
107	36	46	2	180	18	0	2
112	38	16	1	150	15	0	1
117	39	5	3	100	10	0	2
122	41	67	2	20	2	0	3
127	43	37	1	90	9	0	3
132	44	25	3	280	28	0	1
137	46	51	2	240	24	0	1
142	48	62	1	120	12	0	3
147	49	2	3	130	13	0	3
152	51	45	2	130	13	0	3
157	53	5	1	160	16	0	1
158	53	51	2	90	9	0	3
164	55	21	2	250	25	0	1
169	57	3	1	150	15	0	3
174	58	71	3	120	12	0	3
179	62	40	2	100	10	0	3
184	64	59	1	100	10	0	2
189	65	13	3	230	23	0	1
194	67	53	2	40	4	0	3
199	69	34	1	100	10	0	3
204	70	57	3	120	12	0	2
209	72	41	2	90	9	0	3
214	74	23	1	200	20	0	1
219	75	29	3	170	17	0	2
224	77	72	2	70	7	0	3
234	80	22	3	60	6	0	3
239	82	53	2	90	9	0	2
244	84	28	1	150	15	0	2
249	85	29	3	200	20	0	1
254	87	18	2	120	12	0	2
259	89	17	1	0	0	0	3
264	90	34	3	60	6	0	3
269	92	59	2	170	17	0	1
274	94	52	1	310	31	0	1
279	95	64	3	240	24	0	1
284	97	79	2	130	13	0	2
289	99	28	1	120	12	0	2
294	100	12	3	170	17	0	1
299	102	75	2	20	2	0	3
309	105	53	3	120	12	0	2
315	107	41	3	110	11	0	2
314	107	40	2	80	8	0	3
316	108	72	1	120	12	0	2
321	109	12	3	100	10	0	2
326	111	10	2	80	8	0	3
331	113	39	1	170	17	0	1
336	114	53	3	70	7	0	3
341	116	33	2	200	20	0	1
346	118	22	1	100	10	0	3
351	119	65	3	90	9	0	2
3266	1110	48	2	120	12	0	1
3265	1110	66	1	60	6	0	3
3268	1111	55	1	250	25	0	1
3270	1111	36	3	150	15	0	3
3273	1112	80	3	130	13	0	1
3271	1112	70	1	90	9	0	2
3275	1113	15	2	140	14	0	1
3276	1113	73	3	120	12	0	2
3274	1113	42	1	100	10	0	3
3278	1114	60	2	210	21	0	2
3279	1114	20	3	100	10	0	3
3281	1115	14	2	180	18	0	1
3280	1115	30	1	140	14	0	2
3283	1116	70	1	170	17	0	1
3285	1116	55	3	170	17	0	2
3284	1116	80	2	150	15	0	3
3286	1117	19	1	200	20	0	1
3291	1118	76	3	230	23	0	1
3290	1118	61	2	220	22	0	2
3289	1118	36	1	130	13	0	3
3294	1119	43	3	220	22	0	1
3293	1119	73	2	90	9	0	3
3296	1120	30	2	110	11	0	1
3295	1120	35	1	100	10	0	2
3298	1121	42	1	180	18	0	1
3299	1121	20	2	110	11	0	2
3300	1121	66	3	110	11	0	3
3301	1122	20	1	180	18	0	1
3303	1122	70	3	110	11	0	2
3306	1123	36	3	210	21	0	1
3305	1123	76	2	160	16	0	2
3308	1124	43	2	290	29	0	1
3309	1124	55	3	100	10	0	2
3310	1125	80	1	150	15	0	2
3311	1125	49	2	130	13	0	3
3313	1126	48	1	200	20	0	1
3314	1126	61	2	150	15	0	2
3315	1126	73	3	80	8	0	3
3316	1127	14	1	230	23	0	1
3318	1127	35	3	210	21	0	2
3319	1128	30	1	200	20	0	1
3321	1128	35	3	190	19	0	2
3320	1128	24	2	50	5	0	3
3324	1129	43	3	270	27	0	1
3323	1129	15	2	200	20	0	2
3326	1130	66	2	180	18	0	2
3328	1131	61	1	150	15	0	1
3329	1131	24	2	140	14	0	2
3330	1131	76	3	110	11	0	3
3331	1132	30	1	160	16	0	2
3333	1132	73	3	150	15	0	3
3336	1133	80	3	210	21	0	1
3335	1133	20	2	200	20	0	2
3334	1133	70	1	130	13	0	3
3339	1134	14	3	150	15	0	1
3338	1134	48	2	60	6	0	3
3340	1135	55	1	260	26	0	1
361	124	76	1	70	7	0	3
366	125	14	3	180	18	0	2
376	129	19	1	150	15	0	2
381	130	60	3	190	19	0	2
386	132	36	2	140	14	0	2
391	134	73	1	110	11	0	2
396	135	35	3	160	16	0	3
401	137	49	2	70	7	0	2
406	139	14	1	150	15	0	2
411	140	15	3	80	8	0	2
416	142	70	2	150	15	0	3
421	144	42	1	140	14	0	1
426	145	48	3	180	18	0	2
431	147	60	2	70	7	0	3
436	149	55	1	120	12	0	2
441	150	61	3	100	10	0	3
451	154	24	1	140	14	0	3
456	155	36	3	180	18	0	2
467	159	70	2	100	10	0	3
460	157	48	1	110	11	0	3
473	161	66	2	170	17	0	1
472	161	14	1	120	12	0	2
478	163	43	1	170	17	0	1
483	164	1	3	200	20	0	1
488	166	67	2	90	9	0	3
493	168	5	1	170	17	0	2
498	169	56	3	110	11	0	2
503	171	7	2	90	9	0	3
508	173	6	1	150	15	0	3
513	174	44	3	10	1	0	3
523	178	62	1	190	19	0	1
528	179	4	3	180	18	0	1
533	181	26	2	70	7	0	3
538	183	67	1	150	15	0	1
543	184	62	3	120	12	0	2
548	186	31	2	80	8	0	3
553	188	6	1	120	12	0	2
558	189	44	3	160	16	0	1
563	191	78	2	140	14	0	1
568	193	56	1	150	15	0	2
573	194	21	3	130	13	0	2
578	196	5	2	160	16	0	2
583	198	44	1	170	17	0	1
588	199	2	3	220	22	0	2
598	203	56	1	230	23	0	1
603	204	51	3	140	14	0	2
608	206	45	2	60	6	0	3
613	208	4	1	60	6	0	3
618	209	77	3	230	23	0	1
623	211	68	2	260	26	0	1
629	213	50	2	270	27	0	1
630	213	45	3	150	15	0	2
628	213	38	1	60	6	0	3
635	215	26	2	190	19	0	2
640	217	4	1	190	19	0	1
645	218	67	3	130	13	0	3
650	220	68	2	110	11	0	2
655	224	29	1	170	17	0	2
665	227	34	2	60	6	0	3
670	229	39	1	100	10	0	3
675	230	57	3	90	9	0	2
680	232	28	2	100	10	0	3
685	234	9	1	50	5	0	3
690	235	33	3	90	9	0	3
695	237	27	2	160	16	0	2
700	239	52	1	230	23	0	1
705	240	11	3	330	33	0	1
710	242	79	2	140	14	0	2
715	244	22	1	150	15	0	2
720	245	12	3	90	9	0	3
725	247	65	2	220	22	0	1
730	249	22	1	80	8	0	3
740	252	47	2	160	16	0	2
745	254	57	1	60	6	0	3
750	255	52	3	170	17	0	2
755	257	27	2	100	10	0	2
760	259	54	1	170	17	0	2
765	260	72	3	120	12	0	2
770	262	10	2	150	15	0	2
775	264	28	1	50	5	0	2
780	265	53	3	140	14	0	2
786	267	72	3	210	21	0	1
785	267	41	2	150	15	0	2
787	268	12	1	150	15	0	2
792	269	27	3	150	15	0	1
797	271	18	2	230	23	0	2
807	274	58	3	170	17	0	2
812	276	54	2	120	12	0	2
817	278	69	1	90	9	0	3
822	279	28	3	180	18	0	1
827	281	63	2	210	21	0	1
832	283	39	1	130	13	0	2
837	284	11	3	150	15	0	1
842	287	48	2	140	14	0	3
847	289	36	1	190	19	0	2
852	290	35	3	140	14	0	1
857	292	61	2	150	15	0	3
862	294	61	1	250	25	0	2
867	295	76	3	140	14	0	3
872	297	48	2	160	16	0	2
882	300	73	3	140	14	0	2
887	302	55	2	140	14	0	1
892	304	35	1	180	18	0	2
897	305	43	3	210	21	0	1
902	307	30	2	80	8	0	3
907	309	36	1	140	14	0	3
912	310	35	3	90	9	0	3
917	312	48	2	250	25	0	1
922	314	24	1	110	11	0	2
927	315	15	3	150	15	0	3
932	317	61	2	150	15	0	3
3341	1135	42	2	110	11	0	3
3345	1136	61	3	240	24	0	1
3343	1136	49	1	80	8	0	2
3346	1137	76	1	150	15	0	2
3348	1137	14	3	130	13	0	3
3350	1138	20	2	190	19	0	1
3351	1138	73	3	140	14	0	2
3349	1138	24	1	40	4	0	3
3354	1139	43	3	230	23	0	1
3353	1139	80	2	100	10	0	3
3355	1140	36	1	180	18	0	1
3356	1140	35	2	170	17	0	2
3358	1141	55	1	120	12	0	1
3359	1141	70	2	100	10	0	2
3360	1141	19	3	100	10	0	3
942	320	60	3	200	20	0	2
944	321	15	2	90	9	0	2
949	323	36	1	120	12	0	2
954	324	43	3	250	25	0	1
959	326	48	2	170	17	0	2
964	328	4	1	90	9	0	3
969	329	62	3	230	23	0	1
974	331	37	2	100	10	0	2
979	333	6	1	270	27	0	2
984	334	56	3	110	11	0	3
989	336	1	2	170	17	0	2
994	338	74	1	160	16	0	2
999	339	50	3	120	12	0	3
1004	341	5	2	110	11	0	3
1009	343	6	1	200	20	0	1
1014	344	25	3	160	16	0	2
1024	348	78	1	240	24	0	1
1029	349	6	3	240	24	0	1
1034	351	71	2	90	9	0	3
1039	353	38	1	140	14	0	2
1044	354	25	3	180	18	0	2
1049	356	78	2	30	3	0	3
1054	358	32	1	130	13	0	2
1059	359	5	3	140	14	0	3
1064	361	46	2	180	18	0	2
1069	363	4	1	70	7	0	3
1074	364	37	3	90	9	0	2
1079	366	68	2	140	14	0	3
1084	368	62	1	180	18	0	3
1089	369	32	3	110	11	0	3
1101	373	3	3	200	20	0	1
1099	373	26	1	100	10	0	2
1100	373	37	2	70	7	0	3
1106	375	31	2	190	19	0	3
1111	377	77	1	120	12	0	3
1116	378	51	3	130	13	0	2
1121	380	44	2	100	10	0	3
1126	382	21	1	120	12	0	3
1131	383	74	3	150	15	0	3
1136	387	79	2	180	18	0	1
1141	389	75	1	110	11	0	2
1146	390	13	3	110	11	0	3
1151	392	65	2	240	24	0	1
1156	394	22	1	110	11	0	2
1166	397	63	2	240	24	0	1
1171	399	58	1	120	12	0	3
1176	400	47	3	120	12	0	1
1181	402	10	2	100	10	0	2
1186	404	72	1	140	14	0	3
1191	405	27	3	90	9	0	2
1196	407	39	2	100	10	0	3
1201	409	10	1	70	7	0	3
1206	410	75	3	90	9	0	2
1211	412	58	2	140	14	0	2
1216	414	34	1	80	8	0	3
1221	415	33	3	130	13	0	2
1226	417	54	2	170	17	0	1
1231	419	10	1	80	8	0	3
1241	422	59	2	80	8	0	2
1246	424	54	1	90	9	0	1
1251	425	34	3	180	18	0	1
1257	427	33	3	130	13	0	1
1256	427	39	2	120	12	0	2
1258	428	69	1	80	8	0	3
1263	429	28	3	160	16	0	2
1268	431	59	2	190	19	0	1
1273	433	65	1	40	4	0	3
1278	434	34	3	60	6	0	2
1283	436	72	2	110	11	0	1
1288	438	23	1	80	8	0	3
1293	439	58	3	90	9	0	2
1298	441	13	2	170	17	0	2
1308	444	29	3	170	17	0	1
1313	446	28	2	200	20	0	1
1318	448	23	1	120	12	0	2
1323	450	24	3	150	15	0	2
1328	452	70	2	190	19	0	1
1333	454	30	1	60	6	0	3
1338	455	66	3	140	14	0	2
1343	457	35	2	180	18	0	1
1348	459	80	1	90	9	0	3
1353	460	15	3	130	13	0	3
1358	462	14	2	140	14	0	3
1363	464	61	1	190	19	0	1
1368	465	30	3	140	14	0	2
1373	467	19	2	150	15	0	2
1383	470	73	3	80	8	0	3
1388	472	36	2	140	14	0	1
1393	474	20	1	150	15	0	3
1398	475	76	3	130	13	0	3
1403	477	73	2	120	12	0	2
1408	479	80	1	110	11	0	2
1413	480	24	3	160	16	0	1
1415	481	36	2	120	12	0	2
1414	481	35	1	70	7	0	3
1420	483	43	1	130	13	0	2
1425	484	24	3	80	8	0	3
1430	486	43	2	130	13	0	3
1435	488	14	1	120	12	0	3
1440	489	30	3	240	24	0	1
1450	493	71	1	160	16	0	1
1455	494	25	3	150	15	0	3
1460	496	7	2	130	13	0	1
1465	498	31	1	150	15	0	1
1470	499	4	3	240	24	0	1
1475	501	38	2	220	22	0	1
1480	503	16	1	230	23	0	1
1485	504	56	3	120	12	0	3
1490	506	5	2	150	15	0	2
1495	508	74	1	90	9	0	3
1500	509	6	3	100	10	0	3
1505	511	77	2	190	19	0	1
1510	513	37	1	130	13	0	3
1515	514	3	3	180	18	0	2
1525	518	62	1	60	6	0	3
1530	519	25	3	130	13	0	3
1535	521	7	2	70	7	0	3
1540	523	44	1	160	16	0	2
1545	524	68	3	160	16	0	2
1550	526	31	2	210	21	0	2
1555	528	77	1	250	25	0	1
1560	529	62	3	290	29	0	1
1565	531	67	2	160	16	0	1
1571	533	16	2	130	13	0	1
1572	533	71	3	100	10	0	2
1570	533	26	1	90	9	0	3
1582	537	74	1	250	25	0	1
1587	538	37	3	110	11	0	3
1597	542	50	1	100	10	0	3
1602	543	25	3	270	27	0	2
1607	545	38	2	120	12	0	3
1612	547	62	1	120	12	0	2
1617	550	47	3	110	11	0	3
1622	552	29	2	210	21	0	1
1627	554	59	1	100	10	0	3
1632	555	53	3	40	4	0	3
1637	557	33	2	120	12	0	3
1642	559	79	1	130	13	0	2
1647	560	9	3	100	10	0	3
1652	562	29	2	200	20	0	1
1657	564	64	1	150	15	0	2
1662	565	12	3	180	18	0	1
1672	569	11	1	50	5	0	3
1677	570	72	3	110	11	0	2
1682	572	79	2	110	11	0	2
1687	574	64	1	260	26	0	1
1692	575	52	3	190	19	0	1
1697	577	10	2	100	10	0	3
1702	579	33	1	80	8	0	3
1707	580	39	3	180	18	0	2
1712	582	17	2	180	18	0	1
1717	584	63	1	110	11	0	2
1722	585	47	3	130	13	0	2
1727	587	75	2	110	11	0	2
1728	587	10	3	70	7	0	3
1729	588	27	1	110	11	0	2
1739	591	75	2	20	2	0	3
1744	593	18	1	200	20	0	1
1749	594	9	3	120	12	0	2
1754	596	64	2	160	16	0	1
1759	598	17	1	130	13	0	1
1764	599	47	3	70	7	0	3
1769	601	40	2	90	9	0	3
1774	603	29	1	110	11	0	2
1779	604	22	3	70	7	0	3
1784	606	17	2	80	8	0	3
1789	608	65	1	140	14	0	1
1794	609	79	3	210	21	0	1
1799	611	47	2	140	14	0	3
1804	614	42	1	240	24	0	1
1814	617	60	2	220	22	0	1
1819	619	43	1	140	14	0	2
1824	620	80	3	230	23	0	1
1829	622	70	2	220	22	0	1
1834	624	35	1	110	11	0	2
1839	625	66	3	110	11	0	2
1844	627	61	2	140	14	0	2
1849	629	70	1	90	9	0	3
1854	630	49	3	210	21	0	2
1859	632	30	2	130	13	0	3
1864	634	70	1	120	12	0	2
1869	635	20	3	240	24	0	1
1874	637	35	2	170	17	0	2
1885	641	19	1	240	24	0	1
1886	641	80	2	130	13	0	2
1891	643	15	1	90	9	0	2
1896	644	60	3	180	18	0	3
1901	646	48	2	170	17	0	2
1906	648	35	1	130	13	0	2
1911	649	19	3	130	13	0	2
1916	651	73	2	220	22	0	1
1921	653	67	1	200	20	0	2
1926	654	46	3	120	12	0	3
1931	656	62	2	150	15	0	2
1936	658	8	1	210	21	0	2
1941	659	3	3	90	9	0	3
1946	661	25	2	80	8	0	3
1951	663	38	1	240	24	0	1
1961	666	8	2	80	8	0	2
1966	668	3	1	70	7	0	3
1971	669	16	3	230	23	0	2
1976	671	50	2	190	19	0	1
1981	673	32	1	320	32	0	1
1986	674	50	3	110	11	0	3
1991	676	37	2	110	11	0	3
1996	678	67	1	60	6	0	3
2001	679	7	3	160	16	0	1
2006	681	45	2	130	13	0	2
2011	683	68	1	120	12	0	3
2016	684	38	3	150	15	0	2
2021	686	77	2	220	22	0	1
2026	688	2	1	150	15	0	3
2043	693	3	3	210	21	0	2
2036	691	50	2	80	8	0	3
2042	693	71	2	190	19	0	3
2048	695	51	2	190	19	0	2
2053	697	1	1	130	13	0	3
2058	698	7	3	140	14	0	2
2063	700	68	2	40	4	0	3
2068	702	50	1	90	9	0	3
2073	703	21	3	210	21	0	1
2078	705	25	2	120	12	0	2
2083	707	3	1	190	19	0	1
2088	708	37	3	160	16	0	1
2093	710	2	2	170	17	0	3
2098	714	54	1	190	19	0	2
2108	717	47	2	100	10	0	2
2113	719	33	1	90	9	0	3
2118	720	59	3	170	17	0	1
2123	722	17	2	140	14	0	1
2128	724	72	1	110	11	0	2
2133	725	75	3	100	10	0	2
2138	727	29	2	230	23	0	1
2143	729	17	1	0	0	0	3
2148	730	18	3	270	27	0	1
2153	732	52	2	90	9	0	3
2158	734	22	1	50	5	0	3
2163	735	11	3	250	25	0	2
2168	737	40	2	100	10	0	3
2173	739	33	1	90	9	0	3
2183	742	54	2	90	9	0	3
2188	744	41	1	120	12	0	3
2193	745	64	3	50	5	0	3
2199	747	65	3	220	22	0	1
2198	747	63	2	100	10	0	2
2200	748	54	1	50	5	0	3
2205	749	33	3	120	12	0	2
2210	751	29	2	50	5	0	3
2215	753	9	1	70	7	0	3
2220	754	18	3	20	2	0	3
2225	756	40	2	100	10	0	3
2230	758	33	1	120	12	0	2
2240	761	53	2	40	4	0	3
2245	763	34	1	80	8	0	2
2255	766	33	2	150	15	0	1
2260	768	59	1	220	22	0	1
2265	769	22	3	70	7	0	3
2270	771	34	2	60	6	0	2
2275	773	17	1	140	14	0	1
2280	774	63	3	190	19	0	1
2285	777	49	2	110	11	0	3
2290	779	30	1	70	7	0	3
2295	780	80	3	90	9	0	3
2300	782	35	2	120	12	0	3
2305	784	35	1	120	12	0	3
2310	785	36	3	60	6	0	2
2315	787	43	2	130	13	0	3
2320	789	60	1	60	6	0	2
2330	792	42	2	260	26	0	1
2335	794	80	1	240	24	0	1
2340	795	35	3	170	17	0	1
2345	797	30	2	60	6	0	3
2350	799	61	1	150	15	0	3
2355	800	24	3	190	19	0	2
2356	801	48	1	130	13	0	1
2357	801	60	2	80	8	0	2
2363	803	20	2	60	6	0	3
2368	805	61	1	150	15	0	2
2373	806	60	3	210	21	0	1
2378	808	76	2	230	23	0	1
2383	810	70	1	170	17	0	1
2388	811	60	3	180	18	0	2
2398	815	49	1	50	5	0	3
2403	816	44	3	210	21	0	1
2408	818	5	2	120	12	0	1
2413	820	51	1	90	9	0	2
2418	821	21	3	90	9	0	2
2423	823	74	2	90	9	0	3
2428	825	7	1	60	6	0	3
2433	826	31	3	140	14	0	1
2438	828	50	2	310	31	0	1
2443	830	45	1	110	11	0	3
2448	831	1	3	40	4	0	3
2453	833	67	2	150	15	0	2
2458	835	5	1	80	8	0	3
2463	836	71	3	100	10	0	3
2473	840	44	1	130	13	0	1
2478	841	16	3	200	20	0	1
2483	843	74	2	280	28	0	1
2488	845	25	1	140	14	0	3
2493	846	21	3	240	24	0	1
2498	848	2	2	250	25	0	2
2503	850	62	1	110	11	0	3
2508	851	68	3	120	12	0	2
2513	853	46	2	210	21	0	1
2514	853	32	3	90	9	0	3
2519	855	50	2	180	18	0	1
2524	857	44	1	60	6	0	3
2529	858	62	3	220	22	0	1
2534	860	37	2	90	9	0	3
2544	863	3	3	150	15	0	3
2549	865	1	2	140	14	0	3
2554	867	5	1	90	9	0	1
2559	868	26	3	150	15	0	3
2564	870	4	2	60	6	0	3
2569	872	71	1	160	16	0	2
2574	873	16	3	220	22	0	1
2579	877	28	2	60	6	0	3
2584	879	12	1	70	7	0	3
2589	880	27	3	90	9	0	3
2594	882	79	2	130	13	0	2
2599	884	58	1	70	7	0	2
2604	885	34	3	0	0	0	3
2609	887	11	2	110	11	0	2
2619	890	17	3	60	6	0	3
2624	892	39	2	100	10	0	2
2629	894	53	1	60	6	0	3
2634	895	9	3	100	10	0	3
2637	896	69	3	160	16	0	3
2644	899	39	1	140	14	0	2
2649	900	41	3	120	12	0	2
2654	902	64	2	240	24	0	1
2659	904	57	1	160	16	0	2
2664	905	10	3	140	14	0	1
2670	907	63	3	150	15	0	2
2669	907	65	2	130	13	0	3
2671	908	22	1	100	10	0	3
2676	909	9	3	80	8	0	3
2686	913	47	1	60	6	0	3
2691	914	12	3	110	11	0	2
2696	916	33	2	150	15	0	2
2701	918	53	1	60	6	0	3
2706	919	27	3	130	13	0	2
2711	921	34	2	130	13	0	3
2716	923	22	1	110	11	0	2
2721	924	58	3	50	5	0	3
2726	926	57	2	130	13	0	2
2731	928	9	1	40	4	0	3
2736	929	58	3	140	14	0	3
2741	931	53	2	120	12	0	2
2746	933	23	1	140	14	0	2
2751	934	79	3	110	11	0	2
2761	939	35	1	130	13	0	3
2766	940	19	3	230	23	0	1
2771	942	36	2	110	11	0	2
2776	944	42	1	210	21	0	1
2781	945	15	3	140	14	0	2
2786	947	66	2	170	17	0	1
2791	949	36	1	80	8	0	3
2796	950	73	3	70	7	0	3
2801	952	15	2	120	12	0	2
2806	954	49	1	160	16	0	2
2811	955	30	3	160	16	0	2
2816	957	70	2	120	12	0	3
2821	959	24	1	80	8	0	3
2826	960	76	3	240	24	0	1
2828	961	48	2	130	13	0	2
2833	963	43	1	230	23	0	1
2838	964	42	3	130	13	0	2
2843	966	43	2	20	2	0	3
2848	968	14	1	40	4	0	3
2853	969	35	3	120	12	0	1
2858	971	48	2	110	11	0	1
2863	973	49	1	170	17	0	2
2868	974	43	3	180	18	0	2
2873	976	76	2	130	13	0	3
2878	978	14	1	180	18	0	1
2883	979	4	3	90	9	0	3
3	1	8	3	250	25	0	1
1	1	77	1	140	14	0	2
6	2	37	3	60	6	0	3
12	4	3	3	180	18	0	2
26	9	51	2	200	20	0	1
45	15	51	3	120	12	0	2
61	21	56	1	130	13	0	3
81	27	44	3	140	14	0	3
87	29	46	3	100	10	0	3
100	34	4	1	190	19	0	1
120	40	68	3	240	24	0	2
138	46	74	3	80	8	0	3
154	52	31	1	80	8	0	3
159	53	67	3	130	13	0	2
175	61	64	1	180	18	0	1
182	63	39	2	160	16	0	1
201	69	54	3	190	19	0	1
217	75	27	1	20	2	0	3
229	79	12	1	80	8	0	3
235	81	79	1	100	10	0	3
257	88	64	2	140	14	0	1
275	94	29	2	210	21	0	2
292	100	10	1	130	13	0	3
304	104	17	1	120	12	0	2
311	106	64	2	150	15	0	3
333	113	11	3	60	6	0	3
345	117	9	3	100	10	0	2
349	119	72	1	150	15	0	1
356	121	59	2	110	11	0	3
368	126	80	2	190	19	0	2
371	127	42	2	200	20	0	2
387	132	19	3	130	13	0	3
404	138	55	2	120	12	0	3
424	145	20	1	240	24	0	1
444	151	76	3	120	12	0	2
446	152	30	2	210	21	0	1
463	158	30	1	220	22	0	1
481	164	51	1	110	11	0	3
501	170	3	3	150	15	0	3
517	176	45	1	200	20	0	1
2893	983	62	1	180	18	0	2
2898	984	74	3	270	27	0	1
2908	988	31	1	160	16	0	3
2913	989	4	3	90	9	0	3
2918	991	25	2	190	19	0	1
2923	993	1	1	60	6	0	3
2928	994	68	3	170	17	0	2
2933	996	32	2	140	14	0	2
2944	1000	71	1	260	26	0	1
2938	998	45	1	70	7	0	3
2949	1001	37	3	-10	-1	0	3
2954	1003	16	2	330	33	0	1
2959	1005	7	1	70	7	0	3
2964	1006	38	3	100	10	0	3
2969	1008	2	2	190	19	0	3
2974	1010	56	1	70	7	0	3
2985	1013	50	3	110	11	0	2
2984	1013	62	2	80	8	0	3
2990	1015	45	2	110	11	0	2
2995	1017	46	1	120	12	0	3
3000	1018	2	3	170	17	0	1
3005	1020	56	2	240	24	0	1
3010	1022	31	1	160	16	0	3
3015	1023	7	3	20	2	0	3
3020	1025	25	2	200	20	0	1
3025	1027	4	1	180	18	0	2
3030	1028	37	3	60	6	0	3
3035	1030	46	2	150	15	0	3
3040	1032	68	1	240	24	0	1
3045	1033	6	3	50	5	0	3
3055	1039	33	1	210	21	0	1
3060	1040	40	3	30	3	0	3
3065	1042	54	2	100	10	0	3
3070	1044	11	1	110	11	0	2
3075	1045	27	3	90	9	0	3
3080	1047	41	2	80	8	0	2
3091	1051	65	1	100	10	0	3
3085	1049	12	1	130	13	0	3
3096	1052	63	3	120	12	0	2
3101	1054	9	2	90	9	0	2
3106	1056	34	1	110	11	0	2
3111	1057	54	3	100	10	0	2
3127	1063	33	1	70	7	0	3
3116	1059	79	2	170	17	0	2
3132	1064	11	3	170	17	0	1
3137	1066	54	2	70	7	0	2
3141	1067	41	3	60	6	0	2
3142	1068	9	1	30	3	0	3
3147	1069	29	3	140	14	0	2
3152	1071	64	2	150	15	0	1
3157	1073	69	1	120	12	0	2
3162	1074	12	3	150	15	0	2
3167	1076	27	2	170	17	0	1
3172	1078	22	1	150	15	0	1
3177	1079	39	3	240	24	0	1
3182	1081	63	2	130	13	0	2
3187	1083	9	1	80	8	0	3
3192	1084	79	3	100	10	0	3
3202	1088	59	1	200	20	0	2
3207	1089	69	3	90	9	0	3
3212	1091	12	2	90	9	0	3
3217	1093	75	1	90	9	0	3
3222	1094	11	3	150	15	0	2
3227	1096	63	2	120	12	0	3
3232	1098	22	1	50	5	0	3
3237	1099	79	3	160	16	0	2
3242	1102	14	2	220	22	0	1
3247	1104	19	1	180	18	0	1
3252	1105	73	3	110	11	0	2
3257	1107	80	2	180	18	0	1
3262	1109	14	1	150	15	0	2
3267	1110	19	3	120	12	0	2
3277	1114	61	1	250	25	0	1
3282	1115	24	3	80	8	0	3
3287	1117	49	2	100	10	0	3
3292	1119	60	1	200	20	0	2
3297	1120	48	3	80	8	0	3
3302	1122	42	2	30	3	0	3
3307	1124	15	1	70	7	0	3
3312	1125	19	3	160	16	0	1
3317	1127	66	2	170	17	0	3
3322	1129	42	1	160	16	0	3
3327	1130	36	3	120	12	0	3
3332	1132	60	2	190	19	0	1
3337	1134	49	1	80	8	0	2
3342	1135	60	3	160	16	0	2
3352	1139	66	1	120	12	0	2
3357	1140	15	3	110	11	0	3
518	176	6	2	70	7	0	3
522	177	5	3	170	17	0	2
540	183	38	3	80	8	0	3
560	190	21	2	190	19	0	1
577	196	46	1	170	17	0	1
593	201	51	2	30	3	0	3
595	202	8	1	110	11	0	2
615	208	37	3	160	16	0	2
634	215	16	1	120	12	0	3
653	221	74	2	130	13	0	3
660	225	33	3	210	21	0	1
673	230	22	1	150	15	0	1
689	235	65	2	260	26	0	1
691	236	40	1	90	9	0	3
713	243	28	2	190	19	0	1
732	249	10	3	130	13	0	1
735	250	17	3	30	3	0	3
749	255	41	2	110	11	0	3
768	261	53	3	110	11	0	3
789	268	75	3	90	9	0	3
802	273	79	1	150	15	0	1
808	275	10	1	100	10	0	1
826	281	18	1	130	13	0	2
844	288	24	1	190	19	0	2
861	293	80	3	140	14	0	2
866	295	30	2	180	18	0	1
877	299	73	1	140	14	0	2
883	301	30	1	160	16	0	2
903	307	20	3	90	9	0	2
919	313	55	1	60	6	0	3
937	319	48	1	200	20	0	1
940	320	76	1	210	21	0	1
943	321	70	1	40	4	0	3
961	327	67	1	190	19	0	1
980	333	3	2	270	27	0	1
998	339	37	2	170	17	0	2
1016	345	26	2	70	7	0	3
1019	346	50	2	110	11	0	3
1033	351	68	1	110	11	0	1
1037	352	26	2	80	8	0	2
1056	358	68	3	120	12	0	3
1077	365	50	3	110	11	0	1
1094	371	56	2	180	18	0	1
1095	371	2	3	160	16	0	2
1115	378	37	2	140	14	0	1
1134	384	38	3	210	21	0	2
1152	392	10	3	120	12	0	3
1161	395	29	3	80	8	0	3
1170	398	40	3	100	10	0	3
1189	405	69	1	100	10	0	1
1205	410	29	2	90	9	0	1
1208	411	41	2	80	8	0	3
1228	418	40	1	130	13	0	1
1236	420	57	3	170	17	0	2
1247	424	75	2	80	8	0	2
1267	431	13	1	130	13	0	2
1286	437	29	2	130	13	0	2
1303	443	57	1	200	20	0	1
1304	443	40	2	80	8	0	3
1325	451	61	2	230	23	0	1
1344	457	61	3	160	16	0	2
1361	463	76	2	70	7	0	2
1377	468	60	3	190	19	0	1
1378	469	70	1	100	10	0	3
1381	470	19	1	240	24	0	1
1399	476	61	1	140	14	0	2
1421	483	66	2	230	23	0	1
1438	489	80	1	140	14	0	3
1445	491	62	2	110	11	0	2
1457	495	4	2	80	8	0	3
1479	502	6	3	260	26	0	1
1497	508	67	3	220	22	0	1
1513	514	50	1	140	14	0	3
1520	516	2	2	120	12	0	3
1533	520	78	3	120	12	0	3
1549	526	74	1	290	29	0	1
1554	527	5	3	140	14	0	2
1575	534	5	3	180	18	0	2
1577	535	50	2	90	9	0	3
1592	540	56	2	140	14	0	2
1591	540	74	1	120	12	0	3
1610	546	4	2	110	11	0	3
1631	555	34	2	110	11	0	1
1650	561	69	3	150	15	0	2
1667	567	59	2	90	9	0	2
1666	567	10	1	80	8	0	3
1685	573	23	2	100	10	0	3
1706	580	22	2	190	19	0	1
1721	585	40	2	80	8	0	3
1733	589	11	2	160	16	0	1
1734	589	58	3	70	7	0	3
1751	595	54	2	130	13	0	2
1770	601	12	3	100	10	0	2
1786	607	39	1	60	6	0	3
1807	615	30	1	190	19	0	1
1809	615	35	3	190	19	0	2
1827	621	19	3	140	14	0	2
1845	627	73	3	50	5	0	3
1863	633	48	3	100	10	0	3
1879	639	14	1	120	12	0	2
1884	640	73	3	80	8	0	2
1893	643	42	3	80	8	0	3
1898	645	70	2	150	15	0	1
1915	651	70	1	150	15	0	2
1933	657	37	1	80	8	0	2
1952	663	32	2	160	16	0	3
1956	664	67	3	120	12	0	2
1973	670	74	2	300	30	0	1
1990	676	21	1	230	23	0	1
2010	682	67	3	140	14	0	2
2027	688	31	2	150	15	0	2
2031	689	78	3	140	14	0	2
2047	695	67	1	100	10	0	3
2066	701	46	2	240	24	0	1
2070	702	74	3	130	13	0	1
2086	708	71	1	50	5	0	3
2103	715	64	3	80	8	0	3
2106	716	63	3	130	13	0	3
2127	723	54	3	230	23	0	1
2144	729	22	2	200	20	0	1
2162	735	75	2	110	11	0	3
2178	740	57	3	190	19	0	1
2181	741	23	3	40	4	0	3
2202	748	69	3	110	11	0	2
2222	755	58	2	190	19	0	1
2235	759	72	3	170	17	0	1
2237	760	39	2	270	27	0	1
2243	762	22	2	70	7	0	2
2250	764	10	3	80	8	0	3
2262	768	12	3	50	5	0	3
2283	776	60	3	110	11	0	1
2301	782	30	3	210	21	0	1
2318	788	61	2	170	17	0	2
2325	790	15	3	160	16	0	2
2337	794	60	3	70	7	0	3
2358	801	35	3	50	5	0	3
2379	808	14	3	170	17	0	2
2393	813	42	2	220	22	0	1
2397	814	66	3	140	14	0	2
2409	818	1	3	90	9	0	3
2411	819	56	2	160	16	0	3
2432	826	62	2	40	4	0	2
2450	832	25	2	160	16	0	2
2468	838	68	2	160	16	0	2
2469	838	45	3	60	6	0	3
2486	844	4	2	50	5	0	3
2507	851	4	2	140	14	0	1
2525	857	67	2	130	13	0	2
2539	862	71	1	130	13	0	2
2546	864	51	2	170	17	0	1
2563	870	2	1	200	20	0	1
2580	877	65	3	170	17	0	1
2581	878	40	1	20	2	0	3
2602	885	69	1	140	14	0	1
2614	889	75	1	70	7	0	3
2620	891	63	1	100	10	0	2
2639	897	12	2	130	13	0	3
2656	903	9	1	60	6	0	3
2679	910	41	3	70	7	0	3
2681	911	39	2	200	20	0	1
2698	917	53	1	120	12	0	1
2718	923	59	3	110	11	0	1
2735	929	11	2	190	19	0	2
2752	935	34	1	120	12	0	1
2756	936	65	2	270	27	0	1
2758	937	59	1	170	17	0	1
2777	944	61	2	150	15	0	2
2794	950	30	1	90	9	0	2
2813	956	14	2	120	12	0	3
2827	961	49	1	170	17	0	1
2835	963	70	3	130	13	0	3
2856	970	19	3	250	25	0	1
2872	976	73	1	140	14	0	1
2888	981	8	2	200	20	0	1
2892	982	6	3	70	7	0	2
2903	986	51	2	140	14	0	2
2909	988	78	2	160	16	0	2
2922	992	21	3	260	26	0	1
2931	995	2	3	70	7	0	3
2952	1002	3	3	160	16	0	2
2968	1008	71	1	190	19	0	2
2979	1011	26	3	150	15	0	2
2989	1015	44	1	110	11	0	1
3007	1021	1	1	180	18	0	2
3026	1027	25	2	170	17	0	3
3048	1034	2	3	180	18	0	1
3050	1035	51	2	180	18	0	3
3066	1042	64	3	130	13	0	1
3084	1048	52	3	110	11	0	2
3093	1051	29	3	130	13	0	2
3099	1053	64	3	170	17	0	1
3115	1059	39	1	70	7	0	3
3122	1061	59	2	140	14	0	1
3135	1065	39	3	80	8	0	3
3155	1072	72	2	50	5	0	2
3173	1078	41	2	80	8	0	3
3195	1085	28	3	240	24	0	1
3197	1086	40	2	80	8	0	3
3213	1091	28	3	190	19	0	1
3230	1097	58	2	160	16	0	2
3248	1104	36	2	40	4	0	3
3269	1111	76	2	190	19	0	2
3272	1112	35	2	80	8	0	3
3288	1117	15	3	140	14	0	2
3304	1123	60	1	120	12	0	3
3325	1130	19	1	180	18	0	1
3344	1136	30	2	80	8	0	3
3347	1137	48	2	160	16	0	1
461	157	48	2	170	17	0	1
\.


--
-- Name: quiz_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('quiz_teams_id_seq', 3360, true);


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY quizzes (id, division_id, event_id, room_num, round_num, active, category_id) FROM stdin;
1	1	1	1	1	t	1
2	1	1	2	1	t	1
3	1	1	3	1	t	1
4	1	1	4	1	t	1
5	1	1	5	1	t	1
6	1	1	1	2	t	1
7	1	1	2	2	t	1
8	1	1	3	2	t	1
9	1	1	4	2	t	1
10	1	1	5	2	t	1
11	1	1	1	3	t	1
12	1	1	2	3	t	1
13	1	1	3	3	t	1
14	1	1	4	3	t	1
15	1	1	5	3	t	1
16	1	1	1	4	t	1
17	1	1	2	4	t	1
18	1	1	3	4	t	1
19	1	1	4	4	t	1
20	1	1	5	4	t	1
21	1	1	1	5	t	1
22	1	1	2	5	t	1
23	1	1	3	5	t	1
24	1	1	4	5	t	1
25	1	1	5	5	t	1
26	1	1	1	6	t	1
27	1	1	2	6	t	1
28	1	1	3	6	t	1
29	1	1	4	6	t	1
30	1	1	5	6	t	1
31	1	1	1	7	t	1
32	1	1	2	7	t	1
33	1	1	3	7	t	1
34	1	1	4	7	t	1
35	1	1	5	7	t	1
36	1	1	1	8	t	1
37	1	1	2	8	t	1
38	1	1	3	8	t	1
39	1	1	4	8	t	1
40	1	1	5	8	t	1
41	1	1	1	9	t	1
42	1	1	2	9	t	1
43	1	1	3	9	t	1
44	1	1	4	9	t	1
45	1	1	5	9	t	1
46	1	1	1	10	t	1
47	1	1	2	10	t	1
48	1	1	3	10	t	1
49	1	1	4	10	t	1
50	1	1	5	10	t	1
51	1	1	1	11	t	1
52	1	1	2	11	t	1
53	1	1	3	11	t	1
54	1	1	4	11	t	1
55	1	1	5	11	t	1
56	1	1	1	12	t	1
57	1	1	2	12	t	1
58	1	1	3	12	t	1
61	2	1	1	1	t	1
62	2	1	2	1	t	1
63	2	1	3	1	t	1
64	2	1	4	1	t	1
65	2	1	5	1	t	1
66	2	1	6	1	t	1
67	2	1	7	1	t	1
68	2	1	1	2	t	1
69	2	1	2	2	t	1
70	2	1	3	2	t	1
71	2	1	4	2	t	1
72	2	1	5	2	t	1
73	2	1	6	2	t	1
74	2	1	7	2	t	1
75	2	1	1	3	t	1
76	2	1	2	3	t	1
77	2	1	3	3	t	1
78	2	1	4	3	t	1
79	2	1	5	3	t	1
80	2	1	6	3	t	1
81	2	1	7	3	t	1
82	2	1	1	4	t	1
83	2	1	2	4	t	1
84	2	1	3	4	t	1
85	2	1	4	4	t	1
86	2	1	5	4	t	1
87	2	1	6	4	t	1
88	2	1	7	4	t	1
89	2	1	1	5	t	1
90	2	1	2	5	t	1
91	2	1	3	5	t	1
92	2	1	4	5	t	1
93	2	1	5	5	t	1
94	2	1	6	5	t	1
95	2	1	7	5	t	1
96	2	1	1	6	t	1
97	2	1	2	6	t	1
98	2	1	3	6	t	1
99	2	1	4	6	t	1
100	2	1	5	6	t	1
101	2	1	6	6	t	1
102	2	1	7	6	t	1
103	2	1	1	7	t	1
104	2	1	2	7	t	1
105	2	1	3	7	t	1
106	2	1	4	7	t	1
107	2	1	5	7	t	1
108	2	1	6	7	t	1
109	2	1	7	7	t	1
110	2	1	1	8	t	1
111	2	1	2	8	t	1
112	2	1	3	8	t	1
113	2	1	4	8	t	1
114	2	1	5	8	t	1
115	2	1	6	8	t	1
116	2	1	7	8	t	1
117	2	1	1	9	t	1
118	2	1	2	9	t	1
119	2	1	3	9	t	1
120	2	1	4	9	t	1
121	2	1	5	9	t	1
122	2	1	6	9	t	1
124	3	1	1	1	t	1
125	3	1	2	1	t	1
126	3	1	3	1	t	1
127	3	1	4	1	t	1
128	3	1	5	1	t	1
129	3	1	1	2	t	1
130	3	1	2	2	t	1
131	3	1	3	2	t	1
132	3	1	4	2	t	1
133	3	1	5	2	t	1
134	3	1	1	3	t	1
135	3	1	2	3	t	1
136	3	1	3	3	t	1
137	3	1	4	3	t	1
138	3	1	5	3	t	1
139	3	1	1	4	t	1
140	3	1	2	4	t	1
141	3	1	3	4	t	1
142	3	1	4	4	t	1
143	3	1	5	4	t	1
144	3	1	1	5	t	1
145	3	1	2	5	t	1
146	3	1	3	5	t	1
147	3	1	4	5	t	1
148	3	1	5	5	t	1
149	3	1	1	6	t	1
150	3	1	2	6	t	1
151	3	1	3	6	t	1
152	3	1	4	6	t	1
153	3	1	5	6	t	1
154	3	1	1	7	t	1
155	3	1	2	7	t	1
156	3	1	3	7	t	1
157	3	1	4	7	t	1
158	3	1	5	7	t	1
159	3	1	1	8	t	1
160	3	1	2	8	t	1
161	3	1	3	8	t	1
162	3	1	4	8	t	1
163	3	1	5	8	t	1
164	1	2	1	1	t	1
165	1	2	2	1	t	1
166	1	2	3	1	t	1
167	1	2	4	1	t	1
168	1	2	5	1	t	1
169	1	2	1	2	t	1
170	1	2	2	2	t	1
171	1	2	3	2	t	1
172	1	2	4	2	t	1
173	1	2	5	2	t	1
174	1	2	1	3	t	1
175	1	2	2	3	t	1
176	1	2	3	3	t	1
177	1	2	4	3	t	1
178	1	2	5	3	t	1
179	1	2	1	4	t	1
180	1	2	2	4	t	1
181	1	2	3	4	t	1
182	1	2	4	4	t	1
183	1	2	5	4	t	1
184	1	2	1	5	t	1
185	1	2	2	5	t	1
186	1	2	3	5	t	1
187	1	2	4	5	t	1
188	1	2	5	5	t	1
189	1	2	1	6	t	1
190	1	2	2	6	t	1
191	1	2	3	6	t	1
192	1	2	4	6	t	1
193	1	2	5	6	t	1
194	1	2	1	7	t	1
195	1	2	2	7	t	1
196	1	2	3	7	t	1
197	1	2	4	7	t	1
198	1	2	5	7	t	1
199	1	2	1	8	t	1
200	1	2	2	8	t	1
201	1	2	3	8	t	1
202	1	2	4	8	t	1
203	1	2	5	8	t	1
204	1	2	1	9	t	1
205	1	2	2	9	t	1
206	1	2	3	9	t	1
207	1	2	4	9	t	1
208	1	2	5	9	t	1
209	1	2	1	10	t	1
210	1	2	2	10	t	1
211	1	2	3	10	t	1
212	1	2	4	10	t	1
213	1	2	5	10	t	1
214	1	2	1	11	t	1
215	1	2	2	11	t	1
216	1	2	3	11	t	1
217	1	2	4	11	t	1
218	1	2	5	11	t	1
219	1	2	1	12	t	1
220	1	2	2	12	t	1
221	1	2	3	12	t	1
224	2	2	1	1	t	1
225	2	2	2	1	t	1
226	2	2	3	1	t	1
227	2	2	4	1	t	1
228	2	2	5	1	t	1
229	2	2	6	1	t	1
230	2	2	7	1	t	1
231	2	2	1	2	t	1
232	2	2	2	2	t	1
233	2	2	3	2	t	1
234	2	2	4	2	t	1
235	2	2	5	2	t	1
236	2	2	6	2	t	1
237	2	2	7	2	t	1
238	2	2	1	3	t	1
239	2	2	2	3	t	1
240	2	2	3	3	t	1
241	2	2	4	3	t	1
242	2	2	5	3	t	1
243	2	2	6	3	t	1
244	2	2	7	3	t	1
245	2	2	1	4	t	1
246	2	2	2	4	t	1
247	2	2	3	4	t	1
248	2	2	4	4	t	1
249	2	2	5	4	t	1
250	2	2	6	4	t	1
251	2	2	7	4	t	1
252	2	2	1	5	t	1
253	2	2	2	5	t	1
254	2	2	3	5	t	1
255	2	2	4	5	t	1
256	2	2	5	5	t	1
257	2	2	6	5	t	1
258	2	2	7	5	t	1
259	2	2	1	6	t	1
260	2	2	2	6	t	1
261	2	2	3	6	t	1
262	2	2	4	6	t	1
263	2	2	5	6	t	1
264	2	2	6	6	t	1
265	2	2	7	6	t	1
266	2	2	1	7	t	1
267	2	2	2	7	t	1
268	2	2	3	7	t	1
269	2	2	4	7	t	1
270	2	2	5	7	t	1
271	2	2	6	7	t	1
272	2	2	7	7	t	1
273	2	2	1	8	t	1
274	2	2	2	8	t	1
275	2	2	3	8	t	1
276	2	2	4	8	t	1
277	2	2	5	8	t	1
278	2	2	6	8	t	1
279	2	2	7	8	t	1
280	2	2	1	9	t	1
281	2	2	2	9	t	1
282	2	2	3	9	t	1
283	2	2	4	9	t	1
284	2	2	5	9	t	1
285	2	2	6	9	t	1
287	3	2	1	1	t	1
288	3	2	2	1	t	1
289	3	2	3	1	t	1
290	3	2	4	1	t	1
291	3	2	5	1	t	1
292	3	2	1	2	t	1
293	3	2	2	2	t	1
294	3	2	3	2	t	1
295	3	2	4	2	t	1
296	3	2	5	2	t	1
297	3	2	1	3	t	1
298	3	2	2	3	t	1
299	3	2	3	3	t	1
300	3	2	4	3	t	1
301	3	2	5	3	t	1
302	3	2	1	4	t	1
303	3	2	2	4	t	1
304	3	2	3	4	t	1
305	3	2	4	4	t	1
306	3	2	5	4	t	1
307	3	2	1	5	t	1
308	3	2	2	5	t	1
309	3	2	3	5	t	1
310	3	2	4	5	t	1
311	3	2	5	5	t	1
312	3	2	1	6	t	1
313	3	2	2	6	t	1
314	3	2	3	6	t	1
315	3	2	4	6	t	1
316	3	2	5	6	t	1
317	3	2	1	7	t	1
318	3	2	2	7	t	1
319	3	2	3	7	t	1
320	3	2	4	7	t	1
321	3	2	5	7	t	1
322	3	2	1	8	t	1
323	3	2	2	8	t	1
324	3	2	3	8	t	1
325	3	2	4	8	t	1
326	3	2	5	8	t	1
327	1	3	1	1	t	1
328	1	3	2	1	t	1
329	1	3	3	1	t	1
330	1	3	4	1	t	1
331	1	3	5	1	t	1
332	1	3	1	2	t	1
333	1	3	2	2	t	1
334	1	3	3	2	t	1
335	1	3	4	2	t	1
336	1	3	5	2	t	1
337	1	3	1	3	t	1
338	1	3	2	3	t	1
339	1	3	3	3	t	1
340	1	3	4	3	t	1
341	1	3	5	3	t	1
342	1	3	1	4	t	1
343	1	3	2	4	t	1
344	1	3	3	4	t	1
345	1	3	4	4	t	1
346	1	3	5	4	t	1
347	1	3	1	5	t	1
348	1	3	2	5	t	1
349	1	3	3	5	t	1
350	1	3	4	5	t	1
351	1	3	5	5	t	1
352	1	3	1	6	t	1
353	1	3	2	6	t	1
354	1	3	3	6	t	1
355	1	3	4	6	t	1
356	1	3	5	6	t	1
357	1	3	1	7	t	1
358	1	3	2	7	t	1
359	1	3	3	7	t	1
360	1	3	4	7	t	1
361	1	3	5	7	t	1
362	1	3	1	8	t	1
363	1	3	2	8	t	1
364	1	3	3	8	t	1
365	1	3	4	8	t	1
366	1	3	5	8	t	1
367	1	3	1	9	t	1
368	1	3	2	9	t	1
369	1	3	3	9	t	1
370	1	3	4	9	t	1
371	1	3	5	9	t	1
372	1	3	1	10	t	1
373	1	3	2	10	t	1
374	1	3	3	10	t	1
375	1	3	4	10	t	1
376	1	3	5	10	t	1
377	1	3	1	11	t	1
378	1	3	2	11	t	1
379	1	3	3	11	t	1
380	1	3	4	11	t	1
381	1	3	5	11	t	1
382	1	3	1	12	t	1
383	1	3	2	12	t	1
384	1	3	3	12	t	1
387	2	3	1	1	t	1
388	2	3	2	1	t	1
389	2	3	3	1	t	1
390	2	3	4	1	t	1
391	2	3	5	1	t	1
392	2	3	6	1	t	1
393	2	3	7	1	t	1
394	2	3	1	2	t	1
395	2	3	2	2	t	1
396	2	3	3	2	t	1
397	2	3	4	2	t	1
398	2	3	5	2	t	1
399	2	3	6	2	t	1
400	2	3	7	2	t	1
401	2	3	1	3	t	1
402	2	3	2	3	t	1
403	2	3	3	3	t	1
404	2	3	4	3	t	1
405	2	3	5	3	t	1
406	2	3	6	3	t	1
407	2	3	7	3	t	1
408	2	3	1	4	t	1
409	2	3	2	4	t	1
410	2	3	3	4	t	1
411	2	3	4	4	t	1
412	2	3	5	4	t	1
413	2	3	6	4	t	1
414	2	3	7	4	t	1
415	2	3	1	5	t	1
416	2	3	2	5	t	1
417	2	3	3	5	t	1
418	2	3	4	5	t	1
419	2	3	5	5	t	1
420	2	3	6	5	t	1
421	2	3	7	5	t	1
422	2	3	1	6	t	1
423	2	3	2	6	t	1
424	2	3	3	6	t	1
425	2	3	4	6	t	1
426	2	3	5	6	t	1
427	2	3	6	6	t	1
428	2	3	7	6	t	1
429	2	3	1	7	t	1
430	2	3	2	7	t	1
431	2	3	3	7	t	1
432	2	3	4	7	t	1
433	2	3	5	7	t	1
434	2	3	6	7	t	1
435	2	3	7	7	t	1
436	2	3	1	8	t	1
437	2	3	2	8	t	1
438	2	3	3	8	t	1
439	2	3	4	8	t	1
440	2	3	5	8	t	1
441	2	3	6	8	t	1
442	2	3	7	8	t	1
443	2	3	1	9	t	1
444	2	3	2	9	t	1
445	2	3	3	9	t	1
446	2	3	4	9	t	1
447	2	3	5	9	t	1
448	2	3	6	9	t	1
450	3	3	1	1	t	1
451	3	3	2	1	t	1
452	3	3	3	1	t	1
453	3	3	4	1	t	1
454	3	3	5	1	t	1
455	3	3	1	2	t	1
456	3	3	2	2	t	1
457	3	3	3	2	t	1
458	3	3	4	2	t	1
459	3	3	5	2	t	1
460	3	3	1	3	t	1
461	3	3	2	3	t	1
462	3	3	3	3	t	1
463	3	3	4	3	t	1
464	3	3	5	3	t	1
465	3	3	1	4	t	1
466	3	3	2	4	t	1
467	3	3	3	4	t	1
468	3	3	4	4	t	1
469	3	3	5	4	t	1
470	3	3	1	5	t	1
471	3	3	2	5	t	1
472	3	3	3	5	t	1
473	3	3	4	5	t	1
474	3	3	5	5	t	1
475	3	3	1	6	t	1
476	3	3	2	6	t	1
477	3	3	3	6	t	1
478	3	3	4	6	t	1
479	3	3	5	6	t	1
480	3	3	1	7	t	1
481	3	3	2	7	t	1
482	3	3	3	7	t	1
483	3	3	4	7	t	1
484	3	3	5	7	t	1
485	3	3	1	8	t	1
486	3	3	2	8	t	1
487	3	3	3	8	t	1
488	3	3	4	8	t	1
489	3	3	5	8	t	1
490	1	4	1	1	t	1
491	1	4	2	1	t	1
492	1	4	3	1	t	1
493	1	4	4	1	t	1
494	1	4	5	1	t	1
495	1	4	1	2	t	1
496	1	4	2	2	t	1
497	1	4	3	2	t	1
498	1	4	4	2	t	1
499	1	4	5	2	t	1
500	1	4	1	3	t	1
501	1	4	2	3	t	1
502	1	4	3	3	t	1
503	1	4	4	3	t	1
504	1	4	5	3	t	1
505	1	4	1	4	t	1
506	1	4	2	4	t	1
507	1	4	3	4	t	1
508	1	4	4	4	t	1
509	1	4	5	4	t	1
510	1	4	1	5	t	1
511	1	4	2	5	t	1
512	1	4	3	5	t	1
513	1	4	4	5	t	1
514	1	4	5	5	t	1
515	1	4	1	6	t	1
516	1	4	2	6	t	1
517	1	4	3	6	t	1
518	1	4	4	6	t	1
519	1	4	5	6	t	1
520	1	4	1	7	t	1
521	1	4	2	7	t	1
522	1	4	3	7	t	1
523	1	4	4	7	t	1
524	1	4	5	7	t	1
525	1	4	1	8	t	1
526	1	4	2	8	t	1
527	1	4	3	8	t	1
528	1	4	4	8	t	1
529	1	4	5	8	t	1
530	1	4	1	9	t	1
531	1	4	2	9	t	1
532	1	4	3	9	t	1
533	1	4	4	9	t	1
534	1	4	5	9	t	1
535	1	4	1	10	t	1
536	1	4	2	10	t	1
537	1	4	3	10	t	1
538	1	4	4	10	t	1
539	1	4	5	10	t	1
540	1	4	1	11	t	1
541	1	4	2	11	t	1
542	1	4	3	11	t	1
543	1	4	4	11	t	1
544	1	4	5	11	t	1
545	1	4	1	12	t	1
546	1	4	2	12	t	1
547	1	4	3	12	t	1
550	2	4	1	1	t	1
551	2	4	2	1	t	1
552	2	4	3	1	t	1
553	2	4	4	1	t	1
554	2	4	5	1	t	1
555	2	4	6	1	t	1
556	2	4	7	1	t	1
557	2	4	1	2	t	1
558	2	4	2	2	t	1
559	2	4	3	2	t	1
560	2	4	4	2	t	1
561	2	4	5	2	t	1
562	2	4	6	2	t	1
563	2	4	7	2	t	1
564	2	4	1	3	t	1
565	2	4	2	3	t	1
566	2	4	3	3	t	1
567	2	4	4	3	t	1
568	2	4	5	3	t	1
569	2	4	6	3	t	1
570	2	4	7	3	t	1
571	2	4	1	4	t	1
572	2	4	2	4	t	1
573	2	4	3	4	t	1
574	2	4	4	4	t	1
575	2	4	5	4	t	1
576	2	4	6	4	t	1
577	2	4	7	4	t	1
578	2	4	1	5	t	1
579	2	4	2	5	t	1
580	2	4	3	5	t	1
581	2	4	4	5	t	1
582	2	4	5	5	t	1
583	2	4	6	5	t	1
584	2	4	7	5	t	1
585	2	4	1	6	t	1
586	2	4	2	6	t	1
587	2	4	3	6	t	1
588	2	4	4	6	t	1
589	2	4	5	6	t	1
590	2	4	6	6	t	1
591	2	4	7	6	t	1
592	2	4	1	7	t	1
593	2	4	2	7	t	1
594	2	4	3	7	t	1
595	2	4	4	7	t	1
596	2	4	5	7	t	1
597	2	4	6	7	t	1
598	2	4	7	7	t	1
599	2	4	1	8	t	1
600	2	4	2	8	t	1
601	2	4	3	8	t	1
602	2	4	4	8	t	1
603	2	4	5	8	t	1
604	2	4	6	8	t	1
605	2	4	7	8	t	1
606	2	4	1	9	t	1
607	2	4	2	9	t	1
608	2	4	3	9	t	1
609	2	4	4	9	t	1
610	2	4	5	9	t	1
611	2	4	6	9	t	1
613	3	4	1	1	t	1
614	3	4	2	1	t	1
615	3	4	3	1	t	1
616	3	4	4	1	t	1
617	3	4	5	1	t	1
618	3	4	1	2	t	1
619	3	4	2	2	t	1
620	3	4	3	2	t	1
621	3	4	4	2	t	1
622	3	4	5	2	t	1
623	3	4	1	3	t	1
624	3	4	2	3	t	1
625	3	4	3	3	t	1
626	3	4	4	3	t	1
627	3	4	5	3	t	1
628	3	4	1	4	t	1
629	3	4	2	4	t	1
630	3	4	3	4	t	1
631	3	4	4	4	t	1
632	3	4	5	4	t	1
633	3	4	1	5	t	1
634	3	4	2	5	t	1
635	3	4	3	5	t	1
636	3	4	4	5	t	1
637	3	4	5	5	t	1
638	3	4	1	6	t	1
639	3	4	2	6	t	1
640	3	4	3	6	t	1
641	3	4	4	6	t	1
642	3	4	5	6	t	1
643	3	4	1	7	t	1
644	3	4	2	7	t	1
645	3	4	3	7	t	1
646	3	4	4	7	t	1
647	3	4	5	7	t	1
648	3	4	1	8	t	1
649	3	4	2	8	t	1
650	3	4	3	8	t	1
651	3	4	4	8	t	1
652	3	4	5	8	t	1
653	1	5	1	1	t	1
654	1	5	2	1	t	1
655	1	5	3	1	t	1
656	1	5	4	1	t	1
657	1	5	5	1	t	1
658	1	5	1	2	t	1
659	1	5	2	2	t	1
660	1	5	3	2	t	1
661	1	5	4	2	t	1
662	1	5	5	2	t	1
663	1	5	1	3	t	1
664	1	5	2	3	t	1
665	1	5	3	3	t	1
666	1	5	4	3	t	1
667	1	5	5	3	t	1
668	1	5	1	4	t	1
669	1	5	2	4	t	1
670	1	5	3	4	t	1
671	1	5	4	4	t	1
672	1	5	5	4	t	1
673	1	5	1	5	t	1
674	1	5	2	5	t	1
675	1	5	3	5	t	1
676	1	5	4	5	t	1
677	1	5	5	5	t	1
678	1	5	1	6	t	1
679	1	5	2	6	t	1
680	1	5	3	6	t	1
681	1	5	4	6	t	1
682	1	5	5	6	t	1
683	1	5	1	7	t	1
684	1	5	2	7	t	1
685	1	5	3	7	t	1
686	1	5	4	7	t	1
687	1	5	5	7	t	1
688	1	5	1	8	t	1
689	1	5	2	8	t	1
690	1	5	3	8	t	1
691	1	5	4	8	t	1
692	1	5	5	8	t	1
693	1	5	1	9	t	1
694	1	5	2	9	t	1
695	1	5	3	9	t	1
696	1	5	4	9	t	1
697	1	5	5	9	t	1
698	1	5	1	10	t	1
699	1	5	2	10	t	1
700	1	5	3	10	t	1
701	1	5	4	10	t	1
702	1	5	5	10	t	1
703	1	5	1	11	t	1
704	1	5	2	11	t	1
705	1	5	3	11	t	1
706	1	5	4	11	t	1
707	1	5	5	11	t	1
708	1	5	1	12	t	1
709	1	5	2	12	t	1
710	1	5	3	12	t	1
713	2	5	1	1	t	1
714	2	5	2	1	t	1
715	2	5	3	1	t	1
716	2	5	4	1	t	1
717	2	5	5	1	t	1
718	2	5	6	1	t	1
719	2	5	7	1	t	1
720	2	5	1	2	t	1
721	2	5	2	2	t	1
722	2	5	3	2	t	1
723	2	5	4	2	t	1
724	2	5	5	2	t	1
725	2	5	6	2	t	1
726	2	5	7	2	t	1
727	2	5	1	3	t	1
728	2	5	2	3	t	1
729	2	5	3	3	t	1
730	2	5	4	3	t	1
731	2	5	5	3	t	1
732	2	5	6	3	t	1
733	2	5	7	3	t	1
734	2	5	1	4	t	1
735	2	5	2	4	t	1
736	2	5	3	4	t	1
737	2	5	4	4	t	1
738	2	5	5	4	t	1
739	2	5	6	4	t	1
740	2	5	7	4	t	1
741	2	5	1	5	t	1
742	2	5	2	5	t	1
743	2	5	3	5	t	1
744	2	5	4	5	t	1
745	2	5	5	5	t	1
746	2	5	6	5	t	1
747	2	5	7	5	t	1
748	2	5	1	6	t	1
749	2	5	2	6	t	1
750	2	5	3	6	t	1
751	2	5	4	6	t	1
752	2	5	5	6	t	1
753	2	5	6	6	t	1
754	2	5	7	6	t	1
755	2	5	1	7	t	1
756	2	5	2	7	t	1
757	2	5	3	7	t	1
758	2	5	4	7	t	1
759	2	5	5	7	t	1
760	2	5	6	7	t	1
761	2	5	7	7	t	1
762	2	5	1	8	t	1
763	2	5	2	8	t	1
764	2	5	3	8	t	1
765	2	5	4	8	t	1
766	2	5	5	8	t	1
767	2	5	6	8	t	1
768	2	5	7	8	t	1
769	2	5	1	9	t	1
770	2	5	2	9	t	1
771	2	5	3	9	t	1
772	2	5	4	9	t	1
773	2	5	5	9	t	1
774	2	5	6	9	t	1
776	3	5	1	1	t	1
777	3	5	2	1	t	1
778	3	5	3	1	t	1
779	3	5	4	1	t	1
780	3	5	5	1	t	1
781	3	5	1	2	t	1
782	3	5	2	2	t	1
783	3	5	3	2	t	1
784	3	5	4	2	t	1
785	3	5	5	2	t	1
786	3	5	1	3	t	1
787	3	5	2	3	t	1
788	3	5	3	3	t	1
789	3	5	4	3	t	1
790	3	5	5	3	t	1
791	3	5	1	4	t	1
792	3	5	2	4	t	1
793	3	5	3	4	t	1
794	3	5	4	4	t	1
795	3	5	5	4	t	1
796	3	5	1	5	t	1
797	3	5	2	5	t	1
798	3	5	3	5	t	1
799	3	5	4	5	t	1
800	3	5	5	5	t	1
801	3	5	1	6	t	1
802	3	5	2	6	t	1
803	3	5	3	6	t	1
804	3	5	4	6	t	1
805	3	5	5	6	t	1
806	3	5	1	7	t	1
807	3	5	2	7	t	1
808	3	5	3	7	t	1
809	3	5	4	7	t	1
810	3	5	5	7	t	1
811	3	5	1	8	t	1
812	3	5	2	8	t	1
813	3	5	3	8	t	1
814	3	5	4	8	t	1
815	3	5	5	8	t	1
816	1	6	1	1	t	1
817	1	6	2	1	t	1
818	1	6	3	1	t	1
819	1	6	4	1	t	1
820	1	6	5	1	t	1
821	1	6	1	2	t	1
822	1	6	2	2	t	1
823	1	6	3	2	t	1
824	1	6	4	2	t	1
825	1	6	5	2	t	1
826	1	6	1	3	t	1
827	1	6	2	3	t	1
828	1	6	3	3	t	1
829	1	6	4	3	t	1
830	1	6	5	3	t	1
831	1	6	1	4	t	1
832	1	6	2	4	t	1
833	1	6	3	4	t	1
834	1	6	4	4	t	1
835	1	6	5	4	t	1
836	1	6	1	5	t	1
837	1	6	2	5	t	1
838	1	6	3	5	t	1
839	1	6	4	5	t	1
840	1	6	5	5	t	1
841	1	6	1	6	t	1
842	1	6	2	6	t	1
843	1	6	3	6	t	1
844	1	6	4	6	t	1
845	1	6	5	6	t	1
846	1	6	1	7	t	1
847	1	6	2	7	t	1
848	1	6	3	7	t	1
849	1	6	4	7	t	1
850	1	6	5	7	t	1
851	1	6	1	8	t	1
852	1	6	2	8	t	1
853	1	6	3	8	t	1
854	1	6	4	8	t	1
855	1	6	5	8	t	1
856	1	6	1	9	t	1
857	1	6	2	9	t	1
858	1	6	3	9	t	1
859	1	6	4	9	t	1
860	1	6	5	9	t	1
861	1	6	1	10	t	1
862	1	6	2	10	t	1
863	1	6	3	10	t	1
864	1	6	4	10	t	1
865	1	6	5	10	t	1
866	1	6	1	11	t	1
867	1	6	2	11	t	1
868	1	6	3	11	t	1
869	1	6	4	11	t	1
870	1	6	5	11	t	1
871	1	6	1	12	t	1
872	1	6	2	12	t	1
873	1	6	3	12	t	1
876	2	6	1	1	t	1
877	2	6	2	1	t	1
878	2	6	3	1	t	1
879	2	6	4	1	t	1
880	2	6	5	1	t	1
881	2	6	6	1	t	1
882	2	6	7	1	t	1
883	2	6	1	2	t	1
884	2	6	2	2	t	1
885	2	6	3	2	t	1
886	2	6	4	2	t	1
887	2	6	5	2	t	1
888	2	6	6	2	t	1
889	2	6	7	2	t	1
890	2	6	1	3	t	1
891	2	6	2	3	t	1
892	2	6	3	3	t	1
893	2	6	4	3	t	1
894	2	6	5	3	t	1
895	2	6	6	3	t	1
896	2	6	7	3	t	1
897	2	6	1	4	t	1
898	2	6	2	4	t	1
899	2	6	3	4	t	1
900	2	6	4	4	t	1
901	2	6	5	4	t	1
902	2	6	6	4	t	1
903	2	6	7	4	t	1
904	2	6	1	5	t	1
905	2	6	2	5	t	1
906	2	6	3	5	t	1
907	2	6	4	5	t	1
908	2	6	5	5	t	1
909	2	6	6	5	t	1
910	2	6	7	5	t	1
911	2	6	1	6	t	1
912	2	6	2	6	t	1
913	2	6	3	6	t	1
914	2	6	4	6	t	1
915	2	6	5	6	t	1
916	2	6	6	6	t	1
917	2	6	7	6	t	1
918	2	6	1	7	t	1
919	2	6	2	7	t	1
920	2	6	3	7	t	1
921	2	6	4	7	t	1
922	2	6	5	7	t	1
923	2	6	6	7	t	1
924	2	6	7	7	t	1
925	2	6	1	8	t	1
926	2	6	2	8	t	1
927	2	6	3	8	t	1
928	2	6	4	8	t	1
929	2	6	5	8	t	1
930	2	6	6	8	t	1
931	2	6	7	8	t	1
932	2	6	1	9	t	1
933	2	6	2	9	t	1
934	2	6	3	9	t	1
935	2	6	4	9	t	1
936	2	6	5	9	t	1
937	2	6	6	9	t	1
939	3	6	1	1	t	1
940	3	6	2	1	t	1
941	3	6	3	1	t	1
942	3	6	4	1	t	1
943	3	6	5	1	t	1
944	3	6	1	2	t	1
945	3	6	2	2	t	1
946	3	6	3	2	t	1
947	3	6	4	2	t	1
948	3	6	5	2	t	1
949	3	6	1	3	t	1
950	3	6	2	3	t	1
951	3	6	3	3	t	1
952	3	6	4	3	t	1
953	3	6	5	3	t	1
954	3	6	1	4	t	1
955	3	6	2	4	t	1
956	3	6	3	4	t	1
957	3	6	4	4	t	1
958	3	6	5	4	t	1
959	3	6	1	5	t	1
960	3	6	2	5	t	1
961	3	6	3	5	t	1
962	3	6	4	5	t	1
963	3	6	5	5	t	1
964	3	6	1	6	t	1
965	3	6	2	6	t	1
966	3	6	3	6	t	1
967	3	6	4	6	t	1
968	3	6	5	6	t	1
969	3	6	1	7	t	1
970	3	6	2	7	t	1
971	3	6	3	7	t	1
972	3	6	4	7	t	1
973	3	6	5	7	t	1
974	3	6	1	8	t	1
975	3	6	2	8	t	1
976	3	6	3	8	t	1
977	3	6	4	8	t	1
978	3	6	5	8	t	1
979	1	7	1	1	t	1
980	1	7	2	1	t	1
981	1	7	3	1	t	1
982	1	7	4	1	t	1
983	1	7	5	1	t	1
984	1	7	1	2	t	1
985	1	7	2	2	t	1
986	1	7	3	2	t	1
987	1	7	4	2	t	1
988	1	7	5	2	t	1
989	1	7	1	3	t	1
990	1	7	2	3	t	1
991	1	7	3	3	t	1
992	1	7	4	3	t	1
993	1	7	5	3	t	1
994	1	7	1	4	t	1
995	1	7	2	4	t	1
996	1	7	3	4	t	1
997	1	7	4	4	t	1
998	1	7	5	4	t	1
999	1	7	1	5	t	1
1000	1	7	2	5	t	1
1001	1	7	3	5	t	1
1002	1	7	4	5	t	1
1003	1	7	5	5	t	1
1004	1	7	1	6	t	1
1005	1	7	2	6	t	1
1006	1	7	3	6	t	1
1007	1	7	4	6	t	1
1008	1	7	5	6	t	1
1009	1	7	1	7	t	1
1010	1	7	2	7	t	1
1011	1	7	3	7	t	1
1012	1	7	4	7	t	1
1013	1	7	5	7	t	1
1014	1	7	1	8	t	1
1015	1	7	2	8	t	1
1016	1	7	3	8	t	1
1017	1	7	4	8	t	1
1018	1	7	5	8	t	1
1019	1	7	1	9	t	1
1020	1	7	2	9	t	1
1021	1	7	3	9	t	1
1022	1	7	4	9	t	1
1023	1	7	5	9	t	1
1024	1	7	1	10	t	1
1025	1	7	2	10	t	1
1026	1	7	3	10	t	1
1027	1	7	4	10	t	1
1028	1	7	5	10	t	1
1029	1	7	1	11	t	1
1030	1	7	2	11	t	1
1031	1	7	3	11	t	1
1032	1	7	4	11	t	1
1033	1	7	5	11	t	1
1034	1	7	1	12	t	1
1035	1	7	2	12	t	1
1036	1	7	3	12	t	1
1039	2	7	1	1	t	1
1040	2	7	2	1	t	1
1041	2	7	3	1	t	1
1042	2	7	4	1	t	1
1043	2	7	5	1	t	1
1044	2	7	6	1	t	1
1045	2	7	7	1	t	1
1046	2	7	1	2	t	1
1047	2	7	2	2	t	1
1048	2	7	3	2	t	1
1049	2	7	4	2	t	1
1050	2	7	5	2	t	1
1051	2	7	6	2	t	1
1052	2	7	7	2	t	1
1053	2	7	1	3	t	1
1054	2	7	2	3	t	1
1055	2	7	3	3	t	1
1056	2	7	4	3	t	1
1057	2	7	5	3	t	1
1058	2	7	6	3	t	1
1059	2	7	7	3	t	1
1060	2	7	1	4	t	1
1061	2	7	2	4	t	1
1062	2	7	3	4	t	1
1063	2	7	4	4	t	1
1064	2	7	5	4	t	1
1065	2	7	6	4	t	1
1066	2	7	7	4	t	1
1067	2	7	1	5	t	1
1068	2	7	2	5	t	1
1069	2	7	3	5	t	1
1070	2	7	4	5	t	1
1071	2	7	5	5	t	1
1072	2	7	6	5	t	1
1073	2	7	7	5	t	1
1074	2	7	1	6	t	1
1075	2	7	2	6	t	1
1076	2	7	3	6	t	1
1077	2	7	4	6	t	1
1078	2	7	5	6	t	1
1079	2	7	6	6	t	1
1080	2	7	7	6	t	1
1081	2	7	1	7	t	1
1082	2	7	2	7	t	1
1083	2	7	3	7	t	1
1084	2	7	4	7	t	1
1085	2	7	5	7	t	1
1086	2	7	6	7	t	1
1087	2	7	7	7	t	1
1088	2	7	1	8	t	1
1089	2	7	2	8	t	1
1090	2	7	3	8	t	1
1091	2	7	4	8	t	1
1092	2	7	5	8	t	1
1093	2	7	6	8	t	1
1094	2	7	7	8	t	1
1095	2	7	1	9	t	1
1096	2	7	2	9	t	1
1097	2	7	3	9	t	1
1098	2	7	4	9	t	1
1099	2	7	5	9	t	1
1100	2	7	6	9	t	1
1102	3	7	1	1	t	1
1103	3	7	2	1	t	1
1104	3	7	3	1	t	1
1105	3	7	4	1	t	1
1106	3	7	5	1	t	1
1107	3	7	1	2	t	1
1108	3	7	2	2	t	1
1109	3	7	3	2	t	1
1110	3	7	4	2	t	1
1111	3	7	5	2	t	1
1112	3	7	1	3	t	1
1113	3	7	2	3	t	1
1114	3	7	3	3	t	1
1115	3	7	4	3	t	1
1116	3	7	5	3	t	1
1117	3	7	1	4	t	1
1118	3	7	2	4	t	1
1119	3	7	3	4	t	1
1120	3	7	4	4	t	1
1121	3	7	5	4	t	1
1122	3	7	1	5	t	1
1123	3	7	2	5	t	1
1124	3	7	3	5	t	1
1125	3	7	4	5	t	1
1126	3	7	5	5	t	1
1127	3	7	1	6	t	1
1128	3	7	2	6	t	1
1129	3	7	3	6	t	1
1130	3	7	4	6	t	1
1131	3	7	5	6	t	1
1132	3	7	1	7	t	1
1133	3	7	2	7	t	1
1134	3	7	3	7	t	1
1135	3	7	4	7	t	1
1136	3	7	5	7	t	1
1137	3	7	1	8	t	1
1138	3	7	2	8	t	1
1139	3	7	3	8	t	1
1140	3	7	4	8	t	1
1141	3	7	5	8	t	1
\.


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('quizzes_id_seq', 1141, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: quizzing
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
20150608150246
20150608195357
20150609171234
20150610182159
20150613014911
20150613015137
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY settings (id, roster_lock_date, drop_lowest_score, roster_lock_toggle, auto_promote_students, area_name, admin_name, admin_email, intro) FROM stdin;
1	2015-06-23	t	t	t	Pittsburgh Area Quizzing	Tommy Reay	tmreay@example.com	I am Arthur, King of the Britons.
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('settings_id_seq', 1, true);


--
-- Data for Name: student_quizzes; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY student_quizzes (id, student_id, quiz_id, num_correct, num_attempts, num_fouls, score) FROM stdin;
1	96	1	2	5	\N	20
2	97	1	0	0	\N	0
3	98	1	2	2	\N	40
4	99	1	3	4	\N	60
5	45	1	2	3	\N	40
6	46	1	2	2	\N	40
7	47	1	1	1	\N	20
8	25	1	4	4	\N	90
9	26	1	4	4	\N	90
10	27	1	1	1	\N	20
11	69	2	4	4	\N	90
12	70	2	2	4	\N	30
13	71	2	2	3	\N	40
14	42	2	3	4	\N	60
15	43	2	1	1	\N	20
16	44	2	0	0	\N	0
17	51	2	1	2	\N	20
18	52	2	1	1	\N	20
19	53	2	0	2	\N	-10
20	28	3	3	4	\N	60
21	29	3	0	2	\N	-10
22	30	3	3	3	\N	60
23	31	3	2	2	\N	40
24	32	3	2	3	\N	40
25	72	3	4	5	\N	80
26	73	3	1	1	\N	20
27	74	3	4	4	\N	90
28	75	3	2	2	\N	40
29	4	3	3	5	\N	50
30	5	3	3	4	\N	60
31	6	3	1	1	\N	20
32	7	3	2	2	\N	40
33	22	4	1	1	\N	20
34	23	4	0	1	\N	0
35	24	4	4	4	\N	90
36	48	4	4	4	\N	90
37	49	4	4	6	\N	70
38	50	4	1	2	\N	20
39	8	4	1	2	\N	20
40	9	4	4	4	\N	90
41	10	4	1	1	\N	20
42	11	4	0	0	\N	0
43	19	5	1	4	\N	0
44	20	5	0	0	\N	0
45	21	5	3	3	\N	60
46	92	5	2	3	\N	40
47	93	5	1	3	\N	10
48	94	5	0	1	\N	0
49	95	5	1	2	\N	20
50	15	5	3	4	\N	60
51	16	5	1	1	\N	20
52	17	5	1	1	\N	20
53	18	5	0	0	\N	0
54	100	6	3	4	\N	60
55	101	6	0	0	\N	0
56	102	6	0	0	\N	0
57	103	6	0	0	\N	0
58	33	6	3	3	\N	60
59	34	6	4	5	\N	80
60	35	6	3	3	\N	60
61	36	6	4	6	\N	70
62	1	6	4	4	\N	90
63	2	6	0	0	\N	0
64	3	6	2	2	\N	40
65	89	7	4	5	\N	80
66	90	7	0	1	\N	0
67	91	7	1	1	\N	20
68	65	7	4	5	\N	80
69	66	7	2	2	\N	40
70	67	7	0	0	\N	0
71	68	7	0	0	\N	0
72	58	7	3	4	\N	60
73	59	7	2	2	\N	40
74	60	7	0	2	\N	-10
75	61	7	1	3	\N	10
76	37	8	3	4	\N	60
77	38	8	2	2	\N	40
78	39	8	1	3	\N	10
79	40	8	4	4	\N	90
80	41	8	0	2	\N	-10
81	80	8	0	1	\N	0
82	81	8	2	2	\N	40
83	82	8	0	1	\N	0
84	76	8	3	4	\N	60
85	77	8	0	0	\N	0
86	78	8	0	0	\N	0
87	79	8	2	3	\N	40
88	12	9	3	4	\N	60
89	13	9	1	1	\N	20
90	14	9	1	2	\N	20
91	62	9	3	5	\N	50
92	63	9	2	2	\N	40
93	64	9	4	4	\N	90
94	83	9	4	5	\N	80
95	84	9	2	3	\N	40
96	85	9	2	3	\N	40
97	54	10	2	2	\N	40
98	55	10	1	2	\N	20
99	56	10	1	1	\N	20
100	57	10	0	1	\N	0
101	86	10	2	5	\N	20
102	87	10	2	2	\N	40
103	88	10	2	3	\N	40
104	45	10	1	2	\N	20
105	46	10	4	5	\N	80
106	47	10	0	1	\N	0
107	58	11	4	4	\N	90
108	59	11	1	1	\N	20
109	60	11	2	4	\N	30
110	61	11	0	0	\N	0
111	54	11	4	5	\N	80
112	55	11	0	0	\N	0
113	56	11	0	0	\N	0
114	57	11	2	2	\N	40
115	96	11	4	5	\N	80
116	97	11	0	0	\N	0
117	98	11	2	2	\N	40
118	99	11	2	2	\N	40
119	37	12	4	5	\N	80
120	38	12	2	3	\N	40
121	39	12	1	1	\N	20
122	40	12	1	1	\N	20
123	41	12	1	1	\N	20
124	89	12	1	1	\N	20
125	90	12	1	3	\N	10
126	91	12	1	1	\N	20
127	8	12	4	4	\N	90
128	9	12	2	2	\N	40
129	10	12	1	1	\N	20
130	11	12	1	1	\N	20
131	48	13	4	4	\N	90
132	49	13	1	2	\N	20
133	50	13	1	1	\N	20
134	51	13	2	4	\N	30
135	52	13	0	1	\N	0
136	53	13	1	2	\N	20
137	69	13	3	4	\N	60
138	70	13	1	1	\N	20
139	71	13	3	3	\N	60
140	15	14	1	4	\N	0
141	16	14	2	2	\N	40
142	17	14	1	2	\N	20
143	18	14	4	4	\N	90
144	42	14	4	5	\N	80
145	43	14	1	2	\N	20
146	44	14	1	1	\N	20
147	22	14	4	5	\N	80
148	23	14	3	4	\N	60
149	24	14	2	2	\N	40
150	86	15	3	5	\N	50
151	87	15	2	2	\N	40
152	88	15	4	5	\N	80
153	19	15	1	2	\N	20
154	20	15	0	0	\N	0
155	21	15	0	1	\N	0
156	62	15	4	5	\N	80
157	63	15	0	0	\N	0
158	64	15	0	0	\N	0
159	83	16	3	6	\N	40
160	84	16	4	4	\N	90
161	85	16	2	2	\N	40
162	25	16	4	4	\N	90
163	26	16	1	2	\N	20
164	27	16	1	1	\N	20
165	33	16	4	6	\N	70
166	34	16	0	0	\N	0
167	35	16	0	0	\N	0
168	36	16	3	3	\N	60
169	65	17	2	2	\N	40
170	66	17	2	2	\N	40
171	67	17	2	3	\N	40
172	68	17	1	1	\N	20
173	100	17	3	4	\N	60
174	101	17	3	4	\N	60
175	102	17	1	1	\N	20
176	103	17	0	1	\N	0
177	1	17	3	4	\N	60
178	2	17	1	1	\N	20
179	3	17	1	1	\N	20
180	80	18	0	0	\N	0
181	81	18	1	2	\N	20
182	82	18	0	0	\N	0
183	76	18	4	5	\N	80
184	77	18	1	1	\N	20
185	78	18	1	1	\N	20
186	79	18	1	1	\N	20
187	72	18	3	3	\N	60
188	73	18	1	1	\N	20
189	74	18	4	4	\N	90
190	75	18	4	6	\N	70
191	92	19	3	5	\N	50
192	93	19	1	2	\N	20
193	94	19	0	2	\N	-10
194	95	19	3	3	\N	60
195	28	19	4	6	\N	70
196	29	19	4	6	\N	70
197	30	19	0	1	\N	0
198	31	19	1	1	\N	20
199	32	19	0	0	\N	0
200	12	19	4	4	\N	90
201	13	19	1	1	\N	20
202	14	19	4	4	\N	90
203	4	20	4	6	\N	70
204	5	20	4	5	\N	80
205	6	20	0	0	\N	0
206	7	20	1	1	\N	20
207	89	20	4	5	\N	80
208	90	20	1	2	\N	20
209	91	20	0	2	\N	-10
210	54	20	3	6	\N	40
211	55	20	0	0	\N	0
212	56	20	2	2	\N	40
213	57	20	0	0	\N	0
214	65	21	4	5	\N	80
215	66	21	1	3	\N	10
216	67	21	1	1	\N	20
217	68	21	0	2	\N	-10
218	96	21	4	5	\N	80
219	97	21	1	3	\N	10
220	98	21	4	6	\N	70
221	99	21	2	4	\N	30
222	42	21	4	5	\N	80
223	43	21	1	1	\N	20
224	44	21	1	1	\N	20
225	12	22	4	4	\N	90
226	13	22	1	1	\N	20
227	14	22	1	1	\N	20
228	4	22	4	6	\N	70
229	5	22	0	0	\N	0
230	6	22	2	2	\N	40
231	7	22	1	1	\N	20
232	25	22	3	4	\N	60
233	26	22	0	0	\N	0
234	27	22	2	2	\N	40
235	100	23	0	3	\N	-20
236	101	23	3	4	\N	60
237	102	23	4	4	\N	90
238	103	23	1	1	\N	20
239	15	23	3	3	\N	60
240	16	23	0	0	\N	0
241	17	23	3	3	\N	60
242	18	23	4	4	\N	90
243	72	23	4	4	\N	90
244	73	23	2	2	\N	40
245	74	23	1	1	\N	20
246	75	23	0	0	\N	0
247	76	24	4	6	\N	70
248	77	24	1	2	\N	20
249	78	24	1	2	\N	20
250	79	24	3	3	\N	60
251	8	24	4	5	\N	80
252	9	24	2	2	\N	40
253	10	24	2	2	\N	40
254	11	24	2	2	\N	40
255	37	24	4	5	\N	80
256	38	24	0	0	\N	0
257	39	24	1	1	\N	20
258	40	24	0	0	\N	0
259	41	24	1	2	\N	20
260	62	25	4	5	\N	80
261	63	25	0	0	\N	0
262	64	25	4	6	\N	70
263	48	25	4	6	\N	70
264	49	25	0	0	\N	0
265	50	25	0	0	\N	0
266	28	25	4	4	\N	90
267	29	25	0	1	\N	0
268	30	25	1	1	\N	20
269	31	25	0	0	\N	0
270	32	25	0	1	\N	0
271	58	26	4	4	\N	90
272	59	26	0	0	\N	0
273	60	26	0	0	\N	0
274	61	26	1	1	\N	20
275	1	26	3	5	\N	50
276	2	26	4	6	\N	70
277	3	26	1	3	\N	10
278	83	26	1	3	\N	10
279	84	26	2	2	\N	40
280	85	26	2	2	\N	40
281	45	27	4	4	\N	90
282	46	27	0	0	\N	0
283	47	27	3	4	\N	60
284	92	27	3	6	\N	40
285	93	27	1	1	\N	20
286	94	27	3	4	\N	60
287	95	27	0	1	\N	0
288	80	27	3	3	\N	60
289	81	27	0	0	\N	0
290	82	27	4	5	\N	80
291	69	28	0	1	\N	0
292	70	28	1	2	\N	20
293	71	28	3	3	\N	60
294	33	28	4	5	\N	80
295	34	28	0	0	\N	0
296	35	28	4	4	\N	90
297	36	28	0	2	\N	-10
298	51	28	3	6	\N	40
299	52	28	1	1	\N	20
300	53	28	4	5	\N	80
301	22	29	4	4	\N	90
302	23	29	0	0	\N	0
303	24	29	2	2	\N	40
304	19	29	1	2	\N	20
305	20	29	3	3	\N	60
306	21	29	3	3	\N	60
307	86	29	0	1	\N	0
308	87	29	4	4	\N	90
309	88	29	0	0	\N	0
310	89	30	4	4	\N	90
311	90	30	0	0	\N	0
312	91	30	0	0	\N	0
313	37	30	3	4	\N	60
314	38	30	1	1	\N	20
315	39	30	3	3	\N	60
316	40	30	1	2	\N	20
317	41	30	0	0	\N	0
318	69	30	3	5	\N	50
319	70	30	1	2	\N	20
320	71	30	0	0	\N	0
321	42	31	0	1	\N	0
322	43	31	0	0	\N	0
323	44	31	3	3	\N	60
324	72	31	3	4	\N	60
325	73	31	1	1	\N	20
326	74	31	0	1	\N	0
327	75	31	2	2	\N	40
328	4	31	4	4	\N	90
329	5	31	1	1	\N	20
330	6	31	1	1	\N	20
331	7	31	1	1	\N	20
332	33	32	4	4	\N	90
333	34	32	1	2	\N	20
334	35	32	2	2	\N	40
335	36	32	0	0	\N	0
336	62	32	4	5	\N	80
337	63	32	1	2	\N	20
338	64	32	0	0	\N	0
339	58	32	4	5	\N	80
340	59	32	0	0	\N	0
341	60	32	0	0	\N	0
342	61	32	4	5	\N	80
343	15	33	4	5	\N	80
344	16	33	0	0	\N	0
345	17	33	2	2	\N	40
346	18	33	2	2	\N	40
347	80	33	3	4	\N	60
348	81	33	1	1	\N	20
349	82	33	2	2	\N	40
350	100	33	4	4	\N	90
351	101	33	1	2	\N	20
352	102	33	1	1	\N	20
353	103	33	4	4	\N	90
354	12	34	2	2	\N	40
355	13	34	3	3	\N	60
356	14	34	3	4	\N	60
357	22	34	1	4	\N	0
358	23	34	0	2	\N	-10
359	24	34	1	2	\N	20
360	83	34	3	4	\N	60
361	84	34	2	2	\N	40
362	85	34	0	0	\N	0
363	54	35	3	4	\N	60
364	55	35	2	4	\N	30
365	56	35	1	2	\N	20
366	57	35	0	2	\N	-10
367	51	35	3	5	\N	50
368	52	35	3	3	\N	60
369	53	35	4	4	\N	90
370	76	35	3	3	\N	60
371	77	35	0	0	\N	0
372	78	35	0	2	\N	-10
373	79	35	0	2	\N	-10
374	96	36	3	5	\N	50
375	97	36	0	0	\N	0
376	98	36	0	2	\N	-10
377	99	36	1	1	\N	20
378	86	36	3	4	\N	60
379	87	36	1	1	\N	20
380	88	36	3	3	\N	60
381	92	36	4	5	\N	80
382	93	36	4	4	\N	90
383	94	36	1	1	\N	20
384	95	36	0	2	\N	-10
385	19	37	4	5	\N	80
386	20	37	4	6	\N	70
387	21	37	1	1	\N	20
388	8	37	3	4	\N	60
389	9	37	3	3	\N	60
390	10	37	1	1	\N	20
391	11	37	3	3	\N	60
392	45	37	4	4	\N	90
393	46	37	0	0	\N	0
394	47	37	1	1	\N	20
395	28	38	2	5	\N	20
396	29	38	1	1	\N	20
397	30	38	0	0	\N	0
398	31	38	4	5	\N	80
399	32	38	1	1	\N	20
400	48	38	3	3	\N	60
401	49	38	0	0	\N	0
402	50	38	2	2	\N	40
403	25	38	3	6	\N	40
404	26	38	0	0	\N	0
405	27	38	0	0	\N	0
406	65	39	3	4	\N	60
407	66	39	0	0	\N	0
408	67	39	1	2	\N	20
409	68	39	0	0	\N	0
410	1	39	3	5	\N	50
411	2	39	0	0	\N	0
412	3	39	3	4	\N	60
413	15	39	1	2	\N	20
414	16	39	2	4	\N	30
415	17	39	1	2	\N	20
416	18	39	0	0	\N	0
417	83	40	4	4	\N	90
418	84	40	1	1	\N	20
419	85	40	2	2	\N	40
420	54	40	4	5	\N	80
421	55	40	1	2	\N	20
422	56	40	4	4	\N	90
423	57	40	2	3	\N	40
424	72	40	3	4	\N	60
425	73	40	4	4	\N	90
426	74	40	4	6	\N	70
427	75	40	0	0	\N	0
428	4	41	0	0	\N	0
429	5	41	2	3	\N	40
430	6	41	2	2	\N	40
431	7	41	1	3	\N	10
432	69	41	0	1	\N	0
433	70	41	1	1	\N	20
434	71	41	0	0	\N	0
435	45	41	4	4	\N	90
436	46	41	3	3	\N	60
437	47	41	3	4	\N	60
438	80	42	4	6	\N	70
439	81	42	0	2	\N	-10
440	82	42	0	1	\N	0
441	48	42	4	5	\N	80
442	49	42	1	1	\N	20
443	50	42	0	1	\N	0
444	8	42	3	3	\N	60
445	9	42	0	0	\N	0
446	10	42	1	1	\N	20
447	11	42	1	1	\N	20
448	51	43	3	4	\N	60
449	52	43	0	2	\N	-10
450	53	43	1	3	\N	10
451	65	43	3	6	\N	40
452	66	43	1	2	\N	20
453	67	43	1	1	\N	20
454	68	43	0	0	\N	0
455	28	43	2	3	\N	40
456	29	43	1	3	\N	10
457	30	43	3	3	\N	60
458	31	43	1	1	\N	20
459	32	43	1	1	\N	20
460	96	44	4	5	\N	80
461	97	44	1	2	\N	20
462	98	44	0	0	\N	0
463	99	44	0	1	\N	0
464	22	44	3	4	\N	60
465	23	44	2	2	\N	40
466	24	44	3	3	\N	60
467	37	44	3	5	\N	50
468	38	44	4	4	\N	90
469	39	44	4	4	\N	90
470	40	44	1	1	\N	20
471	41	44	0	0	\N	0
472	19	45	4	4	\N	90
473	20	45	3	3	\N	60
474	21	45	1	1	\N	20
475	42	45	3	3	\N	60
476	43	45	2	3	\N	40
477	44	45	1	1	\N	20
478	12	45	3	4	\N	60
479	13	45	2	2	\N	40
480	14	45	2	2	\N	40
481	33	46	4	4	\N	90
482	34	46	0	0	\N	0
483	35	46	0	0	\N	0
484	36	46	0	0	\N	0
485	62	46	4	4	\N	90
486	63	46	3	4	\N	60
487	64	46	2	2	\N	40
488	92	46	3	5	\N	50
489	93	46	0	1	\N	0
490	94	46	1	1	\N	20
491	95	46	0	1	\N	0
492	89	47	3	4	\N	60
493	90	47	2	4	\N	30
494	91	47	2	4	\N	30
495	100	47	4	4	\N	90
496	101	47	4	6	\N	70
497	102	47	0	0	\N	0
498	103	47	0	1	\N	0
499	86	47	3	3	\N	60
500	87	47	3	3	\N	60
501	88	47	1	1	\N	20
502	76	48	3	4	\N	60
503	77	48	1	2	\N	20
504	78	48	1	1	\N	20
505	79	48	0	0	\N	0
506	1	48	1	2	\N	20
507	2	48	2	3	\N	40
508	3	48	2	2	\N	40
509	58	48	1	3	\N	10
510	59	48	1	2	\N	20
511	60	48	1	1	\N	20
512	61	48	4	6	\N	70
513	25	49	4	4	\N	90
514	26	49	0	0	\N	0
515	27	49	2	3	\N	40
516	72	49	4	5	\N	80
517	73	49	0	2	\N	-10
518	74	49	1	1	\N	20
519	75	49	2	2	\N	40
520	4	49	2	3	\N	40
521	5	49	0	0	\N	0
522	6	49	0	0	\N	0
523	7	49	2	2	\N	40
524	22	50	3	5	\N	50
525	23	50	2	2	\N	40
526	24	50	3	3	\N	60
527	80	50	3	3	\N	60
528	81	50	1	1	\N	20
529	82	50	2	4	\N	30
530	51	50	4	5	\N	80
531	52	50	2	2	\N	40
532	53	50	0	0	\N	0
533	92	51	0	1	\N	0
534	93	51	4	5	\N	80
535	94	51	2	4	\N	30
536	95	51	2	2	\N	40
537	83	51	2	4	\N	30
538	84	51	2	2	\N	40
539	85	51	3	3	\N	60
540	37	51	1	1	\N	20
541	38	51	1	1	\N	20
542	39	51	2	3	\N	40
543	40	51	4	6	\N	70
544	41	51	3	4	\N	60
545	45	52	1	3	\N	10
546	46	52	0	0	\N	0
547	47	52	2	2	\N	40
548	25	52	4	4	\N	90
549	26	52	2	2	\N	40
550	27	52	0	0	\N	0
551	65	52	4	4	\N	90
552	66	52	2	3	\N	40
553	67	52	2	2	\N	40
554	68	52	0	1	\N	0
555	15	53	4	5	\N	80
556	16	53	1	3	\N	10
557	17	53	0	0	\N	0
558	18	53	1	2	\N	20
559	62	53	3	6	\N	40
560	63	53	0	2	\N	-10
561	64	53	2	4	\N	30
562	69	53	2	4	\N	30
563	70	53	1	1	\N	20
564	71	53	3	3	\N	60
565	58	54	0	1	\N	0
566	59	54	0	0	\N	0
567	60	54	0	0	\N	0
568	61	54	1	1	\N	20
569	42	54	3	6	\N	40
570	43	54	3	4	\N	60
571	44	54	4	4	\N	90
572	86	54	3	5	\N	50
573	87	54	3	4	\N	60
574	88	54	1	1	\N	20
575	76	55	3	3	\N	60
576	77	55	2	3	\N	40
577	78	55	0	1	\N	0
578	79	55	1	1	\N	20
579	33	55	4	4	\N	90
580	34	55	2	2	\N	40
581	35	55	0	0	\N	0
582	36	55	4	5	\N	80
583	54	55	0	1	\N	0
584	55	55	0	0	\N	0
585	56	55	2	2	\N	40
586	57	55	1	1	\N	20
587	96	56	1	2	\N	20
588	97	56	2	2	\N	40
589	98	56	1	1	\N	20
590	99	56	0	0	\N	0
591	1	56	4	4	\N	90
592	2	56	2	4	\N	30
593	3	56	1	3	\N	10
594	12	56	4	5	\N	80
595	13	56	1	1	\N	20
596	14	56	1	1	\N	20
597	8	57	1	2	\N	20
598	9	57	3	5	\N	50
599	10	57	0	1	\N	0
600	11	57	2	3	\N	40
601	100	57	4	4	\N	90
602	101	57	1	2	\N	20
603	102	57	2	2	\N	40
604	103	57	1	3	\N	10
605	28	57	0	1	\N	0
606	29	57	3	5	\N	50
607	30	57	4	4	\N	90
608	31	57	0	0	\N	0
609	32	57	1	1	\N	20
610	19	58	4	4	\N	90
611	20	58	0	0	\N	0
612	21	58	4	4	\N	90
613	48	58	3	4	\N	60
614	49	58	2	2	\N	40
615	50	58	2	3	\N	40
616	89	58	3	3	\N	60
617	90	58	2	2	\N	40
618	91	58	1	1	\N	20
619	172	61	4	5	\N	80
620	173	61	4	5	\N	80
621	174	61	0	0	\N	0
622	175	61	0	1	\N	0
623	119	61	4	6	\N	70
624	120	61	0	1	\N	0
625	121	61	3	4	\N	60
626	122	61	0	0	\N	0
627	104	61	2	3	\N	40
628	117	62	3	3	\N	60
629	118	62	0	1	\N	0
630	146	62	4	5	\N	80
631	169	62	3	4	\N	60
632	170	62	0	1	\N	0
633	171	62	3	5	\N	50
634	130	63	0	1	\N	0
635	131	63	2	3	\N	40
636	132	63	1	1	\N	20
637	133	63	1	2	\N	20
638	143	63	2	2	\N	40
639	144	63	1	3	\N	10
640	145	63	4	4	\N	90
641	147	63	3	3	\N	60
642	148	63	2	4	\N	30
643	164	64	1	1	\N	20
644	165	64	1	1	\N	20
645	166	64	1	1	\N	20
646	161	64	4	4	\N	90
647	162	64	1	2	\N	20
648	163	64	2	2	\N	40
649	149	64	2	3	\N	40
650	150	64	0	2	\N	-10
651	151	64	0	0	\N	0
652	152	64	0	2	\N	-10
653	134	65	4	4	\N	90
654	135	65	2	2	\N	40
655	136	65	0	0	\N	0
656	137	65	0	0	\N	0
657	138	65	4	4	\N	90
658	139	65	2	2	\N	40
659	140	65	3	3	\N	60
660	114	65	4	5	\N	80
661	115	65	1	1	\N	20
662	116	65	4	4	\N	90
663	107	66	0	0	\N	0
664	108	66	1	1	\N	20
665	109	66	0	0	\N	0
666	110	66	0	1	\N	0
667	176	66	2	3	\N	40
668	177	66	0	1	\N	0
669	178	66	0	1	\N	0
670	179	66	0	1	\N	0
671	182	66	4	6	\N	70
672	183	66	0	0	\N	0
673	185	67	3	3	\N	60
674	186	67	1	2	\N	20
675	187	67	4	4	\N	90
676	153	67	2	3	\N	40
677	154	67	0	0	\N	0
678	128	67	4	5	\N	80
679	129	67	1	3	\N	10
680	111	68	1	2	\N	20
681	112	68	2	2	\N	40
682	113	68	0	1	\N	0
683	105	68	0	2	\N	-10
684	106	68	1	1	\N	20
685	184	68	3	3	\N	60
686	141	69	4	4	\N	90
687	142	69	0	0	\N	0
688	167	69	4	5	\N	80
689	168	69	2	3	\N	40
690	155	69	4	4	\N	90
691	156	69	3	3	\N	60
692	157	69	1	1	\N	20
693	180	70	4	5	\N	80
694	181	70	4	4	\N	90
695	123	70	1	4	\N	0
696	124	70	1	1	\N	20
697	158	70	3	6	\N	40
698	159	70	1	1	\N	20
699	160	70	2	3	\N	40
700	125	71	4	5	\N	80
701	126	71	3	3	\N	60
702	127	71	3	3	\N	60
703	141	71	4	5	\N	80
704	142	71	0	0	\N	0
705	180	71	3	4	\N	60
706	181	71	0	1	\N	0
707	155	72	2	4	\N	30
708	156	72	4	6	\N	70
709	157	72	3	3	\N	60
710	147	72	1	2	\N	20
711	148	72	1	1	\N	20
712	114	72	0	0	\N	0
713	115	72	4	4	\N	90
714	116	72	1	1	\N	20
715	104	73	4	6	\N	70
716	130	73	3	3	\N	60
717	131	73	1	2	\N	20
718	132	73	0	1	\N	0
719	133	73	0	0	\N	0
720	158	73	3	5	\N	50
721	159	73	1	2	\N	20
722	160	73	4	5	\N	80
723	125	74	3	5	\N	50
724	126	74	4	4	\N	90
725	127	74	1	1	\N	20
726	153	74	0	0	\N	0
727	154	74	2	3	\N	40
728	107	74	4	4	\N	90
729	108	74	2	4	\N	30
730	109	74	0	0	\N	0
731	110	74	1	2	\N	20
732	128	75	2	5	\N	20
733	129	75	0	0	\N	0
734	149	75	3	4	\N	60
735	150	75	2	2	\N	40
736	151	75	2	3	\N	40
737	152	75	1	1	\N	20
738	134	75	0	0	\N	0
739	135	75	3	3	\N	60
740	136	75	4	6	\N	70
741	137	75	1	1	\N	20
742	169	76	3	3	\N	60
743	170	76	2	3	\N	40
744	171	76	1	1	\N	20
745	184	76	3	4	\N	60
746	146	76	3	3	\N	60
747	167	77	4	5	\N	80
748	168	77	3	3	\N	60
749	182	77	2	5	\N	20
750	183	77	2	2	\N	40
751	138	77	4	5	\N	80
752	139	77	1	1	\N	20
753	140	77	0	0	\N	0
754	143	78	4	5	\N	80
755	144	78	0	0	\N	0
756	145	78	0	1	\N	0
757	161	78	2	3	\N	40
758	162	78	1	1	\N	20
759	163	78	0	0	\N	0
760	176	78	2	2	\N	40
761	177	78	2	4	\N	30
762	178	78	4	4	\N	90
763	179	78	1	1	\N	20
764	111	79	1	2	\N	20
765	112	79	0	1	\N	0
766	113	79	2	2	\N	40
767	164	79	4	5	\N	80
768	165	79	1	1	\N	20
769	166	79	4	5	\N	80
770	172	79	4	5	\N	80
771	173	79	1	1	\N	20
772	174	79	1	1	\N	20
773	175	79	0	0	\N	0
774	105	80	3	5	\N	50
775	106	80	1	1	\N	20
776	117	80	2	2	\N	40
777	118	80	2	2	\N	40
778	123	80	1	2	\N	20
779	124	80	1	2	\N	20
780	185	81	4	6	\N	70
781	186	81	0	0	\N	0
782	187	81	0	0	\N	0
783	119	81	1	1	\N	20
784	120	81	1	1	\N	20
785	121	81	2	2	\N	40
786	122	81	1	2	\N	20
787	161	81	4	5	\N	80
788	162	81	1	1	\N	20
789	163	81	1	3	\N	10
790	125	82	4	4	\N	90
791	126	82	1	1	\N	20
792	127	82	0	0	\N	0
793	153	82	3	4	\N	60
794	154	82	0	0	\N	0
795	164	82	2	2	\N	40
796	165	82	0	0	\N	0
797	166	82	1	1	\N	20
798	146	83	3	5	\N	50
799	143	83	4	4	\N	90
800	144	83	3	3	\N	60
801	145	83	4	4	\N	90
802	107	83	4	5	\N	80
803	108	83	1	1	\N	20
804	109	83	2	2	\N	40
805	110	83	1	1	\N	20
806	130	84	4	4	\N	90
807	131	84	1	1	\N	20
808	132	84	0	1	\N	0
809	133	84	1	1	\N	20
810	111	84	3	5	\N	50
811	112	84	1	1	\N	20
812	113	84	2	3	\N	40
813	180	84	4	5	\N	80
814	181	84	1	1	\N	20
815	184	85	3	4	\N	60
816	104	85	0	2	\N	-10
817	134	85	3	3	\N	60
818	135	85	1	1	\N	20
819	136	85	1	1	\N	20
820	137	85	4	4	\N	90
821	182	86	4	4	\N	90
822	183	86	1	1	\N	20
823	147	86	4	5	\N	80
824	148	86	1	1	\N	20
825	128	86	2	3	\N	40
826	129	86	0	1	\N	0
827	176	87	3	4	\N	60
828	177	87	2	2	\N	40
829	178	87	3	4	\N	60
830	179	87	0	1	\N	0
831	119	87	3	4	\N	60
832	120	87	1	1	\N	20
833	121	87	1	2	\N	20
834	122	87	0	1	\N	0
835	167	87	3	5	\N	50
836	168	87	0	0	\N	0
837	123	88	4	5	\N	80
838	124	88	0	0	\N	0
839	172	88	3	4	\N	60
840	173	88	1	1	\N	20
841	174	88	3	4	\N	60
842	175	88	0	0	\N	0
843	149	88	4	5	\N	80
844	150	88	1	1	\N	20
845	151	88	0	2	\N	-10
846	152	88	0	1	\N	0
847	117	89	0	1	\N	0
848	118	89	0	1	\N	0
849	158	89	3	3	\N	60
850	159	89	2	2	\N	40
851	160	89	3	4	\N	60
852	138	89	4	4	\N	90
853	139	89	0	2	\N	-10
854	140	89	0	0	\N	0
855	155	90	4	4	\N	90
856	156	90	1	2	\N	20
857	157	90	3	3	\N	60
858	169	90	2	4	\N	30
859	170	90	3	3	\N	60
860	171	90	0	0	\N	0
861	141	90	3	6	\N	40
862	142	90	1	2	\N	20
863	114	91	1	1	\N	20
864	115	91	0	0	\N	0
865	116	91	3	3	\N	60
866	185	91	3	3	\N	60
867	186	91	4	6	\N	70
868	187	91	3	5	\N	50
869	105	91	1	2	\N	20
870	106	91	4	4	\N	90
871	153	92	0	0	\N	0
872	154	92	1	1	\N	20
873	164	92	4	6	\N	70
874	165	92	3	5	\N	50
875	166	92	2	3	\N	40
876	146	92	4	5	\N	80
877	141	93	0	3	\N	-20
878	142	93	1	2	\N	20
879	119	93	3	5	\N	50
880	120	93	0	2	\N	-10
881	121	93	0	0	\N	0
882	122	93	1	3	\N	10
883	138	93	0	0	\N	0
884	139	93	0	0	\N	0
885	140	93	0	2	\N	-10
886	149	94	4	5	\N	80
887	150	94	4	4	\N	90
888	151	94	2	3	\N	40
889	152	94	3	3	\N	60
890	134	94	4	6	\N	70
891	135	94	2	2	\N	40
892	136	94	2	3	\N	40
893	137	94	1	1	\N	20
894	117	94	4	5	\N	80
895	118	94	1	3	\N	10
896	169	95	4	6	\N	70
897	170	95	0	1	\N	0
898	171	95	0	0	\N	0
899	104	95	4	4	\N	90
900	172	95	4	4	\N	90
901	173	95	4	4	\N	90
902	174	95	1	3	\N	10
903	175	95	0	0	\N	0
904	123	96	0	0	\N	0
905	124	96	1	1	\N	20
906	143	96	3	6	\N	40
907	144	96	1	1	\N	20
908	145	96	3	3	\N	60
909	128	96	3	5	\N	50
910	129	96	2	2	\N	40
911	184	97	3	4	\N	60
912	185	97	4	4	\N	90
913	186	97	1	1	\N	20
914	187	97	0	0	\N	0
915	180	97	3	3	\N	60
916	181	97	2	2	\N	40
917	125	98	4	4	\N	90
918	126	98	0	1	\N	0
919	127	98	3	3	\N	60
920	167	98	2	4	\N	30
921	168	98	1	1	\N	20
922	158	98	3	5	\N	50
923	159	98	0	1	\N	0
924	160	98	4	4	\N	90
925	130	99	3	4	\N	60
926	131	99	0	0	\N	0
927	132	99	0	0	\N	0
928	133	99	1	2	\N	20
929	147	99	2	4	\N	30
930	148	99	1	2	\N	20
931	107	99	4	5	\N	80
932	108	99	0	2	\N	-10
933	109	99	2	3	\N	40
934	110	99	0	0	\N	0
935	105	100	3	4	\N	60
936	106	100	1	1	\N	20
937	155	100	4	5	\N	80
938	156	100	2	2	\N	40
939	157	100	1	1	\N	20
940	111	100	4	5	\N	80
941	112	100	2	3	\N	40
942	113	100	1	1	\N	20
943	161	101	1	1	\N	20
944	162	101	1	1	\N	20
945	163	101	3	4	\N	60
946	176	101	4	6	\N	70
947	177	101	2	2	\N	40
948	178	101	2	2	\N	40
949	179	101	3	3	\N	60
950	182	101	3	3	\N	60
951	183	101	0	0	\N	0
952	114	102	3	4	\N	60
953	115	102	1	1	\N	20
954	116	102	0	0	\N	0
955	184	102	1	3	\N	10
956	155	102	3	4	\N	60
957	156	102	0	0	\N	0
958	157	102	0	0	\N	0
959	104	103	3	5	\N	50
960	141	103	4	5	\N	80
961	142	103	1	1	\N	20
962	158	103	1	2	\N	20
963	159	103	1	2	\N	20
964	160	103	4	4	\N	90
965	117	104	4	4	\N	90
966	118	104	1	1	\N	20
967	130	104	2	3	\N	40
968	131	104	4	4	\N	90
969	132	104	2	2	\N	40
970	133	104	2	2	\N	40
971	107	104	0	2	\N	-10
972	108	104	1	3	\N	10
973	109	104	1	1	\N	20
974	110	104	3	3	\N	60
975	180	105	4	5	\N	80
976	181	105	0	0	\N	0
977	164	105	4	6	\N	70
978	165	105	1	1	\N	20
979	166	105	1	3	\N	10
980	153	105	4	5	\N	80
981	154	105	1	2	\N	20
982	138	106	4	6	\N	70
983	139	106	0	0	\N	0
984	140	106	3	3	\N	60
985	172	106	4	5	\N	80
986	173	106	2	3	\N	40
987	174	106	0	0	\N	0
988	175	106	0	1	\N	0
989	161	106	4	4	\N	90
990	162	106	0	0	\N	0
991	163	106	4	4	\N	90
992	176	107	4	5	\N	80
993	177	107	1	1	\N	20
994	178	107	3	3	\N	60
995	179	107	3	3	\N	60
996	146	107	4	6	\N	70
997	147	107	2	2	\N	40
998	148	107	1	2	\N	20
999	182	108	4	6	\N	70
1000	183	108	2	2	\N	40
1001	125	108	0	1	\N	0
1002	126	108	4	6	\N	70
1003	127	108	3	3	\N	60
1004	119	108	0	0	\N	0
1005	120	108	1	2	\N	20
1006	121	108	2	4	\N	30
1007	122	108	0	0	\N	0
1008	123	109	1	3	\N	10
1009	124	109	1	1	\N	20
1010	149	109	3	5	\N	50
1011	150	109	4	5	\N	80
1012	151	109	2	2	\N	40
1013	152	109	3	3	\N	60
1014	111	109	0	3	\N	-20
1015	112	109	1	1	\N	20
1016	113	109	3	3	\N	60
1017	128	110	4	5	\N	80
1018	129	110	2	2	\N	40
1019	114	110	4	4	\N	90
1020	115	110	0	1	\N	0
1021	116	110	1	3	\N	10
1022	134	110	4	4	\N	90
1023	135	110	0	1	\N	0
1024	136	110	1	1	\N	20
1025	137	110	1	1	\N	20
1026	143	111	4	6	\N	70
1027	144	111	4	5	\N	80
1028	145	111	4	4	\N	90
1029	105	111	3	3	\N	60
1030	106	111	0	0	\N	0
1031	185	111	3	6	\N	40
1032	186	111	2	2	\N	40
1033	187	111	1	1	\N	20
1034	167	112	4	6	\N	70
1035	168	112	0	2	\N	-10
1036	169	112	2	3	\N	40
1037	170	112	3	3	\N	60
1038	171	112	1	2	\N	20
1039	172	112	4	5	\N	80
1040	173	112	0	0	\N	0
1041	174	112	1	3	\N	10
1042	175	112	0	1	\N	0
1043	143	113	4	4	\N	90
1044	144	113	1	1	\N	20
1045	145	113	2	4	\N	30
1046	161	113	2	5	\N	20
1047	162	113	0	1	\N	0
1048	163	113	4	5	\N	80
1049	107	113	1	2	\N	20
1050	108	113	1	3	\N	10
1051	109	113	1	1	\N	20
1052	110	113	0	0	\N	0
1053	114	114	0	0	\N	0
1054	115	114	3	4	\N	60
1055	116	114	1	1	\N	20
1056	180	114	4	6	\N	70
1057	181	114	2	2	\N	40
1058	153	114	1	1	\N	20
1059	154	114	1	2	\N	20
1060	184	115	4	5	\N	80
1061	149	115	3	5	\N	50
1062	150	115	0	1	\N	0
1063	151	115	1	3	\N	10
1064	152	115	2	2	\N	40
1065	169	115	3	4	\N	60
1066	170	115	3	3	\N	60
1067	171	115	1	3	\N	10
1068	117	116	3	6	\N	40
1069	118	116	1	2	\N	20
1070	138	116	4	4	\N	90
1071	139	116	1	1	\N	20
1072	140	116	4	4	\N	90
1073	111	116	2	4	\N	30
1074	112	116	2	3	\N	40
1075	113	116	3	3	\N	60
1076	130	117	2	3	\N	40
1077	131	117	2	2	\N	40
1078	132	117	1	1	\N	20
1079	133	117	1	1	\N	20
1080	141	117	0	3	\N	-20
1081	142	117	1	1	\N	20
1082	104	117	4	6	\N	70
1083	123	118	3	4	\N	60
1084	124	118	0	0	\N	0
1085	134	118	1	1	\N	20
1086	135	118	2	3	\N	40
1087	136	118	1	1	\N	20
1088	137	118	0	0	\N	0
1089	167	118	4	6	\N	70
1090	168	118	4	5	\N	80
1091	182	119	4	5	\N	80
1092	183	119	2	2	\N	40
1093	147	119	0	1	\N	0
1094	148	119	1	1	\N	20
1095	176	119	2	5	\N	20
1096	177	119	2	3	\N	40
1097	178	119	0	0	\N	0
1098	179	119	0	0	\N	0
1099	128	120	1	4	\N	0
1100	129	120	0	0	\N	0
1101	185	120	3	4	\N	60
1102	186	120	0	0	\N	0
1103	187	120	3	5	\N	50
1104	158	120	4	5	\N	80
1105	159	120	1	2	\N	20
1106	160	120	3	5	\N	50
1107	105	121	3	3	\N	60
1108	106	121	4	6	\N	70
1109	164	121	3	6	\N	40
1110	165	121	1	3	\N	10
1111	166	121	2	2	\N	40
1112	119	121	2	3	\N	40
1113	120	121	2	4	\N	30
1114	121	121	0	2	\N	-10
1115	122	121	2	3	\N	40
1116	125	122	4	5	\N	80
1117	126	122	1	2	\N	20
1118	127	122	2	2	\N	40
1119	155	122	0	0	\N	0
1120	156	122	0	2	\N	-10
1121	157	122	2	2	\N	40
1122	146	122	3	4	\N	60
1123	250	124	2	3	\N	40
1124	251	124	0	0	\N	0
1125	252	124	1	2	\N	20
1126	253	124	0	1	\N	0
1127	236	124	3	5	\N	50
1128	237	124	4	6	\N	70
1129	238	124	3	3	\N	60
1130	239	124	1	1	\N	20
1131	221	124	3	4	\N	60
1132	222	124	1	3	\N	10
1133	223	124	1	1	\N	20
1134	224	124	1	1	\N	20
1135	191	125	4	4	\N	90
1136	192	125	0	1	\N	0
1137	193	125	0	0	\N	0
1138	229	125	3	3	\N	60
1139	230	125	1	3	\N	10
1140	231	125	2	3	\N	40
1141	232	125	3	3	\N	60
1142	188	125	4	4	\N	90
1143	189	125	2	2	\N	40
1144	190	125	0	0	\N	0
1145	217	126	1	2	\N	20
1146	218	126	2	2	\N	40
1147	219	126	3	3	\N	60
1148	220	126	2	2	\N	40
1149	254	126	3	3	\N	60
1150	255	126	4	5	\N	80
1151	256	126	1	1	\N	20
1152	233	126	1	1	\N	20
1153	234	126	3	5	\N	50
1154	235	126	2	3	\N	40
1155	207	127	3	4	\N	60
1156	208	127	0	1	\N	0
1157	209	127	1	1	\N	20
1158	213	127	0	0	\N	0
1159	214	127	4	4	\N	90
1160	215	127	4	4	\N	90
1161	216	127	0	2	\N	-10
1162	210	127	4	4	\N	90
1163	211	127	4	5	\N	80
1164	212	127	4	4	\N	90
1165	198	128	4	5	\N	80
1166	199	128	1	3	\N	10
1167	200	128	1	1	\N	20
1168	247	128	4	5	\N	80
1169	248	128	2	4	\N	30
1170	249	128	0	0	\N	0
1171	204	128	4	5	\N	80
1172	205	128	0	1	\N	0
1173	206	128	0	0	\N	0
1174	194	129	2	5	\N	20
1175	195	129	2	3	\N	40
1176	196	129	4	6	\N	70
1177	197	129	1	1	\N	20
1178	225	129	4	4	\N	90
1179	226	129	0	0	\N	0
1180	227	129	1	1	\N	20
1181	228	129	3	4	\N	60
1182	201	129	3	6	\N	40
1183	202	129	1	1	\N	20
1184	203	129	1	1	\N	20
1185	240	130	0	2	\N	-10
1186	241	130	1	2	\N	20
1187	242	130	1	1	\N	20
1188	243	130	0	0	\N	0
1189	244	130	4	5	\N	80
1190	245	130	4	4	\N	90
1191	246	130	2	4	\N	30
1192	225	130	1	1	\N	20
1193	226	130	0	1	\N	0
1194	227	130	2	2	\N	40
1195	228	130	4	4	\N	90
1196	254	131	3	3	\N	60
1197	255	131	0	0	\N	0
1198	256	131	4	6	\N	70
1199	221	131	0	1	\N	0
1200	222	131	1	1	\N	20
1201	223	131	2	2	\N	40
1202	224	131	3	3	\N	60
1203	213	131	4	4	\N	90
1204	214	131	1	3	\N	10
1205	215	131	2	2	\N	40
1206	216	131	2	2	\N	40
1207	217	132	1	1	\N	20
1208	218	132	1	3	\N	10
1209	219	132	4	4	\N	90
1210	220	132	1	3	\N	10
1211	210	132	4	4	\N	90
1212	211	132	2	2	\N	40
1213	212	132	0	2	\N	-10
1214	194	132	2	4	\N	30
1215	195	132	4	6	\N	70
1216	196	132	0	1	\N	0
1217	197	132	1	1	\N	20
1218	244	133	2	4	\N	30
1219	245	133	1	1	\N	20
1220	246	133	1	1	\N	20
1221	204	133	3	6	\N	40
1222	205	133	0	1	\N	0
1223	206	133	4	4	\N	90
1224	229	133	4	4	\N	90
1225	230	133	1	1	\N	20
1226	231	133	1	2	\N	20
1227	232	133	3	3	\N	60
1228	247	134	2	3	\N	40
1229	248	134	1	2	\N	20
1230	249	134	2	2	\N	40
1231	201	134	4	5	\N	80
1232	202	134	3	3	\N	60
1233	203	134	0	0	\N	0
1234	233	134	1	2	\N	20
1235	234	134	0	0	\N	0
1236	235	134	1	1	\N	20
1237	191	135	3	4	\N	60
1238	192	135	2	4	\N	30
1239	193	135	2	2	\N	40
1240	198	135	4	4	\N	90
1241	199	135	1	1	\N	20
1242	200	135	3	3	\N	60
1243	207	135	4	4	\N	90
1244	208	135	0	0	\N	0
1245	209	135	2	3	\N	40
1246	250	136	1	2	\N	20
1247	251	136	4	4	\N	90
1248	252	136	1	1	\N	20
1249	253	136	0	0	\N	0
1250	188	136	3	4	\N	60
1251	189	136	1	1	\N	20
1252	190	136	1	1	\N	20
1253	236	136	1	2	\N	20
1254	237	136	3	3	\N	60
1255	238	136	1	2	\N	20
1256	239	136	0	2	\N	-10
1257	240	137	4	4	\N	90
1258	241	137	1	1	\N	20
1259	242	137	2	3	\N	40
1260	243	137	1	3	\N	10
1261	244	137	1	1	\N	20
1262	245	137	2	3	\N	40
1263	246	137	0	0	\N	0
1264	247	137	1	2	\N	20
1265	248	137	0	0	\N	0
1266	249	137	0	1	\N	0
1267	194	138	3	3	\N	60
1268	195	138	0	0	\N	0
1269	196	138	2	3	\N	40
1270	197	138	0	0	\N	0
1271	221	138	3	3	\N	60
1272	222	138	1	1	\N	20
1273	223	138	1	3	\N	10
1274	224	138	0	0	\N	0
1275	198	138	3	3	\N	60
1276	199	138	3	3	\N	60
1277	200	138	4	4	\N	90
1278	188	139	3	3	\N	60
1279	189	139	0	0	\N	0
1280	190	139	2	2	\N	40
1281	250	139	1	1	\N	20
1282	251	139	1	1	\N	20
1283	252	139	0	1	\N	0
1284	253	139	1	1	\N	20
1285	213	139	4	6	\N	70
1286	214	139	1	1	\N	20
1287	215	139	2	2	\N	40
1288	216	139	4	4	\N	90
1289	236	140	0	1	\N	0
1290	237	140	0	0	\N	0
1291	238	140	0	2	\N	-10
1292	239	140	3	3	\N	60
1293	201	140	4	4	\N	90
1294	202	140	0	0	\N	0
1295	203	140	1	1	\N	20
1296	191	140	3	5	\N	50
1297	192	140	1	1	\N	20
1298	193	140	0	2	\N	-10
1299	217	141	0	3	\N	-20
1300	218	141	2	2	\N	40
1301	219	141	4	4	\N	90
1302	220	141	2	2	\N	40
1303	229	141	2	5	\N	20
1304	230	141	0	1	\N	0
1305	231	141	1	1	\N	20
1306	232	141	3	3	\N	60
1307	207	141	3	6	\N	40
1308	208	141	4	4	\N	90
1309	209	141	1	1	\N	20
1310	204	142	4	4	\N	90
1311	205	142	2	3	\N	40
1312	206	142	3	4	\N	60
1313	233	142	4	4	\N	90
1314	234	142	2	2	\N	40
1315	235	142	0	2	\N	-10
1316	225	142	3	5	\N	50
1317	226	142	1	3	\N	10
1318	227	142	2	2	\N	40
1319	228	142	2	2	\N	40
1320	254	143	2	5	\N	20
1321	255	143	2	2	\N	40
1322	256	143	1	2	\N	20
1323	210	143	1	3	\N	10
1324	211	143	0	0	\N	0
1325	212	143	4	4	\N	90
1326	240	143	0	0	\N	0
1327	241	143	1	1	\N	20
1328	242	143	1	1	\N	20
1329	243	143	2	2	\N	40
1330	213	144	4	4	\N	90
1331	214	144	1	1	\N	20
1332	215	144	0	0	\N	0
1333	216	144	0	0	\N	0
1334	247	144	3	6	\N	40
1335	248	144	1	1	\N	20
1336	249	144	0	0	\N	0
1337	254	144	1	3	\N	10
1338	255	144	0	0	\N	0
1339	256	144	0	0	\N	0
1340	198	145	4	6	\N	70
1341	199	145	4	4	\N	90
1342	200	145	2	2	\N	40
1343	191	145	4	4	\N	90
1344	192	145	1	1	\N	20
1345	193	145	0	1	\N	0
1346	240	145	0	2	\N	-10
1347	241	145	4	4	\N	90
1348	242	145	1	2	\N	20
1349	243	145	4	6	\N	70
1350	233	146	4	5	\N	80
1351	234	146	3	5	\N	50
1352	235	146	4	4	\N	90
1353	204	146	2	3	\N	40
1354	205	146	4	4	\N	90
1355	206	146	2	3	\N	40
1356	210	146	0	1	\N	0
1357	211	146	0	0	\N	0
1358	212	146	3	3	\N	60
1359	194	147	0	0	\N	0
1360	195	147	2	2	\N	40
1361	196	147	2	4	\N	30
1362	197	147	1	1	\N	20
1363	225	147	1	1	\N	20
1364	226	147	0	1	\N	0
1365	227	147	2	3	\N	40
1366	228	147	0	0	\N	0
1367	229	147	2	4	\N	30
1368	230	147	1	1	\N	20
1369	231	147	0	0	\N	0
1370	232	147	1	2	\N	20
1371	244	148	2	2	\N	40
1372	245	148	0	1	\N	0
1373	246	148	2	4	\N	30
1374	236	148	0	2	\N	-10
1375	237	148	4	4	\N	90
1376	238	148	3	4	\N	60
1377	239	148	2	3	\N	40
1378	188	148	4	4	\N	90
1379	189	148	2	3	\N	40
1380	190	148	2	2	\N	40
1381	221	149	2	3	\N	40
1382	222	149	1	3	\N	10
1383	223	149	0	1	\N	0
1384	224	149	2	2	\N	40
1385	201	149	3	3	\N	60
1386	202	149	0	0	\N	0
1387	203	149	0	1	\N	0
1388	207	149	4	4	\N	90
1389	208	149	0	2	\N	-10
1390	209	149	2	2	\N	40
1391	217	150	4	5	\N	80
1392	218	150	0	1	\N	0
1393	219	150	0	0	\N	0
1394	220	150	2	2	\N	40
1395	250	150	3	5	\N	50
1396	251	150	0	1	\N	0
1397	252	150	3	3	\N	60
1398	253	150	1	1	\N	20
1399	229	150	2	3	\N	40
1400	230	150	1	3	\N	10
1401	231	150	1	3	\N	10
1402	232	150	0	0	\N	0
1403	221	151	4	5	\N	80
1404	222	151	0	1	\N	0
1405	223	151	0	1	\N	0
1406	224	151	0	1	\N	0
1407	236	151	1	2	\N	20
1408	237	151	3	3	\N	60
1409	238	151	0	0	\N	0
1410	239	151	0	0	\N	0
1411	250	151	1	4	\N	0
1412	251	151	2	2	\N	40
1413	252	151	3	4	\N	60
1414	253	151	0	0	\N	0
1415	194	152	4	5	\N	80
1416	195	152	2	3	\N	40
1417	196	152	1	3	\N	10
1418	197	152	0	1	\N	0
1419	204	152	4	5	\N	80
1420	205	152	4	5	\N	80
1421	206	152	0	0	\N	0
1422	207	152	0	0	\N	0
1423	208	152	4	5	\N	80
1424	209	152	0	1	\N	0
1425	225	153	4	4	\N	90
1426	226	153	2	2	\N	40
1427	227	153	2	2	\N	40
1428	228	153	2	2	\N	40
1429	247	153	4	4	\N	90
1430	248	153	2	2	\N	40
1431	249	153	2	2	\N	40
1432	188	153	0	2	\N	-10
1433	189	153	2	2	\N	40
1434	190	153	0	0	\N	0
1435	201	154	3	6	\N	40
1436	202	154	0	0	\N	0
1437	203	154	3	5	\N	50
1438	233	154	4	4	\N	90
1439	234	154	2	2	\N	40
1440	235	154	2	3	\N	40
1441	213	154	1	2	\N	20
1442	214	154	0	0	\N	0
1443	215	154	2	2	\N	40
1444	216	154	4	4	\N	90
1445	191	155	2	2	\N	40
1446	192	155	0	0	\N	0
1447	193	155	0	0	\N	0
1448	254	155	4	4	\N	90
1449	255	155	0	0	\N	0
1450	256	155	3	3	\N	60
1451	210	155	4	5	\N	80
1452	211	155	4	5	\N	80
1453	212	155	1	2	\N	20
1454	244	156	4	6	\N	70
1455	245	156	4	4	\N	90
1456	246	156	3	3	\N	60
1457	198	156	1	1	\N	20
1458	199	156	2	2	\N	40
1459	200	156	3	5	\N	50
1460	217	156	0	0	\N	0
1461	218	156	0	2	\N	-10
1462	219	156	0	0	\N	0
1463	220	156	0	0	\N	0
1464	240	157	4	4	\N	90
1465	241	157	0	0	\N	0
1466	242	157	0	0	\N	0
1467	243	157	2	2	\N	40
1468	240	157	0	0	\N	0
1469	241	157	0	2	\N	-10
1470	242	157	2	3	\N	40
1471	243	157	3	3	\N	60
1472	201	157	3	4	\N	60
1473	202	157	1	1	\N	20
1474	203	157	2	2	\N	40
1475	204	158	4	4	\N	90
1476	205	158	2	2	\N	40
1477	206	158	3	4	\N	60
1478	207	158	3	3	\N	60
1479	208	158	1	1	\N	20
1480	209	158	0	0	\N	0
1481	254	158	4	6	\N	70
1482	255	158	0	0	\N	0
1483	256	158	0	2	\N	-10
1484	225	159	4	4	\N	90
1485	226	159	0	2	\N	-10
1486	227	159	2	2	\N	40
1487	228	159	3	3	\N	60
1488	233	159	3	4	\N	60
1489	234	159	0	1	\N	0
1490	235	159	1	1	\N	20
1491	213	159	4	6	\N	70
1492	214	159	0	2	\N	-10
1493	215	159	1	2	\N	20
1494	216	159	4	4	\N	90
1495	221	160	1	3	\N	10
1496	222	160	2	2	\N	40
1497	223	160	0	1	\N	0
1498	224	160	4	4	\N	90
1499	229	160	2	2	\N	40
1500	230	160	1	1	\N	20
1501	231	160	2	2	\N	40
1502	232	160	3	3	\N	60
1503	210	160	4	4	\N	90
1504	211	160	0	0	\N	0
1505	212	160	2	3	\N	40
1506	188	161	3	4	\N	60
1507	189	161	1	1	\N	20
1508	190	161	1	2	\N	20
1509	236	161	4	5	\N	80
1510	237	161	2	2	\N	40
1511	238	161	0	0	\N	0
1512	239	161	2	2	\N	40
1513	247	161	2	3	\N	40
1514	248	161	1	1	\N	20
1515	249	161	2	2	\N	40
1516	191	162	3	6	\N	40
1517	192	162	1	2	\N	20
1518	193	162	0	0	\N	0
1519	244	162	3	3	\N	60
1520	245	162	2	4	\N	30
1521	246	162	4	5	\N	80
1522	194	162	4	5	\N	80
1523	195	162	3	3	\N	60
1524	196	162	1	2	\N	20
1525	197	162	4	6	\N	70
1526	217	163	4	6	\N	70
1527	218	163	2	2	\N	40
1528	219	163	2	2	\N	40
1529	220	163	0	0	\N	0
1530	250	163	1	2	\N	20
1531	251	163	2	3	\N	40
1532	252	163	2	2	\N	40
1533	253	163	1	1	\N	20
1534	198	163	3	3	\N	60
1535	199	163	2	2	\N	40
1536	200	163	0	1	\N	0
1537	62	164	4	6	\N	70
1538	63	164	0	1	\N	0
1539	64	164	1	1	\N	20
1540	58	164	2	4	\N	30
1541	59	164	2	2	\N	40
1542	60	164	0	1	\N	0
1543	61	164	2	2	\N	40
1544	1	164	2	3	\N	40
1545	2	164	2	2	\N	40
1546	3	164	4	4	\N	90
1547	4	165	3	3	\N	60
1548	5	165	1	1	\N	20
1549	6	165	0	1	\N	0
1550	7	165	0	1	\N	0
1551	33	165	3	3	\N	60
1552	34	165	3	4	\N	60
1553	35	165	2	3	\N	40
1554	36	165	0	0	\N	0
1555	45	165	1	1	\N	20
1556	46	165	2	3	\N	40
1557	47	165	0	0	\N	0
1558	42	166	4	4	\N	90
1559	43	166	0	0	\N	0
1560	44	166	2	3	\N	40
1561	69	166	0	2	\N	-10
1562	70	166	1	2	\N	20
1563	71	166	3	3	\N	60
1564	86	166	3	4	\N	60
1565	87	166	3	4	\N	60
1566	88	166	0	1	\N	0
1567	96	167	3	4	\N	60
1568	97	167	0	0	\N	0
1569	98	167	1	1	\N	20
1570	99	167	1	1	\N	20
1571	48	167	0	2	\N	-10
1572	49	167	0	0	\N	0
1573	50	167	3	3	\N	60
1574	92	167	3	5	\N	50
1575	93	167	0	0	\N	0
1576	94	167	0	0	\N	0
1577	95	167	0	2	\N	-10
1578	15	168	3	4	\N	60
1579	16	168	0	0	\N	0
1580	17	168	2	3	\N	40
1581	18	168	2	2	\N	40
1582	83	168	4	5	\N	80
1583	84	168	1	1	\N	20
1584	85	168	4	4	\N	90
1585	80	168	1	4	\N	0
1586	81	168	1	2	\N	20
1587	82	168	2	4	\N	30
1588	89	169	3	4	\N	60
1589	90	169	0	0	\N	0
1590	91	169	0	0	\N	0
1591	51	169	4	5	\N	80
1592	52	169	2	2	\N	40
1593	53	169	2	3	\N	40
1594	65	169	4	5	\N	80
1595	66	169	0	0	\N	0
1596	67	169	0	0	\N	0
1597	68	169	1	2	\N	20
1598	76	170	2	4	\N	30
1599	77	170	2	3	\N	40
1600	78	170	2	2	\N	40
1601	79	170	3	5	\N	50
1602	12	170	3	4	\N	60
1603	13	170	3	4	\N	60
1604	14	170	2	2	\N	40
1605	8	170	4	6	\N	70
1606	9	170	0	1	\N	0
1607	10	170	1	1	\N	20
1608	11	170	1	1	\N	20
1609	28	171	2	4	\N	30
1610	29	171	1	1	\N	20
1611	30	171	0	0	\N	0
1612	31	171	1	1	\N	20
1613	32	171	0	1	\N	0
1614	22	171	0	2	\N	-10
1615	23	171	3	3	\N	60
1616	24	171	1	3	\N	10
1617	37	171	4	6	\N	70
1618	38	171	1	1	\N	20
1619	39	171	1	1	\N	20
1620	40	171	2	2	\N	40
1621	41	171	2	2	\N	40
1622	25	172	1	1	\N	20
1623	26	172	2	2	\N	40
1624	27	172	1	1	\N	20
1625	100	172	4	4	\N	90
1626	101	172	0	0	\N	0
1627	102	172	1	2	\N	20
1628	103	172	4	4	\N	90
1629	72	172	4	4	\N	90
1630	73	172	1	1	\N	20
1631	74	172	2	2	\N	40
1632	75	172	1	2	\N	20
1633	19	173	4	5	\N	80
1634	20	173	1	1	\N	20
1635	21	173	0	0	\N	0
1636	54	173	2	2	\N	40
1637	55	173	1	1	\N	20
1638	56	173	3	3	\N	60
1639	57	173	2	2	\N	40
1640	37	173	3	5	\N	50
1641	38	173	1	1	\N	20
1642	39	173	0	0	\N	0
1643	40	173	0	1	\N	0
1644	41	173	3	3	\N	60
1645	48	174	4	6	\N	70
1646	49	174	0	2	\N	-10
1647	50	174	3	4	\N	60
1648	33	174	3	5	\N	50
1649	34	174	4	4	\N	90
1650	35	174	0	2	\N	-10
1651	36	174	0	0	\N	0
1652	80	174	0	1	\N	0
1653	81	174	0	1	\N	0
1654	82	174	0	0	\N	0
1655	51	175	0	2	\N	-10
1656	52	175	1	1	\N	20
1657	53	175	0	2	\N	-10
1658	89	175	3	5	\N	50
1659	90	175	1	3	\N	10
1660	91	175	2	2	\N	40
1661	25	175	4	5	\N	80
1662	26	175	2	2	\N	40
1663	27	175	2	3	\N	40
1664	83	176	4	4	\N	90
1665	84	176	4	4	\N	90
1666	85	176	0	0	\N	0
1667	19	176	4	5	\N	80
1668	20	176	0	1	\N	0
1669	21	176	0	2	\N	-10
1670	92	176	3	3	\N	60
1671	93	176	0	0	\N	0
1672	94	176	0	0	\N	0
1673	95	176	4	4	\N	90
1674	28	177	4	4	\N	90
1675	29	177	3	3	\N	60
1676	30	177	0	1	\N	0
1677	31	177	0	0	\N	0
1678	32	177	0	0	\N	0
1679	45	177	3	5	\N	50
1680	46	177	1	1	\N	20
1681	47	177	0	0	\N	0
1682	15	177	4	4	\N	90
1683	16	177	3	3	\N	60
1684	17	177	0	1	\N	0
1685	18	177	0	0	\N	0
1686	76	178	4	6	\N	70
1687	77	178	0	0	\N	0
1688	78	178	2	2	\N	40
1689	79	178	2	3	\N	40
1690	72	178	4	5	\N	80
1691	73	178	3	4	\N	60
1692	74	178	0	1	\N	0
1693	75	178	0	0	\N	0
1694	1	178	3	3	\N	60
1695	2	178	0	1	\N	0
1696	3	178	2	2	\N	40
1697	100	179	1	2	\N	20
1698	101	179	1	1	\N	20
1699	102	179	0	0	\N	0
1700	103	179	2	2	\N	40
1701	96	179	0	2	\N	-10
1702	97	179	2	3	\N	40
1703	98	179	0	0	\N	0
1704	99	179	0	1	\N	0
1705	12	179	4	4	\N	90
1706	13	179	0	0	\N	0
1707	14	179	3	4	\N	60
1708	54	180	3	5	\N	50
1709	55	180	3	3	\N	60
1710	56	180	0	0	\N	0
1711	57	180	2	2	\N	40
1712	8	180	4	4	\N	90
1713	9	180	2	3	\N	40
1714	10	180	2	2	\N	40
1715	11	180	2	2	\N	40
1716	22	180	4	4	\N	90
1717	23	180	4	4	\N	90
1718	24	180	1	1	\N	20
1719	58	181	3	6	\N	40
1720	59	181	2	2	\N	40
1721	60	181	2	4	\N	30
1722	61	181	0	0	\N	0
1723	42	181	3	4	\N	60
1724	43	181	0	1	\N	0
1725	44	181	0	0	\N	0
1726	65	181	3	4	\N	60
1727	66	181	0	0	\N	0
1728	67	181	3	5	\N	50
1729	68	181	0	1	\N	0
1730	86	182	4	5	\N	80
1731	87	182	3	4	\N	60
1732	88	182	2	3	\N	40
1733	4	182	3	4	\N	60
1734	5	182	0	0	\N	0
1735	6	182	1	1	\N	20
1736	7	182	1	1	\N	20
1737	62	182	1	2	\N	20
1738	63	182	3	3	\N	60
1739	64	182	0	2	\N	-10
1740	69	183	2	2	\N	40
1741	70	183	4	5	\N	80
1742	71	183	0	1	\N	0
1743	51	183	3	3	\N	60
1744	52	183	1	1	\N	20
1745	53	183	1	1	\N	20
1746	54	183	1	4	\N	0
1747	55	183	4	6	\N	70
1748	56	183	0	0	\N	0
1749	57	183	0	1	\N	0
1750	48	184	0	1	\N	0
1751	49	184	0	0	\N	0
1752	50	184	0	0	\N	0
1753	86	184	3	4	\N	60
1754	87	184	3	5	\N	50
1755	88	184	1	2	\N	20
1756	76	184	2	2	\N	40
1757	77	184	1	1	\N	20
1758	78	184	2	2	\N	40
1759	79	184	0	0	\N	0
1760	22	185	4	4	\N	90
1761	23	185	1	1	\N	20
1762	24	185	4	4	\N	90
1763	72	185	3	3	\N	60
1764	73	185	1	1	\N	20
1765	74	185	0	0	\N	0
1766	75	185	0	1	\N	0
1767	62	185	2	4	\N	30
1768	63	185	1	1	\N	20
1769	64	185	3	4	\N	60
1770	96	186	4	5	\N	80
1771	97	186	0	0	\N	0
1772	98	186	0	0	\N	0
1773	99	186	1	1	\N	20
1774	45	186	3	3	\N	60
1775	46	186	1	3	\N	10
1776	47	186	0	2	\N	-10
1777	4	186	0	0	\N	0
1778	5	186	4	4	\N	90
1779	6	186	0	1	\N	0
1780	7	186	0	0	\N	0
1781	12	187	4	5	\N	80
1782	13	187	1	1	\N	20
1783	14	187	0	0	\N	0
1784	89	187	4	5	\N	80
1785	90	187	1	1	\N	20
1786	91	187	2	2	\N	40
1787	58	187	3	3	\N	60
1788	59	187	3	3	\N	60
1789	60	187	1	1	\N	20
1790	61	187	2	2	\N	40
1791	19	188	3	4	\N	60
1792	20	188	1	1	\N	20
1793	21	188	1	1	\N	20
1794	83	188	3	4	\N	60
1795	84	188	2	3	\N	40
1796	85	188	0	2	\N	-10
1797	28	188	0	3	\N	-20
1798	29	188	3	4	\N	60
1799	30	188	2	3	\N	40
1800	31	188	4	6	\N	70
1801	32	188	4	4	\N	90
1802	69	189	2	4	\N	30
1803	70	189	2	2	\N	40
1804	71	189	2	2	\N	40
1805	37	189	2	4	\N	30
1806	38	189	1	3	\N	10
1807	39	189	0	1	\N	0
1808	40	189	3	3	\N	60
1809	41	189	0	2	\N	-10
1810	80	189	4	5	\N	80
1811	81	189	2	2	\N	40
1812	82	189	1	1	\N	20
1813	42	190	4	4	\N	90
1814	43	190	1	1	\N	20
1815	44	190	1	1	\N	20
1816	33	190	4	4	\N	90
1817	34	190	1	2	\N	20
1818	35	190	2	2	\N	40
1819	36	190	0	0	\N	0
1820	15	190	4	6	\N	70
1821	16	190	0	0	\N	0
1822	17	190	1	1	\N	20
1823	18	190	1	1	\N	20
1824	25	191	4	4	\N	90
1825	26	191	1	1	\N	20
1826	27	191	0	0	\N	0
1827	100	191	3	3	\N	60
1828	101	191	3	3	\N	60
1829	102	191	0	1	\N	0
1830	103	191	0	0	\N	0
1831	1	191	2	3	\N	40
1832	2	191	0	2	\N	-10
1833	3	191	2	2	\N	40
1834	92	192	4	4	\N	90
1835	93	192	3	3	\N	60
1836	94	192	1	2	\N	20
1837	95	192	0	0	\N	0
1838	65	192	4	5	\N	80
1839	66	192	0	1	\N	0
1840	67	192	2	3	\N	40
1841	68	192	0	1	\N	0
1842	8	192	4	5	\N	80
1843	9	192	1	1	\N	20
1844	10	192	1	2	\N	20
1845	11	192	1	2	\N	20
1846	65	193	4	4	\N	90
1847	66	193	0	1	\N	0
1848	67	193	1	3	\N	10
1849	68	193	1	1	\N	20
1850	96	193	4	6	\N	70
1851	97	193	2	2	\N	40
1852	98	193	1	1	\N	20
1853	99	193	2	3	\N	40
1854	89	193	1	2	\N	20
1855	90	193	1	1	\N	20
1856	91	193	4	5	\N	80
1857	92	194	1	2	\N	20
1858	93	194	1	1	\N	20
1859	94	194	0	0	\N	0
1860	95	194	0	2	\N	-10
1861	48	194	4	5	\N	80
1862	49	194	4	6	\N	70
1863	50	194	1	1	\N	20
1864	33	194	1	3	\N	10
1865	34	194	2	2	\N	40
1866	35	194	1	1	\N	20
1867	36	194	1	2	\N	20
1868	100	195	2	4	\N	30
1869	101	195	3	3	\N	60
1870	102	195	4	6	\N	70
1871	103	195	4	4	\N	90
1872	54	195	4	4	\N	90
1873	55	195	0	0	\N	0
1874	56	195	1	3	\N	10
1875	57	195	3	3	\N	60
1876	42	195	3	4	\N	60
1877	43	195	2	4	\N	30
1878	44	195	0	2	\N	-10
1879	86	196	4	4	\N	90
1880	87	196	2	3	\N	40
1881	88	196	2	2	\N	40
1882	15	196	3	4	\N	60
1883	16	196	1	1	\N	20
1884	17	196	2	3	\N	40
1885	18	196	1	1	\N	20
1886	12	196	0	0	\N	0
1887	13	196	0	1	\N	0
1888	14	196	1	1	\N	20
1889	19	197	4	4	\N	90
1890	20	197	4	4	\N	90
1891	21	197	2	2	\N	40
1892	72	197	2	5	\N	20
1893	73	197	4	5	\N	80
1894	74	197	0	0	\N	0
1895	75	197	0	2	\N	-10
1896	76	197	3	3	\N	60
1897	77	197	0	0	\N	0
1898	78	197	3	4	\N	60
1899	79	197	0	0	\N	0
1900	80	198	3	4	\N	60
1901	81	198	3	3	\N	60
1902	82	198	1	1	\N	20
1903	8	198	3	4	\N	60
1904	9	198	0	0	\N	0
1905	10	198	1	3	\N	10
1906	11	198	1	1	\N	20
1907	69	198	2	2	\N	40
1908	70	198	0	0	\N	0
1909	71	198	0	1	\N	0
1910	58	199	4	5	\N	80
1911	59	199	2	2	\N	40
1912	60	199	3	4	\N	60
1913	61	199	3	4	\N	60
1914	51	199	1	4	\N	0
1915	52	199	1	1	\N	20
1916	53	199	2	2	\N	40
1917	4	199	2	3	\N	40
1918	5	199	2	2	\N	40
1919	6	199	2	3	\N	40
1920	7	199	4	4	\N	90
1921	45	200	0	1	\N	0
1922	46	200	3	5	\N	50
1923	47	200	4	5	\N	80
1924	1	200	3	3	\N	60
1925	2	200	3	4	\N	60
1926	3	200	1	2	\N	20
1927	83	200	3	4	\N	60
1928	84	200	3	4	\N	60
1929	85	200	1	2	\N	20
1930	28	201	4	4	\N	90
1931	29	201	0	0	\N	0
1932	30	201	1	1	\N	20
1933	31	201	0	0	\N	0
1934	32	201	0	0	\N	0
1935	62	201	0	0	\N	0
1936	63	201	1	3	\N	10
1937	64	201	1	1	\N	20
1938	37	201	1	4	\N	0
1939	38	201	3	3	\N	60
1940	39	201	0	0	\N	0
1941	40	201	1	1	\N	20
1942	41	201	0	0	\N	0
1943	25	202	3	5	\N	50
1944	26	202	1	1	\N	20
1945	27	202	1	1	\N	20
1946	22	202	3	5	\N	50
1947	23	202	1	2	\N	20
1948	24	202	1	2	\N	20
1949	86	202	4	4	\N	90
1950	87	202	4	4	\N	90
1951	88	202	3	3	\N	60
1952	65	203	4	4	\N	90
1953	66	203	0	0	\N	0
1954	67	203	4	4	\N	90
1955	68	203	0	0	\N	0
1956	1	203	3	6	\N	40
1957	2	203	1	1	\N	20
1958	3	203	4	4	\N	90
1959	8	203	4	5	\N	80
1960	9	203	0	2	\N	-10
1961	10	203	2	2	\N	40
1962	11	203	1	1	\N	20
1963	45	204	3	4	\N	60
1964	46	204	2	4	\N	30
1965	47	204	1	1	\N	20
1966	28	204	3	6	\N	40
1967	29	204	0	1	\N	0
1968	30	204	1	1	\N	20
1969	31	204	0	1	\N	0
1970	32	204	2	2	\N	40
1971	62	204	3	3	\N	60
1972	63	204	2	2	\N	40
1973	64	204	1	2	\N	20
1974	54	205	0	1	\N	0
1975	55	205	4	4	\N	90
1976	56	205	0	0	\N	0
1977	57	205	1	1	\N	20
1978	92	205	4	4	\N	90
1979	93	205	0	2	\N	-10
1980	94	205	2	2	\N	40
1981	95	205	0	0	\N	0
1982	25	205	2	4	\N	30
1983	26	205	1	2	\N	20
1984	27	205	0	1	\N	0
1985	58	206	3	6	\N	40
1986	59	206	1	1	\N	20
1987	60	206	0	2	\N	-10
1988	61	206	1	1	\N	20
1989	83	206	0	1	\N	0
1990	84	206	2	3	\N	40
1991	85	206	0	0	\N	0
1992	42	206	4	5	\N	80
1993	43	206	4	4	\N	90
1994	44	206	2	2	\N	40
1995	15	207	0	2	\N	-10
1996	16	207	4	4	\N	90
1997	17	207	2	2	\N	40
1998	18	207	0	0	\N	0
1999	69	207	3	3	\N	60
2000	70	207	1	2	\N	20
2001	71	207	3	3	\N	60
2002	80	207	3	6	\N	40
2003	81	207	0	0	\N	0
2004	82	207	4	4	\N	90
2005	12	208	0	1	\N	0
2006	13	208	1	1	\N	20
2007	14	208	1	1	\N	20
2008	33	208	3	4	\N	60
2009	34	208	2	3	\N	40
2010	35	208	0	0	\N	0
2011	36	208	2	2	\N	40
2012	51	208	4	4	\N	90
2013	52	208	1	2	\N	20
2014	53	208	1	2	\N	20
2015	19	209	3	5	\N	50
2016	20	209	1	1	\N	20
2017	21	209	3	4	\N	60
2018	76	209	3	4	\N	60
2019	77	209	0	0	\N	0
2020	78	209	1	1	\N	20
2021	79	209	1	1	\N	20
2022	96	209	4	6	\N	70
2023	97	209	3	4	\N	60
2024	98	209	4	4	\N	90
2025	99	209	0	0	\N	0
2026	37	210	4	4	\N	90
2027	38	210	3	3	\N	60
2028	39	210	1	1	\N	20
2029	40	210	1	1	\N	20
2030	41	210	2	4	\N	30
2031	22	210	4	5	\N	80
2032	23	210	1	1	\N	20
2033	24	210	4	5	\N	80
2034	100	210	4	5	\N	80
2035	101	210	2	2	\N	40
2036	102	210	1	1	\N	20
2037	103	210	3	3	\N	60
2038	4	211	0	3	\N	-20
2039	5	211	1	2	\N	20
2040	6	211	0	0	\N	0
2041	7	211	3	4	\N	60
2042	72	211	4	5	\N	80
2043	73	211	3	3	\N	60
2044	74	211	4	4	\N	90
2045	75	211	1	2	\N	20
2046	89	211	4	5	\N	80
2047	90	211	2	4	\N	30
2048	91	211	3	3	\N	60
2049	48	212	4	4	\N	90
2050	49	212	1	1	\N	20
2051	50	212	0	0	\N	0
2052	45	212	0	1	\N	0
2053	46	212	4	4	\N	90
2054	47	212	3	4	\N	60
2055	100	212	3	3	\N	60
2056	101	212	3	3	\N	60
2057	102	212	1	1	\N	20
2058	103	212	2	2	\N	40
2059	54	213	0	1	\N	0
2060	55	213	0	1	\N	0
2061	56	213	0	0	\N	0
2062	57	213	1	1	\N	20
2063	58	213	4	5	\N	80
2064	59	213	2	2	\N	40
2065	60	213	3	3	\N	60
2066	61	213	2	2	\N	40
2067	83	213	3	3	\N	60
2068	84	213	3	4	\N	60
2069	85	213	1	3	\N	10
2070	51	214	4	4	\N	90
2071	52	214	4	6	\N	70
2072	53	214	2	2	\N	40
2073	89	214	1	2	\N	20
2074	90	214	2	2	\N	40
2075	91	214	1	1	\N	20
2076	48	214	2	2	\N	40
2077	49	214	2	2	\N	40
2078	50	214	0	0	\N	0
2079	28	215	2	3	\N	40
2080	29	215	0	0	\N	0
2081	30	215	2	2	\N	40
2082	31	215	1	1	\N	20
2083	32	215	0	0	\N	0
2084	42	215	4	4	\N	90
2085	43	215	3	3	\N	60
2086	44	215	0	1	\N	0
2087	37	215	3	4	\N	60
2088	38	215	0	1	\N	0
2089	39	215	0	2	\N	-10
2090	40	215	4	5	\N	80
2091	41	215	2	2	\N	40
2092	25	216	3	5	\N	50
2093	26	216	0	0	\N	0
2094	27	216	2	2	\N	40
2095	22	216	3	6	\N	40
2096	23	216	1	1	\N	20
2097	24	216	2	2	\N	40
2098	65	216	3	3	\N	60
2099	66	216	0	1	\N	0
2100	67	216	2	2	\N	40
2101	68	216	2	2	\N	40
2102	12	217	3	4	\N	60
2103	13	217	2	2	\N	40
2104	14	217	2	2	\N	40
2105	80	217	3	4	\N	60
2106	81	217	2	3	\N	40
2107	82	217	2	2	\N	40
2108	33	217	4	5	\N	80
2109	34	217	1	1	\N	20
2110	35	217	0	0	\N	0
2111	36	217	1	1	\N	20
2112	76	218	4	5	\N	80
2113	77	218	3	3	\N	60
2114	78	218	1	1	\N	20
2115	79	218	3	4	\N	60
2116	15	218	4	5	\N	80
2117	16	218	4	4	\N	90
2118	17	218	0	0	\N	0
2119	18	218	3	4	\N	60
2120	69	218	3	4	\N	60
2121	70	218	1	1	\N	20
2122	71	218	2	2	\N	40
2123	19	219	2	4	\N	30
2124	20	219	0	0	\N	0
2125	21	219	1	1	\N	20
2126	8	219	3	4	\N	60
2127	9	219	2	4	\N	30
2128	10	219	2	4	\N	30
2129	11	219	0	2	\N	-10
2130	62	219	3	5	\N	50
2131	63	219	0	2	\N	-10
2132	64	219	3	3	\N	60
2133	86	220	4	4	\N	90
2134	87	220	4	5	\N	80
2135	88	220	2	2	\N	40
2136	72	220	1	3	\N	10
2137	73	220	0	0	\N	0
2138	74	220	0	1	\N	0
2139	75	220	4	4	\N	90
2140	1	220	1	3	\N	10
2141	2	220	0	0	\N	0
2142	3	220	2	2	\N	40
2143	4	221	1	1	\N	20
2144	5	221	4	4	\N	90
2145	6	221	3	5	\N	50
2146	7	221	0	0	\N	0
2147	92	221	3	6	\N	40
2148	93	221	1	1	\N	20
2149	94	221	0	1	\N	0
2150	95	221	3	4	\N	60
2151	96	221	3	5	\N	50
2152	97	221	0	1	\N	0
2153	98	221	3	4	\N	60
2154	99	221	0	0	\N	0
2155	134	224	0	0	\N	0
2156	135	224	0	0	\N	0
2157	136	224	4	4	\N	90
2158	137	224	2	3	\N	40
2159	114	224	4	5	\N	80
2160	115	224	2	2	\N	40
2161	116	224	0	2	\N	-10
2162	172	224	4	5	\N	80
2163	173	224	4	4	\N	90
2164	174	224	3	5	\N	50
2165	175	224	0	0	\N	0
2166	119	225	3	3	\N	60
2167	120	225	1	1	\N	20
2168	121	225	0	0	\N	0
2169	122	225	1	2	\N	20
2170	167	225	3	5	\N	50
2171	168	225	1	1	\N	20
2172	138	225	4	4	\N	90
2173	139	225	1	1	\N	20
2174	140	225	4	5	\N	80
2175	155	226	0	1	\N	0
2176	156	226	3	3	\N	60
2177	157	226	4	4	\N	90
2178	161	226	3	4	\N	60
2179	162	226	1	1	\N	20
2180	163	226	2	3	\N	40
2181	111	226	4	4	\N	90
2182	112	226	0	1	\N	0
2183	113	226	2	2	\N	40
2184	180	227	4	4	\N	90
2185	181	227	3	3	\N	60
2186	141	227	2	5	\N	20
2187	142	227	1	2	\N	20
2188	146	227	4	5	\N	80
2189	147	228	2	2	\N	40
2190	148	228	1	1	\N	20
2191	107	228	3	5	\N	50
2192	108	228	0	1	\N	0
2193	109	228	1	1	\N	20
2194	110	228	0	1	\N	0
2195	164	228	4	5	\N	80
2196	165	228	1	2	\N	20
2197	166	228	1	1	\N	20
2198	143	229	3	3	\N	60
2199	144	229	0	1	\N	0
2200	145	229	1	1	\N	20
2201	125	229	3	3	\N	60
2202	126	229	1	1	\N	20
2203	127	229	3	3	\N	60
2204	149	229	4	4	\N	90
2205	150	229	2	3	\N	40
2206	151	229	0	0	\N	0
2207	152	229	3	4	\N	60
2208	123	230	4	4	\N	90
2209	124	230	2	2	\N	40
2210	184	230	0	0	\N	0
2211	158	230	3	3	\N	60
2212	159	230	0	0	\N	0
2213	160	230	1	1	\N	20
2214	185	231	1	1	\N	20
2215	186	231	1	1	\N	20
2216	187	231	0	1	\N	0
2217	176	231	3	4	\N	60
2218	177	231	4	4	\N	90
2219	178	231	1	2	\N	20
2220	179	231	1	1	\N	20
2221	169	231	2	4	\N	30
2222	170	231	1	1	\N	20
2223	171	231	1	1	\N	20
2224	117	232	4	5	\N	80
2225	118	232	2	3	\N	40
2226	130	232	0	1	\N	0
2227	131	232	4	4	\N	90
2228	132	232	0	1	\N	0
2229	133	232	1	3	\N	10
2230	182	232	3	4	\N	60
2231	183	232	3	3	\N	60
2232	105	233	4	4	\N	90
2233	106	233	0	1	\N	0
2234	153	233	1	2	\N	20
2235	154	233	0	0	\N	0
2236	128	233	4	4	\N	90
2237	129	233	4	4	\N	90
2238	104	234	2	4	\N	30
2239	182	234	3	4	\N	60
2240	183	234	4	4	\N	90
2241	105	234	3	4	\N	60
2242	106	234	0	0	\N	0
2243	164	235	4	5	\N	80
2244	165	235	0	1	\N	0
2245	166	235	2	2	\N	40
2246	176	235	3	4	\N	60
2247	177	235	4	5	\N	80
2248	178	235	2	2	\N	40
2249	179	235	2	2	\N	40
2250	138	235	0	1	\N	0
2251	139	235	0	0	\N	0
2252	140	235	2	3	\N	40
2253	146	236	4	5	\N	80
2254	114	236	4	5	\N	80
2255	115	236	3	4	\N	60
2256	116	236	0	0	\N	0
2257	134	236	1	2	\N	20
2258	135	236	4	4	\N	90
2259	136	236	3	4	\N	60
2260	137	236	1	2	\N	20
2261	147	237	4	5	\N	80
2262	148	237	4	4	\N	90
2263	128	237	4	5	\N	80
2264	129	237	2	2	\N	40
2265	119	237	3	3	\N	60
2266	120	237	0	1	\N	0
2267	121	237	0	1	\N	0
2268	122	237	3	5	\N	50
2269	155	238	1	2	\N	20
2270	156	238	0	1	\N	0
2271	157	238	2	3	\N	40
2272	141	238	3	4	\N	60
2273	142	238	2	3	\N	40
2274	180	238	0	1	\N	0
2275	181	238	1	1	\N	20
2276	149	239	4	4	\N	90
2277	150	239	3	4	\N	60
2278	151	239	1	1	\N	20
2279	152	239	2	2	\N	40
2280	161	239	1	2	\N	20
2281	162	239	0	0	\N	0
2282	163	239	0	0	\N	0
2283	117	239	1	4	\N	0
2284	118	239	0	0	\N	0
2285	143	240	2	2	\N	40
2286	144	240	0	0	\N	0
2287	145	240	0	2	\N	-10
2288	184	240	4	4	\N	90
2289	107	240	4	4	\N	90
2290	108	240	3	3	\N	60
2291	109	240	3	3	\N	60
2292	110	240	4	4	\N	90
2293	158	241	2	2	\N	40
2294	159	241	2	2	\N	40
2295	160	241	0	1	\N	0
2296	172	241	2	3	\N	40
2297	173	241	2	3	\N	40
2298	174	241	4	4	\N	90
2299	175	241	1	3	\N	10
2300	169	241	4	5	\N	80
2301	170	241	1	1	\N	20
2302	171	241	2	2	\N	40
2303	125	242	4	5	\N	80
2304	126	242	1	1	\N	20
2305	127	242	1	1	\N	20
2306	185	242	3	4	\N	60
2307	186	242	2	2	\N	40
2308	187	242	1	1	\N	20
2309	167	242	1	3	\N	10
2310	168	242	0	0	\N	0
2311	111	243	4	5	\N	80
2312	112	243	0	0	\N	0
2313	113	243	1	1	\N	20
2314	130	243	4	5	\N	80
2315	131	243	4	5	\N	80
2316	132	243	1	1	\N	20
2317	133	243	0	0	\N	0
2318	153	243	1	2	\N	20
2319	154	243	1	1	\N	20
2320	123	244	4	4	\N	90
2321	124	244	2	2	\N	40
2322	104	244	3	3	\N	60
2323	149	244	4	4	\N	90
2324	150	244	2	2	\N	40
2325	151	244	3	3	\N	60
2326	152	244	2	4	\N	30
2327	172	245	4	4	\N	90
2328	173	245	0	0	\N	0
2329	174	245	1	2	\N	20
2330	175	245	4	4	\N	90
2331	185	245	4	6	\N	70
2332	186	245	3	5	\N	50
2333	187	245	0	0	\N	0
2334	111	245	2	3	\N	40
2335	112	245	3	5	\N	50
2336	113	245	0	0	\N	0
2337	169	246	3	3	\N	60
2338	170	246	1	1	\N	20
2339	171	246	4	4	\N	90
2340	143	246	3	4	\N	60
2341	144	246	2	3	\N	40
2342	145	246	1	1	\N	20
2343	182	246	4	5	\N	80
2344	183	246	3	5	\N	50
2345	125	247	3	4	\N	60
2346	126	247	1	3	\N	10
2347	127	247	1	1	\N	20
2348	176	247	4	4	\N	90
2349	177	247	2	2	\N	40
2350	178	247	2	2	\N	40
2351	179	247	2	2	\N	40
2352	134	247	0	0	\N	0
2353	135	247	2	2	\N	40
2354	136	247	1	2	\N	20
2355	137	247	3	3	\N	60
2356	184	248	4	4	\N	90
2357	155	248	4	5	\N	80
2358	156	248	4	6	\N	70
2359	157	248	1	1	\N	20
2360	161	248	3	6	\N	40
2361	162	248	3	4	\N	60
2362	163	248	2	2	\N	40
2363	123	249	2	4	\N	30
2364	124	249	2	2	\N	40
2365	146	249	4	6	\N	70
2366	105	249	3	4	\N	60
2367	106	249	2	2	\N	40
2368	164	250	0	3	\N	-20
2369	165	250	0	0	\N	0
2370	166	250	2	2	\N	40
2371	107	250	3	4	\N	60
2372	108	250	0	0	\N	0
2373	109	250	0	0	\N	0
2374	110	250	3	3	\N	60
2375	117	250	1	2	\N	20
2376	118	250	0	0	\N	0
2377	114	251	4	4	\N	90
2378	115	251	1	2	\N	20
2379	116	251	4	4	\N	90
2380	130	251	4	4	\N	90
2381	131	251	0	2	\N	-10
2382	132	251	1	3	\N	10
2383	133	251	1	1	\N	20
2384	141	251	4	4	\N	90
2385	142	251	1	1	\N	20
2386	119	252	4	6	\N	70
2387	120	252	0	1	\N	0
2388	121	252	0	1	\N	0
2389	122	252	4	5	\N	80
2390	180	252	3	4	\N	60
2391	181	252	4	5	\N	80
2392	128	252	3	5	\N	50
2393	129	252	1	2	\N	20
2394	147	253	4	4	\N	90
2395	148	253	2	2	\N	40
2396	104	253	3	5	\N	50
2397	138	253	4	5	\N	80
2398	139	253	0	0	\N	0
2399	140	253	2	4	\N	30
2400	158	254	0	0	\N	0
2401	159	254	1	1	\N	20
2402	160	254	1	1	\N	20
2403	153	254	4	6	\N	70
2404	154	254	4	4	\N	90
2405	167	254	3	3	\N	60
2406	168	254	2	2	\N	40
2407	176	255	3	4	\N	60
2408	177	255	0	0	\N	0
2409	178	255	1	1	\N	20
2410	179	255	3	3	\N	60
2411	147	255	3	3	\N	60
2412	148	255	0	0	\N	0
2413	149	255	4	4	\N	90
2414	150	255	0	1	\N	0
2415	151	255	3	3	\N	60
2416	152	255	1	1	\N	20
2417	185	256	4	5	\N	80
2418	186	256	2	3	\N	40
2419	187	256	1	1	\N	20
2420	184	256	3	5	\N	50
2421	114	256	3	4	\N	60
2422	115	256	2	2	\N	40
2423	116	256	2	2	\N	40
2424	143	257	3	5	\N	50
2425	144	257	3	4	\N	60
2426	145	257	0	0	\N	0
2427	128	257	4	5	\N	80
2428	129	257	1	2	\N	20
2429	104	257	3	4	\N	60
2430	141	258	4	4	\N	90
2431	142	258	3	4	\N	60
2432	138	258	2	2	\N	40
2433	139	258	1	1	\N	20
2434	140	258	0	1	\N	0
2435	119	258	2	3	\N	40
2436	120	258	3	3	\N	60
2437	121	258	0	0	\N	0
2438	122	258	4	6	\N	70
2439	155	259	4	4	\N	90
2440	156	259	1	2	\N	20
2441	157	259	2	3	\N	40
2442	169	259	3	3	\N	60
2443	170	259	3	4	\N	60
2444	171	259	3	3	\N	60
2445	117	259	3	5	\N	50
2446	118	259	4	4	\N	90
2447	172	260	3	3	\N	60
2448	173	260	0	0	\N	0
2449	174	260	0	0	\N	0
2450	175	260	2	2	\N	40
2451	107	260	4	5	\N	80
2452	108	260	1	1	\N	20
2453	109	260	0	0	\N	0
2454	110	260	4	4	\N	90
2455	182	260	4	5	\N	80
2456	183	260	1	1	\N	20
2457	180	261	4	6	\N	70
2458	181	261	4	4	\N	90
2459	111	261	3	5	\N	50
2460	112	261	2	2	\N	40
2461	113	261	0	1	\N	0
2462	153	261	4	5	\N	80
2463	154	261	1	1	\N	20
2464	161	262	3	4	\N	60
2465	162	262	1	1	\N	20
2466	163	262	1	1	\N	20
2467	105	262	4	4	\N	90
2468	106	262	1	1	\N	20
2469	158	262	3	5	\N	50
2470	159	262	0	0	\N	0
2471	160	262	2	2	\N	40
2472	167	263	4	4	\N	90
2473	168	263	0	0	\N	0
2474	123	263	3	3	\N	60
2475	124	263	2	4	\N	30
2476	125	263	4	5	\N	80
2477	126	263	0	0	\N	0
2478	127	263	0	1	\N	0
2479	130	264	1	2	\N	20
2480	131	264	1	3	\N	10
2481	132	264	0	0	\N	0
2482	133	264	0	0	\N	0
2483	146	264	0	0	\N	0
2484	134	264	0	1	\N	0
2485	135	264	0	0	\N	0
2486	136	264	3	3	\N	60
2487	137	264	0	0	\N	0
2488	164	265	4	4	\N	90
2489	165	265	1	1	\N	20
2490	166	265	0	0	\N	0
2491	155	265	2	4	\N	30
2492	156	265	1	2	\N	20
2493	157	265	1	1	\N	20
2494	153	265	4	5	\N	80
2495	154	265	1	1	\N	20
2496	169	266	4	4	\N	90
2497	170	266	1	1	\N	20
2498	171	266	1	1	\N	20
2499	134	266	1	3	\N	10
2500	135	266	2	4	\N	30
2501	136	266	1	1	\N	20
2502	137	266	1	1	\N	20
2503	141	266	4	4	\N	90
2504	142	266	2	3	\N	40
2505	143	267	3	6	\N	40
2506	144	267	1	3	\N	10
2507	145	267	2	3	\N	40
2508	147	267	4	4	\N	90
2509	148	267	3	5	\N	50
2510	182	267	4	4	\N	90
2511	183	267	4	5	\N	80
2512	111	268	4	6	\N	70
2513	112	268	3	4	\N	60
2514	113	268	1	1	\N	20
2515	158	268	4	5	\N	80
2516	159	268	2	2	\N	40
2517	160	268	2	2	\N	40
2518	184	268	4	5	\N	80
2519	146	269	4	4	\N	90
2520	114	269	3	6	\N	40
2521	115	269	1	2	\N	20
2522	116	269	0	0	\N	0
2523	128	269	3	5	\N	50
2524	129	269	3	3	\N	60
2525	117	270	4	5	\N	80
2526	118	270	3	3	\N	60
2527	149	270	4	4	\N	90
2528	150	270	4	4	\N	90
2529	151	270	0	0	\N	0
2530	152	270	4	4	\N	90
2531	130	270	4	5	\N	80
2532	131	270	0	1	\N	0
2533	132	270	2	3	\N	40
2534	133	270	3	3	\N	60
2535	167	271	4	5	\N	80
2536	168	271	4	5	\N	80
2537	119	271	0	2	\N	-10
2538	120	271	3	4	\N	60
2539	121	271	4	4	\N	90
2540	122	271	3	5	\N	50
2541	164	271	2	3	\N	40
2542	165	271	4	5	\N	80
2543	166	271	4	4	\N	90
2544	138	272	4	4	\N	90
2545	139	272	2	4	\N	30
2546	140	272	3	3	\N	60
2547	125	272	4	5	\N	80
2548	126	272	1	2	\N	20
2549	127	272	2	3	\N	40
2550	104	272	1	2	\N	20
2551	185	273	4	5	\N	80
2552	186	273	0	0	\N	0
2553	187	273	3	3	\N	60
2554	123	273	3	6	\N	40
2555	124	273	2	3	\N	40
2556	176	273	3	4	\N	60
2557	177	273	1	2	\N	20
2558	178	273	0	0	\N	0
2559	179	273	2	3	\N	40
2560	172	274	3	3	\N	60
2561	173	274	0	1	\N	0
2562	174	274	0	0	\N	0
2563	175	274	0	0	\N	0
2564	107	274	4	6	\N	70
2565	108	274	1	2	\N	20
2566	109	274	0	0	\N	0
2567	110	274	4	4	\N	90
2568	161	274	4	4	\N	90
2569	162	274	0	0	\N	0
2570	163	274	2	3	\N	40
2571	105	275	2	4	\N	30
2572	106	275	1	2	\N	20
2573	180	275	0	1	\N	0
2574	181	275	0	0	\N	0
2575	134	275	0	2	\N	-10
2576	135	275	1	1	\N	20
2577	136	275	2	2	\N	40
2578	137	275	1	3	\N	10
2579	138	276	3	4	\N	60
2580	139	276	1	3	\N	10
2581	140	276	2	3	\N	40
2582	155	276	3	4	\N	60
2583	156	276	1	1	\N	20
2584	157	276	1	1	\N	20
2585	172	276	4	4	\N	90
2586	173	276	0	1	\N	0
2587	174	276	0	0	\N	0
2588	175	276	0	2	\N	-10
2589	185	277	1	1	\N	20
2590	186	277	3	5	\N	50
2591	187	277	3	5	\N	50
2592	141	277	3	4	\N	60
2593	142	277	2	2	\N	40
2594	164	277	3	4	\N	60
2595	165	277	3	3	\N	60
2596	166	277	2	3	\N	40
2597	167	278	2	3	\N	40
2598	168	278	2	2	\N	40
2599	105	278	4	4	\N	90
2600	106	278	1	1	\N	20
2601	111	278	3	3	\N	60
2602	112	278	2	4	\N	30
2603	113	278	3	5	\N	50
2604	114	279	4	4	\N	90
2605	115	279	0	0	\N	0
2606	116	279	0	0	\N	0
2607	149	279	1	2	\N	20
2608	150	279	0	1	\N	0
2609	151	279	0	0	\N	0
2610	152	279	1	1	\N	20
2611	130	279	4	5	\N	80
2612	131	279	1	2	\N	20
2613	132	279	2	3	\N	40
2614	133	279	1	1	\N	20
2615	182	280	3	5	\N	50
2616	183	280	0	0	\N	0
2617	128	280	2	4	\N	30
2618	129	280	1	2	\N	20
2619	158	280	4	5	\N	80
2620	159	280	3	4	\N	60
2621	160	280	3	3	\N	60
2622	119	281	3	4	\N	60
2623	120	281	1	1	\N	20
2624	121	281	1	1	\N	20
2625	122	281	1	1	\N	20
2626	169	281	4	4	\N	90
2627	170	281	2	3	\N	40
2628	171	281	2	2	\N	40
2629	125	281	4	6	\N	70
2630	126	281	0	0	\N	0
2631	127	281	0	2	\N	-10
2632	161	282	1	2	\N	20
2633	162	282	3	3	\N	60
2634	163	282	0	0	\N	0
2635	147	282	4	4	\N	90
2636	148	282	2	2	\N	40
2637	176	282	0	3	\N	-20
2638	177	282	1	1	\N	20
2639	178	282	1	1	\N	20
2640	179	282	3	3	\N	60
2641	143	283	4	5	\N	80
2642	144	283	2	3	\N	40
2643	145	283	1	3	\N	10
2644	153	283	4	6	\N	70
2645	154	283	2	2	\N	40
2646	180	283	4	5	\N	80
2647	181	283	0	1	\N	0
2648	123	284	4	5	\N	80
2649	124	284	2	2	\N	40
2650	117	284	3	6	\N	40
2651	118	284	2	2	\N	40
2652	107	284	4	6	\N	70
2653	108	284	0	0	\N	0
2654	109	284	2	2	\N	40
2655	110	284	1	1	\N	20
2656	104	285	3	4	\N	60
2657	184	285	3	6	\N	40
2658	146	285	3	5	\N	50
2659	250	287	4	5	\N	80
2660	251	287	1	3	\N	10
2661	252	287	2	3	\N	40
2662	253	287	0	0	\N	0
2663	240	287	4	4	\N	90
2664	241	287	0	0	\N	0
2665	242	287	1	1	\N	20
2666	243	287	0	0	\N	0
2667	225	287	1	2	\N	20
2668	226	287	0	0	\N	0
2669	227	287	2	2	\N	40
2670	228	287	4	4	\N	90
2671	201	288	4	5	\N	80
2672	202	288	4	4	\N	90
2673	203	288	0	0	\N	0
2674	244	288	3	3	\N	60
2675	245	288	2	3	\N	40
2676	246	288	0	0	\N	0
2677	213	288	3	4	\N	60
2678	214	288	4	5	\N	80
2679	215	288	2	2	\N	40
2680	216	288	0	1	\N	0
2681	210	289	3	5	\N	50
2682	211	289	1	1	\N	20
2683	212	289	4	5	\N	80
2684	194	289	1	2	\N	20
2685	195	289	2	2	\N	40
2686	196	289	3	3	\N	60
2687	197	289	3	3	\N	60
2688	191	289	4	6	\N	70
2689	192	289	1	2	\N	20
2690	193	289	2	3	\N	40
2691	204	290	3	5	\N	50
2692	205	290	3	3	\N	60
2693	206	290	0	0	\N	0
2694	198	290	4	5	\N	80
2695	199	290	1	3	\N	10
2696	200	290	0	2	\N	-10
2697	207	290	4	5	\N	80
2698	208	290	1	1	\N	20
2699	209	290	1	1	\N	20
2700	221	291	4	6	\N	70
2701	222	291	1	1	\N	20
2702	223	291	0	0	\N	0
2703	224	291	1	1	\N	20
2704	254	291	3	3	\N	60
2705	255	291	0	0	\N	0
2706	256	291	0	0	\N	0
2707	217	291	1	4	\N	0
2708	218	291	2	2	\N	40
2709	219	291	1	1	\N	20
2710	220	291	1	1	\N	20
2711	236	292	4	5	\N	80
2712	237	292	2	3	\N	40
2713	238	292	1	3	\N	10
2714	239	292	4	4	\N	90
2715	229	292	4	4	\N	90
2716	230	292	1	2	\N	20
2717	231	292	2	4	\N	30
2718	232	292	0	1	\N	0
2719	247	292	3	6	\N	40
2720	248	292	2	2	\N	40
2721	249	292	1	2	\N	20
2722	233	293	3	5	\N	50
2723	234	293	3	3	\N	60
2724	235	293	4	4	\N	90
2725	188	293	3	6	\N	40
2726	189	293	1	3	\N	10
2727	190	293	0	0	\N	0
2728	254	293	1	2	\N	20
2729	255	293	4	5	\N	80
2730	256	293	1	1	\N	20
2731	229	294	4	6	\N	70
2732	230	294	0	0	\N	0
2733	231	294	4	4	\N	90
2734	232	294	2	2	\N	40
2735	217	294	4	4	\N	90
2736	218	294	3	3	\N	60
2737	219	294	2	2	\N	40
2738	220	294	2	2	\N	40
2739	225	294	0	2	\N	-10
2740	226	294	1	1	\N	20
2741	227	294	0	0	\N	0
2742	228	294	0	0	\N	0
2743	221	295	4	5	\N	80
2744	222	295	1	1	\N	20
2745	223	295	1	1	\N	20
2746	224	295	0	1	\N	0
2747	204	295	4	5	\N	80
2748	205	295	2	2	\N	40
2749	206	295	1	1	\N	20
2750	250	295	3	5	\N	50
2751	251	295	0	1	\N	0
2752	252	295	2	2	\N	40
2753	253	295	2	3	\N	40
2754	191	296	4	6	\N	70
2755	192	296	1	1	\N	20
2756	193	296	3	3	\N	60
2757	236	296	3	4	\N	60
2758	237	296	4	5	\N	80
2759	238	296	1	1	\N	20
2760	239	296	1	2	\N	20
2761	210	296	3	4	\N	60
2762	211	296	0	1	\N	0
2763	212	296	1	2	\N	20
2764	207	297	4	5	\N	80
2765	208	297	3	3	\N	60
2766	209	297	1	2	\N	20
2767	240	297	4	5	\N	80
2768	241	297	1	1	\N	20
2769	242	297	1	1	\N	20
2770	243	297	0	0	\N	0
2771	233	297	4	5	\N	80
2772	234	297	2	2	\N	40
2773	235	297	1	2	\N	20
2774	194	298	0	2	\N	-10
2775	195	298	2	3	\N	40
2776	196	298	1	1	\N	20
2777	197	298	0	0	\N	0
2778	213	298	3	4	\N	60
2779	214	298	0	0	\N	0
2780	215	298	2	3	\N	40
2781	216	298	4	4	\N	90
2782	244	298	4	4	\N	90
2783	245	298	0	0	\N	0
2784	246	298	2	2	\N	40
2785	247	299	3	4	\N	60
2786	248	299	1	1	\N	20
2787	249	299	1	2	\N	20
2788	188	299	0	0	\N	0
2789	189	299	0	0	\N	0
2790	190	299	0	0	\N	0
2791	198	299	3	3	\N	60
2792	199	299	1	1	\N	20
2793	200	299	3	4	\N	60
2794	201	300	4	6	\N	70
2795	202	300	1	1	\N	20
2796	203	300	2	2	\N	40
2797	210	300	2	4	\N	30
2798	211	300	1	2	\N	20
2799	212	300	1	1	\N	20
2800	247	300	4	4	\N	90
2801	248	300	0	0	\N	0
2802	249	300	0	0	\N	0
2803	204	301	4	5	\N	80
2804	205	301	2	4	\N	30
2805	206	301	1	1	\N	20
2806	188	301	4	5	\N	80
2807	189	301	0	0	\N	0
2808	190	301	2	2	\N	40
2809	236	301	3	3	\N	60
2810	237	301	2	4	\N	30
2811	238	301	2	2	\N	40
2812	239	301	0	2	\N	-10
2813	229	302	3	4	\N	60
2814	230	302	0	1	\N	0
2815	231	302	0	0	\N	0
2816	232	302	1	1	\N	20
2817	221	302	4	4	\N	90
2818	222	302	1	1	\N	20
2819	223	302	1	2	\N	20
2820	224	302	0	1	\N	0
2821	233	302	4	6	\N	70
2822	234	302	2	2	\N	40
2823	235	302	0	0	\N	0
2824	250	303	4	5	\N	80
2825	251	303	4	4	\N	90
2826	252	303	2	3	\N	40
2827	253	303	0	0	\N	0
2828	225	303	3	6	\N	40
2829	226	303	2	3	\N	40
2830	227	303	0	1	\N	0
2831	228	303	4	4	\N	90
2832	213	303	4	4	\N	90
2833	214	303	1	1	\N	20
2834	215	303	1	3	\N	10
2835	216	303	3	3	\N	60
2836	207	304	4	5	\N	80
2837	208	304	0	0	\N	0
2838	209	304	3	3	\N	60
2839	254	304	3	5	\N	50
2840	255	304	4	5	\N	80
2841	256	304	0	1	\N	0
2842	191	304	1	1	\N	20
2843	192	304	4	4	\N	90
2844	193	304	3	3	\N	60
2845	244	305	3	5	\N	50
2846	245	305	1	1	\N	20
2847	246	305	3	5	\N	50
2848	194	305	4	4	\N	90
2849	195	305	1	1	\N	20
2850	196	305	1	1	\N	20
2851	197	305	0	0	\N	0
2852	217	305	4	6	\N	70
2853	218	305	1	1	\N	20
2854	219	305	1	2	\N	20
2855	220	305	4	5	\N	80
2856	198	306	4	4	\N	90
2857	199	306	0	0	\N	0
2858	200	306	1	3	\N	10
2859	201	306	1	4	\N	0
2860	202	306	1	1	\N	20
2861	203	306	2	2	\N	40
2862	240	306	2	3	\N	40
2863	241	306	0	1	\N	0
2864	242	306	0	0	\N	0
2865	243	306	2	2	\N	40
2866	217	307	2	3	\N	40
2867	218	307	2	3	\N	40
2868	219	307	2	3	\N	40
2869	220	307	4	5	\N	80
2870	204	307	1	2	\N	20
2871	205	307	0	2	\N	-10
2872	206	307	3	5	\N	50
2873	198	307	1	3	\N	10
2874	199	307	2	2	\N	40
2875	200	307	1	1	\N	20
2876	191	308	3	4	\N	60
2877	192	308	3	3	\N	60
2878	193	308	3	3	\N	60
2879	247	308	4	5	\N	80
2880	248	308	0	0	\N	0
2881	249	308	4	4	\N	90
2882	250	308	4	5	\N	80
2883	251	308	2	2	\N	40
2884	252	308	0	0	\N	0
2885	253	308	1	2	\N	20
2886	210	309	2	4	\N	30
2887	211	309	3	5	\N	50
2888	212	309	1	1	\N	20
2889	194	309	4	4	\N	90
2890	195	309	0	1	\N	0
2891	196	309	3	3	\N	60
2892	197	309	4	5	\N	80
2893	225	309	4	4	\N	90
2894	226	309	2	2	\N	40
2895	227	309	4	5	\N	80
2896	228	309	0	0	\N	0
2897	244	310	3	6	\N	40
2898	245	310	2	3	\N	40
2899	246	310	0	2	\N	-10
2900	236	310	2	2	\N	40
2901	237	310	4	5	\N	80
2902	238	310	1	1	\N	20
2903	239	310	0	0	\N	0
2904	207	310	4	4	\N	90
2905	208	310	0	0	\N	0
2906	209	310	0	0	\N	0
2907	201	311	3	6	\N	40
2908	202	311	1	1	\N	20
2909	203	311	0	0	\N	0
2910	229	311	3	3	\N	60
2911	230	311	1	1	\N	20
2912	231	311	1	1	\N	20
2913	232	311	0	0	\N	0
2914	254	311	4	6	\N	70
2915	255	311	4	5	\N	80
2916	256	311	0	0	\N	0
2917	213	312	0	0	\N	0
2918	214	312	0	0	\N	0
2919	215	312	2	3	\N	40
2920	216	312	1	1	\N	20
2921	240	312	2	5	\N	20
2922	241	312	0	1	\N	0
2923	242	312	4	4	\N	90
2924	243	312	4	4	\N	90
2925	188	312	1	2	\N	20
2926	189	312	4	4	\N	90
2927	190	312	1	1	\N	20
2928	221	313	0	2	\N	-10
2929	222	313	1	3	\N	10
2930	223	313	1	2	\N	20
2931	224	313	0	0	\N	0
2932	233	313	2	3	\N	40
2933	234	313	1	1	\N	20
2934	235	313	1	1	\N	20
2935	207	313	1	2	\N	20
2936	208	313	3	4	\N	60
2937	209	313	1	1	\N	20
2938	201	314	1	3	\N	10
2939	202	314	2	2	\N	40
2940	203	314	1	1	\N	20
2941	236	314	3	5	\N	50
2942	237	314	1	2	\N	20
2943	238	314	0	0	\N	0
2944	239	314	0	2	\N	-10
2945	233	314	4	6	\N	70
2946	234	314	2	2	\N	40
2947	235	314	0	2	\N	-10
2948	210	315	4	4	\N	90
2949	211	315	0	0	\N	0
2950	212	315	2	2	\N	40
2951	217	315	3	5	\N	50
2952	218	315	1	1	\N	20
2953	219	315	0	0	\N	0
2954	220	315	3	3	\N	60
2955	191	315	4	5	\N	80
2956	192	315	0	0	\N	0
2957	193	315	3	5	\N	50
2958	244	316	3	6	\N	40
2959	245	316	3	3	\N	60
2960	246	316	3	3	\N	60
2961	188	316	3	4	\N	60
2962	189	316	0	2	\N	-10
2963	190	316	0	0	\N	0
2964	225	316	4	4	\N	90
2965	226	316	0	1	\N	0
2966	227	316	1	1	\N	20
2967	228	316	0	0	\N	0
2968	198	317	2	2	\N	40
2969	199	317	4	4	\N	90
2970	200	317	4	4	\N	90
2971	229	317	1	2	\N	20
2972	230	317	2	2	\N	40
2973	231	317	2	2	\N	40
2974	232	317	1	3	\N	10
2975	254	317	3	6	\N	40
2976	255	317	4	5	\N	80
2977	256	317	4	4	\N	90
2978	194	318	1	2	\N	20
2979	195	318	3	5	\N	50
2980	196	318	2	4	\N	30
2981	197	318	0	0	\N	0
2982	221	318	3	3	\N	60
2983	222	318	4	4	\N	90
2984	223	318	0	0	\N	0
2985	224	318	0	2	\N	-10
2986	247	318	3	4	\N	60
2987	248	318	4	6	\N	70
2988	249	318	2	2	\N	40
2989	240	319	0	1	\N	0
2990	241	319	2	2	\N	40
2991	242	319	1	2	\N	20
2992	243	319	4	4	\N	90
2993	204	319	3	3	\N	60
2994	205	319	0	0	\N	0
2995	206	319	0	0	\N	0
2996	213	319	4	4	\N	90
2997	214	319	1	1	\N	20
2998	215	319	2	2	\N	40
2999	216	319	0	0	\N	0
3000	250	320	3	3	\N	60
3001	251	320	2	2	\N	40
3002	252	320	4	4	\N	90
3003	253	320	0	0	\N	0
3004	207	320	4	5	\N	80
3005	208	320	1	1	\N	20
3006	209	320	1	1	\N	20
3007	225	320	3	4	\N	60
3008	226	320	4	4	\N	90
3009	227	320	1	3	\N	10
3010	228	320	1	1	\N	20
3011	233	321	2	4	\N	30
3012	234	321	0	0	\N	0
3013	235	321	0	1	\N	0
3014	191	321	2	2	\N	40
3015	192	321	0	0	\N	0
3016	193	321	1	2	\N	20
3017	198	321	1	3	\N	10
3018	199	321	3	3	\N	60
3019	200	321	1	1	\N	20
3020	201	322	4	5	\N	80
3021	202	322	0	0	\N	0
3022	203	322	2	2	\N	40
3023	250	322	1	3	\N	10
3024	251	322	1	1	\N	20
3025	252	322	3	4	\N	60
3026	253	322	2	2	\N	40
3027	213	322	2	5	\N	20
3028	214	322	1	2	\N	20
3029	215	322	2	3	\N	40
3030	216	322	1	2	\N	20
3031	210	323	4	4	\N	90
3032	211	323	1	1	\N	20
3033	212	323	0	0	\N	0
3034	188	323	1	3	\N	10
3035	189	323	1	1	\N	20
3036	190	323	2	2	\N	40
3037	221	323	4	4	\N	90
3038	222	323	4	6	\N	70
3039	223	323	1	1	\N	20
3040	224	323	2	2	\N	40
3041	244	324	1	1	\N	20
3042	245	324	3	3	\N	60
3043	246	324	1	2	\N	20
3044	204	324	4	4	\N	90
3045	205	324	0	0	\N	0
3046	206	324	4	5	\N	80
3047	217	324	4	6	\N	70
3048	218	324	4	4	\N	90
3049	219	324	4	5	\N	80
3050	220	324	0	0	\N	0
3051	194	325	2	4	\N	30
3052	195	325	2	2	\N	40
3053	196	325	3	3	\N	60
3054	197	325	3	3	\N	60
3055	254	325	4	5	\N	80
3056	255	325	0	0	\N	0
3057	256	325	2	2	\N	40
3058	247	325	3	4	\N	60
3059	248	325	1	2	\N	20
3060	249	325	0	0	\N	0
3061	236	326	4	5	\N	80
3062	237	326	0	0	\N	0
3063	238	326	2	2	\N	40
3064	239	326	1	1	\N	20
3065	240	326	3	4	\N	60
3066	241	326	1	2	\N	20
3067	242	326	1	1	\N	20
3068	243	326	2	2	\N	40
3069	229	326	4	6	\N	70
3070	230	326	0	1	\N	0
3071	231	326	1	1	\N	20
3072	232	326	2	3	\N	40
3073	69	327	4	5	\N	80
3074	70	327	4	4	\N	90
3075	71	327	1	3	\N	10
3076	45	327	2	3	\N	40
3077	46	327	2	3	\N	40
3078	47	327	1	1	\N	20
3079	48	327	4	4	\N	90
3080	49	327	1	3	\N	10
3081	50	327	0	0	\N	0
3082	12	328	1	2	\N	20
3083	13	328	0	1	\N	0
3084	14	328	2	3	\N	40
3085	37	328	1	1	\N	20
3086	38	328	0	0	\N	0
3087	39	328	3	4	\N	60
3088	40	328	1	1	\N	20
3089	41	328	1	2	\N	20
3090	72	328	2	2	\N	40
3091	73	328	1	1	\N	20
3092	74	328	1	1	\N	20
3093	75	328	1	1	\N	20
3094	15	329	4	5	\N	80
3095	16	329	1	1	\N	20
3096	17	329	4	5	\N	80
3097	18	329	2	4	\N	30
3098	54	329	3	4	\N	60
3099	55	329	0	2	\N	-10
3100	56	329	3	5	\N	50
3101	57	329	2	2	\N	40
3102	76	329	3	3	\N	60
3103	77	329	1	2	\N	20
3104	78	329	3	3	\N	60
3105	79	329	3	3	\N	60
3106	42	330	2	4	\N	30
3107	43	330	1	1	\N	20
3108	44	330	2	3	\N	40
3109	86	330	4	4	\N	90
3110	87	330	1	1	\N	20
3111	88	330	1	1	\N	20
3112	58	330	0	1	\N	0
3113	59	330	2	2	\N	40
3114	60	330	3	5	\N	50
3115	61	330	2	2	\N	40
3116	89	331	3	3	\N	60
3117	90	331	2	2	\N	40
3118	91	331	4	5	\N	80
3119	51	331	3	3	\N	60
3120	52	331	1	3	\N	10
3121	53	331	0	0	\N	0
3122	62	331	3	5	\N	50
3123	63	331	1	1	\N	20
3124	64	331	0	0	\N	0
3125	100	332	4	4	\N	90
3126	101	332	0	2	\N	-10
3127	102	332	0	1	\N	0
3128	103	332	0	0	\N	0
3129	80	332	3	3	\N	60
3130	81	332	0	0	\N	0
3131	82	332	2	3	\N	40
3132	83	332	3	3	\N	60
3133	84	332	1	1	\N	20
3134	85	332	2	2	\N	40
3135	19	333	4	4	\N	90
3136	20	333	4	4	\N	90
3137	21	333	4	5	\N	80
3138	8	333	4	5	\N	80
3139	9	333	2	2	\N	40
3140	10	333	1	1	\N	20
3141	11	333	4	5	\N	80
3142	28	333	1	3	\N	10
3143	29	333	1	1	\N	20
3144	30	333	1	1	\N	20
3145	31	333	3	3	\N	60
3146	32	333	1	1	\N	20
3147	33	334	4	5	\N	80
3148	34	334	2	4	\N	30
3149	35	334	3	3	\N	60
3150	36	334	1	1	\N	20
3151	96	334	2	2	\N	40
3152	97	334	4	4	\N	90
3153	98	334	0	0	\N	0
3154	99	334	0	0	\N	0
3155	65	334	0	3	\N	-20
3156	66	334	1	1	\N	20
3157	67	334	1	2	\N	20
3158	68	334	4	4	\N	90
3159	92	335	3	6	\N	40
3160	93	335	1	1	\N	20
3161	94	335	3	3	\N	60
3162	95	335	4	4	\N	90
3163	22	335	2	2	\N	40
3164	23	335	0	0	\N	0
3165	24	335	0	0	\N	0
3166	4	335	1	1	\N	20
3167	5	335	1	1	\N	20
3168	6	335	0	1	\N	0
3169	7	335	2	3	\N	40
3170	25	336	3	4	\N	60
3171	26	336	1	2	\N	20
3172	27	336	0	2	\N	-10
3173	1	336	4	5	\N	80
3174	2	336	1	1	\N	20
3175	3	336	1	2	\N	20
3176	65	336	2	3	\N	40
3177	66	336	4	4	\N	90
3178	67	336	2	3	\N	40
3179	68	336	1	2	\N	20
3180	12	337	2	3	\N	40
3181	13	337	3	4	\N	60
3182	14	337	3	3	\N	60
3183	48	337	1	1	\N	20
3184	49	337	1	1	\N	20
3185	50	337	0	1	\N	0
3186	4	337	3	3	\N	60
3187	5	337	0	0	\N	0
3188	6	337	1	1	\N	20
3189	7	337	1	2	\N	20
3190	92	338	3	3	\N	60
3191	93	338	1	1	\N	20
3192	94	338	0	0	\N	0
3193	95	338	2	2	\N	40
3194	62	338	4	4	\N	90
3195	63	338	4	4	\N	90
3196	64	338	0	0	\N	0
3197	89	338	3	5	\N	50
3198	90	338	0	2	\N	-10
3199	91	338	1	2	\N	20
3200	96	339	4	5	\N	80
3201	97	339	4	4	\N	90
3202	98	339	4	4	\N	90
3203	99	339	2	2	\N	40
3204	51	339	3	3	\N	60
3205	52	339	0	1	\N	0
3206	53	339	3	3	\N	60
3207	58	339	3	3	\N	60
3208	59	339	3	4	\N	60
3209	60	339	0	0	\N	0
3210	61	339	0	1	\N	0
3211	76	340	2	3	\N	40
3212	77	340	2	3	\N	40
3213	78	340	0	0	\N	0
3214	79	340	0	2	\N	-10
3215	25	340	0	2	\N	-10
3216	26	340	2	2	\N	40
3217	27	340	1	1	\N	20
3218	22	340	3	5	\N	50
3219	23	340	0	0	\N	0
3220	24	340	1	1	\N	20
3221	100	341	2	3	\N	40
3222	101	341	3	4	\N	60
3223	102	341	4	4	\N	90
3224	103	341	1	1	\N	20
3225	15	341	1	1	\N	20
3226	16	341	2	2	\N	40
3227	17	341	1	1	\N	20
3228	18	341	1	1	\N	20
3229	1	341	4	6	\N	70
3230	2	341	2	2	\N	40
3231	3	341	0	0	\N	0
3232	72	342	1	3	\N	10
3233	73	342	3	3	\N	60
3234	74	342	2	3	\N	40
3235	75	342	1	2	\N	20
3236	8	342	3	4	\N	60
3237	9	342	0	1	\N	0
3238	10	342	1	1	\N	20
3239	11	342	0	0	\N	0
3240	54	342	4	4	\N	90
3241	55	342	1	3	\N	10
3242	56	342	1	2	\N	20
3243	57	342	4	5	\N	80
3244	19	343	4	5	\N	80
3245	20	343	1	1	\N	20
3246	21	343	3	3	\N	60
3247	80	343	3	5	\N	50
3248	81	343	1	1	\N	20
3249	82	343	4	5	\N	80
3250	28	343	1	1	\N	20
3251	29	343	4	4	\N	90
3252	30	343	0	0	\N	0
3253	31	343	1	3	\N	10
3254	32	343	1	1	\N	20
3255	33	344	4	5	\N	80
3256	34	344	1	1	\N	20
3257	35	344	2	2	\N	40
3258	36	344	0	0	\N	0
3259	45	344	2	5	\N	20
3260	46	344	1	2	\N	20
3261	47	344	1	1	\N	20
3262	37	344	3	3	\N	60
3263	38	344	0	0	\N	0
3264	39	344	1	1	\N	20
3265	40	344	1	2	\N	20
3266	41	344	2	3	\N	40
3267	86	345	4	5	\N	80
3268	87	345	1	2	\N	20
3269	88	345	3	3	\N	60
3270	42	345	3	5	\N	50
3271	43	345	1	2	\N	20
3272	44	345	0	0	\N	0
3273	69	345	3	6	\N	40
3274	70	345	2	2	\N	40
3275	71	345	2	3	\N	40
3276	83	346	3	5	\N	50
3277	84	346	0	2	\N	-10
3278	85	346	3	3	\N	60
3279	58	346	1	1	\N	20
3280	59	346	1	1	\N	20
3281	60	346	1	1	\N	20
3282	61	346	2	2	\N	40
3283	12	346	4	5	\N	80
3284	13	346	2	4	\N	30
3285	14	346	3	4	\N	60
3286	22	347	3	4	\N	60
3287	23	347	4	4	\N	90
3288	24	347	1	1	\N	20
3289	65	347	1	4	\N	0
3290	66	347	1	2	\N	20
3291	67	347	0	1	\N	0
3292	68	347	0	1	\N	0
3293	51	347	1	3	\N	10
3294	52	347	0	2	\N	-10
3295	53	347	2	2	\N	40
3296	100	348	3	5	\N	50
3297	101	348	4	4	\N	90
3298	102	348	3	3	\N	60
3299	103	348	0	0	\N	0
3300	48	348	4	4	\N	90
3301	49	348	1	2	\N	20
3302	50	348	2	2	\N	40
3303	83	348	3	5	\N	50
3304	84	348	2	2	\N	40
3305	85	348	0	2	\N	-10
3306	45	349	4	4	\N	90
3307	46	349	0	1	\N	0
3308	47	349	1	1	\N	20
3309	8	349	4	4	\N	90
3310	9	349	2	3	\N	40
3311	10	349	2	4	\N	30
3312	11	349	1	1	\N	20
3313	19	349	4	5	\N	80
3314	20	349	3	3	\N	60
3315	21	349	4	4	\N	90
3316	96	350	4	5	\N	80
3317	97	350	4	4	\N	90
3318	98	350	2	2	\N	40
3319	99	350	0	0	\N	0
3320	69	350	0	3	\N	-20
3321	70	350	2	2	\N	40
3322	71	350	1	1	\N	20
3323	15	350	3	4	\N	60
3324	16	350	0	0	\N	0
3325	17	350	1	2	\N	20
3326	18	350	2	4	\N	30
3327	72	351	3	3	\N	60
3328	73	351	1	1	\N	20
3329	74	351	1	3	\N	10
3330	75	351	0	0	\N	0
3331	89	351	3	3	\N	60
3332	90	351	1	3	\N	10
3333	91	351	0	1	\N	0
3334	25	351	4	6	\N	70
3335	26	351	0	1	\N	0
3336	27	351	0	1	\N	0
3337	80	352	2	4	\N	30
3338	81	352	0	0	\N	0
3339	82	352	0	0	\N	0
3340	42	352	2	2	\N	40
3341	43	352	1	1	\N	20
3342	44	352	1	1	\N	20
3343	76	352	4	4	\N	90
3344	77	352	1	1	\N	20
3345	78	352	0	0	\N	0
3346	79	352	2	3	\N	40
3347	54	353	3	4	\N	60
3348	55	353	0	2	\N	-10
3349	56	353	3	5	\N	50
3350	57	353	1	3	\N	10
3351	4	353	3	3	\N	60
3352	5	353	2	3	\N	40
3353	6	353	1	1	\N	20
3354	7	353	1	3	\N	10
3355	33	353	4	5	\N	80
3356	34	353	2	2	\N	40
3357	35	353	0	1	\N	0
3358	36	353	0	1	\N	0
3359	62	354	2	2	\N	40
3360	63	354	4	4	\N	90
3361	64	354	0	1	\N	0
3362	86	354	4	5	\N	80
3363	87	354	1	1	\N	20
3364	88	354	1	3	\N	10
3365	37	354	3	4	\N	60
3366	38	354	3	3	\N	60
3367	39	354	1	1	\N	20
3368	40	354	0	0	\N	0
3369	41	354	1	2	\N	20
3370	1	355	1	4	\N	0
3371	2	355	3	3	\N	60
3372	3	355	0	0	\N	0
3373	28	355	2	2	\N	40
3374	29	355	3	4	\N	60
3375	30	355	2	3	\N	40
3376	31	355	3	3	\N	60
3377	32	355	1	1	\N	20
3378	92	355	4	5	\N	80
3379	93	355	1	1	\N	20
3380	94	355	1	1	\N	20
3381	95	355	0	0	\N	0
3382	69	356	4	4	\N	90
3383	70	356	1	3	\N	10
3384	71	356	1	2	\N	20
3385	100	356	0	0	\N	0
3386	101	356	0	0	\N	0
3387	102	356	0	1	\N	0
3388	103	356	1	2	\N	20
3389	25	356	3	5	\N	50
3390	26	356	0	0	\N	0
3391	27	356	0	1	\N	0
3392	22	357	4	5	\N	80
3393	23	357	2	3	\N	40
3394	24	357	3	5	\N	50
3395	83	357	3	5	\N	50
3396	84	357	2	2	\N	40
3397	85	357	1	2	\N	20
3398	19	357	3	5	\N	50
3399	20	357	1	2	\N	20
3400	21	357	1	2	\N	20
3401	48	358	3	5	\N	50
3402	49	358	3	5	\N	50
3403	50	358	1	2	\N	20
3404	37	358	4	4	\N	90
3405	38	358	4	4	\N	90
3406	39	358	1	3	\N	10
3407	40	358	0	0	\N	0
3408	41	358	4	5	\N	80
3409	72	358	3	6	\N	40
3410	73	358	1	1	\N	20
3411	74	358	1	1	\N	20
3412	75	358	0	1	\N	0
3413	89	359	4	4	\N	90
3414	90	359	2	2	\N	40
3415	91	359	1	1	\N	20
3416	96	359	3	5	\N	50
3417	97	359	2	2	\N	40
3418	98	359	1	1	\N	20
3419	99	359	1	1	\N	20
3420	15	359	2	3	\N	40
3421	16	359	1	2	\N	20
3422	17	359	2	2	\N	40
3423	18	359	1	2	\N	20
3424	42	360	4	5	\N	80
3425	43	360	2	2	\N	40
3426	44	360	1	1	\N	20
3427	28	360	3	3	\N	60
3428	29	360	4	4	\N	90
3429	30	360	4	6	\N	70
3430	31	360	0	0	\N	0
3431	32	360	2	2	\N	40
3432	62	360	0	1	\N	0
3433	63	360	1	1	\N	20
3434	64	360	0	0	\N	0
3435	1	361	3	6	\N	40
3436	2	361	3	4	\N	60
3437	3	361	2	3	\N	40
3438	86	361	3	3	\N	60
3439	87	361	1	1	\N	20
3440	88	361	3	3	\N	60
3441	92	361	2	3	\N	40
3442	93	361	0	0	\N	0
3443	94	361	1	1	\N	20
3444	95	361	2	2	\N	40
3445	8	362	4	4	\N	90
3446	9	362	3	3	\N	60
3447	10	362	2	2	\N	40
3448	11	362	3	3	\N	60
3449	33	362	0	1	\N	0
3450	34	362	0	1	\N	0
3451	35	362	1	2	\N	20
3452	36	362	3	5	\N	50
3453	58	362	3	3	\N	60
3454	59	362	0	0	\N	0
3455	60	362	3	3	\N	60
3456	61	362	0	0	\N	0
3457	12	363	3	4	\N	60
3458	13	363	0	2	\N	-10
3459	14	363	1	2	\N	20
3460	65	363	3	4	\N	60
3461	66	363	2	3	\N	40
3462	67	363	2	3	\N	40
3463	68	363	4	6	\N	70
3464	76	363	4	5	\N	80
3465	77	363	0	1	\N	0
3466	78	363	2	3	\N	40
3467	79	363	0	1	\N	0
3468	4	364	1	4	\N	0
3469	5	364	0	1	\N	0
3470	6	364	0	1	\N	0
3471	7	364	2	2	\N	40
3472	80	364	4	5	\N	80
3473	81	364	1	2	\N	20
3474	82	364	1	1	\N	20
3475	51	364	2	3	\N	40
3476	52	364	1	1	\N	20
3477	53	364	0	1	\N	0
3478	54	365	0	0	\N	0
3479	55	365	3	4	\N	60
3480	56	365	1	2	\N	20
3481	57	365	0	0	\N	0
3482	45	365	0	1	\N	0
3483	46	365	0	1	\N	0
3484	47	365	1	1	\N	20
3485	58	365	4	6	\N	70
3486	59	365	0	1	\N	0
3487	60	365	0	0	\N	0
3488	61	365	0	0	\N	0
3489	83	366	4	5	\N	80
3490	84	366	2	2	\N	40
3491	85	366	0	0	\N	0
3492	72	366	3	4	\N	60
3493	73	366	1	2	\N	20
3494	74	366	1	1	\N	20
3495	75	366	2	4	\N	30
3496	92	366	3	4	\N	60
3497	93	366	0	1	\N	0
3498	94	366	1	2	\N	20
3499	95	366	2	2	\N	40
3500	96	367	4	5	\N	80
3501	97	367	1	3	\N	10
3502	98	367	0	0	\N	0
3503	99	367	1	1	\N	20
3504	22	367	0	1	\N	0
3505	23	367	4	4	\N	90
3506	24	367	2	2	\N	40
3507	89	367	4	4	\N	90
3508	90	367	2	2	\N	40
3509	91	367	3	4	\N	60
3510	76	368	4	5	\N	80
3511	77	368	4	5	\N	80
3512	78	368	0	0	\N	0
3513	79	368	0	0	\N	0
3514	69	368	3	5	\N	50
3515	70	368	3	4	\N	60
3516	71	368	2	2	\N	40
3517	37	368	3	3	\N	60
3518	38	368	2	2	\N	40
3519	39	368	4	4	\N	90
3520	40	368	1	1	\N	20
3521	41	368	0	0	\N	0
3522	100	369	4	6	\N	70
3523	101	369	3	3	\N	60
3524	102	369	1	3	\N	10
3525	103	369	3	4	\N	60
3526	33	369	4	4	\N	90
3527	34	369	4	5	\N	80
3528	35	369	0	1	\N	0
3529	36	369	0	0	\N	0
3530	48	369	2	4	\N	30
3531	49	369	3	4	\N	60
3532	50	369	0	0	\N	0
3533	86	370	4	4	\N	90
3534	87	370	0	0	\N	0
3535	88	370	1	3	\N	10
3536	54	370	0	2	\N	-10
3537	55	370	0	1	\N	0
3538	56	370	1	1	\N	20
3539	57	370	1	1	\N	20
3540	1	370	3	3	\N	60
3541	2	370	1	1	\N	20
3542	3	370	2	2	\N	40
3543	62	371	0	2	\N	-10
3544	63	371	1	2	\N	20
3545	64	371	0	1	\N	0
3546	65	371	4	5	\N	80
3547	66	371	1	1	\N	20
3548	67	371	1	2	\N	20
3549	68	371	2	3	\N	40
3550	4	371	4	5	\N	80
3551	5	371	0	0	\N	0
3552	6	371	4	5	\N	80
3553	7	371	0	0	\N	0
3554	25	372	3	3	\N	60
3555	26	372	2	2	\N	40
3556	27	372	1	1	\N	20
3557	45	372	4	6	\N	70
3558	46	372	4	4	\N	90
3559	47	372	0	0	\N	0
3560	80	372	4	5	\N	80
3561	81	372	4	5	\N	80
3562	82	372	4	4	\N	90
3563	42	373	3	4	\N	60
3564	43	373	0	0	\N	0
3565	44	373	1	1	\N	20
3566	51	373	1	3	\N	10
3567	52	373	0	1	\N	0
3568	53	373	1	2	\N	20
3569	8	373	4	5	\N	80
3570	9	373	1	1	\N	20
3571	10	373	0	0	\N	0
3572	11	373	4	4	\N	90
3573	28	374	3	4	\N	60
3574	29	374	3	4	\N	60
3575	30	374	2	2	\N	40
3576	31	374	0	2	\N	-10
3577	32	374	0	0	\N	0
3578	12	374	4	4	\N	90
3579	13	374	2	4	\N	30
3580	14	374	1	1	\N	20
3581	15	374	1	3	\N	10
3582	16	374	1	1	\N	20
3583	17	374	0	0	\N	0
3584	18	374	0	0	\N	0
3585	19	375	3	4	\N	60
3586	20	375	4	4	\N	90
3587	21	375	1	2	\N	20
3588	45	375	4	4	\N	90
3589	46	375	4	6	\N	70
3590	47	375	0	2	\N	-10
3591	42	375	4	5	\N	80
3592	43	375	3	3	\N	60
3593	44	375	1	1	\N	20
3594	89	376	3	5	\N	50
3595	90	376	0	0	\N	0
3596	91	376	1	3	\N	10
3597	69	376	3	4	\N	60
3598	70	376	1	1	\N	20
3599	71	376	0	0	\N	0
3600	48	376	4	4	\N	90
3601	49	376	0	1	\N	0
3602	50	376	4	5	\N	80
3603	96	377	0	0	\N	0
3604	97	377	1	1	\N	20
3605	98	377	3	3	\N	60
3606	99	377	2	2	\N	40
3607	83	377	3	4	\N	60
3608	84	377	2	3	\N	40
3609	85	377	1	1	\N	20
3610	1	377	2	3	\N	40
3611	2	377	4	4	\N	90
3612	3	377	0	0	\N	0
3613	86	378	4	6	\N	70
3614	87	378	0	0	\N	0
3615	88	378	1	1	\N	20
3616	51	378	1	3	\N	10
3617	52	378	2	3	\N	40
3618	53	378	4	5	\N	80
3619	62	378	4	6	\N	70
3620	63	378	0	1	\N	0
3621	64	378	1	1	\N	20
3622	76	379	4	4	\N	90
3623	77	379	1	1	\N	20
3624	78	379	2	2	\N	40
3625	79	379	1	1	\N	20
3626	4	379	3	6	\N	40
3627	5	379	2	2	\N	40
3628	6	379	1	1	\N	20
3629	7	379	0	0	\N	0
3630	100	379	3	5	\N	50
3631	101	379	2	2	\N	40
3632	102	379	2	3	\N	40
3633	103	379	0	0	\N	0
3634	28	380	3	3	\N	60
3635	29	380	1	1	\N	20
3636	30	380	0	2	\N	-10
3637	31	380	2	2	\N	40
3638	32	380	1	2	\N	20
3639	80	380	3	5	\N	50
3640	81	380	2	3	\N	40
3641	82	380	0	0	\N	0
3642	19	380	4	4	\N	90
3643	20	380	4	4	\N	90
3644	21	380	2	3	\N	40
3645	8	381	3	5	\N	50
3646	9	381	3	5	\N	50
3647	10	381	0	0	\N	0
3648	11	381	1	1	\N	20
3649	22	381	4	5	\N	80
3650	23	381	0	0	\N	0
3651	24	381	4	4	\N	90
3652	15	381	1	3	\N	10
3653	16	381	0	0	\N	0
3654	17	381	1	1	\N	20
3655	18	381	0	0	\N	0
3656	33	382	3	4	\N	60
3657	34	382	0	0	\N	0
3658	35	382	1	1	\N	20
3659	36	382	1	1	\N	20
3660	58	382	4	5	\N	80
3661	59	382	1	1	\N	20
3662	60	382	1	1	\N	20
3663	61	382	0	0	\N	0
3664	72	382	2	4	\N	30
3665	73	382	0	2	\N	-10
3666	74	382	2	2	\N	40
3667	75	382	2	3	\N	40
3668	25	383	4	4	\N	90
3669	26	383	2	3	\N	40
3670	27	383	1	1	\N	20
3671	65	383	4	5	\N	80
3672	66	383	1	2	\N	20
3673	67	383	4	4	\N	90
3674	68	383	4	5	\N	80
3675	92	383	3	3	\N	60
3676	93	383	1	2	\N	20
3677	94	383	1	2	\N	20
3678	95	383	1	1	\N	20
3679	12	384	3	3	\N	60
3680	13	384	2	2	\N	40
3681	14	384	0	0	\N	0
3682	37	384	4	4	\N	90
3683	38	384	1	2	\N	20
3684	39	384	1	1	\N	20
3685	40	384	3	4	\N	60
3686	41	384	1	1	\N	20
3687	54	384	3	6	\N	40
3688	55	384	3	3	\N	60
3689	56	384	4	6	\N	70
3690	57	384	1	2	\N	20
3691	164	387	3	5	\N	50
3692	165	387	0	2	\N	-10
3693	166	387	3	3	\N	60
3694	185	387	4	4	\N	90
3695	186	387	1	3	\N	10
3696	187	387	2	2	\N	40
3697	117	387	0	2	\N	-10
3698	118	387	0	2	\N	-10
3699	180	388	1	2	\N	20
3700	181	388	1	1	\N	20
3701	128	388	1	4	\N	0
3702	129	388	1	2	\N	20
3703	130	388	3	4	\N	60
3704	131	388	4	6	\N	70
3705	132	388	1	1	\N	20
3706	133	388	4	4	\N	90
3707	184	389	4	4	\N	90
3708	158	389	4	6	\N	70
3709	159	389	0	2	\N	-10
3710	160	389	2	3	\N	40
3711	182	389	3	4	\N	60
3712	183	389	1	1	\N	20
3713	147	390	4	4	\N	90
3714	148	390	1	1	\N	20
3715	107	390	1	2	\N	20
3716	108	390	1	1	\N	20
3717	109	390	3	3	\N	60
3718	110	390	2	3	\N	40
3719	114	390	4	5	\N	80
3720	115	390	0	2	\N	-10
3721	116	390	1	2	\N	20
3722	167	391	4	4	\N	90
3723	168	391	0	0	\N	0
3724	169	391	4	5	\N	80
3725	170	391	1	3	\N	10
3726	171	391	0	1	\N	0
3727	119	391	3	3	\N	60
3728	120	391	2	3	\N	40
3729	121	391	0	0	\N	0
3730	122	391	0	1	\N	0
3731	143	392	4	4	\N	90
3732	144	392	2	2	\N	40
3733	145	392	0	2	\N	-10
3734	176	392	2	3	\N	40
3735	177	392	3	3	\N	60
3736	178	392	4	5	\N	80
3737	179	392	1	2	\N	20
3738	105	392	4	5	\N	80
3739	106	392	1	3	\N	10
3740	172	393	2	2	\N	40
3741	173	393	0	0	\N	0
3742	174	393	1	1	\N	20
3743	175	393	0	0	\N	0
3744	125	393	3	3	\N	60
3745	126	393	3	4	\N	60
3746	127	393	1	1	\N	20
3747	138	393	4	6	\N	70
3748	139	393	1	3	\N	10
3749	140	393	1	3	\N	10
3750	123	394	4	5	\N	80
3751	124	394	1	1	\N	20
3752	161	394	0	2	\N	-10
3753	162	394	2	2	\N	40
3754	163	394	1	1	\N	20
3755	141	394	4	4	\N	90
3756	142	394	2	2	\N	40
3757	155	395	2	3	\N	40
3758	156	395	3	3	\N	60
3759	157	395	0	0	\N	0
3760	104	395	3	3	\N	60
3761	134	395	1	1	\N	20
3762	135	395	1	1	\N	20
3763	136	395	0	1	\N	0
3764	137	395	0	1	\N	0
3765	149	396	4	6	\N	70
3766	150	396	1	3	\N	10
3767	151	396	0	1	\N	0
3768	152	396	0	0	\N	0
3769	111	396	4	5	\N	80
3770	112	396	2	2	\N	40
3771	113	396	3	4	\N	60
3772	153	396	4	5	\N	80
3773	154	396	4	4	\N	90
3774	146	397	0	1	\N	0
3775	169	397	3	3	\N	60
3776	170	397	4	4	\N	90
3777	171	397	3	3	\N	60
3778	149	397	4	4	\N	90
3779	150	397	1	2	\N	20
3780	151	397	0	0	\N	0
3781	152	397	1	1	\N	20
3782	114	398	1	3	\N	10
3783	115	398	2	2	\N	40
3784	116	398	2	2	\N	40
3785	172	398	4	4	\N	90
3786	173	398	0	1	\N	0
3787	174	398	2	2	\N	40
3788	175	398	1	1	\N	20
3789	146	398	3	5	\N	50
3790	161	399	3	3	\N	60
3791	162	399	1	2	\N	20
3792	163	399	1	1	\N	20
3793	176	399	4	6	\N	70
3794	177	399	3	3	\N	60
3795	178	399	3	3	\N	60
3796	179	399	4	5	\N	80
3797	153	399	4	5	\N	80
3798	154	399	1	1	\N	20
3799	119	400	3	3	\N	60
3800	120	400	0	0	\N	0
3801	121	400	0	1	\N	0
3802	122	400	1	1	\N	20
3803	141	400	3	4	\N	60
3804	142	400	1	1	\N	20
3805	180	400	4	4	\N	90
3806	181	400	1	2	\N	20
3807	117	401	3	4	\N	60
3808	118	401	1	1	\N	20
3809	184	401	3	4	\N	60
3810	185	401	3	5	\N	50
3811	186	401	4	4	\N	90
3812	187	401	2	2	\N	40
3813	104	402	3	4	\N	60
3814	105	402	3	5	\N	50
3815	106	402	2	4	\N	30
3816	123	402	4	6	\N	70
3817	124	402	2	2	\N	40
3818	125	403	0	1	\N	0
3819	126	403	2	3	\N	40
3820	127	403	1	1	\N	20
3821	111	403	3	3	\N	60
3822	112	403	4	5	\N	80
3823	113	403	2	2	\N	40
3824	138	403	3	5	\N	50
3825	139	403	0	0	\N	0
3826	140	403	0	1	\N	0
3827	182	404	4	4	\N	90
3828	183	404	1	2	\N	20
3829	158	404	4	5	\N	80
3830	159	404	0	0	\N	0
3831	160	404	3	5	\N	50
3832	164	404	3	4	\N	60
3833	165	404	2	2	\N	40
3834	166	404	0	1	\N	0
3835	167	405	4	5	\N	80
3836	168	405	0	1	\N	0
3837	134	405	0	3	\N	-20
3838	135	405	3	3	\N	60
3839	136	405	1	1	\N	20
3840	137	405	0	0	\N	0
3841	128	405	2	3	\N	40
3842	129	405	2	2	\N	40
3843	147	406	4	5	\N	80
3844	148	406	0	0	\N	0
3845	155	406	0	0	\N	0
3846	156	406	2	2	\N	40
3847	157	406	1	2	\N	20
3848	107	406	0	1	\N	0
3849	108	406	0	1	\N	0
3850	109	406	1	1	\N	20
3851	110	406	1	1	\N	20
3852	130	407	4	6	\N	70
3853	131	407	1	2	\N	20
3854	132	407	1	1	\N	20
3855	133	407	4	5	\N	80
3856	143	407	3	4	\N	60
3857	144	407	1	2	\N	20
3858	145	407	0	1	\N	0
3859	149	407	4	4	\N	90
3860	150	407	0	1	\N	0
3861	151	407	0	0	\N	0
3862	152	407	0	1	\N	0
3863	128	408	4	6	\N	70
3864	129	408	4	4	\N	90
3865	114	408	1	3	\N	10
3866	115	408	4	5	\N	80
3867	116	408	3	3	\N	60
3868	111	408	4	6	\N	70
3869	112	408	4	4	\N	90
3870	113	408	0	0	\N	0
3871	105	409	1	1	\N	20
3872	106	409	2	2	\N	40
3873	123	409	4	5	\N	80
3874	124	409	0	1	\N	0
3875	182	409	3	4	\N	60
3876	183	409	2	2	\N	40
3877	180	410	3	5	\N	50
3878	181	410	0	0	\N	0
3879	134	410	3	6	\N	40
3880	135	410	0	1	\N	0
3881	136	410	0	0	\N	0
3882	137	410	1	2	\N	20
3883	184	410	3	5	\N	50
3884	153	411	1	2	\N	20
3885	154	411	2	2	\N	40
3886	147	411	2	5	\N	20
3887	148	411	2	3	\N	40
3888	143	411	3	4	\N	60
3889	144	411	0	0	\N	0
3890	145	411	0	1	\N	0
3891	104	412	2	5	\N	20
3892	161	412	4	4	\N	90
3893	162	412	1	1	\N	20
3894	163	412	0	1	\N	0
3895	130	412	3	3	\N	60
3896	131	412	1	2	\N	20
3897	132	412	4	4	\N	90
3898	133	412	0	0	\N	0
3899	164	413	3	5	\N	50
3900	165	413	4	4	\N	90
3901	166	413	1	1	\N	20
3902	176	413	4	5	\N	80
3903	177	413	0	0	\N	0
3904	178	413	1	1	\N	20
3905	179	413	0	0	\N	0
3906	167	413	1	2	\N	20
3907	168	413	1	1	\N	20
3908	141	414	3	5	\N	50
3909	142	414	0	2	\N	-10
3910	172	414	3	5	\N	50
3911	173	414	1	1	\N	20
3912	174	414	2	3	\N	40
3913	175	414	4	4	\N	90
3914	169	414	4	5	\N	80
3915	170	414	1	1	\N	20
3916	171	414	0	2	\N	-10
3917	185	415	3	4	\N	60
3918	186	415	3	3	\N	60
3919	187	415	2	3	\N	40
3920	146	415	4	4	\N	90
3921	138	415	3	5	\N	50
3922	139	415	3	3	\N	60
3923	140	415	1	1	\N	20
3924	158	416	4	5	\N	80
3925	159	416	3	4	\N	60
3926	160	416	0	0	\N	0
3927	107	416	3	3	\N	60
3928	108	416	1	2	\N	20
3929	109	416	1	2	\N	20
3930	110	416	1	1	\N	20
3931	119	416	3	6	\N	40
3932	120	416	4	5	\N	80
3933	121	416	2	2	\N	40
3934	122	416	0	0	\N	0
3935	125	417	4	5	\N	80
3936	126	417	0	0	\N	0
3937	127	417	0	2	\N	-10
3938	155	417	4	4	\N	90
3939	156	417	2	4	\N	30
3940	157	417	1	1	\N	20
3941	117	417	3	6	\N	40
3942	118	417	2	2	\N	40
3943	146	418	4	4	\N	90
3944	180	418	0	2	\N	-10
3945	181	418	4	4	\N	90
3946	134	418	2	3	\N	40
3947	135	418	1	1	\N	20
3948	136	418	1	1	\N	20
3949	137	418	0	0	\N	0
3950	105	419	3	4	\N	60
3951	106	419	0	1	\N	0
3952	149	419	4	6	\N	70
3953	150	419	1	1	\N	20
3954	151	419	2	2	\N	40
3955	152	419	0	0	\N	0
3956	119	419	3	3	\N	60
3957	120	419	1	2	\N	20
3958	121	419	0	0	\N	0
3959	122	419	1	1	\N	20
3960	176	420	4	4	\N	90
3961	177	420	4	5	\N	80
3962	178	420	4	4	\N	90
3963	179	420	0	1	\N	0
3964	169	420	3	3	\N	60
3965	170	420	1	3	\N	10
3966	171	420	0	0	\N	0
3967	158	420	4	4	\N	90
3968	159	420	4	6	\N	70
3969	160	420	0	1	\N	0
3970	182	421	3	3	\N	60
3971	183	421	2	2	\N	40
3972	111	421	4	4	\N	90
3973	112	421	1	2	\N	20
3974	113	421	2	3	\N	40
3975	172	421	4	4	\N	90
3976	173	421	1	3	\N	10
3977	174	421	0	2	\N	-10
3978	175	421	3	3	\N	60
3979	147	422	2	2	\N	40
3980	148	422	2	2	\N	40
3981	164	422	1	1	\N	20
3982	165	422	1	1	\N	20
3983	166	422	1	2	\N	20
3984	114	422	1	3	\N	10
3985	115	422	1	3	\N	10
3986	116	422	1	1	\N	20
3987	123	423	2	3	\N	40
3988	124	423	4	4	\N	90
3989	107	423	1	2	\N	20
3990	108	423	4	4	\N	90
3991	109	423	0	0	\N	0
3992	110	423	0	0	\N	0
3993	185	423	3	3	\N	60
3994	186	423	1	2	\N	20
3995	187	423	0	0	\N	0
3996	155	424	2	3	\N	40
3997	156	424	0	1	\N	0
3998	157	424	1	2	\N	20
3999	184	424	4	5	\N	80
4000	130	424	0	3	\N	-20
4001	131	424	0	0	\N	0
4002	132	424	1	2	\N	20
4003	133	424	3	5	\N	50
4004	117	425	2	3	\N	40
4005	118	425	0	0	\N	0
4006	128	425	4	5	\N	80
4007	129	425	0	1	\N	0
4008	141	425	3	4	\N	60
4009	142	425	4	6	\N	70
4010	104	426	4	4	\N	90
4011	125	426	0	2	\N	-10
4012	126	426	4	4	\N	90
4013	127	426	1	1	\N	20
4014	161	426	4	5	\N	80
4015	162	426	1	1	\N	20
4016	163	426	2	2	\N	40
4017	153	427	3	3	\N	60
4018	154	427	0	2	\N	-10
4019	143	427	4	5	\N	80
4020	144	427	0	0	\N	0
4021	145	427	1	1	\N	20
4022	138	427	2	5	\N	20
4023	139	427	1	1	\N	20
4024	140	427	2	2	\N	40
4025	167	428	3	3	\N	60
4026	168	428	0	0	\N	0
4027	172	428	4	5	\N	80
4028	173	428	1	1	\N	20
4029	174	428	1	3	\N	10
4030	175	428	1	1	\N	20
4031	105	428	3	3	\N	60
4032	106	428	4	5	\N	80
4033	180	429	4	4	\N	90
4034	181	429	4	4	\N	90
4035	138	429	4	5	\N	80
4036	139	429	1	1	\N	20
4037	140	429	2	2	\N	40
4038	130	429	4	5	\N	80
4039	131	429	0	1	\N	0
4040	132	429	2	2	\N	40
4041	133	429	1	1	\N	20
4042	111	430	4	5	\N	80
4043	112	430	0	1	\N	0
4044	113	430	2	2	\N	40
4045	146	430	2	4	\N	30
4046	184	430	4	4	\N	90
4047	114	431	3	4	\N	60
4048	115	431	2	2	\N	40
4049	116	431	1	2	\N	20
4050	164	431	1	3	\N	10
4051	165	431	4	4	\N	90
4052	166	431	3	3	\N	60
4053	123	431	2	3	\N	40
4054	124	431	1	1	\N	20
4055	158	432	0	1	\N	0
4056	159	432	1	1	\N	20
4057	160	432	4	5	\N	80
4058	149	432	4	5	\N	80
4059	150	432	2	2	\N	40
4060	151	432	1	1	\N	20
4061	152	432	0	1	\N	0
4062	153	432	3	4	\N	60
4063	154	432	2	4	\N	30
4064	176	433	0	1	\N	0
4065	177	433	1	1	\N	20
4066	178	433	0	0	\N	0
4067	179	433	0	0	\N	0
4068	167	433	3	6	\N	40
4069	168	433	1	2	\N	20
4070	117	433	1	1	\N	20
4071	118	433	4	4	\N	90
4072	119	434	3	3	\N	60
4073	120	434	1	1	\N	20
4074	121	434	0	0	\N	0
4075	122	434	2	2	\N	40
4076	161	434	0	2	\N	-10
4077	162	434	1	1	\N	20
4078	163	434	1	3	\N	10
4079	141	434	3	6	\N	40
4080	142	434	0	1	\N	0
4081	155	435	3	4	\N	60
4082	156	435	1	1	\N	20
4083	157	435	2	3	\N	40
4084	169	435	4	5	\N	80
4085	170	435	0	1	\N	0
4086	171	435	0	0	\N	0
4087	107	435	2	3	\N	40
4088	108	435	0	2	\N	-10
4089	109	435	0	1	\N	0
4090	110	435	1	1	\N	20
4091	147	436	4	5	\N	80
4092	148	436	0	1	\N	0
4093	182	436	4	4	\N	90
4094	183	436	0	0	\N	0
4095	143	436	0	1	\N	0
4096	144	436	0	0	\N	0
4097	145	436	2	2	\N	40
4098	104	437	1	1	\N	20
4099	134	437	3	5	\N	50
4100	135	437	2	2	\N	40
4101	136	437	1	1	\N	20
4102	137	437	0	2	\N	-10
4103	185	437	3	6	\N	40
4104	186	437	3	5	\N	50
4105	187	437	1	1	\N	20
4106	125	438	0	2	\N	-10
4107	126	438	2	2	\N	40
4108	127	438	1	2	\N	20
4109	128	438	4	5	\N	80
4110	129	438	0	1	\N	0
4111	153	438	3	5	\N	50
4112	154	438	1	1	\N	20
4113	167	439	0	0	\N	0
4114	168	439	2	4	\N	30
4115	164	439	0	2	\N	-10
4116	165	439	2	2	\N	40
4117	166	439	2	2	\N	40
4118	161	439	1	2	\N	20
4119	162	439	1	2	\N	20
4120	163	439	0	0	\N	0
4121	149	440	4	5	\N	80
4122	150	440	0	0	\N	0
4123	151	440	3	4	\N	60
4124	152	440	2	2	\N	40
4125	180	440	3	6	\N	40
4126	181	440	0	1	\N	0
4127	185	440	2	5	\N	20
4128	186	440	1	1	\N	20
4129	187	440	0	0	\N	0
4130	147	441	2	3	\N	40
4131	148	441	2	4	\N	30
4132	114	441	3	4	\N	60
4133	115	441	3	4	\N	60
4134	116	441	0	0	\N	0
4135	119	441	4	5	\N	80
4136	120	441	3	3	\N	60
4137	121	441	4	4	\N	90
4138	122	441	1	1	\N	20
4139	105	442	4	5	\N	80
4140	106	442	1	2	\N	20
4141	176	442	3	5	\N	50
4142	177	442	0	0	\N	0
4143	178	442	2	4	\N	30
4144	179	442	0	1	\N	0
4145	172	442	0	1	\N	0
4146	173	442	2	2	\N	40
4147	174	442	0	0	\N	0
4148	175	442	1	1	\N	20
4149	158	443	4	5	\N	80
4150	159	443	4	4	\N	90
4151	160	443	0	2	\N	-10
4152	146	443	2	3	\N	40
4153	141	443	2	3	\N	40
4154	142	443	2	2	\N	40
4155	104	444	3	4	\N	60
4156	123	444	4	6	\N	70
4157	124	444	1	1	\N	20
4158	134	444	4	4	\N	90
4159	135	444	0	0	\N	0
4160	136	444	1	3	\N	10
4161	137	444	3	3	\N	60
4162	143	445	3	4	\N	60
4163	144	445	0	0	\N	0
4164	145	445	0	1	\N	0
4165	184	445	3	4	\N	60
4166	169	445	1	1	\N	20
4167	170	445	0	0	\N	0
4168	171	445	1	1	\N	20
4169	155	446	1	1	\N	20
4170	156	446	1	1	\N	20
4171	157	446	4	5	\N	80
4172	130	446	4	4	\N	90
4173	131	446	4	4	\N	90
4174	132	446	0	1	\N	0
4175	133	446	0	0	\N	0
4176	138	446	3	5	\N	50
4177	139	446	1	2	\N	20
4178	140	446	4	5	\N	80
4179	117	447	4	4	\N	90
4180	118	447	4	6	\N	70
4181	107	447	4	4	\N	90
4182	108	447	3	3	\N	60
4183	109	447	4	4	\N	90
4184	110	447	0	2	\N	-10
4185	128	447	1	1	\N	20
4186	129	447	0	2	\N	-10
4187	125	448	0	1	\N	0
4188	126	448	4	6	\N	70
4189	127	448	2	2	\N	40
4190	182	448	4	5	\N	80
4191	183	448	4	5	\N	80
4192	111	448	4	5	\N	80
4193	112	448	0	0	\N	0
4194	113	448	0	1	\N	0
4195	198	450	3	3	\N	60
4196	199	450	4	4	\N	90
4197	200	450	0	0	\N	0
4198	194	450	4	5	\N	80
4199	195	450	1	2	\N	20
4200	196	450	0	0	\N	0
4201	197	450	0	0	\N	0
4202	201	450	3	4	\N	60
4203	202	450	0	0	\N	0
4204	203	450	4	6	\N	70
4205	188	451	3	5	\N	50
4206	189	451	2	2	\N	40
4207	190	451	3	3	\N	60
4208	229	451	4	4	\N	90
4209	230	451	4	4	\N	90
4210	231	451	0	1	\N	0
4211	232	451	2	2	\N	40
4212	217	451	3	5	\N	50
4213	218	451	0	0	\N	0
4214	219	451	1	1	\N	20
4215	220	451	1	1	\N	20
4216	210	452	4	4	\N	90
4217	211	452	0	1	\N	0
4218	212	452	1	3	\N	10
4219	233	452	4	5	\N	80
4220	234	452	2	3	\N	40
4221	235	452	3	3	\N	60
4222	221	452	1	2	\N	20
4223	222	452	0	0	\N	0
4224	223	452	1	1	\N	20
4225	224	452	2	2	\N	40
4226	240	453	4	5	\N	80
4227	241	453	1	1	\N	20
4228	242	453	1	2	\N	20
4229	243	453	2	3	\N	40
4230	207	453	1	2	\N	20
4231	208	453	1	1	\N	20
4232	209	453	0	0	\N	0
4233	247	453	3	4	\N	60
4234	248	453	0	0	\N	0
4235	249	453	0	0	\N	0
4236	204	454	1	2	\N	20
4237	205	454	0	2	\N	-10
4238	206	454	0	1	\N	0
4239	254	454	0	0	\N	0
4240	255	454	0	0	\N	0
4241	256	454	3	3	\N	60
4242	213	454	3	3	\N	60
4243	214	454	1	2	\N	20
4244	215	454	0	0	\N	0
4245	216	454	0	0	\N	0
4246	225	455	3	3	\N	60
4247	226	455	0	0	\N	0
4248	227	455	1	3	\N	10
4249	228	455	1	1	\N	20
4250	244	455	4	4	\N	90
4251	245	455	2	2	\N	40
4252	246	455	0	0	\N	0
4253	236	455	3	3	\N	60
4254	237	455	1	1	\N	20
4255	238	455	0	2	\N	-10
4256	239	455	2	2	\N	40
4257	191	456	4	4	\N	90
4258	192	456	0	0	\N	0
4259	193	456	2	2	\N	40
4260	250	456	4	4	\N	90
4261	251	456	1	3	\N	10
4262	252	456	3	5	\N	50
4263	253	456	1	1	\N	20
4264	210	456	3	4	\N	60
4265	211	456	2	2	\N	40
4266	212	456	1	1	\N	20
4267	225	457	4	5	\N	80
4268	226	457	0	0	\N	0
4269	227	457	0	1	\N	0
4270	228	457	1	1	\N	20
4271	207	457	4	4	\N	90
4272	208	457	3	4	\N	60
4273	209	457	1	1	\N	20
4274	229	457	4	6	\N	70
4275	230	457	0	0	\N	0
4276	231	457	1	2	\N	20
4277	232	457	3	4	\N	60
4278	213	458	0	2	\N	-10
4279	214	458	0	0	\N	0
4280	215	458	1	1	\N	20
4281	216	458	2	2	\N	40
4282	201	458	4	6	\N	70
4283	202	458	1	2	\N	20
4284	203	458	3	3	\N	60
4285	236	458	0	1	\N	0
4286	237	458	0	1	\N	0
4287	238	458	0	1	\N	0
4288	239	458	4	4	\N	90
4289	254	459	3	4	\N	60
4290	255	459	0	0	\N	0
4291	256	459	0	1	\N	0
4292	233	459	4	6	\N	70
4293	234	459	1	1	\N	20
4294	235	459	4	5	\N	80
4295	198	459	3	3	\N	60
4296	199	459	1	1	\N	20
4297	200	459	2	2	\N	40
4298	250	460	1	2	\N	20
4299	251	460	4	4	\N	90
4300	252	460	2	2	\N	40
4301	253	460	2	2	\N	40
4302	221	460	4	4	\N	90
4303	222	460	2	3	\N	40
4304	223	460	2	2	\N	40
4305	224	460	2	3	\N	40
4306	191	460	2	2	\N	40
4307	192	460	2	3	\N	40
4308	193	460	2	2	\N	40
4309	240	461	0	1	\N	0
4310	241	461	0	0	\N	0
4311	242	461	2	2	\N	40
4312	243	461	2	2	\N	40
4313	244	461	1	2	\N	20
4314	245	461	2	3	\N	40
4315	246	461	1	1	\N	20
4316	194	461	3	6	\N	40
4317	195	461	4	4	\N	90
4318	196	461	2	2	\N	40
4319	197	461	1	1	\N	20
4320	217	462	4	4	\N	90
4321	218	462	4	4	\N	90
4322	219	462	0	1	\N	0
4323	220	462	0	0	\N	0
4324	188	462	3	3	\N	60
4325	189	462	2	4	\N	30
4326	190	462	1	1	\N	20
4327	247	462	4	4	\N	90
4328	248	462	1	2	\N	20
4329	249	462	4	4	\N	90
4330	204	463	0	1	\N	0
4331	205	463	0	0	\N	0
4332	206	463	0	0	\N	0
4333	250	463	0	1	\N	0
4334	251	463	2	2	\N	40
4335	252	463	0	0	\N	0
4336	253	463	0	1	\N	0
4337	213	463	3	5	\N	50
4338	214	463	2	2	\N	40
4339	215	463	1	1	\N	20
4340	216	463	3	5	\N	50
4341	229	464	4	4	\N	90
4342	230	464	3	3	\N	60
4343	231	464	1	1	\N	20
4344	232	464	1	1	\N	20
4345	188	464	4	4	\N	90
4346	189	464	2	2	\N	40
4347	190	464	0	0	\N	0
4348	201	464	3	3	\N	60
4349	202	464	1	2	\N	20
4350	203	464	3	3	\N	60
4351	221	465	3	4	\N	60
4352	222	465	3	5	\N	50
4353	223	465	4	5	\N	80
4354	224	465	1	1	\N	20
4355	244	465	3	3	\N	60
4356	245	465	0	1	\N	0
4357	246	465	0	1	\N	0
4358	204	465	4	5	\N	80
4359	205	465	0	0	\N	0
4360	206	465	2	2	\N	40
4361	254	466	4	5	\N	80
4362	255	466	0	0	\N	0
4363	256	466	1	1	\N	20
4364	236	466	4	5	\N	80
4365	237	466	1	1	\N	20
4366	238	466	1	3	\N	10
4367	239	466	0	0	\N	0
4368	198	466	4	6	\N	70
4369	199	466	0	0	\N	0
4370	200	466	2	3	\N	40
4371	210	467	4	4	\N	90
4372	211	467	3	5	\N	50
4373	212	467	3	3	\N	60
4374	194	467	3	4	\N	60
4375	195	467	0	2	\N	-10
4376	196	467	3	3	\N	60
4377	197	467	2	2	\N	40
4378	207	467	3	4	\N	60
4379	208	467	2	3	\N	40
4380	209	467	0	0	\N	0
4381	240	468	2	3	\N	40
4382	241	468	0	2	\N	-10
4383	242	468	1	1	\N	20
4384	243	468	2	2	\N	40
4385	191	468	4	4	\N	90
4386	192	468	0	2	\N	-10
4387	193	468	3	3	\N	60
4388	225	468	1	2	\N	20
4389	226	468	1	1	\N	20
4390	227	468	1	3	\N	10
4391	228	468	4	4	\N	90
4392	233	469	0	1	\N	0
4393	234	469	2	2	\N	40
4394	235	469	1	2	\N	20
4395	247	469	4	5	\N	80
4396	248	469	0	0	\N	0
4397	249	469	0	1	\N	0
4398	217	469	4	5	\N	80
4399	218	469	4	4	\N	90
4400	219	469	1	1	\N	20
4401	220	469	2	3	\N	40
4402	194	470	3	4	\N	60
4403	195	470	4	4	\N	90
4404	196	470	2	2	\N	40
4405	197	470	2	3	\N	40
4406	188	470	3	4	\N	60
4407	189	470	4	4	\N	90
4408	190	470	1	1	\N	20
4409	247	470	1	1	\N	20
4410	248	470	0	0	\N	0
4411	249	470	1	1	\N	20
4412	204	471	1	1	\N	20
4413	205	471	3	4	\N	60
4414	206	471	2	2	\N	40
4415	201	471	4	6	\N	70
4416	202	471	0	0	\N	0
4417	203	471	4	4	\N	90
4418	221	471	1	1	\N	20
4419	222	471	2	2	\N	40
4420	223	471	2	2	\N	40
4421	224	471	2	3	\N	40
4422	217	472	3	5	\N	50
4423	218	472	0	0	\N	0
4424	219	472	0	1	\N	0
4425	220	472	3	3	\N	60
4426	210	472	1	4	\N	0
4427	211	472	2	2	\N	40
4428	212	472	4	5	\N	80
4429	244	472	1	4	\N	0
4430	245	472	0	1	\N	0
4431	246	472	1	2	\N	20
4432	225	473	3	4	\N	60
4433	226	473	2	2	\N	40
4434	227	473	1	1	\N	20
4435	228	473	1	3	\N	10
4436	240	473	1	3	\N	10
4437	241	473	0	1	\N	0
4438	242	473	0	1	\N	0
4439	243	473	2	3	\N	40
4440	233	473	4	4	\N	90
4441	234	473	2	2	\N	40
4442	235	473	3	4	\N	60
4443	198	474	4	4	\N	90
4444	199	474	1	2	\N	20
4445	200	474	0	2	\N	-10
4446	207	474	4	4	\N	90
4447	208	474	4	4	\N	90
4448	209	474	2	3	\N	40
4449	191	474	3	6	\N	40
4450	192	474	3	4	\N	60
4451	193	474	4	4	\N	90
4452	254	475	4	5	\N	80
4453	255	475	1	3	\N	10
4454	256	475	3	3	\N	60
4455	213	475	2	5	\N	20
4456	214	475	0	0	\N	0
4457	215	475	3	3	\N	60
4458	216	475	4	6	\N	70
4459	250	475	3	4	\N	60
4460	251	475	2	4	\N	30
4461	252	475	0	0	\N	0
4462	253	475	2	2	\N	40
4463	229	476	4	6	\N	70
4464	230	476	1	1	\N	20
4465	231	476	0	0	\N	0
4466	232	476	2	2	\N	40
4467	236	476	3	3	\N	60
4468	237	476	1	1	\N	20
4469	238	476	1	1	\N	20
4470	239	476	0	0	\N	0
4471	225	476	3	4	\N	60
4472	226	476	2	2	\N	40
4473	227	476	1	1	\N	20
4474	228	476	1	1	\N	20
4475	244	477	4	6	\N	70
4476	245	477	3	3	\N	60
4477	246	477	2	4	\N	30
4478	247	477	4	5	\N	80
4479	248	477	0	0	\N	0
4480	249	477	1	1	\N	20
4481	198	477	2	3	\N	40
4482	199	477	1	2	\N	20
4483	200	477	0	0	\N	0
4484	204	478	3	6	\N	40
4485	205	478	1	1	\N	20
4486	206	478	1	2	\N	20
4487	233	478	2	2	\N	40
4488	234	478	1	1	\N	20
4489	235	478	2	2	\N	40
4490	221	478	4	6	\N	70
4491	222	478	1	1	\N	20
4492	223	478	1	2	\N	20
4493	224	478	2	3	\N	40
4494	254	479	2	4	\N	30
4495	255	479	1	1	\N	20
4496	256	479	1	1	\N	20
4497	240	479	2	4	\N	30
4498	241	479	4	5	\N	80
4499	242	479	1	1	\N	20
4500	243	479	3	3	\N	60
4501	213	479	1	2	\N	20
4502	214	479	0	0	\N	0
4503	215	479	0	0	\N	0
4504	216	479	1	2	\N	20
4505	250	480	0	0	\N	0
4506	251	480	3	3	\N	60
4507	252	480	0	0	\N	0
4508	253	480	2	2	\N	40
4509	191	480	2	4	\N	30
4510	192	480	3	3	\N	60
4511	193	480	1	1	\N	20
4512	201	480	4	5	\N	80
4513	202	480	1	1	\N	20
4514	203	480	2	3	\N	40
4515	207	481	0	2	\N	-10
4516	208	481	1	1	\N	20
4517	209	481	2	2	\N	40
4518	210	481	3	5	\N	50
4519	211	481	1	3	\N	10
4520	212	481	2	2	\N	40
4521	229	481	4	4	\N	90
4522	230	481	0	0	\N	0
4523	231	481	1	1	\N	20
4524	232	481	0	0	\N	0
4525	194	482	0	1	\N	0
4526	195	482	1	1	\N	20
4527	196	482	1	3	\N	10
4528	197	482	0	1	\N	0
4529	188	482	0	1	\N	0
4530	189	482	0	0	\N	0
4531	190	482	0	0	\N	0
4532	236	482	4	4	\N	90
4533	237	482	0	0	\N	0
4534	238	482	4	4	\N	90
4535	239	482	2	2	\N	40
4536	217	483	3	3	\N	60
4537	218	483	0	1	\N	0
4538	219	483	1	1	\N	20
4539	220	483	0	0	\N	0
4540	236	483	4	5	\N	80
4541	237	483	3	4	\N	60
4542	238	483	0	2	\N	-10
4543	239	483	3	3	\N	60
4544	221	483	0	0	\N	0
4545	222	483	1	1	\N	20
4546	223	483	1	1	\N	20
4547	224	483	1	1	\N	20
4548	194	484	2	3	\N	40
4549	195	484	4	5	\N	80
4550	196	484	0	0	\N	0
4551	197	484	3	5	\N	50
4552	244	484	0	2	\N	-10
4553	245	484	2	2	\N	40
4554	246	484	1	1	\N	20
4555	201	484	1	2	\N	20
4556	202	484	1	1	\N	20
4557	203	484	1	1	\N	20
4558	233	485	2	5	\N	20
4559	234	485	0	0	\N	0
4560	235	485	1	1	\N	20
4561	210	485	4	4	\N	90
4562	211	485	0	0	\N	0
4563	212	485	0	0	\N	0
4564	207	485	1	2	\N	20
4565	208	485	4	4	\N	90
4566	209	485	0	0	\N	0
4567	191	486	1	2	\N	20
4568	192	486	2	2	\N	40
4569	193	486	1	1	\N	20
4570	217	486	4	4	\N	90
4571	218	486	1	1	\N	20
4572	219	486	1	3	\N	10
4573	220	486	0	0	\N	0
4574	229	486	4	4	\N	90
4575	230	486	1	2	\N	20
4576	231	486	0	0	\N	0
4577	232	486	1	3	\N	10
4578	250	487	4	5	\N	80
4579	251	487	0	1	\N	0
4580	252	487	1	1	\N	20
4581	253	487	0	0	\N	0
4582	225	487	1	4	\N	0
4583	226	487	1	2	\N	20
4584	227	487	1	1	\N	20
4585	228	487	1	1	\N	20
4586	198	487	3	3	\N	60
4587	199	487	1	1	\N	20
4588	200	487	3	3	\N	60
4589	188	488	0	1	\N	0
4590	189	488	3	3	\N	60
4591	190	488	1	1	\N	20
4592	247	488	4	4	\N	90
4593	248	488	3	4	\N	60
4594	249	488	0	0	\N	0
4595	213	488	1	2	\N	20
4596	214	488	0	0	\N	0
4597	215	488	3	3	\N	60
4598	216	488	2	2	\N	40
4599	254	489	4	4	\N	90
4600	255	489	1	1	\N	20
4601	256	489	1	1	\N	20
4602	240	489	4	5	\N	80
4603	241	489	0	1	\N	0
4604	242	489	1	1	\N	20
4605	243	489	4	4	\N	90
4606	204	489	4	4	\N	90
4607	205	489	4	5	\N	80
4608	206	489	2	2	\N	40
4609	86	490	3	4	\N	60
4610	87	490	0	2	\N	-10
4611	88	490	0	0	\N	0
4612	51	490	1	2	\N	20
4613	52	490	3	5	\N	50
4614	53	490	0	0	\N	0
4615	62	490	4	5	\N	80
4616	63	490	1	1	\N	20
4617	64	490	0	0	\N	0
4618	72	491	2	4	\N	30
4619	73	491	0	0	\N	0
4620	74	491	2	2	\N	40
4621	75	491	0	2	\N	-10
4622	76	491	0	1	\N	0
4623	77	491	0	0	\N	0
4624	78	491	4	5	\N	80
4625	79	491	0	0	\N	0
4626	92	491	4	5	\N	80
4627	93	491	1	1	\N	20
4628	94	491	1	2	\N	20
4629	95	491	0	0	\N	0
4630	1	492	4	6	\N	70
4631	2	492	1	1	\N	20
4632	3	492	0	0	\N	0
4633	58	492	2	3	\N	40
4634	59	492	2	2	\N	40
4635	60	492	3	4	\N	60
4636	61	492	1	1	\N	20
4637	54	492	0	1	\N	0
4638	55	492	1	2	\N	20
4639	56	492	0	0	\N	0
4640	57	492	0	1	\N	0
4641	89	493	4	6	\N	70
4642	90	493	2	3	\N	40
4643	91	493	1	3	\N	10
4644	83	493	3	3	\N	60
4645	84	493	1	1	\N	20
4646	85	493	1	1	\N	20
4647	65	493	3	6	\N	40
4648	66	493	2	3	\N	40
4649	67	493	0	0	\N	0
4650	68	493	0	0	\N	0
4651	69	494	4	5	\N	80
4652	70	494	2	4	\N	30
4653	71	494	1	1	\N	20
4654	96	494	3	4	\N	60
4655	97	494	0	2	\N	-10
4656	98	494	1	1	\N	20
4657	99	494	2	2	\N	40
4658	37	494	4	6	\N	70
4659	38	494	0	0	\N	0
4660	39	494	0	0	\N	0
4661	40	494	1	2	\N	20
4662	41	494	1	1	\N	20
4663	4	495	1	2	\N	20
4664	5	495	0	0	\N	0
4665	6	495	3	3	\N	60
4666	7	495	0	1	\N	0
4667	12	495	1	1	\N	20
4668	13	495	0	0	\N	0
4669	14	495	2	3	\N	40
4670	100	495	4	4	\N	90
4671	101	495	0	1	\N	0
4672	102	495	1	3	\N	10
4673	103	495	1	3	\N	10
4674	8	496	0	1	\N	0
4675	9	496	1	1	\N	20
4676	10	496	2	2	\N	40
4677	11	496	2	4	\N	30
4678	22	496	3	5	\N	50
4679	23	496	0	2	\N	-10
4680	24	496	3	3	\N	60
4681	33	496	2	3	\N	40
4682	34	496	0	0	\N	0
4683	35	496	0	1	\N	0
4684	36	496	1	3	\N	10
4685	48	497	0	3	\N	-20
4686	49	497	0	0	\N	0
4687	50	497	1	1	\N	20
4688	25	497	4	5	\N	80
4689	26	497	0	0	\N	0
4690	27	497	0	0	\N	0
4691	28	497	3	3	\N	60
4692	29	497	0	1	\N	0
4693	30	497	3	3	\N	60
4694	31	497	4	4	\N	90
4695	32	497	2	2	\N	40
4696	45	498	2	3	\N	40
4697	46	498	0	1	\N	0
4698	47	498	4	4	\N	90
4699	19	498	2	3	\N	40
4700	20	498	2	2	\N	40
4701	21	498	1	1	\N	20
4702	15	498	2	2	\N	40
4703	16	498	0	0	\N	0
4704	17	498	2	2	\N	40
4705	18	498	0	0	\N	0
4706	80	499	4	5	\N	80
4707	81	499	3	3	\N	60
4708	82	499	0	0	\N	0
4709	42	499	0	0	\N	0
4710	43	499	1	2	\N	20
4711	44	499	0	0	\N	0
4712	12	499	4	5	\N	80
4713	13	499	2	2	\N	40
4714	14	499	4	5	\N	80
4715	4	500	3	4	\N	60
4716	5	500	0	1	\N	0
4717	6	500	4	5	\N	80
4718	7	500	0	0	\N	0
4719	25	500	4	4	\N	90
4720	26	500	0	0	\N	0
4721	27	500	0	2	\N	-10
4722	89	500	3	4	\N	60
4723	90	500	0	1	\N	0
4724	91	500	3	3	\N	60
4725	96	501	1	2	\N	20
4726	97	501	0	0	\N	0
4727	98	501	1	1	\N	20
4728	99	501	1	2	\N	20
4729	54	501	3	4	\N	60
4730	55	501	2	2	\N	40
4731	56	501	1	1	\N	20
4732	57	501	4	4	\N	90
4733	1	501	4	4	\N	90
4734	2	501	2	3	\N	40
4735	3	501	2	2	\N	40
4736	62	502	4	4	\N	90
4737	63	502	0	1	\N	0
4738	64	502	0	1	\N	0
4739	48	502	4	4	\N	90
4740	49	502	2	2	\N	40
4741	50	502	0	2	\N	-10
4742	19	502	3	4	\N	60
4743	20	502	3	3	\N	60
4744	21	502	4	4	\N	90
4745	28	503	4	4	\N	90
4746	29	503	0	2	\N	-10
4747	30	503	4	4	\N	90
4748	31	503	0	0	\N	0
4749	32	503	1	1	\N	20
4750	45	503	3	5	\N	50
4751	46	503	1	1	\N	20
4752	47	503	1	2	\N	20
4753	22	503	2	2	\N	40
4754	23	503	1	1	\N	20
4755	24	503	3	4	\N	60
4756	86	504	4	5	\N	80
4757	87	504	1	2	\N	20
4758	88	504	2	3	\N	40
4759	37	504	4	5	\N	80
4760	38	504	1	1	\N	20
4761	39	504	2	4	\N	30
4762	40	504	1	1	\N	20
4763	41	504	2	2	\N	40
4764	65	504	1	3	\N	10
4765	66	504	0	0	\N	0
4766	67	504	1	1	\N	20
4767	68	504	2	2	\N	40
4768	80	505	1	3	\N	10
4769	81	505	0	0	\N	0
4770	82	505	0	1	\N	0
4771	83	505	3	3	\N	60
4772	84	505	4	6	\N	70
4773	85	505	0	0	\N	0
4774	51	505	3	5	\N	50
4775	52	505	0	0	\N	0
4776	53	505	1	1	\N	20
4777	100	506	4	4	\N	90
4778	101	506	1	2	\N	20
4779	102	506	2	2	\N	40
4780	103	506	0	1	\N	0
4781	15	506	4	5	\N	80
4782	16	506	0	1	\N	0
4783	17	506	0	0	\N	0
4784	18	506	1	1	\N	20
4785	8	506	4	5	\N	80
4786	9	506	1	1	\N	20
4787	10	506	1	2	\N	20
4788	11	506	0	0	\N	0
4789	33	507	2	2	\N	40
4790	34	507	4	4	\N	90
4791	35	507	0	0	\N	0
4792	36	507	0	1	\N	0
4793	76	507	1	2	\N	20
4794	77	507	0	1	\N	0
4795	78	507	4	6	\N	70
4796	79	507	2	4	\N	30
4797	72	507	3	3	\N	60
4798	73	507	3	3	\N	60
4799	74	507	0	0	\N	0
4800	75	507	4	4	\N	90
4801	92	508	4	6	\N	70
4802	93	508	0	2	\N	-10
4803	94	508	0	0	\N	0
4804	95	508	0	0	\N	0
4805	58	508	4	4	\N	90
4806	59	508	0	0	\N	0
4807	60	508	1	1	\N	20
4808	61	508	1	1	\N	20
4809	69	508	4	5	\N	80
4810	70	508	1	1	\N	20
4811	71	508	4	5	\N	80
4812	42	509	4	6	\N	70
4813	43	509	2	3	\N	40
4814	44	509	0	0	\N	0
4815	45	509	2	4	\N	30
4816	46	509	2	3	\N	40
4817	47	509	2	2	\N	40
4818	19	509	2	2	\N	40
4819	20	509	0	0	\N	0
4820	21	509	1	1	\N	20
4821	69	510	4	5	\N	80
4822	70	510	1	1	\N	20
4823	71	510	2	2	\N	40
4824	37	510	4	4	\N	90
4825	38	510	2	2	\N	40
4826	39	510	0	2	\N	-10
4827	40	510	1	3	\N	10
4828	41	510	3	3	\N	60
4829	80	510	4	4	\N	90
4830	81	510	0	1	\N	0
4831	82	510	1	1	\N	20
4832	42	511	3	5	\N	50
4833	43	511	0	0	\N	0
4834	44	511	3	3	\N	60
4835	96	511	4	5	\N	80
4836	97	511	1	3	\N	10
4837	98	511	2	2	\N	40
4838	99	511	2	3	\N	40
4839	22	511	4	5	\N	80
4840	23	511	1	1	\N	20
4841	24	511	2	2	\N	40
4842	100	512	4	6	\N	70
4843	101	512	1	1	\N	20
4844	102	512	1	2	\N	20
4845	103	512	2	2	\N	40
4846	86	512	4	4	\N	90
4847	87	512	0	1	\N	0
4848	88	512	0	2	\N	-10
4849	48	512	1	4	\N	0
4850	49	512	1	1	\N	20
4851	50	512	0	1	\N	0
4852	51	513	4	6	\N	70
4853	52	513	0	0	\N	0
4854	53	513	2	4	\N	30
4855	1	513	4	4	\N	90
4856	2	513	4	5	\N	80
4857	3	513	1	1	\N	20
4858	72	513	4	4	\N	90
4859	73	513	1	1	\N	20
4860	74	513	0	0	\N	0
4861	75	513	2	4	\N	30
4862	58	514	2	3	\N	40
4863	59	514	2	3	\N	40
4864	60	514	0	0	\N	0
4865	61	514	2	3	\N	40
4866	12	514	4	5	\N	80
4867	13	514	2	2	\N	40
4868	14	514	1	1	\N	20
4869	8	514	3	3	\N	60
4870	9	514	0	1	\N	0
4871	10	514	0	1	\N	0
4872	11	514	4	5	\N	80
4873	25	515	3	5	\N	50
4874	26	515	2	2	\N	40
4875	27	515	0	0	\N	0
4876	62	515	0	1	\N	0
4877	63	515	2	2	\N	40
4878	64	515	0	0	\N	0
4879	65	515	0	0	\N	0
4880	66	515	1	2	\N	20
4881	67	515	0	0	\N	0
4882	68	515	2	2	\N	40
4883	92	516	4	5	\N	80
4884	93	516	2	2	\N	40
4885	94	516	1	1	\N	20
4886	95	516	0	0	\N	0
4887	4	516	3	3	\N	60
4888	5	516	1	2	\N	20
4889	6	516	0	1	\N	0
4890	7	516	1	2	\N	20
4891	15	516	4	4	\N	90
4892	16	516	1	1	\N	20
4893	17	516	1	2	\N	20
4894	18	516	4	4	\N	90
4895	89	517	4	6	\N	70
4896	90	517	1	1	\N	20
4897	91	517	0	0	\N	0
4898	83	517	1	3	\N	10
4899	84	517	3	4	\N	60
4900	85	517	0	0	\N	0
4901	33	517	0	2	\N	-10
4902	34	517	0	0	\N	0
4903	35	517	4	6	\N	70
4904	36	517	1	3	\N	10
4905	76	518	1	4	\N	0
4906	77	518	1	1	\N	20
4907	78	518	2	4	\N	30
4908	79	518	0	1	\N	0
4909	54	518	3	3	\N	60
4910	55	518	1	1	\N	20
4911	56	518	2	2	\N	40
4912	57	518	0	0	\N	0
4913	28	518	3	4	\N	60
4914	29	518	1	1	\N	20
4915	30	518	1	2	\N	20
4916	31	518	3	3	\N	60
4917	32	518	2	2	\N	40
4918	19	519	1	3	\N	10
4919	20	519	2	2	\N	40
4920	21	519	4	4	\N	90
4921	83	519	4	5	\N	80
4922	84	519	3	3	\N	60
4923	85	519	3	4	\N	60
4924	37	519	3	3	\N	60
4925	38	519	0	0	\N	0
4926	39	519	2	2	\N	40
4927	40	519	1	1	\N	20
4928	41	519	0	2	\N	-10
4929	1	520	4	5	\N	80
4930	2	520	0	2	\N	-10
4931	3	520	1	1	\N	20
4932	86	520	1	3	\N	10
4933	87	520	0	0	\N	0
4934	88	520	4	5	\N	80
4935	100	520	2	4	\N	30
4936	101	520	1	1	\N	20
4937	102	520	1	1	\N	20
4938	103	520	1	2	\N	20
4939	62	521	4	4	\N	90
4940	63	521	1	2	\N	20
4941	64	521	1	1	\N	20
4942	22	521	1	1	\N	20
4943	23	521	1	1	\N	20
4944	24	521	0	0	\N	0
4945	65	521	4	5	\N	80
4946	66	521	3	5	\N	50
4947	67	521	1	1	\N	20
4948	68	521	0	0	\N	0
4949	76	522	2	5	\N	20
4950	77	522	2	3	\N	40
4951	78	522	0	2	\N	-10
4952	79	522	4	4	\N	90
4953	4	522	3	6	\N	40
4954	5	522	2	3	\N	40
4955	6	522	0	1	\N	0
4956	7	522	4	4	\N	90
4957	33	522	3	4	\N	60
4958	34	522	1	1	\N	20
4959	35	522	2	2	\N	40
4960	36	522	3	4	\N	60
4961	80	523	3	6	\N	40
4962	81	523	2	2	\N	40
4963	82	523	2	2	\N	40
4964	69	523	4	5	\N	80
4965	70	523	2	2	\N	40
4966	71	523	0	0	\N	0
4967	42	523	4	4	\N	90
4968	43	523	4	4	\N	90
4969	44	523	1	1	\N	20
4970	58	524	3	6	\N	40
4971	59	524	2	2	\N	40
4972	60	524	4	6	\N	70
4973	61	524	0	2	\N	-10
4974	28	524	4	5	\N	80
4975	29	524	2	2	\N	40
4976	30	524	0	0	\N	0
4977	31	524	0	1	\N	0
4978	32	524	1	1	\N	20
4979	72	524	3	4	\N	60
4980	73	524	3	5	\N	50
4981	74	524	1	1	\N	20
4982	75	524	1	2	\N	20
4983	54	525	4	4	\N	90
4984	55	525	4	5	\N	80
4985	56	525	0	1	\N	0
4986	57	525	2	2	\N	40
4987	51	525	0	1	\N	0
4988	52	525	0	0	\N	0
4989	53	525	1	1	\N	20
4990	25	525	1	1	\N	20
4991	26	525	0	0	\N	0
4992	27	525	0	2	\N	-10
4993	92	526	3	5	\N	50
4994	93	526	4	5	\N	80
4995	94	526	2	2	\N	40
4996	95	526	4	4	\N	90
4997	45	526	3	3	\N	60
4998	46	526	1	2	\N	20
4999	47	526	4	4	\N	90
5000	12	526	3	4	\N	60
5001	13	526	1	1	\N	20
5002	14	526	0	0	\N	0
5003	89	527	3	4	\N	60
5004	90	527	3	4	\N	60
5005	91	527	0	0	\N	0
5006	48	527	4	5	\N	80
5007	49	527	2	2	\N	40
5008	50	527	1	2	\N	20
5009	15	527	3	4	\N	60
5010	16	527	3	3	\N	60
5011	17	527	0	0	\N	0
5012	18	527	0	0	\N	0
5013	96	528	4	6	\N	70
5014	97	528	3	3	\N	60
5015	98	528	2	4	\N	30
5016	99	528	4	5	\N	80
5017	8	528	0	1	\N	0
5018	9	528	0	1	\N	0
5019	10	528	2	2	\N	40
5020	11	528	2	3	\N	40
5021	83	528	4	4	\N	90
5022	84	528	1	1	\N	20
5023	85	528	1	2	\N	20
5024	22	529	3	3	\N	60
5025	23	529	0	0	\N	0
5026	24	529	0	1	\N	0
5027	4	529	3	3	\N	60
5028	5	529	1	1	\N	20
5029	6	529	0	1	\N	0
5030	7	529	0	0	\N	0
5031	76	529	4	4	\N	90
5032	77	529	4	5	\N	80
5033	78	529	0	0	\N	0
5034	79	529	4	4	\N	90
5035	96	530	4	6	\N	70
5036	97	530	3	3	\N	60
5037	98	530	0	0	\N	0
5038	99	530	1	1	\N	20
5039	100	530	4	4	\N	90
5040	101	530	0	1	\N	0
5041	102	530	2	3	\N	40
5042	103	530	1	1	\N	20
5043	12	530	4	5	\N	80
5044	13	530	2	4	\N	30
5045	14	530	0	1	\N	0
5046	25	531	4	4	\N	90
5047	26	531	0	2	\N	-10
5048	27	531	1	1	\N	20
5049	69	531	3	4	\N	60
5050	70	531	2	2	\N	40
5051	71	531	1	1	\N	20
5052	1	531	4	5	\N	80
5053	2	531	0	0	\N	0
5054	3	531	1	1	\N	20
5055	65	532	2	4	\N	30
5056	66	532	2	2	\N	40
5057	67	532	0	0	\N	0
5058	68	532	0	2	\N	-10
5059	19	532	4	5	\N	80
5060	20	532	1	1	\N	20
5061	21	532	1	2	\N	20
5062	45	532	0	1	\N	0
5063	46	532	0	0	\N	0
5064	47	532	2	2	\N	40
5065	42	533	3	3	\N	60
5066	43	533	0	0	\N	0
5067	44	533	1	1	\N	20
5068	28	533	3	4	\N	60
5069	29	533	0	0	\N	0
5070	30	533	0	0	\N	0
5071	31	533	2	3	\N	40
5072	32	533	1	1	\N	20
5073	89	533	3	3	\N	60
5074	90	533	0	1	\N	0
5075	91	533	0	0	\N	0
5076	80	534	1	3	\N	10
5077	81	534	3	5	\N	50
5078	82	534	1	2	\N	20
5079	54	534	3	4	\N	60
5080	55	534	4	4	\N	90
5081	56	534	2	3	\N	40
5082	57	534	0	0	\N	0
5083	15	534	3	5	\N	50
5084	16	534	4	6	\N	70
5085	17	534	1	3	\N	10
5086	18	534	0	0	\N	0
5087	8	535	2	5	\N	20
5088	9	535	2	2	\N	40
5089	10	535	2	2	\N	40
5090	11	535	0	0	\N	0
5091	58	535	3	5	\N	50
5092	59	535	2	2	\N	40
5093	60	535	0	0	\N	0
5094	61	535	0	0	\N	0
5095	33	535	2	2	\N	40
5096	34	535	2	2	\N	40
5097	35	535	2	4	\N	30
5098	36	535	4	5	\N	80
5099	51	536	4	5	\N	80
5100	52	536	4	4	\N	90
5101	53	536	3	4	\N	60
5102	72	536	4	4	\N	90
5103	73	536	3	3	\N	60
5104	74	536	2	4	\N	30
5105	75	536	0	1	\N	0
5106	37	536	4	5	\N	80
5107	38	536	3	3	\N	60
5108	39	536	4	6	\N	70
5109	40	536	1	1	\N	20
5110	41	536	0	0	\N	0
5111	92	537	4	4	\N	90
5112	93	537	4	4	\N	90
5113	94	537	1	1	\N	20
5114	95	537	0	1	\N	0
5115	86	537	3	4	\N	60
5116	87	537	4	4	\N	90
5117	88	537	2	2	\N	40
5118	62	537	4	5	\N	80
5119	63	537	0	1	\N	0
5120	64	537	4	4	\N	90
5121	48	538	3	5	\N	50
5122	49	538	2	2	\N	40
5123	50	538	1	3	\N	10
5124	83	538	4	5	\N	80
5125	84	538	0	0	\N	0
5126	85	538	2	2	\N	40
5127	51	538	4	4	\N	90
5128	52	538	1	3	\N	10
5129	53	538	0	2	\N	-10
5130	15	539	1	3	\N	10
5131	16	539	2	2	\N	40
5132	17	539	0	0	\N	0
5133	18	539	0	0	\N	0
5134	1	539	4	4	\N	90
5135	2	539	0	2	\N	-10
5136	3	539	1	1	\N	20
5137	25	539	4	5	\N	80
5138	26	539	1	1	\N	20
5139	27	539	0	1	\N	0
5140	92	540	3	5	\N	50
5141	93	540	1	1	\N	20
5142	94	540	0	0	\N	0
5143	95	540	1	1	\N	20
5144	65	540	3	3	\N	60
5145	66	540	1	1	\N	20
5146	67	540	1	2	\N	20
5147	68	540	0	2	\N	-10
5148	62	540	4	5	\N	80
5149	63	540	1	1	\N	20
5150	64	540	1	1	\N	20
5151	86	541	3	5	\N	50
5152	87	541	1	1	\N	20
5153	88	541	0	2	\N	-10
5154	8	541	4	5	\N	80
5155	9	541	3	3	\N	60
5156	10	541	1	1	\N	20
5157	11	541	2	3	\N	40
5158	45	541	3	6	\N	40
5159	46	541	0	0	\N	0
5160	47	541	1	2	\N	20
5161	58	542	1	3	\N	10
5162	59	542	1	1	\N	20
5163	60	542	3	4	\N	60
5164	61	542	0	0	\N	0
5165	100	542	4	5	\N	80
5166	101	542	1	1	\N	20
5167	102	542	2	3	\N	40
5168	103	542	0	0	\N	0
5169	22	542	3	4	\N	60
5170	23	542	1	1	\N	20
5171	24	542	1	1	\N	20
5172	28	543	3	3	\N	60
5173	29	543	2	2	\N	40
5174	30	543	4	4	\N	90
5175	31	543	1	1	\N	20
5176	32	543	1	1	\N	20
5177	42	543	0	0	\N	0
5178	43	543	1	1	\N	20
5179	44	543	2	3	\N	40
5180	37	543	4	4	\N	90
5181	38	543	4	4	\N	90
5182	39	543	0	0	\N	0
5183	40	543	2	2	\N	40
5184	41	543	1	1	\N	20
5185	96	544	4	4	\N	90
5186	97	544	0	0	\N	0
5187	98	544	1	1	\N	20
5188	99	544	4	6	\N	70
5189	72	544	1	1	\N	20
5190	73	544	2	4	\N	30
5191	74	544	0	2	\N	-10
5192	75	544	0	0	\N	0
5193	69	544	4	5	\N	80
5194	70	544	0	0	\N	0
5195	71	544	0	1	\N	0
5196	80	545	4	5	\N	80
5197	81	545	0	0	\N	0
5198	82	545	4	4	\N	90
5199	54	545	2	3	\N	40
5200	55	545	1	3	\N	10
5201	56	545	0	1	\N	0
5202	57	545	1	2	\N	20
5203	33	545	4	5	\N	80
5204	34	545	1	1	\N	20
5205	35	545	0	0	\N	0
5206	36	545	1	3	\N	10
5207	19	546	2	3	\N	40
5208	20	546	4	4	\N	90
5209	21	546	1	1	\N	20
5210	12	546	3	3	\N	60
5211	13	546	2	4	\N	30
5212	14	546	0	0	\N	0
5213	4	546	0	1	\N	0
5214	5	546	2	2	\N	40
5215	6	546	4	4	\N	90
5216	7	546	4	5	\N	80
5217	76	547	3	4	\N	60
5218	77	547	1	2	\N	20
5219	78	547	1	1	\N	20
5220	79	547	0	1	\N	0
5221	89	547	4	5	\N	80
5222	90	547	0	2	\N	-10
5223	91	547	1	1	\N	20
5224	48	547	1	2	\N	20
5225	49	547	0	0	\N	0
5226	50	547	1	1	\N	20
5227	105	550	4	6	\N	70
5228	106	550	3	4	\N	60
5229	119	550	4	5	\N	80
5230	120	550	1	1	\N	20
5231	121	550	2	3	\N	40
5232	122	550	0	1	\N	0
5233	180	550	1	3	\N	10
5234	181	550	3	3	\N	60
5235	143	551	0	2	\N	-10
5236	144	551	2	2	\N	40
5237	145	551	2	2	\N	40
5238	111	551	4	4	\N	90
5239	112	551	1	2	\N	20
5240	113	551	0	0	\N	0
5241	155	551	4	4	\N	90
5242	156	551	0	1	\N	0
5243	157	551	2	3	\N	40
5244	167	552	3	4	\N	60
5245	168	552	4	4	\N	90
5246	134	552	4	4	\N	90
5247	135	552	1	3	\N	10
5248	136	552	4	6	\N	70
5249	137	552	1	1	\N	20
5250	184	552	1	2	\N	20
5251	176	553	4	4	\N	90
5252	177	553	0	2	\N	-10
5253	178	553	1	1	\N	20
5254	179	553	0	2	\N	-10
5255	147	553	4	5	\N	80
5256	148	553	1	1	\N	20
5257	182	553	4	6	\N	70
5258	183	553	1	2	\N	20
5259	164	554	3	5	\N	50
5260	165	554	1	1	\N	20
5261	166	554	1	1	\N	20
5262	172	554	3	3	\N	60
5263	173	554	1	2	\N	20
5264	174	554	3	3	\N	60
5265	175	554	4	4	\N	90
5266	117	554	3	4	\N	60
5267	118	554	1	2	\N	20
5268	123	555	1	2	\N	20
5269	124	555	1	2	\N	20
5270	141	555	3	5	\N	50
5271	142	555	1	1	\N	20
5272	153	555	2	3	\N	40
5273	154	555	0	0	\N	0
5274	125	556	2	3	\N	40
5275	126	556	1	2	\N	20
5276	127	556	4	4	\N	90
5277	158	556	4	5	\N	80
5278	159	556	0	1	\N	0
5279	160	556	4	4	\N	90
5280	146	556	4	4	\N	90
5281	114	557	4	4	\N	90
5282	115	557	3	3	\N	60
5283	116	557	0	0	\N	0
5284	138	557	3	5	\N	50
5285	139	557	3	3	\N	60
5286	140	557	0	0	\N	0
5287	130	557	4	6	\N	70
5288	131	557	0	2	\N	-10
5289	132	557	2	3	\N	40
5290	133	557	0	0	\N	0
5291	104	558	2	2	\N	40
5292	107	558	2	3	\N	40
5293	108	558	1	1	\N	20
5294	109	558	0	0	\N	0
5295	110	558	0	1	\N	0
5296	128	558	2	3	\N	40
5297	129	558	0	0	\N	0
5298	185	559	2	2	\N	40
5299	186	559	0	1	\N	0
5300	187	559	3	3	\N	60
5301	149	559	1	1	\N	20
5302	150	559	0	2	\N	-10
5303	151	559	0	0	\N	0
5304	152	559	2	2	\N	40
5305	169	559	4	6	\N	70
5306	170	559	1	1	\N	20
5307	171	559	1	1	\N	20
5308	161	560	3	4	\N	60
5309	162	560	2	2	\N	40
5310	163	560	0	0	\N	0
5311	125	560	3	4	\N	60
5312	126	560	1	2	\N	20
5313	127	560	4	6	\N	70
5314	104	560	4	4	\N	90
5315	147	561	3	4	\N	60
5316	148	561	3	3	\N	60
5317	185	561	4	5	\N	80
5318	186	561	1	2	\N	20
5319	187	561	3	5	\N	50
5320	167	561	4	4	\N	90
5321	168	561	2	3	\N	40
5322	153	562	4	5	\N	80
5323	154	562	2	2	\N	40
5324	134	562	4	5	\N	80
5325	135	562	0	1	\N	0
5326	136	562	4	4	\N	90
5327	137	562	1	1	\N	20
5328	123	562	3	3	\N	60
5329	124	562	3	3	\N	60
5330	158	563	0	2	\N	-10
5331	159	563	1	1	\N	20
5332	160	563	1	1	\N	20
5333	180	563	4	4	\N	90
5334	181	563	2	2	\N	40
5335	138	563	0	0	\N	0
5336	139	563	0	1	\N	0
5337	140	563	0	0	\N	0
5338	172	564	4	4	\N	90
5339	173	564	0	2	\N	-10
5340	174	564	1	3	\N	10
5341	175	564	1	1	\N	20
5342	143	564	4	6	\N	70
5343	144	564	1	1	\N	20
5344	145	564	0	1	\N	0
5345	130	564	3	4	\N	60
5346	131	564	0	0	\N	0
5347	132	564	4	5	\N	80
5348	133	564	1	3	\N	10
5349	141	565	3	3	\N	60
5350	142	565	4	4	\N	90
5351	149	565	0	2	\N	-10
5352	150	565	3	4	\N	60
5353	151	565	1	3	\N	10
5354	152	565	0	0	\N	0
5355	111	565	4	4	\N	90
5356	112	565	2	3	\N	40
5357	113	565	1	1	\N	20
5358	155	566	3	4	\N	60
5359	156	566	3	3	\N	60
5360	157	566	1	1	\N	20
5361	117	566	4	5	\N	80
5362	118	566	2	2	\N	40
5363	184	566	3	5	\N	50
5364	105	567	3	4	\N	60
5365	106	567	1	1	\N	20
5366	164	567	3	4	\N	60
5367	165	567	0	1	\N	0
5368	166	567	1	2	\N	20
5369	161	567	4	5	\N	80
5370	162	567	4	5	\N	80
5371	163	567	0	2	\N	-10
5372	182	568	1	4	\N	0
5373	183	568	3	3	\N	60
5374	128	568	4	5	\N	80
5375	129	568	1	1	\N	20
5376	176	568	3	5	\N	50
5377	177	568	1	1	\N	20
5378	178	568	0	0	\N	0
5379	179	568	1	1	\N	20
5380	107	569	1	3	\N	10
5381	108	569	1	2	\N	20
5382	109	569	1	1	\N	20
5383	110	569	0	2	\N	-10
5384	119	569	3	6	\N	40
5385	120	569	0	0	\N	0
5386	121	569	1	1	\N	20
5387	122	569	1	1	\N	20
5388	169	569	4	5	\N	80
5389	170	569	1	1	\N	20
5390	171	569	2	4	\N	30
5391	146	570	0	1	\N	0
5392	114	570	3	6	\N	40
5393	115	570	4	6	\N	70
5394	116	570	3	3	\N	60
5395	182	570	3	5	\N	50
5396	183	570	2	2	\N	40
5397	130	571	2	3	\N	40
5398	131	571	1	1	\N	20
5399	132	571	2	2	\N	40
5400	133	571	1	1	\N	20
5401	134	571	1	3	\N	10
5402	135	571	3	3	\N	60
5403	136	571	2	3	\N	40
5404	137	571	0	0	\N	0
5405	128	571	3	3	\N	60
5406	129	571	0	0	\N	0
5407	153	572	4	4	\N	90
5408	154	572	0	2	\N	-10
5409	185	572	4	5	\N	80
5410	186	572	0	2	\N	-10
5411	187	572	0	0	\N	0
5412	184	572	3	5	\N	50
5413	114	573	2	3	\N	40
5414	115	573	1	2	\N	20
5415	116	573	4	6	\N	70
5416	125	573	4	6	\N	70
5417	126	573	0	1	\N	0
5418	127	573	0	0	\N	0
5419	169	573	1	1	\N	20
5420	170	573	1	1	\N	20
5421	171	573	3	3	\N	60
5422	172	574	3	4	\N	60
5423	173	574	0	0	\N	0
5424	174	574	4	4	\N	90
5425	175	574	4	4	\N	90
5426	146	574	3	4	\N	60
5427	155	574	3	4	\N	60
5428	156	574	4	5	\N	80
5429	157	574	0	0	\N	0
5430	167	575	0	1	\N	0
5431	168	575	0	0	\N	0
5432	164	575	4	5	\N	80
5433	165	575	1	1	\N	20
5434	166	575	1	1	\N	20
5435	149	575	4	5	\N	80
5436	150	575	3	3	\N	60
5437	151	575	2	2	\N	40
5438	152	575	0	0	\N	0
5439	141	576	0	1	\N	0
5440	142	576	4	4	\N	90
5441	107	576	3	3	\N	60
5442	108	576	0	1	\N	0
5443	109	576	3	5	\N	50
5444	110	576	0	1	\N	0
5445	180	576	1	1	\N	20
5446	181	576	0	0	\N	0
5447	104	577	4	5	\N	80
5448	105	577	4	6	\N	70
5449	106	577	1	1	\N	20
5450	176	577	0	2	\N	-10
5451	177	577	4	5	\N	80
5452	178	577	0	0	\N	0
5453	179	577	1	1	\N	20
5454	111	578	3	5	\N	50
5455	112	578	1	1	\N	20
5456	113	578	1	2	\N	20
5457	147	578	1	3	\N	10
5458	148	578	1	1	\N	20
5459	119	578	3	5	\N	50
5460	120	578	2	2	\N	40
5461	121	578	0	0	\N	0
5462	122	578	0	2	\N	-10
5463	138	579	3	6	\N	40
5464	139	579	0	1	\N	0
5465	140	579	0	0	\N	0
5466	117	579	4	4	\N	90
5467	118	579	3	5	\N	50
5468	158	579	2	2	\N	40
5469	159	579	3	3	\N	60
5470	160	579	4	5	\N	80
5471	161	580	4	5	\N	80
5472	162	580	1	1	\N	20
5473	163	580	0	0	\N	0
5474	123	580	4	4	\N	90
5475	124	580	4	6	\N	70
5476	143	580	4	4	\N	90
5477	144	580	0	1	\N	0
5478	145	580	3	3	\N	60
5479	158	581	2	3	\N	40
5480	159	581	4	4	\N	90
5481	160	581	1	2	\N	20
5482	155	581	2	5	\N	20
5483	156	581	0	0	\N	0
5484	157	581	0	0	\N	0
5485	147	581	3	3	\N	60
5486	148	581	2	3	\N	40
5487	167	582	0	3	\N	-20
5488	168	582	1	1	\N	20
5489	117	582	4	4	\N	90
5490	118	582	3	3	\N	60
5491	164	582	1	4	\N	0
5492	165	582	2	3	\N	40
5493	166	582	0	2	\N	-10
5494	125	583	1	1	\N	20
5495	126	583	2	4	\N	30
5496	127	583	3	3	\N	60
5497	153	583	4	5	\N	80
5498	154	583	1	2	\N	20
5499	176	583	4	5	\N	80
5500	177	583	0	0	\N	0
5501	178	583	1	3	\N	10
5502	179	583	1	2	\N	20
5503	169	584	4	5	\N	80
5504	170	584	1	1	\N	20
5505	171	584	0	0	\N	0
5506	149	584	3	3	\N	60
5507	150	584	2	2	\N	40
5508	151	584	0	0	\N	0
5509	152	584	0	0	\N	0
5510	130	584	4	4	\N	90
5511	131	584	0	0	\N	0
5512	132	584	1	2	\N	20
5513	133	584	0	0	\N	0
5514	172	585	4	6	\N	70
5515	173	585	0	1	\N	0
5516	174	585	0	0	\N	0
5517	175	585	3	3	\N	60
5518	146	585	3	4	\N	60
5519	180	585	4	4	\N	90
5520	181	585	2	2	\N	40
5521	123	586	0	1	\N	0
5522	124	586	0	0	\N	0
5523	114	586	4	4	\N	90
5524	115	586	2	4	\N	30
5525	116	586	1	1	\N	20
5526	182	586	3	4	\N	60
5527	183	586	1	1	\N	20
5528	185	587	4	5	\N	80
5529	186	587	2	2	\N	40
5530	187	587	1	1	\N	20
5531	184	587	4	4	\N	90
5532	105	587	3	6	\N	40
5533	106	587	0	0	\N	0
5534	128	588	4	6	\N	70
5535	129	588	1	1	\N	20
5536	119	588	3	4	\N	60
5537	120	588	1	2	\N	20
5538	121	588	3	3	\N	60
5539	122	588	3	5	\N	50
5540	141	588	3	3	\N	60
5541	142	588	1	1	\N	20
5542	111	589	3	4	\N	60
5543	112	589	0	1	\N	0
5544	113	589	2	2	\N	40
5545	107	589	3	6	\N	40
5546	108	589	1	1	\N	20
5547	109	589	0	1	\N	0
5548	110	589	4	5	\N	80
5549	161	589	0	1	\N	0
5550	162	589	0	0	\N	0
5551	163	589	3	3	\N	60
5552	143	590	3	5	\N	50
5553	144	590	4	4	\N	90
5554	145	590	0	1	\N	0
5555	104	590	3	4	\N	60
5556	134	590	3	4	\N	60
5557	135	590	2	2	\N	40
5558	136	590	3	3	\N	60
5559	137	590	0	0	\N	0
5560	138	591	3	6	\N	40
5561	139	591	1	1	\N	20
5562	140	591	2	3	\N	40
5563	184	591	0	3	\N	-20
5564	149	591	3	5	\N	50
5565	150	591	4	5	\N	80
5566	151	591	1	1	\N	20
5567	152	591	2	4	\N	30
5568	182	592	2	3	\N	40
5569	183	592	1	2	\N	20
5570	123	592	1	1	\N	20
5571	124	592	4	4	\N	90
5572	164	592	4	4	\N	90
5573	165	592	2	2	\N	40
5574	166	592	3	3	\N	60
5575	119	593	3	5	\N	50
5576	120	593	2	3	\N	40
5577	121	593	2	3	\N	40
5578	122	593	3	3	\N	60
5579	143	593	3	3	\N	60
5580	144	593	0	0	\N	0
5581	145	593	0	0	\N	0
5582	153	593	1	2	\N	20
5583	154	593	1	3	\N	10
5584	141	594	4	5	\N	80
5585	142	594	4	4	\N	90
5586	105	594	0	1	\N	0
5587	106	594	0	0	\N	0
5588	104	594	4	4	\N	90
5589	147	595	1	2	\N	20
5590	148	595	0	0	\N	0
5591	155	595	4	5	\N	80
5592	156	595	2	4	\N	30
5593	157	595	0	0	\N	0
5594	114	595	3	5	\N	50
5595	115	595	0	0	\N	0
5596	116	595	4	6	\N	70
5597	158	596	4	5	\N	80
5598	159	596	1	2	\N	20
5599	160	596	0	1	\N	0
5600	172	596	3	4	\N	60
5601	173	596	2	3	\N	40
5602	174	596	1	3	\N	10
5603	175	596	1	1	\N	20
5604	125	596	3	6	\N	40
5605	126	596	4	5	\N	80
5606	127	596	0	0	\N	0
5607	185	597	3	6	\N	40
5608	186	597	1	1	\N	20
5609	187	597	3	3	\N	60
5610	111	597	4	4	\N	90
5611	112	597	0	2	\N	-10
5612	113	597	1	1	\N	20
5613	161	597	2	2	\N	40
5614	162	597	0	0	\N	0
5615	163	597	1	1	\N	20
5616	117	598	4	6	\N	70
5617	118	598	1	2	\N	20
5618	130	598	2	4	\N	30
5619	131	598	0	0	\N	0
5620	132	598	1	1	\N	20
5621	133	598	1	1	\N	20
5622	107	598	1	3	\N	10
5623	108	598	2	2	\N	40
5624	109	598	1	1	\N	20
5625	110	598	0	2	\N	-10
5626	169	599	4	6	\N	70
5627	170	599	0	1	\N	0
5628	171	599	1	1	\N	20
5629	167	599	4	4	\N	90
5630	168	599	2	3	\N	40
5631	180	599	3	6	\N	40
5632	181	599	0	0	\N	0
5633	176	600	4	4	\N	90
5634	177	600	4	6	\N	70
5635	178	600	1	2	\N	20
5636	179	600	3	4	\N	60
5637	138	600	4	5	\N	80
5638	139	600	1	2	\N	20
5639	140	600	1	3	\N	10
5640	128	600	4	5	\N	80
5641	129	600	1	1	\N	20
5642	134	601	4	6	\N	70
5643	135	601	0	0	\N	0
5644	136	601	4	5	\N	80
5645	137	601	2	2	\N	40
5646	146	601	4	6	\N	70
5647	111	601	1	2	\N	20
5648	112	601	1	1	\N	20
5649	113	601	1	1	\N	20
5650	119	602	4	4	\N	90
5651	120	602	1	3	\N	10
5652	121	602	0	0	\N	0
5653	122	602	0	0	\N	0
5654	147	602	3	5	\N	50
5655	148	602	0	0	\N	0
5656	158	602	4	4	\N	90
5657	159	602	2	2	\N	40
5658	160	602	0	0	\N	0
5659	134	603	3	3	\N	60
5660	135	603	1	2	\N	20
5661	136	603	0	0	\N	0
5662	137	603	0	0	\N	0
5663	114	603	3	3	\N	60
5664	115	603	2	4	\N	30
5665	116	603	0	0	\N	0
5666	169	603	2	3	\N	40
5667	170	603	0	0	\N	0
5668	171	603	2	4	\N	30
5669	155	604	2	2	\N	40
5670	156	604	0	0	\N	0
5671	157	604	1	1	\N	20
5672	161	604	3	6	\N	40
5673	162	604	1	2	\N	20
5674	163	604	2	2	\N	40
5675	123	604	2	4	\N	30
5676	124	604	1	1	\N	20
5677	164	605	2	3	\N	40
5678	165	605	1	1	\N	20
5679	166	605	3	4	\N	60
5680	128	605	0	1	\N	0
5681	129	605	3	4	\N	60
5682	184	605	0	0	\N	0
5683	107	606	4	4	\N	90
5684	108	606	1	2	\N	20
5685	109	606	0	0	\N	0
5686	110	606	3	3	\N	60
5687	117	606	4	6	\N	70
5688	118	606	0	0	\N	0
5689	182	606	3	3	\N	60
5690	183	606	4	4	\N	90
5691	143	607	1	4	\N	0
5692	144	607	1	1	\N	20
5693	145	607	1	1	\N	20
5694	104	607	4	4	\N	90
5695	172	607	4	4	\N	90
5696	173	607	0	0	\N	0
5697	174	607	2	2	\N	40
5698	175	607	0	0	\N	0
5699	176	608	1	1	\N	20
5700	177	608	0	0	\N	0
5701	178	608	1	1	\N	20
5702	179	608	3	3	\N	60
5703	130	608	3	5	\N	50
5704	131	608	0	0	\N	0
5705	132	608	1	2	\N	20
5706	133	608	0	0	\N	0
5707	141	608	4	4	\N	90
5708	142	608	0	0	\N	0
5709	153	609	3	4	\N	60
5710	154	609	3	5	\N	50
5711	146	609	3	3	\N	60
5712	185	609	4	4	\N	90
5713	186	609	3	3	\N	60
5714	187	609	2	2	\N	40
5715	167	610	2	2	\N	40
5716	168	610	1	1	\N	20
5717	125	610	4	5	\N	80
5718	126	610	1	1	\N	20
5719	127	610	1	2	\N	20
5720	105	610	1	2	\N	20
5721	106	610	3	3	\N	60
5722	138	611	4	5	\N	80
5723	139	611	1	2	\N	20
5724	140	611	2	2	\N	40
5725	180	611	3	6	\N	40
5726	181	611	3	3	\N	60
5727	149	611	0	0	\N	0
5728	150	611	1	1	\N	20
5729	151	611	1	3	\N	10
5730	152	611	4	4	\N	90
5731	250	613	3	5	\N	50
5732	251	613	1	3	\N	10
5733	252	613	3	3	\N	60
5734	253	613	1	1	\N	20
5735	194	613	4	4	\N	90
5736	195	613	0	1	\N	0
5737	196	613	2	2	\N	40
5738	197	613	4	5	\N	80
5739	254	613	0	1	\N	0
5740	255	613	4	4	\N	90
5741	256	613	0	0	\N	0
5742	213	614	4	5	\N	80
5743	214	614	4	4	\N	90
5744	215	614	0	2	\N	-10
5745	216	614	2	4	\N	30
5746	244	614	0	1	\N	0
5747	245	614	0	1	\N	0
5748	246	614	3	3	\N	60
5749	247	614	3	4	\N	60
5750	248	614	0	0	\N	0
5751	249	614	2	2	\N	40
5752	204	615	4	4	\N	90
5753	205	615	2	3	\N	40
5754	206	615	2	3	\N	40
5755	233	615	1	2	\N	20
5756	234	615	1	3	\N	10
5757	235	615	0	1	\N	0
5758	207	615	3	5	\N	50
5759	208	615	4	4	\N	90
5760	209	615	2	2	\N	40
5761	240	616	3	5	\N	50
5762	241	616	1	1	\N	20
5763	242	616	1	1	\N	20
5764	243	616	0	2	\N	-10
5765	191	616	0	0	\N	0
5766	192	616	2	3	\N	40
5767	193	616	3	5	\N	50
5768	221	616	3	4	\N	60
5769	222	616	3	5	\N	50
5770	223	616	1	2	\N	20
5771	224	616	0	1	\N	0
5772	236	617	4	4	\N	90
5773	237	617	0	2	\N	-10
5774	238	617	2	2	\N	40
5775	239	617	0	0	\N	0
5776	225	617	4	4	\N	90
5777	226	617	3	4	\N	60
5778	227	617	3	3	\N	60
5779	228	617	0	0	\N	0
5780	201	617	0	1	\N	0
5781	202	617	0	1	\N	0
5782	203	617	3	3	\N	60
5783	229	618	3	3	\N	60
5784	230	618	1	2	\N	20
5785	231	618	0	0	\N	0
5786	232	618	0	0	\N	0
5787	210	618	0	2	\N	-10
5788	211	618	1	1	\N	20
5789	212	618	1	2	\N	20
5790	188	618	1	2	\N	20
5791	189	618	2	2	\N	40
5792	190	618	3	3	\N	60
5793	217	619	4	5	\N	80
5794	218	619	1	1	\N	20
5795	219	619	0	0	\N	0
5796	220	619	1	2	\N	20
5797	198	619	4	4	\N	90
5798	199	619	0	0	\N	0
5799	200	619	4	4	\N	90
5800	188	619	4	5	\N	80
5801	189	619	1	3	\N	10
5802	190	619	1	1	\N	20
5803	201	620	3	4	\N	60
5804	202	620	4	6	\N	70
5805	203	620	2	2	\N	40
5806	240	620	4	4	\N	90
5807	241	620	0	0	\N	0
5808	242	620	2	3	\N	40
5809	243	620	1	1	\N	20
5810	254	620	4	5	\N	80
5811	255	620	2	2	\N	40
5812	256	620	4	5	\N	80
5813	191	621	4	4	\N	90
5814	192	621	4	4	\N	90
5815	193	621	1	1	\N	20
5816	247	621	3	3	\N	60
5817	248	621	1	1	\N	20
5818	249	621	1	1	\N	20
5819	194	621	4	4	\N	90
5820	195	621	0	1	\N	0
5821	196	621	1	1	\N	20
5822	197	621	1	1	\N	20
5823	204	622	1	3	\N	10
5824	205	622	2	3	\N	40
5825	206	622	2	3	\N	40
5826	233	622	4	4	\N	90
5827	234	622	4	4	\N	90
5828	235	622	0	0	\N	0
5829	210	622	4	4	\N	90
5830	211	622	2	2	\N	40
5831	212	622	0	0	\N	0
5832	244	623	3	5	\N	50
5833	245	623	2	3	\N	40
5834	246	623	0	0	\N	0
5835	213	623	0	3	\N	-20
5836	214	623	1	1	\N	20
5837	215	623	4	4	\N	90
5838	216	623	0	1	\N	0
5839	225	623	3	6	\N	40
5840	226	623	3	3	\N	60
5841	227	623	2	2	\N	40
5842	228	623	0	1	\N	0
5843	207	624	4	5	\N	80
5844	208	624	1	3	\N	10
5845	209	624	1	2	\N	20
5846	217	624	3	5	\N	50
5847	218	624	4	4	\N	90
5848	219	624	1	2	\N	20
5849	220	624	2	4	\N	30
5850	229	624	1	1	\N	20
5851	230	624	0	2	\N	-10
5852	231	624	1	2	\N	20
5853	232	624	0	1	\N	0
5854	221	625	1	4	\N	0
5855	222	625	3	4	\N	60
5856	223	625	0	0	\N	0
5857	224	625	0	2	\N	-10
5858	250	625	3	3	\N	60
5859	251	625	0	1	\N	0
5860	252	625	1	2	\N	20
5861	253	625	2	2	\N	40
5862	236	625	3	4	\N	60
5863	237	625	0	0	\N	0
5864	238	625	0	2	\N	-10
5865	239	625	2	3	\N	40
5866	198	626	2	3	\N	40
5867	199	626	3	4	\N	60
5868	200	626	1	1	\N	20
5869	250	626	1	1	\N	20
5870	251	626	1	1	\N	20
5871	252	626	0	1	\N	0
5872	253	626	1	2	\N	20
5873	191	626	3	3	\N	60
5874	192	626	0	0	\N	0
5875	193	626	0	0	\N	0
5876	213	627	4	4	\N	90
5877	214	627	2	3	\N	40
5878	215	627	2	2	\N	40
5879	216	627	3	5	\N	50
5880	229	627	2	2	\N	40
5881	230	627	1	2	\N	20
5882	231	627	1	1	\N	20
5883	232	627	1	2	\N	20
5884	247	627	0	1	\N	0
5885	248	627	1	1	\N	20
5886	249	627	0	1	\N	0
5887	207	628	4	4	\N	90
5888	208	628	1	1	\N	20
5889	209	628	0	0	\N	0
5890	254	628	3	4	\N	60
5891	255	628	0	0	\N	0
5892	256	628	1	2	\N	20
5893	210	628	3	3	\N	60
5894	211	628	3	3	\N	60
5895	212	628	1	3	\N	10
5896	233	629	3	4	\N	60
5897	234	629	2	2	\N	40
5898	235	629	0	2	\N	-10
5899	194	629	3	4	\N	60
5900	195	629	4	5	\N	80
5901	196	629	1	3	\N	10
5902	197	629	1	1	\N	20
5903	221	629	4	4	\N	90
5904	222	629	2	2	\N	40
5905	223	629	4	4	\N	90
5906	224	629	2	2	\N	40
5907	201	630	3	4	\N	60
5908	202	630	1	1	\N	20
5909	203	630	2	2	\N	40
5910	188	630	4	4	\N	90
5911	189	630	4	4	\N	90
5912	190	630	0	0	\N	0
5913	244	630	3	4	\N	60
5914	245	630	4	4	\N	90
5915	246	630	3	3	\N	60
5916	198	631	3	5	\N	50
5917	199	631	1	1	\N	20
5918	200	631	1	1	\N	20
5919	225	631	3	6	\N	40
5920	226	631	0	0	\N	0
5921	227	631	1	3	\N	10
5922	228	631	3	4	\N	60
5923	236	631	4	5	\N	80
5924	237	631	1	3	\N	10
5925	238	631	0	0	\N	0
5926	239	631	1	1	\N	20
5927	217	632	3	3	\N	60
5928	218	632	0	1	\N	0
5929	219	632	0	1	\N	0
5930	220	632	4	5	\N	80
5931	204	632	4	4	\N	90
5932	205	632	0	1	\N	0
5933	206	632	0	0	\N	0
5934	240	632	4	5	\N	80
5935	241	632	1	1	\N	20
5936	242	632	1	1	\N	20
5937	243	632	1	2	\N	20
5938	247	633	3	6	\N	40
5939	248	633	1	3	\N	10
5940	249	633	3	3	\N	60
5941	225	633	3	4	\N	60
5942	226	633	0	0	\N	0
5943	227	633	2	2	\N	40
5944	228	633	4	4	\N	90
5945	240	633	3	6	\N	40
5946	241	633	1	1	\N	20
5947	242	633	0	0	\N	0
5948	243	633	0	0	\N	0
5949	233	634	0	0	\N	0
5950	234	634	3	3	\N	60
5951	235	634	1	1	\N	20
5952	201	634	3	5	\N	50
5953	202	634	0	1	\N	0
5954	203	634	1	1	\N	20
5955	250	634	4	5	\N	80
5956	251	634	0	1	\N	0
5957	252	634	2	2	\N	40
5958	253	634	1	1	\N	20
5959	229	635	3	3	\N	60
5960	230	635	1	2	\N	20
5961	231	635	0	0	\N	0
5962	232	635	0	0	\N	0
5963	213	635	3	4	\N	60
5964	214	635	2	2	\N	40
5965	215	635	0	0	\N	0
5966	216	635	3	3	\N	60
5967	198	635	3	5	\N	50
5968	199	635	3	3	\N	60
5969	200	635	4	4	\N	90
5970	210	636	4	4	\N	90
5971	211	636	1	1	\N	20
5972	212	636	2	3	\N	40
5973	191	636	3	4	\N	60
5974	192	636	2	3	\N	40
5975	193	636	1	1	\N	20
5976	244	636	4	5	\N	80
5977	245	636	4	4	\N	90
5978	246	636	0	0	\N	0
5979	221	637	0	1	\N	0
5980	222	637	4	4	\N	90
5981	223	637	4	4	\N	90
5982	224	637	0	0	\N	0
5983	207	637	4	5	\N	80
5984	208	637	2	2	\N	40
5985	209	637	0	0	\N	0
5986	236	637	1	1	\N	20
5987	237	637	1	3	\N	10
5988	238	637	0	0	\N	0
5989	239	637	3	4	\N	60
5990	204	638	4	4	\N	90
5991	205	638	1	1	\N	20
5992	206	638	1	2	\N	20
5993	194	638	4	4	\N	90
5994	195	638	0	0	\N	0
5995	196	638	4	4	\N	90
5996	197	638	0	1	\N	0
5997	217	638	4	5	\N	80
5998	218	638	0	0	\N	0
5999	219	638	2	4	\N	30
6000	220	638	0	1	\N	0
6001	188	639	4	4	\N	90
6002	189	639	1	1	\N	20
6003	190	639	4	4	\N	90
6004	254	639	0	1	\N	0
6005	255	639	1	3	\N	10
6006	256	639	0	0	\N	0
6007	188	639	3	3	\N	60
6008	189	639	0	1	\N	0
6009	190	639	1	2	\N	20
6010	229	640	3	6	\N	40
6011	230	640	0	1	\N	0
6012	231	640	2	2	\N	40
6013	232	640	1	3	\N	10
6014	204	640	3	4	\N	60
6015	205	640	1	3	\N	10
6016	206	640	0	2	\N	-10
6017	247	640	3	6	\N	40
6018	248	640	1	3	\N	10
6019	249	640	0	0	\N	0
6020	194	641	4	4	\N	90
6021	195	641	2	2	\N	40
6022	196	641	4	4	\N	90
6023	197	641	0	0	\N	0
6024	254	641	3	4	\N	60
6025	255	641	1	1	\N	20
6026	256	641	2	3	\N	40
6027	221	641	0	2	\N	-10
6028	222	641	1	1	\N	20
6029	223	641	1	1	\N	20
6030	224	641	2	2	\N	40
6031	244	642	1	1	\N	20
6032	245	642	1	2	\N	20
6033	246	642	0	1	\N	0
6034	201	642	0	2	\N	-10
6035	202	642	2	2	\N	40
6036	203	642	1	1	\N	20
6037	250	642	3	4	\N	60
6038	251	642	0	0	\N	0
6039	252	642	2	4	\N	30
6040	253	642	0	0	\N	0
6041	191	643	1	4	\N	0
6042	192	643	1	1	\N	20
6043	193	643	3	3	\N	60
6044	236	643	3	3	\N	60
6045	237	643	1	3	\N	10
6046	238	643	1	3	\N	10
6047	239	643	0	0	\N	0
6048	213	643	1	2	\N	20
6049	214	643	0	0	\N	0
6050	215	643	0	0	\N	0
6051	216	643	2	3	\N	40
6052	198	644	4	5	\N	80
6053	199	644	2	2	\N	40
6054	200	644	1	1	\N	20
6055	217	644	1	1	\N	20
6056	218	644	1	1	\N	20
6057	219	644	0	0	\N	0
6058	220	644	4	4	\N	90
6059	225	644	4	5	\N	80
6060	226	644	1	1	\N	20
6061	227	644	2	3	\N	40
6062	228	644	0	0	\N	0
6063	240	645	4	5	\N	80
6064	241	645	0	2	\N	-10
6065	242	645	0	2	\N	-10
6066	243	645	1	1	\N	20
6067	233	645	4	5	\N	80
6068	234	645	1	1	\N	20
6069	235	645	2	2	\N	40
6070	210	645	1	3	\N	10
6071	211	645	0	0	\N	0
6072	212	645	0	2	\N	-10
6073	207	646	3	6	\N	40
6074	208	646	4	4	\N	90
6075	209	646	0	1	\N	0
6076	240	646	1	1	\N	20
6077	241	646	2	4	\N	30
6078	242	646	0	0	\N	0
6079	243	646	4	4	\N	90
6080	236	646	4	5	\N	80
6081	237	646	4	4	\N	90
6082	238	646	1	1	\N	20
6083	239	646	1	1	\N	20
6084	221	647	3	4	\N	60
6085	222	647	4	4	\N	90
6086	223	647	1	2	\N	20
6087	224	647	0	1	\N	0
6088	244	647	3	3	\N	60
6089	245	647	2	2	\N	40
6090	246	647	0	0	\N	0
6091	188	647	3	3	\N	60
6092	189	647	1	2	\N	20
6093	190	647	2	4	\N	30
6094	207	648	3	6	\N	40
6095	208	648	1	2	\N	20
6096	209	648	1	1	\N	20
6097	217	648	4	5	\N	80
6098	218	648	0	1	\N	0
6099	219	648	1	1	\N	20
6100	220	648	0	1	\N	0
6101	210	648	4	6	\N	70
6102	211	648	1	3	\N	10
6103	212	648	1	1	\N	20
6104	254	649	4	6	\N	70
6105	255	649	2	2	\N	40
6106	256	649	3	3	\N	60
6107	198	649	3	4	\N	60
6108	199	649	0	1	\N	0
6109	200	649	0	1	\N	0
6110	194	649	4	5	\N	80
6111	195	649	2	2	\N	40
6112	196	649	1	1	\N	20
6113	197	649	0	2	\N	-10
6114	204	650	4	5	\N	80
6115	205	650	2	2	\N	40
6116	206	650	1	1	\N	20
6117	225	650	3	6	\N	40
6118	226	650	2	2	\N	40
6119	227	650	0	2	\N	-10
6120	228	650	0	1	\N	0
6121	229	650	3	4	\N	60
6122	230	650	3	3	\N	60
6123	231	650	2	4	\N	30
6124	232	650	2	2	\N	40
6125	233	651	3	3	\N	60
6126	234	651	0	1	\N	0
6127	235	651	2	2	\N	40
6128	247	651	1	2	\N	20
6129	248	651	4	6	\N	70
6130	249	651	4	4	\N	90
6131	213	651	3	5	\N	50
6132	214	651	0	2	\N	-10
6133	215	651	3	3	\N	60
6134	216	651	2	4	\N	30
6135	191	652	4	5	\N	80
6136	192	652	1	3	\N	10
6137	193	652	3	3	\N	60
6138	250	652	3	3	\N	60
6139	251	652	2	2	\N	40
6140	252	652	0	0	\N	0
6141	253	652	2	2	\N	40
6142	201	652	4	4	\N	90
6143	202	652	0	0	\N	0
6144	203	652	1	1	\N	20
6145	69	653	4	5	\N	80
6146	70	653	2	2	\N	40
6147	71	653	2	3	\N	40
6148	89	653	3	5	\N	50
6149	90	653	1	2	\N	20
6150	91	653	1	2	\N	20
6151	28	653	4	6	\N	70
6152	29	653	1	1	\N	20
6153	30	653	1	1	\N	20
6154	31	653	4	4	\N	90
6155	32	653	3	5	\N	50
6156	4	654	4	6	\N	70
6157	5	654	3	3	\N	60
6158	6	654	0	0	\N	0
6159	7	654	0	0	\N	0
6160	72	654	4	4	\N	90
6161	73	654	3	4	\N	60
6162	74	654	3	3	\N	60
6163	75	654	0	0	\N	0
6164	86	654	3	5	\N	50
6165	87	654	1	3	\N	10
6166	88	654	1	1	\N	20
6167	19	655	4	4	\N	90
6168	20	655	1	3	\N	10
6169	21	655	0	1	\N	0
6170	100	655	0	1	\N	0
6171	101	655	4	5	\N	80
6172	102	655	2	2	\N	40
6173	103	655	0	0	\N	0
6174	42	655	4	5	\N	80
6175	43	655	0	1	\N	0
6176	44	655	0	0	\N	0
6177	54	656	0	1	\N	0
6178	55	656	1	1	\N	20
6179	56	656	4	6	\N	70
6180	57	656	2	4	\N	30
6181	76	656	4	4	\N	90
6182	77	656	0	0	\N	0
6183	78	656	0	1	\N	0
6184	79	656	2	2	\N	40
6185	96	656	3	3	\N	60
6186	97	656	2	4	\N	30
6187	98	656	4	5	\N	80
6188	99	656	0	0	\N	0
6189	51	657	3	6	\N	40
6190	52	657	1	1	\N	20
6191	53	657	1	1	\N	20
6192	45	657	1	3	\N	10
6193	46	657	0	2	\N	-10
6194	47	657	2	2	\N	40
6195	83	657	0	2	\N	-10
6196	84	657	2	2	\N	40
6197	85	657	4	4	\N	90
6198	25	658	3	3	\N	60
6199	26	658	4	4	\N	90
6200	27	658	2	3	\N	40
6201	1	658	4	4	\N	90
6202	2	658	0	1	\N	0
6203	3	658	0	0	\N	0
6204	33	658	3	5	\N	50
6205	34	658	1	1	\N	20
6206	35	658	4	4	\N	90
6207	36	658	2	2	\N	40
6208	12	659	3	4	\N	60
6209	13	659	4	4	\N	90
6210	14	659	1	1	\N	20
6211	65	659	3	6	\N	40
6212	66	659	3	3	\N	60
6213	67	659	1	1	\N	20
6214	68	659	1	1	\N	20
6215	8	659	2	2	\N	40
6216	9	659	2	4	\N	30
6217	10	659	0	2	\N	-10
6218	11	659	1	3	\N	10
6219	92	660	0	0	\N	0
6220	93	660	1	1	\N	20
6221	94	660	1	3	\N	10
6222	95	660	2	2	\N	40
6223	15	660	0	0	\N	0
6224	16	660	1	1	\N	20
6225	17	660	0	1	\N	0
6226	18	660	1	1	\N	20
6227	58	660	4	4	\N	90
6228	59	660	1	1	\N	20
6229	60	660	1	3	\N	10
6230	61	660	0	0	\N	0
6231	22	661	1	2	\N	20
6232	23	661	4	6	\N	70
6233	24	661	4	4	\N	90
6234	37	661	0	1	\N	0
6235	38	661	2	2	\N	40
6236	39	661	0	1	\N	0
6237	40	661	0	0	\N	0
6238	41	661	1	1	\N	20
6239	48	661	4	5	\N	80
6240	49	661	2	2	\N	40
6241	50	661	4	4	\N	90
6242	80	662	2	3	\N	40
6243	81	662	0	0	\N	0
6244	82	662	0	2	\N	-10
6245	62	662	4	5	\N	80
6246	63	662	2	3	\N	40
6247	64	662	3	3	\N	60
6248	76	662	4	6	\N	70
6249	77	662	0	1	\N	0
6250	78	662	1	1	\N	20
6251	79	662	1	2	\N	20
6252	54	663	4	4	\N	90
6253	55	663	0	1	\N	0
6254	56	663	4	4	\N	90
6255	57	663	1	1	\N	20
6256	48	663	4	6	\N	70
6257	49	663	2	4	\N	30
6258	50	663	2	3	\N	40
6259	100	663	4	5	\N	80
6260	101	663	1	2	\N	20
6261	102	663	1	1	\N	20
6262	103	663	3	3	\N	60
6263	62	664	3	4	\N	60
6264	63	664	2	3	\N	40
6265	64	664	0	0	\N	0
6266	89	664	2	5	\N	20
6267	90	664	0	2	\N	-10
6268	91	664	1	1	\N	20
6269	69	664	3	4	\N	60
6270	70	664	0	0	\N	0
6271	71	664	1	1	\N	20
6272	19	665	4	4	\N	90
6273	20	665	3	3	\N	60
6274	21	665	0	0	\N	0
6275	42	665	2	3	\N	40
6276	43	665	2	3	\N	40
6277	44	665	0	1	\N	0
6278	96	665	4	4	\N	90
6279	97	665	0	0	\N	0
6280	98	665	0	0	\N	0
6281	99	665	1	2	\N	20
6282	1	666	4	4	\N	90
6283	2	666	1	1	\N	20
6284	3	666	4	4	\N	90
6285	25	666	1	3	\N	10
6286	26	666	1	1	\N	20
6287	27	666	0	1	\N	0
6288	83	666	2	3	\N	40
6289	84	666	0	0	\N	0
6290	85	666	0	2	\N	-10
6291	12	667	0	0	\N	0
6292	13	667	1	2	\N	20
6293	14	667	0	1	\N	0
6294	37	667	3	5	\N	50
6295	38	667	0	2	\N	-10
6296	39	667	3	3	\N	60
6297	40	667	1	1	\N	20
6298	41	667	1	1	\N	20
6299	51	667	4	6	\N	70
6300	52	667	3	3	\N	60
6301	53	667	1	1	\N	20
6302	8	668	2	3	\N	40
6303	9	668	0	0	\N	0
6304	10	668	0	1	\N	0
6305	11	668	2	4	\N	30
6306	33	668	0	1	\N	0
6307	34	668	1	3	\N	10
6308	35	668	0	1	\N	0
6309	36	668	2	2	\N	40
6310	86	668	3	3	\N	60
6311	87	668	0	1	\N	0
6312	88	668	1	2	\N	20
6313	80	669	4	4	\N	90
6314	81	669	0	1	\N	0
6315	82	669	1	1	\N	20
6316	65	669	4	5	\N	80
6317	66	669	4	4	\N	90
6318	67	669	0	1	\N	0
6319	68	669	3	3	\N	60
6320	28	669	3	4	\N	60
6321	29	669	0	0	\N	0
6322	30	669	2	2	\N	40
6323	31	669	3	4	\N	60
6324	32	669	3	3	\N	60
6325	72	670	3	4	\N	60
6326	73	670	0	0	\N	0
6327	74	670	0	1	\N	0
6328	75	670	0	0	\N	0
6329	92	670	3	4	\N	60
6330	93	670	3	3	\N	60
6331	94	670	2	2	\N	40
6332	95	670	4	4	\N	90
6333	4	670	4	4	\N	90
6334	5	670	2	2	\N	40
6335	6	670	3	4	\N	60
6336	7	670	1	1	\N	20
6337	22	671	3	3	\N	60
6338	23	671	1	1	\N	20
6339	24	671	1	1	\N	20
6340	58	671	1	1	\N	20
6341	59	671	1	1	\N	20
6342	60	671	2	2	\N	40
6343	61	671	4	4	\N	90
6344	45	671	2	4	\N	30
6345	46	671	0	1	\N	0
6346	47	671	4	4	\N	90
6347	15	672	4	5	\N	80
6348	16	672	1	1	\N	20
6349	17	672	3	3	\N	60
6350	18	672	2	2	\N	40
6351	92	672	4	5	\N	80
6352	93	672	1	3	\N	10
6353	94	672	0	2	\N	-10
6354	95	672	0	0	\N	0
6355	100	672	1	2	\N	20
6356	101	672	2	3	\N	40
6357	102	672	2	2	\N	40
6358	103	672	0	0	\N	0
6359	48	673	4	4	\N	90
6360	49	673	4	4	\N	90
6361	50	673	4	4	\N	90
6362	25	673	3	4	\N	60
6363	26	673	0	0	\N	0
6364	27	673	1	1	\N	20
6365	42	673	0	0	\N	0
6366	43	673	0	2	\N	-10
6367	44	673	0	2	\N	-10
6368	62	674	3	4	\N	60
6369	63	674	1	1	\N	20
6370	64	674	1	2	\N	20
6371	80	674	4	5	\N	80
6372	81	674	1	1	\N	20
6373	82	674	0	0	\N	0
6374	58	674	0	2	\N	-10
6375	59	674	1	1	\N	20
6376	60	674	3	3	\N	60
6377	61	674	2	4	\N	30
6378	28	675	4	5	\N	80
6379	29	675	0	1	\N	0
6380	30	675	1	3	\N	10
6381	31	675	4	4	\N	90
6382	32	675	0	2	\N	-10
6383	65	675	1	3	\N	10
6384	66	675	4	4	\N	90
6385	67	675	3	3	\N	60
6386	68	675	2	2	\N	40
6387	12	675	1	2	\N	20
6388	13	675	0	1	\N	0
6389	14	675	1	2	\N	20
6390	33	676	4	4	\N	90
6391	34	676	1	1	\N	20
6392	35	676	0	1	\N	0
6393	36	676	4	4	\N	90
6394	51	676	1	2	\N	20
6395	52	676	0	0	\N	0
6396	53	676	4	5	\N	80
6397	96	676	4	6	\N	70
6398	97	676	1	1	\N	20
6399	98	676	1	1	\N	20
6400	99	676	2	3	\N	40
6401	8	677	4	4	\N	90
6402	9	677	1	1	\N	20
6403	10	677	3	5	\N	50
6404	11	677	1	1	\N	20
6405	89	677	4	4	\N	90
6406	90	677	1	3	\N	10
6407	91	677	0	1	\N	0
6408	86	677	3	5	\N	50
6409	87	677	1	1	\N	20
6410	88	677	0	2	\N	-10
6411	69	678	2	5	\N	20
6412	70	678	0	0	\N	0
6413	71	678	1	3	\N	10
6414	19	678	0	3	\N	-20
6415	20	678	2	2	\N	40
6416	21	678	4	4	\N	90
6417	76	678	4	4	\N	90
6418	77	678	2	4	\N	30
6419	78	678	2	2	\N	40
6420	79	678	0	1	\N	0
6421	54	679	3	6	\N	40
6422	55	679	1	1	\N	20
6423	56	679	1	1	\N	20
6424	57	679	0	0	\N	0
6425	15	679	2	4	\N	30
6426	16	679	3	4	\N	60
6427	17	679	0	0	\N	0
6428	18	679	3	3	\N	60
6429	22	679	4	4	\N	90
6430	23	679	2	2	\N	40
6431	24	679	1	1	\N	20
6432	37	680	3	6	\N	40
6433	38	680	2	2	\N	40
6434	39	680	4	4	\N	90
6435	40	680	3	3	\N	60
6436	41	680	0	1	\N	0
6437	45	680	0	1	\N	0
6438	46	680	2	4	\N	30
6439	47	680	2	2	\N	40
6440	1	680	4	4	\N	90
6441	2	680	3	4	\N	60
6442	3	680	0	0	\N	0
6443	72	681	3	5	\N	50
6444	73	681	0	1	\N	0
6445	74	681	1	1	\N	20
6446	75	681	2	2	\N	40
6447	83	681	3	6	\N	40
6448	84	681	3	3	\N	60
6449	85	681	0	0	\N	0
6450	4	681	4	5	\N	80
6451	5	681	3	3	\N	60
6452	6	681	0	2	\N	-10
6453	7	681	3	3	\N	60
6454	86	682	4	5	\N	80
6455	87	682	3	4	\N	60
6456	88	682	1	2	\N	20
6457	92	682	1	2	\N	20
6458	93	682	2	2	\N	40
6459	94	682	1	1	\N	20
6460	95	682	0	1	\N	0
6461	69	682	4	4	\N	90
6462	70	682	0	1	\N	0
6463	71	682	1	1	\N	20
6464	72	683	4	4	\N	90
6465	73	683	1	1	\N	20
6466	74	683	0	0	\N	0
6467	75	683	0	0	\N	0
6468	25	683	3	4	\N	60
6469	26	683	0	0	\N	0
6470	27	683	1	1	\N	20
6471	76	683	3	3	\N	60
6472	77	683	1	3	\N	10
6473	78	683	4	5	\N	80
6474	79	683	2	3	\N	40
6475	8	684	4	5	\N	80
6476	9	684	1	3	\N	10
6477	10	684	0	0	\N	0
6478	11	684	0	0	\N	0
6479	37	684	3	4	\N	60
6480	38	684	1	1	\N	20
6481	39	684	0	0	\N	0
6482	40	684	1	2	\N	20
6483	41	684	2	3	\N	40
6484	54	684	3	5	\N	50
6485	55	684	0	1	\N	0
6486	56	684	2	3	\N	40
6487	57	684	1	2	\N	20
6488	12	685	1	3	\N	10
6489	13	685	0	2	\N	-10
6490	14	685	2	2	\N	40
6491	28	685	4	6	\N	70
6492	29	685	2	3	\N	40
6493	30	685	2	4	\N	30
6494	31	685	3	5	\N	50
6495	32	685	1	1	\N	20
6496	42	685	3	6	\N	40
6497	43	685	2	3	\N	40
6498	44	685	4	4	\N	90
6499	83	686	4	4	\N	90
6500	84	686	1	2	\N	20
6501	85	686	0	0	\N	0
6502	96	686	4	4	\N	90
6503	97	686	1	1	\N	20
6504	98	686	3	4	\N	60
6505	99	686	2	4	\N	30
6506	80	686	4	5	\N	80
6507	81	686	4	5	\N	80
6508	82	686	1	1	\N	20
6509	1	687	4	5	\N	80
6510	2	687	2	2	\N	40
6511	3	687	1	3	\N	10
6512	89	687	4	4	\N	90
6513	90	687	0	2	\N	-10
6514	91	687	2	4	\N	30
6515	62	687	2	2	\N	40
6516	63	687	0	1	\N	0
6517	64	687	1	3	\N	10
6518	4	688	1	2	\N	20
6519	5	688	1	1	\N	20
6520	6	688	4	4	\N	90
6521	7	688	0	0	\N	0
6522	45	688	4	4	\N	90
6523	46	688	0	2	\N	-10
6524	47	688	1	2	\N	20
6525	51	688	3	6	\N	40
6526	52	688	3	3	\N	60
6527	53	688	3	5	\N	50
6528	22	689	2	3	\N	40
6529	23	689	2	2	\N	40
6530	24	689	1	2	\N	20
6531	19	689	3	5	\N	50
6532	20	689	2	2	\N	40
6533	21	689	2	2	\N	40
6534	100	689	2	5	\N	20
6535	101	689	2	2	\N	40
6536	102	689	0	0	\N	0
6537	103	689	2	2	\N	40
6538	33	690	3	3	\N	60
6539	34	690	1	3	\N	10
6540	35	690	2	3	\N	40
6541	36	690	0	1	\N	0
6542	48	690	2	3	\N	40
6543	49	690	2	2	\N	40
6544	50	690	2	2	\N	40
6545	15	690	1	3	\N	10
6546	16	690	3	3	\N	60
6547	17	690	0	2	\N	-10
6548	18	690	2	2	\N	40
6549	65	691	4	6	\N	70
6550	66	691	1	1	\N	20
6551	67	691	0	1	\N	0
6552	68	691	2	2	\N	40
6553	58	691	4	4	\N	90
6554	59	691	3	3	\N	60
6555	60	691	1	2	\N	20
6556	61	691	3	3	\N	60
6557	58	691	0	1	\N	0
6558	59	691	0	0	\N	0
6559	60	691	1	1	\N	20
6560	61	691	2	3	\N	40
6561	96	692	4	4	\N	90
6562	97	692	0	1	\N	0
6563	98	692	0	2	\N	-10
6564	99	692	2	4	\N	30
6565	83	692	1	2	\N	20
6566	84	692	0	2	\N	-10
6567	85	692	0	0	\N	0
6568	42	692	1	2	\N	20
6569	43	692	1	1	\N	20
6570	44	692	3	3	\N	60
6571	33	693	3	3	\N	60
6572	34	693	2	3	\N	40
6573	35	693	2	3	\N	40
6574	36	693	2	3	\N	40
6575	89	693	4	6	\N	70
6576	90	693	4	4	\N	90
6577	91	693	1	2	\N	20
6578	8	693	3	4	\N	60
6579	9	693	1	2	\N	20
6580	10	693	2	2	\N	40
6581	11	693	2	2	\N	40
6582	65	694	1	2	\N	20
6583	66	694	3	4	\N	60
6584	67	694	0	0	\N	0
6585	68	694	0	0	\N	0
6586	19	694	4	4	\N	90
6587	20	694	0	0	\N	0
6588	21	694	0	0	\N	0
6589	92	694	1	2	\N	20
6590	93	694	4	4	\N	90
6591	94	694	0	0	\N	0
6592	95	694	1	1	\N	20
6593	69	695	3	4	\N	60
6594	70	695	0	0	\N	0
6595	71	695	2	2	\N	40
6596	62	695	4	5	\N	80
6597	63	695	1	2	\N	20
6598	64	695	3	3	\N	60
6599	4	695	3	3	\N	60
6600	5	695	4	5	\N	80
6601	6	695	2	2	\N	40
6602	7	695	0	0	\N	0
6603	12	696	3	3	\N	60
6604	13	696	2	3	\N	40
6605	14	696	1	1	\N	20
6606	45	696	3	6	\N	40
6607	46	696	1	2	\N	20
6608	47	696	1	2	\N	20
6609	54	696	3	4	\N	60
6610	55	696	1	1	\N	20
6611	56	696	2	3	\N	40
6612	57	696	0	1	\N	0
6613	1	697	4	5	\N	80
6614	2	697	2	2	\N	40
6615	3	697	0	0	\N	0
6616	76	697	4	4	\N	90
6617	77	697	0	1	\N	0
6618	78	697	0	0	\N	0
6619	79	697	1	1	\N	20
6620	15	697	4	4	\N	90
6621	16	697	0	0	\N	0
6622	17	697	4	6	\N	70
6623	18	697	0	0	\N	0
6624	80	698	4	4	\N	90
6625	81	698	0	0	\N	0
6626	82	698	0	0	\N	0
6627	25	698	3	4	\N	60
6628	26	698	0	0	\N	0
6629	27	698	4	4	\N	90
6630	22	698	3	5	\N	50
6631	23	698	2	2	\N	40
6632	24	698	2	2	\N	40
6633	37	699	4	4	\N	90
6634	38	699	2	2	\N	40
6635	39	699	0	0	\N	0
6636	40	699	1	2	\N	20
6637	41	699	3	3	\N	60
6638	28	699	2	4	\N	30
6639	29	699	0	0	\N	0
6640	30	699	2	2	\N	40
6641	31	699	0	0	\N	0
6642	32	699	2	2	\N	40
6643	48	699	3	6	\N	40
6644	49	699	3	3	\N	60
6645	50	699	0	0	\N	0
6646	100	700	0	1	\N	0
6647	101	700	4	5	\N	80
6648	102	700	2	2	\N	40
6649	103	700	1	1	\N	20
6650	72	700	1	3	\N	10
6651	73	700	0	0	\N	0
6652	74	700	0	0	\N	0
6653	75	700	1	2	\N	20
6654	86	700	3	4	\N	60
6655	87	700	0	1	\N	0
6656	88	700	3	3	\N	60
6657	51	701	3	3	\N	60
6658	52	701	1	1	\N	20
6659	53	701	2	4	\N	30
6660	86	701	4	6	\N	70
6661	87	701	4	4	\N	90
6662	88	701	2	3	\N	40
6663	1	701	3	5	\N	50
6664	2	701	1	2	\N	20
6665	3	701	0	0	\N	0
6666	58	702	2	2	\N	40
6667	59	702	0	2	\N	-10
6668	60	702	1	2	\N	20
6669	61	702	1	1	\N	20
6670	72	702	4	5	\N	80
6671	73	702	0	1	\N	0
6672	74	702	0	0	\N	0
6673	75	702	0	0	\N	0
6674	92	702	2	3	\N	40
6675	93	702	2	3	\N	40
6676	94	702	2	2	\N	40
6677	95	702	0	0	\N	0
6678	83	703	4	6	\N	70
6679	84	703	1	1	\N	20
6680	85	703	0	0	\N	0
6681	96	703	3	5	\N	50
6682	97	703	1	2	\N	20
6683	98	703	0	0	\N	0
6684	99	703	0	0	\N	0
6685	33	703	4	5	\N	80
6686	34	703	1	2	\N	20
6687	35	703	4	5	\N	80
6688	36	703	1	1	\N	20
6689	22	704	4	4	\N	90
6690	23	704	2	3	\N	40
6691	24	704	1	2	\N	20
6692	42	704	2	4	\N	30
6693	43	704	4	5	\N	80
6694	44	704	0	1	\N	0
6695	62	704	3	4	\N	60
6696	63	704	3	5	\N	50
6697	64	704	0	1	\N	0
6698	45	705	3	4	\N	60
6699	46	705	3	3	\N	60
6700	47	705	2	3	\N	40
6701	37	705	4	5	\N	80
6702	38	705	0	0	\N	0
6703	39	705	0	0	\N	0
6704	40	705	0	0	\N	0
6705	41	705	2	2	\N	40
6706	65	705	0	1	\N	0
6707	66	705	0	1	\N	0
6708	67	705	2	3	\N	40
6709	68	705	1	1	\N	20
6710	69	706	3	4	\N	60
6711	70	706	0	2	\N	-10
6712	71	706	0	0	\N	0
6713	80	706	3	6	\N	40
6714	81	706	3	3	\N	60
6715	82	706	1	1	\N	20
6716	54	706	1	2	\N	20
6717	55	706	0	0	\N	0
6718	56	706	1	2	\N	20
6719	57	706	2	4	\N	30
6720	8	707	3	4	\N	60
6721	9	707	1	2	\N	20
6722	10	707	1	1	\N	20
6723	11	707	2	3	\N	40
6724	76	707	1	2	\N	20
6725	77	707	1	1	\N	20
6726	78	707	4	4	\N	90
6727	79	707	0	1	\N	0
6728	15	707	1	2	\N	20
6729	16	707	1	1	\N	20
6730	17	707	3	4	\N	60
6731	18	707	0	0	\N	0
6732	89	708	0	1	\N	0
6733	90	708	1	2	\N	20
6734	91	708	0	0	\N	0
6735	25	708	2	2	\N	40
6736	26	708	0	0	\N	0
6737	27	708	0	0	\N	0
6738	51	708	4	4	\N	90
6739	52	708	1	3	\N	10
6740	53	708	1	1	\N	20
6741	28	709	1	2	\N	20
6742	29	709	1	2	\N	20
6743	30	709	1	3	\N	10
6744	31	709	2	2	\N	40
6745	32	709	0	1	\N	0
6746	19	709	3	6	\N	40
6747	20	709	0	0	\N	0
6748	21	709	0	0	\N	0
6749	12	709	0	3	\N	-20
6750	13	709	2	2	\N	40
6751	14	709	1	1	\N	20
6752	100	710	3	3	\N	60
6753	101	710	0	0	\N	0
6754	102	710	4	5	\N	80
6755	103	710	4	4	\N	90
6756	4	710	3	3	\N	60
6757	5	710	2	2	\N	40
6758	6	710	1	2	\N	20
6759	7	710	0	1	\N	0
6760	48	710	4	4	\N	90
6761	49	710	2	2	\N	40
6762	50	710	0	0	\N	0
6763	125	713	3	4	\N	60
6764	126	713	2	2	\N	40
6765	127	713	1	1	\N	20
6766	153	713	3	4	\N	60
6767	154	713	0	2	\N	-10
6768	123	713	4	5	\N	80
6769	124	713	4	6	\N	70
6770	155	714	4	5	\N	80
6771	156	714	4	4	\N	90
6772	157	714	0	0	\N	0
6773	149	714	4	6	\N	70
6774	150	714	1	1	\N	20
6775	151	714	1	1	\N	20
6776	152	714	4	4	\N	90
6777	128	714	1	2	\N	20
6778	129	714	0	0	\N	0
6779	111	715	4	5	\N	80
6780	112	715	1	1	\N	20
6781	113	715	1	1	\N	20
6782	146	715	3	3	\N	60
6783	172	715	3	4	\N	60
6784	173	715	0	0	\N	0
6785	174	715	0	0	\N	0
6786	175	715	1	3	\N	10
6787	185	716	3	5	\N	50
6788	186	716	3	3	\N	60
6789	187	716	0	0	\N	0
6790	114	716	2	5	\N	20
6791	115	716	3	3	\N	60
6792	116	716	1	3	\N	10
6793	169	716	3	6	\N	40
6794	170	716	0	0	\N	0
6795	171	716	3	4	\N	60
6796	119	717	4	5	\N	80
6797	120	717	1	2	\N	20
6798	121	717	4	4	\N	90
6799	122	717	1	1	\N	20
6800	180	717	4	6	\N	70
6801	181	717	1	3	\N	10
6802	105	717	1	1	\N	20
6803	106	717	1	2	\N	20
6804	158	718	4	6	\N	70
6805	159	718	4	5	\N	80
6806	160	718	2	2	\N	40
6807	182	718	3	5	\N	50
6808	183	718	0	0	\N	0
6809	176	718	2	4	\N	30
6810	177	718	3	3	\N	60
6811	178	718	2	2	\N	40
6812	179	718	1	3	\N	10
6813	138	719	4	6	\N	70
6814	139	719	0	2	\N	-10
6815	140	719	1	3	\N	10
6816	141	719	3	5	\N	50
6817	142	719	4	5	\N	80
6818	134	719	1	4	\N	0
6819	135	719	3	4	\N	60
6820	136	719	3	4	\N	60
6821	137	719	2	2	\N	40
6822	130	720	3	3	\N	60
6823	131	720	0	1	\N	0
6824	132	720	1	2	\N	20
6825	133	720	0	0	\N	0
6826	147	720	4	5	\N	80
6827	148	720	1	2	\N	20
6828	164	720	4	5	\N	80
6829	165	720	0	0	\N	0
6830	166	720	2	2	\N	40
6831	143	721	4	4	\N	90
6832	144	721	0	0	\N	0
6833	145	721	0	0	\N	0
6834	104	721	4	4	\N	90
6835	167	721	3	4	\N	60
6836	168	721	1	2	\N	20
6837	184	722	4	4	\N	90
6838	117	722	4	5	\N	80
6839	118	722	2	2	\N	40
6840	161	722	4	4	\N	90
6841	162	722	0	1	\N	0
6842	163	722	2	2	\N	40
6843	107	723	3	4	\N	60
6844	108	723	2	4	\N	30
6845	109	723	2	3	\N	40
6846	110	723	1	3	\N	10
6847	128	723	4	4	\N	90
6848	129	723	0	0	\N	0
6849	155	723	4	5	\N	80
6850	156	723	4	4	\N	90
6851	157	723	2	2	\N	40
6852	182	724	3	3	\N	60
6853	183	724	2	2	\N	40
6854	130	724	3	3	\N	60
6855	131	724	1	1	\N	20
6856	132	724	1	1	\N	20
6857	133	724	2	2	\N	40
6858	105	724	2	4	\N	30
6859	106	724	1	3	\N	10
6860	172	725	3	3	\N	60
6861	173	725	1	2	\N	20
6862	174	725	1	2	\N	20
6863	175	725	2	4	\N	30
6864	147	725	0	0	\N	0
6865	148	725	2	2	\N	40
6866	184	725	4	4	\N	90
6867	176	726	4	5	\N	80
6868	177	726	1	3	\N	10
6869	178	726	1	3	\N	10
6870	179	726	1	1	\N	20
6871	167	726	4	4	\N	90
6872	168	726	1	2	\N	20
6873	185	726	4	5	\N	80
6874	186	726	0	0	\N	0
6875	187	726	1	1	\N	20
6876	161	727	3	3	\N	60
6877	162	727	1	2	\N	20
6878	163	727	0	1	\N	0
6879	134	727	4	5	\N	80
6880	135	727	2	2	\N	40
6881	136	727	1	1	\N	20
6882	137	727	4	4	\N	90
6883	164	727	4	5	\N	80
6884	165	727	1	1	\N	20
6885	166	727	1	2	\N	20
6886	180	728	3	3	\N	60
6887	181	728	3	3	\N	60
6888	143	728	4	5	\N	80
6889	144	728	0	1	\N	0
6890	145	728	0	0	\N	0
6891	107	728	3	5	\N	50
6892	108	728	2	2	\N	40
6893	109	728	1	1	\N	20
6894	110	728	1	1	\N	20
6895	117	729	0	0	\N	0
6896	118	729	0	2	\N	-10
6897	123	729	4	4	\N	90
6898	124	729	4	4	\N	90
6899	138	729	2	5	\N	20
6900	139	729	3	4	\N	60
6901	140	729	0	0	\N	0
6902	169	730	4	6	\N	70
6903	170	730	1	1	\N	20
6904	171	730	1	2	\N	20
6905	146	730	3	5	\N	50
6906	119	730	3	4	\N	60
6907	120	730	4	5	\N	80
6908	121	730	4	4	\N	90
6909	122	730	0	0	\N	0
6910	111	731	2	4	\N	30
6911	112	731	4	5	\N	80
6912	113	731	0	2	\N	-10
6913	141	731	1	1	\N	20
6914	142	731	4	4	\N	90
6915	114	731	3	4	\N	60
6916	115	731	0	2	\N	-10
6917	116	731	2	2	\N	40
6918	158	732	3	5	\N	50
6919	159	732	2	2	\N	40
6920	160	732	2	2	\N	40
6921	149	732	3	4	\N	60
6922	150	732	1	2	\N	20
6923	151	732	0	1	\N	0
6924	152	732	0	1	\N	0
6925	153	732	3	5	\N	50
6926	154	732	0	0	\N	0
6927	104	733	1	4	\N	0
6928	125	733	4	5	\N	80
6929	126	733	1	3	\N	10
6930	127	733	0	2	\N	-10
6931	117	733	2	5	\N	20
6932	118	733	1	2	\N	20
6933	123	734	0	0	\N	0
6934	124	734	1	1	\N	20
6935	180	734	3	3	\N	60
6936	181	734	1	1	\N	20
6937	119	734	4	4	\N	90
6938	120	734	0	0	\N	0
6939	121	734	4	4	\N	90
6940	122	734	1	3	\N	10
6941	130	735	3	4	\N	60
6942	131	735	3	3	\N	60
6943	132	735	4	5	\N	80
6944	133	735	3	3	\N	60
6945	184	735	4	4	\N	90
6946	107	735	3	4	\N	60
6947	108	735	2	2	\N	40
6948	109	735	1	2	\N	20
6949	110	735	4	4	\N	90
6950	169	736	4	5	\N	80
6951	170	736	0	0	\N	0
6952	171	736	0	0	\N	0
6953	182	736	2	3	\N	40
6954	183	736	0	0	\N	0
6955	141	736	4	5	\N	80
6956	142	736	2	3	\N	40
6957	105	737	3	3	\N	60
6958	106	737	2	2	\N	40
6959	146	737	3	3	\N	60
6960	164	737	4	6	\N	70
6961	165	737	0	2	\N	-10
6962	166	737	0	0	\N	0
6963	147	738	3	4	\N	60
6964	148	738	2	2	\N	40
6965	134	738	4	6	\N	70
6966	135	738	2	2	\N	40
6967	136	738	2	2	\N	40
6968	137	738	1	1	\N	20
6969	176	738	3	4	\N	60
6970	177	738	0	0	\N	0
6971	178	738	1	1	\N	20
6972	179	738	0	0	\N	0
6973	138	739	3	5	\N	50
6974	139	739	0	1	\N	0
6975	140	739	1	2	\N	20
6976	167	739	4	4	\N	90
6977	168	739	0	0	\N	0
6978	153	739	4	4	\N	90
6979	154	739	1	1	\N	20
6980	111	740	4	4	\N	90
6981	112	740	2	2	\N	40
6982	113	740	1	2	\N	20
6983	172	740	4	5	\N	80
6984	173	740	3	3	\N	60
6985	174	740	0	0	\N	0
6986	175	740	0	0	\N	0
6987	158	740	4	5	\N	80
6988	159	740	0	1	\N	0
6989	160	740	4	5	\N	80
6990	104	741	3	4	\N	60
6991	185	741	2	4	\N	30
6992	186	741	4	4	\N	90
6993	187	741	1	1	\N	20
6994	125	741	3	5	\N	50
6995	126	741	0	2	\N	-10
6996	127	741	0	0	\N	0
6997	149	742	4	6	\N	70
6998	150	742	1	1	\N	20
6999	151	742	2	3	\N	40
7000	152	742	1	1	\N	20
7001	155	742	0	2	\N	-10
7002	156	742	2	2	\N	40
7003	157	742	1	1	\N	20
7004	143	742	2	4	\N	30
7005	144	742	2	2	\N	40
7006	145	742	2	2	\N	40
7007	114	743	3	5	\N	50
7008	115	743	2	4	\N	30
7009	116	743	1	1	\N	20
7010	161	743	3	4	\N	60
7011	162	743	3	3	\N	60
7012	163	743	0	1	\N	0
7013	128	743	3	5	\N	50
7014	129	743	2	3	\N	40
7015	147	744	4	5	\N	80
7016	148	744	1	1	\N	20
7017	125	744	4	5	\N	80
7018	126	744	3	3	\N	60
7019	127	744	0	1	\N	0
7020	141	744	4	4	\N	90
7021	142	744	0	2	\N	-10
7022	184	745	3	5	\N	50
7023	130	745	4	6	\N	70
7024	131	745	0	1	\N	0
7025	132	745	0	0	\N	0
7026	133	745	1	1	\N	20
7027	172	745	1	3	\N	10
7028	173	745	1	1	\N	20
7029	174	745	0	2	\N	-10
7030	175	745	0	1	\N	0
7031	164	746	1	1	\N	20
7032	165	746	0	0	\N	0
7033	166	746	1	2	\N	20
7034	128	746	4	4	\N	90
7035	129	746	2	2	\N	40
7036	143	746	3	5	\N	50
7037	144	746	0	2	\N	-10
7038	145	746	1	1	\N	20
7039	158	747	3	3	\N	60
7040	159	747	0	0	\N	0
7041	160	747	0	0	\N	0
7042	169	747	3	4	\N	60
7043	170	747	0	1	\N	0
7044	171	747	1	1	\N	20
7045	176	747	3	3	\N	60
7046	177	747	4	6	\N	70
7047	178	747	1	2	\N	20
7048	179	747	3	3	\N	60
7049	155	748	0	2	\N	-10
7050	156	748	2	4	\N	30
7051	157	748	0	0	\N	0
7052	111	748	4	4	\N	90
7053	112	748	1	1	\N	20
7054	113	748	2	2	\N	40
7055	167	748	4	4	\N	90
7056	168	748	0	1	\N	0
7057	119	749	3	3	\N	60
7058	120	749	0	0	\N	0
7059	121	749	2	2	\N	40
7060	122	749	1	3	\N	10
7061	114	749	1	1	\N	20
7062	115	749	0	0	\N	0
7063	116	749	0	0	\N	0
7064	138	749	3	4	\N	60
7065	139	749	1	2	\N	20
7066	140	749	2	2	\N	40
7067	117	750	3	3	\N	60
7068	118	750	0	1	\N	0
7069	185	750	3	4	\N	60
7070	186	750	1	2	\N	20
7071	187	750	2	3	\N	40
7072	105	750	3	6	\N	40
7073	106	750	2	2	\N	40
7074	123	751	3	4	\N	60
7075	124	751	0	1	\N	0
7076	134	751	0	2	\N	-10
7077	135	751	0	0	\N	0
7078	136	751	2	2	\N	40
7079	137	751	0	1	\N	0
7080	182	751	3	4	\N	60
7081	183	751	1	1	\N	20
7082	146	752	4	4	\N	90
7083	161	752	0	1	\N	0
7084	162	752	2	4	\N	30
7085	163	752	2	2	\N	40
7086	107	752	4	5	\N	80
7087	108	752	2	3	\N	40
7088	109	752	3	3	\N	60
7089	110	752	0	0	\N	0
7090	104	753	3	3	\N	60
7091	180	753	3	5	\N	50
7092	181	753	1	1	\N	20
7093	149	753	4	5	\N	80
7094	150	753	2	2	\N	40
7095	151	753	0	0	\N	0
7096	152	753	0	1	\N	0
7097	153	754	3	4	\N	60
7098	154	754	3	4	\N	60
7099	185	754	3	5	\N	50
7100	186	754	0	2	\N	-10
7101	187	754	2	2	\N	40
7102	119	754	1	3	\N	10
7103	120	754	0	1	\N	0
7104	121	754	0	0	\N	0
7105	122	754	0	0	\N	0
7106	149	755	3	5	\N	50
7107	150	755	2	3	\N	40
7108	151	755	0	0	\N	0
7109	152	755	0	1	\N	0
7110	161	755	3	3	\N	60
7111	162	755	1	1	\N	20
7112	163	755	4	5	\N	80
7113	147	755	4	6	\N	70
7114	148	755	1	3	\N	10
7115	176	756	4	5	\N	80
7116	177	756	2	3	\N	40
7117	178	756	4	4	\N	90
7118	179	756	3	3	\N	60
7119	146	756	4	5	\N	80
7120	134	756	4	4	\N	90
7121	135	756	0	0	\N	0
7122	136	756	1	1	\N	20
7123	137	756	2	2	\N	40
7124	117	757	2	3	\N	40
7125	118	757	0	2	\N	-10
7126	104	757	3	3	\N	60
7127	164	757	1	3	\N	10
7128	165	757	1	1	\N	20
7129	166	757	1	2	\N	20
7130	138	758	4	5	\N	80
7131	139	758	2	2	\N	40
7132	140	758	0	0	\N	0
7133	111	758	4	5	\N	80
7134	112	758	1	3	\N	10
7135	113	758	1	1	\N	20
7136	114	758	3	6	\N	40
7137	115	758	0	1	\N	0
7138	116	758	0	0	\N	0
7139	184	759	1	2	\N	20
7140	180	759	0	2	\N	-10
7141	181	759	3	3	\N	60
7142	182	759	4	5	\N	80
7143	183	759	4	6	\N	70
7144	158	760	3	5	\N	50
7145	159	760	0	1	\N	0
7146	160	760	1	1	\N	20
7147	143	760	4	5	\N	80
7148	144	760	3	3	\N	60
7149	145	760	4	4	\N	90
7150	105	760	3	3	\N	60
7151	106	760	4	4	\N	90
7152	167	761	3	4	\N	60
7153	168	761	2	2	\N	40
7154	153	761	0	1	\N	0
7155	154	761	0	0	\N	0
7156	125	761	4	5	\N	80
7157	126	761	3	4	\N	60
7158	127	761	0	0	\N	0
7159	155	762	3	5	\N	50
7160	156	762	2	2	\N	40
7161	157	762	4	5	\N	80
7162	123	762	0	0	\N	0
7163	124	762	2	3	\N	40
7164	128	762	1	4	\N	0
7165	129	762	2	4	\N	30
7166	141	763	2	2	\N	40
7167	142	763	1	2	\N	20
7168	107	763	4	6	\N	70
7169	108	763	2	2	\N	40
7170	109	763	0	0	\N	0
7171	110	763	1	1	\N	20
7172	172	763	1	3	\N	10
7173	173	763	0	1	\N	0
7174	174	763	0	0	\N	0
7175	175	763	2	2	\N	40
7176	169	764	1	2	\N	20
7177	170	764	2	2	\N	40
7178	171	764	2	2	\N	40
7179	130	764	3	6	\N	40
7180	131	764	3	3	\N	60
7181	132	764	3	4	\N	60
7182	133	764	3	4	\N	60
7183	105	764	3	3	\N	60
7184	106	764	0	0	\N	0
7185	182	765	4	6	\N	70
7186	183	765	4	5	\N	80
7187	161	765	0	1	\N	0
7188	162	765	1	1	\N	20
7189	163	765	2	3	\N	40
7190	172	765	4	5	\N	80
7191	173	765	2	2	\N	40
7192	174	765	3	3	\N	60
7193	175	765	2	4	\N	30
7194	180	766	3	5	\N	50
7195	181	766	1	1	\N	20
7196	138	766	4	5	\N	80
7197	139	766	3	3	\N	60
7198	140	766	0	1	\N	0
7199	153	766	1	2	\N	20
7200	154	766	0	2	\N	-10
7201	155	767	3	3	\N	60
7202	156	767	1	1	\N	20
7203	157	767	0	0	\N	0
7204	143	767	3	4	\N	60
7205	144	767	1	1	\N	20
7206	145	767	2	2	\N	40
7207	134	767	1	1	\N	20
7208	135	767	2	2	\N	40
7209	136	767	0	1	\N	0
7210	137	767	2	2	\N	40
7211	164	768	3	5	\N	50
7212	165	768	4	4	\N	90
7213	166	768	4	6	\N	70
7214	119	768	1	2	\N	20
7215	120	768	4	4	\N	90
7216	121	768	0	0	\N	0
7217	122	768	2	3	\N	40
7218	111	768	0	0	\N	0
7219	112	768	0	0	\N	0
7220	113	768	0	0	\N	0
7221	128	769	4	5	\N	80
7222	129	769	1	1	\N	20
7223	176	769	4	4	\N	90
7224	177	769	2	2	\N	40
7225	178	769	2	2	\N	40
7226	179	769	1	1	\N	20
7227	123	769	1	2	\N	20
7228	124	769	1	2	\N	20
7229	104	770	4	4	\N	90
7230	184	770	4	4	\N	90
7231	130	770	3	5	\N	50
7232	131	770	3	4	\N	60
7233	132	770	1	1	\N	20
7234	133	770	1	2	\N	20
7235	167	771	1	1	\N	20
7236	168	771	0	2	\N	-10
7237	141	771	2	3	\N	40
7238	142	771	0	1	\N	0
7239	114	771	2	3	\N	40
7240	115	771	1	1	\N	20
7241	116	771	3	3	\N	60
7242	185	772	3	3	\N	60
7243	186	772	2	2	\N	40
7244	187	772	1	1	\N	20
7245	158	772	4	4	\N	90
7246	159	772	0	0	\N	0
7247	160	772	0	0	\N	0
7248	147	772	3	5	\N	50
7249	148	772	2	2	\N	40
7250	117	773	4	4	\N	90
7251	118	773	1	1	\N	20
7252	107	773	4	5	\N	80
7253	108	773	0	1	\N	0
7254	109	773	0	0	\N	0
7255	110	773	1	3	\N	10
7256	146	773	0	2	\N	-10
7257	149	774	4	4	\N	90
7258	150	774	1	1	\N	20
7259	151	774	0	0	\N	0
7260	152	774	1	1	\N	20
7261	125	774	4	4	\N	90
7262	126	774	0	1	\N	0
7263	127	774	2	2	\N	40
7264	169	774	4	4	\N	90
7265	170	774	1	2	\N	20
7266	171	774	2	3	\N	40
7267	240	776	0	3	\N	-20
7268	241	776	0	0	\N	0
7269	242	776	0	2	\N	-10
7270	243	776	2	2	\N	40
7271	229	776	2	3	\N	40
7272	230	776	0	0	\N	0
7273	231	776	1	1	\N	20
7274	232	776	0	0	\N	0
7275	225	776	3	4	\N	60
7276	226	776	0	0	\N	0
7277	227	776	0	0	\N	0
7278	228	776	1	1	\N	20
7279	250	777	2	3	\N	40
7280	251	777	2	2	\N	40
7281	252	777	0	2	\N	-10
7282	253	777	1	1	\N	20
7283	244	777	4	4	\N	90
7284	245	777	0	1	\N	0
7285	246	777	0	1	\N	0
7286	236	777	3	6	\N	40
7287	237	777	1	1	\N	20
7288	238	777	0	1	\N	0
7289	239	777	3	3	\N	60
7290	201	778	1	3	\N	10
7291	202	778	2	2	\N	40
7292	203	778	0	2	\N	-10
7293	191	778	4	6	\N	70
7294	192	778	2	3	\N	40
7295	193	778	2	2	\N	40
7296	221	778	1	2	\N	20
7297	222	778	2	2	\N	40
7298	223	778	0	0	\N	0
7299	224	778	3	3	\N	60
7300	204	779	3	3	\N	60
7301	205	779	0	1	\N	0
7302	206	779	0	0	\N	0
7303	198	779	4	4	\N	90
7304	199	779	2	2	\N	40
7305	200	779	0	0	\N	0
7306	213	779	4	5	\N	80
7307	214	779	0	0	\N	0
7308	215	779	0	0	\N	0
7309	216	779	1	1	\N	20
7310	247	780	4	6	\N	70
7311	248	780	1	3	\N	10
7312	249	780	0	0	\N	0
7313	210	780	4	4	\N	90
7314	211	780	4	4	\N	90
7315	212	780	1	1	\N	20
7316	254	780	3	6	\N	40
7317	255	780	2	2	\N	40
7318	256	780	0	2	\N	-10
7319	188	781	3	4	\N	60
7320	189	781	1	1	\N	20
7321	190	781	1	1	\N	20
7322	217	781	4	4	\N	90
7323	218	781	1	2	\N	20
7324	219	781	4	4	\N	90
7325	220	781	2	3	\N	40
7326	233	781	4	4	\N	90
7327	234	781	1	2	\N	20
7328	235	781	1	1	\N	20
7329	194	782	4	4	\N	90
7330	195	782	2	2	\N	40
7331	196	782	1	2	\N	20
7332	197	782	2	4	\N	30
7333	207	782	2	3	\N	40
7334	208	782	2	3	\N	40
7335	209	782	0	0	\N	0
7336	204	782	4	6	\N	70
7337	205	782	4	4	\N	90
7338	206	782	1	1	\N	20
7339	201	783	4	4	\N	90
7340	202	783	1	1	\N	20
7341	203	783	2	2	\N	40
7342	244	783	0	1	\N	0
7343	245	783	0	1	\N	0
7344	246	783	4	4	\N	90
7345	240	783	1	3	\N	10
7346	241	783	4	6	\N	70
7347	242	783	0	0	\N	0
7348	243	783	1	1	\N	20
7349	207	784	3	4	\N	60
7350	208	784	1	1	\N	20
7351	209	784	1	1	\N	20
7352	250	784	0	1	\N	0
7353	251	784	4	4	\N	90
7354	252	784	0	1	\N	0
7355	253	784	0	0	\N	0
7356	191	784	4	6	\N	70
7357	192	784	2	2	\N	40
7358	193	784	1	1	\N	20
7359	188	785	0	0	\N	0
7360	189	785	0	1	\N	0
7361	190	785	0	0	\N	0
7362	233	785	4	6	\N	70
7363	234	785	0	1	\N	0
7364	235	785	2	2	\N	40
7365	210	785	1	3	\N	10
7366	211	785	0	1	\N	0
7367	212	785	0	1	\N	0
7368	194	786	3	6	\N	40
7369	195	786	4	4	\N	90
7370	196	786	1	1	\N	20
7371	197	786	1	1	\N	20
7372	213	786	0	1	\N	0
7373	214	786	4	4	\N	90
7374	215	786	1	1	\N	20
7375	216	786	1	1	\N	20
7376	254	786	0	1	\N	0
7377	255	786	2	2	\N	40
7378	256	786	1	3	\N	10
7379	236	787	4	5	\N	80
7380	237	787	0	0	\N	0
7381	238	787	2	4	\N	30
7382	239	787	4	4	\N	90
7383	217	787	4	5	\N	80
7384	218	787	0	0	\N	0
7385	219	787	1	1	\N	20
7386	220	787	0	2	\N	-10
7387	247	787	2	3	\N	40
7388	248	787	3	4	\N	60
7389	249	787	4	6	\N	70
7390	221	788	4	5	\N	80
7391	222	788	3	3	\N	60
7392	223	788	1	1	\N	20
7393	224	788	4	4	\N	90
7394	229	788	3	4	\N	60
7395	230	788	1	2	\N	20
7396	231	788	4	5	\N	80
7397	232	788	0	0	\N	0
7398	198	788	3	4	\N	60
7399	199	788	1	1	\N	20
7400	200	788	3	3	\N	60
7401	225	789	1	1	\N	20
7402	226	789	1	1	\N	20
7403	227	789	0	0	\N	0
7404	228	789	1	1	\N	20
7405	236	789	1	2	\N	20
7406	237	789	1	1	\N	20
7407	238	789	0	1	\N	0
7408	239	789	0	0	\N	0
7409	217	789	4	5	\N	80
7410	218	789	3	4	\N	60
7411	219	789	2	3	\N	40
7412	220	789	1	1	\N	20
7413	244	790	4	4	\N	90
7414	245	790	1	2	\N	20
7415	246	790	1	3	\N	10
7416	221	790	3	4	\N	60
7417	222	790	2	2	\N	40
7418	223	790	0	1	\N	0
7419	224	790	2	3	\N	40
7420	191	790	4	5	\N	80
7421	192	790	2	3	\N	40
7422	193	790	2	3	\N	40
7423	188	791	4	4	\N	90
7424	189	791	4	5	\N	80
7425	190	791	0	0	\N	0
7426	229	791	4	5	\N	80
7427	230	791	4	4	\N	90
7428	231	791	1	2	\N	20
7429	232	791	4	6	\N	70
7430	194	791	4	4	\N	90
7431	195	791	2	2	\N	40
7432	196	791	2	3	\N	40
7433	197	791	3	3	\N	60
7434	250	792	2	3	\N	40
7435	251	792	2	3	\N	40
7436	252	792	0	0	\N	0
7437	253	792	0	1	\N	0
7438	213	792	4	5	\N	80
7439	214	792	3	5	\N	50
7440	215	792	2	3	\N	40
7441	216	792	2	2	\N	40
7442	198	792	3	5	\N	50
7443	199	792	2	3	\N	40
7444	200	792	0	2	\N	-10
7445	247	793	1	2	\N	20
7446	248	793	0	0	\N	0
7447	249	793	4	4	\N	90
7448	210	793	3	3	\N	60
7449	211	793	2	2	\N	40
7450	212	793	0	0	\N	0
7451	233	793	3	3	\N	60
7452	234	793	0	1	\N	0
7453	235	793	1	1	\N	20
7454	254	794	4	4	\N	90
7455	255	794	2	3	\N	40
7456	256	794	4	4	\N	90
7457	240	794	3	6	\N	40
7458	241	794	2	2	\N	40
7459	242	794	1	1	\N	20
7460	243	794	1	2	\N	20
7461	225	794	1	2	\N	20
7462	226	794	1	1	\N	20
7463	227	794	0	0	\N	0
7464	228	794	0	0	\N	0
7465	201	795	4	6	\N	70
7466	202	795	0	1	\N	0
7467	203	795	1	1	\N	20
7468	204	795	1	3	\N	10
7469	205	795	0	0	\N	0
7470	206	795	4	6	\N	70
7471	207	795	4	4	\N	90
7472	208	795	2	2	\N	40
7473	209	795	1	2	\N	20
7474	233	796	4	5	\N	80
7475	234	796	2	3	\N	40
7476	235	796	2	4	\N	30
7477	236	796	4	5	\N	80
7478	237	796	3	4	\N	60
7479	238	796	3	5	\N	50
7480	239	796	0	1	\N	0
7481	194	796	4	4	\N	90
7482	195	796	4	6	\N	70
7483	196	796	3	5	\N	50
7484	197	796	2	4	\N	30
7485	254	797	3	5	\N	50
7486	255	797	2	3	\N	40
7487	256	797	0	0	\N	0
7488	204	797	0	1	\N	0
7489	205	797	0	1	\N	0
7490	206	797	1	2	\N	20
7491	213	797	4	5	\N	80
7492	214	797	1	1	\N	20
7493	215	797	2	3	\N	40
7494	216	797	2	2	\N	40
7495	188	798	3	4	\N	60
7496	189	798	4	6	\N	70
7497	190	798	0	1	\N	0
7498	191	798	3	4	\N	60
7499	192	798	0	0	\N	0
7500	193	798	1	2	\N	20
7501	198	798	4	5	\N	80
7502	199	798	3	3	\N	60
7503	200	798	4	4	\N	90
7504	229	799	1	1	\N	20
7505	230	799	2	2	\N	40
7506	231	799	1	1	\N	20
7507	232	799	3	3	\N	60
7508	217	799	3	6	\N	40
7509	218	799	2	2	\N	40
7510	219	799	2	2	\N	40
7511	220	799	2	3	\N	40
7512	244	799	3	4	\N	60
7513	245	799	3	3	\N	60
7514	246	799	2	3	\N	40
7515	250	800	1	1	\N	20
7516	251	800	1	1	\N	20
7517	252	800	0	0	\N	0
7518	253	800	3	3	\N	60
7519	221	800	3	6	\N	40
7520	222	800	3	3	\N	60
7521	223	800	4	4	\N	90
7522	224	800	1	2	\N	20
7523	201	800	3	5	\N	50
7524	202	800	1	1	\N	20
7525	203	800	4	5	\N	80
7526	240	801	4	4	\N	90
7527	241	801	0	0	\N	0
7528	242	801	0	1	\N	0
7529	243	801	1	2	\N	20
7530	225	801	3	3	\N	60
7531	226	801	0	0	\N	0
7532	227	801	0	2	\N	-10
7533	228	801	0	0	\N	0
7534	207	801	0	0	\N	0
7535	208	801	2	2	\N	40
7536	209	801	0	0	\N	0
7537	210	802	0	1	\N	0
7538	211	802	1	1	\N	20
7539	212	802	2	3	\N	40
7540	247	802	1	3	\N	10
7541	248	802	4	4	\N	90
7542	249	802	2	2	\N	40
7543	247	802	3	6	\N	40
7544	248	802	1	2	\N	20
7545	249	802	2	2	\N	40
7546	213	803	2	4	\N	30
7547	214	803	2	2	\N	40
7548	215	803	4	4	\N	90
7549	216	803	1	1	\N	20
7550	198	803	3	6	\N	40
7551	199	803	0	2	\N	-10
7552	200	803	0	1	\N	0
7553	194	803	4	4	\N	90
7554	195	803	2	2	\N	40
7555	196	803	0	0	\N	0
7556	197	803	0	0	\N	0
7557	191	804	4	6	\N	70
7558	192	804	4	4	\N	90
7559	193	804	1	1	\N	20
7560	254	804	3	3	\N	60
7561	255	804	2	4	\N	30
7562	256	804	0	2	\N	-10
7563	207	804	0	0	\N	0
7564	208	804	0	0	\N	0
7565	209	804	0	0	\N	0
7566	229	805	4	4	\N	90
7567	230	805	0	0	\N	0
7568	231	805	3	3	\N	60
7569	232	805	0	2	\N	-10
7570	210	805	4	4	\N	90
7571	211	805	4	5	\N	80
7572	212	805	2	2	\N	40
7573	217	805	1	1	\N	20
7574	218	805	0	0	\N	0
7575	219	805	1	1	\N	20
7576	220	805	4	5	\N	80
7577	233	806	3	5	\N	50
7578	234	806	0	0	\N	0
7579	235	806	1	1	\N	20
7580	236	806	4	5	\N	80
7581	237	806	1	1	\N	20
7582	238	806	0	1	\N	0
7583	239	806	0	2	\N	-10
7584	225	806	3	4	\N	60
7585	226	806	3	4	\N	60
7586	227	806	4	5	\N	80
7587	228	806	0	0	\N	0
7588	240	807	3	6	\N	40
7589	241	807	2	2	\N	40
7590	242	807	0	0	\N	0
7591	243	807	0	0	\N	0
7592	244	807	0	0	\N	0
7593	245	807	0	0	\N	0
7594	246	807	1	2	\N	20
7595	201	807	3	4	\N	60
7596	202	807	0	0	\N	0
7597	203	807	0	0	\N	0
7598	221	808	1	4	\N	0
7599	222	808	0	1	\N	0
7600	223	808	1	1	\N	20
7601	224	808	0	0	\N	0
7602	250	808	4	4	\N	90
7603	251	808	1	1	\N	20
7604	252	808	3	4	\N	60
7605	253	808	1	2	\N	20
7606	188	808	3	5	\N	50
7607	189	808	3	3	\N	60
7608	190	808	2	2	\N	40
7609	204	809	3	4	\N	60
7610	205	809	0	1	\N	0
7611	206	809	0	1	\N	0
7612	207	809	0	1	\N	0
7613	208	809	2	2	\N	40
7614	209	809	0	0	\N	0
7615	191	809	3	5	\N	50
7616	192	809	2	2	\N	40
7617	193	809	0	1	\N	0
7618	233	810	4	5	\N	80
7619	234	810	2	2	\N	40
7620	235	810	2	2	\N	40
7621	198	810	4	5	\N	80
7622	199	810	0	0	\N	0
7623	200	810	2	3	\N	40
7624	188	810	4	4	\N	90
7625	189	810	0	2	\N	-10
7626	190	810	0	0	\N	0
7627	217	811	4	4	\N	90
7628	218	811	3	4	\N	60
7629	219	811	1	1	\N	20
7630	220	811	1	3	\N	10
7631	210	811	0	1	\N	0
7632	211	811	1	1	\N	20
7633	212	811	0	0	\N	0
7634	225	811	3	4	\N	60
7635	226	811	4	4	\N	90
7636	227	811	0	0	\N	0
7637	228	811	0	0	\N	0
7638	201	812	1	3	\N	10
7639	202	812	1	1	\N	20
7640	203	812	4	4	\N	90
7641	254	812	4	5	\N	80
7642	255	812	1	1	\N	20
7643	256	812	0	1	\N	0
7644	229	812	3	4	\N	60
7645	230	812	3	3	\N	60
7646	231	812	4	4	\N	90
7647	232	812	2	3	\N	40
7648	240	813	3	6	\N	40
7649	241	813	0	1	\N	0
7650	242	813	2	2	\N	40
7651	243	813	1	2	\N	20
7652	213	813	4	4	\N	90
7653	214	813	3	5	\N	50
7654	215	813	1	1	\N	20
7655	216	813	2	2	\N	40
7656	194	813	3	5	\N	50
7657	195	813	2	2	\N	40
7658	196	813	0	2	\N	-10
7659	197	813	2	2	\N	40
7660	221	814	2	2	\N	40
7661	222	814	0	0	\N	0
7662	223	814	1	1	\N	20
7663	224	814	2	2	\N	40
7664	250	814	4	5	\N	80
7665	251	814	0	1	\N	0
7666	252	814	2	3	\N	40
7667	253	814	0	1	\N	0
7668	236	814	0	1	\N	0
7669	237	814	3	3	\N	60
7670	238	814	1	1	\N	20
7671	239	814	2	2	\N	40
7672	244	815	0	3	\N	-20
7673	245	815	1	2	\N	20
7674	246	815	0	1	\N	0
7675	247	815	2	2	\N	40
7676	248	815	1	1	\N	20
7677	249	815	4	4	\N	90
7678	204	815	0	1	\N	0
7679	205	815	1	2	\N	20
7680	206	815	4	4	\N	90
7681	28	816	4	4	\N	90
7682	29	816	2	2	\N	40
7683	30	816	1	3	\N	10
7684	31	816	1	1	\N	20
7685	32	816	1	1	\N	20
7686	86	816	0	1	\N	0
7687	87	816	0	1	\N	0
7688	88	816	2	3	\N	40
7689	80	816	2	4	\N	30
7690	81	816	4	4	\N	90
7691	82	816	2	2	\N	40
7692	45	817	3	3	\N	60
7693	46	817	1	2	\N	20
7694	47	817	1	1	\N	20
7695	89	817	3	5	\N	50
7696	90	817	2	2	\N	40
7697	91	817	3	3	\N	60
7698	48	817	4	5	\N	80
7699	49	817	1	1	\N	20
7700	50	817	0	2	\N	-10
7701	25	818	3	4	\N	60
7702	26	818	0	0	\N	0
7703	27	818	0	1	\N	0
7704	15	818	0	1	\N	0
7705	16	818	0	0	\N	0
7706	17	818	1	1	\N	20
7707	18	818	4	4	\N	90
7708	1	818	4	6	\N	70
7709	2	818	1	1	\N	20
7710	3	818	0	0	\N	0
7711	37	819	0	2	\N	-10
7712	38	819	2	2	\N	40
7713	39	819	4	4	\N	90
7714	40	819	1	1	\N	20
7715	41	819	2	3	\N	40
7716	65	819	3	5	\N	50
7717	66	819	1	1	\N	20
7718	67	819	1	1	\N	20
7719	68	819	2	4	\N	30
7720	54	819	4	5	\N	80
7721	55	819	1	1	\N	20
7722	56	819	2	3	\N	40
7723	57	819	1	2	\N	20
7724	62	820	3	5	\N	50
7725	63	820	0	1	\N	0
7726	64	820	1	1	\N	20
7727	12	820	4	4	\N	90
7728	13	820	2	4	\N	30
7729	14	820	0	0	\N	0
7730	51	820	2	5	\N	20
7731	52	820	1	2	\N	20
7732	53	820	0	0	\N	0
7733	76	821	3	6	\N	40
7734	77	821	0	1	\N	0
7735	78	821	0	0	\N	0
7736	79	821	1	1	\N	20
7737	96	821	3	6	\N	40
7738	97	821	3	5	\N	50
7739	98	821	0	0	\N	0
7740	99	821	1	2	\N	20
7741	33	821	3	4	\N	60
7742	34	821	1	2	\N	20
7743	35	821	0	2	\N	-10
7744	36	821	0	0	\N	0
7745	19	822	2	2	\N	40
7746	20	822	1	1	\N	20
7747	21	822	0	0	\N	0
7748	4	822	3	3	\N	60
7749	5	822	1	1	\N	20
7750	6	822	2	2	\N	40
7751	7	822	1	1	\N	20
7752	58	822	4	5	\N	80
7753	59	822	2	2	\N	40
7754	60	822	0	0	\N	0
7755	61	822	1	1	\N	20
7756	100	823	4	5	\N	80
7757	101	823	1	1	\N	20
7758	102	823	0	0	\N	0
7759	103	823	2	3	\N	40
7760	92	823	2	4	\N	30
7761	93	823	1	1	\N	20
7762	94	823	0	0	\N	0
7763	95	823	1	2	\N	20
7764	42	823	4	6	\N	70
7765	43	823	1	1	\N	20
7766	44	823	0	1	\N	0
7767	72	824	4	5	\N	80
7768	73	824	2	2	\N	40
7769	74	824	4	6	\N	70
7770	75	824	0	0	\N	0
7771	83	824	4	6	\N	70
7772	84	824	2	2	\N	40
7773	85	824	0	0	\N	0
7774	69	824	2	3	\N	40
7775	70	824	0	1	\N	0
7776	71	824	1	2	\N	20
7777	22	825	1	1	\N	20
7778	23	825	0	1	\N	0
7779	24	825	0	0	\N	0
7780	8	825	4	4	\N	90
7781	9	825	0	0	\N	0
7782	10	825	2	2	\N	40
7783	11	825	1	3	\N	10
7784	89	825	3	5	\N	50
7785	90	825	1	1	\N	20
7786	91	825	0	0	\N	0
7787	62	826	0	0	\N	0
7788	63	826	0	1	\N	0
7789	64	826	0	1	\N	0
7790	76	826	1	1	\N	20
7791	77	826	1	1	\N	20
7792	78	826	0	2	\N	-10
7793	79	826	0	1	\N	0
7794	45	826	4	5	\N	80
7795	46	826	0	0	\N	0
7796	47	826	3	5	\N	50
7797	100	827	2	2	\N	40
7798	101	827	1	1	\N	20
7799	102	827	2	3	\N	40
7800	103	827	3	4	\N	60
7801	25	827	3	5	\N	50
7802	26	827	2	2	\N	40
7803	27	827	0	0	\N	0
7804	72	827	3	4	\N	60
7805	73	827	1	2	\N	20
7806	74	827	0	0	\N	0
7807	75	827	2	2	\N	40
7808	51	828	3	3	\N	60
7809	52	828	3	3	\N	60
7810	53	828	3	3	\N	60
7811	58	828	4	5	\N	80
7812	59	828	1	3	\N	10
7813	60	828	4	4	\N	90
7814	61	828	4	4	\N	90
7815	12	828	0	0	\N	0
7816	13	828	1	1	\N	20
7817	14	828	1	2	\N	20
7818	80	829	3	5	\N	50
7819	81	829	2	4	\N	30
7820	82	829	0	1	\N	0
7821	65	829	3	3	\N	60
7822	66	829	2	2	\N	40
7823	67	829	0	0	\N	0
7824	68	829	0	0	\N	0
7825	22	829	3	4	\N	60
7826	23	829	0	0	\N	0
7827	24	829	1	1	\N	20
7828	83	830	3	4	\N	60
7829	84	830	1	3	\N	10
7830	85	830	1	1	\N	20
7831	92	830	4	4	\N	90
7832	93	830	2	2	\N	40
7833	94	830	1	2	\N	20
7834	95	830	0	0	\N	0
7835	48	830	3	4	\N	60
7836	49	830	4	6	\N	70
7837	50	830	1	1	\N	20
7838	42	831	0	2	\N	-10
7839	43	831	0	0	\N	0
7840	44	831	3	3	\N	60
7841	4	831	4	6	\N	70
7842	5	831	3	4	\N	60
7843	6	831	0	0	\N	0
7844	7	831	1	1	\N	20
7845	1	831	0	1	\N	0
7846	2	831	0	0	\N	0
7847	3	831	1	1	\N	20
7848	19	832	4	5	\N	80
7849	20	832	3	3	\N	60
7850	21	832	2	4	\N	30
7851	37	832	4	5	\N	80
7852	38	832	0	0	\N	0
7853	39	832	3	4	\N	60
7854	40	832	0	0	\N	0
7855	41	832	1	1	\N	20
7856	96	832	4	5	\N	80
7857	97	832	1	1	\N	20
7858	98	832	1	1	\N	20
7859	99	832	0	0	\N	0
7860	8	833	0	0	\N	0
7861	9	833	1	1	\N	20
7862	10	833	0	0	\N	0
7863	11	833	1	2	\N	20
7864	69	833	4	4	\N	90
7865	70	833	0	0	\N	0
7866	71	833	2	2	\N	40
7867	33	833	4	4	\N	90
7868	34	833	1	2	\N	20
7869	35	833	2	2	\N	40
7870	36	833	1	3	\N	10
7871	54	834	4	5	\N	80
7872	55	834	1	1	\N	20
7873	56	834	3	3	\N	60
7874	57	834	0	0	\N	0
7875	86	834	4	4	\N	90
7876	87	834	1	2	\N	20
7877	88	834	0	2	\N	-10
7878	28	834	0	0	\N	0
7879	29	834	1	2	\N	20
7880	30	834	4	5	\N	80
7881	31	834	3	3	\N	60
7882	32	834	2	3	\N	40
7883	15	835	0	0	\N	0
7884	16	835	1	3	\N	10
7885	17	835	4	6	\N	70
7886	18	835	0	1	\N	0
7887	19	835	2	4	\N	30
7888	20	835	4	4	\N	90
7889	21	835	1	2	\N	20
7890	8	835	3	6	\N	40
7891	9	835	1	1	\N	20
7892	10	835	2	2	\N	40
7893	11	835	3	4	\N	60
7894	45	836	4	5	\N	80
7895	46	836	1	2	\N	20
7896	47	836	2	4	\N	30
7897	42	836	2	3	\N	40
7898	43	836	3	3	\N	60
7899	44	836	1	2	\N	20
7900	89	836	3	6	\N	40
7901	90	836	1	1	\N	20
7902	91	836	0	0	\N	0
7903	86	837	1	2	\N	20
7904	87	837	2	2	\N	40
7905	88	837	0	0	\N	0
7906	69	837	4	5	\N	80
7907	70	837	0	1	\N	0
7908	71	837	0	2	\N	-10
7909	25	837	4	4	\N	90
7910	26	837	2	2	\N	40
7911	27	837	2	2	\N	40
7912	76	838	2	5	\N	20
7913	77	838	0	0	\N	0
7914	78	838	3	3	\N	60
7915	79	838	2	2	\N	40
7916	72	838	4	5	\N	80
7917	73	838	1	1	\N	20
7918	74	838	1	2	\N	20
7919	75	838	1	1	\N	20
7920	83	838	1	3	\N	10
7921	84	838	0	2	\N	-10
7922	85	838	2	2	\N	40
7923	62	839	3	6	\N	40
7924	63	839	1	3	\N	10
7925	64	839	0	1	\N	0
7926	96	839	1	1	\N	20
7927	97	839	1	1	\N	20
7928	98	839	1	1	\N	20
7929	99	839	0	1	\N	0
7930	54	839	4	4	\N	90
7931	55	839	1	3	\N	10
7932	56	839	1	2	\N	20
7933	57	839	1	1	\N	20
7934	80	840	4	5	\N	80
7935	81	840	2	2	\N	40
7936	82	840	0	0	\N	0
7937	65	840	0	2	\N	-10
7938	66	840	0	0	\N	0
7939	67	840	0	0	\N	0
7940	68	840	1	1	\N	20
7941	1	840	4	5	\N	80
7942	2	840	1	1	\N	20
7943	3	840	0	1	\N	0
7944	22	841	1	2	\N	20
7945	23	841	1	2	\N	20
7946	24	841	1	1	\N	20
7947	100	841	1	3	\N	10
7948	101	841	0	0	\N	0
7949	102	841	0	0	\N	0
7950	103	841	3	3	\N	60
7951	28	841	4	4	\N	90
7952	29	841	4	5	\N	80
7953	30	841	1	1	\N	20
7954	31	841	0	0	\N	0
7955	32	841	0	1	\N	0
7956	15	842	3	3	\N	60
7957	16	842	4	5	\N	80
7958	17	842	1	1	\N	20
7959	18	842	0	0	\N	0
7960	37	842	3	4	\N	60
7961	38	842	0	0	\N	0
7962	39	842	0	0	\N	0
7963	40	842	1	1	\N	20
7964	41	842	0	0	\N	0
7965	51	842	0	0	\N	0
7966	52	842	1	3	\N	10
7967	53	842	1	1	\N	20
7968	48	843	3	3	\N	60
7969	49	843	0	0	\N	0
7970	50	843	2	2	\N	40
7971	92	843	3	4	\N	60
7972	93	843	1	1	\N	20
7973	94	843	4	4	\N	90
7974	95	843	4	4	\N	90
7975	58	843	4	5	\N	80
7976	59	843	1	2	\N	20
7977	60	843	1	1	\N	20
7978	61	843	2	3	\N	40
7979	33	844	4	4	\N	90
7980	34	844	2	2	\N	40
7981	35	844	1	3	\N	10
7982	36	844	4	6	\N	70
7983	12	844	0	2	\N	-10
7984	13	844	1	1	\N	20
7985	14	844	0	0	\N	0
7986	4	844	4	5	\N	80
7987	5	844	1	1	\N	20
7988	6	844	1	3	\N	10
7989	7	844	2	4	\N	30
7990	37	845	1	1	\N	20
7991	38	845	1	1	\N	20
7992	39	845	0	1	\N	0
7993	40	845	3	4	\N	60
7994	41	845	1	1	\N	20
7995	22	845	4	5	\N	80
7996	23	845	1	1	\N	20
7997	24	845	1	2	\N	20
7998	80	845	3	5	\N	50
7999	81	845	4	4	\N	90
8000	82	845	0	1	\N	0
8001	25	846	0	3	\N	-20
8002	26	846	2	2	\N	40
8003	27	846	2	4	\N	30
8004	62	846	4	5	\N	80
8005	63	846	2	2	\N	40
8006	64	846	2	2	\N	40
8007	33	846	3	3	\N	60
8008	34	846	2	4	\N	30
8009	35	846	3	3	\N	60
8010	36	846	3	3	\N	60
8011	28	847	1	2	\N	20
8012	29	847	1	3	\N	10
8013	30	847	2	4	\N	30
8014	31	847	4	4	\N	90
8015	32	847	1	2	\N	20
8016	83	847	2	4	\N	30
8017	84	847	0	1	\N	0
8018	85	847	1	1	\N	20
8019	69	847	4	5	\N	80
8020	70	847	0	0	\N	0
8021	71	847	2	2	\N	40
8022	8	848	4	5	\N	80
8023	9	848	2	2	\N	40
8024	10	848	4	6	\N	70
8025	11	848	1	1	\N	20
8026	4	848	4	4	\N	90
8027	5	848	1	1	\N	20
8028	6	848	2	2	\N	40
8029	7	848	3	4	\N	60
8030	54	848	4	4	\N	90
8031	55	848	2	3	\N	40
8032	56	848	1	1	\N	20
8033	57	848	2	2	\N	40
8034	100	849	2	2	\N	40
8035	101	849	4	5	\N	80
8036	102	849	1	3	\N	10
8037	103	849	1	1	\N	20
8038	89	849	0	0	\N	0
8039	90	849	3	4	\N	60
8040	91	849	0	0	\N	0
8041	96	849	3	4	\N	60
8042	97	849	0	0	\N	0
8043	98	849	3	3	\N	60
8044	99	849	1	2	\N	20
8045	76	850	4	4	\N	90
8046	77	850	0	0	\N	0
8047	78	850	1	3	\N	10
8048	79	850	0	0	\N	0
8049	51	850	2	3	\N	40
8050	52	850	4	6	\N	70
8051	53	850	0	0	\N	0
8052	45	850	3	5	\N	50
8053	46	850	2	3	\N	40
8054	47	850	0	0	\N	0
8055	1	851	1	3	\N	10
8056	2	851	2	2	\N	40
8057	3	851	1	3	\N	10
8058	12	851	4	5	\N	80
8059	13	851	0	0	\N	0
8060	14	851	1	1	\N	20
8061	72	851	1	2	\N	20
8062	73	851	2	3	\N	40
8063	74	851	0	0	\N	0
8064	75	851	1	1	\N	20
8065	15	852	0	2	\N	-10
8066	16	852	1	1	\N	20
8067	17	852	0	0	\N	0
8068	18	852	0	0	\N	0
8069	42	852	1	2	\N	20
8070	43	852	2	2	\N	40
8071	44	852	0	0	\N	0
8072	58	852	1	2	\N	20
8073	59	852	0	0	\N	0
8074	60	852	1	3	\N	10
8075	61	852	0	1	\N	0
8076	65	853	2	3	\N	40
8077	66	853	0	1	\N	0
8078	67	853	1	1	\N	20
8079	68	853	1	2	\N	20
8080	86	853	4	4	\N	90
8081	87	853	4	5	\N	80
8082	88	853	1	2	\N	20
8083	48	853	3	4	\N	60
8084	49	853	0	0	\N	0
8085	50	853	0	0	\N	0
8086	19	854	0	1	\N	0
8087	20	854	2	2	\N	40
8088	21	854	4	4	\N	90
8089	92	854	3	4	\N	60
8090	93	854	0	1	\N	0
8091	94	854	2	2	\N	40
8092	95	854	2	2	\N	40
8093	65	854	4	4	\N	90
8094	66	854	1	1	\N	20
8095	67	854	1	1	\N	20
8096	68	854	1	3	\N	10
8097	25	855	3	6	\N	40
8098	26	855	1	1	\N	20
8099	27	855	2	3	\N	40
8100	58	855	3	4	\N	60
8101	59	855	1	1	\N	20
8102	60	855	2	2	\N	40
8103	61	855	2	2	\N	40
8104	45	855	3	3	\N	60
8105	46	855	0	2	\N	-10
8106	47	855	1	1	\N	20
8107	96	856	3	3	\N	60
8108	97	856	2	3	\N	40
8109	98	856	1	3	\N	10
8110	99	856	0	0	\N	0
8111	33	856	4	5	\N	80
8112	34	856	0	1	\N	0
8113	35	856	1	1	\N	20
8114	36	856	0	0	\N	0
8115	4	856	4	4	\N	90
8116	5	856	2	2	\N	40
8117	6	856	0	0	\N	0
8118	7	856	0	1	\N	0
8119	80	857	1	2	\N	20
8120	81	857	0	1	\N	0
8121	82	857	1	2	\N	20
8122	69	857	4	5	\N	80
8123	70	857	0	0	\N	0
8124	71	857	2	3	\N	40
8125	72	857	4	4	\N	90
8126	73	857	3	3	\N	60
8127	74	857	0	0	\N	0
8128	75	857	1	1	\N	20
8129	28	858	4	6	\N	70
8130	29	858	2	3	\N	40
8131	30	858	0	0	\N	0
8132	31	858	0	0	\N	0
8133	32	858	0	0	\N	0
8134	1	858	4	4	\N	90
8135	2	858	1	1	\N	20
8136	3	858	1	1	\N	20
8137	76	858	4	5	\N	80
8138	77	858	2	2	\N	40
8139	78	858	1	2	\N	20
8140	79	858	4	5	\N	80
8141	54	859	4	5	\N	80
8142	55	859	2	4	\N	30
8143	56	859	0	2	\N	-10
8144	57	859	2	2	\N	40
8145	12	859	4	5	\N	80
8146	13	859	0	1	\N	0
8147	14	859	1	1	\N	20
8148	22	859	4	5	\N	80
8149	23	859	1	2	\N	20
8150	24	859	1	1	\N	20
8151	86	860	3	3	\N	60
8152	87	860	0	2	\N	-10
8153	88	860	2	2	\N	40
8154	51	860	4	4	\N	90
8155	52	860	0	0	\N	0
8156	53	860	0	2	\N	-10
8157	100	860	4	5	\N	80
8158	101	860	0	0	\N	0
8159	102	860	0	0	\N	0
8160	103	860	2	2	\N	40
8161	92	861	3	4	\N	60
8162	93	861	4	4	\N	90
8163	94	861	1	3	\N	10
8164	95	861	3	3	\N	60
8165	15	861	4	6	\N	70
8166	16	861	1	1	\N	20
8167	17	861	0	0	\N	0
8168	18	861	2	4	\N	30
8169	48	861	2	3	\N	40
8170	49	861	2	2	\N	40
8171	50	861	0	2	\N	-10
8172	89	862	3	3	\N	60
8173	90	862	0	0	\N	0
8174	91	862	2	2	\N	40
8175	62	862	3	5	\N	50
8176	63	862	0	2	\N	-10
8177	64	862	4	6	\N	70
8178	19	862	2	3	\N	40
8179	20	862	4	5	\N	80
8180	21	862	2	3	\N	40
8181	37	863	2	3	\N	40
8182	38	863	3	5	\N	50
8183	39	863	0	0	\N	0
8184	40	863	1	1	\N	20
8185	41	863	1	1	\N	20
8186	83	863	3	5	\N	50
8187	84	863	2	4	\N	30
8188	85	863	2	2	\N	40
8189	8	863	4	4	\N	90
8190	9	863	1	1	\N	20
8191	10	863	2	3	\N	40
8192	11	863	0	2	\N	-10
8193	42	864	1	2	\N	20
8194	43	864	0	1	\N	0
8195	44	864	0	1	\N	0
8196	62	864	4	4	\N	90
8197	63	864	1	1	\N	20
8198	64	864	2	2	\N	40
8199	48	864	4	4	\N	90
8200	49	864	0	2	\N	-10
8201	50	864	2	2	\N	40
8202	22	865	4	5	\N	80
8203	23	865	2	4	\N	30
8204	24	865	4	4	\N	90
8205	1	865	3	3	\N	60
8206	2	865	0	0	\N	0
8207	3	865	2	2	\N	40
8208	72	865	3	3	\N	60
8209	73	865	2	2	\N	40
8210	74	865	0	0	\N	0
8211	75	865	3	3	\N	60
8212	100	866	1	1	\N	20
8213	101	866	0	0	\N	0
8214	102	866	3	3	\N	60
8215	103	866	1	3	\N	10
8216	51	866	4	5	\N	80
8217	52	866	2	2	\N	40
8218	53	866	1	2	\N	20
8219	86	866	4	4	\N	90
8220	87	866	1	1	\N	20
8221	88	866	1	1	\N	20
8222	15	867	0	3	\N	-20
8223	16	867	2	2	\N	40
8224	17	867	1	1	\N	20
8225	18	867	1	1	\N	20
8226	83	867	1	3	\N	10
8227	84	867	1	2	\N	20
8228	85	867	1	2	\N	20
8229	96	867	3	5	\N	50
8230	97	867	0	2	\N	-10
8231	98	867	0	0	\N	0
8232	99	867	0	0	\N	0
8233	80	868	0	2	\N	-10
8234	81	868	3	3	\N	60
8235	82	868	4	4	\N	90
8236	76	868	3	5	\N	50
8237	77	868	3	3	\N	60
8238	78	868	0	0	\N	0
8239	79	868	1	2	\N	20
8240	42	868	3	3	\N	60
8241	43	868	2	3	\N	40
8242	44	868	1	1	\N	20
8243	58	869	3	4	\N	60
8244	59	869	0	0	\N	0
8245	60	869	1	1	\N	20
8246	61	869	2	4	\N	30
8247	54	869	3	6	\N	40
8248	55	869	4	4	\N	90
8249	56	869	0	0	\N	0
8250	57	869	1	1	\N	20
8251	92	869	2	5	\N	20
8252	93	869	4	4	\N	90
8253	94	869	2	3	\N	40
8254	95	869	0	0	\N	0
8255	4	870	2	4	\N	30
8256	5	870	2	3	\N	40
8257	6	870	4	6	\N	70
8258	7	870	1	1	\N	20
8259	12	870	0	1	\N	0
8260	13	870	3	4	\N	60
8261	14	870	0	0	\N	0
8262	65	870	4	5	\N	80
8263	66	870	4	5	\N	80
8264	67	870	0	0	\N	0
8265	68	870	0	0	\N	0
8266	33	871	1	2	\N	20
8267	34	871	0	0	\N	0
8268	35	871	1	1	\N	20
8269	36	871	0	0	\N	0
8270	25	871	4	4	\N	90
8271	26	871	0	1	\N	0
8272	27	871	1	3	\N	10
8273	69	871	0	0	\N	0
8274	70	871	1	3	\N	10
8275	71	871	1	1	\N	20
8276	89	872	4	6	\N	70
8277	90	872	0	0	\N	0
8278	91	872	3	3	\N	60
8279	19	872	3	5	\N	50
8280	20	872	1	1	\N	20
8281	21	872	3	3	\N	60
8282	45	872	4	5	\N	80
8283	46	872	0	0	\N	0
8284	47	872	0	0	\N	0
8285	37	873	3	5	\N	50
8286	38	873	2	2	\N	40
8287	39	873	2	3	\N	40
8288	40	873	2	3	\N	40
8289	41	873	0	0	\N	0
8290	8	873	0	1	\N	0
8291	9	873	1	1	\N	20
8292	10	873	2	2	\N	40
8293	11	873	0	0	\N	0
8294	28	873	1	2	\N	20
8295	29	873	0	0	\N	0
8296	30	873	3	3	\N	60
8297	31	873	4	5	\N	80
8298	32	873	1	1	\N	20
8299	125	876	3	4	\N	60
8300	126	876	2	2	\N	40
8301	127	876	4	6	\N	70
8302	138	876	3	4	\N	60
8303	139	876	4	4	\N	90
8304	140	876	1	1	\N	20
8305	155	876	1	1	\N	20
8306	156	876	2	2	\N	40
8307	157	876	0	0	\N	0
8308	119	877	4	4	\N	90
8309	120	877	1	3	\N	10
8310	121	877	0	0	\N	0
8311	122	877	0	0	\N	0
8312	130	877	0	2	\N	-10
8313	131	877	1	2	\N	20
8314	132	877	2	3	\N	40
8315	133	877	0	0	\N	0
8316	176	877	3	4	\N	60
8317	177	877	1	1	\N	20
8318	178	877	0	1	\N	0
8319	179	877	2	3	\N	40
8320	146	878	0	1	\N	0
8321	182	878	3	3	\N	60
8322	183	878	2	2	\N	40
8323	147	878	4	5	\N	80
8324	148	878	2	2	\N	40
8325	111	879	1	4	\N	0
8326	112	879	2	2	\N	40
8327	113	879	0	0	\N	0
8328	143	879	4	5	\N	80
8329	144	879	4	5	\N	80
8330	145	879	3	4	\N	60
8331	158	879	3	3	\N	60
8332	159	879	2	2	\N	40
8333	160	879	2	4	\N	30
8334	149	880	4	5	\N	80
8335	150	880	1	1	\N	20
8336	151	880	2	3	\N	40
8337	152	880	3	3	\N	60
8338	114	880	3	3	\N	60
8339	115	880	2	2	\N	40
8340	116	880	1	1	\N	20
8341	128	880	4	4	\N	90
8342	129	880	0	0	\N	0
8343	180	881	2	3	\N	40
8344	181	881	1	2	\N	20
8345	123	881	3	5	\N	50
8346	124	881	0	1	\N	0
8347	184	881	4	4	\N	90
8348	104	882	4	5	\N	80
8349	185	882	3	3	\N	60
8350	186	882	0	0	\N	0
8351	187	882	2	3	\N	40
8352	117	882	4	5	\N	80
8353	118	882	2	3	\N	40
8354	169	883	4	4	\N	90
8355	170	883	0	1	\N	0
8356	171	883	0	0	\N	0
8357	172	883	3	3	\N	60
8358	173	883	2	2	\N	40
8359	174	883	4	4	\N	90
8360	175	883	2	2	\N	40
8361	134	883	4	4	\N	90
8362	135	883	0	0	\N	0
8363	136	883	0	0	\N	0
8364	137	883	2	4	\N	30
8365	161	884	2	3	\N	40
8366	162	884	0	2	\N	-10
8367	163	884	0	0	\N	0
8368	107	884	3	3	\N	60
8369	108	884	0	1	\N	0
8370	109	884	4	4	\N	90
8371	110	884	1	1	\N	20
8372	105	884	2	2	\N	40
8373	106	884	0	0	\N	0
8374	167	885	4	5	\N	80
8375	168	885	2	2	\N	40
8376	164	885	0	1	\N	0
8377	165	885	0	1	\N	0
8378	166	885	0	1	\N	0
8379	141	885	0	3	\N	-20
8380	142	885	0	0	\N	0
8381	153	886	4	4	\N	90
8382	154	886	0	0	\N	0
8383	180	886	0	0	\N	0
8384	181	886	3	3	\N	60
8385	149	886	3	5	\N	50
8386	150	886	1	1	\N	20
8387	151	886	2	2	\N	40
8388	152	886	0	1	\N	0
8389	158	887	1	3	\N	10
8390	159	887	1	2	\N	20
8391	160	887	1	2	\N	20
8392	107	887	2	3	\N	40
8393	108	887	1	1	\N	20
8394	109	887	1	1	\N	20
8395	110	887	0	0	\N	0
8396	128	887	1	4	\N	0
8397	129	887	3	4	\N	60
8398	114	888	4	4	\N	90
8399	115	888	2	3	\N	40
8400	116	888	3	3	\N	60
8401	172	888	0	1	\N	0
8402	173	888	0	0	\N	0
8403	174	888	0	2	\N	-10
8404	175	888	0	1	\N	0
8405	141	888	3	4	\N	60
8406	142	888	1	3	\N	10
8407	184	889	3	6	\N	40
8408	130	889	0	1	\N	0
8409	131	889	0	0	\N	0
8410	132	889	2	2	\N	40
8411	133	889	0	1	\N	0
8412	138	889	4	4	\N	90
8413	139	889	0	0	\N	0
8414	140	889	1	2	\N	20
8415	111	890	4	5	\N	80
8416	112	890	1	1	\N	20
8417	113	890	0	2	\N	-10
8418	125	890	4	4	\N	90
8419	126	890	1	2	\N	20
8420	127	890	2	2	\N	40
8421	117	890	1	2	\N	20
8422	118	890	1	2	\N	20
8423	169	891	4	4	\N	90
8424	170	891	0	0	\N	0
8425	171	891	0	0	\N	0
8426	119	891	2	3	\N	40
8427	120	891	2	3	\N	40
8428	121	891	4	4	\N	90
8429	122	891	0	0	\N	0
8430	146	891	1	2	\N	20
8431	182	892	4	6	\N	70
8432	183	892	0	1	\N	0
8433	143	892	1	3	\N	10
8434	144	892	2	4	\N	30
8435	145	892	2	2	\N	40
8436	123	892	2	3	\N	40
8437	124	892	1	1	\N	20
8438	134	893	4	4	\N	90
8439	135	893	0	1	\N	0
8440	136	893	1	1	\N	20
8441	137	893	2	3	\N	40
8442	164	893	4	5	\N	80
8443	165	893	4	4	\N	90
8444	166	893	1	1	\N	20
8445	167	893	4	6	\N	70
8446	168	893	0	1	\N	0
8447	153	894	3	6	\N	40
8448	154	894	0	0	\N	0
8449	155	894	3	4	\N	60
8450	156	894	1	2	\N	20
8451	157	894	3	4	\N	60
8452	105	894	3	3	\N	60
8453	106	894	1	2	\N	20
8454	147	895	3	4	\N	60
8455	148	895	1	1	\N	20
8456	161	895	4	5	\N	80
8457	162	895	2	2	\N	40
8458	163	895	3	3	\N	60
8459	104	895	4	5	\N	80
8460	185	896	4	6	\N	70
8461	186	896	4	4	\N	90
8462	187	896	1	2	\N	20
8463	176	896	4	5	\N	80
8464	177	896	1	2	\N	20
8465	178	896	1	1	\N	20
8466	179	896	4	5	\N	80
8467	167	896	4	4	\N	90
8468	168	896	2	2	\N	40
8469	134	897	2	3	\N	40
8470	135	897	1	1	\N	20
8471	136	897	3	3	\N	60
8472	137	897	2	2	\N	40
8473	111	897	3	3	\N	60
8474	112	897	2	3	\N	40
8475	113	897	0	1	\N	0
8476	153	897	4	4	\N	90
8477	154	897	0	0	\N	0
8478	138	898	4	4	\N	90
8479	139	898	1	1	\N	20
8480	140	898	4	5	\N	80
8481	185	898	4	5	\N	80
8482	186	898	2	2	\N	40
8483	187	898	2	2	\N	40
8484	176	898	3	6	\N	40
8485	177	898	2	3	\N	40
8486	178	898	0	1	\N	0
8487	179	898	0	0	\N	0
8488	143	899	3	5	\N	50
8489	144	899	1	1	\N	20
8490	145	899	3	4	\N	60
8491	161	899	1	1	\N	20
8492	162	899	2	3	\N	40
8493	163	899	0	1	\N	0
8494	128	899	3	4	\N	60
8495	129	899	2	3	\N	40
8496	164	900	0	3	\N	-20
8497	165	900	0	0	\N	0
8498	166	900	0	2	\N	-10
8499	182	900	4	5	\N	80
8500	183	900	3	3	\N	60
8501	147	900	4	4	\N	90
8502	148	900	1	2	\N	20
8503	184	901	2	2	\N	40
8504	117	901	4	6	\N	70
8505	118	901	1	1	\N	20
8506	155	901	3	3	\N	60
8507	156	901	0	0	\N	0
8508	157	901	0	0	\N	0
8509	125	902	0	2	\N	-10
8510	126	902	0	0	\N	0
8511	127	902	0	2	\N	-10
8512	172	902	4	5	\N	80
8513	173	902	2	2	\N	40
8514	174	902	4	5	\N	80
8515	175	902	1	2	\N	20
8516	141	902	4	4	\N	90
8517	142	902	3	4	\N	60
8518	104	903	1	2	\N	20
8519	107	903	4	6	\N	70
8520	108	903	2	3	\N	40
8521	109	903	2	3	\N	40
8522	110	903	2	2	\N	40
8523	180	903	4	5	\N	80
8524	181	903	0	0	\N	0
8525	158	904	4	5	\N	80
8526	159	904	3	3	\N	60
8527	160	904	0	0	\N	0
8528	130	904	4	4	\N	90
8529	131	904	2	3	\N	40
8530	132	904	3	5	\N	50
8531	133	904	4	4	\N	90
8532	119	904	4	5	\N	80
8533	120	904	1	1	\N	20
8534	121	904	0	1	\N	0
8535	122	904	1	3	\N	10
8536	123	905	1	2	\N	20
8537	124	905	1	1	\N	20
8538	169	905	3	6	\N	40
8539	170	905	1	1	\N	20
8540	171	905	2	3	\N	40
8541	105	905	4	4	\N	90
8542	106	905	1	1	\N	20
8543	146	906	4	4	\N	90
8544	149	906	4	5	\N	80
8545	150	906	0	0	\N	0
8546	151	906	4	4	\N	90
8547	152	906	0	1	\N	0
8548	114	906	4	4	\N	90
8549	115	906	3	3	\N	60
8550	116	906	3	3	\N	60
8551	161	907	2	4	\N	30
8552	162	907	4	4	\N	90
8553	163	907	1	2	\N	20
8554	176	907	4	5	\N	80
8555	177	907	1	1	\N	20
8556	178	907	1	1	\N	20
8557	179	907	0	0	\N	0
8558	169	907	3	4	\N	60
8559	170	907	3	5	\N	50
8560	171	907	2	3	\N	40
8561	123	908	0	1	\N	0
8562	124	908	4	6	\N	70
8563	130	908	4	4	\N	90
8564	131	908	2	2	\N	40
8565	132	908	3	4	\N	60
8566	133	908	1	1	\N	20
8567	149	908	4	4	\N	90
8568	150	908	1	1	\N	20
8569	151	908	1	1	\N	20
8570	152	908	1	1	\N	20
8571	117	909	3	5	\N	50
8572	118	909	3	5	\N	50
8573	172	909	0	1	\N	0
8574	173	909	2	2	\N	40
8575	174	909	0	0	\N	0
8576	175	909	3	4	\N	60
8577	104	909	4	6	\N	70
8578	114	910	4	4	\N	90
8579	115	910	2	3	\N	40
8580	116	910	0	0	\N	0
8581	185	910	0	0	\N	0
8582	186	910	2	3	\N	40
8583	187	910	0	1	\N	0
8584	147	910	3	6	\N	40
8585	148	910	0	0	\N	0
8586	105	911	4	5	\N	80
8587	106	911	1	3	\N	10
8588	143	911	4	4	\N	90
8589	144	911	2	3	\N	40
8590	145	911	3	5	\N	50
8591	164	911	2	3	\N	40
8592	165	911	0	0	\N	0
8593	166	911	1	3	\N	10
8594	128	912	4	5	\N	80
8595	129	912	3	3	\N	60
8596	141	912	1	2	\N	20
8597	142	912	0	1	\N	0
8598	167	912	3	4	\N	60
8599	168	912	0	0	\N	0
8600	180	913	0	2	\N	-10
8601	181	913	1	1	\N	20
8602	125	913	1	2	\N	20
8603	126	913	4	4	\N	90
8604	127	913	1	1	\N	20
8605	107	913	3	5	\N	50
8606	108	913	1	1	\N	20
8607	109	913	0	0	\N	0
8608	110	913	1	1	\N	20
8609	155	914	3	6	\N	40
8610	156	914	4	5	\N	80
8611	157	914	2	3	\N	40
8612	146	914	2	3	\N	40
8613	111	914	4	4	\N	90
8614	112	914	0	0	\N	0
8615	113	914	0	0	\N	0
8616	119	915	0	2	\N	-10
8617	120	915	3	3	\N	60
8618	121	915	1	1	\N	20
8619	122	915	0	0	\N	0
8620	182	915	4	5	\N	80
8621	183	915	1	1	\N	20
8622	184	915	4	4	\N	90
8623	134	916	3	5	\N	50
8624	135	916	0	0	\N	0
8625	136	916	1	3	\N	10
8626	137	916	2	2	\N	40
8627	138	916	4	6	\N	70
8628	139	916	2	2	\N	40
8629	140	916	2	2	\N	40
8630	158	916	3	5	\N	50
8631	159	916	2	2	\N	40
8632	160	916	4	4	\N	90
8633	153	917	4	4	\N	90
8634	154	917	0	2	\N	-10
8635	117	917	1	1	\N	20
8636	118	917	4	6	\N	70
8637	147	917	4	5	\N	80
8638	148	917	1	1	\N	20
8639	153	918	3	5	\N	50
8640	154	918	0	0	\N	0
8641	184	918	3	3	\N	60
8642	185	918	4	5	\N	80
8643	186	918	0	2	\N	-10
8644	187	918	0	0	\N	0
8645	146	919	2	2	\N	40
8646	130	919	4	4	\N	90
8647	131	919	0	1	\N	0
8648	132	919	2	2	\N	40
8649	133	919	2	2	\N	40
8650	128	919	4	5	\N	80
8651	129	919	1	3	\N	10
8652	125	920	0	2	\N	-10
8653	126	920	0	0	\N	0
8654	127	920	1	3	\N	10
8655	119	920	4	6	\N	70
8656	120	920	4	4	\N	90
8657	121	920	3	4	\N	60
8658	122	920	2	4	\N	30
8659	180	920	4	5	\N	80
8660	181	920	0	0	\N	0
8661	149	921	4	5	\N	80
8662	150	921	2	2	\N	40
8663	151	921	1	1	\N	20
8664	152	921	0	0	\N	0
8665	141	921	4	5	\N	80
8666	142	921	1	1	\N	20
8667	143	921	4	6	\N	70
8668	144	921	3	3	\N	60
8669	145	921	1	1	\N	20
8670	176	922	4	5	\N	80
8671	177	922	1	2	\N	20
8672	178	922	3	3	\N	60
8673	179	922	0	0	\N	0
8674	138	922	1	3	\N	10
8675	139	922	1	1	\N	20
8676	140	922	1	1	\N	20
8677	182	922	2	4	\N	30
8678	183	922	3	5	\N	50
8679	123	923	4	6	\N	70
8680	124	923	1	1	\N	20
8681	111	923	3	6	\N	40
8682	112	923	0	0	\N	0
8683	113	923	1	1	\N	20
8684	164	923	4	5	\N	80
8685	165	923	0	0	\N	0
8686	166	923	1	1	\N	20
8687	155	924	1	2	\N	20
8688	156	924	1	2	\N	20
8689	157	924	1	1	\N	20
8690	105	924	0	0	\N	0
8691	106	924	0	0	\N	0
8692	161	924	0	1	\N	0
8693	162	924	1	2	\N	20
8694	163	924	0	0	\N	0
8695	169	925	4	4	\N	90
8696	170	925	2	3	\N	40
8697	171	925	0	0	\N	0
8698	167	925	2	3	\N	40
8699	168	925	2	2	\N	40
8700	134	925	0	0	\N	0
8701	135	925	1	2	\N	20
8702	136	925	2	3	\N	40
8703	137	925	2	2	\N	40
8704	107	926	4	6	\N	70
8705	108	926	0	0	\N	0
8706	109	926	1	2	\N	20
8707	110	926	3	5	\N	50
8708	158	926	4	6	\N	70
8709	159	926	1	1	\N	20
8710	160	926	0	0	\N	0
8711	114	926	1	1	\N	20
8712	115	926	1	1	\N	20
8713	116	926	0	0	\N	0
8714	172	927	0	1	\N	0
8715	173	927	1	1	\N	20
8716	174	927	2	2	\N	40
8717	175	927	2	3	\N	40
8718	104	927	4	4	\N	90
8719	158	927	3	5	\N	50
8720	159	927	0	0	\N	0
8721	160	927	1	1	\N	20
8722	104	928	1	1	\N	20
8723	134	928	3	3	\N	60
8724	135	928	0	2	\N	-10
8725	136	928	1	1	\N	20
8726	137	928	0	0	\N	0
8727	117	928	2	3	\N	40
8728	118	928	2	2	\N	40
8729	119	929	4	4	\N	90
8730	120	929	3	3	\N	60
8731	121	929	1	1	\N	20
8732	122	929	1	1	\N	20
8733	107	929	4	5	\N	80
8734	108	929	1	2	\N	20
8735	109	929	2	2	\N	40
8736	110	929	0	0	\N	0
8737	161	929	4	6	\N	70
8738	162	929	2	4	\N	30
8739	163	929	0	0	\N	0
8740	167	930	0	1	\N	0
8741	168	930	0	1	\N	0
8742	143	930	4	4	\N	90
8743	144	930	0	0	\N	0
8744	145	930	1	1	\N	20
8745	138	930	0	2	\N	-10
8746	139	930	0	1	\N	0
8747	140	930	3	3	\N	60
8748	169	931	4	4	\N	90
8749	170	931	0	1	\N	0
8750	171	931	0	0	\N	0
8751	153	931	4	5	\N	80
8752	154	931	1	2	\N	20
8753	111	931	2	5	\N	20
8754	112	931	2	3	\N	40
8755	113	931	0	2	\N	-10
8756	114	932	3	3	\N	60
8757	115	932	0	0	\N	0
8758	116	932	0	1	\N	0
8759	149	932	1	2	\N	20
8760	150	932	0	1	\N	0
8761	151	932	3	5	\N	50
8762	152	932	1	1	\N	20
8763	128	932	0	1	\N	0
8764	129	932	2	2	\N	40
8765	125	933	3	6	\N	40
8766	126	933	2	2	\N	40
8767	127	933	3	3	\N	60
8768	105	933	4	4	\N	90
8769	106	933	0	0	\N	0
8770	172	933	2	3	\N	40
8771	173	933	4	5	\N	80
8772	174	933	1	2	\N	20
8773	175	933	0	0	\N	0
8774	155	934	4	4	\N	90
8775	156	934	0	0	\N	0
8776	157	934	2	2	\N	40
8777	180	934	3	3	\N	60
8778	181	934	1	2	\N	20
8779	185	934	2	3	\N	40
8780	186	934	2	2	\N	40
8781	187	934	1	1	\N	20
8782	141	935	4	5	\N	80
8783	142	935	0	1	\N	0
8784	182	935	2	2	\N	40
8785	183	935	1	1	\N	20
8786	123	935	3	3	\N	60
8787	124	935	0	1	\N	0
8788	130	936	3	4	\N	60
8789	131	936	1	3	\N	10
8790	132	936	0	2	\N	-10
8791	133	936	0	0	\N	0
8792	176	936	4	5	\N	80
8793	177	936	1	1	\N	20
8794	178	936	3	3	\N	60
8795	179	936	4	5	\N	80
8796	184	936	2	3	\N	40
8797	164	937	2	3	\N	40
8798	165	937	2	3	\N	40
8799	166	937	2	2	\N	40
8800	147	937	1	3	\N	10
8801	148	937	2	4	\N	30
8802	146	937	3	5	\N	50
8803	207	939	2	4	\N	30
8804	208	939	2	2	\N	40
8805	209	939	1	2	\N	20
8806	240	939	4	6	\N	70
8807	241	939	1	1	\N	20
8808	242	939	0	0	\N	0
8809	243	939	1	1	\N	20
8810	254	939	1	3	\N	10
8811	255	939	0	0	\N	0
8812	256	939	4	4	\N	90
8813	236	940	3	4	\N	60
8814	237	940	0	0	\N	0
8815	238	940	2	2	\N	40
8816	239	940	2	3	\N	40
8817	225	940	4	6	\N	70
8818	226	940	4	4	\N	90
8819	227	940	1	1	\N	20
8820	228	940	0	0	\N	0
8821	194	940	4	4	\N	90
8822	195	940	4	6	\N	70
8823	196	940	2	2	\N	40
8824	197	940	1	2	\N	20
8825	247	941	1	3	\N	10
8826	248	941	1	3	\N	10
8827	249	941	0	2	\N	-10
8828	198	941	4	4	\N	90
8829	199	941	0	0	\N	0
8830	200	941	0	0	\N	0
8831	217	941	3	4	\N	60
8832	218	941	3	3	\N	60
8833	219	941	2	2	\N	40
8834	220	941	1	2	\N	20
8835	191	942	3	6	\N	40
8836	192	942	0	0	\N	0
8837	193	942	1	2	\N	20
8838	210	942	3	4	\N	60
8839	211	942	1	2	\N	20
8840	212	942	2	4	\N	30
8841	221	942	3	4	\N	60
8842	222	942	1	2	\N	20
8843	223	942	3	3	\N	60
8844	224	942	1	1	\N	20
8845	250	943	3	4	\N	60
8846	251	943	1	2	\N	20
8847	252	943	2	3	\N	40
8848	253	943	1	2	\N	20
8849	201	943	3	4	\N	60
8850	202	943	2	2	\N	40
8851	203	943	1	1	\N	20
8852	204	943	4	5	\N	80
8853	205	943	0	1	\N	0
8854	206	943	2	3	\N	40
8855	213	944	3	3	\N	60
8856	214	944	3	3	\N	60
8857	215	944	3	4	\N	60
8858	216	944	0	0	\N	0
8859	229	944	4	5	\N	80
8860	230	944	1	2	\N	20
8861	231	944	2	4	\N	30
8862	232	944	1	1	\N	20
8863	244	944	0	0	\N	0
8864	245	944	2	2	\N	40
8865	246	944	3	3	\N	60
8866	188	945	3	4	\N	60
8867	189	945	2	2	\N	40
8868	190	945	0	1	\N	0
8869	233	945	3	6	\N	40
8870	234	945	0	1	\N	0
8871	235	945	4	4	\N	90
8872	191	945	2	4	\N	30
8873	192	945	1	1	\N	20
8874	193	945	2	3	\N	40
8875	198	946	3	4	\N	60
8876	199	946	3	3	\N	60
8877	200	946	2	4	\N	30
8878	221	946	4	5	\N	80
8879	222	946	2	4	\N	30
8880	223	946	1	1	\N	20
8881	224	946	0	1	\N	0
8882	250	946	4	4	\N	90
8883	251	946	1	1	\N	20
8884	252	946	3	3	\N	60
8885	253	946	0	1	\N	0
8886	240	947	4	5	\N	80
8887	241	947	0	0	\N	0
8888	242	947	0	0	\N	0
8889	243	947	1	1	\N	20
8890	236	947	1	1	\N	20
8891	237	947	1	1	\N	20
8892	238	947	1	1	\N	20
8893	239	947	4	4	\N	90
8894	217	947	4	4	\N	90
8895	218	947	0	2	\N	-10
8896	219	947	0	2	\N	-10
8897	220	947	2	3	\N	40
8898	188	948	0	0	\N	0
8899	189	948	1	1	\N	20
8900	190	948	0	1	\N	0
8901	229	948	3	4	\N	60
8902	230	948	2	2	\N	40
8903	231	948	0	0	\N	0
8904	232	948	4	4	\N	90
8905	207	948	2	2	\N	40
8906	208	948	4	4	\N	90
8907	209	948	0	0	\N	0
8908	210	949	2	3	\N	40
8909	211	949	0	1	\N	0
8910	212	949	1	1	\N	20
8911	194	949	2	4	\N	30
8912	195	949	1	2	\N	20
8913	196	949	2	2	\N	40
8914	197	949	1	1	\N	20
8915	201	949	4	6	\N	70
8916	202	949	2	3	\N	40
8917	203	949	0	1	\N	0
8918	204	950	0	2	\N	-10
8919	205	950	1	3	\N	10
8920	206	950	4	6	\N	70
8921	225	950	3	4	\N	60
8922	226	950	0	0	\N	0
8923	227	950	4	5	\N	80
8924	228	950	4	4	\N	90
8925	247	950	2	3	\N	40
8926	248	950	0	0	\N	0
8927	249	950	1	1	\N	20
8928	254	951	4	4	\N	90
8929	255	951	1	1	\N	20
8930	256	951	4	5	\N	80
8931	244	951	4	4	\N	90
8932	245	951	0	0	\N	0
8933	246	951	3	3	\N	60
8934	213	951	4	6	\N	70
8935	214	951	1	1	\N	20
8936	215	951	0	2	\N	-10
8937	216	951	0	0	\N	0
8938	233	952	3	6	\N	40
8939	234	952	0	0	\N	0
8940	235	952	0	0	\N	0
8941	191	952	0	0	\N	0
8942	192	952	1	1	\N	20
8943	193	952	4	5	\N	80
8944	207	952	4	4	\N	90
8945	208	952	1	1	\N	20
8946	209	952	1	2	\N	20
8947	213	953	3	6	\N	40
8948	214	953	1	3	\N	10
8949	215	953	0	0	\N	0
8950	216	953	3	3	\N	60
8951	240	953	4	5	\N	80
8952	241	953	2	4	\N	30
8953	242	953	2	4	\N	30
8954	243	953	0	1	\N	0
8955	250	953	4	5	\N	80
8956	251	953	4	4	\N	90
8957	252	953	0	1	\N	0
8958	253	953	1	2	\N	20
8959	244	954	4	6	\N	70
8960	245	954	0	0	\N	0
8961	246	954	3	3	\N	60
8962	247	954	4	5	\N	80
8963	248	954	3	4	\N	60
8964	249	954	3	3	\N	60
8965	217	954	4	5	\N	80
8966	218	954	2	3	\N	40
8967	219	954	1	2	\N	20
8968	220	954	0	0	\N	0
8969	236	955	3	4	\N	60
8970	237	955	0	0	\N	0
8971	238	955	3	5	\N	50
8972	239	955	0	2	\N	-10
8973	198	955	4	5	\N	80
8974	199	955	2	3	\N	40
8975	200	955	0	0	\N	0
8976	204	955	3	4	\N	60
8977	205	955	0	2	\N	-10
8978	206	955	4	6	\N	70
8979	201	956	4	4	\N	90
8980	202	956	4	6	\N	70
8981	203	956	2	2	\N	40
8982	188	956	4	4	\N	90
8983	189	956	0	0	\N	0
8984	190	956	1	3	\N	10
8985	210	956	4	5	\N	80
8986	211	956	2	2	\N	40
8987	212	956	0	2	\N	-10
8988	194	957	1	1	\N	20
8989	195	957	1	2	\N	20
8990	196	957	1	3	\N	10
8991	197	957	1	1	\N	20
8992	233	957	4	5	\N	80
8993	234	957	2	2	\N	40
8994	235	957	0	0	\N	0
8995	221	957	1	1	\N	20
8996	222	957	3	3	\N	60
8997	223	957	0	0	\N	0
8998	224	957	2	3	\N	40
8999	225	958	3	4	\N	60
9000	226	958	0	0	\N	0
9001	227	958	3	4	\N	60
9002	228	958	2	2	\N	40
9003	254	958	4	5	\N	80
9004	255	958	2	2	\N	40
9005	256	958	0	2	\N	-10
9006	229	958	1	3	\N	10
9007	230	958	0	1	\N	0
9008	231	958	1	3	\N	10
9009	232	958	1	1	\N	20
9010	201	959	2	4	\N	30
9011	202	959	1	2	\N	20
9012	203	959	0	2	\N	-10
9013	229	959	3	3	\N	60
9014	230	959	1	1	\N	20
9015	231	959	0	0	\N	0
9016	232	959	1	1	\N	20
9017	236	959	3	4	\N	60
9018	237	959	3	4	\N	60
9019	238	959	1	2	\N	20
9020	239	959	2	4	\N	30
9021	254	960	2	3	\N	40
9022	255	960	0	1	\N	0
9023	256	960	3	4	\N	60
9024	221	960	1	2	\N	20
9025	222	960	1	3	\N	10
9026	223	960	2	2	\N	40
9027	224	960	0	0	\N	0
9028	250	960	3	4	\N	60
9029	251	960	2	2	\N	40
9030	252	960	2	3	\N	40
9031	253	960	3	3	\N	60
9032	244	961	4	6	\N	70
9033	245	961	1	1	\N	20
9034	246	961	3	3	\N	60
9035	240	961	3	3	\N	60
9036	241	961	1	1	\N	20
9037	242	961	1	3	\N	10
9038	243	961	1	2	\N	20
9039	247	961	1	2	\N	20
9040	248	961	0	2	\N	-10
9041	249	961	0	0	\N	0
9042	225	962	4	5	\N	80
9043	226	962	0	0	\N	0
9044	227	962	4	4	\N	90
9045	228	962	0	2	\N	-10
9046	210	962	4	4	\N	90
9047	211	962	1	1	\N	20
9048	212	962	4	5	\N	80
9049	194	962	3	5	\N	50
9050	195	962	0	0	\N	0
9051	196	962	3	3	\N	60
9052	197	962	2	4	\N	30
9053	217	963	3	5	\N	50
9054	218	963	4	4	\N	90
9055	219	963	2	2	\N	40
9056	220	963	0	0	\N	0
9057	207	963	4	5	\N	80
9058	208	963	0	0	\N	0
9059	209	963	2	3	\N	40
9060	233	963	3	6	\N	40
9061	234	963	3	3	\N	60
9062	235	963	1	1	\N	20
9063	198	964	2	3	\N	40
9064	199	964	4	5	\N	80
9065	200	964	4	6	\N	70
9066	191	964	1	2	\N	20
9067	192	964	0	0	\N	0
9068	193	964	2	3	\N	40
9069	213	964	1	2	\N	20
9070	214	964	1	2	\N	20
9071	215	964	3	3	\N	60
9072	216	964	0	0	\N	0
9073	204	965	1	2	\N	20
9074	205	965	2	2	\N	40
9075	206	965	2	4	\N	30
9076	188	965	4	4	\N	90
9077	189	965	1	1	\N	20
9078	190	965	2	2	\N	40
9079	210	965	1	3	\N	10
9080	211	965	1	2	\N	20
9081	212	965	4	4	\N	90
9082	233	966	3	4	\N	60
9083	234	966	2	2	\N	40
9084	235	966	1	1	\N	20
9085	217	966	0	1	\N	0
9086	218	966	0	0	\N	0
9087	219	966	0	0	\N	0
9088	220	966	0	0	\N	0
9089	201	966	4	4	\N	90
9090	202	966	3	3	\N	60
9091	203	966	0	2	\N	-10
9092	191	967	4	5	\N	80
9093	192	967	0	0	\N	0
9094	193	967	1	1	\N	20
9095	225	967	0	1	\N	0
9096	226	967	1	1	\N	20
9097	227	967	0	0	\N	0
9098	228	967	0	2	\N	-10
9099	198	967	3	3	\N	60
9100	199	967	1	1	\N	20
9101	200	967	0	0	\N	0
9102	188	968	0	1	\N	0
9103	189	968	0	1	\N	0
9104	190	968	0	0	\N	0
9105	221	968	3	6	\N	40
9106	222	968	1	1	\N	20
9107	223	968	1	1	\N	20
9108	224	968	1	1	\N	20
9109	236	968	3	3	\N	60
9110	237	968	1	2	\N	20
9111	238	968	0	0	\N	0
9112	239	968	2	3	\N	40
9113	247	969	0	0	\N	0
9114	248	969	1	3	\N	10
9115	249	969	0	0	\N	0
9116	254	969	3	6	\N	40
9117	255	969	0	1	\N	0
9118	256	969	1	3	\N	10
9119	207	969	0	3	\N	-20
9120	208	969	1	1	\N	20
9121	209	969	4	5	\N	80
9122	244	970	1	2	\N	20
9123	245	970	1	1	\N	20
9124	246	970	0	0	\N	0
9125	250	970	4	5	\N	80
9126	251	970	1	1	\N	20
9127	252	970	3	4	\N	60
9128	253	970	3	3	\N	60
9129	194	970	1	1	\N	20
9130	195	970	4	4	\N	90
9131	196	970	4	4	\N	90
9132	197	970	2	2	\N	40
9133	213	971	0	2	\N	-10
9134	214	971	2	3	\N	40
9135	215	971	2	2	\N	40
9136	216	971	1	1	\N	20
9137	240	971	3	4	\N	60
9138	241	971	0	0	\N	0
9139	242	971	0	0	\N	0
9140	243	971	0	0	\N	0
9141	229	971	0	3	\N	-20
9142	230	971	0	0	\N	0
9143	231	971	4	4	\N	90
9144	232	971	0	1	\N	0
9145	204	972	3	5	\N	50
9146	205	972	3	4	\N	60
9147	206	972	1	1	\N	20
9148	194	972	4	5	\N	80
9149	195	972	3	3	\N	60
9150	196	972	3	5	\N	50
9151	197	972	0	0	\N	0
9152	229	972	4	6	\N	70
9153	230	972	0	0	\N	0
9154	231	972	0	0	\N	0
9155	232	972	2	4	\N	30
9156	244	973	4	5	\N	80
9157	245	973	2	2	\N	40
9158	246	973	1	1	\N	20
9159	207	973	4	4	\N	90
9160	208	973	1	2	\N	20
9161	209	973	2	2	\N	40
9162	233	973	1	3	\N	10
9163	234	973	4	5	\N	80
9164	235	973	2	4	\N	30
9165	254	974	4	6	\N	70
9166	255	974	3	4	\N	60
9167	256	974	1	1	\N	20
9168	225	974	4	5	\N	80
9169	226	974	0	2	\N	-10
9170	227	974	1	1	\N	20
9171	228	974	2	3	\N	40
9172	217	974	1	2	\N	20
9173	218	974	0	0	\N	0
9174	219	974	4	4	\N	90
9175	220	974	2	2	\N	40
9176	198	975	1	3	\N	10
9177	199	975	2	3	\N	40
9178	200	975	0	0	\N	0
9179	240	975	2	5	\N	20
9180	241	975	0	1	\N	0
9181	242	975	0	0	\N	0
9182	243	975	4	4	\N	90
9183	204	975	3	4	\N	60
9184	205	975	0	1	\N	0
9185	206	975	1	3	\N	10
9186	247	976	4	6	\N	70
9187	248	976	2	4	\N	30
9188	249	976	0	2	\N	-10
9189	250	976	4	4	\N	90
9190	251	976	0	0	\N	0
9191	252	976	1	2	\N	20
9192	253	976	0	0	\N	0
9193	236	976	3	6	\N	40
9194	237	976	2	2	\N	40
9195	238	976	1	1	\N	20
9196	239	976	2	2	\N	40
9197	210	977	4	5	\N	80
9198	211	977	1	1	\N	20
9199	212	977	0	0	\N	0
9200	213	977	4	6	\N	70
9201	214	977	2	2	\N	40
9202	215	977	0	1	\N	0
9203	216	977	2	2	\N	40
9204	191	977	3	4	\N	60
9205	192	977	4	5	\N	80
9206	193	977	0	0	\N	0
9207	188	978	3	4	\N	60
9208	189	978	1	1	\N	20
9209	190	978	4	4	\N	90
9210	221	978	3	4	\N	60
9211	222	978	0	1	\N	0
9212	223	978	0	1	\N	0
9213	224	978	1	2	\N	20
9214	201	978	4	4	\N	90
9215	202	978	0	0	\N	0
9216	203	978	0	0	\N	0
9217	1	979	4	4	\N	90
9218	2	979	0	1	\N	0
9219	3	979	0	0	\N	0
9220	37	979	4	6	\N	70
9221	38	979	4	6	\N	70
9222	39	979	1	2	\N	20
9223	40	979	3	3	\N	60
9224	41	979	1	1	\N	20
9225	12	979	3	3	\N	60
9226	13	979	0	0	\N	0
9227	14	979	1	1	\N	20
9228	42	980	3	5	\N	50
9229	43	980	2	4	\N	30
9230	44	980	1	2	\N	20
9231	65	980	4	4	\N	90
9232	66	980	0	1	\N	0
9233	67	980	4	4	\N	90
9234	68	980	0	0	\N	0
9235	89	980	3	3	\N	60
9236	90	980	1	1	\N	20
9237	91	980	2	3	\N	40
9238	83	981	4	5	\N	80
9239	84	981	0	2	\N	-10
9240	85	981	3	3	\N	60
9241	25	981	2	2	\N	40
9242	26	981	2	2	\N	40
9243	27	981	4	4	\N	90
9244	96	981	3	4	\N	60
9245	97	981	0	0	\N	0
9246	98	981	2	2	\N	40
9247	99	981	0	0	\N	0
9248	58	982	0	0	\N	0
9249	59	982	0	1	\N	0
9250	60	982	1	1	\N	20
9251	61	982	1	1	\N	20
9252	72	982	4	4	\N	90
9253	73	982	1	1	\N	20
9254	74	982	0	1	\N	0
9255	75	982	4	5	\N	80
9256	19	982	2	2	\N	40
9257	20	982	1	1	\N	20
9258	21	982	0	0	\N	0
9259	76	983	4	4	\N	90
9260	77	983	0	0	\N	0
9261	78	983	1	1	\N	20
9262	79	983	3	3	\N	60
9263	69	983	4	5	\N	80
9264	70	983	4	4	\N	90
9265	71	983	0	0	\N	0
9266	80	983	4	4	\N	90
9267	81	983	1	3	\N	10
9268	82	983	2	3	\N	40
9269	33	984	4	4	\N	90
9270	34	984	0	1	\N	0
9271	35	984	1	1	\N	20
9272	36	984	1	1	\N	20
9273	8	984	3	3	\N	60
9274	9	984	0	1	\N	0
9275	10	984	1	1	\N	20
9276	11	984	1	1	\N	20
9277	92	984	3	4	\N	60
9278	93	984	4	4	\N	90
9279	94	984	1	1	\N	20
9280	95	984	4	4	\N	90
9281	28	985	0	0	\N	0
9282	29	985	3	4	\N	60
9283	30	985	1	1	\N	20
9284	31	985	0	0	\N	0
9285	32	985	0	1	\N	0
9286	22	985	1	1	\N	20
9287	23	985	0	0	\N	0
9288	24	985	2	2	\N	40
9289	48	985	3	4	\N	60
9290	49	985	0	0	\N	0
9291	50	985	0	2	\N	-10
9292	51	986	0	2	\N	-10
9293	52	986	1	1	\N	20
9294	53	986	0	1	\N	0
9295	62	986	4	5	\N	80
9296	63	986	1	1	\N	20
9297	64	986	0	1	\N	0
9298	86	986	3	6	\N	40
9299	87	986	2	2	\N	40
9300	88	986	3	4	\N	60
9301	54	987	2	3	\N	40
9302	55	987	1	1	\N	20
9303	56	987	2	2	\N	40
9304	57	987	4	6	\N	70
9305	15	987	1	2	\N	20
9306	16	987	1	2	\N	20
9307	17	987	3	3	\N	60
9308	18	987	0	0	\N	0
9309	4	987	3	3	\N	60
9310	5	987	1	1	\N	20
9311	6	987	3	3	\N	60
9312	7	987	2	3	\N	40
9313	45	988	3	4	\N	60
9314	46	988	4	4	\N	90
9315	47	988	0	0	\N	0
9316	100	988	4	5	\N	80
9317	101	988	1	1	\N	20
9318	102	988	0	1	\N	0
9319	103	988	2	2	\N	40
9320	86	988	4	5	\N	80
9321	87	988	4	4	\N	90
9322	88	988	0	0	\N	0
9323	76	989	4	5	\N	80
9324	77	989	0	1	\N	0
9325	78	989	4	4	\N	90
9326	79	989	1	1	\N	20
9327	8	989	3	5	\N	50
9328	9	989	4	4	\N	90
9329	10	989	2	3	\N	40
9330	11	989	0	0	\N	0
9331	12	989	3	5	\N	50
9332	13	989	1	1	\N	20
9333	14	989	0	0	\N	0
9334	54	990	0	3	\N	-20
9335	55	990	0	0	\N	0
9336	56	990	2	3	\N	40
9337	57	990	3	3	\N	60
9338	51	990	0	3	\N	-20
9339	52	990	2	2	\N	40
9340	53	990	4	4	\N	90
9341	69	990	1	1	\N	20
9342	70	990	4	4	\N	90
9343	71	990	0	0	\N	0
9344	65	991	3	5	\N	50
9345	66	991	1	1	\N	20
9346	67	991	1	1	\N	20
9347	68	991	1	1	\N	20
9348	37	991	4	5	\N	80
9349	38	991	1	1	\N	20
9350	39	991	0	2	\N	-10
9351	40	991	2	2	\N	40
9352	41	991	2	2	\N	40
9353	28	991	3	3	\N	60
9354	29	991	0	2	\N	-10
9355	30	991	2	2	\N	40
9356	31	991	1	1	\N	20
9357	32	991	0	0	\N	0
9358	19	992	4	5	\N	80
9359	20	992	0	2	\N	-10
9360	21	992	1	1	\N	20
9361	100	992	3	5	\N	50
9362	101	992	0	2	\N	-10
9363	102	992	0	0	\N	0
9364	103	992	0	2	\N	-10
9365	33	992	4	4	\N	90
9366	34	992	2	2	\N	40
9367	35	992	4	5	\N	80
9368	36	992	1	2	\N	20
9369	1	993	1	2	\N	20
9370	2	993	0	0	\N	0
9371	3	993	1	2	\N	20
9372	15	993	4	4	\N	90
9373	16	993	2	3	\N	40
9374	17	993	0	0	\N	0
9375	18	993	1	1	\N	20
9376	96	993	3	6	\N	40
9377	97	993	1	1	\N	20
9378	98	993	1	1	\N	20
9379	99	993	0	0	\N	0
9380	25	994	4	5	\N	80
9381	26	994	2	2	\N	40
9382	27	994	2	2	\N	40
9383	62	994	3	4	\N	60
9384	63	994	2	4	\N	30
9385	64	994	2	3	\N	40
9386	72	994	4	5	\N	80
9387	73	994	1	1	\N	20
9388	74	994	1	1	\N	20
9389	75	994	2	2	\N	40
9390	89	995	4	4	\N	90
9391	90	995	2	2	\N	40
9392	91	995	0	0	\N	0
9393	80	995	3	4	\N	60
9394	81	995	0	2	\N	-10
9395	82	995	1	3	\N	10
9396	4	995	1	2	\N	20
9397	5	995	1	2	\N	20
9398	6	995	0	0	\N	0
9399	7	995	1	1	\N	20
9400	22	996	4	5	\N	80
9401	23	996	1	1	\N	20
9402	24	996	2	2	\N	40
9403	48	996	4	4	\N	90
9404	49	996	1	1	\N	20
9405	50	996	1	2	\N	20
9406	58	996	2	4	\N	30
9407	59	996	3	3	\N	60
9408	60	996	1	1	\N	20
9409	61	996	0	0	\N	0
9410	92	997	1	3	\N	10
9411	93	997	4	4	\N	90
9412	94	997	3	3	\N	60
9413	95	997	1	1	\N	20
9414	42	997	2	3	\N	40
9415	43	997	0	0	\N	0
9416	44	997	0	0	\N	0
9417	45	997	4	5	\N	80
9418	46	997	2	4	\N	30
9419	47	997	2	3	\N	40
9420	83	998	4	6	\N	70
9421	84	998	0	1	\N	0
9422	85	998	4	4	\N	90
9423	37	998	2	4	\N	30
9424	38	998	0	0	\N	0
9425	39	998	0	0	\N	0
9426	40	998	4	4	\N	90
9427	41	998	4	4	\N	90
9428	83	998	0	1	\N	0
9429	84	998	0	0	\N	0
9430	85	998	1	1	\N	20
9431	45	999	1	2	\N	20
9432	46	999	0	1	\N	0
9433	47	999	2	2	\N	40
9434	65	999	4	4	\N	90
9435	66	999	1	1	\N	20
9436	67	999	1	1	\N	20
9437	68	999	0	2	\N	-10
9438	19	999	3	5	\N	50
9439	20	999	1	1	\N	20
9440	21	999	1	1	\N	20
9441	89	1000	3	5	\N	50
9442	90	1000	4	4	\N	90
9443	91	1000	4	4	\N	90
9444	1	1000	0	0	\N	0
9445	2	1000	1	3	\N	10
9446	3	1000	4	6	\N	70
9447	76	1000	4	5	\N	80
9448	77	1000	0	0	\N	0
9449	78	1000	0	1	\N	0
9450	79	1000	0	0	\N	0
9451	80	1001	4	4	\N	90
9452	81	1001	3	3	\N	60
9453	82	1001	1	1	\N	20
9454	92	1001	1	3	\N	10
9455	93	1001	2	2	\N	40
9456	94	1001	0	1	\N	0
9457	95	1001	3	3	\N	60
9458	51	1001	0	1	\N	0
9459	52	1001	0	0	\N	0
9460	53	1001	0	2	\N	-10
9461	12	1002	4	5	\N	80
9462	13	1002	0	0	\N	0
9463	14	1002	2	2	\N	40
9464	48	1002	3	4	\N	60
9465	49	1002	0	1	\N	0
9466	50	1002	1	1	\N	20
9467	8	1002	3	6	\N	40
9468	9	1002	4	4	\N	90
9469	10	1002	1	2	\N	20
9470	11	1002	0	0	\N	0
9471	25	1003	4	4	\N	90
9472	26	1003	0	0	\N	0
9473	27	1003	1	1	\N	20
9474	28	1003	4	4	\N	90
9475	29	1003	2	3	\N	40
9476	30	1003	1	1	\N	20
9477	31	1003	4	5	\N	80
9478	32	1003	3	3	\N	60
9479	33	1003	3	4	\N	60
9480	34	1003	0	0	\N	0
9481	35	1003	3	3	\N	60
9482	36	1003	0	0	\N	0
9483	72	1004	2	3	\N	40
9484	73	1004	3	4	\N	60
9485	74	1004	3	3	\N	60
9486	75	1004	2	4	\N	30
9487	58	1004	3	4	\N	60
9488	59	1004	1	2	\N	20
9489	60	1004	4	6	\N	70
9490	61	1004	0	0	\N	0
9491	42	1004	4	4	\N	90
9492	43	1004	1	1	\N	20
9493	44	1004	3	3	\N	60
9494	22	1005	3	4	\N	60
9495	23	1005	0	2	\N	-10
9496	24	1005	0	1	\N	0
9497	69	1005	3	5	\N	50
9498	70	1005	1	1	\N	20
9499	71	1005	2	3	\N	40
9500	62	1005	2	3	\N	40
9501	63	1005	0	0	\N	0
9502	64	1005	2	3	\N	40
9503	4	1006	4	5	\N	80
9504	5	1006	2	4	\N	30
9505	6	1006	4	5	\N	80
9506	7	1006	0	0	\N	0
9507	96	1006	4	6	\N	70
9508	97	1006	2	4	\N	30
9509	98	1006	1	2	\N	20
9510	99	1006	0	1	\N	0
9511	54	1006	3	6	\N	40
9512	55	1006	1	2	\N	20
9513	56	1006	1	1	\N	20
9514	57	1006	0	0	\N	0
9515	100	1007	4	5	\N	80
9516	101	1007	2	2	\N	40
9517	102	1007	2	2	\N	40
9518	103	1007	3	3	\N	60
9519	15	1007	3	3	\N	60
9520	16	1007	4	4	\N	90
9521	17	1007	1	2	\N	20
9522	18	1007	2	4	\N	30
9523	86	1007	3	5	\N	50
9524	87	1007	1	1	\N	20
9525	88	1007	2	2	\N	40
9526	89	1008	4	4	\N	90
9527	90	1008	0	1	\N	0
9528	91	1008	3	3	\N	60
9529	4	1008	4	4	\N	90
9530	5	1008	0	0	\N	0
9531	6	1008	3	3	\N	60
9532	7	1008	1	1	\N	20
9533	100	1008	4	5	\N	80
9534	101	1008	2	3	\N	40
9535	102	1008	2	2	\N	40
9536	103	1008	0	0	\N	0
9537	1	1009	3	5	\N	50
9538	2	1009	0	0	\N	0
9539	3	1009	0	0	\N	0
9540	62	1009	4	4	\N	90
9541	63	1009	1	1	\N	20
9542	64	1009	1	3	\N	10
9543	22	1009	3	5	\N	50
9544	23	1009	0	0	\N	0
9545	24	1009	0	0	\N	0
9546	65	1010	1	4	\N	0
9547	66	1010	0	0	\N	0
9548	67	1010	1	1	\N	20
9549	68	1010	2	2	\N	40
9550	96	1010	3	6	\N	40
9551	97	1010	3	3	\N	60
9552	98	1010	4	5	\N	80
9553	99	1010	1	1	\N	20
9554	37	1010	4	5	\N	80
9555	38	1010	0	2	\N	-10
9556	39	1010	0	0	\N	0
9557	40	1010	3	3	\N	60
9558	41	1010	1	2	\N	20
9559	48	1011	0	1	\N	0
9560	49	1011	0	1	\N	0
9561	50	1011	2	4	\N	30
9562	19	1011	3	4	\N	60
9563	20	1011	4	6	\N	70
9564	21	1011	2	2	\N	40
9565	42	1011	3	4	\N	60
9566	43	1011	1	1	\N	20
9567	44	1011	1	1	\N	20
9568	54	1012	3	4	\N	60
9569	55	1012	0	0	\N	0
9570	56	1012	3	5	\N	50
9571	57	1012	2	4	\N	30
9572	15	1012	4	4	\N	90
9573	16	1012	0	0	\N	0
9574	17	1012	3	4	\N	60
9575	18	1012	4	4	\N	90
9576	45	1012	1	2	\N	20
9577	46	1012	3	3	\N	60
9578	47	1012	3	4	\N	60
9579	72	1013	0	1	\N	0
9580	73	1013	1	1	\N	20
9581	74	1013	1	1	\N	20
9582	75	1013	2	3	\N	40
9583	76	1013	3	5	\N	50
9584	77	1013	0	0	\N	0
9585	78	1013	0	0	\N	0
9586	79	1013	0	0	\N	0
9587	58	1013	3	3	\N	60
9588	59	1013	1	1	\N	20
9589	60	1013	1	1	\N	20
9590	61	1013	0	1	\N	0
9591	69	1014	4	4	\N	90
9592	70	1014	4	5	\N	80
9593	71	1014	0	0	\N	0
9594	51	1014	2	3	\N	40
9595	52	1014	1	3	\N	10
9596	53	1014	3	5	\N	50
9597	12	1014	4	4	\N	90
9598	13	1014	1	1	\N	20
9599	14	1014	1	1	\N	20
9600	80	1015	0	1	\N	0
9601	81	1015	3	3	\N	60
9602	82	1015	1	1	\N	20
9603	83	1015	3	5	\N	50
9604	84	1015	1	1	\N	20
9605	85	1015	0	0	\N	0
9606	28	1015	0	3	\N	-20
9607	29	1015	0	0	\N	0
9608	30	1015	0	1	\N	0
9609	31	1015	1	1	\N	20
9610	32	1015	1	1	\N	20
9611	92	1016	4	5	\N	80
9612	93	1016	3	4	\N	60
9613	94	1016	1	1	\N	20
9614	95	1016	2	2	\N	40
9615	25	1016	0	0	\N	0
9616	26	1016	1	1	\N	20
9617	27	1016	3	3	\N	60
9618	33	1016	4	4	\N	90
9619	34	1016	2	2	\N	40
9620	35	1016	0	2	\N	-10
9621	36	1016	0	0	\N	0
9622	86	1017	3	6	\N	40
9623	87	1017	1	1	\N	20
9624	88	1017	1	1	\N	20
9625	8	1017	3	3	\N	60
9626	9	1017	3	3	\N	60
9627	10	1017	3	3	\N	60
9628	11	1017	0	1	\N	0
9629	19	1017	4	6	\N	70
9630	20	1017	2	2	\N	40
9631	21	1017	1	1	\N	20
9632	83	1018	3	5	\N	50
9633	84	1018	2	3	\N	40
9634	85	1018	0	0	\N	0
9635	92	1018	4	6	\N	70
9636	93	1018	1	1	\N	20
9637	94	1018	1	3	\N	10
9638	95	1018	0	0	\N	0
9639	4	1018	3	4	\N	60
9640	5	1018	0	0	\N	0
9641	6	1018	3	4	\N	60
9642	7	1018	0	0	\N	0
9643	76	1019	0	0	\N	0
9644	77	1019	2	2	\N	40
9645	78	1019	1	1	\N	20
9646	79	1019	0	0	\N	0
9647	62	1019	3	5	\N	50
9648	63	1019	0	1	\N	0
9649	64	1019	4	4	\N	90
9650	15	1019	3	6	\N	40
9651	16	1019	2	2	\N	40
9652	17	1019	2	2	\N	40
9653	18	1019	2	2	\N	40
9654	48	1020	4	5	\N	80
9655	49	1020	1	2	\N	20
9656	50	1020	1	2	\N	20
9657	65	1020	4	4	\N	90
9658	66	1020	4	4	\N	90
9659	67	1020	2	2	\N	40
9660	68	1020	0	0	\N	0
9661	80	1020	4	4	\N	90
9662	81	1020	1	3	\N	10
9663	82	1020	4	4	\N	90
9664	1	1021	0	0	\N	0
9665	2	1021	2	2	\N	40
9666	3	1021	4	4	\N	90
9667	100	1021	3	3	\N	60
9668	101	1021	3	4	\N	60
9669	102	1021	4	6	\N	70
9670	103	1021	0	1	\N	0
9671	54	1021	2	3	\N	40
9672	55	1021	4	5	\N	80
9673	56	1021	1	2	\N	20
9674	57	1021	2	2	\N	40
9675	45	1022	3	5	\N	50
9676	46	1022	2	2	\N	40
9677	47	1022	3	4	\N	60
9678	89	1022	1	3	\N	10
9679	90	1022	1	1	\N	20
9680	91	1022	4	4	\N	90
9681	8	1022	3	4	\N	60
9682	9	1022	2	3	\N	40
9683	10	1022	4	5	\N	80
9684	11	1022	2	2	\N	40
9685	25	1023	4	6	\N	70
9686	26	1023	4	5	\N	80
9687	27	1023	4	4	\N	90
9688	51	1023	0	0	\N	0
9689	52	1023	1	1	\N	20
9690	53	1023	1	1	\N	20
9691	22	1023	1	3	\N	10
9692	23	1023	0	0	\N	0
9693	24	1023	1	3	\N	10
9694	58	1024	3	3	\N	60
9695	59	1024	0	1	\N	0
9696	60	1024	3	3	\N	60
9697	61	1024	2	3	\N	40
9698	72	1024	4	5	\N	80
9699	73	1024	0	0	\N	0
9700	74	1024	1	1	\N	20
9701	75	1024	1	1	\N	20
9702	69	1024	3	4	\N	60
9703	70	1024	3	3	\N	60
9704	71	1024	0	0	\N	0
9705	28	1025	4	5	\N	80
9706	29	1025	0	0	\N	0
9707	30	1025	0	0	\N	0
9708	31	1025	1	1	\N	20
9709	32	1025	0	2	\N	-10
9710	37	1025	2	2	\N	40
9711	38	1025	0	0	\N	0
9712	39	1025	2	3	\N	40
9713	40	1025	4	4	\N	90
9714	41	1025	1	3	\N	10
9715	33	1025	1	3	\N	10
9716	34	1025	1	1	\N	20
9717	35	1025	1	1	\N	20
9718	36	1025	3	3	\N	60
9719	96	1026	4	6	\N	70
9720	97	1026	3	3	\N	60
9721	98	1026	1	1	\N	20
9722	99	1026	3	3	\N	60
9723	86	1026	3	4	\N	60
9724	87	1026	0	1	\N	0
9725	88	1026	0	2	\N	-10
9726	42	1026	4	5	\N	80
9727	43	1026	0	0	\N	0
9728	44	1026	1	1	\N	20
9729	12	1027	4	5	\N	80
9730	13	1027	1	2	\N	20
9731	14	1027	2	2	\N	40
9732	37	1027	1	3	\N	10
9733	38	1027	2	2	\N	40
9734	39	1027	2	3	\N	40
9735	40	1027	0	0	\N	0
9736	41	1027	3	4	\N	60
9737	92	1027	4	4	\N	90
9738	93	1027	2	2	\N	40
9739	94	1027	0	0	\N	0
9740	95	1027	4	4	\N	90
9741	12	1028	3	5	\N	50
9742	13	1028	4	4	\N	90
9743	14	1028	1	1	\N	20
9744	25	1028	4	4	\N	90
9745	26	1028	1	1	\N	20
9746	27	1028	2	3	\N	40
9747	51	1028	0	0	\N	0
9748	52	1028	2	3	\N	40
9749	53	1028	0	1	\N	0
9750	76	1029	1	2	\N	20
9751	77	1029	0	0	\N	0
9752	78	1029	1	2	\N	20
9753	79	1029	2	2	\N	40
9754	89	1029	4	4	\N	90
9755	90	1029	4	4	\N	90
9756	91	1029	2	2	\N	40
9757	83	1029	1	1	\N	20
9758	84	1029	0	1	\N	0
9759	85	1029	0	0	\N	0
9760	22	1030	4	4	\N	90
9761	23	1030	2	2	\N	40
9762	24	1030	0	1	\N	0
9763	86	1030	4	4	\N	90
9764	87	1030	3	3	\N	60
9765	88	1030	0	0	\N	0
9766	96	1030	3	5	\N	50
9767	97	1030	1	2	\N	20
9768	98	1030	4	5	\N	80
9769	99	1030	1	2	\N	20
9770	15	1031	1	1	\N	20
9771	16	1031	2	2	\N	40
9772	17	1031	0	0	\N	0
9773	18	1031	3	3	\N	60
9774	58	1031	2	3	\N	40
9775	59	1031	0	1	\N	0
9776	60	1031	2	3	\N	40
9777	61	1031	2	3	\N	40
9778	45	1031	3	3	\N	60
9779	46	1031	4	5	\N	80
9780	47	1031	1	3	\N	10
9781	72	1032	4	4	\N	90
9782	73	1032	4	4	\N	90
9783	74	1032	2	2	\N	40
9784	75	1032	0	0	\N	0
9785	69	1032	3	5	\N	50
9786	70	1032	1	1	\N	20
9787	71	1032	1	2	\N	20
9788	28	1032	4	6	\N	70
9789	29	1032	2	2	\N	40
9790	30	1032	0	0	\N	0
9791	31	1032	1	2	\N	20
9792	32	1032	3	3	\N	60
9793	48	1033	3	4	\N	60
9794	49	1033	1	1	\N	20
9795	50	1033	1	1	\N	20
9796	8	1033	1	3	\N	10
9797	9	1033	3	3	\N	60
9798	10	1033	1	1	\N	20
9799	11	1033	4	4	\N	90
9800	19	1033	0	0	\N	0
9801	20	1033	1	1	\N	20
9802	21	1033	1	2	\N	20
9803	33	1034	4	4	\N	90
9804	34	1034	1	1	\N	20
9805	35	1034	1	1	\N	20
9806	36	1034	2	2	\N	40
9807	80	1034	3	5	\N	50
9808	81	1034	3	3	\N	60
9809	82	1034	1	1	\N	20
9810	4	1034	4	4	\N	90
9811	5	1034	2	2	\N	40
9812	6	1034	1	1	\N	20
9813	7	1034	0	0	\N	0
9814	100	1035	4	5	\N	80
9815	101	1035	2	4	\N	30
9816	102	1035	3	3	\N	60
9817	103	1035	0	0	\N	0
9818	62	1035	3	5	\N	50
9819	63	1035	3	3	\N	60
9820	64	1035	1	2	\N	20
9821	54	1035	4	4	\N	90
9822	55	1035	1	2	\N	20
9823	56	1035	1	2	\N	20
9824	57	1035	2	2	\N	40
9825	65	1036	2	2	\N	40
9826	66	1036	1	2	\N	20
9827	67	1036	0	0	\N	0
9828	68	1036	0	1	\N	0
9829	1	1036	3	5	\N	50
9830	2	1036	1	1	\N	20
9831	3	1036	1	2	\N	20
9832	42	1036	4	4	\N	90
9833	43	1036	0	0	\N	0
9834	44	1036	4	5	\N	80
9835	138	1039	3	6	\N	40
9836	139	1039	4	4	\N	90
9837	140	1039	2	2	\N	40
9838	167	1039	2	3	\N	40
9839	168	1039	2	2	\N	40
9840	161	1039	1	3	\N	10
9841	162	1039	0	0	\N	0
9842	163	1039	0	0	\N	0
9843	104	1040	3	4	\N	60
9844	114	1040	3	3	\N	60
9845	115	1040	0	0	\N	0
9846	116	1040	3	5	\N	50
9847	146	1040	1	1	\N	20
9848	182	1041	3	4	\N	60
9849	183	1041	2	2	\N	40
9850	164	1041	1	3	\N	10
9851	165	1041	4	6	\N	70
9852	166	1041	1	1	\N	20
9853	169	1041	4	4	\N	90
9854	170	1041	1	1	\N	20
9855	171	1041	0	0	\N	0
9856	158	1042	3	4	\N	60
9857	159	1042	0	2	\N	-10
9858	160	1042	2	3	\N	40
9859	155	1042	0	1	\N	0
9860	156	1042	3	3	\N	60
9861	157	1042	0	0	\N	0
9862	172	1042	2	4	\N	30
9863	173	1042	2	2	\N	40
9864	174	1042	2	2	\N	40
9865	175	1042	0	0	\N	0
9866	184	1043	4	5	\N	80
9867	123	1043	3	4	\N	60
9868	124	1043	2	2	\N	40
9869	119	1043	4	5	\N	80
9870	120	1043	1	1	\N	20
9871	121	1043	0	0	\N	0
9872	122	1043	1	1	\N	20
9873	107	1044	3	4	\N	60
9874	108	1044	1	1	\N	20
9875	109	1044	1	2	\N	20
9876	110	1044	0	2	\N	-10
9877	180	1044	3	6	\N	40
9878	181	1044	0	0	\N	0
9879	130	1044	3	3	\N	60
9880	131	1044	2	2	\N	40
9881	132	1044	2	2	\N	40
9882	133	1044	2	2	\N	40
9883	125	1045	3	5	\N	50
9884	126	1045	2	2	\N	40
9885	127	1045	0	1	\N	0
9886	143	1045	4	6	\N	70
9887	144	1045	0	0	\N	0
9888	145	1045	0	0	\N	0
9889	128	1045	4	4	\N	90
9890	129	1045	0	2	\N	-10
9891	185	1046	0	2	\N	-10
9892	186	1046	1	2	\N	20
9893	187	1046	0	0	\N	0
9894	134	1046	3	3	\N	60
9895	135	1046	0	0	\N	0
9896	136	1046	0	0	\N	0
9897	137	1046	3	3	\N	60
9898	153	1046	2	5	\N	20
9899	154	1046	2	3	\N	40
9900	105	1047	0	1	\N	0
9901	106	1047	2	2	\N	40
9902	147	1047	4	6	\N	70
9903	148	1047	0	2	\N	-10
9904	176	1047	4	5	\N	80
9905	177	1047	3	4	\N	60
9906	178	1047	1	1	\N	20
9907	179	1047	3	3	\N	60
9908	117	1048	4	4	\N	90
9909	118	1048	3	3	\N	60
9910	141	1048	0	2	\N	-10
9911	142	1048	3	4	\N	60
9912	149	1048	2	4	\N	30
9913	150	1048	1	3	\N	10
9914	151	1048	2	2	\N	40
9915	152	1048	0	0	\N	0
9916	111	1049	3	3	\N	60
9917	112	1049	2	2	\N	40
9918	113	1049	1	1	\N	20
9919	111	1049	4	4	\N	90
9920	112	1049	1	1	\N	20
9921	113	1049	1	1	\N	20
9922	149	1049	4	4	\N	90
9923	150	1049	0	1	\N	0
9924	151	1049	2	4	\N	30
9925	152	1049	2	2	\N	40
9926	184	1050	2	3	\N	40
9927	119	1050	2	3	\N	40
9928	120	1050	1	1	\N	20
9929	121	1050	1	1	\N	20
9930	122	1050	0	0	\N	0
9931	164	1050	3	3	\N	60
9932	165	1050	2	2	\N	40
9933	166	1050	1	3	\N	10
9934	176	1051	0	2	\N	-10
9935	177	1051	2	2	\N	40
9936	178	1051	1	2	\N	20
9937	179	1051	2	2	\N	40
9938	130	1051	4	5	\N	80
9939	131	1051	0	0	\N	0
9940	132	1051	0	0	\N	0
9941	133	1051	3	5	\N	50
9942	134	1051	2	4	\N	30
9943	135	1051	0	1	\N	0
9944	136	1051	1	1	\N	20
9945	137	1051	3	3	\N	60
9946	147	1052	3	5	\N	50
9947	148	1052	1	1	\N	20
9948	128	1052	4	4	\N	90
9949	129	1052	3	3	\N	60
9950	169	1052	4	4	\N	90
9951	170	1052	1	1	\N	20
9952	171	1052	0	0	\N	0
9953	138	1053	4	5	\N	80
9954	139	1053	1	3	\N	10
9955	140	1053	3	5	\N	50
9956	105	1053	3	4	\N	60
9957	106	1053	0	0	\N	0
9958	172	1053	4	5	\N	80
9959	173	1053	3	5	\N	50
9960	174	1053	2	4	\N	30
9961	175	1053	0	2	\N	-10
9962	180	1054	0	2	\N	-10
9963	181	1054	2	2	\N	40
9964	104	1054	3	5	\N	50
9965	107	1054	0	1	\N	0
9966	108	1054	1	3	\N	10
9967	109	1054	3	4	\N	60
9968	110	1054	4	4	\N	90
9969	167	1055	4	5	\N	80
9970	168	1055	4	4	\N	90
9971	123	1055	1	1	\N	20
9972	124	1055	0	0	\N	0
9973	125	1055	4	6	\N	70
9974	126	1055	0	1	\N	0
9975	127	1055	0	2	\N	-10
9976	141	1056	3	3	\N	60
9977	142	1056	1	1	\N	20
9978	161	1056	3	3	\N	60
9979	162	1056	1	1	\N	20
9980	163	1056	0	1	\N	0
9981	114	1056	4	6	\N	70
9982	115	1056	0	1	\N	0
9983	116	1056	0	0	\N	0
9984	117	1057	0	0	\N	0
9985	118	1057	2	4	\N	30
9986	153	1057	4	4	\N	90
9987	154	1057	0	0	\N	0
9988	155	1057	0	1	\N	0
9989	156	1057	4	5	\N	80
9990	157	1057	0	0	\N	0
9991	182	1058	1	4	\N	0
9992	183	1058	1	3	\N	10
9993	146	1058	4	5	\N	80
9994	158	1058	1	2	\N	20
9995	159	1058	2	2	\N	40
9996	160	1058	2	3	\N	40
9997	143	1059	3	5	\N	50
9998	144	1059	0	1	\N	0
9999	145	1059	0	0	\N	0
10000	185	1059	4	5	\N	80
10001	186	1059	2	2	\N	40
10002	187	1059	2	3	\N	40
10003	185	1059	4	5	\N	80
10004	186	1059	0	2	\N	-10
10005	187	1059	4	4	\N	90
10006	123	1060	2	5	\N	20
10007	124	1060	3	3	\N	60
10008	169	1060	4	4	\N	90
10009	170	1060	3	4	\N	60
10010	171	1060	2	3	\N	40
10011	182	1060	4	5	\N	80
10012	183	1060	0	0	\N	0
10013	176	1061	1	2	\N	20
10014	177	1061	1	1	\N	20
10015	178	1061	2	2	\N	40
10016	179	1061	0	2	\N	-10
10017	164	1061	4	4	\N	90
10018	165	1061	0	0	\N	0
10019	166	1061	1	1	\N	20
10020	146	1061	4	4	\N	90
10021	184	1062	3	3	\N	60
10022	114	1062	0	2	\N	-10
10023	115	1062	0	2	\N	-10
10024	116	1062	1	1	\N	20
10025	128	1062	4	4	\N	90
10026	129	1062	1	1	\N	20
10027	138	1063	1	1	\N	20
10028	139	1063	0	1	\N	0
10029	140	1063	1	1	\N	20
10030	180	1063	4	5	\N	80
10031	181	1063	1	1	\N	20
10032	167	1063	3	4	\N	60
10033	168	1063	4	4	\N	90
10034	125	1064	3	4	\N	60
10035	126	1064	1	1	\N	20
10036	127	1064	1	1	\N	20
10037	161	1064	1	3	\N	10
10038	162	1064	1	1	\N	20
10039	163	1064	3	3	\N	60
10040	107	1064	3	3	\N	60
10041	108	1064	2	2	\N	40
10042	109	1064	2	2	\N	40
10043	110	1064	1	1	\N	20
10044	119	1065	3	5	\N	50
10045	120	1065	3	4	\N	60
10046	121	1065	3	5	\N	50
10047	122	1065	1	1	\N	20
10048	117	1065	3	3	\N	60
10049	118	1065	1	2	\N	20
10050	143	1065	2	4	\N	30
10051	144	1065	0	0	\N	0
10052	145	1065	1	1	\N	20
10053	153	1066	0	1	\N	0
10054	154	1066	1	1	\N	20
10055	155	1066	2	3	\N	40
10056	156	1066	0	0	\N	0
10057	157	1066	1	2	\N	20
10058	105	1066	3	3	\N	60
10059	106	1066	0	0	\N	0
10060	141	1067	0	0	\N	0
10061	142	1067	0	0	\N	0
10062	172	1067	3	6	\N	40
10063	173	1067	1	3	\N	10
10064	174	1067	1	1	\N	20
10065	175	1067	2	3	\N	40
10066	147	1067	0	0	\N	0
10067	148	1067	1	1	\N	20
10068	104	1068	0	0	\N	0
10069	158	1068	2	2	\N	40
10070	159	1068	0	0	\N	0
10071	160	1068	2	3	\N	40
10072	149	1068	1	1	\N	20
10073	150	1068	0	2	\N	-10
10074	151	1068	1	1	\N	20
10075	152	1068	1	1	\N	20
10076	111	1069	4	6	\N	70
10077	112	1069	3	4	\N	60
10078	113	1069	3	3	\N	60
10079	130	1069	0	3	\N	-20
10080	131	1069	1	1	\N	20
10081	132	1069	4	5	\N	80
10082	133	1069	1	1	\N	20
10083	134	1069	4	5	\N	80
10084	135	1069	0	0	\N	0
10085	136	1069	2	4	\N	30
10086	137	1069	1	1	\N	20
10087	153	1070	3	4	\N	60
10088	154	1070	1	1	\N	20
10089	134	1070	4	5	\N	80
10090	135	1070	3	4	\N	60
10091	136	1070	2	2	\N	40
10092	137	1070	2	3	\N	40
10093	146	1070	1	2	\N	20
10094	114	1071	3	5	\N	50
10095	115	1071	1	1	\N	20
10096	116	1071	0	0	\N	0
10097	172	1071	2	3	\N	40
10098	173	1071	1	1	\N	20
10099	174	1071	0	0	\N	0
10100	175	1071	3	4	\N	60
10101	184	1071	4	4	\N	90
10102	185	1072	3	3	\N	60
10103	186	1072	0	0	\N	0
10104	187	1072	1	3	\N	10
10105	182	1072	1	3	\N	10
10106	183	1072	0	1	\N	0
10107	164	1072	1	1	\N	20
10108	165	1072	1	1	\N	20
10109	166	1072	0	0	\N	0
10110	167	1073	4	5	\N	80
10111	168	1073	0	2	\N	-10
10112	117	1073	1	2	\N	20
10113	118	1073	3	3	\N	60
10114	149	1073	4	5	\N	80
10115	150	1073	0	0	\N	0
10116	151	1073	0	2	\N	-10
10117	152	1073	3	3	\N	60
10118	119	1074	4	4	\N	90
10119	120	1074	0	0	\N	0
10120	121	1074	2	3	\N	40
10121	122	1074	3	3	\N	60
10122	104	1074	2	3	\N	40
10123	111	1074	3	5	\N	50
10124	112	1074	0	1	\N	0
10125	113	1074	3	4	\N	60
10126	155	1075	3	3	\N	60
10127	156	1075	0	0	\N	0
10128	157	1075	3	3	\N	60
10129	158	1075	4	6	\N	70
10130	159	1075	4	4	\N	90
10131	160	1075	0	0	\N	0
10132	130	1075	4	5	\N	80
10133	131	1075	0	0	\N	0
10134	132	1075	3	5	\N	50
10135	133	1075	3	3	\N	60
10136	107	1076	1	1	\N	20
10137	108	1076	1	1	\N	20
10138	109	1076	0	0	\N	0
10139	110	1076	3	3	\N	60
10140	128	1076	4	4	\N	90
10141	129	1076	3	4	\N	60
10142	125	1076	1	1	\N	20
10143	126	1076	2	4	\N	30
10144	127	1076	0	1	\N	0
10145	180	1077	2	5	\N	20
10146	181	1077	1	1	\N	20
10147	138	1077	3	3	\N	60
10148	139	1077	1	3	\N	10
10149	140	1077	3	3	\N	60
10150	176	1077	4	6	\N	70
10151	177	1077	4	6	\N	70
10152	178	1077	1	1	\N	20
10153	179	1077	2	2	\N	40
10154	123	1078	4	4	\N	90
10155	124	1078	3	4	\N	60
10156	147	1078	3	6	\N	40
10157	148	1078	0	1	\N	0
10158	161	1078	4	5	\N	80
10159	162	1078	1	3	\N	10
10160	163	1078	1	1	\N	20
10161	169	1079	4	4	\N	90
10162	170	1079	4	5	\N	80
10163	171	1079	0	0	\N	0
10164	105	1079	3	3	\N	60
10165	106	1079	3	3	\N	60
10166	143	1079	4	4	\N	90
10167	144	1079	4	4	\N	90
10168	145	1079	2	2	\N	40
10169	141	1080	4	6	\N	70
10170	142	1080	4	4	\N	90
10171	125	1080	2	2	\N	40
10172	126	1080	3	3	\N	60
10173	127	1080	0	0	\N	0
10174	155	1080	0	1	\N	0
10175	156	1080	1	1	\N	20
10176	157	1080	1	1	\N	20
10177	184	1081	3	4	\N	60
10178	169	1081	3	5	\N	50
10179	170	1081	2	2	\N	40
10180	171	1081	0	0	\N	0
10181	158	1081	0	2	\N	-10
10182	159	1081	1	3	\N	10
10183	160	1081	4	4	\N	90
10184	176	1082	4	4	\N	90
10185	177	1082	1	2	\N	20
10186	178	1082	2	4	\N	30
10187	179	1082	1	3	\N	10
10188	111	1082	3	4	\N	60
10189	112	1082	3	4	\N	60
10190	113	1082	3	3	\N	60
10191	141	1082	4	5	\N	80
10192	142	1082	3	3	\N	60
10193	104	1083	3	4	\N	60
10194	107	1083	0	1	\N	0
10195	108	1083	4	5	\N	80
10196	109	1083	2	2	\N	40
10197	110	1083	1	2	\N	20
10198	149	1083	2	5	\N	20
10199	150	1083	1	3	\N	10
10200	151	1083	1	2	\N	20
10201	152	1083	2	3	\N	40
10202	138	1084	4	5	\N	80
10203	139	1084	0	1	\N	0
10204	140	1084	0	0	\N	0
10205	172	1084	3	5	\N	50
10206	173	1084	1	2	\N	20
10207	174	1084	1	1	\N	20
10208	175	1084	1	1	\N	20
10209	185	1084	3	3	\N	60
10210	186	1084	1	1	\N	20
10211	187	1084	0	1	\N	0
10212	128	1085	4	5	\N	80
10213	129	1085	0	0	\N	0
10214	123	1085	4	5	\N	80
10215	124	1085	2	2	\N	40
10216	130	1085	3	3	\N	60
10217	131	1085	4	4	\N	90
10218	132	1085	4	6	\N	70
10219	133	1085	1	2	\N	20
10220	105	1086	3	4	\N	60
10221	106	1086	0	0	\N	0
10222	146	1086	4	5	\N	80
10223	147	1086	4	5	\N	80
10224	148	1086	0	0	\N	0
10225	134	1087	2	3	\N	40
10226	135	1087	0	0	\N	0
10227	136	1087	2	3	\N	40
10228	137	1087	1	1	\N	20
10229	114	1087	4	5	\N	80
10230	115	1087	0	0	\N	0
10231	116	1087	4	5	\N	80
10232	180	1087	4	5	\N	80
10233	181	1087	2	2	\N	40
10234	164	1088	3	4	\N	60
10235	165	1088	2	3	\N	40
10236	166	1088	4	5	\N	80
10237	161	1088	4	6	\N	70
10238	162	1088	4	6	\N	70
10239	163	1088	3	4	\N	60
10240	182	1088	4	5	\N	80
10241	183	1088	2	2	\N	40
10242	153	1089	4	4	\N	90
10243	154	1089	0	0	\N	0
10244	143	1089	0	1	\N	0
10245	144	1089	2	2	\N	40
10246	145	1089	1	2	\N	20
10247	167	1089	4	5	\N	80
10248	168	1089	0	1	\N	0
10249	119	1090	4	5	\N	80
10250	120	1090	0	0	\N	0
10251	121	1090	0	0	\N	0
10252	122	1090	1	2	\N	20
10253	117	1090	3	6	\N	40
10254	118	1090	1	2	\N	20
10255	176	1090	4	5	\N	80
10256	177	1090	1	2	\N	20
10257	178	1090	2	2	\N	40
10258	179	1090	0	0	\N	0
10259	117	1091	3	3	\N	60
10260	118	1091	2	4	\N	30
10261	111	1091	0	1	\N	0
10262	112	1091	1	1	\N	20
10263	113	1091	2	2	\N	40
10264	130	1091	4	5	\N	80
10265	131	1091	1	2	\N	20
10266	132	1091	0	0	\N	0
10267	133	1091	3	3	\N	60
10268	147	1092	0	1	\N	0
10269	148	1092	3	5	\N	50
10270	182	1092	2	5	\N	20
10271	183	1092	0	0	\N	0
10272	153	1092	2	2	\N	40
10273	154	1092	4	4	\N	90
10274	184	1093	4	5	\N	80
10275	167	1093	4	5	\N	80
10276	168	1093	4	4	\N	90
10277	149	1093	4	5	\N	80
10278	150	1093	0	1	\N	0
10279	151	1093	2	4	\N	30
10280	152	1093	0	0	\N	0
10281	155	1094	3	4	\N	60
10282	156	1094	1	2	\N	20
10283	157	1094	2	3	\N	40
10284	114	1094	4	4	\N	90
10285	115	1094	1	1	\N	20
10286	116	1094	1	2	\N	20
10287	107	1094	4	4	\N	90
10288	108	1094	0	0	\N	0
10289	109	1094	0	0	\N	0
10290	110	1094	2	4	\N	30
10291	138	1095	3	3	\N	60
10292	139	1095	0	0	\N	0
10293	140	1095	3	3	\N	60
10294	164	1095	3	4	\N	60
10295	165	1095	1	1	\N	20
10296	166	1095	3	3	\N	60
10297	104	1095	2	5	\N	20
10298	158	1096	1	2	\N	20
10299	159	1096	4	4	\N	90
10300	160	1096	0	0	\N	0
10301	169	1096	4	5	\N	80
10302	170	1096	1	1	\N	20
10303	171	1096	0	1	\N	0
10304	143	1096	2	3	\N	40
10305	144	1096	3	3	\N	60
10306	145	1096	1	3	\N	10
10307	141	1097	4	4	\N	90
10308	142	1097	1	1	\N	20
10309	161	1097	4	6	\N	70
10310	162	1097	0	0	\N	0
10311	163	1097	3	3	\N	60
10312	105	1097	3	5	\N	50
10313	106	1097	2	2	\N	40
10314	123	1098	0	1	\N	0
10315	124	1098	1	1	\N	20
10316	180	1098	4	4	\N	90
10317	181	1098	1	1	\N	20
10318	125	1098	4	5	\N	80
10319	126	1098	0	2	\N	-10
10320	127	1098	0	0	\N	0
10321	134	1099	4	5	\N	80
10322	135	1099	2	2	\N	40
10323	136	1099	1	1	\N	20
10324	137	1099	1	3	\N	10
10325	146	1099	3	3	\N	60
10326	185	1099	4	5	\N	80
10327	186	1099	1	2	\N	20
10328	187	1099	1	1	\N	20
10329	119	1100	3	3	\N	60
10330	120	1100	4	5	\N	80
10331	121	1100	1	1	\N	20
10332	122	1100	0	0	\N	0
10333	128	1100	2	3	\N	40
10334	129	1100	2	3	\N	40
10335	172	1100	4	5	\N	80
10336	173	1100	1	2	\N	20
10337	174	1100	2	2	\N	40
10338	175	1100	0	0	\N	0
10339	198	1102	4	5	\N	80
10340	199	1102	3	4	\N	60
10341	200	1102	1	1	\N	20
10342	188	1102	4	4	\N	90
10343	189	1102	0	0	\N	0
10344	190	1102	4	4	\N	90
10345	207	1102	4	4	\N	90
10346	208	1102	0	0	\N	0
10347	209	1102	0	2	\N	-10
10348	191	1103	3	5	\N	50
10349	192	1103	1	2	\N	20
10350	193	1103	0	0	\N	0
10351	204	1103	0	3	\N	-20
10352	205	1103	0	0	\N	0
10353	206	1103	0	0	\N	0
10354	240	1103	4	5	\N	80
10355	241	1103	1	2	\N	20
10356	242	1103	0	0	\N	0
10357	243	1103	4	6	\N	70
10358	194	1104	3	4	\N	60
10359	195	1104	0	0	\N	0
10360	196	1104	3	3	\N	60
10361	197	1104	1	2	\N	20
10362	210	1104	0	2	\N	-10
10363	211	1104	0	0	\N	0
10364	212	1104	0	0	\N	0
10365	233	1104	3	6	\N	40
10366	234	1104	1	1	\N	20
10367	235	1104	1	2	\N	20
10368	201	1105	3	3	\N	60
10369	202	1105	1	3	\N	10
10370	203	1105	0	1	\N	0
10371	229	1105	4	6	\N	70
10372	230	1105	2	3	\N	40
10373	231	1105	4	4	\N	90
10374	232	1105	2	2	\N	40
10375	247	1105	1	1	\N	20
10376	248	1105	3	3	\N	60
10377	249	1105	0	1	\N	0
10378	217	1106	4	4	\N	90
10379	218	1106	0	2	\N	-10
10380	219	1106	1	3	\N	10
10381	220	1106	0	0	\N	0
10382	244	1106	4	5	\N	80
10383	245	1106	1	2	\N	20
10384	246	1106	1	2	\N	20
10385	213	1106	4	5	\N	80
10386	214	1106	0	0	\N	0
10387	215	1106	0	1	\N	0
10388	216	1106	0	1	\N	0
10389	236	1107	0	2	\N	-10
10390	237	1107	0	0	\N	0
10391	238	1107	4	4	\N	90
10392	239	1107	1	1	\N	20
10393	254	1107	4	5	\N	80
10394	255	1107	2	2	\N	40
10395	256	1107	2	3	\N	40
10396	221	1107	4	5	\N	80
10397	222	1107	0	0	\N	0
10398	223	1107	0	0	\N	0
10399	224	1107	2	2	\N	40
10400	250	1108	1	1	\N	20
10401	251	1108	2	4	\N	30
10402	252	1108	0	2	\N	-10
10403	253	1108	0	0	\N	0
10404	225	1108	1	1	\N	20
10405	226	1108	0	0	\N	0
10406	227	1108	1	2	\N	20
10407	228	1108	3	3	\N	60
10408	244	1108	3	3	\N	60
10409	245	1108	4	4	\N	90
10410	246	1108	1	1	\N	20
10411	188	1109	4	4	\N	90
10412	189	1109	1	1	\N	20
10413	190	1109	0	1	\N	0
10414	201	1109	4	4	\N	90
10415	202	1109	0	0	\N	0
10416	203	1109	0	0	\N	0
10417	217	1109	3	3	\N	60
10418	218	1109	3	4	\N	60
10419	219	1109	1	1	\N	20
10420	220	1109	2	4	\N	30
10421	236	1110	0	0	\N	0
10422	237	1110	0	0	\N	0
10423	238	1110	1	1	\N	20
10424	239	1110	1	1	\N	20
10425	240	1110	2	3	\N	40
10426	241	1110	1	1	\N	20
10427	242	1110	0	1	\N	0
10428	243	1110	2	3	\N	40
10429	194	1110	3	3	\N	60
10430	195	1110	0	2	\N	-10
10431	196	1110	1	1	\N	20
10432	197	1110	2	2	\N	40
10433	221	1111	4	4	\N	90
10434	222	1111	3	4	\N	60
10435	223	1111	1	1	\N	20
10436	224	1111	3	4	\N	60
10437	250	1111	2	4	\N	30
10438	251	1111	1	1	\N	20
10439	252	1111	2	3	\N	40
10440	253	1111	4	5	\N	80
10441	210	1111	3	3	\N	60
10442	211	1111	1	1	\N	20
10443	212	1111	2	3	\N	40
10444	233	1112	4	5	\N	80
10445	234	1112	0	2	\N	-10
10446	235	1112	0	0	\N	0
10447	207	1112	0	0	\N	0
10448	208	1112	2	2	\N	40
10449	209	1112	1	1	\N	20
10450	254	1112	0	1	\N	0
10451	255	1112	2	3	\N	40
10452	256	1112	4	5	\N	80
10453	213	1113	2	4	\N	30
10454	214	1113	1	1	\N	20
10455	215	1113	3	5	\N	50
10456	216	1113	0	0	\N	0
10457	191	1113	3	4	\N	60
10458	192	1113	0	0	\N	0
10459	193	1113	3	4	\N	60
10460	247	1113	3	3	\N	60
10461	248	1113	1	1	\N	20
10462	249	1113	1	1	\N	20
10463	229	1114	4	5	\N	80
10464	230	1114	2	2	\N	40
10465	231	1114	3	3	\N	60
10466	232	1114	3	3	\N	60
10467	225	1114	2	4	\N	30
10468	226	1114	2	3	\N	40
10469	227	1114	2	2	\N	40
10470	228	1114	4	4	\N	90
10471	198	1114	1	2	\N	20
10472	199	1114	2	2	\N	40
10473	200	1114	1	1	\N	20
10474	204	1115	3	4	\N	60
10475	205	1115	2	3	\N	40
10476	206	1115	1	1	\N	20
10477	188	1115	4	4	\N	90
10478	189	1115	1	1	\N	20
10479	190	1115	2	2	\N	40
10480	201	1115	1	3	\N	10
10481	202	1115	2	2	\N	40
10482	203	1115	0	1	\N	0
10483	233	1116	0	1	\N	0
10484	234	1116	3	4	\N	60
10485	235	1116	3	3	\N	60
10486	254	1116	3	3	\N	60
10487	255	1116	0	2	\N	-10
10488	256	1116	3	3	\N	60
10489	221	1116	4	5	\N	80
10490	222	1116	0	2	\N	-10
10491	223	1116	0	1	\N	0
10492	224	1116	4	5	\N	80
10493	194	1117	4	4	\N	90
10494	195	1117	3	3	\N	60
10495	196	1117	1	2	\N	20
10496	197	1117	0	0	\N	0
10497	244	1117	4	5	\N	80
10498	245	1117	0	0	\N	0
10499	246	1117	0	2	\N	-10
10500	191	1117	4	4	\N	90
10501	192	1117	1	2	\N	20
10502	193	1117	1	1	\N	20
10503	210	1118	4	6	\N	70
10504	211	1118	1	2	\N	20
10505	212	1118	1	1	\N	20
10506	229	1118	4	5	\N	80
10507	230	1118	2	4	\N	30
10508	231	1118	4	5	\N	80
10509	232	1118	1	1	\N	20
10510	250	1118	4	5	\N	80
10511	251	1118	2	2	\N	40
10512	252	1118	4	4	\N	90
10513	253	1118	0	0	\N	0
10514	225	1119	3	3	\N	60
10515	226	1119	0	0	\N	0
10516	227	1119	3	3	\N	60
10517	228	1119	2	2	\N	40
10518	247	1119	0	1	\N	0
10519	248	1119	0	0	\N	0
10520	249	1119	3	3	\N	60
10521	217	1119	3	3	\N	60
10522	218	1119	1	1	\N	20
10523	219	1119	3	5	\N	50
10524	220	1119	4	5	\N	80
10525	207	1120	2	2	\N	40
10526	208	1120	1	1	\N	20
10527	209	1120	0	1	\N	0
10528	204	1120	1	1	\N	20
10529	205	1120	2	3	\N	40
10530	206	1120	2	2	\N	40
10531	240	1120	3	4	\N	60
10532	241	1120	1	1	\N	20
10533	242	1120	0	0	\N	0
10534	243	1120	0	1	\N	0
10535	213	1121	4	5	\N	80
10536	214	1121	0	0	\N	0
10537	215	1121	0	0	\N	0
10538	216	1121	4	6	\N	70
10539	198	1121	1	1	\N	20
10540	199	1121	2	2	\N	40
10541	200	1121	1	1	\N	20
10542	236	1121	3	5	\N	50
10543	237	1121	0	0	\N	0
10544	238	1121	1	1	\N	20
10545	239	1121	1	2	\N	20
10546	198	1122	4	4	\N	90
10547	199	1122	1	2	\N	20
10548	200	1122	2	2	\N	40
10549	213	1122	0	1	\N	0
10550	214	1122	1	1	\N	20
10551	215	1122	0	0	\N	0
10552	216	1122	0	1	\N	0
10553	233	1122	2	3	\N	40
10554	234	1122	1	1	\N	20
10555	235	1122	2	2	\N	40
10556	225	1123	4	4	\N	90
10557	226	1123	0	0	\N	0
10558	227	1123	0	1	\N	0
10559	228	1123	1	3	\N	10
10560	250	1123	2	4	\N	30
10561	251	1123	2	3	\N	40
10562	252	1123	2	2	\N	40
10563	253	1123	2	2	\N	40
10564	210	1123	4	5	\N	80
10565	211	1123	1	2	\N	20
10566	212	1123	3	3	\N	60
10567	191	1124	1	3	\N	10
10568	192	1124	0	0	\N	0
10569	193	1124	2	2	\N	40
10570	217	1124	3	4	\N	60
10571	218	1124	4	4	\N	90
10572	219	1124	3	4	\N	60
10573	220	1124	2	2	\N	40
10574	221	1124	2	3	\N	40
10575	222	1124	2	2	\N	40
10576	223	1124	0	0	\N	0
10577	224	1124	1	3	\N	10
10578	254	1125	4	5	\N	80
10579	255	1125	3	5	\N	50
10580	256	1125	1	3	\N	10
10581	244	1125	3	4	\N	60
10582	245	1125	2	3	\N	40
10583	246	1125	0	0	\N	0
10584	194	1125	1	2	\N	20
10585	195	1125	1	2	\N	20
10586	196	1125	3	3	\N	60
10587	197	1125	2	3	\N	40
10588	240	1126	4	4	\N	90
10589	241	1126	2	2	\N	40
10590	242	1126	0	0	\N	0
10591	243	1126	2	2	\N	40
10592	229	1126	1	3	\N	10
10593	230	1126	2	2	\N	40
10594	231	1126	1	2	\N	20
10595	232	1126	2	2	\N	40
10596	247	1126	1	4	\N	0
10597	248	1126	1	1	\N	20
10598	249	1126	2	2	\N	40
10599	188	1127	4	4	\N	90
10600	189	1127	2	3	\N	40
10601	190	1127	4	4	\N	90
10602	236	1127	3	3	\N	60
10603	237	1127	2	3	\N	40
10604	238	1127	1	1	\N	20
10605	239	1127	0	0	\N	0
10606	207	1127	4	4	\N	90
10607	208	1127	2	2	\N	40
10608	209	1127	2	2	\N	40
10609	204	1128	4	5	\N	80
10610	205	1128	3	3	\N	60
10611	206	1128	2	3	\N	40
10612	201	1128	0	2	\N	-10
10613	202	1128	0	0	\N	0
10614	203	1128	1	1	\N	20
10615	207	1128	2	2	\N	40
10616	208	1128	1	1	\N	20
10617	209	1128	4	4	\N	90
10618	213	1129	3	3	\N	60
10619	214	1129	1	1	\N	20
10620	215	1129	1	3	\N	10
10621	216	1129	1	2	\N	20
10622	191	1129	4	4	\N	90
10623	192	1129	3	4	\N	60
10624	193	1129	2	2	\N	40
10625	217	1129	4	4	\N	90
10626	218	1129	3	5	\N	50
10627	219	1129	3	3	\N	60
10628	220	1129	3	3	\N	60
10629	194	1130	4	5	\N	80
10630	195	1130	4	5	\N	80
10631	196	1130	0	0	\N	0
10632	197	1130	0	0	\N	0
10633	236	1130	3	3	\N	60
10634	237	1130	1	1	\N	20
10635	238	1130	1	1	\N	20
10636	239	1130	2	2	\N	40
10637	210	1130	4	4	\N	90
10638	211	1130	1	1	\N	20
10639	212	1130	0	0	\N	0
10640	229	1131	3	6	\N	40
10641	230	1131	1	1	\N	20
10642	231	1131	1	1	\N	20
10643	232	1131	2	3	\N	40
10644	201	1131	1	2	\N	20
10645	202	1131	3	4	\N	60
10646	203	1131	1	1	\N	20
10647	250	1131	3	3	\N	60
10648	251	1131	1	2	\N	20
10649	252	1131	0	2	\N	-10
10650	253	1131	0	1	\N	0
10651	204	1132	2	2	\N	40
10652	205	1132	2	4	\N	30
10653	206	1132	2	2	\N	40
10654	225	1132	3	6	\N	40
10655	226	1132	1	1	\N	20
10656	227	1132	2	2	\N	40
10657	228	1132	2	2	\N	40
10658	247	1132	1	1	\N	20
10659	248	1132	1	1	\N	20
10660	249	1132	3	4	\N	60
10661	233	1133	1	2	\N	20
10662	234	1133	1	3	\N	10
10663	235	1133	4	5	\N	80
10664	198	1133	4	6	\N	70
10665	199	1133	3	5	\N	50
10666	200	1133	2	3	\N	40
10667	254	1133	4	6	\N	70
10668	255	1133	2	2	\N	40
10669	256	1133	3	4	\N	60
10670	244	1134	1	2	\N	20
10671	245	1134	0	1	\N	0
10672	246	1134	2	2	\N	40
10673	240	1134	0	1	\N	0
10674	241	1134	2	2	\N	40
10675	242	1134	0	0	\N	0
10676	243	1134	1	2	\N	20
10677	188	1134	3	3	\N	60
10678	189	1134	2	2	\N	40
10679	190	1134	1	1	\N	20
10680	221	1135	4	5	\N	80
10681	222	1135	1	3	\N	10
10682	223	1135	2	4	\N	30
10683	224	1135	4	4	\N	90
10684	213	1135	3	4	\N	60
10685	214	1135	1	2	\N	20
10686	215	1135	0	0	\N	0
10687	216	1135	1	1	\N	20
10688	225	1135	1	1	\N	20
10689	226	1135	2	3	\N	40
10690	227	1135	1	1	\N	20
10691	228	1135	4	5	\N	80
10692	244	1136	1	3	\N	10
10693	245	1136	4	6	\N	70
10694	246	1136	0	0	\N	0
10695	204	1136	1	2	\N	20
10696	205	1136	0	0	\N	0
10697	206	1136	2	2	\N	40
10698	229	1136	4	4	\N	90
10699	230	1136	0	1	\N	0
10700	231	1136	4	4	\N	90
10701	232	1136	2	3	\N	40
10702	250	1137	3	4	\N	60
10703	251	1137	0	0	\N	0
10704	252	1137	1	1	\N	20
10705	253	1137	1	1	\N	20
10706	240	1137	2	2	\N	40
10707	241	1137	1	1	\N	20
10708	242	1137	1	1	\N	20
10709	243	1137	3	3	\N	60
10710	188	1137	4	6	\N	70
10711	189	1137	0	0	\N	0
10712	190	1137	2	3	\N	40
10713	201	1138	0	1	\N	0
10714	202	1138	0	1	\N	0
10715	203	1138	0	0	\N	0
10716	198	1138	4	5	\N	80
10717	199	1138	1	3	\N	10
10718	200	1138	3	3	\N	60
10719	247	1138	4	5	\N	80
10720	248	1138	0	2	\N	-10
10721	249	1138	3	3	\N	60
10722	236	1139	1	3	\N	10
10723	237	1139	1	3	\N	10
10724	238	1139	4	5	\N	80
10725	239	1139	0	0	\N	0
10726	254	1139	4	6	\N	70
10727	255	1139	0	2	\N	-10
10728	256	1139	1	1	\N	20
10729	217	1139	4	4	\N	90
10730	218	1139	0	0	\N	0
10731	219	1139	4	4	\N	90
10732	220	1139	1	1	\N	20
10733	210	1140	2	3	\N	40
10734	211	1140	2	2	\N	40
10735	212	1140	3	4	\N	60
10736	207	1140	2	2	\N	40
10737	208	1140	4	6	\N	70
10738	209	1140	2	2	\N	40
10739	191	1140	3	4	\N	60
10740	192	1140	2	2	\N	40
10741	193	1140	0	0	\N	0
10742	221	1141	3	3	\N	60
10743	222	1141	1	1	\N	20
10744	223	1141	1	1	\N	20
10745	224	1141	1	2	\N	20
10746	233	1141	4	6	\N	70
10747	234	1141	0	1	\N	0
10748	235	1141	0	2	\N	-10
10749	194	1141	2	2	\N	40
10750	195	1141	1	1	\N	20
10751	196	1141	0	0	\N	0
10752	197	1141	1	1	\N	20
\.


--
-- Name: student_quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('student_quizzes_id_seq', 10752, true);


--
-- Data for Name: student_teams; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY student_teams (id, student_id, team_id, is_captain, present, start_date, end_date, seat) FROM stdin;
1	1	1	t	t	2014-09-01	\N	1
4	4	2	t	t	2014-09-01	\N	1
5	5	2	f	t	2014-09-01	\N	2
6	6	2	f	t	2014-09-01	\N	3
7	7	2	f	t	2014-09-01	\N	4
8	8	3	t	t	2014-09-01	\N	1
9	9	3	f	t	2014-09-01	\N	2
10	10	3	f	t	2014-09-01	\N	3
11	11	3	f	t	2014-09-01	\N	4
12	12	4	t	t	2014-09-01	\N	1
13	13	4	f	t	2014-09-01	\N	2
14	14	4	f	t	2014-09-01	\N	3
15	15	5	t	t	2014-09-01	\N	1
16	16	5	f	t	2014-09-01	\N	2
17	17	5	f	t	2014-09-01	\N	3
18	18	5	f	t	2014-09-01	\N	4
19	19	6	t	t	2014-09-01	\N	1
20	20	6	f	t	2014-09-01	\N	2
21	21	6	f	t	2014-09-01	\N	3
22	22	7	t	t	2014-09-01	\N	1
23	23	7	f	t	2014-09-01	\N	2
24	24	7	f	t	2014-09-01	\N	3
25	25	8	t	t	2014-09-01	\N	1
26	26	8	f	t	2014-09-01	\N	2
27	27	8	f	t	2014-09-01	\N	3
28	28	16	t	t	2014-09-01	\N	1
29	29	16	f	t	2014-09-01	\N	2
30	30	16	f	t	2014-09-01	\N	3
31	31	16	f	t	2014-09-01	\N	4
32	32	16	f	t	2014-09-01	\N	5
33	33	21	t	t	2014-09-01	\N	1
34	34	21	f	t	2014-09-01	\N	2
35	35	21	f	t	2014-09-01	\N	3
36	36	21	f	t	2014-09-01	\N	4
37	37	25	t	t	2014-09-01	\N	1
38	38	25	f	t	2014-09-01	\N	2
39	39	25	f	t	2014-09-01	\N	3
40	40	25	f	t	2014-09-01	\N	4
41	41	25	f	t	2014-09-01	\N	5
42	42	26	t	t	2014-09-01	\N	1
43	43	26	f	t	2014-09-01	\N	2
44	44	26	f	t	2014-09-01	\N	3
45	45	31	t	t	2014-09-01	\N	1
46	46	31	f	t	2014-09-01	\N	2
47	47	31	f	t	2014-09-01	\N	3
48	48	32	t	t	2014-09-01	\N	1
49	49	32	f	t	2014-09-01	\N	2
50	50	32	f	t	2014-09-01	\N	3
51	51	37	t	t	2014-09-01	\N	1
52	52	37	f	t	2014-09-01	\N	2
53	53	37	f	t	2014-09-01	\N	3
54	54	38	t	t	2014-09-01	\N	1
55	55	38	f	t	2014-09-01	\N	2
56	56	38	f	t	2014-09-01	\N	3
57	57	38	f	t	2014-09-01	\N	4
58	58	50	t	t	2014-09-01	\N	1
59	59	50	f	t	2014-09-01	\N	2
60	60	50	f	t	2014-09-01	\N	3
61	61	50	f	t	2014-09-01	\N	4
62	62	51	t	t	2014-09-01	\N	1
63	63	51	f	t	2014-09-01	\N	2
64	64	51	f	t	2014-09-01	\N	3
65	65	56	t	t	2014-09-01	\N	1
66	66	56	f	t	2014-09-01	\N	2
67	67	56	f	t	2014-09-01	\N	3
68	68	56	f	t	2014-09-01	\N	4
69	69	67	t	t	2014-09-01	\N	1
70	70	67	f	t	2014-09-01	\N	2
71	71	67	f	t	2014-09-01	\N	3
72	72	68	t	t	2014-09-01	\N	1
73	73	68	f	t	2014-09-01	\N	2
74	74	68	f	t	2014-09-01	\N	3
75	75	68	f	t	2014-09-01	\N	4
76	76	62	t	t	2014-09-01	\N	1
77	77	62	f	t	2014-09-01	\N	2
78	78	62	f	t	2014-09-01	\N	3
79	79	62	f	t	2014-09-01	\N	4
80	80	44	t	t	2014-09-01	\N	1
81	81	44	f	t	2014-09-01	\N	2
82	82	44	f	t	2014-09-01	\N	3
83	83	45	t	t	2014-09-01	\N	1
84	84	45	f	t	2014-09-01	\N	2
85	85	45	f	t	2014-09-01	\N	3
86	86	46	t	t	2014-09-01	\N	1
87	87	46	f	t	2014-09-01	\N	2
88	88	46	f	t	2014-09-01	\N	3
89	89	71	t	t	2014-09-01	\N	1
90	90	71	f	t	2014-09-01	\N	2
91	91	71	f	t	2014-09-01	\N	3
92	92	74	t	t	2014-09-01	\N	1
93	93	74	f	t	2014-09-01	\N	2
94	94	74	f	t	2014-09-01	\N	3
95	95	74	f	t	2014-09-01	\N	4
96	96	77	t	t	2014-09-01	\N	1
97	97	77	f	t	2014-09-01	\N	2
98	98	77	f	t	2014-09-01	\N	3
99	99	77	f	t	2014-09-01	\N	4
100	100	78	t	t	2014-09-01	\N	1
101	101	78	f	t	2014-09-01	\N	2
102	102	78	f	t	2014-09-01	\N	3
103	103	78	f	t	2014-09-01	\N	4
104	104	9	t	t	2014-09-01	\N	1
106	106	10	f	t	2014-09-01	\N	2
107	107	11	t	t	2014-09-01	\N	1
108	108	11	f	t	2014-09-01	\N	2
109	109	11	f	t	2014-09-01	\N	3
110	110	11	f	t	2014-09-01	\N	4
111	111	12	t	t	2014-09-01	\N	1
112	112	12	f	t	2014-09-01	\N	2
113	113	12	f	t	2014-09-01	\N	3
114	114	13	t	t	2014-09-01	\N	1
115	115	13	f	t	2014-09-01	\N	2
116	116	13	f	t	2014-09-01	\N	3
117	117	17	t	t	2014-09-01	\N	1
118	118	17	f	t	2014-09-01	\N	2
119	119	18	t	t	2014-09-01	\N	1
120	120	18	f	t	2014-09-01	\N	2
121	121	18	f	t	2014-09-01	\N	3
122	122	18	f	t	2014-09-01	\N	4
123	123	22	t	t	2014-09-01	\N	1
124	124	22	f	t	2014-09-01	\N	2
125	125	23	t	t	2014-09-01	\N	1
126	126	23	f	t	2014-09-01	\N	2
127	127	23	f	t	2014-09-01	\N	3
128	128	27	t	t	2014-09-01	\N	1
129	129	27	f	t	2014-09-01	\N	2
130	130	28	t	t	2014-09-01	\N	1
131	131	28	f	t	2014-09-01	\N	2
132	132	28	f	t	2014-09-01	\N	3
133	133	28	f	t	2014-09-01	\N	4
134	134	29	t	t	2014-09-01	\N	1
135	135	29	f	t	2014-09-01	\N	2
136	136	29	f	t	2014-09-01	\N	3
137	137	29	f	t	2014-09-01	\N	4
138	138	33	t	t	2014-09-01	\N	1
139	139	33	f	t	2014-09-01	\N	2
140	140	33	f	t	2014-09-01	\N	3
141	141	34	t	t	2014-09-01	\N	1
142	142	34	f	t	2014-09-01	\N	2
143	143	39	t	t	2014-09-01	\N	1
144	144	39	f	t	2014-09-01	\N	2
145	145	39	f	t	2014-09-01	\N	3
146	146	40	t	t	2014-09-01	\N	1
147	147	41	t	t	2014-09-01	\N	1
148	148	41	f	t	2014-09-01	\N	2
149	149	52	t	t	2014-09-01	\N	1
150	150	52	f	t	2014-09-01	\N	2
151	151	52	f	t	2014-09-01	\N	3
152	152	52	f	t	2014-09-01	\N	4
153	153	53	t	t	2014-09-01	\N	1
154	154	53	f	t	2014-09-01	\N	2
155	155	54	t	t	2014-09-01	\N	1
156	156	54	f	t	2014-09-01	\N	2
157	157	54	f	t	2014-09-01	\N	3
105	105	10	t	t	2014-09-01	\N	1
158	158	57	t	t	2014-09-01	\N	1
159	159	57	f	t	2014-09-01	\N	2
160	160	57	f	t	2014-09-01	\N	3
161	161	58	t	t	2014-09-01	\N	1
162	162	58	f	t	2014-09-01	\N	2
163	163	58	f	t	2014-09-01	\N	3
164	164	59	t	t	2014-09-01	\N	1
165	165	59	f	t	2014-09-01	\N	2
166	166	59	f	t	2014-09-01	\N	3
167	167	69	t	t	2014-09-01	\N	1
168	168	69	f	t	2014-09-01	\N	2
169	169	63	t	t	2014-09-01	\N	1
170	170	63	f	t	2014-09-01	\N	2
171	171	63	f	t	2014-09-01	\N	3
172	172	64	t	t	2014-09-01	\N	1
173	173	64	f	t	2014-09-01	\N	2
174	174	64	f	t	2014-09-01	\N	3
175	175	64	f	t	2014-09-01	\N	4
176	176	65	t	t	2014-09-01	\N	1
177	177	65	f	t	2014-09-01	\N	2
178	178	65	f	t	2014-09-01	\N	3
179	179	65	f	t	2014-09-01	\N	4
180	180	47	t	t	2014-09-01	\N	1
181	181	47	f	t	2014-09-01	\N	2
182	182	72	t	t	2014-09-01	\N	1
183	183	72	f	t	2014-09-01	\N	2
184	184	75	t	t	2014-09-01	\N	1
185	185	79	t	t	2014-09-01	\N	1
186	186	79	f	t	2014-09-01	\N	2
187	187	79	f	t	2014-09-01	\N	3
188	188	14	t	t	2014-09-01	\N	1
190	190	14	f	t	2014-09-01	\N	3
191	191	15	t	t	2014-09-01	\N	1
192	192	15	f	t	2014-09-01	\N	2
193	193	15	f	t	2014-09-01	\N	3
194	194	19	t	t	2014-09-01	\N	1
195	195	19	f	t	2014-09-01	\N	2
196	196	19	f	t	2014-09-01	\N	3
197	197	19	f	t	2014-09-01	\N	4
198	198	20	t	t	2014-09-01	\N	1
199	199	20	f	t	2014-09-01	\N	2
200	200	20	f	t	2014-09-01	\N	3
201	201	24	t	t	2014-09-01	\N	1
202	202	24	f	t	2014-09-01	\N	2
203	203	24	f	t	2014-09-01	\N	3
204	204	30	t	t	2014-09-01	\N	1
205	205	30	f	t	2014-09-01	\N	2
206	206	30	f	t	2014-09-01	\N	3
207	207	35	t	t	2014-09-01	\N	1
208	208	35	f	t	2014-09-01	\N	2
209	209	35	f	t	2014-09-01	\N	3
210	210	36	t	t	2014-09-01	\N	1
211	211	36	f	t	2014-09-01	\N	2
212	212	36	f	t	2014-09-01	\N	3
213	213	42	t	t	2014-09-01	\N	1
214	214	42	f	t	2014-09-01	\N	2
215	215	42	f	t	2014-09-01	\N	3
216	216	42	f	t	2014-09-01	\N	4
217	217	43	t	t	2014-09-01	\N	1
218	218	43	f	t	2014-09-01	\N	2
219	219	43	f	t	2014-09-01	\N	3
220	220	43	f	t	2014-09-01	\N	4
221	221	55	t	t	2014-09-01	\N	1
222	222	55	f	t	2014-09-01	\N	2
223	223	55	f	t	2014-09-01	\N	3
224	224	55	f	t	2014-09-01	\N	4
225	225	60	t	t	2014-09-01	\N	1
226	226	60	f	t	2014-09-01	\N	2
227	227	60	f	t	2014-09-01	\N	3
228	228	60	f	t	2014-09-01	\N	4
229	229	61	t	t	2014-09-01	\N	1
230	230	61	f	t	2014-09-01	\N	2
231	231	61	f	t	2014-09-01	\N	3
232	232	61	f	t	2014-09-01	\N	4
233	233	70	t	t	2014-09-01	\N	1
234	234	70	f	t	2014-09-01	\N	2
235	235	70	f	t	2014-09-01	\N	3
236	236	66	t	t	2014-09-01	\N	1
237	237	66	f	t	2014-09-01	\N	2
238	238	66	f	t	2014-09-01	\N	3
239	239	66	f	t	2014-09-01	\N	4
240	240	48	t	t	2014-09-01	\N	1
241	241	48	f	t	2014-09-01	\N	2
242	242	48	f	t	2014-09-01	\N	3
243	243	48	f	t	2014-09-01	\N	4
244	244	49	t	t	2014-09-01	\N	1
245	245	49	f	t	2014-09-01	\N	2
246	246	49	f	t	2014-09-01	\N	3
247	247	73	t	t	2014-09-01	\N	1
248	248	73	f	t	2014-09-01	\N	2
249	249	73	f	t	2014-09-01	\N	3
250	250	76	t	t	2014-09-01	\N	1
251	251	76	f	t	2014-09-01	\N	2
252	252	76	f	t	2014-09-01	\N	3
253	253	76	f	t	2014-09-01	\N	4
254	254	80	t	t	2014-09-01	\N	1
255	255	80	f	t	2014-09-01	\N	2
256	256	80	f	t	2014-09-01	\N	3
3	3	1	f	t	2014-09-01	\N	3
2	2	1	f	t	2014-09-01	\N	2
189	189	14	f	t	2014-09-01	\N	2
\.


--
-- Name: student_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('student_teams_id_seq', 256, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY students (id, first_name, last_name, grade, active) FROM stdin;
1	Rolando	Lebsack	3	t
2	Kamryn	Anderson	5	t
3	Gerda	Mann	3	t
4	Maynard	Morissette	5	t
5	Wilford	Rolfson	6	t
6	Maxime	O'Conner	5	t
7	Teresa	Mayer	5	t
8	Karelle	Rippin	4	t
9	Dave	Aufderhar	4	t
10	Alexys	Witting	3	t
11	Hilma	Koepp	4	t
12	Kara	Stroman	6	t
13	Keith	McDermott	4	t
14	Arnoldo	Towne	6	t
15	Tyrique	Roberts	3	t
16	Joey	Spencer	3	t
17	Gianni	Schimmel	5	t
18	Milo	Lesch	5	t
19	Dane	Quitzon	6	t
20	Hope	Ledner	4	t
21	Adele	McKenzie	5	t
22	Marlene	Wolff	5	t
23	Valentine	Zulauf	3	t
24	Maxine	Hand	5	t
25	Hal	Funk	4	t
26	Brannon	Bogisich	3	t
27	Tia	Nolan	6	t
28	Cleveland	Huels	6	t
29	Zetta	Ziemann	6	t
30	Dayana	Tremblay	6	t
31	Skye	Dooley	5	t
32	Marcus	Rutherford	6	t
33	Crystel	Carter	3	t
34	Dorothea	Bailey	3	t
35	Mona	Pacocha	4	t
36	Olga	Volkman	3	t
37	Magdalena	Wintheiser	3	t
38	Cathy	McCullough	6	t
39	Lourdes	Willms	5	t
40	Isabell	Walsh	4	t
41	Garrison	Reichert	6	t
42	Vicente	Koelpin	6	t
43	Brian	Murphy	5	t
44	Kristy	Durgan	6	t
45	Adrienne	Murray	5	t
46	Nat	Kerluke	6	t
47	Vince	O'Keefe	6	t
48	Alan	Stehr	5	t
49	Stacy	Frami	5	t
50	Marion	Weber	4	t
51	Rosario	Hettinger	5	t
52	Destinee	Abshire	5	t
53	Shyann	Zemlak	6	t
54	Rosendo	Kertzmann	3	t
55	Camden	Hahn	5	t
56	Assunta	Halvorson	5	t
57	Carolina	Quitzon	5	t
58	Shanny	McClure	4	t
59	Bria	Bruen	5	t
60	Arturo	Christiansen	5	t
61	Marcelina	Schulist	6	t
62	Taurean	Balistreri	5	t
63	Ottis	Crist	4	t
64	Ewell	Stanton	5	t
65	Carrie	Wyman	4	t
66	Elyse	Hartmann	3	t
67	Bud	Hills	5	t
68	Fernando	Lueilwitz	6	t
69	Loren	Grady	4	t
70	Janie	Grant	3	t
71	Jovani	Murazik	5	t
72	Kirsten	Borer	4	t
73	Esperanza	Greenfelder	4	t
74	Alessandro	McDermott	5	t
75	Yvonne	Weissnat	3	t
76	Otto	Medhurst	5	t
77	Fanny	Wolf	4	t
78	Cristobal	Treutel	3	t
79	Meda	Pouros	6	t
80	Nora	Graham	3	t
81	Brook	Mayer	4	t
82	Derrick	Skiles	6	t
83	Meggie	Collier	5	t
84	Audra	Ankunding	4	t
85	Adelle	DuBuque	5	t
86	Helene	Bashirian	6	t
87	Ottilie	Friesen	5	t
88	Keaton	Kunde	5	t
89	Eda	Nader	5	t
90	Richmond	Spencer	5	t
91	Marilou	Purdy	3	t
92	Myrl	Schuppe	5	t
93	Kian	Gibson	5	t
94	Gussie	Dickens	4	t
95	Kelli	Little	5	t
96	Gilberto	Auer	5	t
97	Palma	Sauer	6	t
98	Claudine	O'Connell	3	t
99	Augustus	Lubowitz	5	t
100	Sabrina	Fahey	3	t
101	Bryce	Schowalter	6	t
102	Emma	Reynolds	4	t
103	Else	O'Hara	6	t
104	Orlo	Kshlerin	11	t
105	Emile	Schinner	9	t
106	Mariam	Ankunding	11	t
107	Reynold	Ziemann	12	t
108	Martina	Vandervort	10	t
109	Johathan	Prohaska	10	t
110	Christine	Waelchi	9	t
111	Alexandria	Howell	10	t
112	Vada	Daniel	9	t
113	Katherine	Gottlieb	12	t
114	Horacio	Auer	7	t
115	Adolf	Rau	12	t
116	Tremaine	Hagenes	7	t
117	Dina	Reichert	7	t
118	Garry	Koch	11	t
119	Kendall	Mraz	11	t
120	Jacynthe	Olson	9	t
121	Bertram	Nikolaus	8	t
122	Jaleel	Cassin	10	t
123	Alessia	Kuphal	7	t
124	Orville	Bartell	12	t
125	Jake	Botsford	11	t
126	Kade	Lesch	9	t
127	Jayson	Gerlach	10	t
128	Christophe	Walsh	11	t
129	Ola	Lang	8	t
130	Carmel	Zieme	7	t
131	Keenan	Yundt	11	t
132	Sarina	Klocko	10	t
133	Felipe	Jast	8	t
134	Elinore	Larkin	9	t
135	Jonathan	Donnelly	7	t
136	Noel	Toy	9	t
137	Nadia	Kautzer	10	t
138	Domenica	Weissnat	10	t
139	Anika	O'Hara	12	t
140	Willy	Dickens	8	t
141	Destin	Boehm	7	t
142	Peter	Hyatt	9	t
143	Lulu	Gislason	12	t
144	Rashawn	Gislason	11	t
145	Theresia	Kertzmann	7	t
146	Roscoe	Ward	8	t
147	Eusebio	Lebsack	12	t
148	Carley	Oberbrunner	8	t
149	Unique	Daniel	8	t
150	Anabel	Huels	11	t
151	Karson	Price	10	t
152	Shaniya	Johnston	9	t
153	Hope	Schaden	10	t
154	Beulah	Gorczany	12	t
155	Tyrese	Ortiz	9	t
156	Tre	Botsford	12	t
157	Meghan	Kohler	7	t
158	Kyle	Becker	12	t
159	Rowena	Grant	8	t
160	Florencio	Lesch	8	t
161	Stella	Reinger	11	t
162	Edgardo	Zulauf	10	t
163	Akeem	Moore	8	t
164	Esther	Veum	9	t
165	Elton	Fritsch	10	t
166	Boyd	Batz	11	t
167	Creola	Von	10	t
168	Ayden	Heidenreich	9	t
169	Dolores	Roob	10	t
170	Zoey	Carter	12	t
171	Salvador	Kling	8	t
172	Mertie	Kertzmann	11	t
173	Dayton	Hackett	7	t
174	Olaf	Rosenbaum	8	t
175	Nathanial	Metz	7	t
176	Carmela	Bosco	11	t
177	Paige	Schuster	7	t
178	Jared	O'Hara	9	t
179	Angelo	Osinski	8	t
180	Helena	Zulauf	8	t
181	Trudie	Wiegand	10	t
182	Oswaldo	Wolf	10	t
183	Rolando	Will	8	t
184	Tillman	Reichel	10	t
185	Marcelina	Metz	10	t
186	Vesta	Hagenes	10	t
187	Chad	Orn	10	t
188	Felipe	MacGyver	10	t
189	Arvilla	Heathcote	10	t
190	Isabelle	Wyman	12	t
191	Hunter	Hermann	10	t
192	Reed	Bednar	10	t
193	Albin	Crooks	10	t
194	Beth	Brakus	10	t
195	Ubaldo	Balistreri	8	t
196	Candace	Corwin	10	t
197	Dave	Hoppe	9	t
198	Sheila	Wisoky	12	t
199	Norbert	Kovacek	10	t
200	Valerie	Lemke	7	t
201	Barbara	Hilpert	10	t
202	Belle	Langosh	8	t
203	Jasen	Koepp	12	t
204	Freddy	Kilback	7	t
205	Modesta	Abbott	12	t
206	Gabriella	Kovacek	9	t
207	Jonatan	Monahan	8	t
208	Jovany	Senger	10	t
209	Ed	Spinka	11	t
210	Elsa	Hand	11	t
211	Rocky	Dibbert	8	t
212	Enid	Bartell	11	t
213	Eugenia	Schiller	10	t
214	Dashawn	Johnston	7	t
215	Irma	Littel	9	t
216	Henri	Kunde	7	t
217	Leonor	Mitchell	10	t
218	Jordy	Murray	9	t
219	Herminio	Kertzmann	7	t
220	Roselyn	Gutkowski	10	t
221	Sydnee	Simonis	9	t
222	Lysanne	Donnelly	7	t
223	Herminio	Gulgowski	12	t
224	Eleanora	Hessel	7	t
225	Tre	Reilly	8	t
226	Myrl	Mraz	8	t
227	Erna	Huels	11	t
228	Isac	Eichmann	9	t
229	Cassandre	Lowe	10	t
230	Bill	Sporer	8	t
231	Marina	Sawayn	7	t
232	Magnus	Becker	12	t
233	Lincoln	Homenick	11	t
234	Rico	Crist	12	t
235	Alden	Witting	11	t
236	Jasen	Feil	11	t
237	Marietta	Johnston	10	t
238	Serena	Cormier	10	t
239	Estefania	Tromp	8	t
240	Domenico	Lind	11	t
241	Emilie	Bauch	10	t
242	Rebeca	Flatley	8	t
243	Karlee	Conroy	8	t
244	Angel	Waters	10	t
245	Kaylee	Adams	9	t
246	Ezequiel	Von	8	t
247	Damion	Buckridge	9	t
248	Danyka	Bogisich	7	t
249	Isabella	Bosco	12	t
250	Stephany	Rodriguez	8	t
251	Amber	Hegmann	7	t
252	Walter	Gottlieb	12	t
253	Shayna	Dare	9	t
254	Cassandra	Nicolas	9	t
255	Teresa	Feest	12	t
256	Hillard	Medhurst	9	t
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('students_id_seq', 256, true);


--
-- Data for Name: team_coaches; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY team_coaches (id, team_id, coach_id, start_date, end_date) FROM stdin;
\.


--
-- Name: team_coaches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('team_coaches_id_seq', 1, false);


--
-- Data for Name: team_standings; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY team_standings (id, "position", team_id, division_id, total_points, accuracy, created_at, updated_at) FROM stdin;
1	1	25	1	801	0.756000000000000005	2015-06-03 16:48:20.354169	2015-06-03 16:48:20.354169
2	2	16	1	775	0.73899999999999999	2015-06-03 16:48:20.79458	2015-06-03 16:48:20.79458
3	3	21	1	716	0.754000000000000004	2015-06-03 16:48:21.216924	2015-06-03 16:48:21.216924
4	4	78	1	715	0.757000000000000006	2015-06-03 16:48:21.633711	2015-06-03 16:48:21.633711
5	5	3	1	700	0.745999999999999996	2015-06-03 16:48:22.052262	2015-06-03 16:48:22.052262
6	6	2	1	684	0.759000000000000008	2015-06-03 16:48:22.421821	2015-06-03 16:48:22.421821
7	7	74	1	676	0.740999999999999992	2015-06-03 16:48:22.837913	2015-06-03 16:48:22.837913
8	8	77	1	667	0.716999999999999971	2015-06-03 16:48:23.252863	2015-06-03 16:48:23.252863
9	9	68	1	660	0.758000000000000007	2015-06-03 16:48:23.612905	2015-06-03 16:48:23.612905
10	10	38	1	640	0.688999999999999946	2015-06-03 16:48:24.028656	2015-06-03 16:48:24.028656
11	11	62	1	637	0.721999999999999975	2015-06-03 16:48:24.446438	2015-06-03 16:48:24.446438
12	12	46	1	635	0.73899999999999999	2015-06-03 16:48:24.725907	2015-06-03 16:48:24.725907
13	13	56	1	624	0.709999999999999964	2015-06-03 16:48:25.136511	2015-06-03 16:48:25.136511
14	14	6	1	624	0.789000000000000035	2015-06-03 16:48:25.46857	2015-06-03 16:48:25.46857
15	15	5	1	623	0.747999999999999998	2015-06-03 16:48:25.819754	2015-06-03 16:48:25.819754
16	16	50	1	604	0.734999999999999987	2015-06-03 16:48:26.234493	2015-06-03 16:48:26.234493
17	17	71	1	578	0.724999999999999978	2015-06-03 16:48:26.501997	2015-06-03 16:48:26.501997
18	18	67	1	565	0.734999999999999987	2015-06-03 16:48:26.835474	2015-06-03 16:48:26.835474
19	19	31	1	562	0.694999999999999951	2015-06-03 16:48:27.164988	2015-06-03 16:48:27.164988
20	20	44	1	561	0.71599999999999997	2015-06-03 16:48:27.437393	2015-06-03 16:48:27.437393
21	21	1	1	559	0.741999999999999993	2015-06-03 16:48:27.764467	2015-06-03 16:48:27.764467
22	22	7	1	557	0.764000000000000012	2015-06-03 16:48:28.032511	2015-06-03 16:48:28.032511
23	23	32	1	556	0.722999999999999976	2015-06-03 16:48:28.362606	2015-06-03 16:48:28.362606
24	24	4	1	555	0.763000000000000012	2015-06-03 16:48:28.634759	2015-06-03 16:48:28.634759
25	25	51	1	554	0.69399999999999995	2015-06-03 16:48:28.959643	2015-06-03 16:48:28.959643
26	26	8	1	553	0.760000000000000009	2015-06-03 16:48:29.220742	2015-06-03 16:48:29.220742
27	27	26	1	538	0.744999999999999996	2015-06-03 16:48:29.547372	2015-06-03 16:48:29.547372
28	28	45	1	523	0.709999999999999964	2015-06-03 16:48:29.820487	2015-06-03 16:48:29.820487
29	29	37	1	493	0.656000000000000028	2015-06-03 16:48:30.147351	2015-06-03 16:48:30.147351
30	1	65	2	726	0.747999999999999998	2015-06-03 16:48:34.057613	2015-06-03 16:48:34.057613
31	2	28	2	692	0.730999999999999983	2015-06-03 16:48:34.411267	2015-06-03 16:48:34.411267
32	3	52	2	670	0.728999999999999981	2015-06-03 16:48:34.829121	2015-06-03 16:48:34.829121
33	4	64	2	660	0.724999999999999978	2015-06-03 16:48:35.254986	2015-06-03 16:48:35.254986
34	5	18	2	654	0.723999999999999977	2015-06-03 16:48:35.609095	2015-06-03 16:48:35.609095
35	6	29	2	635	0.748999999999999999	2015-06-03 16:48:36.033684	2015-06-03 16:48:36.033684
36	7	11	2	630	0.717999999999999972	2015-06-03 16:48:36.459295	2015-06-03 16:48:36.459295
37	8	57	2	603	0.740999999999999992	2015-06-03 16:48:36.736729	2015-06-03 16:48:36.736729
38	9	63	2	576	0.764000000000000012	2015-06-03 16:48:37.064976	2015-06-03 16:48:37.064976
39	10	79	2	572	0.73899999999999999	2015-06-03 16:48:37.403487	2015-06-03 16:48:37.403487
40	11	39	2	569	0.72699999999999998	2015-06-03 16:48:37.683404	2015-06-03 16:48:37.683404
41	12	13	2	555	0.734999999999999987	2015-06-03 16:48:38.009803	2015-06-03 16:48:38.009803
42	13	54	2	554	0.754000000000000004	2015-06-03 16:48:38.282914	2015-06-03 16:48:38.282914
43	14	33	2	546	0.707999999999999963	2015-06-03 16:48:38.610571	2015-06-03 16:48:38.610571
44	15	12	2	542	0.728999999999999981	2015-06-03 16:48:38.881753	2015-06-03 16:48:38.881753
45	16	23	2	541	0.702999999999999958	2015-06-03 16:48:39.209576	2015-06-03 16:48:39.209576
46	17	59	2	538	0.709999999999999964	2015-06-03 16:48:39.48457	2015-06-03 16:48:39.48457
47	18	58	2	524	0.71599999999999997	2015-06-03 16:48:39.818395	2015-06-03 16:48:39.818395
48	19	72	2	484	0.754000000000000004	2015-06-03 16:48:40.004834	2015-06-03 16:48:40.004834
49	20	34	2	466	0.731999999999999984	2015-06-03 16:48:40.247555	2015-06-03 16:48:40.247555
50	21	69	2	461	0.746999999999999997	2015-06-03 16:48:40.43426	2015-06-03 16:48:40.43426
51	22	27	2	450	0.714999999999999969	2015-06-03 16:48:40.621566	2015-06-03 16:48:40.621566
52	23	47	2	448	0.747999999999999998	2015-06-03 16:48:40.873138	2015-06-03 16:48:40.873138
53	24	41	2	436	0.724999999999999978	2015-06-03 16:48:41.055109	2015-06-03 16:48:41.055109
54	25	17	2	433	0.697999999999999954	2015-06-03 16:48:41.238587	2015-06-03 16:48:41.238587
55	26	22	2	431	0.736999999999999988	2015-06-03 16:48:41.486827	2015-06-03 16:48:41.486827
56	27	10	2	428	0.756000000000000005	2015-06-03 16:48:41.669825	2015-06-03 16:48:41.669825
57	28	53	2	423	0.718999999999999972	2015-06-03 16:48:41.91348	2015-06-03 16:48:41.91348
58	29	75	2	344	0.776000000000000023	2015-06-03 16:48:42.014495	2015-06-03 16:48:42.014495
59	30	40	2	321	0.76100000000000001	2015-06-03 16:48:42.114871	2015-06-03 16:48:42.114871
60	31	9	2	316	0.746999999999999997	2015-06-03 16:48:42.219021	2015-06-03 16:48:42.219021
61	1	43	3	729	0.758000000000000007	2015-06-03 16:48:46.258108	2015-06-03 16:48:46.258108
62	2	19	3	725	0.753000000000000003	2015-06-03 16:48:46.682156	2015-06-03 16:48:46.682156
63	3	61	3	677	0.73899999999999999	2015-06-03 16:48:47.039537	2015-06-03 16:48:47.039537
64	4	42	3	665	0.725999999999999979	2015-06-03 16:48:47.457812	2015-06-03 16:48:47.457812
65	5	55	3	655	0.722999999999999976	2015-06-03 16:48:47.871425	2015-06-03 16:48:47.871425
66	6	60	3	654	0.751000000000000001	2015-06-03 16:48:48.227166	2015-06-03 16:48:48.227166
67	7	76	3	648	0.735999999999999988	2015-06-03 16:48:48.643669	2015-06-03 16:48:48.643669
68	8	20	3	639	0.776000000000000023	2015-06-03 16:48:48.977025	2015-06-03 16:48:48.977025
69	9	66	3	633	0.713999999999999968	2015-06-03 16:48:49.327155	2015-06-03 16:48:49.327155
70	10	80	3	593	0.708999999999999964	2015-06-03 16:48:49.663588	2015-06-03 16:48:49.663588
71	11	15	3	579	0.747999999999999998	2015-06-03 16:48:49.935588	2015-06-03 16:48:49.935588
72	12	36	3	573	0.740999999999999992	2015-06-03 16:48:50.261005	2015-06-03 16:48:50.261005
73	13	48	3	567	0.692999999999999949	2015-06-03 16:48:50.683702	2015-06-03 16:48:50.683702
74	14	35	3	561	0.788000000000000034	2015-06-03 16:48:50.964526	2015-06-03 16:48:50.964526
75	15	70	3	553	0.720999999999999974	2015-06-03 16:48:51.291986	2015-06-03 16:48:51.291986
76	16	30	3	552	0.695999999999999952	2015-06-03 16:48:51.568771	2015-06-03 16:48:51.568771
77	17	49	3	550	0.721999999999999975	2015-06-03 16:48:51.894984	2015-06-03 16:48:51.894984
78	18	14	3	549	0.79500000000000004	2015-06-03 16:48:52.172726	2015-06-03 16:48:52.172726
79	19	24	3	539	0.720999999999999974	2015-06-03 16:48:52.503998	2015-06-03 16:48:52.503998
80	20	73	3	506	0.707999999999999963	2015-06-03 16:48:52.787648	2015-06-03 16:48:52.787648
\.


--
-- Name: team_standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('team_standings_id_seq', 80, true);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: quizzing
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
15	3	1	ACAC 2	t
16	1	4	Broadway 1	t
17	2	4	Broadway 1	t
18	2	4	Broadway 2	t
19	3	4	Broadway 1	t
20	3	4	Broadway 2	t
21	1	7	Cherry Tree 1	t
22	2	7	Cherry Tree 1	t
23	2	7	Cherry Tree 2	t
24	3	7	Cherry Tree 1	t
25	1	10	Chicora 1	t
26	1	10	Chicora 2	t
27	2	10	Chicora 1	t
28	2	10	Chicora 2	t
29	2	10	Chicora 3	t
30	3	10	Chicora 1	t
31	1	3	Dorseyville 1	t
32	1	3	Dorseyville 2	t
33	2	3	Dorseyville 1	t
34	2	3	Dorseyville 2	t
35	3	3	Dorseyville 1	t
36	3	3	Dorseyville 2	t
37	1	16	Elkins 1	t
38	1	16	Elkins 2	t
39	2	16	Elkins 1	t
40	2	16	Elkins 2	t
41	2	16	Elkins 3	t
42	3	16	Elkins 1	t
43	3	16	Elkins 2	t
44	1	17	New Castle 1	t
45	1	17	New Castle 2	t
46	1	17	New Castle 3	t
47	2	17	New Castle 1	t
48	3	17	New Castle 1	t
49	3	17	New Castle 2	t
50	1	13	Greensburg 1	t
51	1	13	Greensburg 2	t
52	2	13	Greensburg 1	t
53	2	13	Greensburg 2	t
54	2	13	Greensburg 3	t
55	3	13	Greensburg 1	t
56	1	6	Indiana 1	t
57	2	6	Indiana 1	t
58	2	6	Indiana 2	t
59	2	6	Indiana 3	t
60	3	6	Indiana 1	t
61	3	6	Indiana 2	t
62	1	15	McKeesport 1	t
63	2	15	McKeesport 1	t
64	2	15	McKeesport 2	t
65	2	15	McKeesport 3	t
66	3	15	McKeesport 1	t
67	1	5	MAC 1	t
68	1	5	MAC 2	t
69	2	5	MAC 1	t
70	3	5	MAC 1	t
71	1	11	Norwin 1	t
72	2	11	Norwin 1	t
73	3	11	Norwin 1	t
74	1	2	Somerset 1	t
75	2	2	Somerset 1	t
76	3	2	Somerset 1	t
77	1	8	Washington 1	t
78	1	8	Washington 2	t
79	2	8	Washington 1	t
80	3	8	Washington 1	t
\.


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('teams_id_seq', 80, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: quizzing
--

COPY users (id, username, email, role, password_digest, active, active_after, password_reset_token, password_reset_sent_at, token_type) FROM stdin;
1	chesstiger91	\N	admin	$2a$10$I.XyZ5noTUO3KVh8PORD4O0uA1jF6PfGsc.IA3qft4tbGyzXJXnSi	t	2015-06-03 16:29:01.238912	\N	\N	\N
2	quizzing	quizzing@cmu.edu	admin	$2a$10$C2im5Am9OzqpALiMWF.5KOWEYCqwgMIBgaaOgL9p2bILbAoFqRBaq	t	2015-06-03 16:29:02.076519	\N	\N	\N
3	tmreay	tmreay@example.com	area_admin	$2a$10$tODvsYPCac5CiWisMcyaRu9V9p.qSHj88AHOkYcnUt1G/OziG3vQO	t	2015-06-03 16:29:02.166314	\N	\N	\N
4	tdaigle	tdaigle@example.com	coach	$2a$10$bh9pmiAjttpoSzIw6as.weLfe5g61xfd6GqbejE1WIB41f.VXVneW	t	2015-06-03 16:29:02.01069	\N	\N	\N
5	kfay64	kfay64@example.com	coach	$2a$10$YffrNWh7KvqnQ.eFTa8iru4ruPlT0DUyb61WQ4duwrHOlC550YTfy	t	2015-06-03 16:29:02.01069	\N	\N	\N
6	smoore30	smoore30@example.com	coach	$2a$10$CCo0QMtVoqAi.1toLzfcuOWl9gw0chv.epgFc.Gxt5koMQX7jARkm	t	2015-06-03 16:29:02.01069	\N	\N	\N
7	wbednar35	wbednar35@example.com	coach	$2a$10$hSZwS/ZBBwgJKIyFWh5.kemyOzgHu0fw14fNOxcf6.dDDb4pcP8/a	t	2015-06-03 16:29:02.01069	\N	\N	\N
8	kmurazik59	kmurazik59@example.com	coach	$2a$10$xVgvEqHuHxWFQ.7RFHyAMuVR8ZeX9kJeCbihAsPoHlfdwqTdp5r.6	t	2015-06-03 16:29:02.01069	\N	\N	\N
9	gconsidine11	gconsidine11@example.com	coach	$2a$10$jNDUFRXYOVwwyfqNiTuu4.yoA.TxGm3OdLmE6FtlGIV73iWg7EzxK	t	2015-06-03 16:29:02.01069	\N	\N	\N
10	bgislason45	bgislason45@example.com	coach	$2a$10$Q8UlBHUdRKnUj5bcQr6CjukRl3BzMmu4h0kShL4imczwjNP/DsIcu	t	2015-06-03 16:29:02.01069	\N	\N	\N
11	drippin53	drippin53@example.com	coach	$2a$10$cYjqTVCcvo5EtFpQ/PsXOOAz4h/SxwdskYP3Tr.40Is.KrGLKFw5q	t	2015-06-03 16:29:02.01069	\N	\N	\N
12	jrunte4	jrunte4@example.com	coach	$2a$10$LaY5AQQf5/qWpY1XcDsTHuYOoqX0TOtJ.YtzYB5cNb806dZswr.qa	t	2015-06-03 16:29:02.01069	\N	\N	\N
13	dgaylord56	dgaylord56@example.com	coach	$2a$10$Xbq4rMdrYVh2t/P.ll8W7.JN2iEzgHGoSweKrjU5oHpnAgI/luY.6	t	2015-06-03 16:29:02.01069	\N	\N	\N
14	josinski35	josinski35@example.com	coach	$2a$10$XD1ILRcKd.xTULdel7BH1uYzHx46Jjge0TzDazFXnyna1zyzjRml.	t	2015-06-03 16:29:02.01069	\N	\N	\N
15	dbuckridge58	dbuckridge58@example.com	coach	$2a$10$83DNTC25fg6b9JkqJP6LAeqeFWXmqq8onPfrEqnhuoceGDjU.X0au	t	2015-06-03 16:29:02.01069	\N	\N	\N
16	whickle29	whickle29@example.com	coach	$2a$10$r2SS1AAYs0PFkb9X6YT3y.HHflni52ZPWVj.D8sC5zXqqjrFIywfS	t	2015-06-03 16:29:02.01069	\N	\N	\N
17	rspinka9	rspinka9@example.com	coach	$2a$10$BC.wBAwm1asEHmHZ621tl.Jojl332LzAyi4mq40KfvIMDybz6nsyW	t	2015-06-03 16:29:02.01069	\N	\N	\N
18	fbeatty40	fbeatty40@example.com	coach	$2a$10$q3RwS7mBltbnS1Cp5w36SOZayLGNwTxjRqKnA.9ZKm1jpYk5u.Wjy	t	2015-06-03 16:29:02.01069	\N	\N	\N
19	jbarton10	jbarton10@example.com	coach	$2a$10$rJ2.TPxCIhNjkhGpe1ITX.mQEtejrEYyZ2o7Ey7x9GB/mk6CfYwq.	t	2015-06-03 16:29:02.01069	\N	\N	\N
20	rrempel54	rrempel54@example.com	coach	$2a$10$xriBR4SFosLP0tkcCvbijuEd4JWa4zyGEtz2T5P9/Mbs9u.NAe9Ri	t	2015-06-03 16:29:02.01069	\N	\N	\N
21	kbradtke10	kbradtke10@example.com	coach	$2a$10$kS8xO.RVPBcONtbY1fH7OOkgq3AnRMwsxaEiBXZGwKHQBH83jOFBC	t	2015-06-03 16:29:02.01069	\N	\N	\N
22	labernathy48	labernathy48@example.com	coach	$2a$10$s2CWrk1dw/ZTv7DQYCizBegHL2MJaKKwTwxtP4sBfgTQLgOdK1LJ.	t	2015-06-03 16:29:02.01069	\N	\N	\N
23	gwaters42	gwaters42@example.com	coach	$2a$10$mMUx11CSJRJ9QHLlPUgDY.0lvoPRYzOftBq1m1MdfRX/wqDPr.p9S	t	2015-06-03 16:29:02.01069	\N	\N	\N
24	hlubowitz76	hlubowitz76@example.com	coach	$2a$10$uQFdAD15iDSq2yRmmm76KOg3pdqhPDqdz9cA9XFawBdMxsPw2vWiW	t	2015-06-03 16:29:02.01069	\N	\N	\N
25	acremin58	acremin58@example.com	coach	$2a$10$Dmd1gxM6z0IdzWXiotfjjOoJPcV7dKWcM7ddoQVYfvBZ3I8IYFHeC	t	2015-06-03 16:29:02.01069	\N	\N	\N
26	lkutch56	lkutch56@example.com	coach	$2a$10$2vHY7V3ClO4SO9fd2P31z.4t7Kl7bCgg6VwfyV2QCJNvyH7lC4Zce	t	2015-06-03 16:29:02.01069	\N	\N	\N
27	alabadie86	alabadie86@example.com	coach	$2a$10$f5IrObO6bE0pAeNprAETE.lRJJ4qeCaNcM5eYohBh4v9S9S44.QYG	t	2015-06-03 16:29:02.01069	\N	\N	\N
28	mschowalter5	mschowalter5@example.com	coach	$2a$10$vc0b1JYbG34GxoBTayGQBOqEUyaixfccMxpgbSO4kigejAwAR41Eq	t	2015-06-03 16:29:02.01069	\N	\N	\N
29	cwehner58	cwehner58@example.com	coach	$2a$10$hs07Y.MBJMz6y0HxN36KwuipP.fM7aoL8kVq0dHP6TiPdrGVzMhGO	t	2015-06-03 16:29:02.01069	\N	\N	\N
30	ewiegand16	ewiegand16@example.com	coach	$2a$10$IvUV0snm9EpyXCwoUhdKQuHNU0VNZEHrWCw6qLZf6p20R3WjaAD3O	t	2015-06-03 16:29:02.01069	\N	\N	\N
31	ostehr73	ostehr73@example.com	coach	$2a$10$nI63LtQtKRaqUSyDll7uoeFEGGRhAErWRuH0fN1idoBEdhcKr83vi	t	2015-06-03 16:29:02.01069	\N	\N	\N
32	herdman22	herdman22@example.com	coach	$2a$10$QcFHOWYSB/JxOP.6R1puVeFIKWVtNTdlJdq92hfKnWdLHX5cwNOm.	t	2015-06-03 16:29:02.01069	\N	\N	\N
33	wgrant53	wgrant53@example.com	coach	$2a$10$nuvEgXZzUPWVUDmLklhb6unzYmxHZaeKJHlPI0wenGYPwsUYkGPBW	t	2015-06-03 16:29:02.01069	\N	\N	\N
34	istiedemann23	istiedemann23@example.com	coach	$2a$10$9EPm00sV1pe2.LelYiyx3ud2tFN6TqgecRryPkp8mEKdSmFq49Zr2	t	2015-06-03 16:29:02.01069	\N	\N	\N
35	dfeest62	dfeest62@example.com	coach	$2a$10$KN5ykalxWy66bqqHSAurOuFrIakyZVDGbI.W1dadliewjTs05dAo6	t	2015-06-03 16:29:02.01069	\N	\N	\N
36	lwilderman87	lwilderman87@example.com	coach	$2a$10$k4moilTzYIJv9EMqgYvDt.RJCEE8wrUjePwsAmXWs519MNY3rWO4G	t	2015-06-03 16:29:02.01069	\N	\N	\N
37	tbartoletti67	tbartoletti67@example.com	coach	$2a$10$9gDCgg8QwNyEJwo35aEgFO3GuGlq62KFL3gnMFGMP8rfMvBj07TXW	t	2015-06-03 16:29:02.01069	\N	\N	\N
38	tsawayn21	tsawayn21@example.com	coach	$2a$10$g8ZC9fgck0ww5LhwDIwXdOwF06BBKfyP3Kd5ShcLsBXGuvoyoiZhi	t	2015-06-03 16:29:02.01069	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quizzing
--

SELECT pg_catalog.setval('users_id_seq', 38, true);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (id);


--
-- Name: divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (id);


--
-- Name: event_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY event_summaries
    ADD CONSTRAINT event_summaries_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: indiv_standings_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY indiv_standings
    ADD CONSTRAINT indiv_standings_pkey PRIMARY KEY (id);


--
-- Name: organization_students_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY organization_students
    ADD CONSTRAINT organization_students_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: quiz_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY quiz_teams
    ADD CONSTRAINT quiz_teams_pkey PRIMARY KEY (id);


--
-- Name: quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: student_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY student_quizzes
    ADD CONSTRAINT student_quizzes_pkey PRIMARY KEY (id);


--
-- Name: student_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY student_teams
    ADD CONSTRAINT student_teams_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: team_coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY team_coaches
    ADD CONSTRAINT team_coaches_pkey PRIMARY KEY (id);


--
-- Name: team_standings_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY team_standings
    ADD CONSTRAINT team_standings_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: quizzing; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_pg_search_documents_on_searchable_id_and_searchable_type; Type: INDEX; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE INDEX index_pg_search_documents_on_searchable_id_and_searchable_type ON pg_search_documents USING btree (searchable_id, searchable_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: quizzing; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: quizzing
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM quizzing;
GRANT ALL ON SCHEMA public TO quizzing;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

