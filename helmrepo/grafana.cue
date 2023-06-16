package homelab

helmRepository: grafana: {
	name: "grafana"
	url:  "https://grafana.github.io/helm-charts"
}

helmrepo: grafana: {
	metadata: {
		name:      "grafana"
		namespace: "mon"
	}
	spec: {
		url: "https://grafana.github.io/helm-charts"
	}
}
