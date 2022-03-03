CREATE TABLE "public"."mail_histories" ("id" serial NOT NULL, "facilityId" integer NOT NULL, "accountId" integer NOT NULL, "content" text NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "parentId" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("facilityId") REFERENCES "public"."facilities"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("accountId") REFERENCES "public"."accounts"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("parentId") REFERENCES "public"."parents"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."mail_histories" IS E'メール送信履歴';
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
CREATE TRIGGER "set_public_mail_histories_updated_at"
BEFORE UPDATE ON "public"."mail_histories"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_mail_histories_updated_at" ON "public"."mail_histories" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
