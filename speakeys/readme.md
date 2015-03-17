## speakeys

Quickly review and transmit dictated speech from your tablet
to Linux desktop as if typing it in yourself at the cursor.

![screenshot](http://dizzib.github.io/rkeys/speakeys.png)

Currently [google chrome][chrome] is the only browser to support speech recognition.

## to always allow microphone without confirmation (on Android)

    $ mkdir ~/ssl   # or any directory of your choosing
    $ cd ~/ssl      # or any empty directory
    $ rkeys -g      # generate ssl certificate using openssl. Follow the prompts.

Copy `cert.crt` onto your android device either via `/sdcard` or
[google drive][gdrive] and install it via `Settings -> Security -> Install from storage`
(based on [this article](https://coderwall.com/p/wv6fpq/add-self-signed-ssl-certificate-to-android-for-browsing)).
You may also need to activate the screen lock via `Settings -> Security -> Screen lock`.

Now host speakeys over https:

    $ rkeys ./speakeys ~/ssl      # your directories might differ

Finally browse your tablet to `https://your-rkeys-server:7001/speakeys` and
confirm the security exception the first time in.

## url

`http://your-rkeys-server:7000/speakeys`


[chrome]: https://www.google.com/chrome/browser/mobile/index.html
[gdrive]: https://www.google.com/drive/
[rkeys]: https://github.com/dizzib/rkeys
