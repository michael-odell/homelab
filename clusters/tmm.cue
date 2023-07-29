package clusters

import (
	"github.com/michael-odell/homelab/apps"
)

tmm: {
	name:     "tmm"
	nodeType: "multipass"
	kubeType: "k3s"

	fqdn:             "odell.sh"
	onePasswordVault: "homelab-tmm"

	app: "cert-manager": apps["cert-manager"]
	app: "external-dns": apps["external-dns"]
	app: mon:            apps["mon"]
	app: loki:           apps["loki"]
	app: openebs:        apps["openebs"]
	app: smb:            apps["smb"]
	app: timescale:      apps["timescale"]
}
