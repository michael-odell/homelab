package homelab

import (
	"tool/file"
	"encoding/yaml"
)

command: flux: {

	fluxOutputDirectory: "tmp"

	for c in cluster {
		let CLUSTER_NAME = c.name

		"\(c.name)": {

			clusterDir: "\(fluxOutputDirectory)/\(CLUSTER_NAME)"
			mkdir:      file.MkdirAll & {
				path: clusterDir
			}

			for app in helmApp {
				let name = app.releaseName
				let namespace = app.namespace

				"\(namespace)-\(name)": file.Create & {
					$after:   mkdir
					filename: "\(clusterDir)/\(namespace)-\(name).yaml"
					contents: yaml.MarshalStream([ app.flux.helmRelease, app.flux.helmRepository])
					//contents: yaml.MarshalStream([app.flux.helmRepository])
					//contents: yaml.MarshalStream([app.flux.helmRelease])
					//contents: yaml.Marshal(app.flux.helmRepository)
					//contents: yaml.Marshal(app.flux.helmRelease)
				}
			}

			ns: file.Create & {
				$after:   mkdir
				filename: "\(clusterDir)/ns.yaml"
				contents: yaml.MarshalStream([ for ns in kubernetes.namespace {ns}])
			}

		}
	}
}
