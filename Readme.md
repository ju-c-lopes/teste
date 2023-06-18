# Virtual Environment Choice


<br>This script ([Anaconda](./choice-env-anaconda.sh) | [venv](./choice-env-venv.sh)) allows the user make a choice between virtual environments for anaconda or python venv by the time they start a terminal window<br><br>

For this, the user must include this script to the end of <code>.bashrc</code> file in your Ubuntu (the one operation system that has been tested).<br><br>

Following the steps:

* open the <code>.bashrc</code> file with: <code>sudo nano ~/.bashrc</code>
* <code>CTRL + End</code> to go to the end of file
* Copy and paste the script at the end of file and make the changes according to their user
* <code>CTRL + X</code> to be asked to save the file
* Click <code>Y</code> to confirm

Then, in your terminal window, type the command:
* <code>source .bashrc</code> to update or close and open a terminal window again.

In case you use Anaconda, it must be installed too.<br><br>

The Script will read the environments that are defined and will include a new one in case it finds one.<br><br>

Next, it show the options to user, who will make their choice.<br><br>

OBS: In case the terminal is an vscode terminal integrated, the script will select the interpreter python that user defined as default or will deliver the default prompt if not.

<hr>
