import psycopg2
import sys
import time
from cassandra.cluster import Cluster

# connect to postgresql
conn = psycopg2.connect("dbname='pennyvault' user='pennyvault' host='localhost'")
cur = conn.cursor()

sql = "SELECT date, security, split_from, split_to, source FROM split"

cur.execute(sql)

if cur.rowcount == 0:
    print('Exiting because there are no rows')
    raise SystemExit

# connect to cassandra
cluster = Cluster()
session = cluster.connect('pennyvault')
    
query = session.prepare("INSERT INTO pennyvault.split (date, security, split_from, split_to, source) VALUES (?, ?, ?, ?, ?)")

for x in cur:
    try:
        session.execute_async(query, x)
    except Exception as e:
        print(e)

cluster.shutdown()
