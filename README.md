# NOTES RIVER


## SETUP

For setup this repository in local some basic requirements should be installed.

- Flutter 
- platform_tools
- vscode / Android Studio

```bash
    git clone https://github.com/Notes-River/notesriver_mobile.git
```
```bash
    cd notesriver_mobile
```

- Then run this command. This command will install required dependencies for this project.

```bash
    flutter pub get
```

- OK setup complete not you can run 

```bash
    flutter run
```

- Now select your android emulator or physical device.

## LOCAL SETUP WITH LOCAL SERVER

Follow These steps to setup with local server.

- First setup server of Notes River.  [click here](https://github.com/Notes-River/backend.git) to see how to setup local server.
- start server
- connect your computer or laptop with your local network (Your mobile also should be connected with that network)
- for linux run this command
```bash
    ifconfig
```
- for windows run this command
```bash
    ipconfig
```

This will give you ip adress of your computer or laptop

- Now open notesriver_mobile folder (git clone https://github.com/Notes-River/notesriver_mobile.git)
- Now open config.dart file which located in.
```bash
    notesriver_mobile > lib > src > config.dart
```
- Now you have to make some small change in it

```
class Config {
  static String serverAdress = 'http://192.168.2.108:3000';
}
```

- change this code with

```
class Config {
  static String serverAdress = 'http://<your laptop or computer ip address>:3000';
}
```

- Done, Now run 

```bash 
    flutter run
```
