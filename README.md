# Budget

Demo app that reads a csv file found under the lib folder,
reads its rows and sorts the transactions by their amount
in ascending order.

The original CSV file looks like this:

```
AcctNum,TranDate,Description,Amount
4002617,01/01/2017,Rent,-1000.00
4002617,01/03/2017,Netflix,-9.99
4002617,01/03/2017,Credit Card,-538.00
4002617,01/04/2017,Car Payment,-320.01
4002617,01/04/2017,Publix,-53.39
```

And the output should look like this:

```
Transactions:
01/03/2017 Netflix $9.99
01/04/2017 Publix $53.39
01/04/2017 Car Payment $320.01
01/03/2017 Credit Card $538.00
01/01/2017 Rent $1000.00
```

## Running

Run `mix`. The default task (_"list_from_csv"_) should be run automatically.

