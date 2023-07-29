package apps

openebs: {
	namespace: "storage"
	helmRepository: {
		name: "openebs"
		url:  "https://openebs.github.io/charts"
	}

	values: {
		// NOTE: I might want to change to this top-level chart so I can get ndm and other related openebs
		// stuff: https://github.com/openebs/charts/tree/main/charts/openebs
		// ref: https://github.com/openebs/lvm-localpv/blob/develop/deploy/helm/charts/values.yaml
		"lvm-localpv": {
			enabled: true
		}
	}
}
