HETZNER_API_KEY=$HETZNER_API_KEY lego --email Moritz.Hedtke@t-online.de --dns hetzner --domains '*.selfmade4u.de' run

kubectl create secret tls selfmade4u.de-wildcard-certificate --cert=.lego/certificates/_.selfmade4u.de.crt --key=.lego/certificates/_.selfmade4u.de.key

