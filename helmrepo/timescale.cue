package homelab

helmrepo: timescale: {
	metadata: {
		name:      "timescale"
		namespace: "data"
	}
	spec: {
		url: "https://charts.timescale.com"
	}
}
