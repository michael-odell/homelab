package homelab

helmRepository: openebs: {
	name: "openebs"
	url:  "https://openebs.github.io/charts"
}

helmrepo: openebs: {
	metadata: {
		name:      "openebs"
		namespace: "storage"
	}
	spec: {
		url: "https://openebs.github.io/charts"
	}
}
