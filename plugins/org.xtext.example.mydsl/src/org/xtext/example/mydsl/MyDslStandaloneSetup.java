
package org.xtext.example.mydsl;

import org.xtext.example.mydsl.generator.CommandLineOptions;

import com.google.inject.Guice;
import com.google.inject.Injector;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class MyDslStandaloneSetup extends MyDslStandaloneSetupGenerated{

	CommandLineOptions options;
	
	public static void doSetup() {
		new MyDslStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
	
	public Injector createInjectorAndDoEMFRegistration(CommandLineOptions options) {
		this.options = options;
		return super.createInjectorAndDoEMFRegistration();
	}
	
	public Injector createInjector() {
		return Guice.createInjector(new org.xtext.example.mydsl.MyDslRuntimeModule(options));
	}
	
}

