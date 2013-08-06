package org.xtext.example.mydsl.generator

import org.xtext.example.mydsl.MyDslStandaloneSetup
import com.google.inject.Inject
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.JavaIoFileSystemAccess
import org.eclipse.xtext.validation.IResourceValidator
import org.eclipse.emf.ecore.resource.ResourceSet
import com.google.inject.Provider
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.validation.CheckMode
import org.eclipse.xtext.util.CancelIndicator
import org.eclipse.emf.ecore.resource.Resource
import java.util.Collection

class MyDslC {

	@Inject
	CommandLineOptions options

	@Inject
	IGenerator generator

	@Inject
	Provider<ResourceSet> resourceSetProvider

	@Inject
	IResourceValidator validator

	@Inject
	JavaIoFileSystemAccess fileAccess

	def static void main(String[] args) {
		System.exit (run(args))
	}

	def static int run(String[] args) {
		val injector = new MyDslStandaloneSetup().createInjectorAndDoEMFRegistration().
			createChildInjector(new MyDslCModule);
		val generator = injector.getInstance(MyDslC)
		generator.generate(args)
	}

	def int generate(String[] args) {
		if (options.parse(args)) {
			if (options.hasHelp) {
				options.printHelpMessage
				return 0
			} else {
				val resources = readResources ()
				if (validateResources(resources)) {
					generate(resources)			
					return 0
				}
			}
		}
		return 1
	}
 
	def readResources () {
		val rs = resourceSetProvider.get()
		options.inputFiles.map [ f | rs.getResource(URI.createFileURI(f.canonicalPath), true) ].toSet
	}
	
	def validateResources (Collection<Resource> resources) {
		resources.fold(true,  [ rv, resource |
			val issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl)
			if (!issues.isEmpty()) {
				issues.forEach [ System.err.println(it) ]
				return false
			}
			rv
		])
	}
	
	def generate (Collection<Resource> resources) {
		fileAccess.setOutputPath(options.outputPath.canonicalPath)
		resources.forEach [
			generator.doGenerate(it, fileAccess)
		]
	}
}