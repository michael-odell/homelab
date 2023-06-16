package homelab

helmrepo: jetstack: {
	metadata: {
		name:      "jetstack"
		namespace: "network"
	}
	spec: {
		url: "https://charts.jetstack.io"
	}
}
