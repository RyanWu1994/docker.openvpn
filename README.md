# docker.openvpn

```bash
# 請把後面的 udp 改成自己的網址或IP (例如:這邊IP是:107.167.184.138)
docker-compose run --rm openvpn ovpn_genconfig -u udp://107.167.184.138
# 需要輸入密碼以及一些設定值
docker-compose run --rm openvpn ovpn_initpki

[root@host openvpn]# docker-compose run --rm openvpn ovpn_initpki
Enter New CA Key Passphrase:  #這邊輸入CA key ，要記起來，建議使用 Aa123456
Common Name (eg: your user, host, or server name) [Easy-RSA CA]: #這邊直接按 Enter 就好

# 啟動 ovpn 伺服器
docker-compose up -d
# 請將這個變數的內容改成自己想要的
export CLIENTNAME="clro"
# 建立一個 client 的憑證 (不須密碼) (p.s.若需要輸入密碼，可以將nopass拿掉即可)
docker-compose run --rm openvpn easyrsa build-client-full "$CLIENTNAME" nopass
# 將 client 的憑證匯出
docker-compose run --rm openvpn ovpn_getclient "$CLIENTNAME" > "$CLIENTNAME.ovpn"
```
