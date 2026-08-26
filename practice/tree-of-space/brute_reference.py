import sys
def main():
    d=sys.stdin.read().split()
    i=0
    n=int(d[i]);i+=1; m=int(d[i]);i+=1; q=int(d[i]);i+=1
    names=d[i:i+n]; i+=n
    idx={s:j for j,s in enumerate(names)}
    locked=[-1]*n
    def par(v): return -1 if v==0 else (v-1)//m
    def anc(v):
        p=par(v)
        while p!=-1:
            yield p; p=par(p)
    def sub(v):  # strict descendants, full scan
        st=[c for c in range(v*m+1,min(v*m+1+m,n))]
        while st:
            x=st.pop(); yield x
            st.extend(range(x*m+1,min(x*m+1+m,n)))
    out=[]
    for _ in range(q):
        op=int(d[i]);nm=d[i+1];uid=int(d[i+2]);i+=3
        v=idx[nm]; ok=False
        if op==1:
            if locked[v]==-1 and not any(locked[a]!=-1 for a in anc(v)) and not any(locked[x]!=-1 for x in sub(v)):
                locked[v]=uid; ok=True
        elif op==2:
            if locked[v]==uid: locked[v]=-1; ok=True
        else:
            ds=[x for x in sub(v) if locked[x]!=-1]
            if locked[v]==-1 and ds and all(locked[x]==uid for x in ds) and not any(locked[a]!=-1 for a in anc(v)):
                for x in ds: locked[x]=-1
                locked[v]=uid; ok=True
        out.append("true" if ok else "false")
    print("\n".join(out))
main()
