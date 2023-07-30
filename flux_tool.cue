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
