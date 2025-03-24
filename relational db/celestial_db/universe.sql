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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50),
    messier_number character varying(3),
    ngc_ic_number character varying(10),
    ddo_number character varying(10) DEFAULT NULL::character varying,
    morphology character varying(8),
    distance_from_earth_kilo_parsec integer NOT NULL,
    constellation character varying(40)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer,
    name character varying(20) NOT NULL,
    systematic_name character varying(20),
    subgroup character varying(30) DEFAULT NULL::character varying,
    year_discovered integer,
    is_round boolean DEFAULT false
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer,
    name character varying(30) NOT NULL,
    mean_distance_from_star_au numeric NOT NULL,
    has_known_satellites boolean DEFAULT false,
    radius_earth_radii real,
    mass_earth_mass real,
    density_kg_m3 integer,
    temperature_kalvin integer,
    planet_type_id integer,
    year_discovered integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planet_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_type (
    planet_type_id integer NOT NULL,
    name character varying NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.planet_type OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_type_planet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_type_planet_type_id_seq OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_type_planet_type_id_seq OWNED BY public.planet_type.planet_type_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer,
    name character varying(30) NOT NULL,
    stellar_class_id integer,
    luminosity_class character varying(5),
    age_billion_years real,
    evolutionary_stage character varying(20),
    distance_from_sun_ly real,
    solar_mass real,
    radius_solar_radii real,
    constellation character varying(40)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: stellar_class; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.stellar_class (
    stellar_class_id integer NOT NULL,
    name character varying(2) NOT NULL,
    effective_temperature_kalvin character varying(20) NOT NULL,
    colour character varying(20) NOT NULL,
    main_spactral_lines text
);


ALTER TABLE public.stellar_class OWNER TO freecodecamp;

--
-- Name: stellar_class_stellar_class_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.stellar_class_stellar_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stellar_class_stellar_class_id_seq OWNER TO freecodecamp;

--
-- Name: stellar_class_stellar_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.stellar_class_stellar_class_id_seq OWNED BY public.stellar_class.stellar_class_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_type planet_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type ALTER COLUMN planet_type_id SET DEFAULT nextval('public.planet_type_planet_type_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: stellar_class stellar_class_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stellar_class ALTER COLUMN stellar_class_id SET DEFAULT nextval('public.stellar_class_stellar_class_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', NULL, NULL, NULL, 'SB(rs)bc', 8, 'Sagittarius');
INSERT INTO public.galaxy VALUES (2, 'Andromeda Galaxy', 'M31', 'NGC 224', NULL, 'SA(s)b', 778, 'Andromeda');
INSERT INTO public.galaxy VALUES (3, 'Messier 32', 'M32', 'NGC 221', NULL, 'cE2', 763, 'Andromeda');
INSERT INTO public.galaxy VALUES (4, 'Triangulum Galaxy', 'M33', 'NGC 598', NULL, 'SA(s)cd', 970, 'Triangulum');
INSERT INTO public.galaxy VALUES (5, 'Messier 49', 'M49', 'NGC 4472', NULL, 'E2', 17000, 'Virgo');
INSERT INTO public.galaxy VALUES (6, 'Bernard''s galaxy', NULL, 'NGC 6822', 'DDO 209', 'IB(s)m', 500, 'Sagittarius');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 4, 'Phobos', 'Mars I', NULL, 1877, false);
INSERT INTO public.moon VALUES (2, 4, 'Deimos', 'Mars II', NULL, 1877, false);
INSERT INTO public.moon VALUES (3, 3, 'Moon', 'Earth I', NULL, NULL, true);
INSERT INTO public.moon VALUES (4, 5, 'Jupiter I', 'Io', 'Galilean moons', 1610, true);
INSERT INTO public.moon VALUES (5, 5, 'Jupiter II', 'Europa', 'Galilean moons', 1610, true);
INSERT INTO public.moon VALUES (6, 5, 'Jupiter III', 'Ganymede', 'Galilean moons', 1610, true);
INSERT INTO public.moon VALUES (7, 5, 'Jupiter IV', 'Callisto', 'Galilean moons', 1610, true);
INSERT INTO public.moon VALUES (8, 5, 'Jupiter XVI', 'Metis', 'Amalthea group', 1979, false);
INSERT INTO public.moon VALUES (9, 5, 'Jupiter XV', 'Adrastea', 'Amalthea group', 1979, false);
INSERT INTO public.moon VALUES (10, 5, 'Jupiter V', 'Amalthea', 'Amalthea group', 1892, false);
INSERT INTO public.moon VALUES (11, 5, 'Jupiter XIV', 'Thebe', 'Amalthea group', 1979, false);
INSERT INTO public.moon VALUES (12, 5, 'Jupiter XVIII', 'Themisto', NULL, 1975, NULL);
INSERT INTO public.moon VALUES (13, 6, 'Saturn II', 'Enceladus', NULL, 1789, true);
INSERT INTO public.moon VALUES (14, 6, 'Saturn VI', 'Titan', NULL, 1655, true);
INSERT INTO public.moon VALUES (15, 6, 'Saturn XXXII', 'Methone', 'Alkyonides', 2004, false);
INSERT INTO public.moon VALUES (16, 6, 'Saturn XXXIII', 'Pallene', 'Alkyonides', 2004, true);
INSERT INTO public.moon VALUES (17, 6, 'Saturn XLIX', 'Anthe', 'Alkyonides', 2007, true);
INSERT INTO public.moon VALUES (18, 7, 'Neptune I', 'Triton', NULL, 1846, true);
INSERT INTO public.moon VALUES (19, 7, 'Neptune XI', 'Sao', 'Sao group', 2002, NULL);
INSERT INTO public.moon VALUES (20, 7, 'Neptune XII', 'Laomedeia', 'Sao group', 2002, NULL);
INSERT INTO public.moon VALUES (21, 8, 'Uranus V', 'Miranda', NULL, 1948, true);
INSERT INTO public.moon VALUES (22, 8, 'Uranus II', 'Umbriel', NULL, 1851, true);
INSERT INTO public.moon VALUES (23, 9, '(134340) Pluto I', 'Charon', NULL, 1978, true);
INSERT INTO public.moon VALUES (24, 9, '(134340) Pluto II', 'Nix', NULL, 2005, false);
INSERT INTO public.moon VALUES (25, 9, '(134340) Pluto III', 'Hydra', NULL, 2005, false);
INSERT INTO public.moon VALUES (26, 9, '(134340) Pluto V', 'Styx', NULL, 2012, false);
INSERT INTO public.moon VALUES (27, 7, 'Neptune III', 'Naiad', NULL, 1989, false);
INSERT INTO public.moon VALUES (28, 6, 'Saturn V', 'Rhea', NULL, 1789, true);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Mercury', 0.39, false, 0.4, 0.1, 5402, 440, 3, NULL);
INSERT INTO public.planet VALUES (2, 1, 'Venus', 0.72, false, 1, 0.8, 5241, 737, 3, NULL);
INSERT INTO public.planet VALUES (3, 1, 'Earth', 1, true, 1, 1, 5513, 288, 3, NULL);
INSERT INTO public.planet VALUES (4, 1, 'Mars', 1.52, true, 0.5, 0.1, 4074, 208, 3, NULL);
INSERT INTO public.planet VALUES (5, 1, 'Jupiter', 5.2, true, 11.2, 317.8, 1244, 163, 1, NULL);
INSERT INTO public.planet VALUES (6, 1, 'Saturn', 9.54, true, 9.1, 95.2, 697, 133, 1, NULL);
INSERT INTO public.planet VALUES (7, 1, 'Neptune', 30.06, true, 3.8, 17.2, 1728, 72, 2, NULL);
INSERT INTO public.planet VALUES (8, 1, 'Uranus', 19.18, true, 4, 14.6, 1258, 78, 2, NULL);
INSERT INTO public.planet VALUES (9, 1, 'Pluto', 39.45, true, 0.19, 0.0022, 1854, 44, 4, 1930);
INSERT INTO public.planet VALUES (10, 1, 'Eris', 67.87, true, 0.36, 0.0027, 2430, 42, 4, 2005);
INSERT INTO public.planet VALUES (11, 2, 'Proxima Centauri b', 0.05, false, 1.1, 1.17, 4859, 234, NULL, 2016);
INSERT INTO public.planet VALUES (12, 3, 'YZ Ceti b', 0.02, false, NULL, 0.7, NULL, NULL, NULL, 2017);
INSERT INTO public.planet VALUES (13, 3, 'YZ Ceti c', 0.02, false, NULL, 0.98, NULL, NULL, NULL, 2017);
INSERT INTO public.planet VALUES (14, 3, 'YZ Ceti d', 0.03, false, NULL, 1.14, NULL, NULL, NULL, 2017);
INSERT INTO public.planet VALUES (15, 4, 'Epsilon Eridani b', 3.48, false, NULL, 247.97, NULL, 150, NULL, 2000);
INSERT INTO public.planet VALUES (16, 5, 'Bernard star b', 0.02, false, NULL, 0.02, NULL, 400, NULL, 2024);


--
-- Data for Name: planet_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_type VALUES (1, 'Gas giant', 'A massive planet composed primarily of hydrogen and helium.');
INSERT INTO public.planet_type VALUES (2, 'Ice giant', 'A giant planet composed mainly of ices - volatile substances heavier than hydrogen and helium - as opposed to "gas". ');
INSERT INTO public.planet_type VALUES (3, 'Terrestrial planet', 'Aka telluric planet, rocky planet. A planet that is composed primarily of carbonaceous or silicates rocks or metals.');
INSERT INTO public.planet_type VALUES (4, 'trans-Neptunian object', 'Aka TNO. A minor planet in the Solar System that orbits the sun at a greater average distance thant Neptune.');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 5, 'V', 4.5, 'Yellow Dwarf', 0, 1, 1, NULL);
INSERT INTO public.star VALUES (2, 1, 'Proxima Centauri', 7, 'V', 5.2, 'Red Dwarf', 4.4, 1.1, 1.22, 'Centaurus');
INSERT INTO public.star VALUES (3, 1, 'YZ Ceti', 7, 'V', 5, 'Red Dwarf', 12.1, 0.13, 0.17, 'Cetus');
INSERT INTO public.star VALUES (4, 1, 'Epsilon Eridani', 6, 'V', 0.5, 'Orange Dwarf', 10.5, 0.82, 0.74, 'Eridanus');
INSERT INTO public.star VALUES (5, 1, 'Bernard star', 7, 'V', 10, 'Red Dwarf', 6, 0.14, 0.2, 'Ophiuchus');
INSERT INTO public.star VALUES (6, 1, 'Betelgeuse', 5, 'la-ab', 0.8, 'Red Supergiant', 723, 11.6, 887, 'Orion');


