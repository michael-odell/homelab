package homelab

kubernetes: namespace: [NAME=_]: {
	metadata: name: NAME
	metadata: labels: "kubernetes.io/metadata.name": NAME

	#KubernetesNamespace
}

#KubernetesNamespace: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: {
			"kubernetes.io/metadata.name": string
			"secrets-injection":           "enabled"
			...
		}
		name: string
	}
}

kubernetes: namespace: {
	storage: {}
	secrets: {}
	network: {}
	ha: {}
	mon: {}
	data: {}
}
