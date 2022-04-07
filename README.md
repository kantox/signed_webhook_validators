# Kantox signed webhooks signature validation SDK

Multilanguage examples for webhook signature verification

The client will receive an HTTP(S) request with the
body and signature corresponding to some certificate.

Example payloads (what is signed) and resulting signature are included directly in the code examples. 

The signature should be generated with the RSASSA-PSS scheme (see https://en.wikipedia.org/wiki/Probabilistic_signature_scheme) which is part of the PKCS#1 standard (since version 2).

The signature should be verifiable only using the `certs/public.cert` file, which would
be available to clients as being our own (public part of the) certificate.

# Current status

Python code example for verifying Kantox Webhooks signatures. The code was tested using python 3.10.0 with pycryptodome package version 3.14.1

certifi==2021.10.8
charset-normalizer==2.0.12
idna==3.3
Naked==0.1.31
pycryptodome==3.14.1
PyYAML==6.0
requests==2.27.1
shellescape==3.8.1
urllib3==1.26.9

Ruby validated using Ruby 2.5.5+


# Core libraries documentation

- Ruby: https://ruby-doc.org/stdlib-2.6.5/libdoc/openssl/rdoc/OpenSSL/PKey/RSA.html
- Python: https://www.pycryptodome.org/en/latest/src/signature/pkcs1_pss.html
- Node: https://nodejs.org/api/crypto.html
- OpenSSL: https://www.openssl.org/docs/man1.1.1/man1/dgst.html and https://www.openssl.org/docs/man1.1.1/man1/pkeyutl.html
