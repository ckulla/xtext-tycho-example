package org.xtext.example.mydsl.generator;

import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;

public class CommandLineOptionsJava {

	@SuppressWarnings("static-access")
	public static Option getOutputDirOption() {
		return OptionBuilder.withArgName("directory")
				.withDescription("Generator output directory").hasArg()
				.withValueSeparator(' ').create("outputDir");
	}

}
