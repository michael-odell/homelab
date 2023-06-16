package homelab

helmRepository: "smb-csi": {
	name: "smb-csi"
	url:  "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
}

helmrepo: "smb-csi": {
	metadata: {
		name:      "smb-csi"
		namespace: "storage"
	}
	spec: {
		url: "https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"
	}
}
