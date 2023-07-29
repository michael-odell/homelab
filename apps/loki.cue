package apps

loki: {
	namespace: "mon"
	chartName: "loki-stack"

	helmRepository: {
		name: "grafana"
		url:  "https://grafana.github.io/helm-charts"
	}

	values: {
		// overall loki-stack ref: https://github.com/grafana/helm-charts/blob/main/charts/loki-stack/values.yaml
		// grafana readme: https://github.com/grafana/helm-charts/tree/main/charts/grafana
		// grafana values: https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml
		grafana: {
			enabled: false
		}

		// Whether loki should present itself as the _default_ data source to grafana
		isDefault: false

		// loki values: https://github.com/grafana/helm-charts/blob/loki-2.15.2/charts/loki/values.yaml
		loki: {
			replicas: 2
			persistence: {
				enabled:          true
				storageClassName: "openebs-lvm"
				accessModes: [
					"ReadWriteOnce",
				]
				size: "50Gi"
			}

			serviceMonitor: enabled: true

			podManagementPolicy: "Parallel"
		}
	}
}
