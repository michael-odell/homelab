package homelab

helmApp: "external-dns": {
	namespace: "network"

	helmRepository: {
		name: "external-dns"
		url:  "https://kubernetes-sigs.github.io/external-dns"
	}

	// ref: https://github.com/kubernetes-sigs/external-dns/blob/master/charts/external-dns/values.yaml
	values: {
		policy:     "sync"
		txtPrefix:  "externaldns-"
		txtOwnerId: "homelab"
		provider:   "aws"
		env: [{
			name: "AWS_ACCESS_KEY_ID"
			valueFrom: secretKeyRef: {
				name: "aws-certbot"
				key:  "access_key"
			}
		}, {
			name: "AWS_SECRET_ACCESS_KEY"
			valueFrom: secretKeyRef: {
				name: "aws-certbot"
				key:  "secret_key"
			}
		}]
	}
}
