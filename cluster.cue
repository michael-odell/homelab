package homelab

cluster: tmm: {
	name:     "tmm"
	nodeType: "multipass"
	kubeType: "k3s"

	fqdn:             "odell.sh"
	onePasswordVault: "homelab-tmm"
}

cluster: alpha: {
	name:     "alpha"
	nodeType: "physical"
	kubeType: "k3s"

	fqdn:             "alpha.odell.sh"
	onePasswordVault: "homelab-alpha"

	app: openebs: helmApp["openebs"]
}

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

		// TODO this doesn't work as I expect right now -- I'm specifying it above, but should I?
		//helmApp[APPNAME]
	}

}

#DnsSafeName: string & =~"[-a-z0-9]+"
