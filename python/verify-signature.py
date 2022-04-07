import ssl
from base64 import b64decode
from Crypto.Hash import SHA512
from Crypto.PublicKey import RSA
from Crypto.Signature import pss

payload = '{"timestamp":"2021-02-11T03:39:30Z","internal_id":"fffffd08-00fa-4806-926d-60fe9bdbec3c","api_version":"v2","type":"FxPricer::Item","data":{"reference":"FP-ZX3Y86CRP","currency_pair":"CNYEUR","rate":0.12779389,"rate_with_markup":0.12779389,"currency":"CNY","counter_currency":"EUR","tenor":"SPT","markup":0.0},"payload":{"api_version":"v2"},"signed_by_domain":"kantox.com","hashed_using":"SHA-512"}'
signature = "LMrao0qMw/nb/dhJhMq0OopZmz6CB32yM1YrQ5xNUjizw3mGy5nAhISGFPLhPrcnRluJBRPUToP6jTQl3InYmdMZ90fZDFdkgbufm3bSPA6RQ7qBRq9e9cSZvSkz09gqOioX4lAqY1WzSbg9gry3F8BtkOtagFZHRXbDvFPRXljeKecMZD624SIvmVF4Cgd1b+LBY/nCjC9BzIhgLUJVZ5oqkKhS7ntQPneC2nDkFhcn5Rn8nGJLyUh1tlGPfMTfppY3uvkQWUZrvDAJ30SMf76V0E6YEY8fIkUI8amLIQ9lojnCHHuN4mUckjY+NkcF0Wsxy3bB/x+R0rdiM/3B8A=="

def verify(payload, sig, cert):
    signature = b64decode(sig)
    digest = SHA512.new(payload.encode("utf-8"))
    pkey = RSA.import_key(cert).publickey()
    try:
        pss.new(pkey).verify(digest, signature)
        return True
    except ValueError:
        return False

cert = ssl.get_server_certificate(('kantox.com', 443))
if verify(payload, signature, cert):
    print("Verification succeeded")
else:
    print("Verification failed")