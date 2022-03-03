CREATE TABLE "public"."informations" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "title" text NOT NULL, "content" text NOT NULL, "published_at" timestamptz, PRIMARY KEY ("id") );COMMENT ON TABLE "public"."informations" IS E'運営からのお知らせ';
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_informations_updated_at"
BEFORE UPDATE ON "public"."informations"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_informations_updated_at" ON "public"."informations" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
