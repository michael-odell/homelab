package homelab

helmApp: "cert-manager": {
	namespace: "network"

	helmRepository: {
		name: "cert-manager"
		url:  "https://charts.jetstack.io"
	}

	// ref: https://github.com/jetstack/cert-manager/blob/master/deploy/charts/cert-manager/values.yaml
	values: {
		installCRDs: true

		// TODO: Enable servicemonitor once I can
		prometheus: {
			servicemonitor: enabled: false
		}
	}
}
