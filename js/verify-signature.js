//npm i -g get-ssl-certificate
//npm link get-ssl-certificate
const sslCertificate = require("get-ssl-certificate");
const crypto = require("crypto");

const payload =
  '{"timestamp":"2021-02-11T03:39:30Z","internal_id":"fffffd08-00fa-4806-926d-60fe9bdbec3c","api_version":"v2","type":"FxPricer::Item","data":{"reference":"FP-ZX3Y86CRP","currency_pair":"CNYEUR","rate":0.12779389,"rate_with_markup":0.12779389,"currency":"CNY","counter_currency":"EUR","tenor":"SPT","markup":0.0},"payload":{"api_version":"v2"},"signed_by_domain":"kantox.com","hashed_using":"SHA-512"}';
const signature =
  "LMrao0qMw/nb/dhJhMq0OopZmz6CB32yM1YrQ5xNUjizw3mGy5nAhISGFPLhPrcnRluJBRPUToP6jTQl3InYmdMZ90fZDFdkgbufm3bSPA6RQ7qBRq9e9cSZvSkz09gqOioX4lAqY1WzSbg9gry3F8BtkOtagFZHRXbDvFPRXljeKecMZD624SIvmVF4Cgd1b+LBY/nCjC9BzIhgLUJVZ5oqkKhS7ntQPneC2nDkFhcn5Rn8nGJLyUh1tlGPfMTfppY3uvkQWUZrvDAJ30SMf76V0E6YEY8fIkUI8amLIQ9lojnCHHuN4mUckjY+NkcF0Wsxy3bB/x+R0rdiM/3B8A==";

const verifySignature = async () => {
  const [algorithm, data, signatureBuffer] = [
    "SHA512",
    Buffer.from(payload),
    Buffer.from(signature, "base64"),
  ];

  try {
    const certificate = await sslCertificate.get("kantox.com");
    const isVerified = crypto.verify(
      algorithm,
      data,
      {
        key: crypto.createPublicKey(certificate.pemEncoded),
        padding: crypto.constants.RSA_PKCS1_PSS_PADDING,
        saltLength: crypto.constants.RSA_PSS_SALTLEN_DIGEST,
      },
      signatureBuffer
    );
    console.log(`Is signature verified: ${isVerified}`);
  } catch (error) {
    console.log(error);
  }
};

verifySignature();

// Execute file in terminal: node verify-signature.js