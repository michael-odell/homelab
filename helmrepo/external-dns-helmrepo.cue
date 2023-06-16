package homelab

helmrepo: "external-dns": {
	metadata: {
		name:      "external-dns"
		namespace: "network"
	}
	spec: {
		url: "https://kubernetes-sigs.github.io/external-dns"
	}
}
