package homelab

helmApp: [NAME=_]: APP={
	#HelmApp
	releaseName: NAME

	flux: {
		helmRelease: {
			#FluxHelmRelease
			metadata: {
				name:      APP.releaseName
				namespace: APP.namespace
			}
			spec: {
				chart: spec: {
					chart: APP.chartName
					sourceRef: name: APP.helmRepository.name
				}

				values: APP.values
			}
		}

		helmRepo: {
			#FluxHelmRepo
			metadata: {
				name:      NAME
				namespace: "flux-system"
			}
			spec: url: APP.helmRepository.url
		}
	}
}

#HelmApp: {
	helmRepository: #HelmRepository

	chartName:   #DnsSafeName | *releaseName
	releaseName: #DnsSafeName
	namespace:   #DnsSafeName

	values: {...}
	// May also want some cluster-specific or type-specific values here

	flux: {...}
}

#FluxHelmRelease: {
	apiVersion: "helm.toolkit.fluxcd.io/v2beta1"
	kind:       "HelmRelease"
	metadata: {
		name:      #DnsSafeName
		namespace: #DnsSafeName
	}
	spec: {
		chart: spec: {
			chart:             #DnsSafeName
			reconcileStrategy: "ChartVersion"
			sourceRef: {
				kind: "HelmRepository"
				name: #DnsSafeName
			}
		}
		interval: "24h"
		values: {...}
	}
}
