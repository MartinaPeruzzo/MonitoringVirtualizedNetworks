# Assignment

- To deploy a network of virtual machines/containers hosted on one or more PCs
- The connections between twoVMs/containers should be bandwidth-limited (see Netem later)
- Networking should be based on OpenVSwitch
- To analyze the state of the system by collecting information about: VMs/containers resource utilization (CPU/memory/etc.) and link usage

## Suggested packages:

- Netem https://alexei-led.github.io/post/pumba_docker_netem/
- Docker/VM hypervisor monitoring APIs

## Design:

<img src="NetworkSchema.png" width="650">

Come si può notare dall'immagine sopra illustrata, la nostra rete network è composta da: 
- 1 router
- 1 switch
- 3 host: host-a e host-b connessi allo switch e host-c connesso direttamente al router

### SUBNET:

- Subnet host-a: BISOGNA METTERE GLI IP - sottorete presente tra host-a e switch 
- Subnet host-b: IP - sottorete presente tra host-b e switch
- Subnet host-c: IP - sottorete presente tra host-c e router

Abbiamo deciso di creare due VLAN per distinguere subnet host-a e subnet host-b, codificandole rispettivamente con il tag 2 e 3. 


### IP MAP E VLAN:

| DEVICE            | IP                | INTERFACE           | SUBNET       |
| -------------     | -------------     | -------------       |------------- |
| router-1          | 192.168.0.1       | enp0s8.2            |   2          |
| host-a            | 192.168.0.2       | enp0s8              |   2          |
| router-1          | 192.168.2.1       | enp0s8.3            |   3          |
| host-b            | 192.168.2.2       | enp0s8              |   3          |
| host-c            | 192.168.4.2       | enp0s9              |   -          |


### VAGRANT FILE
Nel file chiamato Vagrantfile è presente tutta la configurazione di Vagrant. Più precisamente all'interno del fie troviamo le impostazioni per ogni macchina virtuale.

Note: Abbiamo dovuto aumentare la memoria di worker-1 e worker-2 a 512 con il comando vb.memory in quanto devono poter scaricare al loro interno un'immagine docker.

## Realizzazione

### CONFIGURAZIONE SWITCH: 