Ruby automation - Instructuions to run :

(The setup assumes you are running on a Mac OS system and you have ruby installed. If this is not the case, minor changes will be required.)

1. Unzip the file

2. Use gem install to install the automation_wizard: gem install automation_wizard

3. Go inside the file directory in the terminal and enter the command: 'bundle install'
                                                               'bundle update'

4. To run the project, go inside the directory of the project and enter the command: 

    'bundle exec rake FEATURE=features/loblaws_test.feature'

5. You'll need chromedriver to help with the automation. If chromedriver is not installed, use Brew to install the driver. You can use brew list to list the installed packages on your computer. If chromedriver is not listed then install it with command: 'brew install chromedriver'




