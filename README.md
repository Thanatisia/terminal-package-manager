# Terminal Package Manager (TPM)

## Table of Contents:
- Project Information
- Background
- Pre-Requisites
- Obtaining
- Usage
- Remarks

## Project Information

- Author: Asura
- Created: 2022-03-09 2247H, Asura
- CHANGELOGS: [Changelogs](CHANGELOGS.md)


## Background
- A Cross-Distro Package Manager Script/Utility that both beginners and linux regulars can love

- Features
	* Easy package management script for both beginners and linux regulars
	* Includes Distro-specific controls
	* All-in-one, aims to be usable on all distros
		- Dynamically adjust package manager according to current distro as well as the options
		- If distro contains additional package manager support (i.e. AUR)
			- If ArchLinux: AUR control will also be supported (AUR Helper specific)

- Options:
	* S : Search packages
	* L : List Installed Packages
	* I : Install Packages
	* R : Remove Packages

## Pre-Requisites



## Obtaining

- Git Repository Cloning
	```
	Syntax: git clone [repository_url]
	```
	git clone https://github.com/Thanatisia/terminal-package-manager

- File-Only
	```
	- Download via curl
		Syntax: curl -L -O [file_raw_url] [filename (optional)]
	```
	curl -L -O "https://raw.githubusercontent.com/Thanatisia/terminal-package-manager/main/main.sh"

## Usage

1. Change Permission

	chmod +x main.sh

2. (OPTIONAL) Add directory to PATH

	PATH+="/dir/to/main.sh":

3. Execute Program
	- If not added to PATH

		./main.sh

	- If added to PATH

		main.sh

## Remarks
- Many thanks to the following for somehow giving me the random idea that came to my head

	[ChrisTitusTech](https://youtube.com/c/ChrisTitusTech) : was watching the video on "Do not care about Distro Hopping" 