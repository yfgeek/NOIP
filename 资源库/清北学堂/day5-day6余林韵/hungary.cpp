
	#include <cstdlib>
	#include <cstdio>
	#include <algorithm>

	using namespace std;

	int n, m, k, x, y;
	int v[105][105], visit[105], match[105], graph[105][105];

	int dfs(int p)
	{
		for (int i = 0; i < m; i ++)
		{
			if(graph[p][i] == 1 && visit[i] == -1)
			{
				visit[i] = 1;
				if (match[i] == -1 || dfs(match[i]))
				{
					match[i] = p;
					return 1;
				}
			}
		}
		return 0;
	}

	void work()
	{
		scanf("%d%d%d", &n, &m, &k);
		memset(graph, 0, sizeof(graph));
		for (int i = 0; i < k; i ++)
		{
			scanf("%d%d", &x, &y);
			x --;
			y --;
			graph[x][y] = 1;
		}
		int ans = 0;
		memset(match, -1, sizeof(match));
		for (int i = 0; i < n; i ++)
		{
			memset(visit, -1, sizeof(visit));
			if (dfs(i)) 
				ans++;
		}
		printf("%d\n", ans);
		for (int i = 0; i < n; i ++)
			for (int j = 0; j < m; j ++)
				if (match[j] == i)
					printf("%d %d\n", i + 1, j + 1);
	}

	int main()
	{
		freopen("hungary.in", "r", stdin);
		freopen("hungary.out", "w", stdout);
		work();
		return 0;
	}
