import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;
import edu.princeton.cs.algs4.WeightedQuickUnionUF;

import java.util.ArrayList;

public class Percolation {

    private final int[][] grid;
    private final WeightedQuickUnionUF uf;
    private int numberOfOpenSites = 0;
    private final int numberOfElements;
    private final int n;

    // creates n-by-n grid, with all sites initially blocked
    public Percolation(int n) {
        this.n = n;
        this.grid = new int[n][n];
        for(int i = 0; i < n; i++){
            for(int j = 0; j < n; j++){
                this.grid[i][j] = 1;
            }
        }
        this.numberOfElements = n * n + 2;
        this.uf = new WeightedQuickUnionUF(this.numberOfElements);
        this.connectVirtualNodes();
    }

    public int[] getRandomClosedSite(){
        int randomRow = StdRandom.uniform(this.n);
        int randomCol = StdRandom.uniform(this.n);
//        System.out.println("RAndom: " + randomRow + " and " + randomCol);
        if(!this.isOpen(randomRow, randomCol)){
            return new int[] { randomRow, randomCol };
        } else {
//            System.out.println("Its open");
            return this.getRandomClosedSite();
        }
    }

    private void connectVirtualNodes(){
        for(int i = 0; i < n; i++){
            this.uf.union(0, this.gridIndexToUfIndex(0, i));
        }

        for(int i = n - 1; i >= 0; i--){
            this.uf.union(this.numberOfElements - 1, this.gridIndexToUfIndex(n-1, i));
        }
    }

    // opens the site (row, col) if it is not open already
    public void open(int row, int col) {
        if(!this.isOpen(row, col)){
            this.grid[row][col] = 0;
            this.numberOfOpenSites += 1;
            this.unionNeighbors(row, col);
        }
    }

    private int gridIndexToUfIndex(int row, int col) {
        int result = ((row * n) + (col + 1));
//        System.out.println("From: " + row + " and " + col + " to:  " + result);
        return result;
    }

    private void unionNeighbors(int row, int col) {
        ArrayList<Integer> neighbors = new ArrayList<Integer>();
        int targetIndex = this.gridIndexToUfIndex(row, col);

        // We have top
        if(row > 0 && this.isOpen(row - 1, col)) {
            neighbors.add(this.gridIndexToUfIndex(row - 1, col));
        };

        // We have bottom
        if(row < n - 1 && this.isOpen(row + 1, col)) {
            neighbors.add(this.gridIndexToUfIndex(row + 1, col));
        }

        // We have left
        if(col > 0 && this.isOpen(row, col - 1)) {
            neighbors.add(this.gridIndexToUfIndex(row, col - 1));
        }

        // We have right
        if(col < n - 1 && this.isOpen(row, col + 1)){
            neighbors.add(this.gridIndexToUfIndex(row, col + 1));
        }

        for (int neighbor: neighbors) {
            uf.union(targetIndex, neighbor);
        }
    }

    // is the site (row, col) open?
    public boolean isOpen(int row, int col) {
        return this.grid[row][col] == 0;
    }

    // is the site (row, col) full?
    public boolean isFull(int row, int col) {
        return this.grid[row][col] == 1;
    }

    // returns the number of open sites
    public int numberOfOpenSites() {
        return this.numberOfOpenSites;
    }

    // does the system percolate?
    public boolean percolates() {
        return uf.find(0) == uf.find(this.numberOfElements - 1);
    }

    // test client (optional)
//    public static void main(String[] args) {
//        int n = 20;
//        Percolation perc =  new Percolation(n);
//        int opens = 0;
//        while(!perc.percolates()){
//            int[] closedSite = perc.getRandomClosedSite();
//            int row = closedSite[0];
//            int col = closedSite[1];
//            System.out.println("Opening..." + row + " and " + col);
//            perc.open(row, col);
//            opens += 1;
//        }
//        boolean isPercolating = perc.percolates();
//        System.out.println((float) opens / (n * n));
//    }
}
