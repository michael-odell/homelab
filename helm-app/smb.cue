package homelab

helmApp: "smb-csi": {
	namespace: "storage"
	chartName: "csi-driver-smb"

	helmRepository: {
		name: "smb-csi"
		url:  "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
	}
}
