import pypyodbc

connection = pypyodbc.connect(driver='{SQL Server}', server='(localdb)\mssqllocaldb', database='FitnessTracker', uid='grisha', pwd='password')

if (connection):
    cursor = connection.cursor()
    SQLquery = ("""
                SELECT * FROM dbo.test            
    """)
    cursor.execute(SQLquery)
    results = cursor.fetchall()
    print(results)
    connection.close()