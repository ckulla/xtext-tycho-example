package org.xtext.example.mydsl.generator

import org.junit.Test

import static org.junit.Assert.*
import org.junit.Rule
import org.junit.rules.TemporaryFolder
import java.io.File

class MyDslCTest {

	@Rule
	public var temporaryFolder = new TemporaryFolder()

	@Test
	def void testOk () {
		assertEquals (0, MyDslC.run(<String>newArrayList("-outputDir", temporaryFolder.root.path, "models/test.mydsl")))
		assertTrue (new File (temporaryFolder.root, "test.txt").exists)
	}		
	
	@Test
	def void testNoArgs () {
		assertEquals (1, MyDslC.run(<String>newArrayList()))
	}

	@Test
	def void testHelp () {
		assertEquals (0, MyDslC.run(<String>newArrayList("-help")))
	}

	@Test
	def void testNoInputFiles () {
		assertEquals (1, MyDslC.run(<String>newArrayList("-outputDir", temporaryFolder.root.path)))
	}		

	@Test
	def void testInvalidInputFile () {
		assertEquals (1, MyDslC.run(<String>newArrayList("-outputDir", temporaryFolder.root.path, "models/_test.mydsl")))
	}
}