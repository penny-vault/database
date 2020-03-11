import psycopg2
import sys

# connect to postgresql
conn = psycopg2.connect("dbname='pennyvault' user='pennyvault' host='localhost'")
cur = conn.cursor()
cur2 = conn.cursor()

cur2.execute("SELECT id, ticker FROM security WHERE id >= 0 ORDER BY id")
cnt = 0
print("#!/bin/zsh")
for security in cur2:
    print('python convert_pg_2_cassandra.py {} &'.format(security[0]))
    cnt += 1
    if cnt % 50 == 0:
        print("""
running=$(ps -Af | grep python | wc -l)
while (( $running > 50 )) {
    sleep 1;
    running=$(ps -Af | grep python | wc -l)
}
""")
        print('echo "Num complete: {}"'.format(cnt))
