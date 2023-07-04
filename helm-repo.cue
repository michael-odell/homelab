package homelab

helmRepository: [NAME=_]: {
	#HelmRepository
}

#HelmRepository: {
	name: #DnsSafeName

	// URLs for helm repos shouldn't end in slash
	url: string & =~"^https?://.*[^/]$"
}

#FluxHelmRepo: {
	apiVersion: "source.toolkit.fluxcd.io/v1beta2"
	kind:       "HelmRepository"

	metadata: {
		name: string
		// TODO move all of them to flux-system
		namespace: string | "flux-system"
	}

	spec: {
		// TODO probably move them all to same interval, too
		interval: string | *"12h"

		// URLs for helm repos shouldn't end in slash
		url: string & =~"^https?://.*[^/]$"
	}
}
