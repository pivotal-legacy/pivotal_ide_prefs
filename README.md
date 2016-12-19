# Pivotal IDE Prefs

[![Code Climate](https://codeclimate.com/github/pivotal/pivotal_ide_prefs.png)](https://codeclimate.com/github/pivotal/pivotal_ide_prefs)

This repo provides both a superset of the Mac OS X 10.5+ keybindings for JetBrains IDEs, as well as a team-centric workflow for tracking and syncing IDE customizations over time.

## Requires

To run the installer, you will need Ruby 2.0+.

## History

Once upon a time, RubyMine shipped with keybindings that made no sense to anyone who had ever used a Mac. Hence, the Pivotal RubyMine preferences were born. Originally just a project for managing RubyMine preferences, it now includes preferences for multiple JetBrains IDEs. For each IDE, we offer:

* Keymaps (powerful supersets of the JetBrains Mac OS X 10.5+ default keybindings)
* Pivotal Code Styles
* Live Templates

Today, this project is not only a repository of Pivotal's preferences for Jetbrains IDEs – it's also a recommended workflow for tracking your team's customizations to IDE preferences. 

## Installation ##

First, *close your Jetbrains IDE*. 

Then, run the following commands:

```sh
git clone https://github.com/pivotal/pivotal_ide_prefs
cd pivotal_ide_prefs
cli/bin/ide_prefs install --ide=intellij
# ide flag can be any of [rubymine,intellij,intellijcommunity,webstorm,androidstudio,appcode,clion,pycharm]
```

This will install the preferences into your IDE of choice. 

## Tracking changes ##

The installation process symlinks the pivotal preferences into your IDE's preferences folder. Thus, as you and 
your team change your preferences inside your IDE, your clone of the preferences will note the changes, and you can
commit and push those changes to your own fork (or even submit pull requests back to the Pivotal repo for anything
you think is generally useful).

## Uninstall ##

If you'd like to uninstall the pivotal preferences and restore your original settings, first, *close your IDE*. 
Then open a terminal and run the following commands:

```sh
cd /path/to/your/pivotal_ide_prefs/cli
bin/ide_prefs --ide=[rubymine,intellij,intellijcommunity,androidstudio,appcode,clion,pycharm] uninstall
```

## Contributing New Preferences

If you'd like to add preferences for another IDE, simply: 

0. Create a new folder in the `pref_sources` directory, and add any preferences to it that you want to manage for that IDE into the appropriate folders that the IDE calls for. See the existing folders there for examples.
0. Create a new <IdeName>UserPrefDir class inside cli/lib/cli/ide. This class must respond to a single method, `#path`, which tells the installer where to install the preferences to on the system.
0. Modify `cli/bin/ide_prefs.rb` to include the IDE
0. Update the README, indicating that another IDE has been added to the installer. 

## Migrating from Pivotal-Preferences-RubyMine

If your team is already maintaining their rubymine preferences via the now-deprecated Pivotal-Preferences-RubyMine, simply do the following to migrate:

1. Close RubyMine.
2. Uninstall the old prefs:

        cd /path/to/your/Pivotal-Preferences-RubyMine
        ./mineprefs uninstall

3. Copy your old prefs into pivotal\_ide\_prefs. 

        cd /path/to/your/pivotal_ide_prefs
        cp -r /path/to/your/Pivotal-Preferences-RubyMine/RubyMineXX/* pref_sources/RubyMine/

4. Re-install your preferences using `pivotal_ide_prefs` (see the Installation section above).

## TODO

* ~~Install command~~
* ~~Uninstall command~~
* ~~Make commands Idempodent~~
* ~~Basic Logging~~
* ~~Specify log levels at the command line~~
* ~~IntelliJ prefs~~
* ~~Appcode prefs~~
* ~~PyCharm prefs~~
* ~~WebStorm prefs~~
