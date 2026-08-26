#include <bits/stdc++.h>
using namespace std;

string trim(string);

/*  Tree of Space.
    The tree is complete and given in level order, so it is never built:
        par(v) = (v-1)/m,  children(v) = v*m+1 .. v*m+m,  depth = log_m(N).
    lockedBy[v] = uid holding v (-1 = free), cnt[v] = locked nodes below v.
    Locked nodes form an antichain, so cnt answers every check in O(1).
    lock/unlock O(log_m N), upgrade O(locked descendants * log_m N), O(N) space.  */

int n, m;
vector<int> lockedBy, cnt;

int par(int v) { return v ? (v - 1) / m : -1; }

bool ancLocked(int v) {
    for (int p = par(v); p != -1; p = par(p))
        if (lockedBy[p] != -1) return true;
    return false;
}

void bump(int v, int d) {
    for (int p = par(v); p != -1; p = par(p)) cnt[p] += d;
}

void gather(int v, vector<int> &out) {
    for (int c = v * m + 1, e = min(v * m + 1 + m, n); c < e; c++) {
        if (lockedBy[c] != -1) out.push_back(c);   // locks never nest, stop here
        else if (cnt[c] > 0) gather(c, out);       // only descend where a lock hides
    }
}

bool doLock(int v, int uid) {
    if (lockedBy[v] != -1 || cnt[v] > 0 || ancLocked(v)) return false;
    lockedBy[v] = uid;
    bump(v, 1);
    return true;
}

bool doUnlock(int v, int uid) {
    if (lockedBy[v] != uid) return false;          // uid >= 1, so this covers "free"
    lockedBy[v] = -1;
    bump(v, -1);
    return true;
}

bool doUpgrade(int v, int uid) {
    if (lockedBy[v] != -1 || cnt[v] == 0) return false;   // cnt > 0 => no locked ancestor
    vector<int> d;
    gather(v, d);
    for (int i = 0; i < (int)d.size(); i++)
        if (lockedBy[d[i]] != uid) return false;
    for (int i = 0; i < (int)d.size(); i++) {
        lockedBy[d[i]] = -1;
        bump(d[i], -1);
    }
    lockedBy[v] = uid;
    bump(v, 1);
    return true;
}

vector<string> handleActions() {
    int q;
    cin >> n >> m >> q;
    lockedBy.assign(n, -1);
    cnt.assign(n, 0);

    unordered_map<string, int> id;
    id.reserve(2 * n);
    string s;
    for (int i = 0; i < n; i++) { cin >> s; id[s] = i; }   // level order == array order

    vector<string> res;
    res.reserve(q);
    for (int i = 0; i < q; i++) {
        int op, uid;
        cin >> op >> s >> uid;
        int v = id[s];
        bool ok = false;
        if (op == 1) ok = doLock(v, uid);
        else if (op == 2) ok = doUnlock(v, uid);
        else ok = doUpgrade(v, uid);
        res.push_back(ok ? "true" : "false");
    }
    return res;
}

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    string inputline;

    vector<string> result = handleActions();

    for(int j=0; j<result.size(); j++) {
        cout << result[j] << "\n";
    }

    return 0;
}

/* Utility functions. Don't modify these */
string trim(string str){
    if(str.empty())
        return str;

    size_t firstScan = str.find_first_not_of(' ');
    size_t first     = firstScan == string::npos ? str.length() : firstScan;
    size_t last      = str.find_last_not_of(' ');
    return str.substr(first, last-first+1);
}
