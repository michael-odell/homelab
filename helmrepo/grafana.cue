package homelab

helmrepo: grafana: {
	metadata: {
		name:      "grafana"
		namespace: "mon"
	}
	spec: {
		url: "https://grafana.github.io/helm-charts"
	}
}
