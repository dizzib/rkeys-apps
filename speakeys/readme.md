## speakeys

Quickly review and transmit dictated speech from your tablet
to Linux desktop as if typing it in yourself at the cursor.

![screenshot](http://dizzib.github.io/rkeys/speakeys.png)

Currently [google chrome][chrome] is the only browser to support speech recognition.

## url

`http://your-rkeys-server:7000/speakeys`

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

## microphone event hooks

You can configure rkeys to do stuff when the microphone starts or stops
listening by overriding the no-operation (nop) commands in the
[default command.yaml](./command.yaml).
For example, here is my custom command.yaml which conveniently pauses
[simon speech recognition][simon] while speakeys is listening:

    speakeys-onstart: exec qdbus-qt4 org.kde.simon /ActionManager triggerCommand 'Filter' 'pause' > /dev/null
    speakeys-onend: exec qdbus-qt4 org.kde.simon /ActionManager triggerCommand 'Filter' 'resume' > /dev/null

Place your custom command.yaml in its own directory, then pass this directory
on the rkeys command line as the final argument.


[chrome]: https://www.google.com/chrome/browser/mobile/index.html
[gdrive]: https://www.google.com/drive/
[rkeys]: https://github.com/dizzib/rkeys
[simon]: https://projects.kde.org/projects/extragear/accessibility/simon
