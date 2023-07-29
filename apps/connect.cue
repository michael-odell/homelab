package apps

connect: {
	namespace: "secrets"

	helmRepository: {
		name: "onepassword"
		url:  "https://1password.github.io/connect-helm-charts"
	}

	values: {
		// ref: https://github.com/1Password/connect-helm-charts/tree/main/charts/connect
		operator: {
			create: true

			// Operator will restart pods when secret changes (on poll that discovers update)
			autoRestart: true

			pollingInterval: 600

			token: {
				// This secret configured by bless-1password script
				name: "connect"
				key:  "token"
			}
		}

		connect: {
			create: true

			// This secret is set up by the bless-1password script
			credentialsName: "opcreds"
			credentialsKey:  "json"

			serviceType: "ClusterIP"
		}
	}
}
