package homelab

helmrepo: openebs: {
	metadata: {
		name:      "openebs"
		namespace: "storage"
	}
	spec: {
		url: "https://openebs.github.io/charts"
	}
}
