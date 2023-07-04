package homelab

helmApp: mon: {
	namespace: "mon"
	chartName: "kube-prometheus-stack"

	helmRepository: {
		name: "prometheus-community"
		url:  "https://prometheus-community.github.io/helm-charts"
	}

	values: {
		// Overall reference: https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
		alertmanager: {
			ingress: {
				annotations: "cert-manager.io/cluster-issuer": "letsencrypt-dns"
				enabled:          true
				ingressClassName: "traefik"
				hosts: [
					"mon.odell.sh",
				]
				paths: [
					"/alertmanager",
				]
				tls: [{
					hosts: [
						"mon.odell.sh",
					]
					secretName: "mon-tls"
				}]
			}

			alertmanagerSpec: {
				externalUrl: "http://mon.odell.sh/alertmanager/"
				routePrefix: "/alertmanager/"
			}
		}

		defaultRules: {
			rules: {
				kubeScheduler: false
				etcd:          false
			}

			disabled: {
				// Don't need this for now...
				Watchdog: true

				KubeAggregatedAPIDown: true
			}
		}

		// ref: https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml
		grafana: {
			enabled: true
			serviceMonitor: enabled: true

			ingress: {
				annotations: "cert-manager.io/cluster-issuer": "letsencrypt-dns"
				enabled:          true
				ingressClassName: "traefik"
				pathType:         "Prefix"
				hosts: [
					"mon.odell.sh",
				]
				paths: [
					"/grafana",
				]
				tls: [{
					hosts: [
						"mon.odell.sh",
					]
					secretName: "mon-tls"
				}]
			}

			//admin:
			//  existingSecret: "grafana-login"
			//  userKey: username
			//  passwordKey: password
			// Use when persistent volume is enabled
			deploymentStrategy: {
				type: "Recreate"
			}
			persistence: {
				enabled:          true
				type:             "pvc"
				storageClassName: "smb"
				accessModes: [
					"ReadWriteOnce",
				]
				size: "10Gi"
			}

			"grafana.ini": {
				server: {
					domain:              "mon.odell.sh"
					root_url:            "%(protocol)s://%(domain)s:%(http_port)s/grafana/"
					serve_from_sub_path: true
					enable_gzip:         true
				}

				analytics: check_for_updates: false
			}

			sidecar: dashboards: {
				searchNamespace: "ALL"
				provider: allowUiUpdates: true
			}
		}

		// ref: https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus-node-exporter/values.yaml
		"prometheus-node-exporter": {
			prometheus: monitor: enabled: true
		}

		prometheus: {
			ingress: {
				annotations: "cert-manager.io/cluster-issuer": "letsencrypt-dns"
				enabled:          true
				ingressClassName: "traefik"
				hosts: [
					"mon.odell.sh",
				]
				paths: [
					"/prometheus",
				]
				tls: [{
					hosts: [
						"mon.odell.sh",
					]
					secretName: "mon-tls"
				}]
			}

			prometheusSpec: {
				podMonitorSelectorNilUsesHelmValues:     false
				serviceMonitorSelectorNilUsesHelmValues: false
				ruleSelectorNilUsesHelmValues:           false

				replicas: 2
				resources: {
					requests: {
						cpu:    "500m"
						memory: "2300Mi"
					}
					limits: {
						cpu:    "2"
						memory: "4Gi"
					}
				}

				externalUrl: "http://mon.odell.sh/prometheus/"
				routePrefix: "/prometheus/"

				retentionSize:  "90GB"
				walCompression: true

				storageSpec: volumeClaimTemplate: spec: {
					accessModes: [
						"ReadWriteOnce",
					]
					resources: requests: storage: "100Gi"
					storageClassName: "openebs-lvm"
				}
			}

			// Will surely need some stuff here...
			additionalScrapeConfigs: []
		}
	}
}
