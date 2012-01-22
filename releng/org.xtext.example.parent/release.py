#!/usr/bin/env python 

import os
import subprocess
import sys
import string
import argparse
import subprocess

def echo (s):
	print ("[### Release ###] " + s)
	
def call (s):
	echo (s)
	result = subprocess.check_call(s, shell=True)
	if result > 0:
		sys.exit ("Command " + s + "returned " + result)
		
def isGitWorikingDirectoryClean():
	cmd = subprocess.Popen('git status --porcelain', shell=True, stdout=subprocess.PIPE)
	for line in cmd.stdout:
		return False
	return True
	
def revertChanges():
	call ("git clean -f ../..")
	call ("git reset --hard HEAD")
	
projectName = "org.xtext.example"
releaseDir = projectName + ".releases"
updatesiteDir = projectName + ".updatesite"

# Parse command line options

parser = argparse.ArgumentParser(description='Run a release build for "' + projectName +'"')
parser.add_argument('releaseVersion', metavar='RV', help='the version number for the release, e.g. 1.0.0')
parser.add_argument('devVersion', metavar='DV', help='the version number for the next development cycle, e.g. 2.0.0. Do not add SNAPSHOT to it, this will be done automatically')
parser.add_argument('--dry-run', dest='dryRun', action='store_true',
                   help='do a dry run (do not checkin changes into git, revert all changes after the release script is done). Do this to verify the release will be successfull beforing doing it.')
args = parser.parse_args()

echo ("Release version: " + args.releaseVersion + ", development version: " + args.devVersion + "-SNAPSHOT")
if args.dryRun:
	echo ("Dry run, no changes will be committed")

if isGitWorikingDirectoryClean():

	# Doing the release
	
	echo ("Set new version to release version " + args.releaseVersion)
	call ("mvn org.eclipse.tycho:tycho-versions-plugin:set-version -DnewVersion=" + args.releaseVersion)
	call ("sed -i .bak 's/.qualifier//g' ../" + updatesiteDir + "/category.xml")
	call ("./build.py clean verify")
	call ("mv ../" + updatesiteDir + "/target/" + updatesiteDir + ".zip ../" + releaseDir + "/" + releaseDir + "-" + args.releaseVersion + ".zip")
	
	if not args.dryRun:
		call ("git commit -a -m '[release]	Release " + args.releaseVersion + "'")
		call ("git tag v" + args.releaseVersion)
	
	# Setting the development version
	
	echo ("Set new version to development version " + args.devVersion + "-SNAPSHOT")
	call ("mvn org.eclipse.tycho:tycho-versions-plugin:set-version -DnewVersion=" + args.devVersion + "-SNAPSHOT")
	call ('sed -i .bak "s/' + args.releaseVersion + '/' + args.devVersion + '\.qualifier/g" ../' + updatesiteDir + '/category.xml')
	call ("./build.py clean verify")
	
	if not args.dryRun:
		call ("git commit -a -m '[release] Set version to " + args.devVersion + "-SNAPSHOT'")
	
	# Success message
	
	echo ("Release " + args.releaseVersion + " successfully created")
	echo ("Current version is now " + args.devVersion + "-SNAPSHOT")

	if args.dryRun:
		revertChanges()
	if isGitWorikingDirectoryClean():
		echo ("Your working directory is clean")
else:

	echo ("Your working directory is not clean, aborting...")
