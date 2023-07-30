package clusters

import (
	"github.com/michael-odell/homelab/apps"
)

alpha: {
	name:     "alpha"
	nodeType: "physical"
	kubeType: "k3s"

	fqdn:             "alpha.odell.sh"
	onePasswordVault: "homelab-alpha"

	app: "cert-manager": apps["cert-manager"]
	app: "external-dns": apps["external-dns"]
	app: mon:            apps["mon"]
	app: loki:           apps["loki"]
	app: "smb-csi":      apps["smb-csi"]
	app: timescale:      apps["timescale"]
}
