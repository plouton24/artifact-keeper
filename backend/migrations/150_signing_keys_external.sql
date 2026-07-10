-- External/HSM signing key references.
--
-- Allows registering a public key whose private material lives in an HSM, KMS,
-- or other external signer. private_key_enc stays NULL; external_key_ref holds
-- the provider-specific URI (PKCS#11 label, KMS ARN, HSM key URI, etc.).
ALTER TABLE signing_keys
    ADD COLUMN IF NOT EXISTS external_key_ref TEXT,
    ADD COLUMN IF NOT EXISTS signing_provider TEXT NOT NULL DEFAULT 'local';

COMMENT ON COLUMN signing_keys.external_key_ref IS
    'HSM key URI / PKCS#11 label / KMS ARN for external signing; NULL for local keys and public-only trust anchors';

COMMENT ON COLUMN signing_keys.signing_provider IS
    'Signing backend: local (default), hsm, kms, pkcs11, or other provider id';
