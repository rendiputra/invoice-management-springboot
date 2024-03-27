--
-- Name: invoice; Type: TABLE; Schema: public; Owner: invoice
--

CREATE TABLE invoice (
                                id character varying(36) NOT NULL,
                                created timestamp(6) without time zone,
                                created_by character varying(255),
                                status_record character varying(255) NOT NULL,
                                updated timestamp(6) without time zone,
                                updated_by character varying(255),
                                amount numeric(38,2) NOT NULL,
                                description character varying(255) NOT NULL,
                                due_date date NOT NULL,
                                invoice_number character varying(100) NOT NULL,
                                paid boolean NOT NULL,
                                id_invoice_type character varying(255) NOT NULL,
                                CONSTRAINT invoice_amount_check CHECK ((amount >= (0)::numeric)),
                                CONSTRAINT invoice_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE invoice OWNER TO invoice;

--
-- Name: invoice_type; Type: TABLE; Schema: public; Owner: invoice
--

CREATE TABLE invoice_type (
                                     id character varying(36) NOT NULL,
                                     created timestamp(6) without time zone,
                                     created_by character varying(255),
                                     status_record character varying(255) NOT NULL,
                                     updated timestamp(6) without time zone,
                                     updated_by character varying(255),
                                     code character varying(100) NOT NULL,
                                     name character varying(100) NOT NULL,
                                     CONSTRAINT invoice_type_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE invoice_type OWNER TO invoice;

--
-- Name: payment_provider; Type: TABLE; Schema: public; Owner: invoice
--

CREATE TABLE payment_provider (
                                  id character varying(36) NOT NULL,
                                  code character varying(100) NOT NULL,
                                  name character varying(100) NOT NULL,
                                  created timestamp(6) without time zone,
                                  created_by character varying(255),
                                  status_record character varying(255) NOT NULL,
                                  updated timestamp(6) without time zone,
                                  updated_by character varying(255),
                                  logo character varying(255),
                                  CONSTRAINT payment_provider_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE payment_provider OWNER TO invoice;

--
-- Name: payment_provider payment_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY payment_provider
    ADD CONSTRAINT payment_provider_pkey PRIMARY KEY (id);


--
-- Name: payment_provider payment_provider_unique_code; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY payment_provider
    ADD CONSTRAINT payment_provider_unique_code UNIQUE (code);

--
-- Name: invoice_type invoice_type_pkey; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY invoice_type
    ADD CONSTRAINT invoice_type_pkey PRIMARY KEY (id);
ALTER TABLE ONLY invoice_type
    ADD CONSTRAINT invoice_type_unique_id UNIQUE (id);


CREATE TABLE invoice_type_provider (
    id_invoice_type character varying(36) NOT NULL,
    id_payment_provider character varying(36) NOT NULL
);

ALTER TABLE invoice_type_provider OWNER TO invoice;
ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT id_invoice_provider_pkey PRIMARY KEY (id_invoice_type, id_payment_provider);
ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT fk_invoice_type_provider_type FOREIGN KEY (id_invoice_type) REFERENCES invoice_type(id);
ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT fk_invoice_type_provider FOREIGN KEY (id_payment_provider) REFERENCES payment_provider(id);

--
-- Name: payment; Type: TABLE; Schema: public; Owner: invoice
--

CREATE TABLE payment (
                                id character varying(36) NOT NULL,
                                created timestamp(6) without time zone,
                                created_by character varying(255),
                                status_record character varying(255) NOT NULL,
                                updated timestamp(6) without time zone,
                                updated_by character varying(255),
                                amount numeric(38,2) NOT NULL,
                                provider_reference character varying(255) NOT NULL,
                                transaction_time timestamp(6) without time zone NOT NULL,
                                id_virtual_account character varying(255) NOT NULL,
                                CONSTRAINT payment_amount_check CHECK ((amount >= (1)::numeric)),
                                CONSTRAINT payment_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);


ALTER TABLE payment OWNER TO invoice;

--
-- Name: virtual_account; Type: TABLE; Schema: public; Owner: invoice
--

CREATE TABLE virtual_account (
                                        id character varying(36) NOT NULL,
                                        created timestamp(6) without time zone,
                                        created_by character varying(255),
                                        status_record character varying(255) NOT NULL,
                                        updated timestamp(6) without time zone,
                                        updated_by character varying(255),
                                        account_number character varying(255) NOT NULL,
                                        company_id character varying(255) NOT NULL,
                                        virtual_account_type character varying(255) NOT NULL,
                                        id_invoice_type character varying(255) NOT NULL,
                                        id_payment_provider character varying(255) NOT NULL,
                                        CONSTRAINT virtual_account_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[]))),
    CONSTRAINT virtual_account_virtual_account_type_check CHECK (((virtual_account_type)::text = ANY ((ARRAY['CLOSED'::character varying, 'OPEN'::character varying, 'INSTALLMENT'::character varying])::text[])))
);


ALTER TABLE virtual_account OWNER TO invoice;


--
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);
ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_unique_number UNIQUE (invoice_number);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: virtual_account virtual_account_pkey; Type: CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT virtual_account_pkey PRIMARY KEY (id);

--
-- Name: virtual_account fk7uwqgyvagjkjopltjifyxl6em; Type: FK CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT fk7uwqgyvagjkjopltjifyxl6em FOREIGN KEY (id_invoice_type) REFERENCES invoice(id);


--
-- Name: invoice fkco4sbxv9cj2oevm6cdpq76ffb; Type: FK CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fkco4sbxv9cj2oevm6cdpq76ffb FOREIGN KEY (id_invoice_type) REFERENCES invoice_type(id);


--
-- Name: payment fkptriq88d7e8io9mhri8p10cq0; Type: FK CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY payment
    ADD CONSTRAINT fkptriq88d7e8io9mhri8p10cq0 FOREIGN KEY (id_virtual_account) REFERENCES virtual_account(id);


--
-- Name: virtual_account fkt3t7f64hvgk4xjblsovqqkpll; Type: FK CONSTRAINT; Schema: public; Owner: invoice
--

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT fkt3t7f64hvgk4xjblsovqqkpll FOREIGN KEY (id_payment_provider) REFERENCES payment_provider(id);


--
-- PostgreSQL database dump complete
--
