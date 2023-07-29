package homelab

#HelmRepository: {
	name: #DnsSafeName

	// URLs for helm repos shouldn't end in slash
	url: string & =~"^https?://.*[^/]$"
}

#FluxHelmRepository: {
	apiVersion: "source.toolkit.fluxcd.io/v1beta2"
	kind:       "HelmRepository"

	metadata: {
		name:      string
		namespace: string | "flux-system"
	}

	spec: {
		// TODO probably move them all to same interval, too
		interval: string | *"12h"

		// URLs for helm repos shouldn't end in slash
		url: string & =~"^https?://.*[^/]$"
	}
}
