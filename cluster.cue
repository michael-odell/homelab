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
}

#Cluster: {
	name:     #DnsSafeName
	nodeType: "physical" | "multipass"
	kubeType: "k3s"

	fqdn: string

	onePasswordVault: #DnsSafeName
}

#DnsSafeName: string & =~"[-a-z0-9]+"
