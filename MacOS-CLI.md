# MacOS Command Line

## Find WiFi Password

```sh
security find-generic-password -wa "Rho_5G"
```

## IP address

```sh
ifconfig en0 | grep inet | awk '{ print $2 }'
```

## Disable GateKeeper

```sh
sudo spctl --master-disable
```

## Finger print auth for terminal

```sh
sudo vim /etc/pam.d/sudo

auth sufficient pam_tid.so
```

