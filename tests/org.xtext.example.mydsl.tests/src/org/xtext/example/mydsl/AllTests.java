package org.xtext.example.mydsl;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;
import org.xtext.example.mydsl.generator.MyDslCTest;

@RunWith(Suite.class)
@SuiteClasses({ 
	ParserTest.class,
	MyDslCTest.class
})
public class AllTests {

}
