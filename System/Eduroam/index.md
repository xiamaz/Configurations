# Eduroam – Doing it the right way

Setting up eduroam wifi can be a test of patience depending on the specific linux setup.

Add these specific informations to get Eduroam to work correctly.
```
[wifi]
mode=infrastructure
ssid=eduroam

[wifi-security]
key-mgmt=wpa-eap

[802-1x]
eap=peap;
identity=<YOUR LOGIN>
phase2-auth=mschapv2
ca-cert=/etc/NetworkManager/certs/eduroam/telekom_root.pem
```

Adding the correct root certificate can speed up the eduroam connection considerably and make some connections work at all.
