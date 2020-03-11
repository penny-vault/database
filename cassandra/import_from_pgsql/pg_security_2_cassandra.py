import psycopg2
import sys
import time
from cassandra.cluster import Cluster

# connect to postgresql
conn = psycopg2.connect("dbname='pennyvault' user='pennyvault' host='localhost'")
cur = conn.cursor()

sql = "select security.id, ticker, security.name, cusip, isin, sedol, typecode.name as kind, exchange.name as exchange, active from (security left join typecode on security.typecode = typecode.id) LEFT JOIN exchange on security.exchange=exchange.id;"

cur.execute(sql)

if cur.rowcount == 0:
    print('Exiting because there are no rows')
    raise SystemExit

# connect to cassandra
cluster = Cluster()
session = cluster.connect('pennyvault')
    
query = session.prepare("INSERT INTO pennyvault.security (id, ticker, name, cusip, isin, sedol, kind, exchange, active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")

for x in cur:
    print x[1]
    try:
        session.execute_async(query, x)
    except Exception as e:
        print(e)

cluster.shutdown()
