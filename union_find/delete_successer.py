
class WeightedUnionFind:
    def __init__(self, n):
        self.n = [i for i in range(n)]
        self.heights = [1 for i in range(n)]
        self.biggest_elements = [i for i in range(n)]
        self.deleted = set()

    def delete(self, index):
        if index in self.deleted:
            raise RuntimeError(f'Index {index} is already deleted')
        if index != self.n:        
            self._union(index, index + 1)
        self.deleted.add(index)
        return True

    def successor(self, index):
        if index in self.deleted:
            raise RuntimeError(f'Index {index} is deleted')
        print(self.biggest_elements)
        print(self.n)
        return self.biggest_elements[self._get_root(index + 1)]

    def _union(self, i, j):
        root_i = self._get_root(i)
        root_j = self._get_root(j)

        max_element = max(self.biggest_elements[root_j], self.biggest_elements[root_i])
        print(f'Biggest element {max_element}')

        if self.heights[root_i] >= self.heights[root_j]:
            self.n[root_j] = self.n[root_i]
            self.heights[root_j] = self.heights[root_i] + 1
            self.biggest_elements[root_i] = max_element
        else:
            self.n[root_i] = self.n[root_j]
            self.heights[root_i] = self.heights[root_j] + 1
            self.biggest_elements[root_j] = max_element

    def _connected(self, i, j):
        root_i = self.get_root(i)
        root_j = self.get_root(j)
        return root_i == root_j

    def _get_root(self, i):
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
    uf.delete(6)
    uf.delete(4)
    uf.delete(5)
    uf.delete(7)
    uf.delete(2)
    return uf.successor(3)



if __name__ == "__main__":
    print(main())
