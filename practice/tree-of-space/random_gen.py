import random,sys
r=random.Random(int(sys.argv[1]))
m=r.randint(2,4); h=r.randint(1,4)
n=sum(m**k for k in range(h+1))
q=r.randint(5,60)
names=["N%d"%j for j in range(n)]
lines=[str(n),str(m),str(q)]+names
for _ in range(q):
    lines.append("%d %s %d"%(r.randint(1,3), r.choice(names), r.randint(1,3)))
print("\n".join(lines))
