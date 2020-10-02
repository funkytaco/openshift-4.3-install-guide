#!/bin/bash

set -e

run() {
  case "$1" in
    --fast)
      fast "$2"
      ;;
    --latest)
      latest "$2"
      ;;
    --nightly)
      nightly "$2"
      ;;
    --version)
      version "$2"
      ;;
    --stable)
      stable "$2"
      ;;
    --cleanup)
      remove_old_ver
      ;;
    --help)
      show_help
      exit 0
      ;;
    --update)
      latest
      ;;
    *)
      show_help
      exit 0
  esac
}

version() {

  if [[ "$1" == "" ]]; then
    echo "Please specify a version."
    echo "Example: install-oc-tools --version 4.5.6"
    exit 1
  else
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$1/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
    if [ "$VERSION" == "$CUR_VERSION" ]; then
      echo "$VERSION already installed."
      exit 0
    fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$1/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$1/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  fi

}

latest() {

  if [[ "$1" == "" ]]; then
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
      if [ "$VERSION" == "$CUR_VERSION" ]; then
        echo "Lastest $VERSION is installed."
        exit 0
      fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  else
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest-$1/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
    if [ "$VERSION" == "$CUR_VERSION" ]; then
      echo "$VERSION already installed."
      exit 0
    fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest-$1/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest-$1/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  fi

}

fast() {

  if [[ "$1" == "" ]]; then
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
      if [ "$VERSION" == "$CUR_VERSION" ]; then
        echo "Lastest $VERSION is installed."
        exit 0
      fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  else
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast-$1/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
    if [ "$VERSION" == "$CUR_VERSION" ]; then
      echo "$VERSION already installed."
      exit 0
    fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast-$1/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast-$1/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  fi

}

stable() {

  if [[ "$1" == "" ]]; then
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
      if [ "$VERSION" == "$CUR_VERSION" ]; then
        echo "Lastest $VERSION is installed."
        exit 0
      fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  else
    VERSION=$(curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$1/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
    if [ "$VERSION" == "$CUR_VERSION" ]; then
      echo "$VERSION already installed."
      exit 0
    fi
    wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$1/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q  https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$1/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  fi

}

nightly() {

  if [[ "$1" == "" ]]; then
    VERSION=$(curl -s http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
      if [ "$VERSION" == "$CUR_VERSION" ]; then
        echo "Lastest $VERSION is installed."
        exit 0
      fi
      wget -q http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
      wget -q http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  else
    VERSION=$(curl -s http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest-$1/release.txt | grep 'Name:' | awk '{print $NF}')
    CUR_VERSION=$(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')
    if [ "$VERSION" == "$CUR_VERSION" ]; then
      echo "$VERSION already installed."
      exit 0
    fi
    wget -q http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest-$1/openshift-client-linux.tar.gz -O /tmp/openshift-client-linux.tar.gz
    wget -q http://mirror.openshift.com/pub/openshift-v4/clients/ocp-dev-preview/latest-$1/openshift-install-linux.tar.gz -O /tmp/openshift-install-linux.tar.gz
  fi

}

backup() {

  if [[ -f "/usr/local/bin/oc" ]] && [[ -f "/usr/local/bin/openshift-install" ]] && [[ -f "/usr/local/bin/kubectl" ]]
  then
      for i in openshift-install oc kubectl; do mv "$(which $i)" /usr/local/bin/"$i"."$CUR_VERSION".bak; done
  fi
}

extract() {
  tar -zxf /tmp/openshift-client-linux.tar.gz -C /usr/local/bin
  tar -zxf /tmp/openshift-install-linux.tar.gz -C /usr/local/bin
}

cleanup() {
  rm -rf /usr/local/bin/README.md
  rm -rf /tmp/openshift-client-linux.tar.gz
  rm -rf /tmp/openshift-install-linux.tar.gz
}

remove_old_ver() {

  read -p "Delete the following files?
$(echo -e "\n")
$(for i in oc kubectl openshift-install; do ls -1 /usr/local/bin/$i*bak 2>/dev/null; done)
$(echo -e "\nY/N? ")"

  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    for i in oc kubectl openshift-install; do rm -f /usr/local/bin/$i*bak 2>/dev/null; done
    exit 0
  elif [[ $REPLY =~ ^[Nn]$ ]]
  then
    exit 0
  else
    echo "Invalid response."
    exit 1
  fi

}

show_ver() {
  if which oc &>/dev/null; then
      echo -e "\noc version: $(oc version 2>/dev/null | grep Client | sed -e 's/Client Version: //')"
  else
      echo "Error getting oc version. Please rerun script."
  fi

  if which kubectl &>/dev/null; then
      echo -e "\nkubectl version: $(kubectl version --client | grep -o "GitVersion:.*" | cut -d, -f1)"
  else
      echo "Error getting kubectl version. Please rerun script."
  fi

  if which openshift-install &>/dev/null; then
      echo -e "\nopenshift-install version: $(openshift-install version | grep openshift-install | sed -e 's/openshift-install //')"
  else
      echo "Error getting openshift-install version. Please rerun script."
  fi
}

show_help() {
    echo "USAGE: install-oc-tools
install-oc-tools is a small script that will download the latest, stable, fast, nightly,
or specified version of the oc command line tools, kubectl, and openshift-install.
If a previous version of the tools are installed it will make a backup of the file.

Options:
  --latest:  Installs the latest specified version. If no version is specified then it
             downloads the latest stable version of the oc tools.
    Example: install-oc-tools --latest 4.5.6
  --update:  Same as --latest
  --fast:    Installs the latest fast version. If no version is specified then it downloads
             the latest fast version.
    Example: install-oc-tools --fast 4.5.6
  --stable:  Installs the latest stable version. If no version is specified then it
             downloads the latest stable version of the oc tools.
    Example: install-oc-tools --stable 4.5.6
  --version: Installs the specific version.  If no version is specified then it
             downloads the latest stable version of the oc tools.
    Example: install-oc-tools --version 4.5.6
  --nightly: Installs the latest nightly version. If you do not specify a version it will grab
             the latest version.
    Example: install-oc-tools --nightly 4.5.6
             install-oc-tools --nightly
  --cleanup: This deleted all backed up version of oc, kubectl, and openshift-install
    Example: install-oc-tools --cleanup
  --help:    Shows this help message"
}

main() {
  if [ "$EUID" -ne 0 ]
  then echo "This script requires root access to run."
  exit
  fi
  run "$1" "$2"

  backup

  extract

  cleanup

  show_ver
}

main "$@"
