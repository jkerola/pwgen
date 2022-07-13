# pwgen

---

Generates easily memorizable, strong passwords.

## Installation

### Linux

Download the binary, allow execution and then move the file to a suitable location:

```shell
cd path/to/pwgen
sudo chmod +x pwgen
sudo mkdir /opt/pwgen/
sudo mv pwgen /opt/pwgen/
```

Then add the installation folder to your PATH:

```shell
export PATH=$PATH:/opt/pwgen
```

### Other platforms

Fastest way is to compile the binary yourself.

Requirements:

- Dart ^2.17
- git ^2.2

```shell
git clone https://github.com/jkerola/pwgen.git
cd pwgen
dart pub get
dart compile exe bin/pwgen.dart -o pwgen
```

Then add the binary to your PATH.

### Usage

Generate a password with:

```shell
pwgen
```

Display all available options:

```shell
pwgen --help
```

### Options

| Option              | Description                                                                 |
| ------------------- | --------------------------------------------------------------------------- |
| `-w, --word-count`  | Number of words in password. Defaults to 4.                                 |
| `-s, --separator`   | Separate password words with specific character or string. Defaults to '-'. |
| `-c, --capitalized` | Capitalize each word in the password.                                       |
| `-v, --version`     | Display versioning information about this tool.                             |
| `-h, --help`        | Display this information.                                                   |
