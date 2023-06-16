package homelab

import (
	"tool/file"
	"encoding/yaml"
)

command: flux: {

	fluxOutputDirectory: "tmp"
	mkdir:               file.MkdirAll & {
		path: fluxOutputDirectory
	}

	for h in helmrepo {
		let name = h.metadata.name
		"\(name)": file.Create & {
			$after:   mkdir
			filename: "\(fluxOutputDirectory)/\(name).yaml"
			contents: yaml.Marshal(h)
		}
	}
}
