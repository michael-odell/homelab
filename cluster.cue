package homelab

#Cluster: {
	name:     #DnsSafeName
	nodeType: "physical" | "multipass"
	kubeType: "k3s"

	fqdn: string

	onePasswordVault: #DnsSafeName

	// Apps are grouped by name and must have the name of one of the apps from the top level
	app: [APPNAME=_]: {
		// Apps here must be one of the apps named at the topLevel
		name: APPNAME & or([ for x in helmApp {x.name}])
	}
}

#DnsSafeName: string & =~"[-a-z0-9]+"
