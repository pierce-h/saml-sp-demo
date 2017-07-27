class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :validatable

  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "https://lvh.me:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                                = url_base + "/saml/metadata"
    settings.assertion_consumer_service_url        = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    # IdP section
    settings.idp_entity_id      = "https://accounts.google.com/o/saml2?idpid=C018lh6vi"
    settings.idp_sso_target_url = "https://accounts.google.com/o/saml2/idp?idpid=C018lh6vi"
    settings.idp_slo_target_url = "http://lvh.me:3000/trust/saml2/http-redirect/slo"

    settings.idp_cert = "-----BEGIN CERTIFICATE-----
MIIDdDCCAlygAwIBAgIGAV2FywwcMA0GCSqGSIb3DQEBCwUAMHsxFDASBgNVBAoTC0dvb2dsZSBJ
bmMuMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MQ8wDQYDVQQDEwZHb29nbGUxGDAWBgNVBAsTD0dv
b2dsZSBGb3IgV29yazELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWEwHhcNMTcwNzI3
MjA0NDIwWhcNMjIwNzI2MjA0NDIwWjB7MRQwEgYDVQQKEwtHb29nbGUgSW5jLjEWMBQGA1UEBxMN
TW91bnRhaW4gVmlldzEPMA0GA1UEAxMGR29vZ2xlMRgwFgYDVQQLEw9Hb29nbGUgRm9yIFdvcmsx
CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAwz4atOTnT1fVnf10V692G3xCLMLwfndQ4FYY8ZjN15NXwwA2UQHuES2eh4szH72Z
w9xKItXtSrfeWpLB0qllz2ZErz7nsoMaPogG76wzIGxwHuM1bpyg34bOLDhPfeXRcUOBsO4bay+Q
f39l93a19GF35bPxdspRpTTQXPcsuOzNAeQR1TFjcX3Pb6wFWTj+Tp7vqGetB3FUj6aTj0m0gN+o
JbiyyMyECbzxdEPVj+l+IstfSuZWjJKA5qinDFSoUxyvtPJDGJHx/yuypE8MMN3hcCBN7frJ40Oh
vIDDqrnxp0UbzKihP+2KDpNSt6EGDpRpJdUGyvHCh3r47yTqbwIDAQABMA0GCSqGSIb3DQEBCwUA
A4IBAQBGCYsDyTTk2P1V6pFceCOQnA5maloCKvG4Lut5z32sM3UFsb61//3LJdehvC4qf//seR2v
x/afL9aT7WKr58OMxqOJjRSEIOIue5HW54sLyPFo7fHqWYIzH6sTe1YjwCSG+jt6c8Xzq+HbL/Yu
GVyb5qWp2Wh+5SqIUFIUqAnoo3BXKGKniIJsyKFoYQZHd1/ab5czsjCQhN6ZVUQL9BQ4Ld0CaYwZ
RmVSi94UKFzaRIZo1a2mbMsm6cwXCSZwaLYzcfOujszedg8Do67t4qZSXFE2zLEFCMnvHBC2fLXf
+osbK+sXPZxUkDm6kNQtQ7+7hYxjMp6Lu78sSnmHUYsh
-----END CERTIFICATE-----"
    # or settings.idp_cert_fingerprint           = "3B:05:BE:0A:EC:84:CC:D4:75:97:B3:A2:22:AC:56:21:44:EF:59:E6"
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"

    # Security section
    settings.security[:authn_requests_signed]   = false
    settings.security[:logout_requests_signed]  = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed]         = false
    settings.security[:digest_method]           = XMLSecurity::Document::SHA1
    settings.security[:signature_method]        = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
