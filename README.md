# Pivotal IDE Prefs

This repo provides both a superset of the Mac OS X 10.5+ keybindings for JetBrains IDEs, it also gives your team a workflow to track team-specific IDE preferences over time.

## Requires

To run the installer, you will need Ruby 2.0+.

## History

Once upon a time, RubyMine shipped with keybindings that made no sense to anyone who had ever used a Mac. Hence, the Pivotal RubyMine preferences were born. Originally just a project for managing RubyMine preferences, it now includes prefernces for multiple JetBrains IDEs. For each IDE, we offer:

* Keymaps (powerful supersets of the JetBrains Mac OS X 10.5+ default keybindings)
* Pivotal Code Styles
* Live Templates

Today, this project is not only a repository of Pivotal's preferences for Jetbrains IDEs – it's also a recommended workflow for tracking your team's customizations to IDE preferences. 

## Installation ##

First, *close your Jetbrains IDE*. 

Then, run the following commands:

```sh
git clone https://github.com/pivotal/pivotal_ide_prefs
cd pivotal_ide_prefs/cli
bin/ide_prefs --ide=[rubymine,intellij] install
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
bin/cli --ide=[rubymine,intellij] uninstall
```

## TODO

* ~~Install command~~
* ~~Uninstall command~~
* ~~Make commands Idempodent~~
* Logging
