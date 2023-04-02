#      ╔╦╦╦╦═╦══╦═╦══╦╗
#      ║║║║║║╠╣╠╣═╣░░║║
#      ║║║║║╩║║║║═╣╔╗╣║
#      ║╚══╩╩╝╚╝╚═╩╝╚╝║
#      ╚══════════════╝

# This is the installation file to use in Water Installer
# to implement

# load all the dependencies



# import the necessary packages
import curses
import sys
import subprocess



# init curses
stdscr = curses.initscr()

# define the functions
def message(text):
	stdscr.addstr(0, 0, text)
	# Refresh the screen to show the message
	stdscr.refresh()
	# Wait for user input
	stdscr.getch()


def init_color_pair(color):
    # Define color pairs
    curses.start_color()
    if color == "black":
        curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_BLACK)
    elif color == "red":
        curses.init_pair(1, curses.COLOR_RED, curses.COLOR_BLACK)
    elif color == "green":
        curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)
    elif color == "yellow":
        curses.init_pair(1, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    elif color == "blue":
        curses.init_pair(1, curses.COLOR_BLUE, curses.COLOR_BLACK)
    elif color == "magenta":
        curses.init_pair(1, curses.COLOR_MAGENTA, curses.COLOR_BLACK)
    elif color == "cyan":
        curses.init_pair(1, curses.COLOR_CYAN, curses.COLOR_BLACK)
    elif color == "white":
        curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_BLACK)
    elif color == "orange":
        curses.init_pair(1, curses.COLOR_YELLOW, curses.COLOR_RED)
    elif color == "purple":
        curses.init_pair(1, curses.COLOR_MAGENTA, curses.COLOR_BLUE)

def print_center(string, fg_color):
    stdscr.clear()


    # Get screen dimensions
    rows, cols = stdscr.getmaxyx()

    # Define color pair
    curses.start_color()
    init_color_pair(fg_color)

    # Set color for text
    stdscr.attron(curses.color_pair(1))

    # Split the string into lines
    lines = string.splitlines()

    # Calculate center coordinates
    x = int(cols / 2)
    y = int(rows / 2) - int(len(lines) / 2)

    # Print each line in the center of the screen
    for line in lines:
        stdscr.addstr(y, x - int(len(line) / 2), line)
        y += 1

    # Refresh the screen to show the message
    stdscr.refresh()


def print_cool(text,color, input = 'char'):
	logo = '''

                            :+*++##**:            
                        :+############++          
                      :*#################:::      
                     *######################*:    
                   +#*+++:++*#################*   
                  *#+:::::::::+################*  
                 *#+:::::::::: +################+ 
                *#+::::::::::::##################:
               *#+::::::::::#####################+
             :#*+:::::::::::+###*################*
            *#+::::::::::::::::::***######*####*+ 
          +#*::::::::::::::::::::::::++*+*##+::   
        :**:::::::::::::::::::::::::::            
      :++::::::::::::::::::::::::::::::           
    :::::::::::::::::::::::::::::::::::::         
   ::::::::::::::::::::::::::::::::::::::::       
                                                  
	'''
	ans = logo
	ans += text
	print_center(ans,color)


	if input == 'char':
		stdscr.getch()
	else:
		pass


def display_sh_output(stdscr, command):
    # Clear the screen
    stdscr.clear()

    # Set the dimensions of the output window to be 30% of the terminal size
    max_y, max_x = stdscr.getmaxyx()
    output_y = int(max_y * 0.3)
    output_x = int(max_x)

    # Create a window for displaying the output
    output_window = curses.newwin(output_y, output_x, 0, 0)
    output_window.border()

    # Run the command and capture its output
    output = subprocess.check_output(command, shell=True).decode()

    # Display the output in the output window
    output_lines = output.split("\n")
    for i in range(min(output_y-2, len(output_lines))):
        output_window.addstr(i+1, 1, output_lines[i][:output_x-2])

    # Refresh the screen to show the output window
    stdscr.refresh()
    output_window.refresh()



def sprint(text):
	print(text)
	cat @(text) >> Log.txt





# the actual code
print_cool("This is the official Water Linux installer.","green")


# configure the Internet
print_cool("you will need to have internet connection to install water linux","blue")
systemctl start networkmanager &
nmtui
stdscr.clear()

# Clean up ncurses
curses.endwin()



sprint("install the keyrings")
pacman -S archlinux-keyring


# install arch linux and get the best configuration
archinstall



sprint("===== copying the files that will need in our installation")
cp -r InstallChroot.xsh /mnt/archinstall


# install necessary packages that we need to use the script
pacstrap /mnt/archinstall base base-devel git xonsh python


# run the installation file 
arch-chroot /mnt/archinstall xonsh InstallChroot.xsh




