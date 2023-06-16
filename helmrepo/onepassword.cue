package homelab

helmrepo: onepassword: {
	metadata: {
		name:      "onepassword"
		namespace: "secrets"
	}
	spec: {
		url: "https://1password.github.io/connect-helm-charts"
	}
}
