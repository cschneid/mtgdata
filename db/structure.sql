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

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: buylists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buylists (
    id bigint NOT NULL,
    printing_id bigint,
    vendor text,
    valid_on timestamp without time zone,
    price numeric,
    quantity integer
);


--
-- Name: buylists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buylists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buylists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buylists_id_seq OWNED BY public.buylists.id;


--
-- Name: magic_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.magic_sets (
    id bigint NOT NULL,
    name text,
    code text
);


--
-- Name: magic_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.magic_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: magic_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.magic_sets_id_seq OWNED BY public.magic_sets.id;


--
-- Name: printings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.printings (
    id bigint NOT NULL,
    merged_key text NOT NULL,
    scryfall_id text,
    magic_set_id bigint,
    name text,
    foil boolean,
    rarity text
);


--
-- Name: printings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.printings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: printings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.printings_id_seq OWNED BY public.printings.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: buylists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buylists ALTER COLUMN id SET DEFAULT nextval('public.buylists_id_seq'::regclass);


--
-- Name: magic_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magic_sets ALTER COLUMN id SET DEFAULT nextval('public.magic_sets_id_seq'::regclass);


--
-- Name: printings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.printings ALTER COLUMN id SET DEFAULT nextval('public.printings_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: buylists buylists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buylists
    ADD CONSTRAINT buylists_pkey PRIMARY KEY (id);


--
-- Name: magic_sets magic_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.magic_sets
    ADD CONSTRAINT magic_sets_pkey PRIMARY KEY (id);


--
-- Name: printings printings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.printings
    ADD CONSTRAINT printings_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_buylists_on_printings_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_buylists_on_printings_id ON public.buylists USING btree (printing_id);


--
-- Name: index_buylists_on_printings_id_and_valid_on_and_vendor; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_buylists_on_printings_id_and_valid_on_and_vendor ON public.buylists USING btree (printing_id, valid_on, vendor);


--
-- Name: index_buylists_on_valid_on_and_vendor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_buylists_on_valid_on_and_vendor ON public.buylists USING btree (valid_on, vendor);


--
-- Name: index_printings_on_magic_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_printings_on_magic_set_id ON public.printings USING btree (magic_set_id);


--
-- Name: index_printings_on_merged_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_printings_on_merged_key ON public.printings USING btree (merged_key);


--
-- Name: index_printings_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_printings_on_name ON public.printings USING btree (name);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20191206201239');


