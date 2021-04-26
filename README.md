# ubuntu-autoinstall-pxe-server

Setup a PXE server serving autoinstall config of subiquity to provision Ubuntu.

This tool is built on top of [ubuntu-server-netboot](https://github.com/dannf/ubuntu-server-netboot).


## Usage
### Fetch the Code

Fetch the source by:

```
git clone https://github.com/tai271828/ubuntu-autoinstall-pxe-server.git --recurse-submodules
```


or

```
git clone https://github.com/tai271828/ubuntu-autoinstall-pxe-server.git --recurse-submodules -j4
```


### Install Pre-requisite

```
sudo ./contrib/install-dependencies.sh
```


### Setup the Server
#### One Line to Setup the PXE Server

This tool is essentially a wrapper of [ubuntu-server-netboot](https://github.com/dannf/ubuntu-server-netboot). For more details of the arguments, please refer to the project [ubuntu-server-netboot](https://github.com/dannf/ubuntu-server-netboot).

```
sudo ./setup-pxe-server.sh --url http://cdimage.ubuntu.com/ubuntu-server/daily-live/current/hirsute-live-server-arm64.iso
```

If you have a pre-downloaded iso, you could use the iso as a local cache by `--iso`:

```
sudo ./setup-pxe-server.sh --url http://cdimage.ubuntu.com/ubuntu-server/daily-live/current/hirsute-live-server-arm64.iso --iso /home/ubuntu/hirsute-live-server-arm64.iso
```


Alternatively, one line to setup the pxe server offering autoinstall service:

```
sudo ./setup-pxe-server.sh --url http://cdimage.ubuntu.com/ubuntu-server/daily-live/current/hirsute-live-server-arm64.iso --iso /home/ubuntu/hirsute-live-server-arm64.iso --autoinstall http://<IP ADDRESS>/
```


