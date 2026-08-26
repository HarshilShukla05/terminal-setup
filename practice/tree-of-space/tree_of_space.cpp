#include <bits/stdc++.h>
using namespace std;

string trim(string);

/* ------------------------------------------------------------------------ *
 *  Tree of Space  --  lock / unlock / upgradeLock on a complete m-ary tree.
 *
 *  The N node names arrive in level order of a fully balanced m-ary tree, so
 *  the tree never has to be materialised with pointers:
 *        children(v) = v*m + 1 ... v*m + m
 *        parent(v)   = (v - 1) / m
 *  Depth is therefore log_m(N)  (<= 19 for N = 5*10^5, m = 2).
 *
 *  State per node:
 *        lockedBy[v]    uid holding the lock on v, or -1 when v is free
 *        lockedInSub[v] how many locked nodes live strictly below v
 *
 *  lockedInSub lets every check be answered without touching the subtree:
 *        lock(X)     : X free, no ancestor locked (walk up), lockedInSub[X]==0
 *        unlock(X)   : X locked by this very uid
 *        upgrade(X)  : X free, lockedInSub[X] > 0, every locked descendant
 *                      belongs to uid  (descendants are gathered by a DFS that
 *                      only enters branches whose lockedInSub says a lock is
 *                      hiding in there, and stops at the first locked node on
 *                      each path because locks can never nest)
 *
 *  Complexity   lock / unlock    O(log_m N)
 *               upgradeLock      O(lockedDescendants * log_m N)   [* m for the
 *                                child scan, m < 30, and the total work over a
 *                                whole run is still bounded by the locks made]
 *  Memory       O(N) ints -- no per-node containers.
 * ------------------------------------------------------------------------ */
namespace {

struct TreeOfSpace {
    int n, m;
    vector<int> lockedBy;
    vector<int> lockedInSub;

    TreeOfSpace(int nodes, int arity)
        : n(nodes), m(arity), lockedBy(nodes, -1), lockedInSub(nodes, 0) {}

    int parent(int v) const { return v == 0 ? -1 : (v - 1) / m; }

    bool ancestorLocked(int v) const {
        for (int p = parent(v); p != -1; p = parent(p))
            if (lockedBy[p] != -1) return true;
        return false;
    }

    void addToAncestors(int v, int delta) {
        for (int p = parent(v); p != -1; p = parent(p)) lockedInSub[p] += delta;
    }

    void collectLocked(int v, vector<int>& out) const {
        int first = v * m + 1;
        int last  = min(first + m, n);
        for (int c = first; c < last; ++c) {
            if (lockedBy[c] != -1) out.push_back(c);        // nothing locked below it
            else if (lockedInSub[c] > 0) collectLocked(c, out);
        }
    }

    bool lock(int v, int uid) {
        if (lockedBy[v] != -1) return false;                // already locked
        if (lockedInSub[v] > 0) return false;               // a descendant is locked
        if (ancestorLocked(v)) return false;                // an ancestor is locked
        lockedBy[v] = uid;
        addToAncestors(v, +1);
        return true;
    }

    bool unlock(int v, int uid) {
        if (lockedBy[v] == -1 || lockedBy[v] != uid) return false;
        lockedBy[v] = -1;
        addToAncestors(v, -1);
        return true;
    }

    bool upgrade(int v, int uid) {
        if (lockedBy[v] != -1) return false;                // upgrading a locked node fails
        if (lockedInSub[v] == 0) return false;              // nothing to upgrade from
        if (ancestorLocked(v)) return false;                // defensive: keeps the invariant
        vector<int> locked;
        collectLocked(v, locked);
        for (int d : locked)
            if (lockedBy[d] != uid) return false;           // someone else owns a descendant
        for (int d : locked) {
            lockedBy[d] = -1;
            addToAncestors(d, -1);
        }
        lockedBy[v] = uid;
        addToAncestors(v, +1);
        return true;
    }
};

// drops stray '\r' / blanks so CRLF input can never poison a name lookup
string clean(const string& s) {
    size_t b = 0, e = s.size();
    while (b < e && (unsigned char)s[b] <= ' ') ++b;
    while (e > b && (unsigned char)s[e - 1] <= ' ') --e;
    return s.substr(b, e - b);
}

} // namespace

vector<string> handleActions() {
    int n, m, q;
    if (!(cin >> n >> m >> q)) return {};

    TreeOfSpace tree(n, m);
    unordered_map<string, int> indexOf;
    indexOf.reserve(n * 2);

    string name;
    for (int i = 0; i < n; ++i) {
        if (!(cin >> name)) break;
        indexOf[clean(name)] = i;                           // level order == array order
    }

    vector<string> result;
    result.reserve(q);
    for (int i = 0; i < q; ++i) {
        int op, uid;
        if (!(cin >> op >> name >> uid)) break;
        bool ok = false;
        auto it = indexOf.find(clean(name));
        if (it != indexOf.end()) {
            int v = it->second;
            if (op == 1)      ok = tree.lock(v, uid);
            else if (op == 2) ok = tree.unlock(v, uid);
            else if (op == 3) ok = tree.upgrade(v, uid);
        }
        result.push_back(ok ? "true" : "false");
    }
    return result;
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
