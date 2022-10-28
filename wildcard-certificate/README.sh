lego --email Moritz.Hedtke@t-online.de --dns hetzner --domains 'selfmade4u.de,*.selfmade4u.de' run

kubectl create secret tls selfmade4u.de-wildcard-certificate --cert=.lego/certificates/selfmade4u.de.crt --key=.lego/certificates/selfmade4u.de.key

