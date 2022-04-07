require "base64"
require "digest"
require "json"
require "openssl"
require "socket"
 
module Cert
  def self.get_peer_certificate(host)
    tcp_client = TCPSocket.new(host, 443)
    ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client)
    ssl_client.connect
    ssl_client.peer_cert
  ensure
    ssl_client.sysclose
    tcp_client.close
  end
end
 
module Verifier
  def self.verify(data, received_signature, cert)
    sig = Base64.decode64(received_signature)
    OpenSSL::X509::Certificate.
      new(cert).
      public_key.
      verify_pss("SHA512", sig, data, salt_length: :auto, mgf1_hash: "SHA512")
  end
end
 
# payload is the raw body of the webhook
# signature is the content of the header
payload = '{"timestamp":"2021-02-11T03:39:30Z","internal_id":"fffffd08-00fa-4806-926d-60fe9bdbec3c","api_version":"v2","type":"FxPricer::Item","data":{"reference":"FP-ZX3Y86CRP","currency_pair":"CNYEUR","rate":0.12779389,"rate_with_markup":0.12779389,"currency":"CNY","counter_currency":"EUR","tenor":"SPT","markup":0.0},"payload":{"api_version":"v2"},"signed_by_domain":"kantox.com","hashed_using":"SHA-512"}'
 
signature = "LMrao0qMw/nb/dhJhMq0OopZmz6CB32yM1YrQ5xNUjizw3mGy5nAhISGFPLhPrcnRluJBRPUToP6jTQl3InYmdMZ90fZDFdkgbufm3bSPA6RQ7qBRq9e9cSZvSkz09gqOioX4lAqY1WzSbg9gry3F8BtkOtagFZHRXbDvFPRXljeKecMZD624SIvmVF4Cgd1b+LBY/nCjC9BzIhgLUJVZ5oqkKhS7ntQPneC2nDkFhcn5Rn8nGJLyUh1tlGPfMTfppY3uvkQWUZrvDAJ30SMf76V0E6YEY8fIkUI8amLIQ9lojnCHHuN4mUckjY+NkcF0Wsxy3bB/x+R0rdiM/3B8A=="

cert = Cert.get_peer_certificate("kantox.com")

if Verifier.verify(payload, signature, cert)
  puts "Verification succeeded"
else
  puts "Verification failed"
end