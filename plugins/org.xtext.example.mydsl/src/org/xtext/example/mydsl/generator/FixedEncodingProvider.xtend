package org.xtext.example.mydsl.generator

import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.emf.common.util.URI
import com.google.inject.Inject
import com.google.inject.name.Named

class FixedEncodingProvider implements IEncodingProvider {
	
	public val static ENCODING = "org.xtext.example.mydsl.generator.ConstantEncodingProvider.ENCODING"
	
	@Inject @Named(ENCODING)
	String encoding

	override getEncoding(URI uri) {
		encoding
	}
	
}