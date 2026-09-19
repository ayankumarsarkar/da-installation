#!/bin/bash

check_installation_of() {
   command -v "$1" &> /dev/null
}

if check_installation_of rustup; then
	echo "Rust should already be installed."
	exit 0
fi

install_rust() {
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
}

if check_installation_of curl; then
	echo "Curl is installed."
	install_rust
else
	echo "* Curl is not installed."
	sudo apt install curl
	install_rust
	sudo apt remove curl
	sudo apt autoremove
fi

echo "Rust version:"
rustc --version