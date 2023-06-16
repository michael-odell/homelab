package homelab

helmRepository: timescale: {
	name: "timescale"
	url:  "https://charts.timescale.com"
}

helmrepo: timescale: {
	metadata: {
		name:      "timescale"
		namespace: "data"
	}
	spec: {
		url: "https://charts.timescale.com"
	}
}
