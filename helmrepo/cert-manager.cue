package homelab

// TODO rename to cert-manager
helmRepository: jetstack: {
	name: "jetstack"
	url:  "https://charts.jetstack.io"
}

helmrepo: jetstack: {
	metadata: {
		name:      "jetstack"
		namespace: "network"
	}
	spec: {
		url: "https://charts.jetstack.io"
	}
}
