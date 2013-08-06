package org.xtext.example.mydsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.xtext.example.mydsl.myDsl.Model

class MyDslGenerator implements IGenerator {
	
	override void doGenerate(Resource it, IFileSystemAccess fsa) {
        fsa.generateFile(fileName, toTxtFile(it.contents.head as Model))
	}

	def fileName(Resource res) {
        res.URI.lastSegment.replaceAll("\\.mydsl", ".txt")
    }

	def toTxtFile(Model model) '''
		This is an example of a generated file.

		All greetings:
		«FOR greeting : model.greetings»
		«greeting.name»
		«ENDFOR»
		'''
}
