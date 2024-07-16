CREATE TABLE public.invoices (
    id integer,
    name character varying,
    status character varying(1),
    CONSTRAINT pk PRIMARY KEY (id)
);

ALTER TABLE public.invoices OWNER TO postgres;

INSERT INTO public.invoices VALUES (1, 'Invoice1', 'R');
INSERT INTO public.invoices VALUES (2, 'Invoice2', 'P');
INSERT INTO public.invoices VALUES (3, 'Invoice3', 'R');