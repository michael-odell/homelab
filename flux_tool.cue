package homelab

import (
	"tool/file"
	"encoding/yaml"
)

let _FLUX = flux
command: flux: {

	fluxOutputDirectory: "tmp"
	mkdir:               file.MkdirAll & {
		path: fluxOutputDirectory
	}

	for h in _FLUX.helmrepo {
		let name = h.metadata.name
		"\(name)": file.Create & {
			$after:   mkdir
			filename: "\(fluxOutputDirectory)/\(name).yaml"
			contents: yaml.Marshal(h)
		}
	}
}
