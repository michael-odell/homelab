package apps

"smb-csi": {
	namespace: "storage"
	chartName: "csi-driver-smb"

	helmRepository: {
		name: "smb-csi"
		url:  "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
	}

	flux: kubernetes: {
		v1: Service: "smb-csi": {
			// Chart doesn't support ServiceMonitors and prometheus metrics, but the tool does.  I started with
			// example from https://github.com/kubernetes-csi/csi-driver-smb/tree/master/deploy/example/metrics
			apiVersion: "v1"
			kind:       "Service"
			metadata: {
				name:      "smb-csi"
				namespace: "storage"
			}
			spec: {
				selector: app: "smb-csi"
				ports: [{
					port:       29644
					targetPort: 29644
				}]
				type: "ClusterIP"
			}
		}
	}
}
