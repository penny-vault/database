CREATE KEYSPACE IF NOT EXISTS pennyvault WITH REPLICATION = {
       'class': 'NetworkTopologyStrategy',
       'datacenter1': 1
};
