# Publish App Android

## Generate keystore

```sh
keytool -genkey -v -keystore leuwipanjang-release.keystore -alias leuwipanjang -keyalg RSA -keysize 2048 -validity 10000
```

```ps1
[Convert]::ToBase64String([IO.File]::ReadAllBytes("leuwipanjang-release.keystore")) | Set-Clipboard
```

Settings > Secrets and variables > Actions > New repository secret : 
* ANDROID_KEYSTORE_BASE64 = (Paste hasil clipboard tadi)
* ANDROID_KEYSTORE_PASSWORD = (Password keystore Anda)
* ANDROID_KEY_ALIAS = leuwipanjang
* ANDROID_KEY_PASSWORD = (Password alias Anda)

