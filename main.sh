: "
Terminal Package Manager

- A Cross-Distro Package Manager Script/Utility that both beginners and linux regulars can love

:: Features
	- Easy package management script for both beginners and linux regulars
	- Includes Distro-specific controls
	- All-in-one, aims to be usable on all distros
		- Dynamically adjust package manager according to current distro as well as the options
		- If distro contains additional package manager support (i.e. AUR)
			- If ArchLinux: AUR control will also be supported (AUR Helper specific)
"

# Variables
DISTRO=""
pkgmgr=""
aur_helper="$1"	
argv=${@:2}		# Get all arguments except the first element = Script Name and all used argument number
argc=${#argv[@]}	# Get total argument count

# Associative Array
declare -A options=(
	[S]="(S)earch Packages" pkgsearch
	[L]="(L)ist Installed Packages" pkglist
	[I]="(I)nstall Packages" pkginstall
	[R]="(R)emove Packages" pkgremove
	[E]="(E)xit"
)
declare -A pkgmgr_options=()

# Processing - Get current distro
DISTRO=$(get_distro)

# Processing - Switch package management controls according to distro
case "$DISTRO" in
	"Arch")
		# pacman, AUR
		pkgmgr="pacman"
		pkgmgr_options=(
			[install]="s"
			[remove]="r"
			[update]="y"
			[upgrade]="u"
			[update_and_upgrade]="syu"
			[search_pkgs]="Ss"
			[installed]="Q"
			[installed_no_version]="Qq"
		)

		# Check AUR Helper (OPTIONAL)
		if [[ "$aur_helper" == "" ]]; then
			# Empty
			read -p "AUR Helper: " aur_helper
		fi
		;;
	"Debian")
		# Aptitude
		pkgmgr="apt"
		pkgmgr_options=(
			[install]="install"
			[remove]=""
			[update]="update"
			[upgrade]="upgrade"
			[search_pkgs]=""
			[installed]=""
			[installed_no_version]=""
		)
		;;
	*)
		# Default
		;;
esac

: "
	Functions
"
pkgsearch()
{
	: "
		Search for a package from distro repositoryy
	"
	query_stmt ="${pkgmgr} ${pkgmgr_options['search_pkgs']}"

	res=$(query_stmt)

	echo -e "$res"
}

pkglist()
{
	: "
		List installed packages
	"
	query_stmt="${pkgmgr} ${pkgmgr_options['installed']}"

	res=$(query_stmt)

	echo -e "$res"
}

pkginstall()
{
	: "
		Install Packages
	"
	query_stmt="${pkgmgr} ${pkgmgr_options['install']}"

	res=$(query_stmt)

	echo -e "$res"
}

pkgremove()
{
	: "
		Uninstall packages
	"
	query_stmt="${pkgmgr} ${pkgmgr_options['remove']}"

	res=$(query_stmt)

	echo -e "$res"
}

menu()
{
	: "
		Main Menu
	"

	# Local Variables
	u_Input=""

	echo "Options:"

	: "
		Get User Input
	"
	# Display Options
	for opt in "${!options[@]}"; do
		# ! : Get the index of a list, or the Key of a dictionary/associative array
		input=$opt
		echo -e "\t$text"		
	done
	read -p "Please select an option: " u_Input
	
	: "
		Process User Input
	"
	# Check user input
	curr_option=()
	func_params=()
	curr_option_size=0
	full_cmd=""
	if $u_Input in "${!options[@]}"; do
		: "
		Input is in options
		"

		# Check for exit
		if [[ "$u_Input" == "E" ]]; then
			# Exit
			return 0;
		fi

		curr_option=("${options[$u_Input]}")	# Get Current Option Array
		curr_option_size=${#curr_option[@]}	# Get Number of elements in current option's value
		text="${curr_option[0]}"
		func="${curr_option[1]}"

		full_cmd="$func "

		# Check if array has more than 2 elements
		if [[ curr_option_size -gt 2 ]]; then
			# If array has more than 2
			func_params=(${curr_option[@:3]})
			full_cmd+="${func_params[@]}"
		fi
	done

	: "
		Execute Option
	"
	$func && \
		echo -e "Command [$func] executed successfully" || \
		echo -e "Error executing Command [$func]"

	echo ""
	echo -e "================================================"
	echo ""

	: "
		Return back to menu
	"
	menu
}

main()
{
	: " 
		Make menu
	"

	# --- Body
	echo -e "[Terminal Package Manager (TPM)]"
	echo -e "Welcome to the TPM!"

	echo ""

	: "
		- Initiate Menu
	"
 	menu
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main
fi