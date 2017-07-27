class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :validatable

  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://lvh.me:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                                = url_base + "/saml/metadata"
    settings.assertion_consumer_service_url        = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    # IdP section
    settings.idp_entity_id      = "http://lvh.me:3000/saml/metadata"
    settings.idp_sso_target_url = "http://lvh.me:3000/saml/auth"
    settings.idp_slo_target_url = "http://lvh.me:3000/trust/saml2/http-redirect/slo"

    settings.idp_cert           = "-----BEGIN CERTIFICATE-----
MIICbjCCAdegAwIBAgIBADANBgkqhkiG9w0BAQ0FADBUMQswCQYDVQQGEwJ1czET
MBEGA1UECAwKQ2FsaWZvcm5pYTEVMBMGA1UECgwMT25lbG9naW4gSW5jMRkwFwYD
VQQDDBBhcHAub25lbG9naW4uY29tMB4XDTE0MDkxMTE1MDUxMVoXDTE1MDkxMTE1
MDUxMVowVDELMAkGA1UEBhMCdXMxEzARBgNVBAgMCkNhbGlmb3JuaWExFTATBgNV
BAoMDE9uZWxvZ2luIEluYzEZMBcGA1UEAwwQYXBwLm9uZWxvZ2luLmNvbTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAsezUGLSiNMXg80EZMMzvXH43f07a1plU
mm1poYvVfgSICTqhEUuA0x4w9w/K4BegO07GVkUjNCrvtJEqq4FMDbHj2VfOCMHx
lYi52/ELXKe6ALSm48y5BG9fd1kGHBqBg741KpMvDkmAbX1sLq5reAjOccIDme2d
lLD8tQ8y0IMCAwEAAaNQME4wHQYDVR0OBBYEFP3cLGEyby7TBXweK0SeFrvnRoHL
MB8GA1UdIwQYMBaAFP3cLGEyby7TBXweK0SeFrvnRoHLMAwGA1UdEwQFMAMBAf8w
DQYJKoZIhvcNAQENBQADgYEAS3vJKRFGjvxOHHNJR77wYlxSSbyb9vmWOVBzaTMd
5TFfoSDxuP9RskRjSrez/63WON6tdYr/mJNSNB70ZAic824Y9feQ/kBaCswI+Pgp
b6sFIh4CrY4yCEkBPD8jXFCeJMq+2AqshbITpiu7WF1RCAp/sRAO56giP/B4l0o0
Tc0=
-----END CERTIFICATE-----"
    # or settings.idp_cert_fingerprint           = "3B:05:BE:0A:EC:84:CC:D4:75:97:B3:A2:22:AC:56:21:44:EF:59:E6"
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed]   = false
    settings.security[:logout_requests_signed]  = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed]         = false
    settings.security[:digest_method]           = XMLSecurity::Document::SHA1
    settings.security[:signature_method]        = XMLSecurity::Document::RSA_SHA1

    settings
  end

  def authenticate(unencrypted_password)
    encrypted_password == password_digest(unencrypted_password)
  end
end
