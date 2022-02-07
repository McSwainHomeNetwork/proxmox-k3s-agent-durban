%{if length(ssh_keys) > 0 }
ssh_authorized_keys:
%{for line in ssh_keys}
- ${line}
%{endfor}
%{endif}

write_files:
- path: /etc/conf.d/qemu-guest-agent
  content: |-
    # Specifies the transport method used to communicate to QEMU on the host side
    # Default: virtio-serial
    #GA_METHOD="virtio-serial"
    # Specifies the device path for the communications back to QEMU on the host
    # Default: /dev/virtio-ports/org.qemu.guest_agent.0
    GA_PATH="/dev/vport1p1"
  owner: root
  permissions: '0644'
- path: /etc/sysctl.d/90-kubelet.conf
  content: |-
    vm.panic_on_oom=0
    vm.overcommit_memory=1
    kernel.panic=10
    kernel.panic_on_oops=1
  owner: root
  permissions: '0644'

hostname: k8s-${server_name}

k3os:
  modules:
  - wireguard
  %{if length(dns_servers) > 0 }
  dns_nameservers:
  %{for line in dns_servers}
  - ${line}
  %{endfor}
  %{endif}
  password: "${node_password}"
  server_url: "${server_url}"
  token: "${token}"

  k3s_args:
  - agent
  - "--with-node-id"
  - "--selinux"
  - "--protect-kernel-defaults"
  - "--kubelet-arg"
  - "anonymous-auth=false"
  - "--kubelet-arg"
  - "make-iptables-util-chains"
  - "--kubelet-arg"
  - "authentication-token-webhook=true"
  - "--kubelet-arg"
  - "authorization-mode=Webhook"
  - "--kubelet-arg"
  - "eviction-hard=imagefs.available<5%,nodefs.available<5%"
  - "--kubelet-arg"
  - "eviction-minimum-reclaim=imagefs.available=10%,nodefs.available=10%"
  - "--kubelet-arg"
  - "streaming-connection-idle-timeout=5m"
  - "--kubelet-arg"
  - "healthz-bind-address=127.0.0.1"
  - "--kubelet-arg"
  - "protect-kernel-defaults=true"
  - "--kubelet-arg"
  - "read-only-port=0"
  - "--kubelet-arg"
  - "feature-gates=AllBeta=true"
  - "--kube-proxy-arg"
  - "feature-gates=AllBeta=true"
