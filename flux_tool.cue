package homelab

import (
	"tool/file"
	"encoding/yaml"
)

let _FLUX = flux
command: flux: {

	fluxOutputDirectory: "tmp"

	for c in cluster {
		let CLUSTER_NAME = c.name

		"\(c.name)": {

			clusterDir: "\(fluxOutputDirectory)/\(CLUSTER_NAME)"
			mkdir:      file.MkdirAll & {
				path: clusterDir
			}

			for h in _FLUX.helmrepo {
				let name = h.metadata.name
				"\(name)": file.Create & {
					$after:   mkdir
					filename: "\(clusterDir)/\(name).yaml"
					contents: yaml.Marshal(h)
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
