import psycopg2
import sys
import time
from cassandra.cluster import Cluster

# connect to postgresql
conn = psycopg2.connect("dbname='pennyvault' user='pennyvault' host='localhost'")
cur = conn.cursor()

security = sys.argv[1]
sql = "SELECT date, security, open, close, adj_close, high, low, volume, source FROM eod WHERE security={}".format(security)

cur.execute(sql)

if cur.rowcount == 0:
    print('Exiting because there are no rows')
    raise SystemExit

# connect to cassandra
try:
    cluster = Cluster()
    session = cluster.connect('pennyvault')
except:
    time.sleep(2)
    cluster = Cluster()
    session = cluster.connect('pennyvault')
    
query = session.prepare("INSERT INTO pennyvault.eod (date, security, open, close, adj_close, high, low, volume, source) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")

for x in cur:
    try:
        session.execute_async(query, x)
    except Exception as e:
        print(e)

cluster.shutdown()
