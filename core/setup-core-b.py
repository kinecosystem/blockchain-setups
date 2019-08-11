import os


def build_cfg(db_name, db_user, db_password, network_passphrase, preferred_peers, node_seed, node_name, is_validator,
              nodes_names, validators):
    '''
    :param db_name: str
    :param db_user: str
    :param db_password: str
    :param network_passphrase: str
    :param preferred_peers: str - list of hostnames, ex: "test1.test.org", "test2.test.org", "test.again.google.com"
    :param node_seed: str the unique seed of the node
    :param node_name: str thisis-node
    :param is_validator: str true or false
    :param nodes_names: str - list of nodes names and public address: "GCU4.. test1", "CVI4.. test2", "CV5.. test.again"
    :param validators: str - list of nodes names with prefix $: "$test1","$test2","$test.again"
    :return: str that represent fully configured for core.
    '''
    return f'''AUTOMATIC_MAINTENANCE_PERIOD=1800
TARGET_PEER_CONNECTIONS = 50
HTTP_PORT = 11626
PUBLIC_HTTP_PORT = true

WHITELIST = "GCPGMBNS42RQODVI7JCIRZDOO2PKS3BDNHEL45YMB7PLGJP65FS7U4UV"

LOG_FILE_PATH = ""

COMMANDS = ["ll?level=warn"]

DATABASE = "postgresql://dbname={db_name} host=/var/run/postgresql user={db_user} password={db_password}"

NETWORK_PASSPHRASE = "{network_passphrase}"

# REMOVE SELF FROM PREFERRED
PREFERRED_PEERS = [ {preferred_peers} ]

CATCHUP_RECENT = 0

# INSERT SELF SEED AND NAME WITHOUT DOMAIN
NODE_SEED="{node_seed} {node_name}"

NODE_IS_VALIDATOR = {is_validator}

# REMOVE SELF FROM NODE_NAMES
NODE_NAMES = [ {nodes_names} ]

[QUORUM_SET]
THRESHOLD_PERCENT = 67
VALIDATORS = [ {validators} ]
''' + '''
[HISTORY.local]
get = "cp /data/core-history/history/vs/{0} {1}"
put = "cp {0} /data/core-history/history/vs/{1}"
mkdir = "mkdir -p /data/core-history/history/vs/{0}"

# vi: ft=toml'
'''


CFG_FILE_LOCATION = "/usr/local/stellar-core.cfg"

if __name__ == '__main__':
    ''' Setup core config file '''
    print("start creating CFG file")
    # Read environment variables
    validator_state = os.environ.get('validator', 'false')
    all_nodes = {}
    nodes = os.environ.get('all_nodes', "node1 dghdghngf,node2 dhndghnghn")
    for node in nodes.split(','):
        all_nodes[node.split(' ')[0]] = node.split(' ')[1]
    db_name = os.environ.get("db_name", "my_db_name")
    db_user = os.environ.get("db_user", "this-is-user")
    db_password = os.environ.get("db_password", 'nice-password')
    network_pass = os.environ.get("network_pass", "YOGEV NETWORK 2019")
    domain = os.environ.get("domain", '.my.domain.com')

    self_node_name = os.environ.get("self_node_name", 'node3')
    self_node_seed = os.environ.get("self_node_seed", 'sssdddd')

    nodes_pairs = '\n'
    validator_nodes = '\n'
    preferred_peers = '\n'
    for node_name, node_public_address in all_nodes.items():
        if node_name != self_node_name:
            nodes_pairs += f'\"{node_public_address} {node_name}\",\n'
            preferred_peers += f'\"{node_name + domain}\",\n'
        validator_nodes += f'\"${node_name}\",\n'
    cfg_data = build_cfg(db_name, db_user, db_password, network_pass, preferred_peers, self_node_seed, self_node_name,
                         validator_state, nodes_pairs, validator_nodes)
    with open(CFG_FILE_LOCATION, 'w') as f:
        f.write(cfg_data)
    print("done creating CFG file")

