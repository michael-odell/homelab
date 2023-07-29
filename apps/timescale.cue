package apps

timescale: {
	namespace: "data"
	chartName: "timescaledb-single"

	helmRepository: {
		name: "timescale"
		url:  "https://charts.timescale.com"
	}

	// ref: https://github.com/timescale/helm-charts/blob/main/charts/timescaledb-single/values.yaml
	values: {
		persistentVolumes: {
			data: {
				size:         "100Gi"
				storageClass: "openebs-lvm"
			}
			wal: {
				size:         "30Gi"
				storageClass: "openebs-lvm"
			}
		}

		resources: requests: {
			cpu:    "1"
			memory: "2Gi"
		}

		timescaledbTune: args: {
			cpus:   "1"
			memory: "2GB"
		}
	}
}
