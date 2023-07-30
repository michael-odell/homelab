package homelab

#RawKubernetesManifests: [APIVERSION=_]: [KIND=_]: [NAME=_]: {
	apiVersion: APIVERSION
	kind:       KIND

	metadata: {
		name: NAME
		...
	}

	#RawKubernetesManifest
}

#RawKubernetesManifest: {
	apiVersion: string
	kind:       string
	metadata: {
		name: string
	}
	...
}
