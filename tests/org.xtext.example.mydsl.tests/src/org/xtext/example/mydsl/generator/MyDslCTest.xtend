package org.xtext.example.mydsl.generator

import org.junit.Test

import static org.junit.Assert.*
import org.junit.Rule
import org.junit.rules.TemporaryFolder
import java.io.File
import org.xtext.example.mydsl.generator.MyDslC

class MyDslCTest {

	@Rule
	public var temporaryFolder = new TemporaryFolder()

	@Test
	def void testOk () {
		assertEquals (0, MyDslC.run("-outputDir", temporaryFolder.root.path, "models/test.mydsl"))
		assertTrue (new File (temporaryFolder.root, "test.txt").exists)
	}		

	@Test
	def void testUtf8Ok () {
		assertEquals (0, MyDslC.run("-encoding", "UTF-8", "-outputDir", temporaryFolder.root.path, "models/testUTF8.mydsl"))
		assertTrue (new File (temporaryFolder.root, "testUTF8.txt").exists)
	}		
	
	@Test
	def void testUtf8WithoutEncodingNotOk () {
		assertEquals (1, MyDslC.run("-outputDir", temporaryFolder.root.path, "models/testUTF8.mydsl"))
	}		

	@Test
	def void testNoArgs () {
		assertEquals (1, MyDslC.run())
	}

	@Test
	def void testHelp () {
		assertEquals (0, MyDslC.run("-help"))
	}

	@Test
	def void testNoInputFiles () {
		assertEquals (1, MyDslC.run("-outputDir", temporaryFolder.root.path))
	}		

	@Test
	def void testInvalidInputFile () {
		assertEquals (1, MyDslC.run("-outputDir", temporaryFolder.root.path, "models/_test.mydsl"))
	}
}