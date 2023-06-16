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

kubernetes: namespace: storage: {
	metadata: {
		name: "storage"
	}
}
kubernetes: namespace: secrets: {
	metadata: {
		name: "secrets"
	}
}
kubernetes: namespace: network: {
	metadata: {
		name: "network"
	}
}
kubernetes: namespace: ha: {
	metadata: {
		name: "ha"
	}
}
kubernetes: namespace: mon: {
	metadata: {
		name: "mon"
	}
}
kubernetes: namespace: data: {
	metadata: {
		name: "data"
	}
}
