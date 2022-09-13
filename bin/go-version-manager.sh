#!/bin/sh

GO_DIRECTORY="$GOPATH/.go"
CURRENT_VERSION_FILE="$GO_DIRECTORY/.current"

OS=$(uname -s | tr "[:upper:]" "[:lower:]")
ARCH=$(uname -m | sed -e 's/^x86_64$/amd64/')

COMMAND=$1
VERSION=$2

FULL_VERSION="$OS-$ARCH-$VERSION"
VERSION_DIRECTORY="$GO_DIRECTORY/$FULL_VERSION"

OS_REGEX="(darwin|linux)"
ARCH_REGEX="(arm64|amd64)"
VERSION_REGEX="1\.[1-9]?[0-9]\.[1-9]?[0-9]"
FULL_VERSION_REGEX="$OS_REGEX-$ARCH_REGEX-$VERSION_REGEX"

if ! [[ $OS =~ "^$OS_REGEX$" ]]; then
  echo "unsupported OS"
  return 1
fi

if ! [[ $ARCH =~ "^$ARCH_REGEX$" ]]; then
  echo "unsupported processor architecture"
  return 1
fi

check_version() {
  if ! [[ $VERSION =~ "^$VERSION_REGEX$" ]]; then
    echo "invalid version input"
    return 1
  fi
}

read_current_version() {
  head -n 1 $CURRENT_VERSION_FILE
}

write_current_version() {
  echo $VERSION &> $CURRENT_VERSION_FILE
}

apply_current_version() {
  local full_version="$OS-$ARCH-$(read_current_version)"
  local go_directory=$(echo $GO_DIRECTORY | sed -e 's/\//\\\//g')
  if ! [[ $PATH =~ "$GO_DIRECTORY/$FULL_VERSION_REGEX/bin" ]]; then
    export PATH="$GO_DIRECTORY/$full_version/bin:$PATH"
    return 0
  fi
  local pattern="$go_directory\/$FULL_VERSION_REGEX\/bin"
  local replace="$go_directory\/$full_version\/bin"
  export PATH=$(echo $PATH | sed -re "s/$pattern/$replace/")
}

list_installed_versions() {
  local current=$(read_current_version)
  local result=""
  for item in $GO_DIRECTORY/*; do
    if [ -d $item ]; then
      if ! [ -z $result ]; then
        result="\n$result"
      fi
      item=$(basename $item)
      if [ $item = "$OS-$ARCH-$current" ]; then
        item="$item (current)"
      fi
      result="$item$result"
    fi
  done
  echo $result
}

set_version() {
  check_version
  if ! [ $? -eq 0 ]; then
    return $?
  fi
  if ! [ -d $VERSION_DIRECTORY ]; then
    echo "$FULL_VERSION is not installed"
    return 1
  fi
  write_current_version
  apply_current_version
  echo "now using go $VERSION"
}

install_version() {
  check_version
  if ! [ $? -eq 0 ]; then
    return $?
  fi
  if [ -d $VERSION_DIRECTORY ]; then
    echo "$FULL_VERSION is already installed"
  else
    ARCHIVE="go$VERSION.$OS-$ARCH.tar.gz"

    echo "downloading $ARCHIVE"

    curl -fLO https://go.dev/dl/$ARCHIVE &>/dev/null
    if ! [ $? -eq 0 ]; then
      echo "could not download $ARCHIVE"
      echo "make sure specified version is available at https://go.dev/dl"
      return 1
    fi

    echo "unarchiving $ARCHIVE"

    tar -C . -xzf $ARCHIVE &>/dev/null
    local TAR_RESULT=$?

    rm $ARCHIVE &>/dev/null

    if ! [ $TAR_RESULT -eq 0 ]; then
        echo "could not unarchive downloaded file"
        return 1
    fi

    echo "installing $FULL_VERSION"

    mkdir -p $GO_DIRECTORY
    mv go $VERSION_DIRECTORY &>/dev/null

    echo "installation is successful"
  fi

  echo "run with \`set $VERSION\` command to make it active"
}

uninstall_version() {
  check_version
  local current=$(read_current_version)
  if [ $VERSION = $current ]; then
    echo "cannot uninstall $FULL_VERSION as it is active"
    echo "set another version and try again"
    return 1
  fi
  if ! [ -d $VERSION_DIRECTORY ]; then
    echo "$FULL_VERSION is not installed"
    return 1
  fi
  rm -rf $VERSION_DIRECTORY
  echo "successfully uninstalled $FULL_VERSION"
}

show_help() {
  echo "\ncommands:\n"
  echo "\tinit"
  echo "\tlist"
  echo "\tset [version]"
  echo "\tinstall [version]"
  echo "\tuninstall [version]"
  echo "\nversions:\n"
  echo "\tvisit https://go.dev/dl to see all available versions of go\n"
}

case $COMMAND in
  init)
    apply_current_version
    ;;
  list)
    list_installed_versions
    ;;
  set)
    set_version
    ;;
  install)
    install_version
    ;;
  uninstall)
    uninstall_version
    ;;
  *)
    show_help
    ;;
esac

unset GO_DIRECTORY
unset CURRENT_VERSION_FILE

unset OS
unset ARCH

unset COMMAND
unset VERSION

unset FULL_VERSION
unset VERSION_DIRECTORY

unset OS_REGEX
unset ARCH_REGEX
unset VERSION_REGEX
unset FULL_VERSION_REGEX
