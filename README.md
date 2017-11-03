# Mavenlink IDE Prefs

This repo provides both a superset of the Mac OS X 10.5+ keybindings for JetBrains IDEs, as well as a team-centric workflow for tracking and syncing IDE customizations over time. It is forked from Pivotal IDE Prefs.

## Requires

To run the installer, you will need Ruby 2.0+.

## History

Once upon a time, RubyMine shipped with keybindings that made no sense to anyone who had ever used a Mac. Hence, the Pivotal RubyMine preferences were born. Originally just a project for managing RubyMine preferences, it now includes preferences for multiple JetBrains IDEs. For each IDE, we offer:

* Keymaps (powerful supersets of the JetBrains Mac OS X 10.5+ default keybindings)
* Pivotal Code Styles
* Live Templates

Today, this project is not only a repository of Pivotal's preferences for Jetbrains IDEs – it's also a recommended workflow for tracking your team's customizations to IDE preferences. 

This is a forked copy with some small changes for internal use by Mavenlink employees.

## Installation ##

First, *close your Jetbrains IDE*. 

Then, run the following commands:

```sh
git clone https://github.com/mavenlink/mavenlink_ide_prefs
cd mavenlink_ide_prefs/cli
bin/ide_prefs --ide=rubymine install
```

This will install the preferences into your IDE of choice. 

## Tracking changes ##

The installation process symlinks the Mavenlink Synced preferences into your IDE's preferences folder. Thus, as you and 
your team change your preferences inside your IDE, your clone of the preferences will note the changes, and you can
commit and push those changes to your own fork (or even submit pull requests back to the Mavenlink repo for anything
you think is generally useful).

## Uninstall ##

If you'd like to uninstall the preferences and restore your original settings, first, *close your IDE*. 
Then open a terminal and run the following commands:

```sh
cd /path/to/your/mavenlink_ide_prefs/cli
bin/ide_prefs --ide=[rubymine,intellij,intellijcommunity,androidstudio,appcode,pycharm] uninstall
```

## Contributing New Preferences

If you'd like to add preferences for another IDE, simply: 

0. Create a new folder in the `pref_sources` directory, and add any preferences to it that you want to manage for that IDE into the appropriate folders that the IDE calls for. See the existing folders there for examples.
0. Create a new <IdeName>UserPrefDir class inside cli/lib/cli/ide. This class must respond to a single method, `#path`, which tells the installer where to install the preferences to on the system.
0. Modify `cli/bin/ide_prefs.rb` to include the IDE
0. Update the README, indicating that another IDE has been added to the installer. 
