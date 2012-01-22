#!/usr/bin/env python 

import os
import subprocess
import sys
import string

def fileIsNewerThan(file, dependentFile):
	return (not os.path.exists (dependentFile)) or os.path.getmtime(file)>os.path.getmtime(dependentFile)

def createLocalRepositoryIfNotUpToDate ():
	if (fileIsNewerThan ('../../releng/org.xtext.example.repository/category.xml', 
	                    '../../releng/org.xtext.example.repository/target/category.xml') or
	   fileIsNewerThan ('../../releng/org.xtext.example.targetplatform/xtextexample.target', 
					    '../../releng/org.xtext.example.repository/target/category.xml')): 
		print 'Rebuild of repository required'
		subprocess.call ("cd ../../releng/org.xtext.example.repository && mvn package", shell=True)
	else:
		print 'Repository is up to date'

def runMaven():
	s = 'mvn ' + string.join (sys.argv[1:], ' ')
	print "Calling " + '"' + s + '"'
	subprocess.call (s, shell=True)
	
createLocalRepositoryIfNotUpToDate()
runMaven()
