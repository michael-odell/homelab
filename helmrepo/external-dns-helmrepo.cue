package homelab

helmRepository: "external-dns": {
	name: "external-dns"
	url:  "https://kubernetes-sigs.github.io/external-dns"
}

helmrepo: "external-dns": {
	metadata: {
		name:      "external-dns"
		namespace: "network"
	}
	spec: {
		url: "https://kubernetes-sigs.github.io/external-dns"
	}
}
