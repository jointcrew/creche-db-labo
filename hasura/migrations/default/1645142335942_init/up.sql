SET check_function_bodies = false;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.accounts (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.accounts IS 'くれいしゅアカウント';
CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;
CREATE TABLE public.bookings (
    id integer NOT NULL,
    "accountId" integer NOT NULL,
    "parentId" integer NOT NULL,
    "childId" integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    "membershipId" integer NOT NULL,
    "bookingDate" date NOT NULL
);
COMMENT ON TABLE public.bookings IS '予約';
CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;
CREATE TABLE public.children (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    "accountId" integer NOT NULL,
    "parentId" integer NOT NULL
);
COMMENT ON TABLE public.children IS '子供';
CREATE SEQUENCE public.children_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.children_id_seq OWNED BY public.children.id;
CREATE TABLE public.facilities (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.facilities IS '施設';
CREATE SEQUENCE public.facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.facilities_id_seq OWNED BY public.facilities.id;
CREATE TABLE public.memberships (
    id integer NOT NULL,
    "accountId" integer NOT NULL,
    "parentId" integer NOT NULL,
    "childId" integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    "facilityId" integer NOT NULL
);
COMMENT ON TABLE public.memberships IS '施設の会員';
CREATE SEQUENCE public.membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.membership_id_seq OWNED BY public.memberships.id;
CREATE TABLE public.parents (
    id integer NOT NULL,
    "accountId" integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.parents IS '保護者';
CREATE SEQUENCE public.parents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.parents_id_seq OWNED BY public.parents.id;
ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);
ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);
ALTER TABLE ONLY public.children ALTER COLUMN id SET DEFAULT nextval('public.children_id_seq'::regclass);
ALTER TABLE ONLY public.facilities ALTER COLUMN id SET DEFAULT nextval('public.facilities_id_seq'::regclass);
ALTER TABLE ONLY public.memberships ALTER COLUMN id SET DEFAULT nextval('public.membership_id_seq'::regclass);
ALTER TABLE ONLY public.parents ALTER COLUMN id SET DEFAULT nextval('public.parents_id_seq'::regclass);
ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT membership_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.parents
    ADD CONSTRAINT parents_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_accounts_updated_at BEFORE UPDATE ON public.accounts FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_accounts_updated_at ON public.accounts IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_bookings_updated_at ON public.bookings IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_children_updated_at BEFORE UPDATE ON public.children FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_children_updated_at ON public.children IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_facilities_updated_at BEFORE UPDATE ON public.facilities FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_facilities_updated_at ON public.facilities IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_membership_updated_at BEFORE UPDATE ON public.memberships FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_membership_updated_at ON public.memberships IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_parents_updated_at BEFORE UPDATE ON public.parents FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_parents_updated_at ON public.parents IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT "bookings_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT "bookings_childId_fkey" FOREIGN KEY ("childId") REFERENCES public.children(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT "bookings_membershipId_fkey" FOREIGN KEY ("membershipId") REFERENCES public.memberships(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT "bookings_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public.parents(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.children
    ADD CONSTRAINT "children_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.children
    ADD CONSTRAINT "children_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public.parents(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT "membership_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT "membership_childId_fkey" FOREIGN KEY ("childId") REFERENCES public.children(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT "membership_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public.parents(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT "memberships_facilityId_fkey" FOREIGN KEY ("facilityId") REFERENCES public.facilities(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.parents
    ADD CONSTRAINT "parents_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public.accounts(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
