package homelab

helmRepository: onepassword: {
	name: "onepassword"
	url:  "https://1password.github.io/connect-helm-charts"
}

helmrepo: onepassword: {
	metadata: {
		name:      "onepassword"
		namespace: "secrets"
	}
	spec: {
		url: "https://1password.github.io/connect-helm-charts"
	}
}
