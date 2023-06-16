package homelab

helmrepo: "prometheus-community": {
	metadata: {
		name:      "prometheus-community"
		namespace: "mon"
	}
	spec: {
		url: "https://prometheus-community.github.io/helm-charts"
	}
}
