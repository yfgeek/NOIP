
#include <stdio.h>
#include <string.h>
#include <memory.h>
#include <stdlib.h>
#include <time.h>

void init();
void solve();
int compare(const void *a, const void *b);
long findroot(long now);
void make();

const long maxn = 200;
const long maxm = 1000;

long n,m;
long parent[maxn];
long e[(maxm+1)*3];
long p;
long s,o;

int main()
{
//	make();	return 0;
#ifndef ONLINE_JUDGE
	freopen("flycar.001","r+",stdin);
	freopen("flycar.out","w+",stdout);
#endif
	while (scanf("%ld",&n)==1)
	{
		init();
		solve();
	}
	return 0;
}

void init()
{
	long mm,i,j,t;

	m = 0; scanf("%ld",&mm);
	for (mm;mm>0;mm--)
	{
		scanf("%ld%ld%ld",&i,&j,&t);
		e[m*3] = t;
		e[m*3+1] = --i;
		e[m*3+2] = --j;
		m++;
	}
	qsort(e,m,12,compare);
}

void solve()
{
	long Q;
	long i,j,t;
	long t1,t2;
	bool tt;

	scanf("%ld",&Q);
	for (Q;Q>0;Q--)
	{
		scanf("%ld%ld",&s,&o);
		p = e[(m-1)*3]+1;
		s--; o--;

		i = 0;	j = 0;
		for (j=0;j<n;j++)	parent[j] = j;
		parent[e[i*3+2]] = e[i*3+1];
		j = i;
		while ((i<=j) && (j<m-1) && (p>0))
		{
			while ((findroot(s)!=findroot(o)) && (j+1<m))
			{
				j++;
				parent[findroot(e[j*3+2])] = findroot(e[j*3+1]);
			}
			if (parent[s]==parent[o])
			{
				if (p>(t = e[j*3]-e[i*3]))
					p = t;
				for (i=0;i<n;i++)	parent[i] = i;
				parent[e[j*3+2]] = e[j*3+1];
				i = j;	tt = findroot(s)!=findroot(o);
				while (tt && (i>0))
				{
					i--;
					t1 = findroot(e[i*3+1]);	findroot(s);
					t2 = findroot(e[i*3+2]);	findroot(o);
					if ((t1!=t2) && (((parent[s]==t1) && (parent[o]==t2)) || ((parent[s]==t2) && (parent[o]==t1))))
						tt = false;
					else
						parent[t2] = t1;
				}
				if ((!tt) && (p>(t = e[j*3]-e[i*3])))
					p = t;
				i++;
			}
		}
		printf("%ld\n",p);
	}
}

int compare(const void *a, const void *b)
{
	return *(long *)a-*(long *)b;
}

long findroot(long now)
{
	if (parent[now]==now)
		return now;
	else
		return (parent[now] = findroot(parent[now]));
}

void make()
{
	long i,nn,t1,t2;
	freopen("flycar.001","w+",stdout);
	srand((unsigned)time(NULL));
	for (nn=1;nn<11;nn++)
	{
		n = rand()*(maxn-1)/32768+1;	m = 1+rand()*(maxm-1)/32768;
		printf("%ld %ld\n",n,m);
		for (i=0;i<m;i++)
		{
			t1 = rand()*n/32768+1;	while (t1==(t2 = rand()*n/32768+1));
			printf("%ld %ld %ld\n",t1,t2,rand()+1);
		}
		m = rand()*10/32768+1;
		printf("%ld\n",m);
		for (i=0;i<m;i++)
			printf("%ld %ld\n",rand()*n/32768+1,rand()*n/32768+1);
	}
	fclose(stdout);
}

