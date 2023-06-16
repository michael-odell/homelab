package homelab

helmRepository: "prometheus-community": {
	name: "prometheus-community"
	url:  "https://prometheus-community.github.io/helm-charts"
}

helmrepo: "prometheus-community": {
	metadata: {
		name:      "prometheus-community"
		namespace: "mon"
	}
	spec: {
		url: "https://prometheus-community.github.io/helm-charts"
	}
}
