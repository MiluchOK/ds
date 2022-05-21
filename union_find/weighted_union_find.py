
class WeightedUnionFind:
    def __init__(self, n):
        self.n = [i for i in range(n)]
        self.heights = [1 for i in range(n)]
        self.biggest_elements = [i for i in range(n)]

    def union(self, i, j):
        root_i = self.get_root(i)
        root_j = self.get_root(j)

        max_element = max(self.biggest_elements[root_j], self.biggest_elements[root_i])

        if self.heights[root_i] >= self.heights[root_j]:
            self.n[root_j] = self.n[root_i]
            self.heights[root_j] = self.heights[root_i] + 1
            self.biggest_elements[root_j] = max_element
        else:
            self.n[root_i] = self.n[root_j]
            self.heights[root_i] = self.heights[root_j] + 1
            self.biggest_elements[root_j] = max_element

    def connected(self, i, j):
        root_i = self.get_root(i)
        root_j = self.get_root(j)
        return root_i == root_j

    def get_root(self, i):
        path = [i]
        while self.n[i] != i:
            i = self.n[i]
            path.append(i)

        for j in path:
            self.heights[self.n[j]] = 1
            self.n[j] = i

        return i


def main():
    number_of_elements = 10
    uf = WeightedUnionFind(number_of_elements)
    uf.union(0, 1)
    uf.union(1, 2)
    uf.union(3, 4)
    uf.union(5, 6)
    uf.union(7, 8)
    uf.union(9, 1)
    uf.union(1, 3)
    uf.union(3, 5)
    uf.union(7, 9)
    return uf.connected(5, 3)



if __name__ == "__main__":
    print(main())
