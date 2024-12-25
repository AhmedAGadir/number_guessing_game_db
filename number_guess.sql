--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    user_id integer NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer DEFAULT 0
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 6, 1);
INSERT INTO public.games VALUES (2, 0, NULL);
INSERT INTO public.games VALUES (3, 0, NULL);
INSERT INTO public.games VALUES (5, 2, 0);
INSERT INTO public.games VALUES (4, 5, 0);
INSERT INTO public.games VALUES (7, 2, 0);
INSERT INTO public.games VALUES (6, 5, 0);
INSERT INTO public.games VALUES (9, 2, 592);
INSERT INTO public.games VALUES (8, 5, 184);
INSERT INTO public.games VALUES (10, 1, 7);
INSERT INTO public.games VALUES (12, 2, 113);
INSERT INTO public.games VALUES (11, 5, 135);
INSERT INTO public.games VALUES (15, 2, 6);
INSERT INTO public.games VALUES (14, 5, 213);
INSERT INTO public.games VALUES (17, 2, 189);
INSERT INTO public.games VALUES (16, 5, 46);
INSERT INTO public.games VALUES (13, 3, 2);
INSERT INTO public.games VALUES (19, 2, 644);
INSERT INTO public.games VALUES (18, 5, 103);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'ahmedag_101');
INSERT INTO public.users VALUES (2, 'user_1735158133476');
INSERT INTO public.users VALUES (3, 'user_1735158133475');
INSERT INTO public.users VALUES (4, 'user_1735158308920');
INSERT INTO public.users VALUES (5, 'user_1735158308919');
INSERT INTO public.users VALUES (6, 'user_1735158331207');
INSERT INTO public.users VALUES (7, 'user_1735158331206');
INSERT INTO public.users VALUES (8, 'user_1735158558566');
INSERT INTO public.users VALUES (9, 'user_1735158558565');
INSERT INTO public.users VALUES (10, 'BOB');
INSERT INTO public.users VALUES (11, 'user_1735159127719');
INSERT INTO public.users VALUES (12, 'user_1735159127718');
INSERT INTO public.users VALUES (13, 'bob');
INSERT INTO public.users VALUES (14, 'user_1735159339260');
INSERT INTO public.users VALUES (15, 'user_1735159339259');
INSERT INTO public.users VALUES (16, 'user_1735159429168');
INSERT INTO public.users VALUES (17, 'user_1735159429167');
INSERT INTO public.users VALUES (18, 'user_1735159479329');
INSERT INTO public.users VALUES (19, 'user_1735159479328');


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 19, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

