package org.xtext.example.mydsl.generator;

import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;

public class CommandLineOptionsJavaHelper {

	@SuppressWarnings("static-access")
	public static Option getOutputDirOption() {
		return OptionBuilder.
				withArgName("directory")
				.withDescription("Generator output directory")
				.hasArg()
				.withValueSeparator(' ')
				.create("outputDir");
	}

	@SuppressWarnings("static-access")
	public static Option getEncodingOption() {
		return OptionBuilder
				.withArgName("encoding")
				.hasArg()
				.withValueSeparator(' ')
				.withDescription(
					"Encoding of the input files, defaults to "
					+ System.getProperty("file.encoding"))
				.create("encoding");
	}
}
