CREATE TABLE "public"."rooms" ("id" serial NOT NULL, "facility_id" integer NOT NULL, "name" text NOT NULL, "capacity" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("facility_id") REFERENCES "public"."facilities"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."rooms" IS E'部屋';
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
CREATE TRIGGER "set_public_rooms_updated_at"
BEFORE UPDATE ON "public"."rooms"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_rooms_updated_at" ON "public"."rooms" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
