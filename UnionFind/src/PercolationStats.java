import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;


public class PercolationStats {

    private final double mean;
    private final double stddev;
    private final double confidenceLo;
    private final double confidenceHi;

    // perform independent trials on an n-by-n grid
    public PercolationStats(int n, int trials) {
        double[] results = new double[trials];
        int currentTrial = 0;
        while(currentTrial < trials) {
            System.out.println("Trial: " + currentTrial);
            Percolation perc = new Percolation(n);
            int opens = 0;
            while(!perc.percolates()){
                int[] closedSite = perc.getRandomClosedSite();
                int row = closedSite[0];
                int col = closedSite[1];
                perc.open(row, col);
                opens += 1;
            }
            currentTrial += 1;
            results[currentTrial - 1] = (float)opens / (n * n);
        }

        this.mean = StdStats.mean(results);
        this.stddev = StdStats.stddev(results);
        this.confidenceLo = this.mean
                - (1.96 * (this.stddev / Math.sqrt(trials)));
        this.confidenceHi = this.mean
                + (1.96 * (this.stddev / Math.sqrt(trials)));
    }

    // sample mean of percolation threshold
    public double mean() {
        return this.mean;
    }

    // sample standard deviation of percolation threshold
    public double stddev() {
        return this.stddev;
    }

    // low endpoint of 95% confidence interval
    public double confidenceLo() {
        return confidenceLo;
    }

    // high endpoint of 95% confidence interval
    public double confidenceHi() {
        return confidenceHi;
    }

    // test client (see below)
    public static void main(String[] args) {
        int n = (int)args[0];
        int trials;

        for (String s: args) {

        }
        PercolationStats stats = new PercolationStats(2, 1000000);
        System.out.println("mean = " + stats.mean());
        System.out.println("stddev = " + stats.stddev());
        System.out.println("95% confidence interval = " + stats.confidenceLo()
                + ", " + stats.confidenceHi());
    }

}