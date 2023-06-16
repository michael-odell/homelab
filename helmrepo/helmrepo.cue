package homelab

helmrepo: [NAME=_]: {
	#FluxHelmRepo

	metadata: name: NAME
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
		url:      string
	}
}