--
-- Data for Name: stellar_class; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.stellar_class VALUES (1, 'O', '>= 25000', 'blue', 'carbon, nitrogen, helium, oxygen');
INSERT INTO public.stellar_class VALUES (2, 'B', '10000 - 25000', 'light blue', 'helium, hydrogen');
INSERT INTO public.stellar_class VALUES (3, 'A', '7500 - 10000', 'very light blue', 'hydrogen');
INSERT INTO public.stellar_class VALUES (4, 'F', '6000 - 7500', 'blueish white', 'metals: iron, titanium, calcium, strontium, magnesium');
INSERT INTO public.stellar_class VALUES (5, 'G', '5000 - 6000', 'yellowish white', 'calcium, helium, hydrogen and metals');
INSERT INTO public.stellar_class VALUES (6, 'K', '3500 - 5000', 'light orange', 'metals and titanium monoxide');
INSERT INTO public.stellar_class VALUES (7, 'M', '< 3500', 'orangish red', 'metals and titanium monoxide');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 28, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 16, true);


--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_type_planet_type_id_seq', 4, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: stellar_class_stellar_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.stellar_class_stellar_class_id_seq', 7, true);


--
-- Name: galaxy galaxy_messier_number_ngc_ic_number_ddo_number_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_messier_number_ngc_ic_number_ddo_number_key UNIQUE (messier_number, ngc_ic_number, ddo_number);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_systematic_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_systematic_name_key UNIQUE (name, systematic_name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet_type planet_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_name_key UNIQUE (name);


--
-- Name: planet_type planet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_pkey PRIMARY KEY (planet_type_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: stellar_class stellar_class_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stellar_class
    ADD CONSTRAINT stellar_class_name_key UNIQUE (name);


--
-- Name: stellar_class stellar_class_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stellar_class
    ADD CONSTRAINT stellar_class_pkey PRIMARY KEY (stellar_class_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_planet_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_type_id_fkey FOREIGN KEY (planet_type_id) REFERENCES public.planet_type(planet_type_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_stellar_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_stellar_class_id_fkey FOREIGN KEY (stellar_class_id) REFERENCES public.stellar_class(stellar_class_id);


--
-- PostgreSQL database dump complete
--
